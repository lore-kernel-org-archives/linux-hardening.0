Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE81ACEAF
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748869923; cv=none; b=Qu7sCalRfviK7MVAFy1dog52SZE8aIfe5j1SW0MhpqGbmSlIHcjwdSmCeqeeFK55RrEbDgEBy/rsOREhYfuJOgGJjL0XJvWQ4cFQg/bsBlSqw4GWE5YKka/YPO9Nw4YKNTyyiVuUTzkAe5rWYoumTFF+N4OoYyt6cKRbDE1boRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748869923; c=relaxed/simple;
	bh=CX/1iDHPVy0wwNWQINXFXHbW7tkxcP7a0WOFWuDfRgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9VbpbKcINot5lv+7COW+ZDNiPR+JmU6AbE1KJOwYnCxvhJa++YUohMaE0r5vCTfC07ePpoM08sTx0ZsMnx1ToIteZQPxPfeT4DqN3t3PrWTazwSWCo/9Gev6BEUhxkdoLVX7yt2NIvDD0SwwQqlRu8WH45fd0+izm7IiPCRDck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FKGNOYzF; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKGNOYzF"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2da3c572a0bso2221560fac.3
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748869921; x=1749474721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX/1iDHPVy0wwNWQINXFXHbW7tkxcP7a0WOFWuDfRgY=;
        b=FKGNOYzFxWSD8eO+5/EEi2aq04AxbBY0foZDHshun7bGXVSRUaOgkBLNgzi8dBSeVv
         duXUyiEcGz1iR8wMFkM8QLP6vOSWakVhlM1ay7dotKKYmIp+II3l4CmNqC6wWEhnMZaJ
         KGBE+cgGcb+GWYstbLV2rDN2rpBJkK9Mrvp72rmL7g7T7KIAb+KXsB4RQV8C4JGFB6zq
         BYgHheyywqyGTR6cftiNW9ASpTyPMLgB0FaFy0mkQ9U9u2tqjZLEUWX0SfguWkdsNf8/
         +KJAQt4hMYvcYyv8A7sA3hWUasFYFsf8cIEK4s/GNBxzwJjeylppS2FTQsokB3WDvC57
         c6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748869921; x=1749474721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CX/1iDHPVy0wwNWQINXFXHbW7tkxcP7a0WOFWuDfRgY=;
        b=Wz81c6dz77XP4YiqkXVM3kupB5CXlsUoW1tWD+kmtxPzFS2ar0j/eAzpVczSblSyy2
         pDnh0g9yMJ3PJ6g/fUs7dncSngOGxPwhoh5+1jz3GLGW53wqnpMrJ7+JnVPiaJbJzCyp
         PBKEPsHNh7qKR/FQzxduXk7Uw05/b8XqGLLCGM3AHBR19gjyom5W3BMHV5w4zo/qGynd
         dcCcasygmzs4HUX9ZLs/vIK3CgmtB+EJwCt79ikT35s8fZ7/E2GEdHW+5h3RemtnNd5W
         hOQarS/zyIhLMXSiIsnoy168AhWMFD0D6srE4OysyUmqQaZHjF5PTFgpVGHk9/yCl4hi
         6Zzg==
X-Forwarded-Encrypted: i=1; AJvYcCXOOtEpEFiO40YjzCUApJQZOPfQkrVOwGfeZX7PU/sDPe7jDkPhT1Nrsd6FZr2vl3hn/kyBi+NA9O2jaxi2iWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHeJSq9Yq0920K/acv6hByZTKIiK6ac7S725GTJmTfEuZl/Hn3
	NYNRVBnct48pMjs7YfnsdXX4HOXzwYkH/anT37+XbMoXhyW+w8Nmq8yy94oBxzfaEvL0uvuhiav
	iQTgXcEryVPYc1CAmYRu+ZlD7sznlNDE+jDXe2eEW
X-Gm-Gg: ASbGnctr3oBCQkPvklaWj1+xhyO7qWK0Zx0XcrXHbANrxhENfbmseZf8ckfi+YwkXSE
	LvWA5xgJGqwboXfgvb17FtTeMadpKsdg/1KIk9bPJN18yJ+i5svJh4V76zYNW9AWtHsMw+/Xru4
	EjABaeGRgN4YpsFNIhhwUb/F4NCoFKN1X7mJMyPhaztcxHKhvvD9dmKTbUzOn/LxqBPVjv0xDm7
	g==
X-Google-Smtp-Source: AGHT+IEK3NdAWPeTFVYBHSzHkCcveg60NzsP17so1/Ky5+fflhuk++j9utkshWE8HYwfmNNUeec1s+X9NdKXYBaSM/4=
X-Received: by 2002:a05:6871:7288:b0:2e4:140:4b1f with SMTP id
 586e51a60fabf-2e9212bf665mr7498721fac.17.1748869921028; Mon, 02 Jun 2025
 06:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526150141.3407433-1-bqe@google.com> <20250526150141.3407433-3-bqe@google.com>
 <6835eaa4.c80a0220.2baf57.d14b@mx.google.com>
In-Reply-To: <6835eaa4.c80a0220.2baf57.d14b@mx.google.com>
From: Burak Emir <bqe@google.com>
Date: Mon, 2 Jun 2025 15:11:48 +0200
X-Gm-Features: AX0GCFtdTIfbdTAKN2zMtULvGWz-LoXbR6AP_RXTCxaczWNvuvasR0DxMgkYtdo
Message-ID: <CACQBu=XJ+21amU2tEkDYFO00RWt8PvOXsU173ZO_y3u9xmWUHw@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] rust: add bindings for bitops.h
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 6:39=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, May 26, 2025 at 03:01:31PM +0000, Burak Emir wrote:
> > --- /dev/null
> > +++ b/rust/helpers/bitops.c
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bitops.h>
> > +
> > +void rust_helper___set_bit(unsigned int nr, unsigned long *addr)
>
> Why "unsigned int" instead of "unsigned long"? The C API uses
> "unsigned long" and in the Rust API, you uses "usize" for `nbits` and
> `index`s, therefore using "unsigned int" only introduces unnecessary "as
> u32" casting IMO, am I missing something here?

This is certainly a bit confusing to me.

As Jann points out here [1] the expand to asm macros arch___set_bit,
where `nr` is indeed unsigned long.

There is also the constraint that a bitmap's length must be shorter
than INT32_MAX bits, but that does not matter.

Being consistent with the C API, including parameter names, is what we
should do, so fixing this.
I found the underlying C API is just hard to find for these macros.
Thanks for catching.

cheers
- Burak

[1] https://lore.kernel.org/rust-for-linux/CAG48ez1NM7B8Vk7GOwhsitCipmfHi9e=
K6JNb3ve8aR4m8Cj0gA@mail.gmail.com/
