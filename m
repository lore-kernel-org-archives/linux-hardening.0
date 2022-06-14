Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A171AC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Jun 2022 08:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiFNIfC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Jun 2022 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiFNIfB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Jun 2022 04:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD503CA52
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 01:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1852D61540
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 08:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F56C341C0
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 08:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655195699;
        bh=TDuZWw57IjVjkaJI0HVGW5nzj0Xa2Hj/z8qBzOqjYIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PCO4JuOJQL7SqE672LLlLb25v6UmzON08oLzU0+HpLHvJDaL6vILksBRBGuzc07sU
         UklNz5+6ZBNJmGknvtJwX8d7NsU5ae+Fjk0rpxhw0DeYoIn9MnIK3EWUDnvLiSRrZy
         83hxZV9JD5tOxuYEGVK/OKL5x+X3VbwIsNrmSdpVExpx41/J9f1uCGLTeH+iyhTUUY
         9GRdSNPxfCM8LiqtZH1cROmaGoSAPQKfLBZkc15MrJYxLlPJ/ZtIM9+ZzM76/M+1cg
         /qlos//m1SlbaW49T2cWrq8bkwuxd7clMPLpWvc1szGjYlHq7oZRiimjjUl9XZYYDl
         Kw3/8uJwN7URw==
Received: by mail-oi1-f182.google.com with SMTP id u9so5464433oiv.12
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 01:34:59 -0700 (PDT)
X-Gm-Message-State: AOAM533IAkI91YgZrdi21xMwWRIPVEkcin9+Osm6DM+fcS8/VO1KY/rn
        +PLmbM/QpGCWbqKjOOuI7Q/7721IHToljR9KffM=
X-Google-Smtp-Source: ABdhPJyuzWvO1IjH2igTCqmxSyqkGtW8KxnO2q3ZwjvPfJa91BaUd2uj/6JAHXMN1osbqRSDjJKsr7Tf06GpXy3Zqn4=
X-Received: by 2002:aca:aad5:0:b0:32f:3b9b:e0f with SMTP id
 t204-20020acaaad5000000b0032f3b9b0e0fmr1506387oie.228.1655195698549; Tue, 14
 Jun 2022 01:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220613144550.3760857-3-ardb@kernel.org>
 <a3fb8e67-719a-9bf6-407a-1448e3bf21e2@arm.com>
In-Reply-To: <a3fb8e67-719a-9bf6-407a-1448e3bf21e2@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Jun 2022 10:34:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFWm8MbZkhAHsTY_d63wph82CV4vrAUkkRVgcXkR+mJJw@mail.gmail.com>
Message-ID: <CAMj1kXFWm8MbZkhAHsTY_d63wph82CV4vrAUkkRVgcXkR+mJJw@mail.gmail.com>
Subject: Re: [PATCH v4 02/26] arm64: mm: make vabits_actual a build time
 constant if possible
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 14 Jun 2022 at 10:25, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
> On 6/13/22 20:15, Ard Biesheuvel wrote:
> > Currently, we only support 52-bit virtual addressing on 64k pages
>
> But going forward, will support on 4K/16K pages as well via FEAT_LPA2.
>
> > configurations, and in all other cases, vabits_actual is guaranteed to
> > equal VA_BITS (== VA_BITS_MIN). So get rid of the variable entirely in
> > that case.
>
> The change here does not really get rid of vabit_actual in those cases
> either, it just makes it a build time constant AFAICS.
>

Indeed, and so it ceases to be a variable.

> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -174,7 +174,11 @@
>  #include <linux/types.h>
>  #include <asm/bug.h>
>
> +#if VA_BITS > 48
>  extern u64                     vabits_actual;
> +#else
> +#define vabits_actual          ((u64)VA_BITS)
> +#endif
>
> >
> > While at it, move the assignment out of the asm entry code - it has no
> > need to be there.
>
> This also changes when vabits_actual gets evaluated ? Then how would it
> know, that CPU needs to be stuck in kernel (CPU_STUCK_REASON_52_BIT_VA)
> in case all secondary CPUs do not support large VA feature ? Looking at
> the sequence...
>
> secondary_entry
> OR
> secondary_holding_pen
>         secondary_startup
>                 __cpu_secondary_check52bitva
>
> primary_entry
>         __create_page_tables                    <--- original position
>         __primary_switch
>                 start_kernel
>                         setup_arch
>                                 paging_init     <--- new position
>
> It might still be possible for the secondary cpu start up sequence to
> validate LVA support across the platform, but still why even send
> vabits_actual evaluation down the line until paging_init(). Ideally
> should not it be evaluated as early as possible during boot. Hence,
> wondering - what is the real benefit here ?
>

Why should it be evaluated as early as possible? The whole point is
deferring it so we don't have to do it from asm code.

But I suppose doing it as early as possible from C code (i.e., in
setup_arch() before arm64_memblock_init() or even before
early_fixmap_init()) might be better.

> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/memory.h |  4 ++++
> >  arch/arm64/kernel/head.S        | 15 +--------------
> >  arch/arm64/mm/mmu.c             | 15 ++++++++++++++-
> >  3 files changed, 19 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index 0af70d9abede..c751cd9b94f8 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -174,7 +174,11 @@
> >  #include <linux/types.h>
> >  #include <asm/bug.h>
> >
> > +#if VA_BITS > 48
> >  extern u64                   vabits_actual;
> > +#else
> > +#define vabits_actual                ((u64)VA_BITS)
> > +#endif
> >
> >  extern s64                   memstart_addr;
> >  /* PHYS_OFFSET - the physical address of the start of memory. */
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 1cdecce552bb..dc07858eb673 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -293,19 +293,6 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
> >       adrp    x0, idmap_pg_dir
> >       adrp    x3, __idmap_text_start          // __pa(__idmap_text_start)
> >
> > -#ifdef CONFIG_ARM64_VA_BITS_52
> > -     mrs_s   x6, SYS_ID_AA64MMFR2_EL1
> > -     and     x6, x6, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
> > -     mov     x5, #52
> > -     cbnz    x6, 1f
> > -#endif
> > -     mov     x5, #VA_BITS_MIN
> > -1:
> > -     adr_l   x6, vabits_actual
> > -     str     x5, [x6]
> > -     dmb     sy
> > -     dc      ivac, x6                // Invalidate potentially stale cache line
> > -
> >       /*
> >        * VA_BITS may be too small to allow for an ID mapping to be created
> >        * that covers system RAM if that is located sufficiently high in the
> > @@ -713,7 +700,7 @@ SYM_FUNC_START(__enable_mmu)
> >  SYM_FUNC_END(__enable_mmu)
> >
> >  SYM_FUNC_START(__cpu_secondary_check52bitva)
> > -#ifdef CONFIG_ARM64_VA_BITS_52
> > +#if VA_BITS > 48
>
> Just curious - why this is any better ? Although both (VA_BITS > 48)
> and CONFIG_ARM64_VA_BITS_52 are build time constants.
>

VA_BITS > 48 is a bit more readable, and more likely to remain accurate.

> >       ldr_l   x0, vabits_actual
> >       cmp     x0, #52
> >       b.ne    2f
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 7148928e3932..17b339c1a326 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -46,8 +46,10 @@
> >  u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
> >  u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
> >
> > -u64 __section(".mmuoff.data.write") vabits_actual;
> > +#if VA_BITS > 48
> > +u64 vabits_actual __ro_after_init = VA_BITS_MIN;
> >  EXPORT_SYMBOL(vabits_actual);
> > +#endif
> >
> >  u64 kimage_vaddr __ro_after_init = (u64)&_text;
> >  EXPORT_SYMBOL(kimage_vaddr);
> > @@ -772,6 +774,17 @@ void __init paging_init(void)
> >  {
> >       pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
> >
> > +#if VA_BITS > 48
> > +     if (cpuid_feature_extract_unsigned_field(
> > +                             read_sysreg_s(SYS_ID_AA64MMFR2_EL1),
> > +                             ID_AA64MMFR2_LVA_SHIFT))
> > +             vabits_actual = VA_BITS;
> > +
> > +     /* make the variable visible to secondaries with the MMU off */
> > +     dcache_clean_inval_poc((u64)&vabits_actual,
> > +                            (u64)&vabits_actual + sizeof(vabits_actual));
> > +#endif
> > +
> >       map_kernel(pgdp);
> >       map_mem(pgdp);
> >
