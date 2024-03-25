Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F943AB4
	for <linux-hardening@vger.kernel.org>; Mon, 25 Mar 2024 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395659; cv=none; b=Hcqk/vDceUkLVYQoMokBMZB9ZjNoKv6R/Io8BGE2Z36I7DKYJZy4csJWPB7lKUvzUSLnY7YDc3uUmBEXJhVgn85g/K1nuyHOF/SxxNGfwtcmN3XEdGH57my7UcTDJH30VyB9V2H/G8IwQmYdblE2/XT30imGghSNktTkcXjIUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395659; c=relaxed/simple;
	bh=O3T2ZVnqYmBb98eatEjFmoz6lFq5rPVIXrRZI114ot4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TI1DNJrmGvNUvSEgHMSnx66B2K9SkJNPRvosW9RaWsMxg3MTQCmCJWfm5bGMxPdAhytf9+0EoQVE+zPxPPMBsAfUkDAyPck3mNQyTn30kg3irbGnMeyC9aTF809iIiEp4Nxt5aSZZJaDujCaMGi4eP78xLjE6tIJfRZMCKDvQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B1nzWHQz; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B1nzWHQz"
Date: Mon, 25 Mar 2024 15:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711395655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/ulXyWKqkzXiOH+Zl+aph4Lwf/XKPejosEhROqYyvU=;
	b=B1nzWHQz4fk8V3rHqtSVsCx9Y8hVkRHvgrE6Bvb1g36Mh6Av3cmyu8EN7JqrqT14Ci/PLQ
	N/Hhc46Z68FolOA4BiuHuB+K2LrNr1oASp+HeKbGSrjxoqKtfXzyhSY6z9DQcdp7ihUPY/
	L5b8cDpzsUZYaoK4mu7IQW4sc2pYXC8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jann Horn <jannh@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 4/9] slab: Introduce kmem_buckets_create()
Message-ID: <eppzf5gil6izcn6nnvzgzukagdikqnfxdvziga7ipnpl5eeern@i7jfzslklsu6>
References: <20240305100933.it.923-kees@kernel.org>
 <20240305101026.694758-4-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305101026.694758-4-keescook@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 05, 2024 at 02:10:20AM -0800, Kees Cook wrote:
> Dedicated caches are available For fixed size allocations via
> kmem_cache_alloc(), but for dynamically sized allocations there is only
> the global kmalloc API's set of buckets available. This means it isn't
> possible to separate specific sets of dynamically sized allocations into
> a separate collection of caches.
> 
> This leads to a use-after-free exploitation weakness in the Linux
> kernel since many heap memory spraying/grooming attacks depend on using
> userspace-controllable dynamically sized allocations to collide with
> fixed size allocations that end up in same cache.
> 
> While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> against these kinds of "type confusion" attacks, including for fixed
> same-size heap objects, we can create a complementary deterministic
> defense for dynamically sized allocations.
> 
> In order to isolate user-controllable sized allocations from system
> allocations, introduce kmem_buckets_create(), which behaves like
> kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
> which behaves like kmem_cache_alloc().)
> 
> Allows for confining allocations to a dedicated set of sized caches
> (which have the same layout as the kmalloc caches).
> 
> This can also be used in the future once codetag allocation annotations
> exist to implement per-caller allocation cache isolation[1] even for
> dynamic allocations.
> 
> Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
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
> ---
>  include/linux/slab.h |  5 +++
>  mm/slab_common.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index f26ac9a6ef9f..058d0e3cd181 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -493,6 +493,11 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  			   gfp_t gfpflags) __assume_slab_alignment __malloc;
>  void kmem_cache_free(struct kmem_cache *s, void *objp);
>  
> +kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
> +				  slab_flags_t flags,
> +				  unsigned int useroffset, unsigned int usersize,
> +				  void (*ctor)(void *));

I'd prefer an API that initialized an object over one that allocates it
- that is, prefer

kmem_buckets_init(kmem_buckets *bucekts, ...)

by forcing it to be separately allocated, you're adding a pointer deref
to every access.

That would also allow for kmem_buckets to be lazily initialized, which
would play nicely declaring the kmem_buckets in the alloc_hooks() macro.

I'm curious what all the arguments to kmem_buckets_create() are needed
for, if this is supposed to be a replacement for kmalloc() users.
