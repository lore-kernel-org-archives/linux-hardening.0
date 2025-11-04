Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3E337109
	for <linux-hardening@vger.kernel.org>; Tue,  4 Nov 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275288; cv=none; b=BwEIP44bq8traIhjKsNe+SFwDOZQqt4mTyQQtvKRPytn1Ra8i74qhJfpj1/MjZp4F9eN3HIUWWKUspwKGy9LydPclXXQKpUf814AcrWnQzcSCBYWAGa8viPo4iRW+62CvrkPFxfbC50WLB72sMZk8DwACvozj+hvDS/u+6/0lR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275288; c=relaxed/simple;
	bh=JAtNg0M6kmc4mGY5YUKfpDISkIu2dlx6Ld4znTOge4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNlEDgmLJqzAkLDMq33ll7eNF8Bx/cm2VDf07VBegBQBB5W8bC8w8fYdQLatvSGRmuqFCQD0bFCrZZ2NU8lUVwL0KTD8NtixM4HyDMmnmJoxvLBVRASodj1VXt1pajirw/9966AXO0bnKmAgwMBIh8wInS0NghRwxlcucSvW51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4cltr2B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4cltr2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FD6C2BC87;
	Tue,  4 Nov 2025 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762275288;
	bh=JAtNg0M6kmc4mGY5YUKfpDISkIu2dlx6Ld4znTOge4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4cltr2BoxCg5S3n+WfFMKthJadbiZ67/aSl+Cr/+xUN5AdJocEBdlAVpzbztidop
	 lKLu4IdReKYg0UPrgX3OfdCN3m1PMLoc8w8GNBTTQ3frYtDghhlrZoqSRAA4Bun3ts
	 PQisEBxBYr90yHjuvHxdysgbU9fpBooDLYOD/U8DhAjNQAl1N7X3nLX35rZmSl2g+G
	 WHlpMeM1Z7BLaJj3I2FaA9DFzV3LLLjdpX4JltY4rh/MAquf1Yy/XNNvc6mlVzjFz1
	 zpCoGCjC1Ivrt0AUv1CQ5qQT+i/tbwjZ5uiv472dtZUA6wN8+Csm68M5P20kCk0bC+
	 q3svQG/AUdbIg==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeff Law <jeffreyalaw@gmail.com>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v6 4/7] x86: Add x86_64 Kernel Control Flow Integrity implementation
Date: Tue,  4 Nov 2025 08:54:34 -0800
Message-Id: <20251104165447.2835584-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104165430.it.619-kees@kernel.org>
References: <20251104165430.it.619-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=48234; i=kees@kernel.org; h=from:subject; bh=JAtNg0M6kmc4mGY5YUKfpDISkIu2dlx6Ld4znTOge4Q=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlc+md+NFZ9jnPy1CyLeZ4nznWg8eKyM8tFn55vvbW98 DmPksmFjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImoOzEyNOxcfLiMWSJPdYem 19ELv74e+eR9c5v9nA9tW943i+lt3s3wP1bWJG/ON0a5Fw+t1zW7Lau/VSDu+5DpxWXLqM49zhu lGQE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement x86_64-specific KCFI backend:

- Implies -mindirect-branch-register since KCFI needs call target in
  a register for typeid hash loading.

- Function preamble generation with type IDs positioned at -(4+prefix_nops)
  offset from function entry point.

- Function-aligned KCFI preambles using calculated alignment padding NOPs:
  aligned(prefix_nops + 5, $func_align) to maintain ability to call the
  __cfi_ preamble directly in the case of Linux's FineIBT alternative
  CFI sequences (live patched into place).

- Type-id hash avoids generating ENDBR instruction in type IDs
  (0xfa1e0ff3/0xfb1e0ff3 are incremented by 1 to prevent execution).

- On-demand scratch register allocation strategy (r11 as needed), with
  the clobbers added when KCFI is used.

- Incompatible with -ffixed-r10 or -ffixed-r11.

- Uses the .kcfi_traps section for debugger/runtime metadata.

- Introduces -fsanitize-kcfi-arity to enable function arg count to be
  represented in the kcfi hash preamble for FineIBT.

Assembly Code Pattern layout required by Linux kernel:
  movl $inverse_type_id, %r10d   ; Load expected type (0 - hash)
  addl offset(%target), %r10d    ; Add stored type ID from preamble
  je .Lkcfi_call                 ; Branch if types match (sum == 0)
  .Lkcfi_trap: ud2               ; Undefined instruction trap on mismatch
  .Lkcfi_call: call/jmp *%target ; Execute validated indirect transfer

Build and run tested on x86_64 Linux kernel with various CPU errata
handling alternatives, with and without FineIBT patching.

gcc/ChangeLog:

	config/i386/i386.h: KCFI enables TARGET_INDIRECT_BRANCH_REGISTER.
	config/i386/i386-protos.h: Declare ix86_output_kcfi_insn().
	config/i386/i386-expand.cc (ix86_expand_call): Expand indirect
	calls into KCFI RTL.
	config/i386/i386.cc (ix86_kcfi_mask_type_id): New function.
	(ix86_output_kcfi_insn): New function to emit KCFI assembly.
	config/i386/i386.md: Add KCFI RTL patterns.
	doc/invoke.texi: Document x86 nuances.

gcc/testsuite/ChangeLog:

	* gcc.dg/kcfi/kcfi-adjacency.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-basics.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-call-sharing.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-complex-addressing.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-move-preservation.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-no-sanitize.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-offset-validation.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-patchable-large.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-patchable-medium.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-tail-calls.c: Add x86 tail-call patterns.
	* gcc.dg/kcfi/kcfi-trap-section.c: Add x86 trap patterns.
	* gcc.dg/kcfi/kcfi-x86-arity.c: New test.
	* gcc.dg/kcfi/kcfi-x86-fixed-r10.c: New test.
	* gcc.dg/kcfi/kcfi-x86-fixed-r11.c: New test.
	* gcc.dg/kcfi/kcfi-x86-retpoline-r11.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/i386/i386-protos.h                 |   1 +
 gcc/config/i386/i386.h                        |   3 +-
 gcc/config/i386/i386.md                       |  62 +++++-
 gcc/config/i386/i386-expand.cc                |  22 +-
 gcc/config/i386/i386-options.cc               |  11 +
 gcc/config/i386/i386.cc                       | 192 ++++++++++++++++++
 gcc/doc/invoke.texi                           |  46 +++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  17 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  21 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  15 ++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  18 ++
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  19 ++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  11 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   5 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   5 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  24 +++
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  13 ++
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  20 ++
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  21 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  20 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   6 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c    |  93 +++++++++
 .../gcc.dg/kcfi/kcfi-x86-fixed-r10.c          |  17 ++
 .../gcc.dg/kcfi/kcfi-x86-fixed-r11.c          |  17 ++
 .../gcc.dg/kcfi/kcfi-x86-retpoline-r11.c      |  40 ++++
 gcc/common.opt                                |   4 +
 gcc/opts.cc                                   |   1 +
 27 files changed, 716 insertions(+), 8 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c

diff --git a/gcc/config/i386/i386-protos.h b/gcc/config/i386/i386-protos.h
index 5ff414a22a2a..b6a584a27d01 100644
--- a/gcc/config/i386/i386-protos.h
+++ b/gcc/config/i386/i386-protos.h
@@ -378,6 +378,7 @@ extern enum attr_cpu ix86_schedule;
 
 extern bool ix86_nopic_noplt_attribute_p (rtx call_op);
 extern const char * ix86_output_call_insn (rtx_insn *insn, rtx call_op);
+extern const char * ix86_output_kcfi_insn (rtx_insn *insn, rtx *operands);
 extern const char * ix86_output_indirect_jmp (rtx call_op);
 extern const char * ix86_output_function_return (bool long_p);
 extern const char * ix86_output_indirect_function_return (rtx ret_op);
diff --git a/gcc/config/i386/i386.h b/gcc/config/i386/i386.h
index 94f335f8a95c..b81309b770bf 100644
--- a/gcc/config/i386/i386.h
+++ b/gcc/config/i386/i386.h
@@ -3054,7 +3054,8 @@ extern void debug_dispatch_window (int);
 
 #define TARGET_INDIRECT_BRANCH_REGISTER \
   (ix86_indirect_branch_register \
-   || cfun->machine->indirect_branch_type != indirect_branch_keep)
+   || cfun->machine->indirect_branch_type != indirect_branch_keep \
+   || (flag_sanitize & SANITIZE_KCFI))
 
 #define IX86_HLE_ACQUIRE (1 << 16)
 #define IX86_HLE_RELEASE (1 << 17)
diff --git a/gcc/config/i386/i386.md b/gcc/config/i386/i386.md
index 3ea2439526be..6e955afec007 100644
--- a/gcc/config/i386/i386.md
+++ b/gcc/config/i386/i386.md
@@ -20415,11 +20415,24 @@
   DONE;
 })
 
+;; KCFI indirect call
+(define_insn "*call"
+  [(kcfi (call (mem:QI (match_operand:W 0 "call_insn_operand" "<c>BwBz"))
+	       (match_operand 1))
+	 (match_operand 2 "const_int_operand"))]
+  "!SIBLING_CALL_P (insn)"
+{
+  return ix86_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")])
+
 (define_insn "*call"
   [(call (mem:QI (match_operand:W 0 "call_insn_operand" "<c>BwBz"))
 	 (match_operand 1))]
   "!SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[0]);"
+{
+  return ix86_output_call_insn (insn, operands[0]);
+}
   [(set_attr "type" "call")])
 
 ;; This covers both call and sibcall since only GOT slot is allowed.
@@ -20452,11 +20465,24 @@
 }
   [(set_attr "type" "call")])
 
+;; KCFI sibling call
+(define_insn "*sibcall"
+  [(kcfi (call (mem:QI (match_operand:W 0 "sibcall_insn_operand" "UBsBz"))
+	       (match_operand 1))
+	 (match_operand 2 "const_int_operand"))]
+  "SIBLING_CALL_P (insn)"
+{
+  return ix86_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")])
+
 (define_insn "*sibcall"
   [(call (mem:QI (match_operand:W 0 "sibcall_insn_operand" "UBsBz"))
 	 (match_operand 1))]
   "SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[0]);"
+{
+  return ix86_output_call_insn (insn, operands[0]);
+}
   [(set_attr "type" "call")])
 
 (define_insn "*sibcall_memory"
@@ -20613,12 +20639,26 @@
   DONE;
 })
 
+;; KCFI call with return value
+(define_insn "*call_value"
+  [(set (match_operand 0)
+	(kcfi (call (mem:QI (match_operand:W 1 "call_insn_operand" "<c>BwBz"))
+		    (match_operand 2))
+	      (match_operand 3 "const_int_operand")))]
+  "!SIBLING_CALL_P (insn)"
+{
+  return ix86_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "callv")])
+
 (define_insn "*call_value"
   [(set (match_operand 0)
 	(call (mem:QI (match_operand:W 1 "call_insn_operand" "<c>BwBz"))
 	      (match_operand 2)))]
   "!SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[1]);"
+{
+  return ix86_output_call_insn (insn, operands[1]);
+}
   [(set_attr "type" "callv")])
 
 ;; This covers both call and sibcall since only GOT slot is allowed.
@@ -20654,12 +20694,26 @@
 }
   [(set_attr "type" "callv")])
 
+;; KCFI sibling call with return value
+(define_insn "*sibcall_value"
+  [(set (match_operand 0)
+	(kcfi (call (mem:QI (match_operand:W 1 "sibcall_insn_operand" "UBsBz"))
+		    (match_operand 2))
+	      (match_operand 3 "const_int_operand")))]
+  "SIBLING_CALL_P (insn)"
+{
+  return ix86_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "callv")])
+
 (define_insn "*sibcall_value"
   [(set (match_operand 0)
 	(call (mem:QI (match_operand:W 1 "sibcall_insn_operand" "UBsBz"))
 	      (match_operand 2)))]
   "SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[1]);"
+{
+  return ix86_output_call_insn (insn, operands[1]);
+}
   [(set_attr "type" "callv")])
 
 (define_insn "*sibcall_value_memory"
diff --git a/gcc/config/i386/i386-expand.cc b/gcc/config/i386/i386-expand.cc
index c131f7c44c11..4f0557f40ac2 100644
--- a/gcc/config/i386/i386-expand.cc
+++ b/gcc/config/i386/i386-expand.cc
@@ -94,6 +94,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "i386-builtins.h"
 #include "i386-expand.h"
 #include "asan.h"
+#include "kcfi.h"
 
 /* Split one or more double-mode RTL references into pairs of half-mode
    references.  The RTL can be REG, offsettable MEM, integer constant, or
@@ -11071,8 +11072,9 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   unsigned int vec_len = 0;
   tree fndecl;
   bool call_no_callee_saved_registers = false;
+  bool is_direct_call = SYMBOL_REF_P (XEXP (fnaddr, 0));
 
-  if (SYMBOL_REF_P (XEXP (fnaddr, 0)))
+  if (is_direct_call)
     {
       fndecl = SYMBOL_REF_DECL (XEXP (fnaddr, 0));
       if (fndecl)
@@ -11109,7 +11111,7 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   if (TARGET_MACHO && !TARGET_64BIT)
     {
 #if TARGET_MACHO
-      if (flag_pic && SYMBOL_REF_P (XEXP (fnaddr, 0)))
+      if (flag_pic && is_direct_call)
 	fnaddr = machopic_indirect_call_target (fnaddr);
 #endif
     }
@@ -11193,7 +11195,7 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   if (ix86_cmodel == CM_LARGE_PIC
       && !TARGET_PECOFF
       && MEM_P (fnaddr)
-      && SYMBOL_REF_P (XEXP (fnaddr, 0))
+      && is_direct_call
       && !local_symbolic_operand (XEXP (fnaddr, 0), VOIDmode))
     fnaddr = gen_rtx_MEM (QImode, construct_plt_address (XEXP (fnaddr, 0)));
   /* Since x32 GOT slot is 64 bit with zero upper 32 bits, indirect
@@ -11225,6 +11227,20 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
 
   call = gen_rtx_CALL (VOIDmode, fnaddr, callarg1);
 
+  /* Only indirect calls need KCFI instrumentation.  */
+  rtx kcfi_type_rtx = is_direct_call ? NULL_RTX
+    : kcfi_get_type_id_for_expanding_gimple_call ();
+  if (kcfi_type_rtx)
+    {
+      /* Wrap call with KCFI.  */
+      call = gen_rtx_KCFI (VOIDmode, call, kcfi_type_rtx);
+
+      /* Add KCFI clobbers for the insn sequence.  */
+      clobber_reg (&use, gen_rtx_REG (DImode, R10_REG));
+      clobber_reg (&use, gen_rtx_REG (DImode, R11_REG));
+      clobber_reg (&use, gen_rtx_REG (CCmode, FLAGS_REG));
+    }
+
   if (retval)
     call = gen_rtx_SET (retval, call);
   vec[vec_len++] = call;
diff --git a/gcc/config/i386/i386-options.cc b/gcc/config/i386/i386-options.cc
index ba598a817f30..c7c917e1ed33 100644
--- a/gcc/config/i386/i386-options.cc
+++ b/gcc/config/i386/i386-options.cc
@@ -2186,6 +2186,17 @@ ix86_option_override_internal (bool main_args_p,
       ix86_lam_type = lam_u57;
     }
 
+  /* KCFI is only supported in 64-bit mode due to use of r10/r11 registers.  */
+  if ((opts->x_flag_sanitize & SANITIZE_KCFI)
+      && (!TARGET_64BIT_P (opts->x_ix86_isa_flags) || TARGET_X32_P (opts->x_ix86_isa_flags)))
+    sorry ("%<-fsanitize=kcfi%> is not supported for 32-bit x86 or x32 mode");
+
+  /* KCFI requires R10 and R11 registers for type checking.  */
+  if ((opts->x_flag_sanitize & SANITIZE_KCFI)
+      && (fixed_regs[R10_REG] || fixed_regs[R11_REG]))
+    sorry ("%<-fsanitize=kcfi%> is not compatible with %<-ffixed-r10%> or "
+	   "%<-ffixed-r11%> as KCFI requires these registers for type checking");
+
   /* For targets using ms ABI enable ms-extensions, if not
      explicit turned off.  For non-ms ABI we turn off this
      option.  */
diff --git a/gcc/config/i386/i386.cc b/gcc/config/i386/i386.cc
index 6b6febc88709..c998d6dbe49f 100644
--- a/gcc/config/i386/i386.cc
+++ b/gcc/config/i386/i386.cc
@@ -98,6 +98,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "i386-builtins.h"
 #include "i386-expand.h"
 #include "i386-features.h"
+#include "kcfi.h"
 #include "function-abi.h"
 #include "rtl-error.h"
 #include "gimple-pretty-print.h"
@@ -323,6 +324,26 @@ unsigned int const svr4_debugger_register_map[FIRST_PSEUDO_REGISTER] =
   93, 94, 95, 96, 97, 98, 99, 100
 };
 
+/* KCFI arity (how many parameters a function has) is encoded in the
+   preamble's immediate register. The encoding is as follows:
+
+   Arity represented by
+       0 by %eax (gcc regno = 0)
+       1 by %ecx (gcc regno = 2)
+       2 by %edx (gcc regno = 1)
+       3 by %ebx (gcc regno = 3)
+       4 by %esp (gcc regno = 7)
+       5 by %ebp (gcc regno = 6)
+       6 by %esi (gcc regno = 4)
+       7 by %edi (gcc regno = 5)
+*/
+#define KCFI_ARITY_MAX_INDICATOR 7
+unsigned int const kcfi_arity_register_map[KCFI_ARITY_MAX_INDICATOR + 1] =
+{
+  /* eax to edi */
+  0, 2, 1, 3, 7, 6, 4, 5
+};
+
 /* Define parameter passing and return registers.  */
 
 static int const x86_64_int_parameter_registers[6] =
@@ -28730,6 +28751,177 @@ ix86_set_handled_components (sbitmap components)
       }
 }
 
+/* Output the assembly for a KCFI checked call instruction.  INSN is the
+   RTL instruction being processed.  OPERANDS is the array of RTL operands
+   where operands[0] is the call target register, operands[2] is the KCFI
+   type ID constant.  Returns an empty string as all output is handled by
+   direct assembly generation.  */
+
+const char *
+ix86_output_kcfi_insn (rtx_insn *insn, rtx *operands)
+{
+  /* Target is guaranteed to be in a register due to
+     TARGET_INDIRECT_BRANCH_REGISTER.  */
+  rtx target_reg = operands[0];
+  gcc_assert (REG_P (target_reg));
+
+  /* In thunk-extern mode, the register must be R11 for FineIBT
+     compatibility.  Should this be handled via constraints?  */
+  if (cfun->machine->indirect_branch_type == indirect_branch_thunk_extern)
+    {
+      if (REGNO (target_reg) != R11_REG)
+	{
+	  /* Emit move from current target to R11.  */
+	  target_reg = gen_rtx_REG (DImode, R11_REG);
+	  rtx r11_operands[2] = { operands[0], target_reg };
+	  output_asm_insn ("movq\t%0, %1", r11_operands);
+	}
+    }
+
+  /* Get unique label number for this KCFI check.  */
+  int labelno = kcfi_next_labelno ();
+
+  /* Generate custom label names.  */
+  char trap_name[32];
+  char call_name[32];
+  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", labelno);
+  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", labelno);
+
+  /* Choose scratch register: r10 by default, r11 if r10 is the target.  */
+  bool target_is_r10 = (REGNO (target_reg) == R10_REG);
+  int scratch_reg = target_is_r10 ? R11_REG : R10_REG;
+
+  /* Get KCFI type ID from operand.  */
+  uint32_t type_id = (uint32_t) INTVAL (operands[2]);
+
+  /* Convert to inverse for the check (0 - hash) */
+  uint32_t inverse_type_id = (uint32_t)(0 - type_id);
+
+  /* Calculate offset to typeid from target address.  */
+  HOST_WIDE_INT offset = -kcfi_get_typeid_offset ();
+
+  /* Output complete KCFI check + call/sibcall sequence atomically.  */
+  rtx inverse_type_id_rtx = gen_int_mode (inverse_type_id, SImode);
+  rtx mov_operands[2] = { inverse_type_id_rtx,
+			  gen_rtx_REG (SImode, scratch_reg) };
+  output_asm_insn ("movl\t$%c0, %1", mov_operands);
+
+  /* Create memory operand for the addl instruction.  */
+  rtx offset_rtx = gen_int_mode (offset, DImode);
+  rtx mem_op = gen_rtx_MEM (SImode,
+			    gen_rtx_PLUS (DImode, target_reg, offset_rtx));
+  rtx add_operands[2] = { mem_op, gen_rtx_REG (SImode, scratch_reg) };
+  output_asm_insn ("addl\t%0, %1", add_operands);
+
+  /* Output conditional jump to call label.  */
+  fputs ("\tje\t", asm_out_file);
+  assemble_name (asm_out_file, call_name);
+  fputc ('\n', asm_out_file);
+
+  /* Output trap label and instruction.  */
+  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
+  output_asm_insn ("ud2", operands);
+
+  /* Use common helper for trap section entry.  */
+  rtx trap_label_sym = gen_rtx_SYMBOL_REF (Pmode, trap_name);
+  kcfi_emit_traps_section (asm_out_file, trap_label_sym, labelno);
+
+  /* Output pass/call label.  */
+  ASM_OUTPUT_LABEL (asm_out_file, call_name);
+
+  /* Finally emit the protected call or sibling call.  */
+  if (SIBLING_CALL_P (insn))
+    return ix86_output_indirect_jmp (target_reg);
+  else
+    return ix86_output_call_insn (insn, target_reg);
+}
+
+/* Apply x86-64 specific masking to KCFI type ID.  TYPE_ID is the 32-bit
+   KCFI type identifier to potentially mask.  Returns the type ID with
+   x86-64 specific adjustments to avoid embedding ENDBR instruction
+   sequences in the type identifier values.  */
+
+static uint32_t
+ix86_kcfi_mask_type_id (uint32_t type_id)
+{
+  /* Avoid embedding ENDBR instructions in KCFI type IDs.
+     ENDBR64: 0xfa1e0ff3, ENDBR32: 0xfb1e0ff3
+     If the type ID matches either instruction encoding, increment by 1.  */
+  if (type_id == 0xfa1e0ff3U || type_id == 0xfb1e0ff3U)
+    return type_id + 1;
+
+  return type_id;
+}
+
+/* Return x86-64 specific function arity (number of integer register
+   arguments) of the given FNDECL.  */
+
+static uint8_t
+ix86_kcfi_compute_type_arity (tree fndecl)
+{
+  tree args;
+  uint8_t arity = 0;
+
+  /* Only count arity if requested.  */
+  if (!flag_sanitize_kcfi_arity)
+    return 0;
+
+  /* If fndecl is NULL, we can't determine arity - return 0.  */
+  if (!fndecl)
+    return 0;
+
+  /* Count the number of registers used, disregard SSE registers.  */
+  for (args = DECL_ARGUMENTS (fndecl); args; args = TREE_CHAIN (args))
+  {
+    int int_nregs, sse_nregs;
+    bool args_on_stack = false;
+    machine_mode mode = TYPE_MODE (TREE_TYPE (args));
+
+    args_on_stack = examine_argument (mode, TREE_TYPE (args), 0, &int_nregs,
+				      &sse_nregs);
+    /* If we place arguments on the stack, return highest arity indicator.  */
+    if (args_on_stack)
+       return KCFI_ARITY_MAX_INDICATOR;
+    arity += int_nregs;
+  }
+
+  /* Return KCFI_ARITY_MAX_INDICATOR if we have counted more than
+     KCFI_ARITY_MAX_INDICATOR arguments.  */
+  return arity > KCFI_ARITY_MAX_INDICATOR ? KCFI_ARITY_MAX_INDICATOR : arity;
+}
+
+/* Emit x86_64-specific type ID instruction and return instruction size.
+   FILE is the output assembly file stream, or NULL for size calculation only.
+   TYPE_ID is the 32-bit KCFI type identifier to emit.  FNDECL is the function
+   declaration, used to compute arity if needed.  Returns the number
+   of bytes the instruction occupies (5 bytes for x86_64 movl instruction).  */
+
+static int
+ix86_kcfi_emit_type_id (FILE *file, uint32_t type_id, tree fndecl)
+{
+  /* Compute function arity.  */
+  uint8_t arity = ix86_kcfi_compute_type_arity (fndecl);
+
+  /* Choose register for movl instruction.  */
+  gcc_assert (arity <= KCFI_ARITY_MAX_INDICATOR);
+  uint32_t regno = kcfi_arity_register_map[arity];
+
+  if (file)
+    fprintf (file, "\tmovl\t$0x%08x, %%e%s\n", type_id, reg_names[regno]);
+
+  /* x86_64 uses 5-byte movl instruction for type ID.  */
+  return 5;
+}
+
+#undef TARGET_KCFI_SUPPORTED
+#define TARGET_KCFI_SUPPORTED hook_bool_void_true
+
+#undef TARGET_KCFI_MASK_TYPE_ID
+#define TARGET_KCFI_MASK_TYPE_ID ix86_kcfi_mask_type_id
+
+#undef TARGET_KCFI_EMIT_TYPE_ID
+#define TARGET_KCFI_EMIT_TYPE_ID ix86_kcfi_emit_type_id
+
 #undef TARGET_SHRINK_WRAP_GET_SEPARATE_COMPONENTS
 #define TARGET_SHRINK_WRAP_GET_SEPARATE_COMPONENTS ix86_get_separate_components
 #undef TARGET_SHRINK_WRAP_COMPONENTS_FOR_BB
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index faeeb29663dd..a10f2006f1ff 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18477,6 +18477,52 @@ The type identifier is placed before the function entry point,
 allowing runtime verification without additional metadata structures,
 and without changing the entry points of the target functions.
 
+Platform-specific implementation details:
+
+On x86_64, KCFI type identifiers are emitted as a @code{movl $ID, %eax}
+instruction before the function entry.  The implementation ensures that
+type IDs never collide with ENDBR instruction encodings.  When used
+with @option{-fpatchable-function-entry}, the type identifier is
+placed before any patchable NOPs, with appropriate alignment to maintain
+the alignment specified by @code{-falign-functions}.  KCFI automatically
+implies @option{-mindirect-branch-register}, forcing all indirect calls
+and jumps to use registers instead of memory operands.  The runtime
+check loads the type ID from the target function into @code{%r10d} and
+uses an @code{addl} instruction to add the negative expected type ID,
+effectively zeroing the register if the types match.  A conditional
+jump follows to either continue execution or trap on mismatch.  The
+check sequence uses @code{%r10d} and @code{%r11d} as scratch registers.
+Trap locations are recorded in a special @code{.kcfi_traps} section
+that maps trap sites to their corresponding function entry points,
+enabling debuggers and crash handlers to identify KCFI violations.
+The exact instruction sequences for both the KCFI preamble and the
+check-call bundle are considered ABI, as the Linux kernel may
+optionally rewrite these areas at boot time to mitigate detected CPU
+errata.
+
+The @code{-fsanitize-kcfi-arity} option encodes the function arity
+(i.e., the number of arguments) into the @code{movl $ID, $REG} instruction,
+where the @code{$REG} encodes the function arity. This allows users, such as
+FineIBT to generate code in the kernel that is aware of how many register
+arguments a function takes. The encoding is as follows:
+
+@multitable @columnfractions 0.10 0.50 0.40
+@headitem Arity @tab Description @tab Register
+@item 0 @tab 0 parameters @tab @code{EAX}
+@item 1 @tab 1 parameter in RDI @tab @code{ECX}
+@item 2 @tab 2 parameters in RDI and RSI @tab @code{EDX}
+@item 3 @tab 3 parameters in RDI, RSI, and RDX @tab @code{EBX}
+@item 4 @tab 4 parameters in RDI, RSI, RDX, and RCX @tab @code{ESP}
+@item 5 @tab 5 parameters in RDI, RSI, RDX, RCX, and R8 @tab @code{EBP}
+@item 6 @tab 6 parameters in RDI, RSI, RDX, RCX, R8, and R9 @tab @code{ESI}
+@item 7 @tab At least one parameter may be passed on the stack @tab @code{EDI}
+@end multitable
+
+For example, if a function `foo` takes 3 register arguments, the KCFI
+header MOVri instruction would become something like this:
+
+@code{movl    $199571451, %ebx                # hash of foo's type = 0xBE537FB}
+
 KCFI is intended primarily for kernel code and may not be suitable
 for user-space applications that rely on techniques incompatible
 with strict type checking of indirect calls.
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
index 7c1cff986c01..7c59921e630c 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
@@ -46,4 +46,21 @@ __attribute__((noinline)) void test_conditional_call(int flag) {
     }
 }
 
+/*
+** test_complex_args: { target x86_64-*-* }
+** ...
+** movl	\$-?[0-9]+, %r10d
+** addl	-4\((%r[a-z0-9]+)\), %r10d
+** je	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ud2
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .long	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** jmp	\*\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
index ca833fed2971..fe0a21d26df9 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
@@ -1,5 +1,6 @@
 /* Test basic KCFI functionality - preamble generation.  */
 /* { dg-do compile } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 /* Extern function declarations - should NOT get KCFI preambles.  */
 extern void external_func(void);
@@ -55,6 +56,26 @@ int main() {
 /* Function with nocf_check attribute should NOT have preamble.  */
 /* { dg-final { scan-assembler-not {__cfi_nocf_check_function:} } } */
 
+/* x86_64: Verify type ID in preamble (after NOPs, before function label) */
+/* { dg-final { scan-assembler {__cfi_regular_function:\n\t+nop\n.*\n\t+movl\t+\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
+
+/*
+** static_caller: { target x86_64-*-* }
+** ...
+** movl	\$-?[0-9]+, %r10d
+** addl	-4\((%r[a-z0-9]+)\), %r10d
+** je	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ud2
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .long	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** call	\*\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
 
 /* Extern functions should NOT get KCFI preambles.  */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
index 427b092fecb5..16154213eb82 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
@@ -59,3 +59,18 @@ int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *
    Should see:
    1. KCFI check for is_visible call with is_visible type ID A.
    2. KCFI check for is_bin_visible and is_bin_visible_again call with type ID B.  */
+
+/* Verify we have TWO different KCFI check sequences.  */
+/* Each check should have different type ID constants.  */
+/* x86: { dg-final { scan-assembler-times {movl\s+\$-?[0-9]+,\s+%r10d} 2 { target i?86-*-* x86_64-*-* } } } */
+
+/* Verify the checks use DIFFERENT type IDs (not shared).
+   We should NOT see the same type ID used twice - that would indicate
+   unmerged sharing.  */
+/* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*movl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
+
+/* Verify expected number of traps.  */
+/* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_64-*-* } } } */
+
+/* Verify 2 separate call sites.  */
+/* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { target i?86-*-* x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
index c48b8d7ad552..ed415033c5c9 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
@@ -128,4 +128,22 @@ int main() {
     return result;
 }
 
+/* Standard KCFI handling.  */
+/*
+** test_struct_members: { target x86_64-*-* }
+** ...
+** movl	\$-?[0-9]+, %r10d
+** addl	-4\((%r[a-z0-9]+)\), %r10d
+** je	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ud2
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .long	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** call	\*\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
index 7d58fef3f920..5553ff47174b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
@@ -38,4 +38,23 @@ int main(void)
     return 0;
 }
 
+/*
+** indirect_call: { target x86_64-*-* }
+** ...
+** movq	%rdi, (%rax)
+** movl	\$called_count, %edi
+** movl	\$-?[0-9]+, %r10d
+** addl	-4\(\1\), %r10d
+** je	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ud2
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .long	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** jmp	\*\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
index 4a90390d1934..9ed7e21fe8eb 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
@@ -72,3 +72,14 @@ int main(void)
 
     return 0;
 }
+
+/* Verify correct number of KCFI checks: exactly 2 */
+/* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } */
+
+/* Positive controls: these should have KCFI checks.  */
+/* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_function} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {wrap_normal_inline:.*ud2.*\.size\s+wrap_normal_inline} { target x86_64-*-* } } } */
+
+/* Negative controls: these should NOT have KCFI checks.  */
+/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ud2.*\.size\s+wrap_sensitive_inline} { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
index 124d26488635..95a8e8419e00 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
@@ -29,3 +29,8 @@ int main() {
 /* { dg-final { scan-assembler "__cfi_caller_with_checks:" } } */
 /* { dg-final { scan-assembler "__cfi_caller_no_checks:" } } */
 /* { dg-final { scan-assembler "__cfi_main:" } } */
+
+/* caller_with_checks() should generate KCFI check.
+   caller_no_checks() should NOT generate KCFI check (no_sanitize).
+   So a total of exactly 1 KCFI check in the entire program.  */
+/* { dg-final { scan-assembler-times {addl\t-4\(%r[ad]x\), %r1[01]d} 1 { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
index 213a1a2892a5..97d964feebd3 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
@@ -1,5 +1,6 @@
 /* Test KCFI call-site offset validation across architectures.  */
 /* { dg-do compile } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 void target_func_a(void) { }
 void target_func_b(int x) { }
@@ -22,3 +23,7 @@ int main() {
 /* { dg-final { scan-assembler "__cfi_target_func_a:" } } */
 /* { dg-final { scan-assembler "__cfi_target_func_b:" } } */
 /* { dg-final { scan-assembler "__cfi_target_func_c:" } } */
+
+/* x86_64: All call sites should use -4 offset for KCFI type ID loads, even
+   with -falign-functions=16 (we're not using patchable entries here).  */
+/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
index a6a2f4816fef..379356385a16 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
@@ -1,6 +1,7 @@
 /* Test KCFI with patchable function entries - entry NOPs only.  */
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=4,0" } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 void test_function(void) {
 }
@@ -11,4 +12,27 @@ int main() {
     return 0;
 }
 
+/*
+** __cfi_test_function: { target x86_64-*-* }
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** movl	\$0x[0-9a-f]+, %eax
+*/
+
+/*
+** main: { target x86_64-*-* }
+** ...
+** addl	-4\(%r[a-z0-9]+\), %r10d
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
index 8c4ec30cecc5..06df3495bb23 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
@@ -1,6 +1,7 @@
 /* Test KCFI with large patchable function entries.  */
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=11,11" } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 void test_function(void) {
 }
@@ -11,4 +12,16 @@ int main() {
     return 0;
 }
 
+/*
+** __cfi_test_function: { target x86_64-*-* }
+** movl	\$0x[0-9a-f]+, %eax
+*/
+
+/*
+** main: { target x86_64-*-* }
+** ...
+** addl	-15\(%r[a-z0-9]+\), %r10d
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
index 78a834ef2a97..ef87b135934b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
@@ -1,6 +1,7 @@
 /* Test KCFI with medium patchable function entries.  */
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=8,4" } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 void test_function(void) {
 }
@@ -11,4 +12,23 @@ int main() {
     return 0;
 }
 
+/*
+** __cfi_test_function: { target x86_64-*-* }
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** movl	\$0x[0-9a-f]+, %eax
+*/
+
+/*
+** main: { target x86_64-*-* }
+** ...
+** addl	-8\(%r[a-z0-9]+\), %r10d
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
index 1a4d8269ed56..872814aa4171 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
@@ -1,6 +1,7 @@
 /* Test KCFI with patchable function entries - prefix NOPs only.  */
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=3,3" } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 void test_function(void) {
 }
@@ -11,4 +12,24 @@ int main() {
     return 0;
 }
 
+/*
+** __cfi_test_function: { target x86_64-*-* }
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** movl	\$0x[0-9a-f]+, %eax
+*/
+
+/*
+** main: { target x86_64-*-* }
+** ...
+** addl	-7\(%r[a-z0-9]+\), %r10d
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
index 9ddf178aa2b1..04a9eb1fd206 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
@@ -58,3 +58,23 @@ int test_non_tail_indirect_call(func_ptr_t handler, int x) {
 /* { dg-final { scan-assembler-times "__cfi_test_param_indirect_call:" 1 } } */
 /* { dg-final { scan-assembler-times "__cfi_test_void_indirect_call:" 1 } } */
 /* { dg-final { scan-assembler-times "__cfi_test_non_tail_indirect_call:" 1 } } */
+
+/* Should have exactly 4 KCFI checks for indirect calls as
+   (load type ID + compare).  */
+/* { dg-final { scan-assembler-times {movl\t\$-?[0-9]+, %r10d} 4 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {addl\t-4\(%r[a-z0-9]+\), %r10d} 4 { target x86_64-*-* } } } */
+
+/* Should have exactly 4 trap sections and 4 trap instructions.  */
+/* { dg-final { scan-assembler-times "\\.kcfi_traps" 4 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times "ud2" 4 { target x86_64-*-* } } } */
+
+/* Should NOT have unprotected direct jumps to vtable.  */
+/* { dg-final { scan-assembler-not {jmp\t\*vtable\(%rip\)} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-not {jmp\t\*vtable\+8\(%rip\)} { target x86_64-*-* } } } */
+
+/* Should have exactly 3 protected tail calls (jmp through register after
+   KCFI check).  */
+/* { dg-final { scan-assembler-times {jmp\t\*%[a-z0-9]+} 3 { target x86_64-*-* } } } */
+
+/* Should have exactly 1 regular call (non-tail call case).  */
+/* { dg-final { scan-assembler-times {call\t\*%[a-z0-9]+} 1 { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
index 6d34ad6e1a0c..55c0829ccd7b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
@@ -15,3 +15,9 @@ int main() {
 
 /* Should have KCFI preamble.  */
 /* { dg-final { scan-assembler "__cfi_target_function:" } } */
+
+/* Should have exactly 2 trap labels in code.  */
+/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ud2} 2 { target x86_64-*-* } } } */
+
+/* x86_64 should exactly 2 .kcfi_traps sections.  */
+/* { dg-final { scan-assembler-times {\.section\t\.kcfi_traps,"ao",@progbits,\.text} 2 { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
new file mode 100644
index 000000000000..5c1d1ffcc619
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
@@ -0,0 +1,93 @@
+/* Test KCFI -fsanitize-kcfi-arity - preamble generation */
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-O2 -fsanitize-kcfi-arity" } */
+
+void regular_function(int x) {
+    /* This should get KCFI preamble */
+}
+
+/* These functions should get a KCFI arity corresponing to the number of
+   parameter.
+
+   On x86-64, the mov instruction in the preamble encodes the arity in the
+   used immediate register, as follows:
+
+	Arity	Description			Encoding in reg field
+	0	0 parameters			EAX
+	1	1 parameter in RDI		ECX
+	2	2 parameters in RDI 		EDX
+		  and RSI
+	3	3 parameters in RDI, 		EBX
+		  RSI, and RDX
+	4	4 parameters in RDI,		ESP
+		  RSI, RDX, and RCX
+	5	5 parameters in RDI,		EBP
+		  RSI, RDX, RCX, and R8
+	6	6 parameters in RDI, 		ESI
+		  RSI, RDX, RCX, R8, and R9
+	7	At least one parameter		EDI
+		  may be passed on the stack	
+*/
+void ind_fn_00(void) {}
+void ind_fn_01(int) {}
+void ind_fn_02(int, int) {}
+void ind_fn_03(int, int, int) {}
+void ind_fn_04(int, int, int, int) {}
+void ind_fn_05(int, int, int, int, int) {}
+void ind_fn_06(int, int, int, int, int, int) {}
+/* Arguments on stack arity from here on should be 7.  */
+void ind_fn_07(int, int, int, int, int, int, int) {}
+void ind_fn_08(int, int, int, int, int, int, int, int) {}
+
+void ind_fn_float_01(int, float) {}
+void ind_fn_float_03(int, int, float, float, float) {}
+
+void (*func_ptr_00)(void) = ind_fn_00;
+void (*func_ptr_01)(int) = ind_fn_01;
+void (*func_ptr_02)(int, int) = ind_fn_02;
+void (*func_ptr_03)(int, int, int) = ind_fn_03;
+void (*func_ptr_04)(int, int, int, int) = ind_fn_04;
+void (*func_ptr_05)(int, int, int, int, int) = ind_fn_05;
+void (*func_ptr_06)(int, int, int, int, int, int) = ind_fn_06;
+void (*func_ptr_07)(int, int, int, int, int, int, int) = ind_fn_07;
+void (*func_ptr_08)(int, int, int, int, int, int, int, int) = ind_fn_08;
+
+
+void (*func_ptr_float_01)(int, float) = ind_fn_float_01;
+void (*func_ptr_float_03)(int, int, float, float, float) = ind_fn_float_03;
+
+int main() {
+    /* Function arity tests.  */
+    func_ptr_00();
+    func_ptr_01(1);
+    func_ptr_02(1, 1);
+    func_ptr_03(1, 1, 1);
+    func_ptr_04(1, 1, 1, 1);
+    func_ptr_05(1, 1, 1, 1, 1);
+    func_ptr_06(1, 1, 1, 1, 1, 1);
+
+    /* Both of these put arguments on the stack so both get arity 7.  */
+    func_ptr_07(1, 1, 1, 1, 1, 1, 1);
+    func_ptr_08(1, 1, 1, 1, 1, 1, 1, 1);
+
+    /* Float parameters should not be counted for arity.  */
+    func_ptr_float_01(1, 1.0);
+    func_ptr_float_03(1, 1, 0.5, 0.5, 0.5);
+
+    return 0;
+}
+
+/* x86_64: Verify arity immediate register encoding in preamble.  */
+/* { dg-final { scan-assembler {__cfi_ind_fn_00:.*\n\tmovl\t+\$0x[0-9a-f]+, %eax\n.*\nind_fn_00:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_01:.*\n\tmovl\t+\$0x[0-9a-f]+, %ecx\n.*\nind_fn_01:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_02:.*\n\tmovl\t+\$0x[0-9a-f]+, %edx\n.*\nind_fn_02:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_03:.*\n\tmovl\t+\$0x[0-9a-f]+, %ebx\n.*\nind_fn_03:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_04:.*\n\tmovl\t+\$0x[0-9a-f]+, %esp\n.*\nind_fn_04:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_05:.*\n\tmovl\t+\$0x[0-9a-f]+, %ebp\n.*\nind_fn_05:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_06:.*\n\tmovl\t+\$0x[0-9a-f]+, %esi\n.*\nind_fn_06:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_07:.*\n\tmovl\t+\$0x[0-9a-f]+, %edi\n.*\nind_fn_07:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_08:.*\n\tmovl\t+\$0x[0-9a-f]+, %edi\n.*\nind_fn_08:} { target x86_64-*-* } } } */
+
+/* x86_64: Verify arity is not affected by SSE registers.  */
+/* { dg-final { scan-assembler {__cfi_ind_fn_float_01:.*\n\tmovl\t+\$0x[0-9a-f]+, %ecx\n.*\nind_fn_float_01:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_float_03:.*\n\tmovl\t+\$0x[0-9a-f]+, %edx\n.*\nind_fn_float_03:} { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
new file mode 100644
index 000000000000..f509bc918a82
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
@@ -0,0 +1,17 @@
+/* Test that KCFI is incompatible with -ffixed-r10 on x86_64.  */
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-ffixed-r10" } */
+
+/* { dg-message "sorry, unimplemented: '-fsanitize=kcfi' is not compatible with '-ffixed-r10' or '-ffixed-r11' as KCFI requires these registers for type checking" "" { target *-*-* } 0 } */
+
+void test_function(void)
+{
+    /* Empty function.  */
+}
+
+int main(void)
+{
+    void (*ptr)(void) = test_function;
+    ptr();  /* This would need KCFI instrumentation.  */
+    return 0;
+}
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
new file mode 100644
index 000000000000..6b1ce8a1b6c5
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
@@ -0,0 +1,17 @@
+/* Test that KCFI is incompatible with -ffixed-r11 on x86_64.  */
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-ffixed-r11" } */
+
+/* { dg-message "sorry, unimplemented: '-fsanitize=kcfi' is not compatible with '-ffixed-r10' or '-ffixed-r11' as KCFI requires these registers for type checking" "" { target *-*-* } 0 } */
+
+void test_function(void)
+{
+    /* Empty function.  */
+}
+
+int main(void)
+{
+    void (*ptr)(void) = test_function;
+    ptr();  /* This would need KCFI instrumentation.  */
+    return 0;
+}
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
new file mode 100644
index 000000000000..056068b4f197
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
@@ -0,0 +1,40 @@
+/* Test KCFI with retpoline thunk-extern flag forces r11 usage.  */
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-O2 -mindirect-branch=thunk-extern" } */
+
+extern int external_target(void);
+
+/* Test regular call (not tail call) */
+__attribute__((noinline))
+int call_test(int (*func_ptr)(void)) {
+    /* This indirect call should use r11 when both KCFI and
+       -mindirect-branch=thunk-extern are enabled.  */
+    int result = func_ptr();  /* Function parameter prevents direct optimization.  */
+    return result + 1;  /* Prevent tail call optimization.  */
+}
+
+/* Reference external_target to generate the required symbol.  */
+int (*external_func_ptr)(void) = external_target;
+
+/* Test function for sibcalls (tail calls) */
+__attribute__((noinline))
+void sibcall_test(int (**func_ptr)(void)) {
+    /* This sibcall should use r11 when both KCFI and
+       -mindirect-branch=thunk-extern are enabled.  */
+    (*func_ptr)();  /* Tail call - should be optimized to sibcall.  */
+}
+
+/* Should have weak symbol for external function.  */
+/* { dg-final { scan-assembler "__kcfi_typeid_external_target" } } */
+
+/* When both KCFI and -mindirect-branch=thunk-extern are enabled,
+   indirect calls should always use r11 register and convert to extern thunks.  */
+/* { dg-final { scan-assembler-times {call\s+} 1 } } */
+/* { dg-final { scan-assembler-times {call\s+__x86_indirect_thunk_r11} 1 } } */
+
+/* Sibcalls should also use r11 register and convert to extern thunks.  */
+/* { dg-final { scan-assembler-times {jmp\s+} 1 } } */
+/* { dg-final { scan-assembler-times {jmp\s+__x86_indirect_thunk_r11} 1 } } */
+
+/* Should have exactly 2 KCFI traps (one per function) */
+/* { dg-final { scan-assembler-times {ud2} 2 } } */
diff --git a/gcc/common.opt b/gcc/common.opt
index 92b0d4d931bd..70f52186be3d 100644
--- a/gcc/common.opt
+++ b/gcc/common.opt
@@ -1147,6 +1147,10 @@ Enum(sanitize_coverage) String(trace-pc) Value(SANITIZE_COV_TRACE_PC)
 EnumValue
 Enum(sanitize_coverage) String(trace-cmp) Value(SANITIZE_COV_TRACE_CMP)
 
+fsanitize-kcfi-arity
+Common Driver Var(flag_sanitize_kcfi_arity)
+For supported targets, this feature extends kCFI by telling the compiler to record information about each indirect-callable function’s arity (i.e., the number of arguments passed in registers) into the binary. Some kernel CFI techniques, such as FineIBT, may be able to use this information to provide enhanced security.
+
 fasan-shadow-offset=
 Common Joined RejectNegative Var(common_deferred_options) Defer
 -fasan-shadow-offset=<number>	Use custom shadow memory offset.
diff --git a/gcc/opts.cc b/gcc/opts.cc
index 430c7fa6d1ed..5cb7ac995712 100644
--- a/gcc/opts.cc
+++ b/gcc/opts.cc
@@ -2806,6 +2806,7 @@ common_handle_option (struct gcc_options *opts,
 	  SET_OPTION_IF_UNSET (opts, opts_set, param_asan_stack, 0);
 	  SET_OPTION_IF_UNSET (opts, opts_set, param_asan_protect_allocas, 0);
 	  SET_OPTION_IF_UNSET (opts, opts_set, param_asan_use_after_return, 0);
+	  SET_OPTION_IF_UNSET (opts, opts_set, flag_sanitize_kcfi_arity, 0);
 	}
       if (opts->x_flag_sanitize & SANITIZE_KERNEL_HWADDRESS)
 	{
-- 
2.34.1

