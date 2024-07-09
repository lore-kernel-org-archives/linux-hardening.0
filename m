Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2619B5B5;
	Tue,  9 Jul 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541398; cv=none; b=MZAZVnFeCE/GiT+K06zFwCpg5l2xw7wA7NluTcO1T5Ddqmv17DEMOFpANf2W/MBOZSTG3g2IJjHPr8CGo4xwDnkKF70cI0xBM3C6jNtnB6fpy0DIX78CTPC4RqKq0jwVtbJrVLhc5RuFwiL73IlMLXIqgK3EdT/LAndawWlb/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541398; c=relaxed/simple;
	bh=uC+UbPQo4xxV5hC4nWLzCH3ncmgP4biBjlcal1ceo/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgZo7r2BEDwPO6/8gls0G1DsSlrogewm/eN3Uh7HPJ6n1K09boX4oWTPBCgAlIrLRujEfs9jml+9mYSpkdVUKx7T+NrTZUPntmCY0PADiAo2/zCNPCasf/Cc3SktW+CFE9LQ/2bUmQSeMSJAvxJLNUa3ZuN4L0omZV5Jc80t3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCsife4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCsife4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8397AC3277B;
	Tue,  9 Jul 2024 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541397;
	bh=uC+UbPQo4xxV5hC4nWLzCH3ncmgP4biBjlcal1ceo/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCsife4/CYvHvy2wqd6hQxFWZyjy6RBNr4SO4ugKRQa+0lnJ31ZFm0c4m0pokrAdC
	 k02vWnFtUEeB0Q+mUDgXkfs9O34eri/mjlMVvSL0sku/633TTiXvqioMg5k/K68Efc
	 KQbWI7i5jW+mpHEdj/gjitHXpacV1Kc1FeyDhKBUwpXHGwR71U6EqNHacA+MjxpTjm
	 x63TS/Ii8olmk4ULslABkxJj5UJFcbkL5qgGmuwf9BrJQN3JIFdUbWPuG3okG7OA+4
	 +FmhUxW9CP7c+Fdhj99ECBNYq1+5c8u9oFm+W0qsu+tOg4NmrobJpUDKxCyr7KRBpJ
	 t3+dOUikwnAjQ==
Date: Tue, 9 Jul 2024 09:09:57 -0700
From: Kees Cook <kees@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Jann Horn <jannh@google.com>, Tony Luck <tony.luck@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Hao Luo <haoluo@google.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] slab: Detect negative size values and saturate
Message-ID: <202407090903.38C2F463@keescook>
References: <20240708190924.work.846-kees@kernel.org>
 <20240708191840.335463-2-kees@kernel.org>
 <fc080824-37ff-4b69-ad4a-e76b458218d6@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc080824-37ff-4b69-ad4a-e76b458218d6@intel.com>

On Tue, Jul 09, 2024 at 08:57:55AM +0200, Przemek Kitszel wrote:
> On 7/8/24 21:18, Kees Cook wrote:
> > The allocator will already reject giant sizes seen from negative size
> > arguments, so this commit mainly services as an example for initial
> > type-based filtering. The size argument is checked for negative values
> > in signed arguments, saturating any if found instead of passing them on.
> > 
> > For example, now the size is checked:
> > 
> > Before:
> > 				/* %rdi unchecked */
> >   1eb:   be c0 0c 00 00          mov    $0xcc0,%esi
> >   1f0:   e8 00 00 00 00          call   1f5 <do_SLAB_NEGATIVE+0x15>
> >                          1f1: R_X86_64_PLT32 __kmalloc_noprof-0x4
> > 
> > After:
> >   6d0:   48 63 c7                movslq %edi,%rax
> >   6d3:   85 ff                   test   %edi,%edi
> >   6d5:   be c0 0c 00 00          mov    $0xcc0,%esi
> >   6da:   48 c7 c2 ff ff ff ff    mov    $0xffffffffffffffff,%rdx
> >   6e1:   48 0f 49 d0             cmovns %rax,%rdx
> >   6e5:   48 89 d7                mov    %rdx,%rdi
> >   6e8:   e8 00 00 00 00          call   6ed <do_SLAB_NEGATIVE+0x1d>
> >                          6e9: R_X86_64_PLT32     __kmalloc_noprof-0x4
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: linux-mm@kvack.org
> > ---
> >   include/linux/slab.h | 19 ++++++++++++++++++-
> >   1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index d99afce36098..7353756cbec6 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -684,7 +684,24 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
> >   	}
> >   	return __kmalloc_noprof(size, flags);
> >   }
> > -#define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
> > +#define kmalloc_sized(...)			alloc_hooks(kmalloc_noprof(__VA_ARGS__))
> > +
> > +#define __size_force_positive(x)				\
> > +	({							\
> > +		typeof(__force_integral_expr(x)) __forced_val =	\
> > +			__force_integral_expr(x);		\
> > +		__forced_val < 0 ? SIZE_MAX : __forced_val;	\
> > +	})
> > +
> > +#define kmalloc(p, gfp)		_Generic((p),    \
> > +	unsigned char:  kmalloc_sized(__force_integral_expr(p), gfp), \
> > +	unsigned short: kmalloc_sized(__force_integral_expr(p), gfp), \
> > +	unsigned int:   kmalloc_sized(__force_integral_expr(p), gfp), \
> > +	unsigned long:  kmalloc_sized(__force_integral_expr(p), gfp), \
> > +	signed char:    kmalloc_sized(__size_force_positive(p), gfp), \
> > +	signed short:   kmalloc_sized(__size_force_positive(p), gfp), \
> > +	signed int:     kmalloc_sized(__size_force_positive(p), gfp), \
> > +	signed long:    kmalloc_sized(__size_force_positive(p), gfp))
> 
> I like this idea and series very much, thank you!

Thanks!

> What about bool?
> What about long long?

Ah yes, I will add these. LKP also found a weird one (a bitfield!) that
I'm fixing at the source:
https://lore.kernel.org/lkml/20240709154953.work.953-kees@kernel.org/

-- 
Kees Cook
