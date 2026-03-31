Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FC4508EB;
	Tue, 31 Mar 2026 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989077; cv=none; b=eZwovHURXMLOlXxHdxrhE1Qrluhcfc1tV+lFKl1+ERV0DCDVEhOUwQGYEkx3x/t4uXzc1ncYSQwMev2tsu/Y4/GsRe8aeISxXKY9GB00YlODX2Sn5G07o9We8EbL24p61M6JfvZbjzP5CN06pMDROtyrdXhjVjofMtJaU7Kmw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989077; c=relaxed/simple;
	bh=0KVgHaBTELcPga+p3MyVT+8zhwlP4t56Y8zdw533+b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntYFZ82CibUa3uJa+cdomKI2TJX5oDt5wMF0WSKpUL6iL1GTLdUAxts3EhjLwVcquZVzzRCYjBlVmKDbFD42ctml8OrkJSTHxRbM5Vw8x5/cFwSSRxRpj+vNNC4AOVdw9hAwPgnhG2PCEEVLXbRJEHXWJmH2yud+NW0hdJg+87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk2uBlod; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk2uBlod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27327C19423;
	Tue, 31 Mar 2026 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774989077;
	bh=0KVgHaBTELcPga+p3MyVT+8zhwlP4t56Y8zdw533+b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sk2uBlodNeXH5603eWHqDgVq3OE+v5cMCxznOFpYGjue2t0PWv+dZOReOCvNOsdHV
	 XreIsB5jo19Z49WaI2mmor3tqs4tNpq2sKNKb8VUQ/WXVG+HRTBDubOhk5yXrshMW5
	 ewFYMVi+5qgWPR2RmuwG8ErHruVZGpwdRHGPnz+FxCCYtaJjZSwEftOKsSpOmg8MDF
	 vjHr3AeCTc+3uUFJwwi0GkRe/Htv2Dzsdu4lnB0yjzQFP15WeVfa/x7Vv3cUYyzqr+
	 R7zmbW54NHe/cUtiWFnmWYKtZknas8vVNhktZ1H3fBQYlrddw2Geeqs9FKimWzUXYV
	 hF7NgEpmMD8pQ==
Date: Tue, 31 Mar 2026 13:31:16 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <202603311321.4EE9FEA@keescook>
References: <20260331163716.work.696-kees@kernel.org>
 <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <202603311253.95C54588E@keescook>
 <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>

On Tue, Mar 31, 2026 at 01:11:22PM -0700, Linus Torvalds wrote:
> On Tue, 31 Mar 2026 at 13:03, Kees Cook <kees@kernel.org> wrote:
> >
> > Mark Rutland had strong reservations about function-level annotations,
> > but I wonder if the combination of new type _and_ function-level
> > annotation could get us something near what would be palatable:
> 
> Yes, if we had some way to specify the label, that actually looks
> really nice to me.
> 
> So with _this_ kind of interface, all my reservations about it go away.
> 
> And as long as the compiler actually requires that label to exist when
> trapping arithmetic is done, I don't think people will use it without
> having fixups.
> 
> > Or we could make the label a global part of the language itself so it
> > wouldn't need to be a function annotation, but rather a _required_
> > element of any function that uses a trapping type?
> 
> Yes, I'd be ok with that too, because I think in practice you
> typically only ever have one, and I guess you could use local labels -
> or multiple functions - if you really needed to have different
> targets.

Yeah, as you mentioned earlier, I'd agree that nesting is rarely
useful. The only thing I'd want to be careful about is ordering/scope. I
*think* it would just operate as a "goto" and things like the cleanup.h
handlers wouldn't be involved: they operate when a scope is crossed
like before. And I think the overflow result wouldn't be represented
anywhere. i.e. the wrapped/truncated value wouldn't be stored:

int func()
{
	...
	u8 __ob_trap product = 5;
	...
	product = a * b; // if store is truncated, goto __overflow
	...
	return product;

__overflow:
	pr_info("%u\n", product); // shows "5"
	return -1;
}

(Isn't this just an implicit "try"?)

-Kees

-- 
Kees Cook
