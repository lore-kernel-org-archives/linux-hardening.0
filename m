Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C13175A9C
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469235; cv=pass; b=Le5T+LWuZ+rXpLigVM2fyiPK7hTMVrMlHnZGZqAcSSIugp+uF/q2IcmSFJgiQ1SgYoDTeVrz1ubFw0fuL9XuVD9V5PLSnCGhJuTd9XaPN8YO8/AF8z3/ozpJU+0U22EhO6ZC8GyJ2a5+JF9fNttfdP8/fmKEdgzQT6/gyQMHXAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469235; c=relaxed/simple;
	bh=WY2DxBxCJ/QBllizFnq1U2yYlyMv0RiPTaPJNnareHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZmzgWh4A+sema+wMoZn4UoPl0tYmHsCo0V8a65aAJXrZvM+0FVurG5zTMpHB9/nhCfSJeIax92nwaLk5rwk+smcAeIFVx1lPD69d03JkVQQmaBkrb1wsIO7K3hSFssXgpuPi7JJ9s9YsSsnqDs8xGKeUOzj6VxJGPc+KHdtfv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9U4sJQ5; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9U4sJQ5"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b936331786dso1650442566b.3
        for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 06:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777469232; cv=none;
        d=google.com; s=arc-20240605;
        b=TdnBjiBFVcJ8SgCH8jJrmcV/9zB2br0gvylDD9yhJxP6vQoi40bQG8lbTxwFPWdRwo
         3+312DbXUUKnZ6+C5F3kV+UilHk6wa2bcbyylqURhImvwI5409koYklvcdD0hUQJNIaa
         u8CY1ImYtJFjc2309eI5E39swruNGVxEywrBd+IFlNmUjZnGlL/vh146h9yt2+cd0mjI
         cN7drvQIJaUcKd/Z9Y3t2I4Lb3HK8ig2P9KrYv0sCMtbXCae+N2eOH2yUJVQcGflC/Be
         B71mBUeFwIOiztF9rvAP0ldEFaI+TbKMpmsXPd/jOihYw2pNiz0RETzPQxfY7IWVBDXF
         U2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bz4jxdxqMLfYB2vEH5A/J+EMTljIaCywfn6PZBJ4Kh8=;
        fh=n3McbDmu/KNoq+EsUeKmfDnLjztEWDVAMSUGlQuhtRc=;
        b=D9KiKiMIdYtAJ0ZC31Q1dLkdvOfiFN3HX3MG5WiDBFYIXMjG60S4x8blrQOb1ObuSR
         YwWMneftUVci8AYQk/ay2IQmXE11EzitcX7YlGUk9zfM//NN/pfi3j3iO2zN9IlUqu63
         PcXTtuC2QJGbJJWBBkpCuoC4yICvo41RaTbGQjMBV+oijNhrg2eX1V/xUY0Jus4WDaah
         RreregzMk8V05Yt+oVpAEC6TgyR47Cfsx23H1PT3ntrJUUoEJ9KBxsIxrL39mvuF5Xyg
         AGv9tSR1SzrKqvwkyoBTnr78QUE0ya9QzHxt7kLgH9wBu67hpr0SFjudMtNXIOF8a6MM
         aqNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777469232; x=1778074032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz4jxdxqMLfYB2vEH5A/J+EMTljIaCywfn6PZBJ4Kh8=;
        b=P9U4sJQ5zyBgSUJ5V5utsgrM+owRtvjSqQblO+0HMziLeOl/ApnqH2w/s0t6j44S8I
         kCiVxHqk6HSCJKv2aO7z6NLLcbpoai1wS9RXa0rCX9tRi5R3qZmgM20UsKj6ibPXnEd0
         U1nilYYn9VIIYpO7FyhLFT5LldSLzeZT9I70B+asfXlUyrqkR9Kp/2R9Vy911GPGjnce
         FP7TvPoQzpdBchBZWjnI/aX2MzLiT9tsbKBWM1f5mnJhI+k/m9f1Ljn/0nZ4+vg3uzCg
         wOg3FrK2ynrxpE7Srg23cnbzzFuwJ1A3vqWma/lixqQ/7K613s3IYegiN5z0C6M0beAn
         aSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469232; x=1778074032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bz4jxdxqMLfYB2vEH5A/J+EMTljIaCywfn6PZBJ4Kh8=;
        b=j5TClbCicL4P00CQfqq2KmD1lb37SgrTEeg5xQ1on8lmHOAsb7lXa+p4XPQOKbrUYX
         buNxqqLrZcj3XoaKTeO5cRpQcfCRFU6y1YCL330S+IXz4adTawT1vDz/Ia4Hn66U4Lda
         G3a2LwjBnbynMgDtv3axw47eDiMUxAHyup3R0Qm/9h1gfTxH3sRheTWltoCuo2wQ28VI
         I5XBfVij9aTRVl9h3KVvTfEs5tYDtukEt/3USM47ONIDnVU+0Fj/Gs0FLaOo/ov9yty9
         RLMaOFJnVRet6dON06WACeRdt8o5ISg8CbD1IaS62Sooo6oNgiL+yMKlqoMhIWCJ346w
         bccA==
X-Forwarded-Encrypted: i=1; AFNElJ9Z+oAHnf8Pt4BC0FZsU1ItnUnA2XGY+Xnw9EdaUmNX/yh/9WrgpTc+76dlyAIb65rOfZTFKnYFUsRi+g5Hi3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmhPOFFZ+jfZoSZSij0IreDFY3zBfY0BDy412+DHnvR/QdgeX
	QpbgHbo3kyfBQQW/pa9NwpJG8dxTyp4ddPdWA0dWqYxLIM0cfwJEovy74W+IQtdRVw3GGiWdMJ3
	RhgX68uRj9wuq0xURc/7f5i1ozPWD+kE=
X-Gm-Gg: AeBDiesECkMgH6uZtxTqeyEHNzLw4GPDhemdk+z5eqCtTPzKQJBByjEMf1vW3nEyGdF
	kn1nfUMO1ldR8FDfAp8AOS2yDkxTQ+cTsNRgbGcK3m9qr3ijvrTGvQ7fmOD6oeGafq+vYPbn7pY
	0M5RfTUI37LEUa5TIlQJAkyOLTGxSN43wcnCx6mQTGAyjMlmea5tomIPoZJJfUpi+kIplWPRsid
	y3eO/Hdi8lK8KSpbsMEkyfyjLdP8dufnj7eo0m5h6emKZPfR3mE4wzAt9UQs73QJrSqxM6zN53y
	2YFd1647zizQTQBMPQ8mXRPnl0KWnIT1HqF8Ra+wUg5sJGAGNN4mJX+lWDl3AkQklLHirLVCBfE
	3IEvjJ38O+LeVNU/3Ow==
X-Received: by 2002:a17:907:c007:b0:ba6:4e0f:e3a8 with SMTP id
 a640c23a62f3a-bb8022c2c58mr537575466b.12.1777469232296; Wed, 29 Apr 2026
 06:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777369070.git.jqqlijiazi@gmail.com> <0765e025b80f8299e4c1f92332929b6a385465d1.1777369070.git.jqqlijiazi@gmail.com>
In-Reply-To: <0765e025b80f8299e4c1f92332929b6a385465d1.1777369070.git.jqqlijiazi@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 Apr 2026 16:26:35 +0300
X-Gm-Features: AVHnY4KoqHn0C9nqn4l_0nlacYH-5YX5ouHVj9KcSVeG_t1jbiHnikOdQU0RipQ
Message-ID: <CAHp75Vet9kbBTduj4RAzrT0H9JZ4792Jv9tCFJVaxjfJHKUGdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_choices: Add str_alloc_free() helper
To: Jiazi Li <jqqlijiazi@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-hardening@vger.kernel.org, "mingzhu.wang" <mingzhu.wang@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 2:24=E2=80=AFPM Jiazi Li <jqqlijiazi@gmail.com> wro=
te:
>
> Add str_alloc_free() helper to return "alloc" or "free"
> string literal depending on the boolean argument. Also add the
> inversed variant str_free_alloc().

...

>  #define str_no_yes(v)          str_yes_no(!(v))
>
> +static inline const char *str_alloc_free(bool v)
> +{
> +       return v ? "alloc" : "free";
> +}
> +#define str_free_alloc(v)              str_alloc_free(!(v))

The appearance of the function is sorted alphabetically.

--=20
With Best Regards,
Andy Shevchenko
