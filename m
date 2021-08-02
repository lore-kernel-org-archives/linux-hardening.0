Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371DBC4320A
	for <linux-hardening@archiver.kernel.org>; Mon,  2 Aug 2021 16:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1347C6100A
	for <linux-hardening@archiver.kernel.org>; Mon,  2 Aug 2021 16:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhHBQNV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhHBQNU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 2 Aug 2021 12:13:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6549FC06175F
        for <linux-hardening@vger.kernel.org>; Mon,  2 Aug 2021 09:13:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so6640719pjs.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Aug 2021 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N9riSg2fac+VoTKhkzLfWrBDE+0l5wS73gV2Grz1oJo=;
        b=DZtWqGU4zIj2q2wG2EX5uEXZEA37v3g9XZl91m6pb2VzC3ia/H4tD9JI9GNfFao4oJ
         ux+Po8ZNy3yzxrxivaS1i9Y9Iedzp6zoD6awc7A9RtIUdPF3ByWUG7ysQqyOixB+OFvl
         JTV2EJdKVt+T2yv3QT+4JLrXz/EOknP/1IMDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N9riSg2fac+VoTKhkzLfWrBDE+0l5wS73gV2Grz1oJo=;
        b=MRUtxLkLXsxpatOmQMwZmo28grjho0A+ha0kjDUfyS/B1pwJX7B/6vOQYtpKEppj/A
         bJnPUybjkpd2Biy+5dSNsLvfeIfyA+Dlf/9EQp+OAsNO+ruWbG/oVZKzkgpqvGj1ZNhu
         jQg70+qGgQJch9lCBI4yqSM9I09cwHVhYqSsSO0O8+DAuAvpYXwdSR/fPi3nXBR8tsVi
         YJwk/iw6Y18E7aOfCv2kucnstrA1HNYHk4XGX0aOu3Zv3BddFJX2sS1yHdWsFUCeu1Qg
         CnZcJmCAbRykTCh99WW5lrxR3JVOJtUyQ/XcWWw+W5QFaR4YlaGp7kXdIsv70J3U7Rbk
         wTjQ==
X-Gm-Message-State: AOAM532jtFDz8HFbbkINNLoELKKhMIvb9ttpfUn5hD3PVlPQICfk6v06
        0/2RK8ZKYQRcY8NTbUftGf/ngw==
X-Google-Smtp-Source: ABdhPJwzHMx3iRd4NLHmuMWHjpb/4Amiy4/Pkj9WGz085r9gFSYGpW9rTPrZa44cpxRJZC226SXyyA==
X-Received: by 2002:a17:90a:ab0b:: with SMTP id m11mr17527651pjq.221.1627920789933;
        Mon, 02 Aug 2021 09:13:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v30sm10717478pgk.25.2021.08.02.09.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:13:09 -0700 (PDT)
Date:   Mon, 2 Aug 2021 09:13:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Len Baker <len.baker@gmx.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-hardening@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/input: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <202108020912.3807510B4B@keescook>
References: <20210801144316.12841-1-len.baker@gmx.com>
 <20210801145959.GI22278@shell.armlinux.org.uk>
 <922b0d99b6397adc44761abaed12c019dc0b9e88.camel@perches.com>
 <4962ac72a94bc5826960dab855b5e2f47a4d1b9a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4962ac72a94bc5826960dab855b5e2f47a4d1b9a.camel@perches.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Aug 01, 2021 at 09:55:28AM -0700, Joe Perches wrote:
> On Sun, 2021-08-01 at 09:39 -0700, Joe Perches wrote:
> > On Sun, 2021-08-01 at 16:00 +0100, Russell King (Oracle) wrote:
> > > On Sun, Aug 01, 2021 at 04:43:16PM +0200, Len Baker wrote:
> > > > strcpy() performs no bounds checking on the destination buffer. This
> > > > could result in linear overflows beyond the end of the buffer, leading
> > > > to all kinds of misbehaviors. The safe replacement is strscpy().
> []
> > > So if the string doesn't fit, it's fine to silently truncate it?
> > > 
> > > Rather than converting every single strcpy() in the kernel to
> > > strscpy(), maybe there should be some consideration given to how the
> > > issue of a strcpy() that overflows the buffer should be handled.
> > > E.g. in the case of a known string such as the above, if it's longer
> > > than the destination, should we find a way to make the compiler issue
> > > a warning at compile time?
> 
> (apologies for the earlier blank reply, sometimes I dislike my email client)
> 
> stracpy could do that with a trivial addition like below:
> 
> Old lkml references:
> 
> https://lore.kernel.org/lkml/cover.1563889130.git.joe@perches.com/
> and
> https://lore.kernel.org/lkml/56dc4de7e0db153cb10954ac251cb6c27c33da4a.camel@perches.com/
> 
> But Linus T wants a copy_string mechanism instead:
> https://lore.kernel.org/lkml/CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com/
> 
> /**
>  * stracpy - Copy a C-string into an array of char/u8/s8 or equivalent
>  * @dest: Where to copy the string, must be an array of char and not a pointer
>  * @src: String to copy, may be a pointer or const char array
>  *
>  * Helper for strscpy().
>  * Copies a maximum of sizeof(@dest) bytes of @src with %NUL termination.
>  *
>  * A BUILD_BUG_ON is used for cases where @dest is not a char array or
>  * @src is a char array and is larger than @dest.
>  *
>  * Returns:
>  * * The number of characters copied (not including the trailing %NUL)
>  * * -E2BIG if @dest is a zero size array or @src was truncated.
>  */
> #define stracpy(dest, src)						\
> ({									\
> 	BUILD_BUG_ON(!(__same_type(dest, char[]) ||			\
> 		       __same_type(dest, unsigned char[]) ||		\
> 		       __same_type(dest, signed char[])));		\
> 	BUILD_BUG_ON((__same_type(src, char[]) ||			\
> 		      __same_type(src, unsigned char[]) ||		\
> 		      __same_type(src, signed char[])) &&		\
> 		     ARRAY_SIZE(src) > ARRAY_SIZE(dest));		\
> 									\
> 	strscpy(dest, src, ARRAY_SIZE(dest));				\
> })

I'm wondering, instead, if we could convert strcpy() into this instead
of adding another API? I.e. convert all the places that warn (if this
were strcpy), and then land the conversion.

-- 
Kees Cook
