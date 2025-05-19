Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428131C84C0;
	Mon, 19 May 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747679680; cv=none; b=i9fxTqyjjTjTFJVSttA4vwYfisEIxRt4iZGTDIekWKEUY5Hzl/QgNk/wcZ7IHaxsLkiEDCzJSOpUmMj3ZUCL7J55vBrK4DYToleNJr0dWuq+pQC0jhzRguKQGF9eFCKMUfWj7ds/sx0Lj9jS4xq2gGqoM4nZQ4L6yV9ySgG8NJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747679680; c=relaxed/simple;
	bh=mIuTQTuafDLxwJyW/8ql5CnmcoDLPkCrNgOVYhINBxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqI4AVQssSZz00kYRbMON0MFcsHSzdE5PEpoDI5DwfGpdMJL/MqAxTj2pBjqT4+5iQYIuB/49WayfaNzZmeuZHgBYfhlxZxX1cHHnaMaz0eLBbmpQiZ2StSMUK4MA19RCnbB88TKDrRbzbL47r4S++VeMQ1+SpxrpjFIck32dOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkqXP2sN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkqXP2sN"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b074d908e56so3060253a12.2;
        Mon, 19 May 2025 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747679677; x=1748284477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnIRj2RqR1cnm9CM+XbwkvFomUeYfJkTYyw1bP2K0es=;
        b=bkqXP2sNisqLGcpycI/xk1gHjrgWIte1Fle4Frv8gUIhlAjvAXCc0NTRW4bGGjuvo9
         fI35ctszXgW2lMAewY20UiE7Lou7F9jt6nwweFmPu3gE6i937ldFRdN+22LbT/od7HYW
         Nx9TcPNG0JfoR4lOyfMU0aLZCTaivrEZA7O5qatSuqeCr1jhQrPYYQkAeWggR9gWehck
         /Zih7IYXS7CCZtDh+u2jZhSM2IwSo8XmXbTmBdJpZsTSGw1lg4lIrhl/FrJh2k91Dll1
         kmhIsF2VQnOwLOvozj3dbGMc0rwG0d3li/w/8IBIsFpsQ0e+fb7PYKWgpb2pgL5YI6e9
         cXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747679677; x=1748284477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnIRj2RqR1cnm9CM+XbwkvFomUeYfJkTYyw1bP2K0es=;
        b=Jdcv9OQkvS+KmI9FhMsd94G7+sJkZBfd/6kF9SLYNkRe+2stqERwnKqneuD3klCygg
         K07gpaMwq6aqQn2s2gfGxNC/bMx169TtL56sPvMbXwI/7HECe/H+A3D+lfnf2dyz5O0d
         Wy64NToBoEcyDI8QbvjNI6v+tLkn6Y0VvIb3BXACDHzJeaMwW22F9UjzBNw0VNsvQPl0
         y/uQjWKr3BSmtfJoDTTrBzxiTysOkgzAMGCPQzVy97QSd0ikaulClCAB4MT0KQaQUgiE
         AjTxGPbCQcyJ/4zPGVAzkaogUnuo5GYreNOqmMA/0V+oS0mZRQvMVk3F2UPfyRQ7OjL3
         PNQA==
X-Forwarded-Encrypted: i=1; AJvYcCU4yClqlse6KB8zjd3f57LyHqnZX2VHdSJrWaf01A8N5v479/BT9DzZcjgznFK3axZVNcF98ZwQzMAFrABiyX4=@vger.kernel.org, AJvYcCUdQtKMvG8myetQNMClvrIWc6/wrdRIqHlybCOxxTXOxzbrOZwgCcduYAsCMxtRa8tiAgGdDxYT7pYnNJCoSiA=@vger.kernel.org, AJvYcCVd1ldvnSysJM6f1KmeUxuLUwB6SJV9Hck/v/dnrCR4OVvIXBKSnSbglKF0kZZqEhutmdgVu2/lCx5GzYCz@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAc6R1a9ySHUI/oPITur7E94JLWWhOBLSHWZUjK8PzMh5nl6k
	V/ddojsvIPxBPVBweNgpQo1Mhq4N2KC56dfMHWoYcEQudxkx6AygujGY
X-Gm-Gg: ASbGncsiDoXVusay3Z/uBDZt+ShsNDpy+ojw6/YWfz5Rnd4ZHY2xRF7hbXLXCmOv7Le
	ifKIFbyNKwfkCCimMPY7n0qRPcfYBwyKJSdU+jk6hX9nbk/yrmVqTKVTP7qHiJmDUtU3nGPsH+W
	rXjpvLqM2/f1bdPhfVirOShO4H9lo63KOodCdB8PJ7i8Mn+l6p2p07o95KmsPXR6NeWr9a6CcyO
	4jt6w3bzHeAvmzXRglDjbASmd0vSKI1c2UPI+jikdS9nJldESr6GDHugE2Q5VL5x/7urWXEzJiH
	RFMhOSPYb+TvIebXyQNUtAozSzo6FoO/MYOkd5r6/UbtUQq5bsI=
X-Google-Smtp-Source: AGHT+IF4iNXXikl+qNT7wpsafELOsJwJpe7rMKuco/SXGTI7XUhJ7CcytrfQymYy8SdziGCIMHeImA==
X-Received: by 2002:a17:903:11c6:b0:216:6283:5a8c with SMTP id d9443c01a7336-231de370f04mr160319865ad.39.1747679677224;
        Mon, 19 May 2025 11:34:37 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac91e9sm63364135ad.15.2025.05.19.11.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 11:34:36 -0700 (PDT)
Date: Mon, 19 May 2025 14:34:34 -0400
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
Subject: Re: [PATCH v8 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aCt5uvbnIVgOscKf@yury>
References: <20250519161712.2609395-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519161712.2609395-1-bqe@google.com>

On Mon, May 19, 2025 at 04:17:00PM +0000, Burak Emir wrote:
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
> This version includes an optimization to represent the bitmap inline,
> as suggested by Yury.
> 
> A benchmark using a production configuration shows performance on par
> with C:

This should also go in corresponding patch. 'On par' is not a number.
Can you calculate percents? It looks like +7% for next_zero_bit. For
some application this may be a significant number.

Did you enable hardening? Did you estimate confidential interval?
Maybe it's just a noise...

> 
> ```
>               Start testing find_bit() with random-filled bitmap
> [    6.974435] find_next_bit:                  944136 ns, 163996 iterations
> [    6.982039] find_next_zero_bit:             981618 ns, 163685 iterations
> [    6.989460] find_last_bit:                  800630 ns, 163996 iterations
> [    7.004710] find_nth_bit:                  8627435 ns,  16281 iterations
> [    7.013791] find_first_bit:                2459789 ns,  16282 iterations
> [    7.054645] find_first_and_bit:           34227540 ns,  32733 iterations
> [    7.061743] find_next_and_bit:              474530 ns,  73676 iterations
> [    7.068365] 
>                Start testing find_bit() with sparse bitmap
> [    7.075035] find_next_bit:                   11394 ns,    656 iterations
> [    7.083579] find_next_zero_bit:            1920337 ns, 327025 iterations
> [    7.090213] find_last_bit:                   12061 ns,    656 iterations
> [    7.100121] find_nth_bit:                  3279811 ns,    655 iterations
> [    7.107930] find_first_bit:                1188115 ns,    656 iterations
> [    7.114558] find_first_and_bit:               3730 ns,      1 iterations
> [    7.121184] find_next_and_bit:                4679 ns,      1 iterations
> [    7.127805] find_bit_benchmark_rust_module: Start testing find_bit() Rust with random-filled bitmap
> [    7.138550] find_bit_benchmark_rust_module: next_bit:                       999542 ns, 163592 iterations
> [    7.148974] find_bit_benchmark_rust_module: next_zero_bit:                 1053432 ns, 164088 iterations
> [    7.158342] find_bit_benchmark_rust_module: Start testing find_bit() Rust with sparse bitmap
> [    7.166718] find_bit_benchmark_rust_module: next_bit:                        11474 ns,    655 iterations
> [    7.178143] find_bit_benchmark_rust_module: next_zero_bit:                 2056913 ns, 327025 iterations
> ```

So, your output exceeds 80- and even 100-chars limit. Can you drop
that useless "find_bit_benchmark_rust_module:" part?

Thanks,
Yury

> We introduce a Rust API that would replace (dbitmap.h) in file 
> id_pool.rs. This data structure is tightly coupled to the bitmap API. 
> Includes an example of usage that requires releasing a spinlock, as expected
> in Binder driver.
> 
> This is v8 of a patch introducing Rust bitmap API [v7]. Thanks
> for all the helpful comments, this series has improved significantly
> as a result of your work.
> 
> Changes v7 --> v8:
> - added Acked-by for bindings patches
> - add RUST_BITMAP_HARDENED config, making the extra bound-checks configurable.
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
> Link [v7] https://lore.kernel.org/rust-for-linux/20250423134344.3888205-2-bqe@google.com/
> 
> 
> 
> Burak Emir (5):
>   rust: add bindings for bitmap.h
>   rust: add bindings for bitops.h
>   rust: add bitmap API.
>   rust: add find_bit_benchmark_rust module.
>   rust: add dynamic ID pool abstraction for bitmap
> 
>  MAINTAINERS                     |  15 ++
>  lib/Kconfig.debug               |  13 +
>  lib/Makefile                    |   1 +
>  lib/find_bit_benchmark_rust.rs  |  94 +++++++
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers/bitmap.c           |   9 +
>  rust/helpers/bitops.c           |  23 ++
>  rust/helpers/helpers.c          |   2 +
>  rust/kernel/bitmap.rs           | 429 ++++++++++++++++++++++++++++++++
>  rust/kernel/id_pool.rs          | 201 +++++++++++++++
>  rust/kernel/lib.rs              |   2 +
>  security/Kconfig.hardening      |   9 +
>  12 files changed, 800 insertions(+)
>  create mode 100644 lib/find_bit_benchmark_rust.rs
>  create mode 100644 rust/helpers/bitmap.c
>  create mode 100644 rust/helpers/bitops.c
>  create mode 100644 rust/kernel/bitmap.rs
>  create mode 100644 rust/kernel/id_pool.rs
> 
> -- 
> 2.49.0.1101.gccaa498523-goog
