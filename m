Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C528935B
	for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671454; cv=none; b=Wn/LXQI8kKMUlVQa4wYyLGlS5n6s6wT7IC1QnE1Pp+dnI7xsXQ9za4ir0KxAQfj6hYTo85mmyIK1VjdvSxkM2KSNRKWb2u+/SWEdGWLh2qDZIBeMw4jCq4KgYkiXmM34ZMoaciaDeQ6oI9K4RxO6n136p1ZtCUiGjnkbphqYo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671454; c=relaxed/simple;
	bh=w4805dO/Ig3x8k08b19zw0IolP9xDo4xh/Wo3cFOHaY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YO4QBq1+pV+Vw/vm5OlvHIOtX2XkkvfaNupWii6qkPBqofddV3YzQK4KvjgrKs1d5TSfD/n2TLlwfPTVniK2yeRsx5Sd5vu+ZEdsjOlHeiPWqLumkVzc9KGpPF0O4ZYE6IVdYMmEhK6PITPbqgdeB5oapk+mJVjYfXCBCXrvlU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iRQBqeGv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iRQBqeGv"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-445135eb689so12172285e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747671450; x=1748276250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bmVOMUI1WvRgcBItQU4h3P9G6X6eBSLhh3A0eVCy3IM=;
        b=iRQBqeGvXeg+9pQNvUDzm67icnw2gGoP4TKPFgvTZtIXodJFio468rhkCQwmHSNrhF
         A4r/6yUn3SwmYOkWLkKkZFKkA7lUQkqdbLBXKzAghzDtFV0cNcJtUPdaAx8BdXg4A6Up
         vkJLKHPZXLWetuuNJkiMZNUIOiESoHRlgGPf2ff0VaQe9msrs8BN6mYWSl9M3qYelTkO
         CZKvhEhn26L4uXVjp+MTKC+c0lWaADRA6e8cc5PARgHNW2t2z5z0ymSuCnW/UI0fEsJU
         xbSIEXiIsZxHwH08ASRMgsYJ0yXJWN26Ed7xLkWt4iRJY0vTuFiqyMTliiSo59h4Avtm
         +GBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747671450; x=1748276250;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmVOMUI1WvRgcBItQU4h3P9G6X6eBSLhh3A0eVCy3IM=;
        b=IK0uFG+l+LUHmBX57nXZS7BPebGhkYoE3UmlzUWQPXYOJChi5xwepl8fAxibr6hwWT
         HdA3FHntKiq897h9+Z/yCuvdKy/wTFSSVOE+i2p1Pqgp7Y9TwM8BZobZLiwzflVZpnpF
         IwbDm4tuV6rkYNe5JTTDgxMU2eTEFny47zkPk34SZyAc0HWCXBJTtVdfmioYcgftPcbc
         6irArKBxkh6CrsdyAoR57imtXW1WLQTsF3vYZ9sovhIWS1Tlk7+l6Cjno6geG42WPpHk
         6nXtBezLesYrZnGrFc/Ec9X7vLI4HFM/HLDqvRYl/I5NclQRTTx7hk202xzh32KhtBGs
         YayA==
X-Forwarded-Encrypted: i=1; AJvYcCVvEruqyrHBIWyNtT7PoClvrH8wMjF3EYHRcTl7REC5zk9lSe0gGHrjQTYXD7i20UltiW+Uv9oI1QrGLVRREqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37UhhhazbdoCMLaENaoMHEGOSN9CNFe525sOgL/UYR0H7Ibue
	mNHcpty6s3FoI5mafNgZNiNv/62dl3NA+qG+diCs51jzIS5j4EZG4BOi+/5eqOEuPvAPdw==
X-Google-Smtp-Source: AGHT+IFROh9k9MaFF3iOzIZxe2AJZZMZ1n+PtPhwpVT2M5DZgzoJ38wpUziZRxscydtaggZ7lYDT1Dc=
X-Received: from wmsp4.prod.google.com ([2002:a05:600c:1d84:b0:43c:f8ae:4d6c])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3e0a:b0:43c:e478:889
 with SMTP id 5b1f17b1804b1-442fd5a2c09mr156959735e9.0.1747671450127; Mon, 19
 May 2025 09:17:30 -0700 (PDT)
Date: Mon, 19 May 2025 16:17:00 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519161712.2609395-1-bqe@google.com>
Subject: [PATCH v8 0/5] rust: adds Bitmap API, ID pool and bindings
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
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

A benchmark using a production configuration shows performance on par
with C:

```
              Start testing find_bit() with random-filled bitmap
[    6.974435] find_next_bit:                  944136 ns, 163996 iterations
[    6.982039] find_next_zero_bit:             981618 ns, 163685 iterations
[    6.989460] find_last_bit:                  800630 ns, 163996 iterations
[    7.004710] find_nth_bit:                  8627435 ns,  16281 iterations
[    7.013791] find_first_bit:                2459789 ns,  16282 iterations
[    7.054645] find_first_and_bit:           34227540 ns,  32733 iterations
[    7.061743] find_next_and_bit:              474530 ns,  73676 iterations
[    7.068365] 
               Start testing find_bit() with sparse bitmap
[    7.075035] find_next_bit:                   11394 ns,    656 iterations
[    7.083579] find_next_zero_bit:            1920337 ns, 327025 iterations
[    7.090213] find_last_bit:                   12061 ns,    656 iterations
[    7.100121] find_nth_bit:                  3279811 ns,    655 iterations
[    7.107930] find_first_bit:                1188115 ns,    656 iterations
[    7.114558] find_first_and_bit:               3730 ns,      1 iterations
[    7.121184] find_next_and_bit:                4679 ns,      1 iterations
[    7.127805] find_bit_benchmark_rust_module: Start testing find_bit() Rust with random-filled bitmap
[    7.138550] find_bit_benchmark_rust_module: next_bit:                       999542 ns, 163592 iterations
[    7.148974] find_bit_benchmark_rust_module: next_zero_bit:                 1053432 ns, 164088 iterations
[    7.158342] find_bit_benchmark_rust_module: Start testing find_bit() Rust with sparse bitmap
[    7.166718] find_bit_benchmark_rust_module: next_bit:                        11474 ns,    655 iterations
[    7.178143] find_bit_benchmark_rust_module: next_zero_bit:                 2056913 ns, 327025 iterations
```

We introduce a Rust API that would replace (dbitmap.h) in file 
id_pool.rs. This data structure is tightly coupled to the bitmap API. 
Includes an example of usage that requires releasing a spinlock, as expected
in Binder driver.

This is v8 of a patch introducing Rust bitmap API [v7]. Thanks
for all the helpful comments, this series has improved significantly
as a result of your work.

Changes v7 --> v8:
- added Acked-by for bindings patches
- add RUST_BITMAP_HARDENED config, making the extra bound-checks configurable.
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
Link [v7] https://lore.kernel.org/rust-for-linux/20250423134344.3888205-2-bqe@google.com/



Burak Emir (5):
  rust: add bindings for bitmap.h
  rust: add bindings for bitops.h
  rust: add bitmap API.
  rust: add find_bit_benchmark_rust module.
  rust: add dynamic ID pool abstraction for bitmap

 MAINTAINERS                     |  15 ++
 lib/Kconfig.debug               |  13 +
 lib/Makefile                    |   1 +
 lib/find_bit_benchmark_rust.rs  |  94 +++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/bitmap.c           |   9 +
 rust/helpers/bitops.c           |  23 ++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/bitmap.rs           | 429 ++++++++++++++++++++++++++++++++
 rust/kernel/id_pool.rs          | 201 +++++++++++++++
 rust/kernel/lib.rs              |   2 +
 security/Kconfig.hardening      |   9 +
 12 files changed, 800 insertions(+)
 create mode 100644 lib/find_bit_benchmark_rust.rs
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs
 create mode 100644 rust/kernel/id_pool.rs

-- 
2.49.0.1101.gccaa498523-goog

