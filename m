Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F0257423
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489050; cv=none; b=U275CMj6lDw2ONguL19dK2TONROZwhvu+MFVORT3ab4efsIM6FHMiuHhKOxKpYSlmBFg09mXU1qTLHnDu3Tzwt0ssv0fVjnI/G5WoJNEUD5Wt9wgBif8GpMWjTM3mpKO62/zO4oSyfBMar0E46FpuZ6XpVHH17F7TLIyHuoEv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489050; c=relaxed/simple;
	bh=DAw4JxnUtGkEQZ+K5aXpb9DlfRjujHomzxjuX2PxS0Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UItymPVjin3R8IU8WfAwul9XKOK16zW6JhHsJoC8qiqrnIwHBFut2vC3DsupVAvp+ugopRlDj+VXx0of4k8y4rDL+rmRC1QKzrQxMe5ff/Y1PfPwGknzX99LwRw8cL25JP2XTczTZt90MhPT8jfBMjmMul+jYLsQBdExQH76VLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N22U0sio; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N22U0sio"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-beb1bee8c16so85052266b.0
        for <linux-hardening@vger.kernel.org>; Wed, 03 Jun 2026 05:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489048; x=1781093848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqHxoYQzLKR/tGoWFgMeS9pXy4BlkN8McTt2BqpaK9U=;
        b=N22U0sioPS90X6oMviNw6Rvq+i6r658Md4yi2s09qkdDNir8emH7yBVMXQKCFPHefO
         PmLC1SRP63/Ra7yglSf/LwmMVgslqlWEJhlSLtWzhIEv3Yo3a2eaqTBtBnlrvKTGB9aP
         4zExIGAoxexzrgPNTIajBWxgAlICvgRQjfkgborUDYgMIu6RrLCOxiVONWbom4kle9k/
         Zdnug/MLCwOsu70dQLJ+p2bu73qAAB5L3sUpWVn0Okqgng+AJh3VBywTWjDbeaa0Vh98
         Yymp/NywvS2yoGB421Qkw1zHi3rWTvT+mDh1BY4NMGWhwTSdeevrtwR2pHIn80ndhKFH
         wKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489048; x=1781093848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqHxoYQzLKR/tGoWFgMeS9pXy4BlkN8McTt2BqpaK9U=;
        b=bwFtc2YFnol4wkPHSArF540PoSZ2d1vfjvX5qxgz9uZBPxPulvhelE/GnHyez0Dr/L
         /gg3U8DlItVcjwCcTlvcfwvCzIwT6jiawutX85Fbw1oRYdnf3zHafJW33nL6lX6GEfAx
         0Pv6gyhknIritaep8Lg5g/u3Fr5Y2kuRWxGXQr6bVnuuchlnoNXjDI5CVwOlhxrwCQHC
         nPmIj3UVJmVeInkcofN+fcyV4dBTKpA+TljYBktuNBEmikya5HWD1NKx8giKTE4fXuIP
         SQhFWtfCAuA9PxkztmjJiAcz4GSHJia7Wh6KDxchy364m6oPKha8d7GEaz0AcKgVaCoD
         pzyg==
X-Forwarded-Encrypted: i=1; AFNElJ9kPcNwTSwnGNEXvY6SkUM8IlICA3jHHcALuEcR2B82/8+GsASDYon3Y2da84TrQ0jDST+I2zK8UNsU0UWcMI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcSyjLxaDI+B4l7gfAz+xeAcS8sZE2jHICodvSx/H+0svGsOxX
	QHcJDPwBdEuVLLlcjFiWBmwI5ovsXmBFCgRr/zcGW7F3XHa7f9UEksXJ
X-Gm-Gg: Acq92OHJLRGONqsumYVaHgBEYBxX82AvkQsbs2eHz1gyzic09mWjB3hJtcJz8QPb5mz
	xXGcGegqhGJ1Aur4nDKEGFw6H07OVT8ssdIq8GvX0hwzF2GFPgt90fGOcpOTQuHExX3CJVbXlWS
	QXXU1rA+xV7mCVWprUokXILOcpxpS66cED9K5+ZvZOn3d0qyyY9v6ydm7iAhhlt88+pcfibpGLC
	AKPYboCtrV8od/lk31pvS4lq6FxvHJOLxpJoMUAoboCrtXP9sV+qy+5hvfX5Z+KBXVXg6O2Oxts
	klKMrOrOd9mNluskmgWNYlc+QBEtpedVnOa2tAZ5fTp8gejUyYKhe46SBk73VOOEhMV0FZIrQRw
	mvP0Zd2HhqMHV0molS1aZRk8EYAgegsFOXIH0FW9ZNHgTHYFBRCbjDmA4LlRomUp1YAbQjzmKTF
	CUjSXorLAYBSMfE6TtQrT6yC+tSSyfTC2UmXxe6M+2eNFrQOfO1NCuA0QgGp67etMc425MBadqx
	cT5C3MyQmIQym0KdjwhpsQZ3la1EEdeyOsqRSB1YRWLqNONOQ==
X-Received: by 2002:a17:906:6a13:b0:bc1:d3d2:9348 with SMTP id a640c23a62f3a-bf09ea6587emr146364666b.20.1780489047981;
        Wed, 03 Jun 2026 05:17:27 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055500875sm139987966b.53.2026.06.03.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:17:27 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 3 Jun 2026 13:17:25 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 05/12] iio: dac: ad5686: add support for missing power
 supplies
Message-ID: <p3ydzrkizeysxlzc355xzgeboipihgo45w34uwn7a4lb63jgek@kr5r5hgjh354>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-5-691e01883d27@analog.com>
 <ah8oz29R8mem6H5X@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8oz29R8mem6H5X@ashevche-desk.local>

On 26/06/02 10:02PM, Andy Shevchenko wrote:
> On Tue, Jun 02, 2026 at 05:33:52PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > 
> > Get and enable regulators for vdd, vlogic and vref input power pins. Vdd
> > is the input power supply, while vlogic powers the digital side. vref is
> > replacing vcc, which is being deprecated, but still supported. The value
> > of vref_mv is checked so that a device without internal voltage reference
> > cannot proceed without an explicit supply. For correct operation, vdd and
> > vlogic are required, then devm_regulator_get_enable() is used so the
> > driver can still work without them by using the stub/dummy regulators.
> > Error report uses dev_err_probe(), which helps debugging an init issue.
> 
> ...
> 
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> > +	if (ret == -ENODEV) /* vcc-supply is deprecated, but supported still */
> > +		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> 
> >  	if (ret < 0 && ret != -ENODEV)
> 
> It can be deduplicated now with
> 
> 	else if (ret < 0)

Not really, because ret is overwritten with

	ret = devm_regulator_get_enable_read_voltage(dev, "vcc")

so the check for if (ret < 0 && ret != -ENODEV) is intentional
 
> > -		return ret;
> > +		return dev_err_probe(dev, ret, "failed to read vref voltage\n");

-- 
Kind regards,

Rodrigo Alencar
