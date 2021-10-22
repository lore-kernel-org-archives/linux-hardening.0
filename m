Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C04C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Oct 2021 12:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922A660F57
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Oct 2021 12:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJVMon (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 22 Oct 2021 08:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhJVMom (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 22 Oct 2021 08:44:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84E396101C
        for <linux-hardening@vger.kernel.org>; Fri, 22 Oct 2021 12:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634906545;
        bh=BggpFZKzY/lWdXY/3Q0A4hbVlvfYUa8t8zFeeyVahVc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fksCdAN2EBcpgK/BgP5xR2gyHw4Ht27sA0fKvpucrXv/aE6IAST8Q9cbIbr/iQbXs
         1P2DBOTSYUHSYQGWQ5U4+h8dVFEsSXmNTPRqQj94qF+jE6wP2scezMYmYGY4e9xldH
         FFOX+Wp+4iApVqkxX3B+r0csBynYv1THUcZCsghK3eDSy+eZ87JytYkAI+Nu7n+qpA
         wF0NbCvPHtB7xTEzYEDIBkWGRWXILUNLvLH46/EJF3b2DPEAZSAw5FzNF+i2ohKl9F
         m1eKnHT1a5uHRXLCuqhZzGSnryu9hRhm6SHa3pic8xvX01YyPBnyU+MtB5gtumWoPC
         3doNoJU4ezZgA==
Received: by mail-oi1-f173.google.com with SMTP id s9so4841553oiw.6
        for <linux-hardening@vger.kernel.org>; Fri, 22 Oct 2021 05:42:25 -0700 (PDT)
X-Gm-Message-State: AOAM533YvYOi/cgzXFZO7v7jZ8uFBS6a62AW6VKWugWGgb+TzSLgkxh1
        GaKIdLZ+6fmtWQ1Ur4FXdTssfSiC7GXLD8KBiow=
X-Google-Smtp-Source: ABdhPJxC5fTcOvYLZmJ/HXGRY7H+IQxpF1t263IuhWLGH/ZzDoRZLfOmqrHqyMONm4cYo7iSFtlPNwLD6itP3bD8rGU=
X-Received: by 2002:aca:1712:: with SMTP id j18mr9290681oii.33.1634906544704;
 Fri, 22 Oct 2021 05:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211021165119.2136543-1-ardb@kernel.org> <20211021165119.2136543-2-ardb@kernel.org>
In-Reply-To: <20211021165119.2136543-2-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 Oct 2021 14:42:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEuYfQCPL9ERg=-aRLZzLz411vEjCvua+d+kK+EE8PN7Q@mail.gmail.com>
Message-ID: <CAMj1kXEuYfQCPL9ERg=-aRLZzLz411vEjCvua+d+kK+EE8PN7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] [ARM] Add support for TLS register based stack
 protector canary access
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        thomas.preudhomme@celest.fr, adhemerval.zanella@linaro.org,
        Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        gcc-patches@gcc.gnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 21 Oct 2021 at 18:51, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Add support for accessing the stack canary value via the TLS register,
> so that multiple threads running in the same address space can use
> distinct canary values. This is intended for the Linux kernel running in
> SMP mode, where processes entering the kernel are essentially threads
> running the same program concurrently: using a global variable for the
> canary in that context is problematic because it can never be rotated,
> and so the OS is forced to use the same value as long as it remains up.
>
> Using the TLS register to index the stack canary helps with this, as it
> allows each CPU to context switch the TLS register along with the rest
> of the process, permitting each process to use its own value for the
> stack canary.
>
> 2021-10-21 Ard Biesheuvel <ardb@kernel.org>
>
>         * config/arm/arm-opts.h (enum stack_protector_guard): New
>         * config/arm/arm-protos.h (arm_stack_protect_tls_canary_mem):
>         New
>         * config/arm/arm.c (TARGET_STACK_PROTECT_GUARD): Define
>         (arm_option_override_internal): Handle and put in error checks
>         for stack protector guard options.
>         (arm_option_reconfigure_globals): Likewise
>         (arm_stack_protect_tls_canary_mem): New
>         (arm_stack_protect_guard): New
>         * config/arm/arm.md (stack_protect_set): New
>         (stack_protect_set_tls): Likewise
>         (stack_protect_test): Likewise
>         (stack_protect_test_tls): Likewise
>         * config/arm/arm.opt (-mstack-protector-guard): New
>         (-mstack-protector-guard-offset): New.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  gcc/config/arm/arm-opts.h   |  6 ++
>  gcc/config/arm/arm-protos.h |  2 +
>  gcc/config/arm/arm.c        | 52 ++++++++++++++++
>  gcc/config/arm/arm.md       | 62 +++++++++++++++++++-
>  gcc/config/arm/arm.opt      | 22 +++++++
>  gcc/doc/invoke.texi         |  9 +++
>  6 files changed, 151 insertions(+), 2 deletions(-)
>
> diff --git a/gcc/config/arm/arm-opts.h b/gcc/config/arm/arm-opts.h
> index 5c4b62f404f7..581ba3c4fbbb 100644
> --- a/gcc/config/arm/arm-opts.h
> +++ b/gcc/config/arm/arm-opts.h
> @@ -69,4 +69,10 @@ enum arm_tls_type {
>    TLS_GNU,
>    TLS_GNU2
>  };
> +
> +/* Where to get the canary for the stack protector.  */
> +enum stack_protector_guard {
> +  SSP_TLSREG,                  /* per-thread canary in TLS register */
> +  SSP_GLOBAL                   /* global canary */
> +};
>  #endif
> diff --git a/gcc/config/arm/arm-protos.h b/gcc/config/arm/arm-protos.h
> index 9b1f61394ad7..37e80256a78d 100644
> --- a/gcc/config/arm/arm-protos.h
> +++ b/gcc/config/arm/arm-protos.h
> @@ -195,6 +195,8 @@ extern void arm_split_atomic_op (enum rtx_code, rtx, rtx, rtx, rtx, rtx, rtx);
>  extern rtx arm_load_tp (rtx);
>  extern bool arm_coproc_builtin_available (enum unspecv);
>  extern bool arm_coproc_ldc_stc_legitimate_address (rtx);
> +extern rtx arm_stack_protect_tls_canary_mem (void);
> +
>
>  #if defined TREE_CODE
>  extern void arm_init_cumulative_args (CUMULATIVE_ARGS *, tree, rtx, tree);
> diff --git a/gcc/config/arm/arm.c b/gcc/config/arm/arm.c
> index c4ff06b087eb..0bf06e764dbb 100644
> --- a/gcc/config/arm/arm.c
> +++ b/gcc/config/arm/arm.c
> @@ -829,6 +829,9 @@ static const struct attribute_spec arm_attribute_table[] =
>
>  #undef TARGET_MD_ASM_ADJUST
>  #define TARGET_MD_ASM_ADJUST arm_md_asm_adjust
> +
> +#undef TARGET_STACK_PROTECT_GUARD
> +#define TARGET_STACK_PROTECT_GUARD arm_stack_protect_guard
>
>  /* Obstack for minipool constant handling.  */
>  static struct obstack minipool_obstack;
> @@ -3155,6 +3158,26 @@ arm_option_override_internal (struct gcc_options *opts,
>    if (TARGET_THUMB2_P (opts->x_target_flags))
>      opts->x_inline_asm_unified = true;
>
> +  if (arm_stack_protector_guard == SSP_GLOBAL
> +      && opts->x_arm_stack_protector_guard_offset_str)
> +    {
> +      error ("incompatible options %'-mstack-protector-guard=global%' and"
> +            "%'-mstack-protector-guard-offset=%qs%'",
> +            arm_stack_protector_guard_offset_str);
> +    }
> +
> +  if (opts->x_arm_stack_protector_guard_offset_str)
> +    {
> +      char *end;
> +      const char *str = arm_stack_protector_guard_offset_str;
> +      errno = 0;
> +      long offs = strtol (arm_stack_protector_guard_offset_str, &end, 0);
> +      if (!*str || *end || errno)
> +       error ("%qs is not a valid offset in %qs", str,
> +              "-mstack-protector-guard-offset=");
> +      arm_stack_protector_guard_offset = offs;
> +    }
> +
>  #ifdef SUBTARGET_OVERRIDE_INTERNAL_OPTIONS
>    SUBTARGET_OVERRIDE_INTERNAL_OPTIONS;
>  #endif
> @@ -3822,6 +3845,10 @@ arm_option_reconfigure_globals (void)
>        else
>         target_thread_pointer = TP_SOFT;
>      }
> +
> +  if (arm_stack_protector_guard == SSP_TLSREG
> +      && target_thread_pointer != TP_CP15)
> +    error("%'-mstack-protector-guard=tls%' needs a hardware TLS register");
>  }
>
>  /* Perform some validation between the desired architecture and the rest of the
> @@ -8087,6 +8114,19 @@ legitimize_pic_address (rtx orig, machine_mode mode, rtx reg, rtx pic_reg,
>  }
>
>
> +rtx
> +arm_stack_protect_tls_canary_mem (void)
> +{
> +  rtx tp = gen_reg_rtx (SImode);
> +  emit_insn (gen_load_tp_hard (tp));
> +
> +  rtx reg = gen_reg_rtx (SImode);
> +  rtx offset = GEN_INT (arm_stack_protector_guard_offset);
> +  emit_set_insn (reg, gen_rtx_PLUS (SImode, tp, offset));
> +  return gen_rtx_MEM (SImode, reg);
> +}
> +
> +
>  /* Whether a register is callee saved or not.  This is necessary because high
>     registers are marked as caller saved when optimizing for size on Thumb-1
>     targets despite being callee saved in order to avoid using them.  */
> @@ -34054,6 +34094,18 @@ arm_run_selftests (void)
>  #define TARGET_RUN_TARGET_SELFTESTS selftest::arm_run_selftests
>  #endif /* CHECKING_P */
>
> +/* Implement TARGET_STACK_PROTECT_GUARD. In case of a
> +   global variable based guard use the default else
> +   return a null tree.  */
> +static tree
> +arm_stack_protect_guard (void)
> +{
> +  if (arm_stack_protector_guard == SSP_GLOBAL)
> +    return default_stack_protect_guard ();
> +
> +  return NULL_TREE;
> +}
> +
>  /* Worker function for TARGET_MD_ASM_ADJUST, while in thumb1 mode.
>     Unlike the arm version, we do NOT implement asm flag outputs.  */
>
> diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
> index 4adc976b8b67..54b0f145d5ab 100644
> --- a/gcc/config/arm/arm.md
> +++ b/gcc/config/arm/arm.md
> @@ -9183,7 +9183,7 @@ (define_expand "stack_protect_combined_set"
>                       UNSPEC_SP_SET))
>        (clobber (match_scratch:SI 2 ""))
>        (clobber (match_scratch:SI 3 ""))])]
> -  ""
> +  "arm_stack_protector_guard == SSP_GLOBAL"
>    ""
>  )
>
> @@ -9267,7 +9267,7 @@ (define_expand "stack_protect_combined_test"
>        (clobber (match_scratch:SI 3 ""))
>        (clobber (match_scratch:SI 4 ""))
>        (clobber (reg:CC CC_REGNUM))])]
> -  ""
> +  "arm_stack_protector_guard == SSP_GLOBAL"
>    ""
>  )
>
> @@ -9361,6 +9361,64 @@ (define_insn "arm_stack_protect_test_insn"
>     (set_attr "arch" "t,32")]
>  )
>
> +(define_expand "stack_protect_set"
> +  [(match_operand:SI 0 "memory_operand")
> +   (match_operand:SI 1 "memory_operand")]
> +  "arm_stack_protector_guard == SSP_TLSREG"
> +  "
> +{
> +  operands[1] = arm_stack_protect_tls_canary_mem ();
> +  emit_insn (gen_stack_protect_set_tls (operands[0], operands[1]));
> +  DONE;
> +}"
> +)
> +
> +;; DO NOT SPLIT THIS PATTERN.  It is important for security reasons that the
> +;; canary value does not live beyond the life of this sequence.
> +(define_insn "stack_protect_set_tls"
> +  [(set (match_operand:SI 0 "memory_operand" "=m")
> +       (unspec:SI [(match_operand:SI 1 "memory_operand" "m")]
> +        UNSPEC_SP_SET))
> +   (set (match_scratch:SI 2 "=&r") (const_int 0))]
> +  ""
> +  "ldr\\t%2, %1\;str\\t%2, %0\;mov\t%2, #0"
> +  [(set_attr "length" "12")
> +   (set_attr "conds" "nocond")
> +   (set_attr "type" "multiple")]
> +)
> +
> +(define_expand "stack_protect_test"
> +  [(match_operand:SI 0 "memory_operand")
> +   (match_operand:SI 1 "memory_operand")
> +   (match_operand:SI 2)]
> +  "arm_stack_protector_guard == SSP_TLSREG"
> +  "
> +{
> +  operands[1] = arm_stack_protect_tls_canary_mem ();
> +  emit_insn (gen_stack_protect_test_tls (gen_reg_rtx (SImode),
> +                                        operands[0], operands[1]));
> +
> +  rtx cc_reg = gen_rtx_REG (CC_Zmode, CC_REGNUM);
> +  rtx eq = gen_rtx_EQ (CC_Zmode, cc_reg, const0_rtx);
> +  emit_jump_insn (gen_arm_cond_branch (operands[2], eq, cc_reg));
> +  DONE;
> +}"
> +)
> +
> +(define_insn "stack_protect_test_tls"
> +  [(set (match_operand:SI 0 "register_operand" "=r")
> +       (unspec:SI [(match_operand:SI 1 "memory_operand" "m")
> +                   (match_operand:SI 2 "memory_operand" "m")]
> +        UNSPEC_SP_TEST))
> +   (clobber (match_scratch:SI 3 "=&r"))
> +   (clobber (reg:CC CC_REGNUM))]

This should be sth along the lines of

[(set (reg:CC_Z CC_REGNUM)
     (compare:CC_Z (unspec:SI [(match_operand:SI 0 "memory_operand" "m")
                               (match_operand:SI 1 "memory_operand" "m")]
                              UNSPEC_SP_TEST)
                   (const_int 0)))
 (clobber (match_scratch:SI 2 "=&r"))
 (clobber (match_scratch:SI 3 "=&r"))]

(with the indexes below fixed up accordingly).

> +  ""
> +  "ldr\t%3, %1\;ldr\t%0, %2\;eors\t%0, %3, %0\;mov\t%3, #0"
> +  [(set_attr "length" "16")
> +   (set_attr "conds" "set")
> +   (set_attr "type" "multiple")]
> +)
> +
>  (define_expand "casesi"
>    [(match_operand:SI 0 "s_register_operand")   ; index to jump on
>     (match_operand:SI 1 "const_int_operand")    ; lower bound
> diff --git a/gcc/config/arm/arm.opt b/gcc/config/arm/arm.opt
> index a7677eeb45c8..4b3e17bc319c 100644
> --- a/gcc/config/arm/arm.opt
> +++ b/gcc/config/arm/arm.opt
> @@ -311,3 +311,25 @@ Generate code which uses the core registers only (r0-r14).
>  mfdpic
>  Target Mask(FDPIC)
>  Enable Function Descriptor PIC mode.
> +
> +mstack-protector-guard=
> +Target RejectNegative Joined Enum(stack_protector_guard) Var(arm_stack_protector_guard) Init(SSP_GLOBAL)
> +Use given stack-protector guard.
> +
> +Enum
> +Name(stack_protector_guard) Type(enum stack_protector_guard)
> +Valid arguments to -mstack-protector-guard=:
> +
> +EnumValue
> +Enum(stack_protector_guard) String(tls) Value(SSP_TLSREG)
> +
> +EnumValue
> +Enum(stack_protector_guard) String(global) Value(SSP_GLOBAL)
> +
> +mstack-protector-guard-offset=
> +Target Joined RejectNegative String Var(arm_stack_protector_guard_offset_str)
> +Use an immediate to offset from the TLS register. This option is for use with
> +fstack-protector-guard=tls and not for use in user-land code.
> +
> +TargetVariable
> +long arm_stack_protector_guard_offset = 0
> diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> index 6d1e328571a0..d0b9b22da20e 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -810,6 +810,7 @@ Objective-C and Objective-C++ Dialects}.
>  -mpure-code @gol
>  -mcmse @gol
>  -mfix-cmse-cve-2021-35465 @gol
> +-mstack-protector-guard=@var{guard} -mstack-protector-guard-offset=@var{offset} @gol
>  -mfdpic}
>
>  @emph{AVR Options}
> @@ -20936,6 +20937,14 @@ enabled by default when the option @option{-mcpu=} is used with
>  @code{cortex-m33}, @code{cortex-m35p} or @code{cortex-m55}.  The option
>  @option{-mno-fix-cmse-cve-2021-35465} can be used to disable the mitigation.
>
> +@item -mstack-protector-guard=@var{guard}
> +@itemx -mstack-protector-guard-offset=@var{offset}
> +@opindex mstack-protector-guard
> +@opindex mstack-protector-guard-offset
> +Generate stack protection code using canary at @var{guard}.  Supported
> +locations are @samp{global} for a global canary or @samp{tls} for a
> +canary accessible via the TLS register.
> +
>  @item -mfdpic
>  @itemx -mno-fdpic
>  @opindex mfdpic
> --
> 2.30.2
>
