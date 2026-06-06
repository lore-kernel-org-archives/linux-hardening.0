Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821517B425;
	Sat,  6 Jun 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777156; cv=none; b=UdKLa1rBVghJcdRBbNqOrzdh+l516FOMgYaTP0G425HBrWoDH2lPapJbVnFTaV96pZuOyQXEOVqTAxug6K47TfA+Xh3VNDSUAAwnUGLfDKUgzFksJYWivSwq05Cfmu8dFkTM1cr8SWn6vXG3NA00eSJj6+HHQEaHzdvmEBTpkA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777156; c=relaxed/simple;
	bh=6FrevDetvkb60F0vwZ8cvbynNZOisu9LM8VFn5Kv0jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYBJubh1GE29LmxJV+ELwCa6ZTfR9Q2ActEEDKB8QOeoJOh8pZ7fAUp1FJ1PpYddRpGffZ+fYmHPZPuz5m2YuFQmZwTxjrmXf/YWQ7CLvp9uhQmUrrGp2zobGr1KMUMjHIWggXSdaBM6WKOlJbFLPpi59rHdYO2gSRsejqoiRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LKiw7YU7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LKiw7YU7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qn/GwpLQrIFJP6RrB5tk+eCxp+XsTc6Qi46I9/Pk/bg=; b=LKiw7YU7YB5iPci7joQBn8opCX
	QPc4PL+SnIhhQ3mi23T/jG60gOhikMnbAGJW6eqbnMZKNGy2ei/X/uRgLrWL7puLUSdZUwsgu/6EJ
	ktBNNPXlQR8OYKMHom7a1UajkkvcgYUAzx2ONDX5DCPBeYJFltj3ogCxfH15i0cdA2+Ewk//R70ya
	Qy+Bkid7+kqgOrOUEZ++1Lk91q3rLOHxw0jpFf690VV6h3Prb8ZNRldrGiSwY1DnboVUtGXfdP+F7
	iVWhHot6bDPX3Aej+0kdQue9LTn6F43cxhWGwUG9oJayhPCgyI1Hepdr/X7XIGquTs9XzwyuScixg
	xHD6eaoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVxU0-0000000ApOr-3385;
	Sat, 06 Jun 2026 20:19:04 +0000
Date: Sat, 6 Jun 2026 21:19:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/mm: document slab cache isolation with SLAB_NO_MERGE
Message-ID: <aiSAuP-qEhH_RoCn@casper.infradead.org>
References: <20260606155856.15548-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606155856.15548-1-med08elkadiri@gmail.com>

On Sat, Jun 06, 2026 at 04:58:55PM +0100, Mohammed EL Kadiri wrote:
> +The SLUB allocator merges slab caches with compatible size, alignment, and

More of a question for Vlastimil ... do we want to continue to
distinguish between slab (the API) and SLUB (the implementation)?
I don't think we ever want to go back to a situation where we have
multiple competing implementations of the slab API in the kernel.
So shouldn't we deprecate uses of SLUB, particularly in the
documentation?

> +flags to reduce memory fragmentation. While this improves memory efficiency,
> +it allows objects of different types to share the same slab pages. This

s/ pages//

> +enables cross-cache heap exploitation, where a use-after-free in one object
> +type can be leveraged to corrupt an unrelated type.
> +
> +The `SLAB_NO_MERGE` flag prevents a cache from being merged, ensuring it
> +receives dedicated slab pages.

s/slab pages/a dedicated slab/

> +2. *Actually mergeable*: The cache must not already be unmergeable.
> +   A cache is already unmergeable if any of the following is true:
> +
> +   - It has a constructor (`ctor` argument is non-NULL).
> +   - It has a non-zero `usersize` (with `CONFIG_HARDENED_USERCOPY`).
> +   - It already has `SLAB_NO_MERGE` or another `SLAB_NEVER_MERGE` flag.

I don't know if this is good advice for users of the API.  It's true
that the slab will already be unmergable for these other reasons, but
it's harmless to specify SLAB_NO_MERGE in that case.  And it
communicates intent.  And in case somebody removes the ctor in the
future, or we decide to change which flags are in SLAB_NEVER_MERGE,
the slab will still be unmergable.

> +3. *Bounded allocation volume*: The cache has a predictable number of
> +   active objects, so the memory cost of dedicated slab pages is
> +   acceptable.

I don't understand why this is a criteria.

> +How merging works
> +=================
> +
> +When `kmem_cache_create()` is called:
> +
> +1. If `usersize` is non-zero, the merge path is skipped entirely.
> +
> +2. Otherwise, `find_mergeable()` in `mm/slab_common.c` searches for a
> +   compatible existing cache. A merge is prevented if:
> +
> +   - The `slab_nomerge` boot parameter is set
> +   - The new cache has a constructor
> +   - The new cache's flags include `SLAB_NO_MERGE`
> +   - No existing cache has compatible size and flags
> +
> +3. If a compatible cache is found, the new cache becomes an alias. Both
> +   share the same slab pages.

This feels like documenting internals rather than documenting how to use
the flag.  I'd drop it entirely.

> +The cross-cache attack class
> +=============================
> +
> +Cross-cache attacks exploit slab merging to achieve type confusion:
> +
> +1. Attacker triggers a use-after-free in object type A.
> +2. Type A's cache is merged with type B (they share slab pages).
> +3. The freed type A slot is reallocated as type B.
> +4. Attacker uses the dangling pointer to corrupt type B.
> +5. Privilege escalation.
> +
> +CVE-2022-29582 demonstrates this technique: an io_uring use-after-free is
> +exploited via cross-cache page-level reallocation to achieve root.
> +
> +`SLAB_NO_MERGE` prevents step 2: dedicated pages mean a freed slot of
> +one type cannot be reallocated as a different type.

Not sure this section adds anything to what was already described.

> +Tradeoffs
> +=========
> +
> +*Memory*: Isolated caches may have partially-filled slab pages that
> +cannot be used by other types. For caches with bounded allocation counts,
> +this is typically a few extra pages.
> +
> +*Performance*: Zero impact on `kmem_cache_alloc()` and
> +`kmem_cache_free()`. The only effect is at boot when the cache is
> +created.
> +
> +Relationship to other mitigations
> +==================================
> +
> +`CONFIG_RANDOM_KMALLOC_CACHES`
> +    Creates 16 copies of each `kmalloc` size class and randomly assigns
> +    allocations among them. Only affects `kmalloc()` users. Does not
> +    affect named caches created with `kmem_cache_create()`.
> +
> +`SLAB_TYPESAFE_BY_RCU`
> +    Delays freeing the slab page by an RCU grace period. Does not delay
> +    object slot reuse. Does not prevent cross-cache merging. Solves a
> +    different problem: safe lockless access to freed-and-reallocated
> +    objects of the same type.
> +
> +`slab_nomerge` boot parameter
> +    Disables merging for all caches globally. `SLAB_NO_MERGE` provides
> +    the same protection selectively for individual caches without the
> +    global memory cost.

These two sections also feel unnecessary.
