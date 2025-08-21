Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE62E8DFE
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761230; cv=none; b=cNYMJ1hrAJDzsRieac4ttQODXkGtKHTkJa34M/5uawicrD7KFOZJPun9aRhAiLE5toXJhb0AW5SDVnfsxrPnRP5bs/jcdQSCMLLZrIbdHyO8Lvjx46hfXjGswQ4TqmN5evXqkZn1mbw3rpSNedjm1Sk47Toyqxozb77VSUUZIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761230; c=relaxed/simple;
	bh=Ao+YEZjte/ooTw7ckrO+gLxAyyReuAbbeboqQA6Emuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHN+S4TpvE75MigSfh+JHJdh2/Vfd1vc69VGNJZ5TSJDd4uQ+VA5oZfAYns6SGC/fGkCXAtqjAjbb4IerU0roSvKyqFnJASSM5QB7yzQRqE5+/FIOidMu3SpE3ZGNcU7uf1ZzYvAseXN4rS51PmIZ13gW1DFSPEyvVctb/U3kfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttj+aglD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttj+aglD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440BDC2BC87;
	Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755761229;
	bh=Ao+YEZjte/ooTw7ckrO+gLxAyyReuAbbeboqQA6Emuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttj+aglDl2IWDP2GXYxfZkHU73yj3ym1ksyK00lhYdggS7ZaQWrbKtXWj0nwn0DCa
	 9PpQ106GkpuqwkjS0VZX6r3Fj1t+eeMAss6uA0GGku0y7/LtNL7fyHvtN7WjyKmiCl
	 1tPDoHaC7IgHM8+MlAKPlVW8NFaJHWTemRnpKlT8LQEF71AHL3ApUdOrrlXNafxszV
	 izLdviSupeS74L0dikckjpPzC0rRABhbReacggTyZNmdJOaC9y/EOxKfACEWj9im9m
	 ZKRnNYoGYGJvTxa4kWCTApxokSQOYe9q5QlSBfzdf6aGM++Xonvo2SdI7qMV0XMwpO
	 NKsKKH/I+nujQ==
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
Subject: [RFC PATCH 5/7] aarch64: Add AArch64 Kernel Control Flow Integrity implementation
Date: Thu, 21 Aug 2025 00:26:38 -0700
Message-Id: <20250821072708.3109244-5-kees@kernel.org>
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

Implement AArch64-specific KCFI backend.

- Function preamble generation using .word directives for type ID storage
  at offset from function entry point (no prefix NOPs needed due to
  4-byte instruction alignment).

- Trap debugging through ESR (Exception Syndrome Register) encoding
  in BRK instruction immediate values for precise failure analysis.

- Scratch register allocation using w16/w17 (x16/x17) following
  AArch64 procedure call standard for intra-procedure-call registers.

- Support for both regular calls (BLR) and sibling calls (BR) with
  appropriate register usage and jump instructions.

- Atomic bundled KCFI check + call/branch sequences using UNSPECV_KCFI_CHECK
  to prevent optimizer separation and maintain security properties.

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

Like x86, the callback initialization in aarch64_override_options()
seem hacky. Is there a better place for this?

Build and run tested with Linux kernel ARCH=arm64.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/aarch64/aarch64-protos.h |   4 +
 gcc/config/aarch64/aarch64.cc       | 112 +++++++++++++++++++++++
 gcc/config/aarch64/aarch64.md       | 137 ++++++++++++++++++++++++++++
 gcc/doc/invoke.texi                 |  14 +++
 4 files changed, 267 insertions(+)

diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aarch64-protos.h
index 38c307cdc3a6..ff235305fbc1 100644
--- a/gcc/config/aarch64/aarch64-protos.h
+++ b/gcc/config/aarch64/aarch64-protos.h
@@ -1280,4 +1280,8 @@ extern bool aarch64_gcs_enabled ();
 extern unsigned aarch64_data_alignment (const_tree exp, unsigned align);
 extern unsigned aarch64_stack_alignment (const_tree exp, unsigned align);
 
+/* KCFI support.  */
+extern void aarch64_kcfi_init (void);
+extern void kcfi_emit_trap_with_section (FILE *file, rtx trap_label_rtx);
+
 #endif /* GCC_AARCH64_PROTOS_H */
diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.cc
index f4a2062b042a..fe5fbecb59b6 100644
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
@@ -19437,6 +19438,9 @@ aarch64_override_options (void)
 
   aarch64_override_options_internal (&global_options);
 
+  /* Initialize KCFI target hooks for AArch64.  */
+  aarch64_kcfi_init ();
+
   /* Save these options as the default ones in case we push and pop them later
      while processing functions with potential target attributes.  */
   target_option_default_node = target_option_current_node
@@ -25473,6 +25477,9 @@ aarch64_declare_function_name (FILE *stream, const char* name,
 
   aarch64_asm_output_variant_pcs (stream, fndecl, name);
 
+  /* Emit KCFI preamble for non-patchable functions.  */
+  kcfi_emit_preamble_if_needed (stream, fndecl, false, 0, name);
+
   /* Don't forget the type directive for ELF.  */
   ASM_OUTPUT_TYPE_DIRECTIVE (stream, name, "function");
   ASM_OUTPUT_FUNCTION_LABEL (stream, name, fndecl);
@@ -32706,6 +32713,111 @@ aarch64_libgcc_floating_mode_supported_p
 #undef TARGET_DOCUMENTATION_NAME
 #define TARGET_DOCUMENTATION_NAME "AArch64"
 
+
+/* AArch64 doesn't need prefix NOPs (instructions are already 4-byte aligned) */
+static int
+aarch64_kcfi_calculate_prefix_nops (HOST_WIDE_INT prefix_nops ATTRIBUTE_UNUSED)
+{
+  /* AArch64 instructions are 4-byte aligned, no prefix NOPs needed for KCFI preamble.  */
+  return 0;
+}
+
+/* Emit AArch64-specific type ID instruction.  */
+static void
+aarch64_kcfi_emit_type_id_instruction (FILE *file, uint32_t type_id)
+{
+  /* Emit type ID as a 32-bit word.  */
+  fprintf (file, "\t.word 0x%08x\n", type_id);
+}
+
+
+
+/* Generate AArch64 KCFI checked call bundle.  */
+static rtx
+aarch64_kcfi_gen_checked_call (rtx call_insn, rtx target_reg, uint32_t expected_type,
+			       HOST_WIDE_INT prefix_nops)
+{
+  /* For AArch64, we create an RTL bundle that combines the KCFI check
+     with the call instruction in an atomic sequence.  */
+
+  if (!REG_P (target_reg))
+    {
+      /* If not a register, load it into x16.  */
+      rtx temp = gen_rtx_REG (Pmode, 16);
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
+	  || (GET_CODE (call_pattern) == PARALLEL
+	      && GET_CODE (XVECEXP (call_pattern, 0, XVECLEN (call_pattern, 0) - 1)) == RETURN))
+	{
+	  /* Generate sibling call bundle.  */
+	  pattern = gen_aarch64_kcfi_checked_sibcall (target_reg,
+						      gen_int_mode (expected_type, SImode),
+						      gen_int_mode (prefix_nops, SImode),
+						      pass_label,
+						      trap_label);
+	}
+      else
+	{
+	  /* Generate regular call bundle.  */
+	  pattern = gen_aarch64_kcfi_checked_call (target_reg,
+						   gen_int_mode (expected_type, SImode),
+						   gen_int_mode (prefix_nops, SImode),
+						   pass_label,
+						   trap_label);
+	}
+    }
+  else
+    {
+      error ("KCFI: Expected call instruction");
+      return NULL_RTX;
+    }
+
+  return pattern;
+}
+
+/* Add AArch64-specific register clobbers for KCFI calls.  */
+static void
+aarch64_kcfi_add_clobbers (rtx_insn *call_insn)
+{
+  /* AArch64 KCFI uses w16 and w17 (x16 and x17) as scratch registers.  */
+  rtx usage = CALL_INSN_FUNCTION_USAGE (call_insn);
+
+  /* Add w16 (x16) clobber.  */
+  clobber_reg (&usage, gen_rtx_REG (SImode, 16));
+
+  /* Add w17 (x17) clobber.  */
+  clobber_reg (&usage, gen_rtx_REG (SImode, 17));
+
+  CALL_INSN_FUNCTION_USAGE (call_insn) = usage;
+}
+
+/* Initialize AArch64 KCFI target hooks.  */
+void
+aarch64_kcfi_init (void)
+{
+  if (flag_sanitize & SANITIZE_KCFI)
+    {
+      kcfi_target.gen_kcfi_checked_call = aarch64_kcfi_gen_checked_call;
+      kcfi_target.add_kcfi_clobbers = aarch64_kcfi_add_clobbers;
+      kcfi_target.calculate_prefix_nops = aarch64_kcfi_calculate_prefix_nops;
+      kcfi_target.emit_type_id_instruction = aarch64_kcfi_emit_type_id_instruction;
+    }
+}
+
 struct gcc_target targetm = TARGET_INITIALIZER;
 
 #include "gt-aarch64.h"
diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.md
index a4ae6859da01..28f9aa651519 100644
--- a/gcc/config/aarch64/aarch64.md
+++ b/gcc/config/aarch64/aarch64.md
@@ -416,6 +416,7 @@
     UNSPECV_TCANCEL		; Represent transaction cancel.
     UNSPEC_RNDR			; Represent RNDR
     UNSPEC_RNDRRS		; Represent RNDRRS
+    UNSPECV_KCFI_CHECK		; Represent KCFI check bundled with call
   ]
 )
 
@@ -1342,6 +1343,142 @@
   "brk #1000"
   [(set_attr "type" "trap")])
 
+;; KCFI bundled check and call patterns
+;; These combine the KCFI check with the call in an atomic sequence
+
+(define_insn "aarch64_kcfi_checked_call"
+  [(parallel [(call (mem:DI (match_operand:DI 0 "register_operand" "r"))
+                    (const_int 0))
+              (unspec:DI [(const_int 0)] UNSPEC_CALLEE_ABI)
+              (unspec_volatile:DI [(match_operand:SI 1 "const_int_operand" "n")  ; type_id
+                                   (match_operand:SI 2 "const_int_operand" "n")  ; prefix_nops
+                                   (label_ref (match_operand 3))  ; pass label
+                                   (label_ref (match_operand 4))] ; trap label
+                                  UNSPECV_KCFI_CHECK)
+              (clobber (reg:DI LR_REGNUM))
+              (clobber (reg:SI 16))  ; w16 - scratch for loaded type
+              (clobber (reg:SI 17))])] ; w17 - scratch for expected type
+  "flag_sanitize & SANITIZE_KCFI"
+  "*
+  {
+    uint32_t type_id = INTVAL (operands[1]);
+    HOST_WIDE_INT prefix_nops = INTVAL (operands[2]);
+    HOST_WIDE_INT offset = -(4 + prefix_nops);
+
+    /* AArch64 KCFI check sequence:
+       1. Load actual type from function preamble
+       2. Load expected type
+       3. Compare and branch if equal
+       4. Trap if mismatch
+       5. Call target.  */
+
+    static char ldur_buffer[64];
+    sprintf (ldur_buffer, \"ldur\\tw16, [%%0, #%ld]\", offset);
+    output_asm_insn (ldur_buffer, operands);
+
+    /* Load expected type - may need multiple instructions for large constants.  */
+    if ((type_id & 0xffff0000) == 0)
+      {
+        static char mov_buffer[64];
+        sprintf (mov_buffer, \"mov\\tw17, #%u\", type_id);
+        output_asm_insn (mov_buffer, operands);
+      }
+    else
+      {
+        static char mov_buffer[64], movk_buffer[64];
+        sprintf (mov_buffer, \"mov\\tw17, #%u\", type_id & 0xffff);
+        output_asm_insn (mov_buffer, operands);
+        sprintf (movk_buffer, \"movk\\tw17, #%u, lsl #16\", (type_id >> 16) & 0xffff);
+        output_asm_insn (movk_buffer, operands);
+      }
+
+    output_asm_insn (\"cmp\\tw16, w17\", operands);
+    output_asm_insn (\"b.eq\\t%l3\", operands);
+
+    /* Generate unique trap ID and emit trap.  */
+    output_asm_insn (\"%l4:\", operands);
+
+    /* Calculate and emit BRK with ESR encoding.  */
+    unsigned type_index = 17;  /* w17 contains expected type.  */
+    unsigned addr_index = REGNO (operands[0]) - R0_REGNUM;
+    unsigned esr_value = 0x8000 | ((type_index & 31) << 5) | (addr_index & 31);
+
+    static char brk_buffer[32];
+    sprintf (brk_buffer, \"brk\\t#%u\", esr_value);
+    output_asm_insn (brk_buffer, operands);
+
+    output_asm_insn (\"%l3:\", operands);
+    output_asm_insn (\"\\tblr\\t%0\", operands);
+
+    return \"\";
+  }"
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
+(define_insn "aarch64_kcfi_checked_sibcall"
+  [(parallel [(call (mem:DI (match_operand:DI 0 "register_operand" "r"))
+                    (const_int 0))
+              (unspec:DI [(const_int 0)] UNSPEC_CALLEE_ABI)
+              (unspec_volatile:DI [(match_operand:SI 1 "const_int_operand" "n")  ; type_id
+                                   (match_operand:SI 2 "const_int_operand" "n")  ; prefix_nops
+                                   (label_ref (match_operand 3))  ; pass label
+                                   (label_ref (match_operand 4))] ; trap label
+                                  UNSPECV_KCFI_CHECK)
+              (return)
+              (clobber (reg:SI 16))  ; w16 - scratch for loaded type
+              (clobber (reg:SI 17))])] ; w17 - scratch for expected type
+  "flag_sanitize & SANITIZE_KCFI"
+  "*
+  {
+    uint32_t type_id = INTVAL (operands[1]);
+    HOST_WIDE_INT prefix_nops = INTVAL (operands[2]);
+    HOST_WIDE_INT offset = -(4 + prefix_nops);
+
+    /* AArch64 KCFI check sequence for sibling calls.  */
+
+    static char ldur_buffer[64];
+    sprintf (ldur_buffer, \"ldur\\tw16, [%%0, #%ld]\", offset);
+    output_asm_insn (ldur_buffer, operands);
+
+    /* Load expected type.  */
+    if ((type_id & 0xffff0000) == 0)
+      {
+        static char mov_buffer[64];
+        sprintf (mov_buffer, \"mov\\tw17, #%u\", type_id);
+        output_asm_insn (mov_buffer, operands);
+      }
+    else
+      {
+        static char mov_buffer[64], movk_buffer[64];
+        sprintf (mov_buffer, \"mov\\tw17, #%u\", type_id & 0xffff);
+        output_asm_insn (mov_buffer, operands);
+        sprintf (movk_buffer, \"movk\\tw17, #%u, lsl #16\", (type_id >> 16) & 0xffff);
+        output_asm_insn (movk_buffer, operands);
+      }
+
+    output_asm_insn (\"cmp\\tw16, w17\", operands);
+    output_asm_insn (\"b.eq\\t%l3\", operands);
+
+    /* Generate unique trap ID and emit trap.  */
+    output_asm_insn (\"%l4:\", operands);
+
+    /* Calculate and emit BRK with ESR encoding.  */
+    unsigned type_index = 17;  /* w17 contains expected type.  */
+    unsigned addr_index = REGNO (operands[0]) - R0_REGNUM;
+    unsigned esr_value = 0x8000 | ((type_index & 31) << 5) | (addr_index & 31);
+
+    static char brk_buffer[32];
+    sprintf (brk_buffer, \"brk\\t#%u\", esr_value);
+    output_asm_insn (brk_buffer, operands);
+
+    output_asm_insn (\"%l3:\", operands);
+    output_asm_insn (\"\\tbr\\t%0\", operands);
+
+    return \"\";
+  }"
+  [(set_attr "type" "branch")
+   (set_attr "length" "24")])
+
 (define_expand "prologue"
   [(clobber (const_int 0))]
   ""
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index f531a9f6ce33..161c7024f842 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18336,6 +18336,20 @@ sequences for both the KCFI preamble and the check-call bundle are
 considered ABI, as the Linux kernel may optionally rewrite these areas
 at boot time to mitigate detected CPU errata.
 
+On AArch64, KCFI type identifiers are emitted as a @code{.word ID}
+directive (a 32-bit constant) before the function entry.  AArch64's
+natural 4-byte instruction alignment eliminates the need for additional
+padding NOPs.  When used with @option{-fpatchable-function-entry}, the
+type identifier is placed before any patchable NOPs.  The runtime check
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

