Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C77226D17
	for <linux-hardening@vger.kernel.org>; Wed, 30 Jul 2025 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869293; cv=none; b=eVoBpdEwV9bpzghqXmVoZJlMnfAyGzdaNl5wgfwJ4eQeBdE2O4Wm2XS37QK6p4JvdZbALmgKQYIInkWo9OxjUU8BS7BoVo35vz9k8DJxdRTvOA3vK01oJebLvPqxCKBL1UVkmdVook6WJUHkC0wtpkWDD7g5O1nzczTFaspOtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869293; c=relaxed/simple;
	bh=hp7bAnlyWbMe0UagxjClRdoFhPBImgjJBDcHhbMOPBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAZvBI3rHhCRC53yJ4nEqLD/vx6sSRyrRK8lwbbHBsvCQf6NT24DPauekGBl83ezBHx+W5p0q7+5eZd+SGu4hIyRQEjg+nGjyX0fRDku4xWyXu+yPTmI9Ou98KZvcxsGQnX0foUmAiOUabfd0lGcr23cGRmp3u/LD48ExT9UnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y6v1Y+rP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y6v1Y+rP"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-555024588b1so7110819e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Jul 2025 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753869290; x=1754474090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6vdhp2EWkPtq+IAr0ObGae8XoJd1fUV2G+NSQOgeB0=;
        b=y6v1Y+rPEVDHOkrqc2KWOfhiugmQ47csz1p9+cPsKrBxMu6N++Lx7mDSVzJx9n6oqS
         UB5hMz5e/MChLsSvAmzP82OKI7y6HHDsJkHIQqJ10ekWc9qTbZH4JevVzniY4W09B0A/
         VbMUa0prk04D/p8/3TRqlWvGNSKC2kXTwf/bhns+HC7/CXVhXgBURVJR/9r87Bn9GlN0
         gv/+LXG6hJV0a64I7ABkBgPr6iaKk6lKUYzENYZv0W+E8GgTmxZDjeJpjUQvzGsRYgUw
         UIsm9yMb4dS4lePbwKM+ubqez2QY+tIytNFSDWF2gXWKi7MulASGNSolQFMpNoSrFq9C
         RciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753869290; x=1754474090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6vdhp2EWkPtq+IAr0ObGae8XoJd1fUV2G+NSQOgeB0=;
        b=U+i07OGgje9i4zm3pqpb4qhmq+zTLZ7fKw68fEdt6UzBV8neuYOBvngCSiUQ3w/ka8
         jXiRqIPwJcp1giG6V6kR62C8rkObBJTCKaxu4KmMj8GIafuQh/vLWJ3POi1NSC9cqfNf
         mf21j6gXFgBJWCL60wQqQCJDPKeRK9ahustiytMqoFI7BBjTFOGJv1WHoF6nChsryAko
         UZI8eR/vJMSOR61UygB0oVcIQRFpZOUqRmdC0tWtR14FQ1jXQMTFrlegslFpJ9HIzIq0
         2/DFQc7ZyIc9FJ1M2xRUrCVOiCtk8tB+XZLXNsITgO7ZZl1NDPpbI2FdmCK8Q12+J6ez
         O6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWoEwLTpcbSvh6nULu61R4wFh0KWxDW7QDanty65qiaWkx1JO5Np4LCDP3VzImVrdRWCDDeL0u/li0Y0FbPZig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyws9xnmfTpzuItHm6UQhCiaLaZyoKCcfXmpIX2svM3AjV1HBKm
	F/37EVzQI7+raapWVNevAxuG5ZYTtnSHn2S2PpnatBRpoV+pX8hiwD10D+qsdWjo+ZB+/lTg1rP
	A6kkBsosEOWaAYMhxddkm1bX48Y/HdaNGtSX8jCS4ew==
X-Gm-Gg: ASbGncs2kmh6pSyVIyZswmzLTj4BHSNoErk/zrMaNoxa6ZgvMggv5aQS+pCkL+n+Lh5
	694KpExZSaGxHCNPapkcDQgi4c4zqY39kvCsRdQdCQ0mM4TGU2ETNRgSvnSWvZ6MwIlo0GZAaJl
	dpUW3KPO5RxTx+vAnEckerYkRO5+uckf0A3KbBv0RpVWeNZrqBVqm3bR3lj8sIkaXl+T/LSl5eR
	2zqdYXzrLOupAz/T2SVHjpKlmzcMR/s7etxcTk=
X-Google-Smtp-Source: AGHT+IFD0mC+adTu2tQIUqoYqi4YbEm6lb9KfHl4WlQUhUVwQ9owZPBnvnUOvhF+89ksRVwAv/r0YIR9B2aVVdKhoAo=
X-Received: by 2002:a05:6512:33c7:b0:554:e7f2:d76b with SMTP id
 2adb3069b0e04-55b7c0b0f66mr939851e87.56.1753869289592; Wed, 30 Jul 2025
 02:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-pinctrl-gpio-pinfuncs-v3-0-af4db9302de4@linaro.org>
 <20250724-pinctrl-gpio-pinfuncs-v3-12-af4db9302de4@linaro.org> <CAHp75Vc4vsJh_-GbP+YO50veoGoGtfAPL4tjcF+73uophfmnGw@mail.gmail.com>
In-Reply-To: <CAHp75Vc4vsJh_-GbP+YO50veoGoGtfAPL4tjcF+73uophfmnGw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 30 Jul 2025 11:54:38 +0200
X-Gm-Features: Ac12FXyouWksKyGI1Z-cYawOTPPQ3IbuMxJxWat2oIDr-ST0nxIlLBCifNIDusI
Message-ID: <CAMRc=Mc1ophkofB6MmtD4adBAi69C3JyovM-S9YD_y7UA3V1qA@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] pinctrl: allow to mark pin functions as
 requestable GPIOs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexey Klimov <alexey.klimov@linaro.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 2:22=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> >  struct pinfunction {
> >         const char *name;
> >         const char * const *groups;
> >         size_t ngroups;
> > +       unsigned long flags;
>
> Not sure we need this. If the function is GPIO, pin control already
> knows about this. The pin muxing has gpio request / release callbacks
> that change the state. Why do we need an additional flag(s)?
>

I'm not following, how does the pin controller know that the function
is GPIO exactly, other than by the bit set in this field?

Bartosz
