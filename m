Received: from mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9ED391845
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325542; cv=none; b=aKLjOEm94sYyPVe8HSUke0Xa27HA7ebxZqd0dub21fizEo1Myq4mxP7uTHSUI3SEJCsQDmnCvYb/GR772jUhOOGTutPJNotugrhbu+Y1Esn+A9Zlh2a/yBNoL1Ob+VS23os6dodolsp6EeD3vcqQ+PqjdFqj4NqYSXX19ReeYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325542; c=relaxed/simple;
	bh=T10y4ASlATCQTgkrEor1JdynVWZNOpt5kzchNql5gDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tamC/hsv//SPXz1jVntSlbYOWkPt8rzogLChJqOv4Z0okeCv5EwujMHmvwHXTaERBE5pFg7WtcnTqHGELN4EsH+v+BW45GyacSP6/99K0yC+kdmA9fuygFzHLE4MQi37DFUKa/G5EnPEb1UDp1oweYUi24cBAwBOkXtGL7F16Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E7ciUoFx; arc=none smtp.client-ip=95.215.58.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E7ciUoFx"
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T10y4ASlATCQTgkrEor1JdynVWZNOpt5kzchNql5gDE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790325537; v=1; x=1790930337;
 b=E7ciUoFxZ/QNFnfQa+NUjtVPPFFXIgb5+pbf0txtkTTjAFFitlvJhh7yJfxVM+aevIkR0P4p
 Toif0YauK6OJZKb7jPqqdQ/5bELzxGLVPPu7DtKguTta3+OnNTLZwSCkKFjTeVb872afnsuakMh
 ju5C69Ov22ckcRdwpxfgS7ig=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 399a8e667ef4d0d5;
	Fri, 25 Sep 2026 08:38:56 +0000
X-Mizu-Trace-ID: 399a8e667ef4d0d5
X-Migadu-Flow: FLOW_OUT
Date: Fri, 25 Sep 2026 16:38:45 +0800
From: Hao Li <hao.li@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
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
Message-ID: <arYy9z0_ehaVd7Iu@fedora>
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

Reviewed-by: Hao Li <hao.li@linux.dev>
