Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46837289E14
	for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671460; cv=none; b=lRA0PEgsm2es1KXQQGYcgjwEFpBPlJkb5fhlm7fgQi58QGXSwG1AJxuCcGV89HtER1263K7eBYxtvpRC2nrmp/giP2W83tpmYkNO47Fn6J+n5gfT0epp3m4YvJAeg1HCfF/mgNCxBNGpte3+CpHODL4SW1c9/1UGcMz7Nvd2o04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671460; c=relaxed/simple;
	bh=QT8ZMTctfr1J+XzRoTakz5AJSOlWu121wMMwbdqDl8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G2EKOSvsE9zFBAcGCpqddkzyE66KA04aQz0Bx/82rdbgDuD8pwKRomz33yYdAOht0q9sAiAl5xIW57yHOebG8fCEyhVyTGKiQt8o4QXOm/UTzkupoTMSllL3VJdRum2sHZC4hyMIXcUN6tQWubxEdWZr7COiKBdFJ1IubLHNs5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLz34hD+; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLz34hD+"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so35747075e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747671455; x=1748276255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfz9nEc/hxUJIcLaKW3k+sD8V+u1a0TDbRDrs80xXFA=;
        b=eLz34hD+y+7ZUOZnkno6THEosVRbXIZOIYWZsttB8p33rw4NNDuqY6MXKEZJw9iJiI
         zgKbUyCf0nygotQLGyzKCwzy6TuxZ3GyXniV3wVA9kMkPMcq2g/Pb9IU6EfBOCtt8xOJ
         b5vbZ+GY7Nm8NUii2Ir0Ix8p/dbo9L1lje4WwmRoxrMuukOY1YSkC6wBOMK1be7SI7cA
         ZwmSeM3zuasU8pChGZbDM0W4t3F+HEyedrEoH1NMPd53IvF665ucE7JZRNY3stmh7uZX
         1fLCgXBnkx2lH8RlQN6dVbsJf7pQtiVQFWTm/V3niBeKmZtfNm/o+iCdPuqzqIWJnYPQ
         2oeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747671455; x=1748276255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfz9nEc/hxUJIcLaKW3k+sD8V+u1a0TDbRDrs80xXFA=;
        b=WKvH17dnMzLMWrL+MtkpfSYQjL2+TmCZjQ/FcevYWWciDkUrbQOIxI6qvROQ+8VKcL
         4MGeInhCsQ95PfTBwgdon3o5uiWNoPNsycfFuT5YV9aIduupXUi5O6abmUnASHAvTCG6
         CDG+SDuwV1A4V13xyo9QNngbeIGzvHBPOdpBYhqXE8ajPYfuzpH5OHhL7p/Pg0PmpcIL
         2ARlqp51Fd5rxDyucnyVWmnbiEAzUyCQp5+5mM+CHCs24hu2T9/cvRn5D+ulMDTMKIPw
         yOS484O22o/xawUXOm2nDvgoG4/GTp8uH7r1oKzbT8RZgl41I3NS02ZQN1DRQ8DNJSCJ
         ouZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGrSlcaRj1wRiNJ7EIosx8PFqyBdRvoO6Nob8nGooXkLN8oiwJ+xkmA3HxjXU2OCUO0Urd+qFfFyNLdc/FH5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hXZBzNxeFDmx8gWJ7uV2liG+xTYz7vSraH9Jib1uxIIXy+eX
	IWKtPJJiTdKhQuEPOmgjDuq4HXNQSVtoM+To+ymviRxRBdIlL1EUFpK11zJ4I0uhPvAY3Q==
X-Google-Smtp-Source: AGHT+IGAeGn+PW2xEgj73EmbMuX5za13/vJqJ3FsRLehDvShqwrYK2lypzy1YOfhlXF1UW5TV8gf0EQ=
X-Received: from wmbgw24.prod.google.com ([2002:a05:600c:8518:b0:440:68cb:bd4])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c1b:b0:43c:e481:3353
 with SMTP id 5b1f17b1804b1-442feffbb8dmr143562675e9.17.1747671455773; Mon, 19
 May 2025 09:17:35 -0700 (PDT)
Date: Mon, 19 May 2025 16:17:03 +0000
In-Reply-To: <20250519161712.2609395-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519161712.2609395-4-bqe@google.com>
Subject: [PATCH v8 3/5] rust: add bitmap API.
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

Provides an abstraction for C bitmap API and bitops operations.
We follow the C Bitmap API closely in naming and semantics, with
a few differences that take advantage of Rust language facilities
and idioms:

  * We leverage Rust type system guarantees as follows:

    * Ownership transfer of a Bitmap is restricted so that it cannot
    be passed between threads (does not implement `Send`).

    * all (non-atomic) mutating operations require a &mut reference which
    amounts to exclusive access.

    * It is permissible to pass shared references &Bitmap between
    threads, and we expose atomic operations through interior mutability.
    Since these atomic operations do not provide any ordering guarantees,
    we mark these as `unsafe`. Anyone who calls the atomic methods needs
    to document that the lack of ordering is safe.

  * The Rust API offers `{set,clear}_bit` vs `{set,clear}_bit_atomic`,
    which is different from the C naming convention (set_bit vs __set_bit).

  * we include enough operations for the API to be useful, but not all
    operations are exposed yet in order to avoid dead code. This commit
    includes enough to enable a Rust implementation of an Android Binder
    data structure that was introduced in commit 15d9da3f818c ("binder:
    use bitmap for faster descriptor lookup"), which can be found in
    drivers/android/dbitmap.h. We need this in order to upstream the Rust
    port of Android Binder driver.

  * We follow the C API closely and fine-grained approach to safety:

    * Low-level bit-ops methods get a safe API with bounds checks.

    * methods correspond to find_* C methods tolerate out-of-bounds
    arguments. Since these are already safe we the same behavior, and
    return results using `Option` types to represent "not found".

  * the Rust API is optimized to represent the bitmap inline if it would
    take the space of a pointer. This saves allocations which is
    relevant in the Binder use case.

  * Bounds checks where out-of-bounds values would not result in
    immediate access faults are configured via a RUST_BITMAP_HARDENED
    config.

The underlying C bitmap is *not* exposed, and must never be exposed
(except in tests). Exposing the representation would lose all static
guarantees, and moreover would prevent the optimized representation of
short bitmaps.

An alternative route of vendoring an existing Rust bitmap package was
considered but suboptimal overall. Reusing the C implementation is
preferable for a basic data structure like bitmaps. It enables Rust
code to be a lot more similar and predictable with respect to C code
that uses the same data structures and enables the use of code that
has been tried-and-tested in the kernel, with the same performance
characteristics whenever possible.

We use the `usize` type for sizes and indices into the bitmap,
because Rust generally always uses that type for indices and lengths
and it will be more convenient if the API accepts that type. This means
that we need to perform some casts to/from u32 and usize, since the C
headers use unsigned int instead of size_t/unsigned long for these
numbers in some places.

Adds new MAINTAINERS section BITMAP API [RUST].

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS                |   7 +
 rust/kernel/bitmap.rs      | 415 +++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs         |   1 +
 security/Kconfig.hardening |   9 +
 4 files changed, 432 insertions(+)
 create mode 100644 rust/kernel/bitmap.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 04d6727e944c..565eaa015d9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4127,6 +4127,13 @@ S:	Maintained
 F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
+BITMAP API [RUST]
+M:	Alice Ryhl <aliceryhl@google.com>
+M:	Burak Emir <bqe@google.com>
+R:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/kernel/bitmap.rs
+
 BITOPS API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
new file mode 100644
index 000000000000..943dbef7948b
--- /dev/null
+++ b/rust/kernel/bitmap.rs
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Rust API for bitmap.
+//!
+//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h).
+
+use crate::alloc::{AllocError, Flags};
+use crate::bindings;
+use core::ptr::NonNull;
+
+/// Holds either a pointer to array of `unsigned long` or a small bitmap.
+#[repr(C)]
+union BitmapRepr {
+    bitmap: usize,
+    ptr: NonNull<usize>,
+}
+
+macro_rules! bitmap_hardening_assert {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(RUST_BITMAP_HARDENED)]
+        assert!($e, $($arg)*);
+    }
+}
+
+/// Represents a bitmap.
+///
+/// Wraps underlying C bitmap API.
+///
+/// # Examples
+///
+/// Basic usage
+///
+/// ```
+/// use kernel::alloc::flags::GFP_KERNEL;
+/// use kernel::bitmap::Bitmap;
+///
+/// let mut b = Bitmap::new(16, GFP_KERNEL)?;
+///
+/// assert_eq!(16, b.len());
+/// for i in 0..16 {
+///     if i % 4 == 0 {
+///       b.set_bit(i);
+///     }
+/// }
+/// assert_eq!(Some(0), b.next_bit(0));
+/// assert_eq!(Some(1), b.next_zero_bit(0));
+/// assert_eq!(Some(4), b.next_bit(1));
+/// assert_eq!(Some(5), b.next_zero_bit(4));
+/// assert_eq!(Some(12), b.last_bit());
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// # Invariants
+///
+/// * `nbits` is `<= i32::MAX` and never changes.
+/// * if `nbits <= bindings::BITS_PER_LONG`, then `repr` is a bitmap.
+/// * otherwise, `repr` holds a non-null pointer that was obtained from a
+///   successful call to `bitmap_zalloc` and holds the address of an initialized
+///   array of `unsigned long` that is large enough to hold `nbits` bits.
+pub struct Bitmap {
+    /// Representation of bitmap.
+    repr: BitmapRepr,
+    /// Length of this bitmap. Must be `<= i32::MAX`.
+    nbits: usize,
+}
+
+/// Enable unsynchronized concurrent access to [`Bitmap`] through shared references.
+///
+/// # Safety
+///
+/// * When no thread performs any mutations, concurrent access is safe.
+/// * Mutations are permitted through atomic operations and interior mutability.
+///   All such methods are marked unsafe, to account for the lack of ordering
+///   guarantees. Callers must acknowledge that updates may be observed in any
+///   order.
+unsafe impl Sync for Bitmap {}
+
+impl Drop for Bitmap {
+    fn drop(&mut self) {
+        if self.nbits <= bindings::BITS_PER_LONG as _ {
+            return;
+        }
+        // SAFETY: `self.ptr` was returned by the C `bitmap_zalloc`.
+        //
+        // INVARIANT: there is no other use of the `self.ptr` after this
+        // call and the value is being dropped so the broken invariant is
+        // not observable on function exit.
+        unsafe { bindings::bitmap_free(self.as_mut_ptr()) };
+    }
+}
+
+impl Bitmap {
+    /// Constructs a new [`Bitmap`].
+    ///
+    /// Fails with [`AllocError`] when the [`Bitmap`] could not be allocated. This
+    /// includes the case when `nbits` is greater than `i32::MAX`.
+    #[inline]
+    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
+        if nbits <= bindings::BITS_PER_LONG as _ {
+            return Ok(Bitmap {
+                repr: BitmapRepr { bitmap: 0 },
+                nbits,
+            });
+        }
+        if nbits > i32::MAX.try_into().unwrap() {
+            return Err(AllocError);
+        }
+        let nbits_u32 = u32::try_from(nbits).unwrap();
+        // SAFETY: `bindings::BITS_PER_LONG < nbits` and `nbits <= i32::MAX`.
+        let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
+        let ptr = NonNull::new(ptr).ok_or(AllocError)?;
+        // INVARIANT: `ptr` returned by C `bitmap_zalloc` and `nbits` checked.
+        return Ok(Bitmap {
+            repr: BitmapRepr { ptr },
+            nbits,
+        });
+    }
+
+    /// Returns length of this [`Bitmap`].
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.nbits
+    }
+
+    /// Returns a mutable raw pointer to the backing [`Bitmap`].
+    #[inline]
+    fn as_mut_ptr(&mut self) -> *mut usize {
+        if self.nbits <= bindings::BITS_PER_LONG as _ {
+            // SAFETY: Bitmap is represented inline.
+            unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
+        } else {
+            // SAFETY: Bitmap is represented as array of `unsigned long`.
+            unsafe { self.repr.ptr.as_mut() }
+        }
+    }
+
+    /// Returns a raw pointer to the backing [`Bitmap`].
+    #[inline]
+    fn as_ptr(&self) -> *const usize {
+        if self.nbits <= bindings::BITS_PER_LONG as _ {
+            // SAFETY: Bitmap is represented inline.
+            unsafe { core::ptr::addr_of!(self.repr.bitmap) }
+        } else {
+            // SAFETY: Bitmap is represented as array of `unsigned long`.
+            unsafe { self.repr.ptr.as_ptr() }
+        }
+    }
+
+    /// Set bit with index `index`.
+    ///
+    /// ATTENTION: `set_bit` is non-atomic, which differs from the naming
+    /// convention in C code. The corresponding C function is `__set_bit`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index` is greater than or equal to `self.nbits`.
+    #[inline]
+    pub fn set_bit(&mut self, index: usize) {
+        assert!(
+            index < self.nbits,
+            "Bit `index` must be < {}, was {}",
+            self.nbits,
+            index
+        );
+        // SAFETY: Bit `index` is within bounds.
+        unsafe { bindings::__set_bit(index as u32, self.as_mut_ptr()) };
+    }
+
+    /// Set bit with index `index`, atomically.
+    ///
+    /// ATTENTION: The naming convention differs from C, where the corresponding
+    /// function is called `set_bit`.
+    ///
+    /// # Safety
+    ///
+    /// This is a relaxed atomic operation (no implied memory barriers, no
+    /// ordering guarantees). The caller must ensure that this is safe, as
+    /// the compiler cannot prevent code with an exclusive reference from
+    /// calling atomic operations.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index` is greater than or equal to `self.nbits`.
+    #[inline]
+    pub unsafe fn set_bit_atomic(&self, index: usize) {
+        assert!(
+            index < self.nbits,
+            "Bit `index` must be < {}, was {}",
+            self.nbits,
+            index
+        );
+        // SAFETY: `index` is within bounds and the caller has ensured that
+        // there is no mix of non-atomic and atomic operations.
+        unsafe { bindings::set_bit(index as u32, self.as_ptr() as *mut usize) };
+    }
+
+    /// Clear `index` bit.
+    ///
+    /// ATTENTION: `clear_bit` is non-atomic, which differs from the naming
+    /// convention in C code. The corresponding C function is `__clear_bit`.
+    /// # Panics
+    ///
+    /// Panics if `index` is greater than or equal to `self.nbits`.
+    #[inline]
+    pub fn clear_bit(&mut self, index: usize) {
+        assert!(
+            index < self.nbits,
+            "Bit `index` must be < {}, was {}",
+            self.nbits,
+            index
+        );
+        // SAFETY: `index` is within bounds.
+        unsafe { bindings::__clear_bit(index as u32, self.as_mut_ptr()) };
+    }
+
+    /// Clear `index` bit, atomically.
+    ///
+    /// ATTENTION: The naming convention differs from C, where the corresponding
+    /// function is called `clear_bit`.
+    ///
+    /// # Safety
+    ///
+    /// This is a relaxed atomic operation (no implied memory barriers, no
+    /// ordering guarantees). The caller must ensure that this is safe, as
+    /// the compiler cannot prevent code with an exclusive reference from
+    /// calling atomic operations.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index` is greater than or equal to `self.nbits`.
+    #[inline]
+    pub unsafe fn clear_bit_atomic(&self, index: usize) {
+        assert!(
+            index < self.nbits,
+            "Bit `index` must be < {}, was {}",
+            self.nbits,
+            index
+        );
+        // SAFETY: `index` is within bounds and the caller has ensured that
+        // there is no mix of non-atomic and atomic operations.
+        unsafe { bindings::clear_bit(index as u32, self.as_ptr() as *mut usize) };
+    }
+
+    /// Copy `src` into this [`Bitmap`] and set any remaining bits to zero.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::bitmap::Bitmap;
+    ///
+    /// let mut long_bitmap = Bitmap::new(256, GFP_KERNEL)?;
+    //
+    /// assert_eq!(None, long_bitmap.last_bit());
+    //
+    /// let mut short_bitmap = Bitmap::new(16, GFP_KERNEL)?;
+    //
+    /// short_bitmap.set_bit(7);
+    /// long_bitmap.copy_and_extend(&short_bitmap);
+    /// assert_eq!(Some(7), long_bitmap.last_bit());
+    ///
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn copy_and_extend(&mut self, src: &Bitmap) {
+        let len = core::cmp::min(src.nbits, self.nbits);
+        // SAFETY: access to `self` and `src` is within bounds.
+        unsafe {
+            bindings::bitmap_copy_and_extend(
+                self.as_mut_ptr(),
+                src.as_ptr(),
+                len as u32,
+                self.nbits as u32,
+            )
+        };
+    }
+
+    /// Finds last set bit.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::bitmap::Bitmap;
+    ///
+    /// let bitmap = Bitmap::new(64, GFP_KERNEL)?;
+    ///
+    /// match bitmap.last_bit() {
+    ///     Some(idx) => {
+    ///         pr_info!("The last bit has index {idx}.\n");
+    ///     }
+    ///     None => {
+    ///         pr_info!("All bits in this bitmap are 0.\n");
+    ///     }
+    /// }
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn last_bit(&self) -> Option<usize> {
+        // SAFETY: `_find_next_bit` access is within bounds due to invariant.
+        let index = unsafe { bindings::_find_last_bit(self.as_ptr(), self.nbits) };
+        if index >= self.nbits {
+            None
+        } else {
+            Some(index)
+        }
+    }
+
+    /// Finds next set bit, starting from `start`.
+    /// Returns `None` if `start` is greater of equal than `self.nbits`.
+    #[inline]
+    pub fn next_bit(&self, start: usize) -> Option<usize> {
+        bitmap_hardening_assert!(start < self.nbits, "`start` must be < {} was {}", self.nbits, start);
+        // SAFETY: `_find_next_bit` tolerates out-of-bounds arguments and returns a
+        // value larger than or equal to `self.nbits` in that case.
+        let index = unsafe { bindings::_find_next_bit(self.as_ptr(), self.nbits, start) };
+        if index >= self.nbits {
+            None
+        } else {
+            Some(index)
+        }
+    }
+
+    /// Finds next zero bit, starting from `start`.
+    /// Returns `None` if `start` is greater than or equal to `self.nbits`.
+    #[inline]
+    pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
+        bitmap_hardening_assert!(start < self.nbits, "`start` must be < {} was {}", self.nbits, start);
+        // SAFETY: `_find_next_zero_bit` tolerates out-of-bounds arguments and returns a
+        // value larger than or equal to `self.nbits` in that case.
+        let index = unsafe { bindings::_find_next_zero_bit(self.as_ptr(), self.nbits, start) };
+        if index >= self.nbits {
+            None
+        } else {
+            Some(index)
+        }
+    }
+}
+
+use macros::kunit_tests;
+
+#[kunit_tests(rust_kernel_bitmap)]
+mod tests {
+    use super::*;
+    use kernel::alloc::flags::GFP_KERNEL;
+
+    #[test]
+    fn bitmap_new() {
+        let b = Bitmap::new(0, GFP_KERNEL).unwrap();
+        assert_eq!(0, b.len());
+
+        let b = Bitmap::new(3, GFP_KERNEL).unwrap();
+        assert_eq!(3, b.len());
+
+        let b = Bitmap::new(1024, GFP_KERNEL).unwrap();
+        assert_eq!(1024, b.len());
+
+        // Requesting too large values results in [`AllocError`].
+        let b = Bitmap::new(1 << 31, GFP_KERNEL);
+        assert!(b.is_err());
+    }
+
+    #[test]
+    fn bitmap_set_clear_find() {
+        let mut b = Bitmap::new(128, GFP_KERNEL).unwrap();
+
+        // Zero-initialized
+        assert_eq!(None, b.last_bit());
+
+        b.set_bit(17);
+
+        assert_eq!(Some(17), b.next_bit(0));
+        assert_eq!(Some(17), b.last_bit());
+
+        b.set_bit(107);
+
+        assert_eq!(Some(17), b.next_bit(0));
+        assert_eq!(Some(17), b.next_bit(17));
+        assert_eq!(Some(107), b.next_bit(18));
+        assert_eq!(Some(107), b.last_bit());
+
+        b.clear_bit(17);
+
+        assert_eq!(Some(107), b.next_bit(0));
+        assert_eq!(Some(107), b.last_bit());
+    }
+
+    #[test]
+    fn bitmap_out_of_bounds() {
+        let mut b = Bitmap::new(128, GFP_KERNEL).unwrap();
+
+        assert_eq!(None, b.next_bit(2048));
+        assert_eq!(None, b.next_zero_bit(2048));
+        assert_eq!(None, b.last_bit(2048));
+    }
+
+    #[test]
+    fn bitmap_copy_and_extend() {
+        let mut long_bitmap = Bitmap::new(256, GFP_KERNEL).unwrap();
+
+        long_bitmap.set_bit(3);
+        long_bitmap.set_bit(200);
+
+        let mut short_bitmap = Bitmap::new(32, GFP_KERNEL).unwrap();
+
+        short_bitmap.set_bit(17);
+
+        long_bitmap.copy_and_extend(&short_bitmap);
+        // The larger bits have been cleared.
+        assert_eq!(Some(17), long_bitmap.next_bit(0));
+        assert_eq!(Some(17), long_bitmap.last_bit());
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index de07aadd1ff5..8c4161cd82ac 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@
 pub use ffi;
 
 pub mod alloc;
+pub mod bitmap;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 #[doc(hidden)]
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 3fe9d7b945c4..926665bbc8f2 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -324,6 +324,15 @@ config LIST_HARDENED
 
 	  If unsure, say N.
 
+config RUST_BITMAP_HARDENED
+	bool "Check integrity of linked list manipulation"
+	help
+	  Enables additional assertions in the Rust Bitmap API to catch
+	  arguments that are not guaranteed to result in an immediate access
+	  fault.
+
+	  If unsure, say N.
+
 config BUG_ON_DATA_CORRUPTION
 	bool "Trigger a BUG when data corruption is detected"
 	select LIST_HARDENED
-- 
2.49.0.1101.gccaa498523-goog

