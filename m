Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B03D648A
	for <linux-hardening@vger.kernel.org>; Tue,  2 Jun 2026 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404866; cv=none; b=rTIf8z3RpBgqU5Gk/rpslEB2FgUYMGFYIzpYs7suOu80KsroI0xIlGx2eXMKsuTl3WXbNY9H+tj+C2iRRM7+4Rz9Zkj7fZD3JIOgOQS0kVuWt85hBLL+tw/WyTNQk0yRK92Ic4Wbe0W/sYqAapvZ2WC6DD9au0oWPw8AWbkb93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404866; c=relaxed/simple;
	bh=Sn677f1avDZkCsXDJK9ax5cLUEJm/EVUXZTw1JXjsYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsWihxWRkFfUqtAaCQX4HpPhwXfCtcqkvifS0r4FaHSHQuD4fiK2hYlD1/+K7Q5tTIPtZSy/7FJh7STmLGsORXNMUbzc/UBlpnQSAIXONwbxXkNHQfS7+TGGsBxmhBwyow4OF0WVN4aN7yyXf5brrt3pPXoS2rGq+4c93j8CnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-59be89d310aso2446996e0c.0
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 05:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780404864; x=1781009664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi8lw9em5f2a38ue4BrDD+pK8F7cdkfj8OF9muR3yps=;
        b=i81uZ5Eo83cvYlhABh+4OaIrvpDQ62kuWZICeo+0wZFbjIFoj0j+WqvOVle8ldfL0m
         xnM63qm19zCr5qC03bfiGUf6HafL7/XDvWuL8KOYgkBZE0NLInE3dMjwlLEADbGiQLl3
         nunEW78NKx5qZ+rBuHKk94GejATZ1ba4wpPtDYefqpMoAtqh8ODk4KJzh+vfVUMnmtsU
         MUQDMvAzWt9/aQu1y5RZ12qDwrc12GEYkyKJVzzrJE2fqoPdTXvFcKcWeOB1eV5ck3b0
         SnqFLjRBap07X0KXblJEEMfU8PGMe6ZqA0XUQyezsXRc31PpLngLJQEHLvYOmW/rf7Vf
         CzOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/45HRfQJwMdOEKPazPj4MqAjABd1WBa221ZUOyH3xc+lpGB602v4WAwT2bMJHmj535BnUmwPYaS33s487fXCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXOROCHsa+ygnoJ5sol+L5XFxX1dB/mxGNsS+nVVUvCJuO7yH
	g6pOcItb8jDS0HeAhZcD9LaHErdDjupAlqvkf7stMQykXvHtqvfHttl7qPtlY6Klxzs=
X-Gm-Gg: Acq92OG5RHEXFAY6eepek6MyT1dUP/mwKawA0P2qVk4eHj4SK4HNM0ajZhVub/TCJqv
	1oxMPtDgVOOJYlhq7BEKxyr+SVsCBF03z/0SbSjpZg3ZvD8K0wVKG4Xtxas50s+NtRKBAKEo6Li
	WCfhddlwXvNcCS4L2bjZvdOgmO7LlXbBljdzXDq2sMrj+g5j+cr4KJ+SaS2cvF8dd6OvNi8EisG
	iPdKewS6ajbn4InmQO5iPPoKhvwlhbssbgCvVCCv5DtkXuxKNFhuO1SocGPMzaETyhEqozv9Lth
	82bes4C6dM2ij3Tegl+kxcwBJSMrXVZOw1mCJrRiI3UU/kk1kCSnSEIqNZmaQVY2juXyalGZ765
	4sZvjKtOaMOeFUjJf0r0KP4g7Jr5IHah6LvCHwDs1flYaWutVZo4UoJthaNh7rDivAZYn7TaIbZ
	he1jqryTpkJ/tV9diEwR5JjXlPmToZEWZ25HoVpnV76phX1j1+XhhxcAuzWHMmrXouDOGNJw0=
X-Received: by 2002:a05:6122:4b1a:b0:575:fa0b:bc23 with SMTP id 71dfb90a1353d-5a3fb625037mr1740181e0c.2.1780404864436;
        Tue, 02 Jun 2026 05:54:24 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a3a9818c89sm3559008e0c.10.2026.06.02.05.54.22
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 05:54:23 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6c67361fa3bso2216188137.1
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 05:54:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+mdlD9QkuKEG952a0lvAPgUOfo1FNd4Q4tcnpEBusrQm0K6H92K51LVOuB7UX+dfUe7e/x8KqlA55pTDbA6yg=@vger.kernel.org
X-Received: by 2002:a05:6102:604a:b0:643:80f1:350f with SMTP id
 ada2fe7eead31-6e1841a6973mr1450406137.21.1780404862675; Tue, 02 Jun 2026
 05:54:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527202317.5347-1-rosenp@gmail.com>
In-Reply-To: <20260527202317.5347-1-rosenp@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jun 2026 14:54:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcqeaPmDPUDa-rWJjxQAsY6jfaQfMTtJJ3bUK-Z_32cQ@mail.gmail.com>
X-Gm-Features: AVHnY4KDMTL0q4heTM07BlcY3ivbV4ExX8CD9RluKc_4RyO9BG5F3XDi0rlWYyw
Message-ID: <CAMuHMdUcqeaPmDPUDa-rWJjxQAsY6jfaQfMTtJJ3bUK-Z_32cQ@mail.gmail.com>
Subject: Re: [PATCHv2] pinctrl: rza2: embed pins in the priv struct
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:PIN CONTROLLER - RENESAS" <linux-renesas-soc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Rosen,

On Wed, 27 May 2026 at 22:23, Rosen Penev <rosenp@gmail.com> wrote:
> Turn the separately allocated pinctrl_pin_desc array into a flexible
> array member of struct rza2_pinctrl_priv, annotated with
> __counted_by(npins). The pin count is now computed before allocation so
> struct_size() can size the combined object, collapsing two allocations
> into one.
>
> Change npins to unsigned int to avoid potential overflow/underflow
> errors.
>
> Assisted-by: Claude:Opus-4.7
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: use unsigned inr

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rza2.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rza2.c

> @@ -289,21 +289,17 @@ static int rza2_gpio_register(struct rza2_pinctrl_priv *priv)
>
>  static int rza2_pinctrl_register(struct rza2_pinctrl_priv *priv)
>  {
> -       struct pinctrl_pin_desc *pins;
> +       struct pinctrl_pin_desc *pin;

I will drop pin...

>         unsigned int i;
>         int ret;
>
> -       pins = devm_kcalloc(priv->dev, priv->npins, sizeof(*pins), GFP_KERNEL);
> -       if (!pins)
> -               return -ENOMEM;
> -
> -       priv->pins = pins;
> -       priv->desc.pins = pins;
> +       priv->desc.pins = priv->pins;
>         priv->desc.npins = priv->npins;
>
>         for (i = 0; i < priv->npins; i++) {
> -               pins[i].number = i;
> -               pins[i].name = rza2_gpio_names[i];
> +               pin = &priv->pins[i];
> +               pin->number = i;
> +               pin->name = rza2_gpio_names[i];

... and simplify this to

    priv->pins[i].number = i;
    priv->pins[i].name = rza2_gpio_names[i];

while applying.

>         }
>
>         ret = devm_pinctrl_register_and_init(priv->dev, &priv->desc, priv,

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v7.3, with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
