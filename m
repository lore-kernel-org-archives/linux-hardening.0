Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196674477E7;
	Fri,  2 Oct 2026 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980027; cv=none; b=fza91s1AW5Ayo9uSKY4TsEC4WPpNgJo6fHsxbaD30AVcefLJjlmhJGDWzaRC8ISOuQrHYymVWTZ1OAwJqo9LQ10E7v+ox8psKoVObZV3ViXnIcjmhvYiCXJyS6ibMbMdNv+qNJsmFxJ/KEC0XkQ9p7CBnxa95tvKe7C1IbblxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980027; c=relaxed/simple;
	bh=rKUJ1Ht/OLxCT4JuW4/2eoRS1UlSZ4jSo532PpnCiZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUPH2+YmSysNSupsi/Oou9bR11XjBvuDU5l1CZ0nOsz9qKKwUtQYbzpeyyNW8GuKF8OdpuQsC6nhtf9TkQq7yae45ZVTumxcc9idoa3ZBlHu/6WBOciNZCPpQ5sYnEb66A0r+B3vYGrusKNUA+o85JMasmQ7Po3CkYR3gyy9Vrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewi4IOFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewi4IOFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2D61F000FF;
	Fri,  2 Oct 2026 22:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790980025;
	bh=XrFDa5YTwQsxjtBU29z2wtgxI1YYa8NMh9+Em7kIbVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ewi4IOFJxxoQ7Qg9VWdgyzC60dmnonJEslzal0W/O13I2WiUEd2OP/DezZ5E4pgi3
	 7l1+sZFtSsPGxggjrflW+1IAZvAkZi2jJSVGKUYoRJlwBgQhmlb3UUY6La6gXNmPHU
	 A3USpiyM1HyNfkNSLVznW0/MYCSV8gEg/Wf+/wBwuJwFAdTtC8Doqh9yVInGN1L6HI
	 yS+4DARPK6rUH+NdAOIAkSrrom0PFGPpqiaJgzToMJAYeTKaK+YR96RrIeVOSR9Y2E
	 6rvOSb6NFJ9v5Xk/Jn3g4y5f5nwYLV6XRmOJH0rwuteh6/RKU9XZcTPyFeB0Ptl+1J
	 ePgpKPyaWT8Pg==
Date: Fri, 2 Oct 2026 15:27:05 -0700
From: Kees Cook <kees@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
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
Subject: Re: [PATCH v4 5/7] mm/slab: Provide kmalloc type fallback for bucket
 allocations
Message-ID: <202610021520.5A076C2A0@keescook>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-5-kees@kernel.org>
 <arJSz0r5u_78NWKe@pedro-suse.tail5790ac.ts.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arJSz0r5u_78NWKe@pedro-suse.tail5790ac.ts.net>

On Tue, Sep 22, 2026 at 11:11:58AM +0100, Pedro Falcato wrote:
> Big thanks for continuing this effort :))

Thanks for starting it! :) I've had a few folks wanting it, so I'm happy
to help.

> On Mon, Sep 21, 2026 at 12:58:16AM -0700, Kees Cook wrote:
> [...]
> > +/*
> > + * The kmalloc types a bucket set can hold a copy of. This is deliberately not
> > + * enum kmalloc_cache_type: the KMALLOC_PARTITION copies are all "normal" to a
> > + * bucket set, which already separates what they were there to separate, so
> > + * indexing by those would mean up to KMALLOC_PARTITION_CACHES_NR unusable
> > + * rows per set. Allocations of any type not listed here are served by the
> > + * general caches.
> > + */
> 
> This sounds odd. Is there a good reason why KMALLOC_PARTITIONs are kmalloc_cache_types?
> Perhaps that bit should be reworked instead?

I'm not sure I follow. Do you mean the partition copies themselves
shouldn't be kmalloc_cache_types? That predates this series. For a
bucket set, they're all the same "normal" type, so a set indexed by
kmalloc_cache_type would carry rows it can never use: on x86_64 with
CONFIG_KMALLOC_PARTITION_CACHES=y, that's 20 rows (2240 bytes) per set
instead of 2 (224 bytes). I've put the numbers in the commit log for
v5.

> [...]
> > +	if (type <= KMALLOC_PARTITION_END)
> > +		btype = KMEM_BUCKET_NORMAL;
> > +	else
> > +		return &kmalloc_caches[type];	/* No set holds a row for it. */
> 
> Hitting this case sounds like a bug in the kernel. WARN_ON_ONCE()?

The next patch warns where a set could have held the row but wasn't
created with it (an accounted allocation without KMEM_BUCKET_CGROUP).
What's left here are types no set can hold, like DMA and reclaimable,
and those already come from caches of their own, so falling back
doesn't lose the separation.

> Otherwise LGTM.

Thanks!

-- 
Kees Cook
