Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48053C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Jan 2022 17:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbiASRoP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356484AbiASRoO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Jan 2022 12:44:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B03AC06161C
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jan 2022 09:44:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97893B8198D
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jan 2022 17:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C640CC340E3;
        Wed, 19 Jan 2022 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642614251;
        bh=OQcXagOrDbfC5dJ9alV0/I026vNrOxBr7lf/wXXRscc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpYaH0uhhKviXf3UOG3GzVHN93kB6c/ypq754eQJn3UVNpwiRmhoI1oXi9s9qS53H
         s0uZnYO4euiMIjSQCch/duUamD0L2jYR1At/2xx/ai8cg9Oazk2yQNwbgF2zScnMKC
         s/iBLAbHy5emDCQXlEu0Lz9sAh147w81QWUtJsdowRfIG7Cqsmb3X02KR26YTZRugp
         jeyzcQeg9xZtiggl9DOvX57eDjdcUOvHwCDrF2Fs3NnRxit2h8uDNNrJJT2takXmYB
         kTZI3d1MXZUtEl/oOdnY4jPFI739+xQg4REDXPzl2ttYx3aXkvI3BjviznTAEv940I
         rpPjLrrwx0uzw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        thomas.preudhomme@celest.fr, adhemerval.zanella@linaro.org,
        Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Kyrylo Tkachov <kyryo.tkachov@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        gcc-patches@gcc.gnu.org
Subject: [PATCH v6 1/1] [ARM] Add support for TLS register based stack protector canary access
Date:   Wed, 19 Jan 2022 18:43:53 +0100
Message-Id: <20220119174353.213723-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119174353.213723-1-ardb@kernel.org>
References: <20220119174353.213723-1-ardb@kernel.org>
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

2022-01-19 Ard Biesheuvel <ardb@kernel.org>

	* config/arm/arm-opts.h (enum stack_protector_guard): New
	* config/arm/arm-protos.h (arm_stack_protect_tls_canary_mem):
	New
	* config/arm/arm.cc (TARGET_STACK_PROTECT_GUARD): Define
	(arm_option_override_internal): Handle and put in error checks
	for stack protector guard options.
	(arm_option_reconfigure_globals): Likewise
	(arm_stack_protect_tls_canary_mem): New
	(arm_stack_protect_guard): New
	* config/arm/arm.md (stack_protect_set): New
	(stack_protect_set_tls): Likewise
	(stack_protect_test): Likewise
	(stack_protect_test_tls): Likewise
	(reload_tp_hard): Likewise
	* config/arm/arm.opt (-mstack-protector-guard): New
	(-mstack-protector-guard-offset): New.
	* doc/invoke.texi: Document new options

gcc/testsuite/ChangeLog:

	* gcc.target/arm/stack-protector-7.c: New test.
	* gcc.target/arm/stack-protector-8.c: New test.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 gcc/config/arm/arm-opts.h                        |  6 ++
 gcc/config/arm/arm-protos.h                      |  2 +
 gcc/config/arm/arm.cc                            | 55 +++++++++++++++
 gcc/config/arm/arm.md                            | 71 +++++++++++++++++++-
 gcc/config/arm/arm.opt                           | 22 ++++++
 gcc/doc/invoke.texi                              | 11 +++
 gcc/testsuite/gcc.target/arm/stack-protector-7.c | 12 ++++
 gcc/testsuite/gcc.target/arm/stack-protector-8.c |  7 ++
 8 files changed, 184 insertions(+), 2 deletions(-)

diff --git a/gcc/config/arm/arm-opts.h b/gcc/config/arm/arm-opts.h
index c50d5e56a181..24d12fafdec8 100644
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
diff --git a/gcc/config/arm/arm-protos.h b/gcc/config/arm/arm-protos.h
index cd55a9f6ca54..881c72c988bd 100644
--- a/gcc/config/arm/arm-protos.h
+++ b/gcc/config/arm/arm-protos.h
@@ -195,6 +195,8 @@ extern void arm_split_atomic_op (enum rtx_code, rtx, rtx, rtx, rtx, rtx, rtx);
 extern rtx arm_load_tp (rtx);
 extern bool arm_coproc_builtin_available (enum unspecv);
 extern bool arm_coproc_ldc_stc_legitimate_address (rtx);
+extern rtx arm_stack_protect_tls_canary_mem (bool);
+
 
 #if defined TREE_CODE
 extern void arm_init_cumulative_args (CUMULATIVE_ARGS *, tree, rtx, tree);
diff --git a/gcc/config/arm/arm.cc b/gcc/config/arm/arm.cc
index 7825e364c01e..c192894ff33e 100644
--- a/gcc/config/arm/arm.cc
+++ b/gcc/config/arm/arm.cc
@@ -829,6 +829,9 @@ static const struct attribute_spec arm_attribute_table[] =
 
 #undef TARGET_MD_ASM_ADJUST
 #define TARGET_MD_ASM_ADJUST arm_md_asm_adjust
+
+#undef TARGET_STACK_PROTECT_GUARD
+#define TARGET_STACK_PROTECT_GUARD arm_stack_protect_guard
 
 /* Obstack for minipool constant handling.  */
 static struct obstack minipool_obstack;
@@ -3176,6 +3179,26 @@ arm_option_override_internal (struct gcc_options *opts,
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
@@ -3843,6 +3866,9 @@ arm_option_reconfigure_globals (void)
       else
 	target_thread_pointer = TP_SOFT;
     }
+
+  if (!TARGET_HARD_TP && arm_stack_protector_guard == SSP_TLSREG)
+    error("%'-mstack-protector-guard=tls%' needs a hardware TLS register");
 }
 
 /* Perform some validation between the desired architecture and the rest of the
@@ -8108,6 +8134,23 @@ legitimize_pic_address (rtx orig, machine_mode mode, rtx reg, rtx pic_reg,
 }
 
 
+/* Generate insns that produce the address of the stack canary */
+rtx
+arm_stack_protect_tls_canary_mem (bool reload)
+{
+  rtx tp = gen_reg_rtx (SImode);
+  if (reload)
+    emit_insn (gen_reload_tp_hard (tp));
+  else
+    emit_insn (gen_load_tp_hard (tp));
+
+  rtx reg = gen_reg_rtx (SImode);
+  rtx offset = GEN_INT (arm_stack_protector_guard_offset);
+  emit_set_insn (reg, gen_rtx_PLUS (SImode, tp, offset));
+  return gen_rtx_MEM (SImode, reg);
+}
+
+
 /* Whether a register is callee saved or not.  This is necessary because high
    registers are marked as caller saved when optimizing for size on Thumb-1
    targets despite being callee saved in order to avoid using them.  */
@@ -34075,6 +34118,18 @@ arm_run_selftests (void)
 #define TARGET_RUN_TARGET_SELFTESTS selftest::arm_run_selftests
 #endif /* CHECKING_P */
 
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
 /* Worker function for TARGET_MD_ASM_ADJUST, while in thumb1 mode.
    Unlike the arm version, we do NOT implement asm flag outputs.  */
 
diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
index 90756fbfa3af..60468f6182c3 100644
--- a/gcc/config/arm/arm.md
+++ b/gcc/config/arm/arm.md
@@ -9183,7 +9183,7 @@ (define_expand "stack_protect_combined_set"
 		      UNSPEC_SP_SET))
       (clobber (match_scratch:SI 2 ""))
       (clobber (match_scratch:SI 3 ""))])]
-  ""
+  "arm_stack_protector_guard == SSP_GLOBAL"
   ""
 )
 
@@ -9267,7 +9267,7 @@ (define_expand "stack_protect_combined_test"
       (clobber (match_scratch:SI 3 ""))
       (clobber (match_scratch:SI 4 ""))
       (clobber (reg:CC CC_REGNUM))])]
-  ""
+  "arm_stack_protector_guard == SSP_GLOBAL"
   ""
 )
 
@@ -9361,6 +9361,64 @@ (define_insn "arm_stack_protect_test_insn"
    (set_attr "arch" "t,32")]
 )
 
+(define_expand "stack_protect_set"
+  [(match_operand:SI 0 "memory_operand")
+   (match_operand:SI 1 "memory_operand")]
+  "arm_stack_protector_guard == SSP_TLSREG"
+  "
+{
+  operands[1] = arm_stack_protect_tls_canary_mem (false /* reload */);
+  emit_insn (gen_stack_protect_set_tls (operands[0], operands[1]));
+  DONE;
+}"
+)
+
+;; DO NOT SPLIT THIS PATTERN.  It is important for security reasons that the
+;; canary value does not live beyond the life of this sequence.
+(define_insn "stack_protect_set_tls"
+  [(set (match_operand:SI 0 "memory_operand" "=m")
+       (unspec:SI [(match_operand:SI 1 "memory_operand" "m")]
+        UNSPEC_SP_SET))
+   (set (match_scratch:SI 2 "=&r") (const_int 0))]
+  ""
+  "ldr\\t%2, %1\;str\\t%2, %0\;mov\t%2, #0"
+  [(set_attr "length" "12")
+   (set_attr "conds" "unconditional")
+   (set_attr "type" "multiple")]
+)
+
+(define_expand "stack_protect_test"
+  [(match_operand:SI 0 "memory_operand")
+   (match_operand:SI 1 "memory_operand")
+   (match_operand:SI 2)]
+  "arm_stack_protector_guard == SSP_TLSREG"
+  "
+{
+  operands[1] = arm_stack_protect_tls_canary_mem (true /* reload */);
+  emit_insn (gen_stack_protect_test_tls (operands[0], operands[1]));
+
+  rtx cc_reg = gen_rtx_REG (CC_Zmode, CC_REGNUM);
+  rtx eq = gen_rtx_EQ (CC_Zmode, cc_reg, const0_rtx);
+  emit_jump_insn (gen_arm_cond_branch (operands[2], eq, cc_reg));
+  DONE;
+}"
+)
+
+(define_insn "stack_protect_test_tls"
+  [(set (reg:CC_Z CC_REGNUM)
+	(compare:CC_Z (unspec:SI [(match_operand:SI 0 "memory_operand" "m")
+				  (match_operand:SI 1 "memory_operand" "m")]
+				 UNSPEC_SP_TEST)
+		      (const_int 0)))
+   (clobber (match_scratch:SI 2 "=&r"))
+   (clobber (match_scratch:SI 3 "=&r"))]
+  ""
+  "ldr\t%2, %0\;ldr\t%3, %1\;eors\t%2, %3, %2\;mov\t%3, #0"
+  [(set_attr "length" "16")
+   (set_attr "conds" "set")
+   (set_attr "type" "multiple")]
+)
+
 (define_expand "casesi"
   [(match_operand:SI 0 "s_register_operand")	; index to jump on
    (match_operand:SI 1 "const_int_operand")	; lower bound
@@ -12133,6 +12191,15 @@ (define_insn "load_tp_hard"
    (set_attr "type" "mrs")]
 )
 
+;; Used by the TLS register based stack protector
+(define_insn "reload_tp_hard"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	(unspec_volatile:SI [(const_int 0)] VUNSPEC_MRC))]
+  "TARGET_HARD_TP"
+  "mrc\\tp15, 0, %0, c13, c0, 3\\t@ reload_tp_hard"
+  [(set_attr "type" "mrs")]
+)
+
 ;; Doesn't clobber R1-R3.  Must use r0 for the first operand.
 (define_insn "load_tp_soft_fdpic"
   [(set (reg:SI 0) (unspec:SI [(const_int 0)] UNSPEC_TLS))
diff --git a/gcc/config/arm/arm.opt b/gcc/config/arm/arm.opt
index 587fc932f969..e342a0df4def 100644
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
index 58751c48b8e9..e7c9400c0ccd 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -821,6 +821,7 @@ Objective-C and Objective-C++ Dialects}.
 -mpure-code @gol
 -mcmse @gol
 -mfix-cmse-cve-2021-35465 @gol
+-mstack-protector-guard=@var{guard} -mstack-protector-guard-offset=@var{offset} @gol
 -mfdpic}
 
 @emph{AVR Options}
@@ -21355,6 +21356,16 @@ enabled by default when the option @option{-mcpu=} is used with
 @code{cortex-m33}, @code{cortex-m35p} or @code{cortex-m55}.  The option
 @option{-mno-fix-cmse-cve-2021-35465} can be used to disable the mitigation.
 
+@item -mstack-protector-guard=@var{guard}
+@itemx -mstack-protector-guard-offset=@var{offset}
+@opindex mstack-protector-guard
+@opindex mstack-protector-guard-offset
+Generate stack protection code using canary at @var{guard}.  Supported
+locations are @samp{global} for a global canary or @samp{tls} for a
+canary accessible via the TLS register. The option
+@option{-mstack-protector-guard-offset=} is for use with
+@option{-fstack-protector-guard=tls} and not for use in user-land code.
+
 @item -mfdpic
 @itemx -mno-fdpic
 @opindex mfdpic
diff --git a/gcc/testsuite/gcc.target/arm/stack-protector-7.c b/gcc/testsuite/gcc.target/arm/stack-protector-7.c
new file mode 100644
index 000000000000..2173bc5a35a0
--- /dev/null
+++ b/gcc/testsuite/gcc.target/arm/stack-protector-7.c
@@ -0,0 +1,12 @@
+/* { dg-require-effective-target arm_hard_vfp_ok }  */
+/* { dg-require-effective-target arm_arch_v7a_ok } */
+/* { dg-do compile } */
+/* { dg-options "-march=armv7-a -mfpu=vfp -fstack-protector-all -Os -mstack-protector-guard=tls -mstack-protector-guard-offset=1296 -mtp=cp15" } */
+
+#include "stack-protector-5.c"
+
+/* See the comment in stack-protector-5.c.  */
+/* { dg-final { scan-assembler-times {\tstr\t} 1 } } */
+/* Expect two TLS register accesses and two occurrences of the offset */
+/* { dg-final { scan-assembler-times {\tmrc\t} 2 } } */
+/* { dg-final { scan-assembler-times {1296} 2 } } */
diff --git a/gcc/testsuite/gcc.target/arm/stack-protector-8.c b/gcc/testsuite/gcc.target/arm/stack-protector-8.c
new file mode 100644
index 000000000000..ea5ef3211678
--- /dev/null
+++ b/gcc/testsuite/gcc.target/arm/stack-protector-8.c
@@ -0,0 +1,7 @@
+/* { dg-require-effective-target arm_hard_vfp_ok }  */
+/* { dg-require-effective-target arm_arch_v7a_ok } */
+/* { dg-do compile } */
+/* { dg-error "needs a hardware TLS register" "missing error when using TLS stack protector without hardware TLS register" { target *-*-* } 0 } */
+/* { dg-options "-fstack-protector-all -Os -mstack-protector-guard=tls -mtp=soft" } */
+
+int foo;
-- 
2.30.2

