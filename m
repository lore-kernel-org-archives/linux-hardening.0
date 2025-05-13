Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECABF28DB70
	for <linux-hardening@vger.kernel.org>; Tue, 13 May 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142651; cv=none; b=MJpgVIDrb1hxCuDt2qYO2PLb1JQyk7y9LrsaW1O3C0VmlUNiha5YjRl0crLcVk0EGKoTmGxbnogQc7983xybXcBTCPskjg+Dt3rLh2pHt6bTXPqBe+VQCEtRuSfY4qZJxBaXlSWk8Ib19OkPCpEAebipS0Di+Y3PSeJSJfsdWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142651; c=relaxed/simple;
	bh=5eKxaIX3fw3jx/+XOFOXndB/4SjWjO6DJ61Rmj65mQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqcIuwF+xWyDwRKcViFybM50xjsrYfdQ6yu63p4L75nwMV8SkifXUjw1mkzhfKlrJcphXMecxPzSIUiUJhmaX+iMtBxXXjlgDPSyxX5f90ReR0WKvrdCQWWl76MJdDk3TkeSZ4kfCtwSfeZX+H4CJf5z9aEIdyfd747cu1UXdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DbwhB7RF; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbwhB7RF"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54e9021d2b5so8190981e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 13 May 2025 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747142647; x=1747747447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eKxaIX3fw3jx/+XOFOXndB/4SjWjO6DJ61Rmj65mQw=;
        b=DbwhB7RF1JQqu3Vx8YErtq3rTPzu9DrvuTZHBpumUlQ9Fqckpe1d5klxFnDVlvW9a0
         mbStNuiJFw6GfBvu77Ue2MiUVYjGnhfDkvYoBPIMkNngWUkdhBZXjME64mxikNmE9Obl
         Bx6okDN+VXaiokTpeMVKPodEUSYw7zYVqSwGTEaDg0KBuIMuEVTI8rbJ6jNHXfC0JJNX
         dBwe8fYiS2PsBI2LA87kD88l/WduHaiVSySc6bJYyqGQwtAF0gt4vSo2bG7RupqrIt0i
         P4v1bE3w+K2sqOjV/XJOYUMhzq9cJZChC3eoTF8Ug7CPfW77rOzm6g3EUgOlE3oJw2G8
         PoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747142647; x=1747747447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eKxaIX3fw3jx/+XOFOXndB/4SjWjO6DJ61Rmj65mQw=;
        b=uK+hsoc6XkcTy91jbGShCin7qyqx18hzRK2hhnBw8mBpv3SkGmZZEaXhEZQ2jAjLed
         E1omThALM4p3WiWccRGdObFzy9sOVg/JkyMD7iE1POnsp4nrjBa2EEumrmcmm0LI0Qew
         mWgaXdGzwgUw6gL3JCnXoXCnuo6DQHBfH55HLjEHTBtahsS2+Co0zSuKB0ZK/tLRmI4t
         uiX3Q4fnMDbCOwTVGrrRTAW6VDZoGNXhNDhjbaxTSQyPTcH6BUfM8WuvlCuAVworYWP+
         UpBeVLpAeITStsKFAjNHqtEHADzpQq8UqozknDWnQez6HL6OBrArkeieE1RL1klX3dgm
         iCwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9p5jYLHeU/ztyTL3ER6mgoDXUgovHWghD9YiUN8WI4ovChuVX0S1ai2O8c/dNZLWRQL+/oTkzV40J3W0Xsgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPSyyfhkJ++QZH/so3YqEzMd3PNcNpcWTo55lAe/wHT0RjFWS
	xXUEijzqaLYnXh9zw+qoWOi33Rd5KSuX9Lqf9rb3D8w6XFvJLCde+l2nIo5SQmgai1WwBIJH9nU
	VZBKQlfIL+gwk0k5OmUbifr/j1T0PcGH6ydV3TA==
X-Gm-Gg: ASbGnctj9xeGKd9J3CxQC6W5S30+CChHiCr5PErjL4IxkIvEMmb30Hc+5HzOE4xvhBh
	CMHKkVeoCdNhYL9bxplAgBomDYmQB/3e9jBqXIKGqxyiRYro48eDNnRXzMh3KT8wWQQJQq7Csk+
	G9nxpZ4Pa27W6+gFOYq5gtWErckWVpLzpv
X-Google-Smtp-Source: AGHT+IFQKowijPtKxWmuvEciX1nJf+TDzv0WZoqM/uKvRSmSrIT4h7hRJwXNUJZcQ/uYhV04L0dGE2029I5lSw65p/4=
X-Received: by 2002:a05:6512:2586:b0:54a:cc10:1050 with SMTP id
 2adb3069b0e04-550d0bc78b3mr1158871e87.15.1747142647002; Tue, 13 May 2025
 06:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-max77759-mfd-v10-0-962ac15ee3ef@linaro.org> <20250509-max77759-mfd-v10-2-962ac15ee3ef@linaro.org>
In-Reply-To: <20250509-max77759-mfd-v10-2-962ac15ee3ef@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 May 2025 15:23:55 +0200
X-Gm-Features: AX0GCFvUasElVjJYv3I7eVQPe0A6FsXnY_zILsVN3taTVIhvI167ZdVbaeRULuk
Message-ID: <CACRpkdZg0ZLcmGbFPqUmRpkw8DJYe5bY8yEDe5+KrnzTWxeXFQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] gpio: max77759: add Maxim MAX77759 gpio driver
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

On Fri, May 9, 2025 at 3:22=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@li=
naro.org> wrote:

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
