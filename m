Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6184C6536
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214845; cv=none; b=EfBMt4uCxf55JGGwZRk4/EqKFBN5/vhbqHwtvtJVoSLFLEp2P6fYUaJRFDs96vJ4PyGAwAowUPupXOWOx4aImngWCCZwGdBJPEEdGURu+cXS333vNQ4qjHlI20/fDw9jfZn1gRvdmIOSGVczfRJYbWNQcoKmZl/InJeCA4NM+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214845; c=relaxed/simple;
	bh=ssb8ADQjAjMNPZcnUC1585ifhulvLGqFpqQU3vCMBKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmR03bh+Xekul666trHLOl3HkbtlXPAis5afG+xquvSYZlJu/zp6w+tACX6jOfRW0iv3OHnUYppBq8iXSRIMg4gV37+XcxwNNDXwpZKKzlI3ResijjUTJeiNdOJ1uBSEVDCr2wWBWGm4uvWpKOiYZoVc3WgpyMBDoHJmWL0sx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3LttGfT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3LttGfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68191F008A3;
	Mon,  5 Oct 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214839;
	bh=M9uBshGmf/6cViGU+shvHB1Aw/y5tdxd2+ICqPJvLao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a3LttGfTI/BOYUNKm/j2HcCQgO4v5GjRV9KwdwAFC3uV75Nd/E0SSL556N0XrDoVT
	 eC6W+NflPaBkNMhDQxKqd/b8NRHX3J/L74zm6CyTxaUv2jeHzvriT98L1py7oz1T6y
	 uZbvrjopPdCG56zENU1O0M3vH52Ou4gp1czVQzf6SBuYJIqhsIsuuKWyYMyClYZa0w
	 r+GM0934c5z9UoDNfRpHSctCn3q3NgYybzUz6LTM22wf3zOq3RS5vz1OjDClpY4VEJ
	 5QLgFo0OszjELfxC1FqFcATaB2A31ap9JCMOvdN06DNQmZ1/5bZlho3BUybzHV1stZ
	 28j+61tOmHpmA==
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>,
	Richard Biener <rguenther@suse.de>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hubicka <hubicka@ucw.cz>,
	Uros Bizjak <ubizjak@gmail.com>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
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
Subject: [PATCH v17 4/7] x86: Add x86_64 Kernel Control Flow Integrity implementation
Date: Mon,  5 Oct 2026 08:40:33 -0700
Message-ID: <20261005154039.1464721-4-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005154028.out.839-kees@kernel.org>
References: <20261005154028.out.839-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=57508; i=kees@kernel.org; h=from:subject; bh=ssb8ADQjAjMNPZcnUC1585ifhulvLGqFpqQU3vCMBKc=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHj3zOWHP6QMHGFuO+I3fOSPw5rfd3EUfhh+C4dyF1E xie33iwoKOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAi/amMDFuufl5rLFiu7dky XV1u34uAVPFtqWL3JhS9Wn7lStKeB+kM/8zPRW51Otd3V/SM4aLY3dW7VIXuVzRPCn7VX6izy2/ BNW4A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement x86_64-specific KCFI backend:

- Implies -mindirect-branch-register since KCFI needs call target in
  a register for typeid hash loading.

- Function preamble generation with type IDs positioned at -(4+prefix_nops)
  offset from function entry point.

- Function-aligned KCFI preambles using calculated alignment padding NOPs:
  aligned(prefix_nops + 5, $func_align) to maintain ability to call the
  __cfi_ preamble directly in the case of Linux's FineIBT alternative
  CFI sequences (live patched into place).

- Type-id hash avoids generating ENDBR instruction in type IDs
  (0xfa1e0ff3/0xfb1e0ff3 are incremented by 1 to prevent execution).

- On-demand scratch register allocation strategy (r11 as needed), with
  the clobbers added when KCFI is used.

- Incompatible with -ffixed-r10 or -ffixed-r11.

- Uses the .kcfi_traps section for debugger/runtime metadata.

- Introduces -fsanitize-kcfi-arity to enable function arg count to be
  represented in the kcfi hash preamble for FineIBT.

Assembly Code Pattern layout required by Linux kernel:
  movl $inverse_type_id, %r10d   ; Load expected type (0 - hash)
  addl offset(%target), %r10d    ; Add stored type ID from preamble
  je .Lkcfi_call                 ; Branch if types match (sum == 0)
  .Lkcfi_trap: ud2               ; Undefined instruction trap on mismatch
  .Lkcfi_call: call/jmp *%target ; Execute validated indirect transfer

Build and run tested on x86_64 Linux kernel with various CPU errata
handling alternatives, with and without FineIBT patching.

Assisted-by: LLM [tests]

gcc/ChangeLog:

	* common.opt (fsanitize-kcfi-arity): New option.
	* config/i386/i386.h: KCFI enables TARGET_INDIRECT_BRANCH_REGISTER.
	* config/i386/i386-protos.h: Update ix86_output_call_insn.
	* config/i386/i386-expand.cc (ix86_expand_call): Expand indirect
	calls into KCFI RTL.
	* config/i386/i386.cc (ix86_kcfi_mask_type_id): New function.
	(ix86_output_call_insn): Emit KCFI assembly.
	* config/i386/i386.md: Add KCFI RTL substitution patterns.
	* doc/invoke.texi: Document x86 nuances.
	* opts.cc (common_handle_option): Reset flag_sanitize_kcfi_arity.

gcc/testsuite/ChangeLog:

	* gcc.dg/kcfi/kcfi-adjacency.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-basics.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-call-sharing.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-complex-addressing.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-direct-call-shapes.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-move-preservation.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-no-sanitize.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-offset-validation.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-patchable-large.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-patchable-medium.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add x86 patterns.
	* gcc.dg/kcfi/kcfi-tail-calls.c: Add x86 tail-call patterns.
	* gcc.dg/kcfi/kcfi-trap-section.c: Add x86 trap patterns.
	* gcc.dg/kcfi/kcfi-trap-section-per-func.c: New test.
	* gcc.dg/kcfi/kcfi-x86-32bit.c: New test.
	* gcc.dg/kcfi/kcfi-x86-arity.c: New test.
	* gcc.dg/kcfi/kcfi-x86-endbr-collision.c: New test.
	* gcc.dg/kcfi/kcfi-x86-fixed-r10.c: New test.
	* gcc.dg/kcfi/kcfi-x86-fixed-r11.c: New test.
	* gcc.dg/kcfi/kcfi-x86-retpoline-r11.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/i386/i386-protos.h                 |   2 +-
 gcc/config/i386/i386.h                        |   3 +-
 gcc/config/i386/i386.md                       |  63 ++++--
 gcc/config/i386/i386-expand.cc                |  28 ++-
 gcc/config/i386/i386.cc                       | 210 +++++++++++++++++-
 gcc/doc/invoke.texi                           |  46 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  17 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  21 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  15 ++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  18 ++
 .../gcc.dg/kcfi/kcfi-direct-call-shapes.c     |   1 +
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  19 ++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  11 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   5 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   5 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  24 ++
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  13 ++
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  20 ++
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  21 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  20 ++
 .../gcc.dg/kcfi/kcfi-trap-section-per-func.c  |  23 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   6 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c    |   7 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c    |  93 ++++++++
 .../gcc.dg/kcfi/kcfi-x86-endbr-collision.c    |  55 +++++
 .../gcc.dg/kcfi/kcfi-x86-fixed-r10.c          |   7 +
 .../gcc.dg/kcfi/kcfi-x86-fixed-r11.c          |   7 +
 .../gcc.dg/kcfi/kcfi-x86-retpoline-r11.c      |  40 ++++
 gcc/common.opt                                |   8 +
 gcc/opts.cc                                   |   1 +
 30 files changed, 782 insertions(+), 27 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section-per-func.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-endbr-collision.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c

diff --git a/gcc/config/i386/i386-protos.h b/gcc/config/i386/i386-protos.h
index 4e56bf70c8d5..dbf40eaa3c67 100644
--- a/gcc/config/i386/i386-protos.h
+++ b/gcc/config/i386/i386-protos.h
@@ -376,7 +376,7 @@ extern enum attr_cpu ix86_schedule;
 #endif
 
 extern bool ix86_nopic_noplt_attribute_p (rtx call_op);
-extern const char * ix86_output_call_insn (rtx_insn *insn, rtx call_op);
+extern const char * ix86_output_call_insn (rtx_insn *insn, rtx *operands);
 extern const char * ix86_output_indirect_jmp (rtx call_op);
 extern const char * ix86_output_function_return (bool long_p);
 extern const char * ix86_output_indirect_function_return (rtx ret_op);
diff --git a/gcc/config/i386/i386.h b/gcc/config/i386/i386.h
index 47725c560906..678aff983bcb 100644
--- a/gcc/config/i386/i386.h
+++ b/gcc/config/i386/i386.h
@@ -3108,7 +3108,8 @@ extern void debug_dispatch_window (int);
 
 #define TARGET_INDIRECT_BRANCH_REGISTER \
   (ix86_indirect_branch_register \
-   || cfun->machine->indirect_branch_type != indirect_branch_keep)
+   || cfun->machine->indirect_branch_type != indirect_branch_keep \
+   || (flag_sanitize & SANITIZE_KCFI))
 
 #define IX86_HLE_ACQUIRE (1 << 16)
 #define IX86_HLE_RELEASE (1 << 17)
diff --git a/gcc/config/i386/i386.md b/gcc/config/i386/i386.md
index 0d4749e6e091..4b249d234c76 100644
--- a/gcc/config/i386/i386.md
+++ b/gcc/config/i386/i386.md
@@ -21165,11 +21165,19 @@
   DONE;
 })
 
-(define_insn "*call"
+(define_subst_attr "kcfi" "kcfi_subst" "" "_kcfi")
+
+(define_subst "kcfi_subst"
+  [(match_operand 0)]
+  ""
+  [(kcfi (match_dup 0)
+	 (match_operand 2 "const_int_operand"))])
+
+(define_insn "*call<kcfi>"
   [(call (mem:QI (match_operand:W 0 "call_insn_operand" "<c>BwBz"))
 	 (match_operand 1))]
   "!SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[0]);"
+  "* return ix86_output_call_insn (insn, operands);"
   [(set_attr "type" "call")])
 
 ;; This covers both call and sibcall since only GOT slot is allowed.
@@ -21180,7 +21188,8 @@
   "TARGET_X32 && !TARGET_INDIRECT_BRANCH_REGISTER"
 {
   rtx fnaddr = gen_const_mem (DImode, XEXP (operands[0], 0));
-  return ix86_output_call_insn (insn, fnaddr);
+  rtx fn_operands[] = { fnaddr };
+  return ix86_output_call_insn (insn, fn_operands);
 }
   [(set_attr "type" "call")])
 
@@ -21198,15 +21207,17 @@
 {
   rtx fnaddr = gen_rtx_PLUS (SImode, operands[0], operands[1]);
   fnaddr = gen_const_mem (SImode, fnaddr);
-  return ix86_output_call_insn (insn, fnaddr);
+  rtx fn_operands[] = { fnaddr };
+  return ix86_output_call_insn (insn, fn_operands);
 }
   [(set_attr "type" "call")])
 
-(define_insn "*sibcall"
+;; KCFI sibling call
+(define_insn "*sibcall<kcfi>"
   [(call (mem:QI (match_operand:W 0 "sibcall_insn_operand" "UBsBz"))
 	 (match_operand 1))]
   "SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[0]);"
+  "* return ix86_output_call_insn (insn, operands);"
   [(set_attr "type" "call")])
 
 (define_insn "*sibcall_memory"
@@ -21214,7 +21225,7 @@
 	 (match_operand 1))
    (unspec [(const_int 0)] UNSPEC_PEEPSIB)]
   "!TARGET_X32 && !TARGET_INDIRECT_BRANCH_REGISTER"
-  "* return ix86_output_call_insn (insn, operands[0]);"
+  "* return ix86_output_call_insn (insn, operands);"
   [(set_attr "type" "call")])
 
 (define_peephole2
@@ -21265,7 +21276,7 @@
 	(plus:SI (reg:SI SP_REG)
 		 (match_operand:SI 2 "immediate_operand" "i")))]
   "!TARGET_64BIT && !SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[0]);"
+  "* return ix86_output_call_insn (insn, operands);"
   [(set_attr "type" "call")])
 
 (define_insn "*sibcall_pop"
@@ -21275,7 +21286,7 @@
 	(plus:SI (reg:SI SP_REG)
 		 (match_operand:SI 2 "immediate_operand" "i")))]
   "!TARGET_64BIT && SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[0]);"
+  "* return ix86_output_call_insn (insn, operands);"
   [(set_attr "type" "call")])
 
 (define_insn "*sibcall_pop_memory"
@@ -21286,7 +21297,7 @@
 		 (match_operand:SI 2 "immediate_operand" "i")))
    (unspec [(const_int 0)] UNSPEC_PEEPSIB)]
   "!TARGET_64BIT && !TARGET_INDIRECT_BRANCH_REGISTER"
-  "* return ix86_output_call_insn (insn, operands[0]);"
+  "* return ix86_output_call_insn (insn, operands);"
   [(set_attr "type" "call")])
 
 (define_peephole2
@@ -21363,12 +21374,22 @@
   DONE;
 })
 
-(define_insn "*call_value"
+(define_subst_attr "kcfiv" "kcfiv_subst" "" "_kcfi")
+
+(define_subst "kcfiv_subst"
+  [(set (match_operand 0)
+	(match_operand 1))]
+  ""
+  [(set (match_dup 0)
+	(kcfi (match_dup 1)
+	      (match_operand 3 "const_int_operand")))])
+
+(define_insn "*call_value<kcfiv>"
   [(set (match_operand 0)
 	(call (mem:QI (match_operand:W 1 "call_insn_operand" "<c>BwBz"))
 	      (match_operand 2)))]
   "!SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[1]);"
+  "* return ix86_output_call_insn (insn, &operands[1]);"
   [(set_attr "type" "callv")])
 
 ;; This covers both call and sibcall since only GOT slot is allowed.
@@ -21381,7 +21402,8 @@
   "TARGET_X32 && !TARGET_INDIRECT_BRANCH_REGISTER"
 {
   rtx fnaddr = gen_const_mem (DImode, XEXP (operands[1], 0));
-  return ix86_output_call_insn (insn, fnaddr);
+  rtx fn_operands[] = { fnaddr };
+  return ix86_output_call_insn (insn, fn_operands);
 }
   [(set_attr "type" "callv")])
 
@@ -21400,16 +21422,17 @@
 {
   rtx fnaddr = gen_rtx_PLUS (SImode, operands[1], operands[2]);
   fnaddr = gen_const_mem (SImode, fnaddr);
-  return ix86_output_call_insn (insn, fnaddr);
+  rtx fn_operands[] = { fnaddr };
+  return ix86_output_call_insn (insn, fn_operands);
 }
   [(set_attr "type" "callv")])
 
-(define_insn "*sibcall_value"
+(define_insn "*sibcall_value<kcfiv>"
   [(set (match_operand 0)
 	(call (mem:QI (match_operand:W 1 "sibcall_insn_operand" "UBsBz"))
 	      (match_operand 2)))]
   "SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[1]);"
+  "* return ix86_output_call_insn (insn, &operands[1]);"
   [(set_attr "type" "callv")])
 
 (define_insn "*sibcall_value_memory"
@@ -21418,7 +21441,7 @@
 	      (match_operand 2)))
    (unspec [(const_int 0)] UNSPEC_PEEPSIB)]
   "!TARGET_X32 && !TARGET_INDIRECT_BRANCH_REGISTER"
-  "* return ix86_output_call_insn (insn, operands[1]);"
+  "* return ix86_output_call_insn (insn, &operands[1]);"
   [(set_attr "type" "callv")])
 
 (define_peephole2
@@ -21475,7 +21498,7 @@
 	(plus:SI (reg:SI SP_REG)
 		 (match_operand:SI 3 "immediate_operand" "i")))]
   "!TARGET_64BIT && !SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[1]);"
+  "* return ix86_output_call_insn (insn, &operands[1]);"
   [(set_attr "type" "callv")])
 
 (define_insn "*sibcall_value_pop"
@@ -21486,7 +21509,7 @@
 	(plus:SI (reg:SI SP_REG)
 		 (match_operand:SI 3 "immediate_operand" "i")))]
   "!TARGET_64BIT && SIBLING_CALL_P (insn)"
-  "* return ix86_output_call_insn (insn, operands[1]);"
+  "* return ix86_output_call_insn (insn, &operands[1]);"
   [(set_attr "type" "callv")])
 
 (define_insn "*sibcall_value_pop_memory"
@@ -21498,7 +21521,7 @@
 		 (match_operand:SI 3 "immediate_operand" "i")))
    (unspec [(const_int 0)] UNSPEC_PEEPSIB)]
   "!TARGET_64BIT && !TARGET_INDIRECT_BRANCH_REGISTER"
-  "* return ix86_output_call_insn (insn, operands[1]);"
+  "* return ix86_output_call_insn (insn, &operands[1]);"
   [(set_attr "type" "callv")])
 
 (define_peephole2
diff --git a/gcc/config/i386/i386-expand.cc b/gcc/config/i386/i386-expand.cc
index 9e112d017345..a93f81f29518 100644
--- a/gcc/config/i386/i386-expand.cc
+++ b/gcc/config/i386/i386-expand.cc
@@ -94,6 +94,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "i386-builtins.h"
 #include "i386-expand.h"
 #include "asan.h"
+#include "kcfi.h"
 #include "function-abi.h"
 
 /* Split one or more double-mode RTL references into pairs of half-mode
@@ -11348,9 +11349,10 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   rtx vec[3];
   rtx use = NULL, call;
   unsigned int vec_len = 0;
+  bool is_direct_call = SYMBOL_REF_P (XEXP (fnaddr, 0));
   tree fndecl;
 
-  if (SYMBOL_REF_P (XEXP (fnaddr, 0)))
+  if (is_direct_call)
     {
       fndecl = SYMBOL_REF_DECL (XEXP (fnaddr, 0));
       if (fndecl)
@@ -11374,7 +11376,7 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   if (TARGET_MACHO && !TARGET_64BIT)
     {
 #if TARGET_MACHO
-      if (flag_pic && SYMBOL_REF_P (XEXP (fnaddr, 0)))
+      if (flag_pic && is_direct_call)
 	fnaddr = machopic_indirect_call_target (fnaddr);
 #endif
     }
@@ -11458,7 +11460,7 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
   if (ix86_cmodel == CM_LARGE_PIC
       && !TARGET_PECOFF
       && MEM_P (fnaddr)
-      && SYMBOL_REF_P (XEXP (fnaddr, 0))
+      && is_direct_call
       && !local_symbolic_operand (XEXP (fnaddr, 0), VOIDmode))
     fnaddr = gen_rtx_MEM (QImode, construct_plt_address (XEXP (fnaddr, 0)));
   /* Since x32 GOT slot is 64 bit with zero upper 32 bits, indirect
@@ -11490,6 +11492,26 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx callarg1,
 
   call = gen_rtx_CALL (VOIDmode, fnaddr, callarg1);
 
+  /* Only indirect calls need KCFI instrumentation.  After address
+     legitimization an indirect target is a REG; every symbolic form
+     (SYMBOL_REF, LABEL_REF, CONST) is a direct call.  Use a strict
+     REG_P check here rather than the broader is_direct_call (which is
+     SYMBOL_REF_P and is shared with PIC/PLT logic) so that direct calls
+     that are not SYMBOL_REF are not wrongly wrapped.  */
+  rtx kcfi_type_rtx = REG_P (XEXP (fnaddr, 0))
+    ? kcfi_get_type_id_for_expanding_gimple_call ()
+    : NULL_RTX;
+  if (kcfi_type_rtx)
+    {
+      /* Wrap call with KCFI.  */
+      call = gen_rtx_KCFI (VOIDmode, call, kcfi_type_rtx);
+
+      /* Add KCFI clobbers for the insn sequence.  */
+      clobber_reg (&use, gen_rtx_REG (DImode, R10_REG));
+      clobber_reg (&use, gen_rtx_REG (DImode, R11_REG));
+      clobber_reg (&use, gen_rtx_REG (CCmode, FLAGS_REG));
+    }
+
   if (retval)
     call = gen_rtx_SET (retval, call);
   vec[vec_len++] = call;
diff --git a/gcc/config/i386/i386.cc b/gcc/config/i386/i386.cc
index e9015d2427e7..2de84b7a3253 100644
--- a/gcc/config/i386/i386.cc
+++ b/gcc/config/i386/i386.cc
@@ -99,6 +99,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "i386-builtins.h"
 #include "i386-expand.h"
 #include "i386-features.h"
+#include "kcfi.h"
 #include "function-abi.h"
 #include "rtl-error.h"
 #include "gimple-pretty-print.h"
@@ -351,6 +352,26 @@ unsigned int const svr4_debugger_register_map[FIRST_PSEUDO_REGISTER] =
   INVALID_REGNUM,
 };
 
+/* KCFI arity (how many parameters a function has) is encoded in the
+   preamble's immediate register.  The encoding is as follows:
+
+   Arity represented by
+       0 by %eax (gcc regno = 0)
+       1 by %ecx (gcc regno = 2)
+       2 by %edx (gcc regno = 1)
+       3 by %ebx (gcc regno = 3)
+       4 by %esp (gcc regno = 7)
+       5 by %ebp (gcc regno = 6)
+       6 by %esi (gcc regno = 4)
+       7 by %edi (gcc regno = 5)
+*/
+#define KCFI_ARITY_MAX_INDICATOR 7
+unsigned int const kcfi_arity_register_map[KCFI_ARITY_MAX_INDICATOR + 1] =
+{
+  /* eax to edi, as above.  */
+  0, 2, 1, 3, 7, 6, 4, 5
+};
+
 /* Define parameter passing and return registers.  */
 
 static int const x86_64_int_parameter_registers[6] =
@@ -17760,11 +17781,89 @@ ix86_output_indirect_function_return (rtx ret_op)
   return "";
 }
 
-/* Output the assembly for a call instruction.  */
+/* Output the assembly for a call instruction.  INSN is the RTL instruction
+   being processed.  OPERANDS is the array of RTL operands where operands[0]
+   is the call target, operands[1] is the call operand (unused on x86), and
+   operands[2] is the KCFI type ID constant (for KCFI-instrumented calls).  */
 
 const char *
-ix86_output_call_insn (rtx_insn *insn, rtx call_op)
+ix86_output_call_insn (rtx_insn *insn, rtx *operands)
 {
+  rtx call_op = operands[0];
+  rtx pat = PATTERN (insn);
+
+  /* If KCFI, emit the check sequence first.  */
+  if (GET_CODE (pat) == KCFI
+      || (GET_CODE (pat) == SET && GET_CODE (XEXP (pat, 1)) == KCFI))
+    {
+      /* Target is guaranteed to be in a register due to
+	 TARGET_INDIRECT_BRANCH_REGISTER.  */
+      gcc_assert (REG_P (call_op));
+
+      /* In thunk-extern mode, the register must be R11 for FineIBT
+	 compatibility.  */
+      if (cfun->machine->indirect_branch_type == indirect_branch_thunk_extern)
+	{
+	  if (REGNO (call_op) != R11_REG)
+	    {
+	      /* Emit move from current target to R11.  */
+	      call_op = gen_rtx_REG (DImode, R11_REG);
+	      rtx r11_operands[2] = { operands[0], call_op };
+	      output_asm_insn ("movq\t%0, %1", r11_operands);
+	    }
+	}
+
+      /* Get unique label number for this KCFI check.  */
+      int labelno = kcfi_next_labelno ();
+
+      /* Generate custom label names.  */
+      char trap_name[32];
+      char call_name[32];
+      ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", labelno);
+      ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", labelno);
+
+      /* Choose scratch register: r10 by default, r11 if r10 is the target.  */
+      bool target_is_r10 = (REGNO (call_op) == R10_REG);
+      rtx scratch_reg = gen_rtx_REG (SImode, target_is_r10 ? R11_REG : R10_REG);
+
+      /* Get KCFI type ID from operand 2.  */
+      uint32_t type_id = UINTVAL (operands[2]);
+
+      /* Convert to inverse for the check (0 - hash).  */
+      uint32_t inverse_type_id = (uint32_t)(0 - type_id);
+
+      /* Calculate offset to typeid from target address.  */
+      HOST_WIDE_INT offset = -kcfi_get_typeid_offset ();
+
+      /* Output complete KCFI check sequence.  */
+      rtx inverse_type_id_rtx = gen_int_mode (inverse_type_id, SImode);
+      rtx mov_operands[2] = { inverse_type_id_rtx, scratch_reg };
+      output_asm_insn ("movl\t$%c0, %1", mov_operands);
+
+      /* Create memory operand for the addl instruction.  */
+      rtx offset_rtx = gen_int_mode (offset, DImode);
+      rtx mem_op = gen_rtx_MEM (SImode,
+				gen_rtx_PLUS (DImode, call_op, offset_rtx));
+      rtx add_operands[2] = { mem_op, scratch_reg };
+      output_asm_insn ("addl\t%0, %1", add_operands);
+
+      /* Output conditional jump to call label.  */
+      fputs ("\tje\t", asm_out_file);
+      assemble_name (asm_out_file, call_name);
+      fputc ('\n', asm_out_file);
+
+      /* Output trap label and instruction.  */
+      ASM_OUTPUT_LABEL (asm_out_file, trap_name);
+      output_asm_insn ("ud2", operands);
+
+      /* Use common helper for trap section entry.  */
+      rtx trap_label_sym = gen_rtx_SYMBOL_REF (Pmode, trap_name);
+      kcfi_emit_traps_section (asm_out_file, trap_label_sym, labelno);
+
+      /* Output pass/call label.  */
+      ASM_OUTPUT_LABEL (asm_out_file, call_name);
+    }
+
   bool direct_p = constant_call_address_operand (call_op, VOIDmode);
   bool output_indirect_p
     = (!TARGET_SEH
@@ -29632,6 +29731,113 @@ ix86_set_handled_components (sbitmap components)
       }
 }
 
+/* Apply x86-64 specific masking to KCFI type ID.  TYPE_ID is the 32-bit
+   KCFI type identifier to potentially mask.  Returns the type ID with
+   x86-64 specific adjustments to avoid embedding ENDBR64/32 instruction
+   sequences in the type identifier values.  */
+
+static uint32_t
+ix86_kcfi_mask_type_id (uint32_t type_id)
+{
+  /* Note this deliberately does NOT use ix86_endbr_immediate_operand,
+     since that is gated by -fcf-protection, but the KCFI ABI requires
+     this always be masked.  */
+  if (type_id == 0xfa1e0ff3U || type_id == 0xfb1e0ff3U)
+    return type_id + 1;
+
+  return type_id;
+}
+
+/* Return x86-64 specific function arity (number of integer register
+   arguments) of the given FNDECL.  */
+
+static uint8_t
+ix86_kcfi_compute_type_arity (tree fndecl)
+{
+  tree args;
+  uint8_t arity = 0;
+
+  /* Only count arity if requested.  */
+  if (!flag_sanitize_kcfi_arity)
+    return 0;
+
+  /* If fndecl is NULL, we can't determine arity - return 0.  */
+  if (!fndecl)
+    return 0;
+
+  /* Count the number of registers used, disregard SSE registers.  */
+  for (args = DECL_ARGUMENTS (fndecl); args; args = TREE_CHAIN (args))
+  {
+    int int_nregs, sse_nregs;
+    bool args_on_stack = false;
+    machine_mode mode = TYPE_MODE (TREE_TYPE (args));
+
+    args_on_stack = examine_argument (mode, TREE_TYPE (args), 0, &int_nregs,
+				      &sse_nregs);
+    /* If we place arguments on the stack, return highest arity indicator.  */
+    if (args_on_stack)
+      return KCFI_ARITY_MAX_INDICATOR;
+    arity += int_nregs;
+  }
+
+  /* Return KCFI_ARITY_MAX_INDICATOR if we have counted more than
+     KCFI_ARITY_MAX_INDICATOR arguments.  */
+  return arity > KCFI_ARITY_MAX_INDICATOR ? KCFI_ARITY_MAX_INDICATOR : arity;
+}
+
+/* Emit x86_64-specific type ID instruction and return instruction size.
+   FILE is the output assembly file stream, or NULL for size calculation only.
+   TYPE_ID is the 32-bit KCFI type identifier to emit.  FNDECL is the function
+   declaration, used to compute arity if needed.  Returns the number
+   of bytes the instruction occupies (5 bytes for x86_64 movl instruction).  */
+
+static int
+ix86_kcfi_emit_type_id (FILE *file, uint32_t type_id, tree fndecl)
+{
+  /* Compute function arity.  */
+  uint8_t arity = ix86_kcfi_compute_type_arity (fndecl);
+
+  /* Choose register for movl instruction.  */
+  gcc_assert (arity <= KCFI_ARITY_MAX_INDICATOR);
+  uint32_t regno = kcfi_arity_register_map[arity];
+
+  if (file)
+    fprintf (file, "\tmovl\t$0x%08x, %%e%s\n", type_id, reg_names[regno]);
+
+  /* x86_64 uses 5-byte movl instruction for type ID.  */
+  return 5;
+}
+
+/* Return true if the target supports KCFI.
+   KCFI requires 64-bit mode (not x32) and the R10/R11 registers.  */
+
+static bool
+ix86_kcfi_supported_p (void)
+{
+  if (!TARGET_64BIT || TARGET_X32)
+    {
+      error ("%<-fsanitize=kcfi%> is not supported for 32-bit x86 or x32 mode");
+      return false;
+    }
+  if (fixed_regs[R10_REG] || fixed_regs[R11_REG])
+    {
+      error ("%<-fsanitize=kcfi%> is not compatible with "
+	     "%<-ffixed-r10%> or %<-ffixed-r11%> as KCFI requires these "
+	     "registers for type checking");
+      return false;
+    }
+  return true;
+}
+
+#undef TARGET_KCFI_SUPPORTED
+#define TARGET_KCFI_SUPPORTED ix86_kcfi_supported_p
+
+#undef TARGET_KCFI_MASK_TYPE_ID
+#define TARGET_KCFI_MASK_TYPE_ID ix86_kcfi_mask_type_id
+
+#undef TARGET_KCFI_EMIT_TYPE_ID
+#define TARGET_KCFI_EMIT_TYPE_ID ix86_kcfi_emit_type_id
+
 #undef TARGET_SHRINK_WRAP_GET_SEPARATE_COMPONENTS
 #define TARGET_SHRINK_WRAP_GET_SEPARATE_COMPONENTS ix86_get_separate_components
 #undef TARGET_SHRINK_WRAP_COMPONENTS_FOR_BB
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index f8a325b5153a..da258175b497 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -17551,6 +17551,52 @@ The type identifier is placed before the function entry point,
 allowing runtime verification without additional metadata structures,
 and without changing the entry points of the target functions.
 
+Platform-specific implementation details:
+
+On x86_64, KCFI type identifiers are emitted as a @code{movl $ID, %eax}
+instruction before the function entry.  The implementation ensures that
+type IDs never collide with ENDBR instruction encodings.  When used
+with @option{-fpatchable-function-entry}, the type identifier is
+placed before any patchable NOPs, with appropriate alignment to maintain
+the alignment specified by @code{-falign-functions}.  KCFI automatically
+implies @option{-mindirect-branch-register}, forcing all indirect calls
+and jumps to use registers instead of memory operands.  The runtime
+check loads the type ID from the target function into @code{%r10d} and
+uses an @code{addl} instruction to add the negative expected type ID,
+effectively zeroing the register if the types match.  A conditional
+jump follows to either continue execution or trap on mismatch.  The
+check sequence uses @code{%r10d} and @code{%r11d} as scratch registers.
+Trap locations are recorded in a special @code{.kcfi_traps} section
+that maps trap sites to their corresponding function entry points,
+enabling debuggers and crash handlers to identify KCFI violations.
+The exact instruction sequences for both the KCFI preamble and the
+check-call bundle are considered ABI, as the Linux kernel may
+optionally rewrite these areas at boot time to mitigate detected CPU
+errata.
+
+The @code{-fsanitize-kcfi-arity} option encodes the function arity
+(i.e., the number of arguments) into the @code{movl $ID, $REG} instruction,
+where the @code{$REG} encodes the function arity.  This allows users, such
+as FineIBT to generate code in the kernel that is aware of how many register
+arguments a function takes.  The encoding is as follows:
+
+@multitable @columnfractions 0.10 0.50 0.40
+@headitem Arity @tab Description @tab Register
+@item 0 @tab 0 parameters @tab @code{EAX}
+@item 1 @tab 1 parameter in RDI @tab @code{ECX}
+@item 2 @tab 2 parameters in RDI and RSI @tab @code{EDX}
+@item 3 @tab 3 parameters in RDI, RSI, and RDX @tab @code{EBX}
+@item 4 @tab 4 parameters in RDI, RSI, RDX, and RCX @tab @code{ESP}
+@item 5 @tab 5 parameters in RDI, RSI, RDX, RCX, and R8 @tab @code{EBP}
+@item 6 @tab 6 parameters in RDI, RSI, RDX, RCX, R8, and R9 @tab @code{ESI}
+@item 7 @tab At least one parameter may be passed on the stack @tab @code{EDI}
+@end multitable
+
+For example, if a function `foo` takes 3 register arguments, the KCFI
+header MOVri instruction would become something like this:
+
+@code{movl    $199571451, %ebx	# hash of foo's type = 0xBE537FB}
+
 KCFI is intended primarily for kernel code and may not be suitable
 for user-space applications that rely on techniques incompatible
 with strict type checking of indirect calls.
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
index 7c1cff986c01..7c59921e630c 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
@@ -46,4 +46,21 @@ __attribute__((noinline)) void test_conditional_call(int flag) {
     }
 }
 
+/*
+** test_complex_args: { target x86_64-*-* }
+** ...
+** movl	\$-?[0-9]+, %r10d
+** addl	-4\((%r[a-z0-9]+)\), %r10d
+** je	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ud2
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .long	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** jmp	\*\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
index ca833fed2971..fe0a21d26df9 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
@@ -1,5 +1,6 @@
 /* Test basic KCFI functionality - preamble generation.  */
 /* { dg-do compile } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 /* Extern function declarations - should NOT get KCFI preambles.  */
 extern void external_func(void);
@@ -55,6 +56,26 @@ int main() {
 /* Function with nocf_check attribute should NOT have preamble.  */
 /* { dg-final { scan-assembler-not {__cfi_nocf_check_function:} } } */
 
+/* x86_64: Verify type ID in preamble (after NOPs, before function label) */
+/* { dg-final { scan-assembler {__cfi_regular_function:\n\t+nop\n.*\n\t+movl\t+\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
+
+/*
+** static_caller: { target x86_64-*-* }
+** ...
+** movl	\$-?[0-9]+, %r10d
+** addl	-4\((%r[a-z0-9]+)\), %r10d
+** je	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ud2
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .long	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** call	\*\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
 
 /* Extern functions should NOT get KCFI preambles.  */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
index f72344f77124..05165f0e2851 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
@@ -59,3 +59,18 @@ int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *
    Should see:
    1. KCFI check for is_visible call with is_visible type ID A.
    2. KCFI check for is_bin_visible and is_bin_visible_again call with type ID B.  */
+
+/* Verify we have TWO different KCFI check sequences.  */
+/* Each check should have different type ID constants.  */
+/* x86: { dg-final { scan-assembler-times {movl\s+\$-?[0-9]+,\s+%r10d} 2 { target i?86-*-* x86_64-*-* } } } */
+
+/* Verify the checks use DIFFERENT type IDs (not shared).
+   We should NOT see the same type ID used twice - that would indicate
+   unmerged sharing.  */
+/* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*movl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
+
+/* Verify expected number of traps.  */
+/* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_64-*-* } } } */
+
+/* Verify 2 separate call sites.  */
+/* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { target i?86-*-* x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
index c48b8d7ad552..ed415033c5c9 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
@@ -128,4 +128,22 @@ int main() {
     return result;
 }
 
+/* Standard KCFI handling.  */
+/*
+** test_struct_members: { target x86_64-*-* }
+** ...
+** movl	\$-?[0-9]+, %r10d
+** addl	-4\((%r[a-z0-9]+)\), %r10d
+** je	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ud2
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .long	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** call	\*\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
index 4fce0771a55d..cda9bf6c82b8 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
@@ -26,3 +26,4 @@ void caller(int sel, void (*ip)(int), int x) {
 
 /* Per-arch dg-final patterns are added by each arch's KCFI implementation
    commit; the invariant is "exactly one typeid load = one indirect call".  */
+/* { dg-final { scan-assembler-times {addl\t-4\(%r[a-z0-9]+\), %r10d} 1 { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
index 7d58fef3f920..5553ff47174b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
@@ -38,4 +38,23 @@ int main(void)
     return 0;
 }
 
+/*
+** indirect_call: { target x86_64-*-* }
+** ...
+** movq	%rdi, (%rax)
+** movl	\$called_count, %edi
+** movl	\$-?[0-9]+, %r10d
+** addl	-4\(\1\), %r10d
+** je	.Lkcfi_call([0-9]+)
+** .Lkcfi_trap([0-9]+):
+** ud2
+** .section	.kcfi_traps,"ao",@progbits,.text
+** .Lkcfi_entry([0-9]+):
+** .long	.Lkcfi_trap\3-.Lkcfi_entry\4
+** .text
+** .Lkcfi_call\2:
+** jmp	\*\1
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
index 4a90390d1934..9ed7e21fe8eb 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
@@ -72,3 +72,14 @@ int main(void)
 
     return 0;
 }
+
+/* Verify correct number of KCFI checks: exactly 2 */
+/* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } */
+
+/* Positive controls: these should have KCFI checks.  */
+/* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_function} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {wrap_normal_inline:.*ud2.*\.size\s+wrap_normal_inline} { target x86_64-*-* } } } */
+
+/* Negative controls: these should NOT have KCFI checks.  */
+/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ud2.*\.size\s+wrap_sensitive_inline} { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
index 124d26488635..95a8e8419e00 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
@@ -29,3 +29,8 @@ int main() {
 /* { dg-final { scan-assembler "__cfi_caller_with_checks:" } } */
 /* { dg-final { scan-assembler "__cfi_caller_no_checks:" } } */
 /* { dg-final { scan-assembler "__cfi_main:" } } */
+
+/* caller_with_checks() should generate KCFI check.
+   caller_no_checks() should NOT generate KCFI check (no_sanitize).
+   So a total of exactly 1 KCFI check in the entire program.  */
+/* { dg-final { scan-assembler-times {addl\t-4\(%r[ad]x\), %r1[01]d} 1 { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
index 213a1a2892a5..97d964feebd3 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
@@ -1,5 +1,6 @@
 /* Test KCFI call-site offset validation across architectures.  */
 /* { dg-do compile } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 void target_func_a(void) { }
 void target_func_b(int x) { }
@@ -22,3 +23,7 @@ int main() {
 /* { dg-final { scan-assembler "__cfi_target_func_a:" } } */
 /* { dg-final { scan-assembler "__cfi_target_func_b:" } } */
 /* { dg-final { scan-assembler "__cfi_target_func_c:" } } */
+
+/* x86_64: All call sites should use -4 offset for KCFI type ID loads, even
+   with -falign-functions=16 (we're not using patchable entries here).  */
+/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
index a6a2f4816fef..379356385a16 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
@@ -1,6 +1,7 @@
 /* Test KCFI with patchable function entries - entry NOPs only.  */
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=4,0" } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 void test_function(void) {
 }
@@ -11,4 +12,27 @@ int main() {
     return 0;
 }
 
+/*
+** __cfi_test_function: { target x86_64-*-* }
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** movl	\$0x[0-9a-f]+, %eax
+*/
+
+/*
+** main: { target x86_64-*-* }
+** ...
+** addl	-4\(%r[a-z0-9]+\), %r10d
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
index 8c4ec30cecc5..06df3495bb23 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
@@ -1,6 +1,7 @@
 /* Test KCFI with large patchable function entries.  */
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=11,11" } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 void test_function(void) {
 }
@@ -11,4 +12,16 @@ int main() {
     return 0;
 }
 
+/*
+** __cfi_test_function: { target x86_64-*-* }
+** movl	\$0x[0-9a-f]+, %eax
+*/
+
+/*
+** main: { target x86_64-*-* }
+** ...
+** addl	-15\(%r[a-z0-9]+\), %r10d
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
index 78a834ef2a97..ef87b135934b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
@@ -1,6 +1,7 @@
 /* Test KCFI with medium patchable function entries.  */
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=8,4" } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 void test_function(void) {
 }
@@ -11,4 +12,23 @@ int main() {
     return 0;
 }
 
+/*
+** __cfi_test_function: { target x86_64-*-* }
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** movl	\$0x[0-9a-f]+, %eax
+*/
+
+/*
+** main: { target x86_64-*-* }
+** ...
+** addl	-8\(%r[a-z0-9]+\), %r10d
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
index 1a4d8269ed56..872814aa4171 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
@@ -1,6 +1,7 @@
 /* Test KCFI with patchable function entries - prefix NOPs only.  */
 /* { dg-do compile } */
 /* { dg-additional-options "-fpatchable-function-entry=3,3" } */
+/* { dg-additional-options "-falign-functions=16" { target x86_64-*-* } } */
 
 void test_function(void) {
 }
@@ -11,4 +12,24 @@ int main() {
     return 0;
 }
 
+/*
+** __cfi_test_function: { target x86_64-*-* }
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** nop
+** movl	\$0x[0-9a-f]+, %eax
+*/
+
+/*
+** main: { target x86_64-*-* }
+** ...
+** addl	-7\(%r[a-z0-9]+\), %r10d
+** ...
+*/
+
 /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
index 9ddf178aa2b1..04a9eb1fd206 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
@@ -58,3 +58,23 @@ int test_non_tail_indirect_call(func_ptr_t handler, int x) {
 /* { dg-final { scan-assembler-times "__cfi_test_param_indirect_call:" 1 } } */
 /* { dg-final { scan-assembler-times "__cfi_test_void_indirect_call:" 1 } } */
 /* { dg-final { scan-assembler-times "__cfi_test_non_tail_indirect_call:" 1 } } */
+
+/* Should have exactly 4 KCFI checks for indirect calls as
+   (load type ID + compare).  */
+/* { dg-final { scan-assembler-times {movl\t\$-?[0-9]+, %r10d} 4 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {addl\t-4\(%r[a-z0-9]+\), %r10d} 4 { target x86_64-*-* } } } */
+
+/* Should have exactly 4 trap sections and 4 trap instructions.  */
+/* { dg-final { scan-assembler-times "\\.kcfi_traps" 4 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times "ud2" 4 { target x86_64-*-* } } } */
+
+/* Should NOT have unprotected direct jumps to vtable.  */
+/* { dg-final { scan-assembler-not {jmp\t\*vtable\(%rip\)} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-not {jmp\t\*vtable\+8\(%rip\)} { target x86_64-*-* } } } */
+
+/* Should have exactly 3 protected tail calls (jmp through register after
+   KCFI check).  */
+/* { dg-final { scan-assembler-times {jmp\t\*%[a-z0-9]+} 3 { target x86_64-*-* } } } */
+
+/* Should have exactly 1 regular call (non-tail call case).  */
+/* { dg-final { scan-assembler-times {call\t\*%[a-z0-9]+} 1 { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section-per-func.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section-per-func.c
new file mode 100644
index 000000000000..448805a37808
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section-per-func.c
@@ -0,0 +1,23 @@
+/* The .kcfi_traps section is SHF_LINK_ORDER and must be tied to the
+   containing function's own text section, not the generic .text.  When it
+   links to the generic .text, building with -ffunction-sections and
+   -Wl,--gc-sections silently drops the entire .kcfi_traps section (losing all
+   KCFI trap metadata, even for retained functions), because the empty generic
+   .text is garbage-collected and the link-ordered section goes with it.
+
+   Only x86_64 and RISC-V use a .kcfi_traps section; AArch64 and ARM encode the
+   trap information directly in the trap instruction's immediate.  */
+
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-ffunction-sections" } */
+
+typedef int (*fn_t) (int);
+volatile fn_t ptr;
+
+int caller (int x) { return ptr (x); }
+
+/* Under -ffunction-sections the link-ordered target must be the function's
+   own text section (.text.caller), not the generic .text (which would be
+   garbage-collected, dropping the trap metadata).  */
+/* { dg-final { scan-assembler {\.kcfi_traps,"ao",@progbits,\.text\.caller\n} } } */
+/* { dg-final { scan-assembler-not {\.kcfi_traps,"ao",@progbits,\.text\n} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
index 6d34ad6e1a0c..55c0829ccd7b 100644
--- a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
@@ -15,3 +15,9 @@ int main() {
 
 /* Should have KCFI preamble.  */
 /* { dg-final { scan-assembler "__cfi_target_function:" } } */
+
+/* Should have exactly 2 trap labels in code.  */
+/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ud2} 2 { target x86_64-*-* } } } */
+
+/* x86_64 should exactly 2 .kcfi_traps sections.  */
+/* { dg-final { scan-assembler-times {\.section\t\.kcfi_traps,"ao",@progbits,\.text} 2 { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c
new file mode 100644
index 000000000000..3bbceb2925c5
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c
@@ -0,0 +1,7 @@
+/* Test that KCFI is rejected for 32-bit x86.  */
+/* { dg-do compile { target i?86-*-* x86_64-*-* } } */
+/* { dg-additional-options "-m32" } */
+/* { dg-error ".-fsanitize=kcfi. is not supported for 32-bit x86 or x32 mode" "" { target *-*-* } 0 } */
+/* { dg-message "sorry, unimplemented: .-fsanitize=kcfi. not supported" "" { target *-*-* } 0 } */
+
+void foo (void) { }
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
new file mode 100644
index 000000000000..446ce1bf514e
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
@@ -0,0 +1,93 @@
+/* Test KCFI -fsanitize-kcfi-arity - preamble generation */
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-O2 -fsanitize-kcfi-arity" } */
+
+void regular_function(int x) {
+    /* This should get KCFI preamble */
+}
+
+/* These functions should get a KCFI arity corresponing to the number of
+   parameter.
+
+   On x86-64, the mov instruction in the preamble encodes the arity in the
+   used immediate register, as follows:
+
+	Arity	Description			Encoding in reg field
+	0	0 parameters			EAX
+	1	1 parameter in RDI		ECX
+	2	2 parameters in RDI 		EDX
+		  and RSI
+	3	3 parameters in RDI, 		EBX
+		  RSI, and RDX
+	4	4 parameters in RDI,		ESP
+		  RSI, RDX, and RCX
+	5	5 parameters in RDI,		EBP
+		  RSI, RDX, RCX, and R8
+	6	6 parameters in RDI, 		ESI
+		  RSI, RDX, RCX, R8, and R9
+	7	At least one parameter		EDI
+		  may be passed on the stack
+*/
+void ind_fn_00(void) {}
+void ind_fn_01(int) {}
+void ind_fn_02(int, int) {}
+void ind_fn_03(int, int, int) {}
+void ind_fn_04(int, int, int, int) {}
+void ind_fn_05(int, int, int, int, int) {}
+void ind_fn_06(int, int, int, int, int, int) {}
+/* Arguments on stack arity from here on should be 7.  */
+void ind_fn_07(int, int, int, int, int, int, int) {}
+void ind_fn_08(int, int, int, int, int, int, int, int) {}
+
+void ind_fn_float_01(int, float) {}
+void ind_fn_float_03(int, int, float, float, float) {}
+
+void (*func_ptr_00)(void) = ind_fn_00;
+void (*func_ptr_01)(int) = ind_fn_01;
+void (*func_ptr_02)(int, int) = ind_fn_02;
+void (*func_ptr_03)(int, int, int) = ind_fn_03;
+void (*func_ptr_04)(int, int, int, int) = ind_fn_04;
+void (*func_ptr_05)(int, int, int, int, int) = ind_fn_05;
+void (*func_ptr_06)(int, int, int, int, int, int) = ind_fn_06;
+void (*func_ptr_07)(int, int, int, int, int, int, int) = ind_fn_07;
+void (*func_ptr_08)(int, int, int, int, int, int, int, int) = ind_fn_08;
+
+
+void (*func_ptr_float_01)(int, float) = ind_fn_float_01;
+void (*func_ptr_float_03)(int, int, float, float, float) = ind_fn_float_03;
+
+int main() {
+    /* Function arity tests.  */
+    func_ptr_00();
+    func_ptr_01(1);
+    func_ptr_02(1, 1);
+    func_ptr_03(1, 1, 1);
+    func_ptr_04(1, 1, 1, 1);
+    func_ptr_05(1, 1, 1, 1, 1);
+    func_ptr_06(1, 1, 1, 1, 1, 1);
+
+    /* Both of these put arguments on the stack so both get arity 7.  */
+    func_ptr_07(1, 1, 1, 1, 1, 1, 1);
+    func_ptr_08(1, 1, 1, 1, 1, 1, 1, 1);
+
+    /* Float parameters should not be counted for arity.  */
+    func_ptr_float_01(1, 1.0);
+    func_ptr_float_03(1, 1, 0.5, 0.5, 0.5);
+
+    return 0;
+}
+
+/* x86_64: Verify arity immediate register encoding in preamble.  */
+/* { dg-final { scan-assembler {__cfi_ind_fn_00:.*\n\tmovl\t+\$0x[0-9a-f]+, %eax\n.*\nind_fn_00:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_01:.*\n\tmovl\t+\$0x[0-9a-f]+, %ecx\n.*\nind_fn_01:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_02:.*\n\tmovl\t+\$0x[0-9a-f]+, %edx\n.*\nind_fn_02:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_03:.*\n\tmovl\t+\$0x[0-9a-f]+, %ebx\n.*\nind_fn_03:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_04:.*\n\tmovl\t+\$0x[0-9a-f]+, %esp\n.*\nind_fn_04:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_05:.*\n\tmovl\t+\$0x[0-9a-f]+, %ebp\n.*\nind_fn_05:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_06:.*\n\tmovl\t+\$0x[0-9a-f]+, %esi\n.*\nind_fn_06:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_07:.*\n\tmovl\t+\$0x[0-9a-f]+, %edi\n.*\nind_fn_07:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_08:.*\n\tmovl\t+\$0x[0-9a-f]+, %edi\n.*\nind_fn_08:} { target x86_64-*-* } } } */
+
+/* x86_64: Verify arity is not affected by SSE registers.  */
+/* { dg-final { scan-assembler {__cfi_ind_fn_float_01:.*\n\tmovl\t+\$0x[0-9a-f]+, %ecx\n.*\nind_fn_float_01:} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {__cfi_ind_fn_float_03:.*\n\tmovl\t+\$0x[0-9a-f]+, %edx\n.*\nind_fn_float_03:} { target x86_64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-endbr-collision.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-endbr-collision.c
new file mode 100644
index 000000000000..ead04a66488c
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-endbr-collision.c
@@ -0,0 +1,55 @@
+/* Verify the x86 KCFI type-id ENDBR avoidance appears in output.  A type
+   whose raw KCFI type-id happens to equal an ENDBR instruction encoding
+   must have that id bumped by one, so the value stored in the __cfi_
+   preamble can never be mistaken for a CET landing pad.  This matches
+   Clang's KCFI ABI (both ENDBR encodings, unconditionally), and exactly
+   those two 32-bit values are adjusted. E.g. the +/-1 neighbours of each
+   are left alone.  */
+
+/* { dg-do compile { target { x86_64-*-* && lp64 } } } */
+/* { dg-additional-options "-O2" } */
+
+/* For the builtin, "void(*)(struct TAG)" should hash to RAW; only the
+   codegen should bump the type_id values on ENDBR64/32 collisions.  */
+#define KCFI_CASE(TAG, FN, RAW)						\
+  struct TAG;								\
+  typedef void FN##_ft (struct TAG *);					\
+  typedef void (*FN##_fp) (struct TAG *);				\
+  _Static_assert (__builtin_linux_abi_kcfi_hash (FN##_ft) == RAW,	\
+		  #TAG " no longer hashes as expected; regenerate it");	\
+  void FN (struct TAG *q) { (void) q; }					\
+  static volatile FN##_fp FN##_p;
+
+KCFI_CASE (jbjNNf, e64_lo, 0xfa1e0ff2U)   /* ENDBR64 - 1 */
+KCFI_CASE (gVAv_j, e64,    0xfa1e0ff3U)   /* ENDBR64     */
+KCFI_CASE (thNpCa, e64_hi, 0xfa1e0ff4U)   /* ENDBR64 + 1 */
+KCFI_CASE (M6uRHd, e32_lo, 0xfb1e0ff2U)   /* ENDBR32 - 1 */
+KCFI_CASE (Q0UXLa, e32,    0xfb1e0ff3U)   /* ENDBR32     */
+KCFI_CASE (uev20d, e32_hi, 0xfb1e0ff4U)   /* ENDBR32 + 1 */
+
+/* volatile keeps the calls indirect, so each target is address-taken.  */
+#define KCFI_USE(FN) FN##_p = FN; FN##_p (0)
+
+void
+run (void)
+{
+  KCFI_USE (e64_lo);
+  KCFI_USE (e64);
+  KCFI_USE (e64_hi);
+  KCFI_USE (e32_lo);
+  KCFI_USE (e32);
+  KCFI_USE (e32_hi);
+}
+
+/* Neither ENDBR encoding is ever stored as a type-id (both were bumped away).  */
+/* { dg-final { scan-assembler-not {\tmovl\t\$0xfa1e0ff3, %eax} } } */
+/* { dg-final { scan-assembler-not {\tmovl\t\$0xfb1e0ff3, %eax} } } */
+
+/* Each ENDBR value lands on its +1 (0xfa1e0ff4 / 0xfb1e0ff4), joining the
+   upper neighbour that already had that value; each appears exactly twice.  */
+/* { dg-final { scan-assembler-times {\tmovl\t\$0xfa1e0ff4, %eax} 2 } } */
+/* { dg-final { scan-assembler-times {\tmovl\t\$0xfb1e0ff4, %eax} 2 } } */
+
+/* The lower neighbours are stored unchanged; each appear exactly once.  */
+/* { dg-final { scan-assembler-times {\tmovl\t\$0xfa1e0ff2, %eax} 1 } } */
+/* { dg-final { scan-assembler-times {\tmovl\t\$0xfb1e0ff2, %eax} 1 } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
new file mode 100644
index 000000000000..d0879d161599
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
@@ -0,0 +1,7 @@
+/* Test that KCFI is incompatible with -ffixed-r10 on x86_64.  */
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-ffixed-r10" } */
+/* { dg-error ".-fsanitize=kcfi. is not compatible with .-ffixed-r10. or .-ffixed-r11. as KCFI requires these registers for type checking" "" { target *-*-* } 0 } */
+/* { dg-message "sorry, unimplemented: .-fsanitize=kcfi. not supported" "" { target *-*-* } 0 } */
+
+void foo (void) { }
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
new file mode 100644
index 000000000000..465f2cad6285
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
@@ -0,0 +1,7 @@
+/* Test that KCFI is incompatible with -ffixed-r11 on x86_64.  */
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-ffixed-r11" } */
+/* { dg-error ".-fsanitize=kcfi. is not compatible with .-ffixed-r10. or .-ffixed-r11. as KCFI requires these registers for type checking" "" { target *-*-* } 0 } */
+/* { dg-message "sorry, unimplemented: .-fsanitize=kcfi. not supported" "" { target *-*-* } 0 } */
+
+void foo (void) { }
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
new file mode 100644
index 000000000000..056068b4f197
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
@@ -0,0 +1,40 @@
+/* Test KCFI with retpoline thunk-extern flag forces r11 usage.  */
+/* { dg-do compile { target x86_64-*-* } } */
+/* { dg-additional-options "-O2 -mindirect-branch=thunk-extern" } */
+
+extern int external_target(void);
+
+/* Test regular call (not tail call) */
+__attribute__((noinline))
+int call_test(int (*func_ptr)(void)) {
+    /* This indirect call should use r11 when both KCFI and
+       -mindirect-branch=thunk-extern are enabled.  */
+    int result = func_ptr();  /* Function parameter prevents direct optimization.  */
+    return result + 1;  /* Prevent tail call optimization.  */
+}
+
+/* Reference external_target to generate the required symbol.  */
+int (*external_func_ptr)(void) = external_target;
+
+/* Test function for sibcalls (tail calls) */
+__attribute__((noinline))
+void sibcall_test(int (**func_ptr)(void)) {
+    /* This sibcall should use r11 when both KCFI and
+       -mindirect-branch=thunk-extern are enabled.  */
+    (*func_ptr)();  /* Tail call - should be optimized to sibcall.  */
+}
+
+/* Should have weak symbol for external function.  */
+/* { dg-final { scan-assembler "__kcfi_typeid_external_target" } } */
+
+/* When both KCFI and -mindirect-branch=thunk-extern are enabled,
+   indirect calls should always use r11 register and convert to extern thunks.  */
+/* { dg-final { scan-assembler-times {call\s+} 1 } } */
+/* { dg-final { scan-assembler-times {call\s+__x86_indirect_thunk_r11} 1 } } */
+
+/* Sibcalls should also use r11 register and convert to extern thunks.  */
+/* { dg-final { scan-assembler-times {jmp\s+} 1 } } */
+/* { dg-final { scan-assembler-times {jmp\s+__x86_indirect_thunk_r11} 1 } } */
+
+/* Should have exactly 2 KCFI traps (one per function) */
+/* { dg-final { scan-assembler-times {ud2} 2 } } */
diff --git a/gcc/common.opt b/gcc/common.opt
index 69a55b8d40d6..1dde799a932c 100644
--- a/gcc/common.opt
+++ b/gcc/common.opt
@@ -1165,6 +1165,14 @@ Enum(sanitize_coverage) String(trace-pc) Value(SANITIZE_COV_TRACE_PC)
 EnumValue
 Enum(sanitize_coverage) String(trace-cmp) Value(SANITIZE_COV_TRACE_CMP)
 
+fsanitize-kcfi-arity
+Common Driver Var(flag_sanitize_kcfi_arity)
+For supported targets, this feature extends kCFI by telling the compiler
+to record information about each indirect-callable function’s
+arity (i.e., the number of arguments passed in registers) into the
+binary.  Some kernel CFI techniques, such as FineIBT, may be able to use
+this information to provide enhanced security.
+
 fasan-shadow-offset=
 Common Joined RejectNegative Var(common_deferred_options) Defer
 -fasan-shadow-offset=<number>	Use custom shadow memory offset.
diff --git a/gcc/opts.cc b/gcc/opts.cc
index ad1fd54d2792..6382550110ac 100644
--- a/gcc/opts.cc
+++ b/gcc/opts.cc
@@ -2853,6 +2853,7 @@ common_handle_option (struct gcc_options *opts,
 	  SET_OPTION_IF_UNSET (opts, opts_set, param_asan_stack, 0);
 	  SET_OPTION_IF_UNSET (opts, opts_set, param_asan_protect_allocas, 0);
 	  SET_OPTION_IF_UNSET (opts, opts_set, param_asan_use_after_return, 0);
+	  SET_OPTION_IF_UNSET (opts, opts_set, flag_sanitize_kcfi_arity, 0);
 	}
       if (opts->x_flag_sanitize & SANITIZE_KERNEL_HWADDRESS)
 	{
-- 
2.55.0

