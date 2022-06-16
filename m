Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEC7C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Jun 2022 11:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376382AbiFPLbi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Jun 2022 07:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiFPLbi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Jun 2022 07:31:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A0F5E74B
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 04:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6C37619B9
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 11:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2968EC36AE2
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655379096;
        bh=qmsxXBuVVUZg+KQGX3X/FI9nXdFC22b1yAE/7mrm39c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MdjCnGcQ8JvSykSUAhH4ggh23OioUENEVoIgWyDFKOm44rSLU20av97lPPkZlU9nx
         jpRe2ow2IuyPuZoSDdXQDswoX4tNs+HH8AnNvFAe7Gn3nzxQzgNAzDvWd5ymtHG6yJ
         6VkOozjze7snJ2CLuKZ5Dwo7CGTrVfBu/TEyPHplRzM5QJ/Nulz743ND3sm/R7/iQ5
         iCOHG1CWduj//6/PglPy+ixpdSIUZpMB2NWly1hLKsuIhO6LPRAiCvDFj9PCMstImX
         hetOuNZcnXgAC6qpVAmpZh4gigiwIj+IJZdVn3qy0ves3Ntz4zlbcSo38F5da18Hf4
         TlaKD7MSrg+OA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-fe539f9afbso1537168fac.5
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 04:31:36 -0700 (PDT)
X-Gm-Message-State: AJIora9d/WCp9P+7gzvsythSxkMR2JZVpBlQkWrqIYTm8jwWc8GYwHCk
        9LPFQx91fruN/Cg5yG9cchaALJtWVxbLEXG/ZOg=
X-Google-Smtp-Source: AGRyM1sFaNSlv1Be0pMK1/+l9deSRGaLWRgEMXuHUR8e3YcPKFTtUYXqszEH85LZwTsvdBfZpgU2e0FBmCw6lFe2FO4=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr2439160oan.126.1655379095285; Thu, 16
 Jun 2022 04:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220613144550.3760857-23-ardb@kernel.org>
 <202206130959.3C01F529@keescook> <CAMj1kXG8MsL5NHN61W+58Q2di1o9P3kaxUCNe4D5sXcdLhOkUQ@mail.gmail.com>
 <202206131630.B6AE6ECEA3@keescook>
In-Reply-To: <202206131630.B6AE6ECEA3@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Jun 2022 13:31:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHP8+yErY8F3wzc8=sWfqUYxCJ_AtW0_Gugng-0cpEXPA@mail.gmail.com>
Message-ID: <CAMj1kXHP8+yErY8F3wzc8=sWfqUYxCJ_AtW0_Gugng-0cpEXPA@mail.gmail.com>
Subject: Re: [PATCH v4 22/26] arm64: mm: move ro_after_init section into the
 data segment
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 14 Jun 2022 at 01:38, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 13, 2022 at 07:16:15PM +0200, Ard Biesheuvel wrote:
> > On Mon, 13 Jun 2022 at 19:00, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Jun 13, 2022 at 04:45:46PM +0200, Ard Biesheuvel wrote:
> > > > Currently, the ro_after_init sections sits right in the middle of the
> > > > text/rodata/inittext segment, making it difficult to map any of those
> > > > non-writable during early boot. So instead, move it to the start of
> > > > .data, and update the init sequences so that the section is remapped
> > > > read-only once startup completes.
> > > >
> > > > Note that this moves the entire HYP data section into .data as well -
> > > > this likely needs to remain as a single block for now, but could perhaps
> > > > split into a .rodata and .data..ro_after_init section later.
> > >
> > > If I'm reading this correctly, this means that .data..ro_after_init now
> > > lives between .data and .rodata?
> > >
> >
> > No, between .initdata and .data
>
> Ah, doesn't this mean more padding (for segment alignment) used? On other
> architectures .data..ro_after_init tried to be near the writable/read-only
> boundary so segment padding was only needed on one side (e.g. it could
> live at the end of .rodata without segment alignment but before .data
> which was segment aligned.) Then when .rodata was made read-only (after
> __init), .data..ro_after_init would also get set read-only.
>
> In this case, I think it ends up needing segment alignment both at the
> front and the end, since the .initdata and .data are freed and left
> writable, respectively?
>

We used to have

text
--
rodata
(ro_after_init)
--
inittext
--
initdata
--
data
bss

where -- are the segment boundaries, which are always aligned to 64k on arm64

After this patch, we get

text
--
rodata
--
inittext
--
initdata
--
(ro_after_init)
data
bss

so in terms of padding due to alignment, there is not a lot of difference.

The main difference here is the fact that we lose the ability to use
block mappings, but if anyone cares about that, we could work around
this by creating a separate segment for ro_after_init.
