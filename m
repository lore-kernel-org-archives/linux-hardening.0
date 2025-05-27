Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855EA2AE99;
	Tue, 27 May 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748356029; cv=none; b=ZIeVHJGn/ur3iVpGTRDkfXA9ezHzjFzLEfxoo+axN4VoRr9zIUhRuEt5Uag/fi9BgelYw9VIfiHGhsEZgnxmf7TZb0NJ+ihqOhQhA7QR3NoM+LYd+7ZruV0DgW+Is858OgXbI9ocT1VLD4Gk+rXECj6+sVj663MsgCG6VlDMVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748356029; c=relaxed/simple;
	bh=LPYmgOtxJddLidfmSH+cwrrETtu84omwyVuUW4hjzWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JASUcUcBdgIN7f0Y2aQQH748meDRBwmAP5mQW7QROcelQhjKhXxE7ADZDmLJH2EU5+ELK83E8fyGJYmmkQLEqWGJ0ahfgLo3nPOS6p+7tD2V69X2DA/PLn/ShAHCD5BZO4BdnCFpUu+/8NwaLNfJRZNAnfE0Nc3QvyWU+wDdOCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbzmNKMP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbzmNKMP"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-310f3c7bd87so2459063a91.3;
        Tue, 27 May 2025 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748356025; x=1748960825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQtWQ89/PEHUBT8qp9VFqYREuTOS+JajvySvOLBNPDY=;
        b=dbzmNKMPeGv/assSgmnFb/oiaKM3el2SKWnnAkxgQ84jAadqJPupMjUDaXHHbys23l
         /Fr7cEuS/Gysf4UbKhbpZ2xr2iG0YyovbL2HtE/VJGmLNUlkVP2lZkhOikKJ7fzWcdUD
         lXrvIgdPBpGFKkZdu6Zb1PDr1gudzXS76YqGWQvKitvAmWB0SIk8QTOcbcDQI1Xg63ja
         mH3V/aVcrTel1ZfxLI6YZjtT0oX49j0FzoIXqvndX7CSj6kOwN5xOAIYAET5U2Bj2lZV
         QwB5iMyRblNshb0FGRqHLprsxkU9kj9VoE3V24HarIJq2co+Drz00710KjlTmOj5qnhJ
         DXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748356025; x=1748960825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQtWQ89/PEHUBT8qp9VFqYREuTOS+JajvySvOLBNPDY=;
        b=SwKNh/LM6ZihYaU9fkiXNFLNVBFPqmxA/sFh58y55lW9UZC0K3j1I3THWRLHjPRlEm
         0aKPyURba2qD78eI0c8CjR4Lbo+J4AT9ENOwkbdQtNLGlyVZpheRrPYIX+AODIUWf0x7
         3UKF+aI/wD6kvDAlnC3szYuAHVgIsxW5AbGqX7qHSJVCMRUX56kwUy6273DVOOcNQtuB
         Kwfhb7i0pTp8gwT6wBSBTZZOGDDwv2Jyh3QP1Uc6NQTQ831KfHYMjhrY0cFKvAhQC/tu
         Y9qjV6BPkTt9yVYSF3/KjtnGd/iYut5KLBN+9Jxsp5aQkCyl+ZE8EoW4U3EPPI0jNmyk
         ZHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKTjDyk8yD0abDeNhUNVUhb1NyBxDx3htaf4HEjluX1hH/l27uw5cFbx4G04uAusbtjvYW7pc2By+gDilSiOs=@vger.kernel.org, AJvYcCVnsj4+BpBxfJxMt1MjM0C4tnV36htugI4C2IOk06oIVQ0jeonLzChR5s0eEzK9e5wOIWKulei+4kK5j6gHUfU=@vger.kernel.org, AJvYcCX/6ErbPpy7k6akk/5kxIn4Zb7gjB1ps7QQ0RiL0Sf1SqXB4sDttmcQ2h3zSagk+GA3bjc08VyZZLfpzOUT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyryxn7scw4GLoJ6+WjpccYg5Nuv+gUxUfhK/k/UxzYTkNVT1n
	1MwxZfxGgnVnVdL9bsiz+hOA54vZr2b3DeWUf0va92VS5SyvTvuc3P1y1To0HQ==
X-Gm-Gg: ASbGnctKGExVfsIJfSLMwSmHvDQcw5wJYXaCh4O1q1X6VKSgIPsUe0QV7cFSkmxkISq
	CUW1NrY5r8RLwhaB764XEtNs2JzidcInVAB3gPLdWbJIXor8DbZJqmWrmKurmzPQQPD6jjFYJC4
	nzfs7L6qTsh+Ynqtb7CxXo1po5k/jiFUR1vyAJLCU9VPew8ZyKo4ctrMD/WPOvT8rWVH0xgw+J6
	WZezFKxG9PaKTw4NvJfrRMYSjAmZ2MS7bESmslMU5d4b+Gw9F+ht0AMpXcoOyC4RrkQs+Ps+Owq
	ZASDboDcEJGrvgyEHuQ8W+WioKC8ZAYoDufv0qOkCVN9ZLH6CrI=
X-Google-Smtp-Source: AGHT+IH5OHdD33cGQgbQcSk20gPgDGaL0VTtTB1HHGSq0K8LrT1VYbwNUSCsmMA18RWqnKbxnsbgqA==
X-Received: by 2002:a17:90a:d44d:b0:30e:ee6:6747 with SMTP id 98e67ed59e1d1-3110f112a26mr19321736a91.13.1748356024502;
        Tue, 27 May 2025 07:27:04 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3110ee8f631sm6690405a91.5.2025.05.27.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:27:03 -0700 (PDT)
Date: Tue, 27 May 2025 10:27:01 -0400
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
Subject: Re: [PATCH v9 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aDXLqJTWlsrvVYB2@yury>
References: <20250526150141.3407433-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526150141.3407433-1-bqe@google.com>

On Mon, May 26, 2025 at 03:01:29PM +0000, Burak Emir wrote:
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
> We ran a simple benchmark (sample size 32), with RUST_BITMAP_HARDENED=n
> on a x86_64 production machine that was not running other processes.
> 
> Results for random-filled bitmap:
> +------------+------+-----------+--------------+-----------+-----------+
> | Benchmark  | Code | Mean (ns) | Std Dev (ns) | 95% CI Lo | 95% CI Hi |
> +------------+------+-----------+--------------+-----------+-----------+
> | find_bit/  | C    |      5.18 |         0.32 |      5.17 |      5.18 |
> | next_bit   | Rust |      5.30 |         0.37 |      5.30 |      5.31 |
> +------------+------+-----------+--------------+-----------+-----------+
> | find_zero/ | C    |      5.66 |         0.33 |      5.66 |      5.67 |
> | next_zero  | Rust |      5.88 |         0.32 |      5.88 |      5.89 |
> +------------+------+-----------+--------------+-----------+-----------+

So, 95% CI means z=1.96, isn't? And to me it should be, for example for
the first line: 5.18 +- 1.96*0.32/sqrt(32) = 5.18 +- 0.11 = [5.07, 5.29].
Can you check your math please?
 
> Results for sparse bitmap:
> +------------+------+-----------+--------------+-----------+-----------+
> | Benchmark  | Code | Mean (ns) | Std Dev (ns) | 95% CI Lo | 95% CI Hi |
> +------------+------+-----------+--------------+-----------+-----------+
> | find_bit/  | C    |     22.51 |        12.34 |     22.38 |     22.65 |
> | next_bit   | Rust |     30.53 |        20.44 |     30.30 |     30.75 |
> +------------+------+-----------+--------------+-----------+-----------+
> | find_zero/ | C    |      5.69 |         0.22 |      5.68 |      5.69 |
> | next_zero  | Rust |      5.68 |         0.29 |      5.68 |      5.68 |
> +------------+------+-----------+--------------+-----------+-----------+

Your numbers look pretty weird. I wrote the test such that on a typical
x86 system it takes milliseconds for each subtest to pass.  Here you
report nanoseconds-scaled times. Did you divide by the number of
iterations? If so, please mention it.

Please print raw output of your test in patch #4 which adds the test.
Because the test is tightly coupled to it's C version, we need to make
sure it hast the same format - fields alignment, etc.

I would prefer to have detailed performance discussion in the
corresponding patch (#4), and here in cover letter you'd just mention
the overall performance difference - 2%, as I can see.

> We introduce a Rust API that would replace (dbitmap.h) in file 
> id_pool.rs. This data structure is tightly coupled to the bitmap API. 
> Includes an example of usage that requires releasing a spinlock, as 
> expected in Binder driver.
> 
> This is v9 of a patch introducing Rust bitmap API [v7]. Thanks
> for all the helpful comments, this series has improved significantly
> as a result of your work.
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
> Link [v8] https://lore.kernel.org/rust-for-linux/20250519161712.2609395-1-bqe@google.com/
> 
> Burak Emir (6):
>   rust: add bindings for bitmap.h
>   rust: add bindings for bitops.h
>   rust: add bitmap API.
>   bitmap: fix find_bit_benchmark module name and config description
>   rust: add find_bit_benchmark_rust module.
>   rust: add dynamic ID pool abstraction for bitmap
> 
>  MAINTAINERS                     |  15 ++
>  lib/Kconfig.debug               |  18 +-
>  lib/Makefile                    |   1 +
>  lib/find_bit_benchmark_rust.rs  |  94 +++++++
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers/bitmap.c           |   9 +
>  rust/helpers/bitops.c           |  23 ++
>  rust/helpers/helpers.c          |   2 +
>  rust/kernel/bitmap.rs           | 429 ++++++++++++++++++++++++++++++++
>  rust/kernel/id_pool.rs          | 201 +++++++++++++++
>  rust/kernel/lib.rs              |   2 +
>  security/Kconfig.hardening      |  11 +
>  12 files changed, 805 insertions(+), 2 deletions(-)
>  create mode 100644 lib/find_bit_benchmark_rust.rs
>  create mode 100644 rust/helpers/bitmap.c
>  create mode 100644 rust/helpers/bitops.c
>  create mode 100644 rust/kernel/bitmap.rs
>  create mode 100644 rust/kernel/id_pool.rs
> 
> -- 
> 2.49.0.1101.gccaa498523-goog
> 
> Burak Emir (5):
>   rust: add bindings for bitmap.h
>   rust: add bindings for bitops.h
>   rust: add bitmap API.
>   rust: add find_bit_benchmark_rust module.
>   rust: add dynamic ID pool abstraction for bitmap
> 
>  MAINTAINERS                     |  15 +
>  lib/Kconfig.debug               |  13 +
>  lib/Makefile                    |   1 +
>  lib/find_bit_benchmark_rust.rs  |  94 ++++++
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers/bitmap.c           |   9 +
>  rust/helpers/bitops.c           |  23 ++
>  rust/helpers/helpers.c          |   2 +
>  rust/kernel/bitmap.rs           | 568 ++++++++++++++++++++++++++++++++
>  rust/kernel/id_pool.rs          | 222 +++++++++++++
>  rust/kernel/lib.rs              |   2 +
>  security/Kconfig.hardening      |  10 +
>  12 files changed, 961 insertions(+)
>  create mode 100644 lib/find_bit_benchmark_rust.rs
>  create mode 100644 rust/helpers/bitmap.c
>  create mode 100644 rust/helpers/bitops.c
>  create mode 100644 rust/kernel/bitmap.rs
>  create mode 100644 rust/kernel/id_pool.rs
> 
> -- 
> 2.49.0.1151.ga128411c76-goog
