Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A48EC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 14 Jan 2022 10:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiANKFU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 14 Jan 2022 05:05:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47820 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiANKFT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 14 Jan 2022 05:05:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6981F61EA7
        for <linux-hardening@vger.kernel.org>; Fri, 14 Jan 2022 10:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59F1C36AF3
        for <linux-hardening@vger.kernel.org>; Fri, 14 Jan 2022 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642154718;
        bh=vPvtbGZFPK5gxWzwGYJIUnQ+d9rKl8i/Smh9Nfw3hOQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B9aRQb1V3qRhJdmnjzs5hi3k1KXjAoVz9QpSeDoH7Lu1yYdC8ObmoLBakq9cWwuuq
         P+ZL6rjwlYk6S7GlncKIqMa5kimrIQgixqlysd4nA/IPXKWeIM1Ho8HhYNKD4ryAl7
         rBRI7CaCyWVeyvBUqVTu7cl8Yodt+j5BUhlVEKKQvu9cJCRSed3HvoEkzlcnTat6CU
         uc5gB6maDb4RBH0oSwobvxboGaZut52W621A5v/m5gyww7xsozZzcb3pMG2nb2prIp
         t2ORV2UnjxU5TQN5QoZaRUbQRH/WnBO1xkINCz51Ex8MYXyg3OEeSYXSb20faadKBV
         iCg4tO/Z2sdxQ==
Received: by mail-wr1-f48.google.com with SMTP id v6so14674291wra.8
        for <linux-hardening@vger.kernel.org>; Fri, 14 Jan 2022 02:05:18 -0800 (PST)
X-Gm-Message-State: AOAM5338kdSfKAlXXL5U2FWzj8Z/Y8KBLKTja4bW3WhClkPTztnfyp6V
        Je6fqaJP62wqri65kDpg+l+l0bp+4PMO9yVckS4=
X-Google-Smtp-Source: ABdhPJwej3X8Ow1WxPlgT8Tv2lycTF7XUwqRpBiAp0bJZxdmY9SKIpmAIdmBSJLeKvfjAXceopQofupVPBDSchktjRY=
X-Received: by 2002:a5d:6541:: with SMTP id z1mr5180083wrv.550.1642154716881;
 Fri, 14 Jan 2022 02:05:16 -0800 (PST)
MIME-Version: 1.0
References: <20211115180410.5272-1-ardb@kernel.org> <20211115180410.5272-2-ardb@kernel.org>
 <CAMj1kXEgHCT4Z_T70QXtoYg1jMrrmw7AmpZu3DDmmXqe9CiB+Q@mail.gmail.com> <CAMj1kXHf+AAui_FRDj1=B9d5Y__pCFxkwc+2MFA02XnoNcRHFA@mail.gmail.com>
In-Reply-To: <CAMj1kXHf+AAui_FRDj1=B9d5Y__pCFxkwc+2MFA02XnoNcRHFA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Jan 2022 11:05:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH8x=OLESpJZvR2yS8GZ9YAa6uy2rcfxryYgFnj6SiUhw@mail.gmail.com>
Message-ID: <CAMj1kXH8x=OLESpJZvR2yS8GZ9YAa6uy2rcfxryYgFnj6SiUhw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] [ARM] Add support for TLS register based stack
 protector canary access
To:     linux-hardening@vger.kernel.org,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        richard.earnshaw@arm.com, Kyrylo Tkachov <kyryo.tkachov@arm.com>
Cc:     Keith Packard <keithpac@amazon.com>, thomas.preudhomme@celest.fr,
        adhemerval.zanella@linaro.org, Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        gcc-patches@gcc.gnu.org, spender@grsecurity.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

(+ Richard Earnshaw)

On Wed, 12 Jan 2022 at 19:29, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 17 Nov 2021 at 18:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > (+ Ramana)
> >
>
> Ping?
>
> > On Mon, 15 Nov 2021 at 19:04, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > Add support for accessing the stack canary value via the TLS register,
> > > so that multiple threads running in the same address space can use
> > > distinct canary values. This is intended for the Linux kernel running in
> > > SMP mode, where processes entering the kernel are essentially threads
> > > running the same program concurrently: using a global variable for the
> > > canary in that context is problematic because it can never be rotated,
> > > and so the OS is forced to use the same value as long as it remains up.
> > >
> > > Using the TLS register to index the stack canary helps with this, as it
> > > allows each CPU to context switch the TLS register along with the rest
> > > of the process, permitting each process to use its own value for the
> > > stack canary.
> > >
> > > 2021-11-15 Ard Biesheuvel <ardb@kernel.org>
> > >
> > >         * config/arm/arm-opts.h (enum stack_protector_guard): New
> > >         * config/arm/arm-protos.h (arm_stack_protect_tls_canary_mem):
> > >         New
> > >         * config/arm/arm.c (TARGET_STACK_PROTECT_GUARD): Define
> > >         (arm_option_override_internal): Handle and put in error checks
> > >         for stack protector guard options.
> > >         (arm_option_reconfigure_globals): Likewise
> > >         (arm_stack_protect_tls_canary_mem): New
> > >         (arm_stack_protect_guard): New
> > >         * config/arm/arm.md (stack_protect_set): New
> > >         (stack_protect_set_tls): Likewise
> > >         (stack_protect_test): Likewise
> > >         (stack_protect_test_tls): Likewise
> > >         (reload_tp_hard): Likewise
> > >         * config/arm/arm.opt (-mstack-protector-guard): New
> > >         (-mstack-protector-guard-offset): New.
> > >         * doc/invoke.texi: Document new options
> > >
> > > gcc/testsuite/ChangeLog:
> > >
> > >         * gcc.target/arm/stack-protector-7.c: New test.
> > >         * gcc.target/arm/stack-protector-8.c: New test.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  gcc/config/arm/arm-opts.h                        |  6 ++
> > >  gcc/config/arm/arm-protos.h                      |  2 +
> > >  gcc/config/arm/arm.c                             | 55 +++++++++++++++
> > >  gcc/config/arm/arm.md                            | 71 +++++++++++++++++++-
> > >  gcc/config/arm/arm.opt                           | 22 ++++++
> > >  gcc/doc/invoke.texi                              | 11 +++
> > >  gcc/testsuite/gcc.target/arm/stack-protector-7.c | 10 +++
> > >  gcc/testsuite/gcc.target/arm/stack-protector-8.c |  5 ++
> > >  8 files changed, 180 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/gcc/config/arm/arm-opts.h b/gcc/config/arm/arm-opts.h
> > > index 5c4b62f404f7..581ba3c4fbbb 100644
> > > --- a/gcc/config/arm/arm-opts.h
> > > +++ b/gcc/config/arm/arm-opts.h
> > > @@ -69,4 +69,10 @@ enum arm_tls_type {
> > >    TLS_GNU,
> > >    TLS_GNU2
> > >  };
> > > +
> > > +/* Where to get the canary for the stack protector.  */
> > > +enum stack_protector_guard {
> > > +  SSP_TLSREG,                  /* per-thread canary in TLS register */
> > > +  SSP_GLOBAL                   /* global canary */
> > > +};
> > >  #endif
> > > diff --git a/gcc/config/arm/arm-protos.h b/gcc/config/arm/arm-protos.h
> > > index 9b1f61394ad7..d8d605920c97 100644
> > > --- a/gcc/config/arm/arm-protos.h
> > > +++ b/gcc/config/arm/arm-protos.h
> > > @@ -195,6 +195,8 @@ extern void arm_split_atomic_op (enum rtx_code, rtx, rtx, rtx, rtx, rtx, rtx);
> > >  extern rtx arm_load_tp (rtx);
> > >  extern bool arm_coproc_builtin_available (enum unspecv);
> > >  extern bool arm_coproc_ldc_stc_legitimate_address (rtx);
> > > +extern rtx arm_stack_protect_tls_canary_mem (bool);
> > > +
> > >
> > >  #if defined TREE_CODE
> > >  extern void arm_init_cumulative_args (CUMULATIVE_ARGS *, tree, rtx, tree);
> > > diff --git a/gcc/config/arm/arm.c b/gcc/config/arm/arm.c
> > > index a5b403eb3e49..e5077348ce07 100644
> > > --- a/gcc/config/arm/arm.c
> > > +++ b/gcc/config/arm/arm.c
> > > @@ -829,6 +829,9 @@ static const struct attribute_spec arm_attribute_table[] =
> > >
> > >  #undef TARGET_MD_ASM_ADJUST
> > >  #define TARGET_MD_ASM_ADJUST arm_md_asm_adjust
> > > +
> > > +#undef TARGET_STACK_PROTECT_GUARD
> > > +#define TARGET_STACK_PROTECT_GUARD arm_stack_protect_guard
> > >
> > >  /* Obstack for minipool constant handling.  */
> > >  static struct obstack minipool_obstack;
> > > @@ -3176,6 +3179,26 @@ arm_option_override_internal (struct gcc_options *opts,
> > >    if (TARGET_THUMB2_P (opts->x_target_flags))
> > >      opts->x_inline_asm_unified = true;
> > >
> > > +  if (arm_stack_protector_guard == SSP_GLOBAL
> > > +      && opts->x_arm_stack_protector_guard_offset_str)
> > > +    {
> > > +      error ("incompatible options %'-mstack-protector-guard=global%' and"
> > > +            "%'-mstack-protector-guard-offset=%qs%'",
> > > +            arm_stack_protector_guard_offset_str);
> > > +    }
> > > +
> > > +  if (opts->x_arm_stack_protector_guard_offset_str)
> > > +    {
> > > +      char *end;
> > > +      const char *str = arm_stack_protector_guard_offset_str;
> > > +      errno = 0;
> > > +      long offs = strtol (arm_stack_protector_guard_offset_str, &end, 0);
> > > +      if (!*str || *end || errno)
> > > +       error ("%qs is not a valid offset in %qs", str,
> > > +              "-mstack-protector-guard-offset=");
> > > +      arm_stack_protector_guard_offset = offs;
> > > +    }
> > > +
> > >  #ifdef SUBTARGET_OVERRIDE_INTERNAL_OPTIONS
> > >    SUBTARGET_OVERRIDE_INTERNAL_OPTIONS;
> > >  #endif
> > > @@ -3843,6 +3866,9 @@ arm_option_reconfigure_globals (void)
> > >        else
> > >         target_thread_pointer = TP_SOFT;
> > >      }
> > > +
> > > +  if (!TARGET_HARD_TP && arm_stack_protector_guard == SSP_TLSREG)
> > > +    error("%'-mstack-protector-guard=tls%' needs a hardware TLS register");
> > >  }
> > >
> > >  /* Perform some validation between the desired architecture and the rest of the
> > > @@ -8108,6 +8134,23 @@ legitimize_pic_address (rtx orig, machine_mode mode, rtx reg, rtx pic_reg,
> > >  }
> > >
> > >
> > > +/* Generate insns that produce the address of the stack canary */
> > > +rtx
> > > +arm_stack_protect_tls_canary_mem (bool reload)
> > > +{
> > > +  rtx tp = gen_reg_rtx (SImode);
> > > +  if (reload)
> > > +    emit_insn (gen_reload_tp_hard (tp));
> > > +  else
> > > +    emit_insn (gen_load_tp_hard (tp));
> > > +
> > > +  rtx reg = gen_reg_rtx (SImode);
> > > +  rtx offset = GEN_INT (arm_stack_protector_guard_offset);
> > > +  emit_set_insn (reg, gen_rtx_PLUS (SImode, tp, offset));
> > > +  return gen_rtx_MEM (SImode, reg);
> > > +}
> > > +
> > > +
> > >  /* Whether a register is callee saved or not.  This is necessary because high
> > >     registers are marked as caller saved when optimizing for size on Thumb-1
> > >     targets despite being callee saved in order to avoid using them.  */
> > > @@ -34075,6 +34118,18 @@ arm_run_selftests (void)
> > >  #define TARGET_RUN_TARGET_SELFTESTS selftest::arm_run_selftests
> > >  #endif /* CHECKING_P */
> > >
> > > +/* Implement TARGET_STACK_PROTECT_GUARD. In case of a
> > > +   global variable based guard use the default else
> > > +   return a null tree.  */
> > > +static tree
> > > +arm_stack_protect_guard (void)
> > > +{
> > > +  if (arm_stack_protector_guard == SSP_GLOBAL)
> > > +    return default_stack_protect_guard ();
> > > +
> > > +  return NULL_TREE;
> > > +}
> > > +
> > >  /* Worker function for TARGET_MD_ASM_ADJUST, while in thumb1 mode.
> > >     Unlike the arm version, we do NOT implement asm flag outputs.  */
> > >
> > > diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
> > > index 4adc976b8b67..45a54d63f5b3 100644
> > > --- a/gcc/config/arm/arm.md
> > > +++ b/gcc/config/arm/arm.md
> > > @@ -9183,7 +9183,7 @@ (define_expand "stack_protect_combined_set"
> > >                       UNSPEC_SP_SET))
> > >        (clobber (match_scratch:SI 2 ""))
> > >        (clobber (match_scratch:SI 3 ""))])]
> > > -  ""
> > > +  "arm_stack_protector_guard == SSP_GLOBAL"
> > >    ""
> > >  )
> > >
> > > @@ -9267,7 +9267,7 @@ (define_expand "stack_protect_combined_test"
> > >        (clobber (match_scratch:SI 3 ""))
> > >        (clobber (match_scratch:SI 4 ""))
> > >        (clobber (reg:CC CC_REGNUM))])]
> > > -  ""
> > > +  "arm_stack_protector_guard == SSP_GLOBAL"
> > >    ""
> > >  )
> > >
> > > @@ -9361,6 +9361,64 @@ (define_insn "arm_stack_protect_test_insn"
> > >     (set_attr "arch" "t,32")]
> > >  )
> > >
> > > +(define_expand "stack_protect_set"
> > > +  [(match_operand:SI 0 "memory_operand")
> > > +   (match_operand:SI 1 "memory_operand")]
> > > +  "arm_stack_protector_guard == SSP_TLSREG"
> > > +  "
> > > +{
> > > +  operands[1] = arm_stack_protect_tls_canary_mem (false /* reload */);
> > > +  emit_insn (gen_stack_protect_set_tls (operands[0], operands[1]));
> > > +  DONE;
> > > +}"
> > > +)
> > > +
> > > +;; DO NOT SPLIT THIS PATTERN.  It is important for security reasons that the
> > > +;; canary value does not live beyond the life of this sequence.
> > > +(define_insn "stack_protect_set_tls"
> > > +  [(set (match_operand:SI 0 "memory_operand" "=m")
> > > +       (unspec:SI [(match_operand:SI 1 "memory_operand" "m")]
> > > +        UNSPEC_SP_SET))
> > > +   (set (match_scratch:SI 2 "=&r") (const_int 0))]
> > > +  ""
> > > +  "ldr\\t%2, %1\;str\\t%2, %0\;mov\t%2, #0"
> > > +  [(set_attr "length" "12")
> > > +   (set_attr "conds" "unconditional")
> > > +   (set_attr "type" "multiple")]
> > > +)
> > > +
> > > +(define_expand "stack_protect_test"
> > > +  [(match_operand:SI 0 "memory_operand")
> > > +   (match_operand:SI 1 "memory_operand")
> > > +   (match_operand:SI 2)]
> > > +  "arm_stack_protector_guard == SSP_TLSREG"
> > > +  "
> > > +{
> > > +  operands[1] = arm_stack_protect_tls_canary_mem (true /* reload */);
> > > +  emit_insn (gen_stack_protect_test_tls (operands[0], operands[1]));
> > > +
> > > +  rtx cc_reg = gen_rtx_REG (CC_Zmode, CC_REGNUM);
> > > +  rtx eq = gen_rtx_EQ (CC_Zmode, cc_reg, const0_rtx);
> > > +  emit_jump_insn (gen_arm_cond_branch (operands[2], eq, cc_reg));
> > > +  DONE;
> > > +}"
> > > +)
> > > +
> > > +(define_insn "stack_protect_test_tls"
> > > +  [(set (reg:CC_Z CC_REGNUM)
> > > +       (compare:CC_Z (unspec:SI [(match_operand:SI 0 "memory_operand" "m")
> > > +                                 (match_operand:SI 1 "memory_operand" "m")]
> > > +                                UNSPEC_SP_TEST)
> > > +                     (const_int 0)))
> > > +   (clobber (match_scratch:SI 2 "=&r"))
> > > +   (clobber (match_scratch:SI 3 "=&r"))]
> > > +  ""
> > > +  "ldr\t%2, %0\;ldr\t%3, %1\;eors\t%2, %3, %2\;mov\t%3, #0"
> > > +  [(set_attr "length" "16")
> > > +   (set_attr "conds" "set")
> > > +   (set_attr "type" "multiple")]
> > > +)
> > > +
> > >  (define_expand "casesi"
> > >    [(match_operand:SI 0 "s_register_operand")   ; index to jump on
> > >     (match_operand:SI 1 "const_int_operand")    ; lower bound
> > > @@ -12133,6 +12191,15 @@ (define_insn "load_tp_hard"
> > >     (set_attr "type" "mrs")]
> > >  )
> > >
> > > +;; Used by the TLS register based stack protector
> > > +(define_insn "reload_tp_hard"
> > > +  [(set (match_operand:SI 0 "register_operand" "=r")
> > > +       (unspec_volatile:SI [(const_int 0)] VUNSPEC_MRC))]
> > > +  "TARGET_HARD_TP"
> > > +  "mrc\\tp15, 0, %0, c13, c0, 3\\t@ reload_tp_hard"
> > > +  [(set_attr "type" "mrs")]
> > > +)
> > > +
> > >  ;; Doesn't clobber R1-R3.  Must use r0 for the first operand.
> > >  (define_insn "load_tp_soft_fdpic"
> > >    [(set (reg:SI 0) (unspec:SI [(const_int 0)] UNSPEC_TLS))
> > > diff --git a/gcc/config/arm/arm.opt b/gcc/config/arm/arm.opt
> > > index a7677eeb45c8..4b3e17bc319c 100644
> > > --- a/gcc/config/arm/arm.opt
> > > +++ b/gcc/config/arm/arm.opt
> > > @@ -311,3 +311,25 @@ Generate code which uses the core registers only (r0-r14).
> > >  mfdpic
> > >  Target Mask(FDPIC)
> > >  Enable Function Descriptor PIC mode.
> > > +
> > > +mstack-protector-guard=
> > > +Target RejectNegative Joined Enum(stack_protector_guard) Var(arm_stack_protector_guard) Init(SSP_GLOBAL)
> > > +Use given stack-protector guard.
> > > +
> > > +Enum
> > > +Name(stack_protector_guard) Type(enum stack_protector_guard)
> > > +Valid arguments to -mstack-protector-guard=:
> > > +
> > > +EnumValue
> > > +Enum(stack_protector_guard) String(tls) Value(SSP_TLSREG)
> > > +
> > > +EnumValue
> > > +Enum(stack_protector_guard) String(global) Value(SSP_GLOBAL)
> > > +
> > > +mstack-protector-guard-offset=
> > > +Target Joined RejectNegative String Var(arm_stack_protector_guard_offset_str)
> > > +Use an immediate to offset from the TLS register. This option is for use with
> > > +fstack-protector-guard=tls and not for use in user-land code.
> > > +
> > > +TargetVariable
> > > +long arm_stack_protector_guard_offset = 0
> > > diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> > > index 6070288856c0..13bebbcbf0fb 100644
> > > --- a/gcc/doc/invoke.texi
> > > +++ b/gcc/doc/invoke.texi
> > > @@ -816,6 +816,7 @@ Objective-C and Objective-C++ Dialects}.
> > >  -mpure-code @gol
> > >  -mcmse @gol
> > >  -mfix-cmse-cve-2021-35465 @gol
> > > +-mstack-protector-guard=@var{guard} -mstack-protector-guard-offset=@var{offset} @gol
> > >  -mfdpic}
> > >
> > >  @emph{AVR Options}
> > > @@ -21099,6 +21100,16 @@ enabled by default when the option @option{-mcpu=} is used with
> > >  @code{cortex-m33}, @code{cortex-m35p} or @code{cortex-m55}.  The option
> > >  @option{-mno-fix-cmse-cve-2021-35465} can be used to disable the mitigation.
> > >
> > > +@item -mstack-protector-guard=@var{guard}
> > > +@itemx -mstack-protector-guard-offset=@var{offset}
> > > +@opindex mstack-protector-guard
> > > +@opindex mstack-protector-guard-offset
> > > +Generate stack protection code using canary at @var{guard}.  Supported
> > > +locations are @samp{global} for a global canary or @samp{tls} for a
> > > +canary accessible via the TLS register. The option
> > > +@option{-mstack-protector-guard-offset=} is for use with
> > > +@option{-fstack-protector-guard=tls} and not for use in user-land code.
> > > +
> > >  @item -mfdpic
> > >  @itemx -mno-fdpic
> > >  @opindex mfdpic
> > > diff --git a/gcc/testsuite/gcc.target/arm/stack-protector-7.c b/gcc/testsuite/gcc.target/arm/stack-protector-7.c
> > > new file mode 100644
> > > index 000000000000..874648060d8d
> > > --- /dev/null
> > > +++ b/gcc/testsuite/gcc.target/arm/stack-protector-7.c
> > > @@ -0,0 +1,10 @@
> > > +/* { dg-do compile } */
> > > +/* { dg-options "-march=armv7-a -mfpu=vfp -fstack-protector-all -Os -mstack-protector-guard=tls -mstack-protector-guard-offset=1296 -mtp=cp15" } */
> > > +
> > > +#include "stack-protector-5.c"
> > > +
> > > +/* See the comment in stack-protector-5.c.  */
> > > +/* { dg-final { scan-assembler-times {\tstr\t} 1 } } */
> > > +/* Expect two TLS register accesses and two occurrences of the offset */
> > > +/* { dg-final { scan-assembler-times {\tmrc\t} 2 } } */
> > > +/* { dg-final { scan-assembler-times {1296} 2 } } */
> > > diff --git a/gcc/testsuite/gcc.target/arm/stack-protector-8.c b/gcc/testsuite/gcc.target/arm/stack-protector-8.c
> > > new file mode 100644
> > > index 000000000000..bcb2f6b82bdf
> > > --- /dev/null
> > > +++ b/gcc/testsuite/gcc.target/arm/stack-protector-8.c
> > > @@ -0,0 +1,5 @@
> > > +/* { dg-do compile } */
> > > +/* { dg-error "needs a hardware TLS register" "missing error when using TLS stack protector without hardware TLS register" { target *-*-* } 0 } */
> > > +/* { dg-options "-fstack-protector-all -Os -mstack-protector-guard=tls -mtp=soft" } */
> > > +
> > > +int foo;
> > > --
> > > 2.30.2
> > >
