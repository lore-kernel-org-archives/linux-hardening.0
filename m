Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06C229B16;
	Mon,  2 Jun 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875493; cv=none; b=gOqno4Tcw5hbSw0Z8RShhR4ZBZ9Ol0i2mTuoKTlP97TEZRLgxP1GuS3VPx7omt1M6ALeL8ElIQLFrHtokTFMa/IiRh/2DDAJT8CUzt6cmedVf4ahnwLAVGqTwkAp2dsyoi1qYfZo2x2yS9srimKAPR/b55/0c/HdOALsZms/jeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875493; c=relaxed/simple;
	bh=jSvHY/i9wEUbIaNH6yIcqYLtUbQfSWmdbAEqoNOUres=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iq6/A2F978VqIv5HP/PL3g0th5l1BMrDZAAteOVWtGwJbkTrkDuSQhGGO/ksaQTm8ryac5u2VVewYR0Wa/EkWrwYg3pDMihvfCL7xoiGLruG7j94REOLBDNcYQSIltIDC2akRS3ylgjiURlmVh63sRDFKg1Q02Cxplb/UvmWc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdheS4wv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdheS4wv"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b16c64b8cbcso462473a12.3;
        Mon, 02 Jun 2025 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748875492; x=1749480292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSvHY/i9wEUbIaNH6yIcqYLtUbQfSWmdbAEqoNOUres=;
        b=MdheS4wvfE9j9D8BOWyyXbz4cJMM1x/wvCwlYMERT9nULI4Qy6IzZGWUjYlA7ma5mo
         V0pBHLkbLYTKPpgAQjrPOyWcFvc1D0ZIi5MUhs4AuHgX9K/nPEQCnnrqnoGac4Tk14Zr
         X6qxjGyoe59Wq7/anf0ZZM2lIJvHz27cKm3mOdiceQIOBCsETljzfOlwZDfDxQBPGrjl
         QeIABRZ0SDFWZcW5vKj/4tC39pITGIWqutzaGIrq/jA4ZCCCECmDkz8muHadEd7+4TNB
         e/RxuXEmThixH3C82+5Aom5IAEeMc92cwcme/9eHb/1YmOh0p+3/fgV2i6eNqCFmXT6h
         OWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875492; x=1749480292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSvHY/i9wEUbIaNH6yIcqYLtUbQfSWmdbAEqoNOUres=;
        b=g/R8eWrZgf+F5E2tMbQzfjkordslNkulpX50AqDOhGjGdfoiX1mWxmvPMTFAsW0no4
         agwY12LTEiAPSI2LhBo5e6txNlSRtAX1iMaxOH6duYkgbA4a94hn9O/ZS51WZe3rq4o6
         WA6AmKj86kjQXk1K89GXPwoUEx3B/BvwXjZtun4O1A4nAU0Y+SC9KSMaAfA7oTvfXClb
         lKFNPIkdcmH2YJ+jUxoywZ803T975VM6hYC82m0s0UoSv//8UNrDJzB31aHevL6uNnss
         uQnTWpoVuq0N5iHlm++A1VRXKR8r3yIAOOt8R7CSQ/v+y+sQFBu18Iqrpk5uHaMz4Yl2
         xHXA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Iw2UJihaTIImnt38rg/bOKqFyb1s1XR6iEgG2u5sXmNgRGwJzrt+qCSGzeq/if2acKDzT8sNlOdcclgR@vger.kernel.org, AJvYcCW8GpQ8FP32KFCI1BfJMViovdn+E3stVdIccbhdECZi7Hfq4vo3lJnh39uj2yZqEoK2Fr1L5E8nlBAMYAAdQQU=@vger.kernel.org, AJvYcCWbIgL4SZHC3iJ3OLs8CS+u6+HHBT5UY1Pc/nODEfH0BrCVZXsOXH5NbSxweuofahGTCfDpPLCMkXQF5ML+ixY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7B48ddNc7ZwI7ldr8k+PUAorRtKXTYMQbCuf+nl1cRXL9FjgA
	qmmE1y+0xjKzR5ybttsJ6oYg1hanl4zbBZVfpDyWKevaslb7gztrwoSSmSu+mpDqL/5ppioZ85p
	i9bWRrqHb0OoJ+PIeMw6A6jdVxRSn3fs=
X-Gm-Gg: ASbGncuoxvOayQH4cJ7ytkJ/I2TFXf9cMlC7UOanojfanKhHK3uCjhMRcy30bk168bA
	cbQrfzIzw0PVPGeoOzzq5QEetKaUxY1TtYkTb+G/vgW261l6mV1ca8gmZhtMZiZ8GX2/sHjf8F1
	KvDHqSTaQx4G6fuQ8g7skjsTw7GUh/Mlq+
X-Google-Smtp-Source: AGHT+IFvBpHreqj20x7/UKsZDEN6zgCxt+bJaSe71NQ1Ky0ZfUsdJH2lN+Zi0j9OlW+A9XZ+6wei/QevbLQY/sL+UGI=
X-Received: by 2002:a17:90b:4f4d:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-31241849819mr8385278a91.4.1748875491587; Mon, 02 Jun 2025
 07:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602133653.1606388-1-bqe@google.com> <20250602133653.1606388-5-bqe@google.com>
 <aD2118mMOs8CZyGa@yury>
In-Reply-To: <aD2118mMOs8CZyGa@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Jun 2025 16:44:38 +0200
X-Gm-Features: AX0GCFutabTiVIbZhB05ZjbsqalKvGcsfDqJNzy2av3u6PaYBZk25GvRzCdeIco
Message-ID: <CANiq72k7wnHsd6jrckkZtRpwbTPE+5ikbCw=_RexuRvwBSp-Rg@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] rust: add find_bit_benchmark_rust module.
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 4:32=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> > +const BITMAP_LEN: usize =3D 4096 * 8 * 10;
> > +// Reciprocal of the fraction of bits that are set in sparse bitmap.
> > +const SPARSENESS: usize =3D 500;
>
> Is there any simple mechanism to keep C and rust sizes synced? (If no,
> not a big deal to redefine them.)

One may pick them from C (possibly with a `RUST_HELPER_*` if needed).
If they are non-trivial macros, then using an `enum` instead of a
`#define` on the C side is also an alternative.

> What is the name policy for rust? Maybe a more human-readable name
> would work better here?

Up to the maintainers, and generally the same as for C. In the global
Rust samples and things like that we have `rust` in the name since
they are Rust samples after all, but there is no need to say `rust` or
`module` in actual modules etc. unless there is a reason for it.

I hope that helps!

Cheers,
Miguel
