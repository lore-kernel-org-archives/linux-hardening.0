Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C368156242;
	Fri, 31 May 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173470; cv=none; b=fCnF8tfuXmInUjYstBgD9fnQMdVZRHs11qbzWsLZ1H/uTaHNeA9QSWxFR4mqaGvS2gwnWtjorvu0cQXburXkG36yPzZW7F4fiYAHvMez4Nc50Yk3vpiIJignvFNFxVUl8a0cWmO8ms5dXp0K+2Bl9rHLz5NPa4DvthyCyy1Ti5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173470; c=relaxed/simple;
	bh=yJj+uTKHabFp9ExqWi8oH1v5GAHx4lefIOwY+fHlkHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjLWutvcTTIZkRXgElzDtwn5fIIfqmCZHcRAh4+TZkvpsvYWk3a/d7svcyEXzI2Mb6d6tqdrIilXnYVZRisi13ceDGN3KWRdqazLYZR1jQyj11RsJFElAkaTprv6RNV4lm9g2bvSnWyt9hfzSR+ANgIjzprKBbEP7ro0BfO+0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbx5tB6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbx5tB6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5EAC116B1;
	Fri, 31 May 2024 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717173470;
	bh=yJj+uTKHabFp9ExqWi8oH1v5GAHx4lefIOwY+fHlkHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pbx5tB6EjU8+CQhUNFFeLFjkG6M4wf7N1ZqBBfLq34zjyuW3Q9dzlO310MNFIqwdW
	 BVI0NbqZQBJeT7JNfabPA9WPA0ssc377p6MAh54bu75FD6S2zbqla569thgaFQ5ZGG
	 RT/LWTZU+podZE/cBP+kBG+/Ne1q/Zga+E5AAtUk8m2UpcxN7umEYpZyWpvIz3+OeB
	 BJZ1+fk9pAF6gs5E9k9hIOY+fqMSRCWXz5/7ctlKHYxt0E0L1o7wSzq9juCJgOjrcL
	 4j52ZL+o/Fudtohd6jUmHask27nHWgPyjXlu8oTQJPjfq7F+pExslZ8UaIZMWOjBrH
	 bX/3M+xxfgaCw==
Date: Fri, 31 May 2024 09:37:49 -0700
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>, julien.voisin@dustri.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mm/slab: Introduce kmem_buckets_create() and
 family
Message-ID: <202405310932.B47B632@keescook>
References: <20240424213019.make.366-kees@kernel.org>
 <20240424214104.3248214-4-keescook@chromium.org>
 <eab4f90c-bfb2-4595-9f52-f88146310c6f@suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab4f90c-bfb2-4595-9f52-f88146310c6f@suse.cz>

On Fri, May 24, 2024 at 03:43:33PM +0200, Vlastimil Babka wrote:
> On 4/24/24 11:41 PM, Kees Cook wrote:
> > Dedicated caches are available for fixed size allocations via
> > kmem_cache_alloc(), but for dynamically sized allocations there is only
> > the global kmalloc API's set of buckets available. This means it isn't
> > possible to separate specific sets of dynamically sized allocations into
> > a separate collection of caches.
> > 
> > This leads to a use-after-free exploitation weakness in the Linux
> > kernel since many heap memory spraying/grooming attacks depend on using
> > userspace-controllable dynamically sized allocations to collide with
> > fixed size allocations that end up in same cache.
> > 
> > While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> > against these kinds of "type confusion" attacks, including for fixed
> > same-size heap objects, we can create a complementary deterministic
> > defense for dynamically sized allocations that are directly user
> > controlled. Addressing these cases is limited in scope, so isolation these
> > kinds of interfaces will not become an unbounded game of whack-a-mole. For
> > example, pass through memdup_user(), making isolation there very
> > effective.
> > 
> > In order to isolate user-controllable sized allocations from system
> > allocations, introduce kmem_buckets_create(), which behaves like
> > kmem_cache_create(). Introduce kmem_buckets_alloc(), which behaves like
> > kmem_cache_alloc(). Introduce kmem_buckets_alloc_track_caller() for
> > where caller tracking is needed. Introduce kmem_buckets_valloc() for
> > cases where vmalloc callback is needed.
> > 
> > Allows for confining allocations to a dedicated set of sized caches
> > (which have the same layout as the kmalloc caches).
> > 
> > This can also be used in the future to extend codetag allocation
> > annotations to implement per-caller allocation cache isolation[1] even
> > for dynamic allocations.
> > 
> > Memory allocation pinning[2] is still needed to plug the Use-After-Free
> > cross-allocator weakness, but that is an existing and separate issue
> > which is complementary to this improvement. Development continues for
> > that feature via the SLAB_VIRTUAL[3] series (which could also provide
> > guard pages -- another complementary improvement).
> > 
> > Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
> > Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
> > Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> So this seems like it's all unconditional and not depending on a config
> option? I'd rather see one, as has been done for all similar functionality
> before, as not everyone will want this trade-off.

Okay, sure, I can do that. Since it was changing some of the core APIs
to pass in the target buckets (instead of using the global buckets), it
seemed less complex to me to just make the simple changes unconditional.

> Also AFAIU every new user (patches 5, 6) will add new bunch of lines to
> /proc/slabinfo? And when you integrate alloc tagging, do you expect every

Yes, that's true, but that's the goal: they want to live in a separate
bucket collection. At present, it's only two, and arguable almost
everything that the manual isolation provides should be using the
mem_from_user() interface anyway.

> callsite will do that as well? Any idea how many there would be and what
> kind of memory overhead it will have in the end?

I haven't measured the per-codetag-site overhead, but I don't expect it
to have giant overhead. If the buckets are created on demand, it should
be small.

But one step at a time. This provides the infrastructure needed to
immediately solve the low-hanging exploitable fruit and to pave the way
for the per-codetag-site automation.

-Kees

-- 
Kees Cook
