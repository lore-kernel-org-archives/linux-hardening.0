Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19A2522A0
	for <linux-hardening@vger.kernel.org>; Tue, 13 May 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141394; cv=none; b=AFGSHRgm1wA2cCl2dbEF4bF+yKPp3kOUwq108vLQWM6Mb5/cV/esEmfNLsmsVyHVo6LuSgd8zl9dMpC42ePzS8vpDbetxhA7jTKaMWhrtVSq234yeTj5a55akK+AgC9ACnuEj2N4RiSefycIt2eYL3WnT/oRiDxgm0piHgidc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141394; c=relaxed/simple;
	bh=x8ieU4EKi2B4fi65n0AYV5vqCBD7U2SnDPQDI/RK5MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaU5QEzcJeH3i/Dp4RYbQ/CI2JZNAwIZcF59RWSE7T/xhKGWE2w2PGSBi7d4KVdt9+jZOSayahf5eyWHh8w1piQH7NvnQCk1CZoUWysXOehz4zIAR3TFtJ2S5nL5VuWIlBOoq0GRGmTlrcx4rZIryebbuWx7GldXDNowcX8y7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LmdMWaiY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LmdMWaiY"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-326ba41006aso40498291fa.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 May 2025 06:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747141391; x=1747746191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bckFuN4azCmbNe0b2Ogt/F42jsbbCCh007jmdEYNzmc=;
        b=LmdMWaiY3rwMXY65xWrlSDrBZm5+MGKWVYjRItOT0iySYAjIoFEfFtvNH4HibHVQ//
         Bf6oHPC0ut9DSRzLtOwFIbO+OzGEgRfk5lJ0siI4SBah5tzM8VkXj3qjrbplEN2nF/Ig
         JadL7xMuwjzGvvxvxQEIgku4Na98fQgev1cYh0XvgeKXGwQdDDSA+zfiPXq/s66G1QhR
         npOA1HcJcpPOXu4PnyqSD3fhfn9EYg6mLY2p0VqvBBVZAwdFpfBhLLCxqtMKv736vK+h
         CpN336LJDgfy28yB9itUMJmzcODbp1TzZDst3saL9ulFEz2ZB196gikdTxVQ9wwtY+8A
         7ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747141391; x=1747746191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bckFuN4azCmbNe0b2Ogt/F42jsbbCCh007jmdEYNzmc=;
        b=A7oUfxXBCGF/9fJ3SvKIsd3PWUuuXBYoQyXzT4+4bKU004uEj4rlPOxwG9fj2l3yN5
         eydayS2sbMJuQc8Vz9IsZP/EL1t1aQHYLNZzvUcRG9XW7Gwi0NnFwRfYUxDRCFDuws/C
         82le2Rh0Wi1gWTXY+RzOV6lHsnMpCH/NeWchzCm4wzntlcODI+6ZGkagsrCgMk560Js9
         ce1zzpoREVrfd7ZFsAivvceEL6HJnh4bNrUX8CBi5CCAPb78LtkEYyqThGjEvjT1iffj
         0E+1VfAJWLK10DMuDCFzmGRiqYSXeqHYTxmoFMzgQnXiZhwxgLSZJ79RZPZMs+ABnV2P
         wFGA==
X-Forwarded-Encrypted: i=1; AJvYcCWDcpObg8OdMOnD4qN4xpFyVRFnsnjQMmBnEwc5AN/YFxiAgRZjPmgpFDpH3D4drvxBP2PH2e4EkJEInqLhlZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/x6QdJFCK75T61rvkwpJzlyn0Yo2FKT/v65K8WLh3qlrjUGS
	HSfdpIlj6ZA7k2IxF90nBIrKr+bXD9r1T65FjBw76zpwE0avjIP0/d79eyL75DSa4N6F9RglJyI
	ldbviZDddw3zPKzW2iIT97nG906oXl5jxLZ/DZA==
X-Gm-Gg: ASbGncsykU9bHNcqqD5rEzpfVjV0RlYT+gh4CiB8v6rKh8ZcqF+ShZBbxgsF+k6TmtZ
	d8HbL/L5mV7TR7+OXqwc0qOQALmtEs4O5UT61mO6Y7Hgv/KgUTsPNEuvHU8M3muqrwhanjKYT+X
	lV/Wo0EtnQQ8Sxh8L1MdsGAWPwReE81YXw
X-Google-Smtp-Source: AGHT+IG41x6HOlIO0IJUYhQJ2UY3oU18tjuuOsvxrjmQ22T794qYcI75spC45YpUWkdDO5fUQhcFroeonzakK7RK33I=
X-Received: by 2002:a2e:a549:0:b0:30b:fe62:2329 with SMTP id
 38308e7fff4ca-326c455e0bamr65757501fa.11.1747141390612; Tue, 13 May 2025
 06:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-aaeon-up-board-pinctrl-support-v5-0-3906529757d2@bootlin.com>
In-Reply-To: <20250506-aaeon-up-board-pinctrl-support-v5-0-3906529757d2@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 May 2025 15:02:58 +0200
X-Gm-Features: AX0GCFuUcIfML44aAdhDDQyW4WElAah3qOFUrVK8KAK7hsanUNq0ZohV10DNP3g
Message-ID: <CACRpkda8XSuO8-pY8K4gRsK7Ny6=PqcgKdrK+8A-3ghCfRTBLQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

thanks for working on this!

Also thanks to Andy for excellent guidance on the series.

On Tue, May 6, 2025 at 5:21=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> This is the fifth version of this series, addressing the few remaining
> issues identified by Andy.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Looks good to me!

> Thomas Richard (12):
>       gpiolib: add support to register sparse pin range
>       pinctrl: remove extern specifier for functions in machine.h
>       pinctrl: core: add devm_pinctrl_register_mappings()
>       gpio: aggregator: move GPIO forwarder allocation in a dedicated fun=
ction
>       gpio: aggregator: refactor the code to add GPIO desc in the forward=
er
>       gpio: aggregator: refactor the forwarder registration part
>       gpio: aggregator: update gpiochip_fwd_setup_delay_line() parameters
>       gpio: aggregator: export symbols of the GPIO forwarder library
>       gpio: aggregator: handle runtime registration of gpio_desc in gpioc=
hip_fwd
>       gpio: aggregator: add possibility to attach data to the forwarder
>       lib/string_choices: Add str_input_output() helper
>       pinctrl: Add pin controller driver for AAEON UP boards
>

Most heavy commits are in the GPIO subsystem, once the nitpicks
are addressed in v6, Bartosz do you want
to create an immutable branch for this and merge into your for-next
and see how it works, if all is good I can perhaps pull the same
branch into pinctrl as well.

If this is stressful I can do the same operation in pinctrl instead so
you can just pull it to GPIO from my tree.

Yours,
Linus Walleij
