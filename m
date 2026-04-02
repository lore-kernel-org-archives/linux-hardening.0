Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB4242D70;
	Thu,  2 Apr 2026 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775108333; cv=none; b=Ur2m4j1EPVNjCYGeQaNB3YfaxLbzmmmLxrbJbhHnB1JlnERjhsXwWK52E/XsG4ojFIc5KnF2Z3UvX3n1bY/KTX7vfzGSs91kNLjWN22D2rcVufh/Rov/bwRO8CpFpn0xfD+zUvM9DzqhOpLbrtzZP+CSl/xO2goUnqGUPjQcEBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775108333; c=relaxed/simple;
	bh=U3xZ1AwEDx8plhHOTiqeJsbncmqK1gx2AA1/5UoeUWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh+n1s1ZkttSfjIjzufI14pW+ND79sKS3CMbrJ7BgAJ3Jb4AUPm1huP87WNLhlCy94LTxp1o4gqp+fgwWeAKTEyYUk8WC745n3YLJKFsLXi7gU5GAAqMLaz+W4NeyFd5dWLpc/9CEvecEiEkYfxLRaluQsDFiXJdvBmo0tafnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CHOG/o0H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CHOG/o0H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=czWzbulJL+c3dxqGyG6G4eYxihbPhqEeecVFHDNjAYk=; b=CHOG/o0HcrD8J9KjJ8u/b9jPNt
	amu2MdnlCTZvW3mUyyyeTaIBMEtAQFIzIKWF01LSnY9TlRRYQckfYfsR75O/kBnl1bf9kP/5r2kH0
	muJeCHe+iBb3i+tGeedB3stwaNoDlql9KLc43duVW5ErhPOlbHj986kTKrBSLIJ2gn5OVgvcxzXHw
	IJKjlzRIqVJ2yQmJwW66xYMUBZ2h81LI73ut/5IryM/3KgIuSM83P+cnaXXWslpc23iDfRI1B4Ufw
	Z0eDopMkbQ8gR2kRJyxdS7r31HgBjMjd5BdmPs04UWCa14ZVMKSvPaShQnNrQbYPualhsXg5OlTDN
	W013HWqg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8AlO-0000000BeiC-3CgU;
	Thu, 02 Apr 2026 05:38:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E351F301BD5; Thu, 02 Apr 2026 07:38:40 +0200 (CEST)
Date: Thu, 2 Apr 2026 07:38:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
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
Message-ID: <20260402053840.GD3254421@noisy.programming.kicks-ass.net>
References: <20260331163716.work.696-kees@kernel.org>
 <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <202603311253.95C54588E@keescook>
 <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
 <202603311321.4EE9FEA@keescook>
 <20260401083137.GT3738786@noisy.programming.kicks-ass.net>
 <202604011328.D3821379@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202604011328.D3821379@keescook>

On Wed, Apr 01, 2026 at 01:52:26PM -0700, Kees Cook wrote:

> (Though I would note that GCC does _not_ refuse the jump when there is a
> cleanup; it only see the other two uninitialized values.)

Yeah.. I know, but since we also build with clang, any such issue will
get discovered.

> So that makes it not totally broken, but it does make it a bit fragile.

Right.

> Another concern I have is dealing with older compilers and how to
> "hide" the label and its code. e.g. if I remove the "goto" from above:
> 
> ../drivers/misc/lkdtm/bugs.c:1060:1: warning: label 'weird' defined but not used [-Wunused-label]
>  1060 | weird:
>       | ^~~~~
> 
> Oddly, the unreachable code isn't a problem, so we could just wrap the
> label is some macro like:
> 
> #define force_label(x) if (0) goto x; x
> 
> force_label(weird):
>         pr_info("value: %lu\n", value);
>         pr_info("outcome: %zu\n", outcome);
> 

__maybe_unused also works on labels. Like:

__overflow: __maybe_unused
	dead-code-here;


