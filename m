Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D55145FEA;
	Sat, 20 Jul 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721493858; cv=none; b=sprfYuDEbWCzqVCskjxbo+AXezWd59psp35a6Fvojo6NYWJ4exApF+C3IJEtD26r9L72YRU3mlQm1pIGIal0RDg/PbVmKXRFOBiyktIqTPY8VJqQ4IyJkNqQXmr2aoYDHb5Cm+nKJCkZl32hbpcNiWqempOIi2/43y9AheuMHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721493858; c=relaxed/simple;
	bh=co3eFJoJmB8r16P3eCUweHLirAF/oqq5JYSMK7J3rvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBtuYwTk/HS0v//mk++8Z0qTtyw4EQH7ed/KlkL6HDjE3aKISTwzLZF40freJgIWCdS09gfSQzm93d5urozI4uJY/3bjkD87A0x9VXegxJYEFpXyKR+tO69Nw4cZBpnb4CvqD9ABUqPe3bH/tmygf6Idxumgsq6Wi/71GT3BwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/sZqTPX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/sZqTPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86282C2BD10;
	Sat, 20 Jul 2024 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721493857;
	bh=co3eFJoJmB8r16P3eCUweHLirAF/oqq5JYSMK7J3rvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/sZqTPXVLOFI6rgsgCp/etM54zIrGYuMA3K+hWkWKK2kCBwgFYsHvPq/YP34/b5o
	 SIB0Ooco5ZznJM9uWe2WEaz1xLnyx+qYzp8ZmqvZrYz9FwYcHppEHcZzUavksQRF1L
	 rGGsS2oC3xr0T74mxTkyacLGmi6isLALLSPV8BboHdVlCaok8yYm37k7x2OvsMWz2x
	 YYKsaC1Nr1j+b24GxTGXLDBTIyfH6zk3arY0HG7K7odOXhMsR86vj6/Zpal4chbLHh
	 iq81QIv6RbT+IwYcaGkxMWzjvPldkWcGqhfN1RJOqdxs11gK1NtDcOxE+8Zxu0ceVQ
	 H6mn3KAEv3Mdw==
Date: Sat, 20 Jul 2024 09:44:17 -0700
From: Kees Cook <kees@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>, linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] slab: Introduce kmalloc_obj() and family
Message-ID: <202407200942.ECB06F1@keescook>
References: <20240719192744.work.264-kees@kernel.org>
 <cd446dfc-d6b6-781f-3a07-5af1edbf2230@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd446dfc-d6b6-781f-3a07-5af1edbf2230@google.com>

On Fri, Jul 19, 2024 at 08:50:41PM -0700, David Rientjes wrote:
> On Fri, 19 Jul 2024, Kees Cook wrote:
> 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 7247e217e21b..3817554f2d51 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -665,6 +665,44 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
> >  }
> >  #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
> >  
> > +#define __alloc_obj3(ALLOC, P, COUNT, FLAGS)			\
> > +({								\
> > +	size_t __obj_size = size_mul(sizeof(*P), COUNT);	\
> > +	void *__obj_ptr;					\
> > +	(P) = __obj_ptr = ALLOC(__obj_size, FLAGS);		\
> > +	if (!__obj_ptr)						\
> > +		__obj_size = 0;					\
> > +	__obj_size;						\
> > +})
> > +
> > +#define __alloc_obj2(ALLOC, P, FLAGS)	__alloc_obj3(ALLOC, P, 1, FLAGS)
> > +
> > +#define __alloc_obj4(ALLOC, P, FAM, COUNT, FLAGS)		\
> > +({								\
> > +	size_t __obj_size = struct_size(P, FAM, COUNT);		\
> > +	void *__obj_ptr;					\
> > +	(P) = __obj_ptr = ALLOC(__obj_size, FLAGS);		\
> > +	if (!__obj_ptr)						\
> > +		__obj_size = 0;					\
> > +	__obj_size;						\
> > +})
> > +
> > +#define kmalloc_obj(...)					\
> > +	CONCATENATE(__alloc_obj,				\
> > +		    COUNT_ARGS(__VA_ARGS__))(kmalloc, __VA_ARGS__)
> > +
> > +#define kzalloc_obj(...)					\
> > +	CONCATENATE(__alloc_obj,				\
> > +		    COUNT_ARGS(__VA_ARGS__))(kzalloc, __VA_ARGS__)
> > +
> > +#define kvmalloc_obj(...)					\
> > +	CONCATENATE(__alloc_obj,				\
> > +		    COUNT_ARGS(__VA_ARGS__))(kvmalloc, __VA_ARGS__)
> > +
> > +#define kvzalloc_obj(...)					\
> > +	CONCATENATE(__alloc_obj,				\
> > +		    COUNT_ARGS(__VA_ARGS__))(kvzalloc, __VA_ARGS__)
> > +
> >  static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gfp_t flags, int node)
> >  {
> >  	if (__builtin_constant_p(size) && size) {
> 
> I'm supportive of this especially because it will pave a pathway toward 
> future hardening work.  Request: could we get an addition to 

Thanks!

> Documentation/ that explains how common idioms today can be converted to 
> these new macros for future users?  The above makes sense only when 
> accompanied by your commit description :)

Oh, yes. Very good point! I will figure out a place to add this. I'm not
sure if kerndoc would be best here.

-- 
Kees Cook
