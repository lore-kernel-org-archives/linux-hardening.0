Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82429A309
	for <linux-hardening@vger.kernel.org>; Sun, 26 Apr 2026 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777207690; cv=none; b=WV9nGkJOV/QJV2AF/C6AQFqRiONDHgKmkcYZMo+gzrog7HY1Ym0Mf0Xepvvxn99mz2JIiC1ijk6+Cuiu415Dv/5C3Y/6vzAdiKTB6tm89QBK//x6+9P/u+5NqEpq6Nlh66EZoFaF8hoN/XMvcar6qddtFPIcdF2AoDtLHioPdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777207690; c=relaxed/simple;
	bh=/C1jSY0hNOX4U3GO4+9/Qy/3BO+jkxZrZ1AeBT7K+Lo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMKtPzVGWYOsktmNnghPD3uasGE0X+ewp8j3X0fx0IwuVJwNQn74G72RD11LFs48UXt7OEztnGkmQ9fFIiuUEzlLTcqj9A33TVFCPzwfVgjhMy0wjN/0g/uuv1aOnJrkuIvNYBhZN5dEGxlHNySPO9b/O7xsTW1dVu5MXvUDSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APmDflE1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APmDflE1"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so59118295e9.0
        for <linux-hardening@vger.kernel.org>; Sun, 26 Apr 2026 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777207686; x=1777812486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdSlfN5TOas9ObtsBftpjoK8qDSsbhsD2j4mnZKffjw=;
        b=APmDflE1rTbEnnkoAupdrwLRCNVThkRqEmKQd1oLLRoNZUz0N9kQl40vM/bAd7yoto
         b20y7Ir//2zXgnA1K0tuLhNuypM/QnPfDvnxyos9R5g6V2s3DNurJrsXr+5GKYZPP2A3
         PDS7ZlOlx0/rADiT7KaG94ZW045eBHxYSMGKlvWz3sC44dwuo8KWdlGA9iYEvTzOaam1
         KmyaVhSBBtkIGwibu73lNuKGfBzBBPqEEoTdYNapQhUMNcohUq6waT2diMY0nWopfqqN
         MqGZFf0JW9T1hmJAwL7iGqvSW9mXpGCD30HhLReN3Btam9EKsBDQnvYjoKRdY7NYQOr3
         7Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777207686; x=1777812486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdSlfN5TOas9ObtsBftpjoK8qDSsbhsD2j4mnZKffjw=;
        b=WKMrDBTIVR/tsCwLEfJDqjns5dXbzqtVyg5NpZi5824N6hwDTIbPsGe/VEB+qo9App
         1G9c47pmivw9a9YAfVGO41egcIyHPNvKXI+CJ/MzfD/+gVeeWJQoi1c+C9J6tbNm/OrW
         /2zhAvSonNgD09p4yCtGffIKNT61N2/dFaXRgtG29JqVhjVb85q+ePFZOr6pPM2qh1jy
         5ogSOZQPTjEuK3rTo2e+/H1jyF/4GZ9dPaxz9ft8eGe/myiSe5jpeMkYIjvGsFPiKTIW
         dGCQFEWKcsH8Ict3wY40zBOA5M6Yf+zt0q8ybClLZQ5IQNCu4MKoyjOHHb8WLTeE5zMY
         GnoA==
X-Forwarded-Encrypted: i=1; AFNElJ+iOEYeHG+pygdytAH8rcEizjh5s2Z9yrxa0mBHfjQeQpRUy/fg3KPA+9e+QFDevFpUsCDfSj1qjk7AdryGL4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NZ1TcGim9ePaCVe0BUcI4JRc8fstbgjNpX11yaNU48fA7M31
	m6bNORmMz5NHVSSNbc6YyqJD1OIOb42Af/eVTgKKHggv1q9ObWMzFiMc
X-Gm-Gg: AeBDietsdIkrFZOHOi20kBp0S4dEK6ELMEdoUDkjumWbQKllB50R7Vt841XMz1Y4Kez
	sHDCNeNyMNTsGE9foAHj0Ld0um+EYA88tn5Q7eyc1J/4GhjBp8WmxkoaT9dWIjJJ0VlmANdS2Qn
	AFi5onaYsfEAyAp2domTfLx89fgqdlUZ7qcqXR41wY2J3FSszI+KSdsfz+ZN5qqLmVczZEOcES+
	V0vkdsKn0wmKHqIbQxUavWrHZ8dHI6u5C0fNsnEPk7gbOnADfjcNc1e0sy06fuAsy9rzo9jO5gh
	BhMa+//jJZlaOK9LLxIjfubibWR4UPo/5ugsIcW+HTKS1lmh7FFYqO2gvMaxqnPwHySL+0AQA64
	SWH2wN9Aa8+qm/0/4gmTS3LKnlLunOeqMcjN6p8mOEIxSQxnCqMWMRoZF9+4yGaAoFBHSCnfm+b
	bMl06vHwllm2wRR1lR5QFaa8/S4/I/RB+6vkc0sbwiq4BOuieon1G/XY39a/iCmMXUQlFTEKO9M
	/HsUeRCIVIvKkMfrwQ2iX/gr/Vvy7bdEMsuTM8PtEipJWbdDQFVIdjvr6Kq
X-Received: by 2002:a05:600c:3546:b0:48a:5546:61a1 with SMTP id 5b1f17b1804b1-48a554663d4mr338552955e9.15.1777207686168;
        Sun, 26 Apr 2026 05:48:06 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5a579bd3sm376534015e9.6.2026.04.26.05.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 05:48:04 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 26 Apr 2026 13:48:02 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v3 1/9] dt-bindings: iio: frequency: add ad9910
Message-ID: <662bly5emi76xwhlcetznipwsa3a5ncyne6zvpffqyxp5pvczq@23udi3emw6sp>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
 <20260417-ad9910-iio-driver-v3-1-29b93712a228@analog.com>
 <20260426120139.3fb8f3da@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426120139.3fb8f3da@jic23-huawei>

On 26/04/26 12:01PM, Jonathan Cameron wrote:
> On Fri, 17 Apr 2026 09:17:30 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> > configurations for clocks, DAC current, reset and basic GPIO control.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  .../bindings/iio/frequency/adi,ad9910.yaml         | 189 +++++++++++++++++++++
> >  MAINTAINERS                                        |   7 +
> >  2 files changed, 196 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> > new file mode 100644
> > index 000000000000..61e879bca5c2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> 
> ...
> 
> > +
> > +  reset-gpios:
> > +    description:
> > +      GPIOs controlling the Main Device reset.
> > +
> > +  io-reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO controlling the I/O_RESET pin.
> > +
> > +  powerdown-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO controlling the EXT_PWR_DWN pin.
> > +
> > +  update-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO controlling the I/O_UPDATE pin.
> > +
> > +  profile-gpios:
> > +    minItems: 3
> > +    maxItems: 3
> > +    description:
> > +      GPIOs controlling the PROFILE[2:0] pins for profile selection.
> > +
> > +  sync-err-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO used to read SYNC_SMP_ERR pin status.
> Looking at the datasheet there are a few other things that might want to be here.
> 
> pll-lock for example might be wired to a gpio to allow a check that lock has
> occurred.  Maybe sync-samp-err as well though possibly that one wants to be an
> interrupt?

I can add the lock-detect gpio. sync-samp-err must be a gpio, because it must be
used by a calibration routine that modifies sync delays and reads the gpio value
to check the sync state. The goal is to find the best delay configs. More details:
https://ez.analog.com/cfs-file/__key/communityserver-discussions-components-files/318/3426.Synchronizing-Multiple-AD9910s.pdf

-- 
Kind regards,

Rodrigo Alencar
