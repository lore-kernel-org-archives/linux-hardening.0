Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5C6CCA47A
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Jun 2022 09:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiFNJek (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbiFNJej (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Jun 2022 05:34:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A273B3EC
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 02:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A77D3B817DF
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 09:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6512BC341C0
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 09:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655199275;
        bh=q5fhuTL6x3cPUPMELJA7Oxk/L1HDewYADyN5rjMVXO0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YR8FRduj5Lstq1TSYWaLaOCu6bzyl9Gb8bIForv1E9560iFHkBtVe477LULeRznao
         D1zLIfNYHUeBORzWwQjbZFOxyB/Y5QmWhRbPr3TmVS0Ixiqsc45YSyMElJMKI8hc/J
         UqdvWpoHiAy3cXuqSNxpXl2bM3iTIsKimfknsgso3pBEC+UeRsch5LCQSu+9gl4JqT
         nMLDQd8VLjsgEUgwMnN4meNUql04aJRiMrH+ZCpViVWL5bXiUxPDIn/7nMFz+dj6cL
         pOkbsRiuSY7hiR2THvetQGHu4ICs9dELI8lhFWpRCo6wVfP+Vf4GYzSUTJLxyDCyCl
         9zRxR0kERoFNA==
Received: by mail-oi1-f180.google.com with SMTP id v4so314979oiv.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 02:34:35 -0700 (PDT)
X-Gm-Message-State: AOAM53351F5p5G523urgqvAqvncEf+zdTj4zYWT5eiWfKRurx4+pUmk2
        yUlsDlTG6qNrFjRaIvH10WYkSrcTqTKKfsPG2Pw=
X-Google-Smtp-Source: ABdhPJyWKCAOhXEc47NVyT04LVoT9rrNFeQs1eJLEHsJvnp0Bg5d1UBkF3LX/n8pvxJJFLLZpZbNFfuc2+GYYlsMOGk=
X-Received: by 2002:aca:aad5:0:b0:32f:3b9b:e0f with SMTP id
 t204-20020acaaad5000000b0032f3b9b0e0fmr1621993oie.228.1655199274518; Tue, 14
 Jun 2022 02:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220613144550.3760857-4-ardb@kernel.org>
 <1223d394-cd70-49be-2d27-f245c15709ef@arm.com>
In-Reply-To: <1223d394-cd70-49be-2d27-f245c15709ef@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Jun 2022 11:34:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFh2ee++UT59z5H9mNF_WO-0Ve=4aG7=CQVoKFk1MDJhQ@mail.gmail.com>
Message-ID: <CAMj1kXFh2ee++UT59z5H9mNF_WO-0Ve=4aG7=CQVoKFk1MDJhQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/26] arm64: head: move assignment of idmap_t0sz to C code
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

On Tue, 14 Jun 2022 at 11:22, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
> On 6/13/22 20:15, Ard Biesheuvel wrote:
> > Setting idmap_t0sz involves fiddling with the caches if done with the
> > MMU off. Since we will be creating an initial ID map with the MMU and
> > caches off, and the permanent ID map with the MMU and caches on, let's
> > move this assignment of idmap_t0sz out of the startup code, and replace
> > it with a macro that simply issues the three instructions needed to
> > calculate the value wherever it is needed before the MMU is turned on.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/assembler.h   | 14 ++++++++++++++
> >  arch/arm64/include/asm/mmu_context.h |  2 +-
> >  arch/arm64/kernel/head.S             | 13 +------------
> >  arch/arm64/mm/mmu.c                  |  5 ++++-
> >  arch/arm64/mm/proc.S                 |  2 +-
> >  5 files changed, 21 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> > index 8c5a61aeaf8e..9468f45c07a6 100644
> > --- a/arch/arm64/include/asm/assembler.h
> > +++ b/arch/arm64/include/asm/assembler.h
> > @@ -359,6 +359,20 @@ alternative_cb_end
> >       bfi     \valreg, \t1sz, #TCR_T1SZ_OFFSET, #TCR_TxSZ_WIDTH
> >       .endm
> >
> > +/*
> > + * idmap_get_t0sz - get the T0SZ value needed to cover the ID map
> > + *
> > + * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
> > + * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
> > + * this number conveniently equals the number of leading zeroes in
> > + * the physical address of _end.
> > + */
> > +     .macro  idmap_get_t0sz, reg
> > +     adrp    \reg, _end
> > +     orr     \reg, \reg, #(1 << VA_BITS_MIN) - 1
> > +     clz     \reg, \reg
> > +     .endm
>
> Is there any particular reason to evaluate idmap t0sz from '__end' and
> VA_BITS_MIN, instead of '__idmap_text_end', as was the case previously.
>

Ah yes, I failed to mention that. In a later patch, the ID map will
cover the entire image.

> > +
> >  /*
> >   * tcr_compute_pa_size - set TCR.(I)PS to the highest supported
> >   * ID_AA64MMFR0_EL1.PARange value
> > diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> > index 6770667b34a3..6ac0086ebb1a 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -60,7 +60,7 @@ static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
> >   * TCR_T0SZ(VA_BITS), unless system RAM is positioned very high in
> >   * physical memory, in which case it will be smaller.
> >   */
> > -extern u64 idmap_t0sz;
> > +extern int idmap_t0sz;
> >  extern u64 idmap_ptrs_per_pgd;
> >
> >  /*
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index dc07858eb673..7f361bc72d12 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -299,22 +299,11 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
> >        * physical address space. So for the ID map, use an extended virtual
> >        * range in that case, and configure an additional translation level
> >        * if needed.
> > -      *
> > -      * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
> > -      * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
> > -      * this number conveniently equals the number of leading zeroes in
> > -      * the physical address of __idmap_text_end.
> >        */
> > -     adrp    x5, __idmap_text_end
> > -     clz     x5, x5
> > +     idmap_get_t0sz x5
> >       cmp     x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
> >       b.ge    1f                      // .. then skip VA range extension
> >
> > -     adr_l   x6, idmap_t0sz
> > -     str     x5, [x6]
> > -     dmb     sy
> > -     dc      ivac, x6                // Invalidate potentially stale cache line
>
> Right, as there is no 'idmap_t0sz' variable to update, cache maintenance
> can be dropped off.
>
> > -
> >  #if (VA_BITS < 48)
> >  #define EXTRA_SHIFT  (PGDIR_SHIFT + PAGE_SHIFT - 3)
> >  #define EXTRA_PTRS   (1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 17b339c1a326..103bf4ae408d 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -43,7 +43,7 @@
> >  #define NO_CONT_MAPPINGS     BIT(1)
> >  #define NO_EXEC_MAPPINGS     BIT(2)  /* assumes FEAT_HPDS is not used */
> >
> > -u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
> > +int idmap_t0sz __ro_after_init;
>
> I guess this is just to reduce 'idmap_t0sz' memory foot print.
>

It's essentially the 2log of a u64 so it doesn't have to be a u64. The
footprint doesn't really matter, of course.


> >  u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
> >
> >  #if VA_BITS > 48
> > @@ -785,6 +785,9 @@ void __init paging_init(void)
> >                              (u64)&vabits_actual + sizeof(vabits_actual));
> >  #endif
> >
> > +     idmap_t0sz = min(63UL - __fls(__pa_symbol(_end)),
> > +                      TCR_T0SZ(VA_BITS_MIN));
> > +
>
> Just curious - but does not this also need some sync for the update
> to be visible across the system ?
>

No it does not, now that the asm macro no longer refers to the variable.

> >       map_kernel(pgdp);
> >       map_mem(pgdp);
> >
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index 972ce8d7f2c5..97cd67697212 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -470,7 +470,7 @@ SYM_FUNC_START(__cpu_setup)
> >       add             x9, x9, #64
> >       tcr_set_t1sz    tcr, x9
> >  #else
> > -     ldr_l           x9, idmap_t0sz
> > +     idmap_get_t0sz  x9
> >  #endif
> >       tcr_set_t0sz    tcr, x9
> >
>
> Avoiding one cache maintenance in __create_page_table(), now makes us
> again evaluate idmap_t0sz in __cpu_setup(), and also capture & update
> idmap_t0sz in paging_init(). This change moves idmap_t0sz outside the
> asm functions but from performance perspecive, is there an improvement ?

No, the performance is not expected to be affected, and a ~10
instruction delta at boot is not going to be measurable anyway. The
point of this patch is to remove the need to reason about how/when
variables are accessed, and whether that requires cache cleaning,
invalidation, system-wide DMBs etc.
