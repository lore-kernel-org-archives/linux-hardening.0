Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB2C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 14:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiFXOkf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiFXOkd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 10:40:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711EB67E58
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 07:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A9FEB82928
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 14:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2578C34114
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656081629;
        bh=wqqC+Sl/QvDz6aEMg+QncwWVY/RZj/e3vSpkojG6rXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mL/qEgf+txlTP9KLdfx3Mlky/et4Ot/Oh7F4bROnDOYLsh5s1Uy6Q5aHWKbaDTrwe
         oxcOacWZGnXCazulre4neBxOmUvHF83HuDptYmZSYYxBDS3YB2nX64kRsQ2VYkT9Vi
         f/FbazV8BDR3wFhBOhYmSrGZipgPlBzpLDzMMksHMJjrzoYJOAYlrOFe/9+iXUFyIh
         /9v92tPsX8ENCzrcsGzB+J3QTiu4pxwRSR950tXEYDJbK2G5Xr1B1cXK8yrUZ3qWgX
         VZyWYiccVqVGM2KEMNfd7Qut67f5hc0kU6kahbXk30rjDrDt9yr0fWHJY5YZSPYmXF
         SwelpW7SlCFcQ==
Received: by mail-oi1-f171.google.com with SMTP id s124so3937013oia.0
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 07:40:29 -0700 (PDT)
X-Gm-Message-State: AJIora9tT4YT9Br03egLR83Hvdj993fVPwIttt8Yqr1eUmV0pcFXSY1r
        hzuGuc+MxcqMONh0+9UbAWdBzdM6GrvoVlhqNc8=
X-Google-Smtp-Source: AGRyM1sy/MSLXTU6IyA4prYn1m1W/73YWU32M1lhDP3lVcdOXTvvsezQIQRqyqvAcj4iggSmaQ0UHsZ7jWUGhtXKNrI=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr2142360oib.126.1656081629092; Fri, 24
 Jun 2022 07:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220624131958.GG18561@willie-the-truck>
In-Reply-To: <20220624131958.GG18561@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jun 2022 16:40:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFMG5dNwB9hSPe81KvsJdBgpyj2OqoBSh=kdafsQSW4MQ@mail.gmail.com>
Message-ID: <CAMj1kXFMG5dNwB9hSPe81KvsJdBgpyj2OqoBSh=kdafsQSW4MQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/26] arm64: refactor boot flow and add support for WXN
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

On Fri, 24 Jun 2022 at 15:20, Will Deacon <will@kernel.org> wrote:
>
> Hi Ard,
>
> On Mon, Jun 13, 2022 at 04:45:24PM +0200, Ard Biesheuvel wrote:
> > [ TL;DR this series does the following:
> >   - move variable definitions and assignments out of early asm code
> >     where possible, and get rid of explicit cache maintenance;
> >   - convert initial ID map so it covers the entire loaded image as well
> >     as the DT blob;
> >   - create the kernel mapping only once instead of twice (for KASLR),
> >     and do it with the MMU and caches on;
> >   - avoid mappings that are both writable and executable entirely;
> >   - avoid parsing the DT while the kernel text and rodata are still
> >     mapped writable;
> >   - allow WXN to be enabled (with an opt-out) so writable mappings are
> >     never executable. ]
>
> I really like this series -- it removes quite a few ugly warts from our
> boot assembly that we've collected over the years and, while functional,
> they have never been particularly satisfactory. Thank you for putting it
> together.
>
> I've left a handful of minor comments on some of the patches and if you
> can address those then I'd like to queue the first 21 patches ASAP to
> give them some more exposure before the next merge window.
>

I'll spin a v5 with just those patches, and we can revisit the
remaining work at a later time.

> The remaining patches are the WXN pieces, which I'd like to give others
> a chance to chime in on first.
>
> Cheers,
>
> Will
