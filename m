Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDA366DAA;
	Fri,  9 Jan 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979864; cv=none; b=r26Y1u5xwEkO9s20fR+cDg5kSRepIqagLOwEO2mxsKPhUZkxTWIaPwFfb7VRZZYHt1onVBX74wm4uyhkHAJcv1nW/8pGikKZsiJ5rlXbu096nNq+tLgrdOjIrf8OgC3UBe+zcZntK1aL0bxMaD0vab1QEYJwABc1/UCqDr8JaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979864; c=relaxed/simple;
	bh=YnLjCzKnQER3FuCe6ES9oXxik4owd0B4EMad2UIfiEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQwfmhx9TCB7nuYQM9TO2RBC2BxOdYAJzKA5vZFHRgPkP54hXvv2svqXyTUOXYELsF22otyTrVf1l5K5cao7hvJsuAkDN/gVE5FbKUKWawjd18bFKypPQk3yUyefjLOLZIJir0UsMaL+NhSoPlSSSWTI8f3ezjsKFlB4wq9pCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb3uH6ZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb3uH6ZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A50C4CEF1;
	Fri,  9 Jan 2026 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767979863;
	bh=YnLjCzKnQER3FuCe6ES9oXxik4owd0B4EMad2UIfiEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zb3uH6ZBwZfeObknlMhLXz6y0O7Yd+lcbqIxtpbkgUGG6UavcGoHaRkBQvHZSNF2n
	 pQStdXJI1VohLDeR1qpGF74WFMxDsP/uXeJR+ObR3RrmnJaCqkS95C+Hw0RpNuFcf5
	 GoPAEEt/X36hy1dO8AoxU3CZSoGH+q/jL1yiONf0HXzyNofTsQ2jvKOxGds4kh8Yhz
	 XVSGdZy9JI1VUWHgjUrbt0jIjhucw841A0LBiPb8vTymFKMiKsqN6rHciHgyobsQQ3
	 nf6x6z0AGWB9ZAu1Tb/cMu8zbewvjfXfN+ipM7+VPadMwl1+2i0KkND8uJpI3Sk4hA
	 Gw6D4gc9Kd9pQ==
Date: Fri, 9 Jan 2026 09:31:03 -0800
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 1/5] slab: Introduce kmalloc_obj() and family
Message-ID: <202601090928.5CFF95F@keescook>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-1-kees@kernel.org>
 <960729bb-0746-4709-a40c-2e254f963deb@suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960729bb-0746-4709-a40c-2e254f963deb@suse.cz>

On Thu, Jan 08, 2026 at 03:01:00PM +0100, Vlastimil Babka wrote:
> On 12/4/25 00:30, Kees Cook wrote:
> > [...]
> > +/**
> > + * __alloc_objs - Allocate objects of a given type using
> > + * @KMALLOC: which size-based kmalloc wrapper to allocate with.
> > + * @GFP: GFP flags for the allocation.
> > + * @TYPE: type to allocate space for.
> > + * @COUNT: how many @TYPE objects to allocate.
> > + *
> > + * Returns: Newly allocated pointer to (first) @TYPE of @COUNT-many
> > + * allocated @TYPE objects, or NULL on failure.
> > + */
> > +#define __alloc_objs(KMALLOC, GFP, TYPE, COUNT)				\
> > +({									\
> > +	const size_t __obj_size = size_mul(sizeof(TYPE), COUNT);	\
> 
> I assume with the hardcoded 1 for COUNT, this size_mul() will be eliminated
> by the compiler and not add unnecessary runtime overhead? Otherwise we
> should have two core #define variants.

You're correct: the compiler completely collapses it with 0 runtime
overhead; a variant is not needed.

> I also noted that the existing kmalloc_array() and kvmalloc_array() do
> check_mul_overflow() and return NULL silently on overflow. This AFAIU will
> make SIZE_MAX passed to the underlying kmalloc/kvmalloc and thus will cause
> a warning. That's IMHO a good thing.

Right -- I prefer seeing the SIZE_MAX yelling from the allocator. Should
we change how k*malloc_array() behaves?

-Kees

-- 
Kees Cook
