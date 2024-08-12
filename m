Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98316EB7A;
	Mon, 12 Aug 2024 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486921; cv=none; b=IjPjk1ZfCNx9S5FzPI0fY96G7jXs1jq/n3RTuvZTiRc/fTnn4VRcsnUzdUbACPvFWjItDjuxFydoiLoGJiYP4O1xAoQS6RU+K9gMN6yqOGv625XMwrAc9ww8Sm+D0JGA5W7VCAxlUwdjm/AWIq4CAIsr+a2duKxUh8Yub1CMZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486921; c=relaxed/simple;
	bh=ws3lgZqtdR8fdkI1wDuo6WPxpiZC7n8mPZcO8DUfngc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6HLpEwqIjeeQPGb9AKZgqYFvdJZv/DMQlScejxPO/gVUXZebngcBIO8GXHQ3L095T1w4RdeYx4xg8egi2GXnd9uPol+KwgXklVLWSIm6QPE8d68tKvRbVYAnMIf1ZGXCVkElD1HtMqvHe4YjG+AY1oOiIIqd+qCUl5/Zzxesq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBwr2DWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBwr2DWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF840C32782;
	Mon, 12 Aug 2024 18:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723486920;
	bh=ws3lgZqtdR8fdkI1wDuo6WPxpiZC7n8mPZcO8DUfngc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBwr2DWtldK2qiuYyAMPXwj2lruEt4qkTNXNxYEaPxOC8WeH6WaUS8SKea60G/1qA
	 ugiqvIaGs59MbYKxNCszLu1mqEWfMbpG284xEa2+XVWJ3NhcEPCB+BdUiQ0I1EXmZU
	 sKwTbZthZgJqXWABdNbJFDgxL/LpKmcurPrYpMq/l0AaxTq38E/kJURnxf8oGAOVHW
	 lPdnST8bcyB8w2lFDbnU3XG3kHk7kaJBYSwlnRfUqL5ZBARxOxdA0afikNgMbdYrTi
	 5CD7UT6AhXylgK49dyzG2m7bqsmdHNy4TxzhLyT56WWLASHeeF52pto9/owdtqyQwx
	 OQLLC6DGcTPQw==
Date: Mon, 12 Aug 2024 11:22:00 -0700
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
	Marco Elver <elver@google.com>, linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] slab: Introduce kmalloc_obj() and family
Message-ID: <202408121113.D638922E4@keescook>
References: <20240807235433.work.317-kees@kernel.org>
 <ddf093db-b0a8-4e44-9d81-1e4840967557@suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddf093db-b0a8-4e44-9d81-1e4840967557@suse.cz>

On Fri, Aug 09, 2024 at 10:59:52AM +0200, Vlastimil Babka wrote:
> On 8/8/24 01:54, Kees Cook wrote:
> > Introduce type-aware kmalloc-family helpers to replace the common
> > idioms for single, array, and flexible object allocations:
> > 
> > 	ptr = kmalloc(sizeof(*ptr), gfp);
> > 	ptr = kcalloc(count, sizeof(*ptr), gfp);
> > 	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
> > 	ptr = kcalloc(count, sizeof(*ptr), gfp);
> > 	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);
> > 
> > These become, respectively:
> > 
> > 	kmalloc_obj(p, gfp);
> > 	kzalloc_obj(p, count, gfp);
> > 	kmalloc_obj(p, count, gfp);
> > 	kzalloc_obj(p, count, gfp);
> > 	kmalloc_obj(p, flex_member, count, gfp);
> 
> So I'm not a huge fan in hiding the assignment, but I understand there's
> value in having guaranteed the target of the assignment is really the same
> thing as the one used for sizeof() etc.
> 
> But returning size seems awkward, it would be IMHO less confusing if it
> still returned the object pointer, that could be then also assigned
> elsewhere if needed, tested for NULL and ZERO_SIZE_PTR (now it's both 0?).

Ah, I made this changed based on requests in earlier threads. But yes,
the ambiguity with ZERO_SIZE_PTR does make me uncomfortable too. I think
I can make the size an optional argument when splitting the functions as
you request below...

> I'm also not sure that having it all called kmalloc_obj() with 3 variants of
> how many parameters it takes is such a win? e.g. kmalloc_obj(),
> kcalloc_obj() and kcalloc_obj_flex() would be more obvious?

I liked it because it's always doing the same thing: allocating a
structure. But yes, I do see that it's a bit weird. Since "kcalloc" means
"zero it also", how about the naming just uses pluralization instead?

	kmalloc_obj(p, gfp);
	kmalloc_objs(p, count, gfp);
	kmalloc_flex(p, flex_member, count, gfp);

Does that looks okay?

> > These each return the size of the allocation, so that other common
> > idioms can be converted easily as well. For example:
> > 
> > 	info->size = struct_size(ptr, flex_member, count);
> > 	ptr = kmalloc(info->size, gfp);
> > 
> > becomes:
> > 
> > 	info->size = kmalloc_obj(ptr, flex_member, count, gfp);
> 
> How about instead taking an &info->size parameter that assigns size to it,
> so the ptr can be still returned but we also can record the size?

If we wanted size output, we could add an optional final argument:

	kmalloc_obj(p, gfp, &size);
	kmalloc_objs(p, count, gfp, &size);
	kmalloc_flex(p, flex_member, count, gfp, &size);

And as far as solving the concern of "hiding the assignment", what about
trying to "show" that "p" is being assigned by requiring that it also
use "&"? For example:

	kmalloc_obj(&p, gfp);
	kmalloc_objs(&p, count, gfp);
	kmalloc_flex(&p, flex_member, count, gfp);

> Also the last time David asked for documentation, you say you would try, but
> there's nothing new here? Dunno if the kerneldocs are feasible but there's
> at least Documentation/core-api/memory-allocation.rst ...

Whoops, yes. I totally missed adding those. I will add that once I have
some direction on the above design ideas.

Thanks for looking at this!

-Kees

-- 
Kees Cook
