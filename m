Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B08488;
	Tue,  7 Oct 2025 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759802874; cv=none; b=oGBxv+2U+2CaJqt76uEDlX8VxhcJNDPdr8stJKTCwnb+59UAbr5y01dQeGbidhZC0rp4RCYj4wQYTZrGYN2WzF0sv/9pUqNQWNxplYRshlUoUPifkPlb9gN0sScuwr6FPuQ4G445st2/nxyTWuboVfjd5qCFBmr4UXlbBnZqEHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759802874; c=relaxed/simple;
	bh=vTd9S+B7Dx3MAbsT6utemI9fOi3cMISlPTKvVv3lPkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p14/joS6DYUkqyH98NFOayCzb88OsHPMbH3ExhBQx5x62Ix9D00K2WvhOx7CI0RTbvarIjCVcobuzy0FaKfbcU8XkPehPTvnZH2aYfAnSQQvshVGVzJJg4aJyfqsdR7MgLPsNGtJ1MJnxaoJTXbjxf3dVoU26WdOqzP7Do/eorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZpMvRr7h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpMvRr7h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OuPt71NmMidGtdlQykkoZsTnnRr+qx1jmb+5gKzLx+E=; b=ZpMvRr7hgj3fyfMUpCnXiyu4/D
	x8r4JH14RaG1qEJLKdCABLMvvriTI+vQZvT5ij04S8iZT3GXt0L+XG651Fx7LpsVASxDcivvVTbP8
	YX9Cd1yMkPPdqfzGKv90q2waA3MdXdYYC2ATriV8XHbSuvclbebqTngcLex2LHUHWOHy6CSmvUOFm
	0d/crWkbRhEPGKh5fDOkBr2JTAlMceA6torGF2cCLlbXjYDen9/ou0pjW7rN0ak8yjCPBMeH/Dtx1
	iEE2mcdzJN+h5wq3kqEUV6aW5JT77oyVCeSSdkyH9qvkLNn7oSK9yxanWKz6teiXupLlwMdiwh00B
	cKrtDQKA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5x6z-000000064Za-34GJ;
	Tue, 07 Oct 2025 02:07:34 +0000
Date: Tue, 7 Oct 2025 03:07:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
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
	Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
Message-ID: <aOR15Xb6DfolYM0z@casper.infradead.org>
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-2-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315031550.473587-2-kees@kernel.org>

On Fri, Mar 14, 2025 at 08:15:45PM -0700, Kees Cook wrote:
> +Performing open-coded kmalloc()-family allocation assignments prevents
> +the kernel (and compiler) from being able to examine the type of the
> +variable being assigned, which limits any related introspection that
> +may help with alignment, wrap-around, or additional hardening. The
> +kmalloc_obj()-family of macros provide this introspection, which can be
> +used for the common code patterns for single, array, and flexible object
> +allocations. For example, these open coded assignments::
> +
> +	ptr = kmalloc(sizeof(*ptr), gfp);
> +	ptr = kmalloc(sizeof(struct the_type_of_ptr_obj), gfp);
> +	ptr = kzalloc(sizeof(*ptr), gfp);
> +	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
> +	ptr = kcalloc(count, sizeof(*ptr), gfp);
> +	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);
> +
> +become, respectively::
> +
> +	kmalloc_obj(ptr, gfp);
> +	kzalloc_obj(ptr, gfp);
> +	kmalloc_objs(ptr, count, gfp);
> +	kzalloc_objs(ptr, count, gfp);
> +	kmalloc_flex(ptr, flex_member, count, gfp);

I'd like to propose a different approach for consideration.

The first two are obvious.  If we now believe that object type is the
important thing, well we have an API for that:

struct buffer_head { ... };

	bh_cache = KMEM_CACHE(buffer_head, SLAB_RECLAIM_ACCOUNT);
...
	ptr = kmem_cache_alloc(bh_cache, GFP_KERNEL);

It's a little more verbose than what you're suggesting, but it does give
us the chance to specify SLAB_ flags.  It already does the alignment
optimisation you're suggesting.  Maybe we can use some macro sugar to
simplify this.

The array ones are a little tougher.  Let's set them aside for the
moment and tackle the really hard one; kmalloc_flex.

Slab is fundamentally built on all objects in the slab being the same
size.  But maybe someone sufficiently enterprising could build a
"variable sized" slab variant?  If we're saying that object type is
more important a discriminator than object size, then perhaps grouping
objects of the same size together isn't nearly as useful as grouping
objects of the same type together, even if they're different sizes.

Might be a good GSoC/outreachy project?

