Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D2447A0DD
	for <linux-hardening@vger.kernel.org>; Wed, 13 May 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684974; cv=none; b=H6GD5Dt9yP2pkdVQHGV6MNPmpFSXiNZwhZv1qbLmbv7AFazTMQJaWvEhUq17rruPgZCdU8cPAg+MSeuyqalzS8ZxlNYnhybmHkz5yrU0ermFXNvdOuI8R+LP3MNDSnuyN7Je1LyNvjOJeYBj+up04HQFFCwOc9q9MhxnJHYsfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684974; c=relaxed/simple;
	bh=6xl1OZ39wivS4tq4DwCHKYc6atV3f69XK8Y07bvYulk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B60ZS1eQvr0IwUyxLp6avFp7GBQMLkIkcxWLKJJXcYLR5UXxudOp85XvdnfoGbv2kZvUEjwJ9QXIL2/cHsgYRrGBqUe7Y4HSmMPIuKPJ95XMsa+hfxRThZnBeqvJOgFRX4KAodZ6FyLBQ2JB+JWYOwX4sHGoHg5KdmpmbdBdUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKTY2ck6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKTY2ck6"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45297094718so5542139f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 13 May 2026 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778684971; x=1779289771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90qdZzTNiTsSE1LEeRcQYoXszr3HSv7vr/Z4t6wMOgk=;
        b=UKTY2ck6pXR6CIazO9ViC2GBc8u7VlKlZELwDr4XBON+z8O34h4T8RJfuyqqLJkTcE
         5TGtLNllxjZcgjeg/Pn1/z9l42mWqCjd0iTYJHtkhn6k0QY/TyRvxWlWrBdk8ZgSfDnl
         Yc5B8aBaQpyRTi1LThoiuOZu47gkgQCrjvNKplqx4M2jFq9wq1H2TcuE9xbejlXqqaRm
         IIgOSuPdVj1pew/ap8JQ4lM+cVgxfBpDJL/Cn4XpgGkyv13ZLgBN8Y3eYVz/0mlfs6jV
         Mqv0VXQ1ydsNh6N/NY7QPNojx8WVA1So4nzcZfvk0juT5oVcnJu5JFnHVtRFuRytQwcU
         hPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778684971; x=1779289771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90qdZzTNiTsSE1LEeRcQYoXszr3HSv7vr/Z4t6wMOgk=;
        b=UgafSVv+h57Zi1EAl/kYSPjIeqRuDjIb5CWX4whz1uw9pFNW2ZCaHKCaPQ8Khs9gfH
         HK64BT5W937th4lyPTIuzDnIjvEJwA6OQIPJOVssmrbXqzuscBlNRUoopCFFB7GKfOrr
         i0Cd5pk5DImTJ1+HL+q9L/iEk4DhEkMQczi1Z9n0o3QOH0nqgDVXzTJBwuttZ+vGeFJs
         yyVwL6lSnrvRX0efGxND+6cCvHwW117qYFdZjWIWaOf07hopX19VYLOtAx/W0lCdvN/e
         rdEDtG4yVfOdPuVZRv0FW8qK2r4x1wjP1TX5ABhVFLAje1EaPdz/1URO6axp+Z5sF8O3
         rIVg==
X-Forwarded-Encrypted: i=1; AFNElJ+KBFLNtDUgWfeWiagxA5fAY5mYqkmqJFI46CM7rmhTETBr0jcxxvaWsdi6xx1A5NXqnJilq/6qrzNK+gj6R3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuIa8W+jRw3fUtpWKiWA1732wDT30c6zHh3ZHKP2KV1TKimGVw
	jPcYxn7jJSUZZcwvNMkBfbltHmbO29eRumwC51p5CMDipKTrNSSM0Dor
X-Gm-Gg: Acq92OFDmM19cQtiqlnc5RWMGO4L0BMPMpfQ0oDON/lcL8Mhfz8ikzfM3D6ZO/0lV4B
	XPvXcC6Omr9phVaZPGs/3azANIplAwbzIIXPzZUzDtVF0xpFhEcKlU73gjjB4WTtTYXA7UqBNq4
	OsvSvhmFwLnf8aiK6s9ai9JuohJ7sphKQ3fer/GCBMexlgcojZkSgjHQZnU0eKwJc1IDuFJBUw5
	APG9mEojwg8R2SGww9kcnFWJxRdobAgdBqmWz3gHaVi/P+i7nVHpvFEc71mzrmK6fYiz1wis/98
	+A0rOHZdUXWPnVG1nO/ucwA5waVy4dc/dPBtkRroFuqoMbmizsX5zGRmv1CaIcHvjQZzOYc6cl8
	qCKJcYrOGK63JxvTZQzVE4KvhOzrOaDEe4lWijNfyCID70FV4it1sB5Qx9EqYOen9jZlJV0pfmB
	ROO+v0BLCo4hNqnyk6ChUhC/+VcwBEeqmjEPI6ghOQJCkG2zvrP1IODnZUJzP1DNJ1nHWTWMpLy
	ZdEnJAQT3ze1Upcbryzh0xori6sAdp2mIWI44grc/6YWRo6WPykrNKK0gs/
X-Received: by 2002:adf:e30c:0:b0:45d:4688:2571 with SMTP id ffacd0b85a97d-45d468825c6mr1533975f8f.41.1778684971053;
        Wed, 13 May 2026 08:09:31 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bb87bsm39821178f8f.2.2026.05.13.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:09:30 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 13 May 2026 16:09:24 +0100
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
Subject: Re: [PATCH RFC v4 01/10] dt-bindings: iio: frequency: add ad9910
Message-ID: <vklczsi4vk3sqf53zifslhp5pysdmj3gfyhvdgrwo4bg3wdkxj@lnbftaf5jcbf>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-1-d26bfd20ee3d@analog.com>
 <20260512193129.777d62a8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512193129.777d62a8@jic23-huawei>

On 26/05/12 07:31PM, Jonathan Cameron wrote:
> On Fri, 08 May 2026 18:00:17 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> > configurations for clocks, DAC current, reset and basic GPIO control.
> 
> I think this is getting close enough now that for next version you should
> drop the RFC (which is probably gating DT binding folk giving it
> a detailed review!)
> 
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> > +
> > +  adi,dac-output-current-microamp:
> > +    minimum: 8640
> > +    maximum: 31590
> > +    default: 20070
> > +    description:
> > +      DAC full-scale output current in microamps.
> > +
> Can we use generic dac.yaml defined output-range-microamp? The base will be 0 always but
> that shouldn't matter.
>

would that be fine even if we do not have those child channel nodes in the device-tree node? 

-- 
Kind regards,

Rodrigo Alencar
