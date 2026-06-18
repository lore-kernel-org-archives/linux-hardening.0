Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7631940B0
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815543; cv=none; b=HHum2XHZNxjm78ONzV8P0iH7/k2MKRQV0RrZ03WxkVFF7qzb57d+den4IbRJ8gG6tQz77FPlHuO4lAkMTc1zQwJeSsC3lAD/hcEugv3paENuvYHhXji6TCSK54AbeYvPkfasaJtV6bTVAsaPgiQwV25su81sKYiY7VITP7CD6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815543; c=relaxed/simple;
	bh=27yGFPcG8t+ZbPo5Re+S4Rr4AwttMqhXkUa2D8K0Fi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=saorzoMxI2iRV41RZAG8E3Z7QAEn52vXKaeWMvr+vF276NJdjU4CvwiVB5Wlntvd5j4dNOCvTpM49Mbn7EbAM3HJB8OajrisBx0YQ2CPVL7W8/sso/tm5gMK6LKfTILyl80vErRxUGXNZUcnQcPKHAqUY/bPKZfUCd5cMi9ADhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3JT2lZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3JT2lZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9942F1F00A3D;
	Thu, 18 Jun 2026 20:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781815539;
	bh=YT3q2WiRSxCVjqn22A65WsydaSY9U1UpW0ipsPZKZ20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D3JT2lZy1w7rzA29gIgsqfKZAyalXQQdN53N0OfFh1vQclVeovQqRtt7BoY8NodD4
	 3v0TlBVWf0Jk/b5xmN3GQSmL/SMvVEQ/3E+VSuBvKHHE+RNMLJHqUjp4pjVPXtj7xv
	 +zbx5PCtCgeNlyCYcT132nvHKP9XMLxBPyFYIocw/rnkkg5Dux+4kUPtpgrT4YbfvU
	 HL68iPPXmDLb2Sv58Y83xxcSnXWvAfjRCxhRNvyNmTvffG/UMURfFuvleZc3Q0M97q
	 DvXSgw45rpUP1pOYq7CW06Ipc6GZy9II+3sK5Ws751RULcf8FSEG6g0SiUXE6PWuOl
	 tgcW0D+4iBcZA==
From: Kees Cook <kees@kernel.org>
To: Jeffrey Law <jefflaw@qti.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>,
	Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
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
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v13 2/7] kcfi: Add core Kernel Control Flow Integrity infrastructure
Date: Thu, 18 Jun 2026 13:45:32 -0700
Message-Id: <20260618204539.824446-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618204530.work.910-kees@kernel.org>
References: <20260618204530.work.910-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=55502; i=kees@kernel.org; h=from:subject; bh=27yGFPcG8t+ZbPo5Re+S4Rr4AwttMqhXkUa2D8K0Fi0=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkmEe+fpsRZlM7cwrp8krrny/Sn/67dWyP3QT3rfJLEp 197t78o6ShlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjInW8M/5Ntrv49c/vBagGr s8myq75eTef9ks7xMlM60/2WYH5z2DSG/6mXxAxO31vWyidn/nRlBvdB5RmMtzZ9a795rM9J2vF 9DD8A
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
        * rtlanal.cc (reg_referenced_p): Add KCFI case.
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
 gcc/kcfi.h                |  59 ++++
 gcc/kcfi.cc               | 696 ++++++++++++++++++++++++++++++++++++++
 gcc/doc/extend.texi       |  42 +++
 gcc/doc/invoke.texi       |  33 ++
 gcc/doc/tm.texi           |  32 ++
 gcc/Makefile.in           |   1 +
 gcc/flag-types.h          |   2 +
 gcc/gimple.h              |  22 ++
 gcc/tree-pass.h           |   1 +
 gcc/c-family/c-attribs.cc |  17 +-
 gcc/df-scan.cc            |   7 +
 gcc/doc/tm.texi.in        |  12 +
 gcc/final.cc              |   3 +
 gcc/opts.cc               |   4 +-
 gcc/passes.cc             |   1 +
 gcc/passes.def            |   1 +
 gcc/rtl.def               |   6 +
 gcc/rtlanal.cc            |   5 +
 gcc/target.def            |  39 +++
 gcc/toplev.cc             |  12 +
 gcc/tree-inline.cc        |  10 +
 gcc/varasm.cc             |  37 +-
 22 files changed, 1030 insertions(+), 12 deletions(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/kcfi.cc

diff --git a/gcc/kcfi.h b/gcc/kcfi.h
new file mode 100644
index 000000000000..ea7e7881040f
--- /dev/null
+++ b/gcc/kcfi.h
@@ -0,0 +1,59 @@
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
+extern void kcfi_emit_traps_section (FILE *file, rtx trap_label_sym,
+				      int labelno);
+
+/* Extract KCFI type ID from current GIMPLE statement.  */
+extern rtx internal_kcfi_get_type_id_for_expanding_gimple_call (void);
+
+/* Convenience wrapper to check for SANITIZE_KCFI.  */
+static inline rtx
+kcfi_get_type_id_for_expanding_gimple_call (void)
+{
+  if (!(flag_sanitize & SANITIZE_KCFI))
+    return NULL_RTX;
+  return internal_kcfi_get_type_id_for_expanding_gimple_call ();
+}
+
+/* Emit KCFI type ID symbol for external address-taken functions.  */
+extern void kcfi_emit_typeid_symbol (FILE *asm_file, tree fndecl);
+
+/* Emit KCFI preamble for potential indirect call targets.  */
+extern void kcfi_emit_preamble (FILE *asm_file, tree fndecl,
+				const char *actual_fname);
+
+/* Get next KCFI label number for trap/call/entry label numbering.  */
+extern int kcfi_next_labelno (void);
+
+/* Get the KCFI typeid offset for calculating callsite typeid offset.  */
+extern HOST_WIDE_INT kcfi_get_typeid_offset (void);
+
+#endif /* GCC_KCFI_H */
diff --git a/gcc/kcfi.cc b/gcc/kcfi.cc
new file mode 100644
index 000000000000..6f5f36906225
--- /dev/null
+++ b/gcc/kcfi.cc
@@ -0,0 +1,696 @@
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
+- An external function that is address-taken but does not have a definition has
+  a weak __kcfi_typeid_$func symbol added at the declaration site.  This weak
+  symbol has the typeid value available so that the typeid can be referenced
+  from assembly linkages, etc, where the typeid values cannot be calculated
+  (i.e where C type information is missing):
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
+- Make sure KCFI expansion is skipped for inline functions that
+  are marked with no_sanitize("kcfi") by marking these calls
+  during GIMPLE inlining with a new flag which is checked during
+  expansion.
+
+- All function types have their associated typeid attached as an
+  attribute during an IPA pass.
+
+- Keep typeid information available through to the RTL expansion
+  phase via a new KCFI insn RTL pattern that wraps the CALL
+  and the typeid as expressions.  Since per-arch RTL call logic
+  can be very complex, we don't want to replace the "define_expand"
+  patterns, but rather hook the tail end of expansion.  This is
+  where kcfi_get_type_id_for_expanding_gimple_call gets used, which
+  uses currently_expanding_gimple_stmt internally, as done in
+  other cases where GIMPLE needs to be examined during expansion.
+
+- Keep indirect calls from being merged (see earlier example)
+  naturally by having typeid be the second argument of the KCFI insn
+  RTL pattern, so jump2 pass's use of rtx_equal_p see differing
+  typeids in the RTL.
+
+- Update register liveness analysis to look inside the new KCFI
+  RTL to find the CALL RTL and examine the registers in use there
+  so the allocator can track register usage correctly.
+
+- KCFI insn emission interacts with patchable function entry to
+  load the typeid from the target preamble, offset by prefix NOPs.
+
+For indirect call targets:
+
+- kcfi_emit_preamble interacts with patchable function entry to add
+  any needed alignment padding prior to emitting the typeid.
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
+/* KCFI label counter, incremented by KCFI insn emission.  */
+static int kcfi_labelno = 0;
+
+/* Get next KCFI label number.  Returns the current KCFI label number
+   and increments the internal counter for the next call.  The label is
+   used to provide a unique number for each indirect callsite of the
+   current module of the compilation.  */
+
+int
+kcfi_next_labelno (void)
+{
+  return kcfi_labelno++;
+}
+
+/* Callsite typeid loading offset.  */
+static HOST_WIDE_INT kcfi_typeid_offset = 0;
+
+/* Get the KCFI typeid offset.  Returns the offset in bytes from the
+   function entry point where the KCFI type ID is stored.  */
+
+HOST_WIDE_INT
+kcfi_get_typeid_offset (void)
+{
+  return kcfi_typeid_offset;
+}
+/* Count of needed __cfi_... preamble alignment padding NOPs.  */
+static HOST_WIDE_INT kcfi_alignment_padding_nops = 0;
+/* NOP insn template.  */
+static const char *kcfi_nop = NULL;
+
+/* Common helper for RTL patterns to emit .kcfi_traps section entry.
+   FILE is the output assembly file stream.  TRAP_LABEL_SYM is the RTX
+   symbol reference for the trap instruction label.  LABELNO is the KCFI
+   label number to use for the entry label.  */
+
+void
+kcfi_emit_traps_section (FILE *file, rtx trap_label_sym, int labelno)
+{
+  /* Generate entry label name with custom prefix.  */
+  char entry_name[32];
+  ASM_GENERATE_INTERNAL_LABEL (entry_name, "Lkcfi_entry", labelno);
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
+/* Compute KCFI type ID for a function type.  FNTYPE is the function
+   type tree node to compute the type ID for.  Returns the 32-bit KCFI
+   type identifier hash.  */
+
+static uint32_t
+compute_kcfi_type_id (tree fntype)
+{
+  gcc_assert (fntype);
+  gcc_assert (TREE_CODE (fntype) == FUNCTION_TYPE);
+
+  uint32_t type_id = kcfi_typeinfo_get_hash (fntype);
+
+  /* Apply target-specific masking if supported.  */
+  if (targetm.kcfi.mask_type_id)
+    type_id = targetm.kcfi.mask_type_id (type_id);
+
+  /* Output to dump file if enabled.  */
+  if (dump_file && (dump_flags & TDF_DETAILS))
+    {
+      std::string mangled_name = kcfi_typeinfo_get_name (fntype);
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
+/* Get KCFI type ID for a function type.  Set it if missing.  FN_TYPE
+   is the function type tree node.  Returns the cached or newly computed
+   32-bit KCFI type identifier, storing it as a type attribute.  */
+
+static uint32_t
+kcfi_get_type_id (tree fn_type)
+{
+  uint32_t type_id;
+
+  /* Cache the attribute identifier for build_tree_list usage.  */
+  if (!kcfi_type_id_attr)
+    kcfi_type_id_attr = get_identifier ("kcfi_type_id");
+
+  tree attr = lookup_attribute ("kcfi_type_id", TYPE_ATTRIBUTES (fn_type));
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
+/* Prepare the global KCFI alignment NOPs calculation.  Called once
+   during IPA pass to set global variables including kcfi_typeid_offset
+   and kcfi_alignment_padding_nops based on patchable function entry
+   settings and function alignment requirements.  */
+
+static void
+kcfi_prepare_alignment_nops (void)
+{
+  /* Calculate where callsites load the 32-bit typeid from, based
+     on the target function address.  Under default circumstances,
+     the typeid is located 4 bytes before the function entry, in
+     the __cfi_... preamble:
+
+     __cfi_func:
+       [typeid]		// -4 from func
+     func:
+       [function body]
+
+   */
+  kcfi_typeid_offset = sizeof (uint32_t);
+
+  /* When Patchable Function Entry (PFE) is enabled, there may be NOP
+     instructions between the typeid and the function entry point.
+     Since KCFI callsites have no way to see PFE function attributes,
+     it can only base the calculations on the global
+     -fpatchable-function-entry=TOTAL[,PREFIX] flag.  */
+  HOST_WIDE_INT prefix_nops = 0;
+  if (flag_patchable_function_entry)
+    {
+      HOST_WIDE_INT total_nops;
+      parse_and_check_patch_area (flag_patchable_function_entry, false,
+				  &total_nops, &prefix_nops);
+    }
+
+  /* However, PFE is measured in NOP instruction counts, not bytes.  So
+     we need to find out how many bytes they are, and we may need to
+     emit NOPs for alignment padding later.  Prepare the NOP template.  */
+  rtx_insn *nop_insn = make_insn_raw (gen_nop ());
+  int code_num = recog_memoized (nop_insn);
+  kcfi_nop = get_insn_template (code_num, nop_insn);
+  int nop_insn_bytes = get_attr_length (nop_insn);
+
+  /* Adjust the offset by how many NOP bytes may be between the typeid
+     and the function entry point.
+
+     __cfi_func:
+       [typeid]		// -(4 + (prefix nop count * nop size)) from func
+       [prefix nops]	// added when -fpatchable-function-entry is set
+     func:
+       [entry nops]	// added when -fpatchable-function-entry is set
+       [function body]
+
+     At this point, kcfi_typeid_offset is ready and callsites can now
+     correctly find the typeid.
+
+   */
+  int prefix_nop_bytes = prefix_nops * nop_insn_bytes;
+  kcfi_typeid_offset += prefix_nop_bytes;
+
+  /* In the case where the KCFI preamble (and potentially the prefix NOPs)
+     are being used for alternative CFI implementations via live-patching,
+     the __cfi_... label itself needs to be usable as a callable function
+     target, so alignment NOPs may need to be added between the preamble
+     label and the typeid during KCFI preamble emission:
+
+     __cfi_func:		// may need to be function entry aligned
+       [alignment padding nops] // may be needed when -falign-functions set
+       [typeid]
+       [prefix nops]
+     func:
+       [entry nops]
+       [function body]
+
+     But we only calculate alignment padding NOPs when -falign-functions
+     has been explicitly set.
+   */
+  if (align_functions.levels[0].log <= 0)
+    return;
+  int function_entry_alignment = align_functions.levels[0].get_value ();
+
+  /* Some architectures may be using an instruction for the typeid (though
+     this requires that the typeid is a trailing immediate value), but the
+     instruction will have a size greater than 4, which must be part of the
+     resulting alignment padding calculation.  */
+  int typeid_insn_bytes = targetm.kcfi.emit_type_id
+			  ? targetm.kcfi.emit_type_id (NULL, 0, NULL)
+			  : sizeof (uint32_t);
+
+  /* Calculate needed architecture-specific alignment padding bytes.  */
+  int needed_alignment_bytes = (function_entry_alignment
+				- ((prefix_nop_bytes + typeid_insn_bytes)
+				   % function_entry_alignment))
+			       % function_entry_alignment;
+
+  /* Calculate number of NOP instructions needed for alignment padding.  */
+  if (needed_alignment_bytes % nop_insn_bytes != 0)
+    sorry ("KCFI function entry alignment padding bytes (%d) are not "
+	   "a multiple of architecture NOP instruction size (%d)",
+	   needed_alignment_bytes, nop_insn_bytes);
+  kcfi_alignment_padding_nops = needed_alignment_bytes / nop_insn_bytes;
+}
+
+/* Extract KCFI type ID from indirect call GIMPLE statement.  Uses the
+   currently expanding GIMPLE statement to determine if KCFI instrumentation
+   is needed.  Returns RTX constant with type ID, or NULL_RTX if no KCFI
+   instrumentation is required.  */
+
+rtx
+internal_kcfi_get_type_id_for_expanding_gimple_call (void)
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
+/* Emit KCFI type ID symbol for an address-taken external function.
+   ASM_FILE is the output assembly file stream.  FNDECL is the external
+   function declaration tree node.  Emits weak symbol definitions for
+   external functions that are address-taken.  */
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
+/* Emit KCFI preamble before the function label.  ASM_FILE is the output
+   assembly file stream.  FNDECL is the function declaration tree node.
+   ACTUAL_FNAME is the actual function name to use, or NULL to use the
+   function's assembler name.  Functions get preambles when -fsanitize=kcfi
+   is enabled, regardless of no_sanitize("kcfi") attribute.  */
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
+  /* Emit any needed alignment padding NOPs using target's NOP template.  */
+  for (int i = 0; i < kcfi_alignment_padding_nops; i++)
+    output_asm_insn (kcfi_nop, NULL);
+
+  /* Emit type ID bytes.  */
+  uint32_t type_id = kcfi_get_type_id (TREE_TYPE (fndecl));
+  if (targetm.kcfi.emit_type_id)
+    targetm.kcfi.emit_type_id (asm_file, type_id, fndecl);
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
+/* Set KCFI type_ids for all usable function types in compilation unit.
+   Processes all functions in the current compilation unit and caches their
+   KCFI type identifiers.  Returns 0 on completion.  */
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
diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
index 2e7b7e4aed89..dbac01cfc8c9 100644
--- a/gcc/doc/extend.texi
+++ b/gcc/doc/extend.texi
@@ -3684,6 +3684,44 @@ void __attribute__ ((no_sanitize ("alignment,object-size")))
 g () @{ /* @r{Do something.} */; @}
 @end smallexample
 
+When @code{no_sanitize ("kcfi")} is applied to a function, it disables
+the generation of Kernel Control Flow Integrity (KCFI) instrumentation
+for indirect function calls within that function.  This means that
+indirect calls in the marked function will not be checked against the
+target function's type signature.
+
+However, the function itself will still receive a KCFI preamble (type
+identifier) when compiled with @option{-fsanitize=kcfi}, allowing it to
+be safely called indirectly from other functions that do perform KCFI
+checks.  In other words, @code{no_sanitize ("kcfi")} affects outgoing
+calls from the function, not incoming calls to the function.
+
+@smallexample
+void __attribute__ ((no_sanitize ("kcfi")))
+trusted_function(void (*callback)(int))
+@{
+  /* This indirect call will NOT be instrumented with KCFI checks.  */
+  callback (42);
+@}
+
+void regular_function(void (*callback)(int))
+@{
+  /* This indirect call WILL be instrumented with KCFI checks.  */
+  callback (42);
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
 @atindex @code{no_sanitize_address}
 @cindex functions that should not be sanitized
 @item no_sanitize_address
@@ -4286,6 +4324,10 @@ script to place the sections with the @code{.persistent} prefix in the
 right location.  Specifically, some type of non-volatile, writable
 memory is required.
 
+This attribute cannot be used with @option{-fsanitize=kcfi} because KCFI
+callsites cannot know about function-specific patchable entry settings on
+a preamble in a different translation unit.
+
 @atindex @code{pure}
 @cindex functions that have no side effects
 @item pure
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 24d0420ca381..372ea7d5f069 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -17445,6 +17445,39 @@ the available options are shown at startup of the instrumented program.
 The option cannot be combined with @option{-fsanitize=thread} or
 @option{-fsanitize=address}, and is currently only available on AArch64.
 
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
 @opindex fsanitize=kernel-hwaddress
 @item -fsanitize=kernel-hwaddress
 Enable Hardware-assisted AddressSanitizer for compilation of the Linux kernel.
diff --git a/gcc/doc/tm.texi b/gcc/doc/tm.texi
index ba037b880534..3c766e59fa62 100644
--- a/gcc/doc/tm.texi
+++ b/gcc/doc/tm.texi
@@ -3181,6 +3181,7 @@ This describes the stack layout and calling conventions.
 * Tail Calls::
 * Shrink-wrapping separate components::
 * Stack Smashing Protection::
+* Kernel Control Flow Integrity::
 * Miscellaneous Register Hooks::
 @end menu
 
@@ -5455,6 +5456,37 @@ should be allocated from heap memory and consumers should release them.
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
+@deftypefn {Target Hook} int TARGET_KCFI_EMIT_TYPE_ID (FILE *@var{file}, uint32_t @var{type_id}, tree @var{fndecl})
+Emit architecture-specific type ID instruction for KCFI preambles
+and return the size of the instruction in bytes.
+@var{file} is the assembly output stream and @var{type_id} is the KCFI
+type identifier to emit.  If @var{file} is NULL, skip emission and only
+return the size.  If not overridden, the default fallback emits a
+@code{.word} directive with the type ID and returns 4 bytes.  Targets can
+override this to emit different instruction sequences and return their
+corresponding sizes.  @var{fndecl} is the function declaration, which
+targets can use to compute architecture-specific arity or other properties.
+@end deftypefn
+
 @node Miscellaneous Register Hooks
 @subsection Miscellaneous register hooks
 @cindex miscellaneous register hooks
diff --git a/gcc/Makefile.in b/gcc/Makefile.in
index b7572535e205..f8b606a4632c 100644
--- a/gcc/Makefile.in
+++ b/gcc/Makefile.in
@@ -1614,6 +1614,7 @@ OBJS = \
 	ira-lives.o \
 	jump.o \
 	kcfi-typeinfo.o \
+	kcfi.o \
 	langhooks.o \
 	late-combine.o \
 	lcm.o \
diff --git a/gcc/flag-types.h b/gcc/flag-types.h
index 3d182785c824..7f75f5e04314 100644
--- a/gcc/flag-types.h
+++ b/gcc/flag-types.h
@@ -342,6 +342,8 @@ enum sanitize_code {
   SANITIZE_MEMTAG_STACK = 1ULL << 32,
   /* Memory Tagging.  */
   SANITIZE_MEMTAG = SANITIZE_MEMTAG_STACK,
+  /* KCFI (Kernel Control Flow Integrity) */
+  SANITIZE_KCFI = 1ULL << 33,
   SANITIZE_SHIFT = SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
   SANITIZE_UNDEFINED = SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNREACHABLE
 		       | SANITIZE_VLA | SANITIZE_NULL | SANITIZE_RETURN
diff --git a/gcc/gimple.h b/gcc/gimple.h
index 0b7589e656f4..b948492b90a7 100644
--- a/gcc/gimple.h
+++ b/gcc/gimple.h
@@ -145,6 +145,7 @@ enum gf_mask {
     GF_CALL_ALLOCA_FOR_VAR	= 1 << 5,
     GF_CALL_INTERNAL		= 1 << 6,
     GF_CALL_CTRL_ALTERING       = 1 << 7,
+    GF_CALL_INLINED_FROM_KCFI_NOSANTIZE = 1 << 8,
     GF_CALL_MUST_TAIL_CALL	= 1 << 9,
     GF_CALL_BY_DESCRIPTOR	= 1 << 10,
     GF_CALL_NOCF_CHECK		= 1 << 11,
@@ -3499,6 +3500,27 @@ gimple_call_from_thunk_p (gcall *s)
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
index b3c97658a8fe..67f93b9a8759 100644
--- a/gcc/tree-pass.h
+++ b/gcc/tree-pass.h
@@ -545,6 +545,7 @@ extern ipa_opt_pass_d *make_pass_ipa_odr (gcc::context *ctxt);
 extern ipa_opt_pass_d *make_pass_ipa_reference (gcc::context *ctxt);
 extern ipa_opt_pass_d *make_pass_ipa_pure_const (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_ipa_pta (gcc::context *ctxt);
+extern simple_ipa_opt_pass *make_pass_ipa_kcfi (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_ipa_tm (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_target_clone (gcc::context *ctxt);
 extern simple_ipa_opt_pass *make_pass_dispatcher_calls (gcc::context *ctxt);
diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
index 88293c37e4ee..39ac1059e775 100644
--- a/gcc/c-family/c-attribs.cc
+++ b/gcc/c-family/c-attribs.cc
@@ -48,6 +48,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "gimplify.h"
 #include "tree-pretty-print.h"
 #include "gcc-rich-location.h"
+#include "asan.h"
 #include "gcc-urlifier.h"
 #include "attr-callback.h"
 
@@ -1774,8 +1775,11 @@ handle_nocf_check_attribute (tree *node, tree name,
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
@@ -6668,6 +6672,17 @@ static tree
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
index c6a5053ddbb6..e7ac751ca78f 100644
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
diff --git a/gcc/doc/tm.texi.in b/gcc/doc/tm.texi.in
index 0944563c9cba..f2477d874511 100644
--- a/gcc/doc/tm.texi.in
+++ b/gcc/doc/tm.texi.in
@@ -2457,6 +2457,7 @@ This describes the stack layout and calling conventions.
 * Tail Calls::
 * Shrink-wrapping separate components::
 * Stack Smashing Protection::
+* Kernel Control Flow Integrity::
 * Miscellaneous Register Hooks::
 @end menu
 
@@ -3833,6 +3834,17 @@ generic code.
 
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
index 0152be59fc85..d2906fb07431 100644
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
index 342517528e8e..a524c66f5976 100644
--- a/gcc/opts.cc
+++ b/gcc/opts.cc
@@ -2224,6 +2224,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =
   SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true, true),
   SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false, false),
   SANITIZER_OPT (memtag-stack, SANITIZE_MEMTAG_STACK, false, false),
+  SANITIZER_OPT (kcfi, SANITIZE_KCFI, false, true),
   SANITIZER_OPT (all, ~sanitize_code_type (0), true, true),
 #undef SANITIZER_OPT
   { NULL, sanitize_code_type (0), 0UL, false, false }
@@ -2363,7 +2364,8 @@ parse_sanitizer_options (const char *p, location_t loc, int scode,
 		  flags |= ~(SANITIZE_THREAD | SANITIZE_LEAK
 			     | SANITIZE_UNREACHABLE | SANITIZE_RETURN
 			     | SANITIZE_SHADOW_CALL_STACK
-			     | SANITIZE_MEMTAG_STACK);
+			     | SANITIZE_MEMTAG_STACK
+			     | SANITIZE_KCFI);
 		else /* if (code == OPT_fsanitize_trap_) */
 		  flags |= (SANITIZE_UNDEFINED
 			    | SANITIZE_UNDEFINED_NONDEFAULT);
diff --git a/gcc/passes.cc b/gcc/passes.cc
index 96c2456fe32d..78445b470140 100644
--- a/gcc/passes.cc
+++ b/gcc/passes.cc
@@ -66,6 +66,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "attribs.h"
 #include "topics/pass-events.h"
 #include "channels.h"
+#include "kcfi.h"
 
 /* Reserved TODOs */
 #define TODO_verify_il			(1u << 31)
diff --git a/gcc/passes.def b/gcc/passes.def
index 1fc867fae517..2affee7269c4 100644
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
index e83d6554c808..a4baffa1e88c 100644
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
index 5274a5c59cf1..14b9c87ed7e9 100644
--- a/gcc/rtlanal.cc
+++ b/gcc/rtlanal.cc
@@ -1177,6 +1177,11 @@ reg_referenced_p (const_rtx x, const_rtx body)
     case IF_THEN_ELSE:
       return reg_overlap_mentioned_p (x, body);
 
+    case KCFI:
+      /* For KCFI wrapper, only check the wrapped call.  The type ID
+	 (XEXP (body, 1)) is always a const_int.  */
+      return reg_overlap_mentioned_p (x, XEXP (body, 0));
+
     case TRAP_IF:
       return reg_overlap_mentioned_p (x, TRAP_CONDITION (body));
 
diff --git a/gcc/target.def b/gcc/target.def
index 89788a26986c..2c5780147e09 100644
--- a/gcc/target.def
+++ b/gcc/target.def
@@ -7677,6 +7677,45 @@ DEFHOOKPOD
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
+corresponding sizes.  @var{fndecl} is the function declaration, which\n\
+targets can use to compute architecture-specific arity or other properties.",
+ int, (FILE *file, uint32_t type_id, tree fndecl),
+ NULL)
+
+HOOK_VECTOR_END (kcfi)
+
 /* Close the 'struct gcc_target' definition.  */
 HOOK_VECTOR_END (C90_EMPTY_HACK)
 
diff --git a/gcc/toplev.cc b/gcc/toplev.cc
index 30f5a3d00639..55ae40e9589a 100644
--- a/gcc/toplev.cc
+++ b/gcc/toplev.cc
@@ -68,6 +68,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "attribs.h"
 #include "asan.h"
 #include "tsan.h"
+#include "kcfi.h"
 #include "plugin.h"
 #include "context.h"
 #include "pass_manager.h"
@@ -1745,6 +1746,17 @@ process_options ()
 		  "requires %<-fno-exceptions%>");
     }
 
+  if (flag_sanitize & SANITIZE_KCFI)
+    {
+      if (!targetm.kcfi.supported ())
+	sorry ("%<-fsanitize=kcfi%> not supported by this target");
+
+      /* Compiling with -flto results in frontend language of GNU GIMPLE.
+	 Allow it since the original source was C.  */
+      if (!lang_GNU_C () && !startswith (lang_hooks.name, "GNU GIMPLE"))
+	sorry ("%<-fsanitize=kcfi%> is only supported for C");
+    }
+
   HOST_WIDE_INT patch_area_size, patch_area_start;
   parse_and_check_patch_area (flag_patchable_function_entry, false,
 			      &patch_area_size, &patch_area_start);
diff --git a/gcc/tree-inline.cc b/gcc/tree-inline.cc
index 302ab8d6b7c8..9db50655fbe1 100644
--- a/gcc/tree-inline.cc
+++ b/gcc/tree-inline.cc
@@ -2110,6 +2110,16 @@ copy_bb (copy_body_data *id, basic_block bb,
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
index 0dbc35d926a3..ce6d217c8967 100644
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
@@ -7287,16 +7295,25 @@ default_elf_asm_named_section (const char *name, unsigned int flags,
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
+	    internal_error ("unexpected use of %<SECTION_LINK_ORDER%> by "
+			    "section %qs", name);
 	}
       if (HAVE_COMDAT_GROUP && (flags & SECTION_LINKONCE))
 	{
-- 
2.34.1

