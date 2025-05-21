Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCB2356C7
	for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747815087; cv=none; b=I1GDPefXi8rb+akaJIfBLRYGfSU9qtj/nMf9YwgonXQ9BK9C+laTKvbZ7n/HEvIxV8kSsIFrCxugWl3gSeTlqKCDpjqr3WLevMGRdC0wC0aSZg9GoCtm+39dXNMT5L9jYkO0XVBNCVDSHGJtr+k3OFkFrKDJybeRSk3H94OlWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747815087; c=relaxed/simple;
	bh=b4Ig0XOyQfEMoUAAjNHDQhh7+S48zOrx5dD261ukggw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2ltKnD0P3Icqi/lSlVS4SbZnJdXO5t7MJLf4+SVfWTtcDwBU3P7EFKlaTkFBvWokXFkzUq861bppsMbbJ8n3l2w5USjpb+izOFIr0x1tcw5ICTbi1q+P6C6NTYYEvoIRdis+Hc4sW8o8YwbZEPmiV8T5f3XFuHG460/ZtJa/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M+Fgxv0d; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+Fgxv0d"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54d98aa5981so9608989e87.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747815083; x=1748419883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4Ig0XOyQfEMoUAAjNHDQhh7+S48zOrx5dD261ukggw=;
        b=M+Fgxv0d/2YG9yBWAIwiGJ3yUSceU3ihyYgjTqSSntnF0Xk+Mc9NXHb3vvPbdQ8t9t
         FimB5zEjkRpL4lpZ5yeYgp5xGwmQyYLNerQslNakuU1iJ72gpWmNMmmPLOSX+u8XvXet
         TIp/0IK+e5vf9+4+l+pdNwVIf7wl8kZY9TdoMckfIoO5Xj4AhxaLn3putFT3sS2IklwD
         Pdid5pZg/QbI54rO7xYJ7y2l0G0gPk5rgWiEWrLO+ZkvKQpvxndigkZOOIMh2NDARsO/
         JPZGEn9YjiBNlGc7eOfDyjs1Mi3vTJ69QRkp1jupRoSiB7MH4roQhLkoV5b9bAL14U2B
         zplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747815083; x=1748419883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4Ig0XOyQfEMoUAAjNHDQhh7+S48zOrx5dD261ukggw=;
        b=AEnx9uEO+0d0dMdAuAYIbV7pffDiha2SMUxvM3Rvi4ONmzkuELQ2qX+os6WOLBzT5p
         kxed7skNB6WDme21fBTaJ6vbL4esHdkFxaMGEXsZGtsJmpxti2pRaLDOoj8RW4dtIi1/
         O+KSqa3jHF0aPK04O9qKSAtOA34TuIS83zABk9Op4DPWxUZiPP+XyAI5RqSsJV6oKYbp
         zP0uhqUJJYFHEQfZGQTMHo3zAF1wwWBny4McVW7eBvGtRrYOGcP/B9nSuPO2DkE33Mhf
         CGyPg/lKyxgLzz5t5Dwwe16PhETnxFUgtWFaWW1iMCF9GjZfGWAuJEsfQ+Yirsj/yuxO
         Xiww==
X-Forwarded-Encrypted: i=1; AJvYcCVb2fB9SW4YWleZCLqMZAf/cPqZNWKwfT9KMYJu0+Efc920WsiWuqQu+Ry6l/3baMKC6ntlK8bTGCq5FZdn+mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeYWG7X1Y6hb6aFTKaiHzBFHYHH4PgmOx5I25AfLTHjRigziY
	OYSczQTlzyztkfAVGpgeNpcQSLrQti0gwCtLLmfcmuG1/P9nKcsV6OGxeh908Rs1sj39AgCRqMg
	Rnc19oU7bUFDetNJTlB0W4UGJwEtr9wDJgVZo+sPvlA==
X-Gm-Gg: ASbGncux0gOZCwrugOI3FUCYcf/Q5kLDhBdkZ4iiFmxPoUI/vXeThpGUvEQ9RmGG5Q2
	KCvdlx2CB00fO3Q45Wylp7WLHQTZDcHId8ws8/oF4ZjswP2vyHosM7Sw9KJz+K/ckJzxQvYEJiS
	4bgn601XnZFJNemqoxpHCJtMkaqx1KBTbl
X-Google-Smtp-Source: AGHT+IHr3PWCQAtuLgEYwRwwW4iRxfUP3QxoUSfN1BXwa21y3iPHsi32IWoXuUCO745fcwdxDECQuaLmM/WWBqdXJzk=
X-Received: by 2002:a05:651c:421b:b0:30b:a20d:1c06 with SMTP id
 38308e7fff4ca-328075fafd4mr52461801fa.0.1747815083428; Wed, 21 May 2025
 01:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-aaeon-up-board-pinctrl-support-v6-0-dcb3756be3c6@bootlin.com>
In-Reply-To: <20250520-aaeon-up-board-pinctrl-support-v6-0-dcb3756be3c6@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 May 2025 10:11:12 +0200
X-Gm-Features: AX0GCFtgrsoYedOY9iI8wKVEZEWG9oGL9tXc9fGDI2DAkg_LOqFcWmofxbD1UNI
Message-ID: <CACRpkdbCUPQT60-bqLhgYHLLUYd3ZcihZ9PV-x__UGPArgbnkg@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 3:28=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> This is the sixth version of this series. The main change is the rework o=
f
> the GPIO forwarder API as requested by Geert to have more consistent nami=
ng
> and parameters.

As Bartosz said it's too late for v6.16.

But I applied patches 2 & 3 to the pin control tree so we will get
down your patch stack a bit and less cross-subsystem noise in
the next kernel cycle.

Yours,
Linus Walleij
