Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D73B297;
	Thu, 16 May 2024 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715845533; cv=none; b=Y3ZIjPRbKfoKeTYx7Av+FP3DT1ANiUq8IPL5SFJYPkhjKjyCwU2ROPHie5AhXqxooY3NTs90hadTYM3BtwRugrX+h8If8bBXIpUjd9Tzr1tlFUMBc5u4iNcIhMWZ4EgU9v0zmoo+iXUJoaERhyMSmbox3jRPAD1daazv74siuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715845533; c=relaxed/simple;
	bh=Jjv0qoO9pCCiZ8DgraPgwD+Ddurfi+cYw9BcEW/I0WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abY4Xl49a7fTdrU3qTB21ZJKSLfK+3Y8F3LPmaDeFXVdZWi08POSJz1P3D9gpAjvbIZLtGwbCwuxKV8vhQZ7Wau4cKVqchKYlgR7yxeaZeymOXDPonpcboGgOjkpFTKqe3YPpYQSV08WulGiCw7pjzUbXiioFYTrNwPZjZKStRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bzg1TJqF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bzg1TJqF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8b+oRtdQ0X9yL9vuTV6GpzpK7D3Wqhggin4wXJLyF8I=; b=bzg1TJqF/Ez5dJqxMoXFpqiCqD
	D2klMN3LrvcHM1hA0P+cqx8bHKznRjJew51iMOXvlWMyAW3+GoifaBmnRhtu39qMGCKYzejmnc89p
	WgedVpFNCkjiqs/KRtZk6J2jibsKuVf3y+RWp0xPE6LHrC7v/k3UQAHmpOHsfhEgUDMStvDXrFPX3
	rRGCE+WKnsel3vGw9UhUendi8pG6PxpEE4sIvz+chIM6VeUJ8gqaIOu18As419o+VIQe0TaUC+xo0
	r2tV1MjC4xl04+/J0gpQ+G9GcweM6SWhaXmiMMM1Sy+VWu+UezuTFbgh1XlyCvbl/HoI85+63dk3I
	v5DbbnhA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7Vnk-0000000BWIH-264v;
	Thu, 16 May 2024 07:45:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1087A30068B; Thu, 16 May 2024 09:45:20 +0200 (CEST)
Date: Thu, 16 May 2024 09:45:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <20240516074519.GB22557@noisy.programming.kicks-ass.net>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net>
 <CAFhGd8qKObvqbLJWvkG+Wfuy0gpWiTsSmFrBO-NzC-akB6bhzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8qKObvqbLJWvkG+Wfuy0gpWiTsSmFrBO-NzC-akB6bhzA@mail.gmail.com>

On Wed, May 15, 2024 at 10:12:20AM -0700, Justin Stitt wrote:
> Hi Peter,
> 
> On Wed, May 15, 2024 at 12:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 08, 2024 at 04:47:25PM -0700, Linus Torvalds wrote:
> > > For example, the most common case of overflow we've ever had has very
> > > much been array indexing. Now, sometimes that has actually been actual
> > > undefined behavior, because it's been overflow in signed variables,
> > > and those are "easy" to find in the sense that you just say "no, can't
> > > do that". UBSAN finds them, and that's good.
> >
> > We build with -fno-strict-overflow, which implies -fwrapv, which removes
> > the UB from signed overflow by mandating 2s complement.
> 
> FWIW,
> 
> Clang-19 allows -fwrapv and -fsanitize=signed-integer-overflow to work
> together [1]
> 
> And the sanitizer was re-introduced with Commit 557f8c582a9ba8ab
> ("ubsan: Reintroduce signed overflow sanitizer").

Urgh, that's the exact kind of drugs we don't need. I detest that
commit. Both unsigned and signed have well defined semantics.

And since (with -fwrapv) there is no UB, UBSAN is not the right place.

> > With the exception of an UBSAN bug prior to GCC-8, UBSAN will not, and
> > should not, warn about signed overflow when using either of these flags.
> 
> [1]: https://clang.llvm.org/docs/ReleaseNotes.html#sanitizers

That link doesn't seem to work for me...
