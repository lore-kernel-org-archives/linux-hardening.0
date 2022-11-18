Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C934C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 16:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbiKRQnb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Nov 2022 11:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbiKRQn3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Nov 2022 11:43:29 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE934B87
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 08:43:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so8778188pjs.4
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 08:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bFpydVEsN0sToFVtM7jELuhoofQy9t2jPUFLTcIXRx8=;
        b=PHxZLY8Iha2TaDny05JWQTVe0OvBw0y5kIlu1jrIxQ+y043xEur9SKJwSXJGZdYF/C
         zq1dqTPaNBWrbbSY2FkMBWe5upYYu4TBKzmWhWP/uY+H7Mu+CtEdN3peJYoo9fHOgNqT
         R5v38A+RV3qaU4RRHUv5Htt/vmgr5kCH78AXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFpydVEsN0sToFVtM7jELuhoofQy9t2jPUFLTcIXRx8=;
        b=NEC9McwffJXXQbgGtClJVdErW7D2HZjtg46RrHipH0+LVpNk2in5Hs2Z8pjGZuCk4U
         sNSd6XGS46/g3hNPXQsPmIIqSSCT8lQvTXI405vN+Zs/4/VL2fbHmrKgNPu4LjdkOQCQ
         qJ6Vf+KiwplwZ42/Jrp60V6zLLZBUwqtzAPQy3n86Zwo7HTNagNAw+hfDyo3aZrDZTQK
         x6zSIcZcE/2WHDWOY1lR/+byRckQ9eobJb1BEZSMT73e900fPmUfwqqpf5Inlkkhbk26
         5QaCRmMQuDVlREwY5BPREb1gwmdrhLO92R2uFE6vanM9KwKqZCw4vAQ5fAEmL8Em46/c
         WcwQ==
X-Gm-Message-State: ANoB5pnOfptLZMBNGbyx4xB31vFn9wcenXFMVPpm7zzhyuvolMObwcbI
        LoCTqRd5MV0+PIe1Q9EwWpaSbstEtzEUmg==
X-Google-Smtp-Source: AA0mqf40QW2uM/mdUZtAUwUfmrT0ybXaxtav/kplbk3xWLYOjhj55pBX/fcy0ASDVHC8fxxYw0QVxA==
X-Received: by 2002:a17:902:7242:b0:17c:4ae7:cf23 with SMTP id c2-20020a170902724200b0017c4ae7cf23mr448359pll.2.1668789804136;
        Fri, 18 Nov 2022 08:43:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b0017f59ebafe7sm3928259plh.212.2022.11.18.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 08:43:20 -0800 (PST)
Date:   Fri, 18 Nov 2022 08:43:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ananda Badmaev <a.badmaev@clicknet.pro>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: zblock_alloc(): Memory - illegal accesses
Message-ID: <202211180841.39558B5E5@keescook>
References: <202211171419.FCDC8EE@keescook>
 <74337ebd-0222-2e78-9149-8fa40b0c815e@clicknet.pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74337ebd-0222-2e78-9149-8fa40b0c815e@clicknet.pro>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 18, 2022 at 04:05:36PM +0300, Ananda Badmaev wrote:
> 18.11.2022 01:20, coverity-bot пишет:
> > Coverity reported the following:
> > 
> > *** CID 1527352:  Memory - illegal accesses  (OVERRUN)
> > mm/zblock.c:320 in zblock_alloc()
> > 314     	}
> > 315     	list = &(pool->block_lists[block_type]);
> > 316
> > 317     check:
> > 318     	spin_lock(&list->lock);
> > 319     	/* check if there are free slots in cache */
> > vvv     CID 1527352:  Memory - illegal accesses  (OVERRUN)
> > vvv     Overrunning array of 10208 bytes at byte offset 10208 by dereferencing pointer "list".
> > 320     	block = cache_find_block(list);
> > 321     	if (block)
> > 322     		goto found;
> > 323     	spin_unlock(&list->lock);
> > 324
> > 325     	/* not found block with free slots try to allocate new empty block */
> > 
> > If this is a false positive, please let us know so we can mark it as
> > such, or teach the Coverity rules to be smarter. If not, please make
> > sure fixes get into linux-next. :) For patches fixing this, please
> > include these lines (but double-check the "Fixes" first):
> > 
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1527352 ("Memory - illegal accesses")
> > Fixes: 9097e28c25c8 ("mm: add zblock - new allocator for use via zpool API")
> > 
> > It looks like block_type is not checked to be < ARRAY_SIZE(block_desc)
> > after exiting the earlier loop, so the access through "list" may be past
> > the end of pool->block_lists.
> > 
> 
> There is no need for this check because it is guaranteed that this code will
> be executed only if size <= PAGE_SIZE. Since slot_size for the last list
> even exceeds PAGE_SIZE, block_type will be always valid.

Ah-ha, understood. Well, if you do want to catch it if there is ever a
typo in the block_desc values (which are not obviously >4096 without
sitting down and calculating them), perhaps add:

        if (WARN_ON(block_type >= ARRAY_SIZE(block_desc))
                return -ENOSPC;


-- 
Kees Cook
