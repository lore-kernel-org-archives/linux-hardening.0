Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9327C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Nov 2021 22:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9268F61177
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Nov 2021 22:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhKIWFr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 9 Nov 2021 17:05:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235025AbhKIWFq (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 9 Nov 2021 17:05:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DD1961186
        for <linux-hardening@vger.kernel.org>; Tue,  9 Nov 2021 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636495380;
        bh=rSQM4NBC5ZnEIU/vlRGLOgpj6FaR5nrElIbjJ+KPNyU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BISE8R5wnKSwKWtklNxtUgn6rpmWxs6tAMmtG/ev3/BxDV/dDJVrXympI3rdPTAL/
         PruOMzvEVqu/IPHsdKXBB8LqkRKaVq0q34QaZ2Xu+JdruyC+gcaAQEjp/qphqcprC9
         +dos4G0byT3UE2seyzWE0/ANuTMTvhtMhSd92t+3kAyhVQN77eDjPw1/I+NrywII9W
         ChPvP7THhd/PMkesCIFnGYe10ADcyO8lWdnTDoYRTGjxs/EgJ6PznPTv2GTXSMIfI0
         dCXH1lPs4j1/dHPqWZMEuV36cXdT5BFtm5adcAtdvsd95ZCfbrHuFm0OalVsHeF19Z
         kWMVXK3xRMqJw==
Received: by mail-oi1-f176.google.com with SMTP id bl27so1458010oib.0
        for <linux-hardening@vger.kernel.org>; Tue, 09 Nov 2021 14:03:00 -0800 (PST)
X-Gm-Message-State: AOAM5313PAIdIdMKARvlo8jUUhcjaRelyL+pqXVq2NE1kuVCe1op7w7a
        FYvCAq0ebnX68PtQPnXhE5iERplFJSBuPPmzjnM=
X-Google-Smtp-Source: ABdhPJyJXhttwMOm4Wyml0uaLzrcVyk6SdiO6SYU/RNuN1rAF5AlUaaclANK8A3Die9IOjgBQ8QG04iJHeo7s0hLJAI=
X-Received: by 2002:aca:ad95:: with SMTP id w143mr7731058oie.47.1636495379545;
 Tue, 09 Nov 2021 14:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20211028112703.1120709-1-ardb@kernel.org> <20211028112703.1120709-2-ardb@kernel.org>
 <B1E5C5B0-C135-4518-80B2-CB4544C246F0@oracle.com>
In-Reply-To: <B1E5C5B0-C135-4518-80B2-CB4544C246F0@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Nov 2021 23:02:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEkcTzhvUG0Y7XQoeny+WFcANt6KwZPmziRT4SoY6F2XQ@mail.gmail.com>
Message-ID: <CAMj1kXEkcTzhvUG0Y7XQoeny+WFcANt6KwZPmziRT4SoY6F2XQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] [ARM] Add support for TLS register based stack
 protector canary access
To:     Qing Zhao <qing.zhao@oracle.com>
Cc:     "ramana.radhakrishnan@arm.com" <ramana.radhakrishnan@arm.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        "thomas.preudhomme@celest.fr" <thomas.preudhomme@celest.fr>,
        "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
        Richard Sandiford <richard.sandiford@arm.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 9 Nov 2021 at 21:45, Qing Zhao <qing.zhao@oracle.com> wrote:
>
> Hi, Ard,
>
> Sorry for the late reply (since I don=E2=80=99t have the right to approve=
 a patch, I has been waiting for any arm port maintainer to review this pat=
ch).
> The following is the arm port maintainer information I got from MAINTAINE=
RS file (you might want to explicitly cc=E2=80=99ing one of them for a revi=
ew)
>
> arm port                Nick Clifton            <nickc@redhat.com>
> arm port                Richard Earnshaw        <richard.earnshaw@arm.com=
>
> arm port                Ramana Radhakrishnan    <ramana.radhakrishnan@arm=
.com>
> arm port                Kyrylo Tkachov          <kyrylo.tkachov@arm.com>
>
> I see that Ramana implemented the similar patch for aarch64 (commit cd0b2=
d361df82c848dc7e1c3078651bb0624c3c6), So, I am CCing him with this email. H=
opefully he will review this patch.
>

Thank you Qing. But I know Ramana well, and I know he no longer works
on GCC. I collaborated with him on the AArch64 implementation at the
time (but he wrote all the code)

> Anyway, I briefly read your patch (version 4), and have the following que=
stions and comments:
>
> 1.  When the option -mstack-protector-guard=3Dtls presents,  should the o=
ption mstack-protector-guard-offset=3D.. be required to present?
>      If it=E2=80=99s required to present, you might want to add such requ=
irement to the documentation, and also issue errors when it=E2=80=99s not p=
resent.
>      It=E2=80=99s not clear right now from the current implementation, so=
, you might need to update both "arm_option_override_internal =E2=80=9C in =
arm.c
>      and doc/invoke.texi to make this clear.
>

An  offset of 0x0 is a reasonable default, so I don't think it is
necessary to require the offset param to be passed in that case.

> 2. For arm, is there only one system register can be used for this purpos=
e?
>

There are other registers that might be used in the same way, but the
TLS register is the obvious choice. On AArch64, we decided to use
'sysreg' and permit the user to specify the register because the Linux
kernel uses the user space stack pointer (SP_EL0), which is kind of
odd so we did not want to hard code that.

> 3. For the functionality you added, I didn=E2=80=99t see any testing case=
s added, I think testing cases are needed.
>

Yes, I am aware of that. I'm just not sure I know how to proceed here:
any pointers?

> More comments are embedded below:
>
> > On Oct 28, 2021, at 6:27 AM, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Add support for accessing the stack canary value via the TLS register,
> > so that multiple threads running in the same address space can use
> > distinct canary values. This is intended for the Linux kernel running i=
n
> > SMP mode, where processes entering the kernel are essentially threads
> > running the same program concurrently: using a global variable for the
> > canary in that context is problematic because it can never be rotated,
> > and so the OS is forced to use the same value as long as it remains up.
> >
> > Using the TLS register to index the stack canary helps with this, as it
> > allows each CPU to context switch the TLS register along with the rest
> > of the process, permitting each process to use its own value for the
> > stack canary.
> >
> > 2021-10-28 Ard Biesheuvel <ardb@kernel.org>
> >
> >       * config/arm/arm-opts.h (enum stack_protector_guard): New
> >       * config/arm/arm-protos.h (arm_stack_protect_tls_canary_mem):
> >       New
> >       * config/arm/arm.c (TARGET_STACK_PROTECT_GUARD): Define
> >       (arm_option_override_internal): Handle and put in error checks
> >       for stack protector guard options.
> >       (arm_option_reconfigure_globals): Likewise
> >       (arm_stack_protect_tls_canary_mem): New
> >       (arm_stack_protect_guard): New
> >       * config/arm/arm.md (stack_protect_set): New
> >       (stack_protect_set_tls): Likewise
> >       (stack_protect_test): Likewise
> >       (stack_protect_test_tls): Likewise
> >       (reload_tp_hard): Likewise
> >       * config/arm/arm.opt (-mstack-protector-guard): New
> >       (-mstack-protector-guard-offset): New.
> >       * doc/invoke.texi: Document new options
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > gcc/config/arm/arm-opts.h   |  6 ++
> > gcc/config/arm/arm-protos.h |  2 +
> > gcc/config/arm/arm.c        | 55 +++++++++++++++
> > gcc/config/arm/arm.md       | 71 +++++++++++++++++++-
> > gcc/config/arm/arm.opt      | 22 ++++++
> > gcc/doc/invoke.texi         |  9 +++
> > 6 files changed, 163 insertions(+), 2 deletions(-)
> >
> > diff --git a/gcc/config/arm/arm-opts.h b/gcc/config/arm/arm-opts.h
> > index 5c4b62f404f7..581ba3c4fbbb 100644
> > --- a/gcc/config/arm/arm-opts.h
> > +++ b/gcc/config/arm/arm-opts.h
> > @@ -69,4 +69,10 @@ enum arm_tls_type {
> >   TLS_GNU,
> >   TLS_GNU2
> > };
> > +
> > +/* Where to get the canary for the stack protector.  */
> > +enum stack_protector_guard {
> > +  SSP_TLSREG,                  /* per-thread canary in TLS register */
> > +  SSP_GLOBAL                   /* global canary */
> > +};
> > #endif
> > diff --git a/gcc/config/arm/arm-protos.h b/gcc/config/arm/arm-protos.h
> > index 9b1f61394ad7..d8d605920c97 100644
> > --- a/gcc/config/arm/arm-protos.h
> > +++ b/gcc/config/arm/arm-protos.h
> > @@ -195,6 +195,8 @@ extern void arm_split_atomic_op (enum rtx_code, rtx=
, rtx, rtx, rtx, rtx, rtx);
> > extern rtx arm_load_tp (rtx);
> > extern bool arm_coproc_builtin_available (enum unspecv);
> > extern bool arm_coproc_ldc_stc_legitimate_address (rtx);
> > +extern rtx arm_stack_protect_tls_canary_mem (bool);
> > +
> >
> > #if defined TREE_CODE
> > extern void arm_init_cumulative_args (CUMULATIVE_ARGS *, tree, rtx, tre=
e);
> > diff --git a/gcc/config/arm/arm.c b/gcc/config/arm/arm.c
> > index c4ff06b087eb..6a659d81a6fe 100644
> > --- a/gcc/config/arm/arm.c
> > +++ b/gcc/config/arm/arm.c
> > @@ -829,6 +829,9 @@ static const struct attribute_spec arm_attribute_ta=
ble[] =3D
> >
> > #undef TARGET_MD_ASM_ADJUST
> > #define TARGET_MD_ASM_ADJUST arm_md_asm_adjust
> > +
> > +#undef TARGET_STACK_PROTECT_GUARD
> > +#define TARGET_STACK_PROTECT_GUARD arm_stack_protect_guard
> >
> > /* Obstack for minipool constant handling.  */
> > static struct obstack minipool_obstack;
> > @@ -3155,6 +3158,26 @@ arm_option_override_internal (struct gcc_options=
 *opts,
> >   if (TARGET_THUMB2_P (opts->x_target_flags))
> >     opts->x_inline_asm_unified =3D true;
> >
> > +  if (arm_stack_protector_guard =3D=3D SSP_GLOBAL
> > +      && opts->x_arm_stack_protector_guard_offset_str)
> > +    {
> > +      error ("incompatible options %'-mstack-protector-guard=3Dglobal%=
' and"
>
> Are the two  =E2=80=9C%=E2=80=9D in the above needed?
>

I get warnings about bare quotes otherwise, so yes AFAICT.

> > +          "%'-mstack-protector-guard-offset=3D%qs%=E2=80=99=E2=80=9D,
> Are the two =E2=80=9C%=E2=80=9D in the above needed?
>
> > +          arm_stack_protector_guard_offset_str);
> > +    }
>
>
> > +
> > +  if (opts->x_arm_stack_protector_guard_offset_str)
> > +    {
> > +      char *end;
> > +      const char *str =3D arm_stack_protector_guard_offset_str;
> > +      errno =3D 0;
> > +      long offs =3D strtol (arm_stack_protector_guard_offset_str, &end=
, 0);
> > +      if (!*str || *end || errno)
> > +     error ("%qs is not a valid offset in %qs", str,
> > +            "-mstack-protector-guard-offset=3D");
> > +      arm_stack_protector_guard_offset =3D offs;
> > +    }
> > +
> > #ifdef SUBTARGET_OVERRIDE_INTERNAL_OPTIONS
> >   SUBTARGET_OVERRIDE_INTERNAL_OPTIONS;
> > #endif
> > @@ -3822,6 +3845,10 @@ arm_option_reconfigure_globals (void)
> >       else
> >       target_thread_pointer =3D TP_SOFT;
> >     }
> > +
> > +  if (arm_stack_protector_guard =3D=3D SSP_TLSREG
> > +      && target_thread_pointer !=3D TP_CP15)
> > +    error("%'-mstack-protector-guard=3Dtls%' needs a hardware TLS regi=
ster");
>
> Under what situation, this might happen?
>

If the user passes -mtp=3Dsoft -mstack-protector-guard=3Dtls, we get in
the paradoxical situation where the stack protector uses the MRC
instruction directly, whereas the TLS variable accesses will call
__aeabi_read_tp to read the same value. This is sub-optimal at the
very least, but also unlikely to be what the user intended.

> > }
> >
> > /* Perform some validation between the desired architecture and the res=
t of the
> > @@ -8087,6 +8114,22 @@ legitimize_pic_address (rtx orig, machine_mode m=
ode, rtx reg, rtx pic_reg,
> > }
> >
> >
> > +rtx
> > +arm_stack_protect_tls_canary_mem (bool reload)
> > +{
> > +  rtx tp =3D gen_reg_rtx (SImode);
> > +  if (reload)
> > +    emit_insn (gen_reload_tp_hard (tp));
> > +  else
> > +    emit_insn (gen_load_tp_hard (tp));
> > +
> > +  rtx reg =3D gen_reg_rtx (SImode);
> > +  rtx offset =3D GEN_INT (arm_stack_protector_guard_offset);
> > +  emit_set_insn (reg, gen_rtx_PLUS (SImode, tp, offset));
> > +  return gen_rtx_MEM (SImode, reg);
> > +}
>
> Could you add a comment for the above routine?
>

Yes.

> > +
> > +
> > /* Whether a register is callee saved or not.  This is necessary becaus=
e high
> >    registers are marked as caller saved when optimizing for size on Thu=
mb-1
> >    targets despite being callee saved in order to avoid using them.  */
> > @@ -34054,6 +34097,18 @@ arm_run_selftests (void)
> > #define TARGET_RUN_TARGET_SELFTESTS selftest::arm_run_selftests
> > #endif /* CHECKING_P */
> >
> > +/* Implement TARGET_STACK_PROTECT_GUARD. In case of a
> > +   global variable based guard use the default else
> > +   return a null tree.  */
> > +static tree
> > +arm_stack_protect_guard (void)
> > +{
> > +  if (arm_stack_protector_guard =3D=3D SSP_GLOBAL)
> > +    return default_stack_protect_guard ();
> > +
> > +  return NULL_TREE;
> > +}
> > +
> > /* Worker function for TARGET_MD_ASM_ADJUST, while in thumb1 mode.
> >    Unlike the arm version, we do NOT implement asm flag outputs.  */
> >
> > diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
> > index 4adc976b8b67..d31349cd2614 100644
> > --- a/gcc/config/arm/arm.md
> > +++ b/gcc/config/arm/arm.md
> > @@ -9183,7 +9183,7 @@ (define_expand "stack_protect_combined_set"
> >                     UNSPEC_SP_SET))
> >       (clobber (match_scratch:SI 2 ""))
> >       (clobber (match_scratch:SI 3 ""))])]
> > -  ""
> > +  "arm_stack_protector_guard =3D=3D SSP_GLOBAL"
> >   ""
> > )
> >
> > @@ -9267,7 +9267,7 @@ (define_expand "stack_protect_combined_test"
> >       (clobber (match_scratch:SI 3 ""))
> >       (clobber (match_scratch:SI 4 ""))
> >       (clobber (reg:CC CC_REGNUM))])]
> > -  ""
> > +  "arm_stack_protector_guard =3D=3D SSP_GLOBAL"
> >   ""
> > )
> >
> > @@ -9361,6 +9361,64 @@ (define_insn "arm_stack_protect_test_insn"
> >    (set_attr "arch" "t,32")]
> > )
> >
> > +(define_expand "stack_protect_set"
> > +  [(match_operand:SI 0 "memory_operand")
> > +   (match_operand:SI 1 "memory_operand")]
> > +  "arm_stack_protector_guard =3D=3D SSP_TLSREG"
> > +  "
> > +{
> > +  operands[1] =3D arm_stack_protect_tls_canary_mem (false /* reload */=
);
> > +  emit_insn (gen_stack_protect_set_tls (operands[0], operands[1]));
> > +  DONE;
> > +}"
> > +)
> > +
> > +;; DO NOT SPLIT THIS PATTERN.  It is important for security reasons th=
at the
> > +;; canary value does not live beyond the life of this sequence.
> > +(define_insn "stack_protect_set_tls"
> > +  [(set (match_operand:SI 0 "memory_operand" "=3Dm")
> > +       (unspec:SI [(match_operand:SI 1 "memory_operand" "m")]
> > +        UNSPEC_SP_SET))
> > +   (set (match_scratch:SI 2 "=3D&r") (const_int 0))]
> > +  ""
> > +  "ldr\\t%2, %1\;str\\t%2, %0\;mov\t%2, #0"
> > +  [(set_attr "length" "12")
> > +   (set_attr "conds" "nocond")
> > +   (set_attr "type" "multiple")]
> > +)
> > +
> > +(define_expand "stack_protect_test"
> > +  [(match_operand:SI 0 "memory_operand")
> > +   (match_operand:SI 1 "memory_operand")
> > +   (match_operand:SI 2)]
> > +  "arm_stack_protector_guard =3D=3D SSP_TLSREG"
> > +  "
> > +{
> > +  operands[1] =3D arm_stack_protect_tls_canary_mem (true /* reload */)=
;
> > +  emit_insn (gen_stack_protect_test_tls (operands[0], operands[1]));
> > +
> > +  rtx cc_reg =3D gen_rtx_REG (CC_Zmode, CC_REGNUM);
> > +  rtx eq =3D gen_rtx_EQ (CC_Zmode, cc_reg, const0_rtx);
> > +  emit_jump_insn (gen_arm_cond_branch (operands[2], eq, cc_reg));
> > +  DONE;
> > +}"
> > +)
> > +
> > +(define_insn "stack_protect_test_tls"
> > +  [(set (reg:CC_Z CC_REGNUM)
> > +     (compare:CC_Z (unspec:SI [(match_operand:SI 0 "memory_operand" "m=
")
> > +                               (match_operand:SI 1 "memory_operand" "m=
")]
> > +                              UNSPEC_SP_TEST)
> > +                   (const_int 0)))
> > +   (clobber (match_scratch:SI 2 "=3D&r"))
> > +   (clobber (match_scratch:SI 3 "=3D&r"))]
> > +  ""
> > +  "ldr\t%2, %0\;ldr\t%3, %1\;eors\t%2, %3, %2\;mov\t%3, #0"
> > +  [(set_attr "length" "16")
> > +   (set_attr "conds" "set")
> > +   (set_attr "type" "multiple")]
> > +)
> > +
> > (define_expand "casesi"
> >   [(match_operand:SI 0 "s_register_operand")  ; index to jump on
> >    (match_operand:SI 1 "const_int_operand")   ; lower bound
> > @@ -12133,6 +12191,15 @@ (define_insn "load_tp_hard"
> >    (set_attr "type" "mrs")]
> > )
> >
> > +;; Used by the TLS register based stack protector
> > +(define_insn "reload_tp_hard"
> > +  [(set (match_operand:SI 0 "register_operand" "=3Dr")
> > +     (unspec_volatile [(const_int 0)] VUNSPEC_MRC))]
> > +  "TARGET_HARD_TP"
> > +  "mrc\\tp15, 0, %0, c13, c0, 3\\t@ reload_tp_hard"
> > +  [(set_attr "type" "mrs")]
> > +)
> > +
> > ;; Doesn't clobber R1-R3.  Must use r0 for the first operand.
> > (define_insn "load_tp_soft_fdpic"
> >   [(set (reg:SI 0) (unspec:SI [(const_int 0)] UNSPEC_TLS))
> > diff --git a/gcc/config/arm/arm.opt b/gcc/config/arm/arm.opt
> > index a7677eeb45c8..4b3e17bc319c 100644
> > --- a/gcc/config/arm/arm.opt
> > +++ b/gcc/config/arm/arm.opt
> > @@ -311,3 +311,25 @@ Generate code which uses the core registers only (=
r0-r14).
> > mfdpic
> > Target Mask(FDPIC)
> > Enable Function Descriptor PIC mode.
> > +
> > +mstack-protector-guard=3D
> > +Target RejectNegative Joined Enum(stack_protector_guard) Var(arm_stack=
_protector_guard) Init(SSP_GLOBAL)
> > +Use given stack-protector guard.
> > +
> > +Enum
> > +Name(stack_protector_guard) Type(enum stack_protector_guard)
> > +Valid arguments to -mstack-protector-guard=3D:
> > +
> > +EnumValue
> > +Enum(stack_protector_guard) String(tls) Value(SSP_TLSREG)
> > +
> > +EnumValue
> > +Enum(stack_protector_guard) String(global) Value(SSP_GLOBAL)
> > +
> > +mstack-protector-guard-offset=3D
> > +Target Joined RejectNegative String Var(arm_stack_protector_guard_offs=
et_str)
> > +Use an immediate to offset from the TLS register. This option is for u=
se with
> > +fstack-protector-guard=3Dtls and not for use in user-land code.
> > +
> > +TargetVariable
> > +long arm_stack_protector_guard_offset =3D 0
> > diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> > index 71992b8c5974..46d009376018 100644
> > --- a/gcc/doc/invoke.texi
> > +++ b/gcc/doc/invoke.texi
> > @@ -810,6 +810,7 @@ Objective-C and Objective-C++ Dialects}.
> > -mpure-code @gol
> > -mcmse @gol
> > -mfix-cmse-cve-2021-35465 @gol
> > +-mstack-protector-guard=3D@var{guard} -mstack-protector-guard-offset=
=3D@var{offset} @gol
> > -mfdpic}
> >
> > @emph{AVR Options}
> > @@ -20946,6 +20947,14 @@ enabled by default when the option @option{-mc=
pu=3D} is used with
> > @code{cortex-m33}, @code{cortex-m35p} or @code{cortex-m55}.  The option
> > @option{-mno-fix-cmse-cve-2021-35465} can be used to disable the mitiga=
tion.
> >
> > +@item -mstack-protector-guard=3D@var{guard}
> > +@itemx -mstack-protector-guard-offset=3D@var{offset}
> > +@opindex mstack-protector-guard
> > +@opindex mstack-protector-guard-offset
> > +Generate stack protection code using canary at @var{guard}.  Supported
> > +locations are @samp{global} for a global canary or @samp{tls} for a
> > +canary accessible via the TLS register.
> > +
>
>
> There is no documentation for -mstack-protector-guard-offset here, and yo=
u might want to explain the relationship between -mstack-protector-guard=3D=
 and it.
>

OK, got it.

Thanks a lot for the review!

--=20
Ard.
