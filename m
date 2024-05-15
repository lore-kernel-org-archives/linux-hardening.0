Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376884CB2E;
	Wed, 15 May 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759870; cv=none; b=UrIMNWpG16yp+7ceaP9kcHUB7w58vqjX4h7uPCUjtWqSThT5knPO2aBGmscO3CaUVy54KZ0QoqKunYm4yAs2lFjo1tW1pxFaaeV0bXFaHn1VaPRC9L4F7zHxA0ZLzyxXau1lFM3IN0wThtP3vlG+YlsaM3Xf5dHdJpwPwBzT4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759870; c=relaxed/simple;
	bh=Z/lRFMon1x6t5IgwQK1lijm0gQDnovjnOQHfgmMkPMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWJw/ynJfZQc8anL5+E5T31QXssnUEXd8XfQrOAKcyUGoF2nNbxFQ7LfVqVvXR/HChTaS9hr+QjSqP+WOl32RVi6vA9moM9SqkyyUe5huQmfR2MKAfLblgg5dqMVb5bS7F/G87Vc5dkzZsR6WTIO/Kz1MSuiFdBMHL6bOxg2ADk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MZil/YLZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZil/YLZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EVMjXvYoWu9duYh304Rm/ZLOEAMOJGnAs/As64ANNG8=; b=MZil/YLZtZbxcwu9zxQwWqU/no
	FsJod91Q2GIeY0p9N68dmcq5o7/HloU8fCADGnfFGR8QT+iJJb5OBTw334/PF1eKpbJJ2Q2a10EZA
	EZagCuaq/y9hVOs6uWdWEMoUmfnLm0WkpxJdNqmHxUKuWZ3BLjmNV+bOFkYPF8mJ6Vp6uEIdeQRwi
	MzJaP8h/5ntJd6/mbyYvI5xCt4prSAMqbhPakulwAPJQtA3+aCGPXodVnX0kn/mZsAcWN/0AvBetR
	9c2+qGOmc9Jz7WPF7zeGbljGp4kS9f8ogDFr5/oix6M3692dOekp4m541m3lXgIGeluXV5te6uxaI
	T/w0fuLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s79WD-0000000A4ao-0ebj;
	Wed, 15 May 2024 07:57:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C8FAA30068B; Wed, 15 May 2024 09:57:44 +0200 (CEST)
Date: Wed, 15 May 2024 09:57:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <20240515075744.GZ40213@noisy.programming.kicks-ass.net>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>

On Wed, May 08, 2024 at 04:47:25PM -0700, Linus Torvalds wrote:

> Now, another thing to do might be to treat assignments (and again,
> implicit casts) to 'size_t' specially. In most compilers (certainly in
> gcc), "size_t" is a special type.
> 
> Now, in the kernel, we don't actually use __builtin_size_t (the kernel
> started out with a very standalone type system, and I think it
> actually predated gcc's __builtin_size_t or maybe I just wasn't aware
> of it). But we certainly _could_ - or we could at least use some
> special marked type for our own 'size_t'.

So I've been arguing that since unsigned (and signed too when -fwrapv)
have well defined wrapping semantics and people rely on them, you cannot
go around and assume that wrapping is bad.

You're arguing much the same.

I've proposed that Kees instead adds a type qualifier to explicitly mark
no-overflow / no-wrap types. That way __buildin_size_t is no longer
magical, and it along with all the other __builtin_*_overflow() muck can
go away. You'd end up with things like:

  typedef nowrap unsigned int __kernel_size_t;


or perhaps:

	nowrap int idx = j * sizeof(foo);

etc. To indeed annotate these baby steps, without making code needlessly
ugly with all these __builtin_*_overflow() wrappers.
