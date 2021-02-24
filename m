Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AE5C433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 24 Feb 2021 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87AF964ED3
	for <linux-hardening@archiver.kernel.org>; Wed, 24 Feb 2021 15:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhBXPqe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:46:34 -0500
Received: from condef-05.nifty.com ([202.248.20.70]:47766 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbhBXOiV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 24 Feb 2021 09:38:21 -0500
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-05.nifty.com with ESMTP id 11OEO4re009799
        for <linux-hardening@vger.kernel.org>; Wed, 24 Feb 2021 23:24:04 +0900
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 11OEJiYb014000;
        Wed, 24 Feb 2021 23:19:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 11OEJiYb014000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614176385;
        bh=aJzB7OzKCqIcfX2oZSpzPUhSm27C1UAj+HvFTplVHLY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W9TsWFXxjLYF5MPcycWR1G5Jdzq6t2tRTyEfrqmG0wiUFcCROTWoJkIjQZnS0hsSk
         x951Ql8a5dP6S5gfbW/OcVpLy3A4sy/KyFx7OmwvgMTEGwZYXdvZ+C6aQMoOm/yVsw
         XnwCPXrX9qj5BE+Q+sh4NJ/AdytBplmm7k5LpJZDB861CEmbK00ofwM8sOiiwGHxc7
         2r324c6wL848GaIrNfs+YchusBXvYWK1E+NxAAoXNQDumrOvKhWbJ+0lMU+JIAf+zN
         ZwicRCSiaElTwxYATgc13KKl0IcqLmR87FJF3fnw/8HycPmKU00L4zIr3kG/bxrsE/
         6lsg/OVzN926A==
X-Nifty-SrcIP: [209.85.208.170]
Received: by mail-lj1-f170.google.com with SMTP id u4so2597785lja.3;
        Wed, 24 Feb 2021 06:19:44 -0800 (PST)
X-Gm-Message-State: AOAM533IeNYsqM0buCk7BzOZPGhByVafe8gcclQm5y+AHRi14kDjhZTe
        aetJhUAAf2rYDh+9U8Khdl2kAg6gxYp5wBTnKqY=
X-Google-Smtp-Source: ABdhPJxE5smMki5qDr7XMKjLEMk+aCLpX4qITWe4NBKwxZysjK7Z4nzfkFyXSLwj1Jg+vNG/ZiLbhr4Mq8zHEhyGB3k=
X-Received: by 2002:a2e:95cf:: with SMTP id y15mr12304603ljh.464.1614176382983;
 Wed, 24 Feb 2021 06:19:42 -0800 (PST)
MIME-Version: 1.0
References: <20210221225650.33134-1-linux@roeck-us.net> <YDOeI5+1H3T1ocmQ@osiris>
 <f35196cc-969f-21ef-0c38-dc6e13831fb0@roeck-us.net> <CAK7LNASdfvJsqq8ubpBZJ5yWPMimt=pF_GFBLTJbFytbtw8jxg@mail.gmail.com>
 <8d3de6fc-0991-9cef-d5fd-032fdbe2e85e@roeck-us.net> <YDTs4vfjezu3j7rX@osiris>
 <20210223174140.GA159796@roeck-us.net> <YDVDg/EZWjCZQn2v@osiris> <20210224014642.GA181726@roeck-us.net>
In-Reply-To: <20210224014642.GA181726@roeck-us.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 24 Feb 2021 23:19:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQcarKoBf-VGucb4KiOvJqQhjBGSRCoi7yrEp-2u634OQ@mail.gmail.com>
Message-ID: <CAK7LNAQcarKoBf-VGucb4KiOvJqQhjBGSRCoi7yrEp-2u634OQ@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: Disable GCC_PLUGIN_CYC_COMPLEXITY for s390
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 24, 2021 at 10:46 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Feb 23, 2021 at 07:03:47PM +0100, Heiko Carstens wrote:
> > On Tue, Feb 23, 2021 at 09:41:40AM -0800, Guenter Roeck wrote:
> > > > I tried to explain why we don't want to set COMPILE_TEST for s390
> > > > anymore. It overrides architecture dependencies in Kconfig, and lots
> > > > of drivers do not set dependencies for HAS_IOMEM, HAS_DMA, and friends
> > > > correctly.
> > > > This generates constantly fallout which is irrelevant for s390 and
> > > > also for other architectures. It generates just work with close to
> > > > zero benefit. For drivers which matter for s390 we still see those
> > > > errors.
> > > >
> > > > > On the other side, if that flag would be set explicitly by
> > > > > all{yes,mod}config, it would really beg for being misused. We
> > > > > might then as well add a new flag that is explicitly associated
> > > > > with all{yes,mod}config, but not with randconfig.
> > > >
> > > > I think that makes most sense, probably also have a flag that is set
> > > > for randconfig.
> > >
> > > Not sure what value such an option would have, and how it would be used.
> > > I would argue that randconfig should not set COMPILE_TEST to start with,
> > > since its purpose should be to test random valid configurations and not
> > > to compile test arbitrary (and in that case random) code. But that is
> > > a different question, and just my personal opinion.
> > >
> > > Overall, the question is what kind of additional option you would find
> > > useful for s390. You make it clear that you don't want COMPILE_TEST.
> > > At the same time, you still want all{mod,yes}config, but presumably
> > > excluding options currently restricted by !COMPILE_TEST (such as
> > > DEBUG_INFO, BPF_PRELOAD, UBSAN_TRAP, GCC_PLUGIN_CYC_COMPLEXITY,
> > > and a few others). SUPPRESS_NOISY_TESTS would not cover that, but
> > > neither would RANDCONFIG (or whatever it would be called).
> >
> > Well, if we would have e.g. RANDCONFIG, then we could probably revert
> > 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390") and
> > instead let COMPILE_TEST depend on !RANDCONFIG.
> > I think this _could_ solve all common problems we currently see.
> >
> > And it would also do what you suggested.
>
> Sounds good.
>
> Question is how one would set such a flag. The code in scripts/kconfig/conf.c
> doesn't really set COMPILE_TEST in conjunction with randconfig; that is
> just as random as all other configuration flags. Would something like
> the patch below be acceptable ?

NACK.

Such a stupid option is what I really do not want to merge.
Even allnoconfig_y is also a horrible mistake, and
I have a plan to kill it.

Only the sensible one is 'option modules'.
The others are really bad hacks.



> Thanks,
> Guenter
>
> ---
> From 301dc1746b259afce02c104ebbf3f0c37189ae4a Mon Sep 17 00:00:00 2001
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Tue, 23 Feb 2021 17:21:51 -0800
> Subject: [PATCH] kconfig: Introduce RANDCONFIG
>
> "make randconfig" is intended to be used to generate random valid
> configurations. It is supposed to verify if configuration dependencies
> are valid and compile. It is not supposed to be used as replacement
> for all{mod,yes}config.

This is just your opinion.
Each sentence should start with "I think".


>
> However, that is not currently the case. "make randconfig" treats all
> configurations randomly.

Yes, this is what randconfig should do.


> This means that "COMPILE_TEST" will be enabled
> randomly. This defeats the purpose of "make randconfig"


If you want to set particular CONFIG option(s) to a fixed value,
KCONFIG_ALLCONFIG is supported.

See Documentation/kbuild/kconfig.rst






>
> To solve the problem, introduce a RANDCONFIG configuration option
> and set it for all "randconfig" configurations. Disable COMPILE_TEST
> whenever RANDCONFIG is enabled.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  init/Kconfig               | 12 ++++++++++++
>  scripts/kconfig/confdata.c | 15 ++++++++++++---
>  scripts/kconfig/expr.h     |  1 +
>  scripts/kconfig/lexer.l    |  1 +
>  scripts/kconfig/lkc.h      |  1 +
>  scripts/kconfig/menu.c     |  5 +++++
>  scripts/kconfig/parser.y   |  6 ++++++
>  7 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index ba8bd5256980..a85099c5e383 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -111,9 +111,21 @@ config INIT_ENV_ARG_LIMIT
>           Maximum of each of the number of arguments and environment
>           variables passed to init from the kernel command line.
>
> +config RANDCONFIG
> +       bool "Compile random configurations"
> +       option randconfig_y
> +       help
> +         This option indicates that the configuration is random and used to
> +         test if configuration dependencies are valid and complete.
> +         Resulting images are not expected to be bootable on real hardware.
> +
> +         If you are a developer and want to build test random configurations,
> +         say Y here. If you are a user/distributor, say N.
> +
>  config COMPILE_TEST
>         bool "Compile also drivers which will not load"
>         depends on !UML && !S390
> +       depends on !RANDCONFIG
>         default n
>         help
>           Some drivers can be compiled on a different platform than they are
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 2568dbe16ed6..0b36cc2f702b 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -1254,10 +1254,16 @@ bool conf_set_all_new_symbols(enum conf_def_mode mode)
>                         has_changed = true;
>                         switch (mode) {
>                         case def_yes:
> -                               sym->def[S_DEF_USER].tri = yes;
> +                               if (sym->flags & SYMBOL_RANDCONFIG_Y)
> +                                       sym->def[S_DEF_USER].tri = no;
> +                               else
> +                                       sym->def[S_DEF_USER].tri = yes;
>                                 break;
>                         case def_mod:
> -                               sym->def[S_DEF_USER].tri = mod;
> +                               if (sym->flags & SYMBOL_RANDCONFIG_Y)
> +                                       sym->def[S_DEF_USER].tri = no;
> +                               else
> +                                       sym->def[S_DEF_USER].tri = mod;
>                                 break;
>                         case def_no:
>                                 if (sym->flags & SYMBOL_ALLNOCONFIG_Y)
> @@ -1267,7 +1273,10 @@ bool conf_set_all_new_symbols(enum conf_def_mode mode)
>                                 break;
>                         case def_random:
>                                 sym->def[S_DEF_USER].tri = no;
> -                               cnt = rand() % 100;
> +                               if (sym->flags & SYMBOL_RANDCONFIG_Y)
> +                                       cnt = -1;
> +                               else
> +                                       cnt = rand() % 100;
>                                 if (sym->type == S_TRISTATE) {
>                                         if (cnt < pty)
>                                                 sym->def[S_DEF_USER].tri = yes;
> diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
> index 5c3443692f34..70f4acce2b7b 100644
> --- a/scripts/kconfig/expr.h
> +++ b/scripts/kconfig/expr.h
> @@ -158,6 +158,7 @@ struct symbol {
>
>  /* Set symbol to y if allnoconfig; used for symbols that hide others */
>  #define SYMBOL_ALLNOCONFIG_Y 0x200000
> +#define SYMBOL_RANDCONFIG_Y  0x400000
>
>  #define SYMBOL_MAXLENGTH       256
>  #define SYMBOL_HASHSIZE                9973
> diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
> index 9c22cb554673..fd9cd3622ea7 100644
> --- a/scripts/kconfig/lexer.l
> +++ b/scripts/kconfig/lexer.l
> @@ -92,6 +92,7 @@ n     [A-Za-z0-9_-]
>  \\\n                   /* escaped new line */
>  \n                     return T_EOL;
>  "allnoconfig_y"                return T_ALLNOCONFIG_Y;
> +"randconfig_y"         return T_RANDCONFIG_Y;
>  "bool"                 return T_BOOL;
>  "choice"               return T_CHOICE;
>  "comment"              return T_COMMENT;
> diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
> index bee2413bda63..871a05f887f0 100644
> --- a/scripts/kconfig/lkc.h
> +++ b/scripts/kconfig/lkc.h
> @@ -110,6 +110,7 @@ void menu_add_symbol(enum prop_type type, struct symbol *sym, struct expr *dep);
>  void menu_add_option_modules(void);
>  void menu_add_option_defconfig_list(void);
>  void menu_add_option_allnoconfig_y(void);
> +void menu_add_option_randconfig_y(void);
>  void menu_finalize(struct menu *parent);
>  void menu_set_type(int type);
>
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index a5fbd6ccc006..5ec3a26566b8 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -233,6 +233,11 @@ void menu_add_option_allnoconfig_y(void)
>         current_entry->sym->flags |= SYMBOL_ALLNOCONFIG_Y;
>  }
>
> +void menu_add_option_randconfig_y(void)
> +{
> +       current_entry->sym->flags |= SYMBOL_RANDCONFIG_Y;
> +}
> +
>  static int menu_validate_number(struct symbol *sym, struct symbol *sym2)
>  {
>         return sym2->type == S_INT || sym2->type == S_HEX ||
> diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
> index 190f1117f35a..335ce0554c84 100644
> --- a/scripts/kconfig/parser.y
> +++ b/scripts/kconfig/parser.y
> @@ -46,6 +46,7 @@ static struct menu *current_menu, *current_entry;
>  %token <string> T_WORD
>  %token <string> T_WORD_QUOTE
>  %token T_ALLNOCONFIG_Y
> +%token T_RANDCONFIG_Y
>  %token T_BOOL
>  %token T_CHOICE
>  %token T_CLOSE_PAREN
> @@ -233,6 +234,11 @@ config_option: T_OPTION T_ALLNOCONFIG_Y T_EOL
>         menu_add_option_allnoconfig_y();
>  };
>
> +config_option: T_OPTION T_RANDCONFIG_Y T_EOL
> +{
> +       menu_add_option_randconfig_y();
> +};
> +
>  /* choice entry */
>
>  choice: T_CHOICE word_opt T_EOL
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
