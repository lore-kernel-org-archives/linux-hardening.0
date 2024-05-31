Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17FA156242;
	Fri, 31 May 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173589; cv=none; b=OrQUsL48rqE2HAV2hb2B+4xGTv2/E+EhtLXZMqwWYS+U7kVe7q4AcJglPzi9QxrO/wBvCbL1/uiDZsZyyw1sekYoCwzyfLWTrPsFP2WiNZ5gTcz6dJzWz44Kv8snbs7q29UcZTfJTWGytoAV79ray0pkUuNPRXWAD3JvARpx7nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173589; c=relaxed/simple;
	bh=gsALt8b3H3D8q2jgqEBlh7ZH83mNDV1aBfFcts9SM0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg6wKza72+TFtecxKjLoqZxzOBtrUvzwSYU0PPje8gxX5d5VJ9ZNGFCOkqockmWICyOfAr3Ws4l2fiPyCqKiNTaiq3qBrkPpWk56oBxhQdJ6XjaDlvc1goJh48POGakJdr3DjBnmhsrwKckfu0NVnBVQW/7M0jL1dcC3UyYAxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0YPJ+tR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0YPJ+tR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF9FC116B1;
	Fri, 31 May 2024 16:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717173588;
	bh=gsALt8b3H3D8q2jgqEBlh7ZH83mNDV1aBfFcts9SM0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0YPJ+tRu7KQvvMWn+FqGf7Ds8NiCGKgObBP/DOHBxKqAXzkTMINok/izr/CIvgFp
	 h7314WElslBeOUoScNRuw+2QiRvqcjPq2cstDU6KK/7YxCW6dNSjtIFOmMTmyuUn4o
	 sT9BE4zvuQQtxhwMD/WHfwXOe2BpUj0wzzlrMaJfqmUVl4Ryl8hGjc6zaiZgaT0lWk
	 321jEKHdUeRMG7S/Ecv2EGrBNSKWEHC5P/4pP8MZtLf6tQAk7DVhjv7BCwDmDK/a8P
	 aewo8jJuljk4xDCjbSFNN/YMeyJsc87NYkGn9oQQ7IteDwmIjFtIvhgv3vzEuOe5A/
	 gdoxBcI2JRTSw==
Date: Fri, 31 May 2024 09:39:48 -0700
From: Kees Cook <kees@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>, julien.voisin@dustri.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/6] slab: Introduce dedicated bucket allocator
Message-ID: <202405310938.A6EFEADB79@keescook>
References: <20240424213019.make.366-kees@kernel.org>
 <7nonr2cucww7j55kresncgt23pvgt3pmnfukqpnqblk3fmtfdl@ewhqe3ylioz2>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7nonr2cucww7j55kresncgt23pvgt3pmnfukqpnqblk3fmtfdl@ewhqe3ylioz2>

On Fri, May 24, 2024 at 10:54:58AM -0400, Kent Overstreet wrote:
> On Wed, Apr 24, 2024 at 02:40:57PM -0700, Kees Cook wrote:
> > Hi,
> > 
> > Series change history:
> > 
> >  v3:
> >   - clarify rationale and purpose in commit log
> >   - rebase to -next (CONFIG_CODE_TAGGING)
> >   - simplify calling styles and split out bucket plumbing more cleanly
> >   - consolidate kmem_buckets_*() family introduction patches
> >  v2: https://lore.kernel.org/lkml/20240305100933.it.923-kees@kernel.org/
> >  v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/
> > 
> > For the cover letter, I'm repeating commit log for patch 4 here, which has
> > additional clarifications and rationale since v2:
> > 
> >     Dedicated caches are available for fixed size allocations via
> >     kmem_cache_alloc(), but for dynamically sized allocations there is only
> >     the global kmalloc API's set of buckets available. This means it isn't
> >     possible to separate specific sets of dynamically sized allocations into
> >     a separate collection of caches.
> >     
> >     This leads to a use-after-free exploitation weakness in the Linux
> >     kernel since many heap memory spraying/grooming attacks depend on using
> >     userspace-controllable dynamically sized allocations to collide with
> >     fixed size allocations that end up in same cache.
> 
> This is going to increase internal fragmentation in the slab allocator,
> so we're going to need better, more visible numbers on the amount of
> memory stranded thusly, so users can easily see the effect this has.

Yes, but not significantly. It's less than the 16-buckets randomized
kmalloc implementation. The numbers will be visible in /proc/slabinfo
just like any other.

> Please also document this effect and point users in the documentation
> where to check, so that we devs can get feedback on this.

Okay, sure. In the commit log, or did you have somewhere else in mind?

-- 
Kees Cook
