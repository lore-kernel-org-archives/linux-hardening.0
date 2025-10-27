Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9F2D73B3
	for <linux-hardening@vger.kernel.org>; Mon, 27 Oct 2025 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588174; cv=none; b=npvkp4XY6+LleU3SxDADm+SfMHUoxKm9XIquQ6Qg9KeOL5wPbxIjdrJUheniU0pDl1yPa3QfRTONfBO9JPJm15q3z5Ke1Bzvfg7XXhdhbaQoP/ltJ3eBto9Q3Yfj9sEq1KvkCf0lfGTx9FjcGKNIy8s2AGxUEvX6r0j7Kt0pXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588174; c=relaxed/simple;
	bh=dOytCd7484DOfztynZOTaK4XEpFsXlZFSICg5xCq2c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqP5/9mWWaOClsFhM9swBnqtcadwbFVTFVfDXTKT365oB/jFWvbz+K7xWbv5r/q98FakwUya+HBoZ7jLNJpyXte+OmGl5XRxRve4U3YtbuQ4Qbpp7r51D+2PxrsIs3G7XtZaWud1kJp7IY72n+LKJhLN9kD83m810iM2i0BpeaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nJJy5t7n; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nJJy5t7n"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3761e5287c9so59210591fa.2
        for <linux-hardening@vger.kernel.org>; Mon, 27 Oct 2025 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761588171; x=1762192971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrVg/J5EzMKPSWWh0QN6HjWznUfKRbFhONdZmAyyMV8=;
        b=nJJy5t7n4ItKqn/J19li0SPqsPySFKjYI5eOBudFqoYMbrLPzmdHgyDVUeJ9zOR2tF
         id/NhUdE9znPdLo5mVeLROmvgSm4d6Ae21l4ZtecXL8HjSyiSALdHEN2TKAV1rn+Pzdy
         DVaUrz8O6wj8fwU9yD3348A9JSkoC/pK1TA4g3cu8BiJAiz+aJ3eT6gD7r9ByRK+7g01
         UIDqPo0p5zbDnok5faIp887ATJaO+lmNc2RZst8ZrCX+KeqxzkAJhvsOGEpbdR1MO0rD
         NK2aBhd4Nf4Nz3mAtNwuCpKwZRKS6YqyYPOW/Zqiggz76W2mK7focZxczSeH0oHRXY79
         GknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588171; x=1762192971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrVg/J5EzMKPSWWh0QN6HjWznUfKRbFhONdZmAyyMV8=;
        b=Zq9ikfYf41vSenYReFk9XrZYWzOTieDCiLFOVRbmYtM1WkJ1r+x6lVMpcSiRkdYxuJ
         nTlDwJqGrhqZc/uMl9YTWGfnHHR8I4upazL7wWQ9BY2hw0as2e02/GNfk8sw5zpAsC4W
         CysEQzHmfEkDYvhkK1lPYFy2po4ZHhm58a4HoUMcygI4sAr3QwBrSQIIJiKHlz/GctVw
         KI2njobKXAA4FDvCpnEvPnvLVIeqNWdKqPqAMcfjf34d5rqDMROCXatGnkalGguJxJ1v
         +vO5YOGzCVXX8VF2iSZND8miZZ7PJP12eNWMzrjEr/sn13C1EZFlkjBt+bSkd7Iyldsb
         G2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoaHAogF8/VidsnLF/bMMThrFS+JkN0Qxp28ttKelVjCocI6B/GL66RV7Tq2zDV0GlO2/74ORVavR3cnQxU4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHFlRjxsOZswbcM0PRk91xPwtUP4u3w1xAsZ9hVtL/n6qvNlP
	j2j3NiYn2A4lE8AcEAxE316tgNpJEVX3sEMccDk02uoEL4gIw6mnrfN5o3W+59Df1/bk51wtfuz
	b6zYJ0vwDivY1Ab5bjnPCywWZXUTsdB1Dms8N2pMWNw==
X-Gm-Gg: ASbGncsLZuTQfPNUCtzYAobV03VmQDBseSZQbIYfMYbECaJ/EHmijK2r9gEzhgfGits
	4dK2T/Ks8Ltw/J7RDs1PeqULGEzwEVJ8XQ60K3VA0ciVfjUisM09YT4dnTYCn20AkXjEiIk1eSe
	AJDQgxIHoy3RUIPnN0s1aF68LDaVdbpKpDssIFDBarQK+o1qTIstA7h8qds2k//ijb/qYqpQZ/o
	PyPUq/1dHm6VNaf3fuvcFx4ghNXDmO3TjqfYK/fimCxuRljKwj5fWs7+YovPgN2ptlrOIekNiCo
	SVu9VFwR0qaqfW0728Y+A/8R0Vs=
X-Google-Smtp-Source: AGHT+IGeODzsqrNJ7WuEiKEpxQ5OBP/KG1OFWpLiokHxsv2XfWfnBCCdrZ+rxY66M0Jj9bx+MfrB+UPW9NfpXb19HIk=
X-Received: by 2002:a05:651c:882:b0:36b:a355:3cb8 with SMTP id
 38308e7fff4ca-3790768d47bmr2162091fa.6.1761588170689; Mon, 27 Oct 2025
 11:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
 <20251022-gpio-shared-v2-3-d34aa1fbdf06@linaro.org> <aPkVjoWkP04Q-2xP@smile.fi.intel.com>
 <CAMRc=Mc165HSLdug1F+t3qcOoE52mR1e_zEh=rSTUKN_-dB5NA@mail.gmail.com> <aPsmMruDxOil_wYQ@smile.fi.intel.com>
In-Reply-To: <aPsmMruDxOil_wYQ@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 Oct 2025 19:02:38 +0100
X-Gm-Features: AWmQ_bleXE1kwyQiCrUiv6lt2gYC06TJbSUdkSnPixltI9qUPpS9huAScAVx_CA
Message-ID: <CAMRc=MfG9fOFQT2L0B5gSGvgvzFTKOVKW4zXLYZ6tmVocZJwjg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] gpiolib: implement low-level, shared GPIO support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:09=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Oct 23, 2025 at 08:55:27PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Oct 22, 2025 at 7:34=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Wed, Oct 22, 2025 at 03:10:42PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
> > > > +             if (!strends(prop->name, "-gpios") &&
> > > > +                 !strends(prop->name, "-gpio") &&
> > >
> > > > +                 strcmp(prop->name, "gpios") !=3D 0 &&
> > > > +                 strcmp(prop->name, "gpio") !=3D 0)
> > >
> > > We have gpio_suffixes for a reason (also refer to for_each_gpio_prope=
rty_name()
> > > implementation, and yes I understand the difference, this is just a r=
eference
> > > for an example of use of the existing list of suffixes).
> >
> > And how would you use them here - when you also need the hyphen -
> > without multiple dynamic allocations instead of static strings?
>
> Something like
>
>         char suffix[6];

Well that is quite fragile, isn't it? Not only does it require 7
characters but if we ever add a "-gpios+1" suffix, it will not work
correctly. At some point you just have to open-code these things for
better readability. I doubt you save any code with this.

>         bool found =3D false;
>
>         for_each_gpio_property_name(suffix, "")
>                 found =3D found || strends();
>         for_each_gpio_property_name(suffix, NULL)
>                 found =3D found || (strcmp() =3D=3D 0);
>         if (!found)
>                 continue;
>
> Of course with more thinking this may be optimized to avoid snprintf()
> (probably with a new helper macro or so).
>
> But see my next reply, I found something more interesting.
>

I must be missing it. I don't know what you're referring to.

> ...
>
> > > > +     /* No need to dev->release() anything. */
> > >
> > > And is it okay?
> > >
> > > See drivers/base/core.c:2567
> > >
> > > WARN(1, KERN_ERR "Device '%s' does not have a release() function, it =
is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
> >
> > Huh... you're not wrong but I haven't seen this warning. Do people
> > just use empty functions in this case?
>
> I dunno. Maybe something applies a default release in you case? Can you
> investigate that?
>

Ah, this only happens when the release is triggered, not at
registration. If I force a release, I see it alright.

Bart
