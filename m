Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA9215767
	for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271718; cv=none; b=o2/EmHCUiyG8i3qv1NqFK1MCDWeS0h4ggjS/hUfL9KarKf+McsVcQL7rUsh2QUOnoJ1LlZhRUZScP3MMVSRKLb9bvYYRP/AyQuZlN9Sa3ZKTXR58BmDmFpN2GswGu0iZ9UI4NQ6Vet1ubK3E0jDFwAk+CNGE5NcWTeYF/5hgLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271718; c=relaxed/simple;
	bh=VvoZlhwxC1CR9pSeDpwnyRek3MbQmb/gC2C5ekD4kLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GXmU3jqSg+ZoOlpnOUM6RS1J45oS1SkS5YEddmvrtl36fgwrv9hi69CFPteyZjn3BLtuNnAOUnRLxlbSiaxTbUI1hm2R0Wo59Q2Eoibr997ueE5F5+5TxhPwhCVfiayXAW6pZzogYbQDwwf4L2CLKj0pnBFpCFHeGFA6WWQSnmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Teqv+g1t; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Teqv+g1t"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43f251dc364so13356195e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 26 May 2025 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748271715; x=1748876515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwqSAmf6/Ep/rBjlBKr3RxUitUbKRr9kZEP0SK5EUrg=;
        b=Teqv+g1tZnAMlyOMcfD467Nk2qGQ453iRdJ3JT1X4uBwt/k1jrrPJwC9OO/OyLY5h+
         zvWmuiQHfM/4xnolDpHBElAmBZ+FrHKx1KbQ7oN8e2KabPh3c936w7/F2g5P/EwOIf63
         enwXa+6egJPROtPksd/bwn0wbPFPjHciTw2CVnKr3QD9lHIwXBckLz17E6Ge6rwZQI3k
         VFHghTd6S75iiCYrCJV8RrosAg3+OHmrL1IOJMNg8IjVhicnRRnNmTGvH3v0q279q1tD
         go9cfPl8H3/L/NLJ4BctZmyusCt3Zt+N4H/TjY1q1Z5ZjdALSLmDi1csyrlbtl2IxI5A
         0J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748271715; x=1748876515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwqSAmf6/Ep/rBjlBKr3RxUitUbKRr9kZEP0SK5EUrg=;
        b=hjKZI0+XchRHQxYZX0tI9xIuUF81jswxvSahUHyhlvCqCjLcQJFuMJiHKwe1iEgDWv
         5esnFvtTP6bI7pceRSnYHcVJsSa1Q/55al9prtFryE+92CjkwR86g/nwdrOtBcaHLauW
         gcIuhf3VDfW93rMPbcevipPDbrmmnQi6QIwF3nKd6lRP6So4u9bF/P+nr/mdu5kXEPZX
         pRKYZpZCwl23Lvpb6ZMbz4/C8IXhPeYaxh6lKNeDn3CLvfbIkWgWR7rtQGTM3ifjSd+u
         Nr2F+L5p5ldOBqnenr6ZWcM2xTLZqRfEBjrLHEaTSKizSg1/0WsYhdXUSkAGf6gwftHH
         Teug==
X-Forwarded-Encrypted: i=1; AJvYcCX/PG5+l2EkuyTfwmU6CQQ2p7BRpQN/VNC+q6ENbzjN442LHcTgH6ErB8ZcsMKyWG1VWdHLPSRvsb/oeKONjiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz76cuIkTrfDbmNjI5GbudaMvFg/Mzy/7PkyNowuADULGLUZbx2
	H0BMnZPceBsgwij500FakySTkOztWOdsILlN3+GHtUI1CTmrGJ4qAsm119hjbImp3cgF/g==
X-Google-Smtp-Source: AGHT+IEB7cMuTlLb7HKkkIS+Jsm8rSxyJlIIPKJvwa0MHgNrxtIoospK6jVxuDUB+SurigLdRBTYA88=
X-Received: from wmqc13.prod.google.com ([2002:a05:600c:a4d:b0:43b:bf16:d6be])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8411:b0:43c:fe15:41cb
 with SMTP id 5b1f17b1804b1-44c91fbb039mr101751335e9.15.1748271715138; Mon, 26
 May 2025 08:01:55 -0700 (PDT)
Date: Mon, 26 May 2025 15:01:34 +0000
In-Reply-To: <20250526150141.3407433-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250526150141.3407433-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250526150141.3407433-6-bqe@google.com>
Subject: [PATCH v9 5/5] rust: add dynamic ID pool abstraction for bitmap
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
2.49.0.1151.ga128411c76-goog

