Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8C285CBD
	for <linux-hardening@vger.kernel.org>; Sat, 26 Jul 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539479; cv=none; b=Nz5I6st3Y4qn0QEScZRPemIk2Rl9WfpsPjfflylcAooV5J2elOlv8OZjikcHGirTak0RsUiulJFyN4gGA20A+qMKWm1YduKDy7JxO76kYaXBR2y0ii98fdZ2UiFAqXQQsctGp8OOoeX0dXPezRocy2L+WtubKTCmgS7siltNeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539479; c=relaxed/simple;
	bh=QsKCYgFN3Pl/637rAO4WBZp3QLVhOoRKIclRbpT1pQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pf/qqdUiv7PcyFm441h13bQdUqvwqj2aDnEtMOqRDO4cvFJ+etPsOz5Eh2iMlJw9U9Jzd/YxRJmb9QTqbXmBI7Zoego9L6AxqPcgwnBj2zKRyWmuVH9Wey3zsAlDct6hfbNGkcnzniKSaUPp7pLZkBpTNN4KRycHcPB1dT1D2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W3phLuaq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3phLuaq"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-558facbc19cso2642208e87.3
        for <linux-hardening@vger.kernel.org>; Sat, 26 Jul 2025 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753539476; x=1754144276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsKCYgFN3Pl/637rAO4WBZp3QLVhOoRKIclRbpT1pQQ=;
        b=W3phLuaq0RVVMNzRc9exL8O8cvPdzFYZxDXxvj/AeDazvwwlRvRGpWLdy13kQbTgc4
         S61a8Sn8e4coANibRq5wFNwXxBLNIUzFXG6dAhpbX3cW+RNKQpMhs3lu/woLzZ2r3UjZ
         QD56BsLYto7BaJF3JtSYuSJKsXS5ES9vXWdm4x4fePIAUiwLnJ8ByugA0oE5N0KV8fY1
         e0+/zL1aMxMNW//hUUzRXDkpMXQ+prQyK2g+OWEZH867zHPr3w3LdbsL30ExWb4iJXQo
         6AhTVmvWyqAjrepZklB7EefS6qNioFncIkTl21BZ5QDQ+pnTMl3v0JyRuVwiH1ffBazU
         1N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753539476; x=1754144276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsKCYgFN3Pl/637rAO4WBZp3QLVhOoRKIclRbpT1pQQ=;
        b=nm5Yr9+BBM2BPdMTUG+YeHVZgXppbcn3RQ3Bf9uy4hurea1PJV6TijM4ScV/dLiRng
         j4RWxAdEE6SZRmW648O6tlkcDWZDeNrSoGk4dfBA1nB3WedzBmJfctdm0cjPsILD1lhe
         e4qRXT5ojN3klZr6Sb2WLnoA/3lamj1dOv8Dvg+gLhkd93WzdzKYVDnf2aGpjCllzS+X
         b4g1YGVsfKA/vJFj3PfbBqt8/233r7AHQS4NoqIbCYMXLMAH03Akrqb5sSVf+poAHmWb
         pgHP4jT+n5HFYE/hw+O8eg6fkWrmTAFlNFFfFT9m7Qe6SGB4cRZ0M8my6vGcwvKOo6bE
         kYPg==
X-Forwarded-Encrypted: i=1; AJvYcCVDfEcYXUIxd6OvShqh01SKuANgITVCT6BKM6dZTrhaU28HQGk1e9oo/iSoIxbc3gdcqz6Q8iIDwLf9NIRxQNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznXbYcQoLtA3UcDKnl7r6WoxJnrU2cNG+bd4b2sq/eRgNwYkUb
	twKAdIAB/3aOBH4Ld0jddvqG2TBCcoiQNtw4IRGJu5D60wkVHup9PuJwKmvmaTb8aslvyR17o17
	dYvx73uQdRZD3njlbkw1OKok4K6igUS+Xvmam1vAfcg==
X-Gm-Gg: ASbGncsC/WW91ZdMrnSsepqbfJiS3H1KudAFCC5pneB5dQDGgflLcKciA9XQKuMhF4l
	GQD1fZamSR6C7bqoYCxrDTbOYLezWlqsFbV6BDjI2VP3VCzeNW8eXD2HnP+sqpOC1fpnj+J86NT
	6ZpBxO+RG6beewuO1d7VRq9CIzZmK3QXm4znuYhrXbtIhn2ZDn4kNRdAkW75RbvYJsJEPY8YSrd
	acgWWFwV9SJ
X-Google-Smtp-Source: AGHT+IH7DWpvL4/EaSvQrUXZxoed9pZpjosN4KFejpqR4sw55oFM2Lj6aw3IRkV89heBwtbytSWltY9kUm8IpC204jQ=
X-Received: by 2002:a05:6512:3da7:b0:55a:4462:f9b5 with SMTP id
 2adb3069b0e04-55b5f4c6d4bmr1362236e87.53.1753539475990; Sat, 26 Jul 2025
 07:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
 <CAMRc=MfS5Em65n0fwbu8JtJsc3rTgQO5cv+PymSonJtf6_zRKQ@mail.gmail.com>
 <824ec6d1-4272-44c7-b3bb-93d716ed3d43@bootlin.com> <CAMRc=McnU6TO5p7Jwy-DOg_8-=AS7rFRfaPD0yH1SERWXM8L+A@mail.gmail.com>
 <CAMRc=MeZ4HHJGkVBysLyusW5G-rM0iSQV1qqmFJUe1rsZrN2AA@mail.gmail.com>
In-Reply-To: <CAMRc=MeZ4HHJGkVBysLyusW5G-rM0iSQV1qqmFJUe1rsZrN2AA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 26 Jul 2025 16:17:45 +0200
X-Gm-Features: Ac12FXwQ27n_JGOOvHJ-jWxO2gK5gh1Sp4QaipYWDU0befizJdpmrsUresvZ2wg
Message-ID: <CACRpkdbjQSns7a9EMx_5kdJ4Y2wsnocTLNsO2es7MQ=rKCBkQw@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thomas Richard <thomas.richard@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 10:43=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> On Tue, Jul 15, 2025 at 3:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:

> > Well, nobody responded to my last email. This is a cross-tree series
> > so at least Linus must confirm he's ok.
> >
> > Bart
>
> Linus, I'm willing to queue at least the GPIO part for v6.17, does the
> pinctrl part look good to you?

Yes go ahead, sorry for late reply!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I was mainly waiting for Andy's review on this, so if Andy
is OK, I'm OK with it.

Yours,
Linus Walleij
