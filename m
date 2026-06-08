Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE03AFB13
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907294; cv=none; b=AOMq8wdSJTAXmLSxDEfkJtADiRkG+XHP6E5R+nBJBnJTGf88oxaVXrVGsCiedXvKVIiqCP2V8ChYGlInlVrEabuhFQlHuEYD+8N37BaIqI+flPywFK97hvJHb2wIyayF57YLofJ8/RWj5u4wejrRf7Xj3xY+gasqHbiT03pVjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907294; c=relaxed/simple;
	bh=1wZNWjUwc+vC0bVgQ0ZlbNdOYECuxeaY+pojCpm9HA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkoKpVyh6kjomPGURgYtfs8rPbHiukUkcp7/g1tmS8VMeYgUNxEZS+EV6zOPIVdCdzS5jTM5aI4S/yOKS4/5wwwwuPr8NjX0Vcl9bnh3IhXsPYbCm4lVtZWTT7YS1zAohWGI48704OVoza1xd2LBmB0kZ9afbA693iYJWu8SHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRxHhS86; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRxHhS86"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45efa80e0afso3096558f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780907288; x=1781512088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PPeReRpnLBnfoJVjUD6XA7EpJ91dRyU67u4RwbeYW+E=;
        b=pRxHhS86/i5lFqEWxQzb0O+X8Zyp37Hv3tGh3OHmku2+J0DMTShEIoDFPF5+g16XoX
         0/xzJY28v1rymS9yzI7KHMRk0IeziIOkWIPqVfkUye8wZJttEFW/FcI+aU86Rikvat9l
         3jA+YliBw41w8GQE7xKZ9EQjOQQbL+YYnxuJjX4jf3aPIR1WfHhJPQdJZuBSe+xnUAl+
         dtoBA37i1x1kYXtM5lfvLefrGVE01DMzYBPcoep0q9+uZ3Eny3uorpfzkgRxuco4ZTbC
         bxYoIh5Qr9/yxZVLN5ZvPQHKjtMWM/Z9Lf1PsHtLLKLv1nCCj0WS1WBtDAK3sVV2iqwl
         OY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907288; x=1781512088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPeReRpnLBnfoJVjUD6XA7EpJ91dRyU67u4RwbeYW+E=;
        b=KY/j/dbfOSHVXByFNoPb5QkjpvNUC33tzr8/yHbfJMPai+OpTfFrqtgWritQBQ6Jnf
         ufhvlkPggSXPxnRDlHMmGumFB39d3DqAZ4e3MNQpHbhvqtyHYXUV1aYSUUekF/PBI1kG
         dWfnjYwss7uZlcJq9MuTnX/8ON85yvUb0QXLKsuxzrO4m78VC2HjUmB5FCRjCOBrtyMu
         sBvQPRXibCwP680qIPcsneb5NpSnOlHjEqwZx0PjZ/eMEEs7ptrayP3r+qaIhmAPaBt/
         jr4fLb79Dn7Td2CBRN4juMq61XOt4BaJPgmK7m2YhFZnuT94WxY1OeoNrhFd986fbPCF
         jUgg==
X-Forwarded-Encrypted: i=1; AFNElJ8X7HRuhNffirpRAotI7UGAF+2UVZm7z+s6wUtMyv+HClU4IHp5W9SHSUpVv6KPdO5tpMZOdytxnEZDQtrpu3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAdZthB6AAK64fQ/aqhFu3AorvF4EPdLiAPniDAhmhe5gE0V5
	GcAlTc8fbfX7X/UmbvQ4hujbfcp9D3z+XY3klWK0ZKQx9PwuQHjk1epN
X-Gm-Gg: Acq92OF/YLay+koUBH7f9tRUPniTAOYmiGkc2GSGPlog8YsDOl0vRDRDzrL1RptKRKb
	DgNgVFhEwSf+DJj0X74EdH7+vrK8fj+S0e+V+hxkuOBWWiId9WerGepAj9NMrhQEPCnFbn5k40v
	sCb0V5A/NrqL12emcSYHALErabA3smW41AJY4if8CNR/I+p1f79oy8ojeuSEeNsUTeJB8AKoZTy
	F0RXI4sq2CeL0KCd1fSTk+w5HktsS5N4pTrwA45vkipWEoOMxbNybPFQcacGHtQZlwTeVfqVU6h
	vFppXe3HLR1HA8QExLQze2+WrjlwDneZEqOHz8q5jITyr84OH8HFiJ85ye3JvmPFFeCDBQAiw0o
	7iebL/ets8ZkiNgm0A0hbgHTsjLFaI35QlCTfQkhGxDrpxLYFDNlNTG6d0RQOlDibzKhMIrSRZy
	iI/9it9Jh2hziUUuBWFIp4TlotPw==
X-Received: by 2002:a05:6000:29d6:b0:460:3233:beeb with SMTP id ffacd0b85a97d-4603233c00bmr13957776f8f.43.1780907287945;
        Mon, 08 Jun 2026 01:28:07 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm49104616f8f.12.2026.06.08.01.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:28:07 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:29:07 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, 
	linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 06/12] iio: dac: ad5686: consume optional reset signal
Message-ID: <aiZ7mVMImugYwOVq@nsa>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-6-691e01883d27@analog.com>
 <ah_k9A9535Vz6PCw@nsa>
 <20260603130833.007c1526@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603130833.007c1526@jic23-huawei>

On Wed, Jun 03, 2026 at 01:08:33PM +0100, Jonathan Cameron wrote:
> On Wed, 3 Jun 2026 09:28:26 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Tue, Jun 02, 2026 at 05:33:53PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add RESET pin GPIO support through an optional reset control, which is
> > > local to the probe function. Also, include delays for power-up time and
> > > reset pulse width.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---
> > >  drivers/iio/dac/ad5686.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > > index 4a8c587ff116..345ca2436332 100644
> > > --- a/drivers/iio/dac/ad5686.c
> > > +++ b/drivers/iio/dac/ad5686.c
> > > @@ -8,12 +8,14 @@
> > >  #include <linux/array_size.h>
> > >  #include <linux/bitfield.h>
> > >  #include <linux/bitops.h>
> > > +#include <linux/delay.h>
> > >  #include <linux/dev_printk.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/export.h>
> > >  #include <linux/kstrtox.h>
> > >  #include <linux/module.h>
> > >  #include <linux/regulator/consumer.h>
> > > +#include <linux/reset.h>
> > >  #include <linux/sysfs.h>
> > >  #include <linux/wordpart.h>
> > >  
> > > @@ -471,6 +473,7 @@ int ad5686_probe(struct device *dev,
> > >  		 const struct ad5686_chip_info *chip_info,
> > >  		 const char *name, const struct ad5686_bus_ops *ops)
> > >  {
> > > +	struct reset_control *rstc;
> > >  	struct ad5686_state *st;
> > >  	struct iio_dev *indio_dev;
> > >  	int ret, i;
> > > @@ -506,6 +509,16 @@ int ad5686_probe(struct device *dev,
> > >  		return dev_err_probe(dev, -EINVAL,
> > >  				     "invalid or not provided vref voltage\n");
> > >  
> > > +	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
> > > +	if (IS_ERR(rstc))
> > > +		return dev_err_probe(dev, PTR_ERR(rstc),
> > > +				     "Failed to get reset control\n");  
> > 
> > On top of what Andy stated, I'm fairly sure
> > devm_reset_control_get_optional_exclusive() returns with the GPIO
> > asserted.
> 
> We've been getting reports on that not being the case from Sashiko
> and when I last looked into one of those it definitely isn't documented
> as doing so and I got the impression it is a reset controller specific
> thing.  Do we are fine here because the gpio reset controller reset_gpio_probe()
> includes:
> 	priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> 	if (IS_ERR(priv->reset))
> 		return dev_err_probe(dev, PTR_ERR(priv->reset),
> 				     "Could not get reset gpios\n");
> Which I guess puts it in to reset?
> 
> So do we assume gpio reset or not for this sort of driver that specifies
> in the binding reset-gpios. Now if the following is implying we need
> a deasserted to asserted transition (maybe?) then we'd need to force
> a deassert first.

Yeah, fair enough. I think in practice it works but we are relying in
internals of other piece of code for it to work which is not great.

- Nuno Sá

> 
> Btw I used claude to explore this and it hallucinated the reverse polarity
> providing otherwise correct code for what was in reset_gpio_probe() but
> oddly editing that one line.  I was being lazy and using the web UI rather
> than a version with access to my git tree so maybe it scraped some
> buggy code from a downstream tree.  Anyhow watch out for subtle garbage!
> It also took a few requests to get it to figure out the logical nature
> of the GPIO signals rather than assuming they were controlling whether
> the line was high or low directly.
> 
> Jonathan
> 
> 
> > 
> > > +
> > > +	udelay(5); /* power-up time */
> > > +	reset_control_assert(rstc);
> > > +	udelay(1); /* reset pulse: comfortably bigger than the spec */
> > > +	reset_control_deassert(rstc);
> > > +
> > >  	/* Initialize masks to all ones */
> > >  	st->pwr_down_mask = ~0;
> > >  	st->pwr_down_mode = ~0;
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > >   
> 
