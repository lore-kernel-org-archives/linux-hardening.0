Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A42C08C5
	for <linux-hardening@vger.kernel.org>; Wed,  1 Oct 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316002; cv=none; b=qBF6L/k73BhVoBCRu/EIokHkdFLK5Kb1pVzg0CTHbC/dLkmRZdrtfKlreZrW5386azYn0owobCTOwRO8sPu9emZFZSVLfnBYCAa0/AAC5/lM5asEJuQu/aOyjX7o6IuEKvUxifq4X3ho1LcCgNx6F9wU9rnFLoh6xhxWRmJNaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316002; c=relaxed/simple;
	bh=iRFBrL9jShE7DNB6IrQqexRe01xpLtZNZRY5DpG098k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hf8P+do5X30QSQGLwvzI/NcbGElVrxt6MYVqOk2a2c0bDAdUh6zlOaCiwHT4pINFHLwu2lQoLost+rOOyofPQPqZ9SGBU2452a2KMzTpmUobdmeAsfGIoEPIxIBF5ZgTu+iNbA7L8kuY3qbNkaLN4r4tdkotpXyHSDx7PQXEkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blYrOHjJ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blYrOHjJ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-33c9f2bcdceso69323151fa.2
        for <linux-hardening@vger.kernel.org>; Wed, 01 Oct 2025 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759315998; x=1759920798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXaRvd/Tl3m+OCCyeRNRvJ/5mgQ4gfksuRE7c8W+vks=;
        b=blYrOHjJ8Xv9hvrnjWXmR7AYvuEPqDvq55kOBz173UptwSMHu+MwAvpp3FQTzRpSPn
         5AC98TBpFOdRUTe8w/J/Now1xyCYyxT27eL7voDXd9TCjSgaoqCVf1rwua5Tm4rw/XDY
         8PN/8UW9e4kG8a1G3nchpZjpCybGIOUn7vYeUMd9yBARwr4148CEXvCt+PlzOWbvlwwC
         o2PFHH5NWyN2O5Wxa4jSYk+eMHwZeETesrtUea1KrpsLa3JkDMXK9TgpmWjf6Gwz1Qux
         U546VBbuVtREaQ2oeCryLodpiblOSi8kUVxs37AXD7K5zuwJVqA3P3CZiqi5gvrRG6uP
         t1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759315998; x=1759920798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXaRvd/Tl3m+OCCyeRNRvJ/5mgQ4gfksuRE7c8W+vks=;
        b=wODfTyrfVt40ZQGUfUrHujQwPppN3IpdBnU5OtnUa82lOwqcfG/V4uBC73dqD2jERD
         kuCrF1Od1Cykv6N7DvrR61xw4tB9AA0uAd2Wp8zA76sj3GNxCAO6F2AwAODacgSAdaw2
         gGR92QtHD6Z8rHxFqPYegIKPntZPcCCI33jaxb5fcft6CBa44thQNYmeASnnTyejkVjH
         we+8rfXtMTl4M+ZA6541JjtuRPSgmN7O9THfqt4QtVEJFgsCAhqhcm8ECMKaP70Jo1Rp
         D5GlCVmftJWv2fltk3ZwYQLbr2d4MkItev6x4ApxndyxW9bqgotWh7T7L3Juh4UHQMYa
         MR7A==
X-Forwarded-Encrypted: i=1; AJvYcCXlfCIcfwWIDkHIKA9WG1379GNKmxZscNOcAAFaUVch8C0981+KP+F0SWV3fyAqB/OOKrPiX1vaaaDInEDTb38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKQt5szCljeDDBEBUxbKhpKxwEXJSQ9glPSFN5EoH2Cq8tpXs
	7CIl/UaX6tb3Q7BQk6/H9MHQwvisFMCg7qmz5mM8inhDDH0lDmq4tLglUrWr2lzOc7ozddRmc9X
	UJYAe9ySmAAtJvyKmdLsThmW+zOri32moSYjj1NSNKQ==
X-Gm-Gg: ASbGncvyfeAp5GouPmTzVVjeqr5U36W9nvcPTlW12CV1WcSThKCT3SBfodr+Kw01eKp
	ayjZA2sXrNMXm/prBBEb7YntrMbb/FI9tZ0muJb9UFVYa3hAYhR0Trd+ag2u5ethljz6l7Db6uQ
	jmL+FphbNgCb0iwLhVZfLtbPMes0i924ZSF+QhOf2NoIR8XueouCiDWGRsr/3t9Ge5xgDeD2kpO
	KGVy5hyk8TFBLGu8btsaq8sO9Gfy6U=
X-Google-Smtp-Source: AGHT+IHNsDtiUQt/i2npQARVssi0DJ3+LBTFoSnvhtZVkK/xmqXN8oNQNgTvZTXOiQqw4WqXcNYRSxbiHzvdCA73Ztc=
X-Received: by 2002:a2e:a7c1:0:b0:372:9fd0:8c40 with SMTP id
 38308e7fff4ca-373a740495dmr7206011fa.31.1759315998524; Wed, 01 Oct 2025
 03:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org> <CACRpkdYcVtJjRHRJ8GgeU7rZDuyaJKu0vgcknb7DsHPjZGKGuA@mail.gmail.com>
In-Reply-To: <CACRpkdYcVtJjRHRJ8GgeU7rZDuyaJKu0vgcknb7DsHPjZGKGuA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 12:53:07 +0200
X-Gm-Features: AS18NWD2nrQaAyXYNX4TJo-95Uw5nXLztXmSEl4xWN8QeMmA2KtvYABQ1GxMrZg
Message-ID: <CACRpkda-ZvrAC4bNLnA+ao0Y8-Nd_-b89N6HU10hhEdaOUYAjw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
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

Replying to self so Bartosz don't have to tell me off...

On Wed, Oct 1, 2025 at 10:49=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> and every GPIO access on every system will be proxied
> and then this better be fast.

What about I read the code before I talk :/

Inspecting patch 4/9 it is clear that only GPIOs that actually
need to be proxied are proxied.

> Two things come to mind, and I bet you have thought of
> them already:
>
> 1. Footprint: all systems using regulators will now have
>    to compile in all this code as well.

This still holds. It could be a concern if it's a lot of code.

> 2. Performance, I didn't quite get it if every GPIO on the
>   system will be proxied through a layer of indirection
>   if you select HAVE_SHARED_GPIOS
>   but that would not be good, since some users are in
>   fastpath such as IRQ handlers, and the old way of
>   sharing GPIOs would just affect pins that are actually
>   shared.

It is clear from patch 4/9 that this only affects GPIOs
that are actually shared, and those tend to not be
performance-critical so this concern is moot.

Yours,
Linus Walleij
