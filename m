Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77523E324
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408214; cv=none; b=DV5+AU3qPzDVXoiGpI18xr6jnsJuPvndy4M3vPZ/FC5kTHT0mypeoFjJ+tlE7+dpMo86splvbOwDz2HqiWTs/+mWftVso0ogDGYsv8UJq8iGHI5afCi6utiz9EWssQjn/qN2pcbfTSAzzqXF7XNgpnYsf0E44UdZ4hg4qzDwnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408214; c=relaxed/simple;
	bh=DC2BcT6tzYClbZYZJqXu3LH8qcVEnahy7EXm3bUVOGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B4ctlK6QZhHIlTsWu9d5B+t1nsF5ws6b7j2fk7+/enrAt66R2rrGJb8JlPYwCWW1qs6N7CN5wA4z1YkhFEGNjxIeCyKVdOeS07H2/k8vBzFx8VtsYCB1DUbqZU/eBDy0RC8EXTMCJblhWQOu+HXbdRBP+jWUT9gFXAKr/cmPJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZbW8mbz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZbW8mbz"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45359bfe631so9200715e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750408210; x=1751013010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fo1XIHJX7wN0reCSMWdLWyFEb50yUvDP7DmO8CGhQYU=;
        b=jZbW8mbz/6AWa0Q5/lbEzcQFNx1NAe6bbbRuokyqWR0dB1+05R/+Sxqxt0Mky996Ro
         5as5TrY/KOScB6T+kwLd8ebd2C9Vt9D5OKgsJgsZbrJf4KX1z9rG+5wWHafmd6B6SNQV
         4AOtkKBcbTmxbGL/opmPCMQCl0PdrfB0vMFknioWMx6Vx72ASTkwD0X4yn6A81pcSdXE
         UzTKEqNWA4Xj/RJ0JQOhbelpaW8DSeCUCbfahTfo2zDKeZKKuhY2FfrLAWQHuFJS92kg
         vrqK1I/ramZv1fm1s9Rc+3jkNM7qp4A7KijyDTa0M52YDBoliNf1PU/5RDufIqOGGS7m
         QT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408210; x=1751013010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fo1XIHJX7wN0reCSMWdLWyFEb50yUvDP7DmO8CGhQYU=;
        b=t0aZ9rmctHW6flQc3PflF6WncemzEH8UibMBjFe7xLD+m2hTU6iHMzYR5D/wLmqJ32
         tbRnxZYWoAP1gQwV7bwTmBH8pcO/91ydYAnhEPz+6NhUG5rM4D/2COYCN7jiiKx1CYc8
         6NxGPhO8umZsCvF4hTbcrLEoYXkDhK9TkxAhwsch37h6wgIPMf9GXIdan4n+Z2eRWTDQ
         dOxl5vVEVVMylbNjWLDmz4fEVRT5vmI50kMSzplQs1HSAOkkBfX/LuHDW1bkm9r6UT5U
         AxnT/I2IqSIpslOF6hZzX4CVr1dqY2Ju59ArL07kQAES51mBxFGejW9zOnxm1m0rTtbU
         CViw==
X-Forwarded-Encrypted: i=1; AJvYcCVSU/+kWjLyUB1zj9f8PrV5AGzcXEORFF6N/KJH446+J29AVCXjtlCbKAvi6JwPEGcNE/zlTZl+78jWiQyuzuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWhVXE+PaMLx7hfYpZXhtbFSGhNmzPms1YZwGfdC57XVmPmjC
	Vg3v30JUQiJu6bpjbt8mEmmypamR+X0fe27H2J1v6wpNZvvbi4SVIESShSna3PucuTADOA==
X-Google-Smtp-Source: AGHT+IEyM0sGVUlhxD2p0JWSwudsUtmKTxZwiS0gAaHxbzzT/tKEU+5EQ5qEBbiip1YAMmf397PPhzw=
X-Received: from wmsp5.prod.google.com ([2002:a05:600c:1d85:b0:453:dda:a53d])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:37c5:b0:453:cd0:903c
 with SMTP id 5b1f17b1804b1-453659be41bmr14887385e9.2.1750408210167; Fri, 20
 Jun 2025 01:30:10 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:29:50 +0000
In-Reply-To: <20250620082954.540955-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620082954.540955-1-bqe@google.com>
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250620082954.540955-6-bqe@google.com>
Subject: [PATCH v13 5/5] rust: add dynamic ID pool abstraction for bitmap
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
 rust/kernel/id_pool.rs | 226 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 3 files changed, 228 insertions(+)
 create mode 100644 rust/kernel/id_pool.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 92511c925db8..49acd6d327dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4210,6 +4210,7 @@ R:	Yury Norov <yury.norov@gmail.com>
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
index 8ae5f1ee0308..569c8b87031f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -79,6 +79,7 @@
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod fs;
+pub mod id_pool;
 pub mod init;
 pub mod io;
 pub mod ioctl;
-- 
2.50.0.rc2.761.g2dc52ea45b-goog

