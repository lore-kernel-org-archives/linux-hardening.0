Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3C259C92
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805845; cv=none; b=YnJBFB+J2mXdJcgdXvKpRv64ltIIucu3i8C/kCC5KmzGeCK0J5jKov/iwiRy963fjWr8sfpGRCxHU11rNNqhfIFhhLVyR0Pnkg4Pat3lZo+C7+AaxGRHfrK1s3wmLc2BnPLcwLnKhK9Bz66oSlqZ4N0hiOVsSvXAT/JBk+4EkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805845; c=relaxed/simple;
	bh=XIlSAT8kGPTjwji1hQzOv9ozivMBfxLxbAhxfuzSfoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BSYBxJ7TU4yEINYPKTowVR5pLLz5ibH+cBdjx3lRFzERUndKwtTUvcICi2uza+WGqKYXifRqIRa10Gp3qpm6Ygo/ew8vTlIRSJCzEAxUAAnBHQWE/vN3V+wfpKmuKYc7h/iXQNomO7Xs18M+W9/dk3zkrwaX8s02pxTUPuWJWwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2JyhZkB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2JyhZkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D35CC4CEF9;
	Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757805845;
	bh=XIlSAT8kGPTjwji1hQzOv9ozivMBfxLxbAhxfuzSfoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2JyhZkByCesR3VKytM/gzdncwq+PIHYTsPdd1W61KUzFnCprZiFZNlLAtNhXNi+5
	 /4C08Px/U3Mb4hmunaWKFyPs2CEW3UStwivTV9mLp7KxaQbev15cNgkJnxf+FeoQW4
	 L4dFDmqqg0kVwXCuVlhB1gmagPAuH8fDy7Q6x26yH1RSwLrXXhlSF88djIkwQLPC2U
	 qN7gnNmcwppo9qxqm1EVHyhHNTTaVC9sh9QFdP/FeX3be7GhRSCzVHeMVTq0X9umUH
	 +s5PmTal1zxfgWVLnFj+SfBBKSzu/DPzgBJc9QmovEX+pluk9nptRdnDy11l28Q161
	 2nzoI30DrZryQ==
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
Subject: [PATCH v3 2/7] kcfi: Add core Kernel Control Flow Integrity infrastructure
Date: Sat, 13 Sep 2025 16:23:58 -0700
Message-Id: <20250913232404.2690431-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913231256.make.519-kees@kernel.org>
References: <20250913231256.make.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=49504; i=kees@kernel.org; h=from:subject; bh=XIlSAT8kGPTjwji1hQzOv9ozivMBfxLxbAhxfuzSfoE=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlH/wroX3UTybzPfOqweYxd42FXtpuBX78EN3VKPc6c6 +j4p5Oho5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCLfORkZZteUfGXI6P2ps+1U x50/nupH3ij5PdE6vUR3R/e1m2nBQowMa7u3cP5e0b+i1cRmzVoD3SdBQaZqCxZVhqqcMPO2XLi ZGQA=
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
	* df-scan.cc (df_uses_record): Add KCFI case to handle KCFI RTL
	patterns and process wrapped RTL.
        * doc/extend.texi: Update nocf_check for kcfi.
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
	* passes.def: Add KCFI IPA pass.
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

gcc/c-family/ChangeLog:

	* c-attribs.cc: Include asan.h.
        (handle_nocf_check_attribute): Enable nocf_check under kcfi.
	(handle_patchable_function_entry_attribute): Add error for using
	patchable_function_entry attribute with -fsanitize=kcfi.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/kcfi.h                |  52 ++++
 gcc/kcfi.cc               | 601 ++++++++++++++++++++++++++++++++++++++
 gcc/Makefile.in           |   1 +
 gcc/flag-types.h          |   2 +
 gcc/gimple.h              |  22 ++
 gcc/tree-pass.h           |   1 +
 gcc/c-family/c-attribs.cc |  17 +-
 gcc/df-scan.cc            |   7 +
 gcc/doc/extend.texi       |  38 +++
 gcc/doc/invoke.texi       |  33 +++
 gcc/doc/tm.texi           |  31 ++
 gcc/doc/tm.texi.in        |  12 +
 gcc/final.cc              |   3 +
 gcc/opts.cc               |   1 +
 gcc/passes.cc             |   1 +
 gcc/passes.def            |   1 +
 gcc/rtl.def               |   6 +
 gcc/rtlanal.cc            |   5 +
 gcc/target.def            |  38 +++
 gcc/toplev.cc             |  10 +
 gcc/tree-inline.cc        |  10 +
 gcc/varasm.cc             |  37 ++-
 22 files changed, 918 insertions(+), 11 deletions(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/kcfi.cc

diff --git a/gcc/kcfi.h b/gcc/kcfi.h
new file mode 100644
index 000000000000..32c186416493
--- /dev/null
+++ b/gcc/kcfi.h
@@ -0,0 +1,52 @@
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
+extern rtx __kcfi_get_type_id_for_expanding_gimple_call (void);
+
+/* Convenience wrapper to check for SANITIZE_KCFI.  */
+#define kcfi_get_type_id_for_expanding_gimple_call()	\
+  ((flag_sanitize & SANITIZE_KCFI)			\
+     ? __kcfi_get_type_id_for_expanding_gimple_call ()	\
+     : NULL_RTX)
+
+/* Emit KCFI type ID symbol for external address-taken functions.  */
+extern void kcfi_emit_typeid_symbol (FILE *asm_file, tree fndecl);
+
+/* Emit KCFI preamble for potential indirect call targets.  */
+extern void kcfi_emit_preamble (FILE *asm_file, tree fndecl,
+				const char *actual_fname);
+
+/* For calculating callsite offset.  */
+extern HOST_WIDE_INT kcfi_patchable_entry_prefix_nops;
+
+#endif /* GCC_KCFI_H */
diff --git a/gcc/kcfi.cc b/gcc/kcfi.cc
new file mode 100644
index 000000000000..9ed0cb00faa1
--- /dev/null
+++ b/gcc/kcfi.cc
@@ -0,0 +1,601 @@
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
+address.  If the hash at the call site and the hash at the target do not
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
+KCFI has a number of specific constraints.  Some are tied to the
+backend architecture, which are covered in arch-specific code.
+The constraints are:
+
+- The KCFI scheme generates a unique 32-bit hash ("typeid") for each
+  unique function prototype, allowing for indirect call sites to verify
+  that they are calling into a matching _type_ of function pointer.
+  This changes the semantics of some optimization logic because now
+  indirect calls to different types cannot be merged.  For example:
+
+    if (p->func_type_1)
+	return p->func_type_1 ();
+    if (p->func_type_2)
+	return p->func_type_2 ();
+
+  In final asm, the optimizer may collapse the second indirect call
+  into a jump to the first indirect call once it has loaded the function
+  pointer.  KCFI must block cross-type merging otherwise there will be a
+  single KCFI check happening for only 1 type but being used by 2 target
+  types.  The distinguishing characteristic for call merging becomes the
+  type, not the address/register usage.
+
+- The check-call instruction sequence must be treated as a single unit: it
+  cannot be rearranged or split or optimized.  The pattern is that
+  indirect calls, "call *%target", get converted into:
+
+    mov $target_expression, %target ; only present if the expression was
+				    ; not already in %target register
+    load -$offset(%target), %tmp    ; load typeid hash from target preamble
+    cmp $typeid, %tmp		    ; compare expected typeid with loaded
+    je .Lkcfi_call$N		    ; success: jump to the indirect call
+  .Lkcfi_trap$N:		    ; label of trap insn
+    trap			    ; trap on failure, but arranged so
+				    ; "permissive mode" falls through
+  .Lkcfi_call$N:		    ; label of call insn
+    call *%target		    ; actual indirect call
+
+  This pattern of call immediately after trap provides for the
+  "permissive" checking mode automatically: the trap gets handled,
+  a warning emitted, and then execution continues after the trap to
+  the call.
+
+- KCFI check-call instrumentation must survive tail call optimization.
+  If an indirect call is turned into an indirect jump, KCFI checking
+  must still happen (but it will use a jmp rather than a call).
+
+- Functions that may be called indirectly have a preamble added,
+  __cfi_$original_func_name, which contains the $typeid value:
+
+    __cfi_target_func:
+      .word $typeid
+    target_func:
+       [regular function entry...]
+
+- The preamble needs to interact with patchable function entry so that
+  the typeid appears further away from the actual start of the function
+  (leaving the prefix NOPs of the patchable function entry unchanged).
+  This means only _globally defined_ patchable function entry is supported
+  with KCFI (indrect call sites must know in advance what the offset is,
+  which may not be possible with extern functions that use a function
+  attribute to change their patchable function entry characteristics).
+  For example, a "4,4" patchable function entry would end up like:
+
+    __cfi_target_func:
+      .data $typeid
+      nop nop nop nop
+    target_func:
+       [regular function entry...]
+
+  Architectures may need to add alignment nops prior to the typeid to keep
+  __cfi_target_func aligned for function call conventions.
+
+- External functions that are address-taken have a weak __kcfi_typeid_$func
+  symbol added with the typeid value available so that the typeid can be
+  referenced from assembly linkages, etc, where the typeid values cannot be
+  calculated (i.e where C type information is missing):
+
+    .weak   __kcfi_typeid_$func
+    .set    __kcfi_typeid_$func, $typeid
+
+- On architectures that do not have a good way to encode additional
+  details in their trap insn (e.g. x86_64 and riscv64), the trap location
+  is identified as a KCFI trap via a relative address offset entry
+  emitted into the .kcfi_traps section for each indirect call site's
+  trap instruction.  The previous check-call example's insn sequence would
+  then have section changes inserted between the trap and call:
+
+  ...
+  .Lkcfi_trap$N:
+    trap
+  .section	.kcfi_traps,"ao",@progbits,.text
+  .Lkcfi_entry$N:
+    .long	.Lkcfi_trap$N - .Lkcfi_entry$N
+  .text
+  .Lkcfi_call$N:
+    call *%target
+
+  It is up to such architectures to decode instructions prior to the
+  trap to locate the typeid that the callsite was expecting.
+
+  For architectures that can encode immediates in their trap function
+  (e.g. aarch64 and arm32), this isn't needed: they just use immediate
+  codes that indicate a KCFI trap.
+
+- The no_sanitize("kcfi") function attribute means that the marked
+  function must not produce KCFI checking for indirect calls, and this
+  attribute must survive inlining.  This is used rarely by Linux, but
+  is required to make BPF JIT trampolines work on older Linux kernel
+  versions.
+
+- The "nocf_check" function attribute can be used to supress the
+  KCFI preamble for a function, making that function unavailable
+  for indirect calls.
+
+As a result of these constraints, there are some behavioral aspects
+that need to be preserved across the middle-end and back-end.
+
+For indirect call sites:
+
+- All function types have their associated typeid attached as an
+  attribute.
+
+- Keep typeid information available through to the RTL expansion
+  phase was done via a new KCFI insn RTL pattern that wraps the CALL
+  and the typeid.
+
+- Keep indirect calls from being merged (see earlier example) by
+  checking the KCFI insn's typeid for equality.
+
+- To make sure KCFI expansion is skipped for inline functions that
+  are marked with no_sanitize("kcfi"), the inlining is marked during
+  GIMPLE with a new flag which is checked during expansion.
+
+- KCFI insn emission interacts with patchable function entry to
+  load the typeid from the target preambble, offset by prefix NOPs.
+
+For indirect call targets:
+
+- kcfi_emit_preamble interacts with patchable function entry to add
+  any needed alignment prior to emitting the typeid.
+
+- assemble_external_real calls kcfi_emit_typeid_symbol to add the
+  __kcfi_typeid_$func symbols.
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
+#include "target.h"
+#include "flags.h"
+#include "kcfi-typeinfo.h"
+#include "insn-config.h"
+#include "recog.h"
+
+/* For callsite typeid loading offset.  */
+HOST_WIDE_INT kcfi_patchable_entry_prefix_nops = 0;
+/* For preamble alignment.  */
+static HOST_WIDE_INT kcfi_patchable_entry_arch_alignment_nops = 0;
+static const char *kcfi_nop = NULL;
+
+/* Common helper for RTL patterns to emit .kcfi_traps section entry.  */
+
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
+  /* Use varasm infrastructure for section handling:
+     .section	.kcfi_traps,"ao",@progbits,.text  */
+  section *kcfi_traps_section = get_section (".kcfi_traps",
+					     SECTION_LINK_ORDER, NULL);
+  switch_to_section (kcfi_traps_section);
+
+  /* Emit entry label for relative offset:
+     .Lkcfi_entry$N:  */
+  ASM_OUTPUT_LABEL (file, entry_name);
+
+  /* Generate address difference using RTL infrastructure.  */
+  rtx entry_label_sym = gen_rtx_SYMBOL_REF (Pmode, entry_name);
+  rtx addr_diff = gen_rtx_MINUS (Pmode, trap_label_sym, entry_label_sym);
+
+  /* Emit the address difference as a 4-byte value:
+    .long	.Lkcfi_trap$N - .Lkcfi_entry$N  */
+  assemble_integer (addr_diff, 4, BITS_PER_UNIT, 1);
+
+  /* Restore the previous section:
+     .text  */
+  switch_to_section (saved_section);
+}
+
+/* Compute KCFI type ID for a function type.  */
+
+static uint32_t
+compute_kcfi_type_id (tree fntype)
+{
+  gcc_assert (fntype);
+  gcc_assert (TREE_CODE (fntype) == FUNCTION_TYPE);
+
+  uint32_t type_id = typeinfo_get_hash (fntype);
+
+  /* Apply target-specific masking if supported.  */
+  if (targetm.kcfi.mask_type_id)
+    type_id = targetm.kcfi.mask_type_id (type_id);
+
+  /* Output to dump file if enabled.  */
+  if (dump_file && (dump_flags & TDF_DETAILS))
+    {
+      std::string mangled_name = typeinfo_get_name (fntype);
+      fprintf (dump_file, "KCFI type ID: mangled='%s' typeid=0x%08x\n",
+	       mangled_name.c_str (), type_id);
+    }
+
+  return type_id;
+}
+
+/* Function attribute to store KCFI type ID.  */
+static tree kcfi_type_id_attr = NULL_TREE;
+
+/* Get KCFI type ID for a function type.  Set it if missing.  */
+
+static uint32_t
+kcfi_get_type_id (tree fn_type)
+{
+  uint32_t type_id;
+
+  /* Cache the attribute identifier.  */
+  if (!kcfi_type_id_attr)
+    kcfi_type_id_attr = get_identifier ("kcfi_type_id");
+
+  tree attr = lookup_attribute (IDENTIFIER_POINTER (kcfi_type_id_attr),
+				TYPE_ATTRIBUTES (fn_type));
+  if (attr)
+    {
+      tree value = TREE_VALUE (attr);
+      gcc_assert (value && TREE_CODE (value) == INTEGER_CST);
+      type_id = (uint32_t) TREE_INT_CST_LOW (value);
+    }
+  else
+    {
+      type_id = compute_kcfi_type_id (fn_type);
+
+      tree type_id_tree = build_int_cst (unsigned_type_node, type_id);
+      tree attr = build_tree_list (kcfi_type_id_attr, type_id_tree);
+
+      TYPE_ATTRIBUTES (fn_type) = chainon (TYPE_ATTRIBUTES (fn_type), attr);
+    }
+
+  return type_id;
+}
+
+/* Prepare the global KCFI alignment NOPs calculation.
+   Called once during IPA pass to set global variables.  */
+
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
+      /* Store value for callsite offset calculation.  */
+      kcfi_patchable_entry_prefix_nops = prefix_nops;
+    }
+
+  /* Calculate architecture-specific alignment NOPs.
+     KCFI preamble layout:
+     __cfi_func: [alignment_nops][typeid][prefix_nops] func: [entry_nops]
+
+     The alignment NOPs ensure __cfi_func stays at proper function entry
+     alignment when prefix NOPs are added.  */
+  HOST_WIDE_INT arch_alignment = 0;
+
+  /* Calculate alignment NOPs based on function alignment setting.
+     Use explicit -falign-functions value if set, otherwise default to 4.  */
+  int alignment_bytes = 4;
+  if (align_functions.levels[0].log > 0)
+    alignment_bytes = align_functions.levels[0].get_value ();
+
+  /* Get typeid instruction size from target hook, default to 4 bytes.  */
+  int typeid_size = targetm.kcfi.emit_type_id
+		    ? targetm.kcfi.emit_type_id (NULL, 0) : 4;
+
+  /* Calculate alignment NOP bytes needed.  */
+  arch_alignment = (alignment_bytes
+		    - ((kcfi_patchable_entry_prefix_nops + typeid_size)
+		       % alignment_bytes)) % alignment_bytes;
+
+  /* Prepare NOP template.  */
+  rtx_insn *nop_insn = make_insn_raw (gen_nop ());
+  int code_num = recog_memoized (nop_insn);
+  kcfi_nop = get_insn_template (code_num, nop_insn);
+
+  /* Calculate number of NOP instructions needed for alignment.  */
+  int nop_size = get_attr_length (nop_insn);
+  if (arch_alignment % nop_size != 0)
+    sorry ("KCFI function entry alignment padding bytes "
+	   "(" HOST_WIDE_INT_PRINT_DEC ") are not a multiple of "
+	   "architecture NOP instruction size (%d)",
+	   arch_alignment, nop_size);
+  kcfi_patchable_entry_arch_alignment_nops = arch_alignment / nop_size;
+}
+
+/* Extract KCFI type ID from indirect call GIMPLE statement.
+   Returns RTX constant with type ID, or NULL_RTX if no KCFI needed.  */
+
+rtx
+__kcfi_get_type_id_for_expanding_gimple_call (void)
+{
+  gcc_assert (currently_expanding_gimple_stmt);
+  gcc_assert (is_gimple_call (currently_expanding_gimple_stmt));
+
+  /* Internally checks for no_sanitize("kcfi") with current_function_decl.  */
+  if (!sanitize_flags_p (SANITIZE_KCFI))
+    return NULL_RTX;
+
+  gcall *call_stmt = as_a <gcall *> (currently_expanding_gimple_stmt);
+
+  /* Only indirect calls need KCFI instrumentation.  */
+  if (gimple_call_fndecl (call_stmt))
+    return NULL_RTX;
+
+  /* Skip calls originating from inlined no_sanitize("kcfi") functions.  */
+  if (gimple_call_inlined_from_kcfi_nosantize_p (call_stmt))
+    return NULL_RTX;
+
+  /* Get function type of call.  */
+  tree fn_type = gimple_call_fntype (call_stmt);
+  gcc_assert (fn_type);
+
+  /* Return the type_id.  */
+  return GEN_INT (kcfi_get_type_id (fn_type));
+}
+
+/* Emit KCFI type ID symbol for an address-taken external function.  */
+
+void
+kcfi_emit_typeid_symbol (FILE *asm_file, tree fndecl)
+{
+  /* Only emit for external function declarations.  */
+  if (TREE_CODE (fndecl) != FUNCTION_DECL || DECL_INITIAL (fndecl))
+    return;
+
+  /* Only emit for functions that are address-taken.  */
+  struct cgraph_node *node = cgraph_node::get (fndecl);
+  if (!node || !node->address_taken)
+    return;
+
+  /* Get symbol name from RTL and strip encoding prefixes.  */
+  rtx rtl = DECL_RTL (fndecl);
+  const char *name = XSTR (XEXP (rtl, 0), 0);
+  name = targetm.strip_name_encoding (name);
+
+  /* .weak __kcfi_typeid_{name} */
+  std::string symbol_name = std::string ("__kcfi_typeid_") + name;
+  ASM_WEAKEN_LABEL (asm_file, symbol_name.c_str ());
+
+  /* .set __kcfi_typeid_{name}, 0x{type_id} */
+  char val[16];
+  snprintf (val, sizeof (val), "0x%08x",
+	    kcfi_get_type_id (TREE_TYPE (fndecl)));
+  ASM_OUTPUT_DEF (asm_file, symbol_name.c_str (), val);
+}
+
+/* Emit KCFI preamble before the function label.
+   Functions get preambles when -fsanitize=kcfi is enabled, regardless of
+   no_sanitize("kcfi") attribute.  */
+
+void
+kcfi_emit_preamble (FILE *asm_file, tree fndecl, const char *actual_fname)
+{
+  /* Skip functions with nocf_check attribute.  */
+  if (lookup_attribute ("nocf_check", TYPE_ATTRIBUTES (TREE_TYPE (fndecl))))
+    return;
+
+  struct cgraph_node *node = cgraph_node::get (fndecl);
+
+  /* Ignore cold partition functions: not reached via indirect call.  */
+  if (node && node->split_part)
+    return;
+
+  /* Ignore cold partition sections: cold partitions are never indirect call
+     targets.  Only skip preambles for cold partitions (has_bb_partition = true)
+     not for entire cold-attributed functions (has_bb_partition = false).  */
+  if (in_cold_section_p && crtl && crtl->has_bb_partition)
+    return;
+
+  /* Check if function is truly address-taken using cgraph node analysis.  */
+  bool addr_taken = (node && node->address_taken);
+
+  /* Only instrument functions that can be targets of indirect calls:
+     - Public functions (can be called externally)
+     - External declarations (from other modules)
+     - Functions with true address-taken status from cgraph analysis.  */
+  if (!(TREE_PUBLIC (fndecl) || DECL_EXTERNAL (fndecl) || addr_taken))
+    return;
+
+  /* Use actual function name if provided, otherwise fall back to
+     DECL_ASSEMBLER_NAME.  */
+  const char *fname = actual_fname
+			? actual_fname
+			: IDENTIFIER_POINTER (DECL_ASSEMBLER_NAME (fndecl));
+
+  /* Create symbol name for reuse.  */
+  std::string cfi_symbol_name = std::string ("__cfi_") + fname;
+
+  /* Emit __cfi_ symbol with proper visibility.  */
+  if (TREE_PUBLIC (fndecl))
+    {
+      if (DECL_WEAK (fndecl))
+	ASM_WEAKEN_LABEL (asm_file, cfi_symbol_name.c_str ());
+      else
+	targetm.asm_out.globalize_label (asm_file, cfi_symbol_name.c_str ());
+    }
+
+  /* Emit .type directive.  */
+  ASM_OUTPUT_TYPE_DIRECTIVE (asm_file, cfi_symbol_name.c_str (), "function");
+  ASM_OUTPUT_LABEL (asm_file, cfi_symbol_name.c_str ());
+
+  /* Emit architecture-specific alignment NOPs using target's NOP template.  */
+  for (int i = 0; i < kcfi_patchable_entry_arch_alignment_nops; i++)
+    output_asm_insn (kcfi_nop, NULL);
+
+  /* Emit type ID bytes.  */
+  uint32_t type_id = kcfi_get_type_id (TREE_TYPE (fndecl));
+  if (targetm.kcfi.emit_type_id)
+    targetm.kcfi.emit_type_id (asm_file, type_id);
+  else
+    fprintf (asm_file, "\t.word\t0x%08x\n", type_id);
+
+  /* Mark end of __cfi_ symbol and emit size directive.  */
+  std::string cfi_end_label = std::string (".Lcfi_func_end_") + fname;
+  ASM_OUTPUT_LABEL (asm_file, cfi_end_label.c_str ());
+
+  ASM_OUTPUT_MEASURED_SIZE (asm_file, cfi_symbol_name.c_str ());
+}
+
+namespace {
+
+/* IPA pass for KCFI type ID setting - runs once per compilation unit.  */
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
+/* Set KCFI type_ids for all usable function types in compilation unit.  */
+
+static unsigned int
+ipa_kcfi_execute (void)
+{
+  struct cgraph_node *node;
+
+  /* Prepare global KCFI alignment NOPs calculation once for all functions.  */
+  kcfi_prepare_alignment_nops ();
+
+  /* Process all functions - both local and external.  */
+  FOR_EACH_FUNCTION (node)
+    {
+      tree fndecl = node->decl;
+
+      /* Skip all non-NORMAL builtins (MD, FRONTEND) entirely.
+	 For NORMAL builtins, skip those that lack an implicit
+	 implementation (closest way to distinguishing DEF_LIB_BUILTIN
+	 from others).  E.g. we need to have typeids for memset().  */
+      if (fndecl_built_in_p (fndecl))
+	{
+	  if (DECL_BUILT_IN_CLASS (fndecl) != BUILT_IN_NORMAL)
+	    continue;
+	  if (!builtin_decl_implicit_p (DECL_FUNCTION_CODE (fndecl)))
+	    continue;
+	}
+
+      /* Cache the type_id in the function type.  */
+      kcfi_get_type_id (TREE_TYPE (fndecl));
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
+}; /* class pass_ipa_kcfi */
+
+} /* anon namespace */
+
+simple_ipa_opt_pass *
+make_pass_ipa_kcfi (gcc::context *ctxt)
+{
+  return new pass_ipa_kcfi (ctxt);
+}
diff --git a/gcc/Makefile.in b/gcc/Makefile.in
index a14fb498ce44..5b89161ac75a 100644
--- a/gcc/Makefile.in
+++ b/gcc/Makefile.in
@@ -1592,6 +1592,7 @@ OBJS = \
 	ira-lives.o \
 	jump.o \
 	kcfi-typeinfo.o \
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
index da32651ea017..d5e7acc2c6a7 100644
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
@@ -3487,6 +3488,27 @@ gimple_call_from_thunk_p (gcall *s)
   return (s->subcode & GF_CALL_FROM_THUNK) != 0;
 }
 
+/* If INLINED_FROM_KCFI_NOSANTIZE_P is true, mark GIMPLE_CALL S as being
+   inlined from a function with no_sanitize("kcfi").  */
+
+inline void
+gimple_call_set_inlined_from_kcfi_nosantize (gcall *s,
+					     bool inlined_from_kcfi_nosantize_p)
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
index 1c68a69350df..8155249c990a 100644
--- a/gcc/tree-pass.h
+++ b/gcc/tree-pass.h
@@ -544,6 +544,7 @@ extern ipa_opt_pass_d *make_pass_ipa_odr (gcc::context *ctxt);
 extern ipa_opt_pass_d *make_pass_ipa_reference (gcc::context *ctxt);
 extern ipa_opt_pass_d *make_pass_ipa_pure_const (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_ipa_pta (gcc::context *ctxt);
+extern simple_ipa_opt_pass *make_pass_ipa_kcfi (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_ipa_tm (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_target_clone (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_dispatcher_calls (gcc::context *ctxt);
diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
index 1e3a94ed9493..1580ab25f70b 100644
--- a/gcc/c-family/c-attribs.cc
+++ b/gcc/c-family/c-attribs.cc
@@ -48,6 +48,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "gimplify.h"
 #include "tree-pretty-print.h"
 #include "gcc-rich-location.h"
+#include "asan.h"
 #include "gcc-urlifier.h"
 
 static tree handle_packed_attribute (tree *, tree, tree, int, bool *);
@@ -1740,8 +1741,11 @@ handle_nocf_check_attribute (tree *node, tree name,
       warning (OPT_Wattributes, "%qE attribute ignored", name);
       *no_add_attrs = true;
     }
-  else if (!(flag_cf_protection & CF_BRANCH))
+  else if (!(flag_cf_protection & CF_BRANCH)
+	   && !(flag_sanitize & SANITIZE_KCFI))
     {
+      /* Allow it with -fsanitize=kcfi, but leave this warning alone
+	 to avoid confusion over this weird corner case.  */
       warning (OPT_Wattributes, "%qE attribute ignored. Use "
 				"%<-fcf-protection%> option to enable it",
 				name);
@@ -6508,6 +6512,17 @@ static tree
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
index 1e4c6a2a4fb5..2be5e60786a3 100644
--- a/gcc/df-scan.cc
+++ b/gcc/df-scan.cc
@@ -2851,6 +2851,13 @@ df_uses_record (class df_collection_rec *collection_rec,
       /* If we're clobbering a REG then we have a def so ignore.  */
       return;
 
+    case KCFI:
+      /* KCFI wraps other RTL - process the wrapped RTL.  */
+      df_uses_record (collection_rec, &XEXP (x, 0), ref_type, bb, insn_info,
+		      flags);
+      /* The type ID operand (XEXP (x, 1)) doesn't contain register uses.  */
+      return;
+
     case MEM:
       df_uses_record (collection_rec,
 		      &XEXP (x, 0), DF_REF_REG_MEM_LOAD,
diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
index 7cddea1ed6c1..ae9c039ab589 100644
--- a/gcc/doc/extend.texi
+++ b/gcc/doc/extend.texi
@@ -2740,6 +2740,44 @@ void __attribute__ ((no_sanitize ("alignment,object-size")))
 g () @{ /* @r{Do something.} */; @}
 @end smallexample
 
+When @code{no_sanitize("kcfi")} is applied to a function, it disables
+the generation of Kernel Control Flow Integrity (KCFI) instrumentation
+for indirect function calls within that function.  This means that
+indirect calls in the marked function will not be checked against the
+target function's type signature.
+
+However, the function itself will still receive a KCFI preamble (type
+identifier) when compiled with @option{-fsanitize=kcfi}, allowing it to
+be safely called indirectly from other functions that do perform KCFI
+checks.  In other words, @code{no_sanitize("kcfi")} affects outgoing
+calls from the function, not incoming calls to the function.
+
+@smallexample
+void __attribute__ ((no_sanitize ("kcfi")))
+trusted_function(void (*callback)(int))
+@{
+  /* This indirect call will NOT be instrumented with KCFI checks */
+  callback(42);
+@}
+
+void regular_function(void (*callback)(int))
+@{
+  /* This indirect call WILL be instrumented with KCFI checks */
+  callback(42);
+@}
+@end smallexample
+
+This attribute is primarily used in kernel code for special contexts such
+as BPF JIT trampolines or other low-level code where KCFI instrumentation
+might interfere with the intended operation.  The attribute survives
+inlining to ensure that @code{no_sanitize("kcfi")} functions do not generate
+KCFI checks even when inlined into a function that otherwise performs KCFI
+checks.
+
+Note: To disable KCFI preamble generation for functions so that they may
+explicitly not be called indirectly, use the @code{nocf_check} function
+attribute instead.
+
 @cindex @code{no_sanitize_address} function attribute
 @item no_sanitize_address
 @itemx no_address_safety_analysis
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 56c4fa86e346..f96e104a7248 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18382,6 +18382,39 @@ possible by specifying the command-line options
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
+for the call site, issuing a trap instruction if a mismatch is detected.
+This provides forward-edge control flow protection against attacks that
+attempt to redirect indirect calls to unintended targets.
+
+The implementation adds minimal runtime overhead and does not require
+runtime library support, making it suitable for kernel environments.
+The type identifier is placed before the function entry point,
+allowing runtime verification without additional metadata structures,
+and without changing the entry points of the target functions.
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
+Use @option{-fdump-ipa-kcfi-details} to examine the computed type identifier
+hashes and their corresponding mangled type strings during compilation.
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
index 68ce53baa0f1..65dd0bf4a41e 100644
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
index 63a1d08c46cf..5016fe93ccac 100644
--- a/gcc/rtlanal.cc
+++ b/gcc/rtlanal.cc
@@ -1177,6 +1177,11 @@ reg_referenced_p (const_rtx x, const_rtx body)
     case IF_THEN_ELSE:
       return reg_overlap_mentioned_p (x, body);
 
+    case KCFI:
+      /* For KCFI wrapper, check both the wrapped call and the type ID.  */
+      return (reg_overlap_mentioned_p (x, XEXP (body, 0))
+	      || reg_overlap_mentioned_p (x, XEXP (body, 1)));
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
index d26467450e37..f48cfeb050aa 100644
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
@@ -1739,6 +1740,15 @@ process_options ()
 		  "requires %<-fno-exceptions%>");
     }
 
+  if (flag_sanitize & SANITIZE_KCFI)
+    {
+      if (!targetm.kcfi.supported ())
+	sorry ("%<-fsanitize=kcfi%> not supported by this target");
+
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
index 0d78f5b384fb..d4e9e2373c6c 100644
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
@@ -2199,6 +2200,10 @@ assemble_start_function (tree decl, const char *fnname)
   unsigned short patch_area_size = crtl->patch_area_size;
   unsigned short patch_area_entry = crtl->patch_area_entry;
 
+  /* Emit KCFI preamble before any patchable areas.  */
+  if (flag_sanitize & SANITIZE_KCFI)
+    kcfi_emit_preamble (asm_out_file, decl, fnname);
+
   /* Emit the patching area before the entry label, if any.  */
   if (patch_area_entry > 0)
     targetm.asm_out.print_patchable_function_entry (asm_out_file,
@@ -2767,6 +2772,9 @@ assemble_external_real (tree decl)
       /* Some systems do require some output.  */
       SYMBOL_REF_USED (XEXP (rtl, 0)) = 1;
       ASM_OUTPUT_EXTERNAL (asm_out_file, decl, XSTR (XEXP (rtl, 0), 0));
+
+      if (flag_sanitize & SANITIZE_KCFI)
+	kcfi_emit_typeid_symbol (asm_out_file, decl);
     }
 }
 #endif
@@ -7283,16 +7291,25 @@ default_elf_asm_named_section (const char *name, unsigned int flags,
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

