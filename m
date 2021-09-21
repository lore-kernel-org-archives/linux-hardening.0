Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C8EC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 19:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857CD61184
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 19:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhIUTJH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhIUTJG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Sep 2021 15:09:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCFBC061575
        for <linux-hardening@vger.kernel.org>; Tue, 21 Sep 2021 12:07:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so2451788pjb.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Sep 2021 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ml/B9AE3unZPxWy+Po9t2eo0Ju6Y8TZgjbb8wuz0J5c=;
        b=jAWtvCGD3Uwu9MO3kfWahPr7jL1eclROA/kmtd77QcOTYJfFk4fqSBE1+2viMb+wAI
         98A7jMhfeq+7CKWQOtuibkHwhgyCJOtw3m1Nddk5odYiwfjn0DUveaeSmnwYyOswFBen
         6fTOk6fH1GfBraI8KTvjdwRN9vEiezuC4UBYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ml/B9AE3unZPxWy+Po9t2eo0Ju6Y8TZgjbb8wuz0J5c=;
        b=VZu8ZPQlFYIJcaBya7xlhbIgRPgpxWmWDL1HC6Pll2RNPEqPj54kovG1vi1lJtiuTp
         uXD1iB4szPTzGjqLcA0jMSGedV41v6jrVZX/0sytcCEb15yadCDkCuRbEtnEWliVSnyg
         GvfT4ceR5VotV7XZp1Kg/vEaseveFQKQ8xzk1gyu/O3qOHq3SbDSww8JSN2wEzA6pMd0
         b6Gcl1iNvns8YRhpNt/TfAOwVUB57+ReyPia3b5GhTu+czD69Gbahnx7dbGw4P83mSZb
         /2h6NTpcnDnTPvUvSdmt55lvS388LXOxqPcG6fiOS9uGnrg8FrFIn6PKrNJLC9Hao3zX
         idTA==
X-Gm-Message-State: AOAM530KTM9pm0v3SaSHCiqfZTm3orLqarpr7RaENAYSLWSKP5WPUgcL
        mWsHisBbDo9HvXzsp7PyMPcb4JaB1YHUgQ==
X-Google-Smtp-Source: ABdhPJxBNntgGV1SogJHsiSuFb6EWrvFr89frBiGL/EqL3090vj0ZVg7K7OXe3sSFWAomsHAji/x4w==
X-Received: by 2002:a17:90b:4d8d:: with SMTP id oj13mr6992187pjb.226.1632251257644;
        Tue, 21 Sep 2021 12:07:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1sm3403151pjg.0.2021.09.21.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:07:36 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:07:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] overflow: Implement size_t saturating arithmetic
 helpers
Message-ID: <202109211204.75043CDF@keescook>
References: <20210920180853.1825195-1-keescook@chromium.org>
 <20210920180853.1825195-2-keescook@chromium.org>
 <aa42ebfa-03b8-93fa-e036-a7507397d0dc@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa42ebfa-03b8-93fa-e036-a7507397d0dc@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 21, 2021 at 08:51:53AM +0200, Rasmus Villemoes wrote:
> On 20/09/2021 20.08, Kees Cook wrote:
> 
> > + * Internal logic for size_mul(). Takes variable names from UNIQUE_ID
> > + * so that the local variables here will never collide with other local
> > + * variables (for example, with itself).
> > + */
> > +#define __size_mul(factor1, factor2, __factor1, __factor2, __product)	\
> > +({									\
> > +	size_t __product;						\
> > +	size_t __factor1 = (factor1);					\
> > +	size_t __factor2 = (factor2);					\
> > +	if (check_mul_overflow(__factor1, __factor2, &__product))	\
> > +		__product = SIZE_MAX;					\
> > +	__product;							\
> > +})
> > +
> 
> Why can't this just be a static inline taking and returning size_ts,
> avoiding all the unique_id ritual and triple layers of macros?

*hold face* Yeah. I've been doing so much type-agnostic macro work
lately that I completely looked past the characteristics I was
describing for this macro are ... in fact ... how functions actually
work. *sigh* Yes, I'll change all of these to just be static inlines.
If we ever need them as constant expressions, we can fix them then.

> Not that I can see that the __must_check matters much for these anyway;
> if anybody does
> 
>   size_mul(foo, bar);
> 
> that's just a statement with no side effects, so probably the compiler
> would warn anyway, or at least nobody can then go on to do anything
> "wrong". Unlike the check_*_overflow(), which have the (possibly
> wrapped) result in a output-pointer and the "did it overflow" as the
> return value, so you can do
> 
>   check_mul_overflow(a, b, &d);
>   do_stuff_with(d);
> 
> were it not for the __must_check wrapper.
> 
> [Reminder: __must_check is a bit of a misnomer, the attribute is really
> warn_unused_result, and there's no requirement that the result is part
> of the controlling expression of an if() or while() - just passing the
> result on directly to some other function counts as a "use", which is
> indeed what we do with the size wrappers.]

Yeah, all a good point. My knee-jerk reaction is to include __must_check
just because it's "free" here.

Thanks!

-Kees

-- 
Kees Cook
