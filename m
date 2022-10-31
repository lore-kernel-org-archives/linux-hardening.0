Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3350FA3743
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Oct 2022 15:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiJaPWz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiJaPWx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Oct 2022 11:22:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCBE11829
        for <linux-hardening@vger.kernel.org>; Mon, 31 Oct 2022 08:22:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b185so10952080pfb.9
        for <linux-hardening@vger.kernel.org>; Mon, 31 Oct 2022 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1dA0Bpm+EerGxQeSwdhCiLJP6Ims7gljy+o1neN8bH8=;
        b=gjPYLPBI8i200feYZ0JN7kv2xudySLuBdbVovx/88OFxLGQQTOQWlxUGIvUnQ1sIhW
         r3QH48FVEHI29WRQkXmuX2eostBHqqet+VmrrFCrL6byOPZ0NS1Z5PjnsjyvPJQ1GyvO
         YF/8OVMsGxxEgVOrDjqyfq/nkRGstOx/8Bci0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dA0Bpm+EerGxQeSwdhCiLJP6Ims7gljy+o1neN8bH8=;
        b=mqm/yaJGmjmW6SHq/FH5kn8ssE8GJN/QSifK1iop5HEC0h7sR91yXtH31SBq3xVeX2
         Uy0WXW98fvlSoFwn5I6czNu+JAACY4TLFUeT8SqZx2vUs5X+PgzVTbNHuCtD9UtYlw5C
         GktsGoQhmyB2HptWGPy/1JYHSr2e0cGKSF9XBMaTFz4KCugVqpSmOzbmueIR5VspsBmM
         5IKex4lzlxIjQD9CqsQF8kFtoM2C2D2/9logj9AYf97UkAeSMO1no7NiOPEr9v6rxI/m
         0b16NutlRcbTmtLo9MLEmvjaM51jzMHdNwTEtP541vh+vFwfjRLe6qHZjKlSAXdCsmxN
         lFYQ==
X-Gm-Message-State: ACrzQf1mvEo6jNoo+znr8+OJN5+tS5rOMqjTBMqKepV73NK8zoLgE5bQ
        rBrDwEme8UtqHmxB3MvpLe8RdA==
X-Google-Smtp-Source: AMsMyM50aXJ7r3X1z4lItzTdn18aYnYoL2XL75pwhE733EavEAKX8Wh7vM2fmh4Pg1j/uaWxqzL6Hw==
X-Received: by 2002:a05:6a00:15c3:b0:56c:e8d0:aaf1 with SMTP id o3-20020a056a0015c300b0056ce8d0aaf1mr14868603pfu.75.1667229771778;
        Mon, 31 Oct 2022 08:22:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ix2-20020a170902f80200b001869efb722csm4585853plb.215.2022.10.31.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:22:51 -0700 (PDT)
Date:   Mon, 31 Oct 2022 08:22:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Anders Roxell <anders.roxell@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] mempool: Do not use ksize() for poisoning
Message-ID: <202210310821.9F7AA27D12@keescook>
References: <20221028154823.you.615-kees@kernel.org>
 <20221031105514.GB69385@mutt>
 <13c4bd6e-09d3-efce-43a5-5a99be8bc96b@suse.cz>
 <Y1/l4Tacaw738UaX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/l4Tacaw738UaX@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 31, 2022 at 03:12:33PM +0000, Matthew Wilcox wrote:
> On Mon, Oct 31, 2022 at 04:00:25PM +0100, Vlastimil Babka wrote:
> > +++ b/mm/mempool.c
> > @@ -57,8 +57,10 @@ static void __check_element(mempool_t *pool, void *element, size_t size)
> >  static void check_element(mempool_t *pool, void *element)
> >  {
> >  	/* Mempools backed by slab allocator */
> > -	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
> > +	if (pool->free == mempool_kfree) {
> >  		__check_element(pool, element, (size_t)pool->pool_data);
> > +	} else if (pool->free == mempool_free_slab) {
> > +		__check_element(pool, element, kmem_cache_size(pool->pool_data));
> >  	} else if (pool->free == mempool_free_pages) {
> >  		/* Mempools backed by page allocator */
> >  		int order = (int)(long)pool->pool_data;
> 
> I had a quick look at this to be sure I understood what was going on,
> and I found a grotesque bug that has been with us since the introduction
> of check_element() in 2015.
> 
> +       if (pool->free == mempool_free_pages) {
> +               int order = (int)(long)pool->pool_data;
> +               void *addr = kmap_atomic((struct page *)element);
> +
> +               __check_element(pool, addr, 1UL << (PAGE_SHIFT + order));
> +               kunmap_atomic(addr);
> 
> kmap_atomic() and friends only map a single page.  So this is all
> nonsense for HIGHMEM kernels, GFP_HIGHMEM allocations and order > 0.
> The consequence of doing that will be calling memset(POISON_INUSE)
> on random pages that we don't own.

Ah-ha! Thank you both! Seems like the first fix should be squashed and
the latter one is separate? Or just put it all together?

-- 
Kees Cook
