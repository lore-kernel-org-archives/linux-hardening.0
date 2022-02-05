Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011B2C433F5
	for <linux-hardening@archiver.kernel.org>; Sat,  5 Feb 2022 11:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbiBELFL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 5 Feb 2022 06:05:11 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54422 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238327AbiBELFK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 5 Feb 2022 06:05:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V3cvWpM_1644059100;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V3cvWpM_1644059100)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Feb 2022 19:05:07 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     gcc-patches@gcc.gnu.org, richard.sandiford@arm.com,
        richard.earnshaw@arm.com, marcus.shawcroft@arm.com,
        kyrylo.tkachov@arm.com, hp@gcc.gnu.org, ndesaulniers@google.com,
        nsz@gcc.gnu.org, pageexec@gmail.com, qinzhao@gcc.gnu.org
Cc:     linux-hardening@vger.kernel.org,
        Dan Li <ashimida@linux.alibaba.com>
Subject: [PATCH] [PATCH,v4,1/1,AARCH64][PR102768] aarch64: Add compiler  support for Shadow Call Stack
Date:   Sat,  5 Feb 2022 03:04:59 -0800
Message-Id: <20220205110500.47430-1-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Shadow Call Stack can be used to protect the return address of a
function at runtime, and clang already supports this feature[1].

To enable SCS in user mode, in addition to compiler, other support
is also required (as discussed in [2]). This patch only adds basic
support for SCS from the compiler side, and provides convenience
for users to enable SCS.

For linux kernel, only the support of the compiler is required.

[1] https://clang.llvm.org/docs/ShadowCallStack.html
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102768

Signed-off-by: Dan Li <ashimida@linux.alibaba.com>

gcc/ChangeLog:

	* config/aarch64/aarch64.c (SLOT_REQUIRED):
	Rename wb_candidate[12] to wb_push_candidate[12].
	(aarch64_layout_frame): Likewise, and
	change callee_adjust when scs is enabled.
	(aarch64_save_callee_saves):
	Rename wb_candidate[12] to wb_push_candidate[12].
	(aarch64_restore_callee_saves): Likewise.
	(aarch64_get_separate_components): Likewise.
	(aarch64_expand_prologue): Push x30 onto SCS before it's
	pushed onto stack.
	(aarch64_expand_epilogue): Pop x30 frome SCS, while
	preventing it from being popped from the regular stack again.
	(aarch64_override_options_internal): Add SCS compile option check.
	(TARGET_HAVE_SHADOW_CALL_STACK): New hook.
	* config/aarch64/aarch64.h (struct GTY): Add is_scs_enabled,
	wb_pop_candidate[12], and rename wb_candidate[12] to
	wb_push_candidate[12].
	* config/aarch64/aarch64.md (scs_push): New template.
	(scs_pop): Likewise.
	* doc/invoke.texi: Document -fsanitize=shadow-call-stack.
	* doc/tm.texi: Regenerate.
	* doc/tm.texi.in: Add hook have_shadow_call_stack.
	* flag-types.h (enum sanitize_code):
	Add SANITIZE_SHADOW_CALL_STACK.
	* opts.c: Add shadow-call-stack.
	* target.def: New hook.
	* toplev.c (process_options): Add SCS compile option check.

gcc/testsuite/ChangeLog:

	* gcc.target/aarch64/shadow_call_stack_1.c: New test.
	* gcc.target/aarch64/shadow_call_stack_2.c: New test.
	* gcc.target/aarch64/shadow_call_stack_3.c: New test.
	* gcc.target/aarch64/shadow_call_stack_4.c: New test.
	* gcc.target/aarch64/shadow_call_stack_5.c: New test.
	* gcc.target/aarch64/shadow_call_stack_6.c: New test.
	* gcc.target/aarch64/shadow_call_stack_7.c: New test.
	* gcc.target/aarch64/shadow_call_stack_8.c: New test.
---
V4:
- Added wb_[push|pop]_candidates[12] to ensure push/pop can
emit different registers.

V3:
- Change scs_push/pop to standard move patterns.
- Optimize scs_pop to avoid pop x30 twice when shadow stack is enabled.

 gcc/config/aarch64/aarch64.c                  | 121 +++++++++++++-----
 gcc/config/aarch64/aarch64.h                  |  21 ++-
 gcc/config/aarch64/aarch64.md                 |  10 ++
 gcc/doc/invoke.texi                           |  30 +++++
 gcc/doc/tm.texi                               |   5 +
 gcc/doc/tm.texi.in                            |   2 +
 gcc/flag-types.h                              |   2 +
 gcc/opts.c                                    |   1 +
 gcc/target.def                                |   8 ++
 .../gcc.target/aarch64/shadow_call_stack_1.c  |   6 +
 .../gcc.target/aarch64/shadow_call_stack_2.c  |   6 +
 .../gcc.target/aarch64/shadow_call_stack_3.c  |  45 +++++++
 .../gcc.target/aarch64/shadow_call_stack_4.c  |  20 +++
 .../gcc.target/aarch64/shadow_call_stack_5.c  |  18 +++
 .../gcc.target/aarch64/shadow_call_stack_6.c  |  18 +++
 .../gcc.target/aarch64/shadow_call_stack_7.c  |  18 +++
 .../gcc.target/aarch64/shadow_call_stack_8.c  |  24 ++++
 gcc/toplev.c                                  |  10 ++
 18 files changed, 332 insertions(+), 33 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_1.c
 create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_2.c
 create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_3.c
 create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_4.c
 create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_5.c
 create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_6.c
 create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_7.c
 create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_8.c

diff --git a/gcc/config/aarch64/aarch64.c b/gcc/config/aarch64/aarch64.c
index 699c105a42a..f4d962917c4 100644
--- a/gcc/config/aarch64/aarch64.c
+++ b/gcc/config/aarch64/aarch64.c
@@ -79,6 +79,7 @@
 #include "tree-ssa-loop-niter.h"
 #include "fractional-cost.h"
 #include "rtlanal.h"
+#include "asan.h"
 
 /* This file should be included last.  */
 #include "target-def.h"
@@ -7291,8 +7292,8 @@ aarch64_layout_frame (void)
 #define SLOT_NOT_REQUIRED (-2)
 #define SLOT_REQUIRED     (-1)
 
-  frame.wb_candidate1 = INVALID_REGNUM;
-  frame.wb_candidate2 = INVALID_REGNUM;
+  frame.wb_push_candidate1 = INVALID_REGNUM;
+  frame.wb_push_candidate2 = INVALID_REGNUM;
   frame.spare_pred_reg = INVALID_REGNUM;
 
   /* First mark all the registers that really need to be saved...  */
@@ -7407,9 +7408,9 @@ aarch64_layout_frame (void)
     {
       /* FP and LR are placed in the linkage record.  */
       frame.reg_offset[R29_REGNUM] = offset;
-      frame.wb_candidate1 = R29_REGNUM;
+      frame.wb_push_candidate1 = R29_REGNUM;
       frame.reg_offset[R30_REGNUM] = offset + UNITS_PER_WORD;
-      frame.wb_candidate2 = R30_REGNUM;
+      frame.wb_push_candidate2 = R30_REGNUM;
       offset += 2 * UNITS_PER_WORD;
     }
 
@@ -7417,10 +7418,10 @@ aarch64_layout_frame (void)
     if (known_eq (frame.reg_offset[regno], SLOT_REQUIRED))
       {
 	frame.reg_offset[regno] = offset;
-	if (frame.wb_candidate1 == INVALID_REGNUM)
-	  frame.wb_candidate1 = regno;
-	else if (frame.wb_candidate2 == INVALID_REGNUM)
-	  frame.wb_candidate2 = regno;
+	if (frame.wb_push_candidate1 == INVALID_REGNUM)
+	  frame.wb_push_candidate1 = regno;
+	else if (frame.wb_push_candidate2 == INVALID_REGNUM)
+	  frame.wb_push_candidate2 = regno;
 	offset += UNITS_PER_WORD;
       }
 
@@ -7443,11 +7444,11 @@ aarch64_layout_frame (void)
 	  }
 
 	frame.reg_offset[regno] = offset;
-	if (frame.wb_candidate1 == INVALID_REGNUM)
-	  frame.wb_candidate1 = regno;
-	else if (frame.wb_candidate2 == INVALID_REGNUM
-		 && frame.wb_candidate1 >= V0_REGNUM)
-	  frame.wb_candidate2 = regno;
+	if (frame.wb_push_candidate1 == INVALID_REGNUM)
+	  frame.wb_push_candidate1 = regno;
+	else if (frame.wb_push_candidate2 == INVALID_REGNUM
+		 && frame.wb_push_candidate1 >= V0_REGNUM)
+	  frame.wb_push_candidate2 = regno;
 	offset += vector_save_size;
       }
 
@@ -7478,10 +7479,38 @@ aarch64_layout_frame (void)
   frame.sve_callee_adjust = 0;
   frame.callee_offset = 0;
 
+  frame.wb_pop_candidate1 = frame.wb_push_candidate1;
+  frame.wb_pop_candidate2 = frame.wb_push_candidate2;
+
+  /* Shadow call stack only deals with functions where the LR is pushed
+     onto the stack and without specifying the "no_sanitize" attribute
+     with the argument "shadow-call-stack".  */
+  frame.is_scs_enabled
+    = (!crtl->calls_eh_return
+       && sanitize_flags_p (SANITIZE_SHADOW_CALL_STACK)
+       && known_ge (cfun->machine->frame.reg_offset[LR_REGNUM], 0));
+
+  /* When shadow call stack is enabled, the scs_pop in the epilogue will
+     restore x30, and we don't need to pop x30 again in the traditional
+     way.  Pop candidates record the registers that need to be popped
+     eventually.  */
+  if (frame.is_scs_enabled)
+    {
+      if (frame.wb_push_candidate2 == R30_REGNUM)
+	frame.wb_pop_candidate2 = INVALID_REGNUM;
+      else if (frame.wb_push_candidate1 == R30_REGNUM)
+	frame.wb_pop_candidate1 = INVALID_REGNUM;
+    }
+
+  /* If candidate2 is INVALID_REGNUM, we need to adjust max_push_offset to
+     256 to ensure that the offset meets the requirements of emit_move_insn.
+     Similarly, if candidate1 is INVALID_REGNUM, we need to set
+     max_push_offset to 0, because no registers are popped at this time,
+     so callee_adjust cannot be adjusted.  */
   HOST_WIDE_INT max_push_offset = 0;
-  if (frame.wb_candidate2 != INVALID_REGNUM)
+  if (frame.wb_pop_candidate2 != INVALID_REGNUM)
     max_push_offset = 512;
-  else if (frame.wb_candidate1 != INVALID_REGNUM)
+  else if (frame.wb_pop_candidate1 != INVALID_REGNUM)
     max_push_offset = 256;
 
   HOST_WIDE_INT const_size, const_outgoing_args_size, const_fp_offset;
@@ -7571,8 +7600,8 @@ aarch64_layout_frame (void)
     {
       /* We've decided not to associate any register saves with the initial
 	 stack allocation.  */
-      frame.wb_candidate1 = INVALID_REGNUM;
-      frame.wb_candidate2 = INVALID_REGNUM;
+      frame.wb_pop_candidate1 = frame.wb_push_candidate1 = INVALID_REGNUM;
+      frame.wb_pop_candidate2 = frame.wb_push_candidate2 = INVALID_REGNUM;
     }
 
   frame.laid_out = true;
@@ -7885,8 +7914,8 @@ aarch64_save_callee_saves (poly_int64 start_offset,
       bool frame_related_p = aarch64_emit_cfi_for_reg_p (regno);
 
       if (skip_wb
-	  && (regno == cfun->machine->frame.wb_candidate1
-	      || regno == cfun->machine->frame.wb_candidate2))
+	  && (regno == cfun->machine->frame.wb_push_candidate1
+	      || regno == cfun->machine->frame.wb_push_candidate2))
 	continue;
 
       if (cfun->machine->reg_is_wrapped_separately[regno])
@@ -7996,8 +8025,8 @@ aarch64_restore_callee_saves (poly_int64 start_offset, unsigned start,
       rtx reg, mem;
 
       if (skip_wb
-	  && (regno == cfun->machine->frame.wb_candidate1
-	      || regno == cfun->machine->frame.wb_candidate2))
+	  && (regno == cfun->machine->frame.wb_push_candidate1
+	      || regno == cfun->machine->frame.wb_push_candidate2))
 	continue;
 
       machine_mode mode = aarch64_reg_save_mode (regno);
@@ -8168,8 +8197,8 @@ aarch64_get_separate_components (void)
   if (cfun->machine->frame.spare_pred_reg != INVALID_REGNUM)
     bitmap_clear_bit (components, cfun->machine->frame.spare_pred_reg);
 
-  unsigned reg1 = cfun->machine->frame.wb_candidate1;
-  unsigned reg2 = cfun->machine->frame.wb_candidate2;
+  unsigned reg1 = cfun->machine->frame.wb_push_candidate1;
+  unsigned reg2 = cfun->machine->frame.wb_push_candidate2;
   /* If registers have been chosen to be stored/restored with
      writeback don't interfere with them to avoid having to output explicit
      stack adjustment instructions.  */
@@ -8778,8 +8807,8 @@ aarch64_expand_prologue (void)
   poly_int64 sve_callee_adjust = cfun->machine->frame.sve_callee_adjust;
   poly_int64 below_hard_fp_saved_regs_size
     = cfun->machine->frame.below_hard_fp_saved_regs_size;
-  unsigned reg1 = cfun->machine->frame.wb_candidate1;
-  unsigned reg2 = cfun->machine->frame.wb_candidate2;
+  unsigned reg1 = cfun->machine->frame.wb_push_candidate1;
+  unsigned reg2 = cfun->machine->frame.wb_push_candidate2;
   bool emit_frame_chain = cfun->machine->frame.emit_frame_chain;
   rtx_insn *insn;
 
@@ -8810,6 +8839,10 @@ aarch64_expand_prologue (void)
       RTX_FRAME_RELATED_P (insn) = 1;
     }
 
+  /* Push return address to shadow call stack.  */
+  if (cfun->machine->frame.is_scs_enabled)
+    emit_insn (gen_scs_push ());
+
   if (flag_stack_usage_info)
     current_function_static_stack_size = constant_lower_bound (frame_size);
 
@@ -8956,8 +8989,8 @@ aarch64_expand_epilogue (bool for_sibcall)
   poly_int64 sve_callee_adjust = cfun->machine->frame.sve_callee_adjust;
   poly_int64 below_hard_fp_saved_regs_size
     = cfun->machine->frame.below_hard_fp_saved_regs_size;
-  unsigned reg1 = cfun->machine->frame.wb_candidate1;
-  unsigned reg2 = cfun->machine->frame.wb_candidate2;
+  unsigned reg1 = cfun->machine->frame.wb_pop_candidate1;
+  unsigned reg2 = cfun->machine->frame.wb_pop_candidate2;
   rtx cfi_ops = NULL;
   rtx_insn *insn;
   /* A stack clash protection prologue may not have left EP0_REGNUM or
@@ -9027,9 +9060,19 @@ aarch64_expand_epilogue (bool for_sibcall)
 				false, &cfi_ops);
   if (maybe_ne (sve_callee_adjust, 0))
     aarch64_add_sp (NULL_RTX, NULL_RTX, sve_callee_adjust, true);
-  aarch64_restore_callee_saves (callee_offset - sve_callee_adjust,
-				R0_REGNUM, R30_REGNUM,
-				callee_adjust != 0, &cfi_ops);
+
+  /* When shadow call stack is enabled, the scs_pop in the epilogue will
+     restore x30, we don't need to restore x30 again in the traditional
+     way.  */
+  if (cfun->machine->frame.is_scs_enabled)
+    aarch64_restore_callee_saves (callee_offset - sve_callee_adjust,
+				  R0_REGNUM, R29_REGNUM,
+				  callee_adjust != 0, &cfi_ops);
+  else
+    aarch64_restore_callee_saves (callee_offset - sve_callee_adjust,
+				  R0_REGNUM, R30_REGNUM,
+				  callee_adjust != 0, &cfi_ops);
+
 
   if (need_barrier_p)
     emit_insn (gen_stack_tie (stack_pointer_rtx, stack_pointer_rtx));
@@ -9066,6 +9109,17 @@ aarch64_expand_epilogue (bool for_sibcall)
       RTX_FRAME_RELATED_P (insn) = 1;
     }
 
+  /* Pop return address from shadow call stack.  */
+  if (cfun->machine->frame.is_scs_enabled)
+    {
+      machine_mode mode = aarch64_reg_save_mode (R30_REGNUM);
+      rtx reg = gen_rtx_REG (mode, R30_REGNUM);
+
+      insn = emit_insn (gen_scs_pop ());
+      add_reg_note (insn, REG_CFA_RESTORE, reg);
+      RTX_FRAME_RELATED_P (insn) = 1;
+    }
+
   /* We prefer to emit the combined return/authenticate instruction RETAA,
      however there are three cases in which we must instead emit an explicit
      authentication instruction.
@@ -16492,6 +16546,10 @@ aarch64_override_options_internal (struct gcc_options *opts)
       aarch64_stack_protector_guard_offset = offs;
     }
 
+  if ((flag_sanitize & SANITIZE_SHADOW_CALL_STACK)
+      && !fixed_regs[R18_REGNUM])
+    error ("%<-fsanitize=shadow-call-stack%> requires %<-ffixed-x18%>");
+
   initialize_aarch64_code_model (opts);
   initialize_aarch64_tls_size (opts);
 
@@ -26505,6 +26563,9 @@ aarch64_libgcc_floating_mode_supported_p
 #undef TARGET_ASM_FUNCTION_EPILOGUE
 #define TARGET_ASM_FUNCTION_EPILOGUE aarch64_sls_emit_blr_function_thunks
 
+#undef TARGET_HAVE_SHADOW_CALL_STACK
+#define TARGET_HAVE_SHADOW_CALL_STACK true
+
 struct gcc_target targetm = TARGET_INITIALIZER;
 
 #include "gt-aarch64.h"
diff --git a/gcc/config/aarch64/aarch64.h b/gcc/config/aarch64/aarch64.h
index 2792bb29adb..b5efe083f30 100644
--- a/gcc/config/aarch64/aarch64.h
+++ b/gcc/config/aarch64/aarch64.h
@@ -906,9 +906,21 @@ struct GTY (()) aarch64_frame
 	 Indicated by CALLEE_ADJUST == 0 && EMIT_FRAME_CHAIN.
 
      These fields indicate which registers we've decided to handle using
-     (1) or (2), or INVALID_REGNUM if none.  */
-  unsigned wb_candidate1;
-  unsigned wb_candidate2;
+     (1) or (2), or INVALID_REGNUM if none.
+
+     In some cases we don't always need to pop all registers in the push
+     candidates, pop candidates record which registers need to be popped
+     eventually.  The initial value of a pop candidate is copied from its
+     corresponding push candidate.
+
+     Currently, the pop candidates are only used for shadow call stack.
+     When "-fsanitize=shadow-call-stack" is specified, we replace x30 in
+     the pop candidate with INVALID_REGNUM to ensure that x30 is not
+     popped twice.  */
+  unsigned wb_push_candidate1;
+  unsigned wb_push_candidate2;
+  unsigned wb_pop_candidate1;
+  unsigned wb_pop_candidate2;
 
   /* Big-endian SVE frames need a spare predicate register in order
      to save vector registers in the correct layout for unwinding.
@@ -916,6 +928,9 @@ struct GTY (()) aarch64_frame
   unsigned spare_pred_reg;
 
   bool laid_out;
+
+  /* True if shadow call stack should be enabled for the current function.  */
+  bool is_scs_enabled;
 };
 
 typedef struct GTY (()) machine_function
diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.md
index 1a39470a1fe..48666b4b218 100644
--- a/gcc/config/aarch64/aarch64.md
+++ b/gcc/config/aarch64/aarch64.md
@@ -6994,6 +6994,16 @@ (define_insn "xpaclri"
   "hint\t7 // xpaclri"
 )
 
+;; Save X30 in the X18-based POST_INC stack (consistent with clang).
+(define_expand "scs_push"
+  [(set (mem:DI (post_inc:DI (reg:DI R18_REGNUM)))
+	(reg:DI R30_REGNUM))])
+
+;; Load X30 form the X18-based PRE_DEC stack (consistent with clang).
+(define_expand "scs_pop"
+  [(set (reg:DI R30_REGNUM)
+	(mem:DI (pre_dec:DI (reg:DI R18_REGNUM))))])
+
 ;; UNSPEC_VOLATILE is considered to use and clobber all hard registers and
 ;; all of memory.  This blocks insns from being moved across this point.
 
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 71992b8c597..1e580107fab 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -15224,6 +15224,36 @@ add @code{detect_invalid_pointer_pairs=2} to the environment variable
 @env{ASAN_OPTIONS}. Using @code{detect_invalid_pointer_pairs=1} detects
 invalid operation only when both pointers are non-null.
 
+@item -fsanitize=shadow-call-stack
+@opindex fsanitize=shadow-call-stack
+Enable ShadowCallStack, a security enhancement mechanism used to protect
+programs against return address overwrites (e.g. stack buffer overflows.)
+It works by saving a function's return address to a separately allocated
+shadow call stack in the function prologue and restoring the return address
+from the shadow call stack in the function epilogue.  Instrumentation only
+occurs in functions that need to save the return address to the stack.
+
+Currently it only supports the aarch64 platform.  It is specifically
+designed for linux kernels that enable the CONFIG_SHADOW_CALL_STACK option.
+For the user space programs, runtime support is not currently provided
+in libc and libgcc.  Users who want to use this feature in user space need
+to provide their own support for the runtime.  It should be noted that
+this may cause the ABI rules to be broken.
+
+On aarch64, the instrumentation makes use of the platform register @code{x18}.
+This generally means that any code that may run on the same thread as code
+compiled with ShadowCallStack must be compiled with the flag
+@option{-ffixed-x18}, otherwise functions compiled without
+@option{-ffixed-x18} might clobber @code{x18} and so corrupt the shadow
+stack pointer.
+
+Also, because there is no userspace runtime support, code compiled with
+ShadowCallStack cannot use exception handling.  Use @option{-fno-exceptions}
+to turn off exceptions.
+
+See @uref{https://clang.llvm.org/docs/ShadowCallStack.html} for more
+details.
+
 @item -fsanitize=thread
 @opindex fsanitize=thread
 Enable ThreadSanitizer, a fast data race detector.
diff --git a/gcc/doc/tm.texi b/gcc/doc/tm.texi
index 990152f5b15..19c130d7420 100644
--- a/gcc/doc/tm.texi
+++ b/gcc/doc/tm.texi
@@ -12575,3 +12575,8 @@ counters are incremented using atomic operations.  Targets not supporting
 64-bit atomic operations may override the default value and request a 32-bit
 type.
 @end deftypefn
+
+@deftypevr {Target Hook} bool TARGET_HAVE_SHADOW_CALL_STACK
+This value is true if the target platform supports
+@option{-fsanitize=shadow-call-stack}.  The default value is false.
+@end deftypevr
diff --git a/gcc/doc/tm.texi.in b/gcc/doc/tm.texi.in
index 193c9bdd853..01db5f54b5a 100644
--- a/gcc/doc/tm.texi.in
+++ b/gcc/doc/tm.texi.in
@@ -8179,3 +8179,5 @@ maintainer is familiar with.
 @hook TARGET_MEMTAG_UNTAGGED_POINTER
 
 @hook TARGET_GCOV_TYPE_SIZE
+
+@hook TARGET_HAVE_SHADOW_CALL_STACK
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
index 4472cec1b98..b2e00e8067a 100644
--- a/gcc/opts.c
+++ b/gcc/opts.c
@@ -1994,6 +1994,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =
   SANITIZER_OPT (vptr, SANITIZE_VPTR, true),
   SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true),
   SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true),
+  SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false),
   SANITIZER_OPT (all, ~0U, true),
 #undef SANITIZER_OPT
   { NULL, 0U, 0UL, false }
diff --git a/gcc/target.def b/gcc/target.def
index 87feeec2ea1..ce382714399 100644
--- a/gcc/target.def
+++ b/gcc/target.def
@@ -7084,6 +7084,14 @@ counters are incremented using atomic operations.  Targets not supporting\n\
 type.",
  HOST_WIDE_INT, (void), default_gcov_type_size)
 
+/* This value represents whether the shadow call stack is implemented on
+   the target platform.  */
+DEFHOOKPOD
+(have_shadow_call_stack,
+ "This value is true if the target platform supports\n\
+@option{-fsanitize=shadow-call-stack}.  The default value is false.",
+ bool, false)
+
 /* Close the 'struct gcc_target' definition.  */
 HOOK_VECTOR_END (C90_EMPTY_HACK)
 
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_1.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_1.c
new file mode 100644
index 00000000000..ab68d6e8482
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_1.c
@@ -0,0 +1,6 @@
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=shadow-call-stack -fno-exceptions" } */
+
+int i;
+
+/* { dg-error "'-fsanitize=shadow-call-stack' requires '-ffixed-x18'" "" {target "aarch64*-*-*" } 0 } */
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_2.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_2.c
new file mode 100644
index 00000000000..b5139a24559
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_2.c
@@ -0,0 +1,6 @@
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=shadow-call-stack -ffixed-x18 -fexceptions" } */
+
+int i;
+
+/* { dg-error "'-fsanitize=shadow-call-stack' requires '-fno-exceptions'" "" {target "aarch64*-*-*" } 0 } */
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_3.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_3.c
new file mode 100644
index 00000000000..b88e490f3ae
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_3.c
@@ -0,0 +1,45 @@
+/* Testing shadow call stack.  */
+/* scs_push: str x30, [x18], #8 */
+/* scs_pop: ldr x30, [x18, #-8]! */
+/* { dg-do compile } */
+/* { dg-options "-O2 -fsanitize=shadow-call-stack -ffixed-x18 -fno-exceptions" } */
+
+int foo (int);
+
+/* function not use x30.  */
+int func1 (void)
+{
+  return 0;
+}
+
+/* function use x30.  */
+int func2 (void)
+{
+  /* scs push */
+  asm volatile ("":::"x30");
+
+  return 0;
+  /* scs pop */
+}
+
+/* sibcall.  */
+int func3 (int a, int b)
+{
+  /* scs push */
+  asm volatile ("":::"x30");
+
+  return foo (a+b);
+  /* scs pop */
+}
+
+/* eh_return.  */
+int func4 (long offset, void *handler)
+{
+  /* Do not emit scs push/pop */
+  asm volatile ("":::"x30");
+
+  __builtin_eh_return (offset, handler);
+}
+
+/* { dg-final { scan-assembler-times {str\tx30, \[x18\], #?8} 2 } } */
+/* { dg-final { scan-assembler-times {ldr\tx30, \[x18, #?-8\]!} 2 } } */
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_4.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_4.c
new file mode 100644
index 00000000000..f63169340e1
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_4.c
@@ -0,0 +1,20 @@
+/* Testing the disable of shadow call stack.  */
+/* scs_push: str x30, [x18], #8 */
+/* scs_pop: ldr x30, [x18, #-8]! */
+/* { dg-do compile } */
+/* { dg-options "-O2 -fno-omit-frame-pointer -fsanitize=shadow-call-stack -ffixed-x18 -fno-exceptions" } */
+
+int foo (int);
+
+/* function disable shadow call stack.  */
+int __attribute__((no_sanitize("shadow-call-stack"))) func1 (void)
+{
+  asm volatile ("":::"x30");
+
+  return 0;
+}
+
+/* { dg-final { scan-assembler-not {str\tx30, \[x18\], #?8} } } */
+/* { dg-final { scan-assembler-not {ldr\tx30, \[x18, #?-8\]!} } } */
+/* { dg-final { scan-assembler-times {stp\tx29, x30, \[sp, -[0-9]+\]!} 1 } } */
+/* { dg-final { scan-assembler-times {ldp\tx29, x30, \[sp\], [0-9]+} 1 } } */
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_5.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_5.c
new file mode 100644
index 00000000000..d88357ca04d
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_5.c
@@ -0,0 +1,18 @@
+/* Verify:
+     * -fno-omit-frame-pointer -fsanitize=shadow-call-stack -fno-exceptions -ffixed-x18.
+     * without outgoing.
+     * total frame size <= 512 but > 256.
+     * callee-saved reg: x29, x30.
+     * optimized code should use "stp	x29, x30, [sp]" to save frame chain.
+     * optimized code should use "ldr	x29, [sp]" to restore x29 only.  */
+
+/* { dg-do compile } */
+/* { dg-options "-O2 -fno-omit-frame-pointer -fsanitize=shadow-call-stack -fno-exceptions -ffixed-x18 --save-temps" } */
+
+#include "test_frame_common.h"
+
+t_frame_pattern (func1, 400, )
+
+/* { dg-final { scan-assembler-times {stp\tx29, x30, \[sp\]} 1 } } */
+/* { dg-final { scan-assembler {ldr\tx29, \[sp\]} } } */
+
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_6.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_6.c
new file mode 100644
index 00000000000..83b74834c6a
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_6.c
@@ -0,0 +1,18 @@
+/* Verify:
+     * -fomit-frame-pointer -fsanitize=shadow-call-stack -fno-exceptions -ffixed-x18.
+     * without outgoing.
+     * total frame size <= 256.
+     * callee-saved reg: x30 only.
+     * optimized code should use "str   x30, [sp]" to save x30 in prologue.
+     * optimized code should not restore x30 in epilogue.  */
+
+/* { dg-do compile } */
+/* { dg-options "-O2 -fomit-frame-pointer -fsanitize=shadow-call-stack -fno-exceptions -ffixed-x18 --save-temps" } */
+
+#include "test_frame_common.h"
+
+t_frame_pattern (func1, 200, )
+
+/* { dg-final { scan-assembler-times {str\tx30, \[sp\]} 1 } } */
+/* { dg-final { scan-assembler-not {ld[r|p]\tx30, \[sp} } } */
+
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_7.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_7.c
new file mode 100644
index 00000000000..5537fb3293a
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_7.c
@@ -0,0 +1,18 @@
+/* Verify:
+     * -fomit-frame-pointer -fsanitize=shadow-call-stack -fno-exceptions -ffixed-x18.
+     * without outgoing.
+     * total frame size <= 256.
+     * callee-saved reg: x19, x30.
+     * optimized code should use "stp   x19, x30, [sp, -x]!" to save x19, x30 in prologue.
+     * optimized code should use "ldr   x19, [sp], x" to restore x19 only.  */
+
+/* { dg-do compile } */
+/* { dg-options "-O2 -fomit-frame-pointer -fsanitize=shadow-call-stack -fno-exceptions -ffixed-x18 --save-temps" } */
+
+#include "test_frame_common.h"
+
+t_frame_pattern (func1, 200, "x19")
+
+/* { dg-final { scan-assembler-times {stp\tx19, x30, \[sp, -[0-9]+\]!} 1 } } */
+/* { dg-final { scan-assembler {ldr\tx19, \[sp\], [0-9]+} } } */
+
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_8.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_8.c
new file mode 100644
index 00000000000..b03f26f7bcf
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_8.c
@@ -0,0 +1,24 @@
+/* Verify:
+     * -fomit-frame-pointer -fsanitize=shadow-call-stack -fno-exceptions -ffixed-x18.
+     * without outgoing.
+     * total frame <= 512 but > 256.
+     * callee-saved reg: x19, x20, x30.
+     * optimized code should use "stp   x19, x20, [sp, -x]!" to save x19, x20 in prologue.
+     * optimized code should use "str	x30, [sp " to save x30 in prologue.
+     * optimized code should use "ldp	x19, x20, [sp], x" to retore x19, x20 in epilogue.
+     * optimized code should not restore x30 in epilogue.  */
+
+/* { dg-do compile } */
+/* { dg-options "-O0 -fomit-frame-pointer -fsanitize=shadow-call-stack -fno-exceptions -ffixed-x18 --save-temps" } */
+
+int func1 (void)
+{
+  unsigned char a[200];
+  __asm__ ("":::"x19","x20","x30");
+  return 0;
+}
+
+/* { dg-final { scan-assembler-times {stp\tx19, x20, \[sp, -[0-9]+\]!} 1 } } */
+/* { dg-final { scan-assembler-times {str\tx30, \[sp} 1 } } */
+/* { dg-final { scan-assembler {ldp\tx19, x20, \[sp\], [0-9]+} } } */
+/* { dg-final { scan-assembler-not {ld[r|p]\tx30, \[sp} } } */
diff --git a/gcc/toplev.c b/gcc/toplev.c
index e91f083f8ff..93d17ddbda1 100644
--- a/gcc/toplev.c
+++ b/gcc/toplev.c
@@ -1677,6 +1677,16 @@ process_options (bool no_backend)
       flag_sanitize &= ~SANITIZE_HWADDRESS;
     }
 
+  if (flag_sanitize & SANITIZE_SHADOW_CALL_STACK)
+    {
+      if (!targetm.have_shadow_call_stack)
+	sorry ("%<-fsanitize=shadow-call-stack%> not supported "
+	       "in current platform");
+      else if (flag_exceptions)
+	error_at (UNKNOWN_LOCATION, "%<-fsanitize=shadow-call-stack%> "
+		  "requires %<-fno-exceptions%>");
+    }
+
   HOST_WIDE_INT patch_area_size, patch_area_start;
   parse_and_check_patch_area (flag_patchable_function_entry, false,
 			      &patch_area_size, &patch_area_start);
-- 
2.17.1

