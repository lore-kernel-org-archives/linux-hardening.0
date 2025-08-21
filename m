Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85D2E8B84
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761229; cv=none; b=GJYwGEe3gfQ+qapZbJh/DnDwjh+/jzSeNN5aGja5ut72GpLLa9D68GDexGI88dmAUZNgXBepfVS+eZAEUWfgeN4S+grAfDUkjKkcu+TY+JSdbzLO9kSuWK4G6M72gRS+HRPZjbvmwa3aKdp2wbViJbbHn6EY+W1F30EiUS02BEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761229; c=relaxed/simple;
	bh=JaLWQnSXDOu1i4kEzVkEMekfSbtqgXy05rJKwkt8LGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQe81gYe9Fy1xCPselCPBpTMBZNloaBTb5NN1VfGVwBtMlebiufFlNeiUmYYZTBiz5Rm+nv/+5+wpSDaQr+BbdeI+VHFzeekPabej8xJizH4sBtdK1hY5blKSsHSakjRAn9t8eufAI3rZpcnL9dCXfJYvaWrdUkDahErhk8fWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOSmiRH/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOSmiRH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A6CC116D0;
	Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755761229;
	bh=JaLWQnSXDOu1i4kEzVkEMekfSbtqgXy05rJKwkt8LGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOSmiRH/iJbuwm6ywwPVz/PxeUBPEmGPQseaxolJOXHRWBnc5NRgiNOHajBvjN9nH
	 YSvdhW+UB7G5v6PL2O2k64yO6GF1RRVJz6F0T0P6ZrERQxaSqOqdXNJWo0qYY7uGgG
	 6CArhZ70O7IxXuj/soD0uw89pru2k28a2snB5VinwQf6J5CAO/puiU8e0RCDRb04g3
	 3M1VIvhWn7rlZjUIs7VjKFGLzl3KjHc6FHcEoPpee64G6PjrLricVT9zStgPBvMq4G
	 ZBcvCQH6wwWYPjFTdP+KdblIOm93t9C4BJbFRVTWH0R8QMrVeOX1YPxZ3fxhhs44jB
	 medLNh30v3apg==
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
Subject: [RFC PATCH 4/7] x86: Add x86_64 Kernel Control Flow Integrity implementation
Date: Thu, 21 Aug 2025 00:26:37 -0700
Message-Id: <20250821072708.3109244-4-kees@kernel.org>
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

Implement x86_64-specific KCFI backend:

- Function preamble generation with type IDs positioned at -(4+prefix_nops)
  offset from function entry point.

- 16-byte alignment of KCFI preambles using calculated prefix NOPs:
  aligned(prefix_nops + 5, 16) to maintain cache lines.

- Type-id hash avoids generating ENDBR instruction in type IDs
  (0xfa1e0ff3/0xfb1e0ff3 are incremented by 1 to prevent execution).

- On-demand scratch register allocation strategy (r11 as needed).
  The clobbers are available both early and late.

- Atomic bundled KCFI check + call/branch sequences using UNSPECV_KCFI
  to prevent optimizer separation and maintain security properties.

- Uses the .kcfi_traps section for debugger/runtime metadata.

Assembly Code Pattern layout required by Linux kernel:
  movl $inverse_type_id, %r10d  ; Load expected type (0 - hash)
  addl offset(%target), %r10d   ; Add stored type ID from preamble
  je .Lpass                     ; Branch if types match (sum == 0)
  .Ltrap: ud2                   ; Undefined instruction trap on mismatch
  .Lpass: call/jmp *%target     ; Execute validated indirect transfer

The initialization of the kcfi callbacks in ix86_option_override()
seems like a hack. I couldn't find a better place to do this.

Build and run tested on x86_64 Linux kernel with various CPU errata
handling alternatives and FineIBT.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/i386/i386-protos.h   |   4 +
 gcc/config/i386/i386-options.cc |   3 +
 gcc/config/i386/i386.cc         | 128 ++++++++++++++++++++++++++++
 gcc/config/i386/i386.md         | 144 ++++++++++++++++++++++++++++++++
 gcc/doc/invoke.texi             |  20 +++++
 5 files changed, 299 insertions(+)

diff --git a/gcc/config/i386/i386-protos.h b/gcc/config/i386/i386-protos.h
index 69bc0ee570dd..a5209077506c 100644
--- a/gcc/config/i386/i386-protos.h
+++ b/gcc/config/i386/i386-protos.h
@@ -36,6 +36,10 @@ extern void ix86_maybe_emit_epilogue_vzeroupper (void);
 extern void ix86_expand_epilogue (int);
 extern void ix86_expand_split_stack_prologue (void);
 
+/* KCFI support.  */
+extern void ix86_kcfi_init (void);
+extern void kcfi_emit_trap_with_section (FILE *file, rtx trap_label_rtx);
+
 extern void ix86_output_addr_vec_elt (FILE *, int);
 extern void ix86_output_addr_diff_elt (FILE *, int, int);
 
diff --git a/gcc/config/i386/i386-options.cc b/gcc/config/i386/i386-options.cc
index 09a35ef62980..f7726c3fdd8f 100644
--- a/gcc/config/i386/i386-options.cc
+++ b/gcc/config/i386/i386-options.cc
@@ -3180,6 +3180,9 @@ void
 ix86_option_override (void)
 {
   ix86_option_override_internal (true, &global_options, &global_options_set);
+
+  /* Initialize KCFI target hooks for x86-64.  */
+  ix86_kcfi_init ();
 }
 
 /* Remember the last target of ix86_set_current_function.  */
diff --git a/gcc/config/i386/i386.cc b/gcc/config/i386/i386.cc
index 65e04d3760d5..1cecd6be2f57 100644
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
@@ -1700,6 +1701,19 @@ ix86_function_naked (const_tree fn)
   return false;
 }
 
+/* Apply x86-64 specific masking to KCFI type ID.  */
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
@@ -1711,6 +1725,9 @@ ix86_asm_output_function_label (FILE *out_file, const char *fname,
   if (cfun)
     cfun->machine->function_label_emitted = true;
 
+  /* Handle KCFI preamble for non-patchable functions.  */
+  kcfi_emit_preamble_if_needed (out_file, decl, false, 0, fname);
+
   if (is_ms_hook)
     {
       int i, filler_count = (TARGET_64BIT ? 32 : 16);
@@ -28456,6 +28473,117 @@ ix86_set_handled_components (sbitmap components)
       }
 }
 
+/* Generate KCFI checked call - replaces indirect call with bundled KCFI check + call.  */
+static rtx
+ix86_kcfi_gen_checked_call (rtx call_insn, rtx target_reg, uint32_t type_id, HOST_WIDE_INT prefix_nops)
+{
+  rtx inverse_type_id_rtx, offset_rtx, pass_label, trap_label, call_args;
+  bool is_sibcall = false;
+
+  /* Check if this is a sibling call (tail call) */
+  if (CALL_P (call_insn))
+    is_sibcall = SIBLING_CALL_P (call_insn);
+
+  /* Convert type ID to inverse for the check (0 - hash) */
+  uint32_t inverse_type_id = (uint32_t)(0 - type_id);
+  inverse_type_id_rtx = gen_int_mode (inverse_type_id, SImode);
+
+  /* Calculate variable offset: -(4 + prefix_nops) */
+  HOST_WIDE_INT offset = -(4 + prefix_nops);
+  offset_rtx = gen_int_mode (offset, DImode);
+
+  /* Generate unique labels for this check.  */
+  pass_label = gen_label_rtx ();
+  trap_label = gen_label_rtx ();
+
+  /* Extract call arguments from original call insn.  */
+  rtx pattern = PATTERN (call_insn);
+  if (GET_CODE (pattern) == CALL)
+    call_args = XEXP (pattern, 1);
+  else if (GET_CODE (pattern) == SET && GET_CODE (SET_SRC (pattern)) == CALL)
+    call_args = XEXP (SET_SRC (pattern), 1);
+  else if (GET_CODE (pattern) == PARALLEL)
+    {
+      /* Handle PARALLEL patterns (includes peephole2 optimizations and other legitimate cases) */
+      is_sibcall = true;  /* PARALLEL indicates a sibling call.  */
+      rtx first_elem = XVECEXP (pattern, 0, 0);
+      if (GET_CODE (first_elem) == CALL)
+	{
+	  call_args = XEXP (first_elem, 1);
+	}
+      else if (GET_CODE (first_elem) == SET && GET_CODE (SET_SRC (first_elem)) == CALL)
+	{
+	  call_args = XEXP (SET_SRC (first_elem), 1);
+	}
+      else
+	{
+	  error ("KCFI: Unexpected PARALLEL pattern structure");
+	  gcc_unreachable ();
+	}
+    }
+  else
+    {
+      /* This should never happen - all indirect calls should match one of the above patterns.  */
+      error ("KCFI: Unexpected call pattern structure");
+      gcc_unreachable ();
+    }
+
+  rtx bundled_call;
+  if (is_sibcall)
+    {
+      /* Use sibling call pattern for tail calls.  */
+      bundled_call = gen_kcfi_checked_sibcall (target_reg, call_args, inverse_type_id_rtx, offset_rtx, pass_label, trap_label);
+    }
+  else
+    {
+      /* Use regular call pattern.  */
+      bundled_call = gen_kcfi_checked_call (target_reg, call_args, inverse_type_id_rtx, offset_rtx, pass_label, trap_label);
+    }
+
+  return bundled_call;
+}
+
+/* Calculate x86_64-specific KCFI prefix NOPs for 16-byte alignment.  */
+static int
+ix86_kcfi_calculate_prefix_nops (HOST_WIDE_INT prefix_nops)
+{
+  /* Calculate KCFI NOPs needed: aligned(prefix_nops + 5, 16).  */
+  return (16 - ((prefix_nops + 5) % 16)) % 16;
+}
+
+/* Emit x86_64-specific type ID instruction.  */
+static void
+ix86_kcfi_emit_type_id_instruction (FILE *file, uint32_t type_id)
+{
+  /* Emit movl instruction with type ID.  */
+  fprintf (file, "\tmovl\t$0x%08x, %%eax\n", type_id);
+}
+
+/* Add x86-64 specific register clobbers for KCFI calls.  */
+static void
+ix86_kcfi_add_clobbers (rtx_insn *call_insn)
+{
+  /* Add r10/r11 clobbers so register allocator knows they'll be used.  */
+  rtx usage = CALL_INSN_FUNCTION_USAGE (call_insn);
+  clobber_reg (&usage, gen_rtx_REG (DImode, R10_REG));
+  clobber_reg (&usage, gen_rtx_REG (DImode, R11_REG));
+  CALL_INSN_FUNCTION_USAGE (call_insn) = usage;
+}
+
+/* Initialize x86-64 KCFI target hooks.  */
+void
+ix86_kcfi_init (void)
+{
+  if (TARGET_64BIT && (flag_sanitize & SANITIZE_KCFI))
+    {
+      kcfi_target.mask_type_id = ix86_kcfi_mask_type_id;
+      kcfi_target.gen_kcfi_checked_call = ix86_kcfi_gen_checked_call;
+      kcfi_target.add_kcfi_clobbers = ix86_kcfi_add_clobbers;
+      kcfi_target.calculate_prefix_nops = ix86_kcfi_calculate_prefix_nops;
+      kcfi_target.emit_type_id_instruction = ix86_kcfi_emit_type_id_instruction;
+    }
+}
+
 #undef TARGET_SHRINK_WRAP_GET_SEPARATE_COMPONENTS
 #define TARGET_SHRINK_WRAP_GET_SEPARATE_COMPONENTS ix86_get_separate_components
 #undef TARGET_SHRINK_WRAP_COMPONENTS_FOR_BB
diff --git a/gcc/config/i386/i386.md b/gcc/config/i386/i386.md
index a50475bdaf4c..acefc2246537 100644
--- a/gcc/config/i386/i386.md
+++ b/gcc/config/i386/i386.md
@@ -248,6 +248,7 @@
   UNSPECV_RDGSBASE
   UNSPECV_WRFSBASE
   UNSPECV_WRGSBASE
+  UNSPECV_KCFI
   UNSPECV_FXSAVE
   UNSPECV_FXRSTOR
   UNSPECV_FXSAVE64
@@ -30582,6 +30583,149 @@
    (set_attr "type" "other")
    (set_attr "mode" "<MODE>")])
 
+;; KCFI checked call - atomic KCFI check + indirect call bundle
+;; This prevents optimizer from separating KCFI checks from their protected calls
+(define_insn "kcfi_checked_call"
+  [(call (mem:QI (match_operand:DI 0 "nonimmediate_operand" "rm"))
+         (match_operand 1))
+   (unspec_volatile [(match_operand:SI 2 "const_int_operand" "n")
+                     (match_operand:DI 3 "const_int_operand" "n")
+                     (label_ref (match_operand 4))
+                     (label_ref (match_operand 5))] UNSPECV_KCFI)
+   (clobber (reg:SI R10_REG))
+   (clobber (reg:SI R11_REG))
+   (clobber (reg:CC FLAGS_REG))]
+  "TARGET_64BIT && !SIBLING_CALL_P (insn)"
+{
+  rtx target_reg;
+  bool need_r11 = false;
+
+  /* If target is not in a register, move it to r11.  */
+  if (!REG_P (operands[0]))
+    {
+      target_reg = gen_rtx_REG (DImode, R11_REG);
+      /* Emit the move to r11.  */
+      rtx mov_to_r11[2] = { target_reg, operands[0] };
+      output_asm_insn ("movq\t%1, %0", mov_to_r11);
+      need_r11 = true;
+    }
+  else
+    {
+      target_reg = operands[0];
+    }
+
+  /* Choose scratch register: r10 by default, r11 if r10 is the target.  */
+  bool target_is_r10 = (REG_P (target_reg) && REGNO (target_reg) == R10_REG);
+  int scratch_reg = target_is_r10 ? R11_REG : R10_REG;
+  const char *scratch_name = target_is_r10 ? "r11d" : "r10d";
+
+  /* Output complete KCFI check + call sequence atomically.  */
+  char mov_insn[64];
+  sprintf (mov_insn, "movl\t$%%c2, %%%%%s", scratch_name);
+  output_asm_insn (mov_insn, operands);
+
+  /* Create memory operand for the addl instruction.  */
+  rtx mem_op = gen_rtx_MEM (SImode, gen_rtx_PLUS (DImode, target_reg, operands[3]));
+  rtx temp_operands[2] = { mem_op, gen_rtx_REG (SImode, scratch_reg) };
+  output_asm_insn ("addl\t%0, %1", temp_operands);
+
+  output_asm_insn ("je\t%l4", operands);
+
+  /* Output trap label and instruction.  */
+  output_asm_insn ("%l5:", operands);
+  output_asm_insn ("ud2", operands);
+
+  /* Use existing function with trap and entry label RTX.  */
+  kcfi_emit_trap_with_section (asm_out_file, operands[5]);
+
+  /* Output pass label.  */
+  output_asm_insn ("%l4:", operands);
+
+  /* Finally emit the protected call using the register we chose.  */
+  if (need_r11)
+    {
+      rtx r11_operand = gen_rtx_REG (DImode, R11_REG);
+      output_asm_insn ("call\t*%0", &r11_operand);
+      return "";
+    }
+  else
+    return "call\t*%0";
+}
+  [(set_attr "type" "call")
+   (set_attr "mode" "DI")])
+
+;; KCFI checked sibling call - atomic KCFI check + indirect sibling call bundle
+;; This handles tail call optimization cases
+(define_insn "kcfi_checked_sibcall"
+  [(call (mem:QI (match_operand:DI 0 "nonimmediate_operand" "rm"))
+         (match_operand 1))
+   (unspec_volatile [(match_operand:SI 2 "const_int_operand" "n")
+                     (match_operand:DI 3 "const_int_operand" "n")
+                     (label_ref (match_operand 4))
+                     (label_ref (match_operand 5))] UNSPECV_KCFI)
+   (clobber (reg:SI R10_REG))
+   (clobber (reg:SI R11_REG))
+   (clobber (reg:CC FLAGS_REG))]
+  "TARGET_64BIT && SIBLING_CALL_P (insn)"
+{
+  rtx target_reg;
+  bool need_r11 = false;
+
+  /* If target is not in a register, move it to r11.  */
+  if (!REG_P (operands[0]))
+    {
+      target_reg = gen_rtx_REG (DImode, R11_REG);
+      /* Emit the move to r11.  */
+      rtx mov_to_r11[2] = { target_reg, operands[0] };
+      output_asm_insn ("movq\t%1, %0", mov_to_r11);
+      need_r11 = true;
+    }
+  else
+    {
+      target_reg = operands[0];
+    }
+
+  /* Choose scratch register: r10 by default, r11 if r10 is the target.  */
+  bool target_is_r10 = (REG_P (target_reg) && REGNO (target_reg) == R10_REG);
+  int scratch_reg = target_is_r10 ? R11_REG : R10_REG;
+  const char *scratch_name = target_is_r10 ? "r11d" : "r10d";
+
+  /* Output complete KCFI check + sibling call sequence atomically.  */
+  char mov_insn[64];
+  sprintf (mov_insn, "movl\t$%%c2, %%%%%s", scratch_name);
+  output_asm_insn (mov_insn, operands);
+
+  /* Create memory operand for the addl instruction.  */
+  rtx mem_op = gen_rtx_MEM (SImode, gen_rtx_PLUS (DImode, target_reg, operands[3]));
+  rtx temp_operands[2] = { mem_op, gen_rtx_REG (SImode, scratch_reg) };
+  output_asm_insn ("addl\t%0, %1", temp_operands);
+
+  output_asm_insn ("je\t%l4", operands);
+
+  /* Output trap label and instruction.  */
+  output_asm_insn ("%l5:", operands);
+  output_asm_insn ("ud2", operands);
+
+  /* Use existing function with trap and entry label RTX.  */
+  kcfi_emit_trap_with_section (asm_out_file, operands[5]);
+
+  /* Output pass label.  */
+  output_asm_insn ("%l4:", operands);
+
+  /* Finally emit the protected sibling call (jmp) using the register we chose.  */
+  if (need_r11)
+    {
+      rtx r11_operand = gen_rtx_REG (DImode, R11_REG);
+      output_asm_insn ("jmp\t*%0", &r11_operand);
+      return "";
+    }
+  else
+    return "jmp\t*%0";
+}
+  [(set_attr "type" "call")
+   (set_attr "mode" "DI")])
+
+
 (include "mmx.md")
 (include "sse.md")
 (include "sync.md")
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index c66f47336826..f531a9f6ce33 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18316,6 +18316,26 @@ and without changing the entry points of the target functions. Only
 functions that have referenced by their address receive the KCFI preamble
 instrumentation.
 
+Platform-specific implementation details:
+
+On x86_64, KCFI type identifiers are emitted as a @code{movl $ID, %eax}
+instruction before the function entry.  The implementation ensures that
+type IDs never collide with ENDBR instruction encodings.  When used with
+@option{-fpatchable-function-entry}, the type identifier is placed before
+any patchable NOPs, with appropriate alignment to maintain a 16-byte
+boundary for the function entry.  The runtime check loads the type ID
+from the target function into @code{%r10d} and uses an @code{addl}
+instruction to add the negative expected type ID, effectively zeroing
+the register if the types match.  A conditional jump follows to either
+continue execution or trap on mismatch.  The check sequence uses
+@code{%r10d} and @code{%r11d} as scratch registers.  Trap locations are
+recorded in a special @code{.kcfi_traps} section that maps trap sites
+to their corresponding function entry points, enabling debuggers and
+crash handlers to identify KCFI violations.  The exact instruction
+sequences for both the KCFI preamble and the check-call bundle are
+considered ABI, as the Linux kernel may optionally rewrite these areas
+at boot time to mitigate detected CPU errata.
+
 KCFI is intended primarily for kernel code and may not be suitable
 for user-space applications that rely on techniques incompatible
 with strict type checking of indirect calls.
-- 
2.34.1

