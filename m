Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520CD189916;
	Sat, 15 Mar 2025 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064999; cv=none; b=HZh/k+3VzQIWac+fZ7WMxdoLWWpzWBPxEYsU39LeWQSYCJDtJWPSjDhvbZhgKrefXQDiE51OTzsB5zuBKzGsmTqB2oGL46KgwxTbI+ulcdFgmRrNdH/DH0jTqeQWqJYkND0Z3z0ZR48Fap/zES3Tq2ZZv+QlHawdpcwtccAfEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064999; c=relaxed/simple;
	bh=0cVJbATR2qhQxWDKABbizVxbgFKBOKXwQRb4x0P1LuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f76v7a98n5Hb7/xbgNAy5bQsBSRIARTbafg7uh1T3ErQytgvw6fpKLoGxeG4DRQZw7CZC2GHpL6zs0Ga0kDsrcavmB19KkRobzbE1CUxeW6U460J8cg1ziQOTyQtjRoBoKllrpPNYH6IbbCWlxeB+a2DICXYlVPB9VYJd5w+7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoLBfqcz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoLBfqcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EF5C4CEE5;
	Sat, 15 Mar 2025 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742064999;
	bh=0cVJbATR2qhQxWDKABbizVxbgFKBOKXwQRb4x0P1LuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoLBfqczX8GbTuzhShU9uH41LAx+3ilH+BtIiLpfqkhkV+o4lEIEH48I/aP9dfIfi
	 kYQfu6IwW0MmnimgscShZs7soXM8mXW4TJRflCP6t2B1MWIAW+5TBQ8ResuiuNjuiG
	 Caidl8s+1iUpCYFQv8EhUE8L1SZD5Q4p9s3r0jTfHlMQxNM+fqjOm+koEY7e4yrv6o
	 eTsfKbVs/zsDJcsL9C7gUA8+k7Rn6Ykl/lXfsJ20SyhshPXjkX1nD12n/YeXZ9tPEg
	 j4SxykaFoSE+iPgJh7SKenYmozEJwcYMHPKkrfA7OAq64DAo/Acaplpe4epTkykv4I
	 cFEv/78Fd5Hfg==
Date: Sat, 15 Mar 2025 11:56:35 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
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
Message-ID: <202503151141.786736B85B@keescook>
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-2-kees@kernel.org>
 <CAHk-=wiFjwOk9knz8i-zAqE=Kc73+3TgkMuj-C_mNB1U=k2W7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFjwOk9knz8i-zAqE=Kc73+3TgkMuj-C_mNB1U=k2W7A@mail.gmail.com>

On Sat, Mar 15, 2025 at 08:31:21AM -1000, Linus Torvalds wrote:
> Alternatively, this might be acceptable if the syntax makes mistakes
> much harder to do. So for example, if it wasn't just an assignment,
> but also declared the 'ptr' variable, maybe it would become much safer
> simply because it would make the compiler warn about mis-uses.

Yeah, this is the real goal (it just so happens that it's fewer
characters). We need some way to gain both compile-time and run-time
sanity checking while making the writing of allocations easier.

> Using visual cues (something that makes it look like it's not a
> regular function call) might also help. The traditional C way is
> obviously to use ALL_CAPS() names, which is how we visually show "this
> is a macro that doesn't necessarily work like the normal stuff". Some
> variation of that might help the fundamental issue with your
> horrendous thing.

Yeah, I really didn't like using &ptr, etc. It just make it weirder.

> My suggestion would be to look at some bigger pattern, maybe including
> that declaration. To take a real example matching that kind of
> pattern, we have
> 
>         struct mod_unload_taint *mod_taint;
>         ...
>         mod_taint = kmalloc(sizeof(*mod_taint), GFP_KERNEL);
> 
> and maybe those *two* lines could be combined into something saner like
> 
>         ALLOC(mod_taint, struct mod_unload_taint, GFP_KERNEL);

Yeah, this covers a fair bit, but there's still an absolute ton of
"allocating stuff tracked by pointers in another structure", like:

	foo->items = kmalloc_array(sizeof(*foo->items), count, GFP_KERNEL)

There's no declaration there. :(

One thing that I noticed at the tail end of building up the Coccinelle
script was the pattern of variable-less "return" allocations:

struct foo *something(...)
{
	...
	return kmalloc(sizeof(struct foo), GFP_KERNEL);
}

And that doesn't fit either my proposal nor the ALLOC() proposal very
well.

> We allow declarations in the middle of code these days because we
> needed it for the guarding macros, so this would be a new kind of
> interface that dos that.

Yeah, that does make part of it easier.

> And no, I'm not married to that disgusting "ALLOC()" thing. I'm
> throwing it out not as TheSOlution(tm), but as a "this interface
> absolutely needs clarity and must stand out syntactically both to
> humans and the compiler".

What about making the redundant information the type/var itself instead
of just the size info of the existing API? For example:

	ptr = kmalloc_obj(ptr, GFP_KERNEL);

as in, don't pass a size, but pass the variable (or type) that can be
examined for type, size, alignment, etc info, but still require that the
assignment happen externally? In other words, at the end of the proposed
macro, instead of:

	(P) = __obj_ptr;

it just does:

	__obj_ptr;

so that the macro usage can't "drift" towards being used without an
assignment? And this would work for the "return" case as well:

	return kmalloc_objs(struct foo, count, GFP_KERNEL);

That would be a much smaller shift in the "usage" of the exist API.

Shall I refactor this proposal for that?

-- 
Kees Cook
