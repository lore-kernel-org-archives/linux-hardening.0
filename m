Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E6C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Nov 2022 22:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbiKQWDY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241201AbiKQWDA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 17:03:00 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8A82DEB
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 14:01:35 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g62so3072569pfb.10
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 14:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt6ioOinpgj3hMNhf3INdav13IL3VvYdTMM5tKc55hs=;
        b=fXXPpVBiRM3ejT7uJgam/jeGMEAa6qjY/UFCdVq+RMwmW9fWGZ95uguYKJegBuw7Kj
         b5epn2BfMtu+da95UodBRUu+URZA0xAqyECuJPp/zEJC3+o6fbaUAyPTvRAnSZZyqY99
         3Cv8LtU4avYofql0wQt7pl1PWpPkiaFN18M6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt6ioOinpgj3hMNhf3INdav13IL3VvYdTMM5tKc55hs=;
        b=ipc0hOSWLqqOepuIIdC4jjAhiG2QRvfk18DzFTs+I391BJqCFSU5AorBQrVo05Peof
         ED84C0xjB8A8EhJ0r52IS6g05kV/D9HgNr45XCTN7jizYRcYz5OW/h7/FR21xgNf+GFc
         von0qTgZZTO/4mucKFOzLWfj/U7O6tZmVeXCYQr5ohMNXTYDrnS8j+c2aP20hL3TdiMT
         bTEDYMbuokf04JSGwrtqh2xtGNQrDpqPQnIwJz7rGKPULEdK8Dxm1SG7HMeJyHVCEY6o
         qPAnPZkHEaElDrfDyHyisC22Ahwag4GE9y8qliP46Z205vjmfcsmXNgmQYm8GiJPDT6Y
         IzQg==
X-Gm-Message-State: ANoB5pnTM442IoAFxFzoRiksXXkOlBXtvuK10a0zwoz3+ItwK3xZwtUJ
        UElUv2rD6IgZ64dVC5DOicUA2A==
X-Google-Smtp-Source: AA0mqf6a3M4WqJQk9uaiVBtkSBfgGVUP1Kw1s4HtP1D+unruSZElFl8tOA4T4e2Wr2MKCNn3x99axw==
X-Received: by 2002:a63:4c59:0:b0:476:c490:798a with SMTP id m25-20020a634c59000000b00476c490798amr3833829pgl.564.1668722494968;
        Thu, 17 Nov 2022 14:01:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h31-20020a63575f000000b0047696938911sm1516588pgm.74.2022.11.17.14.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:01:34 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:01:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-hardening@vger.kernel.org,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
Message-ID: <202211171359.232C769E3A@keescook>
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-6-keescook@chromium.org>
 <542aa83d-6227-ea7d-2150-a74293cbf59a@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542aa83d-6227-ea7d-2150-a74293cbf59a@igalia.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 16, 2022 at 12:42:53PM -0300, Guilherme G. Piccoli wrote:
> On 11/10/2022 17:01, Kees Cook wrote:
> > Update pstore to better reflect reality of active contributors:
> > 
> > - Remove Anton and Colin (thank you for your help through the years!)
> > - Move Tony to Reviewer
> > - Add Guilherme as Reviewer
> > - Add mailing list
> > - Upgrade to Supported
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  MAINTAINERS | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Hi Kees, sorry to revamp this thread for a "tangential" topic, but it
> feels a "kinda" proper thread.
> 
> Since I was added as a reviewer on pstore (in linux-next so far), I
> started to receive a bunch of emails from ARM device-tree folks; they're
> adding ramoops entries to their DTs and looping pstore folks.
> 
> Examples:
> 
> https://lore.kernel.org/linux-hardening/20221111120156.48040-1-angelogioacchino.delregno@collabora.com/
> 
> https://lore.kernel.org/linux-hardening/20221116145616.17884-1-luca@z3ntu.xyz/
> 
> 
> Personally, I have no knowledge of these HW to evaluate if the ramoops
> setting is appropriate, so they're nop from my side, I just delete them.
> But that raises the question - are you/Tony reviewing this kind of
> change? It's not related to pstore/ramoops code, it's just users setting
> ramoops in their DTs, so seems to me a bit far from the purpose of the
> pstore entry.

I usually look at it very quickly, but I can't meaningfully positively
review it because I don't know the hardware, etc.

> What do you/Tony think about that? Likely the DT folks are following
> this entry in the MAINTAINERS to send these emails:
> 
> PSTORE FILESYSTEM
> M:      Kees Cook <keescook@chromium.org>
> [...]
> F:      include/linux/pstore*
> K:      \b(pstore|ramoops) <------
> 
> Should this be kept? Maybe only the ramoops entry could be removed?

I would like to keep it -- if something mentions pstore and ramoops, I'd
like to see it. I can't review all of it, but I'd like it to at least
show up in my inbox. :)

-- 
Kees Cook
