Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1714825DC;
	Mon, 21 Sep 2026 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033135; cv=none; b=d3ollZ3chK59CecgtUbB3y2rfKZ8bPC5FToklaCrQSoutfVV+5U0kpU3q+5yBdT/oeuKbW2gra6eD+S/2MfOXGgHdJU3IQ85vk9PPFLMgL7MoCHBYyGWeWuaxizuNefagTb4IIseeUjgs5koXYzRNCo3UktfoPh5bJ7kKue9ids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033135; c=relaxed/simple;
	bh=MJ2Hp/KWZc5i0XyNPx+/X7OdyoIGYk7ogHruNQqEYpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2ONTJombjck2G/6C9rngu+Y3Vk/ovXbYtToDQxGGDBT/PRarA/6IVHQZWDehSU9CnuTWyOIep8Z6n0bWlwxvAcDprb5sFppb3dHM5iOvhzJVKfJFow5G3/+xBa4BLl1TuB7dw/nA4HES4a9byO+VdJm1Gpia24xvWyYVvugyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azIn/d0w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azIn/d0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CC31F00893;
	Mon, 21 Sep 2026 23:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033126;
	bh=oaGIE4gQUBGH4tcAm0OKjGErwoNdUaA0Sne6xnAyux0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=azIn/d0wCBW/n5NuSAAvioZRTS6hsz/Zzmk86xwjKslNuC+NfEG2OnH1ZfzQ3TRz/
	 3cro52SIhBBCt2l3ERGmS9tyrTutoW2wkR/hIcoE8WXd0jAVCrFmXdAtIROZ+AIl+L
	 mZunPKrWZ9NH7wotaotbcWy1jLlQG8AY+mu2J+ZtfZlmW8ci62EJWLiLIbYeUpfJG9
	 Xn7R+a8VNffucyoETZHR1hjCQqsc31YOS1uipcHkLK6NSFO+mKrQNeu0qUGVDrEYTT
	 nN48t9N17wjW6roUjjostFNHgjYqWZkqJbefoyyzfHGd3NkjlW7+HtwXrktWeN6lhZ
	 jp1Vo/FxK1B0Q==
Date: Mon, 21 Sep 2026 16:25:25 -0700
From: Kees Cook <kees@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	Pedro Falcato <pfalcato@suse.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-hardening@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/7] mm/slab: Give bucket caches the alignment of the
 caches they mirror
Message-ID: <202609211620.342AAA61@keescook>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-2-kees@kernel.org>
 <arEdcaJz4i5HP26a@thinkstation>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arEdcaJz4i5HP26a@thinkstation>

On Mon, Sep 21, 2026 at 02:17:21PM +0100, Harry Yoo wrote:
> On Mon, Sep 21, 2026 at 12:58:13AM -0700, Kees Cook wrote:
> > A bucket set is created with kmem_cache_create_usercopy(..., align = 0),
> > so calculate_alignment() falls back to arch_slab_minalign(), typically 8
> > bytes. The general kmalloc caches it stands in for are created through
> > create_boot_cache(), which starts from ARCH_KMALLOC_MINALIGN and raises
> > it to the largest power-of-two divisor of the size:
> > 
> > 	if (flags & SLAB_KMALLOC)
> > 		align = max(align, 1U << (ffs(size) - 1));
> > 
> > This is only a problem when slab metadata is enabled with
> > CONFIG_KASAN=y, CONFIG_SLUB_DEBUG_ON=y, or "slab_debug=...", because
> > metadata changes the stride size off a power of two, for example:
> >
> > 	size 128:  bucket align=8 size=224  | kmalloc align=128  size=384
> > 	size 512:  bucket align=8 size=608  | kmalloc align=512  size=1536
> > 	size 2048: bucket align=8 size=2144 | kmalloc align=2048 size=6144
> 
> Hmm... I think what adds confusion here is that in new_kmalloc_cache()
> we adjust the size based on alignment, but in create_boot_cache() we
> don't do that. Perhaps let's make it consistent and move it to
> new_kmalloc_cache()?

Yeah, I really couldn't figure out what was "correct" here.

> > So bucket allocations will fail the IS_ALIGNED(p, ARCH_DMA_MINALIGN)
> > check, potentially creating problems for non-coherent DMA situation.
> 
> I was wondering "Why should they respect kmalloc alignment..." but yeah,
> It makes sense if the users were using kmalloc and depended on its
> alignment.

Right, it was a "visible" change between standard kmalloc and bucketed
kmalloc, so I figured the right action was to be (bug?) identical.

> Well, but that's already done in new_kmalloc_cache() and
> kmem_buckets_create() should already honor ARCH_KMALLOC_MINALIGN? 
> 
> The largest-power-of-two-divisor-alignment guarantee was introduced by
> commit ad59baa31695 ("slab, rust: extend kmalloc() alignment guarantees
> to remove Rust padding")
> 
> ...which makes me wonder what you're trying to fix here?

What Sashiko noticed was that alignment might not match under certain
configs, and then I verified it at runtime, and figured I'd best fix it
just on the basis that it was a difference from what a user might expect,
and it might be especially important for skb data.

> >  			if (WARN_ON(!cache_name))
> >  				goto fail;
> >  			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
> > -					0, flags, cache_useroffset,
> > +					kmalloc_caches[KMALLOC_NORMAL][idx]->align,
> > +					flags, cache_useroffset,
> >  					cache_usersize, ctor);
> >  			kfree(cache_name);
> >  			if (WARN_ON(!(*b)[aligned_idx]))

It looks "obviously correct", but I probably failed to correctly
describe it. I'm happy to do whatever here.

-- 
Kees Cook
