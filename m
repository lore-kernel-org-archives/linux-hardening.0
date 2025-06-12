Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBE156F45
	for <linux-hardening@vger.kernel.org>; Thu, 12 Jun 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719091; cv=none; b=GzNSyoalGW4zYaZeXel5Mq5qN+9HtuLGjrsU0maFHT377fKmZsuI98HPjZH9u5bnoss5ZNGaC0mpuskJh+2ZsRQ/ySIpSmmnL5bvApU7wySK3SKb7ft6a30yjW+j1hpt1Uk1ZE/p5Y8fMUjeN0KeYMwz5vbxDuLU/l4Vd34Aiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719091; c=relaxed/simple;
	bh=E/G+Ma5c3HEoZ6V6jEkOVbUqt0oOEDS4ehHgrAzVM4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDCscjvY0t4JrltsvWp8BQm+yXgpvB3ZwLMahe2LNdm8e/dOZYtbQQ332jaRfYrt8/z8m92NAcWBRXdenmztzRV5rC1UJVwGPHTpzXIdFJ1OBtgmavs8ZNMcJfF7qbkaYA8jfLC5capcGtV0X/O/Zu/+PhV2FynfMqJ6EiSqSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WGlv/8qM; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGlv/8qM"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2d4f8c42f49so995321fac.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jun 2025 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749719089; x=1750323889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCmVasf54FJSfgyjNqYu9/T4YHBXvjWI8frtIJ+EEeM=;
        b=WGlv/8qMQK/odOh2tFnkafU2uzWyqFvjPJUgkbK1PcArl45x+x1fabFIDN4SIhjMoI
         4LKGdeub4EQr/MVr/XUGrPTH2VMP/IGIY98U39mJy4BjInU3hHicvMZE97KFCvAvRv3W
         KQydLA9WT5uspZ/Asv3ctKdSo5PmM+sNAtwyCkPuePF5slICQX1k1WJd+U+s2mNcM0Ff
         qJ1w2I20ioqZgsHVMdpnSN7JbCYTbnMIb9MrsZWsYQV24uyd0ASK1uKxTWU9ZcDIdwFe
         +HCd3JwJVpULXkDb+Kbx6VFLIDQCw8Z8RptC3dkxto2ZB78Mno4UZiYjwUGidIbGOcnG
         v76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749719089; x=1750323889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCmVasf54FJSfgyjNqYu9/T4YHBXvjWI8frtIJ+EEeM=;
        b=n2HiCMmBBmX/sT8PuaDwtY0s8vhEAKA9h8ueA8i1bJbwDcaYeTOWdt91zM9kwqZ4tR
         Ot2WuYQFELodsN0v+oFyb2APdGWM7JKY7rGo8HWByBjHF86KoQ1Z6WllgrsuUx+RlAV2
         uVH3mgu1fVEnUdStjXKBoCxdzfomYW0OQ93UfteK/m0Dw4/7mAiRbBMgaoKaEInyiZvw
         7oXZgLZXz/sSYM8UzFdb2AxfPA6nVB2L/YLWaz4LjcVneHj/p6tgCEXcmQF2YGPePa8k
         qwoU8NZRJeWsHZNw1PpRKbpR/Wbq53QXUM6M/PwsiCYg7bJgIHXo+YSiBoLBgq3KziHX
         tK8A==
X-Forwarded-Encrypted: i=1; AJvYcCWeNIC/UH1iXAvZy+LQb2T0sA8+07INp6OrduPAgr72AXdm9lfafFK5CN0YwLQrlJ5DU6426r4OnLiah4L85U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNuZNSkh8kO7UK7AbxZa34N9hbKYxS0VGUMb6BWlw62eV2N0pJ
	Ek/edytCf0UvEE2ndgrgh4hvn9VWkdntI5dsthnUCKYNqBa9qx+RHGOykgvTt0EMxr/bQqL5fr1
	AKhVMt1hJLNAJamnMzZW76VS7rflkQaitSSe74XZH
X-Gm-Gg: ASbGncs8ai/0j7YHDpoo2VC+yait0SXMdF7Ssttk79PxUOA75yrE/EB59Mj/V6TZPIA
	kG/451ujSbhiNNUjvRhYVlzefv5r2wUMxzXkGpncCN6Zga/vRQAwzVIyzWIr29O44BT0ujKjqZ4
	jUsoD8fnhNW1B5+wtf0S9COvo0BxmUJTIZIx7ZUPhlHTywsLMFyG1Uh796EnVEft6nEu9b3UZMR
	Q==
X-Google-Smtp-Source: AGHT+IGsCe0eHuSCDp/ZATxEgcLgpmzOAzhfbi7k6bUdPkZ8Iaa0NcKwebiu9Q1dLW5iD7RCwdbjitcdPo1Ghda45so=
X-Received: by 2002:a05:6871:4f17:b0:2e4:9c8e:f59c with SMTP id
 586e51a60fabf-2eab440444fmr1039305fac.19.1749719088810; Thu, 12 Jun 2025
 02:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194840.877308-1-bqe@google.com> <20250611194840.877308-4-bqe@google.com>
 <CAH5fLgi1GBqDHvMh30fbxVUjnTETLXthpK6eGLJA0Vh_TZRnsQ@mail.gmail.com>
 <CACQBu=W4PziG3Fsnzqu_wu-vgBThktD7FcEJ-vOhOMhNDz8h3g@mail.gmail.com> <CAH5fLghV4gYWMyscY2y+TwwqMW_497Sg0sj_HuzNH4nB_5u6Bg@mail.gmail.com>
In-Reply-To: <CAH5fLghV4gYWMyscY2y+TwwqMW_497Sg0sj_HuzNH4nB_5u6Bg@mail.gmail.com>
From: Burak Emir <bqe@google.com>
Date: Thu, 12 Jun 2025 11:04:36 +0200
X-Gm-Features: AX0GCFvLFjwTkqL9rBhxwG-_dzXGQXfs8fCOFdjNJbl3SinDaFDMM4vufd5kjD0
Message-ID: <CACQBu=WiFs=6K78EuTOhe6HR39uXr8ZEKCz=MVNwKoxOV+F+iQ@mail.gmail.com>
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

On Thu, Jun 12, 2025 at 10:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Thu, Jun 12, 2025 at 10:47=E2=80=AFAM Burak Emir <bqe@google.com> wrot=
e:
> >
> > On Wed, Jun 11, 2025 at 11:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.c=
om> wrote:
> > >
> > > On Wed, Jun 11, 2025 at 9:48=E2=80=AFPM Burak Emir <bqe@google.com> w=
rote:
> > [...]
> > > > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > > > new file mode 100644
> > > > index 000000000000..1fe72ca980ac
> > > > --- /dev/null
> > > > +++ b/rust/kernel/bitmap.rs
> > > > @@ -0,0 +1,582 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +// Copyright (C) 2025 Google LLC.
> > > > +
> > > > +//! Rust API for bitmap.
> > > > +//!
> > > > +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bi=
tmap.h).
> > > > +
> > > > +use crate::alloc::{AllocError, Flags};
> > > > +use crate::bindings;
> > > > +#[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> > > > +use crate::pr_err;
> > > > +use core::ptr::NonNull;
> > > > +
> > > > +/// Represents a C bitmap. Wraps underlying C bitmap API.
> > > > +///
> > > > +/// # Invariants
> > > > +///
> > > > +/// Must reference a `[c_ulong]` long enough to fit `data.len()` b=
its.
> > > > +#[cfg_attr(CONFIG_64BIT, repr(align(8)))]
> > > > +#[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
> > > > +pub struct CBitmap {
> > > > +    data: [()],
> > > > +}
> > >
> > > I wonder if we should just call this type Bitmap?
> > >
> >
> > OK. I am renaming the other type to OwnedBitmap then.
>
> Just thinking a bit more about naming ... how about calling it
> BitmapVec? Rust generally uses the terminology "Vec" to refer to
> arrays whose size is not known at compile-time, and "Array" when the
> size is known. Then, if we eventually add another type for declaring
> fixed-size bitmaps in Rust, that type can be BitmapArray (that's the
> type you'll want in a global).

It sounds good, better than OwnedBitmap.

My only hesitation is that BitmapVec does not support growing (or realloc).
On the other hand, we could support that in the future so it still makes se=
nse.

cheers,
Burak
