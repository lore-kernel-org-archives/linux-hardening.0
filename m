Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58A2C0F66
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805846; cv=none; b=mt/ZEu00CxE1DkG/pW9dcPgxXX4Qt+dm9U5R+RF6ouxz5Q3t4j8LikHlEi9hnjCVb2GIMkJ8HKzVy+CFA+ItBiJbq1lcwRAoXZ4UEkha7cqWB8JmMkd+1OUQS+U6EhHPeIzVnHrqJ4k4qiA0ePsLtrsBlY0A3of6Yi1ckyoG6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805846; c=relaxed/simple;
	bh=M2UXDP89Jn1ifVAUbjOYnLcQFFVIeRDRJPlSB1jYOYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDw7uK/mu6rL/9MufGpSijGG+hA2H4RqP9ZWsiFr+EXP3yk777hGQxW5E4JmyYSoX/EvRVifZ8XtITnJEfA4wPR3L2iP1OVXTAXhtd8qwUOvNn9KgxFOKHb7nelftOWA8OvvGJ8povhBM01SXtSO7R/9XQ8JMFZf5BA553IpAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n32Ae1n1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n32Ae1n1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B20AC4AF0D;
	Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757805845;
	bh=M2UXDP89Jn1ifVAUbjOYnLcQFFVIeRDRJPlSB1jYOYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n32Ae1n1aABPP6iZcv5SKv85WCDGeklpM+onfGe/dTB7MZPuAqk9tAOvlbqXZ71Dt
	 fcqA4m6N28lF/Ft4jXykNUGQ57Fn8b9trQn0aMSMYbgUxm5WvqXIRVMGmy2WhVp5F8
	 iXlrKfblamgV/PoV731QVKfTB7u3q/92bJimciA3rbuFnAPYuBNa7YOgX5e+YHJvUo
	 thlqE6cUVPSNaNUQpW3Ho6XBb9HJyeJalMyFByBr1VhaiYeYSgJRLzb2QfpY5WGfh8
	 VfAlLc9pVGDy7QG7CioUg2rfmYYNm2xunaqEDygcp4uIFS4REJAt/P9JkKGa42HAan
	 fD/b+r+9KJedA==
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
Subject: [PATCH v3 6/7] riscv: Add RISC-V Kernel Control Flow Integrity implementation
Date: Sat, 13 Sep 2025 16:24:02 -0700
Message-Id: <20250913232404.2690431-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913231256.make.519-kees@kernel.org>
References: <20250913231256.make.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14398; i=kees@kernel.org; h=from:subject; bh=M2UXDP89Jn1ifVAUbjOYnLcQFFVIeRDRJPlSB1jYOYY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlH/wr1e/+Mnfh90/K8eO6KrmVM09l/CNx58EN7Crfqr X2q8hNmdJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzE7yrDb3Yn2zd7jAwezai4 zKt5/4v+TYkVr9aY7XjZrPBVNNX+NCsjw0fugJ/XQio37jAwD2admpoevb4izPAjiyXLjokr7xZ G8wMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Implement RISC-V-specific KCFI backend.

- Scratch register allocation using t1/t2 (x6/x7) following RISC-V
  procedure call standard for temporary registers.

- Integration with .kcfi_traps section for debugger/runtime metadata
  (like x86_64).

Assembly Code Pattern for RISC-V:
  lw      t1, -4(target_reg)         ; Load actual type ID from preamble
  lui     t2, %hi(expected_type)     ; Load expected type (upper 20 bits)
  addiw   t2, t2, %lo(expected_type) ; Add lower 12 bits (sign-extended)
  beq     t1, t2, .Lkcfi_call        ; Branch if types match
  .Lkcfi_trap: ebreak                ; Environment break trap on mismatch
  .Lkcfi_call: jalr/jr target_reg    ; Execute validated indirect transfer

Build and run tested with Linux kernel ARCH=riscv.

gcc/ChangeLog:

	config/riscv/riscv-protos.h: Declare KCFI helpers.
	config/riscv/riscv.cc (riscv_maybe_wrap_call_with_kcfi): New
	function, to wrap calls.
	(riscv_maybe_wrap_call_value_with_kcfi): New function, to
	wrap calls with return values.
	(riscv_output_kcfi_insn): New function to emit KCFI assembly.
	config/riscv/riscv.md: Add KCFI RTL patterns and hook expansion.
	doc/invoke.texi: Document riscv nuances.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/riscv/riscv-protos.h |   3 +
 gcc/config/riscv/riscv.cc       | 159 ++++++++++++++++++++++++++++++++
 gcc/config/riscv/riscv.md       |  76 +++++++++++++--
 gcc/doc/invoke.texi             |  13 +++
 4 files changed, 245 insertions(+), 6 deletions(-)

diff --git a/gcc/config/riscv/riscv-protos.h b/gcc/config/riscv/riscv-protos.h
index 2d60a0ad44b3..0e916fbdde13 100644
--- a/gcc/config/riscv/riscv-protos.h
+++ b/gcc/config/riscv/riscv-protos.h
@@ -126,6 +126,9 @@ extern bool riscv_split_64bit_move_p (rtx, rtx);
 extern void riscv_split_doubleword_move (rtx, rtx);
 extern const char *riscv_output_move (rtx, rtx);
 extern const char *riscv_output_return ();
+extern rtx riscv_maybe_wrap_call_with_kcfi (rtx, rtx);
+extern rtx riscv_maybe_wrap_call_value_with_kcfi (rtx, rtx);
+extern const char *riscv_output_kcfi_insn (rtx_insn *, rtx *);
 extern void riscv_declare_function_name (FILE *, const char *, tree);
 extern void riscv_declare_function_size (FILE *, const char *, tree);
 extern void riscv_asm_output_alias (FILE *, const tree, const tree);
diff --git a/gcc/config/riscv/riscv.cc b/gcc/config/riscv/riscv.cc
index 41ee81b93acf..7d51ab11c7ee 100644
--- a/gcc/config/riscv/riscv.cc
+++ b/gcc/config/riscv/riscv.cc
@@ -81,6 +81,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "cgraph.h"
 #include "langhooks.h"
 #include "gimplify.h"
+#include "kcfi.h"
 
 /* This file should be included last.  */
 #include "target-def.h"
@@ -11346,6 +11347,161 @@ riscv_convert_vector_chunks (struct gcc_options *opts)
     return 1;
 }
 
+/* Apply KCFI wrapping to call pattern if needed.  */
+
+rtx
+riscv_maybe_wrap_call_with_kcfi (rtx pat, rtx addr)
+{
+  /* Only indirect calls need KCFI instrumentation.  */
+  bool is_direct_call = SYMBOL_REF_P (addr);
+  if (!is_direct_call)
+    {
+      rtx kcfi_type_rtx = kcfi_get_type_id_for_expanding_gimple_call ();
+      if (kcfi_type_rtx)
+	{
+	  /* Extract the CALL from the PARALLEL and wrap it with KCFI.  */
+	  rtx call_rtx = XVECEXP (pat, 0, 0);
+	  rtx kcfi_call = gen_rtx_KCFI (VOIDmode, call_rtx, kcfi_type_rtx);
+
+	  /* Replace the CALL in the PARALLEL with the KCFI-wrapped call.  */
+	  XVECEXP (pat, 0, 0) = kcfi_call;
+	}
+    }
+  return pat;
+}
+
+/* Apply KCFI wrapping to call_value pattern if needed.  */
+
+rtx
+riscv_maybe_wrap_call_value_with_kcfi (rtx pat, rtx addr)
+{
+  /* Only indirect calls need KCFI instrumentation.  */
+  bool is_direct_call = SYMBOL_REF_P (addr);
+  if (!is_direct_call)
+    {
+      rtx kcfi_type_rtx = kcfi_get_type_id_for_expanding_gimple_call ();
+      if (kcfi_type_rtx)
+	{
+	  /* Extract the SET from the PARALLEL and wrap its CALL with KCFI.  */
+	  rtx set_rtx = XVECEXP (pat, 0, 0);
+	  rtx call_rtx = SET_SRC (set_rtx);
+	  rtx kcfi_call = gen_rtx_KCFI (VOIDmode, call_rtx, kcfi_type_rtx);
+
+	  /* Replace the CALL in the SET with the KCFI-wrapped call.  */
+	  SET_SRC (set_rtx) = kcfi_call;
+	}
+    }
+  return pat;
+}
+
+/* Output the assembly for a KCFI checked call instruction.  */
+
+const char *
+riscv_output_kcfi_insn (rtx_insn *insn, rtx *operands)
+{
+  /* KCFI is only supported in 64-bit mode.  */
+  if (!TARGET_64BIT)
+    {
+      sorry ("%<-fsanitize=kcfi%> is not supported for 32-bit RISC-V");
+      return "";
+    }
+  /* Target register.  */
+  rtx target_reg = operands[0];
+  gcc_assert (REG_P (target_reg));
+
+  /* Get KCFI type ID.  */
+  uint32_t expected_type = (uint32_t) INTVAL (operands[3]);
+
+  /* Calculate typeid offset from call target.  */
+  HOST_WIDE_INT offset = -(4 + kcfi_patchable_entry_prefix_nops);
+
+  /* Choose scratch registers that don't conflict with target.  */
+  unsigned temp1_regnum = T1_REGNUM;
+  unsigned temp2_regnum = T2_REGNUM;
+
+  if (REGNO (target_reg) == T1_REGNUM)
+    temp1_regnum = T3_REGNUM;
+  else if (REGNO (target_reg) == T2_REGNUM)
+    temp2_regnum = T3_REGNUM;
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
+  /* Split expected_type for RISC-V immediate encoding.
+     If bit 11 is set, increment upper 20 bits to compensate for sign
+     extension.  */
+  int32_t lo12 = ((int32_t)(expected_type << 20)) >> 20;
+  uint32_t hi20 = ((expected_type >> 12)
+		    + ((expected_type & 0x800) ? 1 : 0)) & 0xFFFFF;
+
+  rtx temp_operands[3];
+
+  /* Load actual type from memory at offset.  */
+  temp_operands[0] = gen_rtx_REG (SImode, temp1_regnum);
+  temp_operands[1] = gen_rtx_MEM (SImode,
+				  gen_rtx_PLUS (DImode, target_reg,
+						GEN_INT (offset)));
+  output_asm_insn ("lw\t%0, %1", temp_operands);
+
+  /* Load expected type using lui + addiw for proper sign extension.  */
+  temp_operands[0] = gen_rtx_REG (SImode, temp2_regnum);
+  temp_operands[1] = GEN_INT (hi20);
+  output_asm_insn ("lui\t%0, %1", temp_operands);
+
+  temp_operands[0] = gen_rtx_REG (SImode, temp2_regnum);
+  temp_operands[1] = gen_rtx_REG (SImode, temp2_regnum);
+  temp_operands[2] = GEN_INT (lo12);
+  output_asm_insn ("addiw\t%0, %1, %2", temp_operands);
+
+  /* Output conditional branch to call label.  */
+  fprintf (asm_out_file, "\tbeq\t%s, %s, ",
+	   reg_names[temp1_regnum], reg_names[temp2_regnum]);
+  assemble_name (asm_out_file, call_name);
+  fputc ('\n', asm_out_file);
+
+  /* Output trap label and ebreak instruction.  */
+  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
+  output_asm_insn ("ebreak", operands);
+
+  /* Use common helper for trap section entry.  */
+  rtx trap_label_sym = gen_rtx_SYMBOL_REF (Pmode, trap_name);
+  kcfi_emit_traps_section (asm_out_file, trap_label_sym);
+
+  /* Output pass/call label.  */
+  ASM_OUTPUT_LABEL (asm_out_file, call_name);
+
+  /* Execute the indirect call.  */
+  if (SIBLING_CALL_P (insn))
+    {
+      /* Tail call uses x0 (zero register) to avoid saving return address.  */
+      temp_operands[0] = gen_rtx_REG (DImode, 0);
+      temp_operands[1] = target_reg;
+      temp_operands[2] = const0_rtx;
+      output_asm_insn ("jalr\t%0, %1, %2", temp_operands);
+    }
+  else
+    {
+      /* Regular call uses x1 (return address register).  */
+      temp_operands[0] = gen_rtx_REG (DImode, RETURN_ADDR_REGNUM);
+      temp_operands[1] = target_reg;
+      temp_operands[2] = const0_rtx;
+      output_asm_insn ("jalr\t%0, %1, %2", temp_operands);
+    }
+
+  return "";
+}
+
 /* 'Unpack' up the internal tuning structs and update the options
     in OPTS.  The caller must have set up selected_tune and selected_arch
     as all the other target-specific codegen decisions are
@@ -15898,6 +16054,9 @@ riscv_prefetch_offset_address_p (rtx x, machine_mode mode)
 #define TARGET_GET_FUNCTION_VERSIONS_DISPATCHER \
   riscv_get_function_versions_dispatcher
 
+#undef TARGET_KCFI_SUPPORTED
+#define TARGET_KCFI_SUPPORTED hook_bool_void_true
+
 #undef TARGET_DOCUMENTATION_NAME
 #define TARGET_DOCUMENTATION_NAME "RISC-V"
 
diff --git a/gcc/config/riscv/riscv.md b/gcc/config/riscv/riscv.md
index 4718a75598a6..0124999c4c45 100644
--- a/gcc/config/riscv/riscv.md
+++ b/gcc/config/riscv/riscv.md
@@ -3982,10 +3982,25 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[0], 0));
-  emit_call_insn (gen_sibcall_internal (target, operands[1], operands[2]));
+  rtx pat = gen_sibcall_internal (target, operands[1], operands[2]);
+  pat = riscv_maybe_wrap_call_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI sibling call
+(define_insn "*kcfi_sibcall_insn"
+  [(kcfi (call (mem:SI (match_operand:DI 0 "call_insn_operand" "l"))
+	       (match_operand 1 ""))
+	 (match_operand 3 "const_int_operand"))
+   (use (unspec:SI [(match_operand 2 "const_int_operand")] UNSPEC_CALLEE_CC))]
+  "SIBLING_CALL_P (insn)"
+{
+  return riscv_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
 (define_insn "sibcall_internal"
   [(call (mem:SI (match_operand 0 "call_insn_operand" "j,S,U"))
 	 (match_operand 1 "" ""))
@@ -4009,11 +4024,27 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[1], 0));
-  emit_call_insn (gen_sibcall_value_internal (operands[0], target, operands[2],
-					      operands[3]));
+  rtx pat = gen_sibcall_value_internal (operands[0], target, operands[2],
+					operands[3]);
+  pat = riscv_maybe_wrap_call_value_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI sibling call with return value
+(define_insn "*kcfi_sibcall_value_insn"
+  [(set (match_operand 0 "")
+	(kcfi (call (mem:SI (match_operand:DI 1 "call_insn_operand" "l"))
+		    (match_operand 2 ""))
+	      (match_operand 4 "const_int_operand")))
+   (use (unspec:SI [(match_operand 3 "const_int_operand")] UNSPEC_CALLEE_CC))]
+  "SIBLING_CALL_P (insn)"
+{
+  return riscv_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
 (define_insn "sibcall_value_internal"
   [(set (match_operand 0 "" "")
 	(call (mem:SI (match_operand 1 "call_insn_operand" "j,S,U"))
@@ -4037,10 +4068,26 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[0], 0));
-  emit_call_insn (gen_call_internal (target, operands[1], operands[2]));
+  rtx pat = gen_call_internal (target, operands[1], operands[2]);
+  pat = riscv_maybe_wrap_call_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI indirect call
+(define_insn "*kcfi_call_internal"
+  [(kcfi (call (mem:SI (match_operand:DI 0 "call_insn_operand" "l"))
+	       (match_operand 1 "" ""))
+	 (match_operand 3 "const_int_operand"))
+   (use (unspec:SI [(match_operand 2 "const_int_operand")] UNSPEC_CALLEE_CC))
+   (clobber (reg:SI RETURN_ADDR_REGNUM))]
+  "!SIBLING_CALL_P (insn)"
+{
+  return riscv_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
 (define_insn "call_internal"
   [(call (mem:SI (match_operand 0 "call_insn_operand" "l,S,U"))
 	 (match_operand 1 "" ""))
@@ -4065,11 +4112,28 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[1], 0));
-  emit_call_insn (gen_call_value_internal (operands[0], target, operands[2],
-					   operands[3]));
+  rtx pat = gen_call_value_internal (operands[0], target, operands[2],
+				     operands[3]);
+  pat = riscv_maybe_wrap_call_value_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI call with return value
+(define_insn "*kcfi_call_value_insn"
+  [(set (match_operand 0 "" "")
+	(kcfi (call (mem:SI (match_operand:DI 1 "call_insn_operand" "l"))
+		    (match_operand 2 "" ""))
+	      (match_operand 4 "const_int_operand")))
+   (use (unspec:SI [(match_operand 3 "const_int_operand")] UNSPEC_CALLEE_CC))
+   (clobber (reg:SI RETURN_ADDR_REGNUM))]
+  "!SIBLING_CALL_P (insn)"
+{
+  return riscv_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
 (define_insn "call_value_internal"
   [(set (match_operand 0 "" "")
 	(call (mem:SI (match_operand 1 "call_insn_operand" "l,S,U"))
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index dfaec475d2e1..4aaf23cb836d 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18456,6 +18456,19 @@ allowing the kernel to identify both the KCFI violation and the involved
 registers for detailed diagnostics (eliminating the need for a separate
 @code{.kcfi_traps} section as used on x86_64).
 
+On RISC-V, KCFI type identifiers are emitted as a @code{.word ID}
+directive (a 32-bit constant) before the function entry, similar to AArch64.
+RISC-V's natural 4-byte instruction alignment eliminates the need for
+additional alignment NOPs.  When used with @option{-fpatchable-function-entry},
+the type identifier is placed before any prefix NOPs.  The runtime check
+loads the actual type using @code{lw t1, OFFSET(target_reg)}, where the
+offset accounts for any prefix NOPs, constructs the expected type using
+@code{lui} and @code{addiw} instructions into @code{t2}, and compares them
+with @code{beq}.  Type mismatches trigger an @code{ebreak} instruction.
+Like x86_64, RISC-V uses a @code{.kcfi_traps} section to map trap locations
+to their corresponding function entry points for debugging (RISC-V lacks
+ESR-style trap encoding like used on AArch64).
+
 KCFI is intended primarily for kernel code and may not be suitable
 for user-space applications that rely on techniques incompatible
 with strict type checking of indirect calls.
-- 
2.34.1

