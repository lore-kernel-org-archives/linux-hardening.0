Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75FF22259A
	for <linux-hardening@vger.kernel.org>; Thu, 12 Jun 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718023; cv=none; b=qwCPigbETNDHKVwsm+ztAt6g/G3UcVcgxwfN0M8cqhZI0Y3wX4r1wkDk3WXIzbWv4DZ0CHP2SN9uDYwptW+fEbMri/+hw920jiXfmm+pu12bMnEnzOy01Whg1ITV12MXN2V6d1xozYvuip30NMneLz/Gk5Mx9HnZt9ppnUJSpUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718023; c=relaxed/simple;
	bh=IZhPENFSDhVY3cFOYkdh0rxvEIOeL3rV798hNc6/OYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1VZh6rMbkE+p7OnB2EYIxPths6G4lm01McKRangzSfkq7doOhzfAzEj6ZwpZASAWPuuvI45caBQ9SMo3BYNcLGQI/fUCPgmatr08GBL7SV7dlaHBkFxRonWQyZCQkzFXMy1Q0/aN1ZBHN2HYULbnAG3SWqcJVxYr0SrPujd5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hsaetEYT; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsaetEYT"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4074997ce2bso188510b6e.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jun 2025 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749718020; x=1750322820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URYsLG12m2hS1TJ45P5eOvVU8bDPgK05H43IYOFYz08=;
        b=hsaetEYTvH9i6/mtPl1daOoGZSygiQyOW9cW1QePEY/ripVn6rqC8M5FrBpVCRElbe
         XUbMOtkIxigd03B5sz+NNxDqf6G+teaAkjCtjyd2irQE+Yrb6or5rsjXrL22s13AVnZx
         hxUK1/JhsQdt9uJKfu7uQeT/y+Vg4DIhEy24BI4cwG6XxdXF1CNGBaCHg/R6Nt7r7Cb0
         MpiVYX2s8D4DTUsbYXNQuJM4Junwqws1Zw0rzfRNDMOcJvpyXut7waDlk5olIPIkK1dc
         LB2afmEMXs8GErPy39YgOh+q7hwpXoNJZMLTH1UWGhYNeSVxXEp8J+9r6h3VcuIPUptO
         o0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749718020; x=1750322820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URYsLG12m2hS1TJ45P5eOvVU8bDPgK05H43IYOFYz08=;
        b=FOjVEe5uuvtjBLS7NYumLFCHDqt2XVz8DWXIiT8P39x6yyiIUhQt9PbXO+bw18p93o
         4aDAD75NOUO+4WCdQS/jqJmQgkGISjkfGdvVjhi7Xvr21wz9hj9NJoJ0oCblTSL+EC6y
         WhuW1nc28g82Z6sT05VBLAGEdm/BqAg1AKuG5mqXojCGIWgkwnH1+Dx4RxhH0VfGOXyw
         k4I/k+AjNcXBR3I7Nx0kLPpdRo1wn7UmiuxlpowbONNSepXyWnF3n2yjeq4l5pns6nAB
         aAwgHtAJlnBT7APdkkeW2TCMdDhU/GZfvHT/kDDRIkenjKL1ytWEpPvsQdQcZsBKpaMB
         5pIw==
X-Forwarded-Encrypted: i=1; AJvYcCX9cPyTjpsvFBI+1ePVCcKC5j/cbvEKz3DpP3P8kMuArD4D0l9KJjzjOk3cPVXdIVnX1ZJvK5pnfbeps6xx84Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/4ADJ/yOLVM/bgqE6URvMfyjww0A4gmITcalkGn5r4e9cXzL
	03wrDV6cEoY+DFBIWETEG0bqW0d5T7gNYZU09dfo76Xx8k4jPHlRyEMkusE+Wo8OSrBeyiJRAqC
	ygOVHtxDq4KUf+TYrQJQqzJ06rPf0yS6VC985p5mH
X-Gm-Gg: ASbGncsjFHtIKJn4yHOV6s88M/Mnl34pds8nMoW9yv+p3JdBFTE1k6nMb0YT34LMz8P
	i2bpEhetDSQYLXPTpnufA/u3mM5Kb6lQ5EOgEuANp/pX6XwI9EXuqIzjR1dB0zaBPb0NPaCsp6K
	h23UXypa+7l18GBV9xDG29O690j01ssZqOuDcmt5MY2Hnlpef/QKI0eUElbBMbxtsemYY/r8pET
	g==
X-Google-Smtp-Source: AGHT+IHP7Vwp5nPC0xulZAJ7iBG5jk1eBk24nSpz4+bxxhppzuJtI7hJ6ehF36r2w5Rpwp+7BL5FnaTf3TfVWQi2Gpg=
X-Received: by 2002:a05:6808:3a09:b0:403:3973:23c4 with SMTP id
 5614622812f47-40a65fcb9a1mr1865067b6e.9.1749718019461; Thu, 12 Jun 2025
 01:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194840.877308-1-bqe@google.com> <20250611194840.877308-4-bqe@google.com>
 <CAH5fLgi1GBqDHvMh30fbxVUjnTETLXthpK6eGLJA0Vh_TZRnsQ@mail.gmail.com>
In-Reply-To: <CAH5fLgi1GBqDHvMh30fbxVUjnTETLXthpK6eGLJA0Vh_TZRnsQ@mail.gmail.com>
From: Burak Emir <bqe@google.com>
Date: Thu, 12 Jun 2025 10:46:46 +0200
X-Gm-Features: AX0GCFv98Pn9kYvvN90Gvw4jWYhAPagNO5ddvga328nLw_8rnEVeAtEUhREmC0Q
Message-ID: <CACQBu=W4PziG3Fsnzqu_wu-vgBThktD7FcEJ-vOhOMhNDz8h3g@mail.gmail.com>
Subject: Re: [PATCH v12 3/5] rust: add bitmap API.
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Wed, Jun 11, 2025 at 9:48=E2=80=AFPM Burak Emir <bqe@google.com> wrote=
:
[...]
> > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > new file mode 100644
> > index 000000000000..1fe72ca980ac
> > --- /dev/null
> > +++ b/rust/kernel/bitmap.rs
> > @@ -0,0 +1,582 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2025 Google LLC.
> > +
> > +//! Rust API for bitmap.
> > +//!
> > +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap=
.h).
> > +
> > +use crate::alloc::{AllocError, Flags};
> > +use crate::bindings;
> > +#[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> > +use crate::pr_err;
> > +use core::ptr::NonNull;
> > +
> > +/// Represents a C bitmap. Wraps underlying C bitmap API.
> > +///
> > +/// # Invariants
> > +///
> > +/// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
> > +#[cfg_attr(CONFIG_64BIT, repr(align(8)))]
> > +#[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
> > +pub struct CBitmap {
> > +    data: [()],
> > +}
>
> I wonder if we should just call this type Bitmap?
>

OK. I am renaming the other type to OwnedBitmap then.

> > +
> > +/// SAFETY: All methods that take immutable references are either atom=
ic or read-only.
> > +unsafe impl Sync for CBitmap {}
>
> You don't have any fields wrapping C types anymore, so this has no effect=
.

Removing.

> > +
> > +impl CBitmap {
> > +    /// Borrows a C bitmap.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * `ptr` holds a non-null address of an initialized array of `u=
nsigned long`
> > +    ///   that is large enough to hold `nbits` bits.
> > +    /// * the array must not be freed for the lifetime of this [`CBitm=
ap`]
> > +    /// * concurrent access only happens through atomic operations
> > +    pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a=
 CBitmap {
> > +        let data: *const [()] =3D core::ptr::slice_from_raw_parts(ptr.=
cast(), nbits);
> > +        // INVARIANT: `data` references an initialized array that can =
hold `nbits` bits.
> > +        // SAFETY:
> > +        // The caller guarantees that `data` (derived from `ptr` and `=
nbits`)
> > +        // points to a valid, initialized, and appropriately sized mem=
ory region
> > +        // that will not be freed for the lifetime 'a.
> > +        // We are casting `*const [()]` to `*const CBitmap`. The `CBit=
map`
> > +        // struct is a ZST with a `data: [()]` field. This means its l=
ayout
> > +        // is compatible with a slice of `()`, and effectively it's a =
"thin pointer"
> > +        // (its size is 0 and alignment is 1). The `slice_from_raw_par=
ts`
> > +        // function correctly encodes the length (number of bits, not =
elements)
> > +        // into the metadata of the fat pointer. Therefore, dereferenc=
ing this
> > +        // pointer as `&CBitmap` is safe given the caller's guarantees=
.
> > +        unsafe { &*(data as *const CBitmap) }
> > +    }
> > +
> > +    /// Borrows a C bitmap exclusively.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * `ptr` holds a non-null address of an initialized array of `u=
nsigned long`
> > +    ///   that is large enough to hold `nbits` bits.
> > +    /// * the array must not be freed for the lifetime of this [`CBitm=
ap`]
> > +    /// * no concurrent access may happen.
> > +    pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &=
'a mut CBitmap {
> > +        let data: *mut [()] =3D core::ptr::slice_from_raw_parts_mut(pt=
r.cast(), nbits);
> > +        // INVARIANT: `data` references an initialized array that can =
hold `nbits` bits.
> > +        // SAFETY:
> > +        // The caller guarantees that `data` (derived from `ptr` and `=
nbits`)
> > +        // points to a valid, initialized, and appropriately sized mem=
ory region
> > +        // that will not be freed for the lifetime 'a.
> > +        // Furthermore, the caller guarantees no concurrent access wil=
l happen,
> > +        // which upholds the exclusivity requirement for a mutable ref=
erence.
> > +        // Similar to `from_raw`, casting `*mut [()]` to `*mut CBitmap=
` is
> > +        // safe because `CBitmap` is a ZST with a `data: [()]` field,
> > +        // making its layout compatible with a slice of `()`.
> > +        unsafe { &mut *(data as *mut CBitmap) }
> > +    }
> > +
> > +    /// Returns a raw pointer to the backing [`Bitmap`].
> > +    pub fn as_ptr(&self) -> *const usize {
> > +        self as *const CBitmap as *const usize
> > +    }
> > +
> > +    /// Returns a mutable raw pointer to the backing [`Bitmap`].
> > +    pub fn as_mut_ptr(&mut self) -> *mut usize {
> > +        self as *mut CBitmap as *mut usize
> > +    }
> > +
> > +    /// Returns length of this [`CBitmap`].
> > +    #[expect(clippy::len_without_is_empty)]
> > +    pub fn len(&self) -> usize {
> > +        self.data.len()
> > +    }
> > +}
> > +
> > +/// Holds either a pointer to array of `unsigned long` or a small bitm=
ap.
> > +#[repr(C)]
> > +union BitmapRepr {
> > +    bitmap: usize,
> > +    ptr: NonNull<usize>,
> > +}
> > +
> > +macro_rules! bitmap_assert {
> > +    ($cond:expr, $($arg:tt)+) =3D> {
> > +        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
> > +        assert!($cond, $($arg)*);
> > +    }
> > +}
> > +
> > +macro_rules! bitmap_assert_return {
> > +    ($cond:expr, $($arg:tt)+) =3D> {
> > +        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
> > +        assert!($cond, $($arg)*);
> > +
> > +        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> > +        if !($cond) {
> > +            pr_err!($($arg)*);
> > +            return
> > +        }
> > +    }
> > +}
> > +
> > +/// Represents an owned bitmap.
> > +///
> > +/// Wraps underlying C bitmap API. See [`CBitmap`] for available
> > +/// methods.
> > +///
> > +/// # Examples
> > +///
> > +/// Basic usage
> > +///
> > +/// ```
> > +/// use kernel::alloc::flags::GFP_KERNEL;
> > +/// use kernel::bitmap::Bitmap;
> > +///
> > +/// let mut b =3D Bitmap::new(16, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(16, b.len());
> > +/// for i in 0..16 {
> > +///     if i % 4 =3D=3D 0 {
> > +///       b.set_bit(i);
> > +///     }
> > +/// }
> > +/// assert_eq!(Some(0), b.next_bit(0));
> > +/// assert_eq!(Some(1), b.next_zero_bit(0));
> > +/// assert_eq!(Some(4), b.next_bit(1));
> > +/// assert_eq!(Some(5), b.next_zero_bit(4));
> > +/// assert_eq!(Some(12), b.last_bit());
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +///
> > +/// # Invariants
> > +///
> > +/// * `nbits` is `<=3D i32::MAX` and never changes.
> > +/// * if `nbits <=3D bindings::BITS_PER_LONG`, then `repr` is a `usize=
`.
> > +/// * otherwise, `repr` holds a non-null pointer to an initialized
> > +///   array of `unsigned long` that is large enough to hold `nbits` bi=
ts.
> > +pub struct Bitmap {
> > +    /// Representation of bitmap.
> > +    repr: BitmapRepr,
> > +    /// Length of this bitmap. Must be `<=3D i32::MAX`.
> > +    nbits: usize,
> > +}
> > +
> > +impl core::ops::Deref for Bitmap {
> > +    type Target =3D CBitmap;
> > +
> > +    fn deref(&self) -> &CBitmap {
> > +        let ptr =3D if self.nbits <=3D bindings::BITS_PER_LONG as _ {
>
> You can define a local constant with the right size to avoid these casts:
> const BITS_PER_LONG: usize =3D bindings::BITS_PER_LONG as usize;

Done.


> > +            // SAFETY: Bitmap is represented inline.
> > +            unsafe { core::ptr::addr_of!(self.repr.bitmap) }
> > +        } else {
> > +            // SAFETY: Bitmap is represented as array of `unsigned lon=
g`.
> > +            unsafe { self.repr.ptr.as_ptr() }
> > +        };
> > +
> > +        // SAFETY: We got the right pointer and invariants of [`Bitmap=
`] hold.
> > +        // An inline bitmap is treated like an array with single eleme=
nt.
> > +        unsafe { CBitmap::from_raw(ptr, self.nbits) }
> > +    }
> > +}
> > +
> > +impl core::ops::DerefMut for Bitmap {
> > +    fn deref_mut(&mut self) -> &mut CBitmap {
> > +        let ptr =3D if self.nbits <=3D bindings::BITS_PER_LONG as _ {
> > +            // SAFETY: Bitmap is represented inline.
> > +            unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
> > +        } else {
> > +            // SAFETY: Bitmap is represented as array of `unsigned lon=
g`.
> > +            unsafe { self.repr.ptr.as_mut() }
> > +        };
> > +
> > +        // SAFETY: We got the right pointer and invariants of [`Bitmap=
`] hold.
> > +        // An inline bitmap is treated like an array with single eleme=
nt.
> > +        unsafe { CBitmap::from_raw_mut(ptr, self.nbits) }
> > +    }
> > +}
> > +
> > +/// Enable ownership transfer to other threads.
> > +///
> > +/// SAFETY: We own the underlying bitmap representation.
> > +unsafe impl Send for Bitmap {}
> > +
> > +/// Enable unsynchronized concurrent access to [`Bitmap`] through shar=
ed references.
> > +///
> > +/// SAFETY: `deref()` will return a reference to a [`CBitmap`] which i=
s Sync. Its methods
> > +/// that take immutable references are either atomic or read-only.
> > +unsafe impl Sync for Bitmap {}
> > +
> > +impl Drop for Bitmap {
> > +    fn drop(&mut self) {
> > +        if self.nbits <=3D bindings::BITS_PER_LONG as _ {
> > +            return;
> > +        }
> > +        // SAFETY: `self.ptr` was returned by the C `bitmap_zalloc`.
> > +        //
> > +        // INVARIANT: there is no other use of the `self.ptr` after th=
is
> > +        // call and the value is being dropped so the broken invariant=
 is
> > +        // not observable on function exit.
> > +        unsafe { bindings::bitmap_free(self.repr.ptr.as_ptr()) };
> > +    }
> > +}
> > +
> > +impl Bitmap {
> > +    /// Constructs a new [`Bitmap`].
> > +    ///
> > +    /// Fails with [`AllocError`] when the [`Bitmap`] could not be all=
ocated. This
> > +    /// includes the case when `nbits` is greater than `i32::MAX`.
> > +    #[inline]
> > +    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError>=
 {
> > +        if nbits <=3D bindings::BITS_PER_LONG as _ {
> > +            return Ok(Bitmap {
> > +                repr: BitmapRepr { bitmap: 0 },
> > +                nbits,
> > +            });
> > +        }
> > +        if nbits > i32::MAX.try_into().unwrap() {
> > +            return Err(AllocError);
> > +        }
> > +        let nbits_u32 =3D u32::try_from(nbits).unwrap();
> > +        // SAFETY: `bindings::BITS_PER_LONG < nbits` and `nbits <=3D i=
32::MAX`.
> > +        let ptr =3D unsafe { bindings::bitmap_zalloc(nbits_u32, flags.=
as_raw()) };
> > +        let ptr =3D NonNull::new(ptr).ok_or(AllocError)?;
> > +        // INVARIANT: `ptr` returned by C `bitmap_zalloc` and `nbits` =
checked.
> > +        Ok(Bitmap {
> > +            repr: BitmapRepr { ptr },
> > +            nbits,
> > +        })
> > +    }
> > +
> > +    /// Returns length of this [`Bitmap`].
> > +    #[allow(clippy::len_without_is_empty)]
> > +    #[inline]
> > +    pub fn len(&self) -> usize {
> > +        self.nbits
> > +    }
> > +}
> > +
> > +impl CBitmap {
> > +    /// Set bit with index `index`.
> > +    ///
> > +    /// ATTENTION: `set_bit` is non-atomic, which differs from the nam=
ing
> > +    /// convention in C code. The corresponding C function is `__set_b=
it`.
> > +    ///
> > +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and `index` is g=
reater than
> > +    /// or equal to `self.nbits`, does nothing.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `index` i=
s greater than
> > +    /// or equal to `self.nbits`.
> > +    #[inline]
> > +    pub fn set_bit(&mut self, index: usize) {
> > +        bitmap_assert_return!(
> > +            index < self.len(),
> > +            "Bit `index` must be < {}, was {}",
> > +            self.len(),
> > +            index
> > +        );
> > +        // SAFETY: Bit `index` is within bounds.
> > +        unsafe { bindings::__set_bit(index, self.as_mut_ptr()) };
> > +    }
> > +
> > +    /// Set bit with index `index`, atomically.
> > +    ///
> > +    /// This is a relaxed atomic operation (no implied memory barriers=
).
> > +    ///
> > +    /// ATTENTION: The naming convention differs from C, where the cor=
responding
> > +    /// function is called `set_bit`.
> > +    ///
> > +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and `index` is g=
reater than
> > +    /// or equal to `self.len()`, does nothing.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `index` i=
s greater than
> > +    /// or equal to `self.len()`.
> > +    #[inline]
> > +    pub fn set_bit_atomic(&self, index: usize) {
> > +        bitmap_assert_return!(
> > +            index < self.len(),
> > +            "Bit `index` must be < {}, was {}",
> > +            self.len(),
> > +            index
> > +        );
> > +        // SAFETY: `index` is within bounds and the caller has ensured=
 that
> > +        // there is no mix of non-atomic and atomic operations.
> > +        unsafe { bindings::set_bit(index, self.as_ptr() as *mut usize)=
 };
> > +    }
> > +
> > +    /// Clear `index` bit.
> > +    ///
> > +    /// ATTENTION: `clear_bit` is non-atomic, which differs from the n=
aming
> > +    /// convention in C code. The corresponding C function is `__clear=
_bit`.
> > +    ///
> > +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and `index` is g=
reater than
> > +    /// or equal to `self.len()`, does nothing.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `index` i=
s greater than
> > +    /// or equal to `self.len()`.
> > +    #[inline]
> > +    pub fn clear_bit(&mut self, index: usize) {
> > +        bitmap_assert_return!(
> > +            index < self.len(),
> > +            "Bit `index` must be < {}, was {}",
> > +            self.len(),
> > +            index
> > +        );
> > +        // SAFETY: `index` is within bounds.
> > +        unsafe { bindings::__clear_bit(index, self.as_mut_ptr()) };
> > +    }
> > +
> > +    /// Clear `index` bit, atomically.
> > +    ///
> > +    /// This is a relaxed atomic operation (no implied memory barriers=
).
> > +    ///
> > +    /// ATTENTION: The naming convention differs from C, where the cor=
responding
> > +    /// function is called `clear_bit`.
> > +    ///
> > +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and `index` is g=
reater than
> > +    /// or equal to `self.len()`, does nothing.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `index` i=
s greater than
> > +    /// or equal to `self.len()`.
> > +    #[inline]
> > +    pub fn clear_bit_atomic(&self, index: usize) {
> > +        bitmap_assert_return!(
> > +            index < self.len(),
> > +            "Bit `index` must be < {}, was {}",
> > +            self.len(),
> > +            index
> > +        );
> > +        // SAFETY: `index` is within bounds and the caller has ensured=
 that
> > +        // there is no mix of non-atomic and atomic operations.
> > +        unsafe { bindings::clear_bit(index, self.as_ptr() as *mut usiz=
e) };
> > +    }
> > +
> > +    /// Copy `src` into this [`Bitmap`] and set any remaining bits to =
zero.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> > +    /// use kernel::bitmap::Bitmap;
> > +    ///
> > +    /// let mut long_bitmap =3D Bitmap::new(256, GFP_KERNEL)?;
> > +    //
> > +    /// assert_eq!(None, long_bitmap.last_bit());
> > +    //
> > +    /// let mut short_bitmap =3D Bitmap::new(16, GFP_KERNEL)?;
> > +    //
> > +    /// short_bitmap.set_bit(7);
> > +    /// long_bitmap.copy_and_extend(&short_bitmap);
> > +    /// assert_eq!(Some(7), long_bitmap.last_bit());
> > +    ///
> > +    /// # Ok::<(), AllocError>(())
> > +    /// ```
> > +    #[inline]
> > +    pub fn copy_and_extend(&mut self, src: &Bitmap) {
> > +        let len =3D core::cmp::min(src.nbits, self.len());
> > +        // SAFETY: access to `self` and `src` is within bounds.
> > +        unsafe {
> > +            bindings::bitmap_copy_and_extend(
> > +                self.as_mut_ptr(),
> > +                src.as_ptr(),
> > +                len as u32,
> > +                self.len() as u32,
> > +            )
> > +        };
> > +    }
> > +
> > +    /// Finds last set bit.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> > +    /// use kernel::bitmap::Bitmap;
> > +    ///
> > +    /// let bitmap =3D Bitmap::new(64, GFP_KERNEL)?;
> > +    ///
> > +    /// match bitmap.last_bit() {
> > +    ///     Some(idx) =3D> {
> > +    ///         pr_info!("The last bit has index {idx}.\n");
> > +    ///     }
> > +    ///     None =3D> {
> > +    ///         pr_info!("All bits in this bitmap are 0.\n");
> > +    ///     }
> > +    /// }
> > +    /// # Ok::<(), AllocError>(())
> > +    /// ```
> > +    #[inline]
> > +    pub fn last_bit(&self) -> Option<usize> {
> > +        // SAFETY: `_find_next_bit` access is within bounds due to inv=
ariant.
> > +        let index =3D unsafe { bindings::_find_last_bit(self.as_ptr(),=
 self.len()) };
> > +        if index >=3D self.len() {
> > +            None
> > +        } else {
> > +            Some(index)
> > +        }
> > +    }
> > +
> > +    /// Finds next set bit, starting from `start`.
> > +    /// Returns `None` if `start` is greater of equal than `self.nbits=
`.
> > +    #[inline]
>
> The html docs look better if you include a newline:
>

> /// Finds next set bit, starting from `start`.
> ///
> /// Returns `None` if `start` is greater of equal than `self.nbits`.

Done

> > +    pub fn next_bit(&self, start: usize) -> Option<usize> {
> > +        bitmap_assert!(
> > +            start < self.len(),
> > +            "`start` must be < {} was {}",
> > +            self.len(),
> > +            start
> > +        );
> > +        // SAFETY: `_find_next_bit` tolerates out-of-bounds arguments =
and returns a
> > +        // value larger than or equal to `self.len()` in that case.
> > +        let index =3D unsafe { bindings::_find_next_bit(self.as_ptr(),=
 self.len(), start) };
> > +        if index >=3D self.len() {
> > +            None
> > +        } else {
> > +            Some(index)
> > +        }
> > +    }
> > +
> > +    /// Finds next zero bit, starting from `start`.
> > +    /// Returns `None` if `start` is greater than or equal to `self.le=
n()`.
> > +    #[inline]
> > +    pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
> > +        bitmap_assert!(
> > +            start < self.len(),
> > +            "`start` must be < {} was {}",
> > +            self.len(),
> > +            start
> > +        );
> > +        // SAFETY: `_find_next_zero_bit` tolerates out-of-bounds argum=
ents and returns a
> > +        // value larger than or equal to `self.len()` in that case.
> > +        let index =3D unsafe { bindings::_find_next_zero_bit(self.as_p=
tr(), self.len(), start) };
> > +        if index >=3D self.len() {
> > +            None
> > +        } else {
> > +            Some(index)
> > +        }
> > +    }
> > +}
> > +
> > +use macros::kunit_tests;
> > +
> > +#[kunit_tests(rust_kernel_bitmap)]
> > +mod tests {
> > +    use super::*;
> > +    use kernel::alloc::flags::GFP_KERNEL;
> > +
> > +    #[test]
> > +    fn cbitmap_borrow() {
> > +        let fake_c_bitmap: [usize; 2] =3D [0, 0];
> > +        // SAFETY: `fake_c_bitmap` is an array of expected length.
> > +        let b =3D unsafe {
> > +            CBitmap::from_raw(
> > +                core::ptr::addr_of!(fake_c_bitmap) as *const usize,
>
> You can just do fake_c_bitmap.as_ptr()
>

> > +                2 * bindings::BITS_PER_LONG as usize,
> > +            )
> > +        };
> > +        assert_eq!(2 * bindings::BITS_PER_LONG as usize, b.len());
> > +        assert_eq!(None, b.next_bit(0));
> > +    }
> > +
> > +    #[test]
> > +    fn cbitmap_copy() {
> > +        let fake_c_bitmap: usize =3D 0xFF;
> > +        // SAFETY: `fake_c_bitmap` can be used as one-element array of=
 expected length.
> > +        let b =3D unsafe { CBitmap::from_raw(core::ptr::addr_of!(fake_=
c_bitmap), 8) };
> > +        assert_eq!(8, b.len());
> > +        assert_eq!(None, b.next_zero_bit(0));
> > +    }
> > +
> > +    #[test]
> > +    fn bitmap_new() {
> > +        let b =3D Bitmap::new(0, GFP_KERNEL).unwrap();
> > +        assert_eq!(0, b.len());
> > +
> > +        let b =3D Bitmap::new(3, GFP_KERNEL).unwrap();
> > +        assert_eq!(3, b.len());
> > +
> > +        let b =3D Bitmap::new(1024, GFP_KERNEL).unwrap();
> > +        assert_eq!(1024, b.len());
> > +
> > +        // Requesting too large values results in [`AllocError`].
> > +        let b =3D Bitmap::new(1 << 31, GFP_KERNEL);
> > +        assert!(b.is_err());
> > +    }
> > +
> > +    #[test]
> > +    fn bitmap_set_clear_find() {
> > +        let mut b =3D Bitmap::new(128, GFP_KERNEL).unwrap();
> > +
> > +        // Zero-initialized
> > +        assert_eq!(None, b.next_bit(0));
> > +        assert_eq!(Some(0), b.next_zero_bit(0));
> > +        assert_eq!(None, b.last_bit());
> > +
> > +        b.set_bit(17);
> > +
> > +        assert_eq!(Some(17), b.next_bit(0));
> > +        assert_eq!(Some(17), b.next_bit(17));
> > +        assert_eq!(None, b.next_bit(18));
> > +        assert_eq!(Some(17), b.last_bit());
> > +
> > +        b.set_bit(107);
> > +
> > +        assert_eq!(Some(17), b.next_bit(0));
> > +        assert_eq!(Some(17), b.next_bit(17));
> > +        assert_eq!(Some(107), b.next_bit(18));
> > +        assert_eq!(Some(107), b.last_bit());
> > +
> > +        b.clear_bit(17);
> > +
> > +        assert_eq!(Some(107), b.next_bit(0));
> > +        assert_eq!(Some(107), b.last_bit());
> > +    }
> > +
> > +    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> > +    #[test]
> > +    fn bitmap_out_of_bounds() {
> > +        let mut b =3D Bitmap::new(128, GFP_KERNEL).unwrap();
> > +
> > +        b.set_bit(2048);
> > +        b.set_bit_atomic(2048);
> > +        b.clear_bit(2048);
> > +        b.clear_bit_atomic(2048);
> > +        assert_eq!(None, b.next_bit(2048));
> > +        assert_eq!(None, b.next_zero_bit(2048));
> > +        assert_eq!(None, b.last_bit());
> > +    }
> > +
> > +    #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
> > +    #[test]
> > +    #[should_panic]
> > +    fn bitmap_out_of_bounds() {
>
> I don't think we have #[should_panic] support in Rust KUnit yet.
>
True, I observed the panic but the test is erroneously marked as failing.
I have commented it out and added TODO to enable it once
[should_panic] is supported.

> > +        let mut b =3D Bitmap::new(128, GFP_KERNEL).unwrap();
> > +
> > +        b.set_bit(2048);
> > +    }
> > +
> > +    #[test]
> > +    fn bitmap_copy_and_extend() {
> > +        let mut long_bitmap =3D Bitmap::new(256, GFP_KERNEL).unwrap();
> > +
> > +        long_bitmap.set_bit(3);
> > +        long_bitmap.set_bit(200);
> > +
> > +        let mut short_bitmap =3D Bitmap::new(32, GFP_KERNEL).unwrap();
> > +
> > +        short_bitmap.set_bit(17);
> > +
> > +        long_bitmap.copy_and_extend(&short_bitmap);
> > +
> > +        // Previous bits have been cleared.
> > +        assert_eq!(Some(17), long_bitmap.next_bit(0));
> > +        assert_eq!(Some(17), long_bitmap.last_bit());
> > +    }
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index de07aadd1ff5..8c4161cd82ac 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -38,6 +38,7 @@
> >  pub use ffi;
> >
> >  pub mod alloc;
> > +pub mod bitmap;
> >  #[cfg(CONFIG_BLOCK)]
> >  pub mod block;
> >  #[doc(hidden)]
> > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > index 3fe9d7b945c4..d77a39aef554 100644
> > --- a/security/Kconfig.hardening
> > +++ b/security/Kconfig.hardening
> > @@ -324,6 +324,16 @@ config LIST_HARDENED
> >
> >           If unsure, say N.
> >
> > +config RUST_BITMAP_HARDENED
> > +       bool "Check integrity of bitmap Rust API"
> > +       depends on RUST
> > +       help
> > +         Enables additional assertions in the Rust Bitmap API to catch
> > +         arguments that are not guaranteed to result in an immediate a=
ccess
> > +         fault.
> > +
> > +         If unsure, say N.
> > +
> >  config BUG_ON_DATA_CORRUPTION
> >         bool "Trigger a BUG when data corruption is detected"
> >         select LIST_HARDENED
> > --
> > 2.50.0.rc1.591.g9c95f17f64-goog
> >
