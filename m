Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690E1BBBE4;
	Wed, 11 Sep 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093843; cv=none; b=Z4MNeJVMUoGQrQPb9vqX35ogagBWWKhnPNwGbO4Z3jQHimEh1JSc0IRQErrIy5TQ7ZeWKzIsllPjp4oMzL0Cjq36cfDOiFH3rdDcdwsjMbCEwvtvz5pRjEFxwt96i6EJ+1ufRP99X7MWami9Nsah1mBLmzl7d+X2G8DbkGKdDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093843; c=relaxed/simple;
	bh=WwOTVKODLlsieEew/9/eTn6ygyv4nmybvgfiewsHUcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvtTqPyXRdqlzfxAxMxJo+Eq+O8WjysIDGKh58m/FwNjHelO4tCz1nGeIz+WIfWEqGUykh9J9NKIChJY+ly7iZQEEUdRxvESe+YQpfxloLtB5/b9WbVe9EbqonPc0UaFzE8jmIf524l4aBfOX6F1S7hLQuHUpK1cDe5eJvCT2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRt2ljNa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRt2ljNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98552C4CEC6;
	Wed, 11 Sep 2024 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726093840;
	bh=WwOTVKODLlsieEew/9/eTn6ygyv4nmybvgfiewsHUcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRt2ljNawjLRvP1xHwUY0yv3IT4FjV2TPZwX7H05+br38UTe5ED8PEDv/WdFDYAtu
	 5w4/hWH7WRayR1m9YhQe7NTnTAyXF1A/DPxLXdkGtUHnnQCptZ62gTzEBz1amNZAo1
	 NjUNCe0SI8b6EY2SjOtUEViQXlhbskLlZsmDue1QsALVpDPPCnIA5MuGl0AI7AREpe
	 /yvcp79v5i1jLBznkX2McANWnLKEE2YU3fsMT2mhNOzs6gnyAmiBxlfrnvgaoYW1zg
	 shxMqjz63CIJcPI6sOIEXscIdDtoPHQ3FnMM17T9z3LSPf3UCU2eqMcoKqGSlhIuyq
	 KGVy5dRKo/6XQ==
Date: Wed, 11 Sep 2024 15:30:40 -0700
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	jvoisin <julien.voisin@dustri.org>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] slab: Allocate and use per-call-site caches
Message-ID: <202409111523.AEAEE48@keescook>
References: <20240809072532.work.266-kees@kernel.org>
 <20240809073309.2134488-5-kees@kernel.org>
 <CAJuCfpHOqKPzbbkULpWU5g1-8mTLXraQM4taHzajY_cJ-YFWgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHOqKPzbbkULpWU5g1-8mTLXraQM4taHzajY_cJ-YFWgQ@mail.gmail.com>

On Thu, Aug 29, 2024 at 10:03:56AM -0700, Suren Baghdasaryan wrote:
> On Fri, Aug 9, 2024 at 12:33 AM Kees Cook <kees@kernel.org> wrote:
> >
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
> 
> I'm currently working on a feature to identify allocations with
> __GFP_ACCOUNT known at compile time (similar to how you handle the
> size in the previous patch). Might be something you can reuse/extend.

Great, yes! I'd love to check it out.

> >   - Separate MEMCG allocations as well
> 
> Do you mean allocations with __GFP_ACCOUNT or something else?

I do, yes.

> > +static void alloc_tag_site_init_early(struct codetag *ct)
> > +{
> > +       /* Explicitly initialize the caches needed to initialize caches. */
> > +       if (strcmp(ct->function, "kstrdup") == 0 ||
> > +           strcmp(ct->function, "kvasprintf") == 0 ||
> > +           strcmp(ct->function, "pcpu_mem_zalloc") == 0)
> 
> I hope we can find a better way to distinguish these allocations.
> Maybe have a specialized hook for them, like alloc_hooks_early() which
> sets a bit inside ct->flags to distinguish them?

That might be possible. I'll see how that ends up looking. I don't want
to even further fragment the alloc_hooks_... variants.

> 
> > +               alloc_tag_site_init(ct, false);
> > +
> > +       /* TODO: pre-allocate GFP_ATOMIC caches here. */
> 
> You could pre-allocate GFP_ATOMIC caches during
> alloc_tag_module_load() only if gfp_flags are known at compile time I
> think. I guess for the dynamic case choose_slab() will fall back to
> kmalloc_slab()?

Right, yes. I'd do it like the size checking: if we know at compile
time, we can depend on it, otherwise it's a run-time fallback.

> 
> > @@ -175,8 +258,21 @@ static bool alloc_tag_module_unload(struct codetag_type *cttype,
> >
> >                 if (WARN(counter.bytes,
> >                          "%s:%u module %s func:%s has %llu allocated at module unload",
> > -                        ct->filename, ct->lineno, ct->modname, ct->function, counter.bytes))
> > +                        ct->filename, ct->lineno, ct->modname, ct->function, counter.bytes)) {
> >                         module_unused = false;
> > +               }
> > +#ifdef CONFIG_SLAB_PER_SITE
> > +               else if (tag->meta.sized) {
> > +                       /* Remove the allocated caches, if possible. */
> > +                       void *p = READ_ONCE(tag->meta.cache);
> > +
> > +                       WRITE_ONCE(tag->meta.cache, NULL);
> 
> I'm guessing you are not using try_cmpxchg() the same way you did in
> alloc_tag_site_init() because a race with any other user is impossible
> at the module unload time? If so, a comment mentioning that would be
> good.

Correct. It should not be possible. But yes, I will add a comment.

> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 855c63c3270d..4f01cb6dd32e 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -302,7 +302,20 @@ config SLAB_PER_SITE
> >         default SLAB_FREELIST_HARDENED
> >         select SLAB_BUCKETS
> >         help
> > -         Track sizes of kmalloc() call sites.
> > +         As a defense against shared-cache "type confusion" use-after-free
> > +         attacks, every kmalloc()-family call allocates from a separate
> > +         kmem_cache (or when dynamically sized, kmem_buckets). Attackers
> > +         will no longer be able to groom malicious objects via similarly
> > +         sized allocations that share the same cache as the target object.
> > +
> > +         This increases the "at rest" kmalloc slab memory usage by
> > +         roughly 5x (around 7MiB), and adds the potential for greater
> > +         long-term memory fragmentation. However, some workloads
> > +         actually see performance improvements when single allocation
> > +         sites are hot.
> 
> I hope you provide the performance and overhead data in the cover
> letter when you post v1.

That's my plan. It's always odd choosing workloads, but we do seem to
have a few 'regular' benchmarks (hackbench, kernel builds, etc). Is
there anything in particular you'd want to see?

> > +static __always_inline
> > +struct kmem_cache *choose_slab(size_t size, kmem_buckets *b, gfp_t flags,
> > +                              unsigned long caller)
> > +{
> > +#ifdef CONFIG_SLAB_PER_SITE
> > +       struct alloc_tag *tag = current->alloc_tag;
> > +
> > +       if (!b && tag && tag->meta.sized &&
> > +           kmalloc_type(flags, caller) == KMALLOC_NORMAL &&
> > +           (flags & GFP_ATOMIC) != GFP_ATOMIC) {
> 
> What if allocation is GFP_ATOMIC but a previous allocation from the
> same location (same tag) happened without GFP_ATOMIC and
> tag->meta.cache was allocated. Why not use that existing cache?
> Same if the tag->meta.cache was pre-allocated.

Maybe I was being too conservative in my understanding -- I thought that
I couldn't use those caches on the chance that they may already be full?
Or is that always the risk, ad GFP_ATOMIC deals with that? If it would
be considered safe attempt the allocation from the existing cache, then
yeah, I can adjust this check.

Thanks for looking these over!

-Kees

-- 
Kees Cook
