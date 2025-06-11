Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594522BD5A0
	for <linux-hardening@vger.kernel.org>; Wed, 11 Jun 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671329; cv=none; b=bvox8EH8yr4TAY1JU638P12EEb98hKEO5k6TojQH8wdugwx7ye04YpPAoN4R+kUKgaqA2fVKuBuGVda6FfantbDzoVcBjIJ02vi1Oz1Sr48QGp8c85bYgmQb3i4CJksbtIV4Nd7QTKh4F/QMX7Hk0DuZIgaXnuUk1wNOdmFoWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671329; c=relaxed/simple;
	bh=XICA4ok1LD+I/Kx3yMPe8PphL1CkulIAlv1d2qbEvNI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pL0yAM75nXPXp6KZv0IIrOSfOC+w9Kdussp5fIEDzYFrxvtJsMRmYpKRIls5UMx0wamGK68j1s/eUcUbkjlDKLhkunS+SVAgX/cuSYI3sB5Do3e9+afg5byZLF/8q09D3v8CN7+wMg8fXBH18fU+3zlXCMwrEA1r8wc1w2LEHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjBSz5SM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjBSz5SM"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4530623eb8fso813915e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 Jun 2025 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749671325; x=1750276125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jlvw0fpAdOGH9Y4eL+cynC8BGydUOcy3zpj19PY7taQ=;
        b=SjBSz5SMETvvTrCNqsKl8oNxlbMS/vSKKxv9ohSti7sdDA9M6d9yYwlglPH25dV81G
         y4fc/EYsAUxip4rovRlrn/G4JayaoUT7mllHW9lZ2hBj9l1x/13n0g0EwnLTXr53NnIx
         mxq2zUfzHq4Sj6bsOxL+quQ2cmlpKLwNoJjPjti2twaUZ2jzgG8lJdA1SKJVQF+94/ny
         kwDy+h9r5yQd8RVgxjK2/1XOV8Ee0zLZT0fuY2NdRXMWbizzci5FmvAaaDJ8RIAXWV9g
         YL5A96Z3ykdP4XVGTNuqUmaOGWvfAXuxhotXGtdEfgLv1/ZqkfcOj0wRdbyag+C4h/EQ
         WzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749671325; x=1750276125;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jlvw0fpAdOGH9Y4eL+cynC8BGydUOcy3zpj19PY7taQ=;
        b=OillIo3pUmuQ0cqCS3YPTefDbERr93SHJp0CxVzUVSEMNPxpmaHNr7iUsXN0t4ATR6
         Xyrj18aodjULPXPO7vgKugDbFFmjpqQoq+4SHTmwSFKxllXLMNPZDR5v8bZYB9dSKdbM
         BoALKWfvsjcwX/K4EeBaG8HAEBG/qHMCifWTTpQOmvSATbONOZtb7ko5WYVwUYb3knP1
         thZVaI+DYW50NQn0wz7lwYtgZclBVHkyMJJnsSdiCSfT/QtGDWfn4qBgkE1XvN/MFZ7b
         pmKtulFAM5GUJsVNsOklrklD9BGYsCgqJrEamqRj3lpLmasrwXBYrl7AqY86m6/6kSPb
         Syew==
X-Forwarded-Encrypted: i=1; AJvYcCUWbXPlT7BE0kCu5R+wWFsUUsuF0p8Q5lqB4XsZvlIfvNHts1lwjTlXnhpizt5geL3sr9ixUhXAzDNM3gNgyok=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvd2v8OOR2hYZPGA2uUGgcpAWefhWtwQ0EzbmWA8e4S5NtsWc9
	OpoX/3h+7hlsY3aVYz/zRS+as36dhLalRpWNgvLrhYJvDLK5pIRaRTMEvzbi0DANfdveFQ==
X-Google-Smtp-Source: AGHT+IHl8vGYVhIrxJxpAz4SYf0zRP6pj4Q2Dh9O+sOiarUpKtjt4nLk7bw7U3RP/zh/IVsR/4rcO6s=
X-Received: from wmsr14.prod.google.com ([2002:a05:600c:8b0e:b0:450:ce9d:a742])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f95:b0:43d:172:50b1
 with SMTP id 5b1f17b1804b1-453248dbf28mr43607595e9.29.1749671324897; Wed, 11
 Jun 2025 12:48:44 -0700 (PDT)
Date: Wed, 11 Jun 2025 19:48:33 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611194840.877308-1-bqe@google.com>
Subject: [PATCH v12 0/5] rust: adds Bitmap API, ID pool and bindings
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

This series includes an optimization to represent the bitmap inline,
as suggested by Yury.

We ran a simple microbenchmark which shows that overall the Rust API 
can be expected to be about 4.5% slower than C API.

We introduce a Rust API that would replace (dbitmap.h) in file 
id_pool.rs. This data structure is tightly coupled to the bitmap API. 
Includes an example of usage that requires releasing a spinlock, as 
expected in Binder driver. The fine-grained API that permits 
releasing a spinlock is necessary as the Binder code holds it,
yet needs to perform a memory allocation with GFP_KERNEL that may cause 
sleep.

This is v12 of a patch introducing Rust bitmap API [v11]. Thanks
for all the helpful comments, this series has improved significantly
as a result of your work.

Changes v11 --> v12:
- Added Reviewed-by tag, changed named of benchmark module
- Fixed config, rustdoc, clippy and bytes computation (Pekka).
- Added test that exercises CONFIG_RUST_BITMAP_HARDENED,
  verified it panics.
- Had to add a break to benchmark module, for the
  CONFIG_RUST_BITMAP_HARDENED case which enforces bounds check.

Changes v10 --> v11:
- Fix Kconfig dependency, Rust benchmark depends on CONFIG_RUST
- Disable clippy warning for len() without is_empty() in id_pool.rs

Changes v9 --> v10:
- change helper to use `unsigned long` for `nr` parameter (Boqun)
- add missing and fix safety comments (Boqun, Pekka)
- move benchmark module output and results to #4 commit msg.
- use pr_cont to avoid repeating find_bit_benchmark_rust log prefix.
- Disable clippy warning for len() without is_empty() in bitmap.rs

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
Link [v11] https://lore.kernel.org/rust-for-linux/20250602135231.1615281-1-bqe@google.com

Burak Emir (5):
  rust: add bindings for bitmap.h
  rust: add bindings for bitops.h
  rust: add bitmap API.
  rust: add find_bit_benchmark_rust module.
  rust: add dynamic ID pool abstraction for bitmap

 MAINTAINERS                     |  15 +
 lib/Kconfig.debug               |  13 +
 lib/Makefile                    |   1 +
 lib/find_bit_benchmark_rust.rs  | 103 ++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/bitmap.c           |   9 +
 rust/helpers/bitops.c           |  23 ++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/bitmap.rs           | 597 ++++++++++++++++++++++++++++++++
 rust/kernel/id_pool.rs          | 223 ++++++++++++
 rust/kernel/lib.rs              |   2 +
 security/Kconfig.hardening      |  10 +
 12 files changed, 1000 insertions(+)
 create mode 100644 lib/find_bit_benchmark_rust.rs
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs
 create mode 100644 rust/kernel/id_pool.rs

-- 
2.50.0.rc1.591.g9c95f17f64-goog

