Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8518DB35
	for <linux-hardening@vger.kernel.org>; Fri, 26 Sep 2025 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855773; cv=none; b=ZaEKX+Q2uAfw/7+eX4nhBP+VU3/Fm+T0omvIS7ojT4WYd0nXOYv5ZHy29zgFPkjGpPURsAyNmXG6Ya5hkrx8lRbrTNvPW6HsrFCuQ6tqNq8SONUFzdVQQjRWNl7pvpqGNuFvDy4dBpr1uriM2zPmTNFo84CPXcx1osK1LKTfPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855773; c=relaxed/simple;
	bh=nmIXQwYnM4t7kaM3tflOpD/doZFH96KwYRz8CjAEI5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2P63amDbgMpueS/n+2pBcqa04b6MOi1FkpGoBLNpMAkY3K7+AzBrNM+GyGeZXgfffxIyPBPrf8qU/jIRdYs394qlDJ12C5Km8OvJS5iqvyNtoICWZtmHOufzwi5CBlPNMTdEnmlDMIbge0ofYXAoVnIz4kcMQtUJVkOhv/3Xy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opTXY4Lq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opTXY4Lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4271C19422;
	Fri, 26 Sep 2025 03:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855773;
	bh=nmIXQwYnM4t7kaM3tflOpD/doZFH96KwYRz8CjAEI5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opTXY4Lqzh+MfEAHa45ukmgQUWWljX/uTJfL7YWk1ckKN4Us0INWtNLl9w5/Cgin5
	 xw678mH0+tgkbiYU2AcJ+14KgR/4YwB9hJfYjPX1DjT50yvZddGyxD7WTJhnA8uYwB
	 tDqLAlo+5+GKBKsBf5TBR2OLrWJPj/LycyZhdsyOvhHCrLK7s/80ZmWhz+IU1oYVB6
	 XbBI4zUeVwl69SX8G9E0xKJJvXW+/SL0Zgs++gko8pwlAiUhKiNY9NdGSUzhUvnyr6
	 UqZlWNTjyDCH6xxC7c0U1MHvMv80P4iZ5pW38prohhJXG924SEEiDsjdZgIJYpRy2x
	 1UIpop8xlqp4g==
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
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 7/7] riscv: Add RISC-V Kernel Control Flow Integrity implementation
Date: Thu, 25 Sep 2025 20:02:49 -0700
Message-Id: <20250926030252.2387681-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926023737.it.616-kees@kernel.org>
References: <20250926023737.it.616-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=37922; i=kees@kernel.org; h=from:subject; bh=nmIXQwYnM4t7kaM3tflOpD/doZFH96KwYRz8CjAEI5k=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnXmCLfb09TU74io83mx/diq7DfnA1JwnUTPsZ+Pq5+x /drYfXPjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImYJjIyTCuI/nHQ65pj/FTV lMNfrJlucS7eJZgo+oLtbelkwy23yxn+5wa/lGhIqo7L110hxLxOXHF1EzObifcWjqD4rxmzJKz 5AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Implement RISC-V-specific KCFI backend. Nothing is conceptually rv64
specific, but using an alternative set of instructions for rv32 would be
needed, and at present the only user of KCFI on riscv is the rv64 build
of the Linux kernel.

- Scratch register allocation using t1/t2 (x6/x7) following RISC-V
  procedure call standard for temporary registers (already
  caller-saved), and t3 (x8) when either t1 or t2 is already the call
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

	config/riscv/riscv-protos.h: Declare KCFI helpers.
	config/riscv/riscv.cc (riscv_maybe_wrap_call_with_kcfi): New
	function, to wrap calls.
	(riscv_maybe_wrap_call_value_with_kcfi): New function, to
	wrap calls with return values.
	(riscv_output_kcfi_insn): New function to emit KCFI assembly.
	config/riscv/riscv.md: Add KCFI RTL patterns and hook expansion.
	doc/invoke.texi: Document riscv nuances.

gcc/testsuite/ChangeLog:

	* gcc.dg/kcfi/kcfi-adjacency.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-basics.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-call-sharing.c: Add riscv patterns.
	* gcc.dg/kcfi/kcfi-complex-addressing.c: Add riscv patterns.
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
	* gcc.dg/kcfi/kcfi-riscv-fixed-t1.c: New test.
	* gcc.dg/kcfi/kcfi-riscv-fixed-t2.c: New test.
	* gcc.dg/kcfi/kcfi-riscv-fixed-t3.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/riscv/riscv-protos.h               |   3 +
 gcc/config/riscv/riscv.md                     |  76 +++++++-
 gcc/config/riscv/riscv.cc                     | 169 ++++++++++++++++++
 gcc/doc/invoke.texi                           |  17 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  17 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  21 ++-
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |   4 +
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  19 ++
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  20 +++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |   5 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   1 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   3 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |   9 +-
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  10 +-
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |   9 +-
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |   9 +-
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t1.c         |  17 ++
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t2.c         |  17 ++
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t3.c         |  17 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  23 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   5 +-
 21 files changed, 457 insertions(+), 14 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c

diff --git a/gcc/config/riscv/riscv-protos.h b/gcc/config/riscv/riscv-protos.h
index e4473f45d0e4..572ce1d3e7c8 100644
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
index 2a3a20e122a5..76694a1ca210 100644
--- a/gcc/config/riscv/riscv.md
+++ b/gcc/config/riscv/riscv.md
@@ -3997,10 +3997,25 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[0], 0));
-  emit_call_insn (gen_sibcall_internal (target, operands[1], operands[2]));
+  rtx pat = gen_sibcall_internal (target, operands[1], operands[2]);
+  pat = riscv_maybe_wrap_call_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI sibling call
+(define_insn "*kcfi_sibcall_insn"
+  [(kcfi (call (mem:SI (match_operand:DI 0 "call_insn_operand" "l"))
+	       (match_operand 1 ""))
+	 (match_operand 3 "const_int_operand"))
+   (use (unspec:SI [(match_operand 2 "const_int_operand")] UNSPEC_CALLEE_CC))]
+  "SIBLING_CALL_P (insn)"
+{
+  return riscv_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "24")])
+
 (define_insn "sibcall_internal"
   [(call (mem:SI (match_operand 0 "call_insn_operand" "j,S,U"))
 	 (match_operand 1 "" ""))
@@ -4024,11 +4039,27 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[1], 0));
-  emit_call_insn (gen_sibcall_value_internal (operands[0], target, operands[2],
-					      operands[3]));
+  rtx pat = gen_sibcall_value_internal (operands[0], target, operands[2],
+					operands[3]);
+  pat = riscv_maybe_wrap_call_value_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI sibling call with return value
+(define_insn "*kcfi_sibcall_value_insn"
+  [(set (match_operand 0 "")
+	(kcfi (call (mem:SI (match_operand:DI 1 "call_insn_operand" "l"))
+		    (match_operand 2 ""))
+	      (match_operand 4 "const_int_operand")))
+   (use (unspec:SI [(match_operand 3 "const_int_operand")] UNSPEC_CALLEE_CC))]
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
@@ -4052,10 +4083,26 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[0], 0));
-  emit_call_insn (gen_call_internal (target, operands[1], operands[2]));
+  rtx pat = gen_call_internal (target, operands[1], operands[2]);
+  pat = riscv_maybe_wrap_call_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI indirect call
+(define_insn "*kcfi_call_internal"
+  [(kcfi (call (mem:SI (match_operand:DI 0 "call_insn_operand" "l"))
+	       (match_operand 1 "" ""))
+	 (match_operand 3 "const_int_operand"))
+   (use (unspec:SI [(match_operand 2 "const_int_operand")] UNSPEC_CALLEE_CC))
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
@@ -4080,11 +4127,28 @@
   ""
 {
   rtx target = riscv_legitimize_call_address (XEXP (operands[1], 0));
-  emit_call_insn (gen_call_value_internal (operands[0], target, operands[2],
-					   operands[3]));
+  rtx pat = gen_call_value_internal (operands[0], target, operands[2],
+				     operands[3]);
+  pat = riscv_maybe_wrap_call_value_with_kcfi (pat, target);
+  emit_call_insn (pat);
   DONE;
 })
 
+;; KCFI call with return value
+(define_insn "*kcfi_call_value_insn"
+  [(set (match_operand 0 "" "")
+	(kcfi (call (mem:SI (match_operand:DI 1 "call_insn_operand" "l"))
+		    (match_operand 2 "" ""))
+	      (match_operand 4 "const_int_operand")))
+   (use (unspec:SI [(match_operand 3 "const_int_operand")] UNSPEC_CALLEE_CC))
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
index 41ee4014c0dd..091fc27b6104 100644
--- a/gcc/config/riscv/riscv.cc
+++ b/gcc/config/riscv/riscv.cc
@@ -81,6 +81,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "cgraph.h"
 #include "langhooks.h"
 #include "gimplify.h"
+#include "kcfi.h"
 
 /* This file should be included last.  */
 #include "target-def.h"
@@ -11376,6 +11377,160 @@ riscv_convert_vector_chunks (struct gcc_options *opts)
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
+/* Apply KCFI wrapping to call_value pattern if needed.  PAT is the RTL
+   call_value pattern to potentially wrap with KCFI instrumentation.  ADDR
+   is the call target address RTL expression.  Returns the possibly modified
+   call pattern with KCFI wrapper applied for indirect calls.  */
+
+rtx
+riscv_maybe_wrap_call_value_with_kcfi (rtx pat, rtx addr)
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
+/* Output the assembly for a KCFI checked call instruction.  INSN is the
+   RTL instruction being processed.  OPERANDS is the array of RTL operands
+   where operands[0] is the call target register, operands[3] is the KCFI
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
+  uint32_t expected_type = (uint32_t) INTVAL (operands[3]);
+
+  /* Calculate typeid offset from call target.  */
+  HOST_WIDE_INT offset = -kcfi_typeid_offset;
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
+  /* Generate custom label names.  */
+  char trap_name[32];
+  char call_name[32];
+  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", kcfi_labelno);
+  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", kcfi_labelno);
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
+  kcfi_emit_traps_section (asm_out_file, trap_label_sym);
+
+  /* Output pass/call label.  */
+  ASM_OUTPUT_LABEL (asm_out_file, call_name);
+
+  /* Increment label counter for next KCFI instruction.  */
+  kcfi_labelno ++;
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
+  return "";
+}
+
 /* 'Unpack' up the internal tuning structs and update the options
     in OPTS.  The caller must have set up selected_tune and selected_arch
     as all the other target-specific codegen decisions are
@@ -11483,6 +11638,17 @@ riscv_override_options_internal (struct gcc_options *opts)
       opts->x_flag_cf_protection
       = (cf_protection_level) (opts->x_flag_cf_protection | CF_SET);
     }
+
+  /* KCFI is only supported in 64-bit mode.  */
+  if ((opts->x_flag_sanitize & SANITIZE_KCFI) && !TARGET_64BIT)
+    sorry ("%<-fsanitize=kcfi%> is not supported for 32-bit RISC-V");
+
+  /* KCFI requires T1, T2, and T3 registers for type checking.  */
+  if ((opts->x_flag_sanitize & SANITIZE_KCFI)
+      && (fixed_regs[T1_REGNUM] || fixed_regs[T2_REGNUM] || fixed_regs[T3_REGNUM]))
+    sorry ("%<-fsanitize=kcfi%> is not compatible with %<-ffixed-t1%>, "
+	   "%<-ffixed-t2%>, or %<-ffixed-t3%> as KCFI requires these registers "
+	   "for type checking");
 }
 
 /* Implement TARGET_OPTION_OVERRIDE.  */
@@ -15993,6 +16159,9 @@ riscv_prefetch_offset_address_p (rtx x, machine_mode mode)
 #define TARGET_GET_FUNCTION_VERSIONS_DISPATCHER \
   riscv_get_function_versions_dispatcher
 
+#undef TARGET_KCFI_SUPPORTED
+#define TARGET_KCFI_SUPPORTED hook_bool_void_true
+
 #undef TARGET_DOCUMENTATION_NAME
 #define TARGET_DOCUMENTATION_NAME "RISC-V"
 
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 3443cea29fbe..b08bb9da11d3 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18472,6 +18472,23 @@ allowing the kernel to identify both the KCFI violation and the involved
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
+register, they cannot be fixed registers, so KCFI cannot be used with any
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
index 00c14c0375cd..899892b3142d 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
@@ -94,4 +94,21 @@ __attribute__((noinline)) void test_conditional_call(int flag) {
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
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
index 4c9a1e7aa552..6595c940c2d9 100644
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
@@ -110,6 +110,23 @@ int main() {
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
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
 
 /* Extern functions should NOT get KCFI preambles.  */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
index cf01856d05c9..bbcac6f7c260 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
@@ -67,6 +67,7 @@ int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *
 /* x86: { dg-final { scan-assembler-times {movl\s+\$-?[0-9]+,\s+%r10d} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {mov\s+w17, #[0-9]+} 2 { target aarch64*-*-* } } } */
 /* ARM 32-bit: { dg-final { scan-assembler-times {ldr\s+ip, \[(?:r[0-9]+|lr), #-4\]} 3 { target arm*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-times {lui\tt2, [0-9]+} 2 { target riscv*-*-* } } } */
 
 /* Verify the checks use DIFFERENT type IDs (not shared, except arm: see above).
    We should NOT see the same type ID used twice - that would indicate
@@ -74,13 +75,16 @@ int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *
 /* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*movl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-not {mov\s+w17, #([0-9]+).*mov\s+w17, #\1} { target aarch64*-*-* } } } */
 /* ARM 32-bit: { dg-final { scan-assembler-not {eor\s+ip, ip, #([0-9]+)\n\teor\s+r3, r3, #([0-9]+)\n\teor\s+r3, r3, #([0-9]+)\n\teors\s+r3, r3, #([0-9]+).*eor\s+r3, r3, #\1\n\teor\s+r3, r3, #[0-9]+\n\teor\s+r3, r3, #[0-9]+\n\teors\s+r3, r3, #[0-9]+.*eor\s+r3, r3, #\1\n\teor\s+r3, r3, #[0-9]+\n\teor\s+r3, r3, #[0-9]+\n\teors\s+r3, r3, #[0-9]+} { target arm*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-not {lui\s+t2, ([0-9]+)\s.*lui\s+t2, \1\s} { target riscv*-*-* } } } */
 
 /* Verify expected number of traps.  */
 /* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target aarch64*-*-* } } } */
 /* ARM 32-bit: { dg-final { scan-assembler-times {udf\s+#[0-9]+} 3 { target arm*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-times {ebreak} 2 { target riscv*-*-* } } } */
 
 /* Verify 2 separate call sites (except arm).  */
 /* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {br\tx[0-9]+} 2 { target aarch64*-*-* } } } */
 /* ARM 32-bit: { dg-final { scan-assembler-times {bx\s+(?:r[0-9]+|lr)} 3 { target arm*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-times {jalr\t[a-z0-9]+} 2 { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
index 92d9dbb7906b..b55e9dccd50a 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
@@ -181,4 +181,23 @@ int main() {
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
index c259620a3ed8..600c04d5eba3 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
@@ -92,6 +92,26 @@ int main(void)
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
index f8103466816a..36ccf24a41cc 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
@@ -77,6 +77,7 @@ int main(void)
 /* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler-times {udf\s+#[0-9]+} 2 { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-times {ebreak} 2 { target riscv*-*-* } } } */
 
 /* Positive controls: these should have KCFI checks.  */
 /* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_function} { target x86_64-*-* } } } */
@@ -85,6 +86,8 @@ int main(void)
 /* { dg-final { scan-assembler {wrap_normal_inline:.*brk\s+#[0-9]+.*\.size\s+wrap_normal_inline} { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler {normal_function:.*udf\t#[0-9]+.*\.size\s+normal_function} { target arm*-*-* } } } */
 /* { dg-final { scan-assembler {wrap_normal_inline:.*udf\t#[0-9]+.*\.size\s+wrap_normal_inline} { target arm*-*-* } } } */
+/* { dg-final { scan-assembler {normal_function:.*ebreak.*\.size\s+normal_function} { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler {wrap_normal_inline:.*ebreak.*\.size\s+wrap_normal_inline} { target riscv*-*-* } } } */
 
 /* Negative controls: these should NOT have KCFI checks.  */
 /* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
@@ -93,3 +96,5 @@ int main(void)
 /* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*brk\s+#[0-9]+.*\.size\s+wrap_sensitive_inline} { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler-not {sensitive_non_inline_function:[^\n]*udf\t#[0-9]+[^\n]*\.size\tsensitive_non_inline_function} { target arm*-*-* } } } */
 /* { dg-final { scan-assembler-not {wrap_sensitive_inline:[^\n]*udf\t#[0-9]+[^\n]*\.size\twrap_sensitive_inline} { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ebreak.*\.size\s+sensitive_non_inline_function} { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ebreak.*\.size\s+wrap_sensitive_inline} { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
index 95bb46304493..b315e6f65e00 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
@@ -36,3 +36,4 @@ int main() {
 /* { dg-final { scan-assembler-times {addl\t-4\(%r[ad]x\), %r1[01]d} 1 { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 1 { target aarch64-*-* } } } */
 /* { dg-final { scan-assembler-times {ldr\tip, \[r[0-9]+, #-4\]} 1 { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-times {lw\tt1, -[0-9]+\(} 1 { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
index 88f0ae64091b..b0dd7b6fc45d 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
@@ -33,3 +33,6 @@ int main() {
 
 /* ARM 32-bit: All call sites should use -4 offset with EOR sequence.  */
 /* { dg-final { scan-assembler {ldr\tip, \[r[0-9]+, #-4\]} { target arm*-*-* } } } */
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
index da3d8dc41f60..0c026e6d8615 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
@@ -18,7 +18,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* riscv*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -43,4 +43,12 @@ int main() {
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
index d61274e70157..e60c8546ef5c 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
@@ -25,7 +25,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* riscv*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -50,4 +50,11 @@ int main() {
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
index 93df4d7ea5b6..e90979a9b433 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
@@ -26,7 +26,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* riscv*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -51,4 +51,11 @@ int main() {
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
new file mode 100644
index 000000000000..d17f40f6d3b1
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
@@ -0,0 +1,17 @@
+/* Test that KCFI is incompatible with -ffixed-t1 on RISC-V.  */
+/* { dg-do compile { target riscv*-*-* } } */
+/* { dg-additional-options "-ffixed-t1" } */
+
+/* { dg-message "sorry, unimplemented: '-fsanitize=kcfi' is not compatible with '-ffixed-t1', '-ffixed-t2', or '-ffixed-t3' as KCFI requires these registers for type checking" "" 0 } */
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
new file mode 100644
index 000000000000..82cbe894d5f3
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
@@ -0,0 +1,17 @@
+/* Test that KCFI is incompatible with -ffixed-t2 on RISC-V.  */
+/* { dg-do compile { target riscv*-*-* } } */
+/* { dg-additional-options "-ffixed-t2" } */
+
+/* { dg-message "sorry, unimplemented: '-fsanitize=kcfi' is not compatible with '-ffixed-t1', '-ffixed-t2', or '-ffixed-t3' as KCFI requires these registers for type checking" "" 0 } */
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c
new file mode 100644
index 000000000000..2726b691781a
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c
@@ -0,0 +1,17 @@
+/* Test that KCFI is incompatible with -ffixed-t3 on RISC-V.  */
+/* { dg-do compile { target riscv*-*-* } } */
+/* { dg-additional-options "-ffixed-t3" } */
+
+/* { dg-message "sorry, unimplemented: '-fsanitize=kcfi' is not compatible with '-ffixed-t1', '-ffixed-t2', or '-ffixed-t3' as KCFI requires these registers for type checking" "" 0 } */
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
index ee9d2c6dc741..34d18e6e0a03 100644
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
    -4 offset + compare).  */
 /* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 4 { target aarch64-*-* } } } */
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

