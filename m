Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198B24E016;
	Thu,  4 Dec 2025 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764838503; cv=none; b=EpZTps02MGVGWmc/R5sBec8dBbL89R25lKoXCrIrf7lDlU9fQbXCwCN3kY25U0EqYAREjYSxOLLB2VcY3dcSid0PLgYQUh7IbPOlnZ9aYI7Ch+t+imSd2u34krXBXRx/aZQcrF/hgroquxgSWhbUvkcHExZ5PlMLMNH98cb3YFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764838503; c=relaxed/simple;
	bh=ev6wOxwKmhmG7bwlZxZwcWiDotdwEQDBc8PTEeQKiGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaVlAX0a2rjA2IXKlSAdpTj13t0loajxWXP1SmVeI17MmmC93gwpWyaNQyq8YpAS2EzUHDtLG8kIIVA6naBGzCkOmF2JeCkLyCw/Jn+RIcXDQh8RguqGpGhukC/ae/DixlFQrR2yVy7ZX8pWZTPqiiBwggsvubwyz24IlQtefqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n1Fmcq1O; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n1Fmcq1O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1ZKEvWFqVXW3ANMXU8thFViT+wrQQ/PtkxsPiuQj5uA=; b=n1Fmcq1Ozcb1gZNwIwt7tfRmcb
	6np3a9hJ2mNuV0iDdqz4vOjj8nB7hr6wPMYVcRAqwYqBJ/JYSg74MYNtYY6v7QOF6NWVH+Bm1jfjZ
	+3QSmdaLpOIdEBz9MhaV6ERwPjIwH9bzMBwG2Dsh3ocb+kM42BG640wLyfrUvZ6wVY06s2aoSVr6r
	ygMGl/Yg9Q1jwjZeqy7qoOX9MxbbcqqYExtP5uc6u05Q+BZc1iJzDq8h7ORVWT1xjQuCsEbJxex+L
	cDBWaOpNmzXuQIftV0tJE5yg2rPGn3y5hOIeN0UrM7PJRPGi+1xTjhfqIpsJX7J2hDo9FNmRRCFnB
	oI8a0szw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR4FA-00000003fDj-3C2R;
	Thu, 04 Dec 2025 07:59:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0DB523004F8; Thu, 04 Dec 2025 09:54:36 +0100 (CET)
Date: Thu, 4 Dec 2025 09:54:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-hardening@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Christoph Lameter <cl@linux.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v6 3/5] compiler_types: Introduce __flex_counter() and
 family
Message-ID: <20251204085435.GC2528459@noisy.programming.kicks-ass.net>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203233036.3212363-3-kees@kernel.org>

On Wed, Dec 03, 2025 at 03:30:33PM -0800, Kees Cook wrote:
> Introduce __flex_counter() which wraps __builtin_counted_by_ref(),
> as newly introduced by GCC[1] and Clang[2]. Use of __flex_counter()
> allows access to the counter member of a struct's flexible array member
> when it has been annotated with __counted_by().
> 
> Introduce typeof_flex_counter(), overflows_flex_counter_type(), and
> __set_flex_counter() to provide the needed _Generic() wrappers to get
> sane results out of __flex_counter().
> 
> For example, with:
> 
> 	struct foo {
> 		int counter;
> 		short array[] __counted_by(counter);
> 	} *p;
> 
> __flex_counter(p->array) will resolve to: &p->counter
> 
> typeof_flex_counter(p->array) will resolve to "int". (If p->array was not
> annotated, it would resolve to "size_t".)

Uhh, how will this interact with the proposed extension of
__counted_by() to normal pointer types?

Because the moment we have __counted_by() on pointers (remember, you
promised to rename __counted_by_ptr() to __counted_by() once GCC-16
releases) using __flex_counter() on a ptr thing makes absolutely no
sense.

So perhaps just name this thing __counter_of() or something?
