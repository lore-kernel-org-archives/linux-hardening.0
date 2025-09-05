Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAF41760
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757031859; cv=none; b=CmyklpvjuQoxcvfKKt1HbZw9UxheJoMjSQkjhdcauT/CnI9MfZySRxxLCggIPDcNSgykqak1rnPIXyf7TYFVrxW2lo5b+n1g3FOKXxGHiaKiYGPwsqo1gx3CXwYnisaywjF6nrUa5dqRL+V0lTHUhMjZ35VbDYE4/dMLaHdqcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757031859; c=relaxed/simple;
	bh=zmrpENzCFEGEObG++Cm8iHqXZoDrIv6JleKtO6sU8Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c0nMeoR5EI93+/VcJ1n/EMNnrNRjqDorNStBoFX7uHhpwnNsC9XfsrX6cXK61nPtpYCfvvg/Msl+hnMciZsAow3LuPZwuLBqKEPU/SkdJJzmL782713enFx3e9ltsiePbc+GBetV7T/ZLilMji8mwFVEXzso8j0l9rUYqk+NeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvieQ+Dh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvieQ+Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4CEC4CEF4;
	Fri,  5 Sep 2025 00:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757031859;
	bh=zmrpENzCFEGEObG++Cm8iHqXZoDrIv6JleKtO6sU8Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvieQ+DhIkL31IODsPRQpISkSa+yHhvA6RsjlGs0cEAiV9DGtfFbaL3y+smmBOuea
	 iQHWvSUN/fS7/dcmzZo24VQYUtjiW8AGPI4mtJjUBfo6PR5pbrr/Zg0XdSQ8KQbSXq
	 L41lNZd38hSv4HOtpRBdXP4EMW+lrJmlf1AjmJqy09nmlU4iFZFyJxID8qLN9NM93k
	 xjAtvtbqRa+1U/SObNXhk17yJGyTP7nRAw0hDY1eCP7wcPolBNoq4hmbFMbkhvZOXo
	 GCVxBYjq/TugTDyIWZvZYLIprX1j1c2Loc3wJbwWYDKe/4VjRgyhOHI41JbKfTHngn
	 yDdGVhg+LQ63w==
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
Subject: [PATCH v2 2/7] kcfi: Add core Kernel Control Flow Integrity infrastructure
Date: Thu,  4 Sep 2025 17:24:10 -0700
Message-Id: <20250905002418.464643-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905001157.it.269-kees@kernel.org>
References: <20250905001157.it.269-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=53185; i=kees@kernel.org; h=from:subject; bh=zmrpENzCFEGEObG++Cm8iHqXZoDrIv6JleKtO6sU8Zg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm7dNcKbKpe67rsVSX727btxskPLZbZqkqn8N6rFz9iv 83yaezBjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlomjAy/LH52N+Y3WQzxb74 XphPUfSEe1tevhR+3fj5WpDR9U1vZjP8r7vLtr/s2iT573/S1Df7Tclb1p7ynItr0ype12crkg9 eYwYA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Implements the Linux Kernel Control Flow Integrity ABI, which provides a
function prototype based forward edge control flow integrity protection
by instrumenting every indirect call to check for a hash value before
the target function address. If the hash at the call site and the hash
at the target do not match, execution will trap.

See the start of kcfi.cc for design details.

gcc/ChangeLog:

	* kcfi.h: New file with KCFI public interface declarations.
	* kcfi.cc: New file implementing Kernel Control Flow Integrity
	infrastructure.
	* Makefile.in (OBJS): Add kcfi.o.
	* flag-types.h (enum sanitize_code): Add SANITIZE_KCFI.
	* gimple.h (enum gf_mask): Add GF_CALL_INLINED_FROM_KCFI_NOSANTIZE.
	(gimple_call_set_inlined_from_kcfi_nosantize): New function.
	(gimple_call_inlined_from_kcfi_nosantize_p): New function.
	* tree-pass.h Add kcfi passes.
	* c-family/c-attribs.cc: Include asan.h.
	(handle_patchable_function_entry_attribute): Add error for using
	patchable_function_entry attribute with -fsanitize=kcfi.
	* df-scan.cc (df_uses_record): Add KCFI case to handle KCFI RTL
	patterns and process wrapped RTL.
	* doc/invoke.texi (fsanitize=kcfi): Add documentation for KCFI
	sanitizer option.
	* doc/tm.texi.in: Add Kernel Control Flow Integrity section with
	TARGET_KCFI_SUPPORTED, TARGET_KCFI_MASK_TYPE_ID,
	TARGET_KCFI_EMIT_TYPE_ID hooks.
	* doc/tm.texi: Regenerate.
	* final.cc (call_from_call_insn): Add KCFI case to handle
	KCFI-wrapped calls.
	* opts.cc (sanitizer_opts): Add kcfi entry.
	* passes.cc: Include kcfi.h.
	* passes.def: Add KCFI passes (GIMPLE and IPA).
	* rtl.def (KCFI): Add new RTL code for KCFI instrumentation.
	* rtlanal.cc (rtx_cost): Add KCFI case.
	* target.def: Add KCFI target hooks.
	* toplev.cc (process_options): Add KCFI option processing.
	* tree-inline.cc: Include kcfi.h and asan.h.
	(copy_bb): Handle KCFI no_sanitize attribute propagation during
	inlining.
	* varasm.cc (assemble_start_function): Emit KCFI preambles.
	(assemble_external_real): Emit KCFI typeid symbols.
	(default_elf_asm_named_section): Handle .kcfi_traps using
	SECTION_LINK_ORDER flag.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/kcfi.h                |  47 +++
 gcc/kcfi.cc               | 764 ++++++++++++++++++++++++++++++++++++++
 gcc/Makefile.in           |   1 +
 gcc/flag-types.h          |   2 +
 gcc/gimple.h              |  21 ++
 gcc/tree-pass.h           |   3 +
 gcc/c-family/c-attribs.cc |  12 +
 gcc/df-scan.cc            |   6 +
 gcc/doc/invoke.texi       |  35 ++
 gcc/doc/tm.texi           |  31 ++
 gcc/doc/tm.texi.in        |  12 +
 gcc/final.cc              |   3 +
 gcc/opts.cc               |   1 +
 gcc/passes.cc             |   1 +
 gcc/passes.def            |   3 +
 gcc/rtl.def               |   6 +
 gcc/rtlanal.cc            |   5 +
 gcc/target.def            |  38 ++
 gcc/toplev.cc             |  11 +
 gcc/tree-inline.cc        |  10 +
 gcc/varasm.cc             |  46 ++-
 21 files changed, 1048 insertions(+), 10 deletions(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/kcfi.cc

diff --git a/gcc/kcfi.h b/gcc/kcfi.h
new file mode 100644
index 000000000000..17ec59a1a3b8
--- /dev/null
+++ b/gcc/kcfi.h
@@ -0,0 +1,47 @@
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
+/* Common helper for RTL patterns to emit .kcfi_traps section entry.
+   Call after emitting trap label and instruction with the trap symbol
+   reference.  */
+extern void kcfi_emit_traps_section (FILE *file, rtx trap_label_sym);
+
+/* Extract KCFI type ID from current GIMPLE statement.  */
+extern rtx kcfi_get_call_type_id (void);
+
+/* Emit KCFI type ID symbol for address-taken functions.  */
+extern void emit_kcfi_typeid_symbol (FILE *asm_file, tree decl,
+				     const char *name);
+
+/* Emit KCFI preamble.  */
+extern void kcfi_emit_preamble (FILE *file, tree decl,
+				const char *actual_fname);
+
+/* For calculating callsite offset.  */
+extern HOST_WIDE_INT kcfi_patchable_entry_prefix_nops;
+
+#endif /* GCC_KCFI_H */
diff --git a/gcc/kcfi.cc b/gcc/kcfi.cc
new file mode 100644
index 000000000000..1ae0602eac7b
--- /dev/null
+++ b/gcc/kcfi.cc
@@ -0,0 +1,764 @@
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
+/* KCFI ABI Design:
+
+The Linux Kernel Control Flow Integrity ABI provides a function prototype
+based forward edge control flow integrity protection by instrumenting
+every indirect call to check for a hash value before the target function
+address. If the hash at the call site and the hash at the target do not
+match, execution will trap.
+
+The general CFI ideas are discussed here, but focuses more on a CFG
+analysis to construct valid call destinations, which tends to require LTO:
+https://users.soe.ucsc.edu/~abadi/Papers/cfi-tissec-revised.pdf
+
+Later refinement for using jump tables (constructed via CFG analysis
+during LTO) was proposed here:
+https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-paper-tice.pdf
+
+Linux used the above implementation from 2018 to 2022:
+https://android-developers.googleblog.com/2018/10/control-flow-integrity-in-android-kernel.html
+but the corner cases for target addresses not being the actual functions
+(i.e. pointing into the jump table) was a continual source of problems,
+and generating the jump tables required full LTO, which had its own set
+of problems.
+
+Looking at function prototypes as the source of call validity was
+presented here, though still relied on LTO:
+https://www.blackhat.com/docs/asia-17/materials/asia-17-Moreira-Drop-The-Rop-Fine-Grained-Control-Flow-Integrity-For-The-Linux-Kernel-wp.pdf
+
+The KCFI approach built on the function-prototype idea, but avoided
+needing LTO, and could be further updated to deal with CPU errata
+(retpolines, etc):
+https://lpc.events/event/16/contributions/1315/
+
+KCFI has a number of specific constraints. Some are tied to the
+backend architecture, which are covered in arch-specific code.
+The constraints are:
+
+- The KCFI scheme generates a unique 32-bit hash for each unique function
+  prototype, allowing for indirect call sites to verify that they are
+  calling into a matching _type_ of function pointer. This changes the
+  semantics of some optimization logic because now indirect calls to
+  different types cannot be merged. For example:
+
+    if (p->func_type_1)
+	return p->func_type_1();
+    if (p->func_type_2)
+	return p->func_type_2();
+
+  In final asm, the optimizer may collapse the second indirect call
+  into a jump to the first indirect call once it has loaded the function
+  pointer. KCFI must block cross-type merging otherwise there will be a
+  single KCFI check happening for only 1 type but being used by 2 target
+  types. The distinguishing characteristic for call merging becomes the
+  type, not the address/register usage.
+
+- The check-call instruction sequence must be treated a single unit: it
+  cannot be rearranged or split or optimized. The pattern is that
+  indirect calls, "call *$target", get converted into:
+
+    mov $target_expression, %target ; only present if the expression was
+                                    ; not already %target register
+    load -$offset(%target), %tmp    ; load the typeid hash at target
+    cmp $hash, %tmp                 ; compare expected typeid with loaded
+    je .Lcheck_passed               ; jump to the indirect call
+  .Lkcfi_trap$N:                    ; label of trap insn
+    trap                            ; trap on failure, but arranged so
+                                    ; "permissive mode" falls through
+  .Lkcfi_call$N:                    ; label of call insn
+    call *%target                   ; actual indirect call
+
+  This pattern of call immediately after trap provides for the
+  "permissive" checking mode automatically: the trap gets handled,
+  a warning emitted, and then execution continues after the trap to
+  the call.
+
+- KCFI check-call instrumentation must survive tail call optimization.
+  If an indirect call is turned into an indirect jump, KCFI checking
+  must still happen (but will still use the jmp).
+
+- Functions that may be called indirectly have a preamble added,
+  __cfi_$original_func_name, which contains the $hash value:
+
+    __cfi_target_func:
+      .word $hash
+    target_func:
+       [regular function entry...]
+
+- The preamble needs to interact with patchable function entry so that
+  the hash appears further away from the actual start of the function
+  (leaving the prefix NOPs of the patchable function entry unchanged).
+  This means only _globally defined_ patchable function entry is supported
+  with KCFI (indrect call sites must know in advance what the offset is,
+  which may not be possible with extern functions). For example, a "4,4"
+  patchable function entry would end up like:
+
+    __cfi_target_func:
+      .data $hash
+      nop nop nop nop
+    target_func:
+       [regular function entry...]
+
+  Architectures may need to add alignment nops prior to the hash to keep things
+  aligned for function call conventions.
+
+- External functions that are address-taken have a weak __kcfi_typeid_$funcname
+  symbol added with the hash value available so that the hash can be referenced
+  from assembly linkages, etc, where the hash values cannot be calculated (i.e
+  where C type information is missing):
+
+    .weak   __kcfi_typeid_$func
+    .set    __kcfi_typeid_$func, $hash
+
+- On architectures that do not have a good way to encode additional
+  details in their trap insn (e.g. x86_64 and riscv64), the trap location
+  is identified as a KCFI trap via a relative address offset entry
+  emitted into the .kcfi_traps section for each indirect call site's
+  trap instruction. The previous check-call example's insn sequence has
+  a section push/pop inserted between the trap and call:
+
+  ...
+  .Lkcfi_trap$N:
+    trap
+  .section	.kcfi_traps,"ao",@progbits,.text
+    .Lkcfi_entry$N:
+        .long	.Lkcfi_trap$N - .Lkcfi_entry$N
+  .text
+  .Lkcfi_call$N:
+    call *%target
+
+  For architectures that can encode immediates in their trap function
+  (e.g. aarch64 and arm32), this isn't needed: they just use immediate
+  codes that indicate a KCFI trap.
+
+- The no_sanitize("kcfi") function attribute means that the marked
+  function must not produce KCFI checking for indirect calls, and this
+  attribute must survive inlining. This is used rarely by Linux, but
+  is required to make BPF JIT trampolines work on older Linux kernel
+  versions.
+
+As a result of these constraints, there are some behavioral aspects
+that need to be preserved across the middle-end and back-end.
+
+For indirect call sites:
+
+- Keeping indirect calls from being merged (see above) by adding a
+  wrapping type so that equality was tested based on type-id.
+
+- Keeping typeid information available through to the RTL expansion
+  phase was done via a new KCFI insn that wraps CALL and the typeid.
+
+- To make sure KCFI expansion is skipped for inline functions, the
+  inlining is marked during GIMPLE with a new flag which is checked
+  during expansion.
+
+For indirect call targets:
+
+- kcfi_emit_preamble() uses function_needs_kcfi_preamble(),
+  to emit the preablem, which interacts with patchable function
+  entry to add any needed alignment.
+
+- gcc/varasm.cc, assemble_external_real() calls emit_kcfi_typeid_symbol()
+  to add the __kcfi_typeid symbols (see get_function_kcfi_type_id()
+  below).
+
+*/
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
+#include "cfgrtl.h"
+#include "asan.h"
+#include "diagnostic-core.h"
+#include "memmodel.h"
+#include "print-tree.h"
+#include "emit-rtl.h"
+#include "output.h"
+#include "builtins.h"
+#include "varasm.h"
+#include "opts.h"
+#include "mangle.h"
+#include "target.h"
+#include "flags.h"
+
+HOST_WIDE_INT kcfi_patchable_entry_prefix_nops = 0;  /* For callsite offset */
+static HOST_WIDE_INT kcfi_patchable_entry_arch_alignment_nops = 0;  /* For preamble alignment */
+
+/* Common helper for RTL patterns to emit .kcfi_traps section entry.  */
+void
+kcfi_emit_traps_section (FILE *file, rtx trap_label_sym)
+{
+  /* Generate entry label internally and get its number.  */
+  rtx entry_label = gen_label_rtx ();
+  int entry_labelno = CODE_LABEL_NUMBER (entry_label);
+
+  /* Generate entry label name with custom prefix.  */
+  char entry_name[32];
+  ASM_GENERATE_INTERNAL_LABEL (entry_name, "Lkcfi_entry", entry_labelno);
+
+  /* Save current section to restore later.  */
+  section *saved_section = in_section;
+
+  /* Use varasm infrastructure for section handling.  */
+  section *kcfi_traps_section = get_section (".kcfi_traps",
+					     SECTION_LINK_ORDER, NULL);
+  switch_to_section (kcfi_traps_section);
+
+  /* Emit entry label.  */
+  ASM_OUTPUT_LABEL (file, entry_name);
+
+  /* Generate address difference using RTL infrastructure.  */
+  rtx entry_label_sym = gen_rtx_SYMBOL_REF (Pmode, entry_name);
+  rtx addr_diff = gen_rtx_MINUS (Pmode, trap_label_sym, entry_label_sym);
+
+  /* Emit the address difference as a 4-byte value.  */
+  assemble_integer (addr_diff, 4, BITS_PER_UNIT, 1);
+
+  /* Restore the previous section.  */
+  switch_to_section (saved_section);
+}
+
+/* Compute KCFI type ID for a function declaration or function type (internal) */
+static uint32_t
+compute_kcfi_type_id (tree fntype, tree fndecl = NULL_TREE)
+{
+  gcc_assert (fntype);
+  gcc_assert (TREE_CODE (fntype) == FUNCTION_TYPE);
+
+  uint32_t type_id = hash_function_type (fntype, fndecl);
+
+  /* Apply target-specific masking if supported.  */
+  if (targetm.kcfi.mask_type_id)
+    type_id = targetm.kcfi.mask_type_id (type_id);
+
+  return type_id;
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
+/* Set KCFI type ID for a function declaration during IPA phase.
+   Fatal error if type ID is already set.  */
+static void
+set_function_kcfi_type_id (tree fndecl)
+{
+  if (!kcfi_type_id_attr)
+    kcfi_type_id_attr = get_identifier ("kcfi_type_id");
+
+  /* Fatal error if type ID already set - nothing should set it twice.  */
+  if (lookup_attribute_by_prefix ("kcfi_type_id",
+				  DECL_ATTRIBUTES (fndecl)))
+    internal_error ("KCFI type ID already set for function %qD", fndecl);
+
+  /* Compute type ID using FUNCTION_TYPE to preserve typedef information.  */
+  uint32_t type_id = compute_kcfi_type_id (TREE_TYPE (fndecl), fndecl);
+
+  tree type_id_tree = build_int_cst (unsigned_type_node, type_id);
+  tree attr_value = build_tree_list (NULL_TREE, type_id_tree);
+  tree attr = build_tree_list (kcfi_type_id_attr, attr_value);
+
+  DECL_ATTRIBUTES (fndecl) = chainon (DECL_ATTRIBUTES (fndecl), attr);
+}
+
+/* Get KCFI type ID for a function declaration during assembly output phase.
+   Fatal error if type ID was not previously set during IPA phase.  */
+static uint32_t
+get_function_kcfi_type_id (tree fndecl)
+{
+  if (!kcfi_type_id_attr)
+    kcfi_type_id_attr = get_identifier ("kcfi_type_id");
+
+  tree attr = lookup_attribute_by_prefix ("kcfi_type_id",
+					   DECL_ATTRIBUTES (fndecl));
+  if (attr && TREE_VALUE (attr) && TREE_VALUE (TREE_VALUE (attr)))
+    {
+      tree value = TREE_VALUE (TREE_VALUE (attr));
+      if (TREE_CODE (value) == INTEGER_CST)
+	return (uint32_t) TREE_INT_CST_LOW (value);
+    }
+
+  internal_error ("KCFI type ID not found for function %qD - "
+		  "should have been set during GIMPLE phase", fndecl);
+}
+
+/* Prepare the global KCFI alignment NOPs calculation.
+   Called once during IPA pass to set global variable.  */
+static void
+kcfi_prepare_alignment_nops (void)
+{
+  /* Only use global patchable-function-entry flag, not function attributes.
+     KCFI callsites cannot know about function-specific attributes.  */
+  if (flag_patchable_function_entry)
+    {
+      HOST_WIDE_INT total_nops, prefix_nops = 0;
+      parse_and_check_patch_area (flag_patchable_function_entry, false,
+				  &total_nops, &prefix_nops);
+      /* Store value for callsite offset calculation */
+      kcfi_patchable_entry_prefix_nops = prefix_nops;
+    }
+
+  /* Calculate architecture-specific alignment NOPs.
+     KCFI preamble layout:
+     __cfi_func: [alignment_nops][typeid][prefix_nops] func: [entry_nops]
+
+     The alignment NOPs ensure __cfi_func stays at proper function alignment
+     when prefix NOPs are added.  */
+  HOST_WIDE_INT arch_alignment = 0;
+
+  /* Calculate alignment NOPs based on function alignment setting.
+     Use explicit -falign-functions if set, otherwise default to 4 bytes. */
+  int alignment_bytes = 4;
+  if (align_functions.levels[0].log > 0)
+    {
+      /* Use explicit -falign-functions setting */
+      alignment_bytes = align_functions.levels[0].get_value();
+    }
+
+  /* Get typeid instruction size from target hook, default to 4 bytes */
+  int typeid_size = targetm.kcfi.emit_type_id
+                    ? targetm.kcfi.emit_type_id (NULL, 0) : 4;
+
+  /* Calculate alignment NOPs needed */
+  arch_alignment = (alignment_bytes - ((kcfi_patchable_entry_prefix_nops + typeid_size) % alignment_bytes)) % alignment_bytes;
+
+  /* Use the calculated alignment NOPs */
+  kcfi_patchable_entry_arch_alignment_nops = arch_alignment;
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
+  /* Everything else must be indirect calls needing KCFI.  */
+  return true;
+}
+
+/* Extract KCFI type ID from indirect call GIMPLE statement.
+   Returns RTX constant with type ID, or NULL_RTX if no KCFI needed.  */
+rtx
+kcfi_get_call_type_id (void)
+{
+  if (!sanitize_flags_p (SANITIZE_KCFI) || !currently_expanding_gimple_stmt)
+    return NULL_RTX;
+
+  if (!is_gimple_call (currently_expanding_gimple_stmt))
+    return NULL_RTX;
+
+  gcall *call_stmt = as_a <gcall *> (currently_expanding_gimple_stmt);
+
+  /* Only indirect calls need KCFI instrumentation.  */
+  if (gimple_call_fndecl (call_stmt))
+    return NULL_RTX;
+
+  tree fn_type = gimple_call_fntype (call_stmt);
+  if (!fn_type)
+    return NULL_RTX;
+
+  tree attr = lookup_attribute ("kcfi_type_id", TYPE_ATTRIBUTES (fn_type));
+  if (!attr || !TREE_VALUE (attr))
+    return NULL_RTX;
+
+  if (gimple_call_inlined_from_kcfi_nosantize_p (call_stmt))
+    return NULL_RTX;
+
+  uint32_t kcfi_type_id = (uint32_t) tree_to_uhwi (TREE_VALUE (attr));
+  return GEN_INT (kcfi_type_id);
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
+void
+kcfi_emit_preamble (FILE *file, tree decl, const char *actual_fname)
+{
+  /* Check if KCFI is enabled and function needs preamble.  */
+  if (!function_needs_kcfi_preamble (decl))
+    return;
+
+  /* Use actual function name if provided, otherwise fall back to DECL_ASSEMBLER_NAME.  */
+  const char *fname = actual_fname ? actual_fname
+				   : IDENTIFIER_POINTER (DECL_ASSEMBLER_NAME (decl));
+
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
+  /* Emit architecture-specific prefix NOPs.  */
+  for (int i = 0; i < kcfi_patchable_entry_arch_alignment_nops; i++)
+    {
+      fprintf (file, "\tnop\n");
+    }
+
+  /* Emit type ID bytes.  */
+  if (targetm.kcfi.emit_type_id)
+    targetm.kcfi.emit_type_id (file, type_id);
+  else
+    fprintf (file, "\t.word\t0x%08x\n", type_id);
+
+  /* Mark end of __cfi_ symbol and emit size directive.  */
+  char cfi_end_label[256];
+  snprintf (cfi_end_label, sizeof(cfi_end_label), ".Lcfi_func_end_%s", fname);
+  ASM_OUTPUT_LABEL (file, cfi_end_label);
+
+  ASM_OUTPUT_MEASURED_SIZE (file, cfi_symbol_name);
+}
+
+/* KCFI GIMPLE pass implementation.  */
+
+static bool
+gate_kcfi (void)
+{
+  /* Always process functions when KCFI is globally enabled to set type IDs.
+     Individual function processing (call instrumentation) will check no_sanitize("kcfi").  */
+  return sanitize_flags_p (SANITIZE_KCFI);
+}
+
+/* Create a KCFI wrapper function type that embeds the type ID.  */
+static tree
+create_kcfi_wrapper_type (tree original_fn_type, uint32_t type_id)
+{
+  /* Create a unique type name incorporating the type ID.  */
+  char wrapper_name[32];
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
+/* Wrap indirect calls with KCFI type for anti-merging.  */
+static unsigned int
+kcfi_instrument (void)
+{
+  /* Process current function for call instrumentation only.
+     Type ID setting is handled by the separate IPA pass.  */
+
+  basic_block bb;
+
+  FOR_EACH_BB_FN (bb, cfun)
+    {
+      gimple_stmt_iterator gsi;
+      for (gsi = gsi_start_bb (bb); !gsi_end_p (gsi); gsi_next (&gsi))
+	{
+	  gimple *stmt = gsi_stmt (gsi);
+
+	  if (!is_gimple_call (stmt))
+	    continue;
+
+	  gcall *call_stmt = as_a <gcall *> (stmt);
+
+	  // Skip internal calls - we only instrument indirect calls
+	  if (gimple_call_internal_p (call_stmt))
+	    continue;
+
+	  tree fndecl = gimple_call_fndecl (call_stmt);
+
+	  // Only process indirect calls (no fndecl)
+	  if (fndecl)
+	    continue;
+
+	  tree fn = gimple_call_fn (call_stmt);
+	  if (!is_kcfi_indirect_call (fn))
+	    continue;
+
+	  // Get the function type to compute KCFI type ID
+	  tree fn_type = gimple_call_fntype (call_stmt);
+	  gcc_assert (fn_type);
+	  if (TREE_CODE (fn_type) != FUNCTION_TYPE)
+	    continue;
+
+	  uint32_t type_id = compute_kcfi_type_id (fn_type);
+
+	  // Create KCFI wrapper type for this call
+	  tree wrapper_type = create_kcfi_wrapper_type (fn_type, type_id);
+
+	  // Create a temporary variable for the wrapped function pointer
+	  tree wrapper_ptr_type = build_pointer_type (wrapper_type);
+	  tree wrapper_tmp = create_tmp_var (wrapper_ptr_type, "kcfi_wrapper");
+
+	  // Create assignment: wrapper_tmp = (wrapper_ptr_type) fn
+	  tree cast_expr = build1 (NOP_EXPR, wrapper_ptr_type, fn);
+	  gimple *cast_stmt = gimple_build_assign (wrapper_tmp, cast_expr);
+	  gsi_insert_before (&gsi, cast_stmt, GSI_SAME_STMT);
+
+	  // Update the call to use the wrapped function pointer
+	  gimple_call_set_fn (call_stmt, wrapper_tmp);
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
+
+/* IPA pass for KCFI type ID setting - runs once per compilation unit.  */
+
+namespace {
+
+const pass_data pass_data_ipa_kcfi =
+{
+  SIMPLE_IPA_PASS, /* type */
+  "ipa_kcfi", /* name */
+  OPTGROUP_NONE, /* optinfo_flags */
+  TV_IPA_OPT, /* tv_id */
+  0, /* properties_required */
+  0, /* properties_provided */
+  0, /* properties_destroyed */
+  0, /* todo_flags_start */
+  0, /* todo_flags_finish */
+};
+
+/* Set KCFI type IDs for all functions in the compilation unit.  */
+static unsigned int
+ipa_kcfi_execute (void)
+{
+  struct cgraph_node *node;
+
+  /* Prepare global KCFI alignment NOPs calculation once for all functions.  */
+  kcfi_prepare_alignment_nops ();
+
+  /* Process all functions - both local and external.
+     This preserves typedef information using DECL_ARGUMENTS.  */
+  FOR_EACH_FUNCTION (node)
+    {
+      tree fndecl = node->decl;
+
+      /* Skip all non-NORMAL builtins (MD, FRONTEND) entirely.
+         For NORMAL builtins, skip those that lack an implicit
+	 implementation (closest way to distinguishing DEF_LIB_BUILTIN
+	 from others). E.g. we need to have typeids for memset().  */
+      if (fndecl_built_in_p (fndecl))
+        {
+          if (DECL_BUILT_IN_CLASS (fndecl) != BUILT_IN_NORMAL)
+            continue;
+          if (!builtin_decl_implicit_p (DECL_FUNCTION_CODE (fndecl)))
+            continue;
+        }
+
+      set_function_kcfi_type_id (fndecl);
+    }
+
+  return 0;
+}
+
+class pass_ipa_kcfi : public simple_ipa_opt_pass
+{
+public:
+  pass_ipa_kcfi (gcc::context *ctxt)
+    : simple_ipa_opt_pass (pass_data_ipa_kcfi, ctxt)
+  {}
+
+  /* opt_pass methods: */
+  bool gate (function *) final override
+  {
+    return sanitize_flags_p (SANITIZE_KCFI);
+  }
+
+  unsigned int execute (function *) final override
+  {
+    return ipa_kcfi_execute ();
+  }
+
+}; // class pass_ipa_kcfi
+
+} // anon namespace
+
+simple_ipa_opt_pass *
+make_pass_ipa_kcfi (gcc::context *ctxt)
+{
+  return new pass_ipa_kcfi (ctxt);
+}
diff --git a/gcc/Makefile.in b/gcc/Makefile.in
index 4c12ac68d979..84bbc4223734 100644
--- a/gcc/Makefile.in
+++ b/gcc/Makefile.in
@@ -1591,6 +1591,7 @@ OBJS = \
 	ira-emit.o \
 	ira-lives.o \
 	jump.o \
+	kcfi.o \
 	langhooks.o \
 	late-combine.o \
 	lcm.o \
diff --git a/gcc/flag-types.h b/gcc/flag-types.h
index bf681c3e8153..c3c0bc61ee3e 100644
--- a/gcc/flag-types.h
+++ b/gcc/flag-types.h
@@ -337,6 +337,8 @@ enum sanitize_code {
   SANITIZE_KERNEL_HWADDRESS = 1UL << 30,
   /* Shadow Call Stack.  */
   SANITIZE_SHADOW_CALL_STACK = 1UL << 31,
+  /* KCFI (Kernel Control Flow Integrity) */
+  SANITIZE_KCFI = 1ULL << 32,
   SANITIZE_SHIFT = SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
   SANITIZE_UNDEFINED = SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNREACHABLE
 		       | SANITIZE_VLA | SANITIZE_NULL | SANITIZE_RETURN
diff --git a/gcc/gimple.h b/gcc/gimple.h
index da32651ea017..cef915b9164f 100644
--- a/gcc/gimple.h
+++ b/gcc/gimple.h
@@ -142,6 +142,7 @@ enum gf_mask {
     GF_CALL_ALLOCA_FOR_VAR	= 1 << 5,
     GF_CALL_INTERNAL		= 1 << 6,
     GF_CALL_CTRL_ALTERING       = 1 << 7,
+    GF_CALL_INLINED_FROM_KCFI_NOSANTIZE = 1 << 8,
     GF_CALL_MUST_TAIL_CALL	= 1 << 9,
     GF_CALL_BY_DESCRIPTOR	= 1 << 10,
     GF_CALL_NOCF_CHECK		= 1 << 11,
@@ -3487,6 +3488,26 @@ gimple_call_from_thunk_p (gcall *s)
   return (s->subcode & GF_CALL_FROM_THUNK) != 0;
 }
 
+/* If INLINED_FROM_KCFI_NOSANTIZE_P is true, mark GIMPLE_CALL S as being
+   inlined from a function with no_sanitize("kcfi").  */
+
+inline void
+gimple_call_set_inlined_from_kcfi_nosantize (gcall *s, bool inlined_from_kcfi_nosantize_p)
+{
+  if (inlined_from_kcfi_nosantize_p)
+    s->subcode |= GF_CALL_INLINED_FROM_KCFI_NOSANTIZE;
+  else
+    s->subcode &= ~GF_CALL_INLINED_FROM_KCFI_NOSANTIZE;
+}
+
+/* Return true if GIMPLE_CALL S was inlined from a function with
+   no_sanitize("kcfi").  */
+
+inline bool
+gimple_call_inlined_from_kcfi_nosantize_p (const gcall *s)
+{
+  return (s->subcode & GF_CALL_INLINED_FROM_KCFI_NOSANTIZE) != 0;
+}
 
 /* If FROM_NEW_OR_DELETE_P is true, mark GIMPLE_CALL S as being a call
    to operator new or delete created from a new or delete expression.  */
diff --git a/gcc/tree-pass.h b/gcc/tree-pass.h
index 1c68a69350df..fbf235adada3 100644
--- a/gcc/tree-pass.h
+++ b/gcc/tree-pass.h
@@ -357,6 +357,8 @@ extern gimple_opt_pass *make_pass_tsan (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_tsan_O0 (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_sancov (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_sancov_O0 (gcc::context *ctxt);
+extern gimple_opt_pass *make_pass_kcfi (gcc::context *ctxt);
+extern gimple_opt_pass *make_pass_kcfi_O0 (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_lower_cf (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_refactor_eh (gcc::context *ctxt);
 extern gimple_opt_pass *make_pass_lower_eh (gcc::context *ctxt);
@@ -544,6 +546,7 @@ extern ipa_opt_pass_d *make_pass_ipa_odr (gcc::context *ctxt);
 extern ipa_opt_pass_d *make_pass_ipa_reference (gcc::context *ctxt);
 extern ipa_opt_pass_d *make_pass_ipa_pure_const (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_ipa_pta (gcc::context *ctxt);
+extern simple_ipa_opt_pass *make_pass_ipa_kcfi (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_ipa_tm (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_target_clone (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_dispatcher_calls (gcc::context *ctxt);
diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
index 1e3a94ed9493..a12cfe48772a 100644
--- a/gcc/c-family/c-attribs.cc
+++ b/gcc/c-family/c-attribs.cc
@@ -48,6 +48,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "gimplify.h"
 #include "tree-pretty-print.h"
 #include "gcc-rich-location.h"
+#include "asan.h"
 #include "gcc-urlifier.h"
 
 static tree handle_packed_attribute (tree *, tree, tree, int, bool *);
@@ -6508,6 +6509,17 @@ static tree
 handle_patchable_function_entry_attribute (tree *, tree name, tree args,
 					   int, bool *no_add_attrs)
 {
+  /* Function-specific patchable_function_entry attribute is incompatible
+     with KCFI because KCFI callsites cannot know about function-specific
+     patchable entry settings on a preamble in a different translation
+     unit.  */
+  if (sanitize_flags_p (SANITIZE_KCFI))
+    {
+      error ("%qE attribute cannot be used with %<-fsanitize=kcfi%>", name);
+      *no_add_attrs = true;
+      return NULL_TREE;
+    }
+
   for (; args; args = TREE_CHAIN (args))
     {
       tree val = TREE_VALUE (args);
diff --git a/gcc/df-scan.cc b/gcc/df-scan.cc
index 1e4c6a2a4fb5..0e9c75df48dd 100644
--- a/gcc/df-scan.cc
+++ b/gcc/df-scan.cc
@@ -2851,6 +2851,12 @@ df_uses_record (class df_collection_rec *collection_rec,
       /* If we're clobbering a REG then we have a def so ignore.  */
       return;
 
+    case KCFI:
+      /* KCFI wraps other RTL - process the wrapped RTL.  */
+      df_uses_record (collection_rec, &XEXP (x, 0), ref_type, bb, insn_info, flags);
+      /* The type ID operand (XEXP (x, 1)) doesn't contain register uses.  */
+      return;
+
     case MEM:
       df_uses_record (collection_rec,
 		      &XEXP (x, 0), DF_REF_REG_MEM_LOAD,
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 56c4fa86e346..cd70e6351a4e 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18382,6 +18382,41 @@ possible by specifying the command-line options
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
+Note that KCFI is incompatible with function-specific
+@code{patchable_function_entry} attributes because KCFI call sites
+cannot know about function-specific patchable entry settings in different
+translation units.  Only the global @option{-fpatchable-function-entry}
+command-line option is supported with KCFI.
+
+Use @option{-fdump-tree-kcfi} to examine the computed type identifiers
+and their corresponding mangled type strings during compilation.
+
 @opindex fsanitize=pointer-compare
 @item -fsanitize=pointer-compare
 Instrument comparison operation (<, <=, >, >=) with pointer operands.
diff --git a/gcc/doc/tm.texi b/gcc/doc/tm.texi
index 37642680f423..69603fdad090 100644
--- a/gcc/doc/tm.texi
+++ b/gcc/doc/tm.texi
@@ -3166,6 +3166,7 @@ This describes the stack layout and calling conventions.
 * Tail Calls::
 * Shrink-wrapping separate components::
 * Stack Smashing Protection::
+* Kernel Control Flow Integrity::
 * Miscellaneous Register Hooks::
 @end menu
 
@@ -5432,6 +5433,36 @@ should be allocated from heap memory and consumers should release them.
 The result will be pruned to cases with PREFIX if not NULL.
 @end deftypefn
 
+@node Kernel Control Flow Integrity
+@subsection Kernel Control Flow Integrity
+@cindex kernel control flow integrity
+@cindex KCFI
+
+@deftypefn {Target Hook} bool TARGET_KCFI_SUPPORTED (void)
+Return true if the target supports Kernel Control Flow Integrity (KCFI).
+This hook indicates whether the target has implemented the necessary RTL
+patterns and infrastructure to support KCFI instrumentation.  The default
+implementation returns false.
+@end deftypefn
+
+@deftypefn {Target Hook} uint32_t TARGET_KCFI_MASK_TYPE_ID (uint32_t @var{type_id})
+Apply architecture-specific masking to KCFI type ID.  This hook allows
+targets to apply bit masks or other transformations to the computed KCFI
+type identifier to match the target's specific requirements.  The default
+implementation returns the type ID unchanged.
+@end deftypefn
+
+@deftypefn {Target Hook} int TARGET_KCFI_EMIT_TYPE_ID (FILE *@var{file}, uint32_t @var{type_id})
+Emit architecture-specific type ID instruction for KCFI preambles
+and return the size of the instruction in bytes.
+@var{file} is the assembly output stream and @var{type_id} is the KCFI
+type identifier to emit.  If @var{file} is NULL, skip emission and only
+return the size.  If not overridden, the default fallback emits a
+@code{.word} directive with the type ID and returns 4 bytes.  Targets can
+override this to emit different instruction sequences and return their
+corresponding sizes.
+@end deftypefn
+
 @node Miscellaneous Register Hooks
 @subsection Miscellaneous register hooks
 @cindex miscellaneous register hooks
diff --git a/gcc/doc/tm.texi.in b/gcc/doc/tm.texi.in
index c3ed9a9fd7c2..b2856886194c 100644
--- a/gcc/doc/tm.texi.in
+++ b/gcc/doc/tm.texi.in
@@ -2433,6 +2433,7 @@ This describes the stack layout and calling conventions.
 * Tail Calls::
 * Shrink-wrapping separate components::
 * Stack Smashing Protection::
+* Kernel Control Flow Integrity::
 * Miscellaneous Register Hooks::
 @end menu
 
@@ -3807,6 +3808,17 @@ generic code.
 
 @hook TARGET_GET_VALID_OPTION_VALUES
 
+@node Kernel Control Flow Integrity
+@subsection Kernel Control Flow Integrity
+@cindex kernel control flow integrity
+@cindex KCFI
+
+@hook TARGET_KCFI_SUPPORTED
+
+@hook TARGET_KCFI_MASK_TYPE_ID
+
+@hook TARGET_KCFI_EMIT_TYPE_ID
+
 @node Miscellaneous Register Hooks
 @subsection Miscellaneous register hooks
 @cindex miscellaneous register hooks
diff --git a/gcc/final.cc b/gcc/final.cc
index afcb0bb9efbc..7f6aa9f9e480 100644
--- a/gcc/final.cc
+++ b/gcc/final.cc
@@ -2094,6 +2094,9 @@ call_from_call_insn (const rtx_call_insn *insn)
 	case SET:
 	  x = XEXP (x, 1);
 	  break;
+	case KCFI:
+	  x = XEXP (x, 0);
+	  break;
 	}
     }
   return x;
diff --git a/gcc/opts.cc b/gcc/opts.cc
index 3ab993aea573..0ee37e01d24a 100644
--- a/gcc/opts.cc
+++ b/gcc/opts.cc
@@ -2170,6 +2170,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =
   SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true, true),
   SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true, true),
   SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false, false),
+  SANITIZER_OPT (kcfi, SANITIZE_KCFI, false, true),
   SANITIZER_OPT (all, ~sanitize_code_type (0), true, true),
 #undef SANITIZER_OPT
   { NULL, sanitize_code_type (0), 0UL, false, false }
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
index 68ce53baa0f1..fd1bb0846801 100644
--- a/gcc/passes.def
+++ b/gcc/passes.def
@@ -52,6 +52,7 @@ along with GCC; see the file COPYING3.  If not see
   NEXT_PASS (pass_ipa_auto_profile_offline);
   NEXT_PASS (pass_ipa_free_lang_data);
   NEXT_PASS (pass_ipa_function_and_variable_visibility);
+  NEXT_PASS (pass_ipa_kcfi);
   NEXT_PASS (pass_ipa_strub_mode);
   NEXT_PASS (pass_build_ssa_passes);
   PUSH_INSERT_PASSES_WITHIN (pass_build_ssa_passes)
@@ -275,6 +276,7 @@ along with GCC; see the file COPYING3.  If not see
       NEXT_PASS (pass_sink_code, false /* unsplit edges */);
       NEXT_PASS (pass_sancov);
       NEXT_PASS (pass_asan);
+      NEXT_PASS (pass_kcfi);
       NEXT_PASS (pass_tsan);
       NEXT_PASS (pass_dse, true /* use DR analysis */);
       NEXT_PASS (pass_dce, false /* update_address_taken_p */, false /* remove_unused_locals */);
@@ -443,6 +445,7 @@ along with GCC; see the file COPYING3.  If not see
   NEXT_PASS (pass_sancov_O0);
   NEXT_PASS (pass_lower_switch_O0);
   NEXT_PASS (pass_asan_O0);
+  NEXT_PASS (pass_kcfi_O0);
   NEXT_PASS (pass_tsan_O0);
   NEXT_PASS (pass_musttail);
   NEXT_PASS (pass_sanopt);
diff --git a/gcc/rtl.def b/gcc/rtl.def
index 15ae7d10fcc1..af643d187b95 100644
--- a/gcc/rtl.def
+++ b/gcc/rtl.def
@@ -318,6 +318,12 @@ DEF_RTL_EXPR(CLOBBER, "clobber", "e", RTX_EXTRA)
 
 DEF_RTL_EXPR(CALL, "call", "ee", RTX_EXTRA)
 
+/* KCFI wrapper for call expressions.
+   Operand 0 is the call expression.
+   Operand 1 is the KCFI type ID (const_int).  */
+
+DEF_RTL_EXPR(KCFI, "kcfi", "ee", RTX_EXTRA)
+
 /* Return from a subroutine.  */
 
 DEF_RTL_EXPR(RETURN, "return", "", RTX_EXTRA)
diff --git a/gcc/rtlanal.cc b/gcc/rtlanal.cc
index 63a1d08c46cf..4baa820b176e 100644
--- a/gcc/rtlanal.cc
+++ b/gcc/rtlanal.cc
@@ -1177,6 +1177,11 @@ reg_referenced_p (const_rtx x, const_rtx body)
     case IF_THEN_ELSE:
       return reg_overlap_mentioned_p (x, body);
 
+    case KCFI:
+      /* For KCFI wrapper, check both the wrapped call and the type ID */
+      return (reg_overlap_mentioned_p (x, XEXP (body, 0))
+              || reg_overlap_mentioned_p (x, XEXP (body, 1)));
+
     case TRAP_IF:
       return reg_overlap_mentioned_p (x, TRAP_CONDITION (body));
 
diff --git a/gcc/target.def b/gcc/target.def
index 8e491d838642..47a11c60809a 100644
--- a/gcc/target.def
+++ b/gcc/target.def
@@ -7589,6 +7589,44 @@ DEFHOOKPOD
 The default value is NULL.",
  const char *, NULL)
 
+/* Kernel Control Flow Integrity (KCFI) hooks.  */
+#undef HOOK_PREFIX
+#define HOOK_PREFIX "TARGET_KCFI_"
+HOOK_VECTOR (TARGET_KCFI, kcfi)
+
+DEFHOOK
+(supported,
+ "Return true if the target supports Kernel Control Flow Integrity (KCFI).\n\
+This hook indicates whether the target has implemented the necessary RTL\n\
+patterns and infrastructure to support KCFI instrumentation.  The default\n\
+implementation returns false.",
+ bool, (void),
+ hook_bool_void_false)
+
+DEFHOOK
+(mask_type_id,
+ "Apply architecture-specific masking to KCFI type ID.  This hook allows\n\
+targets to apply bit masks or other transformations to the computed KCFI\n\
+type identifier to match the target's specific requirements.  The default\n\
+implementation returns the type ID unchanged.",
+ uint32_t, (uint32_t type_id),
+ NULL)
+
+DEFHOOK
+(emit_type_id,
+ "Emit architecture-specific type ID instruction for KCFI preambles\n\
+and return the size of the instruction in bytes.\n\
+@var{file} is the assembly output stream and @var{type_id} is the KCFI\n\
+type identifier to emit.  If @var{file} is NULL, skip emission and only\n\
+return the size.  If not overridden, the default fallback emits a\n\
+@code{.word} directive with the type ID and returns 4 bytes.  Targets can\n\
+override this to emit different instruction sequences and return their\n\
+corresponding sizes.",
+ int, (FILE *file, uint32_t type_id),
+ NULL)
+
+HOOK_VECTOR_END (kcfi)
+
 /* Close the 'struct gcc_target' definition.  */
 HOOK_VECTOR_END (C90_EMPTY_HACK)
 
diff --git a/gcc/toplev.cc b/gcc/toplev.cc
index d26467450e37..9078bb6318a9 100644
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
@@ -1739,6 +1740,16 @@ process_options ()
 		  "requires %<-fno-exceptions%>");
     }
 
+  if (flag_sanitize & SANITIZE_KCFI)
+    {
+      if (!targetm.kcfi.supported ())
+	sorry ("%<-fsanitize=kcfi%> not supported by this target");
+
+      /* KCFI is supported for only C at this time.  */
+      if (!lang_GNU_C ())
+	sorry ("%<-fsanitize=kcfi%> is only supported for C");
+    }
+
   HOST_WIDE_INT patch_area_size, patch_area_start;
   parse_and_check_patch_area (flag_patchable_function_entry, false,
 			      &patch_area_size, &patch_area_start);
diff --git a/gcc/tree-inline.cc b/gcc/tree-inline.cc
index 08e642178ba5..e674e176f7d3 100644
--- a/gcc/tree-inline.cc
+++ b/gcc/tree-inline.cc
@@ -2104,6 +2104,16 @@ copy_bb (copy_body_data *id, basic_block bb,
 	  /* Advance iterator now before stmt is moved to seq_gsi.  */
 	  gsi_next (&stmts_gsi);
 
+	  /* If inlining from a function with no_sanitize("kcfi"), mark any
+	     call statements in the inlined body with the flag so they skip
+	     KCFI instrumentation.  */
+	  if (is_gimple_call (stmt)
+	      && !sanitize_flags_p (SANITIZE_KCFI, id->src_fn))
+	    {
+	      gcall *call = as_a <gcall *> (stmt);
+	      gimple_call_set_inlined_from_kcfi_nosantize (call, true);
+	    }
+
 	  if (gimple_nop_p (stmt))
 	      continue;
 
diff --git a/gcc/varasm.cc b/gcc/varasm.cc
index 0d78f5b384fb..b897954fd0ea 100644
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
@@ -2199,6 +2200,9 @@ assemble_start_function (tree decl, const char *fnname)
   unsigned short patch_area_size = crtl->patch_area_size;
   unsigned short patch_area_entry = crtl->patch_area_entry;
 
+  /* Emit KCFI preamble before any patchable areas.  */
+  kcfi_emit_preamble (asm_out_file, decl, fnname);
+
   /* Emit the patching area before the entry label, if any.  */
   if (patch_area_entry > 0)
     targetm.asm_out.print_patchable_function_entry (asm_out_file,
@@ -2767,6 +2771,19 @@ assemble_external_real (tree decl)
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
@@ -7283,16 +7300,25 @@ default_elf_asm_named_section (const char *name, unsigned int flags,
 	fprintf (asm_out_file, ",%d", flags & SECTION_ENTSIZE);
       if (flags & SECTION_LINK_ORDER)
 	{
-	  /* For now, only section "__patchable_function_entries"
-	     adopts flag SECTION_LINK_ORDER, internal label LPFE*
-	     was emitted in default_print_patchable_function_entry,
-	     just place it here for linked_to section.  */
-	  gcc_assert (!strcmp (name, "__patchable_function_entries"));
-	  fprintf (asm_out_file, ",");
-	  char buf[256];
-	  ASM_GENERATE_INTERNAL_LABEL (buf, "LPFE",
-				       current_function_funcdef_no);
-	  assemble_name_raw (asm_out_file, buf);
+	  if (!strcmp (name, "__patchable_function_entries"))
+	    {
+	      /* For patchable function entries, internal label LPFE*
+		 was emitted in default_print_patchable_function_entry,
+		 just place it here for linked_to section.  */
+	      fprintf (asm_out_file, ",");
+	      char buf[256];
+	      ASM_GENERATE_INTERNAL_LABEL (buf, "LPFE",
+					   current_function_funcdef_no);
+	      assemble_name_raw (asm_out_file, buf);
+	    }
+	  else if (!strcmp (name, ".kcfi_traps"))
+	    {
+	      /* KCFI traps section links to .text section.  */
+	      fprintf (asm_out_file, ",.text");
+	    }
+	  else
+	    internal_error ("unexpected use of %<SECTION_LINK_ORDER%> by section %qs",
+			    name);
 	}
       if (HAVE_COMDAT_GROUP && (flags & SECTION_LINKONCE))
 	{
-- 
2.34.1

