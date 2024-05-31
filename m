Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CFA176242
	for <linux-hardening@vger.kernel.org>; Fri, 31 May 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174302; cv=none; b=oIWzTcCZzEXc+4SUtiDCIdKa5ewIV8nOTXWz8v9KF2I72JlXBUUFfjYVtu47BD0jaOigmUt1EnIVy40lKEBFlOk/KJHMApbOuF4ZbMWzWiRmla859lDPG/MWUPCduhpqtvT0pg1yrjyygE0IxeSsPVtV+7R7Mp7oSMR7AlIIS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174302; c=relaxed/simple;
	bh=JXG3CIOMNY5wDMzz4UfBJKTp/yf9W3rH8TR6whRWl3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jApiiaSPd7gCXVaX3uKlXMSw78784qoBvIu3zc76g3m5E03PHMbFtZTqLOL4Ly/HxR1eiFK2TMqHcxAOl8rwrqX8UPd9CILK5YuL2MI41CP4hac9t7QMf/yDYQb2QkTlmCTAVScQRazl9INspBsj7AHs3POOy4NpOghw606YS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZ5NNlf5; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZ5NNlf5"
X-Envelope-To: kees@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717174299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lclNorrTuZxHvlm4yhJSeHL+7mBpQLMo/gFiHr6+ZY=;
	b=hZ5NNlf5zcIZZsBTALKRZnh1mVr8ROUllgS4pYmV3KIQYTq2x3XySgxS9WEDtt52jFA1Q5
	6KBII4MnUd/M5BXsTr19url9OpExD0VwT4XAQMBBSbgSHSCBT7HgR/uYK+yBEGooacTXFM
	UIfeCU4+OuZi4fwUR1SHJwFbRzikJu0=
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
Date: Fri, 31 May 2024 12:51:29 -0400
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
Message-ID: <tkjmauxa4jigjznxp2ltxymz3u6urwuzwnbaaxmdg6ema7yf5a@fb2etkpyd4g4>
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

technically there's no reason for your thing to depend on
CONFIG_CODETAGGING at all, that's the infrastructure for finding
codetags for e.g. /proc/allocinfo. you'd just be using the alloc_hoos()
macro and struct alloc_tag as a place to stash the kmem_buckets pointer.
