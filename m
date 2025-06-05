Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EAC2798FF
	for <linux-hardening@vger.kernel.org>; Thu,  5 Jun 2025 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161096; cv=none; b=PddMOA1D7d/Yskw723YbjaJDA4cNnojyyatd63DafHB3TaXKuho0TcMZ0UoaI23p2793Xc7SdGFvn9OE1WN/ZmI+QlftuZRUWI67UDQlTf0htd5mx3B8U9awAPaOqU84Ex7BXG65/ZDwgPyhtKSZjtRBHtfHSLaXs69NjyU6Nq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161096; c=relaxed/simple;
	bh=7mg4Vc3FG3Ub/sNkzbQgtf+fZjB3i5Cl8TFLEjQND6M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gs7zeruR3wwY8QOeDP7+CKQotYuu2YX8vCdbku+mzlVKLsQhxqIYQ+mH81CwypbIn2WZwS187tSgIVHZQC74iWGrEiRbdCg9atp1wFQZoJyIQR0Iwne8KCmurj3j98gVekN4FrqgdTsUmtCAZhXkhJMvx61wq6X4Yrruu7LDTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Z4qGpffd; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Z4qGpffd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1749161083; x=1749420283;
	bh=IrrawZx6kZOkw72+PxxwUrQ2AW3IP1Yx0cPdhL1G4Q8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Z4qGpffdLJol80t+ZEaiVPEqUJNJu6oLIWlW1tGUzj4sCc8UdpOAe9+6qx2BOjbJT
	 v953bonVXMQr++/VwBlg3RhpEj1TSbCBxovhv8Uc7gJMcY77waDFs+9g75zdzNAO1H
	 w8ycMmTb/MG98/1FHpis0vVfGzmrowhXl0fmHUSJjEgHkVb2exZvuAm0WxP5zflE3l
	 By4AlJA1dA0togu4U+GuD8kkibjgtDMQ7wr5qE+htL3JzpSSaoQMtmQMOLMOxEeGfR
	 iucP15ryokFafsQEuVdNefSjAGDcuk7Y/PPxk1DmIr/gsKJFfljDV5bGr549RyRgp8
	 AwoEOrE1wA9WQ==
Date: Thu, 05 Jun 2025 22:04:39 +0000
To: Burak Emir <bqe@google.com>
From: Pekka Ristola <pekkarr@protonmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v11 5/5] rust: add dynamic ID pool abstraction for bitmap
Message-ID: <_YXyH2NepC8WAr7ghT3Y-9mpj_x0nZCgmA3Cm5-eUuRE_sK1zcepZsrCJarthhyjI84G3PAwjp316nfUaPvFFIN4QCgj_W9k2SUaGy7pa0s=@protonmail.com>
In-Reply-To: <20250602135231.1615281-6-bqe@google.com>
References: <20250602135231.1615281-1-bqe@google.com> <20250602135231.1615281-6-bqe@google.com>
Feedback-ID: 29854222:user:proton
X-Pm-Message-ID: cd7b5a4c83110ac7da85fce57973f1a3f869bfc2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, June 2nd, 2025 at 16.53, Burak Emir <bqe@google.com> wrote:
> This is a port of the Binder data structure introduced in commit
> 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> Rust.
>=20
> Like drivers/android/dbitmap.h, the ID pool abstraction lets
> clients acquire and release IDs. The implementation uses a bitmap to
> know what IDs are in use, and gives clients fine-grained control over
> the time of allocation. This fine-grained control is needed in the
> Android Binder. We provide an example that release a spinlock for
> allocation and unit tests (rustdoc examples).
>=20
> The implementation does not permit shrinking below capacity below
> BITS_PER_LONG.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>  MAINTAINERS            |   1 +
>  rust/kernel/id_pool.rs | 222 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  3 files changed, 224 insertions(+)
>  create mode 100644 rust/kernel/id_pool.rs
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 943d85ed1876..bc95d98f266b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4134,6 +4134,7 @@ R:=09Yury Norov <yury.norov@gmail.com>
>  S:=09Maintained
>  F:=09lib/find_bit_benchmark_rust.rs
>  F:=09rust/kernel/bitmap.rs
> +F:=09rust/kernel/id_pool.rs
>=20
>  BITOPS API
>  M:=09Yury Norov <yury.norov@gmail.com>
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> new file mode 100644
> index 000000000000..cf26d405d9bb
> --- /dev/null
> +++ b/rust/kernel/id_pool.rs
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Rust API for an ID pool backed by a [`Bitmap`].
> +
> +use crate::alloc::{AllocError, Flags};
> +use crate::bitmap::Bitmap;
> +
> +/// Represents a dynamic ID pool backed by a [`Bitmap`].
> +///
> +/// Clients acquire and release IDs from unset bits in a bitmap.
> +///
> +/// The capacity of the ID pool may be adjusted by users as
> +/// needed. The API supports the scenario where users need precise contr=
ol
> +/// over the time of allocation of a new backing bitmap, which may requi=
re
> +/// release of spinlock.
> +/// Due to concurrent updates, all operations are re-verified to determi=
ne
> +/// if the grow or shrink is sill valid.
> +///
> +/// # Examples
> +///
> +/// Basic usage
> +///
> +/// ```
> +/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +/// use kernel::id_pool::IdPool;
> +///
> +/// let mut pool =3D IdPool::new(64, GFP_KERNEL)?;
> +/// for i in 0..64 {
> +///   assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
> +/// }
> +///
> +/// pool.release_id(23);
> +/// assert_eq!(23, pool.acquire_next_id(0).ok_or(ENOSPC)?);
> +///
> +/// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
> +/// let resizer =3D pool.grow_request().ok_or(ENOSPC)?.realloc(GFP_KERNE=
L)?;
> +/// pool.grow(resizer);
> +///
> +/// assert_eq!(pool.acquire_next_id(0), Some(64));
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// Releasing spinlock to grow the pool
> +///
> +/// ```no_run
> +/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +/// use kernel::sync::{new_spinlock, SpinLock};
> +/// use kernel::id_pool::IdPool;
> +///
> +/// fn get_id_maybe_realloc(guarded_pool: &SpinLock<IdPool>) -> Result<u=
size, AllocError> {
> +///   let mut pool =3D guarded_pool.lock();
> +///   loop {
> +///     match pool.acquire_next_id(0) {
> +///       Some(index) =3D> return Ok(index),
> +///       None =3D> {
> +///         let alloc_request =3D pool.grow_request();
> +///         drop(pool);
> +///         let resizer =3D alloc_request.ok_or(AllocError)?.realloc(GFP=
_KERNEL)?;
> +///         pool =3D guarded_pool.lock();
> +///         pool.grow(resizer)
> +///       }
> +///     }
> +///   }
> +/// }
> +/// ```
> +pub struct IdPool {
> +    map: Bitmap,
> +}
> +
> +/// Indicates that an [`IdPool`] should change to a new target size.
> +pub struct ReallocRequest {
> +    num_ids: usize,
> +}
> +
> +/// Contains a [`Bitmap`] of a size suitable for reallocating [`IdPool`]=
.
> +pub struct PoolResizer {
> +    new: Bitmap,
> +}
> +
> +impl ReallocRequest {
> +    /// Allocates a new backing [`Bitmap`] for [`IdPool`].
> +    ///
> +    /// This method only prepares reallocation and does not complete it.
> +    /// Reallocation will complete after passing the [`PoolResizer`] to =
the
> +    /// [`IdPool::grow`] or [`IdPool::shrink`] operation, which will che=
ck
> +    /// that reallocation still makes sense.
> +    pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocErro=
r> {
> +        let new =3D Bitmap::new(self.num_ids, flags)?;
> +        Ok(PoolResizer { new })
> +    }
> +}
> +
> +impl IdPool {
> +    /// Constructs a new `[IdPool]`.

The link is broken, it should be [`IdPool`].

> +    ///
> +    /// A capacity below [`BITS_PER_LONG`] is adjusted to [`BITS_PER_LON=
G`].

Since `BITS_PER_LONG` is defined in the bindings, it needs an explicit
path. Rustdoc won't link to it otherwise.

Maybe something like:

```
/// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
```

> +    #[inline]
> +    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError>=
 {
> +        let num_ids =3D core::cmp::max(num_ids, bindings::BITS_PER_LONG =
as usize);
> +        let map =3D Bitmap::new(num_ids, flags)?;
> +        Ok(Self { map })
> +    }
> +
> +    /// Returns how many IDs this pool can currently have.
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.map.len()
> +    }

This needs `#[expect(clippy::len_without_is_empty)]` or adding the
`is_empty` method.

> +
> +    /// Returns a [`ReallocRequest`] if the [`IdPool`] can be shrunk, [`=
None`] otherwise.
> +    ///
> +    /// The capacity of an [`IdPool`] cannot be shrunk below [`BITS_PER_=
LONG`].

The `BITS_PER_LONG` link is broken here as well.

> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::id_pool::{ReallocRequest, IdPool};
> +    ///
> +    /// let mut pool =3D IdPool::new(1024, GFP_KERNEL)?;
> +    /// let alloc_request =3D pool.shrink_request().ok_or(AllocError)?;
> +    /// let resizer =3D alloc_request.realloc(GFP_KERNEL)?;
> +    /// pool.shrink(resizer);
> +    /// assert_eq!(pool.len(), kernel::bindings::BITS_PER_LONG as usize)=
;
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn shrink_request(&self) -> Option<ReallocRequest> {
> +        let len =3D self.map.len();
> +        // Shrinking below [`BITS_PER_LONG`] is never possible.
> +        if len <=3D bindings::BITS_PER_LONG as usize {
> +            return None;
> +        }
> +        // Determine if the bitmap can shrink based on the position of
> +        // its last set bit. If the bit is within the first quarter of
> +        // the bitmap then shrinking is possible. In this case, the
> +        // bitmap should shrink to half its current size.
> +        let last_bit =3D self.map.last_bit();
> +        if last_bit.is_none() {
> +            return Some(ReallocRequest {
> +                num_ids: bindings::BITS_PER_LONG as usize,
> +            });
> +        }
> +        let bit =3D last_bit.unwrap();

Instead of `unwrap`, consider using `let else`:

```
let Some(bit) =3D self.map.last_bit() else {
    return Some(ReallocRequest { ... });
};
```

> +        if bit >=3D (len / 4) {
> +            return None;
> +        }
> +        let num_ids =3D core::cmp::max(bindings::BITS_PER_LONG as usize,=
 len / 2);
> +        Some(ReallocRequest { num_ids })
> +    }
> +
> +    /// Shrinks pool by using a new [`Bitmap`], if still possible.
> +    #[inline]
> +    pub fn shrink(&mut self, mut resizer: PoolResizer) {
> +        // Between request to shrink that led to allocation of `resizer`=
 and now,
> +        // bits may have changed.
> +        // Verify that shrinking is still possible. In case shrinking to
> +        // the size of `resizer` is no longer possible, do nothing,
> +        // drop `resizer` and move on.
> +        let updated =3D self.shrink_request();
> +        if updated.is_none() {
> +            return;
> +        }
> +        if updated.unwrap().num_ids > resizer.new.len() {

Same here, the unwrap can be replaced with `let else`.

> +            return;
> +        }
> +
> +        resizer.new.copy_and_extend(&self.map);
> +        self.map =3D resizer.new;
> +    }
> +
> +    /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if pos=
sible.
> +    ///
> +    /// The capacity of an [`IdPool`] cannot be grown above [`i32::MAX`]=
.
> +    #[inline]
> +    pub fn grow_request(&self) -> Option<ReallocRequest> {
> +        let num_ids =3D self.map.len() * 2;
> +        if num_ids > i32::MAX.try_into().unwrap() {
> +            return None;
> +        }
> +        Some(ReallocRequest { num_ids })
> +    }
> +
> +    /// Grows pool by using a new [`Bitmap`], if still necessary.
> +    ///
> +    /// The `resizer` arguments has to be obtained by calling [`grow_req=
uest`]
> +    /// on this object and performing a `realloc`.

The `grow_request` link doesn't work. Also `realloc` should be a link to
the `ReallocRequest::realloc` method.

> +    #[inline]
> +    pub fn grow(&mut self, mut resizer: PoolResizer) {
> +        // Between request to grow that led to allocation of `resizer` a=
nd now,
> +        // another thread may have already grown the capacity.
> +        // In this case, do nothing, drop `resizer` and move on.
> +        if resizer.new.len() <=3D self.map.len() {
> +            return;
> +        }
> +
> +        resizer.new.copy_and_extend(&self.map);
> +        self.map =3D resizer.new;
> +    }
> +
> +    /// Acquires a new ID by finding and setting the next zero bit in th=
e
> +    /// bitmap.
> +    ///
> +    /// Upon success, returns its index. Otherwise, returns `None`
> +    /// to indicate that a `grow_request` is needed.

`None` and `grow_request` should be changed to links.

> +    #[inline]
> +    pub fn acquire_next_id(&mut self, offset: usize) -> Option<usize> {
> +        let next_zero_bit =3D self.map.next_zero_bit(offset);
> +        if let Some(nr) =3D next_zero_bit {
> +            self.map.set_bit(nr);
> +        }
> +        next_zero_bit
> +    }
> +
> +    /// Releases an ID.
> +    #[inline]
> +    pub fn release_id(&mut self, id: usize) {
> +        self.map.clear_bit(id);
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 8c4161cd82ac..d7def807900a 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -54,6 +54,7 @@
>  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>  pub mod firmware;
>  pub mod fs;
> +pub mod id_pool;
>  pub mod init;
>  pub mod io;
>  pub mod ioctl;
> --
> 2.49.0.1204.g71687c7c1d-goog

Cheers,
Pekka
