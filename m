Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4562973A4
	for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745915950; cv=none; b=iJ9LWHI0rPRulQtCr8KqSUAUVsSOutD1hOxmJiTRZmnAzdAzsnGMtAoRR7pMRgwRR6soAeWbd8ruwE2ZthXRR/XVo78cgQpPLPVG8azZK3NcB5x1S1w38T0wBWmOOi+HVmAUY0XftnBO5Q91zQ133iCiXH5Vzb8W/K6WP12IpK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745915950; c=relaxed/simple;
	bh=UXd6ZBRFfyXJOZgQdgT9dBLzGRXvPHd03emOjSyDqxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szR5H7NylxzVYpKGGvrZZEhAnEttF7ycwNYj3CmIbC0nq4/YYhR4w0o5jkmf/dKjd2vVUpgOeMTcrzu00VLXO5gKa60l6aI/UN6qqkTm671YxXdVjShj66mOzL2EO/qbjTB5Mew6Jl+WQwQuiFclkNO3OKwzCHy8RpwQhtHaCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=n6RwMuSp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="n6RwMuSp"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54998f865b8so5818460e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1745915947; x=1746520747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXd6ZBRFfyXJOZgQdgT9dBLzGRXvPHd03emOjSyDqxM=;
        b=n6RwMuSpP6AkmsI/2yevJMtpE6g9Kd1dNdZ5AVb7T6G+NJ1G+k7Az5ONBmmtpDYHf0
         Lzo5QA7fdy5orVNAn/hh7qEXcM0PtI3wh2pIbqMPfC66nbwABl1K5/ymMnhv8Q+X9Kq8
         3F/uJf3JrHg/VEhbX4Ms92lbZ3i6O0lo7M2w4AwmOLBcmRg1DqQj6wbGZC06XwQj7aF+
         Mr6/3/cID6/FL18dwlqIXcHxaCCakrTxmksKWAMfTZtp3iDLpCqqOQOkfonYE09MVKi1
         BShVXIDgLWRbclOEoRgb5lPPLlYbr3hZmhqwcc0jVjTfWF4/dA6fYY9Z7Z5He5+v1eWf
         9rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745915947; x=1746520747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXd6ZBRFfyXJOZgQdgT9dBLzGRXvPHd03emOjSyDqxM=;
        b=sH3vJm8BkGc9yTamUSONiDkF4OcwnTJqnmAqFzQYm7KdpGZNc0RhQLVnECf45/Qo3V
         brEfDD3y9UZYE3mKLXDCmf15BrDEhCAh9nO9iFRbvMT0vrfaAlAq3d8C4t0IMhdV2du7
         c3nx6rfKfVMtx9U67se2OEm+Iw++JJ+s+iCkkUlTHifKZvcsqaV4nEbQgi0a9OmvlLFm
         JJorQ0pY3cumz4PdmUsIHFvU/w3ulsBOmnEdyaclldeSNh1MiPobhSX18VW0/OEUAzRK
         Doj0MieGa/CNesRsTM3ohiOviUYKdmpuO1ujhMQsIVbHQV1wB1t+ZdwaP7op3EJ6x3Dd
         Uk3w==
X-Forwarded-Encrypted: i=1; AJvYcCVpaebaPfgmI3Qp4o7RC+qNz+KNPljJoXHLRotsnaA4uPaGd7/077AjUHFfrB1WaU/OwQJ493SrXLVDM6vyGCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoa5zorlXCtvCFop6tPv1Bm4X3eyyUtxaheb0EicHu4RCfOi/q
	znR09RAEBI5V9ozJ4bgwZnqkNzKL+5EwcDfhZZCxNYviywuB56D7v3/a4JBqZLkz8nVWTw3MajF
	Lie3gDxjNY1xSommeUjTEu+g9yBmhWdsqcOkeXmTeEuE5ro+8wcY=
X-Gm-Gg: ASbGncuXnUPJwJmU4taCA2IC5ENgGWF3H0pMfGv7fkYzh231SlJ7jDROdJ1kLALj1fh
	U2FPa7e1bg+EtvZ5MfVJrmrdRAzP34MMLFekGit9O3YcChxNBGCAVjGjtuRhVVadWw4zkgzxew/
	AyoLk/W5sY7hRxMYc3jqUEI2nZROS3K0RN4Q8yxLPpkpQqoonJeVWnDYAOzn9nTR2v
X-Google-Smtp-Source: AGHT+IENnVjqUwXNLAYDfTiNrsEIWwNs+6d+NpV5FHnYd17iK45VPUqKM3XyJFL4hddosaZTQWV2RnYYV/NteWYUjPg=
X-Received: by 2002:a05:6512:400c:b0:545:5d:a5ea with SMTP id
 2adb3069b0e04-54e9e537c34mr615854e87.3.1745915946982; Tue, 29 Apr 2025
 01:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-max77759-mfd-v8-0-72d72dc79a1f@linaro.org> <20250429-max77759-mfd-v8-5-72d72dc79a1f@linaro.org>
In-Reply-To: <20250429-max77759-mfd-v8-5-72d72dc79a1f@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 29 Apr 2025 10:38:54 +0200
X-Gm-Features: ATxdqUHQUcFHUAFI3-nZJt5a9IRI1ekBnea7Lczn1CqKEhZ8m8SpsIrkkBLDoLk
Message-ID: <CAMRc=MeizZec6YkYhNDEh4kE4hRO_wJccE=iy0-PKu7uX52u1w@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:22=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@=
linaro.org> wrote:
>
> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This driver supports the GPIO functions using the platform device
> registered by the core MFD driver.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
