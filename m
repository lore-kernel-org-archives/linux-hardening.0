Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0652EDD63
	for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857591; cv=none; b=IOoo+iuOEdGWGnAAJVfT8LWx9Kmgbjg65KYCn1oB+bTHnw1vFibDpxvHjTyBu5XnASyqXZsejDOSeJsX5SNphHNymoC2ZQCUDDY8ZP0YV85gAZe3Ab3ytXlHmKx3m7ekrjL9SUhBGawkRz0l80hJdTp955wyx6IP934xqiL2xAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857591; c=relaxed/simple;
	bh=uQN8C80XsI1DNcTbyZlxKBoQDlYbpinBS57HXqp89to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsMB9V90KHkDp8ie8Ljl63AUBI36KF3SlSAKMrVY3LFvGmhMipiKl8fjW1OYfAEiA74FdcrSPLpnNKl9q2vQpaf5snm1iaGCO2oFxy/so0+nfHyztPtRjU1UL6osAShA0AZbO8OipLeZeL/Tzv1ZNrHeLlVQ9/vsvqiz6ndbyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rX39NeN2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rX39NeN2"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7815092cd0bso38874237b3.2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 02:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762857588; x=1763462388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQN8C80XsI1DNcTbyZlxKBoQDlYbpinBS57HXqp89to=;
        b=rX39NeN2PL/TgYFEBoIA2sPMSLu4q60y1Sa+C9R/8ZPxW6qJe0Dzx95viWXQz7cGgr
         PH0grH2HrymuRTq8svDjQdovq93ZJ4mLlaKgcSTll7KfAhiiROr2GfO1+b7/MxlRgnT/
         5YYNdrwHyqf9vhIur4rcrsQGCfCUZtDfSce/YCJs1a00tA3kOprneBPS8RHUzjtOc9JR
         cbyc3eGbrRXkS8Pm716k0+wpv7u5F7YYgh0Wt+QbcWACSlaIIGEVZEEkS3sG8fQ8I96V
         awB/NynSphoHhND6wLUZqoKVhqOJexO9Wq0NCuwitk89qlEDHzJLxIpdBsDcwTaHYejd
         Y+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857588; x=1763462388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQN8C80XsI1DNcTbyZlxKBoQDlYbpinBS57HXqp89to=;
        b=mbMEpBEWyQUPdfhoepAKto/6F9Al5p16o01ZBqyt2wMJOhVXt72atbXEJr3Qdi2FdW
         erIT4kYt/FoG6XTArByoR1MiT6KvLY3jD/J6jkO7F6RhmxMGJCpJ2tqpJMzNfJwsffK3
         eAR/CE3wUwybo6VfyNQaqg0VBEKO8ieGcuCuUhU/jTepZR6AaKOcRlxrnmb4Szbsqh85
         LorW8sGDx4rEP3dh4azo1mWLqx4B5NNONt2CBaxwLON+hiI/idtLdga3FKZY7svPVE+q
         9pxVwQvUPOh/+KTN8Sz5zSZgldtExEd2kh+t38McGTwwGIFW0HiZOwoKvI9kf6n+z9sv
         hFyg==
X-Forwarded-Encrypted: i=1; AJvYcCVFvzkAFBeUKRF1IgSd8mfnVbshdbz8ndZdoM1Z72fdKjjbATF3p5wxKyfOw7taxIfg+0E9s+4nzZNL6MsXF5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOZdDc5P461bRdJLPeQUoLlgkhcoYXH+7wOnBTySxhs0g1BBM
	uSwOOpt+9XXmFjrJAKtncZJjFvxE6N44HfbUOHOD3EML4PoYh3h8k4qUAdr46rbFgw/55yFaz/z
	pfNXKXDTvj4K26o9ySTgIJxrXKTeQAvLniNRq5SSJbw==
X-Gm-Gg: ASbGncvKvs5TJScjfEmTSAbWoRhRveRj4xz2oZ4wUTqNCcIDoo8BhWG6s/XZlqRi+m1
	UGFIcvDmn/3VCpf8hBE4kvjcX/AASP92J2qwF4WCRUpWO4pHPx/f37phBBsg5sHCOjCyLSgrsBU
	yqgyCOBy7vsoPX4mwo4W6Lw13mFJUcZ/QfsMsxpougBMgbUNkvlHDjcPE3j1fPRJGCOTL8tNa6V
	HVdAVerU2okIDZVCDOYpPHD7Kz2jeD9OjIJZMvcglCPCQ8HQQzmf89Ixlu3PRo5ZmUA7eEdL10E
	sOeHQg==
X-Google-Smtp-Source: AGHT+IGdKr3biW2aMZhYy7DvL1RF+7Uz2kpvCtGXfJ2OgvOVwI6zfxqRAu2DSnJi2xHuqa0EQrFVKg9nUpOsh5XjgKI=
X-Received: by 2002:a05:690c:55c2:10b0:787:deea:1ba8 with SMTP id
 00721157ae682-787deea2334mr150764527b3.50.1762857587612; Tue, 11 Nov 2025
 02:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org> <20251029-gpio-shared-v3-2-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-2-71c568acf47c@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:39:30 +0100
X-Gm-Features: AWmQ_bk198TBC3PdqVd9Oowwqb_fFWVruyMz7Lubn4P_lvSkb0elFliKm8IlGq8
Message-ID: <CACRpkdYRzuumaCv=a5UL_G8StQj10kBiRfkfrpWCk05zVfGYsA@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] gpiolib: define GPIOD_FLAG_SHARED
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
> Define a new GPIO descriptor flag for marking pins that are shared by
> multiple consumer. This flag will be used in several places so we need
> to do it in advance and separately from other changes.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
