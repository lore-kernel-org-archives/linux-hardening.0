Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5441BA4A
	for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687332; cv=none; b=sOWnvZHuVNutupCcNb9O9lu2sWTledWC8EdZp20sVOMI/DTSXMPa23WLDUjTVRyT3k8AmSaTMFsMHKFs7TbaCpDrG3oUiAfxQrNE32ZionZDM1V8ziCvmJekdHBnnmw/YjFxU1KAYK2ZshX6hQPwfQcq/3Gh18FA+WEUUtyDc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687332; c=relaxed/simple;
	bh=UDpbbmEtEItWgXwx0k7kmBGNbLnfd/xF5NbFAMWRqz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlZCyGPNv+PjQHCtnTh5G4YvX7oEx3g8JARM3mUV+vuv1YD2ZV2O1Th58J663a1MHBlTp5QA36RnpiqrVCT4PrlgLTGTKgzT6StUcb7pxDvT+i/1mg9klQRouDAMIpMYJzvuQi8/qPDBC4UBlaAnGZmm6bXZEMmnSJSeIS2sPUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNbsJH9A; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNbsJH9A"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-604ad6c4cf1so1923695eaf.3
        for <linux-hardening@vger.kernel.org>; Mon, 19 May 2025 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747687330; x=1748292130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpTiBmBKTL1rbg6kI5UaNIrIgmA9vD0yyELs03GrkfM=;
        b=UNbsJH9AMmp6iI8z+tvo3vsCM4gIZHis/C5cVgQF7fRKN4MkE9SIX5Pw0mXQ8d2CLW
         Ybz7bQevZl89bzTk/1J1IINzE6dwKv00u9VzKLQtAVFYiI53X/97AreQgvLrz/mkFE4F
         f1xCAw9NdSMPAhajYQg2lpul7Nz36AitvwPcENO8xPoGJXw0k/TtTZatiUCnP6dQgPeg
         GAQbxNr81r7+mg8Fvlw1WctGGXP6RhrOzlp4n/Jc0fqO3nax0pVr8/xxkDt+gYvSRYRh
         L5i/HK6+u2p/1ZiFC54lHPHwRg82tj18mM4Dxrrs73wy6yh+i555zluV18BsJTcbujEl
         ReUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687330; x=1748292130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpTiBmBKTL1rbg6kI5UaNIrIgmA9vD0yyELs03GrkfM=;
        b=oG71xrwlirk7FXT5+DDGJL7HAyGFmBU349qcbC0M2IeJui0p1MEz6ySjQRgCZ0VgQQ
         Z9iOMjapKyUSaBAl8M94RyMAGMBCysVUabYqnumR/9LfaYfrzsEAT5rPP2Fgof5c6tm/
         eA67yRv0YNFrC6MLEWH/JmBhuUkTBk5mfWh3udIrNL+4s6JXyld0sVqkPR2FUvuYvarp
         IXnNK3Zf6QWKJr9m5ismAuL7TQz9wNiJN4Uy44udiONvgsvI9FAxQsEY4xtKSF5MEbSr
         gkr8WslGJBJyWBxyH5RMk9XfL3LiMQlKLs3U4u/RXPGJfUfUm6qgDk8dLJtk2gZdhcM3
         Jm0g==
X-Forwarded-Encrypted: i=1; AJvYcCXlgKxADgXJhIX3762z8gA14r8WUCK60h0kWSnQPG0LWCWr816ulnEIk3DzTAoiYZFekLnYT+GpGxBPaDlntik=@vger.kernel.org
X-Gm-Message-State: AOJu0YysJ3lw5WJjlaTnFDnU1e8UVxNhpQax1Na4XSaxIgmQuQeuYkNB
	KtZNmvpEqEuaeKAYj67WKwzrmQ48/E/svJ2ACqiB+kJDwq5RRy1TbHbSTFK5Ee5qilPlIbCJLwM
	eA8hT54nPGeJ8LQfMhdwtf3hbxl0l9jRe8uDd29gC
X-Gm-Gg: ASbGncvOJ1gdJrgz06QaMGkmT4dKCSaEhNYvMllrQM2eRP2O7us+n/yhOj38tfetysY
	6uPFM+qsFf64Cp3JvP5pxBfZQDxAv+r4o+dWK7VJDMsyVDw/gx1YSc8HiwH7azQNYNcALmFl3hl
	sPBs+ZgJEUtI40Ji6K2w3uZEVW8o4rEOOBzEwNAe5zu+W7ER5RFguvCh7fKc1S
X-Google-Smtp-Source: AGHT+IGESm+Tyk3fWg7lOrKcTbzDjR8/NYHdVH9vgK1tLDaJ0wiKNbTH7dO2RzQfY7Uy2iqNZwXjKBWk6x3MUcNdISI=
X-Received: by 2002:a05:6870:ce8b:b0:2d6:2a40:fb9d with SMTP id
 586e51a60fabf-2e3c854d9b0mr8018386fac.28.1747687329513; Mon, 19 May 2025
 13:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-4-bqe@google.com>
 <aCt23djKOzUiP9L4@yury>
In-Reply-To: <aCt23djKOzUiP9L4@yury>
From: Burak Emir <bqe@google.com>
Date: Mon, 19 May 2025 22:41:58 +0200
X-Gm-Features: AX0GCFuDdt4NJiIVN6JghNmRgeUp05GeBXxHrcS0rOd1Ewavb2qjDzy6zpTj8og
Message-ID: <CACQBu=XQ9QrHwzfXZiJf6-uSLTucpr2k=BwRhrDCkVA3wX7-ug@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] rust: add bitmap API.
To: Yury Norov <yury.norov@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 8:22=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Mon, May 19, 2025 at 04:17:03PM +0000, Burak Emir wrote:
> > Provides an abstraction for C bitmap API and bitops operations.
> > We follow the C Bitmap API closely in naming and semantics, with
> > a few differences that take advantage of Rust language facilities
> > and idioms:
> >
> >   * We leverage Rust type system guarantees as follows:
> >
> >     * Ownership transfer of a Bitmap is restricted so that it cannot
> >     be passed between threads (does not implement `Send`).
>
> Can you explain why you decided to not implement it? You can 'share' a
> reference, but prohibit 'sending' it...
>

My intention here was to be conservative. It seems safe to send a
Bitmap to a different thread,
in the sense that it would not cause data races.

Maybe it would be better to commit now to keep Bitmap "send"able - for all =
time.
It would however constrain the API quite a bit. One could never use this AP=
I
with a thread-local bitmap.

> >     * all (non-atomic) mutating operations require a &mut reference whi=
ch
> >     amounts to exclusive access.
> >
> >     * It is permissible to pass shared references &Bitmap between
> >     threads, and we expose atomic operations through interior mutabilit=
y.
> >     Since these atomic operations do not provide any ordering guarantee=
s,
> >     we mark these as `unsafe`. Anyone who calls the atomic methods need=
s
> >     to document that the lack of ordering is safe.
> >
> >   * The Rust API offers `{set,clear}_bit` vs `{set,clear}_bit_atomic`,
> >     which is different from the C naming convention (set_bit vs __set_b=
it).
> >
> >   * we include enough operations for the API to be useful, but not all
> >     operations are exposed yet in order to avoid dead code. This commit
>
> This sentence and the following one say the same thing. Can you please
> rephrase?

Thanks for catching that, will do.

> >     includes enough to enable a Rust implementation of an Android Binde=
r
> >     data structure that was introduced in commit 15d9da3f818c ("binder:
> >     use bitmap for faster descriptor lookup"), which can be found in
> >     drivers/android/dbitmap.h. We need this in order to upstream the Ru=
st
> >     port of Android Binder driver.
> >
> >   * We follow the C API closely and fine-grained approach to safety:
> >
> >     * Low-level bit-ops methods get a safe API with bounds checks.
> >
> >     * methods correspond to find_* C methods tolerate out-of-bounds
> >     arguments. Since these are already safe we the same behavior, and
> >     return results using `Option` types to represent "not found".
>
> Nit: the above 2 lines look misaligned. Everywhere else you align
> items such that new lines under asterisk align with the first
> character, not the asterisk itself.

Yes, will fix.

> >
> >   * the Rust API is optimized to represent the bitmap inline if it woul=
d
> >     take the space of a pointer. This saves allocations which is
>
> s/take the space of/fits into/
>
> >     relevant in the Binder use case.
> >
> >   * Bounds checks where out-of-bounds values would not result in
> >     immediate access faults are configured via a RUST_BITMAP_HARDENED
> >     config.
> >
> > The underlying C bitmap is *not* exposed, and must never be exposed
> > (except in tests). Exposing the representation would lose all static
> > guarantees, and moreover would prevent the optimized representation of
> > short bitmaps.
>
> Does it mean that all existing kernel bitmaps declared in C are not
> accessible in Rust as well?

At the moment, we do not permit construction of a Rust Bitmap from an
existing C bitmap.
The point is more about the other direction though, not being able to
pass the Rust-owned bitmap to C code.

One could think of an API that requires an exclusively owned (no one
else has access) pointer to a C bitmap to Rust.
Though there is no general way to ensure that property, there are
situations where it would make sense (e.g. newly created).

> > An alternative route of vendoring an existing Rust bitmap package was
> > considered but suboptimal overall. Reusing the C implementation is
> > preferable for a basic data structure like bitmaps. It enables Rust
> > code to be a lot more similar and predictable with respect to C code
> > that uses the same data structures and enables the use of code that
> > has been tried-and-tested in the kernel, with the same performance
> > characteristics whenever possible.
>
> This should go in cover letter as well. Did you run any performance
> tests against the native bitmaps?

ok, I will mention it there. I have not run this against the Rust native bi=
tmap.
I'd need to find out how to get a Rust native bitmap into kernel Rust code.

[...]

> > +    /// Set bit with index `index`.
> > +    ///
> > +    /// ATTENTION: `set_bit` is non-atomic, which differs from the nam=
ing
> > +    /// convention in C code. The corresponding C function is `__set_b=
it`.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `index` is greater than or equal to `self.nbits`.
> > +    #[inline]
> > +    pub fn set_bit(&mut self, index: usize) {
> > +        assert!(
> > +            index < self.nbits,
> > +            "Bit `index` must be < {}, was {}",
> > +            self.nbits,
> > +            index
> > +        );
>
> Shouldn't this assertion be protected with hardening too? I already
> said that: panicking on  out-of-boundary access with hardening
> disabled is a wrong way to go.

I considered it, but could not convince myself that __set_bit etc are
actually always safe.
For the methods that have the hardening assert, I was sure, but for
this one, not.

Are all bit ops guaranteed to handle out-of-bounds gracefully?

> Can you turn your bitmap_hardening_assert() to just bitmap_assert(),
> which panics only if hardening is enabled, and otherwise just prints
> error with pr_err()?

If there is no risk of undefined behavior, then I agree that checking
bounds is hardening.
If a missing bounds check loses safety, we then we should not skip it.

> Did you measure performance impact of hardening? Are those numbers in
> cover letter collected with hardening enabled or disabled? If
> performance impact is measurable, it should be mentioned in config
> description.

The hardening was enabled and it crossed my mind to mention it.
Given that not all methods have hardening, I though it might be misleading.

I'll have a more complete comparision and description in the next version.

[...]

> > +    /// Clear `index` bit, atomically.
> > +    ///
> > +    /// ATTENTION: The naming convention differs from C, where the cor=
responding
> > +    /// function is called `clear_bit`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// This is a relaxed atomic operation (no implied memory barriers=
, no
> > +    /// ordering guarantees). The caller must ensure that this is safe=
, as
>
> Memory barriers is an implementation of 'ordering guarantees', so all
> this sounds tautology.
>

ok, i will remove one of them.

[...]
> > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > index 3fe9d7b945c4..926665bbc8f2 100644
> > --- a/security/Kconfig.hardening
> > +++ b/security/Kconfig.hardening
> > @@ -324,6 +324,15 @@ config LIST_HARDENED
> >
> >         If unsure, say N.
> >
> > +config RUST_BITMAP_HARDENED
> > +     bool "Check integrity of linked list manipulation"
>
> Wah?

oh, thanks for catching that.

Thanks,
Burak
