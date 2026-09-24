Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CD4AA1FB;
	Thu, 24 Sep 2026 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274182; cv=none; b=fSvBU0RzfjDo8fzcyBBNo2aAtedXTJjOvg5kgrmcD5FIj0iAWTsiIxvc3YoRW1R8dUdfCI0s50EFnnIqGjP8Opa8Uwo41RzEY4v2Gw+MLrtEUlhhVVfDwW7AFV/TEInONdjV0MWjXLjS8gzk+LPH/FHuN/spTdn5O/wXJ6BOwFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274182; c=relaxed/simple;
	bh=OArbBLjldqjbVbBbdrPdm56RE7f3E8ZEnAwgNph3ut0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+uwA/uj1JC/j9KYLPheNld2NB+J/87ZG33/2lITwvWXTtD4ZK5uRs8I/FjSDQKMOl6VaE6DQODlYWhqfWpIkgabDWNhsXZ9xD8VyWgw7afeH/8LcOEpNaoq97FA8VPMgi/+rzLtQ8Mya7LuzHMd18ppDBnNrXdtYzUzZyBdo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agYftme9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agYftme9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8C91F000FF;
	Thu, 24 Sep 2026 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790274181;
	bh=jgeLELIzxZ0bp9TzTWk/96zvxSQJOk3kCuECklcXCng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=agYftme9qt93yk8XsoRWixRsLH9tG3aSJYeZ+s+rtAbGS93SnBVQHs1p/SOilNZtz
	 /OJtgxFJVIVFnkpVJSM/cgfX14JqpoHlLIHbw7wogTDO/lxAw8z/o9aSPceiCGJfK6
	 zzpXQ2zNZpP9MQRpkH9MwTu/WZWp10hAc4+Z9fm2sJZ+WDMhSmrtQB9oP1igactp2g
	 9ufQrGFU0LGoCAMhXsUQDxCscdgnzm3xe6BU9j/vDHMoqhLTASqbzVFxRT8XZSHnYp
	 Q+LTAwAJ8piVQ/9jRf85wd04XJuT+v1QzJvmQ7/0jZTifuUwIgF3Z3NCm6T/3DkUEM
	 U7qZteZ0mIeBw==
Date: Thu, 24 Sep 2026 19:22:58 +0100
From: Harry Yoo <harry@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Pedro Falcato <pfalcato@suse.de>, Kuniyuki Iwashima <kuniyu@google.com>, 
	linux-hardening@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/7] mm/slab: Give bucket caches the alignment of the
 caches they mirror
Message-ID: <arViR2Miz61-3fV4@thinkstation>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-2-kees@kernel.org>
 <arEdcaJz4i5HP26a@thinkstation>
 <202609211620.342AAA61@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202609211620.342AAA61@keescook>

On Mon, Sep 21, 2026 at 04:25:25PM -0700, Kees Cook wrote:
> On Mon, Sep 21, 2026 at 02:17:21PM +0100, Harry Yoo wrote:
> > On Mon, Sep 21, 2026 at 12:58:13AM -0700, Kees Cook wrote:
> > >  			if (WARN_ON(!cache_name))
> > >  				goto fail;
> > >  			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
> > > -					0, flags, cache_useroffset,
> > > +					kmalloc_caches[KMALLOC_NORMAL][idx]->align,
> > > +					flags, cache_useroffset,
> > >  					cache_usersize, ctor);
> > >  			kfree(cache_name);
> > >  			if (WARN_ON(!(*b)[aligned_idx]))
> 
> It looks "obviously correct", but I probably failed to correctly
> describe it. I'm happy to do whatever here.

That is correct, but is there any reason why kmem_buckets users should
not specify their own alignment requirement and inherit the alignment
from kmalloc?

For DMA yeah it might be confusing for every user to figure out that
the alignment should be __kmalloc_minalign(), but otherwise there isn't
really a good enough reason to inherit the alignment from kmalloc, no?

-- 
Cheers,
Harry / Hyeonggon
