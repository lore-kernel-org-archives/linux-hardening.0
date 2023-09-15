Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7B3C46CA1
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 21:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjIOVDA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 17:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbjIOVCu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 17:02:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB54C271E
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 14:02:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c43b4b02c1so7843145ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 14:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694811734; x=1695416534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xIW8YzBnPzjMwFioxgcY2G/FS0UtBiM6jL3TdyU9mWA=;
        b=Ws6lioHkXmZRkCOfm4sRK9gIiGAU1M/1cX+vG1UpxKtsUFMS5tgMAk2Vty2SXot0ET
         rHR25M8Qe1bG6gO6TZazHhKLScPzHe1xL3UiZzoTP2i3nnsLwdjc7SKg7snaRht+Kp4w
         uCvuzOSqj/FnYtu4X/9iXHFedOrE3aBTbrJ6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811734; x=1695416534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIW8YzBnPzjMwFioxgcY2G/FS0UtBiM6jL3TdyU9mWA=;
        b=qwiU4sK3oJ4UJcZ8Bn4oogKKs/ware5ScCKkXV/ppHFkqaWFGluKi6qq/ABI1I7GOa
         +LT4XdhtHcGoAazRr3f8qr3GfNiVgAMNI3xMeb7rb0K/9ThB3nNd2RiSeLVIzxZxMsZA
         lUiChc5/kVAO4a8NnjAAttw0oV3OC6jQMj/Imb55i+mLEWP+UYiL4qzFnGqVT1mud3Ba
         7G9ZwCozulIYsXP+8b5YQkHjilSNOB9P0VifDopLQq7gDPORvyMcqLwe6oXwDkJ/tRJB
         vi548GVeEnZxbJli5ZvHrifAVaBrJ3O7aU7bXCUoTbQsM7EARuO7Ync7kt1mICyxq5O3
         zwCw==
X-Gm-Message-State: AOJu0YyTfwK22uza8Tbw3wcM3pUEsgN+B6Ix16CIFUWoFnf8j90z6x+1
        jo1qkbs/YxuIp83Qi9IUHPnGuA==
X-Google-Smtp-Source: AGHT+IGnL4Eg/UbrsjZtb65Tqj96GTr48RD7WqWC+PhqArwGW32wNsPvpvJK3pY3wbLoK553JZFM+w==
X-Received: by 2002:a17:903:455:b0:1c0:b17a:7554 with SMTP id iw21-20020a170903045500b001c0b17a7554mr2433786plb.64.1694811734323;
        Fri, 15 Sep 2023 14:02:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b001c3267ae317sm3902440plh.165.2023.09.15.14.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:02:13 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:02:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
Subject: Re: [RFC PATCH 05/14] mm/slub: create folio_set/clear_slab helpers
Message-ID: <202309151401.C49DDCE8@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-6-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-6-matteorizzo@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:24AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> This is refactoring in preparation for SLAB_VIRTUAL. Extract this code
> to separate functions so that it's not duplicated in the code that
> allocates and frees page with SLAB_VIRTUAL enabled.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
> ---
>  mm/slub.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ad33d9e1601d..9b87afade125 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1849,6 +1849,26 @@ static void *setup_object(struct kmem_cache *s, void *object)
>  /*
>   * Slab allocation and freeing
>   */
> +
> +static void folio_set_slab(struct folio *folio, struct slab *slab)
> +{
> +	__folio_set_slab(folio);
> +	/* Make the flag visible before any changes to folio->mapping */
> +	smp_wmb();
> +
> +	if (folio_is_pfmemalloc(folio))
> +		slab_set_pfmemalloc(slab);
> +}
> +
> +static void folio_clear_slab(struct folio *folio, struct slab *slab)
> +{
> +	__slab_clear_pfmemalloc(slab);
> +	folio->mapping = NULL;
> +	/* Make the mapping reset visible before clearing the flag */
> +	smp_wmb();
> +	__folio_clear_slab(folio);
> +}

Perhaps these should be explicitly marked as inlines?

> +
>  static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>  		struct kmem_cache_order_objects oo)
>  {
> @@ -1865,11 +1885,7 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>  		return NULL;
>  
>  	slab = folio_slab(folio);
> -	__folio_set_slab(folio);
> -	/* Make the flag visible before any changes to folio->mapping */
> -	smp_wmb();
> -	if (folio_is_pfmemalloc(folio))
> -		slab_set_pfmemalloc(slab);
> +	folio_set_slab(folio, slab);
>  
>  	return slab;
>  }
> @@ -2067,11 +2083,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>  	int order = folio_order(folio);
>  	int pages = 1 << order;
>  
> -	__slab_clear_pfmemalloc(slab);
> -	folio->mapping = NULL;
> -	/* Make the mapping reset visible before clearing the flag */
> -	smp_wmb();
> -	__folio_clear_slab(folio);
> +	folio_clear_slab(folio, slab);
>  	mm_account_reclaimed_pages(pages);
>  	unaccount_slab(slab, order, s);
>  	__free_pages(&folio->page, order);
> -- 
> 2.42.0.459.ge4e396fd5e-goog

Otherwise this is a straight function extraction.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
