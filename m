Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D1174EE7;
	Fri,  9 Aug 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201717; cv=none; b=hH4NhA8T6jwciDrmte3v+ulSbu1jFbKbRqYnMEFHRPhEL3y/RVA/qdgmNUBixuBxEkYmT6Rp0otsHGi5adGslPWiG/gKkYV4Y8YPBgLt49aMLC00RtSFCXzHo3Xhdc1bcFWAo9DZygNOpd1sdV4Qjah8ot8zzD6IsdqQ554lMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201717; c=relaxed/simple;
	bh=ru7UV0nYk/mVJWaiDSvKWP/Rux98Qa7ATxM9wsRvvNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUvzEMoNKn/JFxIJ+CvFmfaPWRbmHNnbqdn0NRrUSqSO+KRxIVrqs4WhzUPJ1l0c5p+NYTRvlDlC1SV8GUvTyLInLwrLfSJTLpk5J83qMKzzHtRmGjw0+JntO9s2iE0VnBptLghh5Rwf28K5kBmU0haOauLwy8yNwYl9hNGtUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMd34mHR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMd34mHR"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so2592651a12.3;
        Fri, 09 Aug 2024 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723201714; x=1723806514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ru7UV0nYk/mVJWaiDSvKWP/Rux98Qa7ATxM9wsRvvNE=;
        b=fMd34mHRjU24xfm4WoZ4ZAMneh4JThwbmlzaqXauCLf3g/QqRaXzjmAwsNOWcMeLqS
         NkRrGsDTUq1KnndwZdc21i7Zyeiq5T86tEYbGeURKVLcBKGKEaCCpiwOKzRE9e4VcJMt
         v2v1hC9osQoZG58K97PGbsvLoF1A0328S14gyWBjQ95jEH8aP1rLnkxHDlWnt+NaNecq
         cMTcHoSXVbVaWLRVtD8UsFq4sR6EX80h4CxZRHOVgmrJbigZhwPvWQBpRSQPYQBH898u
         msMLBHCSf0AmUFKkyi3vAe/5j0IYPjk6JGuGvSlJ2Lgujt+o8iFMacKKTg2sQNYmv+gB
         F5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723201714; x=1723806514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ru7UV0nYk/mVJWaiDSvKWP/Rux98Qa7ATxM9wsRvvNE=;
        b=R/ktEAlTMRheedCaYjwWtQd3E6svrSPJ2OQhIj2dRkUeq510ouiSzC8KaubaYwZXpL
         4ggFcz8WHXwjP3W+03fGk2+XqOjasZxJRdbY2ue8WptFyId45t/s/6sFOFEt+7C0Sln3
         7a7hRPFkvr2RvMSAcd6NohOfRXtjS4Ilv/tvsE7tj2ixlN8VUxdLztXm0WO11rRSKykF
         4t6w7bsz5gxTAqkc67d+b5vQbaerzFaWMrAtcD4LeICw0NH7hGhSqd0u+kpPfEG6P0Jm
         NRRzSkkduiNG5eMUPieteOBYcxqBAjuLxDVXtj3TXFuk1XZYzI3vOmkUqmP0LyBdSmtE
         o9KA==
X-Forwarded-Encrypted: i=1; AJvYcCX1xX7+OiLOBYhXa+AvzZas15Y2Xip3NN89mXAqw0nThYWIkmhT2ChM3Z8FmpYift66Z9rmQb3KBPUHdDV95sQNFmPdOzxe7siOrgR55y4WS9hrxI7C3KfNaZ5lQ95MiacLgNHCtiL23RTOoeCi
X-Gm-Message-State: AOJu0YyHHlsolaFJ5yRk5aEkMT1zqysyDQ6B9umvUALmOWSLdk55rzOA
	TjrZsEmvgxu63NCLMHKe0o+jvCjcGqT5G+RIv2lMni0ZAloXoHNRCREmUvIrA4Wuflvk7FyfSqY
	UWXgwD1gwta3mhnqsUKAhqOpE7OpLOFNY
X-Google-Smtp-Source: AGHT+IH2pjJQUUo81sKQcUAG2A2rj8LPxuNT0LDJOw2moT7y7mEzNtcY12Q9X0FrV9Ri8sNdWuOkatsOxMqlrtw9IHk=
X-Received: by 2002:a17:907:c892:b0:a7a:aa35:4089 with SMTP id
 a640c23a62f3a-a80aa594542mr102522266b.24.1723201713513; Fri, 09 Aug 2024
 04:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
 <CAHp75VfBjKLf3LqDXvAehW5sxGzYnU4sS3fr=JoaM-6p_gR34w@mail.gmail.com> <202408081609.D08D11C@keescook>
In-Reply-To: <202408081609.D08D11C@keescook>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Aug 2024 14:07:57 +0300
Message-ID: <CAHp75Vd3wKyq2XE2UPoW_q3KjmncSeaEebL4ff5Gpx8Lz+dB9A@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
To: Kees Cook <kees@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 2:11=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Aug 09, 2024 at 01:07:21AM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 9, 2024 at 12:44=E2=80=AFAM Justin Stitt <justinstitt@googl=
e.com> wrote:
> > >
> > > When @size is 0, the desired behavior is to allow unlimited bytes to =
be
> > > parsed. Currently, this relies on some intentional arithmetic overflo=
w
> > > where --size gives us SIZE_MAX when size is 0.
> > >
> > > Explicitly spell out the desired behavior without relying on intentio=
nal
> > > overflow/underflow.
> >
> > Hmm... but why? Overflow for the _unsigned_ types is okay. No?
>
> Yes, it's well defined, but in trying to find a place to start making a
> meaningful impact on unexpected wrap-around, after discussions with
> Linus and Peter Zijlstra, we're going taking a stab at defining size_t
> as not expecting to wrap. Justin has been collecting false positive
> fixes while working on the compiler side of this, and I had asked him to
> send this one now since I think it additionally helps with readability.

Okay, but the patch has an off-by-one error (which has no impact on
the behavior as it's close to unrealistic to have the SIZE_MAX array).
I prefer that patch can be reconsidered to keep original behaviour,
otherwise it might be not so clear why 0 is SIZE_MAX - 1 in _this_
case.

--=20
With Best Regards,
Andy Shevchenko
