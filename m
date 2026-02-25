Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150F2D374F;
	Wed, 25 Feb 2026 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772003757; cv=none; b=vFpxnbGIOXGobHJ8nGs+U7HBA5vNI0QUuOw/bukugn5ui5aTa3pUbqEZf6yRD13nJ6LwiCUCsgpLc3KvANYg4C5vGuzvnRD+fwAhU7cOfMryuVtlfJt+YS49vj197kPo08s9H+6omAgL+QBjKGndBxSOMQh4n4U4cHiiTEpXJJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772003757; c=relaxed/simple;
	bh=4BdT8DUi7UC7RFjd1x4PTnvnw1YSgTjXNR2GltKSXTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWtBDPTB6OgMzf+gZIsMSX4cfoz87kscnBInw9WdkO3LVbzPpEQyEzuXAth/pzFnhw0VrVdJJiBWzJGPbjTHqAYBAu1KDf0yB3IUJMJ+hb55Oj2R6ovPBG8Ywbm8NTjo1LwXn9W4iFf/JKWfKP4J28hdayzCfBTBSeeJXyIOXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPsNsUYr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPsNsUYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F77C116D0;
	Wed, 25 Feb 2026 07:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772003757;
	bh=4BdT8DUi7UC7RFjd1x4PTnvnw1YSgTjXNR2GltKSXTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPsNsUYrj+Fqdw9dRfQKzsT3tMy3u1TDm4AoZVBqag6LtBFdGVjQyJkZDYJvSIZv3
	 UjSI7y+1GvByJHwvgqLudsQOdYwaRmrynMtukU13oBcSaciaWPKin04/z2QqQtTdiA
	 6FDGYyxWb3782DVe463sw1ddADZdDarAmN8KVGLvBip6S33WPCtbuxqqDACYBKIJIs
	 3+mqFvc/t4xLOXV5LMmmafzBzxdSZVHm/4/GKJ6TDUaEyN77k+mNDhpG0JOv1oVmK3
	 F+3HyOYmbPQsqvDC//7ryRqieJd4h18nPei3J6gQJT3INmw77pNNy56DJ/z2R2PmPo
	 vwIJtt4WMK3Kw==
Date: Tue, 24 Feb 2026 23:15:56 -0800
From: Kees Cook <kees@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] slab: Saturate to SIZE_MAX for allocation size overflows
Message-ID: <202602242315.C9D5430C7@keescook>
References: <20260225013954.work.319-kees@kernel.org>
 <aZ5zjIpYZYoc-LSX@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ5zjIpYZYoc-LSX@casper.infradead.org>

On Wed, Feb 25, 2026 at 03:59:08AM +0000, Matthew Wilcox wrote:
> On Tue, Feb 24, 2026 at 05:40:02PM -0800, Kees Cook wrote:
> > +++ b/include/linux/slab.h
> > @@ -1105,7 +1105,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
> >  	size_t bytes;
> >  
> >  	if (unlikely(check_mul_overflow(n, size, &bytes)))
> > -		return NULL;
> > +		bytes = SIZE_MAX;
> >  	return kmalloc_noprof(bytes, flags);
> 
> Wouldn't this be better written as:
> 
> 	return kmalloc_noprof(size_mul(n, size), flags);
> 
> (etc)

Sure, I can convert them all that way if that's preferred?

-- 
Kees Cook
