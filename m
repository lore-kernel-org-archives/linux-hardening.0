Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728117E4
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763685024; cv=none; b=BCwfP3JF5JPbnujUew723KSd6c90gj8AA5n5ld6b0wZ4wdtpQmENzRCTqwROZo/BkfyN+88RVfbwbXhSax4tV1wVnDUydy81iCL4H22ZcFrtpTuIYnTEQGkVzXIOLkqQ3fuZ8jV4KOAp08tYUyZ7bR2cnk0wNQua+d4qiyWH7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763685024; c=relaxed/simple;
	bh=UxGPs9NXV2Zq8T0BxheOEhOKdsdA64l2y29IEUzVVxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4BKsHBZPhV6a/X52KDucnI1Yqrg4yShbsh5qxdyLGTcdQy7jwgww3z/fezh5V3yHKDWmWxMr2pI+76a8LsjrzfnBa/oO7sivxI7wo4vH+OPPOJX/cn/Um/v+hGezO1fxPzACbSIXsMXZUzTI2qqx4Ta3/mp1oqC0ouf+uEYM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA8po2TS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA8po2TS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0A4C4CEF1;
	Fri, 21 Nov 2025 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763685024;
	bh=UxGPs9NXV2Zq8T0BxheOEhOKdsdA64l2y29IEUzVVxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kA8po2TSSCsNsIfbrWD1yugYWZXeTknTpgBZtP1E7GbjfRX7OcZYqQN7Ep+EtzXBU
	 7LTckBKYp1Pzzwi3/FbfodM650isB4+t46E8oy4ZuxHz2OeNgkO3o6BxrmdD8e67E6
	 PYZSltVyTJa2QehRyfpJT609koPNVCZoVBw1FyEGq7a90DlAqKjV8+dKfwzrP+CRSj
	 wZ5PpnFLWd1uzGwnKcN0qsHBo1GeenaXD4SZkN/GQc9D8Lf19k8X1RG7J/R0ca4bUP
	 N/J0mh+51CYysxCXz9usTldlNP6wAojzPXxOyiBIF0rUDAlypobeA0Y+kCIR+pT/zC
	 vnN0oQxVYWAfA==
Date: Thu, 20 Nov 2025 16:30:23 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
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
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 5/7] aarch64: Add AArch64 Kernel Control Flow
 Integrity implementation
Message-ID: <202511201624.02B217623C@keescook>
References: <20251120222105.us.687-kees@kernel.org>
 <20251120222113.3318463-5-kees@kernel.org>
 <CALvbMcCx+N=P+AkpTbwQBanDTRWi+VsouoxyMLPEfOfEmNZaow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcCx+N=P+AkpTbwQBanDTRWi+VsouoxyMLPEfOfEmNZaow@mail.gmail.com>

On Thu, Nov 20, 2025 at 02:57:49PM -0800, Andrew Pinski wrote:
> On Thu, Nov 20, 2025 at 2:29 PM Kees Cook <kees@kernel.org> wrote:
> >
> > Implement AArch64-specific KCFI backend.
> >
> > - Trap debugging through ESR (Exception Syndrome Register) encoding
> >   in BRK instruction immediate values.
> >
> > - Scratch register allocation using w16/w17 (x16/x17) following
> >   AArch64 procedure call standard for intra-procedure-call registers,
> >   which already makes x16/x17 available through existing clobbers.
> >
> > - Complementary with BTI (which uses a separate pass system to inject
> >   landing instructions where needed).
> >
> > - Does not interfere with SME, which uses attributes not function
> >   prototypes for distinguishing functions.
> >
> > Assembly Code Pattern for AArch64:
> >   ldur w16, [target, #-4]       ; Load actual type ID from preamble
> >   mov  w17, #type_id_low        ; Load expected type (lower 16 bits)
> >   movk w17, #type_id_high, lsl #16  ; Load upper 16 bits if needed
> >   cmp  w16, w17                 ; Compare type IDs directly
> >   b.eq .Lpass                   ; Branch if types match
> >   .Ltrap: brk #esr_value        ; Enhanced trap with register info
> >   .Lpass: blr/br target         ; Execute validated indirect transfer
> >
> > ESR (Exception Syndrome Register) Integration:
> > - BRK instruction immediate encoding format:
> >   0x8000 | ((TypeIndex & 31) << 5) | (AddrIndex & 31)
> >   - TypeIndex indicates which W register contains expected type (W17 = 17)
> >   - AddrIndex indicates which X register contains target address (0-30)
> >   - Example: brk #33313 (0x8221) = expected type in W17, target address in X1
> >
> > Build and run tested with Linux kernel ARCH=arm64.
> >
> > gcc/ChangeLog:
> >
> >         config/aarch64/aarch64-protos.h: Declare aarch64_indirect_branch_asm,
> >         and KCFI helpers.
> >         config/aarch64/aarch64.cc (aarch64_expand_call): Wrap CALLs in
> >         KCFI, with clobbers.
> >         (aarch64_indirect_branch_asm): New function, extract common
> >         logic for branch asm, like existing call asm helper.
> >         (aarch64_output_kcfi_insn): Emit KCFI assembly.
> >         config/aarch64/aarch64.md: Add KCFI RTL patterns and replace
> >         open-coded branch emission with aarch64_indirect_branch_asm.
> >         doc/invoke.texi: Document aarch64 nuances.
> >
> > gcc/testsuite/ChangeLog:
> >
> >         * gcc.dg/kcfi/kcfi-adjacency.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-basics.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-call-sharing.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-complex-addressing.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-move-preservation.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-no-sanitize.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-offset-validation.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-patchable-large.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-patchable-medium.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-tail-calls.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-trap-section.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-trap-encoding.c: New test.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  gcc/config/aarch64/aarch64-protos.h           |   5 +
> >  gcc/config/aarch64/aarch64.md                 |  66 +++++++++--
> >  gcc/config/aarch64/aarch64.cc                 | 105 ++++++++++++++++++
> >  gcc/doc/invoke.texi                           |  14 +++
> >  gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  15 +++
> >  gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  21 ++++
> >  gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |   4 +
> >  .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  16 +++
> >  .../gcc.dg/kcfi/kcfi-move-preservation.c      |  20 ++++
> >  .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |   5 +
> >  gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   1 +
> >  .../gcc.dg/kcfi/kcfi-offset-validation.c      |   3 +
> >  .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  12 ++
> >  .../gcc.dg/kcfi/kcfi-patchable-large.c        |  12 ++
> >  .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  12 ++
> >  .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  12 ++
> >  gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  19 ++++
> >  .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  41 +++++++
> >  gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   4 +
> >  19 files changed, 379 insertions(+), 8 deletions(-)
> >  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
> >
> > diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aarch64-protos.h
> > index a9e407ba340e..c32d454fe277 100644
> > --- a/gcc/config/aarch64/aarch64-protos.h
> > +++ b/gcc/config/aarch64/aarch64-protos.h
> > @@ -1272,6 +1272,7 @@ tree aarch64_resolve_overloaded_builtin_general (location_t, tree, void *);
> >
> >  const char *aarch64_sls_barrier (int);
> >  const char *aarch64_indirect_call_asm (rtx);
> > +const char *aarch64_indirect_branch_asm (rtx);
> >  extern bool aarch64_harden_sls_retbr_p (void);
> >  extern bool aarch64_harden_sls_blr_p (void);
> >
> > @@ -1295,4 +1296,8 @@ extern unsigned aarch64_stack_alignment (const_tree exp, unsigned align);
> >  extern rtx aarch64_gen_compare_zero_and_branch (rtx_code code, rtx x,
> >                                                 rtx_code_label *label);
> >
> > +/* KCFI support.  */
> > +extern void kcfi_emit_trap_with_section (FILE *file, rtx trap_label_rtx);
> > +extern const char *aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands);
> > +
> >  #endif /* GCC_AARCH64_PROTOS_H */
> > diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.md
> > index 855df791bae7..84894816509c 100644
> > --- a/gcc/config/aarch64/aarch64.md
> > +++ b/gcc/config/aarch64/aarch64.md
> > @@ -1506,6 +1506,19 @@
> >    }"
> >  )
> >
> > +;; KCFI indirect call
> > +(define_insn "*call_insn"
> > +  [(kcfi (call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand" "Ucr"))
> > +              (match_operand 1 "" ""))
> > +        (match_operand 3 "const_int_operand"))
> > +   (unspec:DI [(match_operand:DI 2 "const_int_operand")] UNSPEC_CALLEE_ABI)
> > +   (clobber (reg:DI LR_REGNUM))]
> > +  "!SIBLING_CALL_P (insn)"
> > +{
> > +  return aarch64_output_kcfi_insn (insn, operands);
> > +}
> > +  [(set_attr "type" "call")])
> > +
> >  (define_insn "*call_insn"
> >    [(call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand"))
> >          (match_operand 1 "" ""))
> > @@ -1533,6 +1546,21 @@
> >    }"
> >  )
> >
> > +;; KCFI call with return value
> > +(define_insn "*call_value_insn"
> > +  [(set (match_operand 0 "" "")
> > +       (kcfi (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operand"
> > +                            "Ucr"))
> > +                   (match_operand 2 "" ""))
> > +             (match_operand 4 "const_int_operand")))
> > +   (unspec:DI [(match_operand:DI 3 "const_int_operand")] UNSPEC_CALLEE_ABI)
> > +   (clobber (reg:DI LR_REGNUM))]
> > +  "!SIBLING_CALL_P (insn)"
> > +{
> > +  return aarch64_output_kcfi_insn (insn, &operands[1]);
> > +}
> > +  [(set_attr "type" "call")])
> > +
> >  (define_insn "*call_value_insn"
> >    [(set (match_operand 0 "" "")
> >         (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operand"))
> > @@ -1573,6 +1601,19 @@
> >    }
> >  )
> >
> > +;; KCFI sibling call
> > +(define_insn "*sibcall_insn"
> > +  [(kcfi (call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand" "Ucs"))
> > +              (match_operand 1 ""))
> > +        (match_operand 3 "const_int_operand"))
> > +   (unspec:DI [(match_operand:DI 2 "const_int_operand")] UNSPEC_CALLEE_ABI)
> > +   (return)]
> > +  "SIBLING_CALL_P (insn)"
> > +{
> > +  return aarch64_output_kcfi_insn (insn, operands);
> > +}
> > +  [(set_attr "type" "branch")])
> > +
> >  (define_insn "*sibcall_insn"
> >    [(call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand" "Ucs, Usf"))
> >          (match_operand 1 ""))
> > @@ -1581,16 +1622,28 @@
> >    "SIBLING_CALL_P (insn)"
> >    {
> >      if (which_alternative == 0)
> > -      {
> > -       output_asm_insn ("br\\t%0", operands);
> > -       return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> > -      }
> > +      return aarch64_indirect_branch_asm (operands[0]);
> 
> Can you extract aarch64_indirect_branch_asm into a different patch?
> Since it is only slightly related to this.
> The main reason is because applying that can happen before the rest of
> the KFCI patches are approved. And I will handling applying that once
> it has been extracted out.

Sure! I'll extract it.

> 
> >      return "b\\t%c0";
> >    }
> >    [(set_attr "type" "branch, branch")
> >     (set_attr "sls_length" "retbr,none")]
> >  )
> >
> > +;; KCFI sibling call with return value
> > +(define_insn "*sibcall_value_insn"
> > +  [(set (match_operand 0 "")
> > +       (kcfi (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operand"
> > +                            "Ucs"))
> > +                   (match_operand 2 ""))
> > +             (match_operand 4 "const_int_operand")))
> > +   (unspec:DI [(match_operand:DI 3 "const_int_operand")] UNSPEC_CALLEE_ABI)
> > +   (return)]
> > +  "SIBLING_CALL_P (insn)"
> > +{
> > +  return aarch64_output_kcfi_insn (insn, &operands[1]);
> > +}
> > +  [(set_attr "type" "branch")])
> > +
> >  (define_insn "*sibcall_value_insn"
> >    [(set (match_operand 0 "")
> >         (call (mem:DI
> > @@ -1601,10 +1654,7 @@
> >    "SIBLING_CALL_P (insn)"
> >    {
> >      if (which_alternative == 0)
> > -      {
> > -       output_asm_insn ("br\\t%1", operands);
> > -       return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> > -      }
> > +      return aarch64_indirect_branch_asm (operands[1]);
> >      return "b\\t%c1";
> >    }
> >    [(set_attr "type" "branch, branch")
> > diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.cc
> > index 6dfdaa4fb9b0..86e3af992d2a 100644
> > --- a/gcc/config/aarch64/aarch64.cc
> > +++ b/gcc/config/aarch64/aarch64.cc
> > @@ -83,6 +83,7 @@
> >  #include "rtlanal.h"
> >  #include "tree-dfa.h"
> >  #include "asan.h"
> > +#include "kcfi.h"
> >  #include "aarch64-elf-metadata.h"
> >  #include "aarch64-feature-deps.h"
> >  #include "config/arm/aarch-common.h"
> > @@ -11965,6 +11966,16 @@ aarch64_expand_call (rtx result, rtx mem, rtx cookie, bool sibcall)
> >
> >    call = gen_rtx_CALL (VOIDmode, mem, const0_rtx);
> >
> > +  /* Only indirect calls need KCFI instrumentation.  */
> > +  bool is_direct_call = SYMBOL_REF_P (XEXP (mem, 0));
> > +  rtx kcfi_type_rtx = is_direct_call ? NULL_RTX
> > +    : kcfi_get_type_id_for_expanding_gimple_call ();
> > +  if (kcfi_type_rtx)
> > +    {
> > +      /* Wrap call in KCFI.  */
> > +      call = gen_rtx_KCFI (VOIDmode, call, kcfi_type_rtx);
> > +    }
> > +
> >    if (result != NULL_RTX)
> >      call = gen_rtx_SET (result, call);
> >
> > @@ -19225,6 +19236,9 @@ aarch64_override_options_internal (struct gcc_options *opts)
> >  #endif
> >      }
> >
> > +  if ((flag_sanitize & SANITIZE_KCFI) && TARGET_ILP32)
> > +    sorry ("%<-fsanitize=kcfi%> is not supported for %<-mabi=ilp32%>");
> > +
> >    aarch64_feature_flags isa_flags = aarch64_get_isa_flags (opts);
> >    if ((isa_flags & (AARCH64_FL_SM_ON | AARCH64_FL_ZA_ON))
> >        && !(isa_flags & AARCH64_FL_SME))
> > @@ -30822,6 +30836,18 @@ aarch64_indirect_call_asm (rtx addr)
> >    return "";
> >  }
> >
> > +/* Generate assembly for AArch64 indirect branch instruction.  ADDR is the
> > +   target address register.  Returns any additional barrier instructions
> > +   needed for SLS (Straight Line Speculation) mitigation.  */
> > +
> > +const char *
> > +aarch64_indirect_branch_asm (rtx addr)
> > +{
> > +  gcc_assert (REG_P (addr));
> > +  output_asm_insn ("br\t%0", &addr);
> > +  return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> > +}
> > +
> >  /* Emit the assembly instruction to load the thread pointer into DEST.
> >     Select between different tpidr_elN registers depending on -mtp= setting.  */
> >
> > @@ -33089,6 +33115,85 @@ aarch64_libgcc_floating_mode_supported_p
> >  #undef TARGET_DOCUMENTATION_NAME
> >  #define TARGET_DOCUMENTATION_NAME "AArch64"
> >
> > +/* Output the assembly for a KCFI checked call instruction.  INSN is the
> > +   RTL instruction being processed.  OPERANDS is the array of RTL operands
> > +   where operands[0] is the call target register, operands[3] is the KCFI
> > +   type ID constant.  Returns the appropriate call instruction string.  */
> > +
> > +const char *
> > +aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> > +{
> > +  /* Target register is operands[0].  */
> > +  rtx target_reg = operands[0];
> > +  gcc_assert (REG_P (target_reg));
> > +
> > +  /* Get KCFI type ID from operand[3].  */
> > +  uint32_t type_id = (uint32_t) INTVAL (operands[3]);
> > +
> > +  /* Calculate typeid offset from call target.  */
> > +  HOST_WIDE_INT offset = -kcfi_get_typeid_offset ();
> > +
> > +  /* Get unique label number for this KCFI check.  */
> > +  int labelno = kcfi_next_labelno ();
> > +
> > +  /* Generate custom label names.  */
> > +  char trap_name[32];
> > +  char call_name[32];
> > +  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", labelno);
> > +  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", labelno);
> > +
> > +  rtx temp_operands[3];
> > +
> > +  /* Load actual type into w16 from memory at offset using ldur.  */
> > +  temp_operands[0] = gen_rtx_REG (SImode, R16_REGNUM);
> > +  temp_operands[1] = target_reg;
> > +  temp_operands[2] = GEN_INT (offset);
> > +  output_asm_insn ("ldur\t%w0, [%1, #%2]", temp_operands);
> 
> Why not just:
>   temp_operands[0] = target_reg;
>   temp_operands[0] = GEN_INT (offset);
>   output_asm_insn ("ldur\tw16, [%0, #%1]", temp_operands);

Oops, yes. I have rewritten these handlers so many times I've lost my
mind. :)

> 
> > +
> > +  /* Load expected type low 16 bits into w17.  */
> > +  temp_operands[0] = gen_rtx_REG (SImode, R17_REGNUM);
> > +  temp_operands[1] = GEN_INT (type_id & 0xFFFF);
> > +  output_asm_insn ("mov\t%w0, #%1", temp_operands);
> Likewise.
> Also why not use fprintf here?
> Like:
> fprintf(asm_out_file, "mov\t%w0, #%d\n", type_id & 0xFFFF);

It seemed like directly using fprintf() was frowned on, and the
output_asm_insn with an operands array was the "correct" way to do all
of these? I'm happy to do it however! :)

> > +#undef TARGET_KCFI_SUPPORTED
> > +#define TARGET_KCFI_SUPPORTED hook_bool_void_true
> 
> Why return true always for it being supported? I thought this is not
> supported with ilp32, it is definitely not supported for mingw. Is it
> supported with -elf targets rather than -linux-gnu targets?

Ah, it seemed like the only place I could do the checking for ilp32,
etc was in aarch64_override_options_internal. I'll see if I can figure
out how to move that into the TARGET hooks, but all the examples I could
find where in the override_options functions...

Thanks for the review! I'll do more fixing. :)

-Kees

-- 
Kees Cook
