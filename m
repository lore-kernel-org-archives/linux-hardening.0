Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C335E95E
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jul 2026 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271102; cv=none; b=htqlr33/8gwZL1ko1O+2D6rdRzAishhhZqIqQFuNC1P/Ld7aj1XPbIj7Lev6TiccZWIj/avDhfwsgdYUqdzP8hhhOokUEqyu/gfyPwkNbUQoTULMUR5Xc9FOBCVIllA76nlx9f65KYBOhrnAYhPqhJOlbr7qhVesDvD/53AxUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271102; c=relaxed/simple;
	bh=lcV4Pb2mh+fAEOpbU3PIl3OXS7WicGJvoP7zaEWxSq8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aglZ7ZlfH9bQ236wzsf1Bjih/kXfL9EO2CNPVBhFwrz9A5Bmq8KrPTfN97KLfVu3q61vQoo6OU+Ku52eUjYptyaTqCYvBf8IYhGXTMm30wVWl2F/k9EIQVNnudwMIDODHtFzkAdqoj0SSl9STMn0S82dEtK6d4m7wDuCRlHGjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcaLHxgy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcaLHxgy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so3162161f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 23:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784271099; x=1784875899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9UY5ZnEeTRAKjye0Gd13pSYVq2II1CClrTvBqjd8pp4=;
        b=XcaLHxgyidntXUvzNa1qRyxKEE4O0AG8smjjjp+uh2vrhFVwGt9uFYDNAesjiQjwNy
         WpVS+waPgleDiTb5umUv4zr8E/uQK+n4XiwcJtPMf2+MNjTm1/ZXxZEXCHj4xHPPW1Em
         cvDcwF4E677cAilZ8zd9mWbe6TOjryl/SkyDAR6X4GFwHHuT5WKFYtAXWfRtAo6E6SzN
         XcaOh5vixp/Q/i/qNil5JhK6Rhi6k7hyEpt66O1AyU8fWWUrYWDjZnR4qc/MLpvoRhdh
         nLXq63ofwvfPFo3e6fMEbtRZmfWDLOzShi0wF+YngyJDUO7pzbvde8Pim/W+GF7jn1P1
         mKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271099; x=1784875899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UY5ZnEeTRAKjye0Gd13pSYVq2II1CClrTvBqjd8pp4=;
        b=F4UVsMHBwRmkLiAfPuV9A8nUbPIUUKw70PEhwf5dbNMUiETkDOkNFhFE05XfRffKBO
         /TxYdCQ48LxfTEKpcEB+uid4MnYtLLIIiSMQrU7+70Sg+X7WCR1WmI+wDrIKZubNHyCn
         f98FT+pE5EDhSsxuUtTSmA/Gc/l1rTR0sRBSHzWZLzYtfTwup9qhMZc2bUWxgf3ozVmC
         1YP3n7t8HxyGwiJt3BeL1UZH4VnKw5knwMiDgYKAx5grMxG7n4y4cEEjFliZ6Gibjk8E
         W/YKVJNC5Ykf+Zor2qYDVMBTDFzXjtVtkab7Cf3LyjcKG8xIUpz6KmtoaNXr5hIE0lUL
         0bng==
X-Forwarded-Encrypted: i=1; AHgh+RpmAwyM84sfHyjGFX3OFZvo2fe6F2HzgOFjiueAFFPHHVvJnixB5RvOHqECfDePMFCSOAduIXiWPmfVCTpFn1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTOYf6te3vnlcexwxeBw66uzf9+4Um4e7zbyx0mOx+EYgMX9h3
	psnCnOCU7HckfkmyUASelNzQoHt+mWjL++8xf4uoRUSWv1JuDYgGu4hImaK0LMZI
X-Gm-Gg: AfdE7clD8VcBuIaX2VVOiFCaJJrgv1kJ9ImZoQM17Fk0hySYd00KbZhXc2F0Z/mLf70
	1vV73QgmmZijeU85v9do510L7wAWBwjN55vaHxKjYkHyiMHcoAKTvUhenZnww49SGBiOCXzO7sR
	t/08Lkq3J1y2ypiWUVcXG4SYjXvvieu9C4ihO6Qoe1X2cerax/u15zX1/eWYAn5+CXY8mOBNhpa
	gy31N5i9KrYrjBT4lmlATtXhR/NKbUA9jIP1RDV96BGeo3tdHaMgl06APd2h/1Cwm/JYBz3LA48
	Z35QKDQZRReeB44jzDF18b4IInvVHDkfNQ/peRWfab6Z0u9DDniw3LTzp3pJQByLEHgQ4M8I67G
	rDF8lfjjXWnlc4jniGqWB2fLj6p3rEIQoWw9xCCMZqs/jMn2EmZvEzm1PM7Qq7AH/+5OI3my+dm
	kc51OgAx4qMWAQYBh1cJpYOf1RvOFGAm/c6atagVhgy3dn1LVvG3X6u1yyG3JgancK56Bxb2ozZ
	0YT5g==
X-Received: by 2002:a05:6000:4b14:b0:47e:aa3f:f822 with SMTP id ffacd0b85a97d-47f6233be35mr1797439f8f.53.1784271098535;
        Thu, 16 Jul 2026 23:51:38 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49acesm1136427f8f.6.2026.07.16.23.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:51:37 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Fri, 17 Jul 2026 07:51:35 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match data
Message-ID: <ondynh4kmchzugk2l24klamrcaje3qxnhgiks7gnc46wwwvo35@hysk2zaimb2e>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
 <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
 <alkmAcDvSXr_COc_@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alkmAcDvSXr_COc_@ashevche-desk.local>

On 16/07/26 21:42, Andy Shevchenko wrote:
> On Thu, Jul 16, 2026 at 01:14:18PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Verify that chip_info pointer is not NULL. If a user binds the driver
> > using driver_override via sysfs with a device name not present in the
> > id_table or of_match_table, match data will be NULL.
> 
> ...
> 
> >  	struct iio_dev *indio_dev;
> >  	int ret, i;
> 
> 
> Move an assignment here as well.
> 
> 	chip_info = ...

assignment? this is an input param validation

> 
> > +	if (!chip_info)
> > +		return -ENODEV;

-- 
Kind regards,

Rodrigo Alencar
