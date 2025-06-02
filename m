Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E222B223338
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872385; cv=none; b=Ip58PE8P8D1SUGYvQIXhSnqVvZ3B/WYQ1/G8ksH/OTOWB4OnPNFCttJTnoXvz1Wo7PqIIpl8/GBYK4YwoTUbxNcxRYAhcQCJV44MZY692uVC3cW4csvnHb3x6683+PEr61mNYukK2Ab2s1WE1sGr4+BU0YTiJKNF7Q/mq7UOv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872385; c=relaxed/simple;
	bh=MDiwe92RemLQLWAZR4Ed9qqgZux7gkmUeCG7b+J1LrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X7Qh7ZdM7Yh9DLEBbhrbYTHmDO9ILwmlfLzXQ3skdDqtFsK4Ivwjdh+Bg5BvR3Ux/9mfbZJBNE7x5WjS7fsuZj7c7Esn1KCY82rFzN58g4o3iZg7Hs70P4aonhL11yIWcmHl8p8xxyORT/T7LJueTlQ94Orli9nwasvvDCaTtjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSbnkWR8; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSbnkWR8"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1596701f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748872381; x=1749477181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5z04fSJNTsj+SlnGV0/f++pcxzdZGZYxACIWYUFTzv8=;
        b=MSbnkWR8St9PfjrVKS5n35VGcf/q0bo+uql+ozM4a2hykeRbneJ19PvKVjITuIjdLQ
         Xa9NNTWYlZUmDDmPVt/egsNJiCYsSryB0tUhGaD+jk5aqSjU4aUSzkOwljDymJhAwEIO
         C9/Yn0+IWagjAVpulPPoRrLjBwJn6CDISCJZmhkIXS9hv9WS4iytWAsvsOzKOS01s5/X
         a4r5KPU5Jl3J+8qXkmMjtKdkwwmHcIHGI1/6JFC+okKVAQHGwkFX2wHMaHpz/dtWNarC
         XO8PIjkoNV8gmx42ZlweyzsPd0Yo53110B2EdiGA5wvxwzpJBVC6VGTMRmhhTR2CpFF+
         SSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872381; x=1749477181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5z04fSJNTsj+SlnGV0/f++pcxzdZGZYxACIWYUFTzv8=;
        b=pAfBsVHyM0IP66fSfMJx2q7mhYFrq696ToNSvmKGVzCWJtH0WlakE9r5TY8s41nnfz
         Zg3YN3miYyZe6FyT0V1ZRmMDBMhU5Gm/ANGDTybhAj8snb25euQDP9Stc4YWOj4bZHSl
         6enIzWhWPPTBTYPDFZkegsWy3CyIQawySVfS95lZy/AwliEP1pqxL5X9SEW2wxBJdmqE
         itc988M6xnf8hdQ1Vyc8oLHg97KyynuZl2jN0Cx3aLlG8V/L9uQHsZxbvHtDzI9ldQi6
         1Mh2fpAsLSyvcywwGVRXkAZK0o+SXYK064T5sSzSZBqLK5xVIuiRxc0+DkpXoXH6F8b3
         iVfw==
X-Forwarded-Encrypted: i=1; AJvYcCWB585/b0Fbi/375zFnrTN0deyE2lqxQ876TMpsoRTRwganzgPUVcYtZ69QEwfMA5OcRYmZsXOIGQ3C0FTaK5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBiFP89q92fXQLRj63zGIfyg4+QDoxqldEuPq97pnLD8g6XXi
	H3Bo72WxmcOQ2hKLIaKk5AAvqqUdKewlI3igYwIDS7dP1/jmZ978Co4MG3jJDNfStTHngg==
X-Google-Smtp-Source: AGHT+IFMf7nZyL7Nc5A1jaLv72eFIhDtDO1O0+xvpo6yvZ+fEQJnH3/cQKB9GhhO6Y+LtYmFQ+r39sQ=
X-Received: from wmcn1.prod.google.com ([2002:a05:600c:c0c1:b0:450:dc81:eec9])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2407:b0:3a4:f024:6717
 with SMTP id ffacd0b85a97d-3a4f89e169cmr10727046f8f.53.1748872381346; Mon, 02
 Jun 2025 06:53:01 -0700 (PDT)
Date: Mon,  2 Jun 2025 13:52:22 +0000
In-Reply-To: <20250602135231.1615281-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602135231.1615281-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602135231.1615281-4-bqe@google.com>
Subject: [PATCH v11 3/5] rust: add bitmap API.
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

Provides an abstraction for C bitmap API and bitops operations.

This commit enables a Rust implementation of an Android Binder
data structure from commit 15d9da3f818c ("binder: use bitmap for faster
descriptor lookup"), which can be found in drivers/android/dbitmap.h.
It is a step towards upstreaming the Rust port of Android Binder driver.

We follow the C Bitmap API closely in naming and semantics, with
a few differences that take advantage of Rust language facilities
and idioms:

  * We leverage Rust type system guarantees as follows:

    * all (non-atomic) mutating operations require a &mut reference which
      amounts to exclusive access.

    * the Bitmap type implements Send. This enables transferring
      ownership between threads and is needed for Binder.

    * the Bitmap type implements Sync, which enables passing shared
      references &Bitmap between threads. Atomic operations can be
      used to safely modify from multiple threads (interior
      mutability), though without ordering guarantees.

  * The Rust API uses `{set,clear}_bit` vs `{set,clear}_bit_atomic` as
    names, which differs from the C naming convention which uses
    set_bit for atomic vs __set_bit for non-atomic.

  * we include enough operations for the API to be useful, but not all
    operations are exposed yet in order to avoid dead code. The missing
    ones can be added later.

  * We follow the C API closely with a fine-grained approach to safety:

    * Low-level bit-ops get a safe API with bounds checks. Calling with
      an out-of-bounds arguments to {set,clear}_bit becomes a no-op and
      get logged as errors.

    * We introduce a RUST_BITMAP_HARDENED config, which
      causes invocations with out-of-bounds arguments to panic.

    * methods correspond to find_* C methods tolerate out-of-bounds
      since the C implementation does. Also here, we log out-of-bounds
      arguments as errors and panic in RUST_BITMAP_HARDENED mode.

    * We add a way to "borrow" bitmaps from C in Rust, to make C bitmaps
      that were allocated in C directly usable in Rust code (`CBitmap`).

  * the Rust API is optimized to represent the bitmap inline if it would
    fit into a pointer. This saves allocations which is
    relevant in the Binder use case.

The underlying C bitmap is *not* exposed, and must never be exposed
(except in tests). Exposing the representation of the owned bitmap would
lose static guarantees.

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
 rust/kernel/bitmap.rs      | 574 +++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs         |   1 +
 security/Kconfig.hardening |  10 +
 4 files changed, 592 insertions(+)
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
index 000000000000..28c11e400d1e
--- /dev/null
+++ b/rust/kernel/bitmap.rs
@@ -0,0 +1,574 @@
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
+use crate::pr_err;
+use core::ptr::NonNull;
+
+/// Represents a C bitmap. Wraps underlying C bitmap API.
+///
+/// # Invariants
+///
+/// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
+#[cfg_attr(CONFIG_64BIT, repr(align(8)))]
+#[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
+pub struct CBitmap {
+    data: [()],
+}
+
+/// SAFETY: All methods that take immutable references are either atomic or read-only.
+unsafe impl Sync for CBitmap {}
+
+impl CBitmap {
+    /// Borrows a C bitmap.
+    ///
+    /// # Safety
+    ///
+    /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
+    ///   that is large enough to hold `nbits` bits.
+    /// * the array must not be freed for the lifetime of this [`CBitmap`]
+    /// * concurrent access only happens through atomic operations
+    pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a CBitmap {
+        let data: *const [()] = core::ptr::slice_from_raw_parts(ptr.cast(), nbits);
+        // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // SAFETY:
+        // The caller guarantees that `data` (derived from `ptr` and `nbits`)
+        // points to a valid, initialized, and appropriately sized memory region
+        // that will not be freed for the lifetime 'a.
+        // We are casting `*const [()]` to `*const CBitmap`. The `CBitmap`
+        // struct is a ZST with a `data: [()]` field. This means its layout
+        // is compatible with a slice of `()`, and effectively it's a "thin pointer"
+        // (its size is 0 and alignment is 1). The `slice_from_raw_parts`
+        // function correctly encodes the length (number of bits, not elements)
+        // into the metadata of the fat pointer. Therefore, dereferencing this
+        // pointer as `&CBitmap` is safe given the caller's guarantees.
+        unsafe { &*(data as *const CBitmap) }
+    }
+
+    /// Borrows a C bitmap exclusively.
+    ///
+    /// # Safety
+    ///
+    /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
+    ///   that is large enough to hold `nbits` bits.
+    /// * the array must not be freed for the lifetime of this [`CBitmap`]
+    /// * no concurrent access may happen.
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &'a mut CBitmap {
+        let data: *mut [()] = core::ptr::slice_from_raw_parts_mut(ptr.cast(), nbits);
+        // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // SAFETY:
+        // The caller guarantees that `data` (derived from `ptr` and `nbits`)
+        // points to a valid, initialized, and appropriately sized memory region
+        // that will not be freed for the lifetime 'a.
+        // Furthermore, the caller guarantees no concurrent access will happen,
+        // which upholds the exclusivity requirement for a mutable reference.
+        // Similar to `from_raw`, casting `*mut [()]` to `*mut CBitmap` is
+        // safe because `CBitmap` is a ZST with a `data: [()]` field,
+        // making its layout compatible with a slice of `()`.
+        unsafe { &mut *(data as *mut CBitmap) }
+    }
+
+    /// Returns a raw pointer to the backing [`Bitmap`].
+    pub fn as_ptr(&self) -> *const usize {
+        self as *const CBitmap as *const usize
+    }
+
+    /// Returns a mutable raw pointer to the backing [`Bitmap`].
+    pub fn as_mut_ptr(&mut self) -> *mut usize {
+        self as *mut CBitmap as *mut usize
+    }
+
+    /// Returns length of this [`CBitmap`].
+    #[allow(clippy::len_without_is_empty)]
+    pub fn len(&self) -> usize {
+        self.data.len()
+    }
+}
+
+/// Holds either a pointer to array of `unsigned long` or a small bitmap.
+#[repr(C)]
+union BitmapRepr {
+    bitmap: usize,
+    ptr: NonNull<usize>,
+}
+
+macro_rules! bitmap_assert {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(RUST_BITMAP_HARDENED)]
+        assert!($e, $($arg)*);
+    }
+}
+
+macro_rules! bitmap_assert_return {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(RUST_BITMAP_HARDENED)]
+        assert!($e, $($arg)*);
+
+        #[cfg(not(RUST_BITMAP_HARDENED))]
+        if !($cond) {
+            pr_err!($($arg)*);
+            return
+        }
+    }
+}
+
+/// Represents an owned bitmap.
+///
+/// Wraps underlying C bitmap API. See [`CBitmap`] for available
+/// methods.
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
+/// * if `nbits <= bindings::BITS_PER_LONG`, then `repr` is a `usize`.
+/// * otherwise, `repr` holds a non-null pointer to an initialized
+///   array of `unsigned long` that is large enough to hold `nbits` bits.
+pub struct Bitmap {
+    /// Representation of bitmap.
+    repr: BitmapRepr,
+    /// Length of this bitmap. Must be `<= i32::MAX`.
+    nbits: usize,
+}
+
+impl core::ops::Deref for Bitmap {
+    type Target = CBitmap;
+
+    fn deref(&self) -> &CBitmap {
+        let ptr = if self.nbits <= bindings::BITS_PER_LONG as _ {
+            // SAFETY: Bitmap is represented inline.
+            unsafe { core::ptr::addr_of!(self.repr.bitmap) }
+        } else {
+            // SAFETY: Bitmap is represented as array of `unsigned long`.
+            unsafe { self.repr.ptr.as_ptr() }
+        };
+
+        // SAFETY: We got the right pointer and invariants of [`Bitmap`] hold.
+        // An inline bitmap is treated like an array with single element.
+        unsafe { CBitmap::from_raw(ptr, self.nbits) }
+    }
+}
+
+impl core::ops::DerefMut for Bitmap {
+    fn deref_mut(&mut self) -> &mut CBitmap {
+        let ptr = if self.nbits <= bindings::BITS_PER_LONG as _ {
+            // SAFETY: Bitmap is represented inline.
+            unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
+        } else {
+            // SAFETY: Bitmap is represented as array of `unsigned long`.
+            unsafe { self.repr.ptr.as_mut() }
+        };
+
+        // SAFETY: We got the right pointer and invariants of [`Bitmap`] hold.
+        // An inline bitmap is treated like an array with single element.
+        unsafe { CBitmap::from_raw_mut(ptr, self.nbits) }
+    }
+}
+
+/// Enable ownership transfer to other threads.
+///
+/// SAFETY: We own the underlying bitmap representation.
+unsafe impl Send for Bitmap {}
+
+/// Enable unsynchronized concurrent access to [`Bitmap`] through shared references.
+///
+/// SAFETY: `deref()` will return a reference to a [`CBitmap`] which is Sync. Its methods
+/// that take immutable references are either atomic or read-only.
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
+        unsafe { bindings::bitmap_free(self.repr.ptr.as_ptr()) };
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
+        Ok(Bitmap {
+            repr: BitmapRepr { ptr },
+            nbits,
+        })
+    }
+
+    /// Returns length of this [`Bitmap`].
+    #[allow(clippy::len_without_is_empty)]
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.nbits
+    }
+}
+
+impl CBitmap {
+    /// Set bit with index `index`.
+    ///
+    /// ATTENTION: `set_bit` is non-atomic, which differs from the naming
+    /// convention in C code. The corresponding C function is `__set_bit`.
+    ///
+    /// If RUST_BITMAP_HARDENED is not enabled and `index` is greater than
+    /// or equal to `self.nbits`, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if RUST_BITMAP_HARDENED is enabled and `index` is greater than
+    /// or equal to `self.nbits`.
+    #[inline]
+    pub fn set_bit(&mut self, index: usize) {
+        bitmap_assert_return!(
+            index < self.len(),
+            "Bit `index` must be < {}, was {}",
+            self.len(),
+            index
+        );
+        // SAFETY: Bit `index` is within bounds.
+        unsafe { bindings::__set_bit(index, self.as_mut_ptr()) };
+    }
+
+    /// Set bit with index `index`, atomically.
+    ///
+    /// This is a relaxed atomic operation (no implied memory barriers).
+    ///
+    /// ATTENTION: The naming convention differs from C, where the corresponding
+    /// function is called `set_bit`.
+    ///
+    /// If RUST_BITMAP_HARDENED is not enabled and `index` is greater than
+    /// or equal to `self.len()`, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if RUST_BITMAP_HARDENED is enabled and `index` is greater than
+    /// or equal to `self.len()`.
+    #[inline]
+    pub fn set_bit_atomic(&self, index: usize) {
+        bitmap_assert_return!(
+            index < self.len(),
+            "Bit `index` must be < {}, was {}",
+            self.len(),
+            index
+        );
+        // SAFETY: `index` is within bounds and the caller has ensured that
+        // there is no mix of non-atomic and atomic operations.
+        unsafe { bindings::set_bit(index, self.as_ptr() as *mut usize) };
+    }
+
+    /// Clear `index` bit.
+    ///
+    /// ATTENTION: `clear_bit` is non-atomic, which differs from the naming
+    /// convention in C code. The corresponding C function is `__clear_bit`.
+    ///
+    /// If RUST_BITMAP_HARDENED is not enabled and `index` is greater than
+    /// or equal to `self.len()`, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if RUST_BITMAP_HARDENED is enabled and `index` is greater than
+    /// or equal to `self.len()`.
+    #[inline]
+    pub fn clear_bit(&mut self, index: usize) {
+        bitmap_assert_return!(
+            index < self.len(),
+            "Bit `index` must be < {}, was {}",
+            self.len(),
+            index
+        );
+        // SAFETY: `index` is within bounds.
+        unsafe { bindings::__clear_bit(index, self.as_mut_ptr()) };
+    }
+
+    /// Clear `index` bit, atomically.
+    ///
+    /// This is a relaxed atomic operation (no implied memory barriers).
+    ///
+    /// ATTENTION: The naming convention differs from C, where the corresponding
+    /// function is called `clear_bit`.
+    ///
+    /// If RUST_BITMAP_HARDENED is not enabled and `index` is greater than
+    /// or equal to `self.len()`, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if RUST_BITMAP_HARDENED is enabled and `index` is greater than
+    /// or equal to `self.len()`.
+    #[inline]
+    pub fn clear_bit_atomic(&self, index: usize) {
+        bitmap_assert_return!(
+            index < self.len(),
+            "Bit `index` must be < {}, was {}",
+            self.len(),
+            index
+        );
+        // SAFETY: `index` is within bounds and the caller has ensured that
+        // there is no mix of non-atomic and atomic operations.
+        unsafe { bindings::clear_bit(index, self.as_ptr() as *mut usize) };
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
+        let len = core::cmp::min(src.nbits, self.len());
+        // SAFETY: access to `self` and `src` is within bounds.
+        unsafe {
+            bindings::bitmap_copy_and_extend(
+                self.as_mut_ptr(),
+                src.as_ptr(),
+                len as u32,
+                self.len() as u32,
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
+        let index = unsafe { bindings::_find_last_bit(self.as_ptr(), self.len()) };
+        if index >= self.len() {
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
+        bitmap_assert!(
+            start < self.len(),
+            "`start` must be < {} was {}",
+            self.len(),
+            start
+        );
+        // SAFETY: `_find_next_bit` tolerates out-of-bounds arguments and returns a
+        // value larger than or equal to `self.len()` in that case.
+        let index = unsafe { bindings::_find_next_bit(self.as_ptr(), self.len(), start) };
+        if index >= self.len() {
+            None
+        } else {
+            Some(index)
+        }
+    }
+
+    /// Finds next zero bit, starting from `start`.
+    /// Returns `None` if `start` is greater than or equal to `self.len()`.
+    #[inline]
+    pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
+        bitmap_assert!(
+            start < self.len(),
+            "`start` must be < {} was {}",
+            self.len(),
+            start
+        );
+        // SAFETY: `_find_next_zero_bit` tolerates out-of-bounds arguments and returns a
+        // value larger than or equal to `self.len()` in that case.
+        let index = unsafe { bindings::_find_next_zero_bit(self.as_ptr(), self.len(), start) };
+        if index >= self.len() {
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
+    fn cbitmap_borrow() {
+        let fake_c_bitmap: [usize; 2] = [0, 0];
+        // SAFETY: `fake_c_bitmap` is an array of expected length.
+        let b = unsafe {
+            CBitmap::from_raw(
+                core::ptr::addr_of!(fake_c_bitmap) as *const usize,
+                2 * bindings::BITS_PER_LONG as usize,
+            )
+        };
+        assert_eq!(2 * bindings::BITS_PER_LONG as usize, b.len());
+        assert_eq!(None, b.next_bit(0));
+    }
+
+    #[test]
+    fn cbitmap_copy() {
+        let fake_c_bitmap: usize = 0xFF;
+        // SAFETY: `fake_c_bitmap` can be used as one-element array of expected length.
+        let b = unsafe { CBitmap::from_raw(core::ptr::addr_of!(fake_c_bitmap), 8) };
+        assert_eq!(8, b.len());
+        assert_eq!(None, b.next_zero_bit(0));
+    }
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
+        assert_eq!(None, b.next_bit(0));
+        assert_eq!(Some(0), b.next_zero_bit(0));
+        assert_eq!(None, b.last_bit());
+
+        b.set_bit(17);
+
+        assert_eq!(Some(17), b.next_bit(0));
+        assert_eq!(Some(17), b.next_bit(17));
+        assert_eq!(None, b.next_bit(18));
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
+    #[cfg(not(RUST_BITMAP_HARDENED))]
+    #[test]
+    fn bitmap_out_of_bounds() {
+        let mut b = Bitmap::new(128, GFP_KERNEL).unwrap();
+
+        b.set_bit(2048);
+        b.set_bit_atomic(2048);
+        b.clear_bit(2048);
+        b.clear_bit_atomic(2048);
+        assert_eq!(None, b.next_bit(2048));
+        assert_eq!(None, b.next_zero_bit(2048));
+        assert_eq!(None, b.last_bit());
+    }
+
+    // TODO: add test RUST_BITMAP_HARDENED when KUnit supports this type of config.
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
+
+        // Previous bits have been cleared.
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
index 3fe9d7b945c4..3ca3c7dc4381 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -324,6 +324,16 @@ config LIST_HARDENED
 
 	  If unsure, say N.
 
+config RUST_BITMAP_HARDENED
+	bool "Check integrity of linked list manipulation"
+	depends on CONFIG_RUST
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
2.49.0.1204.g71687c7c1d-goog

