Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9ED332ED1
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487830; cv=none; b=jE7/bUENcLDNSCk4lxxG7InXzyY2EmTq+O9t2gYmr0unWqnTIr/x1cAfgvEsaAT3IHCBOPP+xQTiLtmPlt4T1ma1Vo4SNibymJeDCgkFCvXrzOz98KwTUBt2G5qE/Qg8ebSN3TJyPlYUdB+TkxcaPBpNwnm7KvscNZGTI4+O1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487830; c=relaxed/simple;
	bh=hUxk4HA/1LmjRVI/ERTkmt5jBW8D8G4uV1QeZXJbdJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA3elhogkRuJxnZ3OJrHjR81c/a/XJLIFEkG4n4yMmUoCSDeYhJNIUcZ+EVGDX9ixlEjZUyoTR2N/VmFe+CO5Z9KmynwmacRTeFapXVYnKfVzihk082yUdHOVCpT+0PyA0quf1/TPpEd3tHKX++giRSAvwGUQ8+B6GQhC4OrBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wn6zMLsP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wn6zMLsP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-480706554beso7109725e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Feb 2026 23:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771487827; x=1772092627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ee6rz3n4lRLIfzQydkYiBi8fGnwsN3AAWbuDK39dnaE=;
        b=wn6zMLsPxLDSjPqCOC8EPanbRoJjb/GhwwAiwKbxvLfRGBJ3GYTGwQ4qF5HDoQ/1R0
         qdGTCtWPdVN6F2k08vDpaJIvmO803LXTZOngLdaOpV9zNT7llHIMPwYS+ZCZowlG7HKD
         XusJKKjQ9/oy3mtBFEOnDn468IMxsSv2Efh+1iWwfUB//V17e6w1aCHCZAJdYMuKvVZd
         olHfKcXzAVfeAz9LOUDQ2UfXYAdKAwIrjjN6OF6nYA86zdqkm9LIlEHXQQdfN3Iexz2U
         3vc7w1TQUX0LgqScfXjpca8E74x0P7A0ljnubUGSZ+gvd8gKqKr/xZKlSAyTNaWIuLcI
         xBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771487827; x=1772092627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ee6rz3n4lRLIfzQydkYiBi8fGnwsN3AAWbuDK39dnaE=;
        b=F8koanK0qcKALu2YFLfNw3Bgf07vU+Xy+ezYL2itkEtZH0iHIf49EcuPUoWVV0lgc7
         yKBVgvoymdoanMBgm5L/Ozf6rEkWw1aDzv3VbC5810b5IiWC9gYxEKIYMlwO+F1eZGzR
         H1jO1W/9sSuOYP6T0ffW6rq8uLCxJQW0EGOUFVP6irMw15/ds9FP9iaaqjn8TDGDA9ms
         U1HpdeW7rfw7ZH0RcZFWrpHf1izr5K+94kxC+GRuL+FxuAp822fFeAHBLlCzpRA3cJq7
         IUDGGLDjQ9TisC8uET9klm3cyQRrEdkxfm4Y1cvQEWSOVFRxCPPk5im8zfZvuvIKGc24
         90vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpmQAxKritsaeCWr7zn+Ck3MkQtcMZn17JH7PkDnb8SYO2Avj4uJsj8z7F9cC8nimGCyWOVo7ySYXtCM/nJ5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsE1FH3iwTd+sKjOcKPRDkatGnaZhyyaoC05zND3GK/duJRiq4
	M9kE7D+hXztMu/tldKOTyY5UyoZuPZuqHcpwW04QMLok6fqsJupwJqzUFTuCPYdwVNw=
X-Gm-Gg: AZuq6aKEo6BoCWqv42ASFoZEuepMbxawXU0NvkS7Il9XbBRLVbNbDL2nE6kjEbyfbhP
	JEg+IMTiDs7vQTtllHX82Q+BvTTIDjqSDrDmaLeaTz0rKbtN55mICS5dcgsVa3m5MsDwVmXW2b/
	5drYDN4Ebor0ky94kW+15dKW6yjg3evjmy/ux/uKKieRn9/EqFfqA49ubjO1xXW3vmGOZHYuPD8
	QKrRK6Ux3OlL+ktioXykSKfmgJbJCQ4mTtCHEsHFUwDms3gMblFk6AAHgxmPNJ+1tRQYjy85VpF
	dmrXzOyeplhtrSg95mZG3Adfb0lzrVSHee2R4YulXmPUrxS1A0wJAXM8+S1pyljw/qxKOkrpuDT
	2XW6y13GWVY6vboz1D7ktmGZS9zJgJ4QLGakXtnLUGl9vRdT5Sl5cjke/RQFZfj+ZGI8gavqSFZ
	C5ZLx0ZCw1v5Hn8O4BD4DmCUGKs5MK
X-Received: by 2002:a05:600c:698c:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-48379b932b7mr310004635e9.3.1771487826769;
        Wed, 18 Feb 2026 23:57:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f96967bsm15143135e9.3.2026.02.18.23.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 23:57:06 -0800 (PST)
Date: Thu, 19 Feb 2026 10:57:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 1/5] slab: Introduce kmalloc_obj() and family
Message-ID: <aZbCT3-q3O4M5osr@stanley.mountain>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-1-kees@kernel.org>
 <960729bb-0746-4709-a40c-2e254f963deb@suse.cz>
 <202601090928.5CFF95F@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202601090928.5CFF95F@keescook>

On Fri, Jan 09, 2026 at 09:31:03AM -0800, Kees Cook wrote:
> On Thu, Jan 08, 2026 at 03:01:00PM +0100, Vlastimil Babka wrote:
> > On 12/4/25 00:30, Kees Cook wrote:
> > > [...]
> > > +/**
> > > + * __alloc_objs - Allocate objects of a given type using
> > > + * @KMALLOC: which size-based kmalloc wrapper to allocate with.
> > > + * @GFP: GFP flags for the allocation.
> > > + * @TYPE: type to allocate space for.
> > > + * @COUNT: how many @TYPE objects to allocate.
> > > + *
> > > + * Returns: Newly allocated pointer to (first) @TYPE of @COUNT-many
> > > + * allocated @TYPE objects, or NULL on failure.
> > > + */
> > > +#define __alloc_objs(KMALLOC, GFP, TYPE, COUNT)				\
> > > +({									\
> > > +	const size_t __obj_size = size_mul(sizeof(TYPE), COUNT);	\
> > 
> > I assume with the hardcoded 1 for COUNT, this size_mul() will be eliminated
> > by the compiler and not add unnecessary runtime overhead? Otherwise we
> > should have two core #define variants.
> 
> You're correct: the compiler completely collapses it with 0 runtime
> overhead; a variant is not needed.
> 
> > I also noted that the existing kmalloc_array() and kvmalloc_array() do
> > check_mul_overflow() and return NULL silently on overflow. This AFAIU will
> > make SIZE_MAX passed to the underlying kmalloc/kvmalloc and thus will cause
> > a warning. That's IMHO a good thing.
> 
> Right -- I prefer seeing the SIZE_MAX yelling from the allocator. Should
> we change how k*malloc_array() behaves?

Huh, yeah, it's weird to not get a stack trace if kmalloc() fails.  On
the other hand, if we're allocating SIZE_MAX, that is probably a user
controlled size.  Since we don't want people spamming dmesg, it should
probably be WARN_ONCE().

regards,
dan carpenter

