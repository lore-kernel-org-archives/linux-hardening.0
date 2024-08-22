Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F61CC8A7;
	Thu, 22 Aug 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348857; cv=none; b=UrIrOi0dz/kPR9lZT+4khnMRyd8f3h4/oiSL2vUaJUYgJPdXgpBsZNDU+JI+AFHb84TJFquxTuJT14g9JGyzYuIuVQaSK4U/or+txBOf+H3denU/DIWVf02UbzFZgJ5k9xfmTEzFbAXejp5Dohmnx7FoYTJPVTa2YHI1oLtxYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348857; c=relaxed/simple;
	bh=ZouLq/8pIc7NL+u1I+/tJejA2tHWdm7Eju6gVChwW7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9b55dJCXRNIzSAi6IODFnXLylsrHkpnaKwcYPc96QwxDkXv0Iy7XLx69p7Pduw1euQZOHfZWAZV2PzoxAeqMYEmDUPFyxxVBo9Uw8lfIcBPDcZJqM0DSIS6e0pSh6Y6vCEvOqKA/GGmSO2Tx+MzKAjb4OzIOHU8XdLmu+uIR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msg14e4d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msg14e4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA2BC32782;
	Thu, 22 Aug 2024 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724348856;
	bh=ZouLq/8pIc7NL+u1I+/tJejA2tHWdm7Eju6gVChwW7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msg14e4dBoOafgRZOQLJtri9GIzzLAjE4gYBSa0vsNow1AgY8EWoFGYqDkXhgpHno
	 nd4RQVEugGo4Z5ngysg38vftiVVt/kBfz/+xJGLm5/G6HVHyRKM9A9fT3hCZ23ONAN
	 5HUcn9/XfoHa/V7O7LE99EljsIzy/O3cxBNjd9HXWWpNsWWj3JFNxd0txkJKjNfpDX
	 Jvv6FeKzf0dNW+OdsdyP9aEeeOEt0k29cwSTV0/jE+atQHdMrIq6TP8UnL96xSFWqy
	 DHbP8OmmSHFf2LuOqFtcmjhm3kgGSrxamTYwaVOykr38HaUHenqmEirH4bb272mSHS
	 6zqbO5OFxWFDA==
Date: Thu, 22 Aug 2024 10:47:36 -0700
From: Kees Cook <kees@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	jvoisin <julien.voisin@dustri.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] slab: Allocate and use per-call-site caches
Message-ID: <202408221046.808356D202@keescook>
References: <20240809072532.work.266-kees@kernel.org>
 <20240809073309.2134488-5-kees@kernel.org>
 <1ddb539a-79ed-d992-76cf-061acb4df11e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ddb539a-79ed-d992-76cf-061acb4df11e@huaweicloud.com>

On Sat, Aug 17, 2024 at 09:30:58AM +0800, Xiu Jianfeng wrote:
> Hi Kees,
> 
> On 2024/8/9 15:33, Kees Cook wrote:
> > Use separate per-call-site kmem_cache or kmem_buckets. These are
> > allocated on demand to avoid wasting memory for unused caches.
> > 
> > A few caches need to be allocated very early to support allocating the
> > caches themselves: kstrdup(), kvasprintf(), and pcpu_mem_zalloc(). Any
> > GFP_ATOMIC allocations are currently left to be allocated from
> > KMALLOC_NORMAL.
> > 
> > With a distro config, /proc/slabinfo grows from ~400 entries to ~2200.
> > 
> > Since this feature (CONFIG_SLAB_PER_SITE) is redundant to
> > CONFIG_RANDOM_KMALLOC_CACHES, mark it a incompatible. Add Kconfig help
> > text that compares the features.
> > 
> > Improvements needed:
> > - Retain call site gfp flags in alloc_tag meta field to:
> >   - pre-allocate all GFP_ATOMIC caches (since their caches cannot
> >     be allocated on demand unless we want them to be GFP_ATOMIC
> >     themselves...)
> >   - Separate MEMCG allocations as well
> > - Allocate individual caches within kmem_buckets on demand to
> >   further reduce memory usage overhead.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: linux-mm@kvack.org
> > ---
> >  include/linux/alloc_tag.h |   8 +++
> >  lib/alloc_tag.c           | 121 +++++++++++++++++++++++++++++++++++---
> >  mm/Kconfig                |  19 +++++-
> >  mm/slab_common.c          |   1 +
> >  mm/slub.c                 |  31 +++++++++-
> >  5 files changed, 170 insertions(+), 10 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 3520acaf9afa..d14102c4b4d7 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4135,6 +4135,35 @@ void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
> >  }
> >  EXPORT_SYMBOL(__kmalloc_large_node_noprof);
> >  
> > +static __always_inline
> > +struct kmem_cache *choose_slab(size_t size, kmem_buckets *b, gfp_t flags,
> > +			       unsigned long caller)
> > +{
> > +#ifdef CONFIG_SLAB_PER_SITE
> > +	struct alloc_tag *tag = current->alloc_tag;
> 
> There is a compile error here if CONFIG_MEM_ALLOC_PROFILING is disabled
> when I test this patchset.
> 
> mm/slub.c: In function ‘choose_slab’:
> mm/slub.c:4187:40: error: ‘struct task_struct’ has no member named
> ‘alloc_tag’
>  4187 |         struct alloc_tag *tag = current->alloc_tag;
>       |                                        ^~
>   CC      mm/page_reporting.o
> 
> maybe CONFIG_SLAB_PER_SITE should depend on CONFIG_MEM_ALLOC_PROFILING

Thanks! I tried to make the Kconfig use the right dependencies, but I
clearly missed something. There is also some weird behavior between
"depends" and "select". I will get this fixed for the next version.

-Kees

-- 
Kees Cook
