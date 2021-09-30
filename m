Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B45AC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 22:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309CC615A2
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 22:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbhI3WyJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbhI3WyI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 18:54:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EDEC06176D
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 15:52:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k24so7677696pgh.8
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ni4nyZssVA0HCPlkWl3l8E5QliLBQndePk3trvnSSHU=;
        b=OCXVRooELMPDR5vP/0FkKufYRz4/kjAycU8DNXkbNF4KEV/aczDDNSkrG1XAuXYdXo
         l5bN9q7eW3qQuJCtNlrdddP1PhgFlLzdU6xL9UNCUf8qMHHn0KQb03ABlHwApGXLGFmX
         TvgbAFLg0QUow1TdTUEZAcUFp8JC0NEpqlH3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ni4nyZssVA0HCPlkWl3l8E5QliLBQndePk3trvnSSHU=;
        b=AKRjb0lrKutz6xakUucT9PKMi6qQawTriTuH60vtBttrTTHpKw1tLRzJ8kz3sj9U8N
         0plz0Hvz3PI9SpNjUhbQek6XZ64UWejLWQn/eLEGZkIs7W+dyagSXoCe2wOIgFHulhcF
         x913XjwEGEgOmggJkiLHXqFtKM+lsjzBEDw3IbDMwd265EJ18yoAsivLvIoAVfc/ogbh
         +1c9Sa9t0xss9C3qMex6naBeuVLpJPlXawE5yMDKbhTJ81sYAFSVUa4JraQ10hhBRGVF
         6uKGOVllACK1j8dDoerXXlL4PVgmtexBoOf1Wj6J9xBubWKDKKXmJXWgEt+1BVZPpMjQ
         B5ag==
X-Gm-Message-State: AOAM532/yhjZAVPyagLCV5qYKJ5bVJMQ5KUEbSAKHUvhv4Ap/2F+7FiI
        7yT5fiKTOwVWe1ahXGONyMzziw==
X-Google-Smtp-Source: ABdhPJyoNHG1hhvA0wi/BOMWLe4d9VE1eod01oNtCdYPOhCIVx87DO3cv7o+OAsA/k4SIY6lM8H9Uw==
X-Received: by 2002:a65:47c6:: with SMTP id f6mr7150340pgs.450.1633042345253;
        Thu, 30 Sep 2021 15:52:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 126sm4510926pgi.86.2021.09.30.15.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 15:52:24 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:52:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] docs: Explain the desired position of function
 attributes
Message-ID: <202109301530.4BAFDBB1@keescook>
References: <20210930192417.1332877-1-keescook@chromium.org>
 <c273a5d9-ecd7-64fa-bf2c-af0d22c4a68c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c273a5d9-ecd7-64fa-bf2c-af0d22c4a68c@infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 01:11:34PM -0700, Randy Dunlap wrote:
> On 9/30/21 12:24 PM, Kees Cook wrote:
> > While discussing how to format the addition of various function
> > attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
> > close as possible to Linus's preferences for future reference.
> > 
> > (Though I note the dissent voiced by Joe Perches, Alexey Dobriyan, and
> > others that would prefer all attributes live on a separate leading line.)
> > 
> > [1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   Documentation/process/coding-style.rst | 30 ++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> > 
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index 42969ab37b34..6b4feb1c71e7 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -487,6 +487,36 @@ because it is a simple way to add valuable information for the reader.
> >   Do not use the ``extern`` keyword with function prototypes as this makes
> >   lines longer and isn't strictly necessary.
> > +When writing a function declarations, please keep the `order of elements regular
> > +<https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/>`_.
> > +For example::
> > +
> > + extern __init void * __must_check void action(enum magic value, size_t size,
> 
> Drop that second "void" ?  or what does it mean?
> Can __must_check and void be used together?

Gah, thanks. Fixed now in v3.

> 
> > + 	u8 count, char *fmt, ...) __printf(4, 5) __malloc;
> > +
> > +The preferred order of elements for a function prototype is:
> > +
> > +- storage class (here, ``extern``, and things like ``static __always_inline`` even though
> > +  ``__always_inline`` is technically an attribute, it is treated like ``inline``)
> > +- storage class attributes (here, ``__init`` -- i.e. section declarations, but also things like ``__cold``)
> > +- return type (here, ``void *``)
> > +- return type attributes (here, ``__must_check``)
> 
> I'm not trying to get you to change this, but I would prefer to see
> 
> extern __init __must_check void *action(...) <attributes>;
> 
> i.e., with the return type adjacent to the function name.

I have read and re-read Linus's emails, and did a frequency count in the
kernel, and it looks like the preference is [return type] [return type attrs]
but I personally agree with you. :)

# regex I built from __must_check hits...
$ re='((struct .*|void|char) \* ?|((unsigned )?(long|int)|bool|size_t)($| ))'

# type before __must_check
$ git grep -E "$re"'__must_check' | wc -l
746

# type after __must_check
$ git grep -E '\b(static (__always_)?inline )?__must_check($| '"$re"')' | wc -l
297

# type split(!) across __must_check or otherwise weird...
$ git grep -E '\b__must_check\b' | grep -Ev '\b(static (__always_)?inline )?__must_check($| '"$re"')' | grep -Ev "$re"'__must_check\b' | wc -l
44


-- 
Kees Cook
