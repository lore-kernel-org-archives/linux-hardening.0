Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6F347FD7;
	Wed,  1 Apr 2026 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074992; cv=none; b=KDNH/yqkewn+CVuBY6aNqSZoOSddUksNmmymWmyd8pe6MO2zrBuIJ7NL/mwyivj3uzJOA79HYIOQawkOMIKC+bwBVyuqmiyuflEt8YwtHbrjeo5VuvKh+kBG9L+/Ku/6JF4QDixq1FQjc+PCCC+qp3OZpwiGRmi18YLC5zFlxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074992; c=relaxed/simple;
	bh=xWP1+Nl6QH0DBKwNPzGsoagJFFhmP+z/PXIHglPika0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR5XOxtazccK4oCkTQHe4BgtJ52RToa3HmmgyVxtjfMN/JMZlEpygyzkZjF0BHQOjtk20FAV9mjx5fAc8J3F3C162++YiXdlZl7nYheinsYo/C6VffAVKAWDyprMJTGYs6OifgxdKWACxk4fAyKPwCzt63fzmLXcztGjS3nrq58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL4WEnk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL4WEnk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBD8C4CEF7;
	Wed,  1 Apr 2026 20:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775074991;
	bh=xWP1+Nl6QH0DBKwNPzGsoagJFFhmP+z/PXIHglPika0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AL4WEnk5+ta6RB1brLy3jqRkdsNBiDQ4ebe67m6jJnYWEYcqwjG+9MVW6c5/1YWqr
	 1vZXPz4iI1Jy1x7gJPIhvoLizrruvAEIjTDtQMSYkTztVSaZuO+ib8mXUGnSN//MbE
	 PVNXxeUjR8anItFhjPs077hkj3BehgZlDcyMbzDGi2fXdB7b+0GeZeygo8cvGqW7XO
	 z4ZojdkU22Q9YKXxo1XrsOUQ7OQAr803+EyeWytSiG6shz0yOBIlyEE8Nt2lSV63YU
	 Bk2CMspWopl4HNDz1dLsW2DO8sJt8wBfq6c5abdshyk4DS9JCEIxbiyYmxsafW2Iky
	 9xO7/+aQtoAcg==
Date: Wed, 1 Apr 2026 13:23:11 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Finn Thain <fthain@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	llvm@lists.linux.dev, Marco Elver <elver@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nsc@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar
 types
Message-ID: <202604011321.71B00E3@keescook>
References: <20260331163716.work.696-kees@kernel.org>
 <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <202603311253.95C54588E@keescook>
 <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
 <202603311321.4EE9FEA@keescook>
 <20260401085706.GU3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401085706.GU3738786@noisy.programming.kicks-ass.net>

On Wed, Apr 01, 2026 at 10:57:06AM +0200, Peter Zijlstra wrote:
> On Tue, Mar 31, 2026 at 01:31:16PM -0700, Kees Cook wrote:
> 
> > int func()
> > {
> > 	...
> > 	u8 __ob_trap product = 5;
> > 	...
> > 	product = a * b; // if store is truncated, goto __overflow
> > 	...
> > 	return product;
> > 
> > __overflow:
> > 	pr_info("%u\n", product); // shows "5"
> 
> I'm confused by this 'product is still 5' thing. It seems to me that
> making this happen will, in general, require more instructions/registers
> than allowing the old value to be clobbered and have product be the
> truncated result of whatever overflow.

Yeah, that's fair. That's what happens to "out" already with the existing
check_{op}_overflow(a, b, &out) builtins, and what happens right now
with the "while (var--)" exception (var will wrap even as an __ob_trap).

-- 
Kees Cook
