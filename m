Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060623278D
	for <linux-hardening@vger.kernel.org>; Thu, 29 May 2025 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748547746; cv=none; b=kgoBMel17SLy/ef+MqTp3hTBhtapoRff5SpfxYX6UnLagymBuM80nXv8GSuygX33Aqp5SoxYm00e1xBmtgc//aQDO3AOywDebIMCWSXRIKmE+CS3Ca9Fk/RincjyO4/HzX9BQC6/9cXjXQY3NK3JUTFRcGiXBRsOPYeQO3eLqWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748547746; c=relaxed/simple;
	bh=3XdRkzdEIP0VP6eeI5r6MmydDt+f9F+T67X4UoY5VbI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pqYXVVjsz/v8l6BM3BGnxrQziowp1z1NiNVXQknBl8vsn3+hzBfNMqJJiqZzbBP5A2EkuljF2TqS9E1DyvuZr34ipo2wAoux8w2wVD9Uh2GuozjgzE0PPumI6bIiJnE+ZbcTguDALjwJL7D9n6O2K9iJixeYIeZKYyMABBKW42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=WWDq9UBz; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="WWDq9UBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1748547734; x=1748806934;
	bh=HN68gdchsErDCiX+8mZzN8z62u9XEZ5BTa4u64rFW/Y=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=WWDq9UBzIZDfShDQvJVGfcW4ShsA0fwSXu3P3yQE4mbPafyTWCRfQ7RuFQqv3bES2
	 k5TgG89m7y/U+jsIRbchQmYodiZHsJC37H1DaBLbKEAuNqKm8uJwnjC8Htwe+mEUjo
	 ySbYFURWcZ0K/zwDWdaKQRH3j4uGKl5JyX1K/9pH/uUoU/AyIU9GgrjjWSRggPkHSW
	 4oPPAYTwBFQfSPojxY6psW7aEGFXm2R5I0aAbX+2l2Ky1kpJ9hRWTsA7cUY+jNZ8kY
	 atXduUDNpgozPLHmay8uHOrk3y7mH50QqWGaIxPHID2WcY4MQ8bZD+1TdF3wZJphaJ
	 5z0mjgppQuX+Q==
Date: Thu, 29 May 2025 19:42:09 +0000
To: Burak Emir <bqe@google.com>
From: Pekka Ristola <pekkarr@protonmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Pekka Ristola <pekkarr@protonmail.com>
Subject: Re: [PATCH v9 3/5] rust: add bitmap API.
Message-ID: <20250529193850.22210-1-pekkarr@protonmail.com>
Feedback-ID: 29854222:user:proton
X-Pm-Message-ID: 49f166e831a99e11ca288c31792490ba4db523c5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 May 2025 15:01:32 +0000, Burak Emir wrote:
> Provides an abstraction for C bitmap API and bitops operations.
>=20
> This commit enables a Rust implementation of an Android Binder
> data structure from commit 15d9da3f818c ("binder: use bitmap for faster
> descriptor lookup"), which can be found in drivers/android/dbitmap.h.
> It is a step towards upstreaming the Rust port of Android Binder driver.
>=20
> We follow the C Bitmap API closely in naming and semantics, with
> a few differences that take advantage of Rust language facilities
> and idioms:
>=20
>    * We leverage Rust type system guarantees as follows:
>=20
>      * all (non-atomic) mutating operations require a &mut reference whic=
h
>        amounts to exclusive access.
>=20
>      * the Bitmap type implements Send. This enables transferring
>        ownership between threads and is needed for Binder.
>=20
>      * the Bitmap type implements Sync, which enables passing shared
>        references &Bitmap between threads. Atomic operations can be
>        used to safely modify from multiple threads (interior
>        mutability), though without ordering guarantees.
>=20
>    * The Rust API uses `{set,clear}_bit` vs `{set,clear}_bit_atomic` as
>      names, which differs from the C naming convention which uses
>      set_bit for atomic vs __set_bit for non-atomic.
>=20
>    * we include enough operations for the API to be useful, but not all
>      operations are exposed yet in order to avoid dead code. The missing
>      ones can be added later.
>=20
>    * We follow the C API closely with a fine-grained approach to safety:
>=20
>      * Low-level bit-ops get a safe API with bounds checks. Calling with
>        an out-of-bounds arguments to {set,clear}_bit becomes a no-op and
>        get logged as errors.
>=20
>      * We introduce a RUST_BITMAP_HARDENED config, which
>        causes invocations with out-of-bounds arguments to panic.
>=20
>      * methods correspond to find_* C methods tolerate out-of-bounds
>        since the C implementation does. Also here, we log out-of-bounds
>        arguments as errors and panic in RUST_BITMAP_HARDENED mode.
>=20
>      * We add a way to "borrow" bitmaps from C in Rust, to make C bitmaps
>        that were allocated in C directly usable in Rust code (`CBitmap`).
>=20
>    * the Rust API is optimized to represent the bitmap inline if it would
>      fit into a pointer. This saves allocations which is
>      relevant in the Binder use case.
>=20
> The underlying C bitmap is*not* exposed, and must never be exposed
> (except in tests). Exposing the representation of the owned bitmap would
> lose static guarantees.
>=20
> An alternative route of vendoring an existing Rust bitmap package was
> considered but suboptimal overall. Reusing the C implementation is
> preferable for a basic data structure like bitmaps. It enables Rust
> code to be a lot more similar and predictable with respect to C code
> that uses the same data structures and enables the use of code that
> has been tried-and-tested in the kernel, with the same performance
> characteristics whenever possible.
>=20
> We use the `usize` type for sizes and indices into the bitmap,
> because Rust generally always uses that type for indices and lengths
> and it will be more convenient if the API accepts that type. This means
> that we need to perform some casts to/from u32 and usize, since the C
> headers use unsigned int instead of size_t/unsigned long for these
> numbers in some places.
>=20
> Adds new MAINTAINERS section BITMAP API [RUST].
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>   MAINTAINERS                |   7 +
>   rust/kernel/bitmap.rs      | 554 +++++++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs         |   1 +
>   security/Kconfig.hardening |  10 +
>   4 files changed, 572 insertions(+)
>   create mode 100644 rust/kernel/bitmap.rs
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04d6727e944c..565eaa015d9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4127,6 +4127,13 @@ S:=09Maintained
>   F:=09rust/helpers/bitmap.c
>   F:=09rust/helpers/cpumask.c
>  =20
> +BITMAP API [RUST]
> +M:=09Alice Ryhl <aliceryhl@google.com>
> +M:=09Burak Emir <bqe@google.com>
> +R:=09Yury Norov <yury.norov@gmail.com>
> +S:=09Maintained
> +F:=09rust/kernel/bitmap.rs
> +
>   BITOPS API
>   M:=09Yury Norov <yury.norov@gmail.com>
>   R:=09Rasmus Villemoes <linux@rasmusvillemoes.dk>
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> new file mode 100644
> index 000000000000..a6edd4889518
> --- /dev/null
> +++ b/rust/kernel/bitmap.rs
> @@ -0,0 +1,554 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Rust API for bitmap.
> +//!
> +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h=
).
> +
> +use crate::alloc::{AllocError, Flags};
> +use crate::bindings;
> +use crate::pr_err;
> +use core::ptr::NonNull;
> +
> +/// Represents a C bitmap. Wraps underlying C bitmap API.
> +///
> +/// # Invariants
> +///
> +/// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
> +pub struct CBitmap {
> +    _align: [usize; 0],
> +    data: [()],

Interestingly, this zero sized slice layout seems to be fine under Tree
Borrows but UB under Stacked Borrows. This slightly modified version[0]
that runs in userspace triggers Miri with Stacked Borrows.

Though I guess it's fine since Miri doesn't complain with Tree Borrows.

[0] https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D202=
4&gist=3D0ccf6fd892c044db9b644a77ad9bd1e9

> +}
> +
> +impl CBitmap {
> +    /// Borrows a C bitmap.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * `ptr` holds a non-null address of an initialized array of `uns=
igned long`
> +    ///   that is large enough to hold `nbits` bits.
> +    /// * the array must not be freed for the lifetime of this [`CBitmap=
`]
> +    /// * concurrent access only happens through atomic operations
> +    pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a C=
Bitmap {
> +        let data: *const [()] =3D core::ptr::slice_from_raw_parts(ptr.ca=
st(), nbits);
> +        unsafe { &*(data as *const CBitmap) }

Safety comment is missing here. Running Clippy with `make LLVM=3D1 CLIPPY=
=3D1`
finds all the missing safety comments and some other issues as well.

[...]

> +/// Holds either a pointer to array of `unsigned long` or a small bitmap=
.
> +#[repr(C)]
> +union BitmapRepr {
> +    bitmap: usize,
> +    ptr: NonNull<usize>,
> +}
> +
> +macro_rules! bitmap_assert {
> +    ($cond:expr, $($arg:tt)+) =3D> {
> +        #[cfg(RUST_BITMAP_HARDENED)]
> +        assert!($e, $($arg)*);

Should be $cond instead of $e.

> +    }
> +}
> +
> +macro_rules! bitmap_assert_return {
> +    ($cond:expr, $($arg:tt)+) =3D> {
> +        #[cfg(RUST_BITMAP_HARDENED)]
> +        assert!($e, $($arg)*);

Same here.

> +
> +        #[cfg(not(RUST_BITMAP_HARDENED))]
> +        if !($cond) {
> +            pr_err!($($arg)*);
> +            return
> +        }
> +    }
> +}
> +
> +/// Represents an owned bitmap.
> +///
> +/// Wraps underlying C bitmap API. See [`CBitmap`] for available
> +/// methods.
> +///
> +/// # Examples
> +///
> +/// Basic usage
> +///
> +/// ```
> +/// use kernel::alloc::flags::GFP_KERNEL;
> +/// use kernel::bitmap::Bitmap;
> +///
> +/// let mut b =3D Bitmap::new(16, GFP_KERNEL)?;
> +///
> +/// assert_eq!(16, b.len());
> +/// for i in 0..16 {
> +///     if i % 4 =3D=3D 0 {
> +///       b.set_bit(i);
> +///     }
> +/// }
> +/// assert_eq!(Some(0), b.next_bit(0));
> +/// assert_eq!(Some(1), b.next_zero_bit(0));
> +/// assert_eq!(Some(4), b.next_bit(1));
> +/// assert_eq!(Some(5), b.next_zero_bit(4));
> +/// assert_eq!(Some(12), b.last_bit());
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// * `inner.nbits` is `<=3D i32::MAX` and never changes.
> +/// * if `inner.nbits <=3D bindings::BITS_PER_LONG`, then `inner.repr` i=
s
> +///   a `usize`.
> +/// * otherwise, `inner.repr` holds a non-null pointer to an initialized
> +///   array of `unsigned long` that is large enough to hold `nbits` bits=
.

There is no `inner` in the struct.

> +pub struct Bitmap {
> +    /// Representation of bitmap.
> +    repr: BitmapRepr,
> +    /// Length of this bitmap. Must be `<=3D i32::MAX`.
> +    nbits: usize,
> +}
> +
> +impl core::ops::Deref for Bitmap {
> +    type Target =3D CBitmap;
> +
> +    fn deref(&self) -> &CBitmap {
> +        let ptr =3D if self.nbits <=3D bindings::BITS_PER_LONG as _ {
> +            // SAFETY: Bitmap is represented inline.
> +            unsafe { core::ptr::addr_of!(self.repr.bitmap) }

This can use the raw ref syntax, `&raw const self.repr.bitmap`.

> +        } else {
> +            // SAFETY: Bitmap is represented as array of `unsigned long`=
.
> +            unsafe { self.repr.ptr.as_ptr() }
> +        };
> +
> +        // SAFETY: We got the right pointer and invariants of [`Bitmap`]=
 hold.
> +        // An inline bitmap is treated like an array with single element=
.
> +        unsafe { CBitmap::from_raw(ptr, self.nbits) }
> +    }
> +}
> +
> +impl core::ops::DerefMut for Bitmap {
> +    fn deref_mut(&mut self) -> &mut CBitmap {
> +        let ptr =3D if self.nbits <=3D bindings::BITS_PER_LONG as _ {
> +            // SAFETY: Bitmap is represented inline.
> +            unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }

Same here, `&raw mut self.repr.bitmap`.

[...]

> +    /// Set bit with index `index`, atomically.
> +    ///
> +    /// This is a relaxed atomic operation (no implied memory barriers).
> +    ///
> +    /// ATTENTION: The naming convention differs from C, where the corre=
sponding
> +    /// function is called `set_bit`.
> +    ///
> +    /// If RUST_BITMAP_HARDENED is not enabled and `index` is greater th=
an
> +    /// or equal to `self.len()`, does nothing.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if RUST_BITMAP_HARDENED is enabled and `index` is greater=
 than
> +    /// or equal to `self.len()`.
> +    #[inline]
> +    pub fn set_bit_atomic(&self, index: usize) {
> +        bitmap_assert_return!(
> +            index < self.len(),
> +            "Bit `index` must be < {}, was {}",
> +            self.len(),
> +            index
> +        );
> +        // SAFETY: `index` is within bounds and the caller has ensured t=
hat
> +        // there is no mix of non-atomic and atomic operations.
> +        unsafe { bindings::set_bit(index as u32, self.as_ptr() as *mut u=
size) };

Maybe use `.cast_mut()` instead of `as *mut usize`?

[...]

> +    /// Clear `index` bit, atomically.
> +    ///
> +    /// This is a relaxed atomic operation (no implied memory barriers).
> +    ///
> +    /// ATTENTION: The naming convention differs from C, where the corre=
sponding
> +    /// function is called `clear_bit`.
> +    ///
> +    /// If RUST_BITMAP_HARDENED is not enabled and `index` is greater th=
an
> +    /// or equal to `self.len()`, does nothing.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if RUST_BITMAP_HARDENED is enabled and `index` is greater=
 than
> +    /// or equal to `self.len()`.
> +    #[inline]
> +    pub fn clear_bit_atomic(&self, index: usize) {
> +        bitmap_assert_return!(
> +            index < self.len(),
> +            "Bit `index` must be < {}, was {}",
> +            self.len(),
> +            index
> +        );
> +        // SAFETY: `index` is within bounds and the caller has ensured t=
hat
> +        // there is no mix of non-atomic and atomic operations.
> +        unsafe { bindings::clear_bit(index as u32, self.as_ptr() as *mut=
 usize) };

Same here. `cast_mut` won't silently change the type unlike `as` casts so
it's a bit safer.

> +    }
> +
> +    /// Copy `src` into this [`Bitmap`] and set any remaining bits to ze=
ro.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::bitmap::Bitmap;
> +    ///
> +    /// let mut long_bitmap =3D Bitmap::new(256, GFP_KERNEL)?;
> +    //
> +    /// assert_eq!(None, long_bitmap.last_bit());
> +    //
> +    /// let mut short_bitmap =3D Bitmap::new(16, GFP_KERNEL)?;
> +    //
> +    /// short_bitmap.set_bit(7);
> +    /// long_bitmap.copy_and_extend(&short_bitmap);
> +    /// assert_eq!(Some(7), long_bitmap.last_bit());
> +    ///
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn copy_and_extend(&mut self, src: &Bitmap) {
> +        let len =3D core::cmp::min(src.nbits, self.len());
> +        // SAFETY: access to `self` and `src` is within bounds.
> +        unsafe {
> +            bindings::bitmap_copy_and_extend(
> +                self.as_mut_ptr(),
> +                src.as_ptr(),
> +                len as u32,
> +                self.len() as u32,
> +            )

Would this cause a data race if `src` is concurrently (atomically)
modified? The C function seems to use a plain `memcpy` which is not atomic.

> +        };
> +    }
> +
> +    /// Finds last set bit.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::bitmap::Bitmap;
> +    ///
> +    /// let bitmap =3D Bitmap::new(64, GFP_KERNEL)?;
> +    ///
> +    /// match bitmap.last_bit() {
> +    ///     Some(idx) =3D> {
> +    ///         pr_info!("The last bit has index {idx}.\n");
> +    ///     }
> +    ///     None =3D> {
> +    ///         pr_info!("All bits in this bitmap are 0.\n");
> +    ///     }
> +    /// }
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn last_bit(&self) -> Option<usize> {
> +        // SAFETY: `_find_next_bit` access is within bounds due to invar=
iant.
> +        let index =3D unsafe { bindings::_find_last_bit(self.as_ptr(), s=
elf.len()) };

The C function uses non-atomic reads, so this might cause data races too.

> +        if index >=3D self.len() {
> +            None
> +        } else {
> +            Some(index)
> +        }
> +    }

Pekka

