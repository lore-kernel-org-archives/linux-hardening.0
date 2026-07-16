Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6042FCD7
	for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228923; cv=pass; b=iNZkYbLtEMMG13Tng7CsqHwARJhdRameHNzuvFvt/jmq3wG9tT9E8XBQiHOPF4trsy8+Q1lHT0r1ooM6Y5A7UvXgDuNXtnBzvAxmwoID4y6uAtKYvyA2vHtv0COhJGXWDSbmbpIoM5WxrfW/93czClcBDqzl2exStBAwi1n7jZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228923; c=relaxed/simple;
	bh=jLdFeRnLlFspnZwXeo9oBcZZ/8ssWumYg5r20QmYeNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sO/SwFhOK8yAv1YctbuOCds95F14FkKq/ZttwmH2ztlG8CeyPRTQE0UUV2qD772awIsMzkzcMz5FnyeC9bMCky++oLO3KKYplPm9EUG3Zw91BrDOCtjb0y+CcvhqXFvb6+MCnDHWgJefcAnfzlskJE3/af1oosCHR5qM1p/9ZuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWedmSFm; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWedmSFm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f75f7172so51581245e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 12:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784228921; cv=none;
        d=google.com; s=arc-20260327;
        b=Z0eIcHm4OWcNolv7shFkIL4z03GKmaGIB1WBMecBw9PGXtqCPMn0m7bpu1TnpTpTT+
         Y57Zto0b5ecI2ld8V6t5J8R3zs2JJFDP5ZJjZSjcMOZKgmgs5lvLiZCsPoRlmgbGGyh0
         jSzSd7EdW9hna1iWQillonPmyyk/8IcpoMgeqctxFdZy7Bs/vaPEIY2jDOBm4dMnP0my
         94FWOlT9a/cr8x9LbSvHUjmm8E0FjRgFO40uy3C4WlyMoOZaR2T06diWsvX0W2HXJP/n
         adNUbxbx+7ZCvuOAGyGFju4R0ULI7brOMc3i08l8ten6hk6nbgVomRVZ/2P6gLKa31qi
         WiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5fFbXpQ6cgL1W+wXgp57WxL1BMwiS9aV1pLY4h9zMNk=;
        fh=OPrAscx+Gh1QHCKbaTn+d1JqVP57MlcORLebyOP8YR8=;
        b=PM9uFh9su30Y3G0XrexfGhhMXiM6KBQkyGYyes4dPwGiDdGgrHKodq2xQgO/KS/RtC
         UBwI2q9CVOru3ualRc+OPejdSyRSN82c0DTiNg1n6h8ndXqQATjnqIZJ416l221DnlvV
         NabReg3pDRiwJAetJ3pOD+bzAoV9oFOIdauKCKBGPabHVidTqGbYvhuIL/cUSArvWdfl
         Bj4Hy5AOYXyMFQiuvel9/EJd9XEAFguoOxhhNfzq6Wa9Ep+JbZPY7ic12n3EldI+UQXM
         SHHmmw0cKWkw93yM6meuZDhDrYSg8OxHb/wIMZyxSGA0E1uVg/79ioStNSwE1AFDlf+/
         R36Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784228921; x=1784833721; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5fFbXpQ6cgL1W+wXgp57WxL1BMwiS9aV1pLY4h9zMNk=;
        b=YWedmSFm80jIjFcKxqJ4AC0eHC5iHFykx0HicwhLkCsVcI6/tpozRbDnF9YpbUjIWj
         qr+0nEDMhxaUpP5M7oqP0B/l5kcQgPdCavGAqqzF3WMgkibB+EmTGZmEiJ9Bm6zZRQE5
         PZSqj+SRgYfpsIvy64xC5pu5/juS4AgUVnJHTSP0R4AwAiAgOETG9a+yymSRxSmXOlZx
         hzm4Cv5d1zoSoLEHPOT9L/+41cxh6QV/rU+ZvBcpkc2xFzQw8GkhG/TIN1pKu0zWXh9K
         jEFHbmF+yufJy97+Ouzq2JOVpc413pgnhuv4vt5X9IRg52f/IXpihxqN5jxyDsxszcWR
         HA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784228921; x=1784833721;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5fFbXpQ6cgL1W+wXgp57WxL1BMwiS9aV1pLY4h9zMNk=;
        b=oX0w1IoW9Bp/l4L3Wo+eJ59iIMh65Eg2VjBnIb1VrLRgnhtWHjuTiq+C/8ro7YDhJC
         8e5qUg00MhtfjZC+AHTalZi7/uJEM9j8+HAtMGnsiqPCtGkaNWu3+r9z/bAaUZYCGGmG
         NRdhZpJmYuVdrtEWmL+apX+Q4qp/q00Y1PPfGS6LByT44Ulwzi4K8CcRWQRewKX4uU/M
         moKzkO816rN7HkSPeK8nqUrgFiredSgvm25XyaO3pZg4IHkgKhB+cnfiA+z5COfyVT8P
         Hy2DjyKj5NreYetIbpxejpyBRPf+B1YNjb85s99417YTsXcrflpep37yEE0ynChMhF8O
         8DTg==
X-Forwarded-Encrypted: i=1; AHgh+RqBQYE8SliY8sOQmrdswsTV8IqOu2IQgdUnOiE97yRxHwh18uPeDUJPRRBw6i3Z1yY7BP8y/q77PRGV4zNcndM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRsAQ6JOY1NU+qcjYXeKlhZpexFUmB82HLJl+cN4F9HSPsWMp
	JjigOOQTVGaoknWH5gHRGFSqkItL/3jCdc0vs33ECmQ/BQJkQDW0qzzLLyFwOjAJY37vsUf1oJC
	ASYtwndok3fv7YTV2XM51n9veyCpq+5E=
X-Gm-Gg: AfdE7clYLsCBft9ANl7S4qXop/vwbwdLLu2rSiXzlB4YIhOO3BnHrIq6SimykuTeSPc
	Z0Qmfgf3YPOt48ZkRvTw7TBLXiXElbWXRay7CYtISXZF7qwVAy7NzTxNlBPXbZHZDlyPOHmd85V
	54QGP/UKntF6Ki00fubFsMasht/AsM20TxvQJs92aZg8wEudQVRupaEMT92GetfI2I4p2WfRqqJ
	n5nqnIExq1b9InWX9jGFdiRm2XTiEYMMPNhIoPCq14rz4r8guZOaugdeWcuENhlSWMxL99ZX/XL
	bHTzKz82TQ+7bmDC0/3BaDN4rBfWSQK3HMJTr0kembHVpbNV/R/dGWZ9c/5XS1Stg/Cbl69I4Gp
	ibl8WZMBkH8sJjF/+IKsQMCxcOhZtTVulC8y3JXQeec25jSx1IvBbhhNnQn+hqM2QvlgycBlAxA
	3o8k4xQLbSqNxp1hU9ynC66iBb1I4bKaoKK7bTJfLOPIWH/bE/UkiiQsLHIlDBpA==
X-Received: by 2002:a05:600c:1507:b0:493:9b02:484c with SMTP id
 5b1f17b1804b1-4953c289549mr63624915e9.29.1784228920599; Thu, 16 Jul 2026
 12:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
 <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com> <alkmAcDvSXr_COc_@ashevche-desk.local>
In-Reply-To: <alkmAcDvSXr_COc_@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 16 Jul 2026 21:08:29 +0200
X-Gm-Features: AUfX_mxCntOtogOB2qZP4BBtfm04CggLYlXKnLS_glyM7cRaPGIAoMal3mZWjak
Message-ID: <CALoEA-wQwxjG860Y9u-vBkGn=Y=82UBX4bG1rvaed_A-qZu6Yg@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match data
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 at 20:42, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 01:14:18PM +0100, Rodrigo Alencar via B4 Relay wrote:
>
> > Verify that chip_info pointer is not NULL. If a user binds the driver
> > using driver_override via sysfs with a device name not present in the
> > id_table or of_match_table, match data will be NULL.
>
> ...
>
> >       struct iio_dev *indio_dev;
> >       int ret, i;
>
>
> Move an assignment here as well.
>
>         chip_info = ...
>
> > +     if (!chip_info)
> > +             return -ENODEV;
>

Enough reviewing for me today, considering I let this slip past me.

-- 
Kind regards

CJD
