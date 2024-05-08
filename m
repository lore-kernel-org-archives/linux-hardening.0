Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D115134CEA
	for <linux-hardening@vger.kernel.org>; Wed,  8 May 2024 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715212079; cv=none; b=r2qGPR5L4WXDn4AhOBN5IwsSBvjP18+qvdDVO9+cxfMzulzjQUmS8quzIOQTX0RjUfKxt89iTN1vERndnXlMr5dYHLjwW1+682v1QDtFd08ubEaevQoz19LJm/Ty5LFqryUyvMw9glG24ooA+nZYCwgtf2hMlHUaFOEcSe7qysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715212079; c=relaxed/simple;
	bh=OW/b8uAOH+Sb+MiKHJVZZkROsd6CBAfhvOiVb6V3tqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUhOWlCZ3nVtrY6RPfZ15EtdPrM/kTMuCmQN88mLuMfJ5H1kG5FSHzsDSKGQrSYAqYgq4E7ID7l36B9nnkvLzDMiOLEhu/tum9ZjMSqEXd/jeWJRTCySVNBs+uD/HIaezz61CVCifor268SAxT8XnxCleetf1L02oYRZNnXdKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mq9zzV7o; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mq9zzV7o"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a1192c664so70802366b.2
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715212063; x=1715816863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLC5ByXhKS1C0+XIxfmxA5pdOYFsJLXlzKRuFCObZZY=;
        b=Mq9zzV7oBk8CmxD+LhXUqnbbcR/g5RQsKfNmjvEv7nbMzKyhyf4saLGy5nExfadOq2
         mhQJvOqiD91Ti6LHR1E+Q9TgHu3tbZW/9nbs3SNTiSs4aoH21RgofZdOZg3a12FAjWDn
         mi+JEyVQOVbLMXBZou8CyOSiOG+8BRfFbzwQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715212063; x=1715816863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLC5ByXhKS1C0+XIxfmxA5pdOYFsJLXlzKRuFCObZZY=;
        b=G5Zw5S2DQhV4X7dUCxJTMVUJ43BNTNBcWu9H348HweQ1f4aXDww2tVX+oz4d4BnOLy
         Eb1rxKKDS//H7KNttRe9rRAvmQM/u6gxNp0o/jOSFshZ0LnEHcqUExANhFLS/Tgk7b0W
         2eT8h0f8V+mTRkLZ4iGARRmqZfKowFPlJBvjv8taS54R6R4NWiN2luSUs9vQO6amUVsI
         eXbB8fCPMyhtnMV//mOT1n/wxGtbkgauM3EArfo/wTz7geESqJv+nJf2XJ48jNYBQzYF
         N8iBBYJZfCmBfX4QINobVQU0ylbeX15QsXCnrb1HfLQCvYXAnkkTIdqD7Gr9Onl3xMCR
         v8HA==
X-Forwarded-Encrypted: i=1; AJvYcCUS1sRC3ei1STnSsYRsnHLtU5bKaU6yzwNtHCTJRF9VUc2L2tJ8jNFTgOdKEXTv9weHxmyG2/064rEtPDBtF4uOWDUEO9PDXJeAJ0/FnRcD
X-Gm-Message-State: AOJu0YypISTxOpkqiDdF+Xzl/gGcn9bXtI4TRb9GmCP9XDLq6p1MTcs+
	wrBPaMM9uUGp8SmpIB78Xz0+aC1OgnEBB2Z3mh+D47Zfkg4TNnDqATxLcd6uFgGka2ykck7bPwD
	HpqZPBQ==
X-Google-Smtp-Source: AGHT+IF5uALA9lNufl4DjL2C3folTdNmHVGjXypTnZfmZHoj5KzVjt2LWyvHoPpkAAEkB0yC/tNdcw==
X-Received: by 2002:a17:906:a14c:b0:a5a:15f6:157e with SMTP id a640c23a62f3a-a5a15f615ebmr43895966b.11.1715212063340;
        Wed, 08 May 2024 16:47:43 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd85sm13224566b.15.2024.05.08.16.47.42
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 16:47:42 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59b81d087aso65355966b.3
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 16:47:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlJuEs/pgOX+VXNFOf5Yb69VXSdOzVQKFYzzDVizz+Ef6F3qo9qe88msR7ra7g1riJ5u9kkuLf6sX/Jzq3IOSAWIfG/vfReXrQawqze0za
X-Received: by 2002:a17:907:118b:b0:a59:bb63:5e93 with SMTP id
 a640c23a62f3a-a59fb920592mr343424566b.16.1715212062214; Wed, 08 May 2024
 16:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
In-Reply-To: <202405081354.B0A8194B3C@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 16:47:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
Message-ID: <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 15:54, Kees Cook <keescook@chromium.org> wrote:
>
> Sure, but if the bar is omniscience, that's not a path forward.

I really don't think there's a lot of omniscience involved at all.

> I haven't really heard a viable counterproposal here.

So let me make the counter-proposal that you actually concentrate on
very limited cases.

Baby steps, in other words.

For example, the most common case of overflow we've ever had has very
much been array indexing. Now, sometimes that has actually been actual
undefined behavior, because it's been overflow in signed variables,
and those are "easy" to find in the sense that you just say "no, can't
do that". UBSAN finds them, and that's good.

So I'd suggest seeing if we can catch the cases that *technically*
aren't UB, but match dangerous overflow situations. IOW, start with
very limited and very targeted things to look out for.

For example: some of the "this is not UB" may actually be trivial
mistakes that come about because of the silent C type casting rules:
overflow in unsigned arithmetic isn't UB, but it's actually very easy
to make arithmetic unsigned "by mistake".

IOW, a pattern to look out for might be

        int a;
        ...
        a * sizeof(xyz);

where "sizeof" obviously is unsigned, and then the C integer
promotions end up making this a well-defined operation that probably
really *is* dangerous, because the integer promotion basically adds an
implicit cast from "int" to "size_t" in there.

End result: it's not UB, but maybe it is not-*accidentally*-UB, and
thus maybe worth a warning? See what I'm saying?

So *that* I feel could be something where you can warn without a ton
of compiler smarts at all. If you see an *implicit* cast to unsigned
and then the subsequent operations wraps around, it's probably worth
being a lot more worried about.

Now, another thing to do might be to treat assignments (and again,
implicit casts) to 'size_t' specially. In most compilers (certainly in
gcc), "size_t" is a special type.

Now, in the kernel, we don't actually use __builtin_size_t (the kernel
started out with a very standalone type system, and I think it
actually predated gcc's __builtin_size_t or maybe I just wasn't aware
of it). But we certainly _could_ - or we could at least use some
special marked type for our own 'size_t'.

And basically try to catch cases where arithmetic is explicitly used
for a size calculation: things like 'kmalloc()' etc are the obvious
things. And yes, the result will then have an (implicit) cast to
'size_t' as part of the calling convention.

That's another "pattern that sounds relevant and easy to notice for a compiler".

And, finally, simply pointer arithmetic. Again, this is *not* some
"omniscience required". This is something very obvious where the
compiler is *very* aware of it being pointer arithmetic, because
pointer arithmetic has that implicit (and important) "take size of
object into account".

So again, if you see an integer expression that leads to pointer
arithmetic, at that point the overflow very much is relevant.

See? Three very *targeted* things where

 (a) the compiler is very much aware of the use

 (b) you can fairly confidently say "integer arithmetic wraparound is
a dangerous thing even when not UB".

So what I object to - loudly - is some completely bogus argument of
"integer wraparound is always wrong".

And dammit, I have seen you state something that sounds very much like
that several times, most recently in just this thread where you were
arguing for a special "u32_wrap" type just to allow wrapping without
complaints.

And I think it's that overly-generic "wrap-around is wrong" argument
that is completely bogus and needs to be nipped in the bud.

Wrap-around is not only well-defined, it's *useful*, and it's *used*,
and I find tools that warn about good code (like our existing hash
functions) to be *HORRIBLE*.

False positive warnings make real warnings worthless.

And so I think warning about wrap-around in general is mindless and
wrong and actively counter-productive. If people then just "fix" the
warning by casting it to "u32_wrap", you have only caused problems.

But catching wrap-around in *specific* cases, if you can argue for why
it's wrong in *those* cases: that sounds fine.

And I tried to give three examples of such specific cases above - I'm
sure there are many others.

To conclude: I think the path forward is not at all omniscience. It's
"limit yourself to cases that matter". Don't think of wrap-around as
some "global evil" like you seem to do. Think of it as wrong in
_specific_ cases, and see if you can target those cases.

Start small, in other words.

Now, to take the specific example you brought up: commits a723968c0ed3
and 382c27f4ed28. Honestly, I think you'll find that that one wouldn't
have been caught by some arithmetic wrap-around issue, because the
*arithmetic* was actually done in a type that didn't even wrap around.

IOW, in that case, you had "int size", and none of the arithmetic on
the size actually wrapped.

No, the only point where that actually failed was then when a
(non-overflowing, non-wrapping) final value was assigned to a 16-bit
field, ie the problem only ever happened at the final assignment:

        event->read_size = size;

where no overflow had ever happened before that.

So in *that* case, you actually have a much more interesting
situation. Not wrap-around, not overflow, but "implicit cast drops
significant bits".

And yes, I do think implicit integer casts are dangerous. Often *more*
dangerous than arithmetic overflow and wrapping. We've had absolutely
tons of them. Some of our most traditional bugs have very much been
about implicit casting losing bits and causing problems as a result.

In fact, that's the reason we have MAX_RW_COUNT - because we used to
have too many places where various drivers or filesystems ended up
casting a "size_t" count argument down to "int count". So we are
literally violating POSIX semantics for some of the most important
system calls (read() and write()) as a safety measure against hidden
implicit truncating casts.

I think that would be a completely different area that might be worth
looking at: instrumenting implicit casts for "drops bits". I'm afraid
that it's just *so* common than we might not be able to do that
sanely.

But again, maybe it would be worth looking into, at least for some
limited cases. To go back to your particular example, it might be
worth trying to limit it for unusual type sizes like implicit casts to
'u16' or bitfields: not because those type sizes are magical, but
because it might be a way to limit the pain.

Summary: targeted baby steps, not some draconian "wrap-around is wrong".

                  Linus
