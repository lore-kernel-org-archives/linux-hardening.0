Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751D3AEB2D;
	Tue, 13 Oct 2026 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880625; cv=none; b=iJwXUQJI+Jc3ht6/o1xCUYxNSRDpo7IaG45WO99BhKOv7eampZl/xxf29kb+Y5iQ6i9PPWlYjs7Lu77h2P/Yghz/bIGt6pwOr0h09XsH64nWnARcKzLWtwRZrzOzxLKfCVge9uNT3jYSqyx9NjDN7xArH7/fsKwpvQZLxwO2lY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880625; c=relaxed/simple;
	bh=5Larl/MqdSIF9ccyNZKIoWKA808oDwCFRDG8EaXM1FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABWiCF6qiQ32tck+pwFjsqWKJ7iApcP5zKA5NKA/CU0NBVE2vWoWyq9artKmG0fsp1TP4Nic1aF+QT4g2c9tj81AbYe47+MUjnB8qB1tJxhwmqnXg8P7K0SnOASjBvAyGgvTJdifuX4aNGgk+NV4H7a/7+Rw8G8A/wpmNcpKSn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2CEIrrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2CEIrrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3467D1F000FF;
	Tue, 13 Oct 2026 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791880624;
	bh=KNjASguwlBNzeT+AWUBWq2LymeV1FQikCYw41kf7W5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W2CEIrrDMjZNjyWos9DeKK2LkCOAICupRynidZ+RkjtZZ0JVaUbRWQbCaGXkh4iGY
	 DtJIdZr0YDwMtyoSp2T7dSJNvodEfIYDS0qt0u73Yos2+VejkwWrul2ammk1RVC0oN
	 4DlgHWXtZ45RSW57Mm0BuyZa3vB/x/KWD2MS7hKLGEa5AzS2hXwCmvZfFwao73jvxy
	 FKSZx6L9v9BIGwndutkVuB9klZr6xNPkYoG4TviKLQcMd+TRBxVKRmXuMEeK3SfVM8
	 NpCG8RIz7vJ/bEsL5sZYFK4bv7bk9d47GI9fiLUWvvVZ5dxwsHCwJoon+hX41Tbu2L
	 AuIEKxam9gZMw==
Date: Tue, 13 Oct 2026 01:37:03 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool: Skip jump table jumps in the kCFI indirect
 call check
Message-ID: <202610130126.E24D003C0@keescook>
References: <20261012090424.i.497-kees@kernel.org>
 <20261012090436.1676525-3-kees@kernel.org>
 <20261012092250.GO4121339@noisy.programming.kicks-ass.net>
 <20261012183925.ca026d-kees@kernel.org>
 <20261013064405.GY2009045@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013064405.GY2009045@noisy.programming.kicks-ass.net>

On Tue, Oct 13, 2026 at 08:44:05AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 12, 2026 at 11:41:03AM -0700, Kees Cook wrote:
> > Clang never has this jump: with retpolines, LLVM's IndirectBrExpand pass
> > turns the label addresses into indexes and the "goto *" into a switch,
> > which Clang's -fno-jump-tables then makes a compare tree. So it's only
> > constructed this way under GCC, but since now we can turn on kCFI with
> > GCC, the objtool warning about indirects without kcfi protection trips.
> 
> OK, then the next question; do we *want* to allow a 'naked' indirect
> branch to survive?

I originally struggled about this. I'd really rather that GCC not codgen
like this at all. On the other hand, it's a bounded load and jump through
an .rodata table, so that's kind of a manual CFI. :P (And if it gets
targeted via ROP, it doesn't matter: everything is a target then.)

> We can simply disable the whole interpreter when kcfi=y. Isn't that
> thing recommended disabled anyway?

I don't think that's realistic, as every GCC-building distro will (I
hope) enable KCFI as soon as it's in GCC. It's present with
CONFIG_BPF_JIT_ALWAYS_ON=y, and only Debian has it off:

  │ Debian sid and trixie                      │ not set
  │ Ubuntu noble                               │ y
  │ Fedora, CentOS Stream 9 and 10             │ y
  │ Arch                                       │ y
  │ openSUSE Tumbleweed, SLE15-SP7             │ y
  │ Alpine (lts and virt)                      │ y
  │ Android GKI android16-6.12 (arm64 and x86) │ y


-- 
Kees Cook
