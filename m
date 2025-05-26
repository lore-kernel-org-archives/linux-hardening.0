Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F001388
	for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271708; cv=none; b=cl73Nfn/eEB57FXTEmOL2zrN42l3MW/jNTSV90A3cahxzyO+f4BbZJdUndDm4qUj38+2hRb8y0468wOjYroH4eZyNEXqSnT5WOy2QLISHXWiK67djth5O6oApzVFNmenntvFCm3j+gXGhAIIAZKbjUWs/3YMeIEoq+gDdg8SCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271708; c=relaxed/simple;
	bh=v0KQm/WJwXviltRfc1vi6oynkiWfboC7WCh0qKJDMaI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oAFGB9xGJZMhRQVGiNhrGPYCQBMklRT4Bn9vT00XWgzmXLU0L7qHfaVhzbKh+6BkrhLr6d4ecEShLtQ42QmLW3A5ulqqpuQ1wnbhlcuQANbGcIbatAWgi6QJ8lxOd2SQdvw7LNeOtMXJTBmfR7u+kouS+aGJVGAOsSdr0+4AEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZyicjSq; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZyicjSq"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a3684a5655so1171494f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748271704; x=1748876504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HW7TU1+evSIvemzcZY+e+hhe6NWVCkz71V2mJEakLFU=;
        b=rZyicjSq71QT6qqTatEelXsr4a+PSvxA6rEbl52wbEzn3f/tOBPOgoUGvqbQzhtEja
         DhlSNeIk8fY3i/6mxhbYaEmiS2qway/OuPab0en+IH/RpP/SN4RHBdNiKekVZQp6Soxo
         XZQfHSDOdn41ozEO8gwz8ZVBUgNm7wKj9oERxYR6ZYW2KfMZExiOf/8f76L2OgYVrcaw
         y4ayC6eGMi+olmw2Qw1RzvNF5lQlSpR/UyMzw50eAhTh7mXk7N6YrBQfuMGjkNnZWXE8
         vIAC1RmFOvgzy6V3eZP3fI7icrU7hw46AYwxPPZJ7bniY2IW8wfTGZXM7pftlxEQRi0q
         iZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748271704; x=1748876504;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HW7TU1+evSIvemzcZY+e+hhe6NWVCkz71V2mJEakLFU=;
        b=NBXlpP2SX77TqGNmB3MJk0RWCRqzDSMG8OCZnaXn+gWnKNy7CVBbRMrCrLYRt/kr9Y
         RvFW74oAqstccFBUDl5theRL0KTCyTXDD8TOjSaVbMrh/EtR3lVYSsMRoAtdh6VI3mQv
         hmhjOz5Wbwz0txkov9v2+9S2BLLWhTj2NQTr7WLZgw1DLwhRllR9us3gRunQzgACDteC
         jQJvooyITFkcft7dwN1rIAyCdUMO0mljNiF1DmR9iA3z1dfp4QbHiiNu7r47uf0j3aeE
         Di6hjS6zSf4VkdW0W5izFQtve2ZwmNvwyROF5LcFJKh9TNfVOGha2Jr2Y+XsYXasYbkE
         m5gA==
X-Forwarded-Encrypted: i=1; AJvYcCWX+urupL9mv/aqcPZ/rcIq93MRn/lXreb2tkOiOhZii0cIQ9sZ4YISNIB5/1EdMNq02U5+y2O2cSA2En17GOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyggA6xRekOT91BRGP8wiVaVmMj+SDazJjk6KtpYR3TJCzsTNZ5
	Wuyug2QP1ca6hPiin0hSgYAP/nG+i4FBIi09hpMl8kGuUgdG73TEgi7AQf+MqzgPLdiVkA==
X-Google-Smtp-Source: AGHT+IHDj8El1t6EprDIxCVSwgkfNDj80ioimIhk/WFuBA+5L11rO5dlFh4KrGcfa7jS4aiYyQpFLQc=
X-Received: from wmbea8.prod.google.com ([2002:a05:600c:6748:b0:43d:4ba5:b5d6])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2907:b0:3a4:dfc2:2a3e
 with SMTP id ffacd0b85a97d-3a4dfc22a80mr383390f8f.39.1748271704342; Mon, 26
 May 2025 08:01:44 -0700 (PDT)
Date: Mon, 26 May 2025 15:01:29 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250526150141.3407433-1-bqe@google.com>
Subject: [PATCH v9 0/5] rust: adds Bitmap API, ID pool and bindings
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

We ran a simple benchmark (sample size 32), with RUST_BITMAP_HARDENED=n
on a x86_64 production machine that was not running other processes.

Results for random-filled bitmap:
+------------+------+-----------+--------------+-----------+-----------+
| Benchmark  | Code | Mean (ns) | Std Dev (ns) | 95% CI Lo | 95% CI Hi |
+------------+------+-----------+--------------+-----------+-----------+
| find_bit/  | C    |      5.18 |         0.32 |      5.17 |      5.18 |
| next_bit   | Rust |      5.30 |         0.37 |      5.30 |      5.31 |
+------------+------+-----------+--------------+-----------+-----------+
| find_zero/ | C    |      5.66 |         0.33 |      5.66 |      5.67 |
| next_zero  | Rust |      5.88 |         0.32 |      5.88 |      5.89 |
+------------+------+-----------+--------------+-----------+-----------+

Results for sparse bitmap:
+------------+------+-----------+--------------+-----------+-----------+
| Benchmark  | Code | Mean (ns) | Std Dev (ns) | 95% CI Lo | 95% CI Hi |
+------------+------+-----------+--------------+-----------+-----------+
| find_bit/  | C    |     22.51 |        12.34 |     22.38 |     22.65 |
| next_bit   | Rust |     30.53 |        20.44 |     30.30 |     30.75 |
+------------+------+-----------+--------------+-----------+-----------+
| find_zero/ | C    |      5.69 |         0.22 |      5.68 |      5.69 |
| next_zero  | Rust |      5.68 |         0.29 |      5.68 |      5.68 |
+------------+------+-----------+--------------+-----------+-----------+

We introduce a Rust API that would replace (dbitmap.h) in file 
id_pool.rs. This data structure is tightly coupled to the bitmap API. 
Includes an example of usage that requires releasing a spinlock, as 
expected in Binder driver.

This is v9 of a patch introducing Rust bitmap API [v7]. Thanks
for all the helpful comments, this series has improved significantly
as a result of your work.

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
Link [v8] https://lore.kernel.org/rust-for-linux/20250519161712.2609395-1-bqe@google.com/

Burak Emir (6):
  rust: add bindings for bitmap.h
  rust: add bindings for bitops.h
  rust: add bitmap API.
  bitmap: fix find_bit_benchmark module name and config description
  rust: add find_bit_benchmark_rust module.
  rust: add dynamic ID pool abstraction for bitmap

 MAINTAINERS                     |  15 ++
 lib/Kconfig.debug               |  18 +-
 lib/Makefile                    |   1 +
 lib/find_bit_benchmark_rust.rs  |  94 +++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/bitmap.c           |   9 +
 rust/helpers/bitops.c           |  23 ++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/bitmap.rs           | 429 ++++++++++++++++++++++++++++++++
 rust/kernel/id_pool.rs          | 201 +++++++++++++++
 rust/kernel/lib.rs              |   2 +
 security/Kconfig.hardening      |  11 +
 12 files changed, 805 insertions(+), 2 deletions(-)
 create mode 100644 lib/find_bit_benchmark_rust.rs
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs
 create mode 100644 rust/kernel/id_pool.rs

-- 
2.49.0.1101.gccaa498523-goog

Burak Emir (5):
  rust: add bindings for bitmap.h
  rust: add bindings for bitops.h
  rust: add bitmap API.
  rust: add find_bit_benchmark_rust module.
  rust: add dynamic ID pool abstraction for bitmap

 MAINTAINERS                     |  15 +
 lib/Kconfig.debug               |  13 +
 lib/Makefile                    |   1 +
 lib/find_bit_benchmark_rust.rs  |  94 ++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/bitmap.c           |   9 +
 rust/helpers/bitops.c           |  23 ++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/bitmap.rs           | 568 ++++++++++++++++++++++++++++++++
 rust/kernel/id_pool.rs          | 222 +++++++++++++
 rust/kernel/lib.rs              |   2 +
 security/Kconfig.hardening      |  10 +
 12 files changed, 961 insertions(+)
 create mode 100644 lib/find_bit_benchmark_rust.rs
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs
 create mode 100644 rust/kernel/id_pool.rs

-- 
2.49.0.1151.ga128411c76-goog

