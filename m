Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AE3BD246;
	Fri,  2 Oct 2026 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790981977; cv=none; b=hJnUdV36lVNB8N7XSznnCxWqo+k6x5J3EQ1r3mKPUxiYwtXwycjHA4JKtrwySJ4WVKTg3uUMsgH9ugQ3pCVt6l3HOfGqOOY9DVbZGc4vzolLMy5wwteEoYyzd2wrgQUKcLlyH9Cc+L23gqmqZfkDvJEHNAXd6HQuxLttovCnu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790981977; c=relaxed/simple;
	bh=bE7Zl9IWk+uckl2YZcLFCtuyK3VF7pTM6/ugeaNjLv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnxRQDhvldRkOuEZ0z8dCCl2ItvjJsyb3LQSFxRLeX8KlvadJD7wVORwNfpy8ZtAm9/QihYzH6leQTDVKuatu6BYLKuCY2UmVU44kOcOb0mTp4GS1V9C9P8gDJDjlz0KGcVX3V71heer1YHu5ssLZeo0WVrd11E0yvTykA/V2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNfHSg1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNfHSg1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662DD1F000FF;
	Fri,  2 Oct 2026 22:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790981975;
	bh=JJBZoitWEBQrTY8FcV1qjmfA5wNk/u7NZng6rYh3IJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HNfHSg1Uf8VJletd/R2fu339SQf15SzodVIk+PgQjnibCGWW0FKaGqCJtTB9CsNHH
	 6ZUjgPXjwhCfn0EGwOSXZnhmp45GPc+8mBA4KIzr/toF9NifDgEMbBmB4wpIm6Wuoy
	 PGDxN8NS97pBFrWQT9d7hKP5mkCXJblmyL+hkEVaPn1KH1+pekc/czSzjfNxTn5i4w
	 2Iq0tz+X5nmVOxpuWhDIPmemZAOT9ihSSeBT885X0ojH1LJGqvnzh7JC6JlgbypVQl
	 HfjwRzYoVzwUGjpamhY/kQ/PSG3PTNTaVZ5goiedFc9jkBzMgkMLorUjrNGTzbdTns
	 xrxKXyue6TwAw==
Date: Fri, 2 Oct 2026 15:59:35 -0700
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-hardening@vger.kernel.org, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 7/7] net: skb: isolate skb data area allocations into
 a separate bucket
Message-ID: <202610021554.58F5CBB8@keescook>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-7-kees@kernel.org>
 <8862b9ed-6f96-48c6-a134-6e8635c38987@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8862b9ed-6f96-48c6-a134-6e8635c38987@redhat.com>

On Sun, Sep 27, 2026 at 10:24:16AM +0200, Paolo Abeni wrote:
> On 9/21/26 09:58, Kees Cook wrote:
> > From: Pedro Falcato <pfalcato@suse.de>
> > 
> > SKB data area allocations (as done from alloc_skb()) use kmalloc().
> > These allocations can be variably sized and their contents can be more
> > or less controlled from userspace, which makes them useful for attackers
> > that want to overwrite a use-after-free'd object from the same kmalloc slab
> > (which often just requires the sizes to roughly match into the same kmalloc
> > bucket). [0] is an easy example of an exploit that uses netlink skb
> > allocation to target another similarly-sized accidentally freed object.
> > 
> > While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, these are
> > probabilistic. Use the existing kmem buckets API to further isolate these
> > allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=y.
> > 
> > Ask for the accounted kmalloc type as well as the normal one. AF_UNIX
> > sets sk_allocation to GFP_KERNEL_ACCOUNT, so without it every AF_UNIX
> > skb data area would fall back to the general caches, and those are the
> > ones most worth isolating. GFP_DMA is left to fall back, being passed to
> > an skb allocator only by rare devices.
> > 
> > Link: https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> I would be curious to learn how about the memory usage delta.
> However I see buckets are protected by their own kconfig, small
> systems can unselect them.

Correct. But here's the delta for a 1 node NUMA with memcg, which is
dominated by sysfs. 26 caches (13 normal and 13 memcg):

  sysfs, 26 caches                                          113,152
  struct kmem_cache, 26                                       6,656
  kmem_cache_node, 26                                         1,664
  node_barn, 26                                               1,664
  names, 26                                                   1,248
  the set itself, 2 rows × 14 pointers in kmalloc_buckets       224
  per-CPU sheaf structs                                 CPUSx x 832

> For the networking bits:
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Thanks!

-- 
Kees Cook
