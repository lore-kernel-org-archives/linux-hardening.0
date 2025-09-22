Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624A192B7D
	for <linux-hardening@vger.kernel.org>; Mon, 22 Sep 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550642; cv=none; b=dusYdwiY+vXMHKv00Ltr3HxDPbxDU0ngkis1gMbZKC1J8Wq4HlI3jTCujk+GQhdHsFsWgpMSwVkVqz9S3hvyUdJGuzbH4Ri1GlHbvWpVIiYi7117jRPpe9nZgRalBqDGhmOC2wVjV46zukczLXFIBSZ1wnp/z/9GuOX2IETO5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550642; c=relaxed/simple;
	bh=fWzzdjlL6Qeihn+o/itxjEqN74qvQQO38r2QqurBj94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugKQfc+C/gnXIM7wRk0NE4QjjNetHpEzyn1qVShALElClrsj3rCENy6ntL9REQ1fEn7tAEZGgMJCrvb+Wfp0BFecUKYdF6VAmFTKczYHCau/v6VB4Eee8oNafe93HmG5Is2zd+slU4dXasPgEYb8rEbJ0T7Q0yMW7B80/eR59r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FJtRL/ii; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FJtRL/ii"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36a6a3974fdso14311141fa.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 Sep 2025 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758550638; x=1759155438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D42mDx7XES4dJT5DCpqob2SIIqhWq10lpNC2IIru3f8=;
        b=FJtRL/iilefnLtGJ8RHt8JgsdkR9Bwv5jp5h9u6hOudyZ6LPBr9JRFkLYvaXS5n/Pj
         3eN6Slc2BXlzCDaaPKfYUf5kPD8EA8rodgkufNy8SWMmZi14ttFzIAHz7CnvDpQbeG9P
         CltohY2KfFtz68kLonVt6XNO6gjd8lrIw9B9vlGk4wwxZvnWInWWjtBaC40wPJK9CDOh
         QnNLP1EwDbHlXAfEEI8M6895VghrF9762JOwmVEvQqjx+nH9TOnut8S28f/AwfvZjytS
         2Wn1dHe5v0Lq10jRdpBiKL4t3iN1tecmmm8LUqjTucWDL/g9rbqyOm3rXyuCvHdO41fa
         xh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550638; x=1759155438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D42mDx7XES4dJT5DCpqob2SIIqhWq10lpNC2IIru3f8=;
        b=rxcnq9dR82Yoo1hIKJ0cWCzxNFPmPYeY/asUvr2BrrATkZ9PDzbU3bTPcNtitYlBzd
         iHIE9qgYDBdJ3dH2jkguYd/kGBoteQEf1cMfEGwq2x5E7o9wvc9SUJ9xMymhp9fZ0HjC
         TBbb1osNY+hm2Sv0GqEBEjgEETWG2FwUpT3M5MqOrIZxD/b49Q9XRfGy+qmHBBGJPeez
         yQEV05J47ZTrPSm9hXbFTzYT3matCp1fk6K+LfEcYoJ3ERHe8zi5vEF/n5KkQN9qQpo4
         hC993hDXai6QC/41K4XAbGSjX8cLwp+296gY/oJ3kJoNWGhtx7iftjihTyN2wsZuHEMf
         BRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNiChpWifimM5wWytnwQD87Uo/jBDfOKhPboZsWOsLrgTKyEfMDji7DxB+7hjjxg8h5gqw0gyZ21yG5ekolVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0T04T3ll5DUmBK4MK2jf5NJXOblMhyfr6byRXVOnj7j8tdcO
	M6G3RUE58Q/Y8AbyVQ0dii5du5rB7gWyQ+cbkK7BFFtBjEZGkHY8J82OeQYFOsGxwwSqpBFesMq
	vK0IgEGQzgxT/wK9eZL5SxA8Hld3w/goLgyvZD9w6+Q==
X-Gm-Gg: ASbGncvwnaHNCZ78/ExbFbjD7lPN/NJeLBRtirY9pe7EJElKG314S0wNgKjbT9pR1/M
	S5Hp55lZ3UQPEtRWocp3Bwbxw/ndusGhmUoHpCPPGRuPROoxM3aEvk/Im/JCFhNu3JwWaav0fAf
	TbRqFZjuzSKqmUEoedOSYEI3VxgnGpgRIMvZUf9M00UFQvyx687bfTUDDx6z7WT7IGbp1F/rhPe
	krEdBZi46+Aw25B1IWBjU42a/6EVyTvYGFQCg==
X-Google-Smtp-Source: AGHT+IGS2AjVg06y9Gl4ZoVygRe0txj+WZLEO+s0iRtEWqABbE+tNtV+p0mvb++GTiupjPDEskTHy6Yf/wVmcolsOo4=
X-Received: by 2002:a2e:be07:0:b0:36a:97e5:c4a5 with SMTP id
 38308e7fff4ca-36a97e5c8d3mr17177811fa.39.1758550638057; Mon, 22 Sep 2025
 07:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
In-Reply-To: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 16:17:05 +0200
X-Gm-Features: AS18NWBBtPPpfa65LcAbGVqvkVRIVUyroOGhaWLkgkmXpHaSdWCO_RUkKb2djeo
Message-ID: <CAMRc=Mc4hO1LDumxAfkB1W6miTJXR1NUVAKBVarkwiF2yGvSLA@mail.gmail.com>
Subject: Re: [PATCH 00/10] RDA8810PL SD/MMC support
To: dang.huynh@mainlining.org
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

On Thu, Sep 18, 2025 at 8:49=E2=80=AFPM Dang Huynh via B4 Relay
<devnull+dang.huynh.mainlining.org@kernel.org> wrote:
>
> This patch series aims to add SDMMC driver and various drivers required
> for SDMMC controller to function.
>
> This also fixed a bug where all the GPIO switched from INPUT to OUTPUT
> after the GPIO driver probed or by reading the GPIO debugfs.
>
> This patch series is a split from [1] to ease the maintainers.
>

This is still targeting at least 4 subsystems and isn't making the
merging any easier. Are there any build-time dependencies here? If
not, then split it further into small chunks targeting individual
subsystems and the relevant ARM SoC tree.

Bartosz

> Tested on Orange Pi 2G-IOT using a Buildroot environment.
>
> [1]: https://lore.kernel.org/all/20250917-rda8810pl-drivers-v1-0-9ca9184c=
a977@mainlining.org/
>
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
> Dang Huynh (10):
>       dt-bindings: gpio: rda: Make interrupts optional
>       dt-bindings: clock: Add RDA Micro RDA8810PL clock/reset controller
>       dt-bindings: dma: Add RDA IFC DMA
>       dt-bindings: mmc: Add RDA SDMMC controller
>       gpio: rda: Make IRQ optional
>       gpio: rda: Make direction register unreadable
>       clk: Add Clock and Reset Driver for RDA Micro RDA8810PL SoC
>       dmaengine: Add RDA IFC driver
>       mmc: host: Add RDA Micro SD/MMC driver
>       ARM: dts: unisoc: rda8810pl: Add SDMMC controllers
>
>  .../bindings/clock/rda,8810pl-apsyscon.yaml        |  43 ++
>  Documentation/devicetree/bindings/dma/rda,ifc.yaml |  45 ++
>  .../devicetree/bindings/gpio/gpio-rda.yaml         |   3 -
>  Documentation/devicetree/bindings/mmc/rda,mmc.yaml |  92 +++
>  MAINTAINERS                                        |  18 +
>  .../boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts  |  20 +
>  .../arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts |  20 +
>  arch/arm/boot/dts/unisoc/rda8810pl.dtsi            |  47 +-
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/rda/Kconfig                            |  14 +
>  drivers/clk/rda/Makefile                           |   2 +
>  drivers/clk/rda/clk-rda8810.c                      | 769 +++++++++++++++=
++++
>  drivers/dma/Kconfig                                |  10 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/rda-ifc.c                              | 450 +++++++++++
>  drivers/gpio/gpio-rda.c                            |   4 +-
>  drivers/mmc/host/Kconfig                           |  12 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/rda-mmc.c                         | 853 +++++++++++++++=
++++++
>  include/dt-bindings/clock/rda,8810pl-apclk.h       |  70 ++
>  include/dt-bindings/dma/rda-ifc.h                  |  28 +
>  22 files changed, 2495 insertions(+), 9 deletions(-)
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250918-rda8810pl-mmc-3f33b83c313d
>
> Best regards,
> --
> Dang Huynh <dang.huynh@mainlining.org>
>
>
