Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420912;
	b=KSZdzQ35sgL+iPFP6l4BPZJnbjZcZni8yGCN6quQAlyL6EzOq6oZkmNDINqcr3AdbFt0
	 fNXD4GGyFT402TZnHgDfeDegcvjqSuNnOtjfjhzUgwPovPkHfcKrhlEP9/ystJCYbRhSp
	 JFKtvr7LTiCAB/AG3eGfTro97jEgLq6vh13QVbNmkwU80cNfV4JEXkqkw0hw9JZStnHN5
	 HW31tUw48vEdYGLLypoOVWQPnOvN89kG8HmgLC+XXUZT3fKUuHjb7eQ8Ym2bhok09lERd
	 zxa5gZKHeHoDnapIT9Oau9JpH6SZClCaIh7PVAw+G+cDUUvZ/Q3RCqpuEWWu3uT1Hxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420912;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nPI7+m7xqukMbqrFFt+ctdQhrHqe+UHCY/7XpSE1aQU=;
	b=KTDyJj8GWLgyiJRv4A44MUWIuVg1HifGO/DhvkU5RfGp0F6IekxmtPfCV3l+yiuNf9mu
	 /APzjXzWiWPyVdOJDhcPzregCl9LWhFrs61BPqW52iTLWkrPgI6ojT20p2uojzTpK528b
	 8ahcy8irvygMkj38TTGaf/DOlNObjNbP0EtZ9HeToMqA4cA69DECDaP7AzQGvFWRojMPh
	 RNNKQjeOpb3RuzGynffnqSkO2dmJiaHVwp3Xs5dMXp7kVG3Y9Rh8ehhXlRIiv+oex7Lnw
	 FMcHLicCo7BlnrgrVATAbKFh1mNdka8olMG6DPyUtfgsK5ibA/CKc1QkQUNo6rudjmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYb7BKxt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951D606A31A;
	Sat, 31 Oct 2026 04:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYb7BKxt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389E31F000C1;
	Sat, 31 Oct 2026 04:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793420911;
	bh=nPI7+m7xqukMbqrFFt+ctdQhrHqe+UHCY/7XpSE1aQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YYb7BKxtbnvtVVP17CkQSB9ZHp+q7J5pQnsntezGl3/r67S0/g58i2DSZyhH4Vcc+
	 8zHUeXXiqXoaogxItyNX3VmIJffBG+2qwMRxX2b5gZaoe2R7eNUsxLwWct4M1pJcU3
	 u8AEKYNCE2vXGX+8ZOkVT0kczwGR4QPYYo7obUvEOlacUL/7pt1CHJN9Rf33ojM1lH
	 u8qBgs0DngHLJeIYCVYXuLPpu7MhtfZnlcUgoTvsFbNMrfzEq38fzrF9PgtKONtCac
	 MNHhdYS9I/TKZIF/Sm8OemJe2Ne5yyAvMh2f3JkX+q9FBkzPgyONJZIykuMTDNEBPC
	 OZadJGLN+hLEw==
Date: Fri, 30 Oct 2026 21:28:30 -0700
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
Subject: Re: [PATCH v2 5/6] mm/slab: Support disabling
 KMALLOC_PARTITION_CACHES at boot
Message-ID: <202610302123.687A961@keescook>
References: <cover.1793253633.git.chris@chrisdown.name>
 <617bbfdce4fb2689c2510f0cd7f9adbb3ab8edfa.1793253633.git.chris@chrisdown.name>
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
In-Reply-To: <617bbfdce4fb2689c2510f0cd7f9adbb3ab8edfa.1793253633.git.chris@chrisdown.name>

On Thu, Oct 29, 2026 at 02:09:09PM +0800, Chris Down wrote:
> KMALLOC_PARTITION_CACHES creates several copies of each normal kmalloc
> cache and spreads allocations across them. That costs a fair bit of
> memory: Harry measured about 18 MiB more slab memory after boot on a 64
> CPU, 64 GiB VM, mostly from under-used slabs [1]. Like SLAB_BUCKETS, it
> can only be chosen at build time.
> 
> Add a kmalloc_partition= early parameter, enabled by default on kernels
> built with CONFIG_KMALLOC_PARTITION_CACHES=y. When it's off, the copies
> alias the normal caches rather than being created.
> 
> Let's leave kmalloc_type() unchanged since each index simply resolves to
> the same cache when partitioning is off.
> 
> Link: https://lore.kernel.org/r/179312451613.474906.1475329637924619088@kernel.org [1]
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  .../admin-guide/kernel-parameters.txt         |  7 +++++++
>  mm/Kconfig                                    |  5 +++++
>  mm/slab_common.c                              | 19 ++++++++++++++++++-
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index de2fd6963a16..6633a553a79c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3054,6 +3054,13 @@ Kernel parameters
>  			Configure the RouterBoard 532 series on-chip
>  			Ethernet adapter MAC address.
>  
> +	kmalloc_partition= [MM,EARLY]
> +			Format: <bool>
> +			Enable or disable kmalloc cache partitioning on
> +			kernels built with CONFIG_KMALLOC_PARTITION_CACHES=y.
> +			Ignored without that option.
> +			Default: on.
> +
>  	kmemleak=	[KNL,EARLY] Boot-time kmemleak enable/disable
>  			Valid arguments: on, off
>  			Default: on
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 48078c1fd26f..b90b3915fcd5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -266,6 +266,11 @@ config KMALLOC_PARTITION_CACHES
>  	  limited degree of memory and CPU overhead that relates to hardware
>  	  and system workload.
>  
> +	  The partitioning can be disabled at boot with the
> +	  "kmalloc_partition=0" kernel parameter, in which case the copies
> +	  are not created and all normal kmalloc allocations use the
> +	  regular kmalloc caches.
> +
>  choice
>  	prompt "Partitioned slab cache mode"
>  	depends on KMALLOC_PARTITION_CACHES
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 9fe48da12010..5391149a2eed 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -781,6 +781,16 @@ unsigned long random_kmalloc_seed __ro_after_init;
>  EXPORT_SYMBOL(random_kmalloc_seed);
>  #endif
>  
> +#ifdef CONFIG_KMALLOC_PARTITION_CACHES
> +static bool kmalloc_partition_enabled __ro_after_init = true;
> +
> +static int __init setup_kmalloc_partition(char *str)
> +{
> +	return kstrtobool(str, &kmalloc_partition_enabled);
> +}
> +early_param("kmalloc_partition", setup_kmalloc_partition);
> +#endif
> +
>  /*
>   * Conversion table for small slabs sizes / 8 to the index in the
>   * kmalloc array. This is necessary for slabs < 192 since we have non power
> @@ -1013,8 +1023,15 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
>  	}
>  
>  #ifdef CONFIG_KMALLOC_PARTITION_CACHES

Swap the ifdef for a CONFIG-controlled static branch that defaults off
without CONFIG_KMALLOC_PARTITION_CACHES.

> -	if (type >= KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END)
> +	if (!kmalloc_partition_enabled) {
> +		/* Use the normal caches, which have already been created. */
> +		if (type > KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END) {
> +			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
> +			return;
> +		}
> +	} else if (type >= KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END) {
>  		flags |= SLAB_NO_MERGE;
> +	}
>  #endif
>  
>  	/*
> -- 
> 2.54.0
> 

-- 
Kees Cook
