Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1C8405F
	for <linux-hardening@vger.kernel.org>; Fri, 24 May 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562908; cv=none; b=OKmfmebvwHJSMcWmC0lsL/YNBo3mn3ukI9uQmSMgtgyS8z2DCUGEzK62hwqhjWvBf4FZcxh3oJWKHnQmNIwE8x/zml76r9O/GYkBBZaZekSMd2gaP73iyZT/a1mHJzDnmukjTazGkEDdehQm556w0czz7d7VPWzdydNVfdUjS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562908; c=relaxed/simple;
	bh=W2HTM0WFCdxL76Odvjz18hrMZmxkUbqXvN3Psgn07I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4962ls5QB+ly478/gxd027S4kN5+pIe2pTOaIB2/b2lYD57tOzjK+9v7ANLgfR6LsFewwETd/TImDCGQEWE8v+qfkO4AiMLrM5MQvZoCJLDgZsUrbzS6i6lmqeai0oyE3KV62LJuv+PWHRlbapgHkbbwn7l9N6H3wzN2HMWaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EPfkRfE+; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EPfkRfE+"
X-Envelope-To: keescook@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716562904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=75jOm2WHxxBcp7S96tzxhfDiq4d/NzT8Jz5YkcJqW9s=;
	b=EPfkRfE+4h3TuCuLCGYrYlVwiQrfTlaT7Ope4AcU+P2VRcOZHZSbnlB/J7Jc/YbuOiQ4Ac
	XiSg8ORTNcUbC05CJlyyAv2yuZZyMb7KTE5gd/AHtGZEdLX1tuiHtWsb5ZHUuMb08kZDfi
	tEAI3jsMKNqJPHj8wpfCqcXBe2mnBxI=
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: cl@linux.com
X-Envelope-To: penberg@kernel.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-hardening@vger.kernel.org
X-Envelope-To: gongruiqi@huaweicloud.com
X-Envelope-To: xiujianfeng@huawei.com
X-Envelope-To: surenb@google.com
X-Envelope-To: jannh@google.com
X-Envelope-To: matteorizzo@google.com
X-Envelope-To: tgraf@suug.ch
X-Envelope-To: herbert@gondor.apana.org.au
X-Envelope-To: julien.voisin@dustri.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 24 May 2024 11:01:40 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Suren Baghdasaryan <surenb@google.com>, 
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>, 
	Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>, 
	julien.voisin@dustri.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mm/slab: Plumb kmem_buckets into
 __do_kmalloc_node()
Message-ID: <zxc3fpd552hnd4jumot2k3bnol3pe2ooybz2rts4qrcxpgn7ll@4aggaem6acjw>
References: <20240424213019.make.366-kees@kernel.org>
 <20240424214104.3248214-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424214104.3248214-2-keescook@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 24, 2024 at 02:40:59PM -0700, Kees Cook wrote:
> To be able to choose which buckets to allocate from, make the buckets
> available to the lower level kmalloc interfaces by adding them as the
> first argument. Where the bucket is not available, pass NULL, which means
> "use the default system kmalloc bucket set" (the prior existing behavior),
> as implemented in kmalloc_slab().

I thought the plan was to use codetags for this? That would obviate the
need for all this plumbing.

Add fields to the alloc tag for:
 - allocation size (or 0 if it's not a compile time constant)
 - union of kmem_cache, kmem_buckets, depending on whether the
   allocation size is constant or not

Then this can all be internal to slub.c, and the kmem_cache or
kmem_buckets gets lazy initialized.

If memory allocation profiling isn't enabled, #ifdef the other fields of
the alloc tag out (including the codetag itself) so your fields will be
the only fields in alloc_tag.

> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  include/linux/slab.h | 16 ++++++++--------
>  lib/fortify_kunit.c  |  2 +-
>  mm/slab.h            |  6 ++++--
>  mm/slab_common.c     |  4 ++--
>  mm/slub.c            | 14 +++++++-------
>  mm/util.c            |  2 +-
>  6 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index c8164d5db420..07373b680894 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -569,8 +569,8 @@ static __always_inline void kfree_bulk(size_t size, void **p)
>  	kmem_cache_free_bulk(NULL, size, p);
>  }
>  
> -void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
> -							 __alloc_size(1);
> +void *__kmalloc_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
> +				__assume_kmalloc_alignment __alloc_size(2);
>  #define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))
>  
>  void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
> @@ -679,7 +679,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
>  				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>  				flags, node, size);
>  	}
> -	return __kmalloc_node_noprof(size, flags, node);
> +	return __kmalloc_node_noprof(NULL, size, flags, node);
>  }
>  #define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
>  
> @@ -730,10 +730,10 @@ static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(voi
>   */
>  #define kcalloc(n, size, flags)		kmalloc_array(n, size, (flags) | __GFP_ZERO)
>  
> -void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
> -				  unsigned long caller) __alloc_size(1);
> +void *kmalloc_node_track_caller_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node,
> +				       unsigned long caller) __alloc_size(2);
>  #define kmalloc_node_track_caller(...)		\
> -	alloc_hooks(kmalloc_node_track_caller_noprof(__VA_ARGS__, _RET_IP_))
> +	alloc_hooks(kmalloc_node_track_caller_noprof(NULL, __VA_ARGS__, _RET_IP_))
>  
>  /*
>   * kmalloc_track_caller is a special version of kmalloc that records the
> @@ -746,7 +746,7 @@ void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
>  #define kmalloc_track_caller(...)		kmalloc_node_track_caller(__VA_ARGS__, NUMA_NO_NODE)
>  
>  #define kmalloc_track_caller_noprof(...)	\
> -		kmalloc_node_track_caller_noprof(__VA_ARGS__, NUMA_NO_NODE, _RET_IP_)
> +		kmalloc_node_track_caller_noprof(NULL, __VA_ARGS__, NUMA_NO_NODE, _RET_IP_)
>  
>  static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags,
>  							  int node)
> @@ -757,7 +757,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
>  		return NULL;
>  	if (__builtin_constant_p(n) && __builtin_constant_p(size))
>  		return kmalloc_node_noprof(bytes, flags, node);
> -	return __kmalloc_node_noprof(bytes, flags, node);
> +	return __kmalloc_node_noprof(NULL, bytes, flags, node);
>  }
>  #define kmalloc_array_node(...)			alloc_hooks(kmalloc_array_node_noprof(__VA_ARGS__))
>  
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> index 493ec02dd5b3..ff059d88d455 100644
> --- a/lib/fortify_kunit.c
> +++ b/lib/fortify_kunit.c
> @@ -220,7 +220,7 @@ static void alloc_size_##allocator##_dynamic_test(struct kunit *test)	\
>  	checker(expected_size, __kmalloc(alloc_size, gfp),		\
>  		kfree(p));						\
>  	checker(expected_size,						\
> -		__kmalloc_node(alloc_size, gfp, NUMA_NO_NODE),		\
> +		__kmalloc_node(NULL, alloc_size, gfp, NUMA_NO_NODE),	\
>  		kfree(p));						\
>  									\
>  	orig = kmalloc(alloc_size, gfp);				\
> diff --git a/mm/slab.h b/mm/slab.h
> index 5f8f47c5bee0..f459cd338852 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -403,16 +403,18 @@ static inline unsigned int size_index_elem(unsigned int bytes)
>   * KMALLOC_MAX_CACHE_SIZE and the caller must check that.
>   */
>  static inline struct kmem_cache *
> -kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
> +kmalloc_slab(kmem_buckets *b, size_t size, gfp_t flags, unsigned long caller)
>  {
>  	unsigned int index;
>  
> +	if (!b)
> +		b = &kmalloc_caches[kmalloc_type(flags, caller)];
>  	if (size <= 192)
>  		index = kmalloc_size_index[size_index_elem(size)];
>  	else
>  		index = fls(size - 1);
>  
> -	return kmalloc_caches[kmalloc_type(flags, caller)][index];
> +	return (*b)[index];
>  }
>  
>  gfp_t kmalloc_fix_flags(gfp_t flags);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index db9e1b15efd5..7cb4e8fd1275 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -702,7 +702,7 @@ size_t kmalloc_size_roundup(size_t size)
>  		 * The flags don't matter since size_index is common to all.
>  		 * Neither does the caller for just getting ->object_size.
>  		 */
> -		return kmalloc_slab(size, GFP_KERNEL, 0)->object_size;
> +		return kmalloc_slab(NULL, size, GFP_KERNEL, 0)->object_size;
>  	}
>  
>  	/* Above the smaller buckets, size is a multiple of page size. */
> @@ -1186,7 +1186,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  		return (void *)p;
>  	}
>  
> -	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
> +	ret = kmalloc_node_track_caller_noprof(NULL, new_size, flags, NUMA_NO_NODE, _RET_IP_);
>  	if (ret && p) {
>  		/* Disable KASAN checks as the object's redzone is accessed. */
>  		kasan_disable_current();
> diff --git a/mm/slub.c b/mm/slub.c
> index 23bc0d236c26..a94a0507e19c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4093,7 +4093,7 @@ void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
>  EXPORT_SYMBOL(kmalloc_large_node_noprof);
>  
>  static __always_inline
> -void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
> +void *__do_kmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node,
>  			unsigned long caller)
>  {
>  	struct kmem_cache *s;
> @@ -4109,7 +4109,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
>  	if (unlikely(!size))
>  		return ZERO_SIZE_PTR;
>  
> -	s = kmalloc_slab(size, flags, caller);
> +	s = kmalloc_slab(b, size, flags, caller);
>  
>  	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
>  	ret = kasan_kmalloc(s, ret, size, flags);
> @@ -4117,22 +4117,22 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
>  	return ret;
>  }
>  
> -void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
> +void *__kmalloc_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
>  {
> -	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> +	return __do_kmalloc_node(b, size, flags, node, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__kmalloc_node_noprof);
>  
>  void *__kmalloc_noprof(size_t size, gfp_t flags)
>  {
> -	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
> +	return __do_kmalloc_node(NULL, size, flags, NUMA_NO_NODE, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__kmalloc_noprof);
>  
> -void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
> +void *kmalloc_node_track_caller_noprof(kmem_buckets *b, size_t size, gfp_t flags,
>  				       int node, unsigned long caller)
>  {
> -	return __do_kmalloc_node(size, flags, node, caller);
> +	return __do_kmalloc_node(b, size, flags, node, caller);
>  }
>  EXPORT_SYMBOL(kmalloc_node_track_caller_noprof);
>  
> diff --git a/mm/util.c b/mm/util.c
> index c9e519e6811f..80430e5ba981 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -128,7 +128,7 @@ void *kmemdup_noprof(const void *src, size_t len, gfp_t gfp)
>  {
>  	void *p;
>  
> -	p = kmalloc_node_track_caller_noprof(len, gfp, NUMA_NO_NODE, _RET_IP_);
> +	p = kmalloc_node_track_caller_noprof(NULL, len, gfp, NUMA_NO_NODE, _RET_IP_);
>  	if (p)
>  		memcpy(p, src, len);
>  	return p;
> -- 
> 2.34.1
> 
