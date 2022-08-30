Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08341ECAAA1
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 18:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiH3SmY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiH3SmX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 14:42:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C267392F
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 11:42:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fa2so4281642pjb.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 11:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=/4wRyQVPnpm0KB4dE3umHjXeWEoivMkXwHyYZflvSps=;
        b=oHW2q7g58OU5P4I1xg11aEMvZ4GqvzNeTNxgPmTS5nkgtaLrFThhrWWIbjQSHSIibI
         KNxxW61WBoZriW6aocPIyN2bG+7apSGakrbqv8pmegKsvq6KD137k3nBMgOXLhVslzP1
         1ycSlTZi2nAe+pH0XaDiQMY3Gq4LQSuXQ1pSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/4wRyQVPnpm0KB4dE3umHjXeWEoivMkXwHyYZflvSps=;
        b=VnjM1S3guQleJjPjxe306DWcfP0OOHLfFp2/HGkr121Iu/TR6a3i7F3pZ7nPjdyets
         N4A8xWyv23DE6vm+gi1BO7Pl2wiZPye3tYKbphSgC1sn3ROeONE8VUWMTiswvi1tAx1h
         fT8viYtwaO7aTK9UOwxTpEEqXmFczgcL+wCtCHX8dEa3MGkz2Lqwemk1m2h1lOF8Eobw
         EsCS5WU1Lv6UdG03BcIM00nZ6S3dXByJH9J6G78o/lbyUfK2o4WMYNN3g5/5jS5p5o2V
         ZGjr2JG8wCC87OqFby3xVLeCCGxomO/EJuO99TKkxfq3QNA44uPzQCIA1D1kuYoT9pZD
         wQ8w==
X-Gm-Message-State: ACgBeo0VewhPZuPKVn9rfLCbW9Ohf2hJi/iljwNyA2glgHip6RaLs5lB
        Ol65G8bbrJUdEQHTr0Bp4Ia2WA==
X-Google-Smtp-Source: AA6agR5BlmQWTRcjYXPHxW7g/mCkXXJ5KQ4OLa0ngCNjDRDFz87eUdeicBGUWiZ6SHhiWRAzSV9BtQ==
X-Received: by 2002:a17:90b:4f81:b0:1fe:1716:fe20 with SMTP id qe1-20020a17090b4f8100b001fe1716fe20mr3001701pjb.63.1661884942237;
        Tue, 30 Aug 2022 11:42:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b0016bf9437766sm10198594plx.261.2022.08.30.11.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:42:20 -0700 (PDT)
Date:   Tue, 30 Aug 2022 11:42:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: Allow mixed type arguments
Message-ID: <202208301141.8CA10CA@keescook>
References: <20220829214550.3443472-1-keescook@chromium.org>
 <8d880425-72f5-6ba6-933f-b8b016da88cd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d880425-72f5-6ba6-933f-b8b016da88cd@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 30, 2022 at 08:40:25AM +0200, Andrzej Hajda wrote:
> 
> 
> On 29.08.2022 23:45, Kees Cook wrote:
> > When the check_[op]_overflow() helpers were introduced, all arguments were
> > required to be the same type to make the fallback macros simpler. However,
> > once the fallback macros were removed[1], it is fine to allow mixed
> > types, which makes using the helpers much more useful, as they can be
> > used to test for type-based overflows (e.g. adding two large ints but
> > storing into a u8), as would be handy in the drm core[2].
> > 
> > Remove the restriction, and add additional self-tests that exercise some
> > of the mixed-type overflow cases.
> > 
> > [1] https://git.kernel.org/linus/4eb6bd55cfb22ffc20652732340c4962f3ac9a91
> > [2] https://lore.kernel.org/lkml/20220824084514.2261614-2-gwan-gyeong.mun@intel.com
> > 
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2: change names to "type1_type2__output-type" for better readability (Rasmus)
> > v1: https://lore.kernel.org/lkml/20220829204729.3409270-1-keescook@chromium.org
> > ---
> >   include/linux/overflow.h |  6 ----
> >   lib/overflow_kunit.c     | 77 +++++++++++++++++++++++++++++-----------
> >   2 files changed, 57 insertions(+), 26 deletions(-)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 0eb3b192f07a..ad692fb11bf3 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -63,8 +63,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >   	typeof(a) __a = (a);			\
> >   	typeof(b) __b = (b);			\
> >   	typeof(d) __d = (d);			\
> > -	(void) (&__a == &__b);			\
> > -	(void) (&__a == __d);			\
> >   	__builtin_add_overflow(__a, __b, __d);	\
> >   }))
> 
> Is there a reason to keep all local vars?
> Why not:
> #define check_add_overflow(a, b, d)
> __must_check_overflow(__builtin_add_overflow((a), (b), (d)))

Excellent point! Those were there to avoid side-effects when doing the
type comparisons in the macro, which are being removed too. :P

-- 
Kees Cook
