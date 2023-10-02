Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1417C3
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 07:19:24 +0000 (UTC)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB04A99
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 00:19:22 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-493542a25dfso5764955e0c.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Oct 2023 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696231162; x=1696835962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJYpofyuAEv4jvR+QfJqDzbesTQIm4BiLwBiP1RFTxg=;
        b=FD2cCmBvfbdxp2rLmRGjB/OdFADslsSKGVp42pVAxaeWvBZszsCx24W/Kf/JZlwFiM
         jmXKHNwLPquWnloEZgDT0Qgu3/qLuEaLJGf5CWPSQbuTMXUNkS+nZgFEnc0EmtDMv4G5
         oNhdzAczo3SAKu/rdINO48fWzDqmTg+Q9/XMrkdDpWjON2s1IJKoIQ45rwG+k8rxsiww
         F3SptW+aY75B1Eu+t+YjUBtZU5vfD20WIJgOzRClGNdqUsJaE4kzA5/9wXqtGQDv8qgB
         x+kKLxexiMva5x3RVrzqAS9/gxQDPsnMt8KEDkeGDkHRACtzCVdT2nLSQNHoyjIx9sQX
         Ny2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696231162; x=1696835962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJYpofyuAEv4jvR+QfJqDzbesTQIm4BiLwBiP1RFTxg=;
        b=vlh2BMOMdzS7/dt2BRhI5NPyVGy57fZgd/5r3stkSj8SjUajIeSlxP1eZE7ZvQ2/o2
         g+aOL6N73gkvwET/72cQtRgbG7NQz+wKGBEo05Ihu8jtBXj0kSGUai++bKDFob5H7sbe
         UNgtDmCK2+stg8m41Fh8ys7ShV9uK1P+6GvPIFavDh8sVWzzHMONIaaEFSeqBlNCnJ2O
         DQ/9GJyajFO6LcPA6G1UWGpZ0AqEf6/exjz6bcXfcySq83sas2SwdOBHpaZABPfBrIPe
         RAwz7r75kfgH4r/BwPrfipD4S54lVdXE98e7ggO/4fVp7naSVXKefbbRrodPjGb9Hi2j
         kZYA==
X-Gm-Message-State: AOJu0Ywq/kWZsDVimegO5m/zoLdRZINg4f6MdgWR+IPpGuhcFsHv/mP9
	fttTdzxyfJfUm0iKMsTb+yFtTEeizbn1fy6ny7VGFw==
X-Google-Smtp-Source: AGHT+IFzc+4NII5E+Bbq2HSe+Tfh0b+oyGG0oCJoYCRjhheamRaNHC0qOW9XNPegrbm7tafeSUWThKV2MC2+atCwOHc=
X-Received: by 2002:a67:fdc9:0:b0:452:829e:ac90 with SMTP id
 l9-20020a67fdc9000000b00452829eac90mr9154479vsq.28.1696231162035; Mon, 02 Oct
 2023 00:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929-pxa1908-lkml-v5-0-5aa5a1109c5f@skole.hr> <20230929-pxa1908-lkml-v5-1-5aa5a1109c5f@skole.hr>
In-Reply-To: <20230929-pxa1908-lkml-v5-1-5aa5a1109c5f@skole.hr>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Oct 2023 09:19:11 +0200
Message-ID: <CAMRc=MerAnyZd08S61YEn6Gu0VmK+KmNyChbtBuCfBpaUGFvug@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 1/8] gpio: pxa: disable pinctrl calls for MMP_GPIO
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, afaerber@suse.de, balejk@matfyz.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 5:42=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:
>
> Similarly to PXA3xx and MMP2, pinctrl-single isn't capable of setting
> pin direction on MMP either.
>
> Fixes: a770d946371e ("gpio: pxa: add pin control gpio direction and reque=
st")
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> ---
>  drivers/gpio/gpio-pxa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
> index a1630ed4b741..d92650aecb06 100644
> --- a/drivers/gpio/gpio-pxa.c
> +++ b/drivers/gpio/gpio-pxa.c
> @@ -238,6 +238,7 @@ static bool pxa_gpio_has_pinctrl(void)
>         switch (gpio_type) {
>         case PXA3XX_GPIO:
>         case MMP2_GPIO:
> +       case MMP_GPIO:
>                 return false;
>
>         default:
>
> --
> 2.42.0
>
>

Queued for fixes, thanks!

Bart
