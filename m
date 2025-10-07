Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF834BA34;
	Tue,  7 Oct 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857459; cv=none; b=bVu2TicCaDZZcuLDbCkUfaZLKgBQ6AjS2XA/XFGuh2IOY5iTkXm+oCIXWmjnEjOCz1zOgg2G5w6NmhpVpV8AqMcPoO8P8FrvILby5STrdyuiu/pVd/hNNwZ44k4Y6NHaMvta7aN3fgWy9lh/AwZ+kgLqA3XWxIsK6+EAJPfbakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857459; c=relaxed/simple;
	bh=DAFgXC6SxWdL/cD7ojk7LsHsHwahqWWObauM/TTqz9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1FVWPO/0Q1+26WyvwktMwoEq8NDS0RCgqr/sCCC0cXOh01MXpi/Be0m2Z/XqcVBKBR5KYWbvH35aHH9jswTIwA7Jm1uyjAQ9tlNftm0H9BxIbNdMv/0yUeHDnCaM6MN+IjJwDLmamVCD5Lp3JKyHaGfMN/VYrHDwz4c6gPwwlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSh73hti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSh73hti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C66C4CEF1;
	Tue,  7 Oct 2025 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759857458;
	bh=DAFgXC6SxWdL/cD7ojk7LsHsHwahqWWObauM/TTqz9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSh73htibwbHo797aqyy0ATyVZ1v0pN8Yur3u3gy/4KFT7w4a+bkPaNjov2hdmA0/
	 u8CaPUMV/QxXXeGWwUV2+RjmJzTxT1z20lKVtPGj7hrKe7mJpxepagf5Wfec89hrwe
	 fv21GZ9GJR409dSph3W9pQDUIuGm2A0JeFHeyQrG9k6VfubpS+5BtMRf89QoBUT/mi
	 mzCSAfdpcXMAKf2It86JU6JFMb43A7tMMcpqxBhe1SS0lYsdHswS/uy07jr27NmEuc
	 PL0/ciQMuav2n19IxbfFAWo6vTud4fAd4veAji50d4My7Rh0N1pgu4fAIB0oqVBn0D
	 PS8Ayw2IHr7Rw==
Date: Tue, 7 Oct 2025 10:17:38 -0700
From: Kees Cook <kees@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
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
Message-ID: <202510071001.11497F6708@keescook>
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-2-kees@kernel.org>
 <aOR15Xb6DfolYM0z@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOR15Xb6DfolYM0z@casper.infradead.org>

On Tue, Oct 07, 2025 at 03:07:33AM +0100, Matthew Wilcox wrote:
> On Fri, Mar 14, 2025 at 08:15:45PM -0700, Kees Cook wrote:
> > +Performing open-coded kmalloc()-family allocation assignments prevents
> > +the kernel (and compiler) from being able to examine the type of the
> > +variable being assigned, which limits any related introspection that
> > +may help with alignment, wrap-around, or additional hardening. The
> > +kmalloc_obj()-family of macros provide this introspection, which can be
> > +used for the common code patterns for single, array, and flexible object
> > +allocations. For example, these open coded assignments::
> > +
> > +	ptr = kmalloc(sizeof(*ptr), gfp);
> > +	ptr = kmalloc(sizeof(struct the_type_of_ptr_obj), gfp);
> > +	ptr = kzalloc(sizeof(*ptr), gfp);
> > +	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
> > +	ptr = kcalloc(count, sizeof(*ptr), gfp);
> > +	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);
> > +
> > +become, respectively::
> > +
> > +	kmalloc_obj(ptr, gfp);
> > +	kzalloc_obj(ptr, gfp);
> > +	kmalloc_objs(ptr, count, gfp);
> > +	kzalloc_objs(ptr, count, gfp);
> > +	kmalloc_flex(ptr, flex_member, count, gfp);
> 
> I'd like to propose a different approach for consideration.
> 
> The first two are obvious.  If we now believe that object type is the
> important thing, well we have an API for that:
> 
> struct buffer_head { ... };
> 
> 	bh_cache = KMEM_CACHE(buffer_head, SLAB_RECLAIM_ACCOUNT);
> ...
> 	ptr = kmem_cache_alloc(bh_cache, GFP_KERNEL);
> 
> It's a little more verbose than what you're suggesting, but it does give
> us the chance to specify SLAB_ flags.  It already does the alignment
> optimisation you're suggesting.  Maybe we can use some macro sugar to
> simplify this.

I just don't think this is remotely feasible. We have tens of thousands
of kmalloc callers in the kernel and that's just not going to work. Also
it's wildly redundant given that the type info is present already in
the proposed series -- the point is ot make this something the allocator
can use (if it wants to) and not depend on the user to do it.
kmem_cache_alloc is just too inflexible.

Doing the mechanical transformation of these callsites is also largely
done already via a Coccinelle script I mentioned in earlier threads:
https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/kmalloc_objs.cocci

https://web.git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=dev/v6.14-rc2/alloc_obj/v4-treewide&id=106fd376feea1699868859e82416d5b7c50866ee
7568 files changed, 16342 insertions, 18580 deletions

> The array ones are a little tougher.  Let's set them aside for the
> moment and tackle the really hard one; kmalloc_flex.
> 
> Slab is fundamentally built on all objects in the slab being the same
> size.  But maybe someone sufficiently enterprising could build a
> "variable sized" slab variant?  If we're saying that object type is
> more important a discriminator than object size, then perhaps grouping
> objects of the same size together isn't nearly as useful as grouping
> objects of the same type together, even if they're different sizes.
> 
> Might be a good GSoC/outreachy project?

I already did this (see kmem_buckets_create()) and expanded on it
with the per-call-site series I proposed:
https://lore.kernel.org/all/20240809073309.2134488-1-kees@kernel.org/
https://lore.kernel.org/all/20240809073309.2134488-5-kees@kernel.org/

But all of that is orthogonal to just _having_ the type info available.

-Kees

-- 
Kees Cook
