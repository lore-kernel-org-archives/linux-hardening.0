Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F120485B
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084660; cv=none; b=fvWPzX9W0zisucDrvN6e15+KWJXk5vVy8brVkqHGXzrSQ36CPtlvh6xfrvbvUSzRLzqyW3ozL/M7VIKjnkUOxU5/WuH0mQTJixWeKeka+vJQ04JbQWkSt7jrhs2N+Ex8e3QoImTxhGrRoxfOzNW9upyCefqm9OrJDbvu10Nindc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084660; c=relaxed/simple;
	bh=W7wu7x2CGHp+hodRLerhrOyuQsqw+FEk+o1KUxZ12pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXtOZrlvxDZt8omHnjsX6fZ8Fa1JqMJKQeiWphWQWhNfGLww8asPRxgsGcKtGa5T4LiR4BMqZe87LA9WQAqy4GlxUPnzOq/3dfDIgQE3z5RkIKyC+lVh0+UoLAt2eCQkhdsPhPmPIvsQ6lpOskEJl37+7NQJYjFDijtehilIwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0YTgtxRc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0YTgtxRc"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5497590ffbbso934926e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 04 Mar 2025 02:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741084656; x=1741689456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7wu7x2CGHp+hodRLerhrOyuQsqw+FEk+o1KUxZ12pk=;
        b=0YTgtxRc1G9z7rDwnABxcg/ByXXadjxAutXZ1ItVvJh0QPNu1I0EhtOvaOHp6SHWoe
         sKyjlFNH7v0qDv7HvwHME/z2mQA0EEaiL/Mb7me4XwOz+CWtyGjmcyJsk+2oH4eudi0U
         752W1pzlKTyEkRjC22eSIJI2FU5zQUzJDctJ8NjF+3eZR78QVeJT/HmkztbO62FqkENb
         4TvzAcwoWgTZjcOiwonK45m58k2tptJ5122aJfYzY2REZuizWBn0L1XDqHi7I2kGgtJW
         +RiHSigepggpyIqULqYZvochfIF9G5yeZxxf/zGH1ZgjdOF+N9bWxAzMuFle6vhHxDl+
         d4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084656; x=1741689456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7wu7x2CGHp+hodRLerhrOyuQsqw+FEk+o1KUxZ12pk=;
        b=v0ekYEYk3ENkvo9uM9OK7l+fGHljfym2JAHs3TOcTDj7qvPphlawNWRij9MsL8q5W6
         E1MsOALAdkcN8m65gLSaMvD30Wdo8ZFMFA4zWfr/P5CFOhjfuuJt6tCWGxQb3X7TwnAc
         ho+BuOvsbWnsIDr967OnNlVW65gJFE/GKDTd/vitgw5lzByvvKfb7wA6A4wjxWkpms75
         abSnuS9/xUT/oRsvxUnUoOzgjsdm8dLZCQI4/zwMQsLc7+AgUzOHx3Thn2tLwYyEDZh3
         j5gEAvGEKnxkQpPRMYPqjEC4L1nbjxR/Wo0Aqhaol83UfaCS4S3v4kX+Sot15Ont9XiP
         z/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCX+kveiVI26YaP1flqs4GtCnMpPVCV+qh28uflEYHqhghNK84VeCgCmJUt8ufcnxxtSkR7ucdsHvL23ks/jcLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiF396w/YHv6rr00KhJM/EINBP9tQTaItY99nAxEVf/vgCRYi5
	nmeTnD8+txMWaSDc6FY3AOmQ6DuanQmMdAl0eO42vD9K/t4+Xo5HxefIjaK0omGqtJQIuZesA87
	0W7orTqDc+ujc6k2LiLGuPGUwyMtJTnpxb79xXg==
X-Gm-Gg: ASbGncsxDejfon5Wr7dmkVGpTZuWuHmngMcxcPxFZBy7dM2oXaRyKLwfYYKV/GRzqrM
	l112v6iqA1pR4oGySMznUXRorTrVaLObXqOFRAUGSryASDozvHRLh+ER/fOLdb09mKLf6iEz1c4
	6gbAEocc9zwvEaiiwuzTXhpliDUByQUU6+IRpfXzaczclRfxgamBoDQZkYIQ==
X-Google-Smtp-Source: AGHT+IFB+Oj8/Xe4YEFmV/Rb3Rt3KPraZIDAVAusl2gbbTUJaqBBb2xF6ULfEj5cbkgmnDxxA+ahMM664a5woA/zI1I=
X-Received: by 2002:ac2:4a74:0:b0:549:4e80:6dc0 with SMTP id
 2adb3069b0e04-5494e806dc6mr5633715e87.0.1741084656455; Tue, 04 Mar 2025
 02:37:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org> <20250228-max77759-mfd-v3-5-0c3627d42526@linaro.org>
In-Reply-To: <20250228-max77759-mfd-v3-5-0c3627d42526@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Mar 2025 11:37:24 +0100
X-Gm-Features: AQ5f1JpxU_9Y_clBmQu6eNXqzblGFz3KZ1pj5Yu3Z5R1OCnwlBjw0Sc-D8_i8O4
Message-ID: <CAMRc=MeYXFonF8wcU_5RzSYpTUXEhnY+wpsFKJQ6-EJ1h=K3Wg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
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

On Fri, Feb 28, 2025 at 3:25=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This driver supports the GPIO functions using the platform device
> registered by the core MFD driver.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
