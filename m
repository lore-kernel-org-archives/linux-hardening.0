Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E2E1BD9D3;
	Mon, 19 May 2025 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678963; cv=none; b=m6ipt+k8OVjYbfZgjJKdrSO6UeWNSCimH3Vwx7f2YLrYexaq+XVa3MnSNyw21N7pAnHsnRV0lv9crZvgDrbQ21/+WGsoizb91xcYTHQLt3N6VQopXBSKrdyqUBPI0LQwIP9iDSPcbCEfey8lqzmUpW5StvkKxg1GiEkMg3qwvRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678963; c=relaxed/simple;
	bh=tJoRyMajunWPJf8mJUGN4ecjP8frnTRlWxnruxSRVa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrtSAX8qDxOOiEGuz3U52FywnV/GOkUUnpToMoSwv9/ECq+OseBoOkaGVQx1bfyr223dnunTxUxyhlnPnGxmWo82bQJKyDOjwLLN9rloqC8ods/J2jGbl3Xab2C34e4AVL1+gSWaq8/+aXOCAwQCdTgxEaOn+m0rDOZtT2xPYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2zHkPUH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2zHkPUH"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c73f82dfso1429026b3a.2;
        Mon, 19 May 2025 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747678961; x=1748283761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVfTyKhcAaO9GVxvjuaj4XGnVxJW/64DE4KC6j1OGcM=;
        b=S2zHkPUHyDFOWxgMYyny3xP+AyjJcbXQoDFTX09Rt/q2mgCu4/4D6XYcIkmxwBePT0
         yNe5+8GYhvOheMC+7eR51+ThmP3lfynjbsAPzgmFL21Nosg5hr3cm5fPU8YiDW4DnRhv
         vJEveh6E7ys+5J0oxuy9xwc0+AQd42SPfytsu+D/SbdcCR/X0exAT3e8XK9F+x1iovaa
         TMSdH/lfWg9Jd7ZnXU3LPLH1yhMM6XZB8CtTYP1YJhqHXnzq08TFgUbhx5jmg0vVQOwT
         zB8pc3a0a0tfz/AUHC/bKlJSJE1Ik4sc3Ixdry65Hsjgn9LdfE+3EVBqtXWdTnWJG5Ry
         BdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678961; x=1748283761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVfTyKhcAaO9GVxvjuaj4XGnVxJW/64DE4KC6j1OGcM=;
        b=iE8NsFdMGrMh0atitzf5mE+hB8ZlKcHDfEZPpqWgvZCLUPKiVFlygkRnlZVaGZWyOf
         UnHBMvcIHqzyhnQogzAFKtcc5XmwSSz3zlLwDX+3rJGrcwSqLNqHNU+7vp256K22ak/k
         2hF/6qYVxLRRfOOh+ml61J8CBtwCtMK7p402RYJz1WBU5JtmXYAetRY0YiBWy1vIrcbe
         iuuoXhLiYn/9pRlqf5zBPR1ItD3W1Y3lNIh/4ipYXmrBYe44QaHu6sun5kRbH8HbrA5v
         8Kwwiq++palfBzZv9zeHgPe7gy7o4SSbr+FV3+X+1F53+x5JaC540i9RkOd1t4WMW6EJ
         wWhA==
X-Forwarded-Encrypted: i=1; AJvYcCVbTWcQP3pc4kK+LCLnuafyFAQMkEnXsj4/8cOPmNBcOTtrSKDE7o2VvomwuMbAqsPVKTmAhTOuIgcoMCx4DsY=@vger.kernel.org, AJvYcCX+fbmpy2oWuk8hoDfs3FLj+F7QZvQNSHpPq1oSHY0bUIPJJPafRk4Lta0I3IPvPT00aOVJ6WOkrLxb553T8LY=@vger.kernel.org, AJvYcCXn1Bs0fvJaR0cS5avO/53bGAmO/aLOJx4JBuDZMYzdUoVaQj5REgwsxtSnRPutfW07E1hLE3AuqIPZm2uq@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiGsTqLZjzzLF5ktGkjS6s4vjI4Nz5qyHSGMyJCXlEDiNzKcu
	IG9FCLCabKDE6LJgkZ5ChjDAz+0JVcavHhhzBhFDxHvOByOEglqbXYBV
X-Gm-Gg: ASbGncuv47rJmhxQuo/pw+QJJQsD1L69G1m/o/z4NgDu13Ks67aPbdiRmmxwyZ73nXx
	1AAZwrPulwaE6hBRVXUx0/g06UIBdZmq0rySmKy2IEprUEjb6ZdN9bQwgSc7S5HFlznVZxYlLyw
	kCMS07DgsqM5g4JIz1OKQJhYpl/mE00Bcgko/ZnuqZPirXal79OeISnqqDkzZa77Fpv0s65EEON
	mhyEnUA2hkOqTSI69/i1r3GGC9v41cwF+jrtQhwVccrvico9t3KPbFhMePVXZ+MgJf28k1YTKC4
	fizAuqyRRFXyJsJA4HxpBpAXeo0B884iqv2THo/YBlciEtkXt84=
X-Google-Smtp-Source: AGHT+IGSkwr1jCPWSZI4sWsGNr8+8Bmnvv1Tq5bgfEkO9nRJRBjDULaNcJlQHomDG2cRP5raBbc8gQ==
X-Received: by 2002:a05:6a00:3c89:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-742a989f492mr20143204b3a.19.1747678960722;
        Mon, 19 May 2025 11:22:40 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970bae4sm6498320b3a.43.2025.05.19.11.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 11:22:40 -0700 (PDT)
Date: Mon, 19 May 2025 14:22:38 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 3/5] rust: add bitmap API.
Message-ID: <aCt23djKOzUiP9L4@yury>
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-4-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519161712.2609395-4-bqe@google.com>

On Mon, May 19, 2025 at 04:17:03PM +0000, Burak Emir wrote:
> Provides an abstraction for C bitmap API and bitops operations.
> We follow the C Bitmap API closely in naming and semantics, with
> a few differences that take advantage of Rust language facilities
> and idioms:
> 
>   * We leverage Rust type system guarantees as follows:
> 
>     * Ownership transfer of a Bitmap is restricted so that it cannot
>     be passed between threads (does not implement `Send`).

Can you explain why you decided to not implement it? You can 'share' a
reference, but prohibit 'sending' it...

>     * all (non-atomic) mutating operations require a &mut reference which
>     amounts to exclusive access.
> 
>     * It is permissible to pass shared references &Bitmap between
>     threads, and we expose atomic operations through interior mutability.
>     Since these atomic operations do not provide any ordering guarantees,
>     we mark these as `unsafe`. Anyone who calls the atomic methods needs
>     to document that the lack of ordering is safe.
> 
>   * The Rust API offers `{set,clear}_bit` vs `{set,clear}_bit_atomic`,
>     which is different from the C naming convention (set_bit vs __set_bit).
> 
>   * we include enough operations for the API to be useful, but not all
>     operations are exposed yet in order to avoid dead code. This commit

This sentence and the following one say the same thing. Can you please
rephrase?

>     includes enough to enable a Rust implementation of an Android Binder
>     data structure that was introduced in commit 15d9da3f818c ("binder:
>     use bitmap for faster descriptor lookup"), which can be found in
>     drivers/android/dbitmap.h. We need this in order to upstream the Rust
>     port of Android Binder driver.
> 
>   * We follow the C API closely and fine-grained approach to safety:
> 
>     * Low-level bit-ops methods get a safe API with bounds checks.
> 
>     * methods correspond to find_* C methods tolerate out-of-bounds
>     arguments. Since these are already safe we the same behavior, and
>     return results using `Option` types to represent "not found".

Nit: the above 2 lines look misaligned. Everywhere else you align
items such that new lines under asterisk align with the first
character, not the asterisk itself.

> 
>   * the Rust API is optimized to represent the bitmap inline if it would
>     take the space of a pointer. This saves allocations which is

s/take the space of/fits into/

>     relevant in the Binder use case.
> 
>   * Bounds checks where out-of-bounds values would not result in
>     immediate access faults are configured via a RUST_BITMAP_HARDENED
>     config.
> 
> The underlying C bitmap is *not* exposed, and must never be exposed
> (except in tests). Exposing the representation would lose all static
> guarantees, and moreover would prevent the optimized representation of
> short bitmaps.

Does it mean that all existing kernel bitmaps declared in C are not
accessible in Rust as well?

> An alternative route of vendoring an existing Rust bitmap package was
> considered but suboptimal overall. Reusing the C implementation is
> preferable for a basic data structure like bitmaps. It enables Rust
> code to be a lot more similar and predictable with respect to C code
> that uses the same data structures and enables the use of code that
> has been tried-and-tested in the kernel, with the same performance
> characteristics whenever possible.

This should go in cover letter as well. Did you run any performance
tests against the native bitmaps?
 
> We use the `usize` type for sizes and indices into the bitmap,
> because Rust generally always uses that type for indices and lengths
> and it will be more convenient if the API accepts that type. This means
> that we need to perform some casts to/from u32 and usize, since the C
> headers use unsigned int instead of size_t/unsigned long for these
> numbers in some places.
> 
> Adds new MAINTAINERS section BITMAP API [RUST].
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>  MAINTAINERS                |   7 +
>  rust/kernel/bitmap.rs      | 415 +++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs         |   1 +
>  security/Kconfig.hardening |   9 +
>  4 files changed, 432 insertions(+)
>  create mode 100644 rust/kernel/bitmap.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04d6727e944c..565eaa015d9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4127,6 +4127,13 @@ S:	Maintained
>  F:	rust/helpers/bitmap.c
>  F:	rust/helpers/cpumask.c
>  
> +BITMAP API [RUST]
> +M:	Alice Ryhl <aliceryhl@google.com>
> +M:	Burak Emir <bqe@google.com>
> +R:	Yury Norov <yury.norov@gmail.com>
> +S:	Maintained
> +F:	rust/kernel/bitmap.rs
> +
>  BITOPS API
>  M:	Yury Norov <yury.norov@gmail.com>
>  R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> new file mode 100644
> index 000000000000..943dbef7948b
> --- /dev/null
> +++ b/rust/kernel/bitmap.rs
> @@ -0,0 +1,415 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Rust API for bitmap.
> +//!
> +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h).
> +
> +use crate::alloc::{AllocError, Flags};
> +use crate::bindings;
> +use core::ptr::NonNull;
> +
> +/// Holds either a pointer to array of `unsigned long` or a small bitmap.
> +#[repr(C)]
> +union BitmapRepr {
> +    bitmap: usize,
> +    ptr: NonNull<usize>,
> +}
> +
> +macro_rules! bitmap_hardening_assert {
> +    ($cond:expr, $($arg:tt)+) => {
> +        #[cfg(RUST_BITMAP_HARDENED)]
> +        assert!($e, $($arg)*);
> +    }
> +}
> +
> +/// Represents a bitmap.
> +///
> +/// Wraps underlying C bitmap API.
> +///
> +/// # Examples
> +///
> +/// Basic usage
> +///
> +/// ```
> +/// use kernel::alloc::flags::GFP_KERNEL;
> +/// use kernel::bitmap::Bitmap;
> +///
> +/// let mut b = Bitmap::new(16, GFP_KERNEL)?;
> +///
> +/// assert_eq!(16, b.len());
> +/// for i in 0..16 {
> +///     if i % 4 == 0 {
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
> +/// * `nbits` is `<= i32::MAX` and never changes.
> +/// * if `nbits <= bindings::BITS_PER_LONG`, then `repr` is a bitmap.
> +/// * otherwise, `repr` holds a non-null pointer that was obtained from a
> +///   successful call to `bitmap_zalloc` and holds the address of an initialized
> +///   array of `unsigned long` that is large enough to hold `nbits` bits.
> +pub struct Bitmap {
> +    /// Representation of bitmap.
> +    repr: BitmapRepr,
> +    /// Length of this bitmap. Must be `<= i32::MAX`.
> +    nbits: usize,
> +}
> +
> +/// Enable unsynchronized concurrent access to [`Bitmap`] through shared references.
> +///
> +/// # Safety
> +///
> +/// * When no thread performs any mutations, concurrent access is safe.
> +/// * Mutations are permitted through atomic operations and interior mutability.
> +///   All such methods are marked unsafe, to account for the lack of ordering
> +///   guarantees. Callers must acknowledge that updates may be observed in any
> +///   order.
> +unsafe impl Sync for Bitmap {}
> +
> +impl Drop for Bitmap {
> +    fn drop(&mut self) {
> +        if self.nbits <= bindings::BITS_PER_LONG as _ {
> +            return;
> +        }
> +        // SAFETY: `self.ptr` was returned by the C `bitmap_zalloc`.
> +        //
> +        // INVARIANT: there is no other use of the `self.ptr` after this
> +        // call and the value is being dropped so the broken invariant is
> +        // not observable on function exit.
> +        unsafe { bindings::bitmap_free(self.as_mut_ptr()) };
> +    }
> +}
> +
> +impl Bitmap {
> +    /// Constructs a new [`Bitmap`].
> +    ///
> +    /// Fails with [`AllocError`] when the [`Bitmap`] could not be allocated. This
> +    /// includes the case when `nbits` is greater than `i32::MAX`.
> +    #[inline]
> +    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
> +        if nbits <= bindings::BITS_PER_LONG as _ {
> +            return Ok(Bitmap {
> +                repr: BitmapRepr { bitmap: 0 },
> +                nbits,
> +            });
> +        }
> +        if nbits > i32::MAX.try_into().unwrap() {
> +            return Err(AllocError);
> +        }
> +        let nbits_u32 = u32::try_from(nbits).unwrap();
> +        // SAFETY: `bindings::BITS_PER_LONG < nbits` and `nbits <= i32::MAX`.
> +        let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
> +        let ptr = NonNull::new(ptr).ok_or(AllocError)?;
> +        // INVARIANT: `ptr` returned by C `bitmap_zalloc` and `nbits` checked.
> +        return Ok(Bitmap {
> +            repr: BitmapRepr { ptr },
> +            nbits,
> +        });
> +    }
> +
> +    /// Returns length of this [`Bitmap`].
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.nbits
> +    }
> +
> +    /// Returns a mutable raw pointer to the backing [`Bitmap`].
> +    #[inline]
> +    fn as_mut_ptr(&mut self) -> *mut usize {
> +        if self.nbits <= bindings::BITS_PER_LONG as _ {
> +            // SAFETY: Bitmap is represented inline.
> +            unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
> +        } else {
> +            // SAFETY: Bitmap is represented as array of `unsigned long`.
> +            unsafe { self.repr.ptr.as_mut() }
> +        }
> +    }
> +
> +    /// Returns a raw pointer to the backing [`Bitmap`].
> +    #[inline]
> +    fn as_ptr(&self) -> *const usize {
> +        if self.nbits <= bindings::BITS_PER_LONG as _ {
> +            // SAFETY: Bitmap is represented inline.
> +            unsafe { core::ptr::addr_of!(self.repr.bitmap) }
> +        } else {
> +            // SAFETY: Bitmap is represented as array of `unsigned long`.
> +            unsafe { self.repr.ptr.as_ptr() }
> +        }
> +    }
> +
> +    /// Set bit with index `index`.
> +    ///
> +    /// ATTENTION: `set_bit` is non-atomic, which differs from the naming
> +    /// convention in C code. The corresponding C function is `__set_bit`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn set_bit(&mut self, index: usize) {
> +        assert!(
> +            index < self.nbits,
> +            "Bit `index` must be < {}, was {}",
> +            self.nbits,
> +            index
> +        );

Shouldn't this assertion be protected with hardening too? I already
said that: panicking on  out-of-boundary access with hardening
disabled is a wrong way to go.

Can you turn your bitmap_hardening_assert() to just bitmap_assert(),
which panics only if hardening is enabled, and otherwise just prints
error with pr_err()?

Did you measure performance impact of hardening? Are those numbers in
cover letter collected with hardening enabled or disabled? If
performance impact is measurable, it should be mentioned in config
description.

> +        // SAFETY: Bit `index` is within bounds.
> +        unsafe { bindings::__set_bit(index as u32, self.as_mut_ptr()) };
> +    }
> +
> +    /// Set bit with index `index`, atomically.
> +    ///
> +    /// ATTENTION: The naming convention differs from C, where the corresponding
> +    /// function is called `set_bit`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This is a relaxed atomic operation (no implied memory barriers, no
> +    /// ordering guarantees). The caller must ensure that this is safe, as
> +    /// the compiler cannot prevent code with an exclusive reference from
> +    /// calling atomic operations.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub unsafe fn set_bit_atomic(&self, index: usize) {
> +        assert!(
> +            index < self.nbits,
> +            "Bit `index` must be < {}, was {}",
> +            self.nbits,
> +            index
> +        );
> +        // SAFETY: `index` is within bounds and the caller has ensured that
> +        // there is no mix of non-atomic and atomic operations.
> +        unsafe { bindings::set_bit(index as u32, self.as_ptr() as *mut usize) };
> +    }
> +
> +    /// Clear `index` bit.
> +    ///
> +    /// ATTENTION: `clear_bit` is non-atomic, which differs from the naming
> +    /// convention in C code. The corresponding C function is `__clear_bit`.
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn clear_bit(&mut self, index: usize) {
> +        assert!(
> +            index < self.nbits,
> +            "Bit `index` must be < {}, was {}",
> +            self.nbits,
> +            index
> +        );
> +        // SAFETY: `index` is within bounds.
> +        unsafe { bindings::__clear_bit(index as u32, self.as_mut_ptr()) };
> +    }
> +
> +    /// Clear `index` bit, atomically.
> +    ///
> +    /// ATTENTION: The naming convention differs from C, where the corresponding
> +    /// function is called `clear_bit`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This is a relaxed atomic operation (no implied memory barriers, no
> +    /// ordering guarantees). The caller must ensure that this is safe, as

Memory barriers is an implementation of 'ordering guarantees', so all
this sounds tautology.

> +    /// the compiler cannot prevent code with an exclusive reference from
> +    /// calling atomic operations.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `index` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub unsafe fn clear_bit_atomic(&self, index: usize) {
> +        assert!(
> +            index < self.nbits,
> +            "Bit `index` must be < {}, was {}",
> +            self.nbits,
> +            index
> +        );
> +        // SAFETY: `index` is within bounds and the caller has ensured that
> +        // there is no mix of non-atomic and atomic operations.
> +        unsafe { bindings::clear_bit(index as u32, self.as_ptr() as *mut usize) };
> +    }
> +
> +    /// Copy `src` into this [`Bitmap`] and set any remaining bits to zero.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::bitmap::Bitmap;
> +    ///
> +    /// let mut long_bitmap = Bitmap::new(256, GFP_KERNEL)?;
> +    //
> +    /// assert_eq!(None, long_bitmap.last_bit());
> +    //
> +    /// let mut short_bitmap = Bitmap::new(16, GFP_KERNEL)?;
> +    //
> +    /// short_bitmap.set_bit(7);
> +    /// long_bitmap.copy_and_extend(&short_bitmap);
> +    /// assert_eq!(Some(7), long_bitmap.last_bit());
> +    ///
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn copy_and_extend(&mut self, src: &Bitmap) {
> +        let len = core::cmp::min(src.nbits, self.nbits);
> +        // SAFETY: access to `self` and `src` is within bounds.
> +        unsafe {
> +            bindings::bitmap_copy_and_extend(
> +                self.as_mut_ptr(),
> +                src.as_ptr(),
> +                len as u32,
> +                self.nbits as u32,
> +            )
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
> +    /// let bitmap = Bitmap::new(64, GFP_KERNEL)?;
> +    ///
> +    /// match bitmap.last_bit() {
> +    ///     Some(idx) => {
> +    ///         pr_info!("The last bit has index {idx}.\n");
> +    ///     }
> +    ///     None => {
> +    ///         pr_info!("All bits in this bitmap are 0.\n");
> +    ///     }
> +    /// }
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn last_bit(&self) -> Option<usize> {
> +        // SAFETY: `_find_next_bit` access is within bounds due to invariant.
> +        let index = unsafe { bindings::_find_last_bit(self.as_ptr(), self.nbits) };
> +        if index >= self.nbits {
> +            None
> +        } else {
> +            Some(index)
> +        }
> +    }
> +
> +    /// Finds next set bit, starting from `start`.
> +    /// Returns `None` if `start` is greater of equal than `self.nbits`.
> +    #[inline]
> +    pub fn next_bit(&self, start: usize) -> Option<usize> {
> +        bitmap_hardening_assert!(start < self.nbits, "`start` must be < {} was {}", self.nbits, start);
> +        // SAFETY: `_find_next_bit` tolerates out-of-bounds arguments and returns a
> +        // value larger than or equal to `self.nbits` in that case.
> +        let index = unsafe { bindings::_find_next_bit(self.as_ptr(), self.nbits, start) };
> +        if index >= self.nbits {
> +            None
> +        } else {
> +            Some(index)
> +        }
> +    }
> +
> +    /// Finds next zero bit, starting from `start`.
> +    /// Returns `None` if `start` is greater than or equal to `self.nbits`.
> +    #[inline]
> +    pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
> +        bitmap_hardening_assert!(start < self.nbits, "`start` must be < {} was {}", self.nbits, start);
> +        // SAFETY: `_find_next_zero_bit` tolerates out-of-bounds arguments and returns a
> +        // value larger than or equal to `self.nbits` in that case.
> +        let index = unsafe { bindings::_find_next_zero_bit(self.as_ptr(), self.nbits, start) };
> +        if index >= self.nbits {
> +            None
> +        } else {
> +            Some(index)
> +        }
> +    }
> +}
> +
> +use macros::kunit_tests;
> +
> +#[kunit_tests(rust_kernel_bitmap)]
> +mod tests {
> +    use super::*;
> +    use kernel::alloc::flags::GFP_KERNEL;
> +
> +    #[test]
> +    fn bitmap_new() {
> +        let b = Bitmap::new(0, GFP_KERNEL).unwrap();
> +        assert_eq!(0, b.len());
> +
> +        let b = Bitmap::new(3, GFP_KERNEL).unwrap();
> +        assert_eq!(3, b.len());
> +
> +        let b = Bitmap::new(1024, GFP_KERNEL).unwrap();
> +        assert_eq!(1024, b.len());
> +
> +        // Requesting too large values results in [`AllocError`].
> +        let b = Bitmap::new(1 << 31, GFP_KERNEL);
> +        assert!(b.is_err());
> +    }
> +
> +    #[test]
> +    fn bitmap_set_clear_find() {
> +        let mut b = Bitmap::new(128, GFP_KERNEL).unwrap();
> +
> +        // Zero-initialized
> +        assert_eq!(None, b.last_bit());
> +
> +        b.set_bit(17);
> +
> +        assert_eq!(Some(17), b.next_bit(0));
> +        assert_eq!(Some(17), b.last_bit());
> +
> +        b.set_bit(107);
> +
> +        assert_eq!(Some(17), b.next_bit(0));
> +        assert_eq!(Some(17), b.next_bit(17));
> +        assert_eq!(Some(107), b.next_bit(18));
> +        assert_eq!(Some(107), b.last_bit());
> +
> +        b.clear_bit(17);
> +
> +        assert_eq!(Some(107), b.next_bit(0));
> +        assert_eq!(Some(107), b.last_bit());
> +    }
> +
> +    #[test]
> +    fn bitmap_out_of_bounds() {
> +        let mut b = Bitmap::new(128, GFP_KERNEL).unwrap();
> +
> +        assert_eq!(None, b.next_bit(2048));
> +        assert_eq!(None, b.next_zero_bit(2048));
> +        assert_eq!(None, b.last_bit(2048));
> +    }
> +
> +    #[test]
> +    fn bitmap_copy_and_extend() {
> +        let mut long_bitmap = Bitmap::new(256, GFP_KERNEL).unwrap();
> +
> +        long_bitmap.set_bit(3);
> +        long_bitmap.set_bit(200);
> +
> +        let mut short_bitmap = Bitmap::new(32, GFP_KERNEL).unwrap();
> +
> +        short_bitmap.set_bit(17);
> +
> +        long_bitmap.copy_and_extend(&short_bitmap);
> +        // The larger bits have been cleared.
> +        assert_eq!(Some(17), long_bitmap.next_bit(0));
> +        assert_eq!(Some(17), long_bitmap.last_bit());
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index de07aadd1ff5..8c4161cd82ac 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -38,6 +38,7 @@
>  pub use ffi;
>  
>  pub mod alloc;
> +pub mod bitmap;
>  #[cfg(CONFIG_BLOCK)]
>  pub mod block;
>  #[doc(hidden)]
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 3fe9d7b945c4..926665bbc8f2 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -324,6 +324,15 @@ config LIST_HARDENED
>  
>  	  If unsure, say N.
>  
> +config RUST_BITMAP_HARDENED
> +	bool "Check integrity of linked list manipulation"

Wah?

> +	help
> +	  Enables additional assertions in the Rust Bitmap API to catch
> +	  arguments that are not guaranteed to result in an immediate access
> +	  fault.
> +
> +	  If unsure, say N.
> +
>  config BUG_ON_DATA_CORRUPTION
>  	bool "Trigger a BUG when data corruption is detected"
>  	select LIST_HARDENED
> -- 
> 2.49.0.1101.gccaa498523-goog
