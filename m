Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2230D3F6
	for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163343; cv=none; b=P8mXv9k0BVvfgs5WuwY/xuINSPDPOk8sp9f5vNg58eerQrsVIX+G0d1CmU2byAtbq+w1DM1DtFY7oYqX3xWcX6L/9qqpeLE2ArdP1GKKB/5WLS4AvJXIWSWDyYDzFPn3snw023EQX9txC5sRxaodXCwSzw67cLvwMxYXAdUBUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163343; c=relaxed/simple;
	bh=DOBzHTwYZMfFrwTUyjcdAAPEA04E/pBloASM80sKO54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtJtNgpILyYTFmjq1p+Clq069Gvfr7/xSsFKXLwlzkVYhc7Lt/wrvGDYSr4GArjk4RJSi5FYi9coUxoC68TpufsenfyU6x9ILyEs8LQa8OTxr3OQavh9QyigGMccKlA2t+hr/cGHEMLTODeCysuSwhnHeLDbljjschuxEKuUJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlgSwyne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlgSwyne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497531F00AC4;
	Thu, 16 Jul 2026 00:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784163336;
	bh=jWTR7bTaaPhjR+q/8XCdIuE0cqaXfTzxt+JwQlSsxE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YlgSwyneFGVApvXrYofy5BqV2TrVNYnPN2f/jOyDCDT6yoyPYlTmXx5S+DNgAhS6q
	 WFQTybXacZuasBsEVPuLpkdbmRiarMOVKUpKFzrqXq2CvTcx99w9umPgnxQewTPqnE
	 5d3hOIE/ui/mKVIqELqoEkDc4HDtHQOlFx22B8Bcdq1TINSqXbVfjjphSxg9gToIKw
	 YgJkxzj2CAD1kw6WiaodLdHnbyKPbfn+2xP6acDcN9q7g7a7j3+fmTt2eAH20rhbFj
	 TsHgw3pbIafO+gBDykV/iVA+UMyLhKHvO36lap3Px/LXT5h5ntej2iSMAVyb2LZmoy
	 JF6+/YLokDF1w==
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
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
	"Osterlund Sebastian" <sebastian.osterlund@intel.com>,
	"Constable Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v14 7/7] riscv: Add RISC-V Kernel Control Flow Integrity implementation
Date: Wed, 15 Jul 2026 17:55:34 -0700
Message-Id: <20260716005535.1786157-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716005527.it.950-kees@kernel.org>
References: <20260716005527.it.950-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=40851; i=kees@kernel.org; h=from:subject; bh=DOBzHTwYZMfFrwTUyjcdAAPEA04E/pBloASM80sKO54=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkROqzakxXLVNi1Lyf3lfS1/35xPf3+kVNhSrFF66Otl p7juxPXUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJGex4wMZ56VppbMYnjUz1J0 4uSdzcF2Mp/v1u28pX+e836BBFdqJMMfLvWtbRZ+pT/fWm5UPDnpokLIgU/M5qwfDWqvL3PN6Uj gAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Implement RISC-V-specific KCFI backend. This is rv64-only: the emitted
typeid construction uses addiw, which exists only on RV64/RV128. An rv32
backend would need an alternate sequence (e.g. addi); since the only
current user of KCFI on riscv is the rv64 build of the Linux kernel, the
support hook rejects rv32.

- Scratch register allocation using t1/t2 (x6/x7) following RISC-V
  procedure call standard for temporary registers (already
  caller-saved), and t3 (x28) when either t1 or t2 is already the call
  target register.

- Incompatible with -ffixed-t1, -ffixed-t2, or -ffixed-t3.

- Integration with .kcfi_traps section for debugger/runtime metadata
  (like x86_64).

Assembly Code Pattern for RISC-V:
  lw      t1, -4(target_reg)         ; Load actual type ID from preamble
  lui     t2, %hi(expected_type)     ; Load expected type (upper 20 bits)
  addiw   t2, t2, %lo(expected_type) ; Add lower 12 bits (sign-extended)
  beq     t1, t2, .Lkcfi_call        ; Branch if types match
  .Lkcfi_trap: ebreak                ; Environment break trap on mismatch
  .Lkcfi_call: jalr/jr target_reg    ; Execute validated indirect transfer

Build and run tested with Linux kernel ARCH=riscv.

gcc/ChangeLog:

	* config/riscv/riscv-protos.h: Declare KCFI helpers.
	* config/riscv/riscv.cc (riscv_maybe_wrap_call_with_kcfi): New
	function, to wrap calls.
	(riscv_maybe_wrap_call_value_with_kcfi): New function, to
	wrap calls with return values.
	(riscv_output_kcfi_insn): New function to emit KCFI assembly.
	* config/riscv/riscv.md: Add KCFI RTL patterns and hook expansion.
	* doc/invoke.texi: Document riscv nuances.

gcc/testsuite/ChangeLog:

	* gcc.dg/kcfi/kcfi-adjacency.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-basics.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-call-sharing.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-complex-addressing.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-direct-call-shapes.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-move-preservation.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-no-sanitize.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-offset-validation.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-patchable-large.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-patchable-medium.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-tail-calls.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-trap-section.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-trap-section-per-func.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-riscv-32bit.c: New test.
	* gcc.dg/kcfi/kcfi-riscv-fixed-t1.c: New test.
	* gcc.dg/kcfi/kcfi-riscv-fixed-t2.c: New test.
	* gcc.dg/kcfi/kcfi-riscv-fixed-t3.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/riscv/riscv-protos.h               |   3 +
 gcc/config/riscv/riscv.md                     |  76 ++++++-
 gcc/config/riscv/riscv.cc                     | 199 ++++++++++++++++++
 gcc/doc/invoke.texi                           |  17 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  18 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  22 +-
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |   4 +
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  19 ++
 .../gcc.dg/kcfi/kcfi-direct-call-shapes.c     |   1 +
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  20 ++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |   5 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   1 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   3 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |   9 +-
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  10 +-
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |   9 +-
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |   9 +-
 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c  |   7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t1.c         |   7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t2.c         |   7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t3.c         |   7 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  23 ++
 .../gcc.dg/kcfi/kcfi-trap-section-per-func.c  |   2 +-
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   5 +-
 24 files changed, 466 insertions(+), 17 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c

diff --git a/gcc/config/riscv/riscv-protos.h b/gcc/config/riscv/riscv-protos.h
index 3da840fab470..e4440b58181a 100644
--- a/gcc/config/riscv/riscv-protos.h
+++ b/gcc/config/riscv/riscv-protos.h
@@ -126,6 +126,9 @@ extern bool riscv_split_64bit_move_p (rtx, rtx);
 extern void riscv_split_doubleword_move (rtx, rtx);
 extern const char *riscv_output_move (rtx, rtx);
 extern const char *riscv_output_return ();
+extern rtx riscv_maybe_wrap_call_with_kcfi (rtx, rtx);
+extern rtx riscv_maybe_wrap_call_value_with_kcfi (rtx, rtx);
+extern const char *riscv_output_kcfi_insn (rtx_insn *, rtx *);
 extern void riscv_declare_function_name (FILE *, const char *, tree);
 extern void riscv_declare_function_size (FILE *, const char *, tree);
 extern void riscv_asm_output_alias (FILE *, const tree, const tree);
diff --git a/gcc/config/riscv/riscv.md b/gcc/config/riscv/riscv.md
index c64e4ff3c77b..c36758b7dfb0 100644
--- a/gcc/config/riscv/riscv.md
+++ b/gcc/config/riscv/riscv.md
@@ -4154,10 +4154,24 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[0], 0));
-  emit_call_insn (gen_sibcall_internal (target, operands[1]));
+  rtx pat = gen_sibcall_internal (target, operands[1]);
+  pat = riscv_maybe_wrap_call_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI sibling call
+(define_insn "*kcfi_sibcall_insn"
+  [(kcfi (call (mem:SI (match_operand 0 "call_insn_operand" "l"))
+	       (match_operand 1 ""))
+	 (match_operand 2 "const_int_operand"))]
+  "SIBLING_CALL_P (insn)"
+{
+  return riscv_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
 (define_insn "sibcall_internal"
   [(call (mem:SI (match_operand 0 "call_insn_operand" "j,S,U"))
 	 (match_operand 1 "" ""))]
@@ -4176,11 +4190,25 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[1], 0));
-  emit_call_insn (gen_sibcall_value_internal (operands[0], target,
-					      operands[2]));
+  rtx pat = gen_sibcall_value_internal (operands[0], target, operands[2]);
+  pat = riscv_maybe_wrap_call_value_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI sibling call with return value
+(define_insn "*kcfi_sibcall_value_insn"
+  [(set (match_operand 0 "")
+	(kcfi (call (mem:SI (match_operand 1 "call_insn_operand" "l"))
+		    (match_operand 2 ""))
+	      (match_operand 3 "const_int_operand")))]
+  "SIBLING_CALL_P (insn)"
+{
+  return riscv_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
 (define_insn "sibcall_value_internal"
   [(set (match_operand 0 "" "")
 	(call (mem:SI (match_operand 1 "call_insn_operand" "j,S,U"))
@@ -4198,15 +4226,31 @@
 	      (use (match_operand 2 ""))])]
   ""
 {
+  rtx pat;
   rtx addr = XEXP (operands[0], 0);
   rtx target = riscv_legitimize_call_address (addr);
   if (riscv_call_needs_lpad_p (addr))
-    emit_call_insn (gen_call_internal_cfi (target, operands[1]));
+    pat = gen_call_internal_cfi (target, operands[1]);
   else
-    emit_call_insn (gen_call_internal (target, operands[1]));
+    pat = gen_call_internal (target, operands[1]);
+  pat = riscv_maybe_wrap_call_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI indirect call
+(define_insn "*kcfi_call_internal"
+  [(kcfi (call (mem:SI (match_operand 0 "call_insn_operand" "l"))
+	       (match_operand 1 "" ""))
+	 (match_operand 2 "const_int_operand"))
+   (clobber (reg:SI RETURN_ADDR_REGNUM))]
+  "!SIBLING_CALL_P (insn)"
+{
+  return riscv_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
 (define_insn "call_internal"
   [(call (mem:SI (match_operand 0 "call_insn_operand" "l,S,U"))
 	 (match_operand 1 "" ""))
@@ -4256,16 +4300,32 @@
 	      (use (match_operand 3 ""))])]
   ""
 {
+  rtx pat;
   rtx addr = XEXP (operands[1], 0);
   rtx target = riscv_legitimize_call_address (addr);
   if (riscv_call_needs_lpad_p (addr))
-    emit_call_insn (gen_call_value_internal_cfi (operands[0], target,
-						 operands[2]));
+    pat = gen_call_value_internal_cfi (operands[0], target, operands[2]);
   else
-    emit_call_insn (gen_call_value_internal (operands[0], target, operands[2]));
+    pat = gen_call_value_internal (operands[0], target, operands[2]);
+  pat = riscv_maybe_wrap_call_value_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI call with return value
+(define_insn "*kcfi_call_value_insn"
+  [(set (match_operand 0 "" "")
+	(kcfi (call (mem:SI (match_operand 1 "call_insn_operand" "l"))
+		    (match_operand 2 "" ""))
+	      (match_operand 3 "const_int_operand")))
+   (clobber (reg:SI RETURN_ADDR_REGNUM))]
+  "!SIBLING_CALL_P (insn)"
+{
+  return riscv_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
 (define_insn "call_value_internal"
   [(set (match_operand 0 "" "")
 	(call (mem:SI (match_operand 1 "call_insn_operand" "l,S,U"))
diff --git a/gcc/config/riscv/riscv.cc b/gcc/config/riscv/riscv.cc
index 873defc5a5b5..7ef5a97d6110 100644
--- a/gcc/config/riscv/riscv.cc
+++ b/gcc/config/riscv/riscv.cc
@@ -82,6 +82,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "cgraph.h"
 #include "langhooks.h"
 #include "gimplify.h"
+#include "kcfi.h"
 
 /* This file should be included last.  */
 #include "target-def.h"
@@ -12012,6 +12013,180 @@ riscv_convert_vector_chunks (struct gcc_options *opts)
     return 1;
 }
 
+/* Apply KCFI wrapping to call pattern if needed.  PAT is the RTL call
+   pattern to potentially wrap with KCFI instrumentation.  ADDR is the
+   call target address RTL expression.  Returns the possibly modified
+   call pattern with KCFI wrapper applied for indirect calls.  */
+
+rtx
+riscv_maybe_wrap_call_with_kcfi (rtx pat, rtx addr)
+{
+  /* Only indirect calls need KCFI instrumentation.  */
+  if (REG_P (addr))
+    {
+      rtx kcfi_type_rtx = kcfi_get_type_id_for_expanding_gimple_call ();
+      if (kcfi_type_rtx)
+	{
+	  /* The call pattern is a PARALLEL when it has clobbers (regular
+	     calls) and a bare CALL otherwise (sibling calls).  Wrap the
+	     CALL in either case.  */
+	  if (GET_CODE (pat) == PARALLEL)
+	    {
+	      rtx call_rtx = XVECEXP (pat, 0, 0);
+	      rtx kcfi_call = gen_rtx_KCFI (VOIDmode, call_rtx, kcfi_type_rtx);
+	      XVECEXP (pat, 0, 0) = kcfi_call;
+	    }
+	  else
+	    {
+	      gcc_assert (GET_CODE (pat) == CALL);
+	      pat = gen_rtx_KCFI (VOIDmode, pat, kcfi_type_rtx);
+	    }
+	}
+    }
+  return pat;
+}
+
+/* Apply KCFI wrapping to call_value pattern if needed.  PAT is the RTL
+   call_value pattern to potentially wrap with KCFI instrumentation.  ADDR
+   is the call target address RTL expression.  Returns the possibly modified
+   call pattern with KCFI wrapper applied for indirect calls.  */
+
+rtx
+riscv_maybe_wrap_call_value_with_kcfi (rtx pat, rtx addr)
+{
+  /* Only indirect calls need KCFI instrumentation.  */
+  if (REG_P (addr))
+    {
+      rtx kcfi_type_rtx = kcfi_get_type_id_for_expanding_gimple_call ();
+      if (kcfi_type_rtx)
+	{
+	  /* The call_value pattern is a PARALLEL when it has clobbers
+	     (regular calls) and a bare SET otherwise (sibling calls).
+	     Wrap the inner CALL in either case.  */
+	  rtx set_rtx = (GET_CODE (pat) == PARALLEL)
+			? XVECEXP (pat, 0, 0) : pat;
+	  gcc_assert (GET_CODE (set_rtx) == SET);
+	  rtx call_rtx = SET_SRC (set_rtx);
+	  rtx kcfi_call = gen_rtx_KCFI (VOIDmode, call_rtx, kcfi_type_rtx);
+	  SET_SRC (set_rtx) = kcfi_call;
+	}
+    }
+  return pat;
+}
+
+/* Output the assembly for a KCFI checked call instruction.  INSN is the
+   RTL instruction being processed.  OPERANDS is the array of RTL operands
+   where operands[0] is the call target register, operands[2] is the KCFI
+   type ID constant.  Returns an empty string as all output is handled by
+   direct assembly generation.  */
+
+const char *
+riscv_output_kcfi_insn (rtx_insn *insn, rtx *operands)
+{
+  /* Target register.  */
+  rtx target_reg = operands[0];
+  gcc_assert (REG_P (target_reg));
+
+  /* Get KCFI type ID.  */
+  uint32_t expected_type = UINTVAL (operands[2]);
+
+  /* Calculate typeid offset from call target.  */
+  HOST_WIDE_INT offset = -kcfi_get_typeid_offset ();
+
+  /* Choose scratch registers that don't conflict with target.  */
+  unsigned temp1_regnum = T1_REGNUM;
+  unsigned temp2_regnum = T2_REGNUM;
+
+  if (REGNO (target_reg) == T1_REGNUM)
+    temp1_regnum = T3_REGNUM;
+  else if (REGNO (target_reg) == T2_REGNUM)
+    temp2_regnum = T3_REGNUM;
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
+  /* Split expected_type for RISC-V immediate encoding.
+     If bit 11 is set, increment upper 20 bits to compensate for sign
+     extension.  */
+  int32_t lo12 = ((int32_t)(expected_type << 20)) >> 20;
+  uint32_t hi20 = ((expected_type >> 12)
+		    + ((expected_type & 0x800) ? 1 : 0)) & 0xFFFFF;
+
+  rtx temp_operands[3];
+
+  /* The check sequence (typeid load through indirect jump) must be emitted
+     as a single atomic unit: a mismatch must be caught before the jalr
+     executes, with no opportunity for the linker or assembler to interleave
+     anything.  Disable linker relaxation (which can rewrite jalr/call forms
+     and shift offsets) and the C extension (which can shrink instructions
+     and perturb sizes the length attribute reports) for the duration.  */
+  output_asm_insn (".option push", operands);
+  output_asm_insn (".option norelax", operands);
+  output_asm_insn (".option norvc", operands);
+
+  /* Load actual type from memory at offset.  */
+  temp_operands[0] = gen_rtx_REG (SImode, temp1_regnum);
+  temp_operands[1] = gen_rtx_MEM (SImode,
+				  gen_rtx_PLUS (DImode, target_reg,
+						GEN_INT (offset)));
+  output_asm_insn ("lw\t%0, %1", temp_operands);
+
+  /* Load expected type using lui + addiw for proper sign extension.  */
+  temp_operands[0] = gen_rtx_REG (SImode, temp2_regnum);
+  temp_operands[1] = GEN_INT (hi20);
+  output_asm_insn ("lui\t%0, %1", temp_operands);
+
+  temp_operands[0] = gen_rtx_REG (SImode, temp2_regnum);
+  temp_operands[1] = gen_rtx_REG (SImode, temp2_regnum);
+  temp_operands[2] = GEN_INT (lo12);
+  output_asm_insn ("addiw\t%0, %1, %2", temp_operands);
+
+  /* Output conditional branch to call label.  */
+  fprintf (asm_out_file, "\tbeq\t%s, %s, ",
+	   reg_names[temp1_regnum], reg_names[temp2_regnum]);
+  assemble_name (asm_out_file, call_name);
+  fputc ('\n', asm_out_file);
+
+  /* Output trap label and ebreak instruction.  */
+  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
+  output_asm_insn ("ebreak", operands);
+
+  /* Use common helper for trap section entry.  */
+  rtx trap_label_sym = gen_rtx_SYMBOL_REF (Pmode, trap_name);
+  kcfi_emit_traps_section (asm_out_file, trap_label_sym, labelno);
+
+  /* Output pass/call label.  */
+  ASM_OUTPUT_LABEL (asm_out_file, call_name);
+
+  /* Execute the indirect call.  */
+  if (SIBLING_CALL_P (insn))
+    {
+      /* Tail call uses x0 (zero register) to avoid saving return address.  */
+      temp_operands[0] = gen_rtx_REG (DImode, 0);
+      temp_operands[1] = target_reg;
+      temp_operands[2] = const0_rtx;
+      output_asm_insn ("jalr\t%0, %1, %2", temp_operands);
+    }
+  else
+    {
+      /* Regular call uses x1 (return address register).  */
+      temp_operands[0] = gen_rtx_REG (DImode, RETURN_ADDR_REGNUM);
+      temp_operands[1] = target_reg;
+      temp_operands[2] = const0_rtx;
+      output_asm_insn ("jalr\t%0, %1, %2", temp_operands);
+    }
+
+  output_asm_insn (".option pop", operands);
+
+  return "";
+}
+
 /* 'Unpack' up the internal tuning structs and update the options
     in OPTS.  The caller must have set up selected_tune and selected_arch
     as all the other target-specific codegen decisions are
@@ -16931,6 +17106,30 @@ riscv_memtag_tag_bitsize ()
 #undef TARGET_MEMTAG_TAG_BITSIZE
 #define TARGET_MEMTAG_TAG_BITSIZE riscv_memtag_tag_bitsize
 
+/* Return true if the target supports KCFI.
+   KCFI requires 64-bit mode and the T1, T2, and T3 registers.  */
+
+static bool
+riscv_kcfi_supported_p (void)
+{
+  if (!TARGET_64BIT)
+    {
+      error ("%<-fsanitize=kcfi%> is not supported for 32-bit RISC-V");
+      return false;
+    }
+  if (fixed_regs[T1_REGNUM] || fixed_regs[T2_REGNUM] || fixed_regs[T3_REGNUM])
+    {
+      error ("%<-fsanitize=kcfi%> is not compatible with %<-ffixed-t1%>, "
+	     "%<-ffixed-t2%>, or %<-ffixed-t3%> as KCFI requires these "
+	     "registers for type checking");
+      return false;
+    }
+  return true;
+}
+
+#undef TARGET_KCFI_SUPPORTED
+#define TARGET_KCFI_SUPPORTED riscv_kcfi_supported_p
+
 #undef TARGET_DOCUMENTATION_NAME
 #define TARGET_DOCUMENTATION_NAME "RISC-V"
 
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 4385590a0af6..9448ec64a47a 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -17600,6 +17600,23 @@ allowing the kernel to identify both the KCFI violation and the involved
 registers for detailed diagnostics (eliminating the need for a separate
 @code{.kcfi_traps} section as used on x86_64).
 
+On 64-bit RISC-V, KCFI type identifiers are emitted as a @code{.word ID}
+directive (a 32-bit constant) before the function entry, similar to AArch64.
+RISC-V's natural instruction alignment eliminates the need for
+additional alignment NOPs.  When used with @option{-fpatchable-function-entry},
+the type identifier is placed before any prefix NOPs.  The runtime check
+loads the actual type using @code{lw t1, OFFSET(target_reg)}, where the
+offset accounts for any prefix NOPs, constructs the expected type using
+@code{lui} and @code{addiw} instructions into @code{t2}, and compares them
+with @code{beq}.  @code{t3} is used as an alternative when @code{t1} or
+@code{t2} is the target call register.  Because of the use of these
+registers, they cannot be fixed registers, so KCFI cannot be used with any
+of @code{-ffixed-t1}, @code{-ffixed-t2}, nor @code{-ffixed-t3}. Type
+mismatches trigger an @code{ebreak} instruction.  Like x86_64, RISC-V
+uses a @code{.kcfi_traps} section to map trap locations to their
+corresponding function entry points for debugging (RISC-V lacks
+ESR-style trap encoding like used on AArch64).
+
 KCFI is intended primarily for kernel code and may not be suitable
 for user-space applications that rely on techniques incompatible
 with strict type checking of indirect calls.
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
index 63fade749ddd..fad09c4f08d1 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
@@ -121,4 +121,22 @@ __attribute__((noinline)) void test_conditional_call(int flag) {
 ** ...
 */
 
+/*
+** test_complex_args: { target riscv*-*-* }
+** ...
+** lw	t1, -4\((a[0-9]+)\)
+** lui	t2, [0-9]+
+** addiw	t2, t2, -?[0-9]+
+** beq	t1, t2, .Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ebreak
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .4byte	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** jalr	zero, \1, 0
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
index a917e1c70089..9256d2a1a3c3 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
@@ -59,8 +59,8 @@ int main() {
 /* x86_64: Verify type ID in preamble (after NOPs, before function label) */
 /* { dg-final { scan-assembler {__cfi_regular_function:\n\t+nop\n.*\n\t+movl\t+\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
 
-/* AArch64, ARM32: Verify type ID word in preamble.  */
-/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word\t0x[0-9a-f]+} { target aarch64*-*-* arm*-*-* } } } */
+/* AArch64, ARM32, RISC-V: Verify type ID word in preamble.  */
+/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word\t0x[0-9a-f]+} { target aarch64*-*-* arm*-*-* riscv*-*-* } } } */
 
 /*
 ** static_caller: { target x86_64-*-* }
@@ -128,6 +128,24 @@ int main() {
 ** ...
 */
 
+/*
+** static_caller: { target riscv*-*-* }
+** ...
+** lw	t1, -4\((a[0-9]+)\)
+** lui	t2, [0-9]+
+** addiw	t2, t2, -?[0-9]+
+** beq	t1, t2, .Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ebreak
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .4byte	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** jalr	ra, \1, 0
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
 
 /* Extern functions should NOT get KCFI preambles.  */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
index c2ecf3448b73..476e12534578 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
@@ -69,6 +69,7 @@ int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *
 /* ARM 32-bit: In Thumb-2 the load base is ip (post-Thumb-bit-strip), in ARM
    mode it is the call target register or lr; accept any.  */
 /* { dg-final { scan-assembler-times {ldr\s+ip, \[(?:r[0-9]+|lr|ip), #-4\]} 3 { target arm*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-times {lui\tt2, [0-9]+} 2 { target riscv*-*-* } } } */
 
 /* Verify the checks use DIFFERENT type IDs (not shared, except arm: see above).
    We should NOT see the same type ID used twice - that would indicate
@@ -76,13 +77,16 @@ int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *
 /* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*movl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-not {mov\s+w17, #([0-9]+).*mov\s+w17, #\1} { target aarch64*-*-* } } } */
 /* ARM 32-bit: { dg-final { scan-assembler-not {eor\s+ip, ip, #([0-9]+)\n\teor\s+r3, r3, #([0-9]+)\n\teor\s+r3, r3, #([0-9]+)\n\teors\s+r3, r3, #([0-9]+).*eor\s+r3, r3, #\1\n\teor\s+r3, r3, #[0-9]+\n\teor\s+r3, r3, #[0-9]+\n\teors\s+r3, r3, #[0-9]+.*eor\s+r3, r3, #\1\n\teor\s+r3, r3, #[0-9]+\n\teor\s+r3, r3, #[0-9]+\n\teors\s+r3, r3, #[0-9]+} { target arm*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-not {lui\s+t2, ([0-9]+)\s.*lui\s+t2, \1\s} { target riscv*-*-* } } } */
 
 /* Verify expected number of traps.  */
 /* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {brk\s+#0x[0-9a-f]+} 2 { target aarch64*-*-* } } } */
 /* ARM 32-bit: { dg-final { scan-assembler-times {udf\s+#[0-9]+} 3 { target arm*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-times {ebreak} 2 { target riscv*-*-* } } } */
 
 /* Verify 2 separate call sites (except arm).  */
 /* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {br\tx[0-9]+} 2 { target aarch64*-*-* } } } */
 /* ARM 32-bit: { dg-final { scan-assembler-times {bx\s+(?:r[0-9]+|lr)} 3 { target arm*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-times {jalr\t[a-z0-9]+} 2 { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
index 5eec800e108d..b11014c29676 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
@@ -184,4 +184,23 @@ int main() {
 ** ...
 */
 
+/* Standard KCFI handling.  */
+/*
+** test_struct_members: { target riscv*-*-* }
+** ...
+** lw	t1, -4\((a[0-9]+)\)
+** lui	t2, [0-9]+
+** addiw	t2, t2, -?[0-9]+
+** beq	t1, t2, .Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ebreak
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .4byte	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** jalr	ra, \1, 0
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
index 2daf5aa94bcf..1c72f0fc5757 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
@@ -33,3 +33,4 @@ void caller(int sel, void (*ip)(int), int x) {
 /* The arm load base is the call target register in ARM mode and ip in
    Thumb-2 (after the Thumb-bit strip); accept either.  */
 /* { dg-final { scan-assembler-times {ldr\tip, \[(?:r[0-9]+|ip), #-4\]} 1 { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-times {lw\tt1, -4\(a[0-9]+\)} 1 { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
index fac0e3aff0e4..b78434cbe5e6 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
@@ -112,6 +112,26 @@ int main(void)
 ** ...
 */
 
+/*
+** indirect_call: { target riscv*-*-* }
+** ...
+** mv	(a[0-9]+),a0
+** addi	a0,a4,%lo\(called_count\)
+** lw	t1, -4\(\1\)
+** lui	t2, [0-9]+
+** addiw	t2, t2, -?[0-9]+
+** beq	t1, t2, .Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ebreak
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .4byte	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** jalr	zero, \1, 0
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
 
 /* AArch64, ARM32 should NOT have trap section (use immediate instructions instead).  */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
index 279207a85cdc..8bc353ed2d32 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
@@ -77,6 +77,7 @@ int main(void)
 /* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-times {brk\s+#0x[0-9a-f]+} 2 { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler-times {udf\s+#[0-9]+} 2 { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-times {ebreak} 2 { target riscv*-*-* } } } */
 
 /* Positive controls: these should have KCFI checks.  */
 /* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_function} { target x86_64-*-* } } } */
@@ -85,6 +86,8 @@ int main(void)
 /* { dg-final { scan-assembler {wrap_normal_inline:.*brk\s+#0x[0-9a-f]+.*\.size\s+wrap_normal_inline} { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler {normal_function:.*udf\t#[0-9]+.*\.size\s+normal_function} { target arm*-*-* } } } */
 /* { dg-final { scan-assembler {wrap_normal_inline:.*udf\t#[0-9]+.*\.size\s+wrap_normal_inline} { target arm*-*-* } } } */
+/* { dg-final { scan-assembler {normal_function:.*ebreak.*\.size\s+normal_function} { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler {wrap_normal_inline:.*ebreak.*\.size\s+wrap_normal_inline} { target riscv*-*-* } } } */
 
 /* Negative controls: these should NOT have KCFI checks.  */
 /* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
@@ -93,3 +96,5 @@ int main(void)
 /* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*brk\s+#0x[0-9a-f]+.*\.size\s+wrap_sensitive_inline} { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler-not {sensitive_non_inline_function:[^\n]*udf\t#[0-9]+[^\n]*\.size\tsensitive_non_inline_function} { target arm*-*-* } } } */
 /* { dg-final { scan-assembler-not {wrap_sensitive_inline:[^\n]*udf\t#[0-9]+[^\n]*\.size\twrap_sensitive_inline} { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ebreak.*\.size\s+sensitive_non_inline_function} { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ebreak.*\.size\s+wrap_sensitive_inline} { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
index 9355d633301b..86855eca9d86 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
@@ -38,3 +38,4 @@ int main() {
 /* In Thumb-2 the load base is ip (post-Thumb-bit-strip), in ARM mode it is
    the call target register; accept either.  */
 /* { dg-final { scan-assembler-times {ldr\tip, \[(?:r[0-9]+|ip), #-4\]} 1 { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-times {lw\tt1, -[0-9]+\(} 1 { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
index cb1eb7c7ecc6..8d48c5f2ef23 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
@@ -35,3 +35,6 @@ int main() {
    In Thumb-2 the load base is ip (after the Thumb-bit strip); in ARM mode it
    is the call target register directly.  Accept either.  */
 /* { dg-final { scan-assembler {ldr\tip, \[(?:r[0-9]+|ip), #-4\]} { target arm*-*-* } } } */
+
+/* RISC-V: All call sites should use -4 offset.  */
+/* { dg-final { scan-assembler {lw\tt1, -4\(} { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
index 612140a0f509..db2ec8a5b64f 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
@@ -29,7 +29,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* riscv*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -54,4 +54,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target riscv*-*-* }
+** ...
+** lw	t1, -4\(a[0-9]+\)
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
index 7f7ada17cc14..49a684b7ee15 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
@@ -21,7 +21,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* riscv*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -46,4 +46,12 @@ int main() {
 ** ...
 */
 
+
+/*
+** main: { target riscv*-*-* }
+** ...
+** lw	t1, -48\(a[0-9]+\)
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
index 0a1f4e20851f..8d53407789cf 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
@@ -28,7 +28,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* riscv*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -53,4 +53,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target riscv*-*-* }
+** ...
+** lw	t1, -20\(a[0-9]+\)
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
index 548a2f5d8b84..d85f7f907ce5 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
@@ -29,7 +29,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* riscv*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -54,4 +54,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target riscv*-*-* }
+** ...
+** lw	t1, -16\(a[0-9]+\)
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c
new file mode 100644
index 000000000000..8b2dc926c704
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c
@@ -0,0 +1,7 @@
+/* Test that KCFI is rejected for 32-bit RISC-V.  */
+/* { dg-do compile { target riscv*-*-* } } */
+/* { dg-additional-options "-march=rv32gc -mabi=ilp32d" } */
+/* { dg-error ".-fsanitize=kcfi. is not supported for 32-bit RISC-V" "" { target *-*-* } 0 } */
+/* { dg-message "sorry, unimplemented: .-fsanitize=kcfi. not supported" "" { target *-*-* } 0 } */
+
+void foo (void) { }
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
new file mode 100644
index 000000000000..a5ef21092d63
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
@@ -0,0 +1,7 @@
+/* Test that KCFI is incompatible with -ffixed-t1 on RISC-V.  */
+/* { dg-do compile { target riscv*-*-* } } */
+/* { dg-additional-options "-ffixed-t1" } */
+/* { dg-error ".-fsanitize=kcfi. is not compatible with .-ffixed-t1., .-ffixed-t2., or .-ffixed-t3. as KCFI requires these registers for type checking" "" { target *-*-* } 0 } */
+/* { dg-message "sorry, unimplemented: .-fsanitize=kcfi. not supported" "" { target *-*-* } 0 } */
+
+void foo (void) { }
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
new file mode 100644
index 000000000000..3ead648e7154
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
@@ -0,0 +1,7 @@
+/* Test that KCFI is incompatible with -ffixed-t2 on RISC-V.  */
+/* { dg-do compile { target riscv*-*-* } } */
+/* { dg-additional-options "-ffixed-t2" } */
+/* { dg-error ".-fsanitize=kcfi. is not compatible with .-ffixed-t1., .-ffixed-t2., or .-ffixed-t3. as KCFI requires these registers for type checking" "" { target *-*-* } 0 } */
+/* { dg-message "sorry, unimplemented: .-fsanitize=kcfi. not supported" "" { target *-*-* } 0 } */
+
+void foo (void) { }
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c
new file mode 100644
index 000000000000..98b579867a48
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c
@@ -0,0 +1,7 @@
+/* Test that KCFI is incompatible with -ffixed-t3 on RISC-V.  */
+/* { dg-do compile { target riscv*-*-* } } */
+/* { dg-additional-options "-ffixed-t3" } */
+/* { dg-error ".-fsanitize=kcfi. is not compatible with .-ffixed-t1., .-ffixed-t2., or .-ffixed-t3. as KCFI requires these registers for type checking" "" { target *-*-* } 0 } */
+/* { dg-message "sorry, unimplemented: .-fsanitize=kcfi. not supported" "" { target *-*-* } 0 } */
+
+void foo (void) { }
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
index 544ae7807297..f8a76d3ac4f6 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
@@ -67,6 +67,8 @@ int test_non_tail_indirect_call(func_ptr_t handler, int x) {
 /* Should have exactly 4 trap sections and 4 trap instructions.  */
 /* { dg-final { scan-assembler-times "\\.kcfi_traps" 4 { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-times "ud2" 4 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times "\\.kcfi_traps" 4 { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler-times "ebreak" 4 { target riscv*-*-* } } } */
 
 /* Should NOT have unprotected direct jumps to vtable.  */
 /* { dg-final { scan-assembler-not {jmp\t\*vtable\(%rip\)} { target x86_64-*-* } } } */
@@ -79,6 +81,27 @@ int test_non_tail_indirect_call(func_ptr_t handler, int x) {
 /* Should have exactly 1 regular call (non-tail call case).  */
 /* { dg-final { scan-assembler-times {call\t\*%[a-z0-9]+} 1 { target x86_64-*-* } } } */
 
+/* RISC-V: Should have exactly 4 KCFI checks for indirect calls
+   (comparison instruction).  */
+/* { dg-final { scan-assembler-times {beq\tt1, t2, \.Lkcfi_call[0-9]+} 4 { target riscv*-*-* } } } */
+
+/* RISC-V: Should have exactly 4 KCFI checks for indirect calls as
+   (load type ID + compare).  */
+/* { dg-final { scan-assembler-times {lw\tt1, -4\([a-z0-9]+\)} 4 { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler-times {lui\tt2, [0-9]+} 4 { target riscv*-*-* } } } */
+
+/* RISC-V: Should have exactly 3 protected tail calls (jr after
+   KCFI check - no return address save).  */
+/* { dg-final { scan-assembler-times {jalr\t(x0|zero), [a-z0-9]+, 0} 3 { target riscv*-*-* } } } */
+
+/* RISC-V: Should have exactly 1 regular call (non-tail call case - saves
+   return address).  */
+/* { dg-final { scan-assembler-times {jalr\t(x1|ra), [a-z0-9]+, 0} 1 { target riscv*-*-* } } } */
+
+/* Type ID loading should use lui + addiw pattern for 32-bit constants.  */
+/* { dg-final { scan-assembler {lui\tt2, [0-9]+} { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler {addiw\tt2, t2, -?[0-9]+} { target riscv*-*-* } } } */
+
 /* Should have exactly 4 KCFI checks for indirect calls (load type ID from
    -4 offset + compare).  The actual-type scratch register avoids the call
    target, so it is w9 for the sibcall targets (x16) and w16 otherwise; the
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section-per-func.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section-per-func.c
index 448805a37808..7faeca95cac7 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section-per-func.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section-per-func.c
@@ -8,7 +8,7 @@
    Only x86_64 and RISC-V use a .kcfi_traps section; AArch64 and ARM encode the
    trap information directly in the trap instruction's immediate.  */
 
-/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-do compile { target x86_64-*-* riscv*-*-* } } */
 /* { dg-additional-options "-ffunction-sections" } */
 
 typedef int (*fn_t) (int);
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
index e02a320f2f92..5d1159cfb39b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
@@ -20,9 +20,10 @@ int main() {
 /* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ud2} 2 { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*brk} 2 { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*udf} 2 { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ebreak} 2 { target riscv*-*-* } } } */
 
-/* x86_64 should exactly 2 .kcfi_traps sections.  */
-/* { dg-final { scan-assembler-times {\.section\t\.kcfi_traps,"ao",@progbits,\.text} 2 { target x86_64-*-* } } } */
+/* x86_64 and RISC-V should exactly 2 .kcfi_traps sections.  */
+/* { dg-final { scan-assembler-times {\.section\t\.kcfi_traps,"ao",@progbits,\.text} 2 { target x86_64-*-* riscv*-*-* } } } */
 
 /* AArch64 and ARM 32-bit should NOT have .kcfi_traps section.  */
 /* { dg-final { scan-assembler-not {\.section\t+\.kcfi_traps} { target aarch64*-*-* arm*-*-* } } } */
-- 
2.34.1

