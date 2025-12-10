Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE225743D
	for <linux-hardening@vger.kernel.org>; Wed, 10 Dec 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765333236; cv=none; b=uGayQqrOQ9yI0ILs47Ex75zsmi9wTrJkRqhfkcTSw6TQCXdyZaQ9DYwzv4phjngJylYpAWJxhtXNBtgjvD88AVByUMWJAtKRY0TnEMA47xn3eVy6LdfIHTOOjTV7T8LXgeR1qrLch2qguXUtOJo3UbbitxmZ5gIk/MoVbM+UQxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765333236; c=relaxed/simple;
	bh=BZUKqJVtyxuhrUMbVPuFJLp45heOwA8pChPzhdpXk9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXYm09Y6ceyn1Cx5faDW0Hfy9KUNJdmgI/LXq02Jzg81NPOUN+kYArfJdws4THrSjcurwFbPsNXq5SOzYx+f+IULc3I1VlxPzBeS4LConU/+O3WsxVsMnpmmQNDrH4NzfFkA4oWTteaFeGMeTr9/GSw77dUy1W9SZmze8dQysbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0IUwmdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0IUwmdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A529C2BCB1;
	Wed, 10 Dec 2025 02:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765333236;
	bh=BZUKqJVtyxuhrUMbVPuFJLp45heOwA8pChPzhdpXk9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0IUwmdpPMisDFgjlvBR8V9eMgt+DESPcpbcijFvG+3JmGfVQ6O/H0mmhDKhz71sn
	 0iX+/ci6Jw+7HjVGBvQnfQcanPzgtI1CcvFMRSCm1A3+OfxBEJBMtJN9A2g0mCxqY8
	 2kv9m6toWvYBhIuuA3WDlwZI1Mi/MMIEqBJXKms+LUzCdNNqhtYi/r6uWrJYH6HDF5
	 MWWayeM91tym6SeH6g1gsg2po24Og2f0fVXCoXtWG0dqygTvuPdeQepelJgdiROQfI
	 RIYH0G2PGRrXlwcM9zusnuYh7B60iRXWlQ/1bnm2CH/L2oycji6//cdI+xyj4NmnkP
	 qAkcn29Bgk0Hg==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
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
Subject: [PATCH v9 6/7] arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
Date: Tue,  9 Dec 2025 18:20:32 -0800
Message-Id: <20251210022035.331892-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210022025.harder.803-kees@kernel.org>
References: <20251210022025.harder.803-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=37399; i=kees@kernel.org; h=from:subject; bh=BZUKqJVtyxuhrUMbVPuFJLp45heOwA8pChPzhdpXk9w=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkWNz74+N0+/Gh/qcL1sl8Crt7ONR0hUh2Tq3rOR5vyc Ts9U1vSUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMBErOUaGxXttq5ZHvPhSvcog oPDf41ARlfSvH5avbrbuSOT1+aX0n5HhCaOts0vQnfRtTVcnPWRmuZ5j8/3apIL5thbX/GydBe+ yAQA=
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

	config/arm/arm-protos.h: Declare KCFI helpers.
	config/arm/arm.cc (arm_maybe_wrap_call_with_kcfi): New function.
	(arm_maybe_wrap_call_value_with_kcfi): New function.
	(arm_output_kcfi_insn): Emit KCFI assembly.
	config/arm/arm.md: Add KCFI RTL patterns and hook expansion.
	doc/invoke.texi: Document arm32 nuances.

gcc/testsuite/ChangeLog:

	* gcc.dg/kcfi/kcfi-adjacency.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-basics.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-call-sharing.c: Add arm patterns.
	* gcc.dg/kcfi/kcfi-complex-addressing.c: Add arm patterns.
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

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/arm/arm-protos.h                   |   4 +
 gcc/config/arm/arm.md                         |  62 +++++++
 gcc/config/arm/arm.cc                         | 170 ++++++++++++++++++
 gcc/doc/invoke.texi                           |  17 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  16 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c |  15 ++
 .../gcc.dg/kcfi/kcfi-arm-fixed-r12.c          |  15 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  24 ++-
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  12 +-
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  19 ++
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  22 ++-
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |   5 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   1 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   3 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |   9 +-
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |   9 +-
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |   9 +-
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |   9 +-
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  18 ++
 .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  30 +++-
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   5 +-
 21 files changed, 458 insertions(+), 16 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-r12.c

diff --git a/gcc/config/arm/arm-protos.h b/gcc/config/arm/arm-protos.h
index ff7e7658f912..ad3dc522e2b9 100644
--- a/gcc/config/arm/arm-protos.h
+++ b/gcc/config/arm/arm-protos.h
@@ -607,6 +607,10 @@ void arm_initialize_isa (sbitmap, const enum isa_feature *);
 
 const char * arm_gen_far_branch (rtx *, int, const char * , const char *);
 
+rtx arm_maybe_wrap_call_with_kcfi (rtx, rtx);
+rtx arm_maybe_wrap_call_value_with_kcfi (rtx, rtx);
+const char *arm_output_kcfi_insn (rtx_insn *, rtx *);
+
 bool arm_mve_immediate_check(rtx, machine_mode, bool);
 
 opt_machine_mode arm_mve_data_mode (scalar_mode, poly_uint64);
diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
index b5d92aebf4d8..f1149b3e291d 100644
--- a/gcc/config/arm/arm.md
+++ b/gcc/config/arm/arm.md
@@ -8622,6 +8622,7 @@
     else
       {
 	pat = gen_call_internal (operands[0], operands[1], operands[2]);
+	pat = arm_maybe_wrap_call_with_kcfi (pat, XEXP (operands[0], 0));
 	arm_emit_call_insn (pat, XEXP (operands[0], 0), false);
       }
 
@@ -8680,6 +8681,20 @@
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
@@ -8746,6 +8761,7 @@
       {
 	pat = gen_call_value_internal (operands[0], operands[1],
 				       operands[2], operands[3]);
+	pat = arm_maybe_wrap_call_value_with_kcfi (pat, XEXP (operands[1], 0));
 	arm_emit_call_insn (pat, XEXP (operands[1], 0), false);
       }
 
@@ -8792,6 +8808,21 @@
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
@@ -8894,6 +8925,7 @@
       operands[2] = const0_rtx;
 
     pat = gen_sibcall_internal (operands[0], operands[1], operands[2]);
+    pat = arm_maybe_wrap_call_with_kcfi (pat, XEXP (operands[0], 0));
     arm_emit_call_insn (pat, operands[0], true);
     DONE;
   }"
@@ -8928,11 +8960,26 @@
 
     pat = gen_sibcall_value_internal (operands[0], operands[1],
                                       operands[2], operands[3]);
+    pat = arm_maybe_wrap_call_value_with_kcfi (pat, XEXP (operands[1], 0));
     arm_emit_call_insn (pat, operands[1], true);
     DONE;
   }"
 )
 
+;; KCFI sibling call - KCFI wraps just the call pattern
+(define_insn "*kcfi_sibcall_insn"
+  [(kcfi (call (mem:SI (match_operand:SI 0 "s_register_operand" "r"))
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
@@ -8953,6 +9000,21 @@
   [(set_attr "type" "call")]
 )
 
+;; KCFI sibling call with return value - KCFI wraps just the call pattern
+(define_insn "*kcfi_sibcall_value_insn"
+  [(set (match_operand 0 "" "")
+	(kcfi (call (mem:SI (match_operand:SI 1 "s_register_operand" "r"))
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
index 1f413b61d5f6..d8e78cddecc8 100644
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
@@ -35852,6 +35854,174 @@ arm_mode_base_reg_class (machine_mode mode)
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
+arm_maybe_wrap_call_value_with_kcfi (rtx pat, rtx addr)
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
+   where operands[0] is the call target register, operands[2] is the KCFI
+   type ID constant.  Returns an empty string as all output is handled by
+   direct assembly generation.  */
+
+const char *
+arm_output_kcfi_insn (rtx_insn *insn, rtx *operands)
+{
+  /* KCFI type id.  */
+  uint32_t type_id = INTVAL (operands[2]);
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
+  /* Create memory operand for the type load.  */
+  rtx mem_op = gen_rtx_MEM (SImode,
+			    gen_rtx_PLUS (SImode, operands[0],
+					  GEN_INT (offset)));
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
+  /* Load actual type from memory into scratch register.  */
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
+#undef TARGET_KCFI_SUPPORTED
+#define TARGET_KCFI_SUPPORTED hook_bool_void_true
+
 #undef TARGET_DOCUMENTATION_NAME
 #define TARGET_DOCUMENTATION_NAME "ARM"
 
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index d93e6b4bb3f4..733267e7cd1f 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -18775,6 +18775,23 @@ trap is taken, allowing the kernel to identify both the KCFI violation
 and the involved registers for detailed diagnostics (eliminating the need
 for a separate @code{.kcfi_traps} section as used on x86_64).
 
+On ARM 32-bit, KCFI type identifiers are emitted as a @code{.word ID}
+directive (a 32-bit constant) before the function entry.  ARM's
+natural 4-byte instruction alignment eliminates the need for additional
+alignment NOPs.  When used with @option{-fpatchable-function-entry}, the
+type identifier is placed before any prefix NOPs.  The runtime check
+preserves argument registers @code{r0} and @code{r1} using @code{push}
+and @code{pop} instructions, then uses them as scratch registers for
+the type comparison.  The expected type is loaded using @code{movw} and
+@code{movt} instruction pairs for 32-bit immediate values.  Type mismatches
+trigger a @code{udf} instruction with an immediate value that encodes
+both the expected type register index and the target address register
+index in the format @code{0x8000 | (type_reg << 5) | addr_reg}.  This
+encoding is captured in the UDF immediate field when the trap is taken,
+allowing the kernel to identify both the KCFI violation and the involved
+registers for detailed diagnostics (eliminating the need for a separate
+@code{.kcfi_traps} section as used on x86_64).
+
 KCFI is intended primarily for kernel code and may not be suitable
 for user-space applications that rely on techniques incompatible
 with strict type checking of indirect calls.
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
index f3d7d23e6af2..00c14c0375cd 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
@@ -78,4 +78,20 @@ __attribute__((noinline)) void test_conditional_call(int flag) {
 ** ...
 */
 
+/*
+** test_complex_args: { target arm*-*-* }
+** ...
+** ldr	ip, \[(r[0-9]+|lr), #-4\]
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
index 6eac946f7abf..4c9a1e7aa552 100644
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
@@ -94,6 +94,22 @@ int main() {
 ** ...
 */
 
+/*
+** static_caller: { target arm*-*-* }
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
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
 
 /* Extern functions should NOT get KCFI preambles.  */
@@ -112,5 +128,5 @@ int main() {
    __kcfi_typeid_ symbols.  */
 /* { dg-final { scan-assembler-not {__kcfi_typeid_external_func_int} } } */
 
-/* AArch64 should NOT have trap section (use immediate instructions instead).  */
-/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* } } } */
+/* AArch64, ARM32 should NOT have trap section (use immediate instructions instead).  */
+/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
index 6062d74ef62a..625cfa350a53 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
@@ -60,21 +60,27 @@ int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *
    1. KCFI check for is_visible call with is_visible type ID A.
    2. KCFI check for is_bin_visible and is_bin_visible_again call with type ID B.  */
 
-/* Verify we have TWO different KCFI check sequences.  */
+/* Verify we have TWO different KCFI check sequences (except on arm, which
+   due to heavy register pressure ends up generating an unmergeable series
+   of instructions: the call target registers differ).  */
 /* Each check should have different type ID constants.  */
 /* x86: { dg-final { scan-assembler-times {movl\s+\$-?[0-9]+,\s+%r10d} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {mov\s+w17, #[0-9]+} 2 { target aarch64*-*-* } } } */
+/* ARM 32-bit: { dg-final { scan-assembler-times {ldr\s+ip, \[(?:r[0-9]+|lr), #-4\]} 3 { target arm*-*-* } } } */
 
-/* Verify the checks use DIFFERENT type IDs (not shared).
+/* Verify the checks use DIFFERENT type IDs (not shared, except arm: see above).
    We should NOT see the same type ID used twice - that would indicate
    unmerged sharing.  */
 /* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*movl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-not {mov\s+w17, #([0-9]+).*mov\s+w17, #\1} { target aarch64*-*-* } } } */
+/* ARM 32-bit: { dg-final { scan-assembler-not {eor\s+ip, ip, #([0-9]+)\n\teor\s+r3, r3, #([0-9]+)\n\teor\s+r3, r3, #([0-9]+)\n\teors\s+r3, r3, #([0-9]+).*eor\s+r3, r3, #\1\n\teor\s+r3, r3, #[0-9]+\n\teor\s+r3, r3, #[0-9]+\n\teors\s+r3, r3, #[0-9]+.*eor\s+r3, r3, #\1\n\teor\s+r3, r3, #[0-9]+\n\teor\s+r3, r3, #[0-9]+\n\teors\s+r3, r3, #[0-9]+} { target arm*-*-* } } } */
 
 /* Verify expected number of traps.  */
 /* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target aarch64*-*-* } } } */
+/* ARM 32-bit: { dg-final { scan-assembler-times {udf\s+#[0-9]+} 3 { target arm*-*-* } } } */
 
-/* Verify 2 separate call sites.  */
+/* Verify 2 separate call sites (except arm).  */
 /* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { target i?86-*-* x86_64-*-* } } } */
 /* AArch64: { dg-final { scan-assembler-times {br\tx[0-9]+} 2 { target aarch64*-*-* } } } */
+/* ARM 32-bit: { dg-final { scan-assembler-times {bx\s+(?:r[0-9]+|lr)} 3 { target arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
index 3ffbd408a69e..92d9dbb7906b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
@@ -162,4 +162,23 @@ int main() {
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
index df39b7f0a8a3..c259620a3ed8 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
@@ -74,7 +74,25 @@ int main(void)
 ** ...
 */
 
+/*
+** indirect_call: { target arm*-*-* }
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
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
 
-/* AArch64 should NOT have trap section (use immediate instructions instead).  */
-/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* } } } */
+/* AArch64, ARM32 should NOT have trap section (use immediate instructions instead).  */
+/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
index cdeb202ffd12..f8103466816a 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
@@ -76,15 +76,20 @@ int main(void)
 /* Verify correct number of KCFI checks: exactly 2 */
 /* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-times {udf\s+#[0-9]+} 2 { target arm*-*-* } } } */
 
 /* Positive controls: these should have KCFI checks.  */
 /* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_function} { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler {wrap_normal_inline:.*ud2.*\.size\s+wrap_normal_inline} { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler {normal_function:.*brk\s+#[0-9]+.*\.size\s+normal_function} { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler {wrap_normal_inline:.*brk\s+#[0-9]+.*\.size\s+wrap_normal_inline} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler {normal_function:.*udf\t#[0-9]+.*\.size\s+normal_function} { target arm*-*-* } } } */
+/* { dg-final { scan-assembler {wrap_normal_inline:.*udf\t#[0-9]+.*\.size\s+wrap_normal_inline} { target arm*-*-* } } } */
 
 /* Negative controls: these should NOT have KCFI checks.  */
 /* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ud2.*\.size\s+wrap_sensitive_inline} { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*brk\s+#[0-9]+.*\.size\s+sensitive_non_inline_function} { target aarch64*-*-* } } } */
 /* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*brk\s+#[0-9]+.*\.size\s+wrap_sensitive_inline} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-not {sensitive_non_inline_function:[^\n]*udf\t#[0-9]+[^\n]*\.size\tsensitive_non_inline_function} { target arm*-*-* } } } */
+/* { dg-final { scan-assembler-not {wrap_sensitive_inline:[^\n]*udf\t#[0-9]+[^\n]*\.size\twrap_sensitive_inline} { target arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
index af6d86803576..95bb46304493 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
@@ -35,3 +35,4 @@ int main() {
    So a total of exactly 1 KCFI check in the entire program.  */
 /* { dg-final { scan-assembler-times {addl\t-4\(%r[ad]x\), %r1[01]d} 1 { target x86_64-*-* } } } */
 /* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 1 { target aarch64-*-* } } } */
+/* { dg-final { scan-assembler-times {ldr\tip, \[r[0-9]+, #-4\]} 1 { target arm*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
index 0ced5c43ae92..88f0ae64091b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
@@ -30,3 +30,6 @@ int main() {
 
 /* AArch64: All call sites should use -4 offset.  */
 /* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]} { target aarch64*-*-* } } } */
+
+/* ARM 32-bit: All call sites should use -4 offset with EOR sequence.  */
+/* { dg-final { scan-assembler {ldr\tip, \[r[0-9]+, #-4\]} { target arm*-*-* } } } */
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
index 3ed5d16c8e91..da3d8dc41f60 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
@@ -18,7 +18,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -36,4 +36,11 @@ int main() {
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
index e354914209e9..d61274e70157 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
@@ -25,7 +25,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -43,4 +43,11 @@ int main() {
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
index 7a1dc4fa0e07..93df4d7ea5b6 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
@@ -26,7 +26,7 @@ int main() {
 */
 
 /*
-** __cfi_test_function: { target aarch64*-*-* }
+** __cfi_test_function: { target aarch64*-*-* arm*-*-* }
 ** .word	0x[0-9a-f]+
 */
 
@@ -44,4 +44,11 @@ int main() {
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
index 1a7cc4aa167f..ee9d2c6dc741 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
@@ -97,3 +97,21 @@ int test_non_tail_indirect_call(func_ptr_t handler, int x) {
 /* Type ID loading should use mov + movk pattern for 32-bit constants.  */
 /* { dg-final { scan-assembler {mov\tw17, #[0-9]+} { target aarch64-*-* } } } */
 /* { dg-final { scan-assembler {movk\tw17, #[0-9]+, lsl #16} { target aarch64-*-* } } } */
+
+/* Should have exactly 4 KCFI checks for indirect calls (load type ID from
+   -4 offset + EOR sequence).  */
+/* { dg-final { scan-assembler-times {ldr\tip, \[r[0-9]+, #-4\]} 4 { target arm*-*-* } } } */
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
index 0c257565c9e8..f302283db943 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
@@ -1,5 +1,5 @@
 /* Test AArch64 and ARM32 KCFI trap encoding in BRK/UDF instructions.  */
-/* { dg-do compile { target aarch64*-*-* } } */
+/* { dg-do compile { target aarch64*-*-* arm*-*-* } } */
 
 void target_function(int x, char y) {
 }
@@ -38,4 +38,32 @@ int main() {
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
+** main: { target arm*-*-* }
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

