Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C1374A04
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124127; cv=pass; b=g+Vnmro08ALGDqAePDwMTwGxO8rwRRQH5ka5PaK+8KfKr9mKh2t8dcXkaIh+4h6sXE1ToCdE2eBnQX3oBocCc0UiZIgmp8frsPyWEObhmaXbGnM2uEzdX13l+T+VIHQjzA/2aqv7x3J6e0q4NkZKu0uTRq3oAVWgknN03wbfuJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124127; c=relaxed/simple;
	bh=gXP3ndAsKNjuDSlFH6w+TobFDE6Il8749kvMxRWmd2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSIV+K0Iifueb6ZKJ9zgz57h8vTsn0ldD5xaOEF0ZW96daMJKLMtFDfLFLSGxhNwrb+PlJsPqm1RXRzD+6+ov3//xMGOj/lazPtdnn/jtWM7r5PuhmoZnum4oSt582WLDesSzX3qWqRZNWOd4Taqjhg+I17+AWO2kvtOo7wKiyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mxm6dAcA; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mxm6dAcA"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa679cc2c9so968135e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 13:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781124125; cv=none;
        d=google.com; s=arc-20240605;
        b=fUzRXdKSU6/XfvD5x+op9it9mA9LfBpoQzAkcZ993Ct0s3yP47JH0BviSuScjlSRVd
         TD4UYcaIJw7+TkbAjPyeoVu8vdnKKg9xd+hJ1g9hc7n2eY8HG1jyFI6M77cIeqhE+d7A
         zHk2nlXgRHE3ag+ovsaw4WlviMr/SvrkYGJdtAGw7PanXy2jFgWSLyEsreS9qFBLledw
         uQk02qaSXaYiJAYC4yv7jxMG+1rWvP+sDni8oUVvC6bcP56X9Rz3eKi2FQZt0HHVkjMC
         rV4SaDrV0oHjOAgXFkGKo8EDF70VdL4g1jvBD8XUDPXuOb/JRIUqO/CzxFfuhyNsGxaz
         aN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ojjdRU7C8G8Jli98gKi2UMEANrqIYaK3aEdrLJL6lYU=;
        fh=tnra3gb17I++BaGhteF+enFCHz6evztgXDqmPE3F4zI=;
        b=aspoKwOTlgRL1ny7g+4R2/S8zDOBO4OghCtuMX1Ad+sDLpVbmu/qp82Nguxi/sZQe+
         s7/tZpAOhlixRV7MQFTlcbEwfmmmqhDjiPY8NR919JMxShLa6GTaOypzHvPvIYE1btb0
         ZG2UdOgI+oP8DwlVFJlzwzV3p4UzxBysr1Ky6FJitBKyvb+EqeiL4pW1TIb2QbY8dODI
         n8oXZLbsocketB6S7mOAM0MYkHXBLbvRBFyJ14WMzNaohhUJ/UhXVl9te/t+yMtHDRPP
         yVGtGmN38DmYj5ay7HyhYzombvJsZMUjKI+9JFGoMQpAbRu1jkuY+ZglSQ9A7BTMQJg2
         TMAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781124125; x=1781728925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojjdRU7C8G8Jli98gKi2UMEANrqIYaK3aEdrLJL6lYU=;
        b=Mxm6dAcAHsB1+Va/U8FRRAgHNjhWwb6JhAy0mhyMQzkHsRg7CAYx6BX4rqTocFSucN
         xpyFKZL0aJLcU6m5Ea1nQ68QoA2tYS0maJ+w/ZDMibXCauOqCxMFpTLc5Uiav6t14uoJ
         gdMcBI/QSd7txIRg6lMomwQuFk9GQUJJb4WNIOH8Ru11OWZ0hV6aIWWeJ4GT8O5+PCfZ
         48q2QXOuKERr0Tgu2xcz4uLPLWLYsfkweS4YdAIWpvYPYNwAo0OKuP9ykVvz4N7nbNMd
         qtjWk/V46soRNBFlLnSItPgQNSpA5SGoGx9pVLg4bCotN9AIET23oNZlC8wKG6yH/6go
         lZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781124125; x=1781728925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ojjdRU7C8G8Jli98gKi2UMEANrqIYaK3aEdrLJL6lYU=;
        b=sS4qunWNciJWVyNOpWcJzKapnKuPDF5tCPxVdDtvRxrhVDV6WscFmTBRlrxn6vBPa0
         lurS7UHJQ9v2rrk4uJmsi7gPjmkrtdqd38okRpCtbn8rvqwQHuB1fXFvKCBP6MW/9UUY
         pDGvCp5mxmAIwbVjhT/sNGrdXKnCQV9vbfdpanoY5IlA6t7ArHknwstsOmmnOlbVq6D5
         i9Ft3L4PXFlIJQ2a8jD2OWWrbugfpBv+VERLNzTr3svBhLRaMmDHAA1Jws1KYnjoc9sj
         cWhPpR2YIxqWSUtK8cHChNsQxH8Ly4OhPCofLOkG9vsj/5U1qtiQ613EsHuz0C7bJM3c
         gT2g==
X-Forwarded-Encrypted: i=1; AFNElJ+3Mw+UPSzS3hb2bHCMh1w94K7YLF538BjSwlMPDOVJL1ppwRTp23RgM2qOlddNp+bwb9L2ot1Fk9qwhJbajvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCvuvn/g8t8aFotGowl6DgNHKfVkB+V14S8efqzR3wMHvHcCgq
	AeQ2w2oZptJwgYimkH9IPfrdL9QnUHCmUtiApX4G6v6I5boeZRzATXFHJ4Z23gHwSxXSCieVRtT
	3GhPrUt1cH5JBZtZfcx7x6rQhzt6bnz8=
X-Gm-Gg: Acq92OH3XNvt2CZMPTI31L6col3VTwDHRcX8tmm74WrT9tM+d8UYnzmMuTE/E/+Oob5
	EJ1E/KFQWwq35MtzitVbmM/lsoM/Gfqhoc5NRkADMklvdCAv0Ww858+ALJgtzdE/Hd5v1AZTwxK
	KLuvpngDu6Zuh9S4U6vFL2TICPtdzLrtJ+ALnr0ZlN/8vtdWToF8lfoEHvHIA8k+8P0k+H9aLUM
	uqL6n8aI/gwkxcBJyR4hQxQDEZdJ7dnWLrxvi7Pi10qoedV+MzZRzmbpc9mGCWcBx+h0bATF3GU
	U/THFcs7ZUTn0anAUkHb117KuLOBKi+pzQ6WP5rZSHFwjFMNX5NBW7MahMx+GNtiCs2A4ajSw3O
	2NWvFSsBYsDABOIUK7q72jk03boJVDa4Zbw==
X-Received: by 2002:a05:6512:a8d:b0:5aa:635f:7c08 with SMTP id
 2adb3069b0e04-5acfb00c7b7mr1360974e87.7.1781124124359; Wed, 10 Jun 2026
 13:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-rust-reverse-randstruct-dep-v1-1-45ce9ee8d0d1@kernel.org>
 <202606101335.648C6993@keescook>
In-Reply-To: <202606101335.648C6993@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Jun 2026 22:41:45 +0200
X-Gm-Features: AVVi8CeKmaEylMIDtCA3uvyQRS2s97f1cBEsBG3LVoZ_J7jIYMPtfwWRp6_WCeU
Message-ID: <CANiq72=bH=H-pMHzB7Bk-A-L2421qZD=bz3Rm4kH9QSjFxNRbg@mail.gmail.com>
Subject: Re: [PATCH] hardening: Default randstruct off with rust for better
 allmodconfig support
To: Kees Cook <kees@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Can we instead just allow it? This has been ready to go for a while,
> IIUC:
> https://lore.kernel.org/all/CANiq72n=3DhgH4bqJjp8MsMHAaxaAo75GSBcHGTvFT3N=
TSaVPGWg@mail.gmail.com/

Mark sent a v2 where I mentioned that! :) Please see:

  https://lore.kernel.org/rust-for-linux/CANiq72mmzfBg0_y+TMTsUUuO0cJFE0=3D=
n60-ttwOynai06_y=3Dzg@mail.gmail.com/

Cheers,
Miguel
