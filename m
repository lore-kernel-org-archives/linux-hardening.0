Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610DA33BBAA
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715837; cv=none; b=K37VvahdKKKzG8J5kMiPz7EG+st4/ZTPm5k6q/q8S2ftgJktJZmkd9FyIeYf6zEQ99x07qtKFovhqqGtXit2N7LQkl/12RU4txar1XXIFMpemSCtCRb7hNnL/TSncwlD8Atkaphf2NpnoAlWXmVsJIgrIyQXneZog98GyTqdHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715837; c=relaxed/simple;
	bh=7oJ3FzW76jvcvPZYZdFnXMjjUYeOTlfsS6uSULymDYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXq+YA5xkCWavEuwCJ1MjMWqewjywI865XVql/rJb0G++oWglQMNhMRgeYU1Ly///ISfCIGzN2kDWhV0t1eyYDfxf51tPyATQJ/jNdQoaadiPf1vOoYc2cn21J6oiiraHVSjihVfZHNyyD93PZqR76rM5k9FttWsCWHb+Cv15jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=crNDnz7J; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="crNDnz7J"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5959b2f3fc9so1739218e87.2
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 01:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763715833; x=1764320633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcWFlcuSs7Y0eO4oq2DsaroJj7DisvwmuRZnugA2UKI=;
        b=crNDnz7JsKDrVf+c9ML/Yi+wl+7ATQVsTeDb7bd1ZUZ70TcLTwxSohtrwcY8zcZDE7
         ebiP3Uph5U4pDL9jBv9CM9hmLkIqU+MRGi+0jwvV3MD52m6d09loKJvpDu7iZNQqNFZw
         UnE55uyAv8afXzudxDdS0IGR+MROfaDgUDAJHZYHYOIKlh5sk1+KVSfoDyfiXAStHGkC
         86niqR/buV09FsAgkYyVa2nRx5NqXW049/otL7pzrwneiSXiNCDwdSdEm7D5x0uo48T4
         YLxJIvgfOON7gtGahs584M6LoOsUB2OrS6zD1Qg2YtV58G30k5B3aIujKzHFKxjWIIdH
         v2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763715833; x=1764320633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qcWFlcuSs7Y0eO4oq2DsaroJj7DisvwmuRZnugA2UKI=;
        b=cggFnd2zNgevCA6kUM61aXb3QQf40vsPYilq+7yYyp+Br1uk6h2adRKiEViqM3ZOfh
         DdN+3bC4tjdqabIWbCBAFJoaYlRCxantWKUSR8krnsk762vltJKiiC9iJZMSaQEq4VLa
         JcLNFY6XC6N8uBznwKFh41H/a9dRS+n/gB1F/O+ii/px6FJOTIjtOmCFhcw98hEFMMVt
         gFYLQWnYodeytaSbO8RfvcqF1PVSohaLPFWeizd7Sv/1W9FtIy1B3pJv84y8bgY5m+Vk
         Ho4+fW7cVlhat4TrnFrjyxS2yrYom20uyOx7VkS37cmxRIOX5qkrFU64ET4DCZhikDjl
         AJaA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Nu9+8n+Zco3vPyceUwjjmqW5XHExo6PCVl/4jmiT3h/nlzhUtCty9gZP0zJ4s4Tlj7FXIiNd8EKOr+pcj28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ikaitFi7Kx5/rJLbi/kr6ufcp3k6g8fy5YKfk1Dpfjv1I1jU
	aTrrWjqzLaIS+Pk5HSflcpVgX6jI6n26ZAu8mFIPakT45rbWhDyW4REhF+cCfJuoJRBtNREyGIC
	T0akTIJFBg0t7guOQQGF1CWROKRvdejHCqOsdzkk71A==
X-Gm-Gg: ASbGncsigW59vIGZEmOphleLw9b7HDf2aySpm4Lup2xzprvMuZw6W4rV6d4e1wwSydb
	G/Wo0eSulDh/gM5p9TzWMWojIOPRKusYyrP1e2v0vWs2A4rOsBAVgvvCE0Ur5uj65JvPpiiHGfI
	DYF3JDwHcqLoaDdg/QHpxnw+0g5qnrIzYrQWdcz0nKx92ltpl5OqvD4OJS3ESVHQUP2mNnc+OIV
	/1h+t14bA+UfVVeOpcwqZojjdlhSuNuoZEN4RO1amVPiyFRO9jXbL/8uCp//Nh+ATdOYfR1nvxy
	LRRNtl4bMV+8JOhWu3mJXSb1yuc=
X-Google-Smtp-Source: AGHT+IG0xMLdX41Lvo7vBm08ZV8ZEpQ5JhaXD6X3/W4zoN34NhHz8H25fTpuCQYyNb+ut5xnYF/JFxp9/xuV++nbU+8=
X-Received: by 2002:a05:6512:e8c:b0:594:2f72:2f7b with SMTP id
 2adb3069b0e04-596a3e9fd96mr603564e87.6.1763715833160; Fri, 21 Nov 2025
 01:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org> <3b5d9df5-934d-4591-8827-6c9573a6f7ba@packett.cool>
In-Reply-To: <3b5d9df5-934d-4591-8827-6c9573a6f7ba@packett.cool>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Nov 2025 10:03:40 +0100
X-Gm-Features: AWmQ_bkRtfIm-ZUN8rNvHIz8drG7ooSNLpBN4-3cE0G66VIlgSyBd_sHX8YgQAA
Message-ID: <CAMRc=McHCG8N0zeVUUvYF+rHqBrBKe52o+pf+Hjp5dnG3+NmjA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] gpio: improve support for shared GPIOs
To: Val Packett <val@packett.cool>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 1:28=E2=80=AFAM Val Packett <val@packett.cool> wrot=
e:
>
> Hi,
>
> On 11/12/25 10:55 AM, Bartosz Golaszewski wrote:
> > ---
> > Bartosz Golaszewski (10):
> >        string: provide strends()
> >        gpiolib: define GPIOD_FLAG_SHARED
> >        gpiolib: implement low-level, shared GPIO support
> >        gpio: shared-proxy: implement the shared GPIO proxy driver
> >        gpiolib: support shared GPIOs in core subsystem code
> >        gpio: provide gpiod_is_shared()
> >        arm64: select HAVE_SHARED_GPIOS for ARCH_QCOM
> >        ASoC: wsa881x: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE flag from GPIO =
lookup
> >        ASoC: wsa883x: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE flag from GPIO =
lookup
> >        regulator: make the subsystem aware of shared GPIOs
>
> this seems to actually have caused a regression for me, audio does not
> initialize anymore on hamoa due to EBUSY since upgrading
> from next-20251114 to next-20251118 or next-20251120:
>

Thanks for the heads-up.

> [   11.748781] platform
> 6800000.remoteproc:glink-edge:gpr:service@1:dais: Adding to iommu group 3=
0
> [   11.785864] wsa_macro 6aa0000.codec: using zero-initialized flat
> cache, this may cause unexpected behavior
> [   11.796964] reset-gpio reset-gpio.0: error -EBUSY: Could not get
> reset gpios
> [   11.796984] reset-gpio reset-gpio.0: probe with driver reset-gpio
> failed with error -16
> [   11.894662] reset-gpio reset-gpio.1: error -EBUSY: Could not get
> reset gpios
> [   11.894676] reset-gpio reset-gpio.1: probe with driver reset-gpio
> failed with error -16

It seems like it's the reset-gpio driver, not shared GPIOLIB path?
This driver has never used the GPIOD_FLAGS_BIT_NONEXCLUSIVE flag.

> [   12.006938] wcd938x_codec audio-codec: bound sdw:2:0:0217:010d:00:4
> (ops wcd_sdw_component_ops [snd_soc_wcd_common])
> [   12.006964] wcd938x_codec audio-codec: bound sdw:3:0:0217:010d:00:3
> (ops wcd_sdw_component_ops [snd_soc_wcd_common])
> [   15.424657] qcom-soundwire 6ab0000.soundwire: qcom_swrm_irq_handler:
> SWR CMD error, fifo status 0x4e00c00f, flushing fifo
> [   21.994354] qcom-soundwire 6ab0000.soundwire: qcom_swrm_irq_handler:
> SWR CMD error, fifo status 0xe00c000, flushing fifo
> [   21.996001] qcom-soundwire 6b10000.soundwire: qcom_swrm_irq_handler:
> SWR CMD error, fifo status 0x4e00c00f, flushing fifo
> [   21.996239] platform sound: deferred probe pending: snd-x1e80100: WSA
> Playback: codec dai not found
> [   21.996248] soundwire sdw:4:0:0217:0204:00:0: deferred probe pending:
> wsa884x-codec: Failed to get reset
> [   21.996250] soundwire sdw:4:0:0217:0204:00:1: deferred probe pending:
> wsa884x-codec: Failed to get reset
> [   21.996251] soundwire sdw:1:0:0217:0204:00:0: deferred probe pending:
> wsa884x-codec: Failed to get reset
> [   21.996253] soundwire sdw:1:0:0217:0204:00:1: deferred probe pending:
> wsa884x-codec: Failed to get reset
>
> gpio_shared_proxy, reset_gpio, pinctrl_sm8550_lpass_lpi are all built as
> modules and were autoloaded fine.
>
> This is wsa884x (not wsa881x nor wsa883x), failing in
> devm_reset_control_get_optional_shared..
>

Can you enable DEBUG_GPIO in menuconfig and post the entire kernel log
somewhere as well as the output of gpiodetect and gpioinfo after
booting?

Bartosz
