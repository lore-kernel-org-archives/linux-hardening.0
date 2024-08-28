Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AFBD512;
	Wed, 28 Aug 2024 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724804380; cv=none; b=FOSgkK5/UWA9yjlhEvSBg6QiHCfc3C2JTCuj88PxDGmBnbZ12vTGnPufZP8D0i9IYlhL2yvQiv8+koOdBgrNOmxUxlBcPEKKa+yOSlE+mOH/+VlbTRK41JBWTtoJa4+ok0Uwx4h+yv4dj2WXkncIfJigpRtWCvLwrWzIVMq+WtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724804380; c=relaxed/simple;
	bh=ZoyDIz63nWYpi7kgSp5N7yU52tLO9esbjOR04pJNKQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3iVLHG9MamNsA3FF6WaweRTc2ruHg1rPXOB+cHTU6QCamsVdcmc9RGYSHShOBRgGNX0MLxbIHlwCm3UIMTKGW1G8b6MJsIr6eanhdnj8g5E25yrQiSbKZUSqnSyd+27jgBCUZOwjNKu5ESpl7UyITdxlw5NkVQV6Wb9plPZfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtdnD7A7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtdnD7A7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECCAC4DDEF;
	Wed, 28 Aug 2024 00:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724804380;
	bh=ZoyDIz63nWYpi7kgSp5N7yU52tLO9esbjOR04pJNKQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtdnD7A7NsL4pMbFwtC2SBfC8RVhRJP9WNAQvLy78pWjWCPOVs/B4zGwI0FqY8JRU
	 bgAbYXiozbSt1NvLkB5p7DCKTvBckJdwZK44PyoAJBjxY7r2wWsLnytSDoglhsHzYt
	 o8oXbN2PDIJUBkK0/ueRACpFtnpx+W8hWU3KwQA/5FBmm6Vz4NS/d9Xeb2OfcrqkIq
	 asNLlP3AgZq84n+E8qXDJoIGqqSpBQz0XdxSaXy05Pm/cFmpLXZ4/3jUvWfewWDH9z
	 LgTm4YfbPiWf6VTbL83e4sQOh1JpyvYLxWaZFZlTjRiZw8H/l9/uPN1abcRhWS3mcZ
	 edqhHRikuJgVQ==
Date: Tue, 27 Aug 2024 17:19:39 -0700
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>, linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] slab: Introduce kmalloc_obj() and family
Message-ID: <202408271709.31D322019@keescook>
References: <20240822231324.make.666-kees@kernel.org>
 <5c3852e6-4a6a-42d8-85ff-8c1605939454@suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3852e6-4a6a-42d8-85ff-8c1605939454@suse.cz>

On Tue, Aug 27, 2024 at 11:32:14PM +0200, Vlastimil Babka wrote:
> +Cc Linus
> 
> On 8/23/24 01:13, Kees Cook wrote:
> > Introduce type-aware kmalloc-family helpers to replace the common
> > idioms for single, array, and flexible object allocations:
> > 
> > 	ptr = kmalloc(sizeof(*ptr), gfp);
> > 	ptr = kzalloc(sizeof(*ptr), gfp);
> > 	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
> > 	ptr = kcalloc(count, sizeof(*ptr), gfp);
> > 	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);
> > 
> > These become, respectively:
> > 
> > 	kmalloc_obj(ptr, gfp);
> > 	kzalloc_obj(ptr, gfp);
> > 	kmalloc_objs(ptr, count, gfp);
> > 	kzalloc_objs(ptr, count, gfp);
> > 	kmalloc_flex(ptr, flex_member, count, gfp);
> 
> This is indeed better than the previous version. The hidden assignment to
> ptr seems still very counter-intuitive, but if it's the only way to do those
> validations, the question is then just whether it's worth the getting used
> to it, or not.

We could make the syntax require "&ptr"?

As for alternatives, one thing I investigated for a while that made
several compiler people unhappy was to introduce an builtin named
something like __builtin_lvalue() which could be used on the RHS of an
assignment to discover the lvalue in some way. Then we could, for
example, add alignment discovery like so:

#define kmalloc(_size, _gfp)	\
	__kmalloc(_size, __alignof(typeof(__builtin_lvalue())), _gfp)

or do the FAM struct allocations:

#define kmalloc_flex(_member, _count, _gfp)	\
	__kmalloc(sizeof(*typeof(__builtin_lvalue())) +
		  sizeof(*__builtin_lvalue()->_member) * (_count), gfp)

Compiler folks seems very unhappy with this, though. As I can recognize
it creates problems for stuff like:

	return kmalloc(...)

Of course the proposed macros still have the above problem, and both to
use a temporary variable to deal with it.

So, really it's a question of "how best to introspect the lvalue?"

> [...]
> > by GCC[1] and Clang[2]. The internal use of __flex_count() allows for
> > automatically setting the counter member of a struct's flexible array
> 
> But if it's a to-be-implemented feature, perhaps it would be too early to
> include it here? Were you able to even test that part right now?

There are RFC patches for both GCC and Clang that I tested against.
However, yes, it is still pretty early. I just wanted to show that it
can work, etc. (i.e. not propose a macro with no "real" benefit over the
existing assignments).

> [...]
> > Replacing all existing simple code patterns found via Coccinelle[3]
> > shows what could be replaced immediately (saving roughly 1,500 lines):
> > 
> >  7040 files changed, 14128 insertions(+), 15557 deletions(-)
> 
> Since that could be feasible to apply only if Linus ran that directly
> himself, including him now. Because doing it any other way would leave us
> semi-converted forever and not bring the full benefits?

Right -- I'd want to do a mass conversion and follow it up with any
remaining ones. There are a lot in the style of "return k*alloc(...)"
for example.

> [...]
> > +#define kvmalloc_obj(P, FLAGS)				\
> > +	__alloc_objs(kvmalloc, P, 1, FLAGS, NULL)
> 
> Wonder if there is really a single struct (not array) with no flex array
> that could need kvmalloc? :)

Ah, yes, Good point. I was going for "full" macro coverage. :P

Thanks for looking at this!

-Kees

-- 
Kees Cook
