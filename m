Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596938DE8
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235099; cv=none; b=Sl3DLZmcCve6QLLSiEK19n/30Gi13tD5KAEei/CXTT+tzvqgx7jkn4igVDSfXwqimmEBQKqsvyvPCt0J9xG8W9rjWsIMtb15Y+cQwsDWmj6qoBZ8ZHwHHMgzM4hZrQlYm+xbCm6nJMvP+d0sl2dBD4RzEHp2aiRv8fcGbv8tOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235099; c=relaxed/simple;
	bh=VSaW/apPlrArKcvmW8VTwX9WHVoo/UgeeO0M3uw7v94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeOW68vMq6Jfvwwysp29P4fjW8nEtU8OpKWONGHej5+gRDjrAWDJH9CjoaEeP4CB4PJNZr4HrkDkhKDayc9yBkAtroH/MSWFiMecsAXNYeH4C2UjkTbzQhznrXZZuS2uPqmIJa4rmSesOOKtfBISJhk9v3EyfcBXcex0PcmXZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gv009ieR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gv009ieR"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-61be599ab77so269424a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715235097; x=1715839897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0K8G3AglPkL2fIAqhVyBG1qXwEcXVUsVnaW1DyqOlQ=;
        b=Gv009ieRQ6JquxobBfTQDQeuvMRzJVzc2JVdAnAMNWTDN8fvsiYLkc9/YGDaMEYreF
         wsVF0rL8LQMDBd/Krp/C7/bTfgRj1ogmttb46gQjXmXNqsUeo7qCyjEwIEaw6BcAI/st
         heOZ0pznOdSOYIg+oXb67+pguZRZVxEOopFKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715235097; x=1715839897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0K8G3AglPkL2fIAqhVyBG1qXwEcXVUsVnaW1DyqOlQ=;
        b=wSoX8k57EriKJ8mRf4294DEVBH8PxrNIrJQNBYYLQR8dOterwvNHZ2gNZT9WFSPwuL
         oLjEY5w7oLS6LMpQYA1vfSWNlozrLn+t4evoH14k8j50YoMFLjcMSCnacxZEJBD0DjBB
         BlGnuiXqvozx/YhVSd8PnaY1RmtcE+JcwdcQ5G5CB9bCayUyG05T0cawTelIRYTp2qVk
         //PZTv4FjV+iJZbpmKLh1x4cbJ11M6UpH81JiSqwoSWHUcEpTQtRwawkcaPGyUPFVn06
         9SjjAhYPjkyMjq/NeAEBm2Yj+b1ww+4N7UGdMbpGz0pePqT0JJKhDxYy748ObWbTIpPj
         VW/g==
X-Forwarded-Encrypted: i=1; AJvYcCXG3CC5zYn0GbkQ4lE+h+q2ZPmpqxHZISfYWR5QM1DuiCSln1ET5udyEu8ljFBAQ0m3xO82iHGwKT63T1RQVHnV2VhyogsZZd9yFcwDpNM6
X-Gm-Message-State: AOJu0YxdyRd1RyMRekOznbuqL3HMLqZCUdyFoc+A7Vt+txEbClWkSvpZ
	8WjKHRqMTi7lXl0F5I7RerwBpBb4oiauLs0iVlXxjOWuNywmMlDDYqwwzqMbNg==
X-Google-Smtp-Source: AGHT+IHWnG8slcBCx8M7TXvghTiOSC/MA43D+v+CR+3pMR/oyw+4KROq/kc704i6kih9FsKtpDdP7g==
X-Received: by 2002:a05:6a21:4981:b0:1aa:6a28:cf6e with SMTP id adf61e73a8af0-1afc8dc6e23mr4710728637.48.1715235097166;
        Wed, 08 May 2024 23:11:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66c54sm594794b3a.40.2024.05.08.23.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:11:36 -0700 (PDT)
Date: Wed, 8 May 2024 23:11:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <202405081949.0565810E46@keescook>
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

Yes, the array bounds checking work has been going well. It's been
about 5 years now, plucking out all the weird compiler behaviors,
refactoring code to get rid of ambiguous patterns, etc. It's turtles
and compiler extensions all the way down. It's been a real education on
"this will be easy: the compiler already has all the information". Only
to find, no, it's not, because no one has tried to make any of it work
together sanely in 50 years. But we're finally at the tail end of it,
with clear and unambiguous semantics and mitigations now.

> So I'd suggest seeing if we can catch the cases that *technically*
> aren't UB, but match dangerous overflow situations. IOW, start with
> very limited and very targeted things to look out for.

Yes, exactly. What I'd said in the RFC was that from a terminology
perspective I don't want to focus on "undefined behavior", this means
a very specific thing to the compiler folks. I'm focused on what
_unexpected_ things actually happens in the real world that lead to
exploitable flaws.

> So *that* I feel could be something where you can warn without a ton
> of compiler smarts at all. If you see an *implicit* cast to unsigned
> and then the subsequent operations wraps around, it's probably worth
> being a lot more worried about.

I agree, implicit casts are worth exploring. It's a more limited set of
behaviors, but I remain skeptical about the utility of catching them since
the visibility of those kinds of promotions can quickly go out of scope.

> And basically try to catch cases where arithmetic is explicitly used
> for a size calculation: things like 'kmalloc()' etc are the obvious
> things. And yes, the result will then have an (implicit) cast to
> 'size_t' as part of the calling convention.

We've been doing this kind of static analysis of allocation size
mistakes for a while, but it remains not very well introspected by the
compiler, making it a long game of whack-a-mole. And generally speaking
all the wrapping around has already happened way before it hits the
allocator. We've mostly dealt with all the low hanging code pattern fruit
in this area, but it could be a place to add type-based compiler smarts.

> And, finally, simply pointer arithmetic. Again, this is *not* some
> "omniscience required". This is something very obvious where the
> compiler is *very* aware of it being pointer arithmetic, because
> pointer arithmetic has that implicit (and important) "take size of
> object into account".

Yes, that is already in progress too. Now that we've got __counted_by for
flex arrays, the next addition is __counted_by for pointers. Coverage
there will continue to grow. There is, unfortunately, a rather lot of
alloc-and-forget going on in the kernel where object sizes are just
thrown away. We've done some refactoring in places to add it, but I
suspect the need for that will become more common once we gain coverage
for pointer offsets.

> So again, if you see an integer expression that leads to pointer
> arithmetic, at that point the overflow very much is relevant.

Right, and we've already been doing all of these things. They do all share
the common root cause, though: unexpected wrap-around. But I hear you:
don't go after the root cause, find high-signal things that are close to
it.

> So what I object to - loudly - is some completely bogus argument of
> "integer wraparound is always wrong".

Just so it's not mistaken, I didn't say "always": I said "can be". This
was never a proposal to outlaw all wrap-around. :P

> But catching wrap-around in *specific* cases, if you can argue for why
> it's wrong in *those* cases: that sounds fine.

Right. I mean, that is basically what I proposed. It was just over a
much larger class than it seems you'll tolerate. :P You're asking to keep
the scope smaller, and aimed at places where we know it can go wrong. I
still think this is backwards from what would be best coverage. For the
highest level of flaw mitigation, we want to exclude that which is proven
safe, not try to catch things that might be unsafe. But I do try to be
pragmatic, and it doesn't sound like that approach will be accepted here.

> So in *that* case, you actually have a much more interesting
> situation. Not wrap-around, not overflow, but "implicit cast drops
> significant bits".

Yup! This is what I was talking about in the RFC: implicit integer
truncation. It *is* very nasty, I agree. We can get started on this next
then. I poked around at it earlier this year[1]. My plan was to tackle
it after finishing signed integer overflows (which is well underway).

> And yes, I do think implicit integer casts are dangerous. Often *more*
> dangerous than arithmetic overflow and wrapping. We've had absolutely
> tons of them. Some of our most traditional bugs have very much been
> about implicit casting losing bits and causing problems as a result.

I really started screaming when I saw this one:

https://git.kernel.org/linus/6311071a056272e1e761de8d0305e87cc566f734

	u8 num_elems = 0;
	...
	nla_for_each_nested(nl_elems, attrs, rem_elems)
		num_elems++; /* Whoops */

	elems = kzalloc(struct_size(elems, elem, num_elems), GFP_KERNEL);
	...
	nla_for_each_nested(nl_elems, attrs, rem_elems) {
		elems->elem[i].data = nla_data(nl_elems);
	        ...

(The good news for this particular case is that the fix for this bug
almost literally crossed paths with the wave of __counted_by annotations
we landed[2], after which overflows of the elems->elem[] array would
have been noticed by CONFIG_UBSAN_BOUNDS.)

> I think that would be a completely different area that might be worth
> looking at: instrumenting implicit casts for "drops bits". I'm afraid
> that it's just *so* common than we might not be able to do that
> sanely.

During the initial investigation, I tripped over several idioms we'll
need to deal with (possibly in the compiler). (2 are basically variations
of ones from the overflow calculation cases.)

- truncation of constant expressions:
	u8 var = ~(1 << 3);
  This becomes int, and then all the high bits are thrown away. But
  intention is nearly universally that the expression should be
  applied only to the variable width. i.e. what is meant is:
	u8 var = (u8)~(1 << 3);
  Allowing this from the compiler side makes sense since it's a constant
  expression. There may be cases where it is NOT intended, though, if
  there is some mismatch of type widths hiding in macros that resolve
  to a constant expression. But refactoring all these instances to
  include an explicit cast seems prone to inducing maintainer rage.

- basically all cases where the assigned variable is smaller than u32:
	...checksum(const u8 *buf, u8 len)
		...
		u8 sum;
 		int a;

		for (a = 0; a < len; a++)
			sum += buf[a];

	buf[a] goes from u8 to int, then added to a u8 value (no
	overflow), but then written back and truncated.

	This gets immediately to the ambiguity case, though. This is
	nearly indistinguishable from the "num_elems++" example above.

	So what do we do? We can add the "wraps" attribute to "sum"?
	We can use a helper for the "+="?

	Or even just simple math between u8s:

	while (xas->xa_offset == 255) {
		xas->xa_offset = xas->xa_node->offset - 1;

	Is it expecting to wrap (truncate)? How is it distinguished from
	the "num_elems++" case?

- "while (var--)" when var is a smaller type than u32: the final
  post-decrement gets truncated from the promoted "0 - 1" int expression.
	Ignore post decrements only when the variable is not read again?
	Ignore it only in "while" cases?

- ERR_PTR() returns long. But all cases of its assignment are into int
  variables. I need to spend more time looking at this. There
  shouldn't be any loss of information here, since it's all low negative
  values. The sanitizer may be upset that 0xffffffffffffffff being
  converted to 0xffffffff is "losing bits" but they're both just -1.
  We might also just be able to change ERR_PTR() to return int, and add
  the cast directly:
	-	return (long) ptr;
	+	return (int)(long) ptr;


>[...thread merge...]
> I think it would be interesting in general to have some kind of
> warning for "implicit cast drops bits".
> 
> I fear that we'd have an enormous about of them, and maybe they'd be
> unsolvable without making the code *much* uglier (and sometimes the
> fix might be to add an explicit cast to document intentionally dropped
> bits, but explicit casts have their own issues).

This is immediately the place we find ourselves. :)

> So that's why I feel like it might be interesting to see if limiting
> such checks to only "unusual" types might give us a manageable list of
> worrisome places.

Well, we'd want to catch the "num_elems++" case, and that's not
involving any unusual types. How do you propose we distinguish that from
the u8 checksum case, etc? I had been planning to use the "wraps"
attribute on the variable. I.e. mark all the places where we expect
truncation.

>[...thread merge...]
> I still suspect the "implicit truncating cast at assignment" is likely
> a much more common case of loss of information than actual arithmetic
> wrap-around, but clearly the two have commonalities.

Both of the "real world" examples we had in this thread were due
to implicit truncation. I do think it's less noisy than the unsigned
arithmetic cases, but it does have significant commonalities. So much so
that it still looks to me like using the "wraps" attribute makes sense
for this.

> Summary: targeted baby steps, not some draconian "wrap-around is wrong".

I still think we should bite the bullet, but let's finish up signed
overflow (this just keeps finding accidental but mostly harmless
overflows), and then dig into implicit integer truncation next.

Thank you for spending the time to look at all of this. It's a big topic
that many people feel very strongly about, so it's good to get some
"approved" direction on it. :)

-Kees

[1] These are NOT meant to be upstreamed as-is. We have idiom exclusions
    to deal with, etc, but here's the tree I haven't refreshed yet:
    https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=dev/v6.8-rc2/signed-trunc-sanitizer

[2] c14679d7005a ("wifi: cfg80211: Annotate struct cfg80211_mbssid_elems with __counted_by")

-- 
Kees Cook
