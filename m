Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6000D12BF23
	for <linux-hardening@vger.kernel.org>; Wed,  8 May 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715197499; cv=none; b=EVq9cfoNMMNfLbyrP1E3/d8Jd0VvAti9z3dsA72arHQAvjXWIIqGvGsi68Nq14OIGyXyGEY3Li3G9ADR3ZbP9S6RHLWqYmxVRJeYT+NheDA+e673GpuFu+84alVHLqQsCwjH5hcFPfpmPjzkU/eQrABvN/6uldp6eGI97FzCprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715197499; c=relaxed/simple;
	bh=IlFN+qjVbyWxbajojL+B3XzFHidR01L29y4ThUK6x84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKJl4cEocodTGjGK+bkHRXLV0XPcfe1lElmA8fO9mors+YQasafG7Li5jS74H+FIhGY99KYdGo6v/joVOQaihUFGpIDgOn6PbOGe7YRPY6LpHBvH2A+5jjEtHD7mchqxN/D78Ugu4S+m8mnOphZyxS8mrw4HjbD/UmA5zfq0G9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EqfmzA+K; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EqfmzA+K"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-61bbb208ea5so130182a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715197498; x=1715802298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSkp1IjyO8SPzHju8VI5tBOliintVpxYB8En8fnp8Mk=;
        b=EqfmzA+Kfc5DePx79WriG5iM23AcOvyazs4+a2tvnJWKPWBniJ9qbve1my6BHaFqNm
         YluT9ga3vCUaUHEmOsSzfDdGgJcfdnGmrOmZoNezv0zWaLBPQbhjyD3+kf2KXnIAFW+q
         i++PrNm0Rj9zUmk/dOYuWy71pPxqHxJFsuo4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715197498; x=1715802298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSkp1IjyO8SPzHju8VI5tBOliintVpxYB8En8fnp8Mk=;
        b=AUT6K59FXCWZPGi2lMXqJ3w8dWTCsstA41ol5qXqq7PAY329UpTfwcTfbb83Gtdija
         0vJp4HrmDaYRTJTsY11WCi6xtNwYkqHkdNY44aYUMw81W7kjxEc8ATCPfXUfr5SfEyC8
         vTF+gqzrcVD72LSAdlVef6NCC5+bJiP0F492Z7w6Meyd1sOx/2dCOLWDDCBuS4OWtlNV
         P/14GMSC3c/ZVorMWFSTObagrFncq96Wk2jArnIJ0vu2+mSc35cDMCj2iZYRoBAxWmQc
         OyEsRLf55DylymKKhERXz3Tv/e5PGMe3SiqCKJ2H5sn3egL6up2m1pfZ1X8BhSm9RoxL
         sB8w==
X-Forwarded-Encrypted: i=1; AJvYcCV9Xec6EfEKW3ILFMHC/7VCGiLa73Jof3zMW5AQsPabmbO2gjPTaxZFrUxeTHxCBp/4gNe96/nRfXLIPFVGuv3uamntECpDbjpn19FqE6b+
X-Gm-Message-State: AOJu0YwxOjpDTIy/nQslK7BPqDuJuwLJSIPoIN5SSOmlrxSdJgbB5eI7
	0AIpvbSfWmu07ZYp4624lu5X5q4vZJmbCrIAfQpe9t9RXofKHP4DBB3Y+yIKZlSXlTMUZq68v9A
	=
X-Google-Smtp-Source: AGHT+IEQJv5MoWCuSsH7z9sDM3firMHKZ9a0PaOa+JkXwojX56OtQaqrhExQGOf6H5m7P+TAapuX/w==
X-Received: by 2002:a17:90a:1305:b0:2ab:9819:64bc with SMTP id 98e67ed59e1d1-2b6169e25cfmr3250633a91.32.1715197497713;
        Wed, 08 May 2024 12:44:57 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ac29700b002acf260e82bsm1827034pjt.57.2024.05.08.12.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:44:57 -0700 (PDT)
Date: Wed, 8 May 2024 12:44:56 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <202405081144.D5FCC44A@keescook>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>

On Wed, May 08, 2024 at 10:52:44AM -0700, Linus Torvalds wrote:
> On Tue, 7 May 2024 at 16:27, Kees Cook <keescook@chromium.org> wrote:
> [...]
> Put another way the absolute first and fundamental thing you should
> look at is to make sure tools don't complain about sane behavior.

Agreed, and I explicitly called this out in the proposals, including
adding several idioms that have been found besides the case you mention:

> > - allow for common idioms to bypass sanitizers:
> >   - explicit wrap-around tests: if (var + offset < var)
> >   - loop iterator wrap-around during post-decrement: while (var--)
> >   - negative unsigned constants: -1UL

What I need, though, is for _intent_ to be captured at the source level.
Unfortunately neither compilers nor humans are omniscient. Wrapping vs
non-wrapping intent can only rarely be unambiguously determined. I tried
to explain that here:

> > This is what is meant through-out by "ambiguous": the _intent of the
> > author_ can be ambiguous as it relates to whether a calculation is
> > meant to wrap-around. That it wraps around on overflow is not ambiguous:
> > it will wrap-around. :) See "Terminology Considerations".
> >
> > This is the corner stone of the problem: even though the behavior of
> > overflow is well-defined, so many authors so often don't correctly handle
> > it that the results threaten the integrity of Linux as a whole. C makes
> > it too easy to get it wrong, so we are left needing to fix this at a
> > fundamental level. This is not a developer education problem; it is a
> > problem with C language semantics. "Just do it correctly" has not
> > worked.


> The thing is, wrap-around is not only well-defined, it's *common*, and
> *EXPECTED*.

Yes, common, but that still means "sometimes unexpected". The fact that
when wrap-around is wanted, an author does nothing different from when
it is unwanted is the core of the problem: C doesn't provide a way for
us to see intent. We need to fix this.

> Example:
> 
>    static inline u32 __hash_32_generic(u32 val)
>    {
>         return val * GOLDEN_RATIO_32;
>    }

But what about:

static inline u32 __item_offset(u32 val)
{
	return val * ITEM_SIZE_PER_UNIT;
}

All I did was change the names of things and now we have to wonder if
the result is going to be used for indexing or sizing, and maybe it
never considered that there might be a way for val to be greater than
UINT_MAX / ITEM_SIZE_PER_UNIT.

So instead, how about:

static inline u32_wrap __hash_32_generic(u32_wrap val)
{
         return val * GOLDEN_RATIO_32;
}

Now intent is clear.

> and dammit, I absolutely DO NOT THINK we should annotate this as some
> kind of "special multiply".

Yes, I agree, annotating the calculations individually seems like it would
make things much less readable. And this matches the nearly universal
feedback from developers. The solution used in other languages, with
much success, is to tie wrapping intent to types. We can do the same.

> I have no idea how many of these exist. But I am 100% convinced that
> making humans annotate this and making the source code worse is
> absolutely the wrong approach.

I'd like to make the source better, not worse. :) But if we're going
to solve this, and do it incrementally, I think progressively updating
types is the way to go. We have used types in plenty of places where we
want the compiler to help with checking (gfp_t, pid_t, etc), or with
specific behaviors (atomic_t, refcount_t, etc). This would be more of
that, though, yes, to a greater degree.

> So I think you need to limit your wrap-around complaints, and really
> think about how to limit them. If you go "wrap-around is wrong" as
> some kind of general; rule, I'm going to ignore you, and I'm going to
> tell people to ignore you, and refuse any idiotic patches that are the
> result of such idiotic rules.

This doesn't take into account the reality of deployments worldwide that
are getting exploited by unexpected wrap-around. There's no problem with
wrap-around per se, it's that we have no source-level way to indicate
when it is _intended_. I would phrase the rule as "ambiguous intent of
wrap-around is wrong".

> Put another way the absolute first and fundamental thing you should
> look at is to make sure tools don't complain about sane behavior.

What do you see as the solution for the ambiguous intent problem?

> Until you have done that, and taken this seriously, this discussion is
> not going to ever result in anything productive.

I think I've shown pretty clearly that I take this seriously. We have
been working out feasibility and potential directions for some time now,
engaging with compiler communities, building the tooling needed to do
this with as minimal impact as possible, etc. I didn't send this RFC
for fun. :)

But let me make sure we're on the same page: do you agree that we need
to protect Linux from classes of bugs? That there is value in protecting
our billions of users from avoidable and exploitable flaws that have
literally life-threatening consequences? If we don't agree that there
is a problem here worth solving, then yes, it will be hard to have a
productive discussion.

And please remember that I'm not saying "let's fix it overnight", I'm
looking to coordinate a best way forward. I want to make a plan. Neither
human nor compiler omniscience has manifested, so what's the next step?

-Kees

-- 
Kees Cook
