Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B17C0A1
	for <linux-hardening@vger.kernel.org>; Tue,  7 May 2024 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124473; cv=none; b=IV01rJYtTDJfJGCJyajVIfaVB0xihlJVcq8m3unQBSPqCRDfcSGJuX5kFEW8G4B6uXDfzqLNSjVxa6uZm8tIHIIZ/Q2+26XWP+04OADdsyickeV/M7pZxbIOuZb/pZsaWyhsopDvgnWCMFLx15y27WaMyWtYEXlfY/gCUBWRQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124473; c=relaxed/simple;
	bh=QrC2XTjhaFqvIYFUQMLZeQ+wwdKsLry8CdwZ1QDrvhk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eGav9iqIR3sJBqB8DEHt9XBE0jfwEFswpiqmWB0PbUptzGuf8Xi7aagEvFqTC1m2ZmCC86i+sWo8zxIyR89PSBH0Wbx5fZ1rWTCb3tbDmwGFXWLkcaZM/DqjBQdWVweF0uEhfPmrI73wi23vlno4vGg+AfGWMZ/RkDWVyFdTY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=duUZC6JR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="duUZC6JR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso26342365ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 07 May 2024 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715124470; x=1715729270; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLWEXjMZK05OdzWWn6dfRHIshRQNB3cz4ZxogUVoyI0=;
        b=duUZC6JRW+uNEhPXpbkf0swf+XNyhhE+8zIWGADo30bEzkGZL13yRD8snKkoRvkcLa
         VeOoIaa+iIBXa+UW7P0WWdgFVwyxRob/AIdD0Fupb2KsUD8mwYfXob77MA6ksgFCJPss
         Q8TNgGEWr9zcsKF5Qq6baYJoiF3n50E9Th2oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715124470; x=1715729270;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLWEXjMZK05OdzWWn6dfRHIshRQNB3cz4ZxogUVoyI0=;
        b=c68+3N7JqxQU66EqvYh1tsMGCJXQGfB+K5Jn3Usd8GLiwo8J2bXJPO2rGUbPe3MPgm
         CXfeWICxIACjmnUNwksQODr1ymKqwCirwfksdqnfmHHwypA7k08P9Y07ANutvmqDgwmY
         SqJrcuVmf5ZzamPDvNCc3+VtzDyF+80EWyXkJm/Lo0YDQf0PSx3zPZ5jFcNPzSom46Qg
         4CViLevFPA2nmeEE5EHIGvMdSvWsZZt+i4J29AAyH2n+UTfL35drb6dKdhEg1FFQoNgQ
         8uPE8fmYXk5/6Vy4CP8fdTxntPdXaHJ2ZUKidDPGrar3IFkhG+YbLZexBS8OeNOLqtTT
         twZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7haF3RU0pduq7a68DG+1OqXuTIpm2BEGLggNUTxxcFaCUWIoi+zfUR6vQ6Av19bqbd/XBFWDwxTZZCLIAhulwau/ESMz2o8SV78AQocpO
X-Gm-Message-State: AOJu0YyACzx8fveI9Lf5/ckBdMmcBKJPc6waCHYyGABEDeTRMhVr4bkF
	mSnB+QUZZL/BhaZLfT6ywymgvbAyxHbVenbY5ebMbKcxAekROPvrvOQr/KOLuYu7Ud/MOY7E7VE
	=
X-Google-Smtp-Source: AGHT+IHFl7rD94B/E5UxGvSKpBCTcyP5G60ZMyyC7CakBf3DE7hFWqFKhv2WIEHzdRnuTsR5ELP4CQ==
X-Received: by 2002:a17:903:2303:b0:1ec:b6e2:da89 with SMTP id d9443c01a7336-1eeb0993064mr13723955ad.61.1715124469860;
        Tue, 07 May 2024 16:27:49 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903121200b001eb03a2bb0asm10518113plh.53.2024.05.07.16.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 16:27:49 -0700 (PDT)
Date: Tue, 7 May 2024 16:27:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <202404291502.612E0A10@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Over the last decade or so, our work hardening against weaknesses
in various kernel APIs and eliminating the ambiguities in C language
semantics have traditionally been somewhat off in one corner or another
of the Linux codebase. This topic is going to be much different as
it is ultimately about the C type system, which is rather front and
center. So, hold on to your hats while I try to explain what's desired
here. Please try to reserve judgement until the end; as we've explored
the topic we've found a lot of nuances, which I've tried to touch on
below. I'm hoping folks can have an open mind about all this and not
jump to any conclusions without first hearing me out. :)


Problem to Solve
================
The Linux kernel has consistently suffered from unexpected arithmetic
overflow bugs. These lead to any number of exploitable conditions[0].
Our continuing efforts to improve things (refcount_t, alloc_size(),
etc) have helped in some specific areas, but on the whole, we've had a
relatively unchanged count of serious arithmetic overflow flaws over the
life of the project[1]. This is not tolerable, and we should, all of us,
make the effort needed to put an end to it in a systematic way.


Terminology Considerations
==========================
When I say "overflow", I mean "overflow and underflow", but more
specifically I mean "wrap-around". This is not about "undefined
behavior". We already demand from our compilers that all our arithmetic
uses a well-defined overflow resolution strategy; overflow results in
wrap-around (thanks to "-fno-strict-overflow").


Root Cause Analysis
===================
The condition we need to catch is the case of unexpected wrap-around. We
have plenty of places in the kernel where we _expect_ wrap-around,
and many places in the kernel where we attempt to _manually check_
for wrap-around. What is not covered are the cases where a check is
missing or poorly implemented. Some of the more insidious bugs come from
places where assumptions about the possible value ranges of variables are
wrong, or got changed, or were never considered in the first place. But
fundamentally the exceptional condition is the wrap-around: most bounds
checks associated with a given calculation are prepared for a non-wrapping
value range. Having a calculation wrap-around is what ends up knocking
the rest of the logic on its head.

This is what is meant through-out by "ambiguous": the _intent of the
author_ can be ambiguous as it relates to whether a calculation is
meant to wrap-around. That it wraps around on overflow is not ambiguous:
it will wrap-around. :) See "Terminology Considerations".

This is the corner stone of the problem: even though the behavior of
overflow is well-defined, so many authors so often don't correctly handle
it that the results threaten the integrity of Linux as a whole. C makes
it too easy to get it wrong, so we are left needing to fix this at a
fundamental level. This is not a developer education problem; it is a
problem with C language semantics. "Just do it correctly" has not worked.


Mitigation Considerations
=========================
When making large scale changes to Linux where we're adding a check
that didn't exist before, we must not break the old behavior as we're
migrating to a new behavior/expectation. This has served us well
across many hardening transitions we've made. Most recently this has
been exemplified by the array bounds checking, where new checks are
effectively phased in as a WARN[2], and once they've had sufficient
bake time (usually measured in years), the check becomes more strongly
enforced. All the while, there is a steady stream of refactoring going
on to adopt the new behavior/pattern.


Coverage Considerations
=======================
Just like any other kind of filtering, coverage for an exceptional
state is best done with an allowlist, not a blocklist. Using a blocklist
requires one to know _in advance_ which instances need to be caught. As
mentioned above, we've spent decades proving we don't adequately know
where we need to catch overflows. Therefore, we need to take an allowlist
approach: we must identify the places where wrap-around _is_ expected,
so that what remains is where it is _not_ expected. That which has not
yet been identified therefore remains suspect, and we can incrementally
grow the allowlist, since any not-yet-identified false positives will
not break any existing behaviors (see "Mitigation Considerations").

All of our hardening efforts have tried to follow this allowlist
approach. Early on, one of the times we didn't do it was with
refcount_t. We created a separate type to catch the overflow state and
used it where we thought things might go wrong. This turned out to be
a mistake: we've had a long tail of atomic_t overflows that turned into
real bugs that would have been caught had we detected atomic_t overflows
by default and instead created a separate type for the atomic_t cases
that were meant to wrap around.

The integer overflow situation is, as you may observe, very similar to
the atomic_t situation, and so we must make sure we don't repeat the
same mistake here. (Though just as an example about different overflow
resolution strategies, it's worth noting that the major difference with
atomic_t was that the desired strategy was saturation, not wrap-around.)


Language Considerations
=======================
C has no formal exception handling system, and standard arithmetic was
never designed to "fail". This is similar to the many problematic Standard
C Library routines (e.g. memcpy), which were also never designed to
have a "failure" case. This puts us in the uncomfortable (but familiar)
situation where overflow mitigation becomes all-or-nothing, and this
is what informs the approach detailed in Mitigation Considerations:
warn but allow wrap-around until we find all false positives.

The lack of unambiguous arithmetic intent in C has been recognized and
addressed in more modern languages[3], but we're faced with needing to
solve it in C, for Linux, today. As it happens, this is actually already
starting to come up in other areas[4] now that we're trying to interface
Rust with Linux's C internals. Being able to unambiguously describe
wrapping vs non-wrapping expectations will stop an entire class of flaws,
but will also help with the continuing Rust integration.

C has no operator overloading, and the only practical way to change types
is via attributes, which is additive in nature. Whatever the solution,
we'll need to create new wrapping types that are separate from the
existing types (as per Coverage Considerations), and the existing types
will become the non-wrapping types.

C also performs implicit integer promotion and implicit integer
truncation, so things that look like they would overflow don't overflow
until they get stored. For example: in "u8 var=255; ...; var++;"
during what is "var = var + 1", the "var + 1" part doesn't overflow
because it has been promoted to "int", which happily holds "256" without
overflow. But the resulting "var = 256" gets truncated to 0 (effectively
wrapping around). So to properly mitigate integer overflows in C, we
must deal with both overflowing calculations and truncated assignments.


Codebase Considerations
=======================
It's become clear from our investigatory efforts with arithmetic overflow
mitigation that Linux has very few intentional overflows involving
signed calculations. These overflows tend to either be legitimate bugs
(many harmless), or are using an signed type when an unsigned type was
intended (e.g. expecting to operate above INT_MAX, and possibly
expecting wrap-around).

For unsigned calculations, though, many places are expecting to be
wrapping (hashes, counters, etc). As a result, there will be much more
work involved to deal with unsigned calculations, but these are _also_ the
calculations that have led to most of our wrap-around flaws (e.g. sizes,
indexes, etc).


Practical Considerations
========================
While simultaneously taking into account Mitigation, Coverage, Language,
and Codebase Considerations, we must additionally continue to be able
to build Linux with multiple version of GCC and Clang; we must remain
"backward compatible" with our existing toolchains. We need to be able
to make changes incrementally; the proven successful development strategy
of Linux generally. We cannot have a "flag day".


Potential Solution #1: Use sanitizers
=====================================
There already exists, for both GCC[5] and Clang, several sanitizers that
were created specifically for handling integer overflow (and implicit
truncation, the fun sibling to integer overflow[6]). These, today,
already handle the unexpected overflow conditions we need to catch.

Needed on compiler side:
- create attribute that can be applied to typedefs and variable
  definitions to indicate "expected to wrap" types. (Clang has this
  at the ready[7].)
- allow for common idioms to bypass sanitizers:
  - explicit wrap-around tests: if (var + offset < var)
  - loop iterator wrap-around during post-decrement: while (var--)
  - negative unsigned constants: -1UL

Needed on Linux side:
- create "expected to wrap" typedefs
- replace all expected-to-wrap variables with their appropriate wrapping
  type over the next several years (yes, there's a lot)

Changes to binary when mitigation is enabled:
- All cases where non-wrapping types may overflow gain instrumentation
  that checks for wrap-around and when found call (via cold branch) to
  the sanitizer handler, and then continue on (if so configured).

Example:

    #define __wraps __attribute__((__wraps__))
    typedef unsigned int __wraps u32_wrap;
    ...
    u16 area;
    u32_wrap crc;
    ...
    area = x * y;	/* Sanitizer will check for overflow. */
    ...
    crc += word;	/* Wrap-around ignored by sanitizer */
    ...

Pros:
- Much of the compiler work is done
- Sanitizer semantics are well defined
- Binary changes are well understood (other sanitizers have been in
  production use for several years now)
- Bootable proof of concept already exists[8]


Potential Solution #2: Operator overloading
===========================================
Among some recent[9] C standards proposals was "Operator Overloading
Without Name Mangling"[10]. This could allow for the redefinition of
the basic arithmetic operators, overloaded via small static inline
helpers. This could allow for arbitrary handling of overflows within
those helpers, using typedefs to distinguish the wrapping types.

Needed on compiler side:
- Actually implement it
- Handle all the idioms from solution #1 somehow, but without a clear
  way to approach it

Needed on Linux side:
- create "expected to wrap" typedefs
- create operator overflow functions
- implement exception handling
- replace all expected-to-wrap variables over the next several years

Changes to binary when mitigation is enabled:
- Unknown, but in theory similar to solution #1, though impact of redefining
  all arithmetic in terms of static inlines is unclear.

Example (in theory -- semantics aren't fully defined yet):

	int int_mul_int(int a, int b)
	{
		int result;
		if (__builtin_mul_overflow(a, b, &result))
			__builtin_trap();
		return result;
	}
	_Operator * int_mul_int;

	typedef int int_wrap;
	int int_mul_int_wrap(int_wrap a, int b)
	{
		return a * b;
	}
	_Operator * int_wrap_eq_int_mul_int;

	int area = x * y;	  /* Traps on overflow */
	...
	int_wrap counter = x;
	counter = counter * y;	  /* Wraps around */

Pros:
- Flexibility of overflow resolution strategy (though this is currently
  a non-goal)

Cons:
- Semantics not fully defined
- Amount of compiler work needed is unknown
- More work on the Linux side than solution #1
- May not handle implicit integer truncation
- Unknown impact on binary output (e.g. does the compiler handle composing
  the overloaded operators sanely? Is optimization trashed due to using
  inlines for everything? etc)


Conclusion
==========
I'm seeking some general consensus on taking approach #1 above. Any
solution that actually gains us meaningful coverage is going to require
pretty extensive changes to Linux's types so that's a universal pain
point. But I've been beating the "make Linux safer" drum for a long time
now, and I hope I can convince folks that we need to actually make a
change here. The status quo isn't good enough, and we can do better. I
just need to find a common solution we can agree on and realistically
apply over the coming years.

I'll go get my asbestos suit now... What are your thoughts, suggestions,
alternatives?

Thanks,

-Kees

[0] I may be a broken record on this topic, but we have to do better.
These attacks range from script kiddies sneaking bitcoin miners onto
systems, to ransomware criminals locking healthcare providers out of all
of their patient records, to fascist regimes tracking and disappearing
dissidents and their families. We can't pretend Linux's flaws are just
some academic consideration; there are real-world consequences to our
use of C.

[1] Looking through the last 10 years of medium and high CVEs (not a
terrific metric, but it's been a relatively stable one over the same
time period), we've averaged about 6 major integer overflow flaws a
year. https://outflux.net/slides/2024/lss-na/#/2

[2] This also lets early adopters of hardening mitigations use things
like the "warn_limit" sysctl to get enforcement immediately once they've
validated their workloads.

[3] e.g. Rust has explicitly wrapping and non-wrapping types, C++ has
operator overloading, etc.

[4] https://lore.kernel.org/lkml/20240411230801.1504496-3-boqun.feng@gmail.com/

[5] Things are more fully developed on the Clang side, so more work
would be needed on GCC to reach parity, but the bulk of the
infrastructure exists there. Compared to Clang, GCC needs:
 - unsigned integer overflow sanitizer
 - implicit truncation sanitizer
 - decouple "undefined" from "overflow" (i.e. allow sanitizers to work with
   -fno-strict-overflow)

[6] https://outflux.net/slides/2024/lss-na/#/30 and the next few slides

[7] https://github.com/llvm/llvm-project/pull/86618

[8] It's not pretty and totally not upstreamable as-is, but it does
basically work. Many coverage areas are excluded, but the scope of what's
needed is observable. Notably, this has not been updated to use the
"wraps" attribute, which should make refactoring much less ugly:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer

[9] https://lore.kernel.org/all/9162660e-2d6b-47a3-bfa2-77bfc55c817b@paulmck-laptop/

[10] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3201.pdf

-- 
Kees Cook
