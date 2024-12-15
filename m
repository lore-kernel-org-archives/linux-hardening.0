Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA3B14D433;
	Sun, 15 Dec 2024 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300937; cv=none; b=b4Z8oqpGcHrlcMaUeJoRKsUFEp3SObZDwEkzqYmEhFc126h0K81254C/ZSR8BIyJGqZauHXESckfYexFOkEL1xGnljsEKEN1jQqPPut4BVYp0YuvZvFEG1hMkuga+3+yZB70Vpo+/1vsCSyDrhDshfKrztSxMXB2pcrNAFJjwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300937; c=relaxed/simple;
	bh=LFLsQ0g+lzZ4xHcMyDh47Z5D9FCtM0KWFaRCr1r3IMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoMBF+G21xnhP/rwyDjC8RuSXMc4VDCHqBQT10iD4N/dDNmM4dooENeFvT2+rvJRh7Mn3zQYkmaEV54QU3cjRVp9gT67+2fiwLQDUu6stn8leCAUM5TZk4D8dDmjjPW7hLSde8O/cAlngUXesOsk6apyjGnFGOnfV4wmEad4Fus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIXSdxyy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIXSdxyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ED4C4CECE;
	Sun, 15 Dec 2024 22:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734300936;
	bh=LFLsQ0g+lzZ4xHcMyDh47Z5D9FCtM0KWFaRCr1r3IMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIXSdxyy9yHUUaCJhCOict0yfneCE5cfn7INLa74DfWrS/nz7z0QmA+i6lPqQ5F+e
	 WYb7klJmPw7ps/KI40KKdGoGD7x0wnoZ84IBXtGR8gUs2T3j2TYv/EVfRjtwjBvjsP
	 e8Z80aXBUdlt5wDTa4IGm4NQDtsKgNFNzu2GWrJ2BivcDdxPBBewITQ4u+pWa2Sp7n
	 P1oPKBjiGYu6mJDbdU0f3Tu+qkzn1JUa/6XZRPuCKSnd50cxhJjGNL66k6NbHK9HB0
	 R/IeeCBaNdytudoN7D6981bwM8PKem9n+0lxBsdXYkMLLaV/On6VjDJGwmrxMOKQa1
	 4fkuu7+tEeuIw==
Date: Sun, 15 Dec 2024 14:15:33 -0800
From: Kees Cook <kees@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>, Qing Zhao <qing.zhao@oracle.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fortify: Hide run-time copy size from value range
 tracking
Message-ID: <202412151415.E116A89B@keescook>
References: <20241214013600.it.020-kees@kernel.org>
 <383ed0428fd2415aa7ab09255134d61c@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383ed0428fd2415aa7ab09255134d61c@AcuMS.aculab.com>

On Sun, Dec 15, 2024 at 07:06:12PM +0000, David Laight wrote:
> From: Kees Cook
> > Sent: 14 December 2024 01:36
> ...
> > In order to silence this false positive but keep deterministic
> > compile-time warnings intact, hide the length variable from GCC with
> > OPTIMIZE_HIDE_VAR() before calling the builtin memcpy.
> ...
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index 0d99bf11d260..1eef0119671c 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -616,6 +616,12 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
> >  	return false;
> >  }
> > 
> > +/*
> > + * To work around what seems to be an optimizer bug, the macro arguments
> > + * need to have const copies or the values end up changed by the time they
> > + * reach fortify_warn_once(). See commit 6f7630b1b5bc ("fortify: Capture
> > + * __bos() results in const temp vars") for more details.
> > + */
> >  #define __fortify_memcpy_chk(p, q, size, p_size, q_size,		\
> >  			     p_size_field, q_size_field, op) ({		\
> >  	const size_t __fortify_size = (size_t)(size);			\
> > @@ -623,6 +629,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
> >  	const size_t __q_size = (q_size);				\
> >  	const size_t __p_size_field = (p_size_field);			\
> >  	const size_t __q_size_field = (q_size_field);			\
> > +	/* Keep a mutable version of the size for the final copy. */	\
> > +	size_t __copy_size = __fortify_size;				\
> >  	fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_size,	\
> >  				     __q_size, __p_size_field,		\
> >  				     __q_size_field, FORTIFY_FUNC_ ##op), \
> > @@ -630,7 +638,11 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
> >  		  __fortify_size,					\
> >  		  "field \"" #p "\" at " FILE_LINE,			\
> >  		  __p_size_field);					\
> > -	__underlying_##op(p, q, __fortify_size);			\
> > +	/* Hide only the run-time size from value range tracking to */	\
> > +	/* silence compile-time false positive bounds warnings. */	\
> > +	if (!__builtin_constant_p(__fortify_size))			\
> > +		OPTIMIZER_HIDE_VAR(__copy_size);			\
> 
> I think you can make that:
> 	if (!__builtin_constant_p(__copy_size)) \
> 		OPTIMISER_HIDE_VAR(__copy_size) \
> which is probably more readable.

Yeah, that tests out fine. I've updated it locally. Thanks!

-Kees

-- 
Kees Cook
