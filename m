Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A571C687
	for <linux-hardening@vger.kernel.org>; Fri, 31 May 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174216; cv=none; b=JDwgGLxvt0YnB1DjIlHKVej8/kwu89qAUMmi55ijwD/KXTiqhAkfVhGuIH2fGYhWmFGvi98XTpTROYU1q7XemYq6UXM627Ydn+VCCPfaBW6i1/dWFwycAmbyjh6gCnJXDAUBxpRkj3COzITn8S2bocEiN78rHs1Q90iuSsU7J9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174216; c=relaxed/simple;
	bh=6KcPpMIaVhrfLLpYPvkz29y7PLFD1EMfiqlDmt1B7hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWgn6PP6y7TTrZoCn+buQNfbqUTdkg1Vo1Vg5dtX/3bKAW2gwVa3I2Rqxi3uYlpAEjxVY8W/rjPMvHOkQ10zda3xNdbUIArkwWf0inL8s/7uMzrjJI1y3lyLigpW5m5dzGorXT0XEYdpU6O7Wutwogcz5HIjJ4YqUsdgAZezyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bcv4uZSf; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bcv4uZSf"
X-Envelope-To: kees@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717174213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VEEopXa/6axR2qlwT+N+gjyPs9hJMbVFhL2Ri7Y7Wg4=;
	b=Bcv4uZSfIXwv++7KSEEVLfdODz8CsX7iI+ORptEsJ6KIZ7aQzRHKRGsAkmGcH0q/T5GAFI
	GFb3ZFZp4vgQsbTlTiSIxol1fLl9iGS/oo7fgJo4VRmS74TN8TVvbMOU/TK9/zEAxLZ4wf
	Ni5rG8WTUCon886TDWtyjxTtC62/JqY=
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: cl@linux.com
X-Envelope-To: penberg@kernel.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-hardening@vger.kernel.org
X-Envelope-To: gongruiqi@huaweicloud.com
X-Envelope-To: xiujianfeng@huawei.com
X-Envelope-To: surenb@google.com
X-Envelope-To: jannh@google.com
X-Envelope-To: matteorizzo@google.com
X-Envelope-To: tgraf@suug.ch
X-Envelope-To: herbert@gondor.apana.org.au
X-Envelope-To: julien.voisin@dustri.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 12:50:08 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Suren Baghdasaryan <surenb@google.com>, 
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>, 
	Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>, 
	julien.voisin@dustri.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mm/slab: Plumb kmem_buckets into
 __do_kmalloc_node()
Message-ID: <5boulybop2fxtkht7n65r6ktdr5aiedts5xnuadmyr6wvaectx@sbcdzqoljpeh>
References: <20240424213019.make.366-kees@kernel.org>
 <20240424214104.3248214-2-keescook@chromium.org>
 <zxc3fpd552hnd4jumot2k3bnol3pe2ooybz2rts4qrcxpgn7ll@4aggaem6acjw>
 <202405310943.D9818A4FE@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405310943.D9818A4FE@keescook>
X-Migadu-Flow: FLOW_OUT

On Fri, May 31, 2024 at 09:48:49AM -0700, Kees Cook wrote:
> On Fri, May 24, 2024 at 11:01:40AM -0400, Kent Overstreet wrote:
> > On Wed, Apr 24, 2024 at 02:40:59PM -0700, Kees Cook wrote:
> > > To be able to choose which buckets to allocate from, make the buckets
> > > available to the lower level kmalloc interfaces by adding them as the
> > > first argument. Where the bucket is not available, pass NULL, which means
> > > "use the default system kmalloc bucket set" (the prior existing behavior),
> > > as implemented in kmalloc_slab().
> > 
> > I thought the plan was to use codetags for this? That would obviate the
> > need for all this plumbing.
> > 
> > Add fields to the alloc tag for:
> >  - allocation size (or 0 if it's not a compile time constant)
> >  - union of kmem_cache, kmem_buckets, depending on whether the
> >    allocation size is constant or not
> 
> I want to provide "simple" (low-hanging fruit) coverage that can live
> separately from the codetags-based coverage. The memory overhead for
> this patch series is negligible, but I suspect the codetags expansion,
> while not giant, will be more than some deployments will want. I want
> to avoid an all-or-nothing solution -- which is why I had intended this
> to be available "by default".

You don't need to include the full codetag + alloc tag counters - with
the appropriate #ifdefs the overhead will be negligable.
