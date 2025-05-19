Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61861C8604;
	Mon, 19 May 2025 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747683982; cv=none; b=kDL4FnkyeOwhaPTN3BnboE6F78xLVAyAIGVuSWZv+e02Z5fql0C+EYDoF+eShPUVe4ntmPTgf7T1NLhxRNKpZcwmH77DlAQ47Ebq1RloRLfOy6wI8fNDfBGD8WaoM4cYqm96zzRpJIGH+kySiKtOgZySlBgm2lgbQc6quXvG1WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747683982; c=relaxed/simple;
	bh=dzyHX1BH4jllE8WUig5qynLGWjQ6ogLV5kDKWaSFo7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFamSIDsEff3Fp+oiqYMj7mI7ff4PVFKinQDs+bBiNSuRtLp1Vz7FqtuubSEuDU7U29cxn81HFJxItobAQ7RckwrrnvZCQpVkN1ayaF/iirKUKUkSIE8yWvHyt4eY/G/WWtITmMhBlVOmrgDcXRz+fYXYtHMdC/pxTzEmzVGSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTBcjZAX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTBcjZAX"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c2ed0fe1so2291000b3a.1;
        Mon, 19 May 2025 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747683979; x=1748288779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KYRU02TVq8/dirxnlanJGcUcoUt7XKR8bCEBfMqNk4=;
        b=UTBcjZAXafO6xHWw+MHWm6spI3qkdxcUnvV7RqSDp+ADqOMbQtF7OewtprLJmlWBON
         HaZ1NEZxTpDqpaNFd3m0XizGG4nJe0XuYR5fGqm9rWCsdiPfWergfamK4UsR7J3WmuxE
         nLN64x54SEyz0TcLCn4f0JK2S5iiB64C+4M5eJPOhDFPqhV/Cq2xqXG3uiF6HowODPGi
         7HWBiDUb9LgLUUpogahxBhWW6m64LXCos8YsBqviNLRX3jvFS9AUGsZMFjSJSdksR21A
         djMea5oOxQLGm92c7NlfbSK16w76QkZK1XzN94TAofii9RyED78YRg0eo/NJMqYtz8UR
         o6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747683979; x=1748288779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KYRU02TVq8/dirxnlanJGcUcoUt7XKR8bCEBfMqNk4=;
        b=NF5m7vUePM3NUzGsqyeWjhRBBgvch81TdbpUjmJnGq4mSsr6y2cDOO3dESVuVn7xO7
         LuWBEpgjzEKU6A7VD5OymT79dNGd/ECSDdLt3PkPyoWaIZSvB3FoxHpSR8KatehfDaZn
         iVrnsCK4TCvZJI7goTPKX4s5n2L0mXQgIP1MghrGYgpD9H/Djw45DZWdXpgfORmXqPCR
         v9Fim+25CjLzvFrqIbCia0f8aL9CGwp+xdiGXzJMnUkUYk55R/wpO82tcgRymYZdhQEr
         IZceVSFYyIV0z36F/vEZDOtTQv0BhcGdVBcoJctJU5GH87e/IvT/YpkpZj47xEbd4SgT
         4T3g==
X-Forwarded-Encrypted: i=1; AJvYcCU5ikdi/r8/ekMjXSyRipwwxqZQMtUoI/8/J5hGkjjQCXLeouYTN64Vos5pSVCVBuo+c0WnL15+5q0RSYpg@vger.kernel.org, AJvYcCUjURdvGgLxC5jfqLX13vb/6DU9xIHJTHPlHhItNpkJ5WMo798KR1hOlhqJ5KNxF3SCVMJ+fVdUMPyPDhJPpno=@vger.kernel.org, AJvYcCXfiXJeMSzz8/I6/pe4xIIpjbU5q8JF5VuphaU7MtStBsiTsoSs3YMpz5AUvOIl4BtDlYbTuV51pex1ESF3X6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZUewcdyukRHElzeJ7xHpMyC08lp9K5IhZvos95h0wgkC+bs7
	wUjHeTuCBYlC78nKAIMgTjdWlPCfhxp/NxM8FRC/Gq0SRVCIU1OvQwkw
X-Gm-Gg: ASbGncs9OMo1MsI8x/BXpn6gyVsHMDHubowGkOzLBQuxFoFl4TbilJm6rE9cFvjUBPE
	SPuvmu33O3ZFquPQFzL6XnY4fcdfOl96alAwpb9qs216RTO4woGEsx8xOyIfvnkOI+dtpIN/4AO
	MjByS2Z7ABsRR8sUuYi/VhbZAFe3FVltrIqK2FwoqULOhA9zPw6pTm/P0ig0W+58VvGd6nrdd1o
	/DJBCwobOvmXXkk6E+/yVnQdB7Mu4HS0gSMrq4MYSd4dHfnd6uRE4QCsZZ2TuIXnkRh00Ck6E97
	7wR5Rh0haHLR1YVWoy2yELtxqCIifquCeu720aQ1RUo1j1+kvFM=
X-Google-Smtp-Source: AGHT+IFutdp9LZlElMzmD02VLuMhE/QQCDxrbRn3fz6st4/yEgVGZwT2cdz2JQmceVk3HE1ze+S3+w==
X-Received: by 2002:a05:6a00:3c89:b0:742:9cdc:5cbd with SMTP id d2e1a72fcca58-742a98abc68mr16835272b3a.17.1747683978939;
        Mon, 19 May 2025 12:46:18 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6dc3csm6611780a12.24.2025.05.19.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 12:46:18 -0700 (PDT)
Date: Mon, 19 May 2025 15:46:15 -0400
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
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
Message-ID: <aCuKh0VLh4oUbdv0@yury>
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-6-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519161712.2609395-6-bqe@google.com>

On Mon, May 19, 2025 at 04:17:05PM +0000, Burak Emir wrote:
> This is a port of the Binder data structure introduced in commit
> 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> Rust.
> 
> Like drivers/android/dbitmap.h, the ID pool abstraction lets
> clients acquire and release IDs. The implementation uses a bitmap to
> know what IDs are in use, and gives clients fine-grained control over
> the time of allocation. This fine-grained control is needed in the
> Android Binder. We provide an example that release a spinlock for
> allocation and unit tests (rustdoc examples).
> 
> The implementation is not aware that the underlying Bitmap abstraction
> handles lengths below BITS_PER_LONG without allocation.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>  MAINTAINERS            |   1 +
>  rust/kernel/id_pool.rs | 201 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  3 files changed, 203 insertions(+)
>  create mode 100644 rust/kernel/id_pool.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 943d85ed1876..bc95d98f266b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4134,6 +4134,7 @@ R:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
>  F:	lib/find_bit_benchmark_rust.rs
>  F:	rust/kernel/bitmap.rs
> +F:	rust/kernel/id_pool.rs
>  
>  BITOPS API
>  M:	Yury Norov <yury.norov@gmail.com>
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> new file mode 100644
> index 000000000000..8f07526bb580
> --- /dev/null
> +++ b/rust/kernel/id_pool.rs
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Rust API for an ID pool backed by a `Bitmap`.
> +
> +use crate::alloc::{AllocError, Flags};
> +use crate::bitmap::Bitmap;
> +
> +/// Represents a dynamic ID pool backed by a `Bitmap`.
> +///
> +/// Clients acquire and release IDs from zero bits in a bitmap.

Maybe 'unset' or 'free' instead of 'zero'?

> +///
> +/// The ID pool can grow or shrink as needed. It has been designed

s/can/may/. You don't implement automatic adjustment of a pool
capacity, but from this comment one may conclude that the pool  
may grow or shrink by itself. Can you instead say: the Capacity
of IDs may be adjusted by user as needed. Or something like that.

> +/// to support the scenario where users need to control the time
> +/// of allocation of a new backing bitmap, which may require release
> +/// of locks.
> +/// These operations then, are verified to determine if the grow or
> +/// shrink is sill valid.
> +///
> +/// # Examples
> +///
> +/// Basic usage
> +///
> +/// ```
> +/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +/// use kernel::id_pool::IdPool;
> +///
> +/// let mut pool = IdPool::new(64, GFP_KERNEL)?;
> +/// for i in 0..64 {
> +///   assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
> +/// }
> +///
> +/// pool.release_id(23);
> +/// assert_eq!(23, pool.acquire_next_id(0).ok_or(ENOSPC)?);
> +///
> +/// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
> +/// let resizer = pool.grow_alloc().alloc(GFP_KERNEL)?;
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
> +/// fn get_id_maybe_alloc(guarded_pool: &SpinLock<IdPool>) -> Result<usize, AllocError> {
> +///   let mut pool = guarded_pool.lock();
> +///   loop {
> +///     match pool.acquire_next_id(0) {
> +///       Some(index) => return Ok(index),
> +///       None => {
> +///         let alloc_request = pool.grow_alloc();
> +///         drop(pool);
> +///         let resizer = alloc_request.alloc(GFP_KERNEL)?;
> +///         pool = guarded_pool.lock();
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
> +/// Returned when the `IdPool` should change size.
> +pub struct AllocRequest {
> +    nbits: usize,
> +}
> +
> +/// Contains an allocated `Bitmap` for resizing `IdPool`.
> +pub struct PoolResizer {
> +    new: Bitmap,
> +}
> +
> +impl AllocRequest {
> +    /// Allocates a new `Bitmap` for `IdPool`.
> +    pub fn alloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
> +        let new = Bitmap::new(self.nbits, flags)?;
> +        Ok(PoolResizer { new })
> +    }
> +}
> +
> +impl IdPool {
> +    /// Constructs a new `[IdPool]`.
> +    #[inline]
> +    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {

Those 'bits' are 'IDs' now. I think the 1st parameter name should
reflect that: num_ids, or something.

> +        let map = Bitmap::new(nbits, flags)?;
> +        Ok(Self { map })
> +    }

What for do you split new() and alloc()? When I call 'new()' method, I
expect it will initialize all the fields.

Or I misunderstand something?

> +
> +    /// Returns how many IDs this pool can currently have.
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.map.len()
> +    }
> +
> +    /// Returns an [`AllocRequest`] if the [`IdPool`] can be shrunk, [`None`] otherwise.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::id_pool::{AllocRequest, IdPool};
> +    ///
> +    /// let mut pool = IdPool::new(1024, GFP_KERNEL)?;
> +    /// let alloc_request = pool.shrink_alloc().ok_or(AllocError)?;
> +    /// let resizer = alloc_request.alloc(GFP_KERNEL)?;
> +    /// pool.shrink(resizer);
> +    /// assert_eq!(pool.len(), kernel::bindings::BITS_PER_LONG as usize);
> +    /// # Ok::<(), AllocError>(())


So, I don't understand what for do you have this 'pool.shrink_alloc()'
line after the 'new()' call. Thinking object-oriented, when I create
a new object, and receive OK, I can use it immediately. IIUC, I can't
request an ID immediately after creating an IdPool.

> +    /// ```
> +    #[inline]
> +    pub fn shrink_alloc(&self) -> Option<AllocRequest> {
> +        let len = self.map.len();
> +        if len <= bindings::BITS_PER_LONG as usize {
> +            return None;
> +        }

How that? If I want to shrink from 60 to say 30 IDs, I expect that
you will not allow me to allocate 31st ID. But the above code makes
the whole function a no-op...

> +        /*
> +         * Determine if the bitmap can shrink based on the position of
> +         * its last set bit. If the bit is within the first quarter of
> +         * the bitmap then shrinking is possible. In this case, the
> +         * bitmap should shrink to half its current size.
> +         */
> +        match self.map.last_bit() {
> +            Some(bit) => {
> +                if bit < (len >> 2) {
> +                    Some(AllocRequest { nbits: len >> 1 })

Can you use the 'a/2' style instead of this shifts?

> +                } else {
> +                    None
> +                }
> +            }
> +            None => Some(AllocRequest {
> +                nbits: bindings::BITS_PER_LONG as usize,
> +            }),

Can you reorder the logic such that non-error path will have no extra
indentations?

> +        }
> +    }
> +
> +    /// Shrinks pool by using a new `Bitmap`, if still possible.
> +    #[inline]

I don't understand it. You have shrink_alloc(), which indeed allocates
something, and you have just 'shrink(). And it also allocates before
using the copy_and_extend().

Can you elaborate what for do you need 2 versions of 'shrink'?

> +    pub fn shrink(&mut self, mut resizer: PoolResizer) {

I believe your users will be more thankful if you just allow them to
shrink their ID pools without all that intermediate objects, like:
        my_pool.shrink(100);

> +        // Verify that shrinking is still possible. The `resizer`
> +        // bitmap might have been allocated without locks, so this call
> +        // could now be outdated. In this case, drop `resizer` and move on.
> +        if let Some(AllocRequest { nbits }) = self.shrink_alloc() {
> +            if nbits <= resizer.new.len() {
> +                resizer.new.copy_and_extend(&self.map);
> +                self.map = resizer.new;
> +                return;

Again, can you please have non-error path as non-indented as possible?

> +            }
> +        }
> +    }
> +
> +    /// Returns an `AllocRequest` for growing this `IdPool`.
> +    #[inline]
> +    pub fn grow_alloc(&self) -> AllocRequest {
> +        AllocRequest {
> +            nbits: self.map.len() << 1,
> +        }
> +    }
> +
> +    /// Grows pool by using a new `Bitmap`, if still necessary.
> +    #[inline]
> +    pub fn grow(&mut self, mut resizer: PoolResizer) {
> +        // `resizer` bitmap might have been allocated without locks,
> +        // so this call could now be outdated. In this case, drop
> +        // `resizer` and move on.
> +        if resizer.new.len() <= self.map.len() {
> +            return;
> +        }
> +
> +        resizer.new.copy_and_extend(&self.map);
> +        self.map = resizer.new;
> +    }
> +
> +    /// Acquires a new ID by finding and setting the next zero bit in the
> +    /// bitmap. Upon success, returns its index. Otherwise, returns `None`
> +    /// to indicate that a `grow_alloc` is needed.
> +    #[inline]
> +    pub fn acquire_next_id(&mut self, offset: usize) -> Option<usize> {
> +        match self.map.next_zero_bit(offset) {
> +            res @ Some(nr) => {
> +                self.map.set_bit(nr);
> +                res
> +            }
> +            None => None,
> +        }
> +    }
> +
> +    /// Releases an ID.
> +    #[inline]
> +    pub fn release_id(&mut self, id: usize) {
> +        self.map.clear_bit(id);

What if I release an empty ID? Maybe emit a warning?

> +    }
> +}

I think I totally miss the idea of PoolResizers here. The standard
dynamic array API looks like this:

        new(capacity)     -> IdPool
        drop(IdPool)      -> void
        acquire()         -> int
        release(id)       -> bool       // True if had been allocated
        acquire_next(id)* -> int        
        get_capacity()    -> int
        set_capacity(cap) -> bool
        num_ids()         -> int

 * This one is pretty rare.  Are you sure you need it?

Your API looks weird with those AllocRequests and PoolResizers,
and TBH I don't understand how that would help your users.

Can you please consider a more standard API?

Thanks,
Yury

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
> 2.49.0.1101.gccaa498523-goog
