Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA82B3EDAD2
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145053; cv=none; b=jPFvkXfqsTkBTcUSttcL2aGTBbIEXPEZEZMjQlg2aKB/WUWWPIki6NX1C/rh1mTpL9hPSEgP8zFEtp1wxKqz/8b7gMrIWS0ybiGrw/0lWpV7PqWA5Wzd/ZwWLsU94/VFtd7LuuTujoWH6JTcR+V4mJk5bE9I0JyVsPIqU97NM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145053; c=relaxed/simple;
	bh=Yt4WhkQ0bfNF3i+Bo8I3umUKuq7qDV0/dN0snQn+DvY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuZv6Kh7GvfQSw52WZVh24/MlATSKW/dtCsB8vyMs47zyThSd56V28Ax2CPOU63IPw0wi6gQayBT6apkH2qJIhtaR4KWAu/BoOf6tlBTP+x4SGfAIG1hk7QYiURaCtR5jaiEJt3l2Ge9qWv6eHAJaV0jAqKiFu7C16R3XkDq6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFIKNIr9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFIKNIr9"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so401247766b.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785145050; x=1785749850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uCfmC301HH+gxHVN5YqFyM0xtUcGcZEvjNT2gWZ/T7c=;
        b=NFIKNIr9gNX6hiLcxyJ1PnERyaIpcHyF4w1xYzgsAxoU+6NWOl2gkrvNE6SHH4e2hs
         cfCdye4jttAfg3z1Ak0YLi15xJf2F37g9j3/TKh5BZJx/K6O2kfnbGXTrPajnqbXfsw3
         gjY6AnR0qMSLN/YK5tFClUa9scK2AkUEh9hQzfveshvt3rohnqcB6KMr7oThXwE9X2ZU
         Aa3tP93nbjYoiako+NEUWCiLuXaNcCrj5RZkeilAoadat+tbPApcpKOqW/Qu0jA7+VlA
         qA7hYv7FGzZ7CG9x29KGEU1KU/P8qlfp0zDtKBDLTh+dyp1qkF8rFC2lKWltjAjLvU4C
         vyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785145050; x=1785749850;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCfmC301HH+gxHVN5YqFyM0xtUcGcZEvjNT2gWZ/T7c=;
        b=TaTRdHQH3TRIzc3rVF1ymmiJLaZhEBrzqhjDBzuIMicGWwRi4+fVl5cTkV5Pob0nV7
         WpnVOi2LaT+HAe6w1vHZwOgYcG7Aisbaz0F5nbpJ/lpZz1Obk1fyn9PpPiaFrXDWJcGw
         XSR9gDar6Pl7yQ8gkcGtaz6vtitDozFrmJGCjMqWXl11/dUMdJ7ed4MkVOsRrqfXEkcB
         PvG3dKd4ABho2yG8NafruSXV4Qv+NPi7EsDn+NcFyr+BtpIhVII14cAIt1iux+QgyrBA
         EEg/eXYWKyubvJ0VCqHsDhWlTBQeSVNFeRX7mJhWzMN3SLV1NdQg3NfXsV/NLDTx6Sk/
         QjUA==
X-Forwarded-Encrypted: i=1; AHgh+RoJwqKck6vuedXbZ749pJ/YBUikaFrV9RHtNT80GSWM8WU/7o5SBTYpoCtszgdUX/AhnG9970F5DK7AdAo/Pbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlISUqfn0oD7g8JNFyCipn7Yi+xDAar4r9hbaLwNgLocL+pPia
	iAuDOuYmWVF0+B0iyrONObpIKxlB95DNSX5P+MfN6qmFpxQi2ed1Bi5/VwNWBqs/
X-Gm-Gg: AR+sD12HjhwXkHKtT+0B9TrLY2kevelTh+W9EAZ29i2+HnTulgbmjmYArSFYLm9Y51x
	w81nRHg7GmMnZe4WIB8PpuMeNJ86hIxTMbyGJLx3D01G/SRJzDyBHkpBZlk09wMOjLyxotZ9kcV
	bhX2v6GpvdU2AdgS18e8nLQ19lvUouWSxcnr5NTbJ28u3JWTrICYpTgurp0WhfIC82rHYxQE8ry
	C1qQrpatRe+h9d1ElaBIT7CHx5b6ldaS3BCDjMnYPkfURhehkLQd5+73tSRrTQ5gchMbWgWSD6o
	5AyNUdBxz4vvuaa/uaXzlAulEVCX310SFmbEcIa/mKiSfiCRxut/7lFT2L+zPi7PhqLaGmJBEQ4
	FnmrkyyHFPxPn3EYFs4mhPHQwboikMDDsaylR79VFDbgt1ugQG2jIBTDCK1O501jCLb40Tl2zYp
	QfTcF65a62Dxrj4kcjgVGCU5yD9LcEvUE001GZbqlCA3n7hi9yxAKcvR7XnqJCtc/Tft5hWeAjF
	19y7Q==
X-Received: by 2002:a17:907:3cc3:b0:c16:2dc0:e1ef with SMTP id a640c23a62f3a-c1f1ebe59c1mr303138166b.14.1785145049847;
        Mon, 27 Jul 2026 02:37:29 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac8c4bsm622684366b.18.2026.07.27.02.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:37:29 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 27 Jul 2026 10:37:26 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v9 10/17] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <k5gfkzynht4d2hqaqhoqbrszah352dblvbopgaxwgwx26maeue@nv3hjwplqqv4>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
 <20260722-ad9910-iio-driver-v9-10-459d1df5ac56@analog.com>
 <20260725233354.369b3fa2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725233354.369b3fa2@jic23-huawei>

On 25/07/26 23:33, Jonathan Cameron wrote:
> On Wed, 22 Jul 2026 16:50:19 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add the core AD9910 DDS driver infrastructure with single tone mode
> > support. This includes SPI register access, profile management via GPIO
> > pins, PLL/DAC configuration from firmware properties, and single tone
> > frequency/phase/amplitude control through IIO attributes.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> ...
> 
> > diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> > new file mode 100644
> > index 000000000000..b41b011af281
> > --- /dev/null
> > +++ b/drivers/iio/frequency/ad9910.c
> 
> ...
> 
> > +static int ad9910_parse_fw(struct ad9910_state *st)
> > +{
> > +	static const char * const refclk_out_drv0[] = {
> > +		"disabled", "low", "medium", "high",
> > +	};
> > +	struct device *dev = &st->spi->dev;
> > +	const char *prop;
> > +	u32 tmp;
> > +	int ret;
> > +
> > +	st->data.pll_enabled = device_property_read_bool(dev, "adi,pll-enable");
> > +	if (st->data.pll_enabled) {
> > +		prop = "adi,charge-pump-current-microamp";
> > +		if (device_property_present(dev, prop)) {
> > +			ret = device_property_read_u32(dev, prop, &tmp);
> > +			if (ret)
> > +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> > +
> > +			if (tmp < AD9910_ICP_MIN_uA || tmp > AD9910_ICP_MAX_uA)
> > +				return dev_err_probe(dev, -ERANGE,
> > +						     "invalid charge pump current %u\n", tmp);
> > +		} else {
> > +			tmp = AD9910_ICP_MIN_uA;
> > +		}
> > +		st->data.pll_charge_pump_current = tmp;
> > +
> > +		prop = "adi,refclk-out-drive-strength";
> 
> Sashiko did have a question about this.  I didn't care enough about the particular
> combination restrictions on the clock being output, but please have a quick check.
> https://sashiko.dev/#/patchset/20260722-ad9910-iio-driver-v9-0-459d1df5ac56%40analog.com
> 
> If it is possible but nonsensical, add a comment here.

The datasheet states:

	When the PLL is enabled, a buffered clock signal is available at 
	the REFCLK_OUT pin. This clock signal is the same frequency 
	as the REF_CLK input. This is especially useful when a crystal 
	is connected because it gives the user a replica of the crystal 
	clock for driving other external devices

REFCLK_OUT is basically the input to the PLL added some gain. So that is only
applicable when PLL is enabled. By default, st->data.refclk_out_drv is zero
so it is disabled when PLL is not being used.

This DT-property (adi,refclk-out-drive-strength) is also dependent on the
adi,pll-enable property in the bindings.

> > +		if (device_property_present(dev, prop)) {
> > +			ret = device_property_match_property_string(dev, prop,
> > +								    refclk_out_drv0,
> > +								    ARRAY_SIZE(refclk_out_drv0));
> > +			if (ret < 0)
> > +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> > +
> > +			st->data.refclk_out_drv = ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}

-- 
Kind regards,

Rodrigo Alencar
