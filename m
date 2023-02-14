Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479DFC61DA4
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Feb 2023 17:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjBNR17 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Feb 2023 12:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjBNR14 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Feb 2023 12:27:56 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EAB3C38
        for <linux-hardening@vger.kernel.org>; Tue, 14 Feb 2023 09:27:54 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id j184so5755166pfg.10
        for <linux-hardening@vger.kernel.org>; Tue, 14 Feb 2023 09:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4z/tD1lWs3iqZhTLhoCdz9qidIMqh/iqk3ouPbYGchw=;
        b=Ys1x9uEKNmx/xFXtuBky5R7Pot5G5/ZB5NHSiX9Bho0s9k5YLk4wx+ZpSMP+I5KiAr
         8Dml4HdVk4F/JAibrLkif6ueAnnS6FBztP4o3wd2Wao5PfyIoNxZFPq+kreVvXNIyLO2
         TbAgZU2P8n6BYV1hcN4UKYDA4kjEKE6mWT3lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4z/tD1lWs3iqZhTLhoCdz9qidIMqh/iqk3ouPbYGchw=;
        b=Jf4rX2UYbQw2d/MCkn/+xhQexYZmUHmkTIJVI3hG8cIpSvwpOMK1MApMY6E++uPNXm
         ubysH05Cj9t0Hn9qSNl3LukF7RpyDUoNq672UWkQY77H7u/dpaP8ihALL9P/w2WYQNd0
         vWMPBrmwjn1rlyRws5mltHvMqOY5YgoEzqHKLLd5MkU8pbDw1127R05rQnSNARhuR54U
         0UNwsnt2GwnrL3oPmGTMSei63rrBPREROn5l8dmPlbfY40b1GlQk2kYh7hb/DO4tQ7Xd
         bRn6ol37zNJmJDHSixpxUdEHoXp3IDgcVoJ8OZ8vSS6YCHUs1NqOg4nyA4HoxVQ0YSUY
         8Ggw==
X-Gm-Message-State: AO0yUKXeMbgn3rySCmL8AIroU9y0+lyaj8e9MT5jTewA/oz/j86MupiB
        NsME2p+ZTkLRaJmQLfe15/jCVA==
X-Google-Smtp-Source: AK7set+DsC+4BbHcXcFv0KKcntwhdI7NVFQqT87ovOltDjEphAAcDPL60hNtFjP0y7pHEStkb0s/Bg==
X-Received: by 2002:aa7:9f12:0:b0:5a8:515a:eb9f with SMTP id g18-20020aa79f12000000b005a8515aeb9fmr2416399pfr.2.1676395673638;
        Tue, 14 Feb 2023 09:27:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f5-20020aa78b05000000b005a8512c9988sm10345490pfd.93.2023.02.14.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:27:53 -0800 (PST)
Message-ID: <63ebc499.a70a0220.9ac51.29ea@mx.google.com>
X-Google-Original-Message-ID: <202302140916.@keescook>
Date:   Tue, 14 Feb 2023 09:27:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Halbuer <halbuer@sra.uni-hannover.de>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: reduce lock contention of pcp buffer refill
References: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
 <20230202152501.297639031e96baad35cdab17@linux-foundation.org>
 <70fc9040-f976-0314-46e8-d9ddad82ccf5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70fc9040-f976-0314-46e8-d9ddad82ccf5@suse.cz>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 08, 2023 at 11:45:14AM +0100, Vlastimil Babka wrote:
> But I wonder also what kernel hardening folks think here - are the hardened
> kernels usually built with DEBUG_VM or debug_pagealloc enabled, or would you
> like to hook some other kernel option for keeping the checks on page/alloc
> free active? And should those checks be done on every alloc/free, including
> pcplist cached allocations?

What we're depending on for heap-related (i.e. both page allocator and
slab) hardening currently is:

- CONFIG_SLAB_FREELIST_HARDENED
	- pointer obfuscation (SLUB) -- freelist_ptr(), set_freepointer()
	- pool membership verification (SLUB and SLAB) -- cache_from_obj()
	- consecutive double free detection (SLUB and SLAB) -- __free_one()
- allocation order randomization
	- CONFIG_SLAB_FREELIST_RANDOM (SLUB and SLAB)
	- CONFIG_SHUFFLE_PAGE_ALLOCATOR (page allocator)
- memory wiping (both slab and page allocator)
	- init_on_alloc / CONFIG_INIT_ON_ALLOC_DEFAULT_ON
	- init_on_free / CONFIG_INIT_ON_FREE_DEFAULT_ON

I'd be nice to gain slab redzone verification, but that seems expensive
enough that anyone interested in that level of hardening has likely
turned on full KASAN.

-- 
Kees Cook
