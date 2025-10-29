Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8503054D8
	for <linux-hardening@vger.kernel.org>; Wed, 29 Oct 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741688; cv=none; b=da0n5M/o7X8FtJXULDPrCOeRSqbEowzzlRWBnMkwq58aYKp3eg3efUc3eA9NZwDcQAeNaOrbr9avAwKQctwnyD55lVJ9ckW6oQLTN3Q/B1a34d92GOYdPRxj+cpotRvXxaqUKq3+5Giq2HLHTWEtsoKbzG0ldi2cKXHwnLla9q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741688; c=relaxed/simple;
	bh=4GfXeQTTcxSpcQZ8VLho/amPI/XMfZn1ZR5wbT6W4Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdZggZFPbw7ZNIhbmB6IuK2A7kmTxoCd2zTStna2uc1NJ/3GunG0CfRX4i0WsFKJYywdRGltK1SPdM8fKFSoHUA6iUne3mPq4z8j2RleUzHOG37W9SyEzbjcOD9xUeCiG8rZ0LMuHrSwGZXI70kjZAJ7Z+gYP90BqajLH7e/uOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hyjqqwMK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hyjqqwMK"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-592f600acb3so3973099e87.2
        for <linux-hardening@vger.kernel.org>; Wed, 29 Oct 2025 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761741684; x=1762346484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GfXeQTTcxSpcQZ8VLho/amPI/XMfZn1ZR5wbT6W4Qw=;
        b=hyjqqwMKlVbrsrlesNjru6EvotES6SrhMga7FgYCG0XewJxKvoiDPxx2ycrLRo3Lqe
         IW40iMZQYr0LfAf6nSu/98u2A1l1wfVszqz7PPr1Z3SmTtUoBpSnRXdGf3L8Trs8SzPD
         vSqunM7aZBP6O0ZpRLA36J4FFq+lBhpESQ8xn4Phlbf/BjTrcsYvHHRjczJAuzdWVTT0
         xSMl4FkByJ2JulSrmfkn07inXE4sk5ineQaXOonfrrO/3dkTSmjfUTcG5xEWCCdY30RK
         DJEm2NqnOzr8JM2CVjlNuf8s0E1aPlCyxoHfRPqXH+JJjhF6DdrwcpoC3rzKbnA9pIeU
         wenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741684; x=1762346484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GfXeQTTcxSpcQZ8VLho/amPI/XMfZn1ZR5wbT6W4Qw=;
        b=F1Bj34eIxV2v6uZr+putGSb4hlWeA17nq/mnSptGcYRmoK1o/aag53SE/a4gqbJNl1
         UYlw75CW93PInqrHxR2z2c1Z2PGl9MuveK/KmaFki2uEBAjOIYWYG77VwQfuRGdxIlyR
         CE2K48eseR93NFECWUK+meNi5q6vFT8vPHb+SIbXYNxxGf5X4PUhmMgnxkBB1mcRkw6+
         N/UHuUBvEpO8x+klWSrCVzUF3E4M2X5720d4whlEdGIjruIdHoBN6tFXMkkhuCAghCYI
         0/OtQ0pyNveMzpQj0UNqJqTEdIhHinzDQpxrYzIIY6YCAIvSKEm2Taowwe15vADnwdOM
         H7tw==
X-Forwarded-Encrypted: i=1; AJvYcCW24iUQEDOAmi/jA3FW3z/EqjTHPxkcEPOJpLzyO+JsPA81bmJDCIdzDspStsoFh5LqWRqEOjQ/YhgiQVhGnho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgg5jM9jGWBQxm+eA5CQdmvlSO39BURkf83okQi2al8EGFY+dO
	ZADCi4OeHWJKSVbGofG7z0aUBKFKcSqoX1QnDV7L67YOQuy0ta+CLQbJIy2MQ51iuBII9lPKcc/
	qN6Jy+WNO0+5+b95LLkzKruzlntLAEMDhMVW0LuHLufUFLnwCXpcjHK4=
X-Gm-Gg: ASbGncv+jwKKDzFxo9l+wBL8llzCLyp/bhKiD4FVdKn5b7q9dzrvKayWYTRVMiCLRU1
	Se1Wl1xRH98w08BVU53rVSsGfPolYyt9jNtI3fDcK5WRt6tqQ93tPKBTVQiqhlrkVDvqxYpPCQT
	sN3LWD9Y5jaiepVh9h5WsnwL8nVgfZJylq1gkAa/yMLF9Hc5sUvMCKnxCaWpzQvIa+gopGQOmjC
	5A3rSjWUY5V+hXidWZo5anxOls0GI9KCJMu8owLo3rEcpwDkmdTptCvJsjOAWX8tZkzceHWR7pf
	hKJzxDn/VLe2fh4c
X-Google-Smtp-Source: AGHT+IHlRZvbfo/SYNZZ4o30tnBaAGKMcvTAo3NYRcGh1EJ9OHd3AuMhXHkwK8JOue6As+3lLZ2qXnJTw5y6BaOTrIQ=
X-Received: by 2002:a05:6512:3d05:b0:580:dda2:5318 with SMTP id
 2adb3069b0e04-59412a36b93mr989969e87.8.1761741684202; Wed, 29 Oct 2025
 05:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
 <20251029-gpio-shared-v3-10-71c568acf47c@linaro.org> <aQIAXO1hUrw4Yp9V@smile.fi.intel.com>
In-Reply-To: <aQIAXO1hUrw4Yp9V@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:41:10 +0100
X-Gm-Features: AWmQ_blYolUjn6HNVFswcXKBY7oowKsMMcCgguiaK5B1Up7lgJHjEAFObXA-S34
Message-ID: <CAMRc=McT+HinKvajHmBYPcQKoboapAf2E3ErJSP=2jXW9B0omA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] regulator: make the subsystem aware of shared GPIOs
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 29, 2025 at 12:20:46PM +0100, Bartosz Golaszewski wrote:
> >
> > GPIOLIB is now aware of shared GPIOs and - for platforms where access t=
o
> > such pins is managed internally - we don't need to keep track of the
> > enable count.
> >
> > Once all users in the kernel switch to using the new mechanism, we'll b=
e
> > able to drop the internal counting of users from the regulator code.
>
> I am wondering if you took into account the layering violation (or others
> put it as "transferring of ownership") in the regulator core for the plat=
form
> based GPIO regulators? This popped up during the discussion of
> https://lore.kernel.org/platform-driver-x86/20251024050537.92440-1-qiuwen=
bo@gnome.org/
>

I am aware of this weird ownership transfer in regulator but these
changes don't affect it. The layering is still being violated though.

This should be fixed and I've looked into it but it's not trivial so
it's another big rework for the future.

Bart
