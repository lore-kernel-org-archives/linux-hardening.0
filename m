Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC88413BAC4;
	Mon, 15 Jul 2024 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032655; cv=none; b=b3bbt68hyOw6Tr1PUykmGAEWCuuO1RWhmNAWGS0wJF2v0fnE+L3S+snfEdt7OfO15SWmZIVJhOKCtONo3YJDd7RZT9UHDQcV0PKkr7SAgcHVJZOhqTLEFGMcKopKyyoWavO826VZ1OubDwGbTVF4tCvsyNxklnUeIrL1qN2APII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032655; c=relaxed/simple;
	bh=6a47WPAIRfycPuOXAWxzW6xF3377lHud2VcJBGbtAZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipUQUmkgwDq9LpFtKtghTfh4mhLO1Kki1kb+/PBxa+YnzP7nYroARyt2AWK2efS59w3r7LwBnb/LMUdXTCpzSIKlY77tikGf+2MSwyz2Kr6GBR+DxdwB/PMcDmsb81/f/FE1mn3QK/foONfLPe63zRamjBCRC3FhV9VNi7AyFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MAvEBGFk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MAvEBGFk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P3XQdNXvKucQfzbIesbDHM6Ks3Dxta1uhheNQVnB0gk=; b=MAvEBGFkB2t3GlMRTwZWFx5kWi
	TuAbQxtjubFI2vJbTagxDOaCQHc4ocf9RSMnlO6a9uo0oA1y4TpZ03G2HiWtyRdtLnsODJLEVij2J
	eMztHpz7GkpTvku8+GxHopbarVGApOC/QUGy41kSH5u91GLCAimg6LAQPX1okHTOjdXfNUmyG7nrG
	YWM5+xegfAjiyvfp0fkKl2MMtGaKUvP64rnizJwF07zHyXAA+BvUdTRMwNLSIHI99mm8HMzEzvv+Q
	3djM7Zuxs/c0juhXRtrE80+5QrlDc4mjX+YUWlDb7HV0n4z8sKusUMfjMffR/ON5Pn5u4+6RkSXmg
	QYa01LFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTHCt-0000000FZm3-1McC;
	Mon, 15 Jul 2024 08:37:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 283BD3003FF; Mon, 15 Jul 2024 10:37:13 +0200 (CEST)
Date: Mon, 15 Jul 2024 10:37:13 +0200
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
Message-ID: <20240715083713.GX27299@noisy.programming.kicks-ass.net>
References: <20240708202202.work.477-kees@kernel.org>
 <20240711214450.GG27299@noisy.programming.kicks-ass.net>
 <202407111500.B86485B3@keescook>
 <20240712090008.GA19796@noisy.programming.kicks-ass.net>
 <202407121008.EDAD65A33@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407121008.EDAD65A33@keescook>

On Fri, Jul 12, 2024 at 10:55:16AM -0700, Kees Cook wrote:

> > What will actually break if you 'fix' this? Given that inlining (see
> > below) changes the rules willy nilly, I feel we can (and should!) just
> > fix this.
> 
> I'm not sure -- I have kind of given up on "standard" C helping with any
> of this. I look to consistent language extensions now, and where there
> isn't any, we've been trying to create them. :P 

Yeah, arguing a committee is mostly a waste of time, also, they
typically listen a lot more when you say, here these two compilers have
implemented it and this Linux thing uses it.

So yeah, language extensions are it.

> And we're not alone:
> Apple's -fbounds-safety stuff[1] looks good too, and overlaps with what
> we were already designing with the "counted_by" attribute:
> https://discourse.llvm.org/t/rfc-enforcing-bounds-safety-in-c-fbounds-safety/
> (We borrowed the "counted_by" name, which is better than what we were
> calling it: "element_count".)

Yep, I read that a while back. I think you referenced it in one of them
other threads where we disagreed over struct_size() :-)

> > > Does report the expected things for _bdos internally (48), but not for
> > > sizeof (8) nor _bos (SIZE_MAX). Of course if we inline it, _bos starts
> > > working and, along with _bdos, realizes it was lied to, and reports
> > > 32 again.
> > 
> > WTF ?!?! How can all this be so inconsistent and why are people okay
> > with that?
> 
> This. A thousands times, this. I'm really not okay with it, and we've
> been working to get rid of every ambiguity we trip over. It's made sane
> bounds checking in Linux extremely hard to get right.

Yeah, not just Linux I imagine. The rules are so insane it's near
useless. I'd say press onwards with the language extension, it's not
like Linux kernel is written in ANSI/ISO C anyway :-)

> For more fun with array bounds, the one that absolutely floored me was
> the exception over trailing arrays:
> 
> struct middle_t {
> 	u8 array[6];
> 	int foo;
> } *middle;
> 
> __builtin_object_size(middle->array, 1)  ==  6
> 
> struct trailing_t {
> 	int foo;
> 	u8 array[6];
> } *trailing;
> 
> __builtin_object_size(trailing->array, 1)  ==  SIZE_MAX ("unknown")

WTF :-)

> > So I'm not entirely sure I agree with that argument. Yes, &regs->bx is
> > 'unsigned long *' and sizeof(unsigned long) is 8 (if we assume 64bit).
> > However, you can also read it as the point of pt_regs where bx sits --
> > which is a far more sensible interpretation IMO.
> > 
> > Because then we're looking at struct pt_regs and an offset therein.
> 
> Right -- the way to make this unambiguous has been to make sure there
> is an addressable object which contains the elements in question. For
> the least disruption, the best we were able to do is introduce the
> struct_group() helper. It's internally ugly, but it works.

That macro is fairly trivial, nowhere near as ugly as struct_size() :-)
But urgh... can't we do something like:

void *memcpy_off(void *dst, const void *src, size_t off, size_t n)
{
	memcpu(dst, src+off, n);
	return dst;
}

And then you can write:

  memcpy_off(args, regs, offsetof(*regs, bx), 6);

I mean, that sucks, but possilby less than struct_group() does.

[ also, we should probably do:
  #defime offsetof(t, m) __builtin_offsetof(typeof(t), m) ]

> > So really pt_regs *is* an array of unsigned long, and I feel it is
> > really unfortunate we cannot express this in a way that is more concise.
> 
> A way to do this would be:
> 
> struct pt_regs {
> 	union {
> 		struct {
> 			unsigned long bx;
> 			unsigned long cx;
> 			unsigned long dx;
> 			unsigned long si;
> 			unsigned long di;
> 			unsigned long bp;
> 		};
> 		unsigned long syscall_regs[6];
> 	};
> 	unsigned long ax;
> 	...
> };
> 
> Now regs->syscall_regs is addressable, sized, etc. "bx" means just bx,
> and "syscall_regs" means all 6.

In this case I would just make all of pt_regs a union with one giant
array (much like some archs already have IIRC).

> I wrote up a bunch of notes about much of this horror last year here:
> https://people.kernel.org/kees/bounded-flexible-arrays-in-c

Oh, yeah, I think I saw that fly by on hackernews a while ago.

