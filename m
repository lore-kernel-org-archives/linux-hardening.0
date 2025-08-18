Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63673308F02
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531967; cv=none; b=RpxhhHeFmWee6ThCv1r1kqgrhf/7bcEljGFC+vpMhX7mgrTU4eI/kWozV2DiTRJJysNCKyLN3GWYrZtoRV0QdIwjWmandLLSp3zk0/OSNkvG7bm31ES6QVHlcsT8VYRrHrXnRHNfQzenUhpuiwWeayJtL3n9IpcgMVXFjLWEqOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531967; c=relaxed/simple;
	bh=V9A8nqHTup9ZR91fdAkDX3/VWJ7GOgH3IYdlBgF2tus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUmchH+4KeTRZNayMl5VhE7F+0S9aZn4j2TesEP+WftvUmNKuV1oJKyLmBuM51BPkK07PoMFR3URra0JFFSt4YkfWKwmAvL989jEy32JKd/TaqQkLCldb/vRH8CYVOgdv7zmIFsTORFHIKhXoY2G0cz+q75k0EyHJu2qONw1SSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pAgOcfzu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pAgOcfzu"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333f8f0965dso36118631fa.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755531963; x=1756136763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51DTC+MITTH703qrd2I1XRJ94G7+1YiQ7tYFyiKxmzY=;
        b=pAgOcfzuZdNXo1QLi+fdQv34MCOtqrpMynZ0eBD00VmnEmvuGzoMFEH7DDj0x43JzN
         vq5kx7nXJtGxc+upulCbwaOfSSvcH6avZ1FpAIDz03rUvwVYgacupaJbHyKbmenvNdKJ
         VcxHX/WM6FAtodKfDyerntyX/JZN3ki6UGW7STWzUwTisrlA8xZ8Q0ZlIvm2WkySeXYC
         ZzRiK9tTX5KRPDeHP7l4sALiLbQZpuOuYXbvqpSHBvoA7rb7BBJP/XDxhV509A10uWvK
         aq4eWbJvlFDf5Eu+JxUI/TaW3cb6arhmOxtsXeqVgHiXnr5DwKqCU5M9Igm5NGtcsb36
         pkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755531963; x=1756136763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51DTC+MITTH703qrd2I1XRJ94G7+1YiQ7tYFyiKxmzY=;
        b=PXCy46j/9ovmGFb4fHTYF9Uom/Ahir+Z/DS+x6t/83ctGt86zuEv55dV5Ayw8AoOw8
         O3ZDb+ZfZgqH4mVre04cvQxwOxQ8ZMXXENHfq4HvX5QvB9/U04oikCafTegVW8Am5AOQ
         NBT80jjJMLulqfuSgKbtSvoWD8h1fywT5cbPbqznYA1pP/DRZjWeAjd0Z8mqwm3qpS2V
         ISUsDFHXIfNkj7jz0WkJAzU4XmEEbBpq1xQeS0PI36LLXJbCBAJ0BKgOLkvVfbCi0CSa
         kzJ1NSqIhhXW9PLARJZ1qED3gT0+TERg754cM9uLY+rNnW/H8HDZ0dpPXEN7MmysyWg1
         7Eyw==
X-Forwarded-Encrypted: i=1; AJvYcCXQtYXbbrw3pJfUrsjw4PxVCqjf3VNjppsMw8wydzaAy16210dk9gTi0ozanV8bOKwTk/WRINqFkcFLeHpdrS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvP41qlaG1pWBD9Njn2T/1Jf2d/mA7TFpZaP9a7ASfXW5sJVP6
	j3QelEycPmW4i7cKDpgbhO3qRGD0ltIFYV8EhSy+HJcPILYAXRlTm1lUmPhk0CDGKJ5kvS2ZFBY
	BkI/o5YFwy/+KXPfQdQ+0eDYyuDo8gKotZHkacdyw5KkpZdJ2vPa5
X-Gm-Gg: ASbGncsH3CB7vjblF84A+0NRl7RFIlPAQn3pXhTVjHmirr7ZmSOoLKcDbbcIA+XzLRL
	kjEhnBuj/r/Dhm49gLJnb+Sd1w9b8ErTw110ZQMsKtLbtpYAdYC4CScuLbHTqo8IuE9+nAmYR4I
	fG7k/4xbIV5Qa0AihubKwOGp+XWTrbcCmNeWAfZKUoxXzqcWKbZsFa51qU07NMx0O2Nx2Ofw5LT
	rBjUB54MLJS
X-Google-Smtp-Source: AGHT+IHwmWtaGT/XklYdjGHxL0ZkWBsslCIIfDul9Sr0lAl+wS4aHTOEpnoQAPHxKPwDMb6Ei8e0PuqlGjO+zjkpvos=
X-Received: by 2002:a05:651c:510:b0:333:f3e6:9f2d with SMTP id
 38308e7fff4ca-334097ca050mr27791091fa.6.1755531963498; Mon, 18 Aug 2025
 08:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-aaeon-up-board-pinctrl-support-v9-0-29f0cbbdfb30@bootlin.com>
 <20250811-aaeon-up-board-pinctrl-support-v9-10-29f0cbbdfb30@bootlin.com>
In-Reply-To: <20250811-aaeon-up-board-pinctrl-support-v9-10-29f0cbbdfb30@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 17:45:49 +0200
X-Gm-Features: Ac12FXw-f5f96UXYk89oFAKTC8GUPUN3mfWKfLNKZL2BLwooNi64tGeRuwAt8AM
Message-ID: <CACRpkdb6XjX0unh70Gwq1dmLdGjo=19W39fziDd0L8vT3g39hA@mail.gmail.com>
Subject: Re: [PATCH v9 10/10] pinctrl: Add pin controller driver for AAEON UP boards
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:25=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> This enables the pin control support of the onboard FPGA on AAEON UP
> boards.
>
> This FPGA acts as a level shifter between the Intel SoC pins and the pin
> header, and also as a mux or switch.
>
> +---------+          +--------------+             +---+
>           |          |              |             |   |
>           | PWM0     |       \      |             | H |
>           |----------|------  \-----|-------------| E |
>           | I2C0_SDA |              |             | A |
> Intel SoC |----------|------\       |             | D |
>           | GPIO0    |       \------|-------------| E |
>           |----------|------        |             | R |
>           |          |     FPGA     |             |   |
> ----------+          +--------------+             +---+
>
> For most of the pins, the FPGA opens/closes a switch to enable/disable
> the access to the SoC pin from a pin header.
> Each switch, has a direction flag that is set depending the status of the
> SoC pin.
>
> For some other pins, the FPGA acts as a mux, and routes one pin (or the
> other one) to the header.
>
> The driver also provides a GPIO chip. It requests SoC pins in GPIO mode,
> and drives them in tandem with FPGA pins (switch/mux direction).
>
> This commit adds support only for UP Squared board.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

This patch applied on top of the pile I pulled in from Bartosz!

Yours,
Linus Walleij
