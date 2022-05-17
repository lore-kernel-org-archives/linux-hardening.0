Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C99C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 17 May 2022 21:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbiEQVPq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 May 2022 17:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiEQVPp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 May 2022 17:15:45 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE5E2DEF
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 14:15:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n8so18431773plh.1
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JWJH0H3VnL630PpxKgPoS9Ozluel4tO19edpwjN9dAY=;
        b=UY58ZLPSUEWH1oW7m8vE1PZXb1XF9W65pNy+7zoChQg79UoRE+M07cnON1DfeFsiNR
         UTWXwYpV9VNT7S+u/LK2EYC4HNZQcm1aZBmLsIAwiBq8kBAwi/JRkBVnsTQdqQmygL+N
         9eJAm5HiiqC1SLddngx11AH+JvWWyw6IFRufI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JWJH0H3VnL630PpxKgPoS9Ozluel4tO19edpwjN9dAY=;
        b=RzfC6z6P7Ed3X2RbzbQOX9YvboAUn1h1n/lKdPuo8ySOIu1d50K6pFYkHQmPfQrunK
         e68cllgr/qCTIGGguUXeFR+jo+ZY5/uWjwQ9eue6Y65vkXZFDzPpr2tvr2TRXO54D5/X
         +i28f3adYkGB57pNxTTjC0Q6jc1eZF1Nxa/nHU7OIaCHiJkOfcYPoBWrTjd1heK2RdnN
         VCRsVlbxE7/seZdQrPSBuoYfAWe/dB6FkwHKDKGpVaSeY/nbBevZbLZDPb1x07RkEFJP
         zv+QmbwhlpEUCfzAyru/2Y84Cp3G2h5MmVRlwwQgOb7gbzZsnn0aMtI8exGRexpTtq5l
         p/zw==
X-Gm-Message-State: AOAM530j5LKRxm0OrDyXOqidncpQ1/jvevnUtEiVvFPSLu7l/C3DZJqx
        LGIUWPbYY+Zh02MZVJzWwxiDLockhmJJCA==
X-Google-Smtp-Source: ABdhPJzuNYcm9pMZVcLxkSWUsXlyJcOrjqGa2NwCeZoMmCo7tW1EFesxNxH8CKotizug9h3lOMpglQ==
X-Received: by 2002:a17:902:7886:b0:15f:4cc6:3196 with SMTP id q6-20020a170902788600b0015f4cc63196mr23676659pll.127.1652822143657;
        Tue, 17 May 2022 14:15:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mq7-20020a17090b380700b001cd4989ff5esm52794pjb.37.2022.05.17.14.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:15:43 -0700 (PDT)
Date:   Tue, 17 May 2022 14:15:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bitmap: Fix return values to be unsigned
Message-ID: <202205171414.D21437E7@keescook>
References: <20220517035411.31144-1-keescook@chromium.org>
 <b443e5d7-0803-cfa4-89ab-dec1637953bf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b443e5d7-0803-cfa4-89ab-dec1637953bf@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 17, 2022 at 08:49:38AM +0200, Rasmus Villemoes wrote:
> On 17/05/2022 05.54, Kees Cook wrote:
> > Both nodemask and bitmap routines had mixed return values that provided
> > potentially signed results that could never happen. This was leading to
> > the compiler getting confusing about the range of possible return values
> > (it was thinking things could be negative where they could not be). Fix
> > all the nodemask and bitmap routines that should be returning unsigned
> > (or bool) values. Silences GCC 12 warnings:
> 
> So, for the bitmap functions themselves, makes sense, and then also for
> the nodemask functions which are merely wrappers around the bitmap
> functions (or wrappers around wrappers ...). But see below.

Cool. I think I should split this into two patches.

> 
> >  
> >  #define first_node(src) __first_node(&(src))
> > -static inline int __first_node(const nodemask_t *srcp)
> > +static inline unsigned int __first_node(const nodemask_t *srcp)
> >  {
> > -	return min_t(int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
> > +	return min_t(unsigned int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
> >  }
> 
> Unrelated to the type change, but what's that min() doing there in the
> first place? Doesn't find_first_bit() already return the nbits argument
> if no "first bit" exists (i.e., the bitmap is empty)?
> 
> >  #define next_node(n, src) __next_node((n), &(src))
> > -static inline int __next_node(int n, const nodemask_t *srcp)
> > +static inline unsigned int __next_node(int n, const nodemask_t *srcp)
> >  {
> > -	return min_t(int,MAX_NUMNODES,find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
> > +	return min_t(unsigned int, MAX_NUMNODES, find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
> >  }
> 
> Same here and a few more places.
> 
> It seems to go all the way back to pre-git. Hm. Could be cleaned up
> separately I guess.

Yeah, all I find as a hint is:

/* FIXME: better would be to fix all architectures to never return
          > MAX_NUMNODES, then the silly min_ts could be dropped. */

which also predates git history.

> 
> >  
> >  #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
> > -extern int node_random(const nodemask_t *maskp);
> > +extern unsigned int node_random(const nodemask_t *maskp);
> 
> So this one I'm not convinced about. It has a documented return value of
> NUMA_NO_NODE aka -1 if the mask is empty. And since it's not a wrapper
> around a corresponding bitmap_random() (which would presumably, did it
> exist, use the "return nbits if empty" convention), there's no
> compelling reason to make its return type unsigned.

Agreed; I'll drop this change.

Thanks!

-- 
Kees Cook
