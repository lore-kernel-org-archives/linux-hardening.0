Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2690290D81
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805846; cv=none; b=esocnJpAiBycJOThTf7Vcx69/QctYZIDbLxJJHXl8Tr2YBPUaZbpeDM8idikFMzjdzhdSAcxmVfesxFsOJET2opDRSEDDCXXFw8ytv66txqimKLYcuq/1KtTlSxhmNVxJR0sBA1cx4lc7TOqPglcxUT39ykn0Neae9e6NdUwgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805846; c=relaxed/simple;
	bh=RicSM13Us7UVR3BUlyRqgQvIzZydZ1URVgFZtdMojP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AcI1u0fnIOYdTYn0fjFyzn/5mxDB07dbApZHllWV43FhUFVW6HXK5h4vlTUI6/O6X4X9MNsViVoWIMf6c9YcNks0Tb4ySyTzH6xhNslvEFlKLbPLsszMLAs+Cb6caU5FIUtkwlH9Gfq2n/RoBKTIbxxLT3H/jPEyqoeLJaN4aPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reRr9+OH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reRr9+OH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FAAC4CEFA;
	Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757805845;
	bh=RicSM13Us7UVR3BUlyRqgQvIzZydZ1URVgFZtdMojP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=reRr9+OHBUNVIyv9aVbXYX+ZUrBRIHRyzr+8UJgEEYjjNQBcnEhIshLfHi0TLDR9m
	 ZHhA2RsN0SMajd/eVyH3hAHU+OiVSb6pbIlw/tApb4ndzwUF4SJB2GxMvAGsKh5W8T
	 JvmA1ULxD/lFMt1DZzcB/rSnmE/mC7WC5RzlhAi7sjKq3rgqj3Q6/SJj7USsVdury3
	 oCU8X56KOpL4LbC3Hzj1UOPwR7oEThsoh7RErqIegJoRsq+w0hzE9EyQ17wIwNF5V2
	 oTsxYZDNfCmV0gO7m4w7ZudBV1PFWrwTqhdWEtdSoN++AQ09dsm2AI3ZvnJAqmPWWH
	 44UKXvPBsrXCw==
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
Subject: [PATCH v3 4/7] aarch64: Add AArch64 Kernel Control Flow Integrity implementation
Date: Sat, 13 Sep 2025 16:24:00 -0700
Message-Id: <20250913232404.2690431-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913231256.make.519-kees@kernel.org>
References: <20250913231256.make.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13489; i=kees@kernel.org; h=from:subject; bh=RicSM13Us7UVR3BUlyRqgQvIzZydZ1URVgFZtdMojP8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlH/wpqHz9e4O0Wv7PG79zCPcGRwcvLI7cey77q/86YZ 9eN1oKujlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIn0PWb4X7fxzo5yw4LIV9wf Xf9MWKES+CRm6p9u0y89E6crvEvOM2Rk6Fl3ccM6pv35W5fNXubVpuwcPjM18cHZ5fNda4uynxa mMAAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Implement AArch64-specific KCFI backend.

- Trap debugging through ESR (Exception Syndrome Register) encoding
  in BRK instruction immediate values.

- Scratch register allocation using w16/w17 (x16/x17) following
  AArch64 procedure call standard for intra-procedure-call registers.

Assembly Code Pattern for AArch64:
  ldur w16, [target, #-4]       ; Load actual type ID from preamble
  mov  w17, #type_id_low        ; Load expected type (lower 16 bits)
  movk w17, #type_id_high, lsl #16  ; Load upper 16 bits if needed
  cmp  w16, w17                 ; Compare type IDs directly
  b.eq .Lpass                   ; Branch if types match
  .Ltrap: brk #esr_value        ; Enhanced trap with register info
  .Lpass: blr/br target         ; Execute validated indirect transfer

ESR (Exception Syndrome Register) Integration:
- BRK instruction immediate encoding format:
  0x8000 | ((TypeIndex & 31) << 5) | (AddrIndex & 31)
  - TypeIndex indicates which W register contains expected type (W17 = 17)
  - AddrIndex indicates which X register contains target address (0-30)
  - Example: brk #33313 (0x8221) = expected type in W17, target address in X1

Build and run tested with Linux kernel ARCH=arm64.

gcc/ChangeLog:

	config/aarch64/aarch64-protos.h: Declare aarch64_indirect_branch_asm,
	and KCFI helpers.
	config/aarch64/aarch64.cc (aarch64_expand_call): Wrap CALLs in
	KCFI, with clobbers.
	(aarch64_indirect_branch_asm): New function, extract common
	logic for branch asm, like existing call asm helper.
	(aarch64_output_kcfi_insn): Emit KCFI assembly.
	config/aarch64/aarch64.md: Add KCFI RTL patterns and replace
	open-coded branch emission with aarch64_indirect_branch_asm.
	doc/invoke.texi: Document aarch64 nuances.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/aarch64/aarch64-protos.h |   5 ++
 gcc/config/aarch64/aarch64.cc       | 116 ++++++++++++++++++++++++++++
 gcc/config/aarch64/aarch64.md       |  64 +++++++++++++--
 gcc/doc/invoke.texi                 |  14 ++++
 4 files changed, 191 insertions(+), 8 deletions(-)

diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aarch64-protos.h
index 56efcf2c7f2c..c91fdcc80ea3 100644
--- a/gcc/config/aarch64/aarch64-protos.h
+++ b/gcc/config/aarch64/aarch64-protos.h
@@ -1261,6 +1261,7 @@ tree aarch64_resolve_overloaded_builtin_general (location_t, tree, void *);
 
 const char *aarch64_sls_barrier (int);
 const char *aarch64_indirect_call_asm (rtx);
+const char *aarch64_indirect_branch_asm (rtx);
 extern bool aarch64_harden_sls_retbr_p (void);
 extern bool aarch64_harden_sls_blr_p (void);
 
@@ -1284,4 +1285,8 @@ extern unsigned aarch64_stack_alignment (const_tree exp, unsigned align);
 extern rtx aarch64_gen_compare_zero_and_branch (rtx_code code, rtx x,
 						rtx_code_label *label);
 
+/* KCFI support.  */
+extern void kcfi_emit_trap_with_section (FILE *file, rtx trap_label_rtx);
+extern const char *aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands);
+
 #endif /* GCC_AARCH64_PROTOS_H */
diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.cc
index fb8311b655d7..a7d17f18b72e 100644
--- a/gcc/config/aarch64/aarch64.cc
+++ b/gcc/config/aarch64/aarch64.cc
@@ -83,6 +83,7 @@
 #include "rtlanal.h"
 #include "tree-dfa.h"
 #include "asan.h"
+#include "kcfi.h"
 #include "aarch64-elf-metadata.h"
 #include "aarch64-feature-deps.h"
 #include "config/arm/aarch-common.h"
@@ -11848,6 +11849,16 @@ aarch64_expand_call (rtx result, rtx mem, rtx cookie, bool sibcall)
 
   call = gen_rtx_CALL (VOIDmode, mem, const0_rtx);
 
+  /* Only indirect calls need KCFI instrumentation.  */
+  bool is_direct_call = SYMBOL_REF_P (XEXP (mem, 0));
+  rtx kcfi_type_rtx = is_direct_call ? NULL_RTX
+    : kcfi_get_type_id_for_expanding_gimple_call ();
+  if (kcfi_type_rtx)
+    {
+      /* Wrap call in KCFI.  */
+      call = gen_rtx_KCFI (VOIDmode, call, kcfi_type_rtx);
+    }
+
   if (result != NULL_RTX)
     call = gen_rtx_SET (result, call);
 
@@ -11864,6 +11875,16 @@ aarch64_expand_call (rtx result, rtx mem, rtx cookie, bool sibcall)
 
   auto call_insn = aarch64_emit_call_insn (call);
 
+  /* Add KCFI clobbers for indirect calls.  */
+  if (kcfi_type_rtx)
+    {
+      rtx usage = CALL_INSN_FUNCTION_USAGE (call_insn);
+      /* Add X16 and X17 clobbers for AArch64 KCFI scratch registers.  */
+      clobber_reg (&usage, gen_rtx_REG (DImode, 16));
+      clobber_reg (&usage, gen_rtx_REG (DImode, 17));
+      CALL_INSN_FUNCTION_USAGE (call_insn) = usage;
+    }
+
   /* Check whether the call requires a change to PSTATE.SM.  We can't
      emit the instructions to change PSTATE.SM yet, since they involve
      a change in vector length and a change in instruction set, which
@@ -30630,6 +30651,14 @@ aarch64_indirect_call_asm (rtx addr)
   return "";
 }
 
+const char *
+aarch64_indirect_branch_asm (rtx addr)
+{
+  gcc_assert (REG_P (addr));
+  output_asm_insn ("br\t%0", &addr);
+  return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
+}
+
 /* Emit the assembly instruction to load the thread pointer into DEST.
    Select between different tpidr_elN registers depending on -mtp= setting.  */
 
@@ -32823,6 +32852,93 @@ aarch64_libgcc_floating_mode_supported_p
 #undef TARGET_DOCUMENTATION_NAME
 #define TARGET_DOCUMENTATION_NAME "AArch64"
 
+/* Output the assembly for a KCFI checked call instruction.  */
+
+const char *
+aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands)
+{
+  /* KCFI is only supported in LP64 mode.  */
+  if (TARGET_ILP32)
+    {
+      sorry ("%<-fsanitize=kcfi%> is not supported for %<-mabi=ilp32%>");
+      return "";
+    }
+  /* Target register is operands[0].  */
+  rtx target_reg = operands[0];
+  gcc_assert (REG_P (target_reg));
+
+  /* Get KCFI type ID from operand[3].  */
+  uint32_t type_id = (uint32_t) INTVAL (operands[3]);
+
+  /* Calculate typeid offset from call target.  */
+  HOST_WIDE_INT offset = -(4 + kcfi_patchable_entry_prefix_nops);
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
+  rtx temp_operands[3];
+
+  /* Load actual type into w16 from memory at offset using ldur.  */
+  temp_operands[0] = gen_rtx_REG (SImode, R16_REGNUM);
+  temp_operands[1] = target_reg;
+  temp_operands[2] = GEN_INT (offset);
+  output_asm_insn ("ldur\t%w0, [%1, #%2]", temp_operands);
+
+  /* Load expected type low 16 bits into w17.  */
+  temp_operands[0] = gen_rtx_REG (SImode, R17_REGNUM);
+  temp_operands[1] = GEN_INT (type_id & 0xFFFF);
+  output_asm_insn ("mov\t%w0, #%1", temp_operands);
+
+  /* Load expected type high 16 bits into w17.  */
+  temp_operands[0] = gen_rtx_REG (SImode, R17_REGNUM);
+  temp_operands[1] = GEN_INT ((type_id >> 16) & 0xFFFF);
+  output_asm_insn ("movk\t%w0, #%1, lsl #16", temp_operands);
+
+  /* Compare types.  */
+  temp_operands[0] = gen_rtx_REG (SImode, R16_REGNUM);
+  temp_operands[1] = gen_rtx_REG (SImode, R17_REGNUM);
+  output_asm_insn ("cmp\t%w0, %w1", temp_operands);
+
+  /* Output conditional branch to call label.  */
+  fputs ("\tb.eq\t", asm_out_file);
+  assemble_name (asm_out_file, call_name);
+  fputc ('\n', asm_out_file);
+
+  /* Output trap label and BRK instruction.  */
+  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
+
+  /* Calculate and emit BRK with ESR encoding.  */
+  unsigned type_index = R17_REGNUM;
+  unsigned addr_index = REGNO (operands[0]) - R0_REGNUM;
+  unsigned esr_value = 0x8000 | ((type_index & 31) << 5) | (addr_index & 31);
+
+  temp_operands[0] = GEN_INT (esr_value);
+  output_asm_insn ("brk\t#%0", temp_operands);
+
+  /* Output call label.  */
+  ASM_OUTPUT_LABEL (asm_out_file, call_name);
+
+  /* Return appropriate call instruction based on SIBLING_CALL_P.  */
+  if (SIBLING_CALL_P (insn))
+    return aarch64_indirect_branch_asm (operands[0]);
+  else
+    return aarch64_indirect_call_asm (operands[0]);
+}
+
+#undef TARGET_KCFI_SUPPORTED
+#define TARGET_KCFI_SUPPORTED hook_bool_void_true
+
 struct gcc_target targetm = TARGET_INITIALIZER;
 
 #include "gt-aarch64.h"
diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.md
index fedbd4026a06..1a5abc142f50 100644
--- a/gcc/config/aarch64/aarch64.md
+++ b/gcc/config/aarch64/aarch64.md
@@ -1483,6 +1483,19 @@
   }"
 )
 
+;; KCFI indirect call
+(define_insn "*call_insn"
+  [(kcfi (call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand" "Ucr"))
+	       (match_operand 1 "" ""))
+	 (match_operand 3 "const_int_operand"))
+   (unspec:DI [(match_operand:DI 2 "const_int_operand")] UNSPEC_CALLEE_ABI)
+   (clobber (reg:DI LR_REGNUM))]
+  "!SIBLING_CALL_P (insn)"
+{
+  return aarch64_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")])
+
 (define_insn "*call_insn"
   [(call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand"))
 	 (match_operand 1 "" ""))
@@ -1510,6 +1523,20 @@
   }"
 )
 
+;; KCFI call with return value
+(define_insn "*call_value_insn"
+  [(set (match_operand 0 "" "")
+	(kcfi (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operand" "Ucr"))
+		    (match_operand 2 "" ""))
+	      (match_operand 4 "const_int_operand")))
+   (unspec:DI [(match_operand:DI 3 "const_int_operand")] UNSPEC_CALLEE_ABI)
+   (clobber (reg:DI LR_REGNUM))]
+  "!SIBLING_CALL_P (insn)"
+{
+  return aarch64_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "call")])
+
 (define_insn "*call_value_insn"
   [(set (match_operand 0 "" "")
 	(call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operand"))
@@ -1550,6 +1577,19 @@
   }
 )
 
+;; KCFI sibling call
+(define_insn "*sibcall_insn"
+  [(kcfi (call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand" "Ucs"))
+	       (match_operand 1 ""))
+	 (match_operand 3 "const_int_operand"))
+   (unspec:DI [(match_operand:DI 2 "const_int_operand")] UNSPEC_CALLEE_ABI)
+   (return)]
+  "SIBLING_CALL_P (insn)"
+{
+  return aarch64_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "branch")])
+
 (define_insn "*sibcall_insn"
   [(call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand" "Ucs, Usf"))
 	 (match_operand 1 ""))
@@ -1558,16 +1598,27 @@
   "SIBLING_CALL_P (insn)"
   {
     if (which_alternative == 0)
-      {
-	output_asm_insn ("br\\t%0", operands);
-	return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
-      }
+      return aarch64_indirect_branch_asm (operands[0]);
     return "b\\t%c0";
   }
   [(set_attr "type" "branch, branch")
    (set_attr "sls_length" "retbr,none")]
 )
 
+;; KCFI sibling call with return value
+(define_insn "*sibcall_value_insn"
+  [(set (match_operand 0 "")
+	(kcfi (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operand" "Ucs"))
+		    (match_operand 2 ""))
+	      (match_operand 4 "const_int_operand")))
+   (unspec:DI [(match_operand:DI 3 "const_int_operand")] UNSPEC_CALLEE_ABI)
+   (return)]
+  "SIBLING_CALL_P (insn)"
+{
+  return aarch64_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "branch")])
+
 (define_insn "*sibcall_value_insn"
   [(set (match_operand 0 "")
 	(call (mem:DI
@@ -1578,10 +1629,7 @@
   "SIBLING_CALL_P (insn)"
   {
     if (which_alternative == 0)
-      {
-	output_asm_insn ("br\\t%1", operands);
-	return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
-      }
+      return aarch64_indirect_branch_asm (operands[1]);
     return "b\\t%c1";
   }
   [(set_attr "type" "branch, branch")
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index bd84b7dd903f..972e8e76494f 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18425,6 +18425,20 @@ check-call bundle are considered ABI, as the Linux kernel may
 optionally rewrite these areas at boot time to mitigate detected CPU
 errata.
 
+On AArch64, KCFI type identifiers are emitted as a @code{.word ID}
+directive (a 32-bit constant) before the function entry.  AArch64's
+natural 4-byte instruction alignment eliminates the need for additional
+alignment NOPs.  When used with @option{-fpatchable-function-entry}, the
+type identifier is placed before any prefix NOPs.  The runtime check
+uses @code{x16} and @code{x17} as scratch registers.  Type mismatches
+trigger a @code{brk} instruction with an immediate value that encodes
+both the expected type register index and the target address register
+index in the format @code{0x8000 | (type_reg << 5) | addr_reg}.  This
+encoding is captured in the ESR (Exception Syndrome Register) when the
+trap is taken, allowing the kernel to identify both the KCFI violation
+and the involved registers for detailed diagnostics (eliminating the need
+for a separate @code{.kcfi_traps} section as used on x86_64).
+
 KCFI is intended primarily for kernel code and may not be suitable
 for user-space applications that rely on techniques incompatible
 with strict type checking of indirect calls.
-- 
2.34.1

