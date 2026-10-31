Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420249;
	b=ec4/liIEnwez+sCZirx6F7WeBp9JFLG1LMaEhiV1sInSHC3pxcTfLBb5jBuh6MWp1zjK
	 YP4yHZ9sbJF7QeEPM32AxJ+BYiOM/jz6IbVl7puXIl0dCGJK7ZAqrFSihL3ERrcX2peOg
	 PNWPTGtp1RK1NvHfGUPGbHSo6J+iRemiQ/s1RKxBqP34Wom8gxt1rLYjHkep4DOIOnsZG
	 xrYOFJzm+/Ri0q3TZ8/Chgt8MU3gaf7rcOIMb34SuAeyxeoGI7zxUOb7yIUiRYPPC9iNR
	 +ptcYBHs6goKLXgg+gQn9ZMGdoKorpEC5IG1peqpzcq65JHSEcyQxeEsZiCIMCr7pQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420249;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8TqGj30S1M01nBTKS0rP1dh/7dQv0SfGvxWL56l6kOw=;
	b=ibivHvcNUzrkOiD69152DNMzjZd3fStTZGxmMQYOaukN7+cLZy7KyjwPLmKs1+yP0KrB
	 LcEXjvDOyRz/NbXFAQsLHBihFJnFBZzbIr5RGEXfnw5sRlh24dQ7imJbXMRQpNGiFkbOk
	 vW9BcmaN9Nh7nv9zEsqE9/JPC9yE3infASF8Gzf/eQfwYpOpcxriEJKdY5YzI8v4SXA2E
	 kwg99KTa5qX89eEuIKFNpsXUxCjVaCxtD7Y6BVrIVfKx9bzoW0X277jVCHRTB4OgdQwat
	 Jl45k2vcuh+slUJ1MwK0KFWgH9IhAHJxWC1S5VgLoz6a3U7X8SBAaT+kCYYj7paqtrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+ZJukh0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384C606A31A;
	Sat, 31 Oct 2026 04:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+ZJukh0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C01C1F000C1;
	Sat, 31 Oct 2026 04:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793420249;
	bh=8TqGj30S1M01nBTKS0rP1dh/7dQv0SfGvxWL56l6kOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X+ZJukh09k95tOFSiSKcjzf5IwhTAal9NzT7PYeaTHJoqQh5dMzFVaWuMmxRZ2PU+
	 J3iDFNpMYWaxrW/WtmmKGpNX2iBRZKH4a2/ClNtvAKMkyA99RNu2rZgdwnlt6uPmrV
	 yUtQ8BWtxmVm4pcpKzmcvo2yyl4hvzLF+W/MNur9t2urIv3NLjFwckiVHtYHEAjgF0
	 XUPXmh+KP9fQpwWzJy4Y13Mnmx7En7pc0bET9jzOcEgZ6nQfEJ1o3unw9iidX2V4xR
	 ZJBlkuLY+fyGgjCTWQjBixbzS4mJgTaMtXJA0BaY6wVAEdI1kS41JfLwsSquG9nNDt
	 Pc9fIkWhVHh4w==
Date: Fri, 30 Oct 2026 21:17:29 -0700
From: Kees Cook <kees@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 3/6] mm/slab: Support disabling SLAB_BUCKETS at boot
Message-ID: <202610302115.8C7AD110@keescook>
References: <cover.1793253633.git.chris@chrisdown.name>
 <9a68a4d95830352ad3821437c2e22c30a673055b.1793253633.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a68a4d95830352ad3821437c2e22c30a673055b.1793253633.git.chris@chrisdown.name>

On Thu, Oct 29, 2026 at 02:08:25PM +0800, Chris Down wrote:
> SLAB_BUCKETS gives allocations with user-controlled size and contents,
> like memdup_user() and msg_msg, their own set of kmalloc caches, at the
> cost of the memory for those caches. It can only be chosen at build
> time, so hosts which want it and hosts which would rather not pay for it
> need separate kernels.
> 
> Add a slab_buckets= early parameter, enabled by default on kernels built
> with CONFIG_SLAB_BUCKETS=y, so that it can be turned off at boot.

I thought the issue here was about calling convention (i.e. with
CONFIG_SLAB_BUCKETS Vlastimil had suggested making the argument lists
for the call chain shorter by dropping the bucket argument entirely).

> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 ++++++
>  mm/Kconfig                                    |  4 +++
>  mm/slab_common.c                              | 26 +++++++++++++++----
>  3 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 68647ff4bdd2..de2fd6963a16 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7001,6 +7001,14 @@ Kernel parameters
>  			apic=verbose is specified.
>  			Example: apic=debug show_lapic=all
>  
> +	slab_buckets= [MM,EARLY]
> +			Format: <bool>
> +			Enable or disable separate kmalloc buckets on kernels
> +			built with CONFIG_SLAB_BUCKETS=y. When disabled,
> +			allocations use regular kmalloc caches. Ignored
> +			without that option.
> +			Default: on.
> +
>  	slab_debug[=options[,slabs][;[options[,slabs]]...]]	[MM]
>  			Enabling slab_debug allows one to determine the
>  			culprit if slab objects become corrupted. Enabling
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 92ff97ff24fb..48078c1fd26f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -231,6 +231,10 @@ config SLAB_BUCKETS
>  	  of extra pages since the bulk of user-controlled allocations
>  	  are relatively long-lived.
>  
> +	  The separate buckets can be disabled at boot with the
> +	  "slab_buckets=0" kernel parameter, in which case these
> +	  allocations use the regular kmalloc caches.
> +
>  	  If unsure, say Y.
>  
>  config SLUB_STATS
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e66c0778ee98..b7a46c368ab1 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -410,6 +410,16 @@ EXPORT_SYMBOL(__kmem_cache_create_args);
>  
>  static struct kmem_cache *kmem_buckets_cache __ro_after_init;
>  
> +static bool slab_buckets_enabled __ro_after_init = IS_ENABLED(CONFIG_SLAB_BUCKETS);
> +
> +#ifdef CONFIG_SLAB_BUCKETS
> +static int __init setup_slab_buckets(char *str)
> +{
> +	return kstrtobool(str, &slab_buckets_enabled);
> +}
> +early_param("slab_buckets", setup_slab_buckets);
> +#endif
> +
>  /**
>   * kmem_buckets_create - Create a set of caches that handle dynamic sized
>   *			 allocations via kmem_buckets_alloc()
> @@ -424,10 +434,12 @@ static struct kmem_cache *kmem_buckets_cache __ro_after_init;
>   *
>   * Context: Cannot be called within an interrupt, but can be interrupted.
>   *
> - * Return: a pointer to the cache on success, NULL on failure. When
> - * CONFIG_SLAB_BUCKETS is not enabled, ZERO_SIZE_PTR is returned, and
> - * subsequent calls to kmem_buckets_alloc() will fall back to kmalloc().
> - * (i.e. callers only need to check for NULL on failure.)
> + * Return: a pointer to the cache on success, NULL on failure or when the
> + * separate buckets were disabled with the "slab_buckets=0" boot parameter.
> + * When CONFIG_SLAB_BUCKETS is not enabled, ZERO_SIZE_PTR is returned. In all
> + * of these cases subsequent calls to kmem_buckets_alloc() with the returned
> + * value fall back to kmalloc(), so callers that can live without separate
> + * buckets do not need to check the return value.
>   */
>  kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
>  				  unsigned int useroffset,
> @@ -448,6 +460,10 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
>  	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS))
>  		return ZERO_SIZE_PTR;
>  
> +	/* NULL makes kmalloc_slab() use the regular kmalloc caches. */
> +	if (!slab_buckets_enabled)
> +		return NULL;

Regardless, I still prefer this being a static branch so we don't end
up with a needless rodata global check.

> +
>  	if (WARN_ON(!kmem_buckets_cache))
>  		return NULL;
>  
> @@ -1059,7 +1075,7 @@ void __init create_kmalloc_caches(void)
>  	/* Kmalloc array is now usable */
>  	slab_state = UP;
>  
> -	if (IS_ENABLED(CONFIG_SLAB_BUCKETS))
> +	if (IS_ENABLED(CONFIG_SLAB_BUCKETS) && slab_buckets_enabled)
>  		kmem_buckets_cache = kmem_cache_create("kmalloc_buckets",
>  						       sizeof(kmem_buckets),
>  						       0, SLAB_NO_MERGE, NULL);
> -- 
> 2.54.0
> 

-- 
Kees Cook
