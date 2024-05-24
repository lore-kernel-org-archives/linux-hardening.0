Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1E86643
	for <linux-hardening@vger.kernel.org>; Fri, 24 May 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562509; cv=none; b=MV8C/wJ10AJyzBBW8ACGmsK7DtWL8qWrTQ9jjNngBQfWbEEgNyvrlM0hA4bCznsi3G9RdQi/9qAGBhi459HVtTns8OlCSj5XAfpi9KF++yJDgz3dnpbiNjkboJXfmotryE0VoT11PU1nypZ4hPX9kGNFINMNl9JZGLOhzHWSdeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562509; c=relaxed/simple;
	bh=ys1NXraa5YBjhGzFwgmkQfLtgZfUi3TRL9qe0CS4rAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0gNcOK22x2fjYZLV/GAYVXSv9b18Sa2dGr2TWgI+YAfXntnb7Y5Z/78z1BhObtUSnNm6nvjpZRRKjK0mTBpJf1KJwa+fT5MVgVrWrscF6VuOurdNOfz3JNDVq7Xb4BGj5l53/q0ze4b/cAhbipiVlhI6ZfFu5uhE9yO/YMnVKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VEKBWNRw; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VEKBWNRw"
X-Envelope-To: keescook@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716562504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7eBsqdgaEgOyK97Okk1hi9lHrmzeIeL0UB3tqvDlIRw=;
	b=VEKBWNRw/vIK1I11UQntL0tbVI40n9fwIDNjWrmS/yO6NcBT7iM8OrrN0fAApJnI8HlcMv
	NJijsJJ8VQ/28RWLHEEslbN/nHi04xkmLPun8i7kREnkqMh9PlWA3fJ21lHErYrRcko6j2
	ImDohF7BAmiSIQ+Ime2Wv+cWQPm/ZAc=
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cl@linux.com
X-Envelope-To: penberg@kernel.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: gongruiqi@huaweicloud.com
X-Envelope-To: xiujianfeng@huawei.com
X-Envelope-To: surenb@google.com
X-Envelope-To: jannh@google.com
X-Envelope-To: matteorizzo@google.com
X-Envelope-To: tgraf@suug.ch
X-Envelope-To: herbert@gondor.apana.org.au
X-Envelope-To: julien.voisin@dustri.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-hardening@vger.kernel.org
Date: Fri, 24 May 2024 10:54:58 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Suren Baghdasaryan <surenb@google.com>, 
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>, 
	Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>, 
	julien.voisin@dustri.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/6] slab: Introduce dedicated bucket allocator
Message-ID: <7nonr2cucww7j55kresncgt23pvgt3pmnfukqpnqblk3fmtfdl@ewhqe3ylioz2>
References: <20240424213019.make.366-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424213019.make.366-kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 24, 2024 at 02:40:57PM -0700, Kees Cook wrote:
> Hi,
> 
> Series change history:
> 
>  v3:
>   - clarify rationale and purpose in commit log
>   - rebase to -next (CONFIG_CODE_TAGGING)
>   - simplify calling styles and split out bucket plumbing more cleanly
>   - consolidate kmem_buckets_*() family introduction patches
>  v2: https://lore.kernel.org/lkml/20240305100933.it.923-kees@kernel.org/
>  v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/
> 
> For the cover letter, I'm repeating commit log for patch 4 here, which has
> additional clarifications and rationale since v2:
> 
>     Dedicated caches are available for fixed size allocations via
>     kmem_cache_alloc(), but for dynamically sized allocations there is only
>     the global kmalloc API's set of buckets available. This means it isn't
>     possible to separate specific sets of dynamically sized allocations into
>     a separate collection of caches.
>     
>     This leads to a use-after-free exploitation weakness in the Linux
>     kernel since many heap memory spraying/grooming attacks depend on using
>     userspace-controllable dynamically sized allocations to collide with
>     fixed size allocations that end up in same cache.

This is going to increase internal fragmentation in the slab allocator,
so we're going to need better, more visible numbers on the amount of
memory stranded thusly, so users can easily see the effect this has.

Please also document this effect and point users in the documentation
where to check, so that we devs can get feedback on this.
