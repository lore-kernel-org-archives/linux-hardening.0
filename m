Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8A269B12
	for <linux-hardening@vger.kernel.org>; Tue, 29 Jul 2025 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776198; cv=none; b=KL1QlfyqVWJctU+wZRBFyFCP86JngpXyRHsdq4rYkSBn1MgupM5d+E5+9+tgMB1haNTt+1SjDlqKXM7fSHrSU7TaFd/UT/RlAo81FJRb2uKyXzQsN5llnPRwSoDZd+FKD+P8HObZ4dWAi1hG8RWCfjHTmlihRGSuNKgUMqa6By8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776198; c=relaxed/simple;
	bh=UflJNvI/cneK2LX3m1PgDlZbFunqpRrS1ehCqCFEDw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBTr5Nmsm411tzprQ36OTT0e/+Gz3A6ZDmIOBD+Lmb3P9W6OpMwka5st3VQaCNbUQds0k4ZYJRC34J70mffFCDbMPrVfoF/KRnJAul2knnnrmEKbtmnS1oz6pmQK5lf91XN3BH80i63me/ZgNtnt0U7+Z66J2DdvISYZhKvbfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lHg4Wcyd; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lHg4Wcyd"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso5317833e87.0
        for <linux-hardening@vger.kernel.org>; Tue, 29 Jul 2025 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753776195; x=1754380995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UflJNvI/cneK2LX3m1PgDlZbFunqpRrS1ehCqCFEDw4=;
        b=lHg4WcyduMyjgVQ75Wwb2TKuNLuAjYgZ4+19osY9bKFZEzrmKY4uIMEN3fBC07R6go
         pskGLbA/N0ne2CkWctM4JDpWYRXHpfcukZqQEhqeEsS54LkKFTuuE8R2gHQZ7dHNDIzV
         xGLXBvdxtYSSjTyADL+bLKVpv3DsON/0tKEvOi6kSLDyDLULXRAG2ooTXmm8osUX1nPP
         eQlgc/4PzsjKTztid0tyehGU1MC7XLP8r+wa855O6Q9zN8PzYCUtiWd31uem/WT820in
         0XQ3IPjOetIlqAYz57oHyNvYGPqfDU25en2sUfikIhDhSjCjIlz/r5YYwbKOrg5MtohH
         0miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753776195; x=1754380995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UflJNvI/cneK2LX3m1PgDlZbFunqpRrS1ehCqCFEDw4=;
        b=a04APWE4VG737jkhYZbHnS20Y+BS3qunLg+WcRBxwpGRgy82qoggj7DY1tQQUEVDcd
         7QOOAsy3EztfL9PYTcr140cHt4cT8PkbcYZrdDPhscvC9oRRrhRvdRCPupY6Uvf17czP
         z1yChzrGCUteUWevEahEUMgDZSA6KhwoYKpSgvucygBzkETQZ9trWXCsSzjVaQurOTvx
         GGSuAz4RfMHR5gluQBZyZ5wpYG8Kq9JxsubLnGl4QShKNrG7wUBHWMzYyaeibO0+8yok
         OhJxvJc/4u1ef1VEyMc/gO+lqPKP+vHHj8OmSyPtkjTA7OrjglX+J5xat3fdl3hJ22Qn
         qiHw==
X-Forwarded-Encrypted: i=1; AJvYcCV64D2Vd8AsJCVwCZC5iIzUyQqw6s4V/BctEM5frfvpA86dnmQcYgB9r+qT0hAtauPxzELnImD/uG3hWhQY0OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOcl7B7fd44auIwIi6sgMu/ds/n+7pzdgBVRW0brc+mpYmDse
	78NetQLxIJp3JMWx+rd6IcpX8OfVur0kfUnha1t0h53D4RuGHrBz6x/Ve9G7QZ11+aM28Y64/3f
	k3dy0yZFD0mmWx+kcJg77LT+MZJd8NrnSVOt6ltRgEQ==
X-Gm-Gg: ASbGnctiJauUoitJulnf4MACUXk6NZv02Jol533FsiZi16SbtMUUrRYrMiVqaaj3rzP
	D7f8aVlUj3x+f/NVq/4CcyVNYua3Yp0ZDbgGJHlt7adNDMXPqv1OgiPTk/r0O4fSFqMtQ2uEiLv
	OJPwBk/l41jKdqTw0O9QnKgel93v7wcqB9iDH/B6iK4KYsBdEyD92kfKBFcaWqzP3DCYLTvbgq0
	uaATAXFC3G87rQxfIHJSGvdZsIikdVDlSe7Kni0jtYs6tAbGw==
X-Google-Smtp-Source: AGHT+IHhGTfRcwlCoTMkBpGGIbg24X8fFN+ca6FGQ7O5Z0tgMTO9PPQ8O181X8MbzMzcz0jB3+Pt3eo0mb+Vi3jG5I0=
X-Received: by 2002:a05:6512:1082:b0:553:25f4:695c with SMTP id
 2adb3069b0e04-55b5f4b9c66mr3802415e87.50.1753776194943; Tue, 29 Jul 2025
 01:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
 <CAMRc=MfS5Em65n0fwbu8JtJsc3rTgQO5cv+PymSonJtf6_zRKQ@mail.gmail.com>
 <824ec6d1-4272-44c7-b3bb-93d716ed3d43@bootlin.com> <CAMRc=McnU6TO5p7Jwy-DOg_8-=AS7rFRfaPD0yH1SERWXM8L+A@mail.gmail.com>
 <CAMRc=MeZ4HHJGkVBysLyusW5G-rM0iSQV1qqmFJUe1rsZrN2AA@mail.gmail.com> <CACRpkdbjQSns7a9EMx_5kdJ4Y2wsnocTLNsO2es7MQ=rKCBkQw@mail.gmail.com>
In-Reply-To: <CACRpkdbjQSns7a9EMx_5kdJ4Y2wsnocTLNsO2es7MQ=rKCBkQw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 29 Jul 2025 10:03:03 +0200
X-Gm-Features: Ac12FXz22uZHpwAEpH2A-edyCZbULy4WGvtG8B3M_WQs_F93ggeN_b2SiWiW7F4
Message-ID: <CAMRc=MdWkWvwVU66daz94NB-asxBBY-1EC3BSLtPO+6dcvyCMw@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 4:17=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Wed, Jul 23, 2025 at 10:43=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > On Tue, Jul 15, 2025 at 3:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
>
> > > Well, nobody responded to my last email. This is a cross-tree series
> > > so at least Linus must confirm he's ok.
> > >
> > > Bart
> >
> > Linus, I'm willing to queue at least the GPIO part for v6.17, does the
> > pinctrl part look good to you?
>
> Yes go ahead, sorry for late reply!
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I was mainly waiting for Andy's review on this, so if Andy
> is OK, I'm OK with it.
>

Ah, I already sent my big PR for this cycle. :( Let's pick it up early
after rc1 and I'll prepare for you an immutable branch.

Bartosz
