Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E491E7C03;
	Thu,  5 Jun 2025 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749158432; cv=none; b=MlaQ9oT7a1MH418kFDxbtCR5nW4mtzyXVY+zdGO3mTd9ijwOVh06kjL8HHGZs3FahcwOWqV9TXhH1lIB9cMWpq2Znq3PiP2a5gZPS2+tuIX5faBXtjsH6fhRlHVF5p7YxDYEwrvtjAT/93v8ziPM87Iwy98zYKYGLt24SgtnKtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749158432; c=relaxed/simple;
	bh=mufn19hPlgQ6NEoSc03kk/eDPI9BBT8SEPAfnKWcjzI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dryFGdl+qzZZ8BbKQ7QYf17sNfDmGNLWfABoxAlV3s93vA1y2Os1WiANpceCNMPwVLPh2kY2Q/R1z5jDrezhFuulwPxvSnCpnG3qYmoLAmEt4da0DfIey6+IUg6n9jDIjlIFRhPtZ9LNqfkRvoQkG2HZYGVwVTN+XE8FHKCHVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=rOUiZQ42; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rOUiZQ42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1749158413; x=1749417613;
	bh=47lez6F5pabPoFPvx8kOKO3g/OggZmFNdiAKAkn0fxE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=rOUiZQ424MFhcTamtDLMBjX27SJcn48z0adoCkiWKOiPLX0MbLW9PO4UCLqnRipl9
	 6E3W1jw4vlHvRRmMhPHaFcf1tqnYMh8ypK6QS8tzjJUppKGGWbEEbKtyHa4DL00HBn
	 X1wlJhFGf/413Cuo6Ty/0Pgq3oC+ws8xivzrImMdP8ZtDV80Wi/GX/J41kRrK+B3k5
	 irsZGJ1e2oAbgUBfn5F0camaYke8puW9UJ+2sNvwBvTgpHtnxufpaaYaheNmUM7H25
	 G7hwJDxxgaB3fVLbaus06w4nWHj6oGO4peD2cjYSbi/sAEFrMJ8ZdNRxbsGK5eq3Nr
	 SKDAdL2jj76PQ==
Date: Thu, 05 Jun 2025 21:20:09 +0000
To: Burak Emir <bqe@google.com>
From: Pekka Ristola <pekkarr@protonmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v11 3/5] rust: add bitmap API.
Message-ID: <LGWNtyhjCByj6PPHMsGCwo-WBkCCUuCOn_cUuwlwHPhfRZ4TdDR97a3u63ACSIvJQZF2SyAInyX90iMkERX2MK3Up-R6jazWHWhFzTIWah4=@protonmail.com>
In-Reply-To: <20250602135231.1615281-4-bqe@google.com>
References: <20250602135231.1615281-1-bqe@google.com> <20250602135231.1615281-4-bqe@google.com>
Feedback-ID: 29854222:user:proton
X-Pm-Message-ID: 101473ab8081905c8394262b66904cff266291bd
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, June 2nd, 2025 at 16.53, Burak Emir <bqe@google.com> wrote:
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
>   * We leverage Rust type system guarantees as follows:
>=20
>     * all (non-atomic) mutating operations require a &mut reference which
>       amounts to exclusive access.
>=20
>     * the Bitmap type implements Send. This enables transferring
>       ownership between threads and is needed for Binder.
>=20
>     * the Bitmap type implements Sync, which enables passing shared
>       references &Bitmap between threads. Atomic operations can be
>       used to safely modify from multiple threads (interior
>       mutability), though without ordering guarantees.
>=20
>   * The Rust API uses `{set,clear}_bit` vs `{set,clear}_bit_atomic` as
>     names, which differs from the C naming convention which uses
>     set_bit for atomic vs __set_bit for non-atomic.
>=20
>   * we include enough operations for the API to be useful, but not all
>     operations are exposed yet in order to avoid dead code. The missing
>     ones can be added later.
>=20
>   * We follow the C API closely with a fine-grained approach to safety:
>=20
>     * Low-level bit-ops get a safe API with bounds checks. Calling with
>       an out-of-bounds arguments to {set,clear}_bit becomes a no-op and
>       get logged as errors.
>=20
>     * We introduce a RUST_BITMAP_HARDENED config, which
>       causes invocations with out-of-bounds arguments to panic.
>=20
>     * methods correspond to find_* C methods tolerate out-of-bounds
>       since the C implementation does. Also here, we log out-of-bounds
>       arguments as errors and panic in RUST_BITMAP_HARDENED mode.
>=20
>     * We add a way to "borrow" bitmaps from C in Rust, to make C bitmaps
>       that were allocated in C directly usable in Rust code (`CBitmap`).
>=20
>   * the Rust API is optimized to represent the bitmap inline if it would
>     fit into a pointer. This saves allocations which is
>     relevant in the Binder use case.
>=20
> The underlying C bitmap is *not* exposed, and must never be exposed
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
>  MAINTAINERS                |   7 +
>  rust/kernel/bitmap.rs      | 574 +++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs         |   1 +
>  security/Kconfig.hardening |  10 +
>  4 files changed, 592 insertions(+)
>  create mode 100644 rust/kernel/bitmap.rs
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04d6727e944c..565eaa015d9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4127,6 +4127,13 @@ S:=09Maintained
>  F:=09rust/helpers/bitmap.c
>  F:=09rust/helpers/cpumask.c
>=20
> +BITMAP API [RUST]
> +M:=09Alice Ryhl <aliceryhl@google.com>
> +M:=09Burak Emir <bqe@google.com>
> +R:=09Yury Norov <yury.norov@gmail.com>
> +S:=09Maintained
> +F:=09rust/kernel/bitmap.rs
> +
>  BITOPS API
>  M:=09Yury Norov <yury.norov@gmail.com>
>  R:=09Rasmus Villemoes <linux@rasmusvillemoes.dk>
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> new file mode 100644
> index 000000000000..28c11e400d1e
> --- /dev/null
> +++ b/rust/kernel/bitmap.rs
> @@ -0,0 +1,574 @@

[...]

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
> +    #[allow(clippy::len_without_is_empty)]

Using `expect` would be more idiomatic than `allow`.

> +    pub fn len(&self) -> usize {
> +        self.data.len()
> +    }
> +}
> +
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

The config name should be prefixed with `CONFIG_`.

> +        assert!($e, $($arg)*);

`$e` is not defined, it should be `$cond`.

> +    }
> +}
> +
> +macro_rules! bitmap_assert_return {
> +    ($cond:expr, $($arg:tt)+) =3D> {
> +        #[cfg(RUST_BITMAP_HARDENED)]
> +        assert!($e, $($arg)*);
> +
> +        #[cfg(not(RUST_BITMAP_HARDENED))]
> +        if !($cond) {
> +            pr_err!($($arg)*);
> +            return
> +        }
> +    }
> +}

Same for this macro.

[...]

> +    #[test]
> +    fn bitmap_set_clear_find() {
> +        let mut b =3D Bitmap::new(128, GFP_KERNEL).unwrap();
> +
> +        // Zero-initialized
> +        assert_eq!(None, b.next_bit(0));
> +        assert_eq!(Some(0), b.next_zero_bit(0));
> +        assert_eq!(None, b.last_bit());
> +
> +        b.set_bit(17);
> +
> +        assert_eq!(Some(17), b.next_bit(0));
> +        assert_eq!(Some(17), b.next_bit(17));
> +        assert_eq!(None, b.next_bit(18));
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
> +    #[cfg(not(RUST_BITMAP_HARDENED))]

Here as well, the config name should be `CONFIG_RUST_BITMAP_HARDENED`.

> +    #[test]
> +    fn bitmap_out_of_bounds() {
> +        let mut b =3D Bitmap::new(128, GFP_KERNEL).unwrap();
> +
> +        b.set_bit(2048);
> +        b.set_bit_atomic(2048);
> +        b.clear_bit(2048);
> +        b.clear_bit_atomic(2048);
> +        assert_eq!(None, b.next_bit(2048));
> +        assert_eq!(None, b.next_zero_bit(2048));
> +        assert_eq!(None, b.last_bit());
> +    }

[...]

> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 3fe9d7b945c4..3ca3c7dc4381 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -324,6 +324,16 @@ config LIST_HARDENED
>=20
>  =09  If unsure, say N.
>=20
> +config RUST_BITMAP_HARDENED
> +=09bool "Check integrity of linked list manipulation"

The description seems to have been copied from the previous menu entry.

> +=09depends on CONFIG_RUST

This needs to be `depends on RUST`, as Kconfig doesn't use the `CONFIG_`
prefix here.

> +=09help
> +=09  Enables additional assertions in the Rust Bitmap API to catch
> +=09  arguments that are not guaranteed to result in an immediate access
> +=09  fault.
> +
> +=09  If unsure, say N.
> +
>  config BUG_ON_DATA_CORRUPTION
>  =09bool "Trigger a BUG when data corruption is detected"
>  =09select LIST_HARDENED
> --
> 2.49.0.1204.g71687c7c1d-goog

Cheers,
Pekka
