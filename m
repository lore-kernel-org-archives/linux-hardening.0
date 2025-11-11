Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91862FB0AE
	for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857873; cv=none; b=KG54hFtpsqaCfMWe2jcRdwob6rS+kci3ZSvJGq6H/4nIfxUwTq98AFRIMK4S1ePdac+nPtdwI4bTU3PIkAA6TaBCEz9De3THdgcCjNR8CJ9XAbcMTp574PZIsOxwn/VV9b8D9nJsdSQClyYMNC9Hx3ZoTLlrTIHnbDrPZURmxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857873; c=relaxed/simple;
	bh=9cdWyWvVx1HiMmqJtLkBOepfaD6aK6+e9z5z1DN0zTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGvshZXoR6ytN30jb4z+Cc36F1gE/CPuPDReOJxDTcOGwS03CdMsVyqFeBc1CdNt4/G1yaoxuKf+2ZbCzdympJCxEwVpxXlX1a4lh/2UKrbmighf91VSsvMbFTeeF2EDqUFZ9iPmUh0lTMRpSKSLqyVXUHitiaIOZwp8AXR6fWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kZfXwY8j; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZfXwY8j"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640f2c9cc72so1058512d50.3
        for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 02:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762857870; x=1763462670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cdWyWvVx1HiMmqJtLkBOepfaD6aK6+e9z5z1DN0zTM=;
        b=kZfXwY8jA2RfIv/beanYlCuNRNHEDnYc6FC7/viUrwd3DhBhSMKXVNQ+LBx54BwxQb
         6bRRD7eO7duzXc/3Vk/cdQsVQ3Je9WCIBmTCXNLDXuCe58WxeNkjWVmYseOlz4Iyvcpy
         2CxO2Tdzj6VYV3p3Zo7KPqusjhQWgDJ7TK4NN8KORD4ZzyMagDHoqPnUWP12U7HEliik
         95BYqbIytmiLh93FTrSVi2AYEMFG76DXmIHRS15zq0lq1ySaJQoNNf7ti93YIdZMKyIZ
         jttvw8xqbhoNduIsu2RPnUnh5Z3ZGTRyXcb+M7uxQZZOpTvbE0H35OiLvsfmz46LUpl8
         yfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857870; x=1763462670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9cdWyWvVx1HiMmqJtLkBOepfaD6aK6+e9z5z1DN0zTM=;
        b=XdaI0nogq66fTKGPPbI1qDCB4alYU2ECoHCu7iFyY45d2SO3yD3Zq3KOOSnJNSdTfR
         MdUiDvPtzBxiVSvg70Vbtgmxg5OfsbOy9Vo/CQW7ip6soquGCpHWXQyChXHJ2HcUKxBE
         Q2UHgdm30CGc75tHM541fox3KGdGefDj/WUyCsDvDvgKRXA2Q6D0EEq5acyX0l4XwC+p
         E5XK9myqsOhJuNlVHzy43B4QqqCZhZhm2b0KM9YLM1VETzzzO5E5iqzoJAw4A68LGfZ8
         0I295Tmmfg+NHhrvdLG7lAmeWQbWyqYxgfblCYJcOkjBddRMjhLlWVyhC9Y/v8Zh8X3U
         unGw==
X-Forwarded-Encrypted: i=1; AJvYcCWbQ70KOt9TrOxaNT/PN/XtphI1PfY2sHrzrmozkyc1kCxDLnQkO1K3jLrvI40KjyYDWdmTgEfKq8ywg3WsYxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbq6bx0oRgi+wYFeG2IqvWFnQlQGdbgekqzsBuPwop/obkH1S7
	wMYvJhW4pYpC7Mb9Xv0B++Djq5Vxd/L8MiyYxLZpdN9IJvx8y20q993Ixalrw+VcHo9YKn4bhIs
	prQPi1vFd5CdcEM2a/Mtur09xMljbq+mxFSmxC5qTOg==
X-Gm-Gg: ASbGncuNyEfNZ3K+NVQR8Q9ORMVuu9keCp7ZdQ9vJj0YB25b+Kz958BEOf4a5CdVTcU
	EfFghB4UX40vBcuZzA1icuMdXyD5o+BxPjCmGz4KhnYoIQfCruqZPFnyV+LAqBFvbdLiheDezbF
	Z5QjN0jH9usT0YrAG/KFJvw/oHpgqEJ0jhVUTfuJORaJToEt96/tpH675N6gKYCihNHh8ZT08+D
	4KplUqDW9PRZE9p+YTwnyQAH1P8A8FQQLY+UVjJxVbhxPWhWNsLnMsgVsUT
X-Google-Smtp-Source: AGHT+IGM3E/e9Scx4gWocd3epZsySeg+GiSnUa6Lqk3ZWYP/cx+DuGwZohc+rkcKQ1+QYm8c7Jg9lh/z3+tSIbO/Q/8=
X-Received: by 2002:a05:690c:a719:b0:781:32c:b359 with SMTP id
 00721157ae682-787d541c211mr161593377b3.36.1762857869718; Tue, 11 Nov 2025
 02:44:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org> <20251022-gpio-shared-v2-6-d34aa1fbdf06@linaro.org>
In-Reply-To: <20251022-gpio-shared-v2-6-d34aa1fbdf06@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:44:06 +0100
X-Gm-Features: AWmQ_bkCgjjs_tm6yJMft7dkXQVENEnuhOT2qvpn5ldswgUFUo9RrRQtDQDlZKU
Message-ID: <CACRpkdbqLyeaZx37yrKjDFWb=C5c=vK6aPgnW8cMQvwi_6Jiug@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] gpio: provide gpiod_is_shared()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Provide an interface allowing consumers to check if a GPIO descriptor
> represents a GPIO that can potentially be shared by multiple consumers
> at the same time. This is exposed to allow subsystems that already
> work around the limitations of the current non-exclusive GPIO handling
> in some ways, to gradually convert to relying on the new shared GPIO
> feature of GPIOLIB.
>
> Extend the gpiolib-shared module to mark the GPIO shared proxy
> descriptors with a flag checked by the new interface.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
