Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88279C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 17 Oct 2022 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJQTkS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Oct 2022 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJQTkR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Oct 2022 15:40:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C346AEAE
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 12:40:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i3so12018587pfk.9
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E40amjbnNYxi3bHXc6L0DGbJMK1J+X/tuw892jtBoNU=;
        b=HioGEo0tu/fTff5p7+5URNAqsTkxuMUcprVmRw/RLbDP+9Ri1kpdI3gsf1OIic19gm
         xGAVgJUoBW3KWNpp6oXrIR88dslb5v5TP/lP9ayZ1ZD9mOilpohAAD5qLMSqfpEu/gRr
         2MNTC75SbLXwE0eIPwW2MqRqpQVROdq8dz3As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E40amjbnNYxi3bHXc6L0DGbJMK1J+X/tuw892jtBoNU=;
        b=gfxWYv3uxs3d2Lrdn0vrRorQdyWZ9b0BdQ2rKdmnol9SEgIAbPlUz+jQI+Q/oU11FC
         KUpay3RxY4zR6EYs7WyZ8l7fhDZtc3TwHdSDxzRjr0Y6Ba3kNeRahDxVI0VcDAE1WlPx
         BIWwHU22PscHUue0vtvsuTWq96HlwQ73s+w8b6M5YqEO5ZE+T/NvfemiYkQ1VJHoUemH
         WXqM/oN/eA5t3BDQlWIg+idaVCc452ZcB+b+yadmN8pPkQTU2+IJk/Jxa7kU/Wcp5uYA
         NHZvBtCwvsy9eOa5nY5X5YSV0HgQae9hufRF/Y/CTowCfw9c9aUOt0o0O+vs/Fg4BcCJ
         6h4A==
X-Gm-Message-State: ACrzQf2LYy93xqFW3N893emma4Osnsdps3PRcGlMoS6DhzfQcFSdIszh
        dExR9nTEwdc0TtPGpWdPvoJKeYWnnZZJNg==
X-Google-Smtp-Source: AMsMyM7bnvMYy8lgjWKpP3JrejST49cSKxLgtUin0NtvpiI8/Xeqliqk/xu678J8YtDL/Yej1GUBAQ==
X-Received: by 2002:a63:91:0:b0:461:f509:2a31 with SMTP id 139-20020a630091000000b00461f5092a31mr11831239pga.108.1666035615423;
        Mon, 17 Oct 2022 12:40:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7940e000000b0056389e00a83sm7479253pfo.63.2022.10.17.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:40:14 -0700 (PDT)
Date:   Mon, 17 Oct 2022 12:40:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Message-ID: <202210171237.DF5D4A3FD7@keescook>
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
 <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
 <202210171227.35ED875219@keescook>
 <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 17, 2022 at 09:33:06PM +0200, Ard Biesheuvel wrote:
> On Mon, 17 Oct 2022 at 21:29, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Oct 17, 2022 at 08:14:14PM +0200, Ard Biesheuvel wrote:
> > > So once we use the same size for input and output, I was curious
> > > whether we could encrypt in place, and get rid of the big_oops_buf.
> > > And the answer is 'yes', precisely because we have this horrid per-CPU
> > > allocation which serves as a bounce buffer. And this is not specific
> > > to acomp, the old comp algorithms get wrapped in scomps which receive
> > > the same treatment.
> >
> > Ah, in the sense that "in place" is actually happening in the per-cpu
> > allocation, and only if it succeeds does the input buffer get
> > overwritten?
> 
> Something like that IIRC.
> 
> > > So at that point, I wondered what the point is of all this complexity.
> > > Do we really need 6 different algorithms to compress a couple of K of
> > > ASCII text on a code path that is ice cold by definition? Wouldn't it
> > > be better to drop the crypto API altogether here, and just use GZIP
> > > via the library interface?
> >
> > Well, my goal was to make the algo "pstore doesn't care". If someone
> > picks deflate, do they still get all the per-cpu allocations?
> >
> 
> Not if you use the library interface directly.
> 
> The issue with the percpu buffers is that they are only kept if any
> scomp TFMs are active, but this is always the case for pstore, as you
> don't want to allocate it on the panic path.

Okay, so strictly speaking, eliminating the per-CPU allocation is an
improvement. Keeping scomp and doing in-place compression will let
pstore use "any" compressions method.

Is there a crypto API that does _not_ preallocate the per-CPU stuff?
Because, as you say, it's a huge amount of memory on the bigger
systems...

-- 
Kees Cook
