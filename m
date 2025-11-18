Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A5A3376B9
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460881; cv=none; b=nKsr6haavnpz4P9yZwfUaorIVF4baORtK64qcPF6nv9nqTzgA8aSz+dniI/qOj0HIasaVWH3WMfAQy4Nz9Q497ABCs1039lQOY/DecBmNwJN5+xuifRFaUOA+ercFegBMQGC2axTMz80r8vyC7QFWOnm7WoSPuvn1H+JTCiwXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460881; c=relaxed/simple;
	bh=0OgFtEYRFJ8A9sNCbqNcHHzblz+18mUpQiCaeeuf3TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRRbHdxyNKg3ifT3Weubc4VMJNtlaUJpXiy9rBY2KpPTHIyiI4uuQHlq352yBWJU0bYGA+paDbOWg1VsTvpMzZhYUjQaIeJ/2f7PNh/YpQ949miFQeY5zsfdhsNoZ6M1PFYXC+fpkF8geL/eb9oGUTE5EB2rvirNyll/oYhK3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IwLfxm84; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IwLfxm84"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so5829045e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 02:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763460875; x=1764065675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn8sykep7y0i+wcwaNUzOmBFhkOj2Taub+pUCsXkMNA=;
        b=IwLfxm84+rBBFgXnGxhkjZz1Zt0vdB8JxkqVCcA29JV1w6WhW6yeLCFoqZJUgKcv4N
         wqxn6/qjI1dnaYlO53h5a+NiIw1Ok1xhzGpP33554NbaQFUOwPLRh6u0l4hj3Mi1RQ3D
         P63n/hb9Relb1dSoTqfcT2FfOzQblG1cGv0CfByir5aEHi8pys5v/pL8W+X9dp06gfa1
         nzGQSENADWn2u1d1tX2Zs+7j5ZFrUFnBlXEnQqfwY4I9gXoh1BjC7MTiC67N/Bi+vvDI
         ReGK/QaSQSpBHTUr3nY08FwMGIadIiuNqhSrOwwnl1wqxdMfnQ4NY5zOllb4bN3cG8EE
         vzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460875; x=1764065675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cn8sykep7y0i+wcwaNUzOmBFhkOj2Taub+pUCsXkMNA=;
        b=Rlh4kAKMdfoptOgIv6ZmkW/bCuVfKrw+SB2srg69kqcjXMh0504Cvkjq1iz9P3hKh6
         lRDyn+dejw1TfM+IBUDz4s+VsY+7IWzekLDyeraEm/aF4hoHVswx4YntZQ4QTshKQpgd
         fzBqyYeZWVA5RCDXgBpRezzVcfm5/YMS/mWhka5qwUp4RgKWqCRR9dH6y8/MA43ZG6TL
         mcfwTn9lbthD6Ce5AGM7DdYNmygLsUDKew8ByfwZMvgesa9TFhJqAcVCcYZYptmbZiIP
         ozQvbGifvHWqB/LFsQ7DBD4vuMXejy4bbx3354MUJ5Bz51QvRtWQt4Xhn06SgjoUdjZ6
         1tPw==
X-Forwarded-Encrypted: i=1; AJvYcCVrAqEtWU85dHutjujoUnCBeE1bqL/2gN7eaiJ9EiNWLid5V8au3hUqMsL1h81OwBCe3peGNfL8o6/mHkohdb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyloFaTVfa40d0r3oH2dWqTAFaR4KmHwO907Yhl7ZfMhNu5RmcL
	utaEFIl0BFsicLcj8YVFgTL4PRN+GmYSm5bw1J+Mhm9hQt2qNu9JDwYZwVcK2M9diQJTNHVnPxe
	Vr8TTXLizY9hgcG/U85os0k0TThySSKJYmNGyyJVi+g==
X-Gm-Gg: ASbGncu2Y3IJg2R1rCSty1st7VqlWwTJgVJmDxMZM8piqj7DQHt4g5f1T7aJxyXrIrm
	mLPYvv84l2qAsmJJgjPmLPpNOZfKMi0XxYN66TA1b06v13LmlTav7C5fQuK5U+xgdCcdrbh29hD
	Cy0jGHjiWebSh/Q5+KqxRCxKGMXKTbg5FskV99dF/YDFkb7axxG4+18y0+rl+ozsfJynjG4/IXN
	YdpHx/wmIRQkdFnfCina8cx/5Mdxw3orM0xIi4w3fGiwhTndSvMytvbxW8cOwUxpsfiII4fXO+C
	qPVgLGnGw+JmxAE6z7Ch5usETQ==
X-Google-Smtp-Source: AGHT+IGQ/uT7duUINAl9dIKFSFpyufMaYjsrTEEiNO0BcuanT8TQQCY4OXJkaBF92AJ4d1WDBnBmY62PLazMuEs5YsE=
X-Received: by 2002:ac2:4e0b:0:b0:594:3503:d847 with SMTP id
 2adb3069b0e04-59584237c96mr6165818e87.51.1763460874774; Tue, 18 Nov 2025
 02:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org> <CAHp75VfhQ-pv5J-WAaTz+mRu8Yp4JhB5CxNxDPBMaoaOVJBdXA@mail.gmail.com>
In-Reply-To: <CAHp75VfhQ-pv5J-WAaTz+mRu8Yp4JhB5CxNxDPBMaoaOVJBdXA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 18 Nov 2025 11:14:22 +0100
X-Gm-Features: AWmQ_bkEim9eLC8jgm4qPB9-dEXS4yX3J_lVisATDhr5KRyFLDg3IfRrlOdwIbM
Message-ID: <CAMRc=MecMJDNA=ry6YnyFxq_EeTDG6hfx2+wg+OTPBfdzXKFeA@mail.gmail.com>
Subject: Re: [PATCH 0/2] string: strends() follow-ups
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:09=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Nov 18, 2025 at 12:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
>
> > A couple follow-up changes to the new strends() string helper. This
> > needs to go through the GPIO tree as this is where the strends()
> > currently is.
>
> It appears that due to some local issue my messages from the last 8
> days disappeared and seemed to never be delivered. I tried to review
> your v4 again and I have comments on this and patch 3. For the
> strends() I proposed to get rid of strlen() calls by
>
>   char *p;
>
>   p =3D strrchr(str, suffix[0[);
>   if (!p)
>     return false;
>
>   return strcmp(p, suffix) =3D=3D 0;
>

IMO that's a bit less readable. Unless you benchmark it and show it's
faster than the current version, I'd say: let's keep the current
implementation.

Bart
