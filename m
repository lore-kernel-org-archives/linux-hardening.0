Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476334F495
	for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857832; cv=none; b=TFJx9GEQ6luGm+IlXEsCNQ3Hxx9ngUAgylbPC99w6aZ21AmUCDYuBeo+fbHVvXpRA63Nn7V5ah0J3CLD7Ba5q8ypiUExrl9Xl9wvXiQyLacQlRyaPI+Kcp3d44UKxH2Mb35EFobRcdJSwybuOWZ2fmIDkdASDk/lIK/o48yNwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857832; c=relaxed/simple;
	bh=SskqgXLt/V1yNmdj79sn9yutCDT6ypSkI+cVjqdA3Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAWX0a6wK2MszIDfkLEpc0v/yhKoWX1UlsHKbBPiRqJgXesSLLegU7FqzsUE8IYWduLfuy+a4sE+tCBAIk9XfoHIUUbI5mCi4dmQiS7YtOvOa4qEJlhFQ2M4YKyeCtYa+LsvixrNpafusFimsENDJAVnP1Cb4yKbPXpbp7kvKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aoAMdZ4G; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoAMdZ4G"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7880686d178so4561887b3.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 02:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762857830; x=1763462630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SskqgXLt/V1yNmdj79sn9yutCDT6ypSkI+cVjqdA3Ec=;
        b=aoAMdZ4GDsVZXOdtQdFRhrMS2K3fyqxHTQL4UBooKSpJdPhUgkBSNYsJV6WvoT51D7
         cyxRV9vXmiA5tj54QvVnCyMyzWGqR/Hjv/oXFkTmuUVpTb0BMJWt0qQXel/hVwMDraIP
         QaAo9b+LpZvYzkZCipeF0l6LxqvcGbwbkel0tt3liCnkLeUzc1LUySbp/ITGRYfcelwL
         Mat6DeVw7O1sck6zgrNz3B+T3pEOuxgkdY6h7KZgTMtNLszAf0bFk1mLgZcYHsI+S0QS
         ZMjtGjd7B3q8FV/rN3oVtqMgYclaZCMKN6h6TrSmcZLcCOG2Pju2JP5lxRq6IngdETGg
         SYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857830; x=1763462630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SskqgXLt/V1yNmdj79sn9yutCDT6ypSkI+cVjqdA3Ec=;
        b=tNn5ydxID1HmGm7tfEvoHno4hPZpufo6QhAlC1/gdtFYetkF39VsWtvvlsVaMA2Ya1
         a8O6bvhE6bSuvRedfNXkma20zYvXFGrRGfD70thIwQnffbDrjrx41toalCdnO+3eVbkK
         wV0+1mMOJzcxz5s0O8wvSC68qfB/jt+AR84NClgNBXYdLVooTd/8FUO22/d6z0DnpNee
         tBOw9zZ6l1K/trLRyz5JG+aE4vxPXNXj5qjFeDG2h4xO9HnhIKPckFc9ulepiVVwuJqQ
         wGYOM1HwhtHirYRQatfSORDDASemtKU2cUq1tczonAbrEJkwpWXgEh4fKoZMbZoYbitR
         W/jA==
X-Forwarded-Encrypted: i=1; AJvYcCWeFcK/dIkvS/colBieXk2PcQNsAVtGPkmFPoytvut8Eeibz9kwX5hBMG9n1oF31YwJQzFycJDBA7wnHPe7Hc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHVKXuHJGVCIBj1lW880AVjgRK3fkWCqnFlRtfz3n7FRPDCur
	G/cNk6pVEihE9uxqCCqNds1fQ6LPH7I/tBTOMjZvZDEvCpAqWMtzeKDopkb1lP73qf4z2bkNwxp
	2+EkVzdRk0/B3h35QpXxGGTQzJJ72i/CmwS/RQ7ZS6A==
X-Gm-Gg: ASbGnctiv5x9+kXds52sBTW6xCkJw5qpGgu79TQrEJyj+RACEyq70+4rXND3RNdIGfs
	V4qfKseLvBaDaiM9WV//oQF818kO7QR0CpBTYHk/Q2Rme0x+1F+S55oyMMZ7uaj16jM4Z7NsGQD
	aMhZJZHIKC3nz+iG26p+yHgrD6IRMyqXa3axnaiRfNHPbgSvtksyoWAs/g7JTIQmCU9f2BNdx3A
	82yk36HR1GmKAEI78sodmFwuLGCufqYSBw4jmT79XcbXHgmSqjHjTNJwbwehUINR2unRGA=
X-Google-Smtp-Source: AGHT+IEi46gFe2Gc58dgZGHKXPtg9MeZZjbfraM5Zhb8zF1ao1O9DUHuINeceNpyj8ML6p+v/cNPJjLoRvHJIEr4ZNE=
X-Received: by 2002:a05:690c:3505:b0:786:9774:a3d2 with SMTP id
 00721157ae682-787d5470c8emr109020077b3.69.1762857829792; Tue, 11 Nov 2025
 02:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org> <20251029-gpio-shared-v3-5-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-5-71c568acf47c@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:43:36 +0100
X-Gm-Features: AWmQ_bmyzwb3DdThSflgKKoxHLLAiD3IBdKLnNpObGkxmw37AFoyfkH61KGqKvo
Message-ID: <CACRpkdazzchuetece8WOJ+0D002HXhUvK6d47JmyeAauopoZXw@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] gpiolib: support shared GPIOs in core subsystem code
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> As the final step in adding official support for shared GPIOs, enable
> the previously added elements in core GPIO subsystem code. Set-up shared
> GPIOs when adding a GPIO chip, tear it down on removal and check if a
> GPIO descriptor looked up during the firmware-node stage is shared and
> fall-back to machine lookup in this case.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
