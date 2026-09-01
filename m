Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7A471CE0;
	Tue,  1 Sep 2026 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249711; cv=none; b=c8sTXGYgJxK+RpGS1cJbZG5kvX07f608pYpEPBF5ykNAr0+WnAnY+kevu5X/ep9pyW6fPB9SdRc97UlzGyZv8FObSIZJ+qtsq16lu5GLeBiuxfKrMIvOqFgmaNoAA13GEzxptGexyzly5G6eXCQV5YGSgJUYh4My8aI1Ez1UP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249711; c=relaxed/simple;
	bh=9B6Wxdvw3xp5ld7hEtbbwEFIpm4K2FL2RhXsefID288=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mla5y7z1Op7953KiOEMNoRD48BWRUUQVz0RGYt8heBxbSeHQXW8o2i4xa2kUoKsV/7ybMeo3yZv0gYq92eISWvxnC6++lQs3TOVrqPMxZAJDpuTAmZ6RCq2wRrd5iI+wtf0RIsRlis2l/xZLA9vjIYJ1ZYBT8O3BfwU/s/78ggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4YYzm+vl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLPpUdCd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4YYzm+vl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLPpUdCd"
Date: Tue, 1 Sep 2026 10:01:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788249704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0pI8XTpNn+xxOYdAi7WHG2gkeeqcx1hUF85pJOp+GY=;
	b=4YYzm+vls8qdZmN6EGlklWzPcwnIuoEQVd3e5ESsC1adh0nXf0IqUqd73abgsshx0rOyQz
	an8E8ZD5tkzgQ3T4pvFBq0nwXk9ZGAIH+pvO918t1PphVnWxB3lFt14u7WIwldbxsgFx6x
	HQhO6W91ugFP+NqYfxGvU//WIV0o61+bSiAUV/+Q69fCJ5Q5rtaBQmVlNeKDoeCqvh4YGq
	kJwqgywKGvuLVl64VOFZzb5CQfGhisurtEQUEVtZ8aCc4ZE3xyP0rn8ejw3jgVYgOTZJDZ
	xsYb0u/drSSYfl467Sw9+A+bF35BOJdCuDO0NN0dIgZZbY952gTT6kauufjFiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788249704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0pI8XTpNn+xxOYdAi7WHG2gkeeqcx1hUF85pJOp+GY=;
	b=yLPpUdCdh4aRuH3xDYiA2EkjygI6oShXPQrWJ792XVzviGfc+PtQ6r4oOZT4Z9RjedP9AT
	5q6f7SnyIY32TbAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] kallsyms: Document why unresolved symbols are
 revealed
Message-ID: <20260901080142.CMTCw6vE@linutronix.de>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
 <20260821152614.2202196-3-bigeasy@linutronix.de>
 <ao8SeCCG65uwH-Tk@pathway.suse.cz>
 <20260827102411.NsziRXyJ@linutronix.de>
 <20260831133729.p5ylO7O6@linutronix.de>
 <20260831124928.22e163ab@gandalf.local.home>
 <apZ9ea1on8A7o6kk@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apZ9ea1on8A7o6kk@pathway.suse.cz>

On 2026-09-01 09:23:37 [+0200], Petr Mladek wrote:
> On Mon 2026-08-31 12:49:28, Steven Rostedt wrote:
> > On Mon, 31 Aug 2026 15:37:29 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> > > Could someone yell here, please? I convinced myself that hiding
> > > unresolved pointers is the good thing to do here since a "wrong" pointer
> > > would be seen in backtrace anyway.
> > > 
> > > Thread starts at
> > > 	https://lore.kernel.org/all/20260821152614.2202196-1-bigeasy@linutronix.de/
> > 
> > I wonder if we should just tagged hash values as such:
> > 
> > | [    1.498171]  <TASK>
> > | [    1.498172]  00000000cb9bc262 [hash]
> > | [    1.498174]  ? 00000000eb5021dd [hash]
> > | [    1.498176]  00000000ed1a9938 [hash]
> > | [    1.498178]  </TASK>
> > 
> > So that people will know that the value is just some random hash value and
> > not a real address.
> > 
> > Although rather useless in call stacks, I like hash values because the same
> > address will show up the same.
> > 
> > Having '[unknown]' may also be confusing because it doesn't really say
> > "why" it was unknown. But having a number goes back to what it always did.
> > Hashing it with a "[hash]" marker will also let people know the value was
> > hashed.
> 
> I like this idea. I just wonder whether it might confuse some parsers
> who expect that symbol name is one string. %ps, %pS, %pB are used
> in various context.
> 
> I think about adding the hint into the hashed value, e.g. by using
> 'h' instead of the highest number, something like:
> 
>  [    1.498171]  <TASK>
>  [    1.498172]  h0000000cb9bc262
>  [    1.498174]  ? h0000000eb5021dd
>  [    1.498176]  h0000000ed1a9938
>  [    1.498178]  </TASK>
> 
> But 'h' is not a valid number number so it might confuse parsers as
> well. And it is not that user friedly either.
> 
> So, I still like more Steven's variant with [hash].

While it does make sense to add [hash] to make it obvious it breaks
formatting for some of the %p users where %p is expected to have a fixed
length depending on 32/64 bit. Here, it is a %pS so adding extra it
wouldn't break anything but I don't think it should be different between
%p and %pS assuming we do print the hash instead 'unknown'.

> Best Regards,
> Petr

Sebastian
