Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F619C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 10:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059D160F6E
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 10:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJUK0I (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 06:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJUK0H (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 06:26:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F0AD610FF;
        Thu, 21 Oct 2021 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634811831;
        bh=+jsdhmO4lCUcOluWCMIEgMlJSnmePCnS4qi/Oo6+ODc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=am3e2q/6cRcNr5tZKsdmdVVL3Cmolk5CjfUQ9vuHweghXQRGGv4ts5xH76vhZBHoN
         dAgfDObzFSuV231qArOlAjSrKKm3d6pcjYK6c3PGreLpqXUhSXfeFpsurrjqBiuMfq
         vCLMJezf4ZeDPa4ccNghe9P9Yw0KhIgQix1OOd8T0U+MqrwArxJyYhgrY+Q4fqobBM
         KVYrrsz6YyRe5usetwhB5rzWjNARQasVFBJCI6G7kyAd3MDXiZyOagZ5Lu6lbUB7tW
         o8/csBb3nrTJsrmx4RisXSTijmcgBikUOIApQNiynINLbEGmy29h8jAaNjpc0Md5Jf
         g680az+WkyW8Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        thomas.preudhomme@celest.fr, adhemerval.zanella@linaro.org,
        Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        gcc-patches@gcc.gnu.org
Subject: [RFC PATCH 1/1] [ARM] Add support for TLS register based stack protector canary access
Date:   Thu, 21 Oct 2021 12:23:27 +0200
Message-Id: <20211021102327.1415789-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021102327.1415789-1-ardb@kernel.org>
References: <20211021102327.1415789-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add support for accessing the stack canary value via the TLS register,
so that multiple threads running in the same address space can use
distinct canary values. This is intended for the Linux kernel running in
SMP mode, where processes entering the kernel are essentially threads
running the same program concurrently: using a global variable for the
canary in that context is problematic because it can never be rotated,
and so the OS is forced to use the same value as long as it remains up.

Using the TLS register to index the stack canary helps with this, as it
allows each CPU to context switch the TLS register along with the rest
of the process, permitting each process to use its own value for the
stack canary.

2021-10-20 Ard Biesheuvel <ardb@kernel.org>

	* config/arm/arm-opts.h (enum stack_protector_guard): New
	* config/arm/arm.c (arm_option_override_internal): Handle
	and put in error checks for stack protector guard options.
	(arm_stack_protect_guard): New.
	(TARGET_STACK_PROTECT_GUARD): Define.
	* config/arm/arm.md (reg_stack_protect_address<mode>): New.
        (stack_protect_set): Adjust for SSP_GLOBAL.
        (stack_protect_test): Likewise.
	* config/arm/arm.opt (-mstack-protector-guard): New
	(-mstack-protector-guard-offset): New.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 gcc/config/arm/arm-opts.h |  6 +++
 gcc/config/arm/arm.c      | 39 +++++++++++++++++
 gcc/config/arm/arm.md     | 44 ++++++++++++++++++--
 gcc/config/arm/arm.opt    | 22 ++++++++++
 gcc/doc/invoke.texi       |  9 ++++
 5 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/gcc/config/arm/arm-opts.h b/gcc/config/arm/arm-opts.h
index 5c4b62f404f7..581ba3c4fbbb 100644
--- a/gcc/config/arm/arm-opts.h
+++ b/gcc/config/arm/arm-opts.h
@@ -69,4 +69,10 @@ enum arm_tls_type {
   TLS_GNU,
   TLS_GNU2
 };
+
+/* Where to get the canary for the stack protector.  */
+enum stack_protector_guard {
+  SSP_TLSREG,                  /* per-thread canary in TLS register */
+  SSP_GLOBAL                   /* global canary */
+};
 #endif
diff --git a/gcc/config/arm/arm.c b/gcc/config/arm/arm.c
index e51f60a1841d..deccc88e006e 100644
--- a/gcc/config/arm/arm.c
+++ b/gcc/config/arm/arm.c
@@ -829,6 +829,9 @@ static const struct attribute_spec arm_attribute_table[] =
 
 #undef TARGET_MD_ASM_ADJUST
 #define TARGET_MD_ASM_ADJUST arm_md_asm_adjust
+
+#undef TARGET_STACK_PROTECT_GUARD
+#define TARGET_STACK_PROTECT_GUARD arm_stack_protect_guard
 
 /* Obstack for minipool constant handling.  */
 static struct obstack minipool_obstack;
@@ -3157,6 +3160,26 @@ arm_option_override_internal (struct gcc_options *opts,
   if (TARGET_THUMB2_P (opts->x_target_flags))
     opts->x_inline_asm_unified = true;
 
+  if (arm_stack_protector_guard == SSP_GLOBAL
+      && opts->x_arm_stack_protector_guard_offset_str)
+    {
+      error ("incompatible options %'-mstack-protector-guard=global%' and"
+	     "%'-mstack-protector-guard-offset=%qs%'",
+	     arm_stack_protector_guard_offset_str);
+    }
+
+  if (opts->x_arm_stack_protector_guard_offset_str)
+    {
+      char *end;
+      const char *str = arm_stack_protector_guard_offset_str;
+      errno = 0;
+      long offs = strtol (arm_stack_protector_guard_offset_str, &end, 0);
+      if (!*str || *end || errno)
+	error ("%qs is not a valid offset in %qs", str,
+	       "-mstack-protector-guard-offset=");
+      arm_stack_protector_guard_offset = offs;
+    }
+
 #ifdef SUBTARGET_OVERRIDE_INTERNAL_OPTIONS
   SUBTARGET_OVERRIDE_INTERNAL_OPTIONS;
 #endif
@@ -3824,6 +3847,10 @@ arm_option_reconfigure_globals (void)
       else
 	target_thread_pointer = TP_SOFT;
     }
+
+  if (arm_stack_protector_guard == SSP_TLSREG
+      && target_thread_pointer != TP_CP15)
+    error("%'-mstack-protector-guard=tls%' needs a hardware TLS register");
 }
 
 /* Perform some validation between the desired architecture and the rest of the
@@ -34052,6 +34079,18 @@ arm_run_selftests (void)
 }
 } /* Namespace selftest.  */
 
+/* Implement TARGET_STACK_PROTECT_GUARD. In case of a
+   global variable based guard use the default else
+   return a null tree.  */
+static tree
+arm_stack_protect_guard (void)
+{
+  if (arm_stack_protector_guard == SSP_GLOBAL)
+    return default_stack_protect_guard ();
+
+  return NULL_TREE;
+}
+
 #undef TARGET_RUN_TARGET_SELFTESTS
 #define TARGET_RUN_TARGET_SELFTESTS selftest::arm_run_selftests
 #endif /* CHECKING_P */
diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
index 4adc976b8b67..f57e1db07e6a 100644
--- a/gcc/config/arm/arm.md
+++ b/gcc/config/arm/arm.md
@@ -9183,8 +9183,21 @@
 		      UNSPEC_SP_SET))
       (clobber (match_scratch:SI 2 ""))
       (clobber (match_scratch:SI 3 ""))])]
+  "arm_stack_protector_guard == SSP_GLOBAL"
   ""
-  ""
+)
+
+(define_expand "stack_protect_set"
+  [(match_operand:SI 0 "memory_operand")
+   (match_operand:SI 1 "")]
+  "arm_stack_protector_guard == SSP_TLSREG"
+  "
+{
+  rtx tp_reg = gen_reg_rtx (SImode);
+  emit_insn (gen_load_tp_hard (tp_reg));
+  emit_insn (gen_stack_protect_combined_set_insn (operands[0], tp_reg));
+  DONE;
+}"
 )
 
 ;; Use a separate insn from the above expand to be able to have the mem outside
@@ -9192,7 +9205,7 @@
 ;; try to reload the guard since we need to control how PIC access is done in
 ;; the -fpic/-fPIC case (see COMPUTE_NOW parameter when calling
 ;; legitimize_pic_address ()).
-(define_insn_and_split "*stack_protect_combined_set_insn"
+(define_insn_and_split "stack_protect_combined_set_insn"
   [(set (match_operand:SI 0 "memory_operand" "=m,m")
 	(unspec:SI [(mem:SI (match_operand:SI 1 "guard_addr_operand" "X,X"))]
 		   UNSPEC_SP_SET))
@@ -9206,7 +9219,10 @@
 	      (clobber (match_dup 2))])]
   "
 {
-  if (flag_pic)
+  if (arm_stack_protector_guard == SSP_TLSREG)
+    emit_insn (gen_addsi3 (operands[2], operands[1],
+			   GEN_INT (arm_stack_protector_guard_offset)));
+  else if (flag_pic)
     {
       rtx pic_reg;
 
@@ -9267,8 +9283,28 @@
       (clobber (match_scratch:SI 3 ""))
       (clobber (match_scratch:SI 4 ""))
       (clobber (reg:CC CC_REGNUM))])]
+  "arm_stack_protector_guard == SSP_GLOBAL"
   ""
-  ""
+)
+
+(define_expand "stack_protect_test"
+  [(match_operand:SI 0 "memory_operand")
+   (match_operand:SI 1 "")
+   (match_operand:SI 2 "")]
+  "arm_stack_protector_guard == SSP_TLSREG"
+  "
+{
+  rtx tp_reg = gen_reg_rtx (SImode);
+  emit_insn (gen_load_tp_hard (tp_reg));
+  emit_insn (gen_addsi3 (tp_reg, tp_reg,
+			 GEN_INT (arm_stack_protector_guard_offset)));
+  emit_insn (gen_arm_stack_protect_test_insn (gen_reg_rtx (SImode),
+					      operands[0], tp_reg));
+  rtx eq, cc_reg = gen_rtx_REG (CC_Zmode, CC_REGNUM);
+  eq = gen_rtx_EQ (CC_Zmode, cc_reg, const0_rtx);
+  emit_jump_insn (gen_arm_cond_branch (operands[2], eq, cc_reg));
+  DONE;
+}"
 )
 
 ;; Use a separate insn from the above expand to be able to have the mem outside
diff --git a/gcc/config/arm/arm.opt b/gcc/config/arm/arm.opt
index a7677eeb45c8..4b3e17bc319c 100644
--- a/gcc/config/arm/arm.opt
+++ b/gcc/config/arm/arm.opt
@@ -311,3 +311,25 @@ Generate code which uses the core registers only (r0-r14).
 mfdpic
 Target Mask(FDPIC)
 Enable Function Descriptor PIC mode.
+
+mstack-protector-guard=
+Target RejectNegative Joined Enum(stack_protector_guard) Var(arm_stack_protector_guard) Init(SSP_GLOBAL)
+Use given stack-protector guard.
+
+Enum
+Name(stack_protector_guard) Type(enum stack_protector_guard)
+Valid arguments to -mstack-protector-guard=:
+
+EnumValue
+Enum(stack_protector_guard) String(tls) Value(SSP_TLSREG)
+
+EnumValue
+Enum(stack_protector_guard) String(global) Value(SSP_GLOBAL)
+
+mstack-protector-guard-offset=
+Target Joined RejectNegative String Var(arm_stack_protector_guard_offset_str)
+Use an immediate to offset from the TLS register. This option is for use with
+fstack-protector-guard=tls and not for use in user-land code.
+
+TargetVariable
+long arm_stack_protector_guard_offset = 0
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 0cc8a8edd058..0da551600884 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -810,6 +810,7 @@ Objective-C and Objective-C++ Dialects}.
 -mpure-code @gol
 -mcmse @gol
 -mfix-cmse-cve-2021-35465 @gol
+-mstack-protector-guard=@var{guard} -mstack-protector-guard-offset=@var{offset} @gol
 -mfdpic}
 
 @emph{AVR Options}
@@ -20933,6 +20934,14 @@ enabled by default when the option @option{-mcpu=} is used with
 @code{cortex-m33}, @code{cortex-m35p} or @code{cortex-m55}.  The option
 @option{-mno-fix-cmse-cve-2021-35465} can be used to disable the mitigation.
 
+@item -mstack-protector-guard=@var{guard}
+@itemx -mstack-protector-guard-offset=@var{offset}
+@opindex mstack-protector-guard
+@opindex mstack-protector-guard-offset
+Generate stack protection code using canary at @var{guard}.  Supported
+locations are @samp{global} for a global canary or @samp{tls} for a
+canary accessible via the TLS register.
+
 @item -mfdpic
 @itemx -mno-fdpic
 @opindex mfdpic
-- 
2.30.2

