Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1C37C901
	for <linux-hardening@vger.kernel.org>; Fri, 24 Apr 2026 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018122; cv=none; b=BmXLZQiTU4CKAaP0MYcGzV+ZpVXAA1GnX0Jl5JhKEnrzAr9Jm98169jZNALrgavNQzC024Ntk+++CirWg+nwMCWWvsm7g4evjZi9YQo8+1oBCPlAT39azy/Rs09eTWsrOOUWpQ8sWVJXUn2eEOos0JKIK1rPYWjk7mrjUCIqGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018122; c=relaxed/simple;
	bh=7FiijmYu3Dj8mlC564v1KV2nBi9KBlwe5DUSdSCtYYc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXTBDCr6txp60FLltz5+w2iVqF6mtq21H6brb5kkDRMnuHIU0DzmprhLRhT5yIL7JoPiVu2BcAzQaldu4AdCXXMcAvnzRc3fJcZIsAiDQtcKvN2NGHuSQ2xaaTdQmNeZBo+T2ZUNyjp9cbFLyLSdNEG2dijKnMDqXFTon3Bl7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJ38r0Kx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ38r0Kx"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso50532565e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 24 Apr 2026 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018118; x=1777622918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyquCGe5ofz0hi3dMWSPP6IFFimcOu7be/w7dUl/RaE=;
        b=UJ38r0Kx7SEdEShhcakqmlL9+v5z+oG5vq50iW1JlKxQQXQQ4RpUPhjJKUv0s+K4US
         hsI+zIl98wSflLz1EoWNlwD+iifrIqlv6Pf0kvQZ0goZhNRc8Ftl2J48NGTUdsruwbm6
         KPV4sRYa4fKdsWcBHV5DlsV9L53DIwmIetEEPAj60L172ljUVIt6GJueakiJQSlCM09u
         soVBbHll8XNBhzOZT9czd2BwCTVFNJ8CLm4uR7uFM0K7HSvuym4jW6mXg9EQxpV4dj+g
         3+lgCaHN1ZgUnKO93Ydjwewy7sOYY8y99YliOOxtxkGhUJ51PBBWsCrxkVD/MAaozOfi
         xsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018118; x=1777622918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyquCGe5ofz0hi3dMWSPP6IFFimcOu7be/w7dUl/RaE=;
        b=fY8Xvq3HZt4GzfSehnCsxFETJRnIIILl8rwIxKbyj6soKXIJaCuZwLlejl0YxbXYPl
         BPor9c7qBxvkOMRfR14LOWGNwR4z8zL+JMwwkOADaJK0HwcLa8F4hwy4EDe5fxQbwe2n
         vNEm+qUU7iAB23yicy4fCDB9+pEjLdquuwMfFaXv6zZUNF6aE5mihv2WTKPTvDBsgc5K
         HfTU/BKPGkWRrvD00toJePnUDXeuSgTUtF4oUsCrlSQQUYGrP85cz9Rl0rsaHTjfGG3X
         8AsWj8h4QuGzY7fD0TnU1Jm9plQ+fEubu22zwcvPMnfoBnbKIRPhXJgJPxa0WYVOi4eV
         ZskA==
X-Forwarded-Encrypted: i=1; AFNElJ8MI4kv3nHWZTEa5l9cShVTDrMEL0WrOiVBFs0BB+vn3H0fEyBi8cVi4uCRq/J2H2oOMqn+tQinWO1DqFiRavI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNGG4qXLO8kN5UVTfxnqVDGjtrz+Ahxi/30EkIn0TYNTdtP+O
	BbWFNvvgDGKN2l7bmS5tA4lBAjo+LLB0KeNkkKwghPFg/m3SNSRfW0J/
X-Gm-Gg: AeBDieuIeNr3x5BT8dzfe4MUPJZAFp3sE56O3fvc/kzcJU7lpfjgaB6u2c2GGF7iYb2
	YP9pl9rfGGQd5I/dasAzRp+xqfiqiqnGisMUuLG1QKXa8r5FNI/q36C2ePe3BS7SRfUqvMGoCz4
	da+0sGWzxotRXUxCRd4ua8yJg4HFLtPj2ZIlH9AOBZq6qOQTaeLMQzequ7dHRguvlbQVI51vBVo
	1Eoea38v0o6RAu+7I2iUBSL02StmExQ1TlraKKtvf58tzRMKlDY8taJRTpfHxuFMCKTLBcMAWyZ
	0v14XRDAwl7IjJjw56x1gab+aP+0Eq8Kz8jhw1L8n32w5oCz+nOWDZj0i6mnaHrqdM2Q9ZlwOWC
	6uJBGRWpx6fWbOjJmJ5oEIa7gAWlX9cGLKaV0Mv94QepqPc0n6lDtE/sMJGhmoSXIyev9GUqscj
	pnFEZMU8qZ4sKZh5vsd7F4P/6P2ImeMEnNoIwLlODsPcFHUhsseN7/MxMI/nGKU7U/g3sgxSI/Z
	Yev4lDe+3mfAfitrv+2ClBJy+2l0sN5lgRJ+tcMEN/oWvnksE+oegSl8LHtdA==
X-Received: by 2002:a05:600c:3006:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-488fb739f86mr239225625e9.2.1777018118104;
        Fri, 24 Apr 2026 01:08:38 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm521542255e9.8.2026.04.24.01.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:08:37 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 24 Apr 2026 09:08:30 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 14/22] iio: dac: ad5686: add support for missing power
 supplies
Message-ID: <mr2roj56empkjsfmeptr4iemblzca4myxohcieobk7bx5ikpy4@5a2j52x7x7lo>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-14-ed7dca001d1b@analog.com>
 <20260423190524.12ef4acb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423190524.12ef4acb@jic23-huawei>

On 26/04/23 07:05PM, Jonathan Cameron wrote:
> On Wed, 22 Apr 2026 15:45:48 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Get optional regulators for vdd, vlogic and vref input power pins. vdd is
> > the input power supply, while vlogic powers the digital side. vref is
> > replacing vcc, which is being deprecated, but still supported. The value
> > of vref_mv is checked so that a device without internal voltage reference
> > cannot proceed without an explicit supply. Error report uses
> > dev_err_probe(), which helps debugging an init issue.

...

> > -	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> > +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> > +	if (ret && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
> vdd is very rarely optional.  Can we not rely on the stub regulator
> that will be provided if there isn't one in DT?

Corret, vdd should not be optional, but I havent made it required in the dt-binding
doc. Should I be concerned on breaking existing dts in the driver implementation?

> > +
> > +	ret = devm_regulator_get_enable_optional(dev, "vlogic");
> Also doesn't sound very optional.

The same way, that is not required in the dt-binding doc. Also, there are different
packaging for the same device, on which vlogic is internally connected to vdd and only
vdd is exposed. Some board designs may also do the same externally.

> > +	if (ret && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "failed to enable vlogic supply\n");
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> > +	if (ret == -ENODEV) /* vcc-supply is deprecated, but supported still */
> > +		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> >  	if (ret < 0 && ret != -ENODEV)
> > -		return ret;
> > +		return dev_err_probe(dev, ret, "failed to read vref voltage\n");
> >  

-- 
Kind regards,

Rodrigo Alencar
