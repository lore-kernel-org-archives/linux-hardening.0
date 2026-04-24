Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C17346ACD
	for <linux-hardening@vger.kernel.org>; Fri, 24 Apr 2026 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022452; cv=none; b=Mq+UjAnn/uV7rqzB7xrGyXfwyCgRgP7CsXovuUcfJlWoKh1aTlM265NZH3cRU8Tdme+BJ6RKOaOGimTDiJ2ixse/S6weCCH55DLmgywe7Y4hnqHTfB19BTETJcuOzINIRqwT3WlXKzOk4SdumZLmjyfBVmYK1ntbKu4yu00pAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022452; c=relaxed/simple;
	bh=3QluWGMR+jHmo+7IdSGCtayU9+fIrN4dk4r82ov60Mg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qpx3LTyzg4/FsMBrAaVIe+SiPaluyJmFLIpQ8z3dhOhf6F5TxqMWkutPVtPNvJtXgZlsAJya/wTxvxfszaDUXN3jUjR6pGjDDivuRg9KU1xcEtlR1iro71Jk6zNUptqMmzT+TRVPvpn6b4hmvEUWa1CM9szL9/jMW8bTo8ZssYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcpNHEpD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcpNHEpD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so124483005e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 24 Apr 2026 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777022450; x=1777627250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Lw13ndhj4hcVsNP3zE5oxceQrXyrN1eVPpHFMKp7r4=;
        b=WcpNHEpDL+yjUcZBCKH0Y8pegl45kvF0gJZk43Pz6FtGDWPks0QQfvEho3E/NpYNxX
         9QEqItjO8XYFyZ7PoKcg3dLSOR2MCawfFjnO64DFT5ka9ddpNHcOitYlgQfgsGgBlJUw
         KXSC3xrJ+cIHIDoIrvZ91YvVUc6bjSqU3A7pKFZhOtq10lRybQwTZtlCGmmxiu6Piyx/
         coY0H8ARp0pdOVLST3y/rnYm+XokPxAPAiq8ia8nKNbVQG/cf1ykQOyHyz05o4uANO/O
         BJNQ1YkRiLvl+WOZRA01DNfvlX+FqSk7HYf17ypwrXzkGwV66NECXozfxa9+SVizXBT2
         fYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777022450; x=1777627250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Lw13ndhj4hcVsNP3zE5oxceQrXyrN1eVPpHFMKp7r4=;
        b=qyQRC2FT/45L4OW3Pli3InVynBfV9UjPCiMtH6CtF9lKWU2R5/MyEUvO0aGmw6d9qT
         f/aNibm7XFGEEFxi9kmqGjE/4MobHEO0kk34kYym0qeu+6Bmw7hkgsjuaT8fZZzHK1/4
         YodC8ApvLvq+fYQ0qtsk9W6ilD1UC4qgef6ysfgtUofddyh2dwCMXn6d+oVnBAAokKe7
         lJVdVH6IcW8XJ7K+1bI7TChR43e6oTnO3Ls6HlNGRYXbdDJjlwlnAMXhyOXj9iz0i8N7
         M5RVSElXdYn6LB73v1hVxUOYrxAdVi0muyzcMRY8mrdQYGDnsMLtw0B/oNKvWHw+F2mf
         8hCg==
X-Forwarded-Encrypted: i=1; AFNElJ/lnxEefXyjPz8v1t2ClpGJpeOYPvyv4rvp1zn1jXCGHAAcv6Mfjdu2klV8hfLu0B4ojUh1yFKoq+BKgE4O5K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywr0X9x1LVvzY4F19DNxOdk3ZPaaQvZTy/dur96DOXXVlhZ/2P
	bHLYXiQIVY5xJ9HxEIKARWkRLmjLK7FKIkdlPW+/xVRIu21jTPfJkeST
X-Gm-Gg: AeBDiesweE5P/foyawCSxf6LnIKq2upkzBsy/tnglAOnWdl64DAZdRk7tWipidSbCT7
	yrNCa3RV65Xz9YnlfrJwp2Ip9hjvb0XdCjPlxQqSBZdnPf0nUPT2TmimmLBE/GaKImZwmmedh6a
	YJ4/D08si5rmDYzdg/t38hFYNpmRtFsvWXuZITW08G+Io3X9KrVk1tA96YZ9bPzI33/Dt2mMt0D
	T/iwdfQ4lZfXED0CTuVp/L0xl+QXQTlgzmrteLc1ezMAG5eDJ3C6YXEy3XCKUfD4zS+EqMrz70F
	FxbBaAbgp5mjRSFV7uHtn1Qf1JskYX8Im0WgMsHsM4v8PXb/0mUGpPdiPQnbMEGUZspTGItygUo
	T0URrUPzx4sjd6smMhSggW5PzP0j8khAvt8Vx5AOdT87ER9uECTd0G8hNDHmb3VxFrTueQglmlF
	V7dcyGxWHHrZjI09qwaYKdkcVwqgq+f4QpDik+u6J53+Vok3D8bF9O0h0PxvJ5/Yw8z5iVjrpB2
	OaPqQfo/CTKD7hZQe9a/KfSgbMPPhOAiFv51xSWBdn3QP0+mnNgmDBamgkckHgY9/r59dQ=
X-Received: by 2002:a05:600c:4746:b0:488:9439:881a with SMTP id 5b1f17b1804b1-488fb738412mr415441935e9.2.1777022449653;
        Fri, 24 Apr 2026 02:20:49 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm276246255e9.13.2026.04.24.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 02:20:49 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 24 Apr 2026 10:20:43 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 21/22] iio: dac: ad5686: add triggered buffer support
Message-ID: <h65ofgapkjztmi5szcmtejcwtjchiyxyp73njefrppxyalw7y3@fjz764sgxkbz>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-21-ed7dca001d1b@analog.com>
 <20260423192714.04eaa55e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423192714.04eaa55e@jic23-huawei>

On 26/04/23 07:27PM, Jonathan Cameron wrote:
> On Wed, 22 Apr 2026 15:45:55 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

...

> > +static irqreturn_t ad5686_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct ad5686_state *st = iio_priv(indio_dev);
> > +	const struct iio_chan_spec *chan;
> > +	u16 val[AD5686_MAX_CHANNELS];
> 
> I may be wrong but I suspect the static analysers won't like the
> fact that only part of this is initialised and they can't
> tell how much of it is then used. We might need some sanity checks
> to keep them happy even though we know they will always be fine
> (branch predictors should quickly make them near cost free).

will just add = { } to end, so it get initialized to zero:

	u16 val[AD5686_MAX_CHANNELS] = { };

> > +	int ret, ch, i = 0;
> > +	bool async_update;
> > +	u8 cmd;
> > +
> > +	ret = iio_pop_from_buffer(buffer, val);
> At somepoint we should probably add a sanity check on buffer size to that.

nothing to be done here then, I suppose that should be an API-level change
for iio_pop_from_buffer().

> > +	if (ret)
> > +		goto out;

-- 
Kind regards,

Rodrigo Alencar
