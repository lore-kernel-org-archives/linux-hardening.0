Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5723211475;
	Wed, 22 Jan 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562249; cv=none; b=Yjp3HXFncu3NDEO65mhDm/Mdndm6ZXQdhcoXxE2l1KWkog66XqrIQ6CUZnARMPYp8yS4gcfi1Zwt33RM2rRgohFs02slrwSx0AYvUNT0w5BO4kloeVUj9fY/wYbwJHLO35ADEoFSoDOh5D3txAZRETHfMoKlQRxUkPm9DnTwiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562249; c=relaxed/simple;
	bh=Ic8MsEM2Z9i1aKlQU87fEU3YTUdutszRsehAgkOZ9kM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VHfR1RUKwDjnOWNItQotPbqN71lMa2mNby6nzJ2siyxwzQWFVl59ikqOmOqD66nfFM6BkRvMTSTO1w036toBOLlfm0nT2k1ZBFipfQEyX4EBfPi8tjeWzJLVsHlZ/2CaFmCwnBIeCJQCAR5kw3yr05WR7q03I9gBCgxURNAxmD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=szdwTv1W; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="szdwTv1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1737561774;
	bh=Ic8MsEM2Z9i1aKlQU87fEU3YTUdutszRsehAgkOZ9kM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=szdwTv1WCR2x1PRnjNvCvdSND2MCEsqxtCBZNhuaNX60ubKsKw+pWZuejtn6l/xNC
	 zX7aejHqMDlATIrQxYeB3+l19h4XI9gVztirBFluoen5ZplSvUkooeBiV8IYTAH9kK
	 aAUSeXSNjgl/A3xTnxXmUyoaHwVo7lCyWzxbq3+E=
Received: by gentwo.org (Postfix, from userid 1003)
	id 22039401F1; Wed, 22 Jan 2025 08:02:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 1F8EC400CA;
	Wed, 22 Jan 2025 08:02:54 -0800 (PST)
Date: Wed, 22 Jan 2025 08:02:54 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: GONG Ruiqi <gongruiqi1@huawei.com>
cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, Kees Cook <kees@kernel.org>, 
    Tamas Koczka <poprdi@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
    linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: Achieve better kmalloc caches randomization in
 kvmalloc
In-Reply-To: <20250122074817.991060-1-gongruiqi1@huawei.com>
Message-ID: <a424b98e-87dc-4f1a-e18b-28ed28b555ef@gentwo.org>
References: <20250122074817.991060-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 22 Jan 2025, GONG Ruiqi wrote:

>
> +void *__kmalloc_node_inline(size_t size, kmem_buckets *b, gfp_t flags,
> +				int node, unsigned long caller);
> +


Huh? Is this inline? Where is the body of the function?

> diff --git a/mm/slub.c b/mm/slub.c
> index c2151c9fee22..ec75070345c6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4319,6 +4319,13 @@ void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flag
>  }
>  EXPORT_SYMBOL(__kmalloc_node_track_caller_noprof);
>
> +__always_inline void *__kmalloc_node_inline(size_t size, kmem_buckets *b,
> +					    gfp_t flags, int node,
> +					    unsigned long caller)
> +{
> +	return __do_kmalloc_node(size, b, flags, node, caller);
> +}
> +

inline functions need to be defined in the header file AFAICT.


