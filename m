Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794627507;
	b=vWb9SAEH344O5u27n2VmodSouEk6Ay6h/yP6T0TOPGqB+5I4K+qWvucSM0f4TCCPStvZ
	 PdZW5SkGv1F1Ovp1spzjWyWb5A9supHPbbsnmxSNUsLKvt0sY8oNolvbjUo/dTNd2Z5nY
	 rq7ojpq78dFopMg6pR3GaGi/GiRrt5V2V6xnqVm4s62xLFDNrVXdvc55Mp0yMQaXfRvut
	 agw6d+1dCYg0WvxHRZT9e0aupyVh1ub9LHucm8mXkPQGNwKtrg+P5kJAfjRAC2xV7cWXG
	 DMoEp22RUAFNG3Rwhu7K6pykHCw8bGLLnC/dMhdUeMiQgsjxrMYR+U1eMwCXpMNzbMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794627507;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yU/5BPJ2TQOxgYVVI8HlorlFhoWXcWnPPL8fgZ8lABI=;
	b=OdZGYKSee+ost6E8xbEfMrA5WJi6zYCZMgd7/RlFE1kABeN5noQrB322LNbkEfBiJ0G4
	 sq9L3aDoR9m29YqkLG6Itcxdr+rV+fZ7aiS6pJGc22jXzKPjbNGINu6206r2Ci1eeULp7
	 bDY4vZOgtxd/TYxxVj+ByKUC4UcoES3yWdo0PhI1pW9UHO5WHuniQ3y+P9cXkLl52Sjkg
	 b3Ba1eZVQaJEpnzUSOCWsajcUM5xtCyDkOFhs2IsBBLZwTPdCrgcKvvxwuhCRaqyoZ3rc
	 DwKfZNeUpa6uE+nQbCp9/rj4VMV7mkisvpHMT2mNZC3D6c6ujm3xIkrP3UiTy3+/RNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ckspue12;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90F606A881;
	Sat, 14 Nov 2026 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ckspue12
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95471F000CB;
	Sat, 14 Nov 2026 03:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794627507;
	bh=yU/5BPJ2TQOxgYVVI8HlorlFhoWXcWnPPL8fgZ8lABI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ckspue12vhtoodYEOl81nD3fwNQ/qoegECvhTq8vaJ+UbCR+wKH1UTuwbk7sAWGza
	 VL0hUZB87GCd6EV5jOWkMr7zAClDVgNA/0g1t6fZQRLlktqV7qKUjC/rM3B8C51/dh
	 fCL8Y21AYDytFPuxUczkPTHQ1RgrTBU0b6gdT5M9zKHFOdU6SNjoa7kP00JxBOYLH4
	 FA2KtMqlzpQohSAowkmIHngmDEz0JmFi3pOLDVKgbLOdnnwY+Xag/Taqeat85bPRRl
	 dRFSdPd7+2vogdN/w3sz1NZDXn7oIqDm7aIDZejDwgf3VCCheVfOdKSgyJoNSfx6MX
	 IZP9e2DuBSv/g==
Date: Sat, 14 Nov 2026 03:38:25 +0000
From: Harry Yoo <harry@kernel.org>
To: Felix Hoffmann <f3lix.dev@gmx.de>
Cc: Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>, 
	Tamas Koczka <poprdi@google.com>, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Flush virtual-slab work before cache destruction
Message-ID: <179462737686.1463521.17920259642574913474@kernel.org>
References: <20261113221330.162567-1-f3lix.dev@gmx.de>
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
In-Reply-To: <20261113221330.162567-1-f3lix.dev@gmx.de>

Hi Felix,

CONFIG_SLAB_VIRTUAL is not in the upstream kernel.
Maybe you sent a patch for a downstream tree to the upstream?

On Fri, 13 Nov 2026 23:13:30 +0100, Felix Hoffmann wrote:
> Under CONFIG_SLAB_VIRTUAL, freeing a slab queues it to
> slub_tlbflush_work. The worker later follows slab->slab_cache to take the
> cache's virtual-slab lock and update its lists.
>
> __kmem_cache_shutdown() can report success after the last slabs have been
> removed from the cache's accounting but before that deferred work runs.
> The cache can then be released while queued slabs still refer to it. When
> the worker runs, it dereferences the freed kmem_cache and corrupts its
> lists.
>
> Flush the virtual-slab worker after confirming that every cache node is
> empty and before allowing cache destruction to proceed. This drains both
> queued and running work that can still reference the cache.
>
> Fixes: 0d6f38b78adda ("mm/slub: allocate slabs from virtual memory")
> Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
> ---
> Tested on x86-64 with KCSAN enabled:
>
>   - on the unmodified SLAB_VIRTUAL feature kernel, a stress module that
>     repeatedly created, filled, emptied and destroyed a non-mergeable cache
>     triggered list corruption in slub_tlbflush_worker() and panicked the
>     kernel almost immediately
>   - with this change, the identical module completed 10,000 cache
>     create/destroy cycles (81.92 million allocation/free pairs) without a
>     BUG, warning, KCSAN report or panic
>   - the fixed KCSAN kernel and the external stress module build with W=1
>
> The reproducer and complete console logs are available privately on request.
>  mm/slub.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index b4c64b2bbd334..dbfd42b31a0a2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -8541,6 +8541,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>  		if (n->nr_partial || node_nr_slabs(n))
>  			return 1;
>  	}
> +
> +#ifdef CONFIG_SLAB_VIRTUAL
> +	/* The TLB flush worker still dereferences slab->slab_cache. */
> +	kthread_flush_work(&slub_tlbflush_work);
> +#endif
>  	return 0;
>  }
>
> --
> 2.43.0
