Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D624C07D;
	Tue, 27 May 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363752; cv=none; b=sHdd2khOalT9xNaEoXamgDt+9fsyQiCPO1ViQjUBjPAok4rB9oGoh8AckKmIM4b9577gnukkfLEbOAO6Rb1XaojX7XiQbYLVVSmcMioOmXHDeCApMOPLpr5Pr4HcmMTaXEAlzkwULDZu5czSza+m3MLswG8wi4lVUWgGNX085Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363752; c=relaxed/simple;
	bh=v7oXNK3Ke5dbo2wt2nmaEf2zrq3u1XeLL4yhthe55Dw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPTqbtgyyAHxanmrLb2YTdbxhcKRbQl229jW7Zrl1fVWqixeVUfxhBo6hmCh3oMrNIZ49lOxORAY/6q/Ba6fiy5/mfGpLzYEqIbD3gInj4YsTrtuiQ1LXw3OjX1uiwmgD7osyE7ZcM5IgMcePjsOMfc7yvWi3q4varBgjuRHFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObDKTE2l; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObDKTE2l"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fa9dced621so219246d6.1;
        Tue, 27 May 2025 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748363749; x=1748968549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPsZbYFffuAtRnYlvtT8UtXxqyN8802mnf9mpWTpqj4=;
        b=ObDKTE2lYVqIDUP+Hx/uBZRIVXqo7CRrPgNlZ1hJXemlIJ6BvL4FEQzZS3PxAPeJPz
         h2KFvig8zRT9svFclcnzBVZolZ/XZx6e6wNAjtsJ1wMejKEWoY0OWpA6PFvK9uFHRJun
         YIsXt7Tm9jiAT2h01Nhs+XYtgJO5XtgHWADhe+gjh/rG4IJKtoExGpYwFksxKSm3TvBr
         s2HXMwhmLyPm2qt6gib/6AvzVRBB09e8f1/0bbt83OA+oHEUl+aZooNkqbpObtE7hSl1
         SKaNnEn07f0VBThSWfBAdkbh073RMN0kgLrsjSjn1JDT7NC4VXYtEtiJ4S9E4YJA7kZZ
         xmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748363749; x=1748968549;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPsZbYFffuAtRnYlvtT8UtXxqyN8802mnf9mpWTpqj4=;
        b=gI+RQtTF335f3xp9/LahvODljfOoYkLfL7XcoRviiBy7j3dP34O64AzeTAt4t8E3Re
         Pi9XtR3Dc5wAAM0pDQIek2rL0aaZKVxGwoftz/wxXUWb+BOZeOUrIP9sQ71+lpD9bn3t
         HEj6r6S5EAGK3BNzfX+NiKUdVkjeIBnc+yi0AyZiPxWWDRFpBru7Kawu0uKCZmS907IE
         fM+whTuK0eIWGeehwSPRYhtmhbs2d/tq006rs5ikOmqtfBmCdPSnIlK531wOlRTy3z5N
         jTzE0MAt1SstbIgNsPMIAg8iYx7bxGkkRYe2pGupgbQZPirRIcJPIjCMRuqTq4u1UoES
         qgOg==
X-Forwarded-Encrypted: i=1; AJvYcCVEBaUgq5WkfM6tcNLpZSKIkZFZev8Cq0tzCbnWrpCycvcSd2pIl7+Uim+vDuF8z6P7LGbcRpSTdZSwaNZk@vger.kernel.org, AJvYcCVLnkalQGIEGgGJyetAI6iYTH0SE4T3YkwOtkNmBZ6k+mOsUfpVE77vVqqRFhCl0K0CTj8FvDcN0HKemqk5DMI=@vger.kernel.org, AJvYcCXkRCbpA43xrI7ndpnqEICOIkNOXXIQku+VUQS0PwB6QqxGNsZwfgSFtqaLSGc4v+uR6M1OSIDElo71HCGtqKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfnRPPsFcypVzk07kyVO7WXrt4Mh+TSEMvBymZbzqH3S1W0Buo
	fTmispEfxcnlGAdjXkbxqrc2oQW4G9+KXl7RtFgNffHLi5SB/FpnF8vN
X-Gm-Gg: ASbGncseC25BMkWypelCaqKSmVxIYX0d69x+W3udlQ6tiUk/wYNaFNFWxqMjCPGAzvw
	MXHyzEy4rMB/EPvR2pr83VDk4dgHXUJEvb0/IRx+YvjFcJWzh1VclAzhFkM9HwixMC2F09yU+nM
	G2m66+7+LNKA4zp5FLD6jJf8xvHHyafJELJOQyhlJb567jOITpUzu8vhdsobQ54pJh3/M9YF/BO
	tkyppV4BxljfUTe1ZMCQS8BJ1lVTks6xcdEdqfjZ3tYhkFAA7/38DV/FKWrk3UyzVd0GvvEZvVw
	z59nJn3BZ8UTLSS9E9cagvArRb9WKkWv/SJP3WK5yxEs60H722CLrHoE/6OZMT0GBa3h7x1cMp+
	vw/pJ7HJObVXaI6RKTP/Pd4hn7F+w3fhHMDcb1dhvgQ==
X-Google-Smtp-Source: AGHT+IE4D0ZOp7WLSc8FsSzTT8JIoWgebfgQpgd8AhwUS7r/DkfoanqLbx88Hi4XS40fvhuzlXVorQ==
X-Received: by 2002:a05:6214:624:b0:6e2:4da9:4e2d with SMTP id 6a1803df08f44-6fab9ea0321mr21175696d6.9.1748363748985;
        Tue, 27 May 2025 09:35:48 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6faa21762a3sm47138716d6.9.2025.05.27.09.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:35:48 -0700 (PDT)
Message-ID: <6835e9e4.d40a0220.1ebca7.f846@mx.google.com>
X-Google-Original-Message-ID: <aDXp4u7g7Ym6NLya@winterfell.>
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id CB4661200043;
	Tue, 27 May 2025 12:35:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 May 2025 12:35:47 -0400
X-ME-Sender: <xms:4-k1aLb0b4_CwP9VALTWoRK_NwoUCZG8go1aDe2kyWuDv3I3EvDZGQ>
    <xme:4-k1aKbRRFySz5Pp5KO3P4xF44J9Y-Rm0SSnK-bFYkUJf-wVBagDjJacvZzztdsU5
    HW3LLN8UfIFLZuEVw>
X-ME-Received: <xmr:4-k1aN-_EE6jyzOF_QZGVkh-JKnUPWrc4Z-WzaF58VRdj088uuMCjNhMlxLMRgYY9mfVamJldD_Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdekjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquh
    hnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephfekudfhfeff
    vdfhhfdvtefhveffhfeftdefvdehjeegkeeftdeggfevfffhveeknecuffhomhgrihhnpe
    hpthhrrdgrshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvge
    ehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhm
    sehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegsqhgvsehgohhoghhlvgdrtghomhdprhgtphhtthhopeihuhhr
    hidrnhhorhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugiesrhgrshhmuhhsvhhilhhlvghmohgvshdr
    ughkpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprh
    gtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidr
    ghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguh
    hordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:4-k1aBp4-9F8dCCwBXaGk7s4mojXgGW4TvRXrUvy_eFEJ_fnYDCgNw>
    <xmx:4-k1aGpDNdZofCIsbNbgKvat-lM4W_bMR4SRooFd1sFqPSfJBnQ_RQ>
    <xmx:4-k1aHSM3aFwUeQpF0Zfv5UWyuRCCkvwSXIdUWgHFYd41lIyqXV1rA>
    <xmx:4-k1aOqWEn095Gb4bGa5famOETLRSunPFiQ669HmK_aD2lFGSx6mdw>
    <xmx:4-k1aH5K6QjRZkGzW_yUkczEwhfYLa-wUi3cB6zucP8UZnwG4imKu_l_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 12:35:47 -0400 (EDT)
Date: Tue, 27 May 2025 09:35:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 3/5] rust: add bitmap API.
References: <20250526150141.3407433-1-bqe@google.com>
 <20250526150141.3407433-4-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526150141.3407433-4-bqe@google.com>

On Mon, May 26, 2025 at 03:01:32PM +0000, Burak Emir wrote:
> Provides an abstraction for C bitmap API and bitops operations.
> 
> This commit enables a Rust implementation of an Android Binder
> data structure from commit 15d9da3f818c ("binder: use bitmap for faster
> descriptor lookup"), which can be found in drivers/android/dbitmap.h.
> It is a step towards upstreaming the Rust port of Android Binder driver.
> 
> We follow the C Bitmap API closely in naming and semantics, with
> a few differences that take advantage of Rust language facilities
> and idioms:
> 
>   * We leverage Rust type system guarantees as follows:
> 
>     * all (non-atomic) mutating operations require a &mut reference which
>       amounts to exclusive access.
> 
>     * the Bitmap type implements Send. This enables transferring
>       ownership between threads and is needed for Binder.
> 
>     * the Bitmap type implements Sync, which enables passing shared
>       references &Bitmap between threads. Atomic operations can be
>       used to safely modify from multiple threads (interior
>       mutability), though without ordering guarantees.
> 
>   * The Rust API uses `{set,clear}_bit` vs `{set,clear}_bit_atomic` as
>     names, which differs from the C naming convention which uses
>     set_bit for atomic vs __set_bit for non-atomic.
> 
>   * we include enough operations for the API to be useful, but not all
>     operations are exposed yet in order to avoid dead code. The missing
>     ones can be added later.
> 
>   * We follow the C API closely with a fine-grained approach to safety:
> 
>     * Low-level bit-ops get a safe API with bounds checks. Calling with
>       an out-of-bounds arguments to {set,clear}_bit becomes a no-op and
>       get logged as errors.
> 
>     * We introduce a RUST_BITMAP_HARDENED config, which
>       causes invocations with out-of-bounds arguments to panic.
> 
>     * methods correspond to find_* C methods tolerate out-of-bounds
>       since the C implementation does. Also here, we log out-of-bounds
>       arguments as errors and panic in RUST_BITMAP_HARDENED mode.
> 
>     * We add a way to "borrow" bitmaps from C in Rust, to make C bitmaps
>       that were allocated in C directly usable in Rust code (`CBitmap`).
> 
>   * the Rust API is optimized to represent the bitmap inline if it would
>     fit into a pointer. This saves allocations which is
>     relevant in the Binder use case.
> 
> The underlying C bitmap is *not* exposed, and must never be exposed
> (except in tests). Exposing the representation of the owned bitmap would
> lose static guarantees.
> 
> An alternative route of vendoring an existing Rust bitmap package was
> considered but suboptimal overall. Reusing the C implementation is
> preferable for a basic data structure like bitmaps. It enables Rust
> code to be a lot more similar and predictable with respect to C code
> that uses the same data structures and enables the use of code that
> has been tried-and-tested in the kernel, with the same performance
> characteristics whenever possible.
> 
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
>  rust/kernel/bitmap.rs      | 554 +++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs         |   1 +
>  security/Kconfig.hardening |  10 +
>  4 files changed, 572 insertions(+)
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
> +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h).
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

This is the same as #[repr(align(8)] on 64bit architecture? If so, maybe
we should do:

	#[cfg_attr(CONFIG_64BIT, repr(align(8)))]
	#[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
	pub struct CBitmap {
	    data: [()],
	}

? I find it slightly better because it's explicit on the targeted
alignment.

> +    data: [()],
> +}
> +
> +impl CBitmap {
> +    /// Borrows a C bitmap.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
> +    ///   that is large enough to hold `nbits` bits.
> +    /// * the array must not be freed for the lifetime of this [`CBitmap`]
> +    /// * concurrent access only happens through atomic operations
> +    pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a CBitmap {
> +        let data: *const [()] = core::ptr::slice_from_raw_parts(ptr.cast(), nbits);

Need "// INVARIANT:" here and in from_raw_mut() to explain why the
references are valid.

> +        unsafe { &*(data as *const CBitmap) }
> +    }
> +
> +    /// Borrows a C bitmap exclusively.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
> +    ///   that is large enough to hold `nbits` bits.
> +    /// * the array must not be freed for the lifetime of this [`CBitmap`]
> +    /// * no concurrent access may happen.
> +    pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &'a mut CBitmap {
> +        let data: *mut [()] = core::ptr::slice_from_raw_parts_mut(ptr.cast(), nbits);
> +        unsafe { &mut *(data as *mut CBitmap) }
> +    }
> +
> +    /// Returns a raw pointer to the backing [`Bitmap`].
> +    pub fn as_ptr(&self) -> *const usize {
> +        self as *const CBitmap as *const usize
> +    }
> +
> +    /// Returns a mutable raw pointer to the backing [`Bitmap`].
> +    pub fn as_mut_ptr(&mut self) -> *mut usize {
> +        self as *mut CBitmap as *mut usize
> +    }
> +
> +    /// Returns length of this [`CBitmap`].
> +    pub fn len(&self) -> usize {
> +        self.data.len()
> +    }
> +}
> +
[...]
> +/// Enable ownership transfer to other threads.
> +///
> +/// # Safety
> +///
> +/// We own the underlying bitmap representation.

Usually the comment here should be a:

// SAFETY: <explain why Bitmap is Send>

"# Safety" is for describing the safety requirement.

> +unsafe impl Send for Bitmap {}
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

I think this comment is out-of-date. What makes `Bitmap` is that all
methods will immutable references are either atomic or read-only (more
accurately, `Bitmap`'s deref() will return a reference to a `CBitmap`
which is `Sync`).

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
> +        unsafe { bindings::bitmap_free(self.repr.ptr.as_ptr()) };
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
> +    /// Returns length of this [`CBitmap`].

Copy-pasta? It should be "[`Bitmap`]".

> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.nbits
> +    }
> +}
> +

Probably need:

unsafe impl Sync for CBitmap { }

> +impl CBitmap {
> +    /// Set bit with index `index`.
> +    ///
> +    /// ATTENTION: `set_bit` is non-atomic, which differs from the naming
> +    /// convention in C code. The corresponding C function is `__set_bit`.
> +    ///
> +    /// If RUST_BITMAP_HARDENED is not enabled and `index` is greater than
> +    /// or equal to `self.nbits`, does nothing.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if RUST_BITMAP_HARDENED is enabled and `index` is greater than
> +    /// or equal to `self.nbits`.
> +    #[inline]
> +    pub fn set_bit(&mut self, index: usize) {
> +        bitmap_assert_return!(
> +            index < self.len(),
> +            "Bit `index` must be < {}, was {}",
> +            self.len(),
> +            index
> +        );
> +        // SAFETY: Bit `index` is within bounds.
> +        unsafe { bindings::__set_bit(index as u32, self.as_mut_ptr()) };
> +    }
> +
[...]

Regards,
Boqun
