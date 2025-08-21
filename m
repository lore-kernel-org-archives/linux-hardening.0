Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5B2E8B9B
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761229; cv=none; b=bAYo4qT56WQSKPTpj809kM3tnPq0J9imfuhQj7E8wnAs7ByZcWluvsXdyvO9cZW3xFXa2GPCAfJQCQUi6Tx2jhg9d+gSFDSoq7mwt95MfxbAqBsiiIJ6KQjcioY9zMWEM4r/eub4K2/9SlA/3pcWBaGlG4383aLZNM4svKaU7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761229; c=relaxed/simple;
	bh=6ZLDyaCWRp//WLasPz5lXxLcd/zUh2gHu7s2KfhzANc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUtJcMSOycR1JsD8eYqBs4UV54RCSKW903WkxI6b7Or2lAICytwlSMGZRk7msc+GeZuo1/ZQpqP/e9g0Zp+7ZNVoCWS3YET825q7lZAx2IOom6EenVWQaERGKOFBQt1btmHwW0v6fjxLGchKbKw0VW2n1LUpgVMlTkPJoIeBPHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5rLkn2G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5rLkn2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407E1C19425;
	Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755761229;
	bh=6ZLDyaCWRp//WLasPz5lXxLcd/zUh2gHu7s2KfhzANc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5rLkn2GuCoj4fHnqGTpjytu7bHZXrXJFpocaIeuSEj0nkbit8dw8BkBnKod7hv5A
	 OOZuyXbFb1BKh4V0LWJg3Wxn0CIOxW+Twk6Qt4ZE0ZrYDmDsTK4lr/DKQ9sVmmxphG
	 htqZ+J/AJezyz1aTvpOdfj9S5PnzvHM8CgxX07KLKIrwF31TxlF83YS8ak91DetkiY
	 YPmjrqL/qccKiPwRpqmotdGbaataXQ7SvBGq/9udIrzg9pVeizJJfZRUQD1rwI6h/2
	 TWYLWi5L1UAF0lt9J77jyfsbsNgUWOSegfLIqwBQnpLtTnmaYOB+GrG9bx2h1ByN5J
	 s/dG08IdniWJA==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
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
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH 6/7] riscv: Add RISC-V Kernel Control Flow Integrity implementation
Date: Thu, 21 Aug 2025 00:26:39 -0700
Message-Id: <20250821072708.3109244-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821064202.work.893-kees@kernel.org>
References: <20250821064202.work.893-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement RISC-V-specific KCFI backend.

- Function preamble generation using .word directives for type ID storage
  at offset from function entry point (no prefix NOPs needed due to
  natural 4-byte instruction alignment).

- Scratch register allocation using t1/t2 (x6/x7) following RISC-V
  procedure call standard for temporary registers.

- Support for both regular calls (JALR) and sibling calls (JR) with
  appropriate register usage and jump instructions.

- Integration with .kcfi_traps section for debugger/runtime metadata
  (like x86_64).

- Atomic bundled KCFI check + call/jump sequences using UNSPECV_KCFI_CHECK
  to prevent optimizer separation and maintain security properties.

Assembly Code Pattern for RISC-V:
  lw      t1, -4(target_reg)        ; Load actual type ID from preamble
  lui     t2, %hi(expected_type)    ; Load expected type (upper 20 bits)
  addiw   t2, t2, %lo(expected_type) ; Add lower 12 bits (sign-extended)
  beq     t1, t2, .Lpass            ; Branch if types match
  .Ltrap: ebreak                    ; Environment break trap on mismatch
  .Lpass: jalr/jr target_reg        ; Execute validated indirect transfer

Build tested with Linux kernel ARCH=riscv (I am still building a proper
risc-v emulation setup). Run tested via userspace binaries.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/riscv/riscv-protos.h |   1 +
 gcc/config/riscv/riscv.cc       | 157 ++++++++++++++++++++++++++++++++
 gcc/config/riscv/riscv.md       |  49 ++++++++++
 gcc/doc/invoke.texi             |  13 +++
 4 files changed, 220 insertions(+)

diff --git a/gcc/config/riscv/riscv-protos.h b/gcc/config/riscv/riscv-protos.h
index 539321ff95b8..1d343c529934 100644
--- a/gcc/config/riscv/riscv-protos.h
+++ b/gcc/config/riscv/riscv-protos.h
@@ -126,6 +126,7 @@ extern bool riscv_split_64bit_move_p (rtx, rtx);
 extern void riscv_split_doubleword_move (rtx, rtx);
 extern const char *riscv_output_move (rtx, rtx);
 extern const char *riscv_output_return ();
+extern const char *riscv_output_kcfi_checked_call (uint32_t, HOST_WIDE_INT, bool);
 extern void riscv_declare_function_name (FILE *, const char *, tree);
 extern void riscv_declare_function_size (FILE *, const char *, tree);
 extern void riscv_asm_output_alias (FILE *, const tree, const tree);
diff --git a/gcc/config/riscv/riscv.cc b/gcc/config/riscv/riscv.cc
index 0a9fcef37029..5daa5427568d 100644
--- a/gcc/config/riscv/riscv.cc
+++ b/gcc/config/riscv/riscv.cc
@@ -81,6 +81,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "cgraph.h"
 #include "langhooks.h"
 #include "gimplify.h"
+#include "kcfi.h"
 
 /* This file should be included last.  */
 #include "target-def.h"
@@ -11156,6 +11157,9 @@ riscv_declare_function_name (FILE *stream, const char *name, tree fndecl)
 	    fprintf (stream, "\t# tune = %s\n", local_tune_str);
 	}
     }
+
+  /* Emit KCFI preamble for non-patchable functions.  */
+  kcfi_emit_preamble_if_needed (stream, fndecl, false, 0, name);
 }
 
 void
@@ -11418,6 +11422,147 @@ riscv_convert_vector_chunks (struct gcc_options *opts)
     return 1;
 }
 
+/* KCFI (Kernel Control Flow Integrity) support.  */
+
+/* Generate KCFI checked call RTL pattern following AArch64 approach. */
+static rtx
+riscv_kcfi_gen_checked_call (rtx call_insn, rtx target_reg, uint32_t expected_type,
+                             HOST_WIDE_INT prefix_nops)
+{
+  /* For RISC-V, we create an RTL bundle that combines the KCFI check
+     with the call instruction in an atomic sequence.  */
+
+  if (!REG_P (target_reg))
+    {
+      /* If not a register, load it into t1.  */
+      rtx temp = gen_rtx_REG (Pmode, T1_REGNUM);
+      emit_move_insn (temp, target_reg);
+      target_reg = temp;
+    }
+
+  /* Generate the bundled KCFI check + call pattern.  */
+  rtx pattern;
+  if (CALL_P (call_insn))
+    {
+      rtx call_pattern = PATTERN (call_insn);
+
+      /* Create labels used by both call and sibcall patterns.  */
+      rtx pass_label = gen_label_rtx ();
+      rtx trap_label = gen_label_rtx ();
+
+      /* Check if it's a sibling call.  */
+      if (find_reg_note (call_insn, REG_NORETURN, NULL_RTX)
+          || (GET_CODE (call_pattern) == PARALLEL
+              && GET_CODE (XVECEXP (call_pattern, 0, XVECLEN (call_pattern, 0) - 1)) == RETURN))
+        {
+          /* Generate sibling call bundle.  */
+          pattern = gen_riscv_kcfi_checked_sibcall (target_reg,
+                                                    gen_int_mode (expected_type, SImode),
+                                                    gen_int_mode (prefix_nops, SImode),
+                                                    pass_label,
+                                                    trap_label);
+        }
+      else
+        {
+          /* Generate regular call bundle.  */
+          pattern = gen_riscv_kcfi_checked_call (target_reg,
+                                                 gen_int_mode (expected_type, SImode),
+                                                 gen_int_mode (prefix_nops, SImode),
+                                                 pass_label,
+                                                 trap_label);
+        }
+    }
+  else
+    {
+      error ("KCFI: Expected call instruction");
+      gcc_unreachable ();
+    }
+
+  return pattern;
+}
+
+/* Add RISC-V specific register clobbers for KCFI instrumentation.  */
+static void
+riscv_kcfi_add_clobbers (rtx_insn *call_insn)
+{
+  /* Add t1/t2 clobbers so register allocator knows they'll be used.  */
+  rtx usage = CALL_INSN_FUNCTION_USAGE (call_insn);
+  clobber_reg (&usage, gen_rtx_REG (DImode, T1_REGNUM));
+  clobber_reg (&usage, gen_rtx_REG (DImode, T2_REGNUM));
+  CALL_INSN_FUNCTION_USAGE (call_insn) = usage;
+}
+
+/* Calculate prefix NOPs (RISC-V doesn't need additional NOPs).  */
+static int
+riscv_kcfi_calculate_prefix_nops (HOST_WIDE_INT prefix_nops ATTRIBUTE_UNUSED)
+{
+  /* RISC-V instructions are 4-byte aligned, no additional NOPs needed.  */
+  return 0;
+}
+
+/* Emit RISC-V type ID instruction.  */
+static void
+riscv_kcfi_emit_type_id_instruction (FILE *file, uint32_t type_id)
+{
+  /* Emit .word directive with type ID.  */
+  fprintf (file, "\t.word\t0x%08x\n", type_id);
+}
+
+/* Output KCFI checked call instruction sequence.  */
+const char *
+riscv_output_kcfi_checked_call (uint32_t expected_type, HOST_WIDE_INT prefix_nops, bool sibling_call)
+{
+  static char buf[512];
+  
+  /* Calculate offset for type ID load, accounting for prefix NOPs.  */
+  HOST_WIDE_INT offset = -(4 + prefix_nops);
+  
+  /* Generate unique labels.  */
+  static int label_counter = 0;
+  int pass_label_num = ++label_counter;
+  int trap_label_num = ++label_counter;
+  
+  /* Generate the KCFI check sequence:
+     lw      t1, -4(target_reg)           # Load actual type from function[-4]
+     lui     t2, %hi(expected_type_id)    # Load upper 20 bits of expected type
+     addiw   t2, t2, %lo(expected_type_id) # Add lower 12 bits (sign-extended)
+     beq     t1, t2, .Lpass               # Branch if types match
+     .Ltrap:
+     ebreak                               # Environment break (trap on mismatch)
+     .Lpass:
+     jalr    target_reg                   # Execute indirect function call
+  */
+  
+  /* Manually split expected_type as required by agentic/kcfi-riscv.md:
+     - Upper 20 bits for lui instruction
+     - Lower 12 bits for addiw instruction (sign-extended) */
+  uint32_t hi20 = (expected_type >> 12) & 0xFFFFF;  /* Upper 20 bits */
+  int32_t lo12 = ((int32_t)(expected_type << 20)) >> 20;  /* Lower 12 bits, sign-extended */
+
+  snprintf (buf, sizeof (buf),
+    "lw\tt1, %ld(%%0)\n"
+    "\tlui\tt2, %u\n"
+    "\taddiw\tt2, t2, %d\n"
+    "\tbeq\tt1, t2, .Lkcfi_pass_%d\n"
+    ".Lkcfi_trap_%d:\n"
+    "\tebreak\n"
+    "\t.pushsection\t.kcfi_traps,\"ao\",@progbits,.text\n"
+    ".Lkcfi_trap_entry_%d:\n"
+    "\t.word\t.Lkcfi_trap_%d - .Lkcfi_trap_entry_%d\n"
+    "\t.popsection\n"
+    ".Lkcfi_pass_%d:\n"
+    "\t%s\t%%0",
+    offset, hi20, lo12,
+    pass_label_num,
+    trap_label_num,
+    trap_label_num,
+    trap_label_num, trap_label_num,
+    pass_label_num,
+    sibling_call ? "jr" : "jalr");
+    
+  return buf;
+}
+
 /* 'Unpack' up the internal tuning structs and update the options
     in OPTS.  The caller must have set up selected_tune and selected_arch
     as all the other target-specific codegen decisions are
@@ -11525,6 +11670,7 @@ riscv_override_options_internal (struct gcc_options *opts)
       opts->x_flag_cf_protection
       = (cf_protection_level) (opts->x_flag_cf_protection | CF_SET);
     }
+
 }
 
 /* Implement TARGET_OPTION_OVERRIDE.  */
@@ -11715,6 +11861,16 @@ riscv_option_override (void)
 
   riscv_override_options_internal (&global_options);
 
+  /* Initialize KCFI hooks if KCFI is enabled.  */
+  if (flag_sanitize & SANITIZE_KCFI)
+    {
+      kcfi_target.gen_kcfi_checked_call = riscv_kcfi_gen_checked_call;
+      kcfi_target.add_kcfi_clobbers = riscv_kcfi_add_clobbers;
+      kcfi_target.calculate_prefix_nops = riscv_kcfi_calculate_prefix_nops;
+      kcfi_target.emit_type_id_instruction = riscv_kcfi_emit_type_id_instruction;
+      /* Note: mask_type_id is NULL - no masking needed for RISC-V.  */
+    }
+
   /* Save these options as the default ones in case we push and pop them later
      while processing functions with potential target attributes.  */
   target_option_default_node = target_option_current_node
@@ -15795,6 +15951,7 @@ synthesize_and (rtx operands[3])
 #define TARGET_VECTORIZE_BUILTIN_VECTORIZATION_COST \
   riscv_builtin_vectorization_cost
 
+
 #undef TARGET_VECTORIZE_CREATE_COSTS
 #define TARGET_VECTORIZE_CREATE_COSTS riscv_vectorize_create_costs
 
diff --git a/gcc/config/riscv/riscv.md b/gcc/config/riscv/riscv.md
index 578dd43441e2..6e9545e9d003 100644
--- a/gcc/config/riscv/riscv.md
+++ b/gcc/config/riscv/riscv.md
@@ -152,6 +152,9 @@
   ;; XTheadInt unspec
   UNSPECV_XTHEADINT_PUSH
   UNSPECV_XTHEADINT_POP
+
+  ;; KCFI unspec
+  UNSPECV_KCFI_CHECK
 ])
 
 (define_constants
@@ -4078,6 +4081,52 @@
   DONE;
 })
 
+;; KCFI checked call patterns
+
+(define_insn "riscv_kcfi_checked_call"
+  [(parallel [(call (mem:DI (match_operand:DI 0 "register_operand" "r"))
+                    (const_int 0))
+              (unspec:DI [(const_int 0)] UNSPEC_CALLEE_CC)
+              (unspec_volatile:DI [(match_operand:SI 1 "const_int_operand" "n")  ; type_id
+                                   (match_operand:SI 2 "const_int_operand" "n")  ; prefix_nops
+                                   (label_ref (match_operand 3))  ; pass label
+                                   (label_ref (match_operand 4))] ; trap label
+                                  UNSPECV_KCFI_CHECK)
+              (clobber (reg:DI RETURN_ADDR_REGNUM))
+              (clobber (reg:DI T1_REGNUM))  ; t1 - scratch for loaded type
+              (clobber (reg:DI T2_REGNUM))])] ; t2 - scratch for expected type
+  "flag_sanitize & SANITIZE_KCFI"
+  "*
+  {
+    uint32_t type_id = INTVAL (operands[1]);
+    HOST_WIDE_INT prefix_nops = INTVAL (operands[2]);
+    return riscv_output_kcfi_checked_call (type_id, prefix_nops, false);
+  }"
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
+(define_insn "riscv_kcfi_checked_sibcall"
+  [(parallel [(call (mem:DI (match_operand:DI 0 "register_operand" "r"))
+                    (const_int 0))
+              (unspec:DI [(const_int 0)] UNSPEC_CALLEE_CC)
+              (unspec_volatile:DI [(match_operand:SI 1 "const_int_operand" "n")  ; type_id
+                                   (match_operand:SI 2 "const_int_operand" "n")  ; prefix_nops
+                                   (label_ref (match_operand 3))  ; pass label
+                                   (label_ref (match_operand 4))] ; trap label
+                                  UNSPECV_KCFI_CHECK)
+              (return)
+              (clobber (reg:DI T1_REGNUM))  ; t1 - scratch for loaded type
+              (clobber (reg:DI T2_REGNUM))])] ; t2 - scratch for expected type
+  "flag_sanitize & SANITIZE_KCFI"
+  "*
+  {
+    uint32_t type_id = INTVAL (operands[1]);
+    HOST_WIDE_INT prefix_nops = INTVAL (operands[2]);
+    return riscv_output_kcfi_checked_call (type_id, prefix_nops, true);
+  }"
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
 (define_insn "nop"
   [(const_int 0)]
   ""
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 161c7024f842..f82d0464590d 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18350,6 +18350,19 @@ trap is taken, allowing the kernel to identify both the KCFI violation
 and the involved registers for detailed diagnostics (eliminating the need
 for a separate @code{.kcfi_traps} section as used on x86_64).
 
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

