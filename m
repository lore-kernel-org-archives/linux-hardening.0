Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4112DC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 10 May 2022 22:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiEJWB3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 10 May 2022 18:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiEJWB1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 10 May 2022 18:01:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D431C4A930
        for <linux-hardening@vger.kernel.org>; Tue, 10 May 2022 15:01:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k14so161131pga.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 May 2022 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i8lQi4uyiCT7jQZzDyA2atJwe0TBijGbcFdUMtd4OMM=;
        b=ZSoJ+FUKlcrZBAptXSalTXcAE2E15WyyI4QVVMM3HAvlapUWJ46fr7YKgN6pzaUcQY
         ocM7hwQDztfpxL/udshq3B24X4fB2YnaTYJkH7Gcu2gT6vAdiveOztv30KrVQdvwo8LU
         4GdOKu1d1qwkkKciPdkP3SKtIeS9tcuuQiyvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i8lQi4uyiCT7jQZzDyA2atJwe0TBijGbcFdUMtd4OMM=;
        b=VZHAyA1szTsR9kJrMukLb6jkVWC8rdc883Y9vzPKvrUk0NOJfX92baabV/sjfwXQVJ
         Uyie7q7mzroU8aoHWlsivpzEVJbYdbwOlJlIqtHi1O/Gu8PhwaSfKA+XODDRjU4y6LOS
         elrXwaLiFwXZLSKS2ov65FdtdWk+RGfNyfNZTWTxfEt1ZRj2NNzxtbU5fj9Tm1fMSzIm
         UpUgFiynKJaSTiNbCvtTVMtnDliwo/LhXleSGv2F3QhgXnVo1Oqaql6XytSmQGL9TSZb
         WcmFQtBZColPPjAXD9niWGJz9iXWISnBNvGr666nYGJEReU7hPqK2vP+4D8o0J/c/+XL
         kM4Q==
X-Gm-Message-State: AOAM530fnl86peM3vX7zgC3l5pCp7EEH8L/d+UxrL1DwrvqTQpHFFTsQ
        PAXH4vuyFmY9GGOKv75513WIBupVO8mIcg==
X-Google-Smtp-Source: ABdhPJzAvs0guM22nqTRC61X8dIP2hQy1mtahN5BxBPCgqBrEtCGruh9ewsVgBKVkVnPtLekHh0x1g==
X-Received: by 2002:a63:694a:0:b0:3aa:e962:db29 with SMTP id e71-20020a63694a000000b003aae962db29mr18341240pgc.421.1652220083930;
        Tue, 10 May 2022 15:01:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7-20020a62b407000000b0050dc7628141sm51069pfn.27.2022.05.10.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 15:01:23 -0700 (PDT)
Date:   Tue, 10 May 2022 15:01:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/usercopy: Check kmap addresses properly
Message-ID: <202205101455.24F5C046F@keescook>
References: <20220110231530.665970-1-willy@infradead.org>
 <20220110231530.665970-2-willy@infradead.org>
 <20220509203742.0f4adfa4004e51e66c1c9a20@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509203742.0f4adfa4004e51e66c1c9a20@linux-foundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 09, 2022 at 08:37:42PM -0700, Andrew Morton wrote:
> On Mon, 10 Jan 2022 23:15:27 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > If you are copying to an address in the kmap region, you may not copy
> > across a page boundary,
> 
> In the source, the destination or in both, and why may we not?

This depends on direction. For copying to userspace, the source (kmap).
For copying from userspace, the destination (kmap).

> > no matter what the size of the underlying
> > allocation.  You can't kmap() a slab page because slab pages always
> > come from low memory.

As in it'll be processed as a slab page instead of kmap by the usercopy
checks?

-- 
Kees Cook
