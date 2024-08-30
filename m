Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029215572D
	for <linux-hardening@vger.kernel.org>; Fri, 30 Aug 2024 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002691; cv=none; b=JTwK0wZPYHl/iU0CBbTIFOR4YhV0scvL5kl+z0POi3gWnoBi9CMHvp8xPtU1egZVIV1iz7uA7iqczckdr0aSQh3+RokVIQwyQpQmPn+8vdsJAMLu/XtjXTbvJI+14+QOhOeOwif5P9gHqSbTJ40M648BclJSr4pUSklq2aiXoe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002691; c=relaxed/simple;
	bh=tWyjjYxHBns2cctAaoyvYs8zJycR53/wZQdhmHSBxGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU+u+BLMR/2njPTwLXnHhyAp9HAFMvQ5uvkBtKALAr0IeXG7EDeJKL9nwW00pk1PmDywPS0KrV02buIrM/vmoI0VqWSdlEKiPFYAITfncm7B8Df9xllFJ1wnEZ7DgEKnNwGwTfEDg97gdYhti4CiUJanAIj3eo/TcDN4vb4psZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UzNWg7rw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UzNWg7rw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bb72a5e0bso12099025e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 30 Aug 2024 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725002687; x=1725607487; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ecl9V3mHP2TroPJgyQO8RmF2Y8C5vbk13wxZrIkGuAw=;
        b=UzNWg7rwYkBTzPTU5iQCJS3Z1F+/fRX5RhZt1JQHwWqNt3qdMdlLEG63+9dZoAcZq+
         7lJ0o7Z5Ng5Qr+659dLlIfSXHDgvdeknUhQ8f0zeUdDHxRXw7TaHSn6/fBZWJTUfY8jo
         wt5aJfkFVahDWhJ7b034kJlAiJlF0dsXMBOSfrJXNCEhYsiw4CtF0e/EcnUeGJz41y9B
         xbJaOUhXh7GbOa2op4Xj6wGGQLH0MPc2EKb90G5gYzdwRt7ZPyB47u8JPGD3azT9ZzBs
         Xpb9X738QikgdVUQMuRvCLbUUCIhkjDphzps62KtUM2M/G9AhWI3gpLHldYD6a4hoMaZ
         rdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725002687; x=1725607487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecl9V3mHP2TroPJgyQO8RmF2Y8C5vbk13wxZrIkGuAw=;
        b=N3d2hl6Jzhd77HpIaK7iPRa8uWUZeccr5lgDAI9NAEhmKL3PSgP6JMRT0u925bSUMY
         wyUV4Q11uaAONBE22kGBGbSevkfVPY0p4RPPNaQtPHX+Kh9+Lt3YQLIBJ6dAEv9aovR6
         UrSJvQAM1fXYh6jaNNIb+2SpHK2BTxwmAd8pEP4ciE07/Lmiqudvm1TzkXlAbrlGOigv
         e76aCVMvrPHSo/jWPeefQseounhIBp2Hl5KLW8uYDCc20QUbj3ve97N5W47jjookhPmN
         KhKizpQtltUJAuwp7IEe9UswQLZDvH6QHVC+LR6flrHwNsFgOmybpp7lC3uT2xsMTjH+
         k9kg==
X-Forwarded-Encrypted: i=1; AJvYcCWeendBitgT6AnCxBDFgWO7uxLuCTf6o/0WwgeVezypWpJGWa35IhTeN9B3uj2K7aGK8x060BiBhT79yztA8N0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw671mDaTAyJvueeK4NcfwGYNzbFWgmhaxdIOqQRXS/H3f2lmGm
	RE/J0EYD7nuwwhiEF9H8ZwUeQ66yTBfFZ+rCNi2TTTWtrlLmY7x03J1FuHlEgIs=
X-Google-Smtp-Source: AGHT+IGd+v4gw5NFrcdO2V0+lNAzqgrBBOAwStEmLuvRWpuojLyJlgncKQDgdAUlXD0sjILmrgTK8w==
X-Received: by 2002:a05:600c:4693:b0:426:63b4:73b0 with SMTP id 5b1f17b1804b1-42bb01fd12dmr45492325e9.34.1725002687187;
        Fri, 30 Aug 2024 00:24:47 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb3efsm37586855e9.6.2024.08.30.00.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:24:46 -0700 (PDT)
Date: Fri, 30 Aug 2024 09:24:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: vbabka@suse.cz, 42.hyeyoo@gmail.com, akpm@linux-foundation.org,
	cl@linux.com, david@redhat.com, hailong.liu@oppo.com,
	hch@infradead.org, iamjoonsoo.kim@lge.com, laoar.shao@gmail.com,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZtFzvU1wiBSlhzzY@tiehlicka>
References: <CAGsJ_4wZiE08XDjNAPENwH=KQEzdm2FB_bMDi0b7PJx+e7ydrA@mail.gmail.com>
 <20240829223114.1102-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829223114.1102-1-21cnbao@gmail.com>

On Fri 30-08-24 10:31:14, Barry Song wrote:
> > > > Patch 4/4: We will move the order > 1 check from the current fast path
> > > > to the slow path and extend
> > > >                  the check of gfp_direct_reclaim flag also in the slow path.
> > >
> > > OK, let's have that go in now as well.
> 
> Hi Michal and Vlastimil,
> Could you please review the changes below before I send v4 for patch 4/4?
> 
> 1. We should consolidate all warnings in one place. Currently, the order > 1 warning is
> in the hotpath, while others are in less likely scenarios. Moving all warnings to the
> slowpath will reduce the overhead for order > 1 and increase the visibility of other
> warnings.
> 
> 2. We currently have two warnings for order: one for order > 1 in the hotpath and another
> for order > costly_order in the laziest path. I suggest standardizing on order > 1 since
> it’s been in use for a long time.
> 
> 3.I don't think we need to check for __GFP_NOWARN in this case. __GFP_NOWARN is
> meant to suppress allocation failure reports, but here we're dealing with bug detection, not
> allocation failures.
> So I'd rather use WARN_ON_ONCE than WARN_ON_ONCE_GFP.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c81ee5662cc7..0d3dd679d0ab 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>  {
>  	struct page *page;
>  
> -	/*
> -	 * We most definitely don't want callers attempting to
> -	 * allocate greater than order-1 page units with __GFP_NOFAIL.
> -	 */
> -	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> -
>  	if (likely(pcp_allowed_order(order))) {
>  		page = rmqueue_pcplist(preferred_zone, zone, order,
>  				       migratetype, alloc_flags);
> @@ -4174,6 +4168,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  						struct alloc_context *ac)
>  {
>  	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
> +	bool nofail = gfp_mask & __GFP_DIRECT_RECLAIM;
>  	bool can_compact = gfp_compaction_allowed(gfp_mask);
>  	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
>  	struct page *page = NULL;
> @@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	unsigned int zonelist_iter_cookie;
>  	int reserve_flags;
>  
> +	if (nofail) {
> +		/*
> +		 * We most definitely don't want callers attempting to
> +		 * allocate greater than order-1 page units with __GFP_NOFAIL.
> +		 */
> +		WARN_ON_ONCE(order > 1);
> +		/*
> +		 * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
> +		 * otherwise, we may result in lockup.
> +		 */
> +		WARN_ON_ONCE(!can_direct_reclaim);
> +		/*
> +		 * PF_MEMALLOC request from this context is rather bizarre
> +		 * because we cannot reclaim anything and only can loop waiting
> +		 * for somebody to do a work for us.
> +		 */
> +		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
> +	}

Yes, this makes sense. Any reason you have not put that int the nofail
branch below?

> +
>  restart:
>  	compaction_retries = 0;
>  	no_progress_loops = 0;
> @@ -4404,29 +4418,15 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
>  	 * we always retry
>  	 */
> -	if (gfp_mask & __GFP_NOFAIL) {
> +	if (nofail) {
>  		/*
> -		 * All existing users of the __GFP_NOFAIL are blockable, so warn
> -		 * of any new users that actually require GFP_NOWAIT
> +		 * Lacking direct_reclaim we can't do anything to reclaim memory,
> +		 * we disregard these unreasonable nofail requests and still
> +		 * return NULL
>  		 */
> -		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> +		if (!can_direct_reclaim)
>  			goto fail;
>  
> -		/*
> -		 * PF_MEMALLOC request from this context is rather bizarre
> -		 * because we cannot reclaim anything and only can loop waiting
> -		 * for somebody to do a work for us
> -		 */
> -		WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
> -
> -		/*
> -		 * non failing costly orders are a hard requirement which we
> -		 * are not prepared for much so let's warn about these users
> -		 * so that we can identify them and convert them to something
> -		 * else.
> -		 */
> -		WARN_ON_ONCE_GFP(costly_order, gfp_mask);
> -
>  		/*
>  		 * Help non-failing allocations by giving some access to memory
>  		 * reserves normally used for high priority non-blocking
> 
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
> 
> Thanks
> Barry

-- 
Michal Hocko
SUSE Labs
