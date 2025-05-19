Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4B158218;
	Mon, 19 May 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747692464; cv=none; b=Xyn2pnvad4lIoODcVf0ePh42Tgto0ErbeOcVZbLuh6R8z85PLkcPZSLaplen/HmmMeCyeOMAm3EgFY8J3RRNEA7CscVP1GOxQjils7Utj6Mao7Qcl/Ne1tha/PyjQL5osIbYIYiZzYkh+/U7kr0uHBnngwAMIXOEbHU07cZF5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747692464; c=relaxed/simple;
	bh=tGJG3BGVwnfOfqG0pD9Jn7QT2AuJ1JskGwWW8nhUuw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9x07dVLwHz8MLXwYWsdLSm2jKC3YZhio1Bcj9EdrdhvKnnUzJcKnEw3QA/6DddsxzE97A+kZWr+mLAcq3TSnplWA0k/0pjOCflAW6nImyGTfD1PsMuWHAw09kJpiiaxBRi2UBirR7qGWbEQEtdJUvkJF056KdocV9CLa7ccO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3kEQXzB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3kEQXzB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso5745540b3a.2;
        Mon, 19 May 2025 15:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747692461; x=1748297261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsKQLfbRjGz1UTGHrEqHLBrI6P02Dgqdd0Lbpjk3qKs=;
        b=m3kEQXzBrfrDhbXWNo+lMzUQwb0uNRUi+IXGoHVuEjHhifI7KCWNth0KmAb+W2+ZXs
         ViMjfn5GZ+Rq1pFk1FrhEPPS7ZNsPu3rl99MkdO24+Qi/UIYtG1S+7E6hcS/r890RyGe
         ZakJLHEQhilGtYyPQrVzas30MQsleZ0eUE8EKQWRpi/c/pUEHM4s9qW3RedIflJXoK1e
         ViVqoiUFp1nvqt4tNtqlpoojBQzVutujeWHEEY1aiF56JhX5gMqZdgUrL81TD9XjinRN
         YYqqM1ieTQ3r4VfhDGKiLIAuEKxYMhADeBIhaX2Gh2GqZ1et9mAeCdH09+SpzF6LB3DQ
         L1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747692461; x=1748297261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsKQLfbRjGz1UTGHrEqHLBrI6P02Dgqdd0Lbpjk3qKs=;
        b=pA6xi9Jmw4RBvk2wJde5+++aRkN1ydy1Da9v0ZzCWn0BDZ7Vcha1/1HfNcObLZEhUL
         kS1gIQbVfJ824PCrbvSGvQVHPCLETYNmytN/9zDLfWF1KxKGGgwYLylPRwlqiGAIgjwm
         /RQuMq81xBulLeI/+H/unjY/X2AvhAhze0oScJmkP7wWzf8r6Fpb3mlBWdnFeezYqg+M
         pMeDnfCePcol1rC00fCFNM5LGCifldMaCZoalG7+Y8GtBwzNWJR28Iik4PYNx/ZWioGV
         WwGj8A+d7riBCeNaIu2U9SNdnp8xDekvgdziAq4jzCt408hjuB28weCJVC9B26QqVP3u
         MMFw==
X-Forwarded-Encrypted: i=1; AJvYcCUy66SiqczqoYGi4g9eIcvNrPIqO96XgTqUd3EypoboOyayi2FfeMWl4P1/Uj5HPPOj7F5YQ891TbRkllCbo0Y=@vger.kernel.org, AJvYcCVT/SMuGtrT09ljkttAdUSgr6XvWPfUBpZZUxccqJc8KEKvhgdmJhSeNwMQx5Fha5HdI7Rx5VPnCNdWm5ur0aU=@vger.kernel.org, AJvYcCWa8Ca1blW1uY3e0N4FFVNfHgll5AC9mUshb086ef/oXzVtx5CEzGkJghij0tKAQ1YbOqzVGW/gDhv3hP89@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8L8ONV2byFDxZLANOWpNk9OrwUtTB7XmQwOFs9SsJN917j8yK
	WcX8Lv+WioJj+x+3s+ysaSTfKS/41GBapq8yyNgVeeIm2Gp0XpJ+GK7d
X-Gm-Gg: ASbGncsB4A+sfCVYDI1WdP7+I2o67HRrIuKMTey8jkR0/voLaO203bTqGaW5Vm21+2G
	h26n2hCCvzVEM6ep5BA+T9sLT/QEeAe5EtPVDd9P43ZafPXD+pasn6A52DwBkkki2/mBoJGBNI3
	B+oGk5bE/VteBjc/1Zz4WpaisSk9+a801zyxqvhBMDaILDsX3PEK8+d7I4+wzrtqPMsP3//jlL/
	LqnrwkkyR8tq6JJNdn+VmIh6qwR9em9LB47MLvdNVgXkmmlSemk2aSR7jLo9qeBkH+XFwpfpVju
	MPPXjSIge5qTxFGRH0L2ReeZRgGM+hF+iIdqQe38vl2JKOJLjEo=
X-Google-Smtp-Source: AGHT+IFN/glchZUzWbm/7UP3n2CrUuYAqQxmN2QFRKVUdVR/8U/2QhE1NxAMOc+i0u+19zTbaQl+ig==
X-Received: by 2002:a05:6a21:103:b0:1f5:7c6f:6c96 with SMTP id adf61e73a8af0-21621902a69mr24006099637.22.1747692460592;
        Mon, 19 May 2025 15:07:40 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986d9c3sm6646198b3a.121.2025.05.19.15.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 15:07:39 -0700 (PDT)
Date: Mon, 19 May 2025 18:07:37 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 3/5] rust: add bitmap API.
Message-ID: <aCurhRZzWZG3tpXK@yury>
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-4-bqe@google.com>
 <aCt23djKOzUiP9L4@yury>
 <CACQBu=XQ9QrHwzfXZiJf6-uSLTucpr2k=BwRhrDCkVA3wX7-ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACQBu=XQ9QrHwzfXZiJf6-uSLTucpr2k=BwRhrDCkVA3wX7-ug@mail.gmail.com>

On Mon, May 19, 2025 at 10:41:58PM +0200, Burak Emir wrote:
> On Mon, May 19, 2025 at 8:22 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Mon, May 19, 2025 at 04:17:03PM +0000, Burak Emir wrote:
> > > Provides an abstraction for C bitmap API and bitops operations.
> > > We follow the C Bitmap API closely in naming and semantics, with
> > > a few differences that take advantage of Rust language facilities
> > > and idioms:
> > >
> > >   * We leverage Rust type system guarantees as follows:
> > >
> > >     * Ownership transfer of a Bitmap is restricted so that it cannot
> > >     be passed between threads (does not implement `Send`).
> >
> > Can you explain why you decided to not implement it? You can 'share' a
> > reference, but prohibit 'sending' it...
> >
> 
> My intention here was to be conservative. It seems safe to send a
> Bitmap to a different thread,
> in the sense that it would not cause data races.
> 
> Maybe it would be better to commit now to keep Bitmap "send"able - for all time.
> It would however constrain the API quite a bit. One could never use this API
> with a thread-local bitmap.

I'd implement the Send method, or just say that the method is to be
implemented in future when it will be needed.
 
> > >     * all (non-atomic) mutating operations require a &mut reference which
> > >     amounts to exclusive access.
> > >
> > >     * It is permissible to pass shared references &Bitmap between
> > >     threads, and we expose atomic operations through interior mutability.
> > >     Since these atomic operations do not provide any ordering guarantees,
> > >     we mark these as `unsafe`. Anyone who calls the atomic methods needs
> > >     to document that the lack of ordering is safe.
> > >
> > >   * The Rust API offers `{set,clear}_bit` vs `{set,clear}_bit_atomic`,
> > >     which is different from the C naming convention (set_bit vs __set_bit).
> > >
> > >   * we include enough operations for the API to be useful, but not all
> > >     operations are exposed yet in order to avoid dead code. This commit
> >
> > This sentence and the following one say the same thing. Can you please
> > rephrase?
> 
> Thanks for catching that, will do.
> 
> > >     includes enough to enable a Rust implementation of an Android Binder
> > >     data structure that was introduced in commit 15d9da3f818c ("binder:
> > >     use bitmap for faster descriptor lookup"), which can be found in
> > >     drivers/android/dbitmap.h. We need this in order to upstream the Rust
> > >     port of Android Binder driver.
> > >
> > >   * We follow the C API closely and fine-grained approach to safety:
> > >
> > >     * Low-level bit-ops methods get a safe API with bounds checks.
> > >
> > >     * methods correspond to find_* C methods tolerate out-of-bounds
> > >     arguments. Since these are already safe we the same behavior, and
> > >     return results using `Option` types to represent "not found".
> >
> > Nit: the above 2 lines look misaligned. Everywhere else you align
> > items such that new lines under asterisk align with the first
> > character, not the asterisk itself.
> 
> Yes, will fix.
> 
> > >
> > >   * the Rust API is optimized to represent the bitmap inline if it would
> > >     take the space of a pointer. This saves allocations which is
> >
> > s/take the space of/fits into/
> >
> > >     relevant in the Binder use case.
> > >
> > >   * Bounds checks where out-of-bounds values would not result in
> > >     immediate access faults are configured via a RUST_BITMAP_HARDENED
> > >     config.
> > >
> > > The underlying C bitmap is *not* exposed, and must never be exposed
> > > (except in tests). Exposing the representation would lose all static
> > > guarantees, and moreover would prevent the optimized representation of
> > > short bitmaps.
> >
> > Does it mean that all existing kernel bitmaps declared in C are not
> > accessible in Rust as well?
> 
> At the moment, we do not permit construction of a Rust Bitmap from an
> existing C bitmap.
> The point is more about the other direction though, not being able to
> pass the Rust-owned bitmap to C code.
> 
> One could think of an API that requires an exclusively owned (no one
> else has access) pointer to a C bitmap to Rust.
> Though there is no general way to ensure that property, there are
> situations where it would make sense (e.g. newly created).

OK. Can you also mention it? And if we'll need to share bitmaps
between C and Rust modules, are you going to create a new class, or
extent the existing one?

> > > An alternative route of vendoring an existing Rust bitmap package was
> > > considered but suboptimal overall. Reusing the C implementation is
> > > preferable for a basic data structure like bitmaps. It enables Rust
> > > code to be a lot more similar and predictable with respect to C code
> > > that uses the same data structures and enables the use of code that
> > > has been tried-and-tested in the kernel, with the same performance
> > > characteristics whenever possible.
> >
> > This should go in cover letter as well. Did you run any performance
> > tests against the native bitmaps?
> 
> ok, I will mention it there. I have not run this against the Rust native bitmap.
> I'd need to find out how to get a Rust native bitmap into kernel Rust code.
> 
> [...]
> 
> > > +    /// Set bit with index `index`.
> > > +    ///
> > > +    /// ATTENTION: `set_bit` is non-atomic, which differs from the naming
> > > +    /// convention in C code. The corresponding C function is `__set_bit`.
> > > +    ///
> > > +    /// # Panics
> > > +    ///
> > > +    /// Panics if `index` is greater than or equal to `self.nbits`.
> > > +    #[inline]
> > > +    pub fn set_bit(&mut self, index: usize) {
> > > +        assert!(
> > > +            index < self.nbits,
> > > +            "Bit `index` must be < {}, was {}",
> > > +            self.nbits,
> > > +            index
> > > +        );
> >
> > Shouldn't this assertion be protected with hardening too? I already
> > said that: panicking on  out-of-boundary access with hardening
> > disabled is a wrong way to go.
> 
> I considered it, but could not convince myself that __set_bit etc are
> actually always safe.
> For the methods that have the hardening assert, I was sure, but for
> this one, not.
> 
> Are all bit ops guaranteed to handle out-of-bounds gracefully?

No. set_bit(), clear_bit() and test_bit() don't know the bitmap size
and can't check out-of-boundary. 

But your Rust set_bit() does! You can check boundaries unconditionally,
and throw errors depending on the hardening config. If user wants to set
an out-of-boundary bit, you should just do nothing,

> > Can you turn your bitmap_hardening_assert() to just bitmap_assert(),
> > which panics only if hardening is enabled, and otherwise just prints
> > error with pr_err()?
> 
> If there is no risk of undefined behavior, then I agree that checking
> bounds is hardening.
> If a missing bounds check loses safety, we then we should not skip it.
> 
> > Did you measure performance impact of hardening? Are those numbers in
> > cover letter collected with hardening enabled or disabled? If
> > performance impact is measurable, it should be mentioned in config
> > description.
> 
> The hardening was enabled and it crossed my mind to mention it.
> Given that not all methods have hardening, I though it might be misleading.
> 
> I'll have a more complete comparision and description in the next version.
 
The hardening should be disabled for benchmarking reasons, isn't?

