Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D325785B
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805845; cv=none; b=i6Dg7fF8atviM95V3jvJ/vRYZY9XnFGVf+XoqyzUUpSOcn2bSCTdYl1CrpkW30AozUc2YAbKoqFLQtrnfRzJVE3Va1g0BJyNBiMxxnV1XC9f1kuWCknXxEcGFFdPthAjwS2lTH3c/Jq+Jm/dhcLkuhJDpLPMbDHWkAkZHZ5xORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805845; c=relaxed/simple;
	bh=GDBgcRfi+AsNRuGFzlnvalohmejBfTtg448T6556LCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ox9nj04cMRmQLUfVuXyhcx08ofSWrpvBfMwtaOb07pq1iWjjdmgxKNLbVi+4Zqvb/uDIOE1HRR3eGrS2DayEYZ6uGkAhhRG+GZEWyYaLWCK+Nbg5zHivSO8BOqujnx3gc0XOWvln0N2+EE6YLPXJDEATf6LKFe56gwjox9mqpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjNSdjML; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjNSdjML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C5BC4CEF8;
	Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757805845;
	bh=GDBgcRfi+AsNRuGFzlnvalohmejBfTtg448T6556LCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjNSdjML5zn9YDHmNLjWInmUgnxqe3/dOP/MkQr9B9DQpNRtZtvxUzcfDUWkto7bt
	 gvHOwyjPj03vU6sukmOhsust/YzdYuvNDwBhm0Z9zZv3FNmUqY8a4cNeUe/0jLFb8z
	 nz47KgcHIiDnqSkGjw0eKWRAuG8B+AtC+xZgA9+Huup5NGLsM3VWDdWCur3sgyI/nb
	 HaxwXRyg1vCsd57mGue8Ok6MOJ0T/5F3ANKj9XXOSFAEJ8Yp8Qx2SplOwxEnmcwibu
	 pX+OoITchxIbsQEgvaSiPUNb0GDDYij9O8+AZtBTlcgslRlN+vcPyXkmFVx+VTYPI/
	 RD6P15Nru7nmA==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v3 3/7] x86: Add x86_64 Kernel Control Flow Integrity implementation
Date: Sat, 13 Sep 2025 16:23:59 -0700
Message-Id: <20250913232404.2690431-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913231256.make.519-kees@kernel.org>
References: <20250913231256.make.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16645; i=kees@kernel.org; h=from:subject; bh=GDBgcRfi+AsNRuGFzlnvalohmejBfTtg448T6556LCw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlH/wpuifgcWWyYIGHDmuO/dFH4grKXzKV29UEP3tjNS Fmy2uhtRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQu7WVkeHp0LQOzxt0vwUY7 tycn/Vpx9Xng9cvvbr9p/H0v8/mE0CpGhlU3JdUyZfI2yr7Q3JPFNHWjit5a5nt/ei/Oj+4VaS6 /yAUA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Implement x86_64-specific KCFI backend:

- Implies -mindirect-branch-register since KCFI needs call target in
  a register for typeid hash loading.

- Function preamble generation with type IDs positioned at -(4+prefix_nops)
  offset from function entry point.

- Function-aligned KCFI preambles using calculated alignment NOPs:
  aligned(prefix_nops + 5, $func_align) to maintain ability to call the
  __cfi_ preamble directly in the case of Linux's FineIBT alternative
  CFI sequences (live patched into place).

- Type-id hash avoids generating ENDBR instruction in type IDs
  (0xfa1e0ff3/0xfb1e0ff3 are incremented by 1 to prevent execution).

- On-demand scratch register allocation strategy (r11 as needed).
  The clobbers are available both early and late.

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

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/i386/i386-protos.h  |   1 +
 gcc/config/i386/i386.h         |   3 +-
 gcc/config/i386/i386-expand.cc |  22 +++++-
 gcc/config/i386/i386.cc        | 130 +++++++++++++++++++++++++++++++++
 gcc/config/i386/i386.md        |  62 +++++++++++++++-
 gcc/doc/invoke.texi            |  23 ++++++
 6 files changed, 233 insertions(+), 8 deletions(-)

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
index 2d53db683176..5c6012ac743b 100644
--- a/gcc/config/i386/i386.h
+++ b/gcc/config/i386/i386.h
@@ -3038,7 +3038,8 @@ extern void debug_dispatch_window (int);
 
 #define TARGET_INDIRECT_BRANCH_REGISTER \
   (ix86_indirect_branch_register \
-   || cfun->machine->indirect_branch_type != indirect_branch_keep)
+   || cfun->machine->indirect_branch_type != indirect_branch_keep \
+   || (flag_sanitize & SANITIZE_KCFI))
 
 #define IX86_HLE_ACQUIRE (1 << 16)
 #define IX86_HLE_RELEASE (1 << 17)
diff --git a/gcc/config/i386/i386-expand.cc b/gcc/config/i386/i386-expand.cc
index ef6c12cd5697..3f322271b98f 100644
--- a/gcc/config/i386/i386-expand.cc
+++ b/gcc/config/i386/i386-expand.cc
@@ -94,6 +94,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "i386-builtins.h"
 #include "i386-expand.h"
 #include "asan.h"
+#include "kcfi.h"
 
 /* Split one or more double-mode RTL references into pairs of half-mode
    references.  The RTL can be REG, offsettable MEM, integer constant, or
@@ -10279,8 +10280,9 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   unsigned int vec_len = 0;
   tree fndecl;
   bool call_no_callee_saved_registers = false;
+  bool is_direct_call = SYMBOL_REF_P (XEXP (fnaddr, 0));
 
-  if (SYMBOL_REF_P (XEXP (fnaddr, 0)))
+  if (is_direct_call)
     {
       fndecl = SYMBOL_REF_DECL (XEXP (fnaddr, 0));
       if (fndecl)
@@ -10317,7 +10319,7 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   if (TARGET_MACHO && !TARGET_64BIT)
     {
 #if TARGET_MACHO
-      if (flag_pic && SYMBOL_REF_P (XEXP (fnaddr, 0)))
+      if (flag_pic && is_direct_call)
 	fnaddr = machopic_indirect_call_target (fnaddr);
 #endif
     }
@@ -10401,7 +10403,7 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   if (ix86_cmodel == CM_LARGE_PIC
       && !TARGET_PECOFF
       && MEM_P (fnaddr)
-      && SYMBOL_REF_P (XEXP (fnaddr, 0))
+      && is_direct_call
       && !local_symbolic_operand (XEXP (fnaddr, 0), VOIDmode))
     fnaddr = gen_rtx_MEM (QImode, construct_plt_address (XEXP (fnaddr, 0)));
   /* Since x32 GOT slot is 64 bit with zero upper 32 bits, indirect
@@ -10433,6 +10435,20 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
 
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
diff --git a/gcc/config/i386/i386.cc b/gcc/config/i386/i386.cc
index b2c1acd12dac..c3dde17322f6 100644
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
@@ -1700,6 +1701,20 @@ ix86_function_naked (const_tree fn)
   return false;
 }
 
+/* Apply x86-64 specific masking to KCFI type ID.  */
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
 /* Write the extra assembler code needed to declare a function properly.  */
 
 void
@@ -28469,6 +28484,121 @@ ix86_set_handled_components (sbitmap components)
       }
 }
 
+/* Output the assembly for a KCFI checked call instruction.  */
+
+const char *
+ix86_output_kcfi_insn (rtx_insn *insn, rtx *operands)
+{
+  /* KCFI is only supported in 64-bit mode due to use of r10/r11 registers.  */
+  if (!TARGET_64BIT || TARGET_X32)
+    {
+      sorry ("%<-fsanitize=kcfi%> is not supported for 32-bit x86 or x32 mode");
+      return "";
+    }
+
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
+  /* Generate labels internally.  */
+  rtx trap_label = gen_label_rtx ();
+  rtx call_label = gen_label_rtx ();
+
+  /* Get label numbers for custom naming.  */
+  int trap_labelno = CODE_LABEL_NUMBER (trap_label);
+  int call_labelno = CODE_LABEL_NUMBER (call_label);
+
+  /* Generate custom label names.  */
+  char trap_name[32];
+  char call_name[32];
+  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", trap_labelno);
+  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", call_labelno);
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
+  HOST_WIDE_INT offset = -(4 + kcfi_patchable_entry_prefix_nops);
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
+  /* Finally emit the protected call or sibling call.  */
+  if (SIBLING_CALL_P (insn))
+    return ix86_output_indirect_jmp (target_reg);
+  else
+    return ix86_output_call_insn (insn, target_reg);
+}
+
+/* Emit x86_64-specific type ID instruction and return instruction size.  */
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
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index f96e104a7248..bd84b7dd903f 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18402,6 +18402,29 @@ The type identifier is placed before the function entry point,
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
-- 
2.34.1

