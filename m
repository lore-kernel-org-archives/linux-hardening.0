Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8203E21C16D
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871421; cv=none; b=QQlEuE8y7n7JYIvIRJ5a77bPhK51ipK73k4mEJhGlxVmzBlW7Ciweqzlub0NjMuKdLbE2OAW79CGwg1unXBUllRtsY2WuSoDNu9lb+4oNA1W+xrRbTdwNd1JfmZIzAgSvf1BeZWRFS5R3BkwBGnBMf8vscOK0k390bi2Ye6rlqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871421; c=relaxed/simple;
	bh=QHSS6EnyJgLgXZ8y0Fsif8DRC6T2WbBqWKFRmSvkFaY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bAcinqEW3hlStbKHdRqd/OQS8litd0zYgKpEcAMWdzbYfI3N4EliiIotmXLWvYOii7qdzPBjcZbC3SABQR/9Uw1Swkli73Bge//YwMg6/89/BZSdmhmYyI2XcenMAdCXrpLfkwSRCtK1cFMQITKhJ1sOTDfaPtUZkcyZDK92KYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWqvsxs6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWqvsxs6"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-450dada0f83so21001795e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 06:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748871417; x=1749476217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xp41BqileRut15GE0tOdaNpTK0mK4C6NmbTB45C0bk4=;
        b=MWqvsxs61IMIC1vsMQHXzK2QX2ZoPTPZWpaNDAyUl3hB2JUt84MKrV4A3CvM1x401m
         zW5PrKVFOpbtduNd5GuAEuzwn/wIoQBmw1W01LNX4dl1yUJeCWcKnqeOcaClo6jKjRKw
         3lZAk1fvkcdGJRaF9DbgjVr/qSPsEnIRlRylWAab7YCDEuSk8/yEKhhXiV6IDKzteWeo
         PYNtOg2rG6bQTckJPYeK1Fa5X6X3EDgJVIEJoKJhDFp6uvUXKY8Of8t0qrHXpeJloA5k
         dQ7aZQHhpT8TFZnV05tbq2T0CH8kwpyPskoAXZZZhb/3Sti1wBLUsZRNeqI8AzXX87Nt
         akhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748871417; x=1749476217;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xp41BqileRut15GE0tOdaNpTK0mK4C6NmbTB45C0bk4=;
        b=pZSaPZ7EUJf+pgpC+DSXqwExehnVNB/ic+P5iaUdjPFLdu+tEortFNvGeN64YNkd45
         U0bi2qL8Xf4lB+wlLpub/hPvoaoJBgqe4zLUvRneONg+m0Dfc8dDTd4QZ2WmlvLUSthc
         6SdNpuCnRwOFFLDFjwRQjH1IU0FfS/2FUCTv5K2HOCKNe0gyFFAEz1lxNrROfM96FFXK
         Zsa+2FtOKy8BPyqdFLaO+9zhiDplCbfc7kBEtr+8uPu8BotoOcIUWpnkhA9LVAKNLFVg
         sOp/ZOE8RUsv8naCG8VGAs6cM6NemaLxvN8UQZNtpe1142fDMbrdfNWPE4VEfyi3Y5xs
         7m+A==
X-Forwarded-Encrypted: i=1; AJvYcCWGv5wIj4IAic1N0Fx43KyRT/NRcbjFZAMnUMz6B7l5FpEoyOd+wOYUwtWsZV9p0RBS0xn98+9Tni1HVaFpKeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDy/kAfS8HcdvE6knkiOVO3mqPv6uUpy0XFt7UexwcTyyJVDqx
	9ZS6xcradxAut4wTDEW7Z1OFt2dKTamOEkPw2Kjzej1ROvQG/gANJI0T8JbN+eRYSOYGXg==
X-Google-Smtp-Source: AGHT+IFVxblwBsZVLpkF/wlyRk+n/tNaJXkE5BjYQ4XZYwoJJW7Z3LHpe4iEt/C7U7pvYZKCxhq62F8=
X-Received: from wmbep23.prod.google.com ([2002:a05:600c:8417:b0:43c:ef7b:ffac])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:37ce:b0:442:e109:3027
 with SMTP id 5b1f17b1804b1-451220ad6d4mr65615665e9.24.1748871417012; Mon, 02
 Jun 2025 06:36:57 -0700 (PDT)
Date: Mon,  2 Jun 2025 13:36:41 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602133653.1606388-1-bqe@google.com>
Subject: [PATCH v10 0/5] rust: adds Bitmap API, ID pool and bindings
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds a Rust bitmap API for porting the approach from
commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.

The Rust bitmap API provides a safe abstraction to underlying bitmap
and bitops operations. For now, only includes method necessary for
dbitmap.h, more can be added later. We perform bounds checks for
hardening, violations are programmer errors that result in panics.

We include set_bit_atomic and clear_bit_atomic operations. One has
to avoid races with non-atomic operations, which is ensure by the
Rust type system: either callers have shared references &bitmap in
which case the mutations are atomic operations. Or there is a
exclusive reference &mut bitmap, in which case there is no concurrent
access.

This version includes an optimization to represent the bitmap inline,
as suggested by Yury.

We ran a simple microbenchmark which shows that overall the Rust API 
can be expected to be about 4.5% slower than C API.

We introduce a Rust API that would replace (dbitmap.h) in file 
id_pool.rs. This data structure is tightly coupled to the bitmap API. 
Includes an example of usage that requires releasing a spinlock, as 
expected in Binder driver.

This is v10 of a patch introducing Rust bitmap API [v9]. Thanks
for all the helpful comments, this series has improved significantly
as a result of your work.

Changes v9 --> v10:
- change helper to use `unsigned long` for `nr` parameter (Boqun)
- add missing and fix safety comments (Boqun, Pekka)
- move benchmark module output and results to #4 commit msg.
- use pr_cont to avoid repeating find_bit_benchmark_rust log prefix.

Changes v8 --> v9:
- added a new type `CBitmap` that makes any C bitmap accessible with
  the same API, and add Deref so both Bitmap and
  CBitmap can share the same implementation.  Full credit for this 
  goes to Alice who suggested idea and code.
- added config dependency on CONFIG_RUST that was missing from
  CONIG_FIND_BIT_BENCHMARK_RUST.
- implemented Send for Bitmap, it is actually needed by Binder.
- reworded commit msg for clarity.
- removed unsafe for atomic ops.
- renamed `bitmap_hardening_assert` to `bitmap_assert` and make operations
  do nothing and log error when RUST_BITMAP_HARDENED is off.
- update author information in find_bit_benchmark_rust.rs
- Various improvements to id_pool, better names and comments.

Changes v7 --> v8:
- added Acked-by for bindings patches
- add RUST_BITMAP_HARDENED config, making extra bound-checks configurable.
  This is added to security/Kconfig.hardening 
- changed checks of `index` return value to >=
- removed change to FIND_BIT_BENCHMARK

Changes v6 --> v7:
- Added separate unit tests in bitmap.rs and benchmark module,
  following the example in find_bit_benchmark.c
- Added discussion about using vendored bitset to commit message.
- Refined warning about naming convention

Changes v5 --> v6:
- Added SAFETY comment for atomic operations.
- Added missing volatile to bitops set_bit and clear_bit bindings.
- Fixed condition on `nbits` to be <= i32::MAX, update SAFETY comments.
- Readability improvements.
- Updated doc comments wording and indentation.

Changes v4 --> v5: (suggested by Yury and Alice)
- rebased on next-20250318
- split MAINTAINERS changes
- no dependencies on [1] and [2] anymore - Viresh,
  please do add a separate section if you want to maintain cpumask.rs
  separately.
- imports atomic and non-atomic variants, introduces a naming convention
  set_bit and set_bit_atomic on the Rust side.
- changed naming and comments. Keeping `new`.
- change dynamic_id_pool to id_pool
- represent bitmap inline when possible
- add some more tests
- add myself to M: line for the Rust abstractions

Changes v3 --> v4:
- Rebased on Viresh's v3 [2].
- split into multiple patches, separate Rust and bindings. (Yury)
- adds dynamic_id_pool.rs to show the Binder use case. (Yury)
- include example usage that requires release of spinlock (Alice)
- changed bounds checks to `assert!`, shorter (Yury)
- fix param names in binding helpers. (Miguel)
- proper rustdoc formatting, and use examples as kunit tests. (Miguel)
- reduce number of Bitmap methods, and simplify API through
  use Option<usize> to handle the "not found" case.
- make Bitmap pointer accessors private, so Rust Bitmap API
  provides an actual abstraction boundary (Tamir)
- we still return `AllocError` in `Bitmap::new` in case client code
  asks for a size that is too large. Intentionally
  different from other bounds checks because it is not about
  access but allocation, and we expect that client code need
  never handle AllocError and nbits > u32::MAX situations
  differently.

Changes v2 --> v3:
- change `bitmap_copy` to `copy_from_bitmap_and_extend` which
  zeroes out extra bits. This enables dbitmap shrink and grow use
  cases while offering a consistent and understandable Rust API for
  other uses (Alice)

Changes v1 --> v2:
- Rebased on Yury's v2 [1] and Viresh's v3 [2] changes related to
  bitmap.
- Removed import of `bindings::*`, keeping only prefix (Miguel)
- Renamed panic methods to make more explicit (Miguel)
- use markdown in doc comments and added example/kunit test (Miguel)
- Added maintainer section for BITOPS API BINDINGS [RUST] (Yury)
- Added M: entry for bitmap.rs which goes to Alice (Viresh, Alice)
- Changed calls from find_* to _find_*, removed helpers (Yury)
- Use non-atomic __set_bit and __clear_bit from Bitmap Rust API (Yury)

Link [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.com/
Link [2] https://lore.kernel.org/rust-for-linux/cover.1742296835.git.viresh.kumar@linaro.org/
Link [v9] https://lore.kernel.org/rust-for-linux/20250526150141.3407433-1-bqe@google.com/

*** BLURB HERE ***

Burak Emir (5):
  rust: add bindings for bitmap.h
  rust: add bindings for bitops.h
  rust: add bitmap API.
  rust: add find_bit_benchmark_rust module.
  rust: add dynamic ID pool abstraction for bitmap

 MAINTAINERS                     |  15 +
 lib/Kconfig.debug               |  13 +
 lib/Makefile                    |   1 +
 lib/find_bit_benchmark_rust.rs  |  95 ++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/bitmap.c           |   9 +
 rust/helpers/bitops.c           |  23 ++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/bitmap.rs           | 588 ++++++++++++++++++++++++++++++++
 rust/kernel/id_pool.rs          | 222 ++++++++++++
 rust/kernel/lib.rs              |   2 +
 security/Kconfig.hardening      |  10 +
 12 files changed, 982 insertions(+)
 create mode 100644 lib/find_bit_benchmark_rust.rs
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs
 create mode 100644 rust/kernel/id_pool.rs

-- 
2.49.0.1204.g71687c7c1d-goog

