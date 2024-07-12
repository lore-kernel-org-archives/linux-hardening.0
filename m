Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB114884E;
	Fri, 12 Jul 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774823; cv=none; b=o567Sy3+Cp33s23ciG3e1Sn3shk8D3/YlNzvwUota8nmuzgQ8PmEUrvEmFzylavNU0LPO8bbe8u4mjNaUvz50BOvNJrNCWRAFG+6nfyxSuDhwZGBkWI7epy/NFcbsHk2xvqxHmiXrt1Vh+rTIGNNEpWJ9RfgfTkOL/NEPLWpPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774823; c=relaxed/simple;
	bh=uxYO52ltdR2PNRJ6oSXEONigvyRNjnTBKwbjZQwPy+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJoNVcVDKEu77nwPjZZJVGiyoAajyYeEqvO3LMw1PJN5tFQ0eseQeItT1Q41ZC7KMvEfV45aQEivD8BEqtWI1IT7tNXNypgnLD6JwnukOTgGMoPW3HVlnaURyrHCSbeA2fdB9aKUGRm5s90J/nDd2UhGyp1PpbSZt4+X0B1SDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p6TLCviy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p6TLCviy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vIxJ9d7tmxDH2tQfYINrnWcP20UCiZxZZimj0EyFxIs=; b=p6TLCviySBKdIDFJzxXsnjUVVJ
	bv8DOoPPcHDB2D+0aKzFXVBtT25P3IDF72Lf4xs/8vb07qREVQabQY436Jxf7pmJ4GGoLdORzIkPk
	TFuTkS4WllYd7k6yXXn4uylaMWy8Fgtldp3f1rQKwMcF4UT3SH71WpzWdW8oYvpqVfFobF60C6q4L
	JI/m8a2CjJKq22iASmLkcAKg/mQnjMIgxcNFhmOviQ7oKesYhvK3DL/kuT+OsPlexsNFcY1Y9NzMe
	vYEVTrChnOkEnxm68jIyNEOKelMBXV2aOglMns/MpGLtaU46kYrWFZ3Rx4GRyUzZPIJEnePaBA/P7
	3tLEV0XQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSC8P-00000001GbO-1EGG;
	Fri, 12 Jul 2024 09:00:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AE4FC30050D; Fri, 12 Jul 2024 11:00:08 +0200 (CEST)
Date: Fri, 12 Jul 2024 11:00:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/syscall: Avoid memcpy() for ia32
 syscall_get_arguments()
Message-ID: <20240712090008.GA19796@noisy.programming.kicks-ass.net>
References: <20240708202202.work.477-kees@kernel.org>
 <20240711214450.GG27299@noisy.programming.kicks-ass.net>
 <202407111500.B86485B3@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407111500.B86485B3@keescook>

On Thu, Jul 11, 2024 at 04:10:43PM -0700, Kees Cook wrote:

> The long answer is long, and comes in two halves: the language half and
> the fortify half.
> 
> First, the C standard requires that all function argument arrays be
> decayed to pointers, so your prototype is semantically handled as if
> it were:
> 
> void syscall_get_arguments(struct pt_regs *regs, unsigned long *args)
> 
> The "6" is just totally thrown away by the language. :(

Bah. I mean, I understand why, they *are* pointers after all. But to
then also discard the object size is just silly. I mean, traditionally C
doesn't give a crap about object size -- it is irrelevant.

But with alias analysis (which we switch off) and doubly so with this
fortify stuff, you do care about it.

So why throw it out?

> *However* the compilers _will_ do things with it while generating
> diagnostics, but only from the caller's perspective (code _inside_
> has no awareness of the "6" unless the function has been inlined, sort
> of). For example:
> 
> 	unsigned long toosmall[4];
> 	...
> 	syscall_get_arguments(regs, toosmall);
> 
> Produces:
> 
> <source>:60:5: warning: 'syscall_get_arguments' accessing 48 bytes in a region of size 32 [-Wstringop-overflow=]
>    60 |     syscall_get_arguments(regs, toosmall);
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Makes sense.

> But syscall_get_arguments() internally has no idea what size "args" is:
> 
> void noinline syscall_get_arguments(struct pt_regs *regs, unsigned long args[6])
> {
> 	report(sizeof(args));
> 	report(__builtin_object_size(args, 1));
> 	report(__builtin_dynamic_object_size(args, 1));
>         memcpy(args, (typeof(args))&regs->bx, 6*sizeof(args[0]));
> }
> 
> Which reports 8, SIZE_MAX (unknown), and SIZE_MAX (unknown) respectively.

And that's just daft :/

> And the language is so busted about this that there is actually a
> diagnostic for "don't do that" that shows up with this code:
> 
> <source>: In function 'syscall_get_arguments':
> <source>:53:22: warning: 'sizeof' on array function parameter 'args' will return size of 'long unsigned int *' [-Wsizeof-array-argument]
>    53 |         report(sizeof(args));
>       |                      ^

:-( This just doesn't make sense. How can you be so inconsistent about
things.

What will actually break if you 'fix' this? Given that inlining (see
below) changes the rules willy nilly, I feel we can (and should!) just
fix this.

> _However_, if we _inline_ the function, suddenly _bos and _bdos know
> what's going on since they have visibility into the actual objection
> definition:
> 
> void inline syscall_get_arguments(struct pt_regs *regs, unsigned long args[6])

*sigh* yes ofcourse, inlineing in C is a mess, it really does change the
meaning of what you've written.

Combine this with the fact that 'inline' doesn't actually mean anything
much these days because the compiler will do whatever it feels like
anyway, and you've got a language that's like *really* hard to use.

Hence our noinline and __always_inline attributes to force it where we
need to.

> Now it reports 8, 32 (8 * the "toosmall" array size 4), 32 (same: _bdos
> falls back to _bos if there is no dynamic component). Note this is _not_
> 6, but 4, the actual object size.
> 
> Using the newer arg-sized array prototypes using a named argument _does_
> inform the internals, but that requires changing the calling convention
> for what is supposed to be a fixed size, and only behaves at runtime,
> which is just silly for compile-time fixed sizes. For example:
> 
> void noinline syscall_get_arguments(struct pt_regs *regs, int n, unsigned long args[n])
> ...
> 	syscall_get_arguments(regs, 6, toosmall);
> 
> Does report the expected things for _bdos internally (48), but not for
> sizeof (8) nor _bos (SIZE_MAX). Of course if we inline it, _bos starts
> working and, along with _bdos, realizes it was lied to, and reports
> 32 again.

WTF ?!?! How can all this be so inconsistent and why are people okay
with that?

> For the patch in this thread, the W=1 case was reported (overread of
> "bx"), because normally fortify would just ignore the overread of
> the source.

So I'm not entirely sure I agree with that argument. Yes, &regs->bx is
'unsigned long *' and sizeof(unsigned long) is 8 (if we assume 64bit).
However, you can also read it as the point of pt_regs where bx sits --
which is a far more sensible interpretation IMO.

Because then we're looking at struct pt_regs and an offset therein.

> Finally to answer your question about working around this case, _bos/_bdos
> will see right through the casting because it operates on the actual
> object behind it. (And casts to an array type are illegal too.)
> 
>     unsigned long args[6];
> 
>     report(__builtin_object_size((typeof(args))&regs->bx, 1));
> 
> <source>: In function 'show':
> <source>:76:34: error: cast specifies array type
>    76 |     report(__builtin_object_size((typeof(args))&regs->bx, 1));
>       |                                  ^
> 
> And a (char *) cast doesn't work: _bos(1) reports 8, the size of bx. Using
> locals doesn't help either:
> 
>     void *ptr = (void *)&regs->bx;
> 
>     report(__builtin_object_size(ptr, 1));
> 
> Still 8. And ultimately this is good, since fortify will see through to
> the actual object that could get overflowed, etc. It's the behavior we
> want for the overflow defense.

So really pt_regs *is* an array of unsigned long, and I feel it is
really unfortunate we cannot express this in a way that is more concise.

