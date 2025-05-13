Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27149216396
	for <linux-hardening@vger.kernel.org>; Tue, 13 May 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128068; cv=none; b=C+uzsccDgWjRzXz0QN1UNVj56bTUIGHDWBqJbo7MJcX9GhqNHo9YBHYfMYd5+QKI2PBaaeS4LMe4rWfbZ8o6zEfGBMnT+HrK9sTSx9xVavH8T5h+Cqvkj5iCKPhHcMHoy9v00Vc+8to9uiprypYNMSHxaSDbl0Uz6AmAFkMFu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128068; c=relaxed/simple;
	bh=jAG6UOMOffV3gCVoCmbgmLMxOpZlx9u8Ad39RHvZ1TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0+Ng3A282gbeidTxShIKSHxEz6vxBT/WsDWMbqm8YLaNzl47rjYeGDvB/TmfUaslYwsyEUlqbt8rIu6TdnnUSEOLazVjHNpoynsJXDLSyp40Y/N/3Gt7x9Gfx6fRc3dajqWTgs4hmUWv/qEvK9Pe5hG9x/v5oPb6bhQ+ttTAKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxy+1epp; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxy+1epp"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54298ec925bso7782410e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 May 2025 02:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747128064; x=1747732864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAG6UOMOffV3gCVoCmbgmLMxOpZlx9u8Ad39RHvZ1TI=;
        b=zxy+1eppz0AOm1YjT6rvKlsa5iMWWAkQC3+DLhyvnNkmS5KdD+kIjB7uDdODpZoBPO
         MTttUZ5XI9A0q9ACZ43hFuXk5aU7I9Fr6gVn9WvjDbi0p4Hp5ht+6vtgvWJ2nhwnHFTJ
         VNkmbpN5Y1Um747b7nCwGKbjz+/mzN/A2b8gxSjh+g86/iz+aWgrdGoihG04Ks9g6AON
         bwWF3mI57wxnODdicxu8jx3SWtApeVvgvaKbSSOniRlJAGVhNn1G0bi2PEkDdrJDsH08
         zju4mwRXBPHAtigQ7RlYRAr2veYMcd8TUJ0qkzlJ0P+cGor00OjKAXE5u7CYcjxkGiDQ
         +7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747128064; x=1747732864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAG6UOMOffV3gCVoCmbgmLMxOpZlx9u8Ad39RHvZ1TI=;
        b=SW59iBH8I9a08/0HF7WhouRgVOHYN0Gznw42Cng+FT1HPttWYlG68NDWYf3EMmbWEk
         Ry5rdIwDxileemDKpGZWynO75fAK3agzwinqQAACZ0biIO2TF3GqUSNDrX4+UnxVYb3A
         B0EkbU6be354aFZITuNK+cUYglu54jWqWpYzmgUpskymSWsT867zPd9eR31kcuc66O/9
         v07zEKbUgOhs36VELudwLHkoeJHnSKpGtXKMzMZv1hLYbRWolAwru8ovsJsIvodOCFNq
         s7DiKmZ+haudR8hXV9sk/brAZdZAGSU2IKf0sCzhzPUN0YxPrFIzrrI9cI5GLyIlA0ot
         Lrtw==
X-Forwarded-Encrypted: i=1; AJvYcCW3GXNkuMeZnHOLkw7oaLHmjiGwUKYrjld5VwE+SY/lvoxex3UTqT1hc65FdvlqcjmgdF4ET90RFQI6qupryh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHCLACDro2xa6MD7GfIDe77gC6ryVDBH4q5d/ZFF4YanDhbe9
	UyVIKsZSZXi5X6Zd1f6tONSXMcjlh98fTFB4h+jz5bebaE+55RGOFSF1qGJVKlNq45c/TNcXKvo
	s7zXFlRbuKlHbaT5/uwLPJMSFygvZQ3GZHToU1A==
X-Gm-Gg: ASbGncu7nT8t6kGkH+ySfg9jbzb2zunFHY+EwZ4nc3rN1Sv02iT7rSjWZYl2mM1nKMN
	tqmM7CyMnClsi7xFkSa/f9EAnvh2jfslnmoWrj0D2XVqm65iBW4cHl4kqwVI3Y+WU9iCUhmVoY0
	YmjMfClrBZ+lQFeJZlqC2VFtsBHu5pYgpq
X-Google-Smtp-Source: AGHT+IGKvl0a9PYMoR7pe3tZ5kyPbARxdNFLenyjWORpsYZx6Qr+/V56jGkku8jVsQAW4x2zH8hvY9ZJIUWfZ8j8uTg=
X-Received: by 2002:a05:6512:6408:b0:545:f1d:6f2c with SMTP id
 2adb3069b0e04-54fc67c37b8mr5182580e87.18.1747128064206; Tue, 13 May 2025
 02:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430-max77759-mfd-v9-0-639763e23598@linaro.org> <20250430-max77759-mfd-v9-5-639763e23598@linaro.org>
In-Reply-To: <20250430-max77759-mfd-v9-5-639763e23598@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 May 2025 11:20:53 +0200
X-Gm-Features: AX0GCFux1HtYoXX3UiKQeMd3kDVZuoIvGECfOVBviXvO98OxIVsjOGF-W-k86hk
Message-ID: <CACRpkdY15L5PpV9ah_0R3ZPZVMh18OR+Dg2qXiBG=8Kq79-rjA@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 11:03=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@=
linaro.org> wrote:

> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This driver supports the GPIO functions using the platform device
> registered by the core MFD driver.
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
