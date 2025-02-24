Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1F2571B8
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402152; cv=none; b=heZTYyI3KOiBEK6SzgVQLjkbOIepmC8dxIpOVdGZB+9bMbTcM9M3pV20abTI/rqKFaz/z7MS6leIUFr1xTGt0zaGJgoAGVViknscokrxiqnmwRHcfsVSI2fwWzkm7iI7wyHWCvgWVXWWPUpTxy2NgE6bVBw41L2rONu4jCwZcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402152; c=relaxed/simple;
	bh=3GoOSlh4aghrEUhFA8T2QcZ172IFZvBUU3F8aELhD30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdgQ91pn1eJQ63qBYHcvOjw6InSKv2DhJxwu3UA98DR1H4DkoFpLc7URUn1zl8p1jONDMEuO1Pud/t8pViHD9eLBEZdf1bYVrXDGAN7t4iFZEdgb7XyfHGUd5ne2OKbZgUZFdCxBOzlTLO10vIT/R3NUkmVNyrPPPdTLn5s9LmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MhVjr1jV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhVjr1jV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a823036so41823985e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 05:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740402149; x=1741006949; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6JKe2d60+WlSAD6t2/IsKdHC5kmJu+MWZz25xMIMoOk=;
        b=MhVjr1jVv1jgJBZFuB+Wgh0V5NznAfoH69NS3CTzj8QqgNqaCU5fmub6Wzw+iY//kT
         y8eWlcXsoYCVBBcunWSlu8hfhLkfldIDOjmYZN9gPcgDqE6oP8cvtarensgtaJcdz+Z7
         XfZlwDmcxWXwbSbbuwcarou0oA4WQcsPKo1GfSTbzeiMqz84QUn8HfVMNJG6PUCMKHv9
         XQNssN8iiBD0hxAMIbL79qKJJ1Avq5oproDqcXfaZbbDNAJne05MiKw4XnTSWKyNaRBM
         3h5qOesN/KiyzslTK5frekpvBRCgaBfN9qwTfIpPwZdvk+2q80KFGgvgWY289sy/5/Nb
         F4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402149; x=1741006949;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JKe2d60+WlSAD6t2/IsKdHC5kmJu+MWZz25xMIMoOk=;
        b=ss8pO3EyAfyej3cdCzOdCVMqYfhx8gB0ydf/g9JMaCMYeN5Pm8gH6/gMYh4Uoynn1b
         r1Vu62rC2kBKWBJcm7xzZYG1iwgWTV5dGP2h66Jd1U+kn21DsJE3bvp4WxGoRLBEBkTP
         luxatKwMqeH2KCyvdR6ImL0CIphN/+/3y9iIXQzLJQ/VHhiGYW1kikVP/VrFg6kaa+Dj
         XD7hAV7e3SaZRM9LiSTy5G+UmHg6sYJ0qmM14lqZGIdhLbvN4DKA1PmyBdNhDQDPCQ3a
         Jhujk+8GiFh7BsCJc/YqnXoDJgVtO4NxxdD1QEx0yEsJ6u+j6PGkN6in7cFtXFkUiING
         wjzg==
X-Forwarded-Encrypted: i=1; AJvYcCUYFdnDFu/3AAUGWDNLB/PpdyOGRmiQd8G99bCkqxMfRBb2g36tZqJqq8p2c0BeJ3+HtfQw2VevTQhY6sM8ftE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhItrirktArXXRFWBI5Jc0X0f6iP+hch+cw146REbaHhxxvht
	PpQYxdxK9bTobDbFbOuOh/Wj81HjT/JGL3AQh4MlzJVDXHPpCx7fxINsgek8eQk=
X-Gm-Gg: ASbGncs1LRAK9F+uogIVemCD+PjkvbArrcah0FLk3Id+hSXtiWUyub6xxAgogIuNgKT
	W2wQu2kDFU8rDaetn601jYOv65My4+Za8zXOOWqqAkHAW9HVG50Jc3g0fkD0HnhDYZ4uVnFLUuu
	2fZModrG5BPnqAirfXwK3xQff1+2F3/yWpbv4pJhcBfAN1A0TCJ0zBvSK+9VRX8ukSDA7e7HEf9
	7uqUvmlOdVVmeGkxy5GyNOLDhG+ehUc7m7GgN3W5LfeeuiIVb9zDGISwZhXcybl0L0ZZEELFeYd
	7NIINguuXiSPM7HIuv8NYcUHiMbBMw==
X-Google-Smtp-Source: AGHT+IHIvx/Mzi0ATkCEL7v8mqxYPxS778o/u734+8lN1qwnKFPkNnFzPQqlUpq/kfgg00sUP03rEg==
X-Received: by 2002:a05:600c:358c:b0:439:84ba:5760 with SMTP id 5b1f17b1804b1-439aeae1c8bmr110053185e9.5.1740402145511;
        Mon, 24 Feb 2025 05:02:25 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02e6cf4sm104593555e9.19.2025.02.24.05.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:02:25 -0800 (PST)
Message-ID: <923badeacb9e52b78d276382ae8c06a47c44fbae.camel@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: add max77759 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	devicetree@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>, linux-gpio@vger.kernel.org,
 linux-hardening@vger.kernel.org,  "Gustavo A. R. Silva"	
 <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, 	linux-kernel@vger.kernel.org
Date: Mon, 24 Feb 2025 13:02:23 +0000
In-Reply-To: <174040128694.2418814.685647591949303616.robh@kernel.org>
References: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
	 <20250224-max77759-mfd-v1-1-2bff36f9d055@linaro.org>
	 <174040128694.2418814.685647591949303616.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 06:48 -0600, Rob Herring (Arm) wrote:
>=20
> On Mon, 24 Feb 2025 10:28:49 +0000, Andr=C3=A9 Draszik wrote:
> > Add device tree binding for the Maxim MAX77759 companion PMIC for USB
> > Type-C applications.
> >=20
> > The MAX77759 includes Battery Charger, Fuel Gauge, temperature sensors,
> > USB Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
> >=20
> > This describes the core mfd device.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0.../devicetree/bindings/mfd/maxim,max77759.yaml=C2=A0=C2=A0=C2=A0=
 | 104 +++++++++++++++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 ++
> > =C2=A02 files changed, 110 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/maxim,max77759.example.dtb: pmic@66: gpio: False schema
> does not allow {'compatible': ['maxim,max77759-gpio'], 'gpio-controller':=
 True, '#gpio-cells': 2, 'interrupt-controller': True,
> '#interrupt-cells': 2}
> 	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77759.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/maxim,max77759.example.dtb: pmic@66: pmic-nvmem: False
> schema does not allow {'compatible': ['maxim,max77759-nvmem'], 'nvmem-lay=
out': {'compatible': ['fixed-layout'], '#address-cells': 1,
> '#size-cells': 1, 'reboot-mode@0': {'reg': [[0, 4]]}, 'boot-reason@4': {'=
reg': [[4, 4]]}, 'shutdown-user-flag@8': {'reg': [[8, 1]]},
> 'rsoc@10': {'reg': [[10, 2]]}}}
> 	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77759.yaml#
> Documentation/devicetree/bindings/mfd/maxim,max77759.example.dtb: /exampl=
e-0/i2c/pmic@66/gpio: failed to match any schema with
> compatible: ['maxim,max77759-gpio']
> Documentation/devicetree/bindings/mfd/maxim,max77759.example.dtb: /exampl=
e-0/i2c/pmic@66/pmic-nvmem: failed to match any schema with
> compatible: ['maxim,max77759-nvmem']

The top-level example in here references the two (MFD cell)
bindings added in the two follow-up patches for gpio and
nvmem. When all three binding patches exist in the tree,
the errors are gone.

Is this acceptable, or shall I add the top-level example only
after the bindings?



Thanks,
Andre'

