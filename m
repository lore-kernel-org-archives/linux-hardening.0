Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD81AA1D9
	for <linux-hardening@vger.kernel.org>; Wed, 11 Jun 2025 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662681; cv=none; b=cH1LDbISzn6WRiD/BL+bvXLfF4dmnfC+nt5va+jkaJl9O9T4NUijiscLr9eUTc3rF/Zg1tx+AyMPJopcSrsjl4yf3yegvisEZetqebKPU5a7eLi45V4Xmw7ec8JjkdciauuqVycfNpWInzaoG34gpPerfPrry3PFo8HT8Kf4WMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662681; c=relaxed/simple;
	bh=UEtaR4QFXoWG5mFkO6pOWfp4vS5WT0e1+nwbfyCMPhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nzvr4Bsv3SDprN9yH7w1aeiUAio8HEXZuH5plAIWjFYlmPajYZBhzg7t7yUx0Tcw66sRnun5i4AEVpoB94/6PTgMZIxNnFJVu4ShBgDQVEtCP6tiBLelRQ/aAkXh+Z4nnpDNI021k9cTkQLGEoTjO6g7yWliORT7rpmmsesaZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRl0hnyy; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRl0hnyy"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2eaad5eb1easo5893fac.3
        for <linux-hardening@vger.kernel.org>; Wed, 11 Jun 2025 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749662679; x=1750267479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSGkIw7lXPoOOQ6xsmLGULxOdNRYgMzOtzpFjJzQIBE=;
        b=ZRl0hnyyiXItZ+kyGxYn/z4hYkjWGtd9CajMFLzSzPl1Pqvx3DqfI7SYy2/uvEGysv
         tfpkNdww1yFJAKdozlNytvW9k8LLxnXTepbXe+BH9FNZwvU4I8ZBXXZU90kl7hRlM0b+
         vqMqHSmBJyzZ0RPUDvfEaqzx5GPXkUjWMaQKhRHuCNe3TzM+eZH+Hvci0Bz+x43SbEnW
         m7OJ1K6WHqggBjUMZd4ML250WQwKZx5idM4G0EgiVCRNAFwT6n/JFBaksXNVJQ9NVLjd
         PNR/5XbUtlKMa4zoB0NjfegPXJZ77k2h1xeuH8NqhcAVXTgPNUpn9vyLjHSqE1f9bwaw
         mdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749662679; x=1750267479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSGkIw7lXPoOOQ6xsmLGULxOdNRYgMzOtzpFjJzQIBE=;
        b=bm3XHp9ZgzakcSrE82I35ZFZKHWYf4phVQG6FXdT0zk4YOEYpLow11yZbljVOD5qLO
         jRUThA09XRPg26P7mGWARUkJL3APRvp9jEuHNuLc8fFAgzx1ONh4xzD8xYBRXhPpCe9n
         FonHldZgEJ1mzOKvK71qe6JCbY40+mkRb+cQlYO0mgImOsFaQXwX7JLzCtAiy3wIzmwK
         KzcKBxfo/b8lJU96lw9gjF5yPG+enzp4Ii1SmYCsxUV3plY1yvcwiI/HxURn7KkrFMLl
         T0JSc6/dLl+5DVjnahWGZKhlOqRFmwGvf09AKDUWLR4QGzTW/QIFBh6adgvz89u2aihC
         OulA==
X-Forwarded-Encrypted: i=1; AJvYcCXT8Q2mioFAroQoOOmssFSzVXkdu1gLnjGkwC3TyT6mh3MxGAur7FNVeK/uAZTnfWnD6PR2o5OyKQkJd169daY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9OLOoD6Qp6Qm8JPRwHhRuPA4bPEf44Xx5ITI11kzz2nNoboAk
	eZG2JK/p40IjfWQDdW4lFxY1/7W4wdvcmcGoPUAjNKi2h89+BQV0Xqb2UBu6hDWeO82GWIIkdFg
	fITAFZDvU97Fa60dzeXmddkGTSde/8z0xly/c5TAbxEoikbwwb2fmCorXiuQ=
X-Gm-Gg: ASbGncu7fg0hbqX/LId2i8vCLMesIqokfixUAnW1tL9fNI/VNzxNo/3oyk+GixL7OPN
	l4Ygn8PZY0DNp8bYcjbTlH+ivBuBCd+xu1Ds2+2mps2fJd4FAhOKXAxSQOli9BZA4TAScB1ia8n
	deCJ+bOAK+xGrVeh+P1FUE/0bvho7qPmtW2Vf1s21U12sYciBvHc/kf9TaHRGNzZsIiehPSK8ai
	A==
X-Google-Smtp-Source: AGHT+IHDg8JRnLesFPl1JibUsTLTfDGDn0XZA+uvbAbHEWDtg3wuwb5nGOyTn+G0bLzDeQzprxGqSlM6xctnYJhmBSs=
X-Received: by 2002:a05:6870:170b:b0:29e:6394:fd4a with SMTP id
 586e51a60fabf-2ea96b78087mr2556511fac.2.1749662667786; Wed, 11 Jun 2025
 10:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602135231.1615281-1-bqe@google.com> <20250602135231.1615281-4-bqe@google.com>
 <LGWNtyhjCByj6PPHMsGCwo-WBkCCUuCOn_cUuwlwHPhfRZ4TdDR97a3u63ACSIvJQZF2SyAInyX90iMkERX2MK3Up-R6jazWHWhFzTIWah4=@protonmail.com>
In-Reply-To: <LGWNtyhjCByj6PPHMsGCwo-WBkCCUuCOn_cUuwlwHPhfRZ4TdDR97a3u63ACSIvJQZF2SyAInyX90iMkERX2MK3Up-R6jazWHWhFzTIWah4=@protonmail.com>
From: Burak Emir <bqe@google.com>
Date: Wed, 11 Jun 2025 19:24:16 +0200
X-Gm-Features: AX0GCFs7WUVNcSH5-pbXuRcq_xrq1pRsTFNiXrQfUtQYZGhl32F3isfEx9mg9UE
Message-ID: <CACQBu=VX_x97dJcjUUs_=fxYmtitcrNd8NB+5K8Cqu2+9yoXqg@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] rust: add bitmap API.
To: Pekka Ristola <pekkarr@protonmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 11:20=E2=80=AFPM Pekka Ristola <pekkarr@protonmail.c=
om> wrote:
>
> On Monday, June 2nd, 2025 at 16.53, Burak Emir <bqe@google.com> wrote:


[...]
>
> > +    ($cond:expr, $($arg:tt)+) =3D> {
> > +        #[cfg(RUST_BITMAP_HARDENED)]
>
> The config name should be prefixed with `CONFIG_`.
>
> > +        assert!($e, $($arg)*);
>
> `$e` is not defined, it should be `$cond`.
>

Thanks for pointing out the macro and config mistakes around
CONFIG_RUST_BITMAP_HARDENED.
Fixing all these.

I could not get kunit to enable RUST_BITMAP_HARDENED - now I understand why=
!
Also added the missing test now, exercised the code and observed the
fault (though [should_panic] does not seem to work).

Cheers,
- Burak
