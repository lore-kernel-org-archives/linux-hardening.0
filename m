Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B73074A1
	for <linux-hardening@vger.kernel.org>; Fri, 24 Apr 2026 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017783; cv=none; b=pNlpDdTkuEi4SgP48Mtase9j3ia9yAD0akkUJ6vSDUDVahzfVZEQnyVMsJ3GLBxCk+72JTNmy3Dkx01ZrDYWHxSpWCeD1v8aY8GYI6jHMZpOvY+8B0S1g22M9v2GkVs93qFCv+1JR7LaIyClVQC2d3cJXD/tbvUD28dF+cAE69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017783; c=relaxed/simple;
	bh=Hj1tOHvncsJQ+78/m2uGWzzPNp6G6CHf+6pvVXpzTcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjy2na3d9wscMYAPyazhDhoSuljCN1FRoGpxy+IyP9722boa/zezQR9t13/1Yi4FT3nDZLTsnKAOmSqCI+3jz9hxxS/lOkJ6mviN+fZrNUyPeAwcR12/SwFvz2N9ho5VSh+3fZvQ612dW0ILp5UiSn4Bqpq2UZwDKmigQXiYG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjIpbkR7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjIpbkR7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so69367795e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 24 Apr 2026 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777017779; x=1777622579; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Itef6o5U+8hhDJZnzY0W0DUQufh1131w2DOWcXoqxCE=;
        b=NjIpbkR7tt9BS/Uj3eRrp2RnlbW6toliQsFDAOaFhI1Hu9CjpROKHavE1MnzsSavXo
         3bILRojtAHSNpnvdxBgTarU1383dF2CgDJ9qNG3VRti+zSzGac97/lUC6FMVm8Y45iOg
         lnrnaNHZ2//R3+tSnDogDDqIeOFtX9LF6KVELfwux1fa+wZ2MMhx2/Ip8jZnG9TgqJvh
         5dAuD9Az8N9WUFv4/f3dcLr9n0nTM8tsABBd3pUU8OYXeP7wwS4uZ38xnmVvdqKaot9V
         5B/J/Tl+S1J22ZdxNprUOhSpw3UgK8M4x6qCZJwLqEgsBKrBYc+M/oe4+stt1OQ8zx22
         jREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777017779; x=1777622579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Itef6o5U+8hhDJZnzY0W0DUQufh1131w2DOWcXoqxCE=;
        b=GdRRXuy/MOj70V4BSNaBcwN79BM9iEbhjm22Xr55gFbkK2n/ledrHjWUTpd52DB+Jg
         GgNZrjGtc/xKuY7dXGwi+gHNEMOmqLAEcelEIIM9gxoycvVgfw2bh/sRVHqhWN06P3lM
         P35zEnQPCwhAzVjXr0YVbPn0BbBoj9o66qHNp6XCSCtY00X9siuH2Ds2wRzi5i5tO2q7
         UA8HcEWfbOb62KVTQzouWrsu/fdHBzavvLlr6OmxbKLaH40Xo5JPgiCWlJ39hb7Wmh+3
         9f4vS/RgH39GeKGx3uyDOB1N5Uie5TK/N/QK5aubi75NGJ5nNYM5VCB3lOFxTysPta8V
         +kQA==
X-Forwarded-Encrypted: i=1; AFNElJ/asHgvr8sYXtWbVXykqfoCxkI7SPsjgYc+nvBI/VBCRwB1V7Q+JF9PpSpuJ68RsIrpPo9+143ZH09W38KOwNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8zem0LZkgLq5MU5zzlG8MIFtcNuI6Fzb2MQfIZfR1M2ij1sy9
	m2z9vwmPEzkbMsqlfNtLSbKet2LX3f5Pl/lh1gNKdKh9P8rwy+qobXGe
X-Gm-Gg: AeBDietaoTug4oeC2BYl5W+By0M33nX1QwCStkjhc4RCBGxffN92zSlP8mqsWZove2g
	QKmJzf9W+nFahAWsdXgRDmKDA/dh8dcNnSGqbJT9rrsYZrctqQrCQsviZFS9I0OD5Z6clc7ED4w
	C0nY3E/KOyK+k/sp354Eb+MFtEiAuZfBDEJQlx8LvjqQ1W+aXOrnZuiIzuq/pHhWrwpVfpWDofK
	WveAp14WKJ/NRNap41Eq4a/MNdLseQodnvdRnqUA7mf5WPuKHfnH+5ck2BR+Uwc14mnuWRp0EWV
	fEYn5uS8mNs1kARDIrZsD1CN8P2rBjI74zMF94pTPpf5Ogq6+of+GB69GjAT9L9Spj4setJcC0a
	vOEiK5G4ilATT5vMXf6/3GvwdzhZArstsvpkIT3qajngimFaVej50t351USuiTM1dZQZ0bOYGuf
	/J0xvI8ermAuhbhR526OkTgsc=
X-Received: by 2002:a05:600c:3110:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-488fb739cf6mr445107995e9.6.1777017779044;
        Fri, 24 Apr 2026 01:02:59 -0700 (PDT)
Received: from nsa ([185.128.9.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm62272531f8f.30.2026.04.24.01.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:02:58 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:03:49 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, 
	rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Auchter <michael.auchter@ni.com>, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 13/22] iio: dac: ad5686: fix input raw value check
Message-ID: <aesjWjs1i6rd1HaB@nsa>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-13-ed7dca001d1b@analog.com>
 <20260423190302.338ecdbe@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423190302.338ecdbe@jic23-huawei>

On Thu, Apr 23, 2026 at 07:03:02PM +0100, Jonathan Cameron wrote:
> On Wed, 22 Apr 2026 15:45:47 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Use in_range() to fix range check for input raw value, which is off by
> > one, i.e., for a 10-bit DAC the max valid value is 1023, but 1 << 10
> > equals 1024, which passes the previous check, allowing an out-of-range
> > write.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  drivers/iio/dac/ad5686.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > index 19d791c655b7..07a944311f0e 100644
> > --- a/drivers/iio/dac/ad5686.c
> > +++ b/drivers/iio/dac/ad5686.c
> > @@ -185,7 +185,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> > -		if (val > (1 << chan->scan_type.realbits) || val < 0)
> > +		if (!in_range(val, 0, 1 << chan->scan_type.realbits))
> 
> Might just be me, but I do find in range a bit weird when the offset is 0.
> 
> I'd be tempted to just make the check >=

FWIW, I also don't love the fact that we need to define the range instead
of pure min/max. But in this case, given that "min" is 0 it actually
works without extra defines :)

Having said the above, no preferences on my side.

- Nuno Sá
>  
> >  			return -EINVAL;
> >  
> >  		mutex_lock(&st->lock);
> > 
> 
