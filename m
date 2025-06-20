Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEFD23BD05
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408076; cv=none; b=iCHqM+ffr71AeujIny+PfvUyTqcWNpkfEj/ilAsvy8MxlXAZ4w4o2QTQj+lElAQcPdMWD6bgcdV+zqU0NZIt6Ay4Ku/Co2KQwUaiWEbLy6JVTAi5QfBucsdjcHfHj1boCuntu7oMVrH3aMlK8hd4hJxJwiY+uKgtF1uEu5m4HEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408076; c=relaxed/simple;
	bh=F7ZfMAK+u84TO5CSVJragKvkR0OtJVKpubrMMFL3xMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVJNmTm8ye0n6Ehg4Y1HC3zjZh7v/oDwnh+bbrcvXfMfp/ERy5ghcgF05HftWSc3hE44Swiq0b/nNKSxn8GeM2/r/uLlaVNtRStnh+d9n79vu2cuOQWhpENATJq1xCcPDi4BlV9y7Rzzbq3gBf89CQ3m8PtJUKSi9NeLEH4feb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vgHY5s3N; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vgHY5s3N"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2da73158006so999627fac.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750408073; x=1751012873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5b33lr7yR7TeMIY5Q80Tgf6EEzvmXOBK8meKCI48dg=;
        b=vgHY5s3NRtFLAR2b2lFzhfyV+/jiRoAm14S7icHa+UCEW8u8js/5cwoQHJ1Gg4eFDV
         Qmha0IvzeZdzQ0UmS77eN6WZfkK5qqzKhH0iJiAMI82yWPAO0zbYoFRrABHme8771HLq
         MPUXQtJi2PxprZGPIHSzzBHONg86KwZ9WPil/p8cg8nuAaQuGkhds7O6tANsA1UVkcAx
         EByCgKq0w2LaO4mqJiItYak64WLZZggx+pzwOz9zlP4oF9lpI1ahWHSSEbxHRdsDN0Hg
         vXshzFrBwqt6uGpLMibSSL/Udn/C8ER3EsLoUzJTuz7A68zq4IOQZKjZ+h9MSKD2GjkH
         jZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408073; x=1751012873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5b33lr7yR7TeMIY5Q80Tgf6EEzvmXOBK8meKCI48dg=;
        b=kEvjO/mBgATsVqs/iE5Aiw8aFGxYv3d8Wp01AaKx4VIFCUsB2JHBb2suUm5qW2W6Ri
         XbBCnN114+avDoz3Po8zpn3W3Ii+gJ0AJ+ARJftLxduWQwfnVc5JO2DNc6S2ipCvfvOS
         wSLVAvP0QtK2pafyRHc7ZYUhaSnAfYlYbd1D/zxiQ9U42z42c0xHf8L2EF6WKQTVUYIG
         FZxik0MOdPCh70q9yp2XhB/JY0dhzhYj/XDpO9it7BQc+kx8TkyvqYdrCECwTfPesrWD
         ZH6DNwZYVarXYl5gTPFQuCB92/CtEBdR0rWiFhZn3XkSHlJsRF02g/YwdTQbqIJ/xBAK
         WLOA==
X-Forwarded-Encrypted: i=1; AJvYcCURELzuFuDBVc2jpTGgLtgmI7UHIH73YY4A5zC5uHCxF0/UUvVt2A3Wj5xVyjAgMVlSn57JbNoS2dbk6Q4YcJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL37sDU4lm7s9s+tAIQ3K+N2pBdTN94YOA80ycUdprFgjgF/p8
	8QqHXDYcjnT15ZAqMDcZp3Yk7ligI16W704JNEHkeORGbt736Lvsbhri/0JlQAoC2VGxGszCQPJ
	tZkGfHqPhF9nWRX5WlerKebWfQWlVArXNA1gbSJox
X-Gm-Gg: ASbGncvyeldSsPyul8j3cehllAOLBryEYpa+fnIRBA+0V88EqFjL1K6OcOm6oc1tudJ
	VV2NWQxGK63hR3JnBi7YTNqrQYX5kVvL7kwysyredmeEqwxxZuabSC94/pQ4K43JLH2RpDkUBvB
	5AXIYrulPoZ/st5ng5SKCrchBXo0o7IJw/TFwForregBGoj9qZPyQgdjbVeb6EMqknVMFUM4Mt
X-Google-Smtp-Source: AGHT+IGD8np40QOVTmL1INslOxrzVLJegUcNv2Tz+RR57xxaHkaOMGFd4c5ccJdDk3BTtbuXz8WAg0hOFj2Ue6/nWoI=
X-Received: by 2002:a05:6871:3a20:b0:2c8:5db8:f23a with SMTP id
 586e51a60fabf-2eeee578e6amr1251020fac.20.1750408073170; Fri, 20 Jun 2025
 01:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194840.877308-1-bqe@google.com> <20250611194840.877308-6-bqe@google.com>
 <aEqZOOfx-tP5FYio@google.com>
In-Reply-To: <aEqZOOfx-tP5FYio@google.com>
From: Burak Emir <bqe@google.com>
Date: Fri, 20 Jun 2025 10:27:41 +0200
X-Gm-Features: AX0GCFsvFVjtrbzvekdAg41taEGDRfrR3UaiGMy2f-aX2FJNx2fkspgEucGNTqU
Message-ID: <CACQBu=VnqSHMPaMgMKGOt6E5Aw=bB94uVwKQYypwEXhHp91oXQ@mail.gmail.com>
Subject: Re: [PATCH v12 5/5] rust: add dynamic ID pool abstraction for bitmap
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

On Thu, Jun 12, 2025 at 11:09=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Wed, Jun 11, 2025 at 07:48:38PM +0000, Burak Emir wrote:
> > This is a port of the Binder data structure introduced in commit
> > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> > Rust.
> >
> > Like drivers/android/dbitmap.h, the ID pool abstraction lets
> > clients acquire and release IDs. The implementation uses a bitmap to
> > know what IDs are in use, and gives clients fine-grained control over
> > the time of allocation. This fine-grained control is needed in the
> > Android Binder. We provide an example that release a spinlock for
> > allocation and unit tests (rustdoc examples).
> >
> > The implementation does not permit shrinking below capacity below
> > BITS_PER_LONG.
> >
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Burak Emir <bqe@google.com>
> > ---
> >  MAINTAINERS            |   1 +
> >  rust/kernel/id_pool.rs | 223 +++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs     |   1 +
> >  3 files changed, 225 insertions(+)
> >  create mode 100644 rust/kernel/id_pool.rs
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 943d85ed1876..bc95d98f266b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4134,6 +4134,7 @@ R:      Yury Norov <yury.norov@gmail.com>
> >  S:   Maintained
> >  F:   lib/find_bit_benchmark_rust.rs
> >  F:   rust/kernel/bitmap.rs
> > +F:   rust/kernel/id_pool.rs
> >
> >  BITOPS API
> >  M:   Yury Norov <yury.norov@gmail.com>
> > diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> > new file mode 100644
> > index 000000000000..355a8ae93268
> > --- /dev/null
> > +++ b/rust/kernel/id_pool.rs
> > @@ -0,0 +1,223 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2025 Google LLC.
> > +
> > +//! Rust API for an ID pool backed by a [`Bitmap`].
> > +
> > +use crate::alloc::{AllocError, Flags};
> > +use crate::bitmap::Bitmap;
> > +
> > +/// Represents a dynamic ID pool backed by a [`Bitmap`].
> > +///
> > +/// Clients acquire and release IDs from unset bits in a bitmap.
> > +///
> > +/// The capacity of the ID pool may be adjusted by users as
> > +/// needed. The API supports the scenario where users need precise con=
trol
> > +/// over the time of allocation of a new backing bitmap, which may req=
uire
> > +/// release of spinlock.
> > +/// Due to concurrent updates, all operations are re-verified to deter=
mine
> > +/// if the grow or shrink is sill valid.
> > +///
> > +/// # Examples
> > +///
> > +/// Basic usage
> > +///
> > +/// ```
> > +/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> > +/// use kernel::id_pool::IdPool;
> > +///
> > +/// let mut pool =3D IdPool::new(64, GFP_KERNEL)?;
> > +/// for i in 0..64 {
> > +///   assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
> > +/// }
> > +///
> > +/// pool.release_id(23);
> > +/// assert_eq!(23, pool.acquire_next_id(0).ok_or(ENOSPC)?);
> > +///
> > +/// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
> > +/// let resizer =3D pool.grow_request().ok_or(ENOSPC)?.realloc(GFP_KER=
NEL)?;
> > +/// pool.grow(resizer);
> > +///
> > +/// assert_eq!(pool.acquire_next_id(0), Some(64));
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +///
> > +/// Releasing spinlock to grow the pool
> > +///
> > +/// ```no_run
> > +/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> > +/// use kernel::sync::{new_spinlock, SpinLock};
> > +/// use kernel::id_pool::IdPool;
> > +///
> > +/// fn get_id_maybe_realloc(guarded_pool: &SpinLock<IdPool>) -> Result=
<usize, AllocError> {
> > +///   let mut pool =3D guarded_pool.lock();
> > +///   loop {
> > +///     match pool.acquire_next_id(0) {
> > +///       Some(index) =3D> return Ok(index),
> > +///       None =3D> {
> > +///         let alloc_request =3D pool.grow_request();
> > +///         drop(pool);
> > +///         let resizer =3D alloc_request.ok_or(AllocError)?.realloc(G=
FP_KERNEL)?;
> > +///         pool =3D guarded_pool.lock();
> > +///         pool.grow(resizer)
> > +///       }
> > +///     }
> > +///   }
> > +/// }
> > +/// ```
>
> These examples use two spaces for indentation, but in Rust we use four
> spaces.
>
> > +pub struct IdPool {
> > +    map: Bitmap,
> > +}
> > +
> > +/// Indicates that an [`IdPool`] should change to a new target size.
> > +pub struct ReallocRequest {
> > +    num_ids: usize,
> > +}
> > +
> > +/// Contains a [`Bitmap`] of a size suitable for reallocating [`IdPool=
`].
> > +pub struct PoolResizer {
> > +    new: Bitmap,
> > +}
> > +
> > +impl ReallocRequest {
> > +    /// Allocates a new backing [`Bitmap`] for [`IdPool`].
> > +    ///
> > +    /// This method only prepares reallocation and does not complete i=
t.
> > +    /// Reallocation will complete after passing the [`PoolResizer`] t=
o the
> > +    /// [`IdPool::grow`] or [`IdPool::shrink`] operation, which will c=
heck
> > +    /// that reallocation still makes sense.
> > +    pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocEr=
ror> {
> > +        let new =3D Bitmap::new(self.num_ids, flags)?;
> > +        Ok(PoolResizer { new })
> > +    }
> > +}
> > +
> > +impl IdPool {
> > +    /// Constructs a new [`IdPool`].
> > +    ///
> > +    /// [BITS_PER_LONG]: srctree/include/asm-generic/bitsperlong.h
> > +    /// A capacity below [`BITS_PER_LONG`][BITS_PER_LONG] is adjusted =
to
> > +    /// [`BITS_PER_LONG`][BITS_PER_LONG].
>
> I'm concerned that this might not render correctly in the html docs.
> Markdown links are usually written below the text and with an empty
> line:
>
> /// A capacity below [`BITS_PER_LONG`][BITS_PER_LONG] is adjusted to
> /// [`BITS_PER_LONG`][BITS_PER_LONG].
> ///
> /// [BITS_PER_LONG]: srctree/include/asm-generic/bitsperlong.h
>
> which can be further simplified to
>
> /// A capacity below [`BITS_PER_LONG`] is adjusted to [`BITS_PER_LONG`].
> ///
> /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
>
> Furthermore, if you declare a public BITS_PER_LONG constant on the Rust
> side like I suggested in my reply to one of the other patches, then it
> will automatically link to that if you've imported it with `use` and
> don't specify a link target:
>
> use kernel::bitmap::BITS_PER_LONG;
>
> /// A capacity below [`BITS_PER_LONG`] is adjusted to [`BITS_PER_LONG`].
>
> Same applies to other docs that link to this constant.

Previously, there was no BITS_PER_LONG in scope, so to make rustdoc work
I had resorted to clumsy way above. I had tried it locally, but was wonderi=
ng
whether there is a better way.

In v13, I define a local BITS_PER_LONG usize const as you suggested on
the other file.
With that, it works and the code also reads better.
For a convenience const declaration, I think local redefinition is
better than linking elsewhere.

> > +    #[inline]
> > +    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocErro=
r> {
> > +        let num_ids =3D core::cmp::max(num_ids, bindings::BITS_PER_LON=
G as usize);
>
> Nit: I like to write usize::max(...) instead of core::cmp::max(...),
> which I think reads better.

Done

> > +        let map =3D Bitmap::new(num_ids, flags)?;
> > +        Ok(Self { map })
> > +    }
> > +
> > +    /// Returns how many IDs this pool can currently have.
> > +    #[expect(clippy::len_without_is_empty)]
> > +    #[inline]
> > +    pub fn len(&self) -> usize {
>
> Maybe this should be called capacity() instead? Or maybe we just don't
> have this method at all.

capacity sounds good. I think it is useful in helping readability.

Thanks,
Burak
