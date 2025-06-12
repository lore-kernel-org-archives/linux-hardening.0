Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF1B223DCC
	for <linux-hardening@vger.kernel.org>; Thu, 12 Jun 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718201; cv=none; b=jYxV8Iv1pZlwiOdFWSqkFQqw5Is+258ys+kG4PEnQORCF2G7K55GWf3X4z5wiATfwNGZ1WdNRbrPUKdD4FzNwMXfMVZhOMdV3vxFuFd7tF4Q3VHR6ZCyAOsGVHWrYXuSWSfH8/gBr72TkmZKDRxvYrW1uWlgBdEmmHg+EpbdPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718201; c=relaxed/simple;
	bh=Tz31FWc8ZSU6ldYx49dpHsfPC5cmR3+X/nnw+nZkGvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEehwZb2BfTXjy2nsO2fn51QwTfIORVCvI7PmnKmrz4uKBMZnvUruvUM+lTeuY1HGFcwZQFgGUwBnt8xTfQqbrLD32pXvm+tjTOsMp8ydMZq0m3hvmY/OXKh1UbYrjev7en+KdH6KrHxFdN+U86oJ7Mlc0t+RCZMujL4P4HjNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGDmFSSC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGDmFSSC"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso461351f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jun 2025 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749718197; x=1750322997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuVAAh36fkRqoU5+WrRN9V7KcWrda8Rt/Pe6BIRVzcs=;
        b=JGDmFSSCSzqgimlwTAhwIlay4LeQ/ypez+MZ8tzllXwICqZT8KKb5jfVv0XwI5K+t5
         POFQ24In6PA05H0BCeMTUAtwZP7d/kzTI+5SC5vwFFUyRC+M4chQ92hIOUb/M8H0qFwR
         dUT2a8vo2Z5fQ0LjlKyfMOIndQbhxXHC3ZC7Z5ljBzgWaDCVYN2l2LYYgHyvdSmNsoEO
         kq2nLjhVD4LmgwRxGqa363MQOoE/8gp5wDcn01TijMxKJ5b9PNyCUuUrYp1D4V5pOYI+
         Mg/7Fx7kQZm+fHL6ZN6fKS5BcoKV7xTbjsgwOnrCcmhWt0jsTYjw+Nty66grcZxuMRBw
         n8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749718197; x=1750322997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuVAAh36fkRqoU5+WrRN9V7KcWrda8Rt/Pe6BIRVzcs=;
        b=TqiZ5aXpN8M4ZUdGm8j5FNltgLPiS5DBoH91MFLaPcbtyGZozbgFx8sI/eHhR1rTGU
         2JhZ7RFbdlvU+iJ8BfLkCRzILUa/4bynRoflHdp7cs3W3DOt7rlXoyfCXXyKWW7d6FK+
         zdUNVOXeQ/Svae7ecL19yc7hJ3Ui9tZj7nNwzgQWFyUYJb7XevwIvKRgSoskwPVUMdEZ
         mBnepYFEThvVUWPkzcFDToOfRLmfx3CaVOx9xgeD9TaOEho7o5lwBF4MCPS9yCMHOrs7
         KLM8yWpZhu2/jZF0QGoYCVlcQ6mbswshGHO/kr+myzokPyYySUriJJHVdzy1S5jmm+Uu
         wu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwe1UhjAi7fzVoeKlo942HsYKTgmac9Ym03skV3cdZKer3L4yqb7r+W76zJORXZ92wnktJAdtUoXkDPtivO5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEsD11lN/w8J7yiwQlHctUol01mgOt4qeiqy2tw9Ow7/cHgS0h
	UJPcyjbLFqFzQv+2WJtddf7+7+rhgSMEFOOgOzTgvJGszB7pobKI6sYCTbGR0BQpKj0kgjzHLrO
	DlGWlgMu5DZc92OfZDlol6SNNTpVfui+c3MhXeWk6
X-Gm-Gg: ASbGnctoD6eL/Xxlpy8DsIiTqqtoqnfPgbAu23+fJM0CVla+Y6Uldk4IcAhtyE8PbnG
	sARnNFcAbF/nWhBP+Q2QJvrtj0r7WVp3VLDXlqm1xji9cwtCfpYiVIKd14c/H2unPjTkL+16BTZ
	rvsMIrWOniHFpWrmFgAWeM2wwH8CLDBSGQXZWZhrjv9mKO5d3ly2ib7hfVKbe+6YsE0uBtonlHE
	jnFijeG76TH
X-Google-Smtp-Source: AGHT+IHm7NginZE5oMnjujYEo6jg+R4PPqVdxx630Yf+odjyFRxGpbvJieAtccV/DmBp6q1if19zXlSexyIS2kSKvgI=
X-Received: by 2002:a5d:64c9:0:b0:3a3:652d:1638 with SMTP id
 ffacd0b85a97d-3a5586e9619mr5350282f8f.48.1749718197373; Thu, 12 Jun 2025
 01:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194840.877308-1-bqe@google.com> <20250611194840.877308-4-bqe@google.com>
 <CAH5fLgi1GBqDHvMh30fbxVUjnTETLXthpK6eGLJA0Vh_TZRnsQ@mail.gmail.com> <CACQBu=W4PziG3Fsnzqu_wu-vgBThktD7FcEJ-vOhOMhNDz8h3g@mail.gmail.com>
In-Reply-To: <CACQBu=W4PziG3Fsnzqu_wu-vgBThktD7FcEJ-vOhOMhNDz8h3g@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 12 Jun 2025 10:49:45 +0200
X-Gm-Features: AX0GCFvPCLH4mUb2i-_l7Sq7OF8j6-HxDtqlJsvNUK2C-bZxtlXbyZ5Jsfy0DRU
Message-ID: <CAH5fLghV4gYWMyscY2y+TwwqMW_497Sg0sj_HuzNH4nB_5u6Bg@mail.gmail.com>
Subject: Re: [PATCH v12 3/5] rust: add bitmap API.
To: Burak Emir <bqe@google.com>
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

On Thu, Jun 12, 2025 at 10:47=E2=80=AFAM Burak Emir <bqe@google.com> wrote:
>
> On Wed, Jun 11, 2025 at 11:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > On Wed, Jun 11, 2025 at 9:48=E2=80=AFPM Burak Emir <bqe@google.com> wro=
te:
> [...]
> > > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > > new file mode 100644
> > > index 000000000000..1fe72ca980ac
> > > --- /dev/null
> > > +++ b/rust/kernel/bitmap.rs
> > > @@ -0,0 +1,582 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +// Copyright (C) 2025 Google LLC.
> > > +
> > > +//! Rust API for bitmap.
> > > +//!
> > > +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitm=
ap.h).
> > > +
> > > +use crate::alloc::{AllocError, Flags};
> > > +use crate::bindings;
> > > +#[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> > > +use crate::pr_err;
> > > +use core::ptr::NonNull;
> > > +
> > > +/// Represents a C bitmap. Wraps underlying C bitmap API.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// Must reference a `[c_ulong]` long enough to fit `data.len()` bit=
s.
> > > +#[cfg_attr(CONFIG_64BIT, repr(align(8)))]
> > > +#[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
> > > +pub struct CBitmap {
> > > +    data: [()],
> > > +}
> >
> > I wonder if we should just call this type Bitmap?
> >
>
> OK. I am renaming the other type to OwnedBitmap then.

Just thinking a bit more about naming ... how about calling it
BitmapVec? Rust generally uses the terminology "Vec" to refer to
arrays whose size is not known at compile-time, and "Array" when the
size is known. Then, if we eventually add another type for declaring
fixed-size bitmaps in Rust, that type can be BitmapArray (that's the
type you'll want in a global).

Alice
