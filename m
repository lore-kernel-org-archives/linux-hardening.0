Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E8CC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 13:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiFXN3j (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiFXN3i (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 09:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4193CFD2
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 06:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E4861F10
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 13:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7FCC34114;
        Fri, 24 Jun 2022 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656077376;
        bh=cAb5oUnOcuCQcw4w6bjlAWVkkSzlLDS6e5+2ZbEuF3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huI3CCVgbCKwey58VSplP7RaIUNB4jvALXWUpFYdce/UD4+16gOQxrcsoGrMCK287
         MEbbYS/W/h7n8lbfH6sLKQb/CFqTS1naT1zBRxlgwNN5zwOdbzJArHuRqo0vV0Ue1h
         54YSBYQJu1aNz2hUQ4l4wlXF24jf7tlHdatMFXQKygtMtiiTElXlngyKjb4A0RTO4K
         Nqne88DYizttnbl4G1TFdfUfriwiZAFYr7+/jet64jlpDKnovy1626uBovA1s8g50b
         7fmmdxDIJbOYJdBTZLCvXC5ZTC12Tq307GO2jC815awTEfYO/BptXd3Bhu4D4X4S7i
         hDG7bycQdOxyg==
Date:   Fri, 24 Jun 2022 14:29:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 17/26] arm64: head: populate kernel page tables with
 MMU and caches on
Message-ID: <20220624132929.GH18561@willie-the-truck>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-18-ardb@kernel.org>
 <20220624125631.GD18561@willie-the-truck>
 <CAMj1kXECtiAudxaWJG1Ve1_JJS_yc29A3cs_7CZj4F=iZ+4D+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXECtiAudxaWJG1Ve1_JJS_yc29A3cs_7CZj4F=iZ+4D+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jun 24, 2022 at 03:07:44PM +0200, Ard Biesheuvel wrote:
> On Fri, 24 Jun 2022 at 14:56, Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Jun 13, 2022 at 04:45:41PM +0200, Ard Biesheuvel wrote:
> > > Now that we can access the entire kernel image via the ID map, we can
> > > execute the page table population code with the MMU and caches enabled.
> > > The only thing we need to ensure is that translations via TTBR1 remain
> > > disabled while we are updating the page tables the second time around,
> > > in case KASLR wants them to be randomized.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/arm64/kernel/head.S | 62 +++++---------------
> > >  1 file changed, 16 insertions(+), 46 deletions(-)

[...]

> > > @@ -886,9 +857,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
> > >        * to take into account by discarding the current kernel mapping and
> > >        * creating a new one.
> > >        */
> > > -     pre_disable_mmu_workaround
> > > -     msr     sctlr_el1, x20                  // disable the MMU
> > > -     isb
> > > +     adrp    x1, reserved_pg_dir             // Disable translations via TTBR1
> > > +     load_ttbr1 x1, x1, x2
> >
> > I'd have thought we'd need some TLB maintenance here... is that not the
> > case?
> >
> 
> You mean at this particular point? We are running from the ID map with
> TTBR1 translations disabled. We clear the page tables, repopulate
> them, and perform a TLBI VMALLE1.
> 
> So are you saying repopulating the page tables while translations are
> disabled needs to occur only after doing TLB maintenance?

I'm thinking about walk cache entries from the previous page-table, which
would make the reserved_pg_dir ineffective. However, if we're clearing the
page-table anyway, I'm not even sure why we need reserved_pg_dir at all!

> > Also, it might be a tiny bit easier to clear EPD1 instead of using the
> > reserved_pg_dir.
> >
> 
> Right. So is there any reason in particular why it would be
> appropriate here but not anywhere else? IOW, why do we have
> reserved_pg_dir in the first place if we can just flick EPD1 on and
> off?

I think using a reserved (all zeroes) page-table makes sense when it
has its own ASID, as you can switch to/from it without TLB invalidation,
but that doesn't seem to be the case here. Anyway, no strong preference,
I just thought it might simplify things a bit.

Will
