Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5B1E9B31
	for <linux-hardening@vger.kernel.org>; Fri, 26 Sep 2025 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855773; cv=none; b=HVKg28T4FCT0xR3HieBhYM1eieXDdd3wqYsjt3nVPHCjLFnASn+lRVoCgxiKN0ASm6auMziCeF8L7mPNoWm9zlDSUpK4v9gThRUNsN4aRc+v8N+CU7TuuR1QWjcqWpnswIcBp9W3DYf6e8UJp6Irxma7MDc9Ebvp1Vg4V5M3qGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855773; c=relaxed/simple;
	bh=Hh3Xctujf80gDTqx8G6q6OpP9m07WLCWOLPK2436BWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fn1hHPasUuySM38Qr3kyTvjYRLqohizfQYT0i097XtFV2muTmgggH6/L43Xmum1Ah9RkHykIpwm4soJNHDMd3/jImB5/OT4hyNkoIUfEUpLqG8lBpCLKfrxYNE0nYQestGUCerPbkW5DDnLkNvLzuoDwfX9HdimgA/ZrF028Z5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX6WMfDD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX6WMfDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A797AC19423;
	Fri, 26 Sep 2025 03:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855772;
	bh=Hh3Xctujf80gDTqx8G6q6OpP9m07WLCWOLPK2436BWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rX6WMfDDhFEbysTUHpViK8PI4iL8uG5D/rCL1v9a4120F/YLVqo26xqpAQThTtWkC
	 l5KTb82pu+i3EEyjm+cD6C4aFIe+Udwc+NMTrb3Yg3pwl8hntLHXxUsoqmNzlg+b39
	 sVcmMsCbrWZU5BZRqbTVNoa0CKNvyWmYJG/nkBXW4Mm/wIJHvgVfpZ0IYvMZbaaKzM
	 oeHUiAkuK1jQWyoKqIGZFnZNqgUlP2Eo0D/yK6Xf7c8WJs3n6Eb4RdHeDALQz0By35
	 sEWyf9eMkycx91ZOqUQHlJ7MhmKTGpFMDrpL6lC04D7ESmfCleeXYp6Q8L6VC4M8pf
	 Wf8cB07Fpjw2A==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
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
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 4/7] x86: Add x86_64 Kernel Control Flow Integrity implementation
Date: Thu, 25 Sep 2025 20:02:46 -0700
Message-Id: <20250926030252.2387681-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926023737.it.616-kees@kernel.org>
References: <20250926023737.it.616-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=38292; i=kees@kernel.org; h=from:subject; bh=Hh3Xctujf80gDTqx8G6q6OpP9m07WLCWOLPK2436BWE=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnXmMJP7LbP3e8l9kP0bVtK/eHylZLaOzx99+92PpxVa Hwn8e3PjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIm4vmf4K3env/nKtriLTvUe 8ydJOsxzPHV5ivBKg8IJrG7ZH8/vj2b4K1SxbMb+CYENz+fueBryZspUm7uHSpbv+LRT8b3IYVs dWS4A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
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
	* gcc.dg/kcfi/kcfi-tail-calls.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-trap-section.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-x86-fixed-r10.c: New test.
	* gcc.dg/kcfi/kcfi-x86-fixed-r11.c: New test.
	* gcc.dg/kcfi/kcfi-x86-retpoline-r11.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/i386/i386-protos.h                 |   1 +
 gcc/config/i386/i386.h                        |   3 +-
 gcc/config/i386/i386.md                       |  62 ++++++++-
 gcc/config/i386/i386-expand.cc                |  22 ++-
 gcc/config/i386/i386-options.cc               |  11 ++
 gcc/config/i386/i386.cc                       | 128 ++++++++++++++++++
 gcc/doc/invoke.texi                           |  23 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  17 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  21 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  15 ++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  18 +++
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  19 +++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  11 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   5 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   5 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  24 ++++
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  13 ++
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  20 +++
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  21 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  20 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   6 +
 .../gcc.dg/kcfi/kcfi-x86-fixed-r10.c          |  17 +++
 .../gcc.dg/kcfi/kcfi-x86-fixed-r11.c          |  17 +++
 .../gcc.dg/kcfi/kcfi-x86-retpoline-r11.c      |  40 ++++++
 24 files changed, 531 insertions(+), 8 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c

diff --git a/gcc/config/i386/i386-protos.h b/gcc/config/i386/i386-protos.h
index bdb8bb963b5d..b0b3864fb53c 100644
--- a/gcc/config/i386/i386-protos.h
+++ b/gcc/config/i386/i386-protos.h
@@ -377,6 +377,7 @@ extern enum attr_cpu ix86_schedule;
 
 extern bool ix86_nopic_noplt_attribute_p (rtx call_op);
 extern const char * ix86_output_call_insn (rtx_insn *insn, rtx call_op);
+extern const char * ix86_output_kcfi_insn (rtx_insn *insn, rtx *operands);
 extern const char * ix86_output_indirect_jmp (rtx call_op);
 extern const char * ix86_output_function_return (bool long_p);
 extern const char * ix86_output_indirect_function_return (rtx ret_op);
diff --git a/gcc/config/i386/i386.h b/gcc/config/i386/i386.h
index ac0ce687f36e..07f394d305a5 100644
--- a/gcc/config/i386/i386.h
+++ b/gcc/config/i386/i386.h
@@ -3057,7 +3057,8 @@ extern void debug_dispatch_window (int);
 
 #define TARGET_INDIRECT_BRANCH_REGISTER \
   (ix86_indirect_branch_register \
-   || cfun->machine->indirect_branch_type != indirect_branch_keep)
+   || cfun->machine->indirect_branch_type != indirect_branch_keep \
+   || (flag_sanitize & SANITIZE_KCFI))
 
 #define IX86_HLE_ACQUIRE (1 << 16)
 #define IX86_HLE_RELEASE (1 << 17)
diff --git a/gcc/config/i386/i386.md b/gcc/config/i386/i386.md
index cea6c152f2b9..b36979e67981 100644
--- a/gcc/config/i386/i386.md
+++ b/gcc/config/i386/i386.md
@@ -20274,11 +20274,24 @@
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
@@ -20311,11 +20324,24 @@
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
@@ -20472,12 +20498,26 @@
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
@@ -20513,12 +20553,26 @@
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
index b0b9e6da9469..9b338b1f77e1 100644
--- a/gcc/config/i386/i386-expand.cc
+++ b/gcc/config/i386/i386-expand.cc
@@ -94,6 +94,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "i386-builtins.h"
 #include "i386-expand.h"
 #include "asan.h"
+#include "kcfi.h"
 
 /* Split one or more double-mode RTL references into pairs of half-mode
    references.  The RTL can be REG, offsettable MEM, integer constant, or
@@ -10294,8 +10295,9 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   unsigned int vec_len = 0;
   tree fndecl;
   bool call_no_callee_saved_registers = false;
+  bool is_direct_call = SYMBOL_REF_P (XEXP (fnaddr, 0));
 
-  if (SYMBOL_REF_P (XEXP (fnaddr, 0)))
+  if (is_direct_call)
     {
       fndecl = SYMBOL_REF_DECL (XEXP (fnaddr, 0));
       if (fndecl)
@@ -10332,7 +10334,7 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   if (TARGET_MACHO && !TARGET_64BIT)
     {
 #if TARGET_MACHO
-      if (flag_pic && SYMBOL_REF_P (XEXP (fnaddr, 0)))
+      if (flag_pic && is_direct_call)
 	fnaddr = machopic_indirect_call_target (fnaddr);
 #endif
     }
@@ -10416,7 +10418,7 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   if (ix86_cmodel == CM_LARGE_PIC
       && !TARGET_PECOFF
       && MEM_P (fnaddr)
-      && SYMBOL_REF_P (XEXP (fnaddr, 0))
+      && is_direct_call
       && !local_symbolic_operand (XEXP (fnaddr, 0), VOIDmode))
     fnaddr = gen_rtx_MEM (QImode, construct_plt_address (XEXP (fnaddr, 0)));
   /* Since x32 GOT slot is 64 bit with zero upper 32 bits, indirect
@@ -10448,6 +10450,20 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
 
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
index abb5dd7700e7..05a489cd731a 100644
--- a/gcc/config/i386/i386-options.cc
+++ b/gcc/config/i386/i386-options.cc
@@ -2196,6 +2196,17 @@ ix86_option_override_internal (bool main_args_p,
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
index a091e9438287..ec3328c503bf 100644
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
@@ -28714,6 +28715,133 @@ ix86_set_handled_components (sbitmap components)
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
+  /* Generate custom label names.  */
+  char trap_name[32];
+  char call_name[32];
+  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", kcfi_labelno);
+  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", kcfi_labelno);
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
+  HOST_WIDE_INT offset = -kcfi_typeid_offset;
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
+  kcfi_emit_traps_section (asm_out_file, trap_label_sym);
+
+  /* Output pass/call label.  */
+  ASM_OUTPUT_LABEL (asm_out_file, call_name);
+
+  /* Increment label counter for next KCFI instruction.  */
+  kcfi_labelno ++;
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
+/* Emit x86_64-specific type ID instruction and return instruction size.
+   FILE is the output assembly file stream, or NULL for size calculation only.
+   TYPE_ID is the 32-bit KCFI type identifier to emit.  Returns the number
+   of bytes the instruction occupies (5 bytes for x86_64 movl instruction).  */
+
+static int
+ix86_kcfi_emit_type_id (FILE *file, uint32_t type_id)
+{
+  /* Emit movl instruction with type ID if file is not NULL.  */
+  if (file)
+    fprintf (file, "\tmovl\t$0x%08x, %%eax\n", type_id);
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
index 85790667b12e..f119a634ad86 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18418,6 +18418,29 @@ The type identifier is placed before the function entry point,
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
new file mode 100644
index 000000000000..73a2a2d62cc9
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
@@ -0,0 +1,17 @@
+/* Test that KCFI is incompatible with -ffixed-r10 on x86_64.  */
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-ffixed-r10" } */
+
+/* { dg-message "sorry, unimplemented: '-fsanitize=kcfi' is not compatible with '-ffixed-r10' or '-ffixed-r11' as KCFI requires these registers for type checking" "" 0 } */
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
index 000000000000..ba785b1dbc5e
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
@@ -0,0 +1,17 @@
+/* Test that KCFI is incompatible with -ffixed-r11 on x86_64.  */
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-ffixed-r11" } */
+
+/* { dg-message "sorry, unimplemented: '-fsanitize=kcfi' is not compatible with '-ffixed-r10' or '-ffixed-r11' as KCFI requires these registers for type checking" "" 0 } */
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
-- 
2.34.1

