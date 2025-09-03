Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A892DCF73
	for <linux-hardening@vger.kernel.org>; Wed,  3 Sep 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895655; cv=none; b=j7Wf+f0bM/v2TIk9QUIFCXuvG4ooJaqcxV896gQ2bCKRy6FpBe2o4DtUu2uc3AOTWJxdXalwenZTBChk9CwwnWL/Ug3G5ul2F8AMg+x3kpM2Kvf2PKD3NhCWvZ+AGHUevzIMwl1SrESmn73QgBC2vygve8ewOzsE9PP+lcuH1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895655; c=relaxed/simple;
	bh=AVAB3SPxcLA6cClsIyttHLnupSB+I6SCJnu7WODswL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L93Suj3KMePXhwbKJzbdTHPhBmrCg/01j9heYFALnQ4E00rWap0XbZHWmlSyNUmkTFIrIfQk6NUVDcwzhQJMXb2o52VV1hvrx9vYLRSGbp12nXnZvluBJjFyHUQTJZTtfZojyUW3fFwHG5fHzVQG8x6caY+iFxTZ2BDPZmrvfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S4+HAp7P; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S4+HAp7P"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-336b908cbaaso45105071fa.1
        for <linux-hardening@vger.kernel.org>; Wed, 03 Sep 2025 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756895652; x=1757500452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVAB3SPxcLA6cClsIyttHLnupSB+I6SCJnu7WODswL8=;
        b=S4+HAp7PfnL+7xT3FUacCfdWe4tC9q7HLKsUbv5UGPDfDaAYUtVsjTDSx3VCkMGHdx
         gn5lEhOcgYEjdftLOzcobBZzTHfb1cq/4Fj6sSHClvRBh0lEB/NHSCOjsWwlCgD932dz
         gxNGvfqPGarlOwH8J/5fZdSoyaLy7C7OTULWZbdXui9IMOM+PRiXLCLngjMmQCQ6x2Zp
         WBEjHaf5unGtOE0boSEf2Na5o8rP2ZvithVHAlnQ6WOIrndRC+2L8IWJ/DemcHWBkDRI
         pVYV9JNhY8gb/3Tzeuljoteyy/ZR03rTke7wP+AdAgOxK8ZmtkrAu04ZH5dj01swXs4o
         7GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895652; x=1757500452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVAB3SPxcLA6cClsIyttHLnupSB+I6SCJnu7WODswL8=;
        b=RUIP0KJCdXGWLjeW0AS6uwoM8fQHER8NPNQwl6bFaP8yEb4EejcXuuFFTXtuVupBpG
         8BpM8VX0uauKzQlly+9/Ooitv0KOQm9hDZme6UfYdG4DjUGr+S13heefA+cSSOtlW0V8
         Li1ZbGTho57Un/NovNry8uIqGcM5nphCyxdkii+s2ZPW15YkTm/864a29+3oxyOZOvdb
         qi/D54z50gM0aWPXd9A0fHDTPgvB38DQsWjFGePTC9OiWNPtZMgc9yeou0gRboNvdjZ6
         KZnvrh/RhUnWuSrIjm/1s3Fb0Bjcbqo9wPnjp0PdHv/y1NaHes/RW95gerjjyh6vrKGw
         3BPw==
X-Forwarded-Encrypted: i=1; AJvYcCVow3NJso48VPJXy5ZHKx5xInQVVsrRGntVmBXXYOP80mKsv++5JwOPVTlkYTH5gZlhxpA4zzPA5RQ9bnx3YgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3e6Z436Q/2U5odBWZD82Vti7/ZaUqKdonL5Bf7Iu/LPdAozSJ
	SgrXLKsoBRuN3PobnckpyIYihO4XvuJJokAZpEdLN+N5o3C086r5vbdcHP52sQ5Nm6v7X0OW7dL
	aMNUiT8LXO8mLdAXHan6RDMmiYfVd04iAs9bCFmSwjw==
X-Gm-Gg: ASbGncvySyZttM24gB3qAkt8+EL9oT5m6dySRuqoBCwvjsePC7ww5cgnWRhL4Ri57MR
	NQGW2W9StBq50hWsc2M4J2HRcxejrKmSbkdzv+Rd6ntkRfV+imm87r/RVoF4/6yHhhva7e+ESRU
	p1fKPxIYtNbVbYPeJBqJmTRFtVm3SZn03nQjZJl+4XPgCeDpaEYJymzTm+RtBtT3qIGDiPP3iMo
	mlH5MJymtC3KkTTNKn8NjkutVQbSv4VG6OCb2gYikLi/rNY6Q==
X-Google-Smtp-Source: AGHT+IGoaflavucoSX1WEgopzKKcdrinu9KA/FkcvAd1RueKhs+WVyWiixXNe2xfLOG4W6BWq8swdn67NOOrJeNUBug=
X-Received: by 2002:a05:651c:40d5:b0:336:8fa8:e03c with SMTP id
 38308e7fff4ca-336caf36f96mr24077381fa.31.1756895651781; Wed, 03 Sep 2025
 03:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pinctrl-gpio-pinfuncs-v7-0-bb091daedc52@linaro.org>
 <20250902-pinctrl-gpio-pinfuncs-v7-16-bb091daedc52@linaro.org>
 <aLcBcjvMbrxoDYoC@smile.fi.intel.com> <CAMRc=MfcFMgkNqWNZV5o0NxkAvxBTjC3vv56Cr98n0R2CkxuPw@mail.gmail.com>
 <CAHp75VcgaqnDrPH27wxfgyK6zz4RAKJQB0r7G2vbTONTxkEzTw@mail.gmail.com>
 <CAMRc=MfhhX2NJ0fhhX8u+7=sdyUy0G27n7caGf9=TpHxUDJVxg@mail.gmail.com> <aLgW7J-j4nn0u8uo@smile.fi.intel.com>
In-Reply-To: <aLgW7J-j4nn0u8uo@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Sep 2025 12:34:00 +0200
X-Gm-Features: Ac12FXzivaaUXd08fTdsNp_v1t2v6QHg93m25vorvolXWMo4UMb6c0rxngkBDGg
Message-ID: <CAMRc=MdA21fwnamymG6YhqBjKDso_nJs_4xefPNONQNfEcPHXA@mail.gmail.com>
Subject: Re: [PATCH v7 16/16] pinctrl: qcom: make the pinmuxing strict
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, imx@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 12:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Sep 03, 2025 at 09:33:34AM +0200, Bartosz Golaszewski wrote:
> > On Tue, Sep 2, 2025 at 10:46=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Sep 2, 2025 at 8:42=E2=80=AFPM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> > > > On Tue, Sep 2, 2025 at 4:38=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@intel.com> wrote:
> > > > > On Tue, Sep 02, 2025 at 01:59:25PM +0200, Bartosz Golaszewski wro=
te:
>
> ...
>
> > > > > > The strict flag in struct pinmux_ops disallows the usage of the=
 same pin
> > > > > > as a GPIO and for another function. Without it, a rouge user-sp=
ace
> > > > > > process with enough privileges (or even a buggy driver) can req=
uest a
> > > > > > used pin as GPIO and drive it, potentially confusing devices or=
 even
> > > > > > crashing the system. Set it globally for all pinctrl-msm users.
> > > > >
> > > > > How does this keep (or allow) I=C2=B2C generic recovery mechanism=
 to work?
> >
> > Anyway, what is your point? I don't think it has any impact on this.
>
> If we have a group of pins that are marked as I=C2=B2C, and we want to us=
e recovery
> via GPIOs, would it be still possible to request as GPIO when controller =
driver
> is in the strict mode?
>

Yes, if you mark that function as a "GPIO" function in the pin
controller driver.

Bartosz
