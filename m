Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444044;
	b=KJoJJJZIYydXHU3Sz9+D6EjYgsJR8bOcqiiYJf1NavQiiZauwJ5ItqD3tBYnuTcfCt5H
	 Rk0mam9jjReEuIh/We6NI1CigY9fE/z8UAZz9jGAuZOWkDHx1VneDuLele/EiibCNfJkW
	 FT9rrt9kE+pptYzqupHNUpVAXdwTgtZA/az9luL9JujwmEexN2ttTQk0Nrl6rHqOC2Fgy
	 8/51nJxXnmLrurAXllaUeXIJtfTV2LrYn+TpZF8apMx47NXCu6HuyDPYdONJGsqEXJ0+Z
	 koNDtAcZBFVefRF7w8UL+bytzb/gaN62AUKM1CUeDeS6AY+CeClcmz1mwUZEzbs48Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444044;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=6xpWvm8FwNjmg+fPN53wD4gkIM4E/p3REBlACqtLvXs=;
	b=olIeDjS0h0xsWt2B+RHRtXmTdEjXnBdJDFpVTF02Fz3VuJ+1eIhbyUx42q1DJbC+YqoZ
	 vR5aICk75FvamSc+YMeXVF20cTroR4IFBCMRoQ2qGzHTKRF6/OVJJCmm9nXoGuCSkKIzI
	 nDjvWfi98aPjlkYx6oNFCASJ8F75mFQx9iYP0vPGFEX53Q1iBksrJQZH4mz+P/Wjo9asu
	 RMc7+dgGiy8RIA7ih/RP3GIgpeFEJfgRCDgd+qnaoPsIyPscmklhLKf6TDGqhgf9xgnQB
	 1KfmS8T6tJzQJu+4Y7O/jWtSbGsehTI8lIL3cBZqUrzV8u/3AgFDXCfGhgrZ8hKnHnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=OwAplIni;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74780606A32A;
	Thu, 12 Nov 2026 00:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74780606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=OwAplIni
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C75A1F8;
	Thu, 12 Nov 2026 01:38:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794443897;
	bh=xqfnEjqyHMQl2qHFWowUXzE/Oqfvp6pljb9uxPDED6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OwAplIniUURguBikb+R/YMs3Bk8BOTl5EYLwv+82bdKT0dPNZJZiMnz9j+W0pHvef
	 FtqWTyR04z/5aW7g+jR/himpZlnP3HJ9YmG522bYVRRYPgmf8uA6/vCIJj0CspD307
	 tAoFk2kEEVq48RsFodiAydmT/svA8mDID9+hwG6E=
Date: Thu, 12 Nov 2026 02:40:39 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	driver-core@lists.linux.dev, linux-hardening@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for
 devm_kmalloc
Message-ID: <20261112004039.GA523044@killaraus.ideasonboard.com>
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-2-kees@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914223219.901347-2-kees@kernel.org>

Hi Kees,

On Mon, Sep 14, 2026 at 03:32:17PM -0700, Kees Cook wrote:
> Mirroring the type-based allocation now in use for the kmalloc family of
> APIs, provide the same for the devm_kmalloc family of APIs. This will
> allow for future plumbing of type information (e.g. alignment) into the
> underlying allocations. This immediately gains type check on return
> values (instead of the prior "void *" return type).
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: <driver-core@lists.linux.dev>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  include/linux/device/devres.h | 102 ++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
> index 14ab9159bdda..7656c9ecd4da 100644
> --- a/include/linux/device/devres.h
> +++ b/include/linux/device/devres.h
> @@ -62,6 +62,108 @@ static inline void *devm_kcalloc(struct device *dev, size_t n, size_t size, gfp_
>  {
>  	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>  }
> +
> +/**
> + * __devm_alloc_objs - Device-managed allocation of objects of a given type
> + * @DEVM_ALLOC: which device-managed size-based allocator to use.
> + * @DEV: device to scope the allocation lifetime to.
> + * @GFP: GFP flags for the allocation.
> + * @TYPE: type to allocate space for.
> + * @COUNT: how many @TYPE objects to allocate.
> + *
> + * Device-managed counterpart of __alloc_objs().
> + * @DEVM_ALLOC takes (@DEV, size, gfp).
> + *
> + * Returns: Newly allocated pointer to (first) @TYPE of @COUNT-many allocated
> + * @TYPE objects, or NULL on failure.
> + */
> +#define __devm_alloc_objs(DEVM_ALLOC, DEV, GFP, TYPE, COUNT)		\
> +({									\
> +	const size_t __obj_size = size_mul(sizeof(TYPE), COUNT);	\
> +	(TYPE *)DEVM_ALLOC(DEV, __obj_size, GFP);			\
> +})
> +
> +/**
> + * devm_kmalloc_obj - Device-managed allocation of a single typed object
> + * @DEV: Device to scope the allocation lifetime to.
> + * @VAR_OR_TYPE: Variable or type to allocate.
> + * @GFP: Optional GFP flags (defaults to %GFP_KERNEL).
> + *
> + * Device-managed counterpart of kmalloc_obj(): the allocation is sized from
> + * @VAR_OR_TYPE and returned as a pointer to that type, not void *.
> + *
> + * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL on
> + * failure.
> + */
> +#define devm_kmalloc_obj(DEV, VAR_OR_TYPE, ...)				\
> +	__devm_alloc_objs(devm_kmalloc, DEV, default_gfp(__VA_ARGS__),	\
> +			  typeof(VAR_OR_TYPE), 1)
> +
> +/**
> + * devm_kmalloc_objs - Device-managed allocation of an array of a typed object
> + * @DEV: Device to scope the allocation lifetime to.
> + * @VAR_OR_TYPE: Variable or type to allocate an array of.
> + * @COUNT: How many elements in the array.
> + * @GFP: Optional GFP flags (defaults to %GFP_KERNEL).
> + *
> + * Returns: newly allocated pointer to an array of @VAR_OR_TYPE on success, or
> + * NULL on failure (including when the total size overflows).
> + */
> +#define devm_kmalloc_objs(DEV, VAR_OR_TYPE, COUNT, ...) \
> +	__devm_alloc_objs(devm_kmalloc, DEV, default_gfp(__VA_ARGS__), \
> +			  typeof(VAR_OR_TYPE), COUNT)
> +
> +/**
> + * __devm_alloc_flex - Device-managed allocation of a trailing-flex-array object
> + * @DEVM_ALLOC: which device-managed allocator to use.
> + * @DEV: device to scope the allocation lifetime to.
> + * @GFP: GFP flags for the allocation.
> + * @TYPE: type of structure to allocate space for.
> + * @FAM: name of the flexible array member of @TYPE.
> + * @COUNT: how many @FAM elements to allocate space for.
> + *
> + * Device-managed counterpart of __alloc_flex().
> + * @DEVM_ALLOC takes (@DEV, size, gfp).
> + *
> + * Returns: Newly allocated pointer to @TYPE with @COUNT-many trailing @FAM
> + * elements, or NULL on failure.
> + */
> +#define __devm_alloc_flex(DEVM_ALLOC, DEV, GFP, TYPE, FAM, COUNT)	\
> +({									\
> +	const size_t __count = (COUNT);					\
> +	const size_t __obj_size = struct_size_t(TYPE, FAM, __count);	\
> +	TYPE *__obj_ptr = DEVM_ALLOC(DEV, __obj_size, GFP);		\
> +	if (__obj_ptr)							\
> +		__set_flex_counter(__obj_ptr->FAM, __count);		\
> +	__obj_ptr;							\
> +})
> +
> +/**
> + * devm_kmalloc_flex - Device-managed allocation of a flexible-array structure
> + * @DEV: Device to scope the allocation lifetime to.
> + * @VAR_OR_TYPE: Variable or type to allocate (with its flexible array).
> + * @FAM: The name of the flexible array member of the structure.
> + * @COUNT: How many flexible array member elements to allocate.
> + * @GFP: Optional GFP flags (defaults to %GFP_KERNEL).
> + *
> + * Returns: newly allocated pointer to @VAR_OR_TYPE on success, or NULL on
> + * failure. If @FAM has been annotated with __counted_by(), its counter is set
> + * to @COUNT.
> + */
> +#define devm_kmalloc_flex(DEV, VAR_OR_TYPE, FAM, COUNT, ...) \
> +	__devm_alloc_flex(devm_kmalloc, DEV, default_gfp(__VA_ARGS__), \
> +			  typeof(VAR_OR_TYPE), FAM, COUNT)
> +
> +/* All devm_kzalloc aliases for devm_kmalloc_(obj|objs|flex). */
> +#define devm_kzalloc_obj(DEV, P, ...) \
> +	__devm_alloc_objs(devm_kzalloc, DEV, default_gfp(__VA_ARGS__), typeof(P), 1)
> +#define devm_kzalloc_objs(DEV, P, COUNT, ...) \
> +	__devm_alloc_objs(devm_kzalloc, DEV, default_gfp(__VA_ARGS__), \
> +			  typeof(P), COUNT)

I was recently made aware by Geert of an unfortunate side effect of the
default GPF_KERNEL argument. I've fixed a memory leak in the imx8-isi
driver by using devm_kzalloc_objs() as follows:

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index 0ae5f35e017c..9373a5256224 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -488,7 +488,8 @@ static int mxc_isi_probe(struct platform_device *pdev)

 	isi->pdata = of_device_get_match_data(dev);

-	isi->pipes = kzalloc_objs(isi->pipes[0], isi->pdata->num_channels);
+	isi->pipes = devm_kzalloc_objs(dev, isi->pipes[0],
+				       isi->pdata->num_channels);
 	if (!isi->pipes)
 		return -ENOMEM;

So far, so good. However, the following code also compiles:

	isi->pipes = devm_kzalloc_obj(dev, isi->pipes[0],
				      isi->pdata->num_channels);

(note the *obj* instead of *objs*) because the third argument is
interpreted as gfp flags. It's clearly a bug, but one that the compiler
doesn't catch. The typo is easy to make.

Sparse catches the issue:

drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:491:22: warning: incorrect type in argument 3 (different base types)
drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:491:22:    expected restricted gfp_t [usertype] gfp
drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:491:22:    got unsigned int const num_channels

I'm however not sure if build bots report sparse warnings or only
errors.

Is this an issue you're aware of, and do you think it should be
addressed ?

> +#define devm_kzalloc_flex(DEV, P, FAM, COUNT, ...) \
> +	__devm_alloc_flex(devm_kzalloc, DEV, default_gfp(__VA_ARGS__), \
> +			  typeof(P), FAM, COUNT)
> +
>  static inline __realloc_size(3, 4) void * __must_check
>  devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
>  {

-- 
Regards,

Laurent Pinchart
