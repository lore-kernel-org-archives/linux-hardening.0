Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33050336EED
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157364; cv=none; b=NxNumMxiWqfewR1NOePF/g5WjiNDyYMViL6KtoYIO7wWJVEJkAqVaWWtxQSi2p+ugTwvNuj7LVv8rINdo8UuSa+NXMC97v2ui/1uTMFHJ1OyUjVucIMuEhQDpdum5tbO8MeBP4En0kaMDidKJuI3kc9CfmU/KLB4DH4Hku9EBig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157364; c=relaxed/simple;
	bh=Nw+YgJzuWPHcyxwv9QHtSHhuKDMRtgWvKeTVDgdgnFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KI+d6Bdp4/ceqN1a8ekboYu8EhxoFa0lYxAcHvDIzjwCi5JGTO7rxGcuNqR5QkMSwryUG01WbQ0BX/EQrvMPOewOx2SGhMpdmH2lDltDQA2ZrugxBXmc3hfX2SpdhjleauuSWWHeN5N9I159ndImI1xGyk3fr5Kl28Cq1rE8IAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXZALK9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXZALK9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D703BC2BCAF;
	Wed, 22 Oct 2025 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761157363;
	bh=Nw+YgJzuWPHcyxwv9QHtSHhuKDMRtgWvKeTVDgdgnFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXZALK9d5Rv+g0v0uvhXAxJa2V8znn4/Z6gW4iI4OWgjBL9u+pBH5laDmq3kJ9LN6
	 G+06xqodZB7WXwwCN//XZ3fhV3t4rNx5PLxhuIntWKOl71BazZ8U5shFjXT4tuCiLz
	 /ky7bFgiptGu8drrkq/uNKTdKGgjRXaLGHBqnf6UPW2iKxi9I3kwwYvnSjmTFBngsT
	 4u/v7fJbcwEcg8+l4Vdco17oZVm6C7GpYbaNDLPhIr1hOWqm63TaIqYGijqodc5bA5
	 YmtIBK3a3VKFYXBdt2t3SFy3t1898EmPoAMSqS2N8lYFAFg77NCOVtN6YhLcdE9SXH
	 lHWWFnALxmSXg==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeff Law <jeffreyalaw@gmail.com>,
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
Subject: [PATCH v5 5/7] aarch64: Add AArch64 Kernel Control Flow Integrity implementation
Date: Wed, 22 Oct 2025 11:22:39 -0700
Message-Id: <20251022182243.72085-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022181345.do.256-kees@kernel.org>
References: <20251022181345.do.256-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=33267; i=kees@kernel.org; h=from:subject; bh=Nw+YgJzuWPHcyxwv9QHtSHhuKDMRtgWvKeTVDgdgnFg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk/FT5YeX+b+fyB1Mm6DzfexBppNL6PnWS1LOCextbMs NeHPwhJdpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExkvTYjwwLvCTpRPn3vol0F mzSsZZdttOQVFVOf/+GM99J7J0LOTGVkWMOZacs6R9pHeuo2NR2f0wwpqxYKt4c+OpuQI6S9sGk XPwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Implement AArch64-specific KCFI backend.

- Trap debugging through ESR (Exception Syndrome Register) encoding
  in BRK instruction immediate values.

- Scratch register allocation using w16/w17 (x16/x17) following
  AArch64 procedure call standard for intra-procedure-call registers,
  which already makes x16/x17 available through existing clobbers.

- Incompatible with -ffixed-x16 or -ffixed-x17.

- Complementary with BTI (which uses a separate pass system to inject
  landing instructions where needed).

- Does not interfere with SME, which uses attributes not function
  prototypes for distinguishing functions.

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

gcc/testsuite/ChangeLog:

	* gcc.dg/kcfi/kcfi-adjacency.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-basics.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-call-sharing.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-complex-addressing.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-move-preservation.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-no-sanitize.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-offset-validation.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-patchable-large.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-patchable-medium.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-tail-calls.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-trap-section.c: Add aarch64 patterns.
	* gcc.dg/kcfi/kcfi-aarch64-fixed-x16.c: New test.
	* gcc.dg/kcfi/kcfi-aarch64-fixed-x17.c: New test.
	* gcc.dg/kcfi/kcfi-trap-encoding.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/aarch64/aarch64-protos.h           |   5 +
 gcc/config/aarch64/aarch64.md                 |  64 ++++++++--
 gcc/config/aarch64/aarch64.cc                 | 111 ++++++++++++++++++
 gcc/doc/invoke.texi                           |  14 +++
 .../gcc.dg/kcfi/kcfi-aarch64-fixed-x16.c      |  17 +++
 .../gcc.dg/kcfi/kcfi-aarch64-fixed-x17.c      |  17 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  15 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  21 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |   4 +
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  16 +++
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  20 ++++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |   5 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   1 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   3 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  12 ++
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  12 ++
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  12 ++
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  12 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  19 +++
 .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  41 +++++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   4 +
 21 files changed, 417 insertions(+), 8 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-fixed-x16.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-fixed-x17.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c

diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aarch64-protos.h
index a9e407ba340e..c32d454fe277 100644
--- a/gcc/config/aarch64/aarch64-protos.h
+++ b/gcc/config/aarch64/aarch64-protos.h
@@ -1272,6 +1272,7 @@ tree aarch64_resolve_overloaded_builtin_general (location_t, tree, void *);
 
 const char *aarch64_sls_barrier (int);
 const char *aarch64_indirect_call_asm (rtx);
+const char *aarch64_indirect_branch_asm (rtx);
 extern bool aarch64_harden_sls_retbr_p (void);
 extern bool aarch64_harden_sls_blr_p (void);
 
@@ -1295,4 +1296,8 @@ extern unsigned aarch64_stack_alignment (const_tree exp, unsigned align);
 extern rtx aarch64_gen_compare_zero_and_branch (rtx_code code, rtx x,
 						rtx_code_label *label);
 
+/* KCFI support.  */
+extern void kcfi_emit_trap_with_section (FILE *file, rtx trap_label_rtx);
+extern const char *aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands);
+
 #endif /* GCC_AARCH64_PROTOS_H */
diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.md
index 98c65a74c8ed..878f4859cf3b 100644
--- a/gcc/config/aarch64/aarch64.md
+++ b/gcc/config/aarch64/aarch64.md
@@ -1506,6 +1506,19 @@
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
@@ -1533,6 +1546,20 @@
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
@@ -1573,6 +1600,19 @@
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
@@ -1581,16 +1621,27 @@
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
@@ -1601,10 +1652,7 @@
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
diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.cc
index b86064148fea..61c3ccaa8294 100644
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
@@ -11847,6 +11848,16 @@ aarch64_expand_call (rtx result, rtx mem, rtx cookie, bool sibcall)
 
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
 
@@ -19107,6 +19118,9 @@ aarch64_override_options_internal (struct gcc_options *opts)
 #endif
     }
 
+  if ((flag_sanitize & SANITIZE_KCFI) && TARGET_ILP32)
+    sorry ("%<-fsanitize=kcfi%> is not supported for %<-mabi=ilp32%>");
+
   aarch64_feature_flags isa_flags = aarch64_get_isa_flags (opts);
   if ((isa_flags & (AARCH64_FL_SM_ON | AARCH64_FL_ZA_ON))
       && !(isa_flags & AARCH64_FL_SME))
@@ -19276,6 +19290,12 @@ aarch64_override_options_internal (struct gcc_options *opts)
 			 aarch64_autovec_preference,
 			 opts->x_autovec_preference);
 
+  /* KCFI requires X16 and X17 registers for type checking.  */
+  if ((opts->x_flag_sanitize & SANITIZE_KCFI)
+      && (fixed_regs[R16_REGNUM] || fixed_regs[R17_REGNUM]))
+    sorry ("%<-fsanitize=kcfi%> is not compatible with %<-ffixed-x16%> or "
+	   "%<-ffixed-x17%> as KCFI requires these registers for type checking");
+
   aarch64_override_options_after_change_1 (opts);
 }
 
@@ -30638,6 +30658,18 @@ aarch64_indirect_call_asm (rtx addr)
   return "";
 }
 
+/* Generate assembly for AArch64 indirect branch instruction.  ADDR is the
+   target address register.  Returns any additional barrier instructions
+   needed for SLS (Straight Line Speculation) mitigation.  */
+
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
 
@@ -32899,6 +32931,85 @@ aarch64_libgcc_floating_mode_supported_p
 #undef TARGET_DOCUMENTATION_NAME
 #define TARGET_DOCUMENTATION_NAME "AArch64"
 
+/* Output the assembly for a KCFI checked call instruction.  INSN is the
+   RTL instruction being processed.  OPERANDS is the array of RTL operands
+   where operands[0] is the call target register, operands[3] is the KCFI
+   type ID constant.  Returns the appropriate call instruction string.  */
+
+const char *
+aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands)
+{
+  /* Target register is operands[0].  */
+  rtx target_reg = operands[0];
+  gcc_assert (REG_P (target_reg));
+
+  /* Get KCFI type ID from operand[3].  */
+  uint32_t type_id = (uint32_t) INTVAL (operands[3]);
+
+  /* Calculate typeid offset from call target.  */
+  HOST_WIDE_INT offset = -kcfi_get_typeid_offset ();
+
+  /* Get unique label number for this KCFI check.  */
+  int labelno = kcfi_next_labelno ();
+
+  /* Generate custom label names.  */
+  char trap_name[32];
+  char call_name[32];
+  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", labelno);
+  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", labelno);
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
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 7d221910cbca..ad2de3d965e7 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18523,6 +18523,20 @@ header MOVri instruction would become something like this:
 
 @code{movl    $199571451, %ebx                # hash of foo's type = 0xBE537FB}
 
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-fixed-x16.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-fixed-x16.c
new file mode 100644
index 000000000000..9859cb40a6a1
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-fixed-x16.c
@@ -0,0 +1,17 @@
+/* Test that KCFI is incompatible with -ffixed-x16 on AArch64.  */
+/* { dg-do compile { target aarch64*-*-* } } */
+/* { dg-additional-options "-ffixed-x16" } */
+
+/* { dg-message "sorry, unimplemented: '-fsanitize=kcfi' is not compatible with '-ffixed-x16' or '-ffixed-x17' as KCFI requires these registers for type checking" "" { target *-*-* } 0 } */
+
+void test_function(void)
+{
+    /* Empty function.  */
+}
+
+int main(void)
+{
+    void (*ptr)(void) = test_function;
+    ptr();  /* This would need KCFI instrumentation.  */
+    return 0;
+}
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-fixed-x17.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-fixed-x17.c
new file mode 100644
index 000000000000..d3302ba7ceaa
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-fixed-x17.c
@@ -0,0 +1,17 @@
+/* Test that KCFI is incompatible with -ffixed-x17 on AArch64.  */
+/* { dg-do compile { target aarch64*-*-* } } */
+/* { dg-additional-options "-ffixed-x17" } */
+
+/* { dg-message "sorry, unimplemented: '-fsanitize=kcfi' is not compatible with '-ffixed-x16' or '-ffixed-x17' as KCFI requires these registers for type checking" "" { target *-*-* } 0 } */
+
+void test_function(void)
+{
+    /* Empty function.  */
+}
+
+int main(void)
+{
+    void (*ptr)(void) = test_function;
+    ptr();  /* This would need KCFI instrumentation.  */
+    return 0;
+}
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
index 7c59921e630c..f3d7d23e6af2 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
@@ -63,4 +63,19 @@ __attribute__((noinline)) void test_conditional_call(int flag) {
 ** ...
 */
 
+/*
+** test_complex_args: { target aarch64*-*-* }
+** ...
+** ldur	w16, \[(x[0-9]+), #-4\]
+** mov	w17, #[0-9]+
+** movk	w17, #[0-9]+, lsl #16
+** cmp	w16, w17
+** b.eq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** brk	#[0-9]+
+** .Lkcfi_call\2:
+** br	\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
index fe0a21d26df9..6eac946f7abf 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
@@ -59,6 +59,9 @@ int main() {
 /* x86_64: Verify type ID in preamble (after NOPs, before function label) */
 /* { dg-final { scan-assembler {__cfi_regular_function:\n\t+nop\n.*\n\t+movl\t+\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
 
+/* AArch64: Verify type ID word in preamble.  */
+/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word\t0x[0-9a-f]+} { target aarch64*-*-* } } } */
+
 /*
 ** static_caller: { target x86_64-*-* }
 ** ...
@@ -76,6 +79,21 @@ int main() {
 ** ...
 */
 
+/*
+** static_caller: { target aarch64*-*-* }
+** ...
+** ldur	w16, \[(x[0-9]+), #-4\]
+** mov	w17, #[0-9]+
+** movk	w17, #[0-9]+, lsl #16
+** cmp	w16, w17
+** b.eq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** brk	#[0-9]+
+** .Lkcfi_call\2:
+** blr	\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
 
 /* Extern functions should NOT get KCFI preambles.  */
@@ -93,3 +111,6 @@ int main() {
 /* External functions that are only called directly should NOT get
    __kcfi_typeid_ symbols.  */
 /* { dg-final { scan-assembler-not {__kcfi_typeid_external_func_int} } } */
+
+/* AArch64 should NOT have trap section (use immediate instructions instead).  */
+/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
index 16154213eb82..c36168b60752 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
@@ -63,14 +63,18 @@ int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *
 /* Verify we have TWO different KCFI check sequences.  */
 /* Each check should have different type ID constants.  */
 /* x86: { dg-final { scan-assembler-times {movl\s+\$-?[0-9]+,\s+%r10d} 2 { target i?86-*-* x86_64-*-* } } } */
+/* AArch64: { dg-final { scan-assembler-times {mov\s+w17, #[0-9]+} 2 { target aarch64*-*-* } } } */
 
 /* Verify the checks use DIFFERENT type IDs (not shared).
    We should NOT see the same type ID used twice - that would indicate
    unmerged sharing.  */
 /* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*movl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
+/* AArch64: { dg-final { scan-assembler-not {mov\s+w17, #([0-9]+).*mov\s+w17, #\1} { target aarch64*-*-* } } } */
 
 /* Verify expected number of traps.  */
 /* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_64-*-* } } } */
+/* AArch64: { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target aarch64*-*-* } } } */
 
 /* Verify 2 separate call sites.  */
 /* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { target i?86-*-* x86_64-*-* } } } */
+/* AArch64: { dg-final { scan-assembler-times {br\tx[0-9]+} 2 { target aarch64*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
index ed415033c5c9..3ffbd408a69e 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
@@ -146,4 +146,20 @@ int main() {
 ** ...
 */
 
+/* Standard KCFI handling.  */
+/*
+** main: { target aarch64*-*-* }
+** ...
+** ldur	w16, \[(x[0-9]+), #-4\]
+** mov	w17, #[0-9]+
+** movk	w17, #[0-9]+, lsl #16
+** cmp	w16, w17
+** b.eq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** brk	#[0-9]+
+** .Lkcfi_call\2:
+** blr	\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
index 5553ff47174b..df39b7f0a8a3 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
@@ -57,4 +57,24 @@ int main(void)
 ** ...
 */
 
+/*
+** indirect_call: { target aarch64*-*-* }
+** ...
+** mov	(x[0-9]+), x0
+** ...
+** ldur	w16, \[\1, #-4\]
+** mov	w17, #[0-9]+
+** movk	w17, #[0-9]+, lsl #16
+** cmp	w16, w17
+** b.eq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** brk	#[0-9]+
+** .Lkcfi_call\2:
+** br	\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
+
+/* AArch64 should NOT have trap section (use immediate instructions instead).  */
+/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
index 9ed7e21fe8eb..cdeb202ffd12 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
@@ -75,11 +75,16 @@ int main(void)
 
 /* Verify correct number of KCFI checks: exactly 2 */
 /* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target aarch64*-*-* } } } */
 
 /* Positive controls: these should have KCFI checks.  */
 /* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_function} { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler {wrap_normal_inline:.*ud2.*\.size\s+wrap_normal_inline} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {normal_function:.*brk\s+#[0-9]+.*\.size\s+normal_function} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler {wrap_normal_inline:.*brk\s+#[0-9]+.*\.size\s+wrap_normal_inline} { target aarch64*-*-* } } } */
 
 /* Negative controls: these should NOT have KCFI checks.  */
 /* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ud2.*\.size\s+wrap_sensitive_inline} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*brk\s+#[0-9]+.*\.size\s+sensitive_non_inline_function} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*brk\s+#[0-9]+.*\.size\s+wrap_sensitive_inline} { target aarch64*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
index 95a8e8419e00..af6d86803576 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
@@ -34,3 +34,4 @@ int main() {
    caller_no_checks() should NOT generate KCFI check (no_sanitize).
    So a total of exactly 1 KCFI check in the entire program.  */
 /* { dg-final { scan-assembler-times {addl\t-4\(%r[ad]x\), %r1[01]d} 1 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 1 { target aarch64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
index 97d964feebd3..0ced5c43ae92 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
@@ -27,3 +27,6 @@ int main() {
 /* x86_64: All call sites should use -4 offset for KCFI type ID loads, even
    with -falign-functions=16 (we're not using patchable entries here).  */
 /* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
+
+/* AArch64: All call sites should use -4 offset.  */
+/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]} { target aarch64*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
index 379356385a16..7a251cbdee3b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
@@ -28,6 +28,11 @@ int main() {
 ** movl	\$0x[0-9a-f]+, %eax
 */
 
+/*
+** __cfi_test_function: { target aarch64*-*-* }
+** .word	0x[0-9a-f]+
+*/
+
 /*
 ** main: { target x86_64-*-* }
 ** ...
@@ -35,4 +40,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target aarch64*-*-* }
+** ...
+** ldur	w16, \[x[0-9]+, #-4\]
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
index 06df3495bb23..3ed5d16c8e91 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
@@ -17,6 +17,11 @@ int main() {
 ** movl	\$0x[0-9a-f]+, %eax
 */
 
+/*
+** __cfi_test_function: { target aarch64*-*-* }
+** .word	0x[0-9a-f]+
+*/
+
 /*
 ** main: { target x86_64-*-* }
 ** ...
@@ -24,4 +29,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target aarch64*-*-* }
+** ...
+** ldur	w16, \[x[0-9]+, #-48\]
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
index ef87b135934b..e354914209e9 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
@@ -24,6 +24,11 @@ int main() {
 ** movl	\$0x[0-9a-f]+, %eax
 */
 
+/*
+** __cfi_test_function: { target aarch64*-*-* }
+** .word	0x[0-9a-f]+
+*/
+
 /*
 ** main: { target x86_64-*-* }
 ** ...
@@ -31,4 +36,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target aarch64*-*-* }
+** ...
+** ldur	w16, \[x[0-9]+, #-20\]
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
index 872814aa4171..7a1dc4fa0e07 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
@@ -25,6 +25,11 @@ int main() {
 ** movl	\$0x[0-9a-f]+, %eax
 */
 
+/*
+** __cfi_test_function: { target aarch64*-*-* }
+** .word	0x[0-9a-f]+
+*/
+
 /*
 ** main: { target x86_64-*-* }
 ** ...
@@ -32,4 +37,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target aarch64*-*-* }
+** ...
+** ldur	w16, \[x[0-9]+, #-16\]
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
index 04a9eb1fd206..1a7cc4aa167f 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
@@ -78,3 +78,22 @@ int test_non_tail_indirect_call(func_ptr_t handler, int x) {
 
 /* Should have exactly 1 regular call (non-tail call case).  */
 /* { dg-final { scan-assembler-times {call\t\*%[a-z0-9]+} 1 { target x86_64-*-* } } } */
+
+/* Should have exactly 4 KCFI checks for indirect calls (load type ID from
+   -4 offset + compare).  */
+/* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 4 { target aarch64-*-* } } } */
+/* { dg-final { scan-assembler-times {cmp\tw16, w17} 4 { target aarch64-*-* } } } */
+
+/* Should have exactly 4 trap instructions.  */
+/* { dg-final { scan-assembler-times {brk\t#[0-9]+} 4 { target aarch64-*-* } } } */
+
+/* Should have exactly 3 protected tail calls (br through register after
+   KCFI check).  */
+/* { dg-final { scan-assembler-times {br\tx[0-9]+} 3 { target aarch64-*-* } } } */
+
+/* Should have exactly 1 regular call (non-tail call case).  */
+/* { dg-final { scan-assembler-times {blr\tx[0-9]+} 1 { target aarch64-*-* } } } */
+
+/* Type ID loading should use mov + movk pattern for 32-bit constants.  */
+/* { dg-final { scan-assembler {mov\tw17, #[0-9]+} { target aarch64-*-* } } } */
+/* { dg-final { scan-assembler {movk\tw17, #[0-9]+, lsl #16} { target aarch64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
new file mode 100644
index 000000000000..0c257565c9e8
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
@@ -0,0 +1,41 @@
+/* Test AArch64 and ARM32 KCFI trap encoding in BRK/UDF instructions.  */
+/* { dg-do compile { target aarch64*-*-* } } */
+
+void target_function(int x, char y) {
+}
+
+int main() {
+    void (*func_ptr)(int, char) = target_function;
+
+    /* This should generate trap with immediate encoding.  */
+    func_ptr(42, 'a');
+
+    return 0;
+}
+
+/* Should have KCFI preamble.  */
+/* { dg-final { scan-assembler "__cfi_target_function:" } } */
+
+/* AArch64 specific: Should have BRK instruction with proper ESR encoding
+   ESR format: 0x8000 | ((type_reg & 31) << 5) | (addr_reg & 31)
+
+   Test the ESR encoding by checking for the expected value.
+   Since we know this test uses x2, we expect ESR = 0x8000 | (17<<5) | 2 = 33314
+   */
+
+/*
+** main: { target aarch64*-*-* }
+** ...
+** ldur	w16, \[x[0-9]+, #-4\]
+** mov	w17, #[0-9]+
+** movk	w17, #[0-9]+, lsl #16
+** cmp	w16, w17
+** b\.eq	.Lkcfi_call[0-9]+
+** .Lkcfi_trap[0-9]+:
+** brk	#33314
+** .Lkcfi_call[0-9]+:
+** blr	x2
+** ...
+*/
+
+/* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
index 55c0829ccd7b..e92873e51321 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
@@ -18,6 +18,10 @@ int main() {
 
 /* Should have exactly 2 trap labels in code.  */
 /* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ud2} 2 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*brk} 2 { target aarch64*-*-* } } } */
 
 /* x86_64 should exactly 2 .kcfi_traps sections.  */
 /* { dg-final { scan-assembler-times {\.section\t\.kcfi_traps,"ao",@progbits,\.text} 2 { target x86_64-*-* } } } */
+
+/* AArch64 should NOT have .kcfi_traps section.  */
+/* { dg-final { scan-assembler-not {\.section\t+\.kcfi_traps} { target aarch64*-*-* } } } */
-- 
2.34.1

