Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E9612EB;
	Fri, 31 May 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173780; cv=none; b=MSVgTmyRZkmpPGKI47Keq+FbFUGzfc1Q12djRW/HtQIOw9RLry5CEpb8MKGyQIJvA4d7t3zegeQuMK2n3qunVmszVBSaxMt5gVVFeoWLAl4/bhfBCuHP6NphrcbVJzXgdsCLeg+v0jLCLf6kBKDh3+QG/qAMVWVeL+TAsHx//6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173780; c=relaxed/simple;
	bh=h9xEb88Q0BWA/HKbvxBqBPuQDNJV6+lkfys9wgwSsd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI6ibIydSleSqNxCMu9ioRxtbCijpnEwy0VbfjB/QNiq12IwY1GpVSH8lnJgr1457K2FerTJnRaI1Bj7WezV+7NE5aabU6rihkBITb+dqMH3jXreaYa5qjer94bRg+BoxjDTIXO/GwCYFKk7MmwibpoWrCklelRTBUoGzFnBAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJxSOJZz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJxSOJZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C18C116B1;
	Fri, 31 May 2024 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717173780;
	bh=h9xEb88Q0BWA/HKbvxBqBPuQDNJV6+lkfys9wgwSsd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJxSOJZzlU7TkY1lfyEgw7d4dSBX70y+IdQxau1AYjYqMhq3n9Aeng0lWxYyrMfVm
	 WvX1s1qSiNqT5sxYn/WmHZCV7Wxs7AIvQGQt4zHIWEYv5cQAQF5dmiBHx/ibv864wu
	 6LPZGsE3A6AaH2lXyQBmfa49XHreH6tvw8cCnrdQQz03L8W9wCbMUEqRdzqD6bOr1T
	 4SiriN9dvIFHLtb+5WRrARo0pKcQ7IZYGS1mTF5TnZ/85a/dJ4Gay/dFALwYogYo0Z
	 urv031NJ5vNmqL3OhGq4RKc27FvzzG2gwO8ZuRkQ3mQU4ilHrFQq8C8WbN3TmkQdY4
	 sRB6tfzzLGwug==
Date: Fri, 31 May 2024 09:42:59 -0700
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>, julien.voisin@dustri.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mm/slab: Plumb kmem_buckets into
 __do_kmalloc_node()
Message-ID: <202405310941.62F7B2859C@keescook>
References: <20240424213019.make.366-kees@kernel.org>
 <20240424214104.3248214-2-keescook@chromium.org>
 <fb2227dc-facb-4760-ba91-49abb54a991c@suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb2227dc-facb-4760-ba91-49abb54a991c@suse.cz>

On Fri, May 24, 2024 at 03:38:58PM +0200, Vlastimil Babka wrote:
> On 4/24/24 11:40 PM, Kees Cook wrote:
> > To be able to choose which buckets to allocate from, make the buckets
> > available to the lower level kmalloc interfaces by adding them as the
> > first argument. Where the bucket is not available, pass NULL, which means
> > "use the default system kmalloc bucket set" (the prior existing behavior),
> > as implemented in kmalloc_slab().
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  include/linux/slab.h | 16 ++++++++--------
> >  lib/fortify_kunit.c  |  2 +-
> >  mm/slab.h            |  6 ++++--
> >  mm/slab_common.c     |  4 ++--
> >  mm/slub.c            | 14 +++++++-------
> >  mm/util.c            |  2 +-
> >  6 files changed, 23 insertions(+), 21 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index c8164d5db420..07373b680894 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -569,8 +569,8 @@ static __always_inline void kfree_bulk(size_t size, void **p)
> >  	kmem_cache_free_bulk(NULL, size, p);
> >  }
> >  
> > -void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
> > -							 __alloc_size(1);
> > +void *__kmalloc_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
> > +				__assume_kmalloc_alignment __alloc_size(2);
> >  #define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))
> >  
> >  void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
> > @@ -679,7 +679,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
> >  				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> >  				flags, node, size);
> >  	}
> > -	return __kmalloc_node_noprof(size, flags, node);
> > +	return __kmalloc_node_noprof(NULL, size, flags, node);
> 
> This is not ideal as now every kmalloc_node() callsite will now have to add
> the NULL parameter even if this is not enabled. Could the new parameter be
> only added depending on the respective config?

I felt like it was much simpler to add an argument to the existing call
path than to create a duplicate API that had 1 extra argument. However,
if you want this behind a Kconfig option, I can redefine the argument
list based on that?

-- 
Kees Cook
