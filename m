Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F112D1F40;
	Mon, 21 Sep 2026 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996647; cv=none; b=BiaRLgJENNG/TVJiqKJKdHy824Qm2oal6T7n4HBjzAEbvjFAzCHkZvM6fxTzlX6qplbszVmOKGqVa9sO8E5cRJwvQD8jDAT6wAaqMmPsZqUoGZD7saZZsQbjdP/WfMDJFkvRn6BMtOSju59EtyDu2DBIr8Gf6uhSpicEdD88RBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996647; c=relaxed/simple;
	bh=oxHrbd2wvnbnaG3pchytyrG7/FodabB9PQrNp8bSYrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cofytR3Q0y/qZ7lZAoAiasHwUY7ZbrIQTfLcw2X1Hb4AbWGHMZyhMZ7zcMM73aC+1FzEtLUuNUiOSIBXddnSJ4QUI8z3rSFGOMn7qQ9/XxJ6A6+FE1TkqwSSz4c9hteWf1RbkDHL7uuhCchkaj2xhAG9elCXtTDLe/c/ZRaTDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOp7P/Hh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOp7P/Hh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889C81F000FF;
	Mon, 21 Sep 2026 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789996644;
	bh=mdO/1qNOWoyatEwYn7xF77VAMMYfSFesr52raVoM2g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YOp7P/HhFoWCbFNP1Kg1DcohDthKn7Vk8/kd4iFNUPUy2kIIUrBYBD7eYpRgqKvCT
	 T9k3EmIJRky8Jd7bmpBG1s37nMaSnfpPKlG3YBEZsMl2HCHoPxF67Yphnmx5TH8B6G
	 W1rTkNZRz9hm13HD5c7e+gaE9NaU8LAx+3+O7eldHrtHwiHs+XNQtNT+GgEA9HYUrH
	 GSXFSUXZgyWi1re8DchivL48dUbbNI8TZcoZ5AFSzRNxQljbuEQC/Ck1tcdD0ZCfx/
	 Q/DBQnOAfixhhnr69hLosb8a+mw14SYsKX+fDgNxfdv3pDPH2iYH/FJpSsQp0UHQCW
	 Jp6twnn4+BWFA==
Date: Mon, 21 Sep 2026 14:17:21 +0100
From: Harry Yoo <harry@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Pedro Falcato <pfalcato@suse.de>, Kuniyuki Iwashima <kuniyu@google.com>, 
	linux-hardening@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/7] mm/slab: Give bucket caches the alignment of the
 caches they mirror
Message-ID: <arEdcaJz4i5HP26a@thinkstation>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-2-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921075820.1718334-2-kees@kernel.org>

On Mon, Sep 21, 2026 at 12:58:13AM -0700, Kees Cook wrote:
> A bucket set is created with kmem_cache_create_usercopy(..., align = 0),
> so calculate_alignment() falls back to arch_slab_minalign(), typically 8
> bytes. The general kmalloc caches it stands in for are created through
> create_boot_cache(), which starts from ARCH_KMALLOC_MINALIGN and raises
> it to the largest power-of-two divisor of the size:
> 
> 	if (flags & SLAB_KMALLOC)
> 		align = max(align, 1U << (ffs(size) - 1));
> 
> This is only a problem when slab metadata is enabled with
> CONFIG_KASAN=y, CONFIG_SLUB_DEBUG_ON=y, or "slab_debug=...", because
> metadata changes the stride size off a power of two, for example:
>
> 	size 128:  bucket align=8 size=224  | kmalloc align=128  size=384
> 	size 512:  bucket align=8 size=608  | kmalloc align=512  size=1536
> 	size 2048: bucket align=8 size=2144 | kmalloc align=2048 size=6144

Hmm... I think what adds confusion here is that in new_kmalloc_cache()
we adjust the size based on alignment, but in create_boot_cache() we
don't do that. Perhaps let's make it consistent and move it to
new_kmalloc_cache()?

> So bucket allocations will fail the IS_ALIGNED(p, ARCH_DMA_MINALIGN)
> check, potentially creating problems for non-coherent DMA situation.

I was wondering "Why should they respect kmalloc alignment..." but yeah,
It makes sense if the users were using kmalloc and depended on its
alignment.

Well, but that's already done in new_kmalloc_cache() and
kmem_buckets_create() should already honor ARCH_KMALLOC_MINALIGN? 

The largest-power-of-two-divisor-alignment guarantee was introduced by
commit ad59baa31695 ("slab, rust: extend kmalloc() alignment guarantees
to remove Rust padding")

...which makes me wonder what you're trying to fix here?

> Take the alignment from the cache being mirrored, which is where the
> size and the name suffix already come from. Nothing changes where the
> alignment was already implied by the size.
>
> Fixes: b32801d1255be ("mm/slab: Introduce kmem_buckets_create() and family")
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Harry Yoo <harry@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hao Li <hao.li@linux.dev>
> Cc: Christoph Lameter <cl@gentwo.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: <linux-mm@kvack.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  mm/slab_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 270408ce5a9d..cc58f192f349 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -487,7 +487,8 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
>  			if (WARN_ON(!cache_name))
>  				goto fail;
>  			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
> -					0, flags, cache_useroffset,
> +					kmalloc_caches[KMALLOC_NORMAL][idx]->align,
> +					flags, cache_useroffset,
>  					cache_usersize, ctor);
>  			kfree(cache_name);
>  			if (WARN_ON(!(*b)[aligned_idx]))
> -- 
> 2.34.1

-- 
Cheers,
Harry / Hyeonggon
