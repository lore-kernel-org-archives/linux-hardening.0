Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4842E0B5C
	for <linux-hardening@vger.kernel.org>; Tue,  7 Oct 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843312; cv=none; b=HWNlS7Q+8LMSdFMe+42zZZR1pOLBDqI4pYw9a5F6HG+UUZivkwKzzMKRFTj1QRhiM1FXxXr+rsTEsWDiMYn2QBX+dAtFPY9HUb1V4+UR+jeTeoIZD0okxK4MiHXc8PMRobrbLZyyjlPOf+DrWOo3ELFqaimMCx6DeEjySR79IDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843312; c=relaxed/simple;
	bh=264X1qDN3aQAP8Oh7tuky79CRF6X9B+bbwWZ9c7oerg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHIQmlgTWmdSwyZZjRF/BuLKBjt11XpV1FY0L9vSQ11Tha2XOXd0lemXcuSsmUBMRhAKkQmimalgnbzc/i7zRJzP6v9/p5fEagIuLYC/jYwNM56w/AF1PI7wBtLjO7R8NHT2yPNa0RV62eZbLuouHqOQQ6RSWjrwIV0ViMaDLrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DKBRTvtc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DKBRTvtc"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-371e4858f74so70606171fa.1
        for <linux-hardening@vger.kernel.org>; Tue, 07 Oct 2025 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759843309; x=1760448109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=264X1qDN3aQAP8Oh7tuky79CRF6X9B+bbwWZ9c7oerg=;
        b=DKBRTvtcDoAdupeGLvdKBjxsZOnuPORThx375SEX3c94jfX6Pffhx5xH3YCdcUktDk
         8RtUgM4um/ZK/GRKugStNQkcV3NNh6+H4BhAdOqnnQ7MhWjaMligFBl6ArCo5HL+tODJ
         LphZpd4ve9qyEq0Mo+b1iID54E/1c21MHj0Urpfj6/yjhpa0+RL401EJHDwmg8+/vn5E
         KI05vXBgHusbGxk4mg6mf3W1JfiPIYmeDiT/Gd0N7DLhtLB0G6M1PZFl2ORfAIClUN0H
         URVsOSBV6rAG17C9j5Z41C/vIw5+dJYPwpNtzBWy9i8KSLS2bZZbGo1LQdFPTzPDTR3+
         STEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843309; x=1760448109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=264X1qDN3aQAP8Oh7tuky79CRF6X9B+bbwWZ9c7oerg=;
        b=SHOlRnqbNiRCw0Vnx9qbZeGGkI2C08ClcKLfZgeZ0DVtF10UdryBTpm7JMy0HtI11X
         VMcAQw/eZnxIL/nXAKYZu80YNdSpbg9Ln70PqYbogfyTLCVovvn0P8iR20oAghcyNiMB
         L9fXF28jcKgo4AWLYEVG/WQTcXuXvP7VdKN/mT93rE3B4gSuZZrMN1vMdMgEGB8uFfXo
         7Yh12P/klMRqyI45lE5m0MnOD2d7y6pJaXKcjGxevnMmHLZFn4kjN6jJq5msT1fzql8w
         YZjdVLkPM6zDco7hRRw2Y1+0/v2VFjXeNGjH0pVmhwm0jy2A47eF//oTyqC1+uN+fQ7q
         jhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGz5JDQMQGLvH+nB2D4hqKU6zyVWk9gA4bcLYJ0fEkPxsCgqpKuqsEBOren+g17/gV6hdimiv1P3zu4izrKHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+BG7D/BWIww0fodWjk77EIMrkvCFAEd4deX8sPD802S0Hiqc
	jr4rfihkUS859XMxZdQieV6fwR5BQeR/MT0x7Qlkp/TpioFfCtuZMBnj6qHljYDxgBJpSTLJe2B
	9L2sAojPJ5IUBIsj24URdO2QCEBY3xyl5DiRoVfFoKw==
X-Gm-Gg: ASbGncuJx5qI1kAVnEer/GrHdQldOiB4S3Ym4nRjt3slyC/5D/rsVbh7dnwZgsdIqK9
	PzJcUA5liYMTC78iGjcFQW8Yefzz2UyOX5yhyBZL7VM8LtuijWee7g9fWJrw+HPOjBJjo8pDleK
	mdx5PAolkBLQ1vCUvoyHxu27j2aVkStCIv1ZOEH8HiRgrjjlxkpVCTUVjNYa+LsT+0e15jKc3iX
	sRQWPoTdVBCZzIKTt+1N01st2g6j0Pdp+FJFFulHmqDqkRIdY3bXZtCw6LFkqk=
X-Google-Smtp-Source: AGHT+IE2+IZs52lFcgfooqKpv3k1qTzL2NCFC1USj9Z26FyDVKNO8SnLmrjpEF3qS87kcFqgJsuw+/Q2h1TIfSrcKYE=
X-Received: by 2002:a05:651c:1504:b0:364:c083:2fec with SMTP id
 38308e7fff4ca-375f516a094mr10405761fa.7.1759843309309; Tue, 07 Oct 2025
 06:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <0b402bba-0399-4f93-873e-890a78570ff7@kernel.org> <CAMRc=MfwEHGV-HZQURR3JNg1HatAeWO17qbRmkWUXTSBWj5jSg@mail.gmail.com>
 <80347dcf-419b-489e-9b0e-d901fbacc71a@kernel.org> <CAMRc=McaZV=tUkzDGMYxXqkuEYw_KasKcv8QGdjw709UYZuGhg@mail.gmail.com>
 <a9a4f33f-b6c5-4c25-8321-7b08a2afb8a0@sirena.org.uk>
In-Reply-To: <a9a4f33f-b6c5-4c25-8321-7b08a2afb8a0@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 7 Oct 2025 15:21:37 +0200
X-Gm-Features: AS18NWAcsMukxeTYbTWMUg8zWpW3gx9qkOJvdBd4XuNGAXfy8hVOWJV-QYlmbI0
Message-ID: <CAMRc=Mey+iRyKY7Ou=0LM1268r6_WuQDzYmLOU5MZbVoU1yugg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:18=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Tue, Oct 07, 2025 at 03:13:29PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Oct 6, 2025 at 11:55=E2=80=AFPM Srinivas Kandagatla <srini@kern=
el.org> wrote:
>
> > > Yes, these codec drivers are due to be moved to use reset-gpios.
>
> ...
>
> > anything. And what about shared pins other than reset? 'dc-gpios' for
> > display, other 'powerdown' instances, 'enable-gpios', all kinds of
> > uncommon names like: `dlg,cs`, `wlf,ldo2ena`, `speaker-enable`,
> > `maxim,enable`? It's not likely we will create a separate abstraction
>
> Many of which, crucially, don't actually reset the device.

That's my point. While the function of a `reset-gpios` is quite clear,
these are not.

Bartosz
