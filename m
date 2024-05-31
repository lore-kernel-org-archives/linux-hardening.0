Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7437F7F7;
	Fri, 31 May 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174130; cv=none; b=EEJqtvCo2JJ+xF7W/4/ZKfEnGnrrnRv9twval+ztsjK121msC9kEOGfoIxHqp/VuvRDew7Z2bHyGpcqWUqFrYugy9X3f3QgD006KLRZenX1atTeLce4LbGZyMKEwgtcjMaIHW2V7kSVaqq0lMkevIRZGSV+F/wzG3nYY48z0RdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174130; c=relaxed/simple;
	bh=7NIOshqsMg6hd7t1Z6w0jLoqyFdwJa2iySu2w9THERY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRj+TPe9lNl9lSgl1qJ5wiiECnIzGCU9Ap/ekJLGphXK9BMGMbrFKwHPQ41W/to5E3d+CaxGSChnT9x0xdvu9UsRElm4Sum9kE/109tSW87cLmd8CGE8PYPdEn+rKQbYQc3dS24/ce5xQm5pKh+RT1OMP+A7FeA0uHddXO+fMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbobTXkM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbobTXkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E9DC116B1;
	Fri, 31 May 2024 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717174130;
	bh=7NIOshqsMg6hd7t1Z6w0jLoqyFdwJa2iySu2w9THERY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbobTXkMaJCoz8B1Mrm3hCVPLVj/NtKblGSDve2mUncZusGL8g4sYRgASjGF0gVvM
	 uCXWBjYEm5z39Dpy2JAiFmaQH9YjEoZJx/22LEC+tlKiTV3D2lngXBWtn+0l//J/Nd
	 47LbbMukEOiDqfEhkwK3kbyMXEX1/0Zt6eKey2ulLmMiQM8P7RTt8rpvMrnmXTvaAm
	 S9MNZ241fc2loO7sYCqfh9pZ3K5HmYz4V9Pn0k4rJmI/QJ5KnIWoWAd1GkEwXj8lMN
	 LepKOZmBmhsp4aKFd8NIVqnJEqpqHfqEsXEoTdu12NZmcSESILKLamATqeIiup3/Wd
	 OpMQ38+d7Dz/Q==
Date: Fri, 31 May 2024 09:48:49 -0700
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
Message-ID: <202405310943.D9818A4FE@keescook>
References: <20240424213019.make.366-kees@kernel.org>
 <20240424214104.3248214-2-keescook@chromium.org>
 <zxc3fpd552hnd4jumot2k3bnol3pe2ooybz2rts4qrcxpgn7ll@4aggaem6acjw>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zxc3fpd552hnd4jumot2k3bnol3pe2ooybz2rts4qrcxpgn7ll@4aggaem6acjw>

On Fri, May 24, 2024 at 11:01:40AM -0400, Kent Overstreet wrote:
> On Wed, Apr 24, 2024 at 02:40:59PM -0700, Kees Cook wrote:
> > To be able to choose which buckets to allocate from, make the buckets
> > available to the lower level kmalloc interfaces by adding them as the
> > first argument. Where the bucket is not available, pass NULL, which means
> > "use the default system kmalloc bucket set" (the prior existing behavior),
> > as implemented in kmalloc_slab().
> 
> I thought the plan was to use codetags for this? That would obviate the
> need for all this plumbing.
> 
> Add fields to the alloc tag for:
>  - allocation size (or 0 if it's not a compile time constant)
>  - union of kmem_cache, kmem_buckets, depending on whether the
>    allocation size is constant or not

I want to provide "simple" (low-hanging fruit) coverage that can live
separately from the codetags-based coverage. The memory overhead for
this patch series is negligible, but I suspect the codetags expansion,
while not giant, will be more than some deployments will want. I want
to avoid an all-or-nothing solution -- which is why I had intended this
to be available "by default".

But I will respin this with kmem_buckets under a Kconfig.

-- 
Kees Cook
