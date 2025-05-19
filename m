Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9528A1E0
	for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671462; cv=none; b=tbwqr9pvSIb6YTOq7KZjJ/kj6F3rUNBtxPAQd8KJWEfIFWbgAXb4BDuKAV2ElOFJttGyTwz414eLxBaOS4L2jhFuTMjmYTe24hGVQd9xOHemSu/9umUfYIWgbCjAhwPUwSf8tdVovs8KXkcWFfkBGQH4kAXGUPOx8L5EqQsgwQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671462; c=relaxed/simple;
	bh=rHUxzB2Bwi+2jlKp4urPGDKcCylqhDAV9PHNICkE1AM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ebUKIRXbmJsu/t3DBfJ5CS3JxTrTu2jSnOz6r5Raci648zKO0JcJErWI8BEz3UIG86RD2u5wrXUltfgQ00MS5qlj5+B3/ovB5IZoK6UIUBADaQpBd1N9WQfXfHHXKidJDC1z5eBafLdkDboKytpKmExHwItiMVEOW69Uh+JQu8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QL1YDF5F; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QL1YDF5F"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-442fda1cba7so14762275e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747671459; x=1748276259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zRmZrCz4QpMiECwxwWyXnnAcIyfbi3oIrpsYNgBmqlI=;
        b=QL1YDF5FRrVyQG5Mqn5MfgOfwsLL+ZL01joP1us5ZT8X7nMCzh+JCNji/cYMSUhu1a
         XqMOs4RSeuxqkASbtkVFIAqyDzzSqZ4trkHIfmJ+KSGN80jsYZPxkUouoq3osUGfIb8k
         C3ZX5S2UXrtoP6JzlzNsUGJp7WlLtaw9v08i2wfTgm8+gr+D2L/f0eIyBQ2aVfxkpb/L
         xIRfh4Yltpnhc9k/QRLbukvTDSS3IEBSXQn/8urA0zuqY0WsIjPvB4wuu41ppipvRPpc
         PyDLQULIHtDrM9DaxHBO+x7zCa0xkAIfNUjoQWY6mETBQLT7vRWqG5+ccpA1CUfb7MJD
         Oy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747671459; x=1748276259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRmZrCz4QpMiECwxwWyXnnAcIyfbi3oIrpsYNgBmqlI=;
        b=ijqin+UNJ3QkC+5nkofYLynbHkoMleb/bd3s+Bbhvw/QXPwzPRoHKhDCPKh3vnavTZ
         cY5qP7xDLpFEl0kmCvYXSD6QrFih8A1PEDUWJopP+NhUN+mP6soocOAV14BYRB7cO46x
         ARXGsiXyepNZTan88btbrp1h/zkRPgn2TgOdksqu9osFpDWQNEBs+7jM1yctmp70RQ0c
         SanggmBunECrkFrOy5ePeEljT9KHMVC1M/iX4hkeF81CzsTJdM9U68OR19deEwgYOF4G
         kEfe3loZMq7FmJcsFsQaCzjkAex+aIXFrMXUtkbIwmN40nILJ0d8OYSeD1qL8BpIBi0a
         8Jkw==
X-Forwarded-Encrypted: i=1; AJvYcCXInwIx7acGRJ8npwdq2dVb/uGUIXXI49Dw847kupw1cs4YeHV1jls02kQMG3aMdyWI7f+byMMPZ8g/E4RDL8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBOXPRg9eUUNGpn9l9d13qasmivSuyUlYvQaTfxSe/ZSEWnrK
	LsKgTBoCEBjHBEAla9reyUdO7kUoXuCvmLYMTXeFqIJQp+TLkWyTJWQAqPXfNnrRwDXRMQ==
X-Google-Smtp-Source: AGHT+IFyBZQy4NfRKtT3XwWN6zobbmN0oZUd8mI/AD9F82y7coNWR9BSlEwIZv+kecL0Ld+zemnMy6w=
X-Received: from wmdd3.prod.google.com ([2002:a05:600c:a203:b0:445:1cd2:5e5f])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a46:b0:442:dc6f:2f11
 with SMTP id 5b1f17b1804b1-442ff032533mr80126215e9.25.1747671459299; Mon, 19
 May 2025 09:17:39 -0700 (PDT)
Date: Mon, 19 May 2025 16:17:05 +0000
In-Reply-To: <20250519161712.2609395-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519161712.2609395-6-bqe@google.com>
Subject: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
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

This is a port of the Binder data structure introduced in commit
15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
Rust.

Like drivers/android/dbitmap.h, the ID pool abstraction lets
clients acquire and release IDs. The implementation uses a bitmap to
know what IDs are in use, and gives clients fine-grained control over
the time of allocation. This fine-grained control is needed in the
Android Binder. We provide an example that release a spinlock for
allocation and unit tests (rustdoc examples).

The implementation is not aware that the underlying Bitmap abstraction
handles lengths below BITS_PER_LONG without allocation.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS            |   1 +
 rust/kernel/id_pool.rs | 201 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 3 files changed, 203 insertions(+)
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
index 000000000000..8f07526bb580
--- /dev/null
+++ b/rust/kernel/id_pool.rs
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Rust API for an ID pool backed by a `Bitmap`.
+
+use crate::alloc::{AllocError, Flags};
+use crate::bitmap::Bitmap;
+
+/// Represents a dynamic ID pool backed by a `Bitmap`.
+///
+/// Clients acquire and release IDs from zero bits in a bitmap.
+///
+/// The ID pool can grow or shrink as needed. It has been designed
+/// to support the scenario where users need to control the time
+/// of allocation of a new backing bitmap, which may require release
+/// of locks.
+/// These operations then, are verified to determine if the grow or
+/// shrink is sill valid.
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
+/// let resizer = pool.grow_alloc().alloc(GFP_KERNEL)?;
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
+/// fn get_id_maybe_alloc(guarded_pool: &SpinLock<IdPool>) -> Result<usize, AllocError> {
+///   let mut pool = guarded_pool.lock();
+///   loop {
+///     match pool.acquire_next_id(0) {
+///       Some(index) => return Ok(index),
+///       None => {
+///         let alloc_request = pool.grow_alloc();
+///         drop(pool);
+///         let resizer = alloc_request.alloc(GFP_KERNEL)?;
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
+/// Returned when the `IdPool` should change size.
+pub struct AllocRequest {
+    nbits: usize,
+}
+
+/// Contains an allocated `Bitmap` for resizing `IdPool`.
+pub struct PoolResizer {
+    new: Bitmap,
+}
+
+impl AllocRequest {
+    /// Allocates a new `Bitmap` for `IdPool`.
+    pub fn alloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
+        let new = Bitmap::new(self.nbits, flags)?;
+        Ok(PoolResizer { new })
+    }
+}
+
+impl IdPool {
+    /// Constructs a new `[IdPool]`.
+    #[inline]
+    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
+        let map = Bitmap::new(nbits, flags)?;
+        Ok(Self { map })
+    }
+
+    /// Returns how many IDs this pool can currently have.
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.map.len()
+    }
+
+    /// Returns an [`AllocRequest`] if the [`IdPool`] can be shrunk, [`None`] otherwise.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::id_pool::{AllocRequest, IdPool};
+    ///
+    /// let mut pool = IdPool::new(1024, GFP_KERNEL)?;
+    /// let alloc_request = pool.shrink_alloc().ok_or(AllocError)?;
+    /// let resizer = alloc_request.alloc(GFP_KERNEL)?;
+    /// pool.shrink(resizer);
+    /// assert_eq!(pool.len(), kernel::bindings::BITS_PER_LONG as usize);
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn shrink_alloc(&self) -> Option<AllocRequest> {
+        let len = self.map.len();
+        if len <= bindings::BITS_PER_LONG as usize {
+            return None;
+        }
+        /*
+         * Determine if the bitmap can shrink based on the position of
+         * its last set bit. If the bit is within the first quarter of
+         * the bitmap then shrinking is possible. In this case, the
+         * bitmap should shrink to half its current size.
+         */
+        match self.map.last_bit() {
+            Some(bit) => {
+                if bit < (len >> 2) {
+                    Some(AllocRequest { nbits: len >> 1 })
+                } else {
+                    None
+                }
+            }
+            None => Some(AllocRequest {
+                nbits: bindings::BITS_PER_LONG as usize,
+            }),
+        }
+    }
+
+    /// Shrinks pool by using a new `Bitmap`, if still possible.
+    #[inline]
+    pub fn shrink(&mut self, mut resizer: PoolResizer) {
+        // Verify that shrinking is still possible. The `resizer`
+        // bitmap might have been allocated without locks, so this call
+        // could now be outdated. In this case, drop `resizer` and move on.
+        if let Some(AllocRequest { nbits }) = self.shrink_alloc() {
+            if nbits <= resizer.new.len() {
+                resizer.new.copy_and_extend(&self.map);
+                self.map = resizer.new;
+                return;
+            }
+        }
+    }
+
+    /// Returns an `AllocRequest` for growing this `IdPool`.
+    #[inline]
+    pub fn grow_alloc(&self) -> AllocRequest {
+        AllocRequest {
+            nbits: self.map.len() << 1,
+        }
+    }
+
+    /// Grows pool by using a new `Bitmap`, if still necessary.
+    #[inline]
+    pub fn grow(&mut self, mut resizer: PoolResizer) {
+        // `resizer` bitmap might have been allocated without locks,
+        // so this call could now be outdated. In this case, drop
+        // `resizer` and move on.
+        if resizer.new.len() <= self.map.len() {
+            return;
+        }
+
+        resizer.new.copy_and_extend(&self.map);
+        self.map = resizer.new;
+    }
+
+    /// Acquires a new ID by finding and setting the next zero bit in the
+    /// bitmap. Upon success, returns its index. Otherwise, returns `None`
+    /// to indicate that a `grow_alloc` is needed.
+    #[inline]
+    pub fn acquire_next_id(&mut self, offset: usize) -> Option<usize> {
+        match self.map.next_zero_bit(offset) {
+            res @ Some(nr) => {
+                self.map.set_bit(nr);
+                res
+            }
+            None => None,
+        }
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
2.49.0.1101.gccaa498523-goog

