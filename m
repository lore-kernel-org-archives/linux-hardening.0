Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DE27713
	for <linux-hardening@vger.kernel.org>; Thu,  4 Sep 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004621; cv=none; b=pXjFqowL4axD3InEmGgLU6Yycg92/YU8e8rXLwKj7Oqms2L92vOY5Hld8uoNs2a9BXVLhLj6l0ZVKAfHkPBT9UvKT7O4d2zwgwVpPH9vxbOy8xANM4Ceipt1mrKgxyDlFtn1acFGHPR2820DwqMEomNFIt/vUOjop4yKil9rOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004621; c=relaxed/simple;
	bh=eAZ8pfbaoEypteMV747NomwE1hc0p47KjDxFyUhFRYw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A+8AnmeO4CL4nKS7Vsp8jL5VzmUAIxM/K9Y1CkaSz0q03gIbVSUO+nhiT2w/q+eTU2jYX+RZejwA9z+Im0m6H3m1PKCggxfi7gGH4iAN9+ONkBWmsmjgo4iPx+shDeFH4IdpK1XbVAMwmcff1iAamlWaZkxkaWs1pqL0T3C+Ycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+RRwzoH; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+RRwzoH"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9dc5c2ba0so674568f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 04 Sep 2025 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757004618; x=1757609418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8b7/XUFYjGLTtPaCMlyKu/PlgpxYgj/4qAzmA1kZ03E=;
        b=0+RRwzoH364u6KUS4UTr9xFGNJPblBGwn2gcJSeqSDSPRGjwcZvb66FLp1YlHQYAzb
         DhpM5BglV44j80wZkNVng4qhvH7Qppnh9bAH+kR+FtZA/SpHTRyN2+bW5YsbWCVfbvJB
         10SV6vq4jEK1JNaHg1/SEmaweWFf5tb+RpW1B0DLunxgRyu0TcQg4m/2+0yWHyl5wMe3
         6E1ajCufV8QgX+hUHOdSEYlr1NJpvTIrzgXW6+LT30Z7RcX+Vb/ZWp80296BqgIW+/Mb
         9dKuxOvJ34r4mDns3s2faLEjJdBrqw4d6/w6jAUc/VxY8n9zFtWGh1A9oG1bdut2RP+Q
         7aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004618; x=1757609418;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8b7/XUFYjGLTtPaCMlyKu/PlgpxYgj/4qAzmA1kZ03E=;
        b=RtrnCYbnFUpOh2d3SI6mko9RcKXiN/TCztOPu5g6ngldXA2gOynaS2oQ0OCd9D4qPf
         wY3DVMy9gj6R9UJjdOd9cy3RDSV+8jVWpcWDwteFIQUDW7h9AW1hq4cFd1VMAl3mRJEv
         EX7O/CQgg7/helGpuHjeg35XFwELKedOj4DxXgPBx6fJ+x+5VCsUBQCLMjB6cyD5IjLr
         qugjdSVQ2v9JA0hzRIHVs7rC56vbt96joVEqlsghLj6bK5r53pDGgpredL/XnQiF6l+n
         EDjN+KjBa2ShjZ4SbyhUyrLGznBePiMtxZCZwtDuJJGx0XMEKjSngmFSa26eRtiXTBoI
         hWPw==
X-Forwarded-Encrypted: i=1; AJvYcCXfCbEiGsspTa2uFUBJITIpyWqcmHNZqkmegLHEFUexA91m6GF8GIjhFu9rABOHXfcHXw50VDgFYitZ63CcxFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQPfJ5RgRWpXAsfwORTde6Ipaa38E8UIdpjYxvCRmoM52C+z4
	CBOweC0+Nz1C8FrYQ5JPB+Ukc0RO1W6R+9M/VFiUvPael1SH8NkeCWUHB/0rjJa7Vd1C0w==
X-Google-Smtp-Source: AGHT+IH1toEx+b5y7y/Qyp7BWtKrZQXOEKDEj3q6qAS0VaZ9qh7QZ6upHMiRioEKyfB4tzPWnIBSKjo=
X-Received: from wrce15.prod.google.com ([2002:adf:9bcf:0:b0:3d7:cd09:ae17])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:310e:b0:3c8:6b76:2ee9
 with SMTP id ffacd0b85a97d-3d1dcb764e0mr15298551f8f.19.1757004618425; Thu, 04
 Sep 2025 09:50:18 -0700 (PDT)
Date: Thu,  4 Sep 2025 16:50:04 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904165015.3791895-1-bqe@google.com>
Subject: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
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

We also introduce a Rust API in id_pool.rs that would replace 
dbitmap.h from the commit referenced above. This data structure is coupled 
with the bitmap API and adds support for growing and shrinking, along
with fine-grained control over when allocation happens. 
The Binder code needs this since it holds a spinlock at the time it
discovers that growing is necessary; this has to be release
for performing a memory allocation with GFP_KERNEL that may cause 
sleep.  We include example doctests that demonstrate this usage.

Thanks everyone for all the helpful comments, this series has improved 
significantly as a result of your work.

Changes v14 --> v15:
- Rebased on commit 08b06c30a445 ("Merge tag 'v6.17-rc4-ksmbd-fix' of git://git.samba.org/ksmbd")

Changes v13 --> v14:
- Rebased on commit 8742b2d8935f ("Merge tag 'pull-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")
- applied clippy suggestions for pointer casts
- in benchmark module, replace use of the Rust Ktime abstraction 
- in benchmark module, move newlines around for pr_cont to work
  with Instant, elapsed.
- added Alice's Reviewed-by tag

Changes v12 --> v13:
- Rebased on commit 75f5f23f8787 ("Merge tag 'block-6.16-20250619' of git://git.kernel.dk/linux")
- Renamed types CBitmap --> Bitmap, Bitmap --> BitmapVec.
- Rewrote unit tests to not use `unwrap()` but `Result` and `?`
- Replaced NonNull::as_mut() with NonNull::as_ptr()
- declared local BITS_PER_LONG usize constants, fixed rustdoc

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
Link [v14] https://lore.kernel.org/rust-for-linux/20250813153548.1650533-1-bqe@google.com/

Burak Emir (5):
  rust: add bindings for bitmap.h
  rust: add bindings for bitops.h
  rust: add bitmap API.
  rust: add find_bit_benchmark_rust module.
  rust: add dynamic ID pool abstraction for bitmap

 MAINTAINERS                     |  15 +
 lib/Kconfig.debug               |  13 +
 lib/Makefile                    |   1 +
 lib/find_bit_benchmark_rust.rs  | 104 ++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/bitmap.c           |   9 +
 rust/helpers/bitops.c           |  23 ++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/bitmap.rs           | 597 ++++++++++++++++++++++++++++++++
 rust/kernel/id_pool.rs          | 226 ++++++++++++
 rust/kernel/lib.rs              |   2 +
 security/Kconfig.hardening      |  10 +
 12 files changed, 1004 insertions(+)
 create mode 100644 lib/find_bit_benchmark_rust.rs
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs
 create mode 100644 rust/kernel/id_pool.rs


base-commit: 08b06c30a44555a8b1d14950e4462a52bfa0758b
-- 
2.51.0.355.g5224444f11-goog

