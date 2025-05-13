Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108E202C4E
	for <linux-hardening@vger.kernel.org>; Tue, 13 May 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127874; cv=none; b=f20BA1uS2Cipez0cN6Rh4xuKMnuiQam4qqtVsF8MiDTAQPxuz7xuqNAVnkXVbCBLVwdQyWd8uNjZcb/9/hCT4AIz1toqbVpUmMa3pG4n+qlvvrpcbpKhH2oRo8brs76pevjYqYHzzwTmMcQI5xmt0a1tH3bgx/G0bXuWanvanuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127874; c=relaxed/simple;
	bh=fYj5KQcmLHEMEZBytxHFM2PZV8baZG30rM4LCErfAUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJKruQepVh4Ot2G9ASuOTndK2MFQke5vW19UZvPci9OavygAWNLmYdt6pj78H8bSu5yBnG6V0TIAZFKctZKSAZeMY2ANbnr49XuDaoFJ7NJvL5StPfoPPgTiPAkXrmES6w8CqyXyaFceFzbCk1KzUwlubknHxToc1Ytt5QJgIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rpZhtYvG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpZhtYvG"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-326c1f3655eso41347791fa.1
        for <linux-hardening@vger.kernel.org>; Tue, 13 May 2025 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747127871; x=1747732671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYj5KQcmLHEMEZBytxHFM2PZV8baZG30rM4LCErfAUA=;
        b=rpZhtYvGCX1OdO9DcHoF55s92TPmzmY6DdTVtCEqd334WBobDLW3RPPl2JdKKR8kDy
         m7u1SrMSaPk0qSf5R9gSpL3lvIuDZm3Tfw+X08M9S8i2gvwSYoXljbSPk1JyJS2+B3RE
         Gvg1jLkF/tqcIheNbEVn4ZzH3AHNOVU+UwIccJ3kdz4Mpr2DtlQmd80M2uHfiXgmjDQo
         wt0HKMmFtQThRVfh0dGFUAZ9Rq5nzPTI/vZqL58ucAx5bVqB8GC2bprcdvFn8ApkMUQS
         TAOY+tXSfA/Byvx+CqitUk0tG7PzcMLIU05ogojXI3FLXaYYkqV8IZwDJDbElRJRnMp1
         3i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127871; x=1747732671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYj5KQcmLHEMEZBytxHFM2PZV8baZG30rM4LCErfAUA=;
        b=JalERdohuM1EBQVuMr8pDup2FVGpXBY/FRqdKx1ir5VBJjk3+829DZJQ5cnUf5vbH+
         MKnm01w2IjjxaZOqUYtYUG47KcaFuZ6QxmRhfYGTrufpAEOp/KIaI8JEBQeChhE2M2+a
         UR4nwDu6tJkPsQk5rHpIF6ZPzSwXvui0YtAxAyXsMvhUApTXg6a6GKFZNfp98th2Vzfe
         p8YaxVBJit6bk6KBeNJVySuwVwTvE5Pwrh+SCTa0uMOVatk8OjfoiPi8l+AzKYO70ZPq
         SmXJIU/T+qUg9DzUT5dNnov0DDOdGqwkX73Mtq7vByN74pYVBxMGKnp/+QMJBsA44g9R
         uY2g==
X-Forwarded-Encrypted: i=1; AJvYcCXyCo0Mx8sDLVGp9p9OQu54N2O3rjlRxAsYNRj7Yb/eyQoNMjW9vFeXWJgyG5nxgb36wA3tmmhKzVHxvF7pHNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9r5pwAeOXyWvfUMTJ42T/Qqw9jI+99EIblpDlaG6934aK2NQ
	FPjpiV2ZO9zzoglYvNkGmzkScRI89RGl5KeDmgLApfoszrBkvYJ8AtomTPaWt5N97E8e8G2gBEE
	OhSKBiAsBBoMmbNN/bDHnTxBLT9XKq3O4OOZ1hQ==
X-Gm-Gg: ASbGnctI8TReqocVd/tTAxlBDDPyarLgzE/58wMTLYMtPdmuQVDuIb9ZC5pZG7xdVUg
	v/4i31z2wdUXt8hPxLw5osc4UejDK9BHrcn9E2xfQ3E8zkXZebMdWKcR8RwZt739CzL2mnzVExy
	CXSalUkgygiGWT0uhregi/73+wOp4/s6NBCp1cRNl3V3Q=
X-Google-Smtp-Source: AGHT+IGF5AAEtxjDLnWwB2KhlBfA9BpWe7QwP/k4X0BBbK9pCsdG9d1Hz5QqjrJe/oAyVtJZCXkbt+hJdfoDbRz+p5M=
X-Received: by 2002:a2e:a542:0:b0:308:e54d:61b1 with SMTP id
 38308e7fff4ca-326c4686abamr73346771fa.34.1747127871028; Tue, 13 May 2025
 02:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-max77759-mfd-v8-0-72d72dc79a1f@linaro.org> <20250429-max77759-mfd-v8-5-72d72dc79a1f@linaro.org>
In-Reply-To: <20250429-max77759-mfd-v8-5-72d72dc79a1f@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 May 2025 11:17:40 +0200
X-Gm-Features: AX0GCFvKQMhZ-KOCmIthKIc7OzU6GLwrFz4eRraag3cmXbQnfR3YMu1flp3ZUNg
Message-ID: <CACRpkdZUTJX4ht3CTN6AuEVRgbM38Bs_kLj2yx_NwrRCryE-uw@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:22=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@=
linaro.org> wrote:

> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This driver supports the GPIO functions using the platform device
> registered by the core MFD driver.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
