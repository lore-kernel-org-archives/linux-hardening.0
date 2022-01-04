Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52424C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jan 2022 14:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiADOkN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jan 2022 09:40:13 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40060 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230044AbiADOkM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jan 2022 09:40:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V0yywcm_1641307209;
Received: from 192.168.193.151(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V0yywcm_1641307209)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jan 2022 22:40:10 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
Subject: [PING^2][PATCH,v2,1/1,AARCH64][PR102768] aarch64: Add compiler
 support for Shadow Call Stack
To:     gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Cc:     richard.earnshaw@arm.com, richard.sandiford@arm.com,
        marcus.shawcroft@arm.com, kyrylo.tkachov@arm.com, hp@gcc.gnu.org,
        ndesaulniers@google.com, nsz@gcc.gnu.org, pageexec@gmail.com,
        qinzhao@gcc.gnu.org
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
Message-ID: <3074f5cf-8472-2d14-56e8-92d0e3e86879@linux.alibaba.com>
Date:   Tue, 4 Jan 2022 06:40:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211102070616.119780-1-ashimida@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Gentile ping for this again :), thanks.
Link: https://gcc.gnu.org/pipermail/gcc-patches/2021-December/586204.html

> Shadow Call Stack can be used to protect the return address of a
> function at runtime, and clang already supports this feature[1].
> 
> To enable SCS in user mode, in addition to compiler, other support
> is also required (as discussed in [2]). This patch only adds basic
> support for SCS from the compiler side, and provides convenience
> for users to enable SCS.
> 
> For linux kernel, only the support of the compiler is required.
> 
> [1] https://clang.llvm.org/docs/ShadowCallStack.html
> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102768
> 
Signed-off-by: Dan Li <ashimida@linux.alibaba.com>

gcc/c-family/ChangeLog:

	* c-attribs.c (handle_no_sanitize_shadow_call_stack_attribute):
	New.

gcc/ChangeLog:

	* config/aarch64/aarch64-protos.h (aarch64_shadow_call_stack_enabled):
	New decl.
	* config/aarch64/aarch64.c (aarch64_shadow_call_stack_enabled):
	New.
	(aarch64_expand_prologue):	Push x30 onto SCS before it's
	pushed onto stack.
	(aarch64_expand_epilogue):	Pop x30 frome SCS.
	* config/aarch64/aarch64.h (TARGET_SUPPORT_SHADOW_CALL_STACK):
	New macro.
	(TARGET_CHECK_SCS_RESERVED_REGISTER):	Likewise.
	* config/aarch64/aarch64.md (scs_push):	New template.
	(scs_pop):	Likewise.
	* defaults.h (TARGET_SUPPORT_SHADOW_CALL_STACK):	New macro.
	* doc/extend.texi:	Document -fsanitize=shadow-call-stack.
	* doc/invoke.texi:	Document attribute.
	* flag-types.h (enum sanitize_code):	Add
	SANITIZE_SHADOW_CALL_STACK.
	* opts-global.c (handle_common_deferred_options):	Add SCS
	compile option check.
	* opts.c (finish_options):	Likewise.

gcc/testsuite/ChangeLog:

	* gcc.target/aarch64/shadow_call_stack_1.c: New test.
	* gcc.target/aarch64/shadow_call_stack_2.c: New test.
	* gcc.target/aarch64/shadow_call_stack_3.c: New test.
	* gcc.target/aarch64/shadow_call_stack_4.c: New test.
---
  gcc/c-family/c-attribs.c                      | 21 +++++++++
  gcc/config/aarch64/aarch64-protos.h           |  1 +
  gcc/config/aarch64/aarch64.c                  | 27 +++++++++++
  gcc/config/aarch64/aarch64.h                  | 11 +++++
  gcc/config/aarch64/aarch64.md                 | 18 ++++++++
  gcc/defaults.h                                |  4 ++
  gcc/doc/extend.texi                           |  7 +++
  gcc/doc/invoke.texi                           | 29 ++++++++++++
  gcc/flag-types.h                              |  2 +
  gcc/opts-global.c                             |  6 +++
  gcc/opts.c                                    | 12 +++++
  .../gcc.target/aarch64/shadow_call_stack_1.c  |  6 +++
  .../gcc.target/aarch64/shadow_call_stack_2.c  |  6 +++
  .../gcc.target/aarch64/shadow_call_stack_3.c  | 45 +++++++++++++++++++
  .../gcc.target/aarch64/shadow_call_stack_4.c  | 18 ++++++++
  15 files changed, 213 insertions(+)
  create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_1.c
  create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_2.c
  create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_3.c
  create mode 100644 gcc/testsuite/gcc.target/aarch64/shadow_call_stack_4.c

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
index 2792bb29adb..bdd50a8d0a1 100644
--- a/gcc/config/aarch64/aarch64.h
+++ b/gcc/config/aarch64/aarch64.h
@@ -100,6 +100,17 @@
     generating stack clash probes.  */
  #define STACK_CLASH_MAX_UNROLL_PAGES 4
  
+/* This value represents whether the shadow call stack is implemented on
+   the target platform.  */
+#define TARGET_SUPPORT_SHADOW_CALL_STACK true
+
+#define TARGET_CHECK_SCS_RESERVED_REGISTER()	\
+  do {						\
+    if (!fixed_regs[R18_REGNUM])		\
+      error ("%<-fsanitize=shadow-call-stack%> only "	\
+	     "allowed with %<-ffixed-x18%>");	\
+  } while (0)
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
diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
index eee4c6737bb..16c3fc367fa 100644
--- a/gcc/doc/extend.texi
+++ b/gcc/doc/extend.texi
@@ -3453,6 +3453,13 @@ The @code{no_address_safety_analysis} is a deprecated alias of the
  @code{no_sanitize_address} attribute, new code should use
  @code{no_sanitize_address}.
  
+@item no_sanitize_shadow_call_stack
+@cindex @code{no_sanitize_shadow_call_stack} function attribute
+The @code{no_sanitize_shadow_call_stack} attribute on functions is used
+to inform the compiler that it should not instrument shadow call stack
+push/pop instructions in the function when compiling with the
+@option{-fsanitize=shadow-call-stack} option.
+
  @item no_sanitize_thread
  @cindex @code{no_sanitize_thread} function attribute
  The @code{no_sanitize_thread} attribute on functions is used
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 71992b8c597..2c134c68e83 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -15224,6 +15224,35 @@ add @code{detect_invalid_pointer_pairs=2} to the environment variable
  @env{ASAN_OPTIONS}. Using @code{detect_invalid_pointer_pairs=1} detects
  invalid operation only when both pointers are non-null.
  
+@item -fsanitize=shadow-call-stack
+@opindex fsanitize=shadow-call-stack
+Enable ShadowCallStack, a security enhancement mechanism used to protect
+programs against return address overwrites (e.g. stack buffer overflows.)
+It works by saving a function's return address to a separately allocated
+shadow call stack in the function prologue and restore the return address
+from the shadow call stack in the function epilogue.  Instrumentation only
+occurs in functions that need to save the return address to the stack.
+
+Currently it only supports the aarch64 platform and only works fine in
+the linux kernel that implements CONFIG_SHADOW_CALL_STACK.
+For the user space programs, runtime support is not currently provided
+in libc and libgcc.  Users who want to use this feature in user space need
+to provide their own support for the runtime.  It should be noted that
+this may cause the ABI rules to be broken.
+
+On aarch64, the instrumentation makes use of the platform register 'x18'.
+This generally means that any code that may run on the same thread as code
+compiled with ShadowCallStack must be compiled with the flag
+@option{-ffixed-x18}, otherwise functions compiled without
+@option{-ffixed-x18} may clobber x18 and break scs.
+
+And also because there is no runtime support, the code compiled with
+ShadowCallStack cannot use exception handling, @option{-fno-exceptions}
+also needs to be specified.
+
+See @uref{https://clang.llvm.org/docs/ShadowCallStack.html} for more
+details.
+
  @item -fsanitize=thread
  @opindex fsanitize=thread
  Enable ThreadSanitizer, a fast data race detector.
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
diff --git a/gcc/opts-global.c b/gcc/opts-global.c
index 55273822ec5..98e1d636f7f 100644
--- a/gcc/opts-global.c
+++ b/gcc/opts-global.c
@@ -477,4 +477,10 @@ handle_common_deferred_options (void)
  	  gcc_unreachable ();
  	}
      }
+
+#ifdef TARGET_CHECK_SCS_RESERVED_REGISTER
+  if (flag_sanitize & SANITIZE_SHADOW_CALL_STACK)
+    TARGET_CHECK_SCS_RESERVED_REGISTER ();
+#endif
+
  }
diff --git a/gcc/opts.c b/gcc/opts.c
index 4472cec1b98..fc84a07a4ab 100644
--- a/gcc/opts.c
+++ b/gcc/opts.c
@@ -1308,6 +1308,17 @@ finish_options (struct gcc_options *opts, struct gcc_options *opts_set,
      sorry ("transactional memory is not supported with "
  	   "%<-fsanitize=kernel-address%>");
  
+  if (opts->x_flag_sanitize & SANITIZE_SHADOW_CALL_STACK)
+    {
+      if (!TARGET_SUPPORT_SHADOW_CALL_STACK)
+	error_at (loc, "%<-fsanitize=shadow-call-stack%> not supported "
+		  "in current platform");
+
+      if (opts->x_flag_exceptions)
+	error_at (loc, "%<-fsanitize=shadow-call-stack%> only allowed "
+		  "with %<-fno-exceptions%>");
+    }
+
    /* Currently live patching is not support for LTO.  */
    if (opts->x_flag_live_patching && opts->x_flag_lto)
      sorry ("live patching is not supported with LTO");
@@ -1994,6 +2005,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =
    SANITIZER_OPT (vptr, SANITIZE_VPTR, true),
    SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true),
    SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true),
+  SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false),
    SANITIZER_OPT (all, ~0U, true),
  #undef SANITIZER_OPT
    { NULL, 0U, 0UL, false }
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_1.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_1.c
new file mode 100644
index 00000000000..b8234ca0677
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_1.c
@@ -0,0 +1,6 @@
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=shadow-call-stack" } */
+
+int i;
+
+/* { dg-error "'-fsanitize=shadow-call-stack' only allowed with '-ffixed-x18'" "" {target "aarch64*-*-*" } 0 } */
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_2.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_2.c
new file mode 100644
index 00000000000..b0c663f26d3
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_2.c
@@ -0,0 +1,6 @@
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=shadow-call-stack -ffixed-x18 -fexceptions" } */
+
+int i;
+
+/* { dg-error "'-fsanitize=shadow-call-stack' only allowed with '-fno-exceptions'" "" {target "aarch64*-*-*" } 0 } */
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_3.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_3.c
new file mode 100644
index 00000000000..511b5f0d693
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
+/* { dg-final { scan-assembler-times "str\tx30, \\\[x18\\\], #8" 2 } } */
+/* { dg-final { scan-assembler-times "ldr\tx30, \\\[x18, #-8\\\]!" 2 } } */
diff --git a/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_4.c b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_4.c
new file mode 100644
index 00000000000..a1b1cf16655
--- /dev/null
+++ b/gcc/testsuite/gcc.target/aarch64/shadow_call_stack_4.c
@@ -0,0 +1,18 @@
+/* Testing the disable of shadow call stack.  */
+/* scs_push: str x30, [x18], #8 */
+/* scs_pop: ldr x30, [x18, #-8]! */
+/* { dg-do compile } */
+/* { dg-options "-O2 -fsanitize=shadow-call-stack -ffixed-x18 -fno-exceptions" } */
+
+int foo (int);
+
+/* function disable shadow call stack.  */
+int __attribute__((no_sanitize_shadow_call_stack)) func1 (void)
+{
+  asm volatile ("":::"x30");
+
+  return 0;
+}
+
+/* { dg-final { scan-assembler-not "str\tx30, \\\[x18\\\], #8" } } */
+/* { dg-final { scan-assembler-not "ldr\tx30, \\\[x18, #-8\\\]!" } } */
-- 
2.17.1
