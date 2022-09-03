Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439B1ECAAD4
	for <linux-hardening@archiver.kernel.org>; Sat,  3 Sep 2022 05:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiICFRa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 3 Sep 2022 01:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiICFR3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 3 Sep 2022 01:17:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44F7C19F
        for <linux-hardening@vger.kernel.org>; Fri,  2 Sep 2022 22:17:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u22so3696759plq.12
        for <linux-hardening@vger.kernel.org>; Fri, 02 Sep 2022 22:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UoOKaDK2nS3AZIYDtNGH/RyN8NdgueaNUM8dFk57hT0=;
        b=K0CZJOEzy7vYbA5Yucyikhh4g5ui71445ZrxyBYzmjXLV8CtIVhZks7hR9QO4qWuST
         odWoaAsxgAvqy0GEWNKwhFvpEyn1az2iGvSW6ThmtspBIu9iNA53BQr3xv78s/7j+I6q
         fyYIEcDOURf+xHNMsuu+mXyNl+v2pyCaaoLq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UoOKaDK2nS3AZIYDtNGH/RyN8NdgueaNUM8dFk57hT0=;
        b=wsWN8OdmC68744JU4tBg3uchHF0MsKk+IF0fRh7yRbNgulGq1SRyHuARLW0lmfWg8R
         CMfUn8h4K8R9Xk3s904crlBSfn1IigE/CPXQRYJuzo0YGQSZppZS805M+ZanQwrY4wx/
         y6bdO2TN2cAVmbEZd5nYUV3SVUPntQqLSep1Y18GUADHyoqclbsJp5A/W+Bc0JhdcFt3
         ERnFkc67tBbLmh9WsImy84po1F+ILffB52GGrT/Nq6eQj9z+70ZUGFhrJscteZFIlmUZ
         gm2yFTxF3CMDWhl5V4hZTLGPpE5aZeVjm3TkRfxPqqozkjuK0+aADh1v5MDV+rIDScMu
         xrYQ==
X-Gm-Message-State: ACgBeo0lKPbsCB02fgOJZu2TeIKca+nngNwIpzgivhYDbUuIrLOC9IT5
        5wkkJJF8NHrQEYItNyOiP1Q34A==
X-Google-Smtp-Source: AA6agR6CCouVq+A/WFSKpb9zc6xD/C8MabDfeRf1OmrkfU1dlIUK4F/7i892w96Vp+7QqaJ6Gh+WBQ==
X-Received: by 2002:a17:90b:4acc:b0:1f5:7f05:12e8 with SMTP id mh12-20020a17090b4acc00b001f57f0512e8mr8193494pjb.92.1662182248375;
        Fri, 02 Sep 2022 22:17:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902ed4200b00172c298ba42sm2583448plb.28.2022.09.02.22.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:17:27 -0700 (PDT)
Date:   Fri, 2 Sep 2022 22:17:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] fortify: Add KUnit test for FORTIFY_SOURCE
 internals
Message-ID: <202209022215.FA016FA6@keescook>
References: <20220902204351.2521805-1-keescook@chromium.org>
 <20220902204351.2521805-3-keescook@chromium.org>
 <CABVgOS=Ru4Eu03T71svLA=j9jizGro44n3h59pQYw33QYPfLaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=Ru4Eu03T71svLA=j9jizGro44n3h59pQYw33QYPfLaQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Sep 03, 2022 at 10:59:24AM +0800, David Gow wrote:
> On Sat, Sep 3, 2022 at 4:43 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Add lib/fortify_kunit.c KUnit test for checking the expected behavioral
> > characteristics of FORTIFY_SOURCE internals.
> > [...]
> 
> Overall, this looks good. It's a bit of a shame FORTIFY_SOURCE doesn't
> work under UML, but I tested it on everything else I had to hand and
> it looked good.

It looks like this was never picked up:
https://lore.kernel.org/lkml/20220210003224.773957-1-keescook@chromium.org/

I suppose I could take it via the kernel hardening tree?

> One tiny typo in a comment below, but otherwise this is:
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> [...]
> > +/*
> > + * Runtime test cases for CONFIG_FORTIFY_SOURCE that aren't expected to
> > + * Oops th kernel on success. (For those, see drivers/misc/lkdtm/fortify.c)
> 
> Nit: Oops _the_ kernel

Thanks! I'll get that updated. :)

-- 
Kees Cook
