Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F4BECAAD4
	for <linux-hardening@archiver.kernel.org>; Mon, 29 Aug 2022 21:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiH2VUF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2VUE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 29 Aug 2022 17:20:04 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3DE14039
        for <linux-hardening@vger.kernel.org>; Mon, 29 Aug 2022 14:20:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q3so5993633pjg.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Aug 2022 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=7qls1+YFgdHoWEPQNmxr1ABnrXfeVNJORYv4KETXaJw=;
        b=KN3FcLNOJnJN0y2qtOjDU2oTh7hydSZIVuf7JZC5n+MWm4t6qiTo51dwcJGuLSZuoo
         /DbJw9VEITHb6qoU1XRG/kSZ48KoBsDa7AsnzMyxS/7mppcwlkogrSrJyyVxG2XspaO4
         JfhUjrbpF2smMWHKBFc6mJY2nxL+NO8FSnlUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7qls1+YFgdHoWEPQNmxr1ABnrXfeVNJORYv4KETXaJw=;
        b=TOsWqjIUJwtfVRvCK8H93VJfFeTpK3Kme+6pFgvml3m4k4MfRhywnUS1PWUu/mGpnz
         xAHQn0hurv1z0ABL3rsulryAJY5+BUQSSEfRV6GEiIMDWGwF1QxbxOMZvTRvy90uiIMx
         p53jtfeWoDmJmgALRVAO+qsU0kzJJdOt0ffaHvk5M/CQ9W4CV33dp2hVHRe+2VAIKY61
         q3ANIIXpdMaM/w2ScG8+N9hWQelt5O0n4KsXdNPczAfPLHtTs2gY6Pu9byDCCLgMGuq5
         qEEHXGozcXw9ynwPhykiunM3FfYJQG5qrSipyxey53WUHzWg3q0O4XNP6/ywvFRLAZbJ
         o54A==
X-Gm-Message-State: ACgBeo2ibJhH1JqbzhIQHWS6jOFYXvH8r4dTAPD0wGcW/MAoDqzAHaDw
        tCUgvfxJsNnMTKHc4BJiIzoGIA==
X-Google-Smtp-Source: AA6agR61jD/Sjyr7ltJWd00jEUu/v3VD1etBboWPbe5+r34fUI9U5fmqiJcx9D40DWp2f86yOrVbYQ==
X-Received: by 2002:a17:90b:3ec2:b0:1f7:3f49:17bf with SMTP id rm2-20020a17090b3ec200b001f73f4917bfmr20504510pjb.4.1661808001573;
        Mon, 29 Aug 2022 14:20:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b00174f4316c24sm1783077plg.245.2022.08.29.14.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 14:20:00 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:19:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Allow mixed type arguments
Message-ID: <202208291415.01271EA1@keescook>
References: <20220829204729.3409270-1-keescook@chromium.org>
 <d325bf21-efa4-b3e9-a0d8-3662a9f7ab1a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d325bf21-efa4-b3e9-a0d8-3662a9f7ab1a@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Aug 29, 2022 at 11:14:56PM +0200, Rasmus Villemoes wrote:
> On 29/08/2022 22.47, Kees Cook wrote:
> > When the check_[op]_overflow() helpers were introduced, all arguments were
> > required to be the same type to make the fallback macros simpler. However,
> > once the fallback macros were removed[1], it is fine to allow mixed
> > types, which makes using the helpers much more useful, as they can be
> > used to test for type-based overflows (e.g. adding two large ints but
> > storing into a u8), as would be handy in the drm core[2].
> > 
> > Remove the restriction, and add additional self-tests that exercise some
> > of the mixed-type overflow cases.
> 
> Makes sense. I'm a little worried about the implications for -stable
> backports to kernels that can still be built with gcc < 5.1, but we
> can't let that dictate what is done in mainline. And even people
> building old kernels shouldn't be using ancient compilers.

Right. I hope this will remain a theoretical problem, but if it really
comes up, the -stable patch can get some explicit type size checking or
something...

> 
> >  
> > -#define DEFINE_TEST_ARRAY(t)			\
> > -	static const struct test_ ## t {	\
> > -		t a, b;				\
> > -		t sum, diff, prod;		\
> > -		bool s_of, d_of, p_of;		\
> > -	} t ## _tests[]
> > +#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)		\
> > +	static const struct test_ ## t1 ## t2 ## t {	\
> > +		t1 a;					\
> > +		t2 b;					\
> > +		t sum, diff, prod;			\
> > +		bool s_of, d_of, p_of;			\
> > +	} t1 ## t2 ## t ## _tests[]
> 
> Can I get you to throw in some extra _, because this...
> 
> > +DEFINE_TEST_FUNC_TYPED(u32u32int, int, "%d");
> 
> ...makes my eyes hurt a little. Maybe even make it u32_u32__int, so it's
> emphasized that the order is [src op src -> tgt] and not [tgt = src op src].

Sure! Everything I tried hurt my eyes, so I opted for fewest characters.
;)

-- 
Kees Cook
