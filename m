Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BC224DD;
	Fri, 31 May 2024 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189155; cv=none; b=sFYZv7bqboALn1wOAXz6+KtDzI/w6Owuu2Ua4OgMIDUTWABmcs/KkL3SAn9IPSY41HpNEwaHKEQeG0yMAtvZCvg/SDRTm4BkaV79XkvcyFnp6Ad9pSm+TVEx+WrufYgYwlAK3OgD0Cy+bnbygWQZ274DL21pNOs9iErNwAOwLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189155; c=relaxed/simple;
	bh=Lh/cjNZA4vCUPn9FhPgLX85uXMRWMwk57EIVdsl1yUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOlblxNYg0o6N6VHUJsXWMvNuO9Zcq5+/0/lm8VBK4aJCTw7jb6Jkf2tzCCPrO4zz60KiftTwx94d7kPWPkvP4CYc5c/9TDacPLaAtYgYObkLa39AOc9XaBJL4kyJIcd0coF1Kyq9KgYVkwtOr14lQajhkzdQHTx3KrExr2nyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPi+plar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPi+plar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA8AC116B1;
	Fri, 31 May 2024 20:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717189154;
	bh=Lh/cjNZA4vCUPn9FhPgLX85uXMRWMwk57EIVdsl1yUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPi+plarSLmZmS0y099tumxuYiHlY3/14Lz6Y492HHG7LECDbYLrWWeUJ65ELY7Gz
	 74ChdAs4JgdAgNYZToxGDzgRzQzzBbVKUF+zZg57ZMz4EoHQOdvbHjteo4eoLaHMgU
	 w/2LA8Bql/y1Q8IMB1niy+I4e9kAGva3D7ZBPY/15Dio820tgbY3RtxL9LLafYPIPW
	 4xs5/mR7VDnXpYON9EZEq35G4n0OtOza6wVtjmg/boixgcT/eUMcioPr9udfSSxZSc
	 WmRo2Sru2qIjGECt5pI27dkB0zXWRrkEfF3TnjaC54zTd5ozucFWGDfHBu3iZJ6noD
	 03c8pU/HjaCEg==
Date: Fri, 31 May 2024 13:59:14 -0700
From: Kees Cook <kees@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>, julien.voisin@dustri.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mm/slab: Plumb kmem_buckets into
 __do_kmalloc_node()
Message-ID: <202405311355.B6EBA095@keescook>
References: <20240424213019.make.366-kees@kernel.org>
 <20240424214104.3248214-2-keescook@chromium.org>
 <zxc3fpd552hnd4jumot2k3bnol3pe2ooybz2rts4qrcxpgn7ll@4aggaem6acjw>
 <202405310943.D9818A4FE@keescook>
 <tkjmauxa4jigjznxp2ltxymz3u6urwuzwnbaaxmdg6ema7yf5a@fb2etkpyd4g4>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkjmauxa4jigjznxp2ltxymz3u6urwuzwnbaaxmdg6ema7yf5a@fb2etkpyd4g4>

On Fri, May 31, 2024 at 12:51:29PM -0400, Kent Overstreet wrote:
> On Fri, May 31, 2024 at 09:48:49AM -0700, Kees Cook wrote:
> > On Fri, May 24, 2024 at 11:01:40AM -0400, Kent Overstreet wrote:
> > > On Wed, Apr 24, 2024 at 02:40:59PM -0700, Kees Cook wrote:
> > > > To be able to choose which buckets to allocate from, make the buckets
> > > > available to the lower level kmalloc interfaces by adding them as the
> > > > first argument. Where the bucket is not available, pass NULL, which means
> > > > "use the default system kmalloc bucket set" (the prior existing behavior),
> > > > as implemented in kmalloc_slab().
> > > 
> > > I thought the plan was to use codetags for this? That would obviate the
> > > need for all this plumbing.
> > > 
> > > Add fields to the alloc tag for:
> > >  - allocation size (or 0 if it's not a compile time constant)
> > >  - union of kmem_cache, kmem_buckets, depending on whether the
> > >    allocation size is constant or not
> > 
> > I want to provide "simple" (low-hanging fruit) coverage that can live
> > separately from the codetags-based coverage. The memory overhead for
> > this patch series is negligible, but I suspect the codetags expansion,
> > while not giant, will be more than some deployments will want. I want
> > to avoid an all-or-nothing solution -- which is why I had intended this
> > to be available "by default".
> 
> technically there's no reason for your thing to depend on
> CONFIG_CODETAGGING at all, that's the infrastructure for finding
> codetags for e.g. /proc/allocinfo. you'd just be using the alloc_hoos()
> macro and struct alloc_tag as a place to stash the kmem_buckets pointer.

It's the overhead of separate kmem_cache and kmem_buckets for every
allocation location that I meant. So I'd like the "simple" version for
gaining coverage over the currently-being-regularly-exploited cases, and
then allow for the "big hammer" solution too.

However, I do think I'll still need the codetag infra because of the
sections, etc. I think we'll need to pre-build the caches, but maybe
that could be avoided by adding some kind of per-site READ_ONCE/lock
thingy to create them on demand. We'll see! :)

-- 
Kees Cook
