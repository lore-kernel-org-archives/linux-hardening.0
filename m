Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6B487BE
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773014776; cv=none; b=OvdolM7VOBE62/kmPvvOXSnZ50GpJSF0GegCl9IdFkV123iDKjsFV5u3xMV9/RnbSAdc7B2aqYUugy8XJi1eHWofIwq1/Zxh6eeVYUipTFjqYQDNuaM5IzhNpugShB9j1ph8rA80JciHl9BOWT5TXkwnonTSZ9dl4Oqr4Hsew68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773014776; c=relaxed/simple;
	bh=7VfkDWCT25IPiML+OuV1VYi27QKD7JmygfyqI7YGyJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6QVKh3jGb6wIRCSkD0Yz7w1LVNtCUHMfhZVsnl/N6lBERBVRndWTR7GG9GDP2FrqMh2WVt8P5PlB8EWYuMGC+cakpfOXCTesn5LPlKgEei40IHVGVEEZRFCKtJXKc6sxfsBcUIQsPTTyYvwFC0f9WalhPsVKt0RcfMgYScpjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJblPt5j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJblPt5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A1DC2BC9E
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 00:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773014776;
	bh=7VfkDWCT25IPiML+OuV1VYi27QKD7JmygfyqI7YGyJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FJblPt5jpv/3qqX8qI8PbjgpkMG9LbfWYZPE3/oM05ArvhT3IO8unTa7K3/ZPwKJa
	 JUDVkyySyf9/39minIvepp61mc7TV4xkWXevvEITxaNv1WrrfqT9A0dwcqnuSCVFEx
	 AV3TPM/dO2SJyE0bGIp9BgtY8CTQeUfVKlIUf8Iy0TqLh1faCzoS0utycxfVwOGo8m
	 IPx56nFuVFlSCDpfaylVo2A+9YJzLJ+KgYJyF4D2AnDFarZvnmUINb2dAKk90nTnPh
	 aw7gusA6NIpzj01Y2EvGGd8ltrt1eguA2IzlP4VNwlgdbm8T7MlryKT7A9wYsWuNdP
	 68B9ZD/TtIYzg==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7986a347d4bso107421777b3.0
        for <linux-hardening@vger.kernel.org>; Sun, 08 Mar 2026 17:06:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNpFxu5ue4Y0/blODia4AozQ5Q5usy4Uf5WLmTwXCBsimTLjeLcCSunfKFwz7pYBekVZvjxBwyngBVgDI3nVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1tU6GgyllQ/7ZiTvLhdeGKq4XPRqPf/GCYHoyDATxGmvMEpU
	YZsSOjk76gq9h7BC/9WQlSBmGcTqe5cRsv3miTdSd7QbTZjS4/bj1WjFRD5TK0dU/9HIkRu2Y49
	8yBsRp7V0+Gtvje18ckV3xpmend0Et7g=
X-Received: by 2002:a05:690c:4d86:b0:796:3c99:1833 with SMTP id
 00721157ae682-798dd7aa7ccmr92587587b3.60.1773014775703; Sun, 08 Mar 2026
 17:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308021535.48098-1-rosenp@gmail.com>
In-Reply-To: <20260308021535.48098-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 9 Mar 2026 01:06:04 +0100
X-Gmail-Original-Message-ID: <CAD++jLkLj235Q=U_9E-hSneW5E42JjU=dRBJxKJNnqwgBLCm=w@mail.gmail.com>
X-Gm-Features: AaiRm50BkNsacwf3vNv8Po8_uyxzkaR51BCh7HDgMk0GF4BnX_1Cwh-_3Tsm4-Y
Message-ID: <CAD++jLkLj235Q=U_9E-hSneW5E42JjU=dRBJxKJNnqwgBLCm=w@mail.gmail.com>
Subject: Re: [PATCH] gpio: msc313: remove kcalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>, 
	linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Romain Perier <romain.perier@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	"moderated list:ARM/MStar/Sigmastar Armv7 SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 3:15=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrote=
:

> Use a flexible array member to combine kzalloc and kcalloc.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
(...)
>  struct msc313_gpio {
>         void __iomem *base;
>         const struct msc313_gpio_data *gpio_data;

Do you wanna add:

const unsigned int saved_size;

> -       u8 *saved;
> +       u8 saved[];

u8 saved[] __counted_by(saved_size);

>  static int msc313_gpio_set(struct gpio_chip *chip, unsigned int offset, =
int value)
> @@ -631,16 +631,12 @@ static int msc313_gpio_probe(struct platform_device=
 *pdev)
>         if (!parent_domain)
>                 return -ENODEV;
>
> -       gpio =3D devm_kzalloc(dev, sizeof(*gpio), GFP_KERNEL);
> +       gpio =3D devm_kzalloc(dev, struct_size(gpio, saved, match_data->n=
um), GFP_KERNEL);
>         if (!gpio)
>                 return -ENOMEM;

gpio->saved_size =3D match_data->num;

I know it takes some bytes more but it feels way safer.

Yours,
Linus Walleij
