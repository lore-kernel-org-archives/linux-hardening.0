Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28DD6F305
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757031859; cv=none; b=TofzQ+tBrxIpHzGsHaoKTsZc4nTljIJZAxIpdfux77Hs0jZQHJeLz2Rk6JQYU86mob+KE23SskyhLbmbRlxWjz9o1WQhpxqr2RYyCcAVyc/Vc11uzmhyTTl6xSXms5DETSRiT8bLirN4HCodolr6oEoZqjAaCVCrG/YlI/X+vdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757031859; c=relaxed/simple;
	bh=AfGe0YIHtR0WOAD+XNfJFsZUWzrpMn5hWOBAmmmolGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yiv/JJulJrfiS/yBQEkPQ8+iiHeSDpUMHGao7bqGFdnKt0zVwgsYlVw268LIj7JlWfnY8OFF/RmRFPueS4Shh1f+7NBbes1XQy2zNV7hLN299IIXpnR/Na6ukVdaVlRLh6ZRbsODGeBGHO7Dmv1pSDnP8i7VHEzqrAOSOvolTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3tzmVr+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3tzmVr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F75BC4AF0E;
	Fri,  5 Sep 2025 00:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757031859;
	bh=AfGe0YIHtR0WOAD+XNfJFsZUWzrpMn5hWOBAmmmolGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p3tzmVr+Ppk1vq8r1i7P9s9q5+MO2a1YkoYX7CsCOkw+JxQChYcWaS53OuDwofjrr
	 3j0kwXrI6ApQSJW37ghqo/XT6A1cSgkeUv9oISp+Ysz25RyKJDue7eg8/7XThqtWpU
	 FqcO8E7Yz2fEYmpMgERqyxx4UcmVRlu3N4l4TzptkQFw14KUgKtiZvuWrm9+etIDZx
	 L9imWWDs9nYA3HnfEoSeM2uTRZcAyOopel+fFWGUg/hMSUJDNUGHuWU96Hr94LVMhE
	 Doo0kRmiXHWtvyUO0pZiOpmcsNba53GeJWuvDeOzS1ytQr8henja3K0oUPYJyW/1HI
	 duLA45cSwOA6Q==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Pinski <pinskia@gmail.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 6/7] riscv: Add RISC-V Kernel Control Flow Integrity implementation
Date: Thu,  4 Sep 2025 17:24:14 -0700
Message-Id: <20250905002418.464643-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905001157.it.269-kees@kernel.org>
References: <20250905001157.it.269-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14542; i=kees@kernel.org; h=from:subject; bh=AfGe0YIHtR0WOAD+XNfJFsZUWzrpMn5hWOBAmmmolGA=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm7dNdpes1XaL7udzoockbjTL2oytWn7HvYq8Tm1illO BekzpTsKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMi92wx/ZeN0Yp/fcvAw9X5m KCB28vbWbXkVLwRbef4m9TifUIvqZvjJKPVu7YVwtvLmroKXedyBSxlvy09mLvwzbU9m8C0PbVd mAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Implement RISC-V-specific KCFI backend.

- Function preamble generation using .word directives for type ID storage
  at offset from function entry point (no alignment NOPs needed due to
  fix 4-byte instruction size).

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
 gcc/config/riscv/riscv.cc       | 147 ++++++++++++++++++++++++++++++++
 gcc/config/riscv/riscv.md       |  74 ++++++++++++++--
 gcc/doc/invoke.texi             |  13 +++
 4 files changed, 231 insertions(+), 6 deletions(-)

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
index 41ee81b93acf..8dc54ffb19fe 100644
--- a/gcc/config/riscv/riscv.cc
+++ b/gcc/config/riscv/riscv.cc
@@ -81,6 +81,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "cgraph.h"
 #include "langhooks.h"
 #include "gimplify.h"
+#include "kcfi.h"
 
 /* This file should be included last.  */
 #include "target-def.h"
@@ -11346,6 +11347,149 @@ riscv_convert_vector_chunks (struct gcc_options *opts)
     return 1;
 }
 
+/* Apply KCFI wrapping to call pattern if needed.  */
+rtx
+riscv_maybe_wrap_call_with_kcfi (rtx pat, rtx addr)
+{
+  /* Only indirect calls need KCFI instrumentation.  */
+  bool is_direct_call = SYMBOL_REF_P (addr);
+  if (!is_direct_call)
+    {
+      rtx kcfi_type_rtx = kcfi_get_call_type_id ();
+      if (kcfi_type_rtx)
+	{
+	  /* Extract the CALL from the PARALLEL and wrap it with KCFI */
+	  rtx call_rtx = XVECEXP (pat, 0, 0);
+	  rtx kcfi_call = gen_rtx_KCFI (VOIDmode, call_rtx, kcfi_type_rtx);
+
+	  /* Replace the CALL in the PARALLEL with the KCFI-wrapped call */
+	  XVECEXP (pat, 0, 0) = kcfi_call;
+	}
+    }
+  return pat;
+}
+
+/* Apply KCFI wrapping to call_value pattern if needed.  */
+rtx
+riscv_maybe_wrap_call_value_with_kcfi (rtx pat, rtx addr)
+{
+  /* Only indirect calls need KCFI instrumentation.  */
+  bool is_direct_call = SYMBOL_REF_P (addr);
+  if (!is_direct_call)
+    {
+      rtx kcfi_type_rtx = kcfi_get_call_type_id ();
+      if (kcfi_type_rtx)
+	{
+	  /* Extract the SET from the PARALLEL and wrap its CALL with KCFI */
+	  rtx set_rtx = XVECEXP (pat, 0, 0);
+	  rtx call_rtx = SET_SRC (set_rtx);
+	  rtx kcfi_call = gen_rtx_KCFI (VOIDmode, call_rtx, kcfi_type_rtx);
+
+	  /* Replace the CALL in the SET with the KCFI-wrapped call */
+	  SET_SRC (set_rtx) = kcfi_call;
+	}
+    }
+  return pat;
+}
+
+/* Output the assembly for a KCFI checked call instruction.  */
+const char *
+riscv_output_kcfi_insn (rtx_insn *insn, rtx *operands)
+{
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
+     If bit 11 is set, increment upper 20 bits to compensate for sign extension. */
+  int32_t lo12 = ((int32_t)(expected_type << 20)) >> 20;
+  uint32_t hi20 = ((expected_type >> 12) + ((expected_type & 0x800) ? 1 : 0)) & 0xFFFFF;
+
+  rtx temp_operands[3];
+
+  /* Load actual type from memory at offset.  */
+  temp_operands[0] = gen_rtx_REG (SImode, temp1_regnum);
+  temp_operands[1] = gen_rtx_MEM (SImode,
+                      gen_rtx_PLUS (DImode, target_reg,
+                                   GEN_INT (offset)));
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
+  fprintf (asm_out_file, "\tbeq\t%s, %s, ", reg_names[temp1_regnum], reg_names[temp2_regnum]);
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
+      temp_operands[0] = gen_rtx_REG (DImode, 0);  /* x0 */
+      temp_operands[1] = target_reg;  /* target register */
+      temp_operands[2] = const0_rtx;
+      output_asm_insn ("jalr\t%0, %1, %2", temp_operands);
+    }
+  else
+    {
+      /* Regular call uses x1 (return address register).  */
+      temp_operands[0] = gen_rtx_REG (DImode, RETURN_ADDR_REGNUM);  /* x1 */
+      temp_operands[1] = target_reg;  /* target register */
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
@@ -15898,6 +16042,9 @@ riscv_prefetch_offset_address_p (rtx x, machine_mode mode)
 #define TARGET_GET_FUNCTION_VERSIONS_DISPATCHER \
   riscv_get_function_versions_dispatcher
 
+#undef TARGET_KCFI_SUPPORTED
+#define TARGET_KCFI_SUPPORTED hook_bool_void_true
+
 #undef TARGET_DOCUMENTATION_NAME
 #define TARGET_DOCUMENTATION_NAME "RISC-V"
 
diff --git a/gcc/config/riscv/riscv.md b/gcc/config/riscv/riscv.md
index 4718a75598a6..9a9524a5e46f 100644
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
 
+;; KCFI sibling call - matches KCFI wrapper RTL
+(define_insn "*kcfi_sibcall_insn"
+  [(kcfi (call (mem:SI (match_operand:DI 0 "call_insn_operand" "l"))
+               (match_operand 1 ""))
+         (match_operand 3 "const_int_operand"))
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
@@ -4009,11 +4024,26 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[1], 0));
-  emit_call_insn (gen_sibcall_value_internal (operands[0], target, operands[2],
-					      operands[3]));
+  rtx pat = gen_sibcall_value_internal (operands[0], target, operands[2], operands[3]);
+  pat = riscv_maybe_wrap_call_value_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI sibling call with return value - matches KCFI wrapper RTL
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
@@ -4037,10 +4067,26 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[0], 0));
-  emit_call_insn (gen_call_internal (target, operands[1], operands[2]));
+  rtx pat = gen_call_internal (target, operands[1], operands[2]);
+  pat = riscv_maybe_wrap_call_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI indirect call - matches KCFI wrapper RTL
+(define_insn "*kcfi_call_internal"
+  [(kcfi (call (mem:SI (match_operand:DI 0 "call_insn_operand" "l"))
+               (match_operand 1 "" ""))
+         (match_operand 3 "const_int_operand"))
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
@@ -4065,11 +4111,27 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[1], 0));
-  emit_call_insn (gen_call_value_internal (operands[0], target, operands[2],
-					   operands[3]));
+  rtx pat = gen_call_value_internal (operands[0], target, operands[2], operands[3]);
+  pat = riscv_maybe_wrap_call_value_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI call with return value - matches KCFI wrapper RTL
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
index 25ee82c9cba7..43e86f4bc5b4 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18458,6 +18458,19 @@ allowing the kernel to identify both the KCFI violation and the involved
 registers for detailed diagnostics (eliminating the need for a separate
 @code{.kcfi_traps} section as used on x86_64).
 
+On RISC-V, KCFI type identifiers are emitted as a @code{.word ID}
+directive (a 32-bit constant) before the function entry, similar to AArch64.
+RISC-V's natural 4-byte instruction alignment eliminates the need for
+additional padding NOPs.  When used with @option{-fpatchable-function-entry},
+the type identifier is placed before any patchable NOPs.  The runtime check
+loads the actual type using @code{lw t1, OFFSET(target_reg)}, where the
+offset accounts for any prefix NOPs, constructs the expected type using
+@code{lui} and @code{addiw} instructions into @code{t2}, and compares them
+with @code{beq}.  Type mismatches trigger an @code{ebreak} instruction.
+Like x86_64, RISC-V uses a @code{.kcfi_traps} section to map trap locations
+to their corresponding function entry points for debugging (RISC-V lacks
+ESR-style trap encoding unlike AArch64).
+
 KCFI is intended primarily for kernel code and may not be suitable
 for user-space applications that rely on techniques incompatible
 with strict type checking of indirect calls.
-- 
2.34.1

