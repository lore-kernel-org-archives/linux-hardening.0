Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E51C43334
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 14:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiFXOIn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiFXOIY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 10:08:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CF11104
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 07:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEA84B828E1
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 14:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74D1C3411C
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656079673;
        bh=OuO3IGaiMX1jyhV5Q0106ndgwz1dBc9lmNN+E1HKGBY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cgY5+FuYq43uPUn1jzs2R54gCAaE9mhDntt8s50jh39StwyBZ5yo0XioaU4sHI5x4
         cxxUSE5Jt4DiiHw2MJ041hGe4E+Sp+8eZehfiyliy4OmfNJYg9crIFFVX/Wer+mj9a
         +sq8UFVzxacBa04dGMnW+aIDgMyHFFqdzL8rG9PL3UPoI1zzecr+MpmTXB9Yvw6jYW
         gvGmv/aq/GJF997C+yU18/Q5kCsnnnyufihveR3b/gvlI3q727XfsURSO3KiCuBwCU
         HkjNd8JNPFyoIEwxihlOIy9oE+AuzJeDqyY7mBINOFYlhG/HuJxuSYOKX8yU5G6l3n
         IX36tfOGh6e2A==
Received: by mail-ot1-f53.google.com with SMTP id s20-20020a056830439400b0060c3e43b548so1938242otv.7
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 07:07:53 -0700 (PDT)
X-Gm-Message-State: AJIora/nAokL+/NIZShJ9cxhNYlt5JnE7ceAyNGyKUnPm8ql6wMu27Vo
        LBb4yPzM3SMP5LEpMd74FkwEn+lecnFdKtPSrjg=
X-Google-Smtp-Source: AGRyM1vEMM/K6j3LIG2OhERL8bSeheFnH55d2zYDIsMIh9R+f74mUI6b5FNUlOTVVYfTqhuOue5jzcud+LjGm6Lru7A=
X-Received: by 2002:a9d:37a3:0:b0:60c:5427:1f56 with SMTP id
 x32-20020a9d37a3000000b0060c54271f56mr6266545otb.71.1656079672922; Fri, 24
 Jun 2022 07:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220613144550.3760857-18-ardb@kernel.org>
 <20220624125631.GD18561@willie-the-truck> <CAMj1kXECtiAudxaWJG1Ve1_JJS_yc29A3cs_7CZj4F=iZ+4D+g@mail.gmail.com>
 <20220624132929.GH18561@willie-the-truck>
In-Reply-To: <20220624132929.GH18561@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jun 2022 16:07:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHerHnU9dUS+_T7suv5psmCrZ0HK54UnUNEtNYqSjqO5Q@mail.gmail.com>
Message-ID: <CAMj1kXHerHnU9dUS+_T7suv5psmCrZ0HK54UnUNEtNYqSjqO5Q@mail.gmail.com>
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

On Fri, 24 Jun 2022 at 15:29, Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jun 24, 2022 at 03:07:44PM +0200, Ard Biesheuvel wrote:
> > On Fri, 24 Jun 2022 at 14:56, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Jun 13, 2022 at 04:45:41PM +0200, Ard Biesheuvel wrote:
> > > > Now that we can access the entire kernel image via the ID map, we can
> > > > execute the page table population code with the MMU and caches enabled.
> > > > The only thing we need to ensure is that translations via TTBR1 remain
> > > > disabled while we are updating the page tables the second time around,
> > > > in case KASLR wants them to be randomized.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  arch/arm64/kernel/head.S | 62 +++++---------------
> > > >  1 file changed, 16 insertions(+), 46 deletions(-)
>
> [...]
>
> > > > @@ -886,9 +857,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
> > > >        * to take into account by discarding the current kernel mapping and
> > > >        * creating a new one.
> > > >        */
> > > > -     pre_disable_mmu_workaround
> > > > -     msr     sctlr_el1, x20                  // disable the MMU
> > > > -     isb
> > > > +     adrp    x1, reserved_pg_dir             // Disable translations via TTBR1
> > > > +     load_ttbr1 x1, x1, x2
> > >
> > > I'd have thought we'd need some TLB maintenance here... is that not the
> > > case?
> > >
> >
> > You mean at this particular point? We are running from the ID map with
> > TTBR1 translations disabled. We clear the page tables, repopulate
> > them, and perform a TLBI VMALLE1.
> >
> > So are you saying repopulating the page tables while translations are
> > disabled needs to occur only after doing TLB maintenance?
>
> I'm thinking about walk cache entries from the previous page-table, which
> would make the reserved_pg_dir ineffective. However, if we're clearing the
> page-table anyway, I'm not even sure why we need reserved_pg_dir at all!
>

Perhaps not. But this code is removed again two patches later so it
doesn't matter that much to begin with.

> > > Also, it might be a tiny bit easier to clear EPD1 instead of using the
> > > reserved_pg_dir.
> > >
> >
> > Right. So is there any reason in particular why it would be
> > appropriate here but not anywhere else? IOW, why do we have
> > reserved_pg_dir in the first place if we can just flick EPD1 on and
> > off?
>
> I think using a reserved (all zeroes) page-table makes sense when it
> has its own ASID, as you can switch to/from it without TLB invalidation,
> but that doesn't seem to be the case here. Anyway, no strong preference,
> I just thought it might simplify things a bit.
>

Ah right, I hadn't considered ASIDs.
