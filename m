Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F32459E1
	for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952206; cv=none; b=S80m1X5sjgWPZoUeypwWTlbNTadFqCjJsa5ehToFZTZk91OdoI7ihiE24zbdQD02RPxcvg5mluAVP9P8mPzV1SQesLmjLq29tBJrunHWIJLymcI45EIKGvnSiBFVU5NVHFUE6jxUwePI0wokLQP7WM4FTkWYw3On20hrxAh8WPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952206; c=relaxed/simple;
	bh=UeSc/5BZh1t4ldehBk5tJa7zSp0X0x4lRUAaopaKMhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6B3GjbHbwY/C5Di7J0ZIv0ZXgbY0NICYvLHujjT7T/4S4eymffKNe+CCnWxE58QCZCbWttviCuEOHt1lkjwLcuRD8cMNBI6myK/UcIGrPsxLa36ffRPEAdzzGVAMFSV+L+AqmERqvWBaO+jwCqr9zzfNZJgdN2gEMA91LsFifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KOqFom8e; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KOqFom8e"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30eef9ce7feso65485711fa.0
        for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1745952203; x=1746557003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeSc/5BZh1t4ldehBk5tJa7zSp0X0x4lRUAaopaKMhw=;
        b=KOqFom8eHb+vQj2eGFSmi+wDJmBDCm/4QWc2IQ4ZXLxzvS88gnMSAZ1y1ZdGNPUB01
         lU+Iu7OG+cl2vvDw72+gWT2wubM2pxq8LLhDlF3pcTWYRTCw6vDtXFLFTHhgy9UXiEfz
         hXY06mUnmQUQJo2Xe4LxRXuGqTtedNipVQhtqQOh7UDi+Z3e7tfZU1ntTsC4b6R/ZfSu
         vFBt1IDvGyz/0bUVzcxRvXydzkUkKKAoHzj6KFzNtOZ+X81nUYUHceINOCj9PpvZVxoN
         d+1APMhCJRsH0e2ewsa95iKPfxAYVNb6K3qo8cOPMTGI6Osa0spoEF/htfBcrcCMXF4Y
         rofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745952203; x=1746557003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeSc/5BZh1t4ldehBk5tJa7zSp0X0x4lRUAaopaKMhw=;
        b=taO6YAyxCtg1MhWkB64TTbYGhMnVK6CTj4o7ocG5ioRfBgBPHSQzwKo3veN87G6iqN
         HXBOy7LqT7Jk5vfxyiX1RmibmoUgwYD4v0hRejjVN5e14enW9COk4BBZ3QudlWXYyEup
         2gofJceykYnPhEs4BUhTHFytBZc8EeyX9JxEhhJ6TQkbzT9R3AtuHGVaFiOq36H6vd7O
         pH76FyOAqYbOsH+hkNlaRN63GR4P8TcQb5GGhRikcMZY20NwaujuMdsP75+n1ZROS/87
         fiolF3XApOotQFge8C9DIxcFgECZO3unGLALaOw/RQmn+vBhVPmVeU+9Rlgsfdj2mkd0
         oPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUkwm2saj+kMQvhnr/1M/V5fEoFibmX0LdmLQmEUYHwhVE9HF/oQe0PLWkLav8q6raj7JeRoKJRFuCH1LDG2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxWpzzfPnXCt1AEHcwiZzg0gJw4V7N/Z1X4NR9xvpPNiZYb2/D
	R9mc0gdM+y1ScJpFRHLEigOrYCHb6rHDJKZiy5TV9X6aikQ8+gUw7WcefE046YZaWS5eeF0HN67
	O/feA4DppjqKPzYYPo835B4HbKvYgdRJJ2n0RgQ==
X-Gm-Gg: ASbGncs0tx3ud0YnJULVPf8mSb888aV4jJn6HPcHela6wOCl5eXsZPBFzQRiCgJgb5j
	t23YfqrDXe4MA/I2tarfHSLRbFHUX6Vv43pWFTtE8s2nOnFr2qF1Pyy96vjySvux5hBVsCzr9UN
	uFLoGHrOuR/ZJ2C7FbVn0bvBZpcotOE+2rXX3oxjmP4J2lqbapdZVgVL8hyMee8TVH
X-Google-Smtp-Source: AGHT+IFW/CX408gyWrfHMdOwoequNQf7BFXdXPyHUXK7j2OMhS6KT7GwMmG2rSXP+wTND/kT7QfmLTIIBSLCzPUbzV0=
X-Received: by 2002:a2e:be9e:0:b0:309:23ea:5919 with SMTP id
 38308e7fff4ca-31e6b2c6f0fmr842631fa.31.1745952202951; Tue, 29 Apr 2025
 11:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-aaeon-up-board-pinctrl-support-v4-0-b3fffc11417d@bootlin.com>
In-Reply-To: <20250429-aaeon-up-board-pinctrl-support-v4-0-b3fffc11417d@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 29 Apr 2025 20:43:11 +0200
X-Gm-Features: ATxdqUHJnz3Fduuh7qnUTYN-WgL5KpZt6syl8lZWPYRMAPtml8GzwrHvYI-U59M
Message-ID: <CAMRc=MfpE6M28P6jxFgs6K6Tf84LRhmaw5U4s8WgciF815M7Bg@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 4:08=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> This is the fourth version of this series.
>
> The main change is the way the forwarder type is exported, now gpiochip_f=
wd
> is an opaque structure.
> In the forwarder, a valid_mask was added to track registered GPIO
> descriptors, and it is now possible to remove a GPIO at runtime using the=
 new
> gpio_fwd_gpio_free() helper.
>
> Two new patches were added, the first one to remove extern specifier in
> machine.h, the second one to define new helpers str_input_output() and
> str_output_input().
>
> Other minor changes address Andy's comments, see below for more details i=
n the
> changelog.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---

This looks pretty good now. Who should take it - Linus or I?

Bartosz
