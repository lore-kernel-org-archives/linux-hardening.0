Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEC2DEA61
	for <linux-hardening@vger.kernel.org>; Fri, 24 Oct 2025 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290454; cv=none; b=dw0RnJU84kPJmQUCkBUtKrYBILCwi/6ZdNrWsUBZNO/H0nxYVKEaeUySSjoToVku5Dzv7Ade2GkwOsT26OSmDWAXT+vaJowNCRUk5UHluLL90CrwxiyYdQrvNu4CLc8eZIIwOl7XMpQLn42nBSazQKAgbDz96gHoPoolLQbFvMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290454; c=relaxed/simple;
	bh=CR+8roHK+/LDuQ73yW6ockKv+8Mv8IDa0Xrtz7eQhq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYoUVZbMW7Rs0kxCTQjlaw5ZeAFDg25toNjGIoY+BkQ7UYTjbCA0bUdYbZM48fQ4gx3wcinqFeRaeIiAD46Ld1TRxyEOjoIe1SCx14STw0lJX3q0ZwriPqNlYxXQhqtwm/HTEzXFm+EGCdEgrhx+ysctPaRnaggcGATNAV14I0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=do0n/H+0; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="do0n/H+0"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-592fb80c2faso787391e87.2
        for <linux-hardening@vger.kernel.org>; Fri, 24 Oct 2025 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761290451; x=1761895251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR+8roHK+/LDuQ73yW6ockKv+8Mv8IDa0Xrtz7eQhq0=;
        b=do0n/H+0YBdSMkTq7sBSXWn2/iExuSH4K0sIPxL9iTSfguBIyMA23Lt0sQVhm0PSy0
         0xOcYCLnv24GEMyEVQXR6ARjMO7Mu8VwfZzGGYTd2CkQ7DgrYJBnTyT8tXGIFBZcd+2z
         /7Aupadl9J7Add8zraBmNJfaTmayqpTtIQYwASfQ+2z9NaRvc8O2BOMxiTcgGNNatDjn
         aTy/UOiUjqg1hTXOt2qLk0r2MeMWkvJxIiPlV9sv20AD3ZIonIu05vFTjISc4bFpTg6o
         fjK97f4HJYjgLkswp9aaoSnhY2zJs1fHeFRj/b/czuWD1FFNJTn+X9mHV6UEvyS/RjPm
         4qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761290451; x=1761895251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR+8roHK+/LDuQ73yW6ockKv+8Mv8IDa0Xrtz7eQhq0=;
        b=YI6KS7nM6g+g03shytIa+zGAGqRinaw1kYdkp3lbtQhR4Aov9n3YSyBFl4jEd+pOaM
         2AfEXAIXq4XThFdMfJIaScLU/Rh8ORzhRFPIeU8wrLSYKyVXwOWSIOgupqH8Q6+viHaF
         FrD8zvD+33CrLIL+GkFnrCtCpdxYUbUVnckcmv0JradRC+gxsENahpEyi52Pp+VAXdv0
         toLbIZlq4NBtKQ9gKILtVm9wnaQe4BtbW//c/GRTAYHe7O1oqD3RaHXduuGyTXnp7HAq
         UyB3me65m3eY+7Yl79vrwtXHFUDCVUPMLendFuS5A7XAMHR+JKFr78b9+V61ypaYu5Pm
         u4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXV1huh/lwvyb2zp4OwTFksPwJE/kSofpFvOTeQ8tAcNOyKXoNUSHVMwNu4osXteodpkO+eORajFi0luGh3S4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8xRCWOWRd9+rfEE/3q2qKxDCiEcorwd5hdeDVBTMl1naUq3X
	pMXPPRa3MhIzUkoPLLKTH3mv9Zod78bAfY2hfeJm8hQelWlopN9zYRL2/Zb4X2gkmZdwI4+FiBX
	jFglo5sLwtLtDtaoqq2riwO+X2kivfrrA/bDr88cm9w==
X-Gm-Gg: ASbGncsTpr0Q4gUkLbSpnfh+jz50ZrWU4KzpYvMPqpy6pAOgO3FGdtCVyxtGtzal4xD
	STPPCfSXALKRmw89qToZxV8kWCE4xaZGWlKOQ1E3upwrD93QLrbvLjL510tfBVY1dKPBO/nVFmw
	MduAgjDu7qkHV8APm/39u+nlGQXdVn/UzwE+k8UpoZ+ZJklecZt1jphg767xnK64WWmMA45QKwA
	XkXZETOQWNVix33BsIZtpnjIcT3aUw8f+AXO9xxbHmWtgdcBD+4xBKwvLCxb6xhKGZ8+a82Zwzx
	Y7YV6gKsTWIMM6ERVwIXSGDxlA==
X-Google-Smtp-Source: AGHT+IH0zdKNAnAn0HY8zeCAL8aa1oecPklr3WTZJPyPQRrZZ9JAeaLToU97/5gWoSWPOCpiqMgKR7gX6TBItcaDYYE=
X-Received: by 2002:a05:6512:220e:b0:592:f5f9:f5a9 with SMTP id
 2adb3069b0e04-592f5f9f709mr1849794e87.36.1761290451029; Fri, 24 Oct 2025
 00:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org> <db05003c-8ac5-49da-b0ce-e0b668f49caf@linux.intel.com>
In-Reply-To: <db05003c-8ac5-49da-b0ce-e0b668f49caf@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Oct 2025 09:20:39 +0200
X-Gm-Features: AS18NWBFHHtshqZfLTmGnpCECipG6SuC-vURJ7Hpik3InZgpuKVx4aYTO-AzQUA
Message-ID: <CAMRc=MdWjyTyJh5zfE5qncO8ABn7QSuV1CUZXa+cSMjWoXUrNA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] gpio: improve support for shared GPIOs
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:17=E2=80=AFAM P=C3=A9ter Ujfalusi
<peter.ujfalusi@linux.intel.com> wrote:
>
>
>
> On 22/10/2025 16:10, Bartosz Golaszewski wrote:
> > Problem statement: GPIOs are implemented as a strictly exclusive
> > resource in the kernel but there are lots of platforms on which single
> > pin is shared by multiple devices which don't communicate so need some
> > way of properly sharing access to a GPIO. What we have now is the
> > GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which was introduced as a hack and
> > doesn't do any locking or arbitration of access - it literally just han=
d
> > the same GPIO descriptor to all interested users.
>
> I had few stabs on this in the past, all got somehow derailed, one
> example was:
> https://lkml.org/lkml/2019/10/30/311
>

The main issue I see with this approach is adding an actual device
node for the shared GPIO which is now not accepted in DT bindings. We
only create nodes for actual HW components. All the information is
already in the device-tree, we just need to scan it which is what I'm
trying to do here.

Bartosz
