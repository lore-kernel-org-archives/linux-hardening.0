Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261613FFC;
	Fri, 12 Jul 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806917; cv=none; b=g4Z/uJDU4irJMcavPMRvS+oqER58ZRD4sUtJJUPyzMxDDnjdBuEaN1ONPdV/OH9gJ+pxtxS9SjgATTEPcJeGTOuZdp/Qq8NCuZEasa0gu6vjxKZq/y2ioRiH6RrLWnDuJ85Gp9WQveBdikL6c3Pm6uGSiEUVzxDJIZgsZ7J6YuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806917; c=relaxed/simple;
	bh=FHmrHzxibyVk/KILfp/j7tI5EEgd1xbMGwm/W572nA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyLW9nF6fp3HV5MFEW5EDMKRsME2FeBMQMuoqxN4ZSBN/Z7FYOE0xK6Onqo8yyNFP7DKJYKG3x4lfVmYJ0lRKv1pS2a6yrPtaEy/scOmjepLtUvermSyvPcC/hpdYKgmGJPTy03sQ2cbQNHLfjOcPnoTSAuA9bLLJpwugcJnVko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZDDAmUp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZDDAmUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EFCC32782;
	Fri, 12 Jul 2024 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720806916;
	bh=FHmrHzxibyVk/KILfp/j7tI5EEgd1xbMGwm/W572nA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZDDAmUpXuofN+3Z45Tqo6EtIdqOqC/L4ukoMhmvCL0CxXimnqM6WmXjUyNduXQ6n
	 kMQ5Hn3s1Xrmgl4+eedTssm59E/LX+GZ7dIB3T8UuBNBGpNSmOVm88Suc8Qrxt1AWE
	 GZq4rWoesFvIGr07p1i5v2n2F+dVS9mfRaMl/Mh2MA6Q4zJh9ncE39F5Vq/RutF7ut
	 8D1+SXwSm8qYfur8N0rO11xxSqUXAywNWQf53r3Pgs3hV1QhipQau/nprcWJMj3DZl
	 gnM59foLi1cp4jHWpkEoLwOjJwNJxgIiNZ3j/+Xwkmy41PbYujvs8czIrcAqcE4Xbv
	 8twVI11Sgrlkg==
Date: Fri, 12 Jul 2024 10:55:16 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <202407121008.EDAD65A33@keescook>
References: <20240708202202.work.477-kees@kernel.org>
 <20240711214450.GG27299@noisy.programming.kicks-ass.net>
 <202407111500.B86485B3@keescook>
 <20240712090008.GA19796@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712090008.GA19796@noisy.programming.kicks-ass.net>

On Fri, Jul 12, 2024 at 11:00:08AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 11, 2024 at 04:10:43PM -0700, Kees Cook wrote:
> 
> > The long answer is long, and comes in two halves: the language half and
> > the fortify half.
> > 
> > First, the C standard requires that all function argument arrays be
> > decayed to pointers, so your prototype is semantically handled as if
> > it were:
> > 
> > void syscall_get_arguments(struct pt_regs *regs, unsigned long *args)
> > 
> > The "6" is just totally thrown away by the language. :(
> 
> Bah. I mean, I understand why, they *are* pointers after all. But to
> then also discard the object size is just silly. I mean, traditionally C
> doesn't give a crap about object size -- it is irrelevant.
> 
> But with alias analysis (which we switch off) and doubly so with this
> fortify stuff, you do care about it.
> 
> So why throw it out?

Yes, it boggles the mind. And for a language that doesn't care about
size, it sure cares about size in weird places.

> > And the language is so busted about this that there is actually a
> > diagnostic for "don't do that" that shows up with this code:
> > 
> > <source>: In function 'syscall_get_arguments':
> > <source>:53:22: warning: 'sizeof' on array function parameter 'args' will return size of 'long unsigned int *' [-Wsizeof-array-argument]
> >    53 |         report(sizeof(args));
> >       |                      ^
> 
> :-( This just doesn't make sense. How can you be so inconsistent about
> things.
> 
> What will actually break if you 'fix' this? Given that inlining (see
> below) changes the rules willy nilly, I feel we can (and should!) just
> fix this.

I'm not sure -- I have kind of given up on "standard" C helping with any
of this. I look to consistent language extensions now, and where there
isn't any, we've been trying to create them. :P And we're not alone:
Apple's -fbounds-safety stuff[1] looks good too, and overlaps with what
we were already designing with the "counted_by" attribute:
https://discourse.llvm.org/t/rfc-enforcing-bounds-safety-in-c-fbounds-safety/
(We borrowed the "counted_by" name, which is better than what we were
calling it: "element_count".)

> > Does report the expected things for _bdos internally (48), but not for
> > sizeof (8) nor _bos (SIZE_MAX). Of course if we inline it, _bos starts
> > working and, along with _bdos, realizes it was lied to, and reports
> > 32 again.
> 
> WTF ?!?! How can all this be so inconsistent and why are people okay
> with that?

This. A thousands times, this. I'm really not okay with it, and we've
been working to get rid of every ambiguity we trip over. It's made sane
bounds checking in Linux extremely hard to get right.

For more fun with array bounds, the one that absolutely floored me was
the exception over trailing arrays:

struct middle_t {
	u8 array[6];
	int foo;
} *middle;

__builtin_object_size(middle->array, 1)  ==  6

struct trailing_t {
	int foo;
	u8 array[6];
} *trailing;

__builtin_object_size(trailing->array, 1)  ==  SIZE_MAX ("unknown")

Because of all the fake flexible array abuses over decades, _bos/_bdos
were forced to _ignore_ the size of an array if it was the last member
of a struct. But after C99 flexible arrays were introduced (24 years
ago), nobody cleaned this up! We had to go get the compilers to create
-fstrict-flex-arrays=3 so that all those weird behaviors would go away:
https://git.kernel.org/linus/df8fc4e934c12b906d08050d7779f292b9c5c6b5

> > For the patch in this thread, the W=1 case was reported (overread of
> > "bx"), because normally fortify would just ignore the overread of
> > the source.
> 
> So I'm not entirely sure I agree with that argument. Yes, &regs->bx is
> 'unsigned long *' and sizeof(unsigned long) is 8 (if we assume 64bit).
> However, you can also read it as the point of pt_regs where bx sits --
> which is a far more sensible interpretation IMO.
> 
> Because then we're looking at struct pt_regs and an offset therein.

Right -- the way to make this unambiguous has been to make sure there
is an addressable object which contains the elements in question. For
the least disruption, the best we were able to do is introduce the
struct_group() helper. It's internally ugly, but it works.

> So really pt_regs *is* an array of unsigned long, and I feel it is
> really unfortunate we cannot express this in a way that is more concise.

A way to do this would be:

struct pt_regs {
	union {
		struct {
			unsigned long bx;
			unsigned long cx;
			unsigned long dx;
			unsigned long si;
			unsigned long di;
			unsigned long bp;
		};
		unsigned long syscall_regs[6];
	};
	unsigned long ax;
	...
};

Now regs->syscall_regs is addressable, sized, etc. "bx" means just bx,
and "syscall_regs" means all 6.

I wrote up a bunch of notes about much of this horror last year here:
https://people.kernel.org/kees/bounded-flexible-arrays-in-c

-Kees

-- 
Kees Cook
