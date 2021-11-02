Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC55AC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 07:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F5960F56
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 07:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhKBHJE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 03:09:04 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38892 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231135AbhKBHJA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 03:09:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Uuj7RWN_1635836777;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0Uuj7RWN_1635836777)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Nov 2021 15:06:24 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     gcc-patches@gcc.gnu.org
Cc:     linux-hardening@vger.kernel.org,
        Dan Li <ashimida@linux.alibaba.com>
Subject: [PATCH] [RFC][PR102768] aarch64: Add compiler support for Shadow Call Stack
Date:   Tue,  2 Nov 2021 00:06:16 -0700
Message-Id: <20211102070616.119780-1-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Shadow Call Stack can be used to protect the return address of a
function at runtime, and clang already supports this feature[1].

To enable SCS in user mode, in addition to compiler, other support
is also required (as described in [2]). This patch only adds basic
support for SCS from the compiler side, and provides convenience
for users to enable SCS.

For linux kernel, only the support of the compiler is required.

[1] https://clang.llvm.org/docs/ShadowCallStack.html
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102768

gcc/c-family/ChangeLog:

	* c-attribs.c (handle_no_sanitize_shadow_call_stack_attribute):

gcc/ChangeLog:

	* config/aarch64/aarch64-protos.h (aarch64_shadow_call_stack_enabled):
	* config/aarch64/aarch64.c (aarch64_shadow_call_stack_enabled):
	(aarch64_expand_prologue):
	(aarch64_expand_epilogue):
	* config/aarch64/aarch64.h (TARGET_SUPPORT_SHADOW_CALL_STACK):
	* config/aarch64/aarch64.md (scs_push):
	(scs_pop):
	* defaults.h (TARGET_SUPPORT_SHADOW_CALL_STACK):
	* flag-types.h (enum sanitize_code):
	* opts.c (finish_options):

Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
---
 gcc/c-family/c-attribs.c            | 21 +++++++++++++++++++++
 gcc/config/aarch64/aarch64-protos.h |  1 +
 gcc/config/aarch64/aarch64.c        | 27 +++++++++++++++++++++++++++
 gcc/config/aarch64/aarch64.h        |  4 ++++
 gcc/config/aarch64/aarch64.md       | 18 ++++++++++++++++++
 gcc/defaults.h                      |  4 ++++
 gcc/flag-types.h                    |  2 ++
 gcc/opts.c                          |  6 ++++++
 8 files changed, 83 insertions(+)

diff --git a/gcc/c-family/c-attribs.c b/gcc/c-family/c-attribs.c
index 007b928c54b..9b3a35c06bf 100644
--- a/gcc/c-family/c-attribs.c
+++ b/gcc/c-family/c-attribs.c
@@ -56,6 +56,8 @@ static tree handle_cold_attribute (tree *, tree, tree, int, bool *);
 static tree handle_no_sanitize_attribute (tree *, tree, tree, int, bool *);
 static tree handle_no_sanitize_address_attribute (tree *, tree, tree,
 						  int, bool *);
+static tree handle_no_sanitize_shadow_call_stack_attribute (tree *, tree,
+						  tree, int, bool *);
 static tree handle_no_sanitize_thread_attribute (tree *, tree, tree,
 						 int, bool *);
 static tree handle_no_address_safety_analysis_attribute (tree *, tree, tree,
@@ -454,6 +456,10 @@ const struct attribute_spec c_common_attribute_table[] =
 			      handle_no_sanitize_attribute, NULL },
   { "no_sanitize_address",    0, 0, true, false, false, false,
 			      handle_no_sanitize_address_attribute, NULL },
+  { "no_sanitize_shadow_call_stack",
+			      0, 0, true, false, false, false,
+			      handle_no_sanitize_shadow_call_stack_attribute,
+			      NULL },
   { "no_sanitize_thread",     0, 0, true, false, false, false,
 			      handle_no_sanitize_thread_attribute, NULL },
   { "no_sanitize_undefined",  0, 0, true, false, false, false,
@@ -1175,6 +1181,21 @@ handle_no_sanitize_address_attribute (tree *node, tree name, tree, int,
   return NULL_TREE;
 }
 
+/* Handle a "no_sanitize_shadow_call_stack" attribute; arguments as in
+   struct attribute_spec.handler.  */
+static tree
+handle_no_sanitize_shadow_call_stack_attribute (tree *node, tree name,
+				      tree, int, bool *no_add_attrs)
+{
+  *no_add_attrs = true;
+  if (TREE_CODE (*node) != FUNCTION_DECL)
+    warning (OPT_Wattributes, "%qE attribute ignored", name);
+  else
+    add_no_sanitize_value (*node, SANITIZE_SHADOW_CALL_STACK);
+
+  return NULL_TREE;
+}
+
 /* Handle a "no_sanitize_thread" attribute; arguments as in
    struct attribute_spec.handler.  */
 
diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aarch64-protos.h
index 768e8fae136..150c015df21 100644
--- a/gcc/config/aarch64/aarch64-protos.h
+++ b/gcc/config/aarch64/aarch64-protos.h
@@ -893,6 +893,7 @@ void aarch64_register_pragmas (void);
 void aarch64_relayout_simd_types (void);
 void aarch64_reset_previous_fndecl (void);
 bool aarch64_return_address_signing_enabled (void);
+bool aarch64_shadow_call_stack_enabled (void);
 bool aarch64_bti_enabled (void);
 void aarch64_save_restore_target_globals (tree);
 void aarch64_addti_scratch_regs (rtx, rtx, rtx *,
diff --git a/gcc/config/aarch64/aarch64.c b/gcc/config/aarch64/aarch64.c
index 699c105a42a..5a36a459f4e 100644
--- a/gcc/config/aarch64/aarch64.c
+++ b/gcc/config/aarch64/aarch64.c
@@ -79,6 +79,7 @@
 #include "tree-ssa-loop-niter.h"
 #include "fractional-cost.h"
 #include "rtlanal.h"
+#include "asan.h"
 
 /* This file should be included last.  */
 #include "target-def.h"
@@ -7799,6 +7800,24 @@ aarch64_return_address_signing_enabled (void)
 	      && known_ge (cfun->machine->frame.reg_offset[LR_REGNUM], 0)));
 }
 
+/* Return TRUE if shadow call stack should be enabled for the current
+   function, otherwise return FALSE.  */
+
+bool
+aarch64_shadow_call_stack_enabled (void)
+{
+  /* This function should only be called after frame laid out.  */
+  gcc_assert (cfun->machine->frame.laid_out);
+
+  if (crtl->calls_eh_return)
+    return false;
+
+  /* We only deal with a function if its LR is pushed onto stack
+     and attribute no_sanitize_shadow_call_stack is not specified.  */
+  return (sanitize_flags_p (SANITIZE_SHADOW_CALL_STACK)
+	  && known_ge (cfun->machine->frame.reg_offset[LR_REGNUM], 0));
+}
+
 /* Return TRUE if Branch Target Identification Mechanism is enabled.  */
 bool
 aarch64_bti_enabled (void)
@@ -8810,6 +8829,10 @@ aarch64_expand_prologue (void)
       RTX_FRAME_RELATED_P (insn) = 1;
     }
 
+  /* Push return address to shadow call stack.  */
+  if (aarch64_shadow_call_stack_enabled ())
+	emit_insn (gen_scs_push ());
+
   if (flag_stack_usage_info)
     current_function_static_stack_size = constant_lower_bound (frame_size);
 
@@ -9066,6 +9089,10 @@ aarch64_expand_epilogue (bool for_sibcall)
       RTX_FRAME_RELATED_P (insn) = 1;
     }
 
+  /* Pop return address from shadow call stack.  */
+  if (aarch64_shadow_call_stack_enabled ())
+	emit_insn (gen_scs_pop ());
+
   /* We prefer to emit the combined return/authenticate instruction RETAA,
      however there are three cases in which we must instead emit an explicit
      authentication instruction.
diff --git a/gcc/config/aarch64/aarch64.h b/gcc/config/aarch64/aarch64.h
index 2792bb29adb..1a83875dec8 100644
--- a/gcc/config/aarch64/aarch64.h
+++ b/gcc/config/aarch64/aarch64.h
@@ -100,6 +100,10 @@
    generating stack clash probes.  */
 #define STACK_CLASH_MAX_UNROLL_PAGES 4
 
+/* This value represents whether the shadow call stack is implemented on
+   the target platform.  */
+#define TARGET_SUPPORT_SHADOW_CALL_STACK true
+
 /* The architecture reserves all bits of the address for hardware use,
    so the vbit must go into the delta field of pointers to member
    functions.  This is the same config as that in the AArch32
diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.md
index 1a39470a1fe..8e68a6f793d 100644
--- a/gcc/config/aarch64/aarch64.md
+++ b/gcc/config/aarch64/aarch64.md
@@ -6994,6 +6994,24 @@ (define_insn "xpaclri"
   "hint\t7 // xpaclri"
 )
 
+;; Save X30 in the X18-based POST_INC stack (consistent with clang).
+(define_insn "scs_push"
+  [(set (mem:DI (reg:DI R18_REGNUM)) (reg:DI R30_REGNUM))
+   (set (reg:DI R18_REGNUM) (plus:DI (reg:DI R18_REGNUM) (const_int 8)))]
+  ""
+  "str\\tx30, [x18], #8"
+  [(set_attr "type" "store_8")]
+)
+
+;; Load X30 form the X18-based PRE_DEC stack (consistent with clang).
+(define_insn "scs_pop"
+  [(set (reg:DI R18_REGNUM) (minus:DI (reg:DI R18_REGNUM) (const_int 8)))
+   (set (reg:DI R30_REGNUM) (mem:DI (reg:DI R18_REGNUM)))]
+  ""
+  "ldr\\tx30, [x18, #-8]!"
+  [(set_attr "type" "load_8")]
+)
+
 ;; UNSPEC_VOLATILE is considered to use and clobber all hard registers and
 ;; all of memory.  This blocks insns from being moved across this point.
 
diff --git a/gcc/defaults.h b/gcc/defaults.h
index bb68d0d1a79..0f1719a3bb5 100644
--- a/gcc/defaults.h
+++ b/gcc/defaults.h
@@ -1172,6 +1172,10 @@ see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
 #define PCC_BITFIELD_TYPE_MATTERS false
 #endif
 
+#ifndef TARGET_SUPPORT_SHADOW_CALL_STACK
+#define TARGET_SUPPORT_SHADOW_CALL_STACK false
+#endif
+
 #ifndef INSN_SETS_ARE_DELAYED
 #define INSN_SETS_ARE_DELAYED(INSN) false
 #endif
diff --git a/gcc/flag-types.h b/gcc/flag-types.h
index a5a637160d7..c22ef35a289 100644
--- a/gcc/flag-types.h
+++ b/gcc/flag-types.h
@@ -321,6 +321,8 @@ enum sanitize_code {
   SANITIZE_HWADDRESS = 1UL << 28,
   SANITIZE_USER_HWADDRESS = 1UL << 29,
   SANITIZE_KERNEL_HWADDRESS = 1UL << 30,
+  /* Shadow Call Stack.  */
+  SANITIZE_SHADOW_CALL_STACK = 1UL << 31,
   SANITIZE_SHIFT = SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
   SANITIZE_UNDEFINED = SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNREACHABLE
 		       | SANITIZE_VLA | SANITIZE_NULL | SANITIZE_RETURN
diff --git a/gcc/opts.c b/gcc/opts.c
index 4472cec1b98..e94f316fb85 100644
--- a/gcc/opts.c
+++ b/gcc/opts.c
@@ -1308,6 +1308,11 @@ finish_options (struct gcc_options *opts, struct gcc_options *opts_set,
     sorry ("transactional memory is not supported with "
 	   "%<-fsanitize=kernel-address%>");
 
+  if ((opts->x_flag_sanitize & SANITIZE_SHADOW_CALL_STACK)
+      && !TARGET_SUPPORT_SHADOW_CALL_STACK)
+    error_at (loc, "%<-fsanitize=shadow-call-stack%> not supported "
+	      "in current platform");
+
   /* Currently live patching is not support for LTO.  */
   if (opts->x_flag_live_patching && opts->x_flag_lto)
     sorry ("live patching is not supported with LTO");
@@ -1994,6 +1999,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =
   SANITIZER_OPT (vptr, SANITIZE_VPTR, true),
   SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true),
   SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true),
+  SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false),
   SANITIZER_OPT (all, ~0U, true),
 #undef SANITIZER_OPT
   { NULL, 0U, 0UL, false }
-- 
2.17.1

