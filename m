Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCF1EE7B9
	for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739265366; cv=none; b=AtNP5aKoKLvsGCOq03OxdWngvjyKy3tcWdC+ZJhS4R22+r5caNn+pl+Xwn1Jq/rAt3l0kOm6xM8MW/bm+p2JhhdsHfDfhgY0PKyBVgQ6L2FDSPx+mh8z8mgDaKhTOwtZcWmAK2hGR/bk5I9Ok3238D1mrM2cAP6FiXohqC4+9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739265366; c=relaxed/simple;
	bh=8UfEMiOEBOeaIBtwImceNCmamRpFFTjgv2GGzdM5I7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MK7UIs1yuXX6JfFumuvBaKLl0xS6GqZnbIUbH3prOgjhBiw9t54CdP9HkrsC8QXmnfgHGuBE7c2LNZElTNlgcAN2cJSsiU+BZZZM+CPdKmMo13qtjfBtFlfFUXlodSWikDgDPAhxOfKNcc2XvOFXNrqb6ObvyB8V5aZyG+1lVXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FDIrcK87; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDIrcK87"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54504f29000so2868529e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 01:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739265362; x=1739870162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UfEMiOEBOeaIBtwImceNCmamRpFFTjgv2GGzdM5I7s=;
        b=FDIrcK87hwYMj3ThVP/bpXvBTIwTIxc2CDQk1BsZHgA+tP1wTU0omUWu/JdUadLlpA
         E4prB+oV2f6vzyyU4eOb0rrIoj2Vp8MsO75xNE5zveAndNG0FNGkidoeuYtFBgExAnPb
         OOrP7R+ioGeslyZjvHUQ3+Ncf9dl3Wqcu1VYBZHiGWF1nPrPNqrwMDYkr6DxXqOAR2dm
         xcysla+vtHS1+M7ZKgQyTgUp67cIC1nEUSVEmM0pm54mecRjEuT1qyBPh4vJ0aLJdeMe
         DzKXCdB86OEIamIfNzv65JdBGTGyLZ6rwMEcwHDClXSmQZkLoh6HtYCDD3/lr/TQ2Yj1
         G8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739265362; x=1739870162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UfEMiOEBOeaIBtwImceNCmamRpFFTjgv2GGzdM5I7s=;
        b=utiTQQGLuNrjaZe3HmjRdn/4IMIfJkmFW35xiQ5Vm+/mBSz17RbA1W6BeAEbq2fKoy
         /1p4+W/1K4LbA2yG5EG4ROynYQEdTB7bV7V/e4UJG2phr87ZxOety+rXfWBPfgmSBlhS
         4QU3HMBEMm3rAz3pbQsJrHZPqAO8laSDLjbDiuLkVav4o5BjMdr0HyT5d7rgLRVaa8tB
         k3OSRbleCe8hD0G2VPLr0C/ztPy80quYWQKnwTkeThcCnSAPav26z5amecWxW1+evb2h
         3p/SAxaX6YE+10HyKaePJbygS7RWMVPtiwKOSjIiFwbnWgUD1onvdiYqTAdiQm9/bcfD
         EuOA==
X-Forwarded-Encrypted: i=1; AJvYcCV/ifvEW8QgDT5tEzMqbpkiHPEeJ8zCtFBcIdhW7mE0zcZouGfNCul8ONeoE/37rWUiDNJifg5tYZziT+T6C64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhewSjGPr6M5t107GPfQWsspmaqIHTEXxxDnVI3t08llpi72kV
	e1tH2TRfqUg9nWYx+fCouJrGAur5epFoOCU4T99g2fwSeDeFKZr1Bz+CZQdbzjaU+fFyKYD9tHC
	z9OVa8ArOg+yBzExzDwUo2y7BRu7X4k1ojiL53oH4e32se0dJ
X-Gm-Gg: ASbGncuPnJNutLwrvT/d4tdVyEcKu6HoPheCzkJX+w/uvmKGwq0tCMr4Nht5qFLRo/l
	PcWdzV3SE9WNhNphruT28wTeLNU44CgLWFLWB6W/dwWoOXybu9teGOV9xKgougwFcu2IRJ6rG
X-Google-Smtp-Source: AGHT+IGUDw4T7meBLRLmxvDNfzzNRFxj3H+A9DNaY0nmeEagW6HROntcqR+BTGp7fazad8t23/Foxxtov8jsByu1Lis=
X-Received: by 2002:a05:6512:118f:b0:545:a1a:556f with SMTP id
 2adb3069b0e04-545118767edmr854568e87.50.1739265362482; Tue, 11 Feb 2025
 01:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203121843.3183991-1-andriy.shevchenko@linux.intel.com> <20250203121843.3183991-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250203121843.3183991-7-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Feb 2025 10:15:51 +0100
X-Gm-Features: AWEUYZmKsMFSUUUDA-6QujaPBWCv-A0WnPWsEIS9Ys7-p_cNmYjrYPDZOgguks4
Message-ID: <CACRpkdYgfpYAGaWdoULMhFgXRj49j5Jkf9Do+wmG=NiH83nSRg@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] gpio: 74x164: Switch to use dev_err_probe()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 1:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Switch to use dev_err_probe() to simplify the error path and
> unify a message template.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
