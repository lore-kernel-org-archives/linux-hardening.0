Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD0316194
	for <linux-hardening@vger.kernel.org>; Tue, 23 Sep 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613736; cv=none; b=kCMoJHL9277axoWUmiahR1EU4d9LAKDVABZ6RaDGeP9xLRi6sAodUFh/0QV1Ixe76HS8o3mtDPfB9CYVOVsR7VBf6eZ3ksFBZLeZLBbUFuvVGKRkIZX7zqbPz/u82SI4LFRGJnGn2R2A31JS04AdWIM7/BAz+uq02HXW4pHRpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613736; c=relaxed/simple;
	bh=AJaxzkgGMS2WBlrlop8PHPlSP36j70ySVSvjHs1aEs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeXuYnk2aS4idxrlBYLHLyCOAWY/JPNaC/omlKeMl4Ok/sgPeQZOakTzbMz79r2JY8Fy/a3B2Uads98LFv4Wv47s9NQUOWx/Gtp3gIRiQ6np8pD3b26WpOLZncphbrzRiznd2+SuurbrpbQMBEEDkabyyJ5I9Bz5ApR2xZtqLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Eznf5cwO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Eznf5cwO"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so3056420e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 Sep 2025 00:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758613733; x=1759218533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJaxzkgGMS2WBlrlop8PHPlSP36j70ySVSvjHs1aEs4=;
        b=Eznf5cwOZ88V2MaKv6rCtt4MAxUW5dduUvOhPTHPEjhrlHMPdtFYL4g4qYiFPuFWR6
         yRDDhVGIZ6DAt/SLexaLsJ/KzyndNLZjcqXhu4E2VfIOM+HoLI+eheKVIE1NGXowZAk1
         yA14gM8ifFev7H/ctGl7NvU+O35jBj0uPidDyla1urUOMuP1VUnC4mYP/kDzVshUgnVy
         5HpRSv7cAmu0dNByp8t0STC4EtGaMvBVJ3rzsrwYRC7PgGZmil1bFZeL5Mq8k6NBoj3S
         5/T71ntfl4kZ5JIOnCaaRgMy4+X+mUCOuT9otCord4WGZj3z/5owucBaHuWvnfO7zr90
         r5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758613733; x=1759218533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJaxzkgGMS2WBlrlop8PHPlSP36j70ySVSvjHs1aEs4=;
        b=fAgRLJe+zMv7MQnxZZMiwsB6wtiuFzifP88BfFhLj1qiBS0YDFp7sSx7RfHOPzLKtd
         iad3Zdp3O1JJTCzO01efmzzYqeccryCdtpMUDvgX/c+uoDsYRxmWVPf489feVPOTtg2t
         pL3htk5ZoLcwHyX1qvu3dZYriqAyFg13/GAv4bKa8ia3yJ4RnNYID/0FcwyRPMOXh6CQ
         TlXDkyNUknwn3bKetDg0jl5hgwr9ZkDpZfozICnGgOND+V9/z0W5WKt6ucucKUWIkT4v
         Du5XQjT42AmhuJ4l7cvk7A8TqXBPi4vd2OZdXFmgFIOrm8uss9FIfGowVLXP+az98NV8
         kx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTpDEL6nUiCyJTcwykIFUt/bpaztQZ3o9GLQXWWVuIhwCUQgITbhkE+W8lHdo3daX/4HJMWvdD0iAzlJbx+CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEII9ulQM4lkE4Fh+ltvzuE67HERfmU5vo9ZrkFFYXhkVKrha
	iAWMMmKMrtle4RdDRt9mXrSbbrHKlKYIPYHaGXmNbpLQxe+w4qOdPehutlJmU9VxmhtjFVu52zy
	fgMakq6zny9pw6BfJW21oOcSqm4D7wVFIytNx0xat+Q==
X-Gm-Gg: ASbGnctr3JhCWrScFMSS7Z1erMv+NuSfeVsa7jAXm1UtcjB3Z2AkI4EfzELXco4JrFQ
	FFyKUw/NYfEFgeEgDcplympZbm6HbwAFE+CxahK2kz3zkjO13BigZtWCNG3MMvFIsh5nhM7nPQQ
	SpwWhAFDSA/Wq7lco9iAlYM+I8slQEkYSFcOlqdOd1LuBJYsVAuz/CaiOh3E9VYuJYmXXRKBn97
	rUlG4WGCeRyJTOCD738qRiSTqb6AghNQBnOg26QHUT9+JNt
X-Google-Smtp-Source: AGHT+IFXCbUC7OKlJXhiIcyp3/0pEbhIPcVmkwcaoRpLoXztj3Zx0ZDwfLpI5huj43NEMpkp0HP1DS+xrpQFvaRxUT4=
X-Received: by 2002:a05:6512:b19:b0:578:cee7:7aa9 with SMTP id
 2adb3069b0e04-580734f07d9mr498868e87.48.1758613732567; Tue, 23 Sep 2025
 00:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
 <CAMRc=Mc4hO1LDumxAfkB1W6miTJXR1NUVAKBVarkwiF2yGvSLA@mail.gmail.com> <2wwi3ktbcuyp7y7mqplndvawagae5hdhcx3hn375kycoqtows6@xcww2237rxpe>
In-Reply-To: <2wwi3ktbcuyp7y7mqplndvawagae5hdhcx3hn375kycoqtows6@xcww2237rxpe>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 23 Sep 2025 09:48:41 +0200
X-Gm-Features: AS18NWDP_wgtg5ZAo1aJS0Vwp6mqsgj6RBa2BQg1A6VrGdFXcg4GLeRrQ88qOWM
Message-ID: <CAMRc=MdhQMR=-ayz+GfigUMVy+j1QNO3LguMoZYa5_+Es3E5Ow@mail.gmail.com>
Subject: Re: [PATCH 00/10] RDA8810PL SD/MMC support
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 5:45=E2=80=AFAM Dang Huynh <dang.huynh@mainlining.o=
rg> wrote:
>
> On Mon, Sep 22, 2025 at 04:17:05PM +0200, Bartosz Golaszewski wrote:
> > On Thu, Sep 18, 2025 at 8:49=E2=80=AFPM Dang Huynh via B4 Relay
> > <devnull+dang.huynh.mainlining.org@kernel.org> wrote:
> > >
> > > This patch series aims to add SDMMC driver and various drivers requir=
ed
> > > for SDMMC controller to function.
> > >
> > > This also fixed a bug where all the GPIO switched from INPUT to OUTPU=
T
> > > after the GPIO driver probed or by reading the GPIO debugfs.
> > >
> > > This patch series is a split from [1] to ease the maintainers.
> > >
> >
> > This is still targeting at least 4 subsystems and isn't making the
> > merging any easier. Are there any build-time dependencies here? If
> > not, then split it further into small chunks targeting individual
> > subsystems and the relevant ARM SoC tree.
> The MMC driver depends on both the clock and the DMA driver.
>

But is the dependency a build-time one or does the MMC DT node
reference clocks and the DMA engine by phandle? I assume it's the
latter in which case it's fine for them to go into next separately.

Bart
