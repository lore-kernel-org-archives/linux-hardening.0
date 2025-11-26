Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D578233F36B
	for <linux-hardening@vger.kernel.org>; Wed, 26 Nov 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175816; cv=none; b=ex9KgRcldfTXD6b0NjVvlYRTCeYRspalGUbja7/JeYqxzYlzYEMpZs5OKkVKIIBM1yvs+VKt+Zbz48KMXjAPrSknS2Q5bTI4u6AgKuMqh7kanRTtsHtT5AljLmB9IYA61oqUkpTh1dsyBnW7Vt998+QLagfdFWC/2PEAtlRKr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175816; c=relaxed/simple;
	bh=lcF3w+6mAI/Vq6+cM2+Eb2QkIv1mzqYBu/o9g7uog+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGw0mDRsp5Dxbb+lPqTe7tKDpdph9m6N6NA+FblTfa84HwfiwGzSUzcitj09OcBz959o2b2TsM5w5beEOKGK3v/CdLCelgWnkxoVhmG9xgJz0Ao/QUORcaMkTpyJWwN8GuHQ84KwWN0n0da1loP5ZwpMECveOjJEllpfnmlddsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YV53HYJH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YV53HYJH"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594270ec7f9so6518989e87.3
        for <linux-hardening@vger.kernel.org>; Wed, 26 Nov 2025 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764175812; x=1764780612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6F02K/URUOBsb5sh+E+wRc/rv7WAgmGziAPvy9s7qhI=;
        b=YV53HYJHcWvYwIN2pceHE+jN+wQWPZYa8Fh7v9i1ULrLlo6gwJ0NgFiZx06ZuRgSz3
         BKaq08GI/LlamIrzwWbUh/VzDovUulYkw5JcJqzaQlzkrPSpWWe1LpLVxdKjkb9TF+Dc
         tJM5gXDyin/3JiJ3ny8fYbVljE91d9EshJdDTT7SO7dLO5ha8m8c0c4Y44vmkxJ0KnAb
         E64JZBWCc/1QlSH7hNR9QEv+o+3OzRk5sx8p0cRZbd4WvwFuL4p252uMf00bxlPbkLcg
         8Z+Bkz9IQEjuaiVy2UbGq1ZADTpHyQnkMo9Vag4iaLalMWLCHz4Kk+Yz3Hg60SrBVDVX
         NHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764175812; x=1764780612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6F02K/URUOBsb5sh+E+wRc/rv7WAgmGziAPvy9s7qhI=;
        b=GtELtkunqCbxNNcx8Fp1pinLsDZ8aFIIoQVE/3mcXYdAwU/HvAn612vZH7UAMspJ7O
         fE854JOF8O2PURX4rDjMUSlm+dNeE5P6pZJj8lC29IGiXuBSzbnjqkyECNZyb9JT0MAG
         YLVT8h6WL8jsuCmkGnFTOO2HNiNLrL4AVMvhpAYNhbHy0GF3hyEKvrWyUs2Aanli7xxU
         fiRteuiP9TEkR9LY7qyQxCvUlolXnAr4S63/Z+kbWC3kaFXJbInUJnyJac252E+/6pLD
         Vcq9RN82sCeISj90kGc0XsLPRtY0jpM3vSm8ndmikIupzBuOnL/sWfnc7A0Et2kd10hT
         g3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXl/fl86Nf3+NRO+sLB8iCKI2dV5NLaNqzmzD3qtzy682uj9I/6DQJi47/FF8l33XnWilg9d72dYG7VzPHX0ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRRdJ3/q2c7bjjoIPgrasoj1oX5MCKtEqKEg5vgcoFZnzyR2R
	JaXm7pPjpTuDvH6/9+KHkluM4jNmLTHbYKkDlG71Dn0yGzSLIf4CMtUAUw9aIZRj+Ybu2aplMH8
	E/ZqymfFNL3xO0AiBBxiMk16pCziCv7SOB7BWGJU33Q==
X-Gm-Gg: ASbGncvvSq3ItGaPLnXlci5jpZJC2lZ8n4hT+/mHiusdDJrOxpKZ0k12h7kcXTutJyY
	yobqgNXIz4uHEkddY86QnoBaDDXZnoc2IOolBxKc3e5Ww9eI2X7hRkgcAMPU7m1fJY5KEkHYV2W
	vsOhIbdx37BEKrKjBc6vz+D8oeguuI6KpuG/RJ8OuMRg6jh9rlw0gM6Ud+EjVurQzKxfQv2Z3Rr
	LbhYEexPqFHh6Mvom/YdyvBYLwZV0TmOYA6FEBjPTL2XPXUzczD4Ndi/Oampeu8JGvi6jkStfxV
	Cc5fAbr0v4azfLvzUw2ALQxewGo=
X-Google-Smtp-Source: AGHT+IFmVOdXXIAfnH7OC0VYGQGrZQJtsjkxwvYAqGhWrhZnCIKHENs3MU+gqzGwCeIaQSSJl6QMFA/gNMYKQ2YbWdk=
X-Received: by 2002:a05:6512:1150:b0:595:7daf:9418 with SMTP id
 2adb3069b0e04-596a3ee117dmr7310449e87.45.1764175811444; Wed, 26 Nov 2025
 08:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org> <fimuvblfy2cmn7o4wzcxjzrux5mwhvlvyxfsgeqs6ore2xg75i@ax46d3sfmdux>
In-Reply-To: <fimuvblfy2cmn7o4wzcxjzrux5mwhvlvyxfsgeqs6ore2xg75i@ax46d3sfmdux>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 26 Nov 2025 17:49:59 +0100
X-Gm-Features: AWmQ_blaGCzwiPKb7zOiqvjnxj57Tgzboa7X8YkuhYoHnlFeuOY1PuXL7i92b9Q
Message-ID: <CAMRc=Me8KUGD7Lmdr7iecXWG4JD2cS8i37P+oMxQYdSZ4zAUEA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] gpio: improve support for shared GPIOs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 5:27=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> I'm sorry if this was already reported and fixed. On Qualcomm RB5
> platform with this patchset in place I'm getting the following backtrace
> (and then a lockup):
>
> [    4.298346] gpiolib_shared: GPIO 130 owned by f100000.pinctrl is share=
d by multiple consumers
> [    4.307157] gpiolib_shared: Setting up a shared GPIO entry for speaker=
@0,3
> [    4.314604]
> [    4.316146] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    4.321600] WARNING: possible recursive locking detected
> [    4.327054] 6.18.0-rc7-next-20251125-g3f300d0674f6-dirty #3887 Not tai=
nted
> [    4.334115] --------------------------------------------
> [    4.339566] kworker/u32:3/71 is trying to acquire lock:
> [    4.344931] ffffda019ba71850 (gpio_shared_lock){+.+.}-{4:4}, at: devm_=
gpiod_shared_get+0x34/0x2e0
> [    4.354057]
> [    4.354057] but task is already holding lock:
> [    4.360041] ffffda019ba71850 (gpio_shared_lock){+.+.}-{4:4}, at: gpio_=
device_setup_shared+0x30/0x268
> [    4.369421]

Ah, I missed the use-case where the auxiliary device is bound right
after it gets added and we're still holding the shared_gpio_lock. I
think we should prepare the proxy devices but only add them after
releasing the lock. I will fix it first thing tomorrow morning.

Bartosz
