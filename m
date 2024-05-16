Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083214A4E5;
	Thu, 16 May 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868600; cv=none; b=r7GSHkCoZZfD8R6elzOTl4HibbTAlRvG+PKPhShCvg1WSO+jNYdCGSLVzYTLRID0+jp7+c08uSfPLYCWmUomcv7mls2mcPI8kWtoecM5dfNr+g2t9lGoAiC+Vsx8F7g15yvrx4PoAXzS4fHafSu4y4xMUhCkgBQNb06/4McREPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868600; c=relaxed/simple;
	bh=NG33MsgUIuv6RqtlkvMV7YeulTRGpA4Wba/8OWH9Oj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jltyx8w36Uc3NvV9FGHmxkLEjjfY9ieh8HRHjbt4wiUmcLkbzMsrhNSFPGEPugfirU47Pu3DGhQg3POEwemBgmkpHoSdfUFWrttVQFDrD4oNCw/cRb2Uc9Dp9SXIGhf89NWv6eegt7i3RzuuvMgAzgVLfISK30tjLhtw27djKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aC79Bz1Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aC79Bz1Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B+vHXanNosqR77yg+0PuvGZcIdU1FMsesPSXvdi9FrI=; b=aC79Bz1YkTxxAYhSjCGt8o2StR
	VjxBfTagIHSwM2YuKqY6VBIIwokJxrXcWyB+hNoMWX31yNn3mWCQWbzr3DlfMISGjPv5omvc1pF+H
	bNUoQran6PzOZzioyDuXjEQaLN2btKjMKe6aoTCcnhcuqk2/ou0DrFcAwWm95gKtDLmFfYElUOsz2
	irk03/7fzlgi8sLrDcUVueg9FozjS7J2fHFc24GyngCNs6Ll8K2HmWeEn1RCNRcosq7RBmTY3QWJf
	4QC+G+lubu3Fr2odxsWsbOV6Gmdv8NcZo+UvyCA/rNBCVfOTHc+81r+0w9sAF/7ybvzq9y5GI8dRX
	rnnDUoSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7bns-0000000BrYV-0ziH;
	Thu, 16 May 2024 14:09:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BB3C530068B; Thu, 16 May 2024 16:09:51 +0200 (CEST)
Date: Thu, 16 May 2024 16:09:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <20240516140951.GK22557@noisy.programming.kicks-ass.net>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net>
 <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>

On Thu, May 16, 2024 at 06:30:32AM -0700, Kees Cook wrote:
> 
> 
> On May 15, 2024 12:36:36 AM PDT, Peter Zijlstra <peterz@infradead.org> wrote:
> >On Wed, May 08, 2024 at 04:47:25PM -0700, Linus Torvalds wrote:
> >> For example, the most common case of overflow we've ever had has very
> >> much been array indexing. Now, sometimes that has actually been actual
> >> undefined behavior, because it's been overflow in signed variables,
> >> and those are "easy" to find in the sense that you just say "no, can't
> >> do that". UBSAN finds them, and that's good.
> >
> >We build with -fno-strict-overflow, which implies -fwrapv, which removes
> >the UB from signed overflow by mandating 2s complement.
> 
> I am a broken record. :) This is _not_ about undefined behavior.

And yet you introduced CONFIG_UBSAN_SIGNED_WRAP... *UB*san, get it?

> This is about finding a way to make the intent of C authors
> unambiguous. That overflow wraps is well defined. It is not always
> _desired_. C has no way to distinguish between the two cases.

The current semantics are (and have been for years, decades at this
point) that everything wraps nicely and code has been assuming this. You
cannot just change this.

So what you do is do a proper language extension and add a type
qualifier that makes overflows trap and annotate all them cases where
people do not expect overflows (so that we can put the
__builtin_*_overflow() things where the sun don't shine).

And pretty please, also do a qualifier modification extension, because
that's totally painful already.

