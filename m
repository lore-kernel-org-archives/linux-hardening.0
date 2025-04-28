Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FFA25D531
	for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840617; cv=none; b=WgPKMgiJjQI1RjtKH3c6J4uZKlDLPfOriD4qyBL6SoNkh2nbENE6sEOoJB4+sVvtzWMU6JI5jfBTEOCw9fRHE+RZL1dgAbW1O3S2nglb9uNABC/IHYstq2uS/Xy2D8/71CeHiRb8cgz6DEjLIf5lXD0T67Y6JYqW9jgZFHW95m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840617; c=relaxed/simple;
	bh=N7WIWDwBiFPBHG6RtziOKsfaaUWsA49kMC7wZCjMKe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+bhob7nzjtVYB3OYPmzviSce2PiR0+YiwSmIK7dPVbgS8t/Tk5kQPK29X30ESIT2iDYIYftg4bxrwpHClGMfszAvz/iG5k9UPYDGTFRogL6Hx3ahwJNpQzitwpkGJo2qQ/Xp4WA/TmuXVJd6tVFSXfEjTdJKgep1w9CKon7Aeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=O9XK9Xvm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="O9XK9Xvm"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-549b159c84cso5349322e87.3
        for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1745840613; x=1746445413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX/tC8coeF6pt/Nd0vQ2pLOJWZbhUUNTjjg2AdFwINU=;
        b=O9XK9XvmuRofTbQRIwS9OOX/K+Iz2cRiedvAQGwffCwGvuQQJ6aI2EKnMj8IfJvqrf
         g0uztvsm2trOG4QqvbZrM3yWKuQNdcX9fW39rX5uN4DXrCfJb1D4PEAlAIC3650cXccM
         fZcYDqMTpCwDv2LlV5NzIPwbCfE5vrb/UFPfodFsF8B83OP/hskd1Ly72eAHHPhT22x/
         ilgqAyetGgM4Xl9y5L1BzcPCHx1VXHGX32ZK5+MJMW7TG3ohj5amztf3/hxTuCbqgACk
         pqrERuQg+gG0zUoIOwNXizSyjE2IAJLL/KaeciGd7fC/PmHYuTacSr9Uam/CXhVtY3c6
         7kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745840613; x=1746445413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kX/tC8coeF6pt/Nd0vQ2pLOJWZbhUUNTjjg2AdFwINU=;
        b=N8p3Y6NUWGjvqRxr4nw/miH5aKpw6tlCIsSHOd01bHC/bXOQ3B2HceqzredNUTTwj2
         B/S4Egv8b2indbuxagIB7cA56XLMViazxVUVcIDIvP564BLoixIQpP274dBJppYbLRlN
         o4EzP+NPqB3R26qVSlX5l0r9l3I5YA0m9yCmmKc2hiJvNieM1mQ8x8JbGcddTf686IwQ
         X19+bxGEMNC5wKNm/2Svwia8Ofmo5DLSNEzovcUZMITn7GLliIuxBaM2CIQDb+kKpGen
         3wGCcVmcgvfc4itK/49s32PWTWb//UB6HP5/DkrsnSOCwYuNiVi6jzo81A0gxO8oFWPZ
         M+CA==
X-Forwarded-Encrypted: i=1; AJvYcCWVzNuyjkiDW0yuxusGQUhj27mG+2MbNqXXqLrLQ1aPljaRQFZ8Xeh5mice6UYCUh56yLcDm3KyX7LvEgR7tu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6M8Nxfq1D71Aqvobyd6jpWKyF/Q650hwBOjU1Plj6QxK+3vJ
	E6j9bQk2RxqO+HWL3g03fkKjWUI7aL8XHx9qR6hiCRMKiFT31ylni55Jfn9fTzw6UGPfPO8o8Ve
	y6XuVv/n6qaJQRIrQTSdOFV0aNP6Ro5Jt+p/AHA==
X-Gm-Gg: ASbGnct1b+Q2Uwzh7xOEwpEHSYajs5EJge4cSumFpdbnhm06i9cPMWJA+EbXCHdleNE
	EyBpLJrVC+HdBggv4LzuDEIAtGlDKKI/Cz4wA2D3BsCnq8nRX0eF0Gh4Z1pQYxFstgDqsGYLc6W
	Yfuu42lFfvELLIqdqyfLcRb7TwHb6B96WJCUHfC9zlXgm3oRndIN+URA==
X-Google-Smtp-Source: AGHT+IEX8jJV7HnhVW7+fghG4q9+ghyZY/XzjHuCql+UIJeBm8TXPQiK12eFFODxXmy05fbna2r7j5iNKaow+pXqX44=
X-Received: by 2002:a05:651c:158b:b0:30b:ca48:1089 with SMTP id
 38308e7fff4ca-319dba4f9d9mr29996981fa.2.1745840613339; Mon, 28 Apr 2025
 04:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428-max77759-mfd-v7-0-edfe40c16fe8@linaro.org> <20250428-max77759-mfd-v7-5-edfe40c16fe8@linaro.org>
In-Reply-To: <20250428-max77759-mfd-v7-5-edfe40c16fe8@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 28 Apr 2025 13:43:22 +0200
X-Gm-Features: ATxdqUFCxRnO3E7xcEweLG1JpD07L7-5rWx-FRd1gKrBNZ7uwi1zJAM7VnHWVBE
Message-ID: <CAMRc=MdDH7UPkhjBKr6hO-j2J158_u4Mp=++hjh=V0OtoJHX1g@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 1:36=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This driver supports the GPIO functions using the platform device
> registered by the core MFD driver.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

[snip]

> +
> +       chip->gc.names =3D max77759_gpio_line_names;
> +       chip->gc.ngpio =3D MAX77759_N_GPIOS;
> +       chip->gc.get_direction =3D max77759_gpio_get_direction;
> +       chip->gc.direction_input =3D max77759_gpio_direction_input;
> +       chip->gc.direction_output =3D max77759_gpio_direction_output;
> +       chip->gc.get =3D max77759_gpio_get_value;
> +       chip->gc.set =3D max77759_gpio_set_value;

Please use the set_rv variant now, the old set is deprecated. Until
that's changed, my Ack is revoked.

Bartosz
