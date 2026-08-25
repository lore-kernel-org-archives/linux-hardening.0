Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE248CD71
	for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702285; cv=none; b=Q1KN7k9yGrgeiLXeHPjFtva01SSSda2FMoG7uADLBOM2RiWwUca5aJikecpoGnjxy/LHQDW02GA92nSr9zFpCCYb7I6GAaHEOgU9FukZi01nFXSiaT0l7N/BU+O40M4c2a0vxHerQkv7wAUvg4vmc6W3FPmW9cvlaJgaFu8IYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702285; c=relaxed/simple;
	bh=iR1ErPvGf88XeQATmlsV2RO2VCs8aiEvSlG9zF9faTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qt34+hE86wrkCEzucmkJzabfjXzq0bstUbkXbw1oC5TVFSCm7yyrTrB+6j1wxbnNKEAbZ8Ql+FvgiJRPzE7R8PNgAEUQoikOSpXupHmRxm6lYGUJsVqCPPGe6lqRZH52Mzanql86SH5LeaaIBDLPM5TXnTx+Wr73pdu+/hZQzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qbs5sRE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qbs5sRE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8991F01562;
	Tue, 25 Aug 2026 23:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787702280;
	bh=SNWZgAMln7KaLW32nOt1wUrwf4ICqj+zMEESy7qKptg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qbs5sRE8XZyV+EQpusL1R7My3Hibmzv+iHef5cdBV81hVyVn2sZxwu14Bq4fA9ROg
	 TQnRK75fF7BtjIJMAzZGi0dSLJr2hQ+F7WmjnX9e0cD9TCMEtZecCFl/y2PRa4Jppp
	 /PuVn/gHpk4PHbB5BY2hXgfqIugcVxgIwDWN/AdUb9EmI3jgMXHc1hKvtqb7r8uwPJ
	 z0hzWqwbpFbAE9nv7jsXRh1t4dZPrzlqQJl8lUcfDGBH/NVWd3A8Z/zlJJn+ZP/Oz6
	 55TNWZxkB8d14HRe+4exQvZRoy5Si0pjn3OsYCCKfSErvp8qnJN4V4AIsMOva4sU47
	 axieWw/JCzq9w==
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
Subject: [PATCH v15 6/7] arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
Date: Tue, 25 Aug 2026 16:57:56 -0700
Message-Id: <20260825235759.3379064-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825235748.i.456-kees@kernel.org>
References: <20260825235748.i.456-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=48359; i=kees@kernel.org; h=from:subject; bh=iR1ErPvGf88XeQATmlsV2RO2VCs8aiEvSlG9zF9faTs=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl9OizVdjc8UrlzJVdePVvBrP3V1zZlt7mbg4ngT8NvN kv+/GLtKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmEiZE8M/s+/2MtmmMUHnu8PL 59XXH+i4ee68kUbmxqiX/OvklW4IM/yzfGmidWKRR+FMPssfj3pV9yx4Iu/yvSPimvskls013JL 8AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Implement ARM 32-bit KCFI backend:

- Use eor instructions for 32-bit immediate loading.

- Trap debugging through UDF instruction immediate encoding following
  AArch64 BRK pattern for encoding registers with useful contents.

- Scratch register allocation uses ip by default since it is most
  commonly available as a caller-saved register. When, due to register
  pressure, ip is the call target register, use r3. Since r3 is already
  caller-saved, the allocator will have already arranged to reload r3
  after the call if it is needed again. However, if r3 is being used
  as the 4th argument to the call, we must internally spill/reload
  it.  Also uses r3 with -ffixed-ip or -ffixed-r12.

Assembly Code Pattern for ARM 32-bit:
  ldr  ip, [target, #-4]       ; Load actual type ID from preamble
  eor  ip, ip, #byte1          ; OR type id byte 1
  eor  ip, ip, #byte2 << 8     ; OR type id byte 2
  eor  ip, ip, #byte3 << 16    ; OR type id byte 3
  eors ip, ip, #byte4 << 24    ; OR type id byte 4 and set if reg is 0
  beq  .Lkcfi_call             ; Branch if typeids matched
  .Lkcfi_trap: udf #udf_value  ; Undefined instruction trap with encoding
  .Lkcfi_call: blx/bx target   ; Execute validated indirect transfer

UDF Immediate Encoding (following AArch64 ESR pattern):
- UDF instruction immediate encoding format:
  0x8000 | ((ExpectedTypeReg & 31) << 5) | (TargetAddrReg & 31)
  - ExpectedTypeReg indicates which register contains expected type (R12 = 12)
  - TargetAddrReg indicates which register contains target address (0-15)
  - Example: udf #33154 (0x817A) = expected type in R12, target address in R2

Build and run tested with Linux kernel ARCH=arm.

gcc/ChangeLog:

	* config/arm/arm-protos.h: Declare KCFI helpers.
	* config/arm/arm.cc (arm_maybe_wrap_call_with_kcfi): New function.
	(arm_maybe_wrap_call_value_with_kcfi): New function.
	(arm_output_kcfi_insn): Emit KCFI assembly.
	* config/arm/arm.md: Add KCFI RTL patterns and hook expansion.
	* doc/invoke.texi: Document arm32 nuances.

gcc/testsuite/ChangeLog:

	* gcc.dg/kcfi/kcfi-adjacency.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-basics.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-call-sharing.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-complex-addressing.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-direct-call-shapes.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-move-preservation.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-no-sanitize.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-offset-validation.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-patchable-large.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-patchable-medium.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-tail-calls.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-trap-encoding.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-trap-section.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-arm-fixed-ip.c: New test.
	* gcc.dg/kcfi/kcfi-arm-fixed-r12.c: New test.
	* gcc.dg/kcfi/kcfi-arm-sibcall-r3.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/arm/arm-protos.h                   |   4 +
 gcc/config/arm/arm.md                         |  62 +++++
 gcc/config/arm/arm.cc                         | 217 +++++++++++++++++-
 gcc/doc/invoke.texi                           |  27 ++-
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  38 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c |  15 ++
 .../gcc.dg/kcfi/kcfi-arm-fixed-r12.c          |  15 ++
 .../gcc.dg/kcfi/kcfi-arm-sibcall-r3.c         |  50 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  42 +++-
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  14 +-
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  22 ++
 .../gcc.dg/kcfi/kcfi-direct-call-shapes.c     |   3 +
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  42 +++-
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |   5 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   3 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   5 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |   9 +-
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  12 +-
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  12 +-
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  12 +-
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  20 ++
 .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  48 +++-
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   5 +-
 23 files changed, 656 insertions(+), 26 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-r12.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-sibcall-r3.c

diff --git a/gcc/config/arm/arm-protos.h b/gcc/config/arm/arm-protos.h
index b607cdb3fcc0..295647a0efeb 100644
--- a/gcc/config/arm/arm-protos.h
+++ b/gcc/config/arm/arm-protos.h
@@ -608,6 +608,10 @@ void arm_initialize_isa (sbitmap, const enum isa_feature *);
 
 const char * arm_gen_far_branch (rtx *, int, const char * , const char *);
 
+rtx arm_maybe_wrap_call_with_kcfi (rtx, rtx);
+rtx arm_maybe_wrap_call_value_with_kcfi (rtx, rtx);
+const char *arm_output_kcfi_insn (rtx_insn *, rtx *);
+
 bool arm_mve_immediate_check(rtx, machine_mode, bool);
 
 opt_machine_mode arm_mve_data_mode (scalar_mode, poly_uint64);
diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
index febff17df0bf..a8cdb76f3ade 100644
--- a/gcc/config/arm/arm.md
+++ b/gcc/config/arm/arm.md
@@ -8635,6 +8635,7 @@
     else
       {
 	pat = gen_call_internal (operands[0], operands[1], operands[2]);
+	pat = arm_maybe_wrap_call_with_kcfi (pat, XEXP (operands[0], 0));
 	arm_emit_call_insn (pat, XEXP (operands[0], 0), false);
       }
 
@@ -8693,6 +8694,20 @@
   }
 )
 
+;; KCFI indirect call - KCFI wraps just the call pattern
+(define_insn "*kcfi_call_reg"
+  [(kcfi (call (mem:SI (match_operand:SI 0 "s_register_operand" "r"))
+	       (match_operand 1 "" ""))
+	 (match_operand 2 "const_int_operand"))
+   (use (match_operand 3 "" ""))
+   (clobber (reg:SI LR_REGNUM))]
+  "TARGET_32BIT && !SIBLING_CALL_P (insn) && arm_ccfsm_state == 0"
+{
+  return arm_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "40")])
+
 (define_insn "*call_reg_armv5"
   [(call (mem:SI (match_operand:SI 0 "s_register_operand" "r"))
          (match_operand 1 "" ""))
@@ -8759,6 +8774,7 @@
       {
 	pat = gen_call_value_internal (operands[0], operands[1],
 				       operands[2], operands[3]);
+	pat = arm_maybe_wrap_call_value_with_kcfi (pat, XEXP (operands[1], 0));
 	arm_emit_call_insn (pat, XEXP (operands[1], 0), false);
       }
 
@@ -8805,6 +8821,21 @@
       }
   }")
 
+;; KCFI indirect call_value - KCFI wraps just the call pattern
+(define_insn "*kcfi_call_value_reg"
+  [(set (match_operand 0 "" "")
+	(kcfi (call (mem:SI (match_operand:SI 1 "s_register_operand" "r"))
+		    (match_operand 2 "" ""))
+	      (match_operand 3 "const_int_operand")))
+   (use (match_operand 4 "" ""))
+   (clobber (reg:SI LR_REGNUM))]
+  "TARGET_32BIT && !SIBLING_CALL_P (insn) && arm_ccfsm_state == 0"
+{
+  return arm_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "40")])
+
 (define_insn "*call_value_reg_armv5"
   [(set (match_operand 0 "" "")
         (call (mem:SI (match_operand:SI 1 "s_register_operand" "r"))
@@ -8907,6 +8938,7 @@
       operands[2] = const0_rtx;
 
     pat = gen_sibcall_internal (operands[0], operands[1], operands[2]);
+    pat = arm_maybe_wrap_call_with_kcfi (pat, XEXP (operands[0], 0));
     arm_emit_call_insn (pat, operands[0], true);
     DONE;
   }"
@@ -8941,11 +8973,26 @@
 
     pat = gen_sibcall_value_internal (operands[0], operands[1],
                                       operands[2], operands[3]);
+    pat = arm_maybe_wrap_call_value_with_kcfi (pat, XEXP (operands[1], 0));
     arm_emit_call_insn (pat, operands[1], true);
     DONE;
   }"
 )
 
+;; KCFI sibling call - KCFI wraps just the call pattern
+(define_insn "*kcfi_sibcall_insn"
+  [(kcfi (call (mem:SI (match_operand:SI 0 "s_register_operand" "Cs"))
+	       (match_operand 1 "" ""))
+	 (match_operand 2 "const_int_operand"))
+   (return)
+   (use (match_operand 3 "" ""))]
+  "TARGET_32BIT && SIBLING_CALL_P (insn) && arm_ccfsm_state == 0"
+{
+  return arm_output_kcfi_insn (insn, operands);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "40")])
+
 (define_insn "*sibcall_insn"
  [(call (mem:SI (match_operand:SI 0 "call_insn_operand" "Cs, US"))
 	(match_operand 1 "" ""))
@@ -8966,6 +9013,21 @@
   [(set_attr "type" "call")]
 )
 
+;; KCFI sibling call with return value - KCFI wraps just the call pattern
+(define_insn "*kcfi_sibcall_value_insn"
+  [(set (match_operand 0 "" "")
+	(kcfi (call (mem:SI (match_operand:SI 1 "s_register_operand" "Cs"))
+		    (match_operand 2 "" ""))
+	      (match_operand 3 "const_int_operand")))
+   (return)
+   (use (match_operand 4 "" ""))]
+  "TARGET_32BIT && SIBLING_CALL_P (insn) && arm_ccfsm_state == 0"
+{
+  return arm_output_kcfi_insn (insn, &operands[1]);
+}
+  [(set_attr "type" "call")
+   (set_attr "length" "40")])
+
 (define_insn "*sibcall_value_insn"
  [(set (match_operand 0 "" "")
        (call (mem:SI (match_operand:SI 1 "call_insn_operand" "Cs,US"))
diff --git a/gcc/config/arm/arm.cc b/gcc/config/arm/arm.cc
index 0bc66abe238b..bfaacd4ff57d 100644
--- a/gcc/config/arm/arm.cc
+++ b/gcc/config/arm/arm.cc
@@ -77,6 +77,8 @@
 #include "aarch-common-protos.h"
 #include "machmode.h"
 #include "arm-builtins.h"
+#include "kcfi.h"
+#include "flags.h"
 
 /* This file should be included last.  */
 #include "target-def.h"
@@ -23171,17 +23173,19 @@ thumb_force_lr_save (void)
    we do have an indirect tailcall happening in this
    particular case.  */
 static bool
-is_indirect_tailcall_p (rtx call)
+is_indirect_tailcall_p (rtx_insn *call)
 {
-  rtx pat = PATTERN (call);
-
-  /* Indirect tail call.  */
-  pat = XVECEXP (pat, 0, 0);
-  if (GET_CODE (pat) == SET)
-    pat = SET_SRC (pat);
+  /* Use the generic accessor to reach the CALL expression so that we see
+     through any wrapper, in particular the KCFI call wrapper
+     (kcfi (call ...) typeid).  An open-coded structural walk would peel one
+     level too few and misclassify a KCFI-instrumented indirect tail call as
+     direct, leaving r3 free to be used as stack-alignment padding and thus
+     clobbering the tail-call target.  */
+  rtx pat = get_call_rtx_from (call);
 
-  pat = XEXP (XEXP (pat, 0), 0);
-  return REG_P (pat);
+  /* PAT is (call (mem ADDR) ...); the tail call is indirect when the target
+     ADDR is held in a register.  */
+  return REG_P (XEXP (XEXP (pat, 0), 0));
 }
 
 /* Return true if r3 is used by any of the tail call insns in the
@@ -36109,6 +36113,201 @@ arm_mode_base_reg_class (machine_mode mode)
   return MODE_BASE_REG_REG_CLASS (mode);
 }
 
+/* Apply KCFI wrapping to call pattern if needed.  PAT is the RTL call
+   pattern to potentially wrap with KCFI instrumentation.  ADDR is the
+   call target address RTL expression.  Returns the possibly modified
+   call pattern with KCFI wrapper applied for indirect calls.  */
+
+rtx
+arm_maybe_wrap_call_with_kcfi (rtx pat, rtx addr)
+{
+  /* Only indirect calls need KCFI instrumentation.  */
+  if (REG_P (addr))
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
+arm_maybe_wrap_call_value_with_kcfi (rtx pat, rtx addr)
+{
+  /* Only indirect calls need KCFI instrumentation.  */
+  if (REG_P (addr))
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
+   where operands[0] is the call target register, operands[2] is the KCFI
+   type ID constant.  Returns an empty string as all output is handled by
+   direct assembly generation.  */
+
+const char *
+arm_output_kcfi_insn (rtx_insn *insn, rtx *operands)
+{
+  /* KCFI type id.  */
+  uint32_t type_id = UINTVAL (operands[2]);
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
+  rtx temp_operands[6];
+
+  /* Normally we can use r12 as our scratch register.  */
+  unsigned scratch_reg_num = IP_REGNUM;
+  /* If register pressure has made r12 our target register, we need to pick
+     a different register.  We don't want to spill our target register
+     because on reload at the end of the KCFI check, we'd be producing
+     the very kind of call gadget we were trying to protect against:
+     "pop %target; call %target".  In this case, use r3 as our scratch
+     register.  But since r3 may be used for function arguments, we need
+     to check if it is being used for that and only spill/reload if that
+     happens.  Any spill/reload of r3 due to making a call will already
+     have been managed by the register allocator, so we only have to care
+     about not clobbering the argument value it may be carrying into the
+     call here.  Also use r3 when r12 is a fixed register.  */
+  if (REGNO (operands[0]) == scratch_reg_num
+      || fixed_regs[scratch_reg_num])
+    scratch_reg_num = LAST_ARG_REGNUM;
+  rtx scratch_reg = gen_rtx_REG (SImode, scratch_reg_num);
+
+  /* We only need to spill r3 if it's actually used by the call.  */
+  bool need_spill = (scratch_reg_num == LAST_ARG_REGNUM)
+		    && reg_overlap_mentioned_p (scratch_reg, insn);
+
+  /* Calculate trap immediate.  */
+  unsigned addr_reg_num = REGNO (operands[0]);
+  /* The scratch register is always clobbered by eor seq: use 0x1F.  */
+  unsigned udf_immediate = 0x8000 | (0x1F << 5) | (addr_reg_num & 31);
+
+  /* Spill if needed.  */
+  if (need_spill)
+    output_asm_insn ("push\t{%0}", &scratch_reg);
+
+  /* In Thumb-2 mode, function pointer values carry the Thumb bit (bit 0)
+     set, which would skew the typeid load by one byte.  Mask it off into
+     the scratch register and load through that.  In ARM mode the Thumb
+     bit is always 0, so the BIC is unnecessary.  */
+  rtx addr_reg = operands[0];
+  if (TARGET_THUMB)
+    {
+      temp_operands[0] = scratch_reg;
+      temp_operands[1] = operands[0];
+      output_asm_insn ("bic\t%0, %1, #1", temp_operands);
+      addr_reg = scratch_reg;
+    }
+
+  /* Load actual type from memory into scratch register.  */
+  rtx mem_op = gen_rtx_MEM (SImode,
+			    gen_rtx_PLUS (SImode, addr_reg,
+					  GEN_INT (offset)));
+  temp_operands[0] = scratch_reg;
+  temp_operands[1] = mem_op;
+  output_asm_insn ("ldr\t%0, %1", temp_operands);
+
+  /* Set up operands for EOR instructions - source and dest are the same.  */
+  temp_operands[0] = scratch_reg;
+  temp_operands[1] = scratch_reg;
+
+  /* XOR with type_id byte 0.  */
+  temp_operands[2] = GEN_INT (type_id & 0xFF);
+  output_asm_insn ("eor\t%0, %1, %2", temp_operands);
+
+  /* XOR with type_id byte 1 << 8.  */
+  temp_operands[2] = GEN_INT (((type_id >> 8) & 0xFF) << 8);
+  output_asm_insn ("eor\t%0, %1, %2", temp_operands);
+
+  /* XOR with type_id byte 2 << 16.  */
+  temp_operands[2] = GEN_INT (((type_id >> 16) & 0xFF) << 16);
+  output_asm_insn ("eor\t%0, %1, %2", temp_operands);
+
+  /* EORS with type_id byte 3 << 24 (sets flags).  */
+  temp_operands[2] = GEN_INT (((type_id >> 24) & 0xFF) << 24);
+  output_asm_insn ("eors\t%0, %1, %2", temp_operands);
+
+  /* Reload if needed.  */
+  if (need_spill)
+    output_asm_insn ("pop\t{%0}", &scratch_reg);
+
+  /* Output conditional branch to call label.  */
+  fputs ("\tbeq\t", asm_out_file);
+  assemble_name (asm_out_file, call_name);
+  fputc ('\n', asm_out_file);
+
+  /* Output trap label and UDF instruction.  */
+  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
+  temp_operands[0] = GEN_INT (udf_immediate);
+  output_asm_insn ("udf\t%0", temp_operands);
+
+  /* Output pass/call label.  */
+  ASM_OUTPUT_LABEL (asm_out_file, call_name);
+
+  /* Call or tail call instruction.  */
+  if (SIBLING_CALL_P (insn))
+    output_asm_insn ("bx\t%0", operands);
+  else
+    output_asm_insn ("blx\t%0", operands);
+
+  return "";
+}
+
+/* KCFI is supported in ARM and Thumb-2 modes.  Thumb-1 lacks the wide
+   immediate encodings for EOR, the UDF imm16 form, and BIC with immediate
+   that the check sequence relies on.  */
+
+static bool
+arm_kcfi_supported_p (void)
+{
+  if (TARGET_THUMB1)
+    {
+      error ("%<-fsanitize=kcfi%> is not supported in Thumb-1 mode; "
+	     "build with %<-marm%> or for an architecture that supports "
+	     "Thumb-2");
+      return false;
+    }
+  return true;
+}
+
+#undef TARGET_KCFI_SUPPORTED
+#define TARGET_KCFI_SUPPORTED arm_kcfi_supported_p
+
 #undef TARGET_DOCUMENTATION_NAME
 #define TARGET_DOCUMENTATION_NAME "ARM"
 
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index af5d13db2217..5225f7b90b2a 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -17607,6 +17607,26 @@ trap is taken, allowing the kernel to identify both the KCFI violation
 and the involved registers for detailed diagnostics (eliminating the need
 for a separate @code{.kcfi_traps} section as used on x86_64).
 
+On ARM 32-bit, KCFI type identifiers are emitted as a @code{.word ID}
+directive (a 32-bit constant) before the function entry.  ARM's
+natural 4-byte instruction alignment eliminates the need for additional
+alignment NOPs.  When used with @option{-fpatchable-function-entry}, the
+type identifier is placed before any prefix NOPs.  The runtime check uses
+@code{ip} (@code{r12}) as a scratch register, falling back to @code{r3} when
+@code{ip} is the call target or is a fixed register (spilling and restoring
+@code{r3} only when it carries a live argument).  In Thumb-2 mode a
+@code{bic} first clears the function-pointer Thumb bit before the type
+identifier is loaded.  The loaded type identifier is compared against the
+expected one using a sequence of four @code{eor} instructions (one per byte
+of the 32-bit value), the last of which sets the condition flags.  Type
+mismatches trigger a @code{udf} instruction with an immediate value that
+encodes both the expected type register index and the target address
+register index in the format @code{0x8000 | (type_reg << 5) | addr_reg}.  This
+encoding is captured in the UDF immediate field when the trap is taken,
+allowing the kernel to identify both the KCFI violation and the involved
+registers for detailed diagnostics (eliminating the need for a separate
+@code{.kcfi_traps} section as used on x86_64).
+
 KCFI is intended primarily for kernel code and may not be suitable
 for user-space applications that rely on techniques incompatible
 with strict type checking of indirect calls.
@@ -17621,7 +17641,12 @@ For the same reason, the location of the type identifier relative to a
 function entry point is part of a whole-program ABI: a call site computes
 that offset from its own translation unit's settings, so every translation
 unit that may be reached through an instrumented indirect call must agree on
-it.
+it.  On ARM this additionally requires a uniform instruction set state: the
+prefix-NOP size differs between ARM (4 bytes) and Thumb-2 (2 bytes), and
+Thumb function pointers carry the Thumb bit in bit 0, both of which feed the
+type-identifier location.  KCFI therefore does not support mixing ARM and
+Thumb-2 instrumented code in a single program; all such translation units
+must be built in the same mode.
 
 Use @option{-fdump-ipa-kcfi-details} to examine the computed type identifier
 hashes and their corresponding mangled type strings during compilation.
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
index 47a33bf6393b..63fade749ddd 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
@@ -83,4 +83,42 @@ __attribute__((noinline)) void test_conditional_call(int flag) {
    (same register number) means the target was overwritten by the load.  */
 /* { dg-final { scan-assembler-not {ldur\tw([0-9]+), \[x\1,} { target aarch64*-*-* } } } */
 
+/*
+** test_complex_args: { target arm_nothumb }
+** ...
+** push	\{r3\}
+** ldr	r3, \[ip, #-4\]
+** eor	r3, r3, #[0-9]+
+** eor	r3, r3, #[0-9]+
+** eor	r3, r3, #[0-9]+
+** eors	r3, r3, #[0-9]+
+** pop	\{r3\}
+** beq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** udf	#[0-9]+
+** .Lkcfi_call\1:
+** bx	ip
+** ...
+*/
+
+/* Thumb-2 inserts a BIC to strip the Thumb bit before the typeid load.  */
+/*
+** test_complex_args: { target arm_thumb2 }
+** ...
+** push	\{r3\}
+** bic	r3, ip, #1
+** ldr	r3, \[r3, #-4\]
+** eor	r3, r3, #[0-9]+
+** eor	r3, r3, #[0-9]+
+** eor	r3, r3, #[0-9]+
+** eors	r3, r3, #[0-9]+
+** pop	\{r3\}
+** beq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** udf	#[0-9]+
+** .Lkcfi_call\1:
+** bx	ip
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c
new file mode 100644
index 000000000000..bb76078aa800
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c
@@ -0,0 +1,15 @@
+/* Test that KCFI works with -ffixed-ip on ARM by using r3 fallback.  */
+/* { dg-do compile { target arm*-*-* } } */
+/* { dg-additional-options "-ffixed-ip" } */
+
+void target_function(void) {}
+
+int main() {
+    void (*func_ptr)(void) = target_function;
+    func_ptr();
+    return 0;
+}
+
+/* Should use r3 instead of ip for scratch register when ip is fixed.  */
+/* { dg-final { scan-assembler "ldr\tr3, \\\[r\[0-9\]+, #-4\\\]" } } */
+/* { dg-final { scan-assembler "eor\tr3, r3, #\[0-9\]+" } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-r12.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-r12.c
new file mode 100644
index 000000000000..dd3f1f001f5b
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-r12.c
@@ -0,0 +1,15 @@
+/* Test that KCFI works with -ffixed-r12 on ARM by using r3 fallback.  */
+/* { dg-do compile { target arm*-*-* } } */
+/* { dg-additional-options "-ffixed-r12" } */
+
+void target_function(void) {}
+
+int main() {
+    void (*func_ptr)(void) = target_function;
+    func_ptr();
+    return 0;
+}
+
+/* Should use r3 instead of ip for scratch register when ip is fixed.  */
+/* { dg-final { scan-assembler "ldr\tr3, \\\[r\[0-9\]+, #-4\\\]" } } */
+/* { dg-final { scan-assembler "eor\tr3, r3, #\[0-9\]+" } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-arm-sibcall-r3.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-arm-sibcall-r3.c
new file mode 100644
index 000000000000..dd1833d7b37b
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-arm-sibcall-r3.c
@@ -0,0 +1,50 @@
+/* Regression test for an arm32 KCFI indirect tail-call miscompile.
+
+   When a function makes a KCFI-instrumented indirect sibling call whose
+   target is held in r3, and the prologue needs a register for 8-byte stack
+   alignment padding while every callee-saved register is already in use,
+   arm_get_frame_offsets used to pick r3 as the padding register.  r3 was
+   then pushed in the prologue and restored to its stale entry value by the
+   epilogue, clobbering the tail-call target so "bx r3" branched into
+   garbage (observed as a boot crash in cpuhp_invoke_callback).
+
+   The root cause was is_indirect_tailcall_p failing to look through the
+   KCFI call wrapper, so any_sibcall_could_use_r3 wrongly reported that no
+   sibcall could use r3 and the padding logic was free to steal it.
+
+   This function is shaped to occupy all callee-saved registers across a
+   call while keeping the indirect tail-call target in r3 and requiring
+   alignment padding, which is exactly the situation that exposed the bug.
+   r3 must NOT appear in the prologue push or epilogue pop.  */
+
+/* { dg-do compile { target arm*-*-* } } */
+/* { dg-additional-options "-O2 -marm -mgeneral-regs-only" } */
+
+typedef int (*cb1_t) (unsigned int cpu);
+struct step { cb1_t single; cb1_t teardown; int multi; int x[16]; };
+extern struct step *get_step (int state);
+extern void barrier (void);
+extern void note (int);
+
+int invoke (unsigned int cpu, int state, int bringup)
+{
+  struct step *step = get_step (state);
+  int a = step->x[0], b = step->x[1], c = step->x[2];
+  int d = step->x[3], e = step->x[4], f = step->x[5];
+  cb1_t cb = bringup ? step->single : step->teardown;
+  barrier ();
+  if (a) note (a);
+  if (b) note (b);
+  if (c) note (c);
+  if (d) note (d);
+  if (e) note (e);
+  if (f) note (f);
+  return cb (cpu);
+}
+
+/* The indirect KCFI tail call goes through r3.  */
+/* { dg-final { scan-assembler {bx\tr3} } } */
+/* r3 holds the tail-call target, so it must never be saved/restored around
+   the body; doing so would clobber the target across the epilogue.  */
+/* { dg-final { scan-assembler-not {push\t.r3,} } } */
+/* { dg-final { scan-assembler-not {pop\t.r3,} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
index 7f1c45f1fe94..a917e1c70089 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
@@ -59,8 +59,8 @@ int main() {
 /* x86_64: Verify type ID in preamble (after NOPs, before function label) */
 /* { dg-final { scan-assembler {__cfi_regular_function:\n\t+nop\n.*\n\t+movl\t+\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
 
-/* AArch64: Verify type ID word in preamble.  */
-/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word\t0x[0-9a-f]+} { target aarch64*-*-* } } } */
+/* AArch64, ARM32: Verify type ID word in preamble.  */
+/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word\t0x[0-9a-f]+} { target aarch64*-*-* arm*-*-* } } } */
 
 /*
 ** static_caller: { target x86_64-*-* }
@@ -94,6 +94,40 @@ int main() {
 ** ...
 */
 
+/*
+** static_caller: { target arm_nothumb }
+** ...
+** ldr	ip, \[(r[0-9]+), #-4\]
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eors	ip, ip, #[0-9]+
+** beq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** udf	#[0-9]+
+** .Lkcfi_call\2:
+** blx	\1
+** ...
+*/
+
+/* Thumb-2 inserts a BIC to strip the Thumb bit before the typeid load.  */
+/*
+** static_caller: { target arm_thumb2 }
+** ...
+** bic	ip, (r[0-9]+), #1
+** ldr	ip, \[ip, #-4\]
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eors	ip, ip, #[0-9]+
+** beq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** udf	#[0-9]+
+** .Lkcfi_call\2:
+** blx	\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
 
 /* Extern functions should NOT get KCFI preambles.  */
@@ -112,5 +146,5 @@ int main() {
    __kcfi_typeid_ symbols.  */
 /* { dg-final { scan-assembler-not {__kcfi_typeid_external_func_int} } } */
 
-/* AArch64 should NOT have trap section (use immediate instructions instead).  */
-/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* } } } */
+/* AArch64, ARM32 should NOT have trap section (use immediate instructions instead).  */
+/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
index c402a1678a73..c2ecf3448b73 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
@@ -60,21 +60,29 @@ int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *
    1. KCFI check for is_visible call with is_visible type ID A.
    2. KCFI check for is_bin_visible and is_bin_visible_again call with type ID B.  */
 
-/* Verify we have TWO different KCFI check sequences.  */
+/* Verify we have TWO different KCFI check sequences (except on arm, which
+   due to heavy register pressure ends up generating an unmergeable series
+   of instructions: the call target registers differ).  */
 /* Each check should have different type ID constants.  */
 /* x86: { dg-final { scan-assembler-times {movl\s+\$-?[0-9]+,\s+%r10d} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {mov\s+w17, #[0-9]+} 2 { target aarch64*-*-* } } } */
+/* ARM 32-bit: In Thumb-2 the load base is ip (post-Thumb-bit-strip), in ARM
+   mode it is the call target register or lr; accept any.  */
+/* { dg-final { scan-assembler-times {ldr\s+ip, \[(?:r[0-9]+|lr|ip), #-4\]} 3 { target arm*-*-* } } } */
 
-/* Verify the checks use DIFFERENT type IDs (not shared).
+/* Verify the checks use DIFFERENT type IDs (not shared, except arm: see above).
    We should NOT see the same type ID used twice - that would indicate
    unmerged sharing.  */
 /* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*movl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-not {mov\s+w17, #([0-9]+).*mov\s+w17, #\1} { target aarch64*-*-* } } } */
+/* ARM 32-bit: { dg-final { scan-assembler-not {eor\s+ip, ip, #([0-9]+)\n\teor\s+r3, r3, #([0-9]+)\n\teor\s+r3, r3, #([0-9]+)\n\teors\s+r3, r3, #([0-9]+).*eor\s+r3, r3, #\1\n\teor\s+r3, r3, #[0-9]+\n\teor\s+r3, r3, #[0-9]+\n\teors\s+r3, r3, #[0-9]+.*eor\s+r3, r3, #\1\n\teor\s+r3, r3, #[0-9]+\n\teor\s+r3, r3, #[0-9]+\n\teors\s+r3, r3, #[0-9]+} { target arm*-*-* } } } */
 
 /* Verify expected number of traps.  */
 /* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {brk\s+#0x[0-9a-f]+} 2 { target aarch64*-*-* } } } */
+/* ARM 32-bit: { dg-final { scan-assembler-times {udf\s+#[0-9]+} 3 { target arm*-*-* } } } */
 
-/* Verify 2 separate call sites.  */
+/* Verify 2 separate call sites (except arm).  */
 /* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {br\tx[0-9]+} 2 { target aarch64*-*-* } } } */
+/* ARM 32-bit: { dg-final { scan-assembler-times {bx\s+(?:r[0-9]+|lr)} 3 { target arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
index 0b23caa49ebb..5eec800e108d 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
@@ -4,6 +4,9 @@
    of a simple register.  */
 /* { dg-do compile } */
 /* { dg-additional-options "-O2" } */
+/* The force_r3_spill check verifies ARM-mode register-pressure codegen,
+   which differs in Thumb mode.  Force ARM mode where supported.  */
+/* { dg-additional-options "-marm" { target arm*-*-* } } */
 
 struct function_table {
     int (*callback1)(int);
@@ -162,4 +165,23 @@ int main() {
 ** ...
 */
 
+/* Looking for r3 fall-back due to register pressure.  */
+/*
+** force_r3_spill: { target arm*-*-* }
+** ...
+** push	\{r3\}
+** ldr	r3, \[(ip), #-4\]
+** eor	r3, r3, #[0-9]+
+** eor	r3, r3, #[0-9]+
+** eor	r3, r3, #[0-9]+
+** eors	r3, r3, #[0-9]+
+** pop	\{r3\}
+** beq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** udf	#[0-9]+
+** .Lkcfi_call\2:
+** blx	\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
index 6b4698447b7b..2daf5aa94bcf 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
@@ -30,3 +30,6 @@ void caller(int sel, void (*ip)(int), int x) {
 /* The typeid scratch register avoids the call target, so it is not always
    w16 (a sibcall target lands in x16/x17, forcing the load into w9).  */
 /* { dg-final { scan-assembler-times {ldur\tw[0-9]+, \[x[0-9]+, #-4\]} 1 { target aarch64*-*-* } } } */
+/* The arm load base is the call target register in ARM mode and ip in
+   Thumb-2 (after the Thumb-bit strip); accept either.  */
+/* { dg-final { scan-assembler-times {ldr\tip, \[(?:r[0-9]+|ip), #-4\]} 1 { target arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
index ad6130c9d323..fac0e3aff0e4 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
@@ -74,7 +74,45 @@ int main(void)
 ** ...
 */
 
+/*
+** indirect_call: { target arm_nothumb }
+** ...
+** mov	(r[0-9]+), r0
+** ...
+** ldr	ip, \[\1, #-4\]
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eors	ip, ip, #[0-9]+
+** beq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** udf	#[0-9]+
+** .Lkcfi_call\2:
+** bx	\1
+** ...
+*/
+
+/* Thumb-2 inserts a BIC to strip the Thumb bit before the typeid load.  */
+/*
+** indirect_call: { target arm_thumb2 }
+** ...
+** mov	(r[0-9]+), r0
+** ...
+** bic	ip, \1, #1
+** ldr	ip, \[ip, #-4\]
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eors	ip, ip, #[0-9]+
+** beq	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap[0-9]+:
+** udf	#[0-9]+
+** .Lkcfi_call\2:
+** bx	\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
 
-/* AArch64 should NOT have trap section (use immediate instructions instead).  */
-/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* } } } */
+/* AArch64, ARM32 should NOT have trap section (use immediate instructions instead).  */
+/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
index 98591ed9b145..279207a85cdc 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
@@ -76,15 +76,20 @@ int main(void)
 /* Verify correct number of KCFI checks: exactly 2 */
 /* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-times {brk\s+#0x[0-9a-f]+} 2 { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-times {udf\s+#[0-9]+} 2 { target arm*-*-* } } } */
 
 /* Positive controls: these should have KCFI checks.  */
 /* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_function} { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler {wrap_normal_inline:.*ud2.*\.size\s+wrap_normal_inline} { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler {normal_function:.*brk\s+#0x[0-9a-f]+.*\.size\s+normal_function} { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler {wrap_normal_inline:.*brk\s+#0x[0-9a-f]+.*\.size\s+wrap_normal_inline} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler {normal_function:.*udf\t#[0-9]+.*\.size\s+normal_function} { target arm*-*-* } } } */
+/* { dg-final { scan-assembler {wrap_normal_inline:.*udf\t#[0-9]+.*\.size\s+wrap_normal_inline} { target arm*-*-* } } } */
 
 /* Negative controls: these should NOT have KCFI checks.  */
 /* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ud2.*\.size\s+wrap_sensitive_inline} { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*brk\s+#0x[0-9a-f]+.*\.size\s+sensitive_non_inline_function} { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*brk\s+#0x[0-9a-f]+.*\.size\s+wrap_sensitive_inline} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-not {sensitive_non_inline_function:[^\n]*udf\t#[0-9]+[^\n]*\.size\tsensitive_non_inline_function} { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-not {wrap_sensitive_inline:[^\n]*udf\t#[0-9]+[^\n]*\.size\twrap_sensitive_inline} { target arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
index af6d86803576..9355d633301b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
@@ -35,3 +35,6 @@ int main() {
    So a total of exactly 1 KCFI check in the entire program.  */
 /* { dg-final { scan-assembler-times {addl\t-4\(%r[ad]x\), %r1[01]d} 1 { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 1 { target aarch64-*-* } } } */
+/* In Thumb-2 the load base is ip (post-Thumb-bit-strip), in ARM mode it is
+   the call target register; accept either.  */
+/* { dg-final { scan-assembler-times {ldr\tip, \[(?:r[0-9]+|ip), #-4\]} 1 { target arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
index 0ced5c43ae92..cb1eb7c7ecc6 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
@@ -30,3 +30,8 @@ int main() {
 
 /* AArch64: All call sites should use -4 offset.  */
 /* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]} { target aarch64*-*-* } } } */
+
+/* ARM 32-bit: All call sites should use -4 offset with EOR sequence.
+   In Thumb-2 the load base is ip (after the Thumb-bit strip); in ARM mode it
+   is the call target register directly.  Accept either.  */
+/* { dg-final { scan-assembler {ldr\tip, \[(?:r[0-9]+|ip), #-4\]} { target arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
index 7a251cbdee3b..612140a0f509 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
@@ -29,7 +29,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -47,4 +47,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target arm*-*-* }
+** ...
+** ldr	(r[0-9]+|ip), \[(r[0-9]+|ip), #-4\]
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
index 3ed5d16c8e91..7f7ada17cc14 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
@@ -2,6 +2,9 @@
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=11,11" } */
 /* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
+/* The typeid offset depends on patchable NOP size (4 bytes in ARM mode,
+   2 bytes in Thumb mode).  Force ARM mode for deterministic offsets.  */
+/* { dg-additional-options "-marm" { target arm*-*-* } } */
 
 void test_function(void) {
 }
@@ -18,7 +21,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -36,4 +39,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target arm*-*-* }
+** ...
+** ldr	(r[0-9]+|ip), \[(r[0-9]+|ip), #-48\]
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
index e354914209e9..0a1f4e20851f 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
@@ -2,6 +2,9 @@
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=8,4" } */
 /* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
+/* The typeid offset depends on patchable NOP size (4 bytes in ARM mode,
+   2 bytes in Thumb mode).  Force ARM mode for deterministic offsets.  */
+/* { dg-additional-options "-marm" { target arm*-*-* } } */
 
 void test_function(void) {
 }
@@ -25,7 +28,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -43,4 +46,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target arm*-*-* }
+** ...
+** ldr	ip, \[r[0-9]+, #-20\]
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
index 7a1dc4fa0e07..548a2f5d8b84 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
@@ -2,6 +2,9 @@
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=3,3" } */
 /* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
+/* The typeid offset depends on patchable NOP size (4 bytes in ARM mode,
+   2 bytes in Thumb mode).  Force ARM mode for deterministic offsets.  */
+/* { dg-additional-options "-marm" { target arm*-*-* } } */
 
 void test_function(void) {
 }
@@ -26,7 +29,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -44,4 +47,11 @@ int main() {
 ** ...
 */
 
+/*
+** main: { target arm*-*-* }
+** ...
+** ldr	(r[0-9]+|ip), \[(r[0-9]+|ip), #-16\]
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
index 7ac40719504b..544ae7807297 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
@@ -99,3 +99,23 @@ int test_non_tail_indirect_call(func_ptr_t handler, int x) {
 /* Type ID loading should use mov + movk pattern for 32-bit constants.  */
 /* { dg-final { scan-assembler {mov\tw17, #[0-9]+} { target aarch64-*-* } } } */
 /* { dg-final { scan-assembler {movk\tw17, #[0-9]+, lsl #16} { target aarch64-*-* } } } */
+
+/* Should have exactly 4 KCFI checks for indirect calls (load type ID from
+   -4 offset + EOR sequence).  */
+/* In Thumb-2 the load base is ip (post-Thumb-bit-strip), in ARM mode it is
+   the call target register; accept either.  */
+/* { dg-final { scan-assembler-times {ldr\tip, \[(?:r[0-9]+|ip), #-4\]} 4 { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-times {eors\tip, ip, #[0-9]+} 4 { target arm*-*-* } } } */
+
+/* Should have exactly 4 trap instructions.  */
+/* { dg-final { scan-assembler-times {udf\t#[0-9]+} 4 { target arm*-*-* } } } */
+
+/* Should have exactly 3 protected tail calls (bx through register after
+   KCFI check).  */
+/* { dg-final { scan-assembler-times {bx\tr[0-9]+} 3 { target arm*-*-* } } } */
+
+/* Should have exactly 1 regular call (non-tail call case).  */
+/* { dg-final { scan-assembler-times {blx\tr[0-9]+} 1 { target arm*-*-* } } } */
+
+/* Type ID loading should use 4 EOR instructions for 32-bit constants.  */
+/* { dg-final { scan-assembler-times {eors?\tip, ip, #[0-9]+} 16 { target arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
index 159e3b340973..e567bb4e5b57 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
@@ -1,5 +1,5 @@
 /* Test AArch64 and ARM32 KCFI trap encoding in BRK/UDF instructions.  */
-/* { dg-do compile { target aarch64*-*-* } } */
+/* { dg-do compile { target aarch64*-*-* arm*-*-* } } */
 
 void target_function(int x, char y) {
 }
@@ -39,4 +39,50 @@ int main() {
 ** ...
 */
 
+/* ARM32 specific: Should have UDF instruction with proper encoding
+   UDF format: 0x8000 | ((type_reg & 31) << 5) | (addr_reg & 31)
+
+   Since ARM32 spills and restores r3 before the trap, the type_reg
+   field uses 0x1F (31) to indicate "register was spilled" rather than
+   pointing to a live register. The addr_reg field contains the actual
+   target register number.
+
+   For this test case using r3, we expect:
+   UDF = 0x8000 | (31 << 5) | 3 = 33763
+   */
+
+/*
+** main: { target arm_nothumb }
+** ...
+** ldr	ip, \[r[0-9]+, #-4\]
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eors	ip, ip, #[0-9]+
+** beq	.Lkcfi_call[0-9]+
+** .Lkcfi_trap[0-9]+:
+** udf	#33763
+** .Lkcfi_call[0-9]+:
+** blx	r3
+** ...
+*/
+
+/* Thumb-2 inserts a BIC to strip the Thumb bit before the typeid load.  */
+/*
+** main: { target arm_thumb2 }
+** ...
+** bic	ip, r[0-9]+, #1
+** ldr	ip, \[ip, #-4\]
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eor	ip, ip, #[0-9]+
+** eors	ip, ip, #[0-9]+
+** beq	.Lkcfi_call[0-9]+
+** .Lkcfi_trap[0-9]+:
+** udf	#33763
+** .Lkcfi_call[0-9]+:
+** blx	r3
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
index e92873e51321..e02a320f2f92 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
@@ -19,9 +19,10 @@ int main() {
 /* Should have exactly 2 trap labels in code.  */
 /* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ud2} 2 { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*brk} 2 { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*udf} 2 { target arm*-*-* } } } */
 
 /* x86_64 should exactly 2 .kcfi_traps sections.  */
 /* { dg-final { scan-assembler-times {\.section\t\.kcfi_traps,"ao",@progbits,\.text} 2 { target x86_64-*-* } } } */
 
-/* AArch64 should NOT have .kcfi_traps section.  */
-/* { dg-final { scan-assembler-not {\.section\t+\.kcfi_traps} { target aarch64*-*-* } } } */
+/* AArch64 and ARM 32-bit should NOT have .kcfi_traps section.  */
+/* { dg-final { scan-assembler-not {\.section\t+\.kcfi_traps} { target aarch64*-*-* arm*-*-* } } } */
-- 
2.34.1

