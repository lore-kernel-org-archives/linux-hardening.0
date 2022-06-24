Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A17CC43334
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 13:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiFXNIA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXNIA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 09:08:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0214F2DE9
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 06:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9CEEB828BD
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 13:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7635EC3411C
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656076076;
        bh=AEqxROC/+Xd4iBmtuyCRzXI+SVwaQlK6VIzjDWcdFZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fjSPNxDjxTScxrFZ8rkOu4fu9LrPkU4MqzSEOb6kR966spttdzezxyIRluPdi6CKA
         6DvIbTEGNo7Z7H3XHwag6yrP1Ay5goK2DCffRHJydMjiJBfxjtPtmIYx5DL5cNx5HE
         U2dPgYh8QKp8pt/wz8h/w+Khnz3q8i/tJG/67hLxv11iBVgmTbS2i8Ua7Ff6hn4dER
         NyNpynTW/bd1/jQYKN6ZLKsZ5FFcX0Y17Y15FQEkBGNRBhWjkDe+vdLUcKR2KCgbq2
         +o5TQ/7AJ6CZeyBWMlrYIIbfo4X3BKou1sIp9rsVY1I/5Ti9Abo5MTkiSWa9ZR3cqI
         xoCrcDgUtrUTA==
Received: by mail-oi1-f171.google.com with SMTP id u9so3492349oiv.12
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 06:07:56 -0700 (PDT)
X-Gm-Message-State: AJIora/TmAd1W3hLyzhH2bY81bAzYuF2DO1lq7i315H4cTRZ8tGDwHgR
        Ds/8EiANojBqlRbphq5fzqFLeIRXTVwP+tHSf0A=
X-Google-Smtp-Source: AGRyM1tjAAFitn4WRGbKrcHMqcyKeOpEOKlE4VBnpKInFlXuDZYlGj5OzgQaoeN+uZrEidjaNA9fAvSqQ2ql0YrShXk=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr1912078oib.126.1656076075596; Fri, 24
 Jun 2022 06:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220613144550.3760857-18-ardb@kernel.org>
 <20220624125631.GD18561@willie-the-truck>
In-Reply-To: <20220624125631.GD18561@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jun 2022 15:07:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXECtiAudxaWJG1Ve1_JJS_yc29A3cs_7CZj4F=iZ+4D+g@mail.gmail.com>
Message-ID: <CAMj1kXECtiAudxaWJG1Ve1_JJS_yc29A3cs_7CZj4F=iZ+4D+g@mail.gmail.com>
Subject: Re: [PATCH v4 17/26] arm64: head: populate kernel page tables with
 MMU and caches on
To:     Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 24 Jun 2022 at 14:56, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 04:45:41PM +0200, Ard Biesheuvel wrote:
> > Now that we can access the entire kernel image via the ID map, we can
> > execute the page table population code with the MMU and caches enabled.
> > The only thing we need to ensure is that translations via TTBR1 remain
> > disabled while we are updating the page tables the second time around,
> > in case KASLR wants them to be randomized.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/head.S | 62 +++++---------------
> >  1 file changed, 16 insertions(+), 46 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index d704d0bd8ffc..583cbea865e1 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -85,8 +85,6 @@
> >        *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
> >        *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
> >        *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
> > -      *  x28        clear_page_tables()                      callee preserved temp register
> > -      *  x19/x20    __primary_switch()                       callee preserved temp registers
> >        *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
> >        *  x28        create_idmap()                           callee preserved temp register
> >        */
> > @@ -96,9 +94,7 @@ SYM_CODE_START(primary_entry)
> >       adrp    x23, __PHYS_OFFSET
> >       and     x23, x23, MIN_KIMG_ALIGN - 1    // KASLR offset, defaults to 0
> >       bl      set_cpu_boot_mode_flag
> > -     bl      clear_page_tables
> >       bl      create_idmap
> > -     bl      create_kernel_mapping
> >
> >       /*
> >        * The following calls CPU setup code, see arch/arm64/mm/proc.S for
> > @@ -128,32 +124,14 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
> >  SYM_CODE_END(preserve_boot_args)
> >
> >  SYM_FUNC_START_LOCAL(clear_page_tables)
> > -     mov     x28, lr
> > -
> > -     /*
> > -      * Invalidate the init page tables to avoid potential dirty cache lines
> > -      * being evicted. Other page tables are allocated in rodata as part of
> > -      * the kernel image, and thus are clean to the PoC per the boot
> > -      * protocol.
> > -      */
> > -     adrp    x0, init_pg_dir
> > -     adrp    x1, init_pg_end
> > -     bl      dcache_inval_poc
> > -
> >       /*
> >        * Clear the init page tables.
> >        */
> >       adrp    x0, init_pg_dir
> >       adrp    x1, init_pg_end
> > -     sub     x1, x1, x0
> > -1:   stp     xzr, xzr, [x0], #16
> > -     stp     xzr, xzr, [x0], #16
> > -     stp     xzr, xzr, [x0], #16
> > -     stp     xzr, xzr, [x0], #16
> > -     subs    x1, x1, #64
> > -     b.ne    1b
> > -
> > -     ret     x28
> > +     sub     x2, x1, x0
> > +     mov     x1, xzr
> > +     b       __pi_memset                     // tail call
> >  SYM_FUNC_END(clear_page_tables)
> >
> >  /*
> > @@ -399,16 +377,8 @@ SYM_FUNC_START_LOCAL(create_kernel_mapping)
> >
> >       map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12, x13, x14
> >
> > -     /*
> > -      * Since the page tables have been populated with non-cacheable
> > -      * accesses (MMU disabled), invalidate those tables again to
> > -      * remove any speculatively loaded cache lines.
> > -      */
> > -     dmb     sy
> > -
> > -     adrp    x0, init_pg_dir
> > -     adrp    x1, init_pg_end
> > -     b       dcache_inval_poc                // tail call
> > +     dsb     ishst                           // sync with page table walker
> > +     ret
> >  SYM_FUNC_END(create_kernel_mapping)
> >
> >       /*
> > @@ -863,14 +833,15 @@ SYM_FUNC_END(__relocate_kernel)
> >  #endif
> >
> >  SYM_FUNC_START_LOCAL(__primary_switch)
> > -#ifdef CONFIG_RANDOMIZE_BASE
> > -     mov     x19, x0                         // preserve new SCTLR_EL1 value
> > -     mrs     x20, sctlr_el1                  // preserve old SCTLR_EL1 value
> > -#endif
> > -
> > -     adrp    x1, init_pg_dir
> > +     adrp    x1, reserved_pg_dir
> >       adrp    x2, init_idmap_pg_dir
> >       bl      __enable_mmu
> > +
> > +     bl      clear_page_tables
> > +     bl      create_kernel_mapping
> > +
> > +     adrp    x1, init_pg_dir
> > +     load_ttbr1 x1, x1, x2
> >  #ifdef CONFIG_RELOCATABLE
> >  #ifdef CONFIG_RELR
> >       mov     x24, #0                         // no RELR displacement yet
> > @@ -886,9 +857,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
> >        * to take into account by discarding the current kernel mapping and
> >        * creating a new one.
> >        */
> > -     pre_disable_mmu_workaround
> > -     msr     sctlr_el1, x20                  // disable the MMU
> > -     isb
> > +     adrp    x1, reserved_pg_dir             // Disable translations via TTBR1
> > +     load_ttbr1 x1, x1, x2
>
> I'd have thought we'd need some TLB maintenance here... is that not the
> case?
>

You mean at this particular point? We are running from the ID map with
TTBR1 translations disabled. We clear the page tables, repopulate
them, and perform a TLBI VMALLE1.

So are you saying repopulating the page tables while translations are
disabled needs to occur only after doing TLB maintenance?

> Also, it might be a tiny bit easier to clear EPD1 instead of using the
> reserved_pg_dir.
>

Right. So is there any reason in particular why it would be
appropriate here but not anywhere else? IOW, why do we have
reserved_pg_dir in the first place if we can just flick EPD1 on and
off?
