Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48A47ECF0;
	Mon, 21 Sep 2026 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992202; cv=none; b=SulFKrLxJg0lVowujIWE9k/IUnW3duKCPz+9ttHGnkOuGQQEFcjFp1QorRzgJpsNOBSDfKoCEFMnvb3jn2QmLvtS15D7kjTLsHHcJrqqFjUjGqRMwymZ8DJb0WWIjs/dw5vSznziNCUB2m/X5/Mf/orV5k2eyHuiFi7NyTutzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992202; c=relaxed/simple;
	bh=H0So/+MkpCec0oFknu4pOjgH63d0n2koBSaZ1LNmxUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slCuhXwTc6lk6/RmRossdLsfWdIpU7dLaXqJLpy/iMiPqhHQpZepqbng8gxCBZ7vl6+fZBIq55uTdNtvV9LjV9EzV7m/HB8iuHTUixIAn0mVVi07DZi72TzV9uAe0KqM3DM2CTul1Lig3etNI2sxfDpnOnDWmeWtBy5vW63znzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg+fJKlx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg+fJKlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D732B1F000FF;
	Mon, 21 Sep 2026 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789992201;
	bh=ZSkmJtXL7WUnfY0TRuru1PuhPDtpUorFFaCq4i0ogiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gg+fJKlxBLTrl/SOVvdc/MFTvGp7WFSDmdkHklDMOKY5Ds45e6mpUkt0UR56r8bai
	 6tK8pPdYdyO7yTw2WypRtgizXItRBHvX8S5H/4PUCmfrL+w2kwhNnrsUrbCWNnm2JX
	 AO1ayb2mZTCxhcXx366fnkk3wGSjoLTwD7GEd2/gOmFFkm6Vz0MQuu4D7LKHkYzscE
	 ZZPoylgQzGxEBBG/05saCGEQ9j+vr3u6gfdBfbna/4cXG5pPqEPmtQB0hPuAFVrVDb
	 grxsWteKBuVUYGn9WYJTsHiS38ExMjy6pj//h3C89EHqSjWHfoKBxCDTcyQMxqsFcg
	 mcT8HuHdMzjDQ==
Date: Mon, 21 Sep 2026 13:03:19 +0100
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
Subject: Re: [PATCH v4 1/7] mm/slab: Mark the kmem_buckets_create() context
 as a Context: section
Message-ID: <arEcRFw3mQ6frlDq@thinkstation>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921075820.1718334-1-kees@kernel.org>

On Mon, Sep 21, 2026 at 12:58:12AM -0700, Kees Cook wrote:
> kmem_buckets_create() had the same sentence about calling context as
> kmem_cache_create(), but lacked the "Context:" prefix, so kernel-doc
> rendered in the body instead of as a "context" section.
> 
> Give it the missing prefix. Additionally fix the "a interrupt" typo
> __kmem_cache_create_args() had.
> 
> Fixes: b32801d1255be ("mm/slab: Introduce kmem_buckets_create() and family")
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
