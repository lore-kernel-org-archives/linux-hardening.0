Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD1F27B352
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761229; cv=none; b=tCXj+sNUj8kF8s3Ib105E5kzp5kL8U4XAfcMkt/7QPE8TokE+8FmXFNyVsfoTJYCi8+lF29SlQnf+zFQXEXYQkwRpT50REesWb9mq5uCuQ55ANcAmn5fbYjMlTFeqFReKLI5BKzaJVOTMh9NGyi5Mu59OT68PqC/KAozKQk21ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761229; c=relaxed/simple;
	bh=VxpCTbxiFROXoUWtnSRjZRBsU/9zYH/GSXl9aDZk9CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1IKyf4vfqL1lre7X9+loFMqwN9CS3RVeSqRbnarzg38g7aD1DV8357CkBPTgYL8Pf7+HBxLcDP0+jJ/INgGNqcFX0JXu3vQJ/Xbeq7HBJQhVxKgCewqBFak2q/W2dJS571t5sr9Vbm/vjshYZfGR0f9TximudNmrkvNpBrUWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN+NMWrf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN+NMWrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05230C116C6;
	Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755761229;
	bh=VxpCTbxiFROXoUWtnSRjZRBsU/9zYH/GSXl9aDZk9CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CN+NMWrfNGW++y6NvPIFHC7TuX/spUGjQraUA0RdvxTDlxemgk3sQa3UovY8WvzVb
	 Cq5gMq+kXr9egMk+I9tJdc6sxonAo3VCOwTgw0y/1h266evP/S3CUu1oi4zawGzZCc
	 v/URYAsjj/GxeQZdD0jED13AiAjCWH/JSCQwrm9kr61nmDlSbA9m7yyav9rnqPXp0L
	 SGyDDtf7BIj/gQDS4hEDHzyv/H2AskDymPosGQqY5hVG+sevwWJ/XXKvdZyziba6wX
	 1ase5K5NgyCtqdSsElCOQM6OxfbUhgjtFJ/8ycT7kFJl6r4D9FmGLjzvCrSsCagelw
	 aClSdHX0/yZog==
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
Subject: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity infrastructure
Date: Thu, 21 Aug 2025 00:26:36 -0700
Message-Id: <20250821072708.3109244-3-kees@kernel.org>
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

This series implements the Linux Kernel Control Flow Integrity ABI,
which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

Just to set expectations, this is an RFC because this is my first time
working on most of the affected areas in GCC, and it is likely I have
missed really obvious stuff, or gone about doing things in very wrong
ways. I tried to find the best way to do stuff, but I was left with many
questions. :) All that said, this works for x86_64 and aarch64 Linux
kernels. (I have implemented riscv64 as well, but I lack a viable test
environment -- I am working on this still.)

KCFI has a number of specific constraints. Some are tied to the
backend architecture, which I'll cover in more detail in later patches.
The constraints are:

- The KCFI scheme generates a unique 32-bit hash for each unique function
  prototype, allowing for indirect call sites to verify that they are
  calling into a matching _type_ of function pointer. This changes the
  semantics of some optimization logic because now indirect calls to
  different types cannot be merged. For example:

    if (p->func_type_1)
	return p->func_type_1();
    if (p->func_type_2)
	return p->func_type_2();

  In final asm, the optimizer may collapse the second indirect call
  into a jump to the first indirect call once it has loaded the function
  pointer. KCFI must block cross-type merging otherwise there will be a
  single KCFI check happening for only 1 type but being used by 2 target
  types. The distinguishing characteristic for call merging becomes the
  type, not the address/register usage.

- The check-call instruction sequence must be treated a single unit: it
  cannot be rearranged or split or optimized. The pattern is that
  indirect calls, "call *$target", get converted into:

    mov $target_expression, %target (only present if the expression was
                                     not already %target)
    load -$offset(%target), %tmp
    cmp $hash, %tmp
    je .Lcheck_passed
  .Ltrap$N:
    trap
  .Lcheck_passed$N:
    call *%target

  This pattern of call immediately after trap provides for the
  "permissive" checking mode automatically: the trap gets handled,
  a warning emitted, and then execution continues after the trap to
  the call.

  (x86_64 uses "mov -$hash, %tmp; addl -$offset(%target), %tmp; je"
  to zero out the register before making the call. Also Linux needs
  exactly these insns because it is both disassembling them during
  trap handling and potentially live patching them at boot time to
  be converted into a different series of instrutions, a scheme
  know as FineIBT, making the insn sequence ABI.)

- KCFI check-call instrumentation must survive tail call optimization.
  If an indirect call is turned into an indirect jump, KCFI checking
  must still happen (but will still use the jmp).

- Functions that may be called indirectly have a preamble added,
  __cfi_$original_func_name, that contains the $hash value:

    __cfi_target_func:
      .word $hash
    target_func:
       [regular function entry...]

  (x86_64 uses a movl instruction to hold the hash and prefixed aligned
  NOPs to maintain cache line alignment in the face of patchable function
  entry...)

- The preamble needs to interact with patchable function entry so that
  the hash appears further away from the actual start of the function
  (leaving the prefix NOPs of the patchable function entry unchanged).
  This means only _globally defined_ patchable function entry is supported
  with KCFI (indrect call sites must know in advance what the offset is,
  which may not be possible extern functions). For example, a "4,4"
  patchable function entry would end up like:

    __cfi_target_func:
      .data $hash
      nop nop nop nop
    target_func:
       [regular function entry...]

  (Linux x86_64 uses an 11 byte prefix nop area resulting in 16 bytes
  total including the movl. This region may be live patched at boot time
  for FineIBT so the behavior here is also ABI.)

- External functions that are address-taken have a weak __kcfi_typeid_$funcname
  symbol added with the hash value available so that the hash can be referenced
  from assembly linkages, etc, where the hash values cannot be calculated (i.e
  where C type information is missing):

    .weak   __kcfi_typeid_$func
    .set    __kcfi_typeid_$func, $hash

- On architectures that do not have a good way to encode additional
  details in their trap (x86_64 and riscv64), the trap location
  is identified as a KCFI trap via a relative address offset entry
  emitted into the .kcfi_traps section for each indirect call site's
  trap instruction. The previous check-call example's insn sequence has
  a section push/pop inserted between the trap and call:

  ...
  .Ltrap$N:
    trap
  .pushsection    .kcfi_traps,"ao",@progbits,.text
    .Lentry$N:
        .long   .Ltrap$N - .Lentry$N
  .popsection
  .Lcheck_passed$N:
    call %target

  (aarch64 encodes the register numbers that hold the expected hash
  and the target address in the trap ESR and thereby does not need a
  .kcfi_traps section at all.)

- The no_sanitize("kcfi") function attribute means that the marked function
  must not produce KCFI checking for indirect calls, and that this
  attribute must survive inlining. This is used rarely by Linux, but
  is required to make BPF JIT trampolines work on older Linux kernel
  versions. (The preamble code is very recently finally being generated
  at JIT time on the last remaining Linux KCFI arch where this was
  missing: aarch64.)

As a result of these constraints, there are some behavioral aspects
that need to be preserved across the middle-end and back-end, as I
understand them.

For indirect call sites:

- Keeping indirect calls from being merged (see above). I did this by
  adding a wrapping type so that equality was tested based on type-id.
  This is done in create_kcfi_wrapper_type(), via kcfi_instrument(),
  via an early GIMPLE pass (pass_kcfi and pass_kcfi0). The wrapper type
  is checked in gcc/cfgcleanup.cc, old_insns_match_p().

- Keeping typeid information available through to the RTL expansion
  phase was done via a typeid note (REG_CALL_KCFI_TYPE) attached also
  in create_kcfi_wrapper_type() in the same GIMPLE pass.

- REG_CALL_KCFI_TYPE notes needed to survive optimization passes so RTL
  expansion could find them again. These are retained in gcc/emit-rtl.cc,
  try_split(), and gcc/combine.cc, distribute_notes().

- The expansion to RTL is handled in gcc/cfgexpand.cc, expand_call_stmt().
  This lets the call expansion logic run, but then marks the resulting
  call RTL with REG_CALL_KCFI_TYPE so the last RTL instrumentation pass
  can find it. To me, this logic feels the most weird. It seems like
  there should be a better place to do this, but I do see that similar
  behavioral needs are also here, like nocf_check, so perhaps it's not
  far off.

- The same expand_call_stmt() logic also adds the clobbers that will be
  present in the final KCFI check-call insn sequences, which need to be
  added now so that register allocation is aware of them while working
  through optimization passes. Without this, the clobbered registers
  may get used in the RTL before we have replaced the call instructions
  that actually have the clobbers associated with them. This is the
  "have cake and eat it too" case where we have to do the check-call RTL
  replacement very late, but need to make sure the clobbers are known
  very early. Again, this seems like there should be a better way...

- To emit the exact KCFI check-call instruction sequences, a very late
  RTL pass is used (pass_kcfi_final_instrumentation). In order to
  handle sibling calls (tail calls), this pass chooses between either
  a check-call insn sequence or a check-jump insn sequence (provided by
  the per-arch back-end).

- To make sure instrumentation was skipped for inline functions, the
  RTL pass walks the basic blocks to identify their function origins,
  looking for the no_sanitize("kcfi") attribute, and skipping
  instrumentation if found.

For indirect call targets:

- kcfi_emit_preamble_if_needed() uses function_needs_kcfi_preamble(),
  and counter helpers, to emit the preablem, with patchable function
  entry NOPs. This gets used both in default_print_patchable_function_entry()
  and the per-arch path. I could not find a simpler way to deal with
  patchable function entry besides splitting it up like this. I feel
  like there should be a better way.

- gcc/varasm.cc, assemble_external_real() calls emit_kcfi_typeid_symbol()
  to add the __kcfi_typeid symbols (see get_function_kcfi_type_id()
  below).

To support the per-arch back-ends, there are some common helpers:

- A callback framework is added via struct kcfi_target_hooks for
  backends to fill out.

- kcfi_emit_trap_with_section() handles the push/pop section and
  generating the relative offset section entries.

- get_function_kcfi_type_id() generates the 32-bit hash value, using
  compute_kcfi_type_id() and kcfi_hash_string() to hook to the mangling
  API. The hash is FNV-1a right now: it doesn't need secrecy. It could be
  replaced with any hash, though the hash will need to be coordinated
  with Rust, which implements the KCFI ABI as well.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/Makefile.in     |   1 +
 gcc/flag-types.h    |   2 +
 gcc/kcfi.h          |  85 +++++
 gcc/tree-pass.h     |   1 +
 gcc/cfgcleanup.cc   |  20 ++
 gcc/cfgexpand.cc    |  61 ++++
 gcc/combine.cc      |   1 +
 gcc/doc/invoke.texi |  29 ++
 gcc/emit-rtl.cc     |   1 +
 gcc/kcfi.cc         | 783 ++++++++++++++++++++++++++++++++++++++++++++
 gcc/opts.cc         |   1 +
 gcc/passes.cc       |   1 +
 gcc/passes.def      |   3 +
 gcc/recog.cc        |   1 +
 gcc/reg-notes.def   |   6 +
 gcc/targhooks.cc    |  50 ++-
 gcc/toplev.cc       |   8 +
 gcc/varasm.cc       |  18 +
 18 files changed, 1071 insertions(+), 1 deletion(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/kcfi.cc

diff --git a/gcc/Makefile.in b/gcc/Makefile.in
index 86f62611c1d4..01cccd88fde0 100644
--- a/gcc/Makefile.in
+++ b/gcc/Makefile.in
@@ -1593,6 +1593,7 @@ OBJS = \
 	ira-emit.o \
 	ira-lives.o \
 	jump.o \
+	kcfi.o \
 	langhooks.o \
 	late-combine.o \
 	lcm.o \
diff --git a/gcc/flag-types.h b/gcc/flag-types.h
index 33c88a15ecbb..7ed6dab1bd4b 100644
--- a/gcc/flag-types.h
+++ b/gcc/flag-types.h
@@ -337,6 +337,8 @@ enum sanitize_code {
   SANITIZE_KERNEL_HWADDRESS = 1ULL << 30,
   /* Shadow Call Stack.  */
   SANITIZE_SHADOW_CALL_STACK = 1ULL << 31,
+  /* KCFI (Kernel Control Flow Integrity) */
+  SANITIZE_KCFI = 1ULL << 32,
   SANITIZE_SHIFT = SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
   SANITIZE_UNDEFINED = SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNREACHABLE
 		       | SANITIZE_VLA | SANITIZE_NULL | SANITIZE_RETURN
diff --git a/gcc/kcfi.h b/gcc/kcfi.h
new file mode 100644
index 000000000000..23d679b73ba4
--- /dev/null
+++ b/gcc/kcfi.h
@@ -0,0 +1,85 @@
+/* Kernel Control Flow Integrity (KCFI) support for GCC.
+   Copyright (C) 2025 Free Software Foundation, Inc.
+
+This file is part of GCC.
+
+GCC is free software; you can redistribute it and/or modify it under
+the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 3, or (at your option) any later
+version.
+
+GCC is distributed in the hope that it will be useful, but WITHOUT ANY
+WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+for more details.
+
+You should have received a copy of the GNU General Public License
+along with GCC; see the file COPYING3.  If not see
+<http://www.gnu.org/licenses/>.  */
+
+#ifndef GCC_KCFI_H
+#define GCC_KCFI_H
+
+#include "config.h"
+#include "system.h"
+#include "coretypes.h"
+#include "rtl.h"
+
+/* Get KCFI type ID for a function declaration.  */
+extern uint32_t get_function_kcfi_type_id (tree fndecl);
+
+/* KCFI target hooks for architecture-specific functionality.  */
+
+struct kcfi_target_hooks {
+  /* Apply architecture-specific masking to type ID.  */
+  uint32_t (*mask_type_id) (uint32_t type_id);
+
+  /* Generate bundled KCFI checked call (atomic check + call to prevent optimizer separation) */
+  rtx (*gen_kcfi_checked_call) (rtx call_insn, rtx target_reg, uint32_t expected_type, HOST_WIDE_INT prefix_nops);
+
+  /* Add architecture-specific register clobbers for KCFI calls.  */
+  void (*add_kcfi_clobbers) (rtx_insn *call_insn);
+
+  /* Calculate architecture-specific prefix NOPs count (optional, returns prefix_nops unchanged if NULL) */
+  int (*calculate_prefix_nops) (HOST_WIDE_INT prefix_nops);
+
+  /* Emit architecture-specific type ID instruction (required for common preamble helper) */
+  void (*emit_type_id_instruction) (FILE *file, uint32_t type_id);
+};
+
+/* Global KCFI target hooks.  */
+extern struct kcfi_target_hooks kcfi_target;
+
+/* Common helper for RTL patterns to emit .kcfi_traps section entry.
+   Call AFTER emitting trap label and instruction with the RTX label operand.  */
+extern void kcfi_emit_trap_with_section (FILE *file, rtx trap_label_rtx);
+
+/* RTL note management for KCFI.  */
+
+/* Add KCFI type ID note to call instruction.  */
+extern void add_kcfi_type_note (rtx_insn *call_insn, uint32_t type_id);
+
+/* Emit KCFI type ID symbol for address-taken functions.  */
+extern void emit_kcfi_typeid_symbol (FILE *asm_file, tree decl, const char *name);
+
+/* KCFI preamble emission coordination.  */
+
+/* Mark that KCFI preamble has been emitted to prevent duplication.  */
+extern void mark_kcfi_preamble_emitted (void);
+
+/* Central manager for all KCFI preamble generation decisions.  */
+extern void kcfi_emit_preamble_if_needed (FILE *file, tree decl,
+					  bool is_patchable_context,
+					  HOST_WIDE_INT prefix_nops,
+					  const char *actual_fname);
+
+/* Pass creation functions.  */
+class gimple_opt_pass;
+class rtl_opt_pass;
+namespace gcc { class context; }
+
+extern gimple_opt_pass *make_pass_kcfi (gcc::context *ctxt);
+extern gimple_opt_pass *make_pass_kcfi_O0 (gcc::context *ctxt);
+extern rtl_opt_pass *make_pass_kcfi_final_instrumentation (gcc::context *ctxt);
+
+#endif /* GCC_KCFI_H */
diff --git a/gcc/tree-pass.h b/gcc/tree-pass.h
index 1c68a69350df..2affea230213 100644
--- a/gcc/tree-pass.h
+++ b/gcc/tree-pass.h
@@ -561,6 +561,7 @@ extern gimple_opt_pass *make_pass_fixup_cfg (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_backprop (gcc::context *ctxt);
 
 extern rtl_opt_pass *make_pass_expand (gcc::context *ctxt);
+extern rtl_opt_pass *make_pass_kcfi_final_instrumentation (gcc::context *ctxt);
 extern rtl_opt_pass *make_pass_instantiate_virtual_regs (gcc::context *ctxt);
 extern rtl_opt_pass *make_pass_rtl_fwprop (gcc::context *ctxt);
 extern rtl_opt_pass *make_pass_rtl_fwprop_addr (gcc::context *ctxt);
diff --git a/gcc/cfgcleanup.cc b/gcc/cfgcleanup.cc
index d28d23231911..9707b7e22222 100644
--- a/gcc/cfgcleanup.cc
+++ b/gcc/cfgcleanup.cc
@@ -1238,6 +1238,26 @@ old_insns_match_p (int mode ATTRIBUTE_UNUSED, rtx_insn *i1, rtx_insn *i2)
   if (RTX_FRAME_RELATED_P (i1) && !insns_have_identical_cfa_notes (i1, i2))
     return dir_none;
 
+  /* KCFI (Kernel Control Flow Integrity): Do not cross-jump between different
+     KCFI check patterns.  Each bundled KCFI call has a unique type ID that must
+     be preserved to prevent type confusion attacks.  */
+  if (CALL_P (i1) && CALL_P (i2))
+    {
+      rtx kcfi_note1 = find_reg_note (i1, REG_CALL_KCFI_TYPE, NULL_RTX);
+      rtx kcfi_note2 = find_reg_note (i2, REG_CALL_KCFI_TYPE, NULL_RTX);
+
+      if (kcfi_note1 || kcfi_note2)
+	{
+	  /* If only one has KCFI note, they're different.  */
+	  if (!kcfi_note1 || !kcfi_note2)
+	    return dir_none;
+
+	  /* If both have KCFI notes, compare the type IDs.  */
+	  if (!rtx_equal_p (XEXP (kcfi_note1, 0), XEXP (kcfi_note2, 0)))
+	    return dir_none;
+	}
+    }
+
 #ifdef STACK_REGS
   /* If cross_jump_death_matters is not 0, the insn's mode
      indicates whether or not the insn contains any stack-like
diff --git a/gcc/cfgexpand.cc b/gcc/cfgexpand.cc
index 8950294abb60..432ccc7f864a 100644
--- a/gcc/cfgexpand.cc
+++ b/gcc/cfgexpand.cc
@@ -76,6 +76,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "opts.h"
 #include "gimple-range.h"
 #include "rtl-iter.h"
+#include "kcfi.h"
 
 /* Some systems use __main in a way incompatible with its use in gcc, in these
    cases use the macros NAME__MAIN to give a quoted symbol and SYMBOL__MAIN to
@@ -3203,6 +3204,66 @@ expand_call_stmt (gcall *stmt)
   else
     expand_expr (exp, const0_rtx, VOIDmode, EXPAND_NORMAL);
 
+  /* Add KCFI annotations if this is an indirect call with KCFI wrapper type.  */
+  if (sanitize_flags_p (SANITIZE_KCFI) && !gimple_call_fndecl (stmt))
+    {
+      tree fn_type = gimple_call_fntype (stmt);
+      gcc_assert (fn_type);
+      tree attr = lookup_attribute ("kcfi_type_id", TYPE_ATTRIBUTES (fn_type));
+      if (attr && TREE_VALUE (attr))
+	{
+	  /* Check if this call site originated from a no_sanitize("kcfi") function
+	     during inlining. If so, skip KCFI instrumentation in RTL phase too.  */
+	  bool should_skip_kcfi = false;
+	  location_t call_location = gimple_location (stmt);
+	  gcc_assert (call_location != UNKNOWN_LOCATION);
+
+	  tree block = gimple_block (stmt);
+	  while (block && TREE_CODE (block) == BLOCK)
+	    {
+	      tree fn_decl = BLOCK_ABSTRACT_ORIGIN (block);
+	      if (fn_decl && TREE_CODE (fn_decl) == FUNCTION_DECL)
+		{
+		  /* Found an inlined function - check if it has no_sanitize("kcfi").  */
+		  if (!sanitize_flags_p (SANITIZE_KCFI, fn_decl))
+		    {
+		      should_skip_kcfi = true;
+		      break;
+		    }
+		  break;
+		}
+	      /* Move up the block chain to find parent inlined functions.  */
+	      block = BLOCK_SUPERCONTEXT (block);
+	    }
+
+	  if (!should_skip_kcfi)
+	    {
+	      uint32_t kcfi_type_id = (uint32_t) tree_to_uhwi (TREE_VALUE (attr));
+
+	      /* Find the call that has been created.  */
+	      rtx_insn *call_insn = get_last_insn ();
+	      while (call_insn && call_insn != before_call && !CALL_P (call_insn))
+		call_insn = PREV_INSN (call_insn);
+
+	      if (call_insn && call_insn != before_call && CALL_P (call_insn))
+		{
+		  /* Add KCFI type ID note for anti-merging protection.  */
+		  add_kcfi_type_note (call_insn, kcfi_type_id);
+
+		  /* Add architecture-specific clobbers so register allocator knows
+		     they'll be used.  */
+		  if (kcfi_target.add_kcfi_clobbers)
+		    kcfi_target.add_kcfi_clobbers (call_insn);
+		}
+	      else
+		{
+		  error ("KCFI: Could not find call instruction for wrapper type");
+		  gcc_unreachable ();
+		}
+	    }
+	}
+    }
+
   /* If the gimple call is an indirect call and has 'nocf_check'
      attribute find a generated CALL insn to mark it as no
      control-flow verification is needed.  */
diff --git a/gcc/combine.cc b/gcc/combine.cc
index 4dbc1f6a4a4e..efaeb426d254 100644
--- a/gcc/combine.cc
+++ b/gcc/combine.cc
@@ -14525,6 +14525,7 @@ distribute_notes (rtx notes, rtx_insn *from_insn, rtx_insn *i3, rtx_insn *i2,
 	case REG_CALL_DECL:
 	case REG_UNTYPED_CALL:
 	case REG_CALL_NOCF_CHECK:
+	case REG_CALL_KCFI_TYPE:
 	  /* These notes must remain with the call.  It should not be
 	     possible for both I2 and I3 to be a call.  */
 	  if (CALL_P (i3))
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index c1e708beacf3..c66f47336826 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18294,6 +18294,35 @@ possible by specifying the command-line options
 @option{--param hwasan-instrument-allocas=1} respectively. Using a random frame
 tag is not implemented for kernel instrumentation.
 
+@opindex fsanitize=kcfi
+@item -fsanitize=kcfi
+Enable Kernel Control Flow Integrity (KCFI), a lightweight control
+flow integrity mechanism designed for operating system kernels.
+KCFI instruments indirect function calls to verify that the target
+function has the expected type signature at runtime.  Each function
+receives a unique type identifier computed from a hash of its function
+prototype (including parameter types and return type).  Before each
+indirect call, the implementation inserts a check to verify that the
+target function's type identifier matches the expected identifier
+for the call site, terminating the program if a mismatch is detected.
+This provides forward-edge control flow protection against attacks that
+attempt to redirect indirect calls to unintended targets.
+
+The implementation adds minimal runtime overhead and does not require
+runtime library support, making it suitable for kernel environments.
+The type identifier is placed before the function entry point,
+allowing runtime verification without additional metadata structures,
+and without changing the entry points of the target functions. Only
+functions that have referenced by their address receive the KCFI preamble
+instrumentation.
+
+KCFI is intended primarily for kernel code and may not be suitable
+for user-space applications that rely on techniques incompatible
+with strict type checking of indirect calls.
+
+Use @option{-fdump-tree-kcfi} to examine the computed type identifiers
+and their corresponding mangled type strings during compilation.
+
 @opindex fsanitize=pointer-compare
 @item -fsanitize=pointer-compare
 Instrument comparison operation (<, <=, >, >=) with pointer operands.
diff --git a/gcc/emit-rtl.cc b/gcc/emit-rtl.cc
index f4fc92bb37a1..aa56112bc250 100644
--- a/gcc/emit-rtl.cc
+++ b/gcc/emit-rtl.cc
@@ -4056,6 +4056,7 @@ try_split (rtx pat, rtx_insn *trial, int last)
 	case REG_SETJMP:
 	case REG_TM:
 	case REG_CALL_NOCF_CHECK:
+	case REG_CALL_KCFI_TYPE:
 	case REG_CALL_ARG_LOCATION:
 	  for (insn = insn_last; insn != NULL_RTX; insn = PREV_INSN (insn))
 	    {
diff --git a/gcc/kcfi.cc b/gcc/kcfi.cc
new file mode 100644
index 000000000000..522bb97bf503
--- /dev/null
+++ b/gcc/kcfi.cc
@@ -0,0 +1,783 @@
+/* Kernel Control Flow Integrity (KCFI) support for GCC.
+   Copyright (C) 2025 Free Software Foundation, Inc.
+
+This file is part of GCC.
+
+GCC is free software; you can redistribute it and/or modify it under
+the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 3, or (at your option) any later
+version.
+
+GCC is distributed in the hope that it will be useful, but WITHOUT ANY
+WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+for more details.
+
+You should have received a copy of the GNU General Public License
+along with GCC; see the file COPYING3.  If not see
+<http://www.gnu.org/licenses/>.  */
+
+#include "config.h"
+#include "system.h"
+#include "coretypes.h"
+#include "target.h"
+#include "function.h"
+#include "tree.h"
+#include "tree-pass.h"
+#include "dumpfile.h"
+#include "basic-block.h"
+#include "gimple.h"
+#include "gimple-iterator.h"
+#include "cgraph.h"
+#include "kcfi.h"
+#include "stringpool.h"
+#include "attribs.h"
+#include "rtl.h"
+#include "cfg.h"
+#include "asan.h"
+#include "diagnostic-core.h"
+#include "memmodel.h"
+#include "emit-rtl.h"
+#include "output.h"
+#include "varasm.h"
+#include "opts.h"
+#include "mangle.h"
+
+/* Global KCFI target hooks structure - zero-initialized for safe defaults.  */
+struct kcfi_target_hooks kcfi_target = { };
+
+/* Common KCFI utilities.  */
+
+/* Common helper for RTL patterns to emit .kcfi_traps section entry.  */
+void
+kcfi_emit_trap_with_section (FILE *file, rtx trap_label_rtx)
+{
+  /* Convert trap label to string using standard GCC helper.  */
+  char trap_name[64];
+  ASM_GENERATE_INTERNAL_LABEL (trap_name, "L", CODE_LABEL_NUMBER (trap_label_rtx));
+
+  /* Generate entry label name from trap label number.  */
+  char entry_name[64];
+  ASM_GENERATE_INTERNAL_LABEL (entry_name, "Lentry", CODE_LABEL_NUMBER (trap_label_rtx));
+
+  /* Emit .kcfi_traps section entry using the converted labels.  */
+  fprintf (file, "\t.pushsection\t.kcfi_traps,\"ao\",@progbits,.text\n");
+  assemble_name (file, entry_name);
+  fprintf (file, ":\n");
+  fprintf (file, "\t.long\t");
+  assemble_name (file, trap_name);
+  fprintf (file, " - ");
+  assemble_name (file, entry_name);
+  fprintf (file, "\n");
+  fprintf (file, "\t.popsection\n");
+}
+
+/* Hash function for KCFI type ID computation.
+   This implements a simple hash similar to FNV-1a.  */
+static uint32_t
+kcfi_hash_string (const char *str)
+{
+  uint32_t hash = 2166136261U; /* FNV-1a 32-bit offset basis.  */
+  for (const char *p = str; *p; p++)
+    {
+      hash ^= (unsigned char) *p;
+      hash *= 16777619U; /* FNV-1a 32-bit prime.  */
+    }
+  return hash;
+}
+
+/* Compute KCFI type ID for a function declaration or function type (internal) */
+static uint32_t
+compute_kcfi_type_id (tree fntype_or_fndecl)
+{
+  if (!fntype_or_fndecl)
+    return 0;
+
+  const char *canonical_name = mangle_function_type (fntype_or_fndecl);
+  uint32_t base_type_id = kcfi_hash_string (canonical_name);
+
+  /* Apply target-specific masking if supported.  */
+  if (kcfi_target.mask_type_id)
+    base_type_id = kcfi_target.mask_type_id (base_type_id);
+
+  /* Output to dump file if enabled */
+  if (dump_file && (dump_flags & TDF_DETAILS))
+    {
+      const char *name = NULL;
+      if (TREE_CODE (fntype_or_fndecl) == FUNCTION_DECL)
+        {
+          if (DECL_NAME (fntype_or_fndecl))
+            name = IDENTIFIER_POINTER (DECL_NAME (fntype_or_fndecl));
+        }
+
+      if (name)
+        fprintf (dump_file, "KCFI type ID for function '%s': mangled='%s' typeid=0x%08x\n",
+                 name, canonical_name, base_type_id);
+      else
+        fprintf (dump_file, "KCFI type ID: mangled='%s' typeid=0x%08x\n",
+                 canonical_name, base_type_id);
+    }
+
+  return base_type_id;
+}
+
+/* Check if a function needs KCFI preamble generation.
+   ALL functions get preambles when -fsanitize=kcfi is enabled, regardless
+   of no_sanitize("kcfi") attribute.  */
+static bool
+function_needs_kcfi_preamble (tree fndecl)
+{
+  /* Only instrument if KCFI is globally enabled.  */
+  if (!(flag_sanitize & SANITIZE_KCFI))
+    return false;
+
+  struct cgraph_node *node = cgraph_node::get (fndecl);
+
+  /* Ignore cold partition functions: not reached via indirect call.  */
+  if (node && node->split_part)
+    return false;
+
+  /* Ignore cold partition sections: cold partitions are never indirect call
+     targets.  Only skip preambles for cold partitions (has_bb_partition = true)
+     not for entire cold-attributed functions (has_bb_partition = false).  */
+  if (in_cold_section_p && crtl && crtl->has_bb_partition)
+    return false;
+
+  /* Check if function is truly address-taken using cgraph node analysis.  */
+  bool addr_taken = (node && node->address_taken);
+
+  /* Only instrument functions that can be targets of indirect calls:
+     - Public functions (can be called externally)
+     - External declarations (from other modules)
+     - Functions with true address-taken status from cgraph analysis.  */
+  return TREE_PUBLIC (fndecl) || DECL_EXTERNAL (fndecl) || addr_taken;
+}
+
+/* Function attribute to store KCFI type ID.  */
+static tree kcfi_type_id_attr = NULL_TREE;
+
+/* Get KCFI type ID for a function declaration.  */
+uint32_t
+get_function_kcfi_type_id (tree fndecl)
+{
+  if (!kcfi_type_id_attr)
+    kcfi_type_id_attr = get_identifier ("kcfi_type_id");
+
+  tree attr = lookup_attribute_by_prefix ("kcfi_type_id", DECL_ATTRIBUTES (fndecl));
+  if (attr && TREE_VALUE (attr) && TREE_VALUE (TREE_VALUE (attr)))
+    {
+      tree value = TREE_VALUE (TREE_VALUE (attr));
+      if (TREE_CODE (value) == INTEGER_CST)
+	return (uint32_t) TREE_INT_CST_LOW (value);
+    }
+
+  /* Compute and cache type ID using original parameter declarations.  */
+  uint32_t type_id = compute_kcfi_type_id (fndecl);
+
+  tree type_id_tree = build_int_cst (unsigned_type_node, type_id);
+  tree attr_value = build_tree_list (NULL_TREE, type_id_tree);
+  attr = build_tree_list (kcfi_type_id_attr, attr_value);
+
+  DECL_ATTRIBUTES (fndecl) = chainon (DECL_ATTRIBUTES (fndecl), attr);
+
+  return type_id;
+}
+
+/* Get the number of patchable prefix NOPs for the current function.  */
+static HOST_WIDE_INT
+get_current_function_patchable_prefix_nops (void)
+{
+  HOST_WIDE_INT prefix_nops = 0;
+
+  /* Check for function-specific patchable_function_entry attribute.  */
+  tree patchable_attr = lookup_attribute ("patchable_function_entry",
+					 DECL_ATTRIBUTES (current_function_decl));
+  if (patchable_attr)
+    {
+      tree pp_val = TREE_VALUE (patchable_attr);
+      /* total_nops = tree_to_uhwi (TREE_VALUE (pp_val)); */
+      if (TREE_CHAIN (pp_val))
+	prefix_nops = tree_to_uhwi (TREE_VALUE (TREE_CHAIN (pp_val)));
+    }
+  else
+    {
+      /* Use global configuration if no function-specific attribute.  */
+      HOST_WIDE_INT total_nops, patch_area_entry;
+      parse_and_check_patch_area (flag_patchable_function_entry, false,
+				  &total_nops, &patch_area_entry);
+      prefix_nops = patch_area_entry;
+    }
+
+  return prefix_nops;
+}
+
+/* Check if this is an indirect call that needs KCFI instrumentation.  */
+static bool
+is_kcfi_indirect_call (tree fn)
+{
+  if (!fn)
+    return false;
+
+  /* Only functions WITHOUT no_sanitize("kcfi") should generate KCFI checks at
+     indirect call sites.  */
+  if (!sanitize_flags_p (SANITIZE_KCFI, current_function_decl))
+    return false;
+
+  /* Direct function calls via ADDR_EXPR don't need KCFI checks.  */
+  if (TREE_CODE (fn) == ADDR_EXPR)
+    return false;
+
+  /* Function pointers, variables, and other indirect calls need KCFI.  */
+  return true;
+}
+
+/* Extract target from call instruction RTL pattern.
+   Handles the RTL pattern matching needed to find the rtx containing
+   the function pointer for indirect calls.  */
+static rtx
+kcfi_find_call_target (rtx_insn *call_insn)
+{
+  if (!call_insn || (!CALL_P (call_insn) && !JUMP_P (call_insn)))
+    return NULL_RTX;
+
+  rtx call_pattern = PATTERN (call_insn);
+  rtx target_reg = NULL_RTX;
+
+  if (CALL_P (call_insn) && GET_CODE (call_pattern) == PARALLEL)
+    {
+      /* Handle PARALLEL patterns (need to extract CALL) */
+      rtx call_part = XVECEXP (call_pattern, 0, 0);
+      call_pattern = call_part;
+    }
+
+  if (CALL_P (call_insn) && GET_CODE (call_pattern) == CALL)
+    {
+      /* Handle CALL patterns.  */
+      rtx mem = XEXP (call_pattern, 0);
+      if (GET_CODE (mem) == MEM)
+	{
+	  target_reg = XEXP (mem, 0);
+	}
+    }
+  else if (CALL_P (call_insn) && GET_CODE (call_pattern) == SET)
+    {
+      /* Handle SET patterns (function calls with return values) */
+      rtx src = XEXP (call_pattern, 1);
+      if (GET_CODE (src) == CALL)
+	{
+	  rtx mem = XEXP (src, 0);
+	  if (GET_CODE (mem) == MEM)
+	    {
+	      target_reg = XEXP (mem, 0);
+	    }
+	}
+    }
+  else if (JUMP_P (call_insn) && GET_CODE (call_pattern) == SET)
+    {
+      /* Handle jump patterns.  */
+      rtx src = SET_SRC (call_pattern);
+      if (GET_CODE (src) == MEM)  /* Direct indirect jump.  */
+	{
+	  target_reg = XEXP (src, 0);
+	}
+    }
+
+  return target_reg;
+}
+
+/* Add KCFI type ID note to call instruction.  */
+void
+add_kcfi_type_note (rtx_insn *call_insn, uint32_t type_id)
+{
+  if (!call_insn || !CALL_P (call_insn))
+    return;
+
+  /* Create integer constant for type ID.  */
+  rtx type_id_rtx = gen_int_mode (type_id, SImode);
+
+  /* Add note to call instruction.  */
+  add_reg_note (call_insn, REG_CALL_KCFI_TYPE, type_id_rtx);
+}
+
+/* Global flag to coordinate KCFI preamble emission.  */
+static bool kcfi_preamble_emitted = false;
+
+/* Mark that KCFI preamble has been emitted to prevent duplication.  */
+void
+mark_kcfi_preamble_emitted (void)
+{
+  kcfi_preamble_emitted = true;
+}
+
+/* Emit KCFI type ID symbol for an address-taken function.
+   Centralized emission point to avoid duplication between
+   assemble_external_real() and assemble_start_function(). */
+void
+emit_kcfi_typeid_symbol (FILE *asm_file, tree decl, const char *name)
+{
+  uint32_t type_id = get_function_kcfi_type_id (decl);
+  fprintf (asm_file, "\t.weak\t__kcfi_typeid_%s\n", name);
+  fprintf (asm_file, "\t.set\t__kcfi_typeid_%s, 0x%08x\n", name, type_id);
+}
+
+/* Parse patchable function entry configuration from global flags.  */
+static bool
+parse_patchable_function_entry_config (void)
+{
+  HOST_WIDE_INT total_nops, prefix_nops;
+
+  if (!flag_patchable_function_entry)
+    return false;
+
+  parse_and_check_patch_area (flag_patchable_function_entry, false, &total_nops, &prefix_nops);
+  return (total_nops > 0);
+}
+
+/* Common KCFI preamble helper that handles shared logic across architectures.  */
+static void
+kcfi_emit_cfi_preamble (FILE *file, tree decl, HOST_WIDE_INT prefix_nops, const char *fname)
+{
+  /* Get type ID.  */
+  uint32_t type_id = get_function_kcfi_type_id (decl);
+
+  /* Create symbol name for reuse.  */
+  char cfi_symbol_name[256];
+  snprintf (cfi_symbol_name, sizeof(cfi_symbol_name), "__cfi_%s", fname);
+
+  /* Emit __cfi_ symbol with proper visibility.  */
+  if (TREE_PUBLIC (decl))
+    {
+      if (DECL_WEAK (decl))
+	ASM_WEAKEN_LABEL (file, cfi_symbol_name);
+      else
+	targetm.asm_out.globalize_label (file, cfi_symbol_name);
+    }
+
+  /* Emit .type directive.  */
+  ASM_OUTPUT_TYPE_DIRECTIVE (file, cfi_symbol_name, "function");
+  fprintf (file, "%s:\n", cfi_symbol_name);
+
+  /* Calculate architecture-specific prefix NOPs if hook provided.  */
+  int final_nops = prefix_nops;
+  if (kcfi_target.calculate_prefix_nops)
+    final_nops = kcfi_target.calculate_prefix_nops (prefix_nops);
+
+  /* Emit architecture-specific prefix NOPs.  */
+  for (int i = 0; i < final_nops; i++)
+    {
+      fprintf (file, "\tnop\n");
+    }
+
+  /* Emit architecture-specific type ID instruction.  */
+  if (kcfi_target.emit_type_id_instruction)
+    kcfi_target.emit_type_id_instruction (file, type_id);
+
+  /* Mark end of __cfi_ symbol and emit size directive.  */
+  char cfi_end_label[256];
+  snprintf (cfi_end_label, sizeof(cfi_end_label), ".Lcfi_func_end_%s", fname);
+  ASM_OUTPUT_LABEL (file, cfi_end_label);
+
+  ASM_OUTPUT_MEASURED_SIZE (file, cfi_symbol_name);
+}
+
+void
+kcfi_emit_preamble_if_needed (FILE *file, tree decl,
+			      bool is_patchable_context,
+			      HOST_WIDE_INT prefix_nops,
+			      const char *actual_fname)
+{
+  /* Check if KCFI is enabled and function needs preamble.  */
+  if (!function_needs_kcfi_preamble (decl))
+    return;
+
+  /* Use actual function name if provided, otherwise fall back to DECL_ASSEMBLER_NAME.  */
+  const char *fname = actual_fname ? actual_fname : IDENTIFIER_POINTER (DECL_ASSEMBLER_NAME (decl));
+
+  /* Determine if we should emit here based on context.  */
+  bool has_patchable_entries = parse_patchable_function_entry_config ();
+
+  if (is_patchable_context && has_patchable_entries)
+    {
+      /* Use the provided prefix_nops parameter.  */
+    }
+  else if (!is_patchable_context && !has_patchable_entries)
+    {
+      /* Emit for standard non-patchable functions.  */
+      prefix_nops = 0;
+    }
+  else
+    {
+      /* Skip to avoid duplication:
+	 - Patchable context but no global patchable config
+	 - Non-patchable context but has global patchable config.  */
+      return;
+    }
+
+  kcfi_emit_cfi_preamble (file, decl, prefix_nops, fname);
+}
+
+/* KCFI Final Instrumentation Pass - Post-Optimization Implementation
+
+   This pass runs after all optimizations to insert KCFI checks immediately
+   before indirect calls/jumps, solving the fundamental problem where
+   optimization would insert code between KCFI checks and their protected
+   indirect transfers.  */
+
+namespace {
+
+const pass_data pass_data_kcfi_final_instrumentation =
+{
+  RTL_PASS,                    /* type */
+  "kcfi_final_instrumentation", /* name */
+  OPTGROUP_NONE,              /* optinfo_flags */
+  TV_NONE,                    /* tv_id */
+  0,                          /* properties_required */
+  0,                          /* properties_provided */
+  0,                          /* properties_destroyed */
+  0,                          /* todo_flags_start */
+  0,                          /* todo_flags_finish */
+};
+
+class pass_kcfi_final_instrumentation : public rtl_opt_pass
+{
+public:
+  pass_kcfi_final_instrumentation (gcc::context *ctxt)
+    : rtl_opt_pass (pass_data_kcfi_final_instrumentation, ctxt)
+  {}
+
+  /* opt_pass methods: */
+  bool gate (function *) final override
+  {
+    /* Note: Target KCFI support is validated in toplev.cc during option processing.
+       If the target doesn't provide gen_kcfi_checked_call, compilation stops with
+       a "sorry" message before any passes run.  */
+    return sanitize_flags_p (SANITIZE_KCFI);
+  }
+
+  unsigned int execute (function *) final override;
+};
+
+/* Check if an RTL instruction is an indirect call/jump marked for KCFI.  */
+static bool
+is_marked_indirect_transfer (rtx_insn *insn, uint32_t *type_id)
+{
+  if (!insn || (!CALL_P (insn) && !JUMP_P (insn)))
+    return false;
+
+  /* Check for KCFI type ID note.  */
+  rtx note = find_reg_note (insn, REG_CALL_KCFI_TYPE, NULL_RTX);
+  if (!note)
+    return false;
+
+  rtx type_rtx = XEXP (note, 0);
+  if (!CONST_INT_P (type_rtx))
+    return false;
+
+  *type_id = (uint32_t) INTVAL (type_rtx);
+
+  /* Verify it's actually an indirect transfer.  */
+  rtx pattern = PATTERN (insn);
+
+  if (CALL_P (insn))
+    {
+      /* Handle call patterns.  */
+      if (GET_CODE (pattern) == CALL)
+	{
+	  rtx target = XEXP (pattern, 0);
+	  return GET_CODE (target) == MEM;
+	}
+      else if (GET_CODE (pattern) == SET)
+	{
+	  rtx src = SET_SRC (pattern);
+	  if (GET_CODE (src) == CALL)
+	    {
+	      rtx target = XEXP (src, 0);
+	      return GET_CODE (target) == MEM;
+	    }
+	}
+      else if (GET_CODE (pattern) == PARALLEL)
+	{
+	  for (int i = 0; i < XVECLEN (pattern, 0); i++)
+	    {
+	      rtx elem = XVECEXP (pattern, 0, i);
+	      if (GET_CODE (elem) == CALL
+		  || (GET_CODE (elem) == SET && GET_CODE (SET_SRC (elem)) == CALL))
+		{
+		  rtx call_rtx = (GET_CODE (elem) == SET) ? SET_SRC (elem) : elem;
+		  rtx target = XEXP (call_rtx, 0);
+		  return GET_CODE (target) == MEM;
+		}
+	    }
+	}
+    }
+  else if (JUMP_P (insn))
+    {
+      /* Handle jump patterns.  */
+      if (GET_CODE (pattern) == SET)
+	{
+	  rtx src = SET_SRC (pattern);
+	  if (GET_CODE (src) == MEM)  /* Direct indirect jump.  */
+	    return true;
+	  /* Could also handle other indirect jump patterns here.  */
+	}
+    }
+
+  return false;
+}
+
+/* Replace marked indirect transfer with KCFI-protected version.  */
+unsigned int
+pass_kcfi_final_instrumentation::execute (function *fun)
+{
+  basic_block bb;
+
+  /* Scan all basic blocks for marked indirect transfers.  */
+  FOR_EACH_BB_FN (bb, fun)
+    {
+      rtx_insn *insn, *next_insn;
+
+      /* Use safe iteration since we'll be modifying the instruction stream.  */
+      for (insn = BB_HEAD (bb); insn && insn != NEXT_INSN (BB_END (bb)); insn = next_insn)
+	{
+	  next_insn = NEXT_INSN (insn);
+
+	  uint32_t type_id;
+	  if (is_marked_indirect_transfer (insn, &type_id))
+	    {
+	      /* Extract target address from the call instruction.  */
+	      rtx target_addr = kcfi_find_call_target (insn);
+	      if (!target_addr)
+		{
+		  error ("KCFI: cannot find target for indirect call");
+		  gcc_unreachable ();
+		}
+
+	      HOST_WIDE_INT prefix_nops = get_current_function_patchable_prefix_nops ();
+
+	      /* Generate bundled KCFI checked call.  */
+	      start_sequence ();
+
+	      /* Pass the target as-is to the RTL pattern, which will handle
+		 moving non-register targets to a register internally if needed.  */
+	      rtx bundled_call = kcfi_target.gen_kcfi_checked_call (insn, target_addr, type_id, prefix_nops);
+	      if (!bundled_call)
+		{
+		  error ("KCFI: instruction sequence creation failed");
+		  gcc_unreachable ();
+		}
+
+	      /* Emit as call_insn, not generic insn.  */
+	      emit_call_insn (bundled_call);
+	      rtx replacement_seq = get_insns ();
+	      if (!replacement_seq)
+		{
+		  error ("KCFI: instruction sequence insertion failed");
+		  gcc_unreachable ();
+		}
+
+	      end_sequence ();
+
+	      /* Check if original was a sibling call and preserve that flag.  */
+	      bool was_sibcall = CALL_P (insn) && SIBLING_CALL_P (insn);
+
+	      /* Replace the original call entirely with bundled version.  */
+	      rtx_insn *new_insn = emit_insn_before (replacement_seq, insn);
+
+	      /* If original was a sibling call, mark the new instruction as such.  */
+	      if (was_sibcall && new_insn && CALL_P (new_insn))
+		SIBLING_CALL_P (new_insn) = 1;
+
+	      set_insn_deleted (insn);  /* Mark original call as deleted.  */
+	    }
+	}
+    }
+
+  return 0;
+}
+
+} // anon namespace
+
+rtl_opt_pass *
+make_pass_kcfi_final_instrumentation (gcc::context *ctxt)
+{
+  return new pass_kcfi_final_instrumentation (ctxt);
+}
+
+/* KCFI GIMPLE pass implementation.  */
+
+static bool
+gate_kcfi (void)
+{
+  return sanitize_flags_p (SANITIZE_KCFI);
+}
+
+/* Create a KCFI wrapper function type that embeds the type ID.  */
+static tree
+create_kcfi_wrapper_type (tree original_fn_type, uint32_t type_id)
+{
+  /* Create a unique type name incorporating the type ID.  */
+  char wrapper_name[64];
+  snprintf (wrapper_name, sizeof (wrapper_name), "__kcfi_wrapper_%x", type_id);
+
+  /* Build a new function type that's structurally identical but nominally different.  */
+  tree wrapper_type = build_function_type (TREE_TYPE (original_fn_type),
+					   TYPE_ARG_TYPES (original_fn_type));
+
+  /* Set the type name to make it distinct.  */
+  TYPE_NAME (wrapper_type) = get_identifier (wrapper_name);
+
+  /* Attach kcfi_type_id attribute to the original function type for cfgexpand.cc */
+  tree attr_name = get_identifier ("kcfi_type_id");
+  tree attr_value = build_int_cst (unsigned_type_node, type_id);
+  tree attr = build_tree_list (attr_name, attr_value);
+  TYPE_ATTRIBUTES (original_fn_type) = chainon (TYPE_ATTRIBUTES (original_fn_type), attr);
+
+  return wrapper_type;
+}
+
+/* Replace indirect calls with KCFI wrapper types for anti-merging and clobber tracking.  */
+static unsigned int
+kcfi_instrument (void)
+{
+  basic_block bb;
+
+  FOR_EACH_BB_FN (bb, cfun)
+    {
+      gimple_stmt_iterator gsi;
+      for (gsi = gsi_start_bb (bb); !gsi_end_p (gsi); gsi_next (&gsi))
+	{
+	  gimple *stmt = gsi_stmt (gsi);
+
+	  if (is_gimple_call (stmt))
+	    {
+	      gcall *call_stmt = as_a <gcall *> (stmt);
+
+	      // Skip internal calls - we only instrument indirect calls
+	      if (gimple_call_internal_p (call_stmt))
+		{
+		  continue;
+		}
+
+	      tree fndecl = gimple_call_fndecl (call_stmt);
+
+	      // Only process indirect calls (no fndecl)
+	      if (!fndecl)
+		{
+		  tree fn = gimple_call_fn (call_stmt);
+		  if (fn && is_kcfi_indirect_call (fn))
+		    {
+		      // Get the function type to compute KCFI type ID
+		      tree fn_type = gimple_call_fntype (call_stmt);
+		      gcc_assert (fn_type);
+		      if (TREE_CODE (fn_type) == FUNCTION_TYPE)
+			{
+			  uint32_t type_id = compute_kcfi_type_id (fn_type);
+
+			  // Create KCFI wrapper type for this call
+			  tree wrapper_type = create_kcfi_wrapper_type (fn_type, type_id);
+
+			  // Create a temporary variable for the wrapped function pointer
+			  tree wrapper_ptr_type = build_pointer_type (wrapper_type);
+			  tree wrapper_tmp = create_tmp_var (wrapper_ptr_type, "kcfi_wrapper");
+
+			  // Create assignment: wrapper_tmp = (wrapper_ptr_type) fn
+			  tree cast_expr = build1 (NOP_EXPR, wrapper_ptr_type, fn);
+			  gimple *cast_stmt = gimple_build_assign (wrapper_tmp, cast_expr);
+			  gsi_insert_before (&gsi, cast_stmt, GSI_SAME_STMT);
+
+			  // Update the call to use the wrapped function pointer
+			  gimple_call_set_fn (call_stmt, wrapper_tmp);
+			}
+		    }
+		}
+	    }
+	}
+    }
+
+  return 0;
+}
+
+namespace {
+
+const pass_data pass_data_kcfi =
+{
+  GIMPLE_PASS, /* type */
+  "kcfi", /* name */
+  OPTGROUP_NONE, /* optinfo_flags */
+  TV_NONE, /* tv_id */
+  ( PROP_ssa | PROP_cfg | PROP_gimple_leh ), /* properties_required */
+  0, /* properties_provided */
+  0, /* properties_destroyed */
+  0, /* todo_flags_start */
+  TODO_update_ssa, /* todo_flags_finish */
+};
+
+class pass_kcfi : public gimple_opt_pass
+{
+public:
+  pass_kcfi (gcc::context *ctxt)
+    : gimple_opt_pass (pass_data_kcfi, ctxt)
+  {}
+
+  /* opt_pass methods: */
+  opt_pass * clone () final override { return new pass_kcfi (m_ctxt); }
+  bool gate (function *) final override
+  {
+    return gate_kcfi ();
+  }
+  unsigned int execute (function *) final override
+  {
+    return kcfi_instrument ();
+  }
+
+}; // class pass_kcfi
+
+} // anon namespace
+
+gimple_opt_pass *
+make_pass_kcfi (gcc::context *ctxt)
+{
+  return new pass_kcfi (ctxt);
+}
+
+namespace {
+
+const pass_data pass_data_kcfi_O0 =
+{
+  GIMPLE_PASS, /* type */
+  "kcfi0", /* name */
+  OPTGROUP_NONE, /* optinfo_flags */
+  TV_NONE, /* tv_id */
+  ( PROP_ssa | PROP_cfg | PROP_gimple_leh ), /* properties_required */
+  0, /* properties_provided */
+  0, /* properties_destroyed */
+  0, /* todo_flags_start */
+  TODO_update_ssa, /* todo_flags_finish */
+};
+
+class pass_kcfi_O0 : public gimple_opt_pass
+{
+public:
+  pass_kcfi_O0 (gcc::context *ctxt)
+    : gimple_opt_pass (pass_data_kcfi_O0, ctxt)
+  {}
+
+  /* opt_pass methods: */
+  bool gate (function *) final override
+    {
+      return !optimize && gate_kcfi ();
+    }
+  unsigned int execute (function *) final override
+  {
+    return kcfi_instrument ();
+  }
+
+}; // class pass_kcfi_O0
+
+} // anon namespace
+
+gimple_opt_pass *
+make_pass_kcfi_O0 (gcc::context *ctxt)
+{
+  return new pass_kcfi_O0 (ctxt);
+}
diff --git a/gcc/opts.cc b/gcc/opts.cc
index 5fd86aa89adb..ab74414b9c5b 100644
--- a/gcc/opts.cc
+++ b/gcc/opts.cc
@@ -2168,6 +2168,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =
   SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true, true),
   SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true, true),
   SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false, false),
+  SANITIZER_OPT (kcfi, SANITIZE_KCFI, false, true),
   SANITIZER_OPT (all, ~0ULL, true, true),
 #undef SANITIZER_OPT
   { NULL, 0ULL, 0UL, false, false }
diff --git a/gcc/passes.cc b/gcc/passes.cc
index a33c8d924a52..4c6ceac740ff 100644
--- a/gcc/passes.cc
+++ b/gcc/passes.cc
@@ -63,6 +63,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "diagnostic-core.h" /* for fnotice */
 #include "stringpool.h"
 #include "attribs.h"
+#include "kcfi.h"
 
 /* Reserved TODOs */
 #define TODO_verify_il			(1u << 31)
diff --git a/gcc/passes.def b/gcc/passes.def
index d528a0477d9a..d4c84ca7064d 100644
--- a/gcc/passes.def
+++ b/gcc/passes.def
@@ -275,6 +275,7 @@ along with GCC; see the file COPYING3.  If not see
       NEXT_PASS (pass_sink_code, false /* unsplit edges */);
       NEXT_PASS (pass_sancov);
       NEXT_PASS (pass_asan);
+      NEXT_PASS (pass_kcfi);
       NEXT_PASS (pass_tsan);
       NEXT_PASS (pass_dse, true /* use DR analysis */);
       NEXT_PASS (pass_dce, false /* update_address_taken_p */, false /* remove_unused_locals */);
@@ -443,6 +444,7 @@ along with GCC; see the file COPYING3.  If not see
   NEXT_PASS (pass_sancov_O0);
   NEXT_PASS (pass_lower_switch_O0);
   NEXT_PASS (pass_asan_O0);
+  NEXT_PASS (pass_kcfi_O0);
   NEXT_PASS (pass_tsan_O0);
   NEXT_PASS (pass_musttail);
   NEXT_PASS (pass_sanopt);
@@ -563,6 +565,7 @@ along with GCC; see the file COPYING3.  If not see
 	  NEXT_PASS (pass_delay_slots);
 	  NEXT_PASS (pass_split_for_shorten_branches);
 	  NEXT_PASS (pass_convert_to_eh_region_ranges);
+	  NEXT_PASS (pass_kcfi_final_instrumentation);
 	  NEXT_PASS (pass_shorten_branches);
 	  NEXT_PASS (pass_set_nothrow_function_flags);
 	  NEXT_PASS (pass_dwarf2_frame);
diff --git a/gcc/recog.cc b/gcc/recog.cc
index 67d7fa630692..127524cfb4e2 100644
--- a/gcc/recog.cc
+++ b/gcc/recog.cc
@@ -4026,6 +4026,7 @@ peep2_attempt (basic_block bb, rtx_insn *insn, int match_len, rtx_insn *attempt)
 	  case REG_SETJMP:
 	  case REG_TM:
 	  case REG_CALL_NOCF_CHECK:
+	  case REG_CALL_KCFI_TYPE:
 	    add_reg_note (new_insn, REG_NOTE_KIND (note),
 			  XEXP (note, 0));
 	    break;
diff --git a/gcc/reg-notes.def b/gcc/reg-notes.def
index 68e137ceccaa..27924ee8afda 100644
--- a/gcc/reg-notes.def
+++ b/gcc/reg-notes.def
@@ -251,5 +251,11 @@ REG_NOTE (UNTYPED_CALL)
    compiler when the option -fcf-protection=branch is specified.  */
 REG_NOTE (CALL_NOCF_CHECK)
 
+/* Contains the expected KCFI type ID for an indirect call instruction.
+   This note carries the 32-bit type identifier that should match the
+   type ID stored in the function preamble.  Used by KCFI (Kernel Control
+   Flow Integrity) to validate indirect call targets at runtime.  */
+REG_NOTE (CALL_KCFI_TYPE)
+
 /* The values passed to callee, for debuginfo purposes.  */
 REG_NOTE (CALL_ARG_LOCATION)
diff --git a/gcc/targhooks.cc b/gcc/targhooks.cc
index e723bbbc4df6..7edd3d8619af 100644
--- a/gcc/targhooks.cc
+++ b/gcc/targhooks.cc
@@ -77,6 +77,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "calls.h"
 #include "expr.h"
 #include "output.h"
+#include "kcfi.h"
 #include "common/common-target.h"
 #include "reload.h"
 #include "intl.h"
@@ -2203,7 +2204,11 @@ default_compare_by_pieces_branch_ratio (machine_mode)
    the location of the NOPs will be recorded in a special object section
    called "__patchable_function_entries".  This routine may be called
    twice per function to put NOPs before and after the function
-   entry.  */
+   entry.
+
+   KCFI Integration: When KCFI is enabled and this is prefix emission (record_p = true),
+   this function will emit the KCFI preamble (symbols, NOPs, movl) before the prefix NOPs
+   to ensure correct memory layout per KCFI specification.  */
 
 void
 default_print_patchable_function_entry (FILE *file,
@@ -2219,6 +2224,42 @@ default_print_patchable_function_entry (FILE *file,
   code_num = recog_memoized (my_nop);
   nop_templ = get_insn_template (code_num, my_nop);
 
+  /* KCFI Integration for prefix emission.  */
+  bool kcfi_handled = false;
+  if (record_p && current_function_decl)
+    {
+      /* Parse patchable function entry configuration to get prefix NOPs.  */
+      HOST_WIDE_INT total_nops = patch_area_size;
+      HOST_WIDE_INT prefix_nops = 0;
+
+      /* Check for function-specific patchable_function_entry attribute.  */
+      tree patchable_attr = lookup_attribute ("patchable_function_entry",
+					     DECL_ATTRIBUTES (current_function_decl));
+      if (patchable_attr)
+	{
+	  tree pp_val = TREE_VALUE (patchable_attr);
+	  total_nops = tree_to_uhwi (TREE_VALUE (pp_val));
+	  if (TREE_CHAIN (pp_val))
+	    prefix_nops = tree_to_uhwi (TREE_VALUE (TREE_CHAIN (pp_val)));
+	}
+      else
+	{
+	  /* Use global configuration if no function-specific attribute.  */
+	  HOST_WIDE_INT patch_area_entry;
+	  parse_and_check_patch_area (flag_patchable_function_entry, false,
+				      &total_nops, &patch_area_entry);
+	  prefix_nops = patch_area_entry;
+	}
+
+      /* Use centralized KCFI manager for patchable context.  */
+      if (prefix_nops > 0 && patch_area_size == (unsigned HOST_WIDE_INT)prefix_nops)
+	{
+	  kcfi_emit_preamble_if_needed (file, current_function_decl, true, prefix_nops, NULL);
+	  kcfi_handled = true;
+	}
+    }
+
+  /* Standard patchable function entry handling.  */
   if (record_p && targetm_common.have_named_sections)
     {
       char buf[256];
@@ -2249,9 +2290,16 @@ default_print_patchable_function_entry (FILE *file,
       ASM_OUTPUT_LABEL (file, buf);
     }
 
+  /* Emit the patchable NOPs.  */
   unsigned i;
   for (i = 0; i < patch_area_size; ++i)
     output_asm_insn (nop_templ, NULL);
+
+  /* Mark that KCFI preamble was handled to prevent duplication in ix86_asm_output_function_label.  */
+  if (kcfi_handled)
+    {
+      mark_kcfi_preamble_emitted ();
+    }
 }
 
 bool
diff --git a/gcc/toplev.cc b/gcc/toplev.cc
index 70dbb3e717f6..04331947b9da 100644
--- a/gcc/toplev.cc
+++ b/gcc/toplev.cc
@@ -67,6 +67,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "attribs.h"
 #include "asan.h"
 #include "tsan.h"
+#include "kcfi.h"
 #include "plugin.h"
 #include "context.h"
 #include "pass_manager.h"
@@ -524,6 +525,7 @@ compile_file (void)
       insn_locations_init ();
       targetm.asm_out.code_end ();
 
+
       /* Do dbx symbols.  */
       timevar_push (TV_SYMOUT);
 
@@ -1733,6 +1735,12 @@ process_options ()
 		  "requires %<-fno-exceptions%>");
     }
 
+  if (flag_sanitize & SANITIZE_KCFI)
+    {
+      if (!kcfi_target.gen_kcfi_checked_call)
+	sorry ("%<-fsanitize=kcfi%> not supported by this target");
+    }
+
   HOST_WIDE_INT patch_area_size, patch_area_start;
   parse_and_check_patch_area (flag_patchable_function_entry, false,
 			      &patch_area_size, &patch_area_start);
diff --git a/gcc/varasm.cc b/gcc/varasm.cc
index 000ad9e26f6f..9c4e3c223159 100644
--- a/gcc/varasm.cc
+++ b/gcc/varasm.cc
@@ -57,6 +57,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "attribs.h"
 #include "asan.h"
 #include "rtl-iter.h"
+#include "kcfi.h"
 #include "file-prefix-map.h" /* remap_debug_filename()  */
 #include "alloc-pool.h"
 #include "toplev.h"
@@ -2210,6 +2211,10 @@ assemble_start_function (tree decl, const char *fnname)
   ASM_OUTPUT_FUNCTION_LABEL (asm_out_file, fnname, current_function_decl);
 #endif /* ASM_DECLARE_FUNCTION_NAME */
 
+  /* KCFI type ID symbols are only emitted for external function declarations,
+     handled by assemble_external_real().  Function definitions do not emit
+     __kcfi_typeid symbols.  */
+
   /* And the area after the label.  Record it if we haven't done so yet.  */
   if (patch_area_size > patch_area_entry)
     targetm.asm_out.print_patchable_function_entry (asm_out_file,
@@ -2752,6 +2757,19 @@ assemble_external_real (tree decl)
       /* Some systems do require some output.  */
       SYMBOL_REF_USED (XEXP (rtl, 0)) = 1;
       ASM_OUTPUT_EXTERNAL (asm_out_file, decl, XSTR (XEXP (rtl, 0), 0));
+
+      /* Emit KCFI type ID symbol for external function declarations that are address-taken.  */
+      struct cgraph_node *node = (TREE_CODE (decl) == FUNCTION_DECL) ? cgraph_node::get (decl) : NULL;
+      if (flag_sanitize & SANITIZE_KCFI
+	  && TREE_CODE (decl) == FUNCTION_DECL
+	  && !DECL_INITIAL (decl)  /* Only for external declarations (no function body) */
+	  && node && node->address_taken)  /* Use direct cgraph analysis for address-taken check.  */
+	{
+	  const char *name = XSTR (XEXP (rtl, 0), 0);
+	  /* Strip any encoding prefixes like '*' from symbol name.  */
+	  name = targetm.strip_name_encoding (name);
+	  emit_kcfi_typeid_symbol (asm_out_file, decl, name);
+	}
     }
 }
 #endif
-- 
2.34.1

