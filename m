Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED823BD0C
	for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773675; cv=none; b=LK/1GCt8oWx37qHL3bHUdJRfVbZw1BspvhCv8z7Jqd7OuRRteKfnPlNYa4+7P+//EcjGnTsTry5cnIpl3XwEqm9QDFHy8bWGebVhPCPnKfzAE1xc90/Rxu2emT4+eKfHs8MXUpLAm3dUgWMjB802P8xyNgiCYFA8Rvp3jstsFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773675; c=relaxed/simple;
	bh=H70cromMzBc7G1Dxdn7Ujl+1TcPLdylbz6SBFKEdUOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7wk1HL5khNmDTHgZLkihTKVf2jM7/1QNoQU/MpPCJ3/RjOKIFZ59HOgGOaOm91BV29objxP8WWaMQg+vuq8J+KjU97ypjILQczl/zUxzKoJvi2aFj4joLC4zEtQrld8BKufEFg0HqkeVveA72fYeKtbYAVOsbPit17YHxX0268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LM+WMKTE; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LM+WMKTE"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so6455886e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 03:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741773672; x=1742378472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H70cromMzBc7G1Dxdn7Ujl+1TcPLdylbz6SBFKEdUOo=;
        b=LM+WMKTEtBro67ucRHGFG82QurBUVVTKueWjq6fDb4ct1i3KejryugfkoRLxmXodsT
         gEpX5bmbXgc0Pia5+kYM/u22mb5eE2PU965J+nKcNzU+gnD5g0qPMC+AGwDIvQNU6OvV
         4gMhJu81ak6Plrm7PcR85qREnu0ChRdO7Emv1PqiXCRAnO4HUygSvj4GME7wukOG4JqE
         nNvagmkxB0k4nQPKYBG9kk4nnP3qFHWfkRXv4BzJq1kZiCUbpYTyee0J/hz4Ljbj0zUU
         mRyJzAftdRRvSOocXvmTHIPX+TQQJF6mMMuI2P28z22iLTQX56T6IOJLTq83PNJ5WsYz
         J8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741773672; x=1742378472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H70cromMzBc7G1Dxdn7Ujl+1TcPLdylbz6SBFKEdUOo=;
        b=fOFubb6QHbHu2BsEsM3dKo6ytan/D5mQbQKMTZnye1VcnFPcFqxEzoihCTV95QkktW
         J6FahwbrXs1SRKU1QoqrkyEjmOWd0ldFJ2MJ/KbMad7v6ysx80mbXqE0lQj2oi0nOazr
         aSJTjBWxveCFUbHQze3PVmCjHDBBnCLB6csLcfO0uW7mWyxqNzXBM6Vy95GAZlUDP7pn
         vRwdGbubq4xPnXR+R2lhqc8jrp4GW5VIAP9hMtbOPuPx+z7q2+7+Ct7XZAouTSzbIQM5
         +ijWV37Z9US2Sk6/wvvY4ZpZ5x2hgoAR69hTCvL/BRpbj1Ma0e4QaU9SEw5q+eTBtHuW
         k/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVVwsSS9Sqx+VguVASxOx6CN/BLntvyzDPxIYtIHXOCb5D2e+Thzj8CVQOCEccVh6p6CY0S6pvJoPx/5JpMVtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxGQcX8XS6vOxCWWEPn30kChEZLw65S3FnUbU2flYzGIs+j9Z8
	goM17Z/ZIb9xZ52OOIaV3kAIyWXrzT6eHvPHsQvsNOYzEFGQBEgB+ON6ggvBC2Jm2gIQW0cs73a
	JJdybKAa4VEAxwyAXbPtXN0KXX/4bzsLaS0poaw==
X-Gm-Gg: ASbGnct3FZZwU/huuPhcaMSqUNNLGzxSdVdRaNNmofUcgpcqqwvL8kaqF9Ggv8tOePn
	PbjWOJGqhFM1809JbET9RBDj0FHt4I7e53uUuTZqp9Yw5Hl3ihqLwHLdAUJ8rrJSNR68l3CvAm0
	Sem4w99A52LDsXcIcLszSCI5vMtDyj574kP8z/QMOYAKZoYdKv7hZbXWcYfQ==
X-Google-Smtp-Source: AGHT+IF3JsnGDmtC8cFGGo9UJ3LwBpBWNU0LU9dhkqF7FdQC0xv6vW0juUcQgoshe4Cj7uKAJnjHv9k5v01339Iy9Rw=
X-Received: by 2002:a05:6512:220a:b0:545:49d:547a with SMTP id
 2adb3069b0e04-54990e5dac1mr7224533e87.18.1741773671774; Wed, 12 Mar 2025
 03:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-max77759-mfd-v4-0-b908d606c8cb@linaro.org> <20250312-max77759-mfd-v4-1-b908d606c8cb@linaro.org>
In-Reply-To: <20250312-max77759-mfd-v4-1-b908d606c8cb@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Mar 2025 11:01:00 +0100
X-Gm-Features: AQ5f1Jp2A-9h5YN6Ed4bZKIBT4UotjU0jd3UNyhUp6pXeEy9BD3imBjHO6ZUslo
Message-ID: <CAMRc=Mddcku1vokKQzxyJOtvpdJSjM2TFvG9r0tnZ_qY7HBGJA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: gpio: add max77759 binding
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:26=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@=
linaro.org> wrote:
>
> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This describes its GPIO module.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
