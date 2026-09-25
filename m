Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8626FA60;
	Fri, 25 Sep 2026 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790298042; cv=none; b=cwaphaWSYLaXeYWRETtqc3v7LyIpo7BhuMJcWLOsu2LwhLwWxS/wmbVB3JjXOFsUBBp2sYudgEP2lYCyrH5j0NtTEfqEtahqWEohmynJ4/dTLaUm0rsfyQIkOhree0Ra0RcGgDHFCewW+1IEFTgpI8aSq68dyzNlCP0xtY9ZfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790298042; c=relaxed/simple;
	bh=n2M63cCDwEgRsvfj0eKZ5Gek1qU2HHR0yQ5PqQ9u3mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7aFfOw8W4krg6/vimSdWfwzMO8hV89GF8hrc0pReawJXNJlRO+O5QmOzZeK7u9LjoEgHInkI1O+E75CxpGV8R+JrKKO6PoTfxjKKQ43eMDGowwO7EpDapqk7N1aktTo5ztBZ5hXCvC7qqplXIr1DigUZNKaoF76Mj9BtBLIksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAnXNKC6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAnXNKC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4461F00893;
	Fri, 25 Sep 2026 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790298040;
	bh=zGt/QJuXYmz1FRSRmOhHZebQauxVGaioH05IWjWbi8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XAnXNKC6Zq14Zt9SIfzI3L/LSHhEAIyJeHjMuS1eXzEsLIzj8XfD7kokWyb1Lmcb6
	 3AWiUliSPoDFnB0+Ua835jlZLlOKe25jr/hdD6kjvn0KrmvRmbTFjndr7vCr25B9ru
	 n0QUHaMAYbygcI0Gzk8d36sT0tQtZSLIWfQbYKW2LNjMRV24rR5m+FtW4DeHqxH9ur
	 b1KXStABsK2Jd94K2FSpZGdf+6JtIYjxEll9DE369uKn70zH9xmF0VmuWdE65t/6Va
	 BDqwwU9TwG8JflV1zb+zOe5ef9gORRPElIM38D+9zZo84DKypA5Q7eD8pgdPujiTuH
	 KXKExAE2P2f0A==
Date: Thu, 24 Sep 2026 18:00:40 -0700
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
Message-ID: <202609241759.28EC6970@keescook>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-2-kees@kernel.org>
 <arEdcaJz4i5HP26a@thinkstation>
 <202609211620.342AAA61@keescook>
 <arViR2Miz61-3fV4@thinkstation>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arViR2Miz61-3fV4@thinkstation>

On Thu, Sep 24, 2026 at 07:22:58PM +0100, Harry Yoo wrote:
> On Mon, Sep 21, 2026 at 04:25:25PM -0700, Kees Cook wrote:
> > On Mon, Sep 21, 2026 at 02:17:21PM +0100, Harry Yoo wrote:
> > > On Mon, Sep 21, 2026 at 12:58:13AM -0700, Kees Cook wrote:
> > > >  			if (WARN_ON(!cache_name))
> > > >  				goto fail;
> > > >  			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
> > > > -					0, flags, cache_useroffset,
> > > > +					kmalloc_caches[KMALLOC_NORMAL][idx]->align,
> > > > +					flags, cache_useroffset,
> > > >  					cache_usersize, ctor);
> > > >  			kfree(cache_name);
> > > >  			if (WARN_ON(!(*b)[aligned_idx]))
> > 
> > It looks "obviously correct", but I probably failed to correctly
> > describe it. I'm happy to do whatever here.
> 
> That is correct, but is there any reason why kmem_buckets users should
> not specify their own alignment requirement and inherit the alignment
> from kmalloc?
> 
> For DMA yeah it might be confusing for every user to figure out that
> the alignment should be __kmalloc_minalign(), but otherwise there isn't
> really a good enough reason to inherit the alignment from kmalloc, no?

Oh, so you mean explicitly add an alignment arg to kmem_buckets_create()?
And perhaps if _that_ one is "0" we can fallback to whatever
kmalloc_caches uses?

-- 
Kees Cook
