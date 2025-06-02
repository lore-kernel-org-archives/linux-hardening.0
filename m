Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A59223339
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872389; cv=none; b=VLYOa85T0MyxCKp+MB/AoHUmqsfLFAUZBwOPZuFIT8VlsHlf+RYREjyYZ2Z9Xvc72s09IwX/a7FwrnyrgIWwtz9+ddND0XWsCKho1VQjjfDr5Am4xgW8BB3DdqANsV6X3NBfgyMWmVOC+PtV1noMiyh4k4gTqJVvpVO3QEjy6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872389; c=relaxed/simple;
	bh=PzU1TNEpY63ziwPu0K6S7872blhntIsbvgBWQ6z5IVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZyuVa6XWoGpNCJfj9vdGovCgn9o9xUHZAfdDOIFiFV6Ho+gYoKTI3H2yDGu062UataJsAx/3RzCAtyUqzYV29YXLnZBJZshyF/shk030SJk3fwZGFzBYvROY3DEt/V4V+thYHYooIAvMgY4j/3cgni7a0Fj7fzO4P93wlQss9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmFRvEJi; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmFRvEJi"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f3796779so2605186f8f.1
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748872385; x=1749477185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFgGeBKzfW5L5KrbepqXepN9vaTJ/sH7LxFyURED/wg=;
        b=KmFRvEJiQAL5VBhNRv/Oqy4SeuHU/KDo+zzqk7AmkMX9EfQ1jJM0eATb0jRNZzGnuz
         IpP5Nfr5pijWZQjTfD2y9GwkuLH+XAzkcVMUBiFNwL5h3in2QQqIez6L6Wg5fXZ9d6on
         lfPFAWUTWm4LQpHmjMD8i+/MdhZ36/0FkLzoYLOtVj+dk86UoGnfdAXlTlJjkdpi10FY
         qjNckZZWXoCYQUEI/BbQpp7wXER3fcKEhRoYIzJuRH+IEqalOPucrcuZ0r2XVX3yw+Ho
         66XbfQcR1zrzmB3zBKQuFM/wx3nt/m4rZpBqV+HzH/wuo8OHtcw5VdI1U28xbw6fqUx5
         aAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872385; x=1749477185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFgGeBKzfW5L5KrbepqXepN9vaTJ/sH7LxFyURED/wg=;
        b=hj1vnyZ+TdurxJ5MtDqwnY6X9USl8jrQNGtUf8keNmksz1n7Rm8SIxY8L/kkpHom1C
         XEGro7BhUrDDs/HiUg9jddeuR7PQfHxEiH0OA3SaL6Uvwp4muWBF8305YI7XRQzA2pmD
         zmxidPVgJIzGX31LyzMVR6r9NiSXWP9yfiQU5Zk6l9zUMJCy3YV0FkhvnWJzj8Yk8A8r
         QGIctTvdPsnG85KOgPKmU9AP7a17DYQVerchCw0MJI98pZXCNqjGYCjYD9OIov7WtXYh
         PfU8ydVyTAdAYmj+4vHUmcGKN+KfEfA9rTK2pLqbRdn//28GDAt863BnXs1VMmwtRz8f
         xViw==
X-Forwarded-Encrypted: i=1; AJvYcCWR780YYQNJ4eihaL8c5zOKMzlyLoUtFFDU9BlWkosLw/Pkp15++jddkQ+5y92DcCU7ErmmGtzRFCslgCwCLiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzkQtswDkDp8qTTphrAV135GVQ/PB3TwSYWFfToc56vnK+v+E
	v8yDsS+lTV3jgdkUQ+JPNkkDnz4CmLZ2iRTP5W386gdcqhQQBQ8gaOLqB/ghXhMQYKdvdQ==
X-Google-Smtp-Source: AGHT+IGrrDe0qHuBb8HvDqbuQ3NhDh/eeybGxxqjlwklk9HuTSmFg9CDuRggmug+tX0/4hi6asRbvIk=
X-Received: from wmsj40.prod.google.com ([2002:a05:600c:1c28:b0:450:dca1:cf91])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5f52:0:b0:3a4:ea9a:1656
 with SMTP id ffacd0b85a97d-3a4f7a3e4ecmr11610541f8f.10.1748872385024; Mon, 02
 Jun 2025 06:53:05 -0700 (PDT)
Date: Mon,  2 Jun 2025 13:52:24 +0000
In-Reply-To: <20250602135231.1615281-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602135231.1615281-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602135231.1615281-6-bqe@google.com>
Subject: [PATCH v11 5/5] rust: add dynamic ID pool abstraction for bitmap
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
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS            |   1 +
 rust/kernel/id_pool.rs | 222 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 3 files changed, 224 insertions(+)
 create mode 100644 rust/kernel/id_pool.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 943d85ed1876..bc95d98f266b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4134,6 +4134,7 @@ R:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
 F:	lib/find_bit_benchmark_rust.rs
 F:	rust/kernel/bitmap.rs
+F:	rust/kernel/id_pool.rs
 
 BITOPS API
 M:	Yury Norov <yury.norov@gmail.com>
diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
new file mode 100644
index 000000000000..cf26d405d9bb
--- /dev/null
+++ b/rust/kernel/id_pool.rs
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Rust API for an ID pool backed by a [`Bitmap`].
+
+use crate::alloc::{AllocError, Flags};
+use crate::bitmap::Bitmap;
+
+/// Represents a dynamic ID pool backed by a [`Bitmap`].
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
+///   assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
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
+///   let mut pool = guarded_pool.lock();
+///   loop {
+///     match pool.acquire_next_id(0) {
+///       Some(index) => return Ok(index),
+///       None => {
+///         let alloc_request = pool.grow_request();
+///         drop(pool);
+///         let resizer = alloc_request.ok_or(AllocError)?.realloc(GFP_KERNEL)?;
+///         pool = guarded_pool.lock();
+///         pool.grow(resizer)
+///       }
+///     }
+///   }
+/// }
+/// ```
+pub struct IdPool {
+    map: Bitmap,
+}
+
+/// Indicates that an [`IdPool`] should change to a new target size.
+pub struct ReallocRequest {
+    num_ids: usize,
+}
+
+/// Contains a [`Bitmap`] of a size suitable for reallocating [`IdPool`].
+pub struct PoolResizer {
+    new: Bitmap,
+}
+
+impl ReallocRequest {
+    /// Allocates a new backing [`Bitmap`] for [`IdPool`].
+    ///
+    /// This method only prepares reallocation and does not complete it.
+    /// Reallocation will complete after passing the [`PoolResizer`] to the
+    /// [`IdPool::grow`] or [`IdPool::shrink`] operation, which will check
+    /// that reallocation still makes sense.
+    pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
+        let new = Bitmap::new(self.num_ids, flags)?;
+        Ok(PoolResizer { new })
+    }
+}
+
+impl IdPool {
+    /// Constructs a new `[IdPool]`.
+    ///
+    /// A capacity below [`BITS_PER_LONG`] is adjusted to [`BITS_PER_LONG`].
+    #[inline]
+    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
+        let num_ids = core::cmp::max(num_ids, bindings::BITS_PER_LONG as usize);
+        let map = Bitmap::new(num_ids, flags)?;
+        Ok(Self { map })
+    }
+
+    /// Returns how many IDs this pool can currently have.
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.map.len()
+    }
+
+    /// Returns a [`ReallocRequest`] if the [`IdPool`] can be shrunk, [`None`] otherwise.
+    ///
+    /// The capacity of an [`IdPool`] cannot be shrunk below [`BITS_PER_LONG`].
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
+    /// assert_eq!(pool.len(), kernel::bindings::BITS_PER_LONG as usize);
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn shrink_request(&self) -> Option<ReallocRequest> {
+        let len = self.map.len();
+        // Shrinking below [`BITS_PER_LONG`] is never possible.
+        if len <= bindings::BITS_PER_LONG as usize {
+            return None;
+        }
+        // Determine if the bitmap can shrink based on the position of
+        // its last set bit. If the bit is within the first quarter of
+        // the bitmap then shrinking is possible. In this case, the
+        // bitmap should shrink to half its current size.
+        let last_bit = self.map.last_bit();
+        if last_bit.is_none() {
+            return Some(ReallocRequest {
+                num_ids: bindings::BITS_PER_LONG as usize,
+            });
+        }
+        let bit = last_bit.unwrap();
+        if bit >= (len / 4) {
+            return None;
+        }
+        let num_ids = core::cmp::max(bindings::BITS_PER_LONG as usize, len / 2);
+        Some(ReallocRequest { num_ids })
+    }
+
+    /// Shrinks pool by using a new [`Bitmap`], if still possible.
+    #[inline]
+    pub fn shrink(&mut self, mut resizer: PoolResizer) {
+        // Between request to shrink that led to allocation of `resizer` and now,
+        // bits may have changed.
+        // Verify that shrinking is still possible. In case shrinking to
+        // the size of `resizer` is no longer possible, do nothing,
+        // drop `resizer` and move on.
+        let updated = self.shrink_request();
+        if updated.is_none() {
+            return;
+        }
+        if updated.unwrap().num_ids > resizer.new.len() {
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
+        let num_ids = self.map.len() * 2;
+        if num_ids > i32::MAX.try_into().unwrap() {
+            return None;
+        }
+        Some(ReallocRequest { num_ids })
+    }
+
+    /// Grows pool by using a new [`Bitmap`], if still necessary.
+    ///
+    /// The `resizer` arguments has to be obtained by calling [`grow_request`]
+    /// on this object and performing a `realloc`.
+    #[inline]
+    pub fn grow(&mut self, mut resizer: PoolResizer) {
+        // Between request to grow that led to allocation of `resizer` and now,
+        // another thread may have already grown the capacity.
+        // In this case, do nothing, drop `resizer` and move on.
+        if resizer.new.len() <= self.map.len() {
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
+    /// Upon success, returns its index. Otherwise, returns `None`
+    /// to indicate that a `grow_request` is needed.
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
index 8c4161cd82ac..d7def807900a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -54,6 +54,7 @@
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod fs;
+pub mod id_pool;
 pub mod init;
 pub mod io;
 pub mod ioctl;
-- 
2.49.0.1204.g71687c7c1d-goog

