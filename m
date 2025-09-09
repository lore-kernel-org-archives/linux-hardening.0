Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A3334726;
	Tue,  9 Sep 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438105; cv=none; b=mx/1djXtyFBmL+ovB0q1rXD9X+JD2SjtiaTNsCFOkmDhHfzD1E0VTzDO578qLuJZGYJVf4sQ3vxXvpOcehICoTciTJUmqh1/C5lJhJhUgRe7vnLus5Ib7eqo/hnNrUqaasIBX8SXpzAaQuwBcrIAye0Pe0HGFaKWAdnK2qxHLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438105; c=relaxed/simple;
	bh=lo1VVObPXEHm1+PWSWem/9+RX2QqUex5R1erNpb7frc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8BVESaYR+XGNBHfybb09CFhU8yrhXn/aaNWA8W2EbsCVV6TqbNBjLHIBiLI44CPuRR0aeXiqRgTCctH6vpNAAweDME3F8hD+o53Vsub8ZrqIr2bVUkP8MpRc7bbaBWwLor45MVX+yolT0khT7HcOH30V9B0n7otP6yiNpS86YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrerBdgn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrerBdgn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77269d19280so5353389b3a.3;
        Tue, 09 Sep 2025 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757438101; x=1758042901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fqhHgAdndor+47iQ2+/o2swDSSfSqPo76fYT/I99AWI=;
        b=mrerBdgnt5azMa2bhuX/BQ1IfwXs6lpXTDL86LUZqoG7vFPN8arOBs+KHGuGXjB4fu
         wBAaBcOraoKo9HiiZ5CH7IT9hcyHJmnzKtj64eA1NzbID88wEPdvsNJq4WX7cwvEcDWx
         cntqv6HR7dyDmVYm5fE8st0sKUNBvkIMt64bFZlmwMtwh9td7XXqrs6u+pLSxtVxsgHQ
         W2Skn6Z+p8imDep6NO3JiSBC/7CIcWyloZoGbRrltTayxYlvVYQzo065GWCSs6iQ/7vn
         nfnVyw0c+NoJeRwJ58Px0Uj2l3g+k5UE25tRCFRB47Q0sru7LD5aBL4i7FVTNcwW1Srz
         kUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757438101; x=1758042901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqhHgAdndor+47iQ2+/o2swDSSfSqPo76fYT/I99AWI=;
        b=oWyhDjBVRYGfI7TO83IRLQXVFwvyaepWXlRmBWLroptM90hD50ZLQbEwmFDRT2iB5I
         y79LH2fvi+Scme0ob9UZyVv+7cnVvle+9hVPlSsYKuiT6UFiaT+PIpup/Tq2GQF4DQui
         CYDVKbtpcM6ElHMQpMbjdDdtjpSy/6OAh30xj4ufPX5tp15SCgSHWNBog9gt8O16FuHA
         4awGGtpDT5XlvftMTin+udJUmBzXpdOkRC40VGXcdisjA/HY2x66jE42WJf5gcX9/lT8
         G0Gba6jljOTGXysDjXVTWs+Zc7YlgWhBfmHpnh5PZWe3lXkgXCj5EsJmlDSMJbiaMKn1
         HcEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHhIV9tWXQfnn2Itodayn8V8OXv29Zi9iXxkSS61boeFpAGcXzdQ9mpfZ4NFdpcqMRlexWc+r80AyqR8H1@vger.kernel.org, AJvYcCVob/Qd4v+hyoKJqob4RtZykwuxNkEg9M4DKZHJGu/YZKX7uwceC/r5GrzGcIbULAQpGbhgjGEYkXY55G5aED0=@vger.kernel.org, AJvYcCWHztcvWnmm+4B0KTUdFhCoAujuDRH//lSHMJ7whGBvuBPdIl5HnemjZGY8SC/JEwgKfN/q7rHekVTVWnzpcEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClSGBOkXjYTsdJMK1jlo5l+BCixGun1L+gXr/sONZbgxfSJ5e
	dm9bhsp4ptv15UsBXu3Za+79IQMi2qhHpWZrMPPJ1sfDfoaCPKNqq7xs
X-Gm-Gg: ASbGncsg8hHlifKHE0UmSOlSkpUjJRWPOeIGABiycATmXhQHd/j5xWUyscWxj00ttEi
	cY+cyomlhLM0YqwKk7MZXU9vkjJOWZf74xGNywnAFH/bYUotERwJ619QmD3DTrVFekXqTmnaiZK
	urY/V49b/8ec3vh3fgAh4s4VhkwQg9dxWnvt5cSJWaAzZNHkHyAQlAsaouUTavD5opdbt/zQSIf
	jb9fWNYQG+k6r0r0b9V3LyIAAjZEwPyHGpM8Y4wIJzrtKI4SceSrzdyfjHSq0hWXuUd6pCmTqPk
	GSPFl/HcYBMoitYwwv0rikI0RaYj3VtHVE47LywfvGRotiQKoPwFYZkKVg0fHnWji7aHX/AwrPi
	lmhRn5lQRw3lWmnaR2CDmwA==
X-Google-Smtp-Source: AGHT+IELUpO7CPglv+Yjw0AFf23xhEIQGXApyFaUCD/s/DloQ4jqdUYPTIj/p1VAM1h8Rp/t+49BKA==
X-Received: by 2002:a05:6a00:2d29:b0:772:700:acea with SMTP id d2e1a72fcca58-7742dc9d3eemr11863270b3a.5.1757438100924;
        Tue, 09 Sep 2025 10:15:00 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e58d9sm2672569b3a.16.2025.09.09.10.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:15:00 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:14:58 -0400
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
	Carlos LLama <cmllamas@google.com>,
	Pekka Ristola <pekkarr@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v16 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aMBgkuFIEf3NbIkN@yury>
References: <20250908072158.1041611-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908072158.1041611-1-bqe@google.com>

On Mon, Sep 08, 2025 at 07:21:50AM +0000, Burak Emir wrote:
> This series adds a Rust bitmap API for porting the approach from
> commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.
> 
> The Rust bitmap API provides a safe abstraction to underlying bitmap
> and bitops operations. For now, only includes method necessary for
> dbitmap.h, more can be added later. We perform bounds checks for
> hardening, violations are programmer errors that result in panics.
> 
> We include set_bit_atomic and clear_bit_atomic operations. One has
> to avoid races with non-atomic operations, which is ensure by the
> Rust type system: either callers have shared references &bitmap in
> which case the mutations are atomic operations. Or there is a
> exclusive reference &mut bitmap, in which case there is no concurrent
> access.
> 
> This series includes an optimization to represent the bitmap inline,
> as suggested by Yury.
> 
> We ran a simple microbenchmark which shows that overall the Rust API 
> can be expected to be about 4.5% slower than C API.
> 
> We also introduce a Rust API in id_pool.rs that would replace 
> dbitmap.h from the commit referenced above. This data structure is coupled 
> with the bitmap API and adds support for growing and shrinking, along
> with fine-grained control over when allocation happens. 
> The Binder code needs this since it holds a spinlock at the time it
> discovers that growing is necessary; this has to be release
> for performing a memory allocation with GFP_KERNEL that may cause 
> sleep.  We include example doctests that demonstrate this usage.
> 
> Thanks everyone for all the helpful comments, this series has improved 
> significantly as a result of your work.
> 
> Changes v15 --> v16:
> - Rebased on commit 6ab41fca2e80 ("Merge tag 'timers-urgent-2025-09-07' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> - kunit [test]s in Rust don't yet work with cfg, which breaks when
>   CONFIG_RUST_BITMAP_HARDENED=y. Miguel identified the issue and
>   suggested to move the [cfg] to body. Should be changed back when issue 
>   https://github.com/Rust-for-Linux/linux/issues/1185 is fixed.
> 
> Changes v14 --> v15:
> - Rebased on commit 08b06c30a445 ("Merge tag 'v6.17-rc4-ksmbd-fix' of git://git.samba.org/ksmbd")
> 
> Changes v13 --> v14:
> - Rebased on commit 8742b2d8935f ("Merge tag 'pull-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")
> - applied clippy suggestions for pointer casts
> - in benchmark module, replace use of the Rust Ktime abstraction 
> - in benchmark module, move newlines around for pr_cont to work
>   with Instant, elapsed.
> - added Alice's Reviewed-by tag
> 
> Changes v12 --> v13:
> - Rebased on commit 75f5f23f8787 ("Merge tag 'block-6.16-20250619' of git://git.kernel.dk/linux")
> - Renamed types CBitmap --> Bitmap, Bitmap --> BitmapVec.
> - Rewrote unit tests to not use `unwrap()` but `Result` and `?`
> - Replaced NonNull::as_mut() with NonNull::as_ptr()
> - declared local BITS_PER_LONG usize constants, fixed rustdoc
> 
> Changes v11 --> v12:
> - Added Reviewed-by tag, changed named of benchmark module
> - Fixed config, rustdoc, clippy and bytes computation (Pekka).
> - Added test that exercises CONFIG_RUST_BITMAP_HARDENED,
>   verified it panics.
> - Had to add a break to benchmark module, for the
>   CONFIG_RUST_BITMAP_HARDENED case which enforces bounds check.
> 
> Changes v10 --> v11:
> - Fix Kconfig dependency, Rust benchmark depends on CONFIG_RUST
> - Disable clippy warning for len() without is_empty() in id_pool.rs
> 
> Changes v9 --> v10:
> - change helper to use `unsigned long` for `nr` parameter (Boqun)
> - add missing and fix safety comments (Boqun, Pekka)
> - move benchmark module output and results to #4 commit msg.
> - use pr_cont to avoid repeating find_bit_benchmark_rust log prefix.
> - Disable clippy warning for len() without is_empty() in bitmap.rs
> 
> Changes v8 --> v9:
> - added a new type `CBitmap` that makes any C bitmap accessible with
>   the same API, and add Deref so both Bitmap and
>   CBitmap can share the same implementation.  Full credit for this 
>   goes to Alice who suggested idea and code.
> - added config dependency on CONFIG_RUST that was missing from
>   CONIG_FIND_BIT_BENCHMARK_RUST.
> - implemented Send for Bitmap, it is actually needed by Binder.
> - reworded commit msg for clarity.
> - removed unsafe for atomic ops.
> - renamed `bitmap_hardening_assert` to `bitmap_assert` and make operations
>   do nothing and log error when RUST_BITMAP_HARDENED is off.
> - update author information in find_bit_benchmark_rust.rs
> - Various improvements to id_pool, better names and comments.
> 
> Changes v7 --> v8:
> - added Acked-by for bindings patches
> - add RUST_BITMAP_HARDENED config, making extra bound-checks configurable.
>   This is added to security/Kconfig.hardening 
> - changed checks of `index` return value to >=
> - removed change to FIND_BIT_BENCHMARK
> 
> Changes v6 --> v7:
> - Added separate unit tests in bitmap.rs and benchmark module,
>   following the example in find_bit_benchmark.c
> - Added discussion about using vendored bitset to commit message.
> - Refined warning about naming convention
> 
> Changes v5 --> v6:
> - Added SAFETY comment for atomic operations.
> - Added missing volatile to bitops set_bit and clear_bit bindings.
> - Fixed condition on `nbits` to be <= i32::MAX, update SAFETY comments.
> - Readability improvements.
> - Updated doc comments wording and indentation.
> 
> Changes v4 --> v5: (suggested by Yury and Alice)
> - rebased on next-20250318
> - split MAINTAINERS changes
> - no dependencies on [1] and [2] anymore - Viresh,
>   please do add a separate section if you want to maintain cpumask.rs
>   separately.
> - imports atomic and non-atomic variants, introduces a naming convention
>   set_bit and set_bit_atomic on the Rust side.
> - changed naming and comments. Keeping `new`.
> - change dynamic_id_pool to id_pool
> - represent bitmap inline when possible
> - add some more tests
> - add myself to M: line for the Rust abstractions
> 
> Changes v3 --> v4:
> - Rebased on Viresh's v3 [2].
> - split into multiple patches, separate Rust and bindings. (Yury)
> - adds dynamic_id_pool.rs to show the Binder use case. (Yury)
> - include example usage that requires release of spinlock (Alice)
> - changed bounds checks to `assert!`, shorter (Yury)
> - fix param names in binding helpers. (Miguel)
> - proper rustdoc formatting, and use examples as kunit tests. (Miguel)
> - reduce number of Bitmap methods, and simplify API through
>   use Option<usize> to handle the "not found" case.
> - make Bitmap pointer accessors private, so Rust Bitmap API
>   provides an actual abstraction boundary (Tamir)
> - we still return `AllocError` in `Bitmap::new` in case client code
>   asks for a size that is too large. Intentionally
>   different from other bounds checks because it is not about
>   access but allocation, and we expect that client code need
>   never handle AllocError and nbits > u32::MAX situations
>   differently.
> 
> Changes v2 --> v3:
> - change `bitmap_copy` to `copy_from_bitmap_and_extend` which
>   zeroes out extra bits. This enables dbitmap shrink and grow use
>   cases while offering a consistent and understandable Rust API for
>   other uses (Alice)
> 
> Changes v1 --> v2:
> - Rebased on Yury's v2 [1] and Viresh's v3 [2] changes related to
>   bitmap.
> - Removed import of `bindings::*`, keeping only prefix (Miguel)
> - Renamed panic methods to make more explicit (Miguel)
> - use markdown in doc comments and added example/kunit test (Miguel)
> - Added maintainer section for BITOPS API BINDINGS [RUST] (Yury)
> - Added M: entry for bitmap.rs which goes to Alice (Viresh, Alice)
> - Changed calls from find_* to _find_*, removed helpers (Yury)
> - Use non-atomic __set_bit and __clear_bit from Bitmap Rust API (Yury)
> 
> Link [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.com/
> Link [2] https://lore.kernel.org/rust-for-linux/cover.1742296835.git.viresh.kumar@linaro.org/
> Link [v15] https://lore.kernel.org/rust-for-linux/20250904165015.3791895-1-bqe@google.com/

Added in bitmap-for-next for testing. Thanks.
