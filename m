Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5583146D59
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394011; cv=none; b=CMWDBqBOUPXsvLOPmbEuw9+i9uWWE8SYBwaTCEq5lCCeLe9eDffWYiR8UV/ph+QD7MranAgxWelTLf/s5VFHv46Hd5v4P/fVZBvLg9w7r7/pxr7GJXsBemhgfXifg7FXtdcvhk3oQmuCaAtjYFl5RTKOUM71OrayYdgjYHvbyAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394011; c=relaxed/simple;
	bh=jdKD75sAUfvwkuog5Jfk0+OozKUBFk+Qyg7OlSdJQ94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KsN4eGk+BDKdZlTPa5NHbHtLJfVpamZA/ZcQ2EgzCUF8Rld/vZWXQmyOQ5UNdL2yQbrH67fFSANXhhwnC6Vjn+Pvo9NnPsbEP8r9wKxnSX0iKXDWm8Q3mjHhsC/5dIJouCJiKJFodN0SAd094ungVEm9VIGKBAqVNHwBwKOVzoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t5/z7dv8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5/z7dv8"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f286b5281so2049720f8f.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740394008; x=1740998808; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w5/GBx+kg3/mCJeQFrD087it3nq31yjKlpDJq3YU0tQ=;
        b=t5/z7dv8HlaBNVISV1qfJ0CsqhwXmS88cwXGxiqlQFFaNU2P4dXNlB8YX47rxxuHGe
         cxy5QivOySFhsO3Vbgu2O+8RdVUXEExrOhS/FzvG5og+aKuMU7DmKaBUkK6SBddYnlKK
         plnuqlxVBmJFT5S8edu8z2QV+JE/J/Q0LSkeDQUmV2ts9eKMSSxyoxx5tFwCo03TTlyl
         /2bIpl/8EBua1CQcvp86hrrpjh1iZ+xznvWdD5+RFZriXr/UAkuOxAy0rBndG0fFdZJk
         BVmJJZ00MijXajkNRncU5Rosn4fzxuEcC8v9LuCuW9wrN8vRr6okZvc7d/sNHkTrkL5i
         V8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740394008; x=1740998808;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5/GBx+kg3/mCJeQFrD087it3nq31yjKlpDJq3YU0tQ=;
        b=CFvWPpt2EpSrR9u7797FXaXOMUh3WBhO4KJGM8JyEaZ3Qcf4M569L+lEWWLe5F+pbW
         paU+ZCao1ZakxqcQpSZe72cO7iSTO7igJSD95ZmyIQfoENgx+9x7NbKmARGV+QntPA5G
         knVGg/Kz1Kndu9hdUGEcGS95g4/Xh0SaeQUMUJ+i74qJDyvbT6k52Fvr3PB5z40bg0Xi
         LobxQKtSYaWLgyOk9t3DHz1ajMV2Np+/58yIftmvuJGaDKDDX462H5cSShTsk4CIva73
         g81NpM9H//nGc1tK3p+ZkJL9yD3J4t4okt3ynCNnti0IdksIk1rcEHDMBlpClu6XkaEp
         x5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0ydsncHSpA0ed+DtpwZ0c/yHjXjbZ+TE0vkCk3hqyi/nRhxuinlR5ydqtnDexy/Ui4aXyE6fpGwDgMcAsccA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDlfa5WrY5NHVSRcluAxQEtbHOimMHuOGBQk/cleci7iMGrxrp
	ygqjF1kpT6lP5r/9cw2dB+E9sBIzludx+sEDTJWYvP3WwPoHlfWbaa7nxAcrTeI=
X-Gm-Gg: ASbGncucVYh9osxomNn2B//L0oq1j6VbPHG3hLJmfYRqRhTl57u8A1Pjd/Z9HW6I0jt
	VoNM1/g2JHdUwyhGjqT7/qXRWbFuUTUQ0PGQ8Gl7EZ4fLSvNl5KgtsSIiXn5Xt6RSxUBkJqVGY8
	7d+Xl0K3zLNM9xg63yWd0g9Rz1ecwsQVWANgCN1/aOCN7MhulfadUTxdsyzsGyjf84cj/IcUTX4
	RrhZvj4oBgS9gxyON+jiGkGMI7bIHvsVq/pEWw225zwOrGmYIRQCCEE0UvnMsaYyffN5TBKyr3U
	JXAmT0kKtR/A+uCe8vqVZurZonLOyQ==
X-Google-Smtp-Source: AGHT+IHOmP2hx/rBkf4Acp+yVpSfNcuXRYdo4aGzHO0akGaVUvPF7o25mxQ1ki6jQ/embQ9fvsszIA==
X-Received: by 2002:a05:6000:154a:b0:38d:e3da:8b50 with SMTP id ffacd0b85a97d-38f7082821bmr11738921f8f.39.1740394008242;
        Mon, 24 Feb 2025 02:46:48 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5ee2sm30848118f8f.80.2025.02.24.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:46:47 -0800 (PST)
Message-ID: <d28ff689dae5a6a35fd408020b3260d6d0f18880.camel@linaro.org>
Subject: Re: [PATCH 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij	 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva"	 <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Mon, 24 Feb 2025 10:46:46 +0000
In-Reply-To: <20250224-max77759-mfd-v1-5-2bff36f9d055@linaro.org>
References: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
	 <20250224-max77759-mfd-v1-5-2bff36f9d055@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 10:28 +0000, Andr=C3=A9 Draszik wrote:
> [...]
>=20
> +#define MAX77759_GPIOx_TRIGGER(offs, val) (((val) & 1) << (offs))
> +#define MAX77759_GPIOx_TRIGGER_MASK(offs) MAX77759_GPIOx_TRIGGER(offs, ~=
0)
> +enum max77759_trigger_gpio_type {
> +	MAX77759_GPIO_TRIGGER_RISING =3D 0,
> +	MAX77759_GPIO_TRIGGER_FALLING =3D 1
> +};
> +
> +#define MAX77759_GPIOx_DIR(offs, dir) (((dir) & 1) << (2 + (3 * (offs)))=
)
> +#define MAX77759_GPIOx_DIR_MASK(offs) MAX77759_GPIOx_DIR(offs, ~0)
> +enum max77759_control_gpio_dir {
> +	MAX77759_GPIO_DIR_IN =3D 0,
> +	MAX77759_GPIO_DIR_OUT =3D 1
> +};
> +
> +#define MAX77759_GPIOx_OUTVAL(offs, val) (((val) & 1) << (3 + (3 * (offs=
))))
> +#define MAX77759_GPIOx_OUTVAL_MASK(offs) MAX77759_GPIOx_OUTVAL(offs, ~0)
> +
> +#define MAX77759_GPIOx_INVAL_MASK(offs) (BIT(4) << (3 * (offs)))
> +
> +[...]
>=20
> +static int
> +max77759_gpio_direction_from_control(int ctrl, unsigned int offset)
> +{
> +	return (((ctrl & MAX77759_GPIOx_DIR_MASK(offset))
> +		 =3D=3D MAX77759_GPIO_DIR_OUT)
> +		? GPIO_LINE_DIRECTION_OUT
> +		: GPIO_LINE_DIRECTION_IN);

Eek, I made a last minute change that I shouldn't have :-(
This should be something more like:

static int
max77759_gpio_direction_from_control(int ctrl, unsigned int offset)
{
	enum max77759_control_gpio_dir dir;

	dir =3D !!(ctrl & MAX77759_GPIOx_DIR_MASK(offset));
	return ((dir =3D=3D MAX77759_GPIO_DIR_OUT)
		? GPIO_LINE_DIRECTION_OUT
		: GPIO_LINE_DIRECTION_IN);
}

I'll fix that for v2.


A.

