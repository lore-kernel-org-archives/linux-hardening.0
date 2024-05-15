Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183A5661;
	Wed, 15 May 2024 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758605; cv=none; b=FkRwCaJ85ygQfKeDoQz+BnLG6C6/slZNsROLNQjBo0UszZ+HH9HE9WXl1VvuPgGU72gfHWoeuI6nYi2PDs45x01reXabfNjT3v43HnIPnuZtxNSpC+rhruExVbZXFZai3kvCf676dGWwoXK/9bcn/sga/JgT+h4M1zqd0fdlLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758605; c=relaxed/simple;
	bh=CefRu0Bn3G1FBcGR9MMrJgXqv9Ap5Ha9Zc0YkoqMsUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIVV5eC4yP8OTzeN4ObsPPq18Fkuagi71vIv/o9YTZm1VnpkIG2GYMZ+Uj3dxlAr5bD7aY5h05C1BU+meEPkKJ5BzJbTIuJdlCMrC35RzCdIMcJGk/weFWXoJCazz63MvK35KlX93o3wKET1I6eGff3wnAYa/KBZPT3m5kwKzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bkD/YtNE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bkD/YtNE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CefRu0Bn3G1FBcGR9MMrJgXqv9Ap5Ha9Zc0YkoqMsUE=; b=bkD/YtNEYdQRG1Ym54cU6b+Wk3
	/00CQhXbI8+/nXZM83gY+riXCUgBmyDhIRyNKzRo+pGuy5mJjHjgZ8nmq5m4esoVj6oibp+HAgZU4
	RTQgb6RNZJYr23Xh6UM7uMCw2eb4tmIoDZD2BC7Iz0pp/Y8WHniefEv2fUXMoH7WiPznGz57Yx/Vh
	W1vANy6uaWgMgYY5oOXBJyFifXNk7psgYoqk4eLIqeLRyk+d56sxx2VRkG15Q3CNW/K9ScsbYB5R4
	k6BtyRFCM9vpJ7/2SzG+K6Apa3qka+PpztVrh2LCYxfU1dLgmJzbjbhl5Vkl1ZTaAeSuck/TdzmW/
	qkk8MwhQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s79Bl-0000000A3Wl-0dEO;
	Wed, 15 May 2024 07:36:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7178730068B; Wed, 15 May 2024 09:36:36 +0200 (CEST)
Date: Wed, 15 May 2024 09:36:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <20240515073636.GY40213@noisy.programming.kicks-ass.net>
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
> For example, the most common case of overflow we've ever had has very
> much been array indexing. Now, sometimes that has actually been actual
> undefined behavior, because it's been overflow in signed variables,
> and those are "easy" to find in the sense that you just say "no, can't
> do that". UBSAN finds them, and that's good.

We build with -fno-strict-overflow, which implies -fwrapv, which removes
the UB from signed overflow by mandating 2s complement.

With the exception of an UBSAN bug prior to GCC-8, UBSAN will not, and
should not, warn about signed overflow when using either of these flags.
