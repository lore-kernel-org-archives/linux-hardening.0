Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF52E7BCA
	for <linux-hardening@vger.kernel.org>; Mon,  8 Sep 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316129; cv=none; b=fw0qA8/7DnjS3C3dgHJ/z0sVX6VZErC62fLjn3kUGysC7cI53g7GsCZu09aomUiQS3DA3+v3ys08l9o48pHnQVAtV1OFT3x5OWOnP7TyhFeg06qCk/UvgtFEB/mS7Mgd6VIB2K8fIeUX0CXE6Y+VeIa6VVE0t6RfyEZa3KVuWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316129; c=relaxed/simple;
	bh=pmqS3evNc5oxoiYApVyvCuJZfNi/fP6gQHZHJm2XXkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BgMlC9xw6ySy2Xjd/CXekmqMVsk7A9KK8Q7RopDsIO2MB2cHSGEIykXqxOgpwlfrWnN07mRWT6AR9YqF/IVjeuaJnIU2aSPPjLxKOkMWiNjOHqF+cmZ/bar614IQrZLtGxJY6vkCucHW85N5F72uU2b5OuwohSSZ75B1A8ZWyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lCsDpyq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lCsDpyq"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e424a186fcso1111787f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 08 Sep 2025 00:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757316125; x=1757920925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwOBttLcfP3y909J4CXHqY+uMaR7wzzUE7W3TRjyS/Q=;
        b=1lCsDpyqtDOudhn07Zp3mYaQBNP531gP2tb2cVwO46VJFB+KfHP3xdw/bNvfN00ydP
         iWaFj6z1UQnf7aaFjYFkkAJpO6bul+34kRw/M2BL24sjVBy1RC54ki1eccccIXoooInq
         G22T513+TbDegh6YuR253hSwhrvCEk6K7TbKARFIzf6ICaDGJovgp/UACipGi6/olCqr
         8uV5aq9kSBWiHnFnVW5fT1/JxHDgfLTr9bU2dQf6/Lk1Ynywv324k2BlbA2RFOLZuE+a
         LHb/y0CwlZx19//RIDep80MLXb/lnk+7XNNoiqpmZDNyckxqVSyVWPBysuk5Wyc3Nt1X
         o5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757316125; x=1757920925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwOBttLcfP3y909J4CXHqY+uMaR7wzzUE7W3TRjyS/Q=;
        b=flgmNraGcmdxUXsv+fWC1gVGGN+3LT7VQcYl7PIh9f0yGnXAlgnWpeEnd/JjzDDqrI
         KaYMvCO+qeio77CSmjYalN35seeAM/D3czvucN11ja7DLokQ391hmJLaaANBnS9F5x1V
         e79lLBYLOYAH6E43w79y8C+KV4VcRBM+liHewqMu6Ie7ORl755vKhFlZUwMQUPg9FLQ2
         6E2GPXz+0sIOUVQkPMlVxxa4n4sLuBe68s7m96Qcsr9gqGkYNhZQmxiTRYrvRzIcyyZF
         hBLaYQkdiJRl5nVTR3yNuAdhujUeY1p+J3zgtm2r+ppAS6RuThr2s+U3NhSX0nb2C1uz
         iMbg==
X-Forwarded-Encrypted: i=1; AJvYcCXQsLZVuO77iZwcTgmJSLXNzyIuwWJdx4xfmgbl1cQ3RDAKqxg0nyt+TTFQY24fyHOoyWRnpc7ctEVsxTrpmNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfd+mHtx4DqdPoYKutOLe1sxotypmeUaFeUBRomFDL6OnaH0X
	iywxe90iZ4EEHFS6dveZlpLRZWKYCMC7fhxDdX0ouwie3XS3/o5sql/3McOiLAQngffLiQ==
X-Google-Smtp-Source: AGHT+IH7qGezYAQxCu5HJIfGQ38GlEMYOXtx+3BqAEho8c7/diV+LhX1oBeAhCEjb2YLeNyh32GKXw8=
X-Received: from wrpk18.prod.google.com ([2002:adf:f5d2:0:b0:3d6:801b:c728])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64e3:0:b0:3e5:955d:a81b
 with SMTP id ffacd0b85a97d-3e64392d35bmr4582712f8f.34.1757316124583; Mon, 08
 Sep 2025 00:22:04 -0700 (PDT)
Date: Mon,  8 Sep 2025 07:21:55 +0000
In-Reply-To: <20250908072158.1041611-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908072158.1041611-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250908072158.1041611-6-bqe@google.com>
Subject: [PATCH v16 5/5] rust: add dynamic ID pool abstraction for bitmap
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

This is a port of the Binder data structure introduced in commit
15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
Rust.

Like drivers/android/dbitmap.h, the ID pool abstraction lets
clients acquire and release IDs. The implementation uses a bitmap to
know what IDs are in use, and gives clients fine-grained control over
the time of allocation. This fine-grained control is needed in the
Android Binder. We provide an example that release a spinlock for
allocation and unit tests (rustdoc examples).

The implementation does not permit shrinking below capacity below
BITS_PER_LONG.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS            |   1 +
 rust/kernel/id_pool.rs | 226 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 3 files changed, 228 insertions(+)
 create mode 100644 rust/kernel/id_pool.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index a720ebab334c..6fb79d990e4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4309,6 +4309,7 @@ R:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
 F:	lib/find_bit_benchmark_rust.rs
 F:	rust/kernel/bitmap.rs
+F:	rust/kernel/id_pool.rs
 
 BITOPS API
 M:	Yury Norov <yury.norov@gmail.com>
diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
new file mode 100644
index 000000000000..a41a3404213c
--- /dev/null
+++ b/rust/kernel/id_pool.rs
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Rust API for an ID pool backed by a [`BitmapVec`].
+
+use crate::alloc::{AllocError, Flags};
+use crate::bitmap::BitmapVec;
+
+const BITS_PER_LONG: usize = bindings::BITS_PER_LONG as usize;
+
+/// Represents a dynamic ID pool backed by a [`BitmapVec`].
+///
+/// Clients acquire and release IDs from unset bits in a bitmap.
+///
+/// The capacity of the ID pool may be adjusted by users as
+/// needed. The API supports the scenario where users need precise control
+/// over the time of allocation of a new backing bitmap, which may require
+/// release of spinlock.
+/// Due to concurrent updates, all operations are re-verified to determine
+/// if the grow or shrink is sill valid.
+///
+/// # Examples
+///
+/// Basic usage
+///
+/// ```
+/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+/// use kernel::id_pool::IdPool;
+///
+/// let mut pool = IdPool::new(64, GFP_KERNEL)?;
+/// for i in 0..64 {
+///     assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
+/// }
+///
+/// pool.release_id(23);
+/// assert_eq!(23, pool.acquire_next_id(0).ok_or(ENOSPC)?);
+///
+/// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
+/// let resizer = pool.grow_request().ok_or(ENOSPC)?.realloc(GFP_KERNEL)?;
+/// pool.grow(resizer);
+///
+/// assert_eq!(pool.acquire_next_id(0), Some(64));
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// Releasing spinlock to grow the pool
+///
+/// ```no_run
+/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+/// use kernel::sync::{new_spinlock, SpinLock};
+/// use kernel::id_pool::IdPool;
+///
+/// fn get_id_maybe_realloc(guarded_pool: &SpinLock<IdPool>) -> Result<usize, AllocError> {
+///     let mut pool = guarded_pool.lock();
+///     loop {
+///         match pool.acquire_next_id(0) {
+///             Some(index) => return Ok(index),
+///             None => {
+///                 let alloc_request = pool.grow_request();
+///                 drop(pool);
+///                 let resizer = alloc_request.ok_or(AllocError)?.realloc(GFP_KERNEL)?;
+///                 pool = guarded_pool.lock();
+///                 pool.grow(resizer)
+///             }
+///         }
+///     }
+/// }
+/// ```
+pub struct IdPool {
+    map: BitmapVec,
+}
+
+/// Indicates that an [`IdPool`] should change to a new target size.
+pub struct ReallocRequest {
+    num_ids: usize,
+}
+
+/// Contains a [`BitmapVec`] of a size suitable for reallocating [`IdPool`].
+pub struct PoolResizer {
+    new: BitmapVec,
+}
+
+impl ReallocRequest {
+    /// Allocates a new backing [`BitmapVec`] for [`IdPool`].
+    ///
+    /// This method only prepares reallocation and does not complete it.
+    /// Reallocation will complete after passing the [`PoolResizer`] to the
+    /// [`IdPool::grow`] or [`IdPool::shrink`] operation, which will check
+    /// that reallocation still makes sense.
+    pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
+        let new = BitmapVec::new(self.num_ids, flags)?;
+        Ok(PoolResizer { new })
+    }
+}
+
+impl IdPool {
+    /// Constructs a new [`IdPool`].
+    ///
+    /// A capacity below [`BITS_PER_LONG`] is adjusted to
+    /// [`BITS_PER_LONG`].
+    ///
+    /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
+    #[inline]
+    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
+        let num_ids = core::cmp::max(num_ids, BITS_PER_LONG);
+        let map = BitmapVec::new(num_ids, flags)?;
+        Ok(Self { map })
+    }
+
+    /// Returns how many IDs this pool can currently have.
+    #[inline]
+    pub fn capacity(&self) -> usize {
+        self.map.len()
+    }
+
+    /// Returns a [`ReallocRequest`] if the [`IdPool`] can be shrunk, [`None`] otherwise.
+    ///
+    /// The capacity of an [`IdPool`] cannot be shrunk below [`BITS_PER_LONG`].
+    ///
+    /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::id_pool::{ReallocRequest, IdPool};
+    ///
+    /// let mut pool = IdPool::new(1024, GFP_KERNEL)?;
+    /// let alloc_request = pool.shrink_request().ok_or(AllocError)?;
+    /// let resizer = alloc_request.realloc(GFP_KERNEL)?;
+    /// pool.shrink(resizer);
+    /// assert_eq!(pool.capacity(), kernel::bindings::BITS_PER_LONG as usize);
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn shrink_request(&self) -> Option<ReallocRequest> {
+        let cap = self.capacity();
+        // Shrinking below [`BITS_PER_LONG`] is never possible.
+        if cap <= BITS_PER_LONG {
+            return None;
+        }
+        // Determine if the bitmap can shrink based on the position of
+        // its last set bit. If the bit is within the first quarter of
+        // the bitmap then shrinking is possible. In this case, the
+        // bitmap should shrink to half its current size.
+        let Some(bit) = self.map.last_bit() else {
+            return Some(ReallocRequest {
+                num_ids: BITS_PER_LONG,
+            });
+        };
+        if bit >= (cap / 4) {
+            return None;
+        }
+        let num_ids = usize::max(BITS_PER_LONG, cap / 2);
+        Some(ReallocRequest { num_ids })
+    }
+
+    /// Shrinks pool by using a new [`BitmapVec`], if still possible.
+    #[inline]
+    pub fn shrink(&mut self, mut resizer: PoolResizer) {
+        // Between request to shrink that led to allocation of `resizer` and now,
+        // bits may have changed.
+        // Verify that shrinking is still possible. In case shrinking to
+        // the size of `resizer` is no longer possible, do nothing,
+        // drop `resizer` and move on.
+        let Some(updated) = self.shrink_request() else {
+            return;
+        };
+        if updated.num_ids > resizer.new.len() {
+            return;
+        }
+
+        resizer.new.copy_and_extend(&self.map);
+        self.map = resizer.new;
+    }
+
+    /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if possible.
+    ///
+    /// The capacity of an [`IdPool`] cannot be grown above [`i32::MAX`].
+    #[inline]
+    pub fn grow_request(&self) -> Option<ReallocRequest> {
+        let num_ids = self.capacity() * 2;
+        if num_ids > i32::MAX.try_into().unwrap() {
+            return None;
+        }
+        Some(ReallocRequest { num_ids })
+    }
+
+    /// Grows pool by using a new [`BitmapVec`], if still necessary.
+    ///
+    /// The `resizer` arguments has to be obtained by calling [`Self::grow_request`]
+    /// on this object and performing a [`ReallocRequest::realloc`].
+    #[inline]
+    pub fn grow(&mut self, mut resizer: PoolResizer) {
+        // Between request to grow that led to allocation of `resizer` and now,
+        // another thread may have already grown the capacity.
+        // In this case, do nothing, drop `resizer` and move on.
+        if resizer.new.len() <= self.capacity() {
+            return;
+        }
+
+        resizer.new.copy_and_extend(&self.map);
+        self.map = resizer.new;
+    }
+
+    /// Acquires a new ID by finding and setting the next zero bit in the
+    /// bitmap.
+    ///
+    /// Upon success, returns its index. Otherwise, returns [`None`]
+    /// to indicate that a [`Self::grow_request`] is needed.
+    #[inline]
+    pub fn acquire_next_id(&mut self, offset: usize) -> Option<usize> {
+        let next_zero_bit = self.map.next_zero_bit(offset);
+        if let Some(nr) = next_zero_bit {
+            self.map.set_bit(nr);
+        }
+        next_zero_bit
+    }
+
+    /// Releases an ID.
+    #[inline]
+    pub fn release_id(&mut self, id: usize) {
+        self.map.clear_bit(id);
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 03eb6b34ddd2..b47442a01002 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -90,6 +90,7 @@
 pub mod firmware;
 pub mod fmt;
 pub mod fs;
+pub mod id_pool;
 pub mod init;
 pub mod io;
 pub mod ioctl;
-- 
2.51.0.355.g5224444f11-goog

