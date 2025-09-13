Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2F2BDC09
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805846; cv=none; b=EDhhw8R/CoNfTcNB9T6/4zIB8iFdKepjy5gj8DV0sOqueSQJcL2C+vfULIzxOpvZq0asCbpBqF7Q1QFTA/IwSX9Ak7USlXk9iJARA6IbsauRkSGmCJn1Ub0olkoNMgMB1K18+agfmsNt0imh4QZAIGZkoOG3Z2vSsdYWqr3hxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805846; c=relaxed/simple;
	bh=RpxjWGib2gzsQhT+AzyGAzu5FT+XsTIWFWtZ0hmylvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RMffqjRGTLSZ0t+NwobyT7OM72U9Fu/dixkDsuuDOJTR+aYTlGR/8USBMm2rsHcx4mqAJIsxauRQ2lCaJGS5xXQu32YHyC0c/eIELrT5maJe73RR+PerBooGFJQpziQShYCmiC3MWm8Ncia4i6bt2V/Epph51bvHSdnIoOadz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7yqq5MS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7yqq5MS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7C1C4CEFC;
	Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757805845;
	bh=RpxjWGib2gzsQhT+AzyGAzu5FT+XsTIWFWtZ0hmylvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7yqq5MSBbV6+/j5yGSOyOY4W+YttBAcm6kTryzrA11dcyFUZlnby0BM106AUVWUS
	 6IjHL9/dlKB5jsdlc7nBkPAUA5dXA4Di/N+iPEzymP4QZAciY+xrEH/KwLxJy87Opa
	 12xf/Os/qRsPl6nkuYX69kZ66e/nfqBmdHl7Qetj7u04/vifLH7siJ8jP33W8K1u0b
	 bbafq/X7ybL761Xf/MegVt+a0d1ZEkWBJVnb2VofTqZ806BQ/6c1FpV6XWYYH491DI
	 jmo1bpR3Z7R/YibyV191Fbd3Vtpr+1nWuqs3o4ilEv5CROpjbGHvEZ/3Rb3kRPPuMY
	 8tihoTgwacUUQ==
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
Subject: [PATCH v3 5/7] arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
Date: Sat, 13 Sep 2025 16:24:01 -0700
Message-Id: <20250913232404.2690431-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913231256.make.519-kees@kernel.org>
References: <20250913231256.make.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14102; i=kees@kernel.org; h=from:subject; bh=RpxjWGib2gzsQhT+AzyGAzu5FT+XsTIWFWtZ0hmylvs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlH/wre5LzcLBZeXjbL7sSq69pV/w3uMqaE/b8u+0prg v+kiheVHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNZ3cbI8P0z0wyv8zZvpJsC dN1+RwbGTBFMifrqfsfCn0/1VOKjWwx/OB9GmOTktUp9eSSi+HrN2RzNLa38L85teF/B/8viZxc fBwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Implement ARM 32-bit KCFI backend supporting ARMv7+:

- Use movw/movt instructions for 32-bit immediate loading.

- Trap debugging through UDF instruction immediate encoding following
  AArch64 BRK pattern for encoding registers with useful contents.

- Scratch register allocation using r0/r1 following ARM procedure call
  standard for caller-saved temporary registers, though they get
  stack spilled due to register pressure. IP (r12) not usable here
  because register allocator regularly uses it as the branch target
  register.

Assembly Code Pattern for ARM 32-bit:
  push {r0, r1}                ; Spill r0, r1
  ldr  r0, [target, #-4]       ; Load actual type ID from preamble
  movw r1, #type_id_low        ; Load expected type (lower 16 bits)
  movt r1, #type_id_high       ; Load upper 16 bits with top instruction
  cmp  r0, r1                  ; Compare type IDs directly
  pop [r0, r1]                 ; Reload r0, r1
  beq  .Lkcfi_call             ; Branch if typeids match
  .Lkcfi_trap: udf #udf_value  ; Undefined instruction trap with encoding
  .Lkcfi_call: blx/bx target   ; Execute validated indirect transfer

UDF Immediate Encoding (following AArch64 ESR pattern):
- UDF instruction immediate encoding format:
  0x8000 | ((ExpectedTypeReg & 31) << 5) | (TargetAddrReg & 31)
  - ExpectedTypeReg indicates which register contains expected type (R12 = 12)
  - TargetAddrReg indicates which register contains target address (0-15)
  - Example: udf #33154 (0x817A) = expected type in R12, target address in R2

Build and run tested with Linux kernel ARCH=arm.

gcc/ChangeLog:

	config/arm/arm-protos.h: Declare KCFI helpers.
	config/arm/arm.cc (arm_maybe_wrap_call_with_kcfi): New function.
	(arm_maybe_wrap_call_value_with_kcfi): New function.
	(arm_output_kcfi_insn): Emit KCFI assembly.
	config/arm/arm.md: Add KCFI RTL patterns and hook expansion.
	doc/invoke.texi: Document arm32 nuances.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/arm/arm-protos.h |   4 +
 gcc/config/arm/arm.cc       | 146 ++++++++++++++++++++++++++++++++++++
 gcc/config/arm/arm.md       |  62 +++++++++++++++
 gcc/doc/invoke.texi         |  17 +++++
 4 files changed, 229 insertions(+)

diff --git a/gcc/config/arm/arm-protos.h b/gcc/config/arm/arm-protos.h
index ff7e7658f912..ad3dc522e2b9 100644
--- a/gcc/config/arm/arm-protos.h
+++ b/gcc/config/arm/arm-protos.h
@@ -607,6 +607,10 @@ void arm_initialize_isa (sbitmap, const enum isa_feature *);
 
 const char * arm_gen_far_branch (rtx *, int, const char * , const char *);
 
+rtx arm_maybe_wrap_call_with_kcfi (rtx, rtx);
+rtx arm_maybe_wrap_call_value_with_kcfi (rtx, rtx);
+const char *arm_output_kcfi_insn (rtx_insn *, rtx *);
+
 bool arm_mve_immediate_check(rtx, machine_mode, bool);
 
 opt_machine_mode arm_mve_data_mode (scalar_mode, poly_uint64);
diff --git a/gcc/config/arm/arm.cc b/gcc/config/arm/arm.cc
index 8b951f3d4a67..d06183fd2d53 100644
--- a/gcc/config/arm/arm.cc
+++ b/gcc/config/arm/arm.cc
@@ -77,6 +77,8 @@
 #include "aarch-common-protos.h"
 #include "machmode.h"
 #include "arm-builtins.h"
+#include "kcfi.h"
+#include "flags.h"
 
 /* This file should be included last.  */
 #include "target-def.h"
@@ -35803,6 +35805,150 @@ arm_mode_base_reg_class (machine_mode mode)
   return MODE_BASE_REG_REG_CLASS (mode);
 }
 
+/* Apply KCFI wrapping to call pattern if needed.  */
+
+rtx
+arm_maybe_wrap_call_with_kcfi (rtx pat, rtx addr)
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
+arm_maybe_wrap_call_value_with_kcfi (rtx pat, rtx addr)
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
+arm_output_kcfi_insn (rtx_insn *insn, rtx *operands)
+{
+  /* KCFI requires movw/movt instructions for type ID loading.  */
+  if (!TARGET_HAVE_MOVT)
+    sorry ("%<-fsanitize=kcfi%> requires movw/movt instructions (ARMv7 or later)");
+
+  /* KCFI type id.  */
+  uint32_t type_id = INTVAL (operands[2]);
+
+  /* Calculate typeid offset from call target.  */
+  HOST_WIDE_INT offset = -(4 + kcfi_patchable_entry_prefix_nops);
+
+  /* Calculate trap immediate.  */
+  unsigned addr_reg_num = REGNO (operands[0]);
+  unsigned udf_immediate = 0x8000 | (0x1F << 5) | (addr_reg_num & 31);
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
+  /* Create memory operand for the type load.  */
+  rtx mem_op = gen_rtx_MEM (SImode,
+			    gen_rtx_PLUS (SImode, operands[0],
+					  GEN_INT (offset)));
+  rtx temp_operands[6];
+
+  /* Spill r0 and r1 to stack.  */
+  output_asm_insn ("push\t{r0, r1}", NULL);
+
+  /* Load actual type from memory using r0.  */
+  temp_operands[0] = gen_rtx_REG (SImode, R0_REGNUM);
+  temp_operands[1] = mem_op;
+  output_asm_insn ("ldr\t%0, %1", temp_operands);
+
+  /* Load expected type low 16 bits into r1.  */
+  temp_operands[0] = gen_rtx_REG (SImode, R1_REGNUM);
+  temp_operands[1] = GEN_INT (type_id & 0xFFFF);
+  output_asm_insn ("movw\t%0, %1", temp_operands);
+
+  /* Load expected type high 16 bits into r1.  */
+  temp_operands[0] = gen_rtx_REG (SImode, R1_REGNUM);
+  temp_operands[1] = GEN_INT ((type_id >> 16) & 0xFFFF);
+  output_asm_insn ("movt\t%0, %1", temp_operands);
+
+  /* Compare types in r0 and r1.  */
+  temp_operands[0] = gen_rtx_REG (SImode, R0_REGNUM);
+  temp_operands[1] = gen_rtx_REG (SImode, R1_REGNUM);
+  output_asm_insn ("cmp\t%0, %1", temp_operands);
+
+  /* Restore r0 and r1 from stack.  */
+  output_asm_insn ("pop\t{r0, r1}", NULL);
+
+  /* Output conditional branch to call label.  */
+  fputs ("\tbeq\t", asm_out_file);
+  assemble_name (asm_out_file, call_name);
+  fputc ('\n', asm_out_file);
+
+  /* Output trap label and UDF instruction.  */
+  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
+  temp_operands[0] = GEN_INT (udf_immediate);
+  output_asm_insn ("udf\t%0", temp_operands);
+
+  /* Output pass/call label.  */
+  ASM_OUTPUT_LABEL (asm_out_file, call_name);
+
+  /* Handle calls to lr using ip (which may be clobbered in subr anyway).  */
+  if (REGNO (operands[0]) == LR_REGNUM)
+    {
+      operands[0] = gen_rtx_REG (SImode, IP_REGNUM);
+      output_asm_insn ("mov\t%0, lr", operands);
+    }
+
+  /* Call or tail call instruction.  */
+  if (SIBLING_CALL_P (insn))
+    output_asm_insn ("bx\t%0", operands);
+  else
+    output_asm_insn ("blx\t%0", operands);
+
+  return "";
+}
+
+#undef TARGET_KCFI_SUPPORTED
+#define TARGET_KCFI_SUPPORTED hook_bool_void_true
+
 #undef TARGET_DOCUMENTATION_NAME
 #define TARGET_DOCUMENTATION_NAME "ARM"
 
diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
index 422ae549b65b..646eb0d757b1 100644
--- a/gcc/config/arm/arm.md
+++ b/gcc/config/arm/arm.md
@@ -8629,6 +8629,7 @@
     else
       {
 	pat = gen_call_internal (operands[0], operands[1], operands[2]);
+	pat = arm_maybe_wrap_call_with_kcfi (pat, XEXP (operands[0], 0));
 	arm_emit_call_insn (pat, XEXP (operands[0], 0), false);
       }
 
@@ -8687,6 +8688,20 @@
   }
 )
 
+;; KCFI indirect call - KCFI wraps just the call pattern
+(define_insn "*kcfi_call_reg"
+  [(kcfi (call (mem:SI (match_operand:SI 0 "s_register_operand" "r"))
+	       (match_operand 1 "" ""))
+	 (match_operand 2 "const_int_operand"))
+   (use (match_operand 3 "" ""))
+   (clobber (reg:SI LR_REGNUM))]
+  "TARGET_32BIT && !SIBLING_CALL_P (insn) && arm_ccfsm_state == 0"
+{
+  return arm_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "36")])
+
 (define_insn "*call_reg_armv5"
   [(call (mem:SI (match_operand:SI 0 "s_register_operand" "r"))
          (match_operand 1 "" ""))
@@ -8753,6 +8768,7 @@
       {
 	pat = gen_call_value_internal (operands[0], operands[1],
 				       operands[2], operands[3]);
+	pat = arm_maybe_wrap_call_value_with_kcfi (pat, XEXP (operands[1], 0));
 	arm_emit_call_insn (pat, XEXP (operands[1], 0), false);
       }
 
@@ -8799,6 +8815,21 @@
       }
   }")
 
+;; KCFI indirect call_value - KCFI wraps just the call pattern
+(define_insn "*kcfi_call_value_reg"
+  [(set (match_operand 0 "" "")
+	(kcfi (call (mem:SI (match_operand:SI 1 "s_register_operand" "r"))
+		    (match_operand 2 "" ""))
+	      (match_operand 3 "const_int_operand")))
+   (use (match_operand 4 "" ""))
+   (clobber (reg:SI LR_REGNUM))]
+  "TARGET_32BIT && !SIBLING_CALL_P (insn) && arm_ccfsm_state == 0"
+{
+  return arm_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "36")])
+
 (define_insn "*call_value_reg_armv5"
   [(set (match_operand 0 "" "")
         (call (mem:SI (match_operand:SI 1 "s_register_operand" "r"))
@@ -8901,6 +8932,7 @@
       operands[2] = const0_rtx;
 
     pat = gen_sibcall_internal (operands[0], operands[1], operands[2]);
+    pat = arm_maybe_wrap_call_with_kcfi (pat, XEXP (operands[0], 0));
     arm_emit_call_insn (pat, operands[0], true);
     DONE;
   }"
@@ -8935,11 +8967,26 @@
 
     pat = gen_sibcall_value_internal (operands[0], operands[1],
                                       operands[2], operands[3]);
+    pat = arm_maybe_wrap_call_value_with_kcfi (pat, XEXP (operands[1], 0));
     arm_emit_call_insn (pat, operands[1], true);
     DONE;
   }"
 )
 
+;; KCFI sibling call - KCFI wraps just the call pattern
+(define_insn "*kcfi_sibcall_insn"
+  [(kcfi (call (mem:SI (match_operand:SI 0 "s_register_operand" "Cs"))
+	       (match_operand 1 "" ""))
+	 (match_operand 2 "const_int_operand"))
+   (return)
+   (use (match_operand 3 "" ""))]
+  "TARGET_32BIT && SIBLING_CALL_P (insn) && arm_ccfsm_state == 0"
+{
+  return arm_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "36")])
+
 (define_insn "*sibcall_insn"
  [(call (mem:SI (match_operand:SI 0 "call_insn_operand" "Cs, US"))
 	(match_operand 1 "" ""))
@@ -8960,6 +9007,21 @@
   [(set_attr "type" "call")]
 )
 
+;; KCFI sibling call with return value - KCFI wraps just the call pattern
+(define_insn "*kcfi_sibcall_value_insn"
+  [(set (match_operand 0 "" "")
+	(kcfi (call (mem:SI (match_operand:SI 1 "s_register_operand" "Cs"))
+		    (match_operand 2 "" ""))
+	      (match_operand 3 "const_int_operand")))
+   (return)
+   (use (match_operand 4 "" ""))]
+  "TARGET_32BIT && SIBLING_CALL_P (insn) && arm_ccfsm_state == 0"
+{
+  return arm_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "36")])
+
 (define_insn "*sibcall_value_insn"
  [(set (match_operand 0 "" "")
        (call (mem:SI (match_operand:SI 1 "call_insn_operand" "Cs,US"))
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 972e8e76494f..dfaec475d2e1 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18439,6 +18439,23 @@ trap is taken, allowing the kernel to identify both the KCFI violation
 and the involved registers for detailed diagnostics (eliminating the need
 for a separate @code{.kcfi_traps} section as used on x86_64).
 
+On ARM 32-bit, KCFI type identifiers are emitted as a @code{.word ID}
+directive (a 32-bit constant) before the function entry.  ARM's
+natural 4-byte instruction alignment eliminates the need for additional
+alignment NOPs.  When used with @option{-fpatchable-function-entry}, the
+type identifier is placed before any prefix NOPs.  The runtime check
+preserves argument registers @code{r0} and @code{r1} using @code{push}
+and @code{pop} instructions, then uses them as scratch registers for
+the type comparison.  The expected type is loaded using @code{movw} and
+@code{movt} instruction pairs for 32-bit immediate values.  Type mismatches
+trigger a @code{udf} instruction with an immediate value that encodes
+both the expected type register index and the target address register
+index in the format @code{0x8000 | (type_reg << 5) | addr_reg}.  This
+encoding is captured in the UDF immediate field when the trap is taken,
+allowing the kernel to identify both the KCFI violation and the involved
+registers for detailed diagnostics (eliminating the need for a separate
+@code{.kcfi_traps} section as used on x86_64).
+
 KCFI is intended primarily for kernel code and may not be suitable
 for user-space applications that rely on techniques incompatible
 with strict type checking of indirect calls.
-- 
2.34.1

