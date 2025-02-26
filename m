Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8622CBCC
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592609; cv=none; b=UODB/J/oTUucf0MWJ6KZcFZVtiO9OB9BctmsQorCAwLaJUqFrNRvR5QI/XtazQQ3eIvjtLo4jXGMH16QHNsbFQi0/TMO/gpWTywBXDmUIZg/cmgtEDPvfGoLcCCELIyaCX/52WxW3VoYt4hlRqsu8aVimD2M7+26vQdcw6rzZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592609; c=relaxed/simple;
	bh=U8EjsXn8hthZd5WnCdsOmkpAAV6+VKIGUBqWIRaY+iI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1bRw3osNrbIUaJAQC9vC8BgIPLsA4etVOhSjOWYJeWzyYs+6rAz78rzxPIZWzkqOcQuOyc2wE/pEe0hEzvjFDCTbcKGwTv4dlPbb5/2lSj3KO6FC8dKwt7h2G+vt+CpPBEloZgyt37Xp6b/S/dK6mlJBHyGPAndShqwaAXgObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QlH9EHuA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlH9EHuA"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390df0138beso10084f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740592606; x=1741197406; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQ1ie5P4f3zQ3Bmnzk4jBndSv2upreQmxRiSWOb230I=;
        b=QlH9EHuAuRerdMHTmbjR5b8xrxGgRglOzbY/6+i41QNkpwbb/RRITEgnpl3vOymKVu
         DhCn3Bsd5mdsHGuWbkibasoIah8vs5Q561WoDUVd2WCFH+ofCtLyYCU6JAZy/cKdmvsY
         tG2oXY0OEqety8VFf76JwAAUA6azcRqN6+F4J4u2R3EHFV538GOUo0CM0iDJTEA2eMvz
         d2BtMd4eaZ9ii6qm96E5WpGJsWBQd6FlEpcyZsKkkpFxNgHqYfBNAkDS7TR3jt0aISUI
         ev6qJMCKIzaeO0jNDx3ZLuWnkdEnuQBkim6nZYBxssGlNlRwswBHz5EsQvhVNoYaMZ9K
         3iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592606; x=1741197406;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQ1ie5P4f3zQ3Bmnzk4jBndSv2upreQmxRiSWOb230I=;
        b=I1TyDt7Cyewx1sTCCyeBY4AybqLKLLmTR2hqoEyv0iXCWlsZpPB+2tugq9Dk8FlhDg
         sXTV6f6MzDEK/Hs48gSVOkkysUkNpGbaTTYDcvNsjY0ZyWAIhrM1NVOqEXb7MUmtmTAv
         IvyciZz+U33uyJQtSFZC3LEd6QRZzogld0MAiIqsh/sF6Ym5Pm29ZJAyk3qOZ2HOLZw/
         ykycX8Ngm1AYZFFKXNQR5/r34Xsml89hlpPHwfYZV2or76FBQBzjLot/kuo0J+FG+5SM
         ssZNGllNgfdfjKBUnlBkIgHKA30fogkGdDTIffIBe7IikUNOWp0gEN3JpmQ7aoggy3uw
         BsNw==
X-Forwarded-Encrypted: i=1; AJvYcCWd+BZC2p0XAqC8mtU+02vzygHOsahocR1jX2YeFZjecfep6FSeK4cndpRzhi/49RpHgyBcHSB0w0mQ/rgP6OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWX4ZpaBgypbwjkT7Ts6dFARhLWPLrC73frr3U1zs9RBkjPX4z
	dCL6xaZmycWG7are8pJGOpzaSKlV199GGk8TxPL6wnivE8R+luvJB7OuuIQ3Qms=
X-Gm-Gg: ASbGncu6TU7Dke0X+Hu9dIGDIOVFB3yfMXLlw46QQvz1BrAixhqHxbneUsx9FP06tcv
	PwxSmxiKcqk51PdnXhsqxMZj/Wgw5XEL6twAbUaM67t0usPlsgzgkchVLMaItlVnlcGk7waBWPW
	rH5vSqv/7JDQTl1QzZ4LbqxlmSgfXnb/nsREYOFQ/v5jT5h8QXzuHdFfrFNjQi6y7XnbUWqBSpM
	9BwW9NpmmkD8jAoi2b149lJctyy5R3e7l1hfz/g/o8HKERDdrI/fxBBNoHrKDNtrV1J+7vVWWnc
	eb7HbOk7pMK0nuNmriVsR9GRDlcywQ==
X-Google-Smtp-Source: AGHT+IEBNkLMPMj9+puIgcT6KXydMqr4dpitTxkeEa4qusNjXwjam9ho838YGBqllbydfQzyijAD/g==
X-Received: by 2002:a5d:64e5:0:b0:38d:e3fd:1990 with SMTP id ffacd0b85a97d-38f6e4b223bmr20340023f8f.0.1740592605805;
        Wed, 26 Feb 2025 09:56:45 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5442c0sm28868475e9.32.2025.02.26.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:56:45 -0800 (PST)
Message-ID: <5cce915b5a22cff1d538059d79c152b83c99a265.camel@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: add max77759 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski	 <brgl@bgdev.pl>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hardening@vger.kernel.org
Date: Wed, 26 Feb 2025 17:56:44 +0000
In-Reply-To: <865e878e79a4e5c3a7619bedd81cc8bdb00a4914.camel@linaro.org>
References: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
		 <20250224-max77759-mfd-v1-1-2bff36f9d055@linaro.org>
		 <20250224153716.GA3137990-robh@kernel.org>
	 <865e878e79a4e5c3a7619bedd81cc8bdb00a4914.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 16:05 +0000, Andr=C3=A9 Draszik wrote:
> Hi Rob,
>=20
> Thanks for the review!
>=20
> On Mon, 2025-02-24 at 09:37 -0600, Rob Herring wrote:
> > On Mon, Feb 24, 2025 at 10:28:49AM +0000, Andr=C3=A9 Draszik wrote:
> > > Add device tree binding for the Maxim MAX77759 companion PMIC for USB
> > > Type-C applications.
> > >=20
> > > The MAX77759 includes Battery Charger, Fuel Gauge, temperature sensor=
s,
> > > USB Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
> > >=20
> > > This describes the core mfd device.
> > >=20
> > > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > > ---
> > > =C2=A0.../devicetree/bindings/mfd/maxim,max77759.yaml=C2=A0=C2=A0=C2=
=A0 | 104 +++++++++++++++++++++
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 ++
> > > =C2=A02 files changed, 110 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yam=
l
> > > b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
> > > new file mode 100644
> > > index 000000000000..1efb841289fb
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
> > > @@ -0,0 +1,104 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/maxim,max77759.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Maxim Integrated MAX77759 PMIC for USB Type-C applications
> > > +
> > > +maintainers:
> > > +=C2=A0 - Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > > +
> > > +description: |
> > > +=C2=A0 This is a part of device tree bindings for the MAX77759 compa=
nion Power
> > > +=C2=A0 Management IC for USB Type-C applications.
> > > +
> > > +=C2=A0 The MAX77759 includes Battery Charger, Fuel Gauge, temperatur=
e sensors, USB
> > > +=C2=A0 Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
> > > +
> > > +properties:
> > > +=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0 const: maxim,max77759
> > > +
> > > +=C2=A0 interrupts:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 interrupt-controller: true
> > > +
> > > +=C2=A0 "#interrupt-cells":
> > > +=C2=A0=C2=A0=C2=A0 const: 2
> > > +
> > > +=C2=A0 gpio-controller: true
> > > +
> > > +=C2=A0 "#gpio-cells":
> > > +=C2=A0=C2=A0=C2=A0 const: 2
> > > +
> > > +=C2=A0 gpio:
> > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/gpio/maxim,max77759-gpio.yaml
> > > +
> > > +=C2=A0 reg:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 pmic-nvmem:
> >=20
> > Just 'nvmem'
>=20
> TBH, I'd prefer that as well, and I had just 'nvmem' initially,
> but that doesn't work:
>=20
> .../maxim,max77759.example.dtb: pmic@66: nvmem: {'compatible': ['maxim,ma=
x77759-nvmem'], 'nvmem-layout': {'compatible': ['fixed-
> layout'], '#address-cells': 1, '#size-cells': 1, 'reboot-mode@0': {'reg':=
 [[0, 4]]}, 'boot-reason@4': {'reg': [[4, 4]]},
> 'shutdown-user-flag@8': {'reg': [[8, 1]]}, 'rsoc@10': {'reg': [[10, 2]]}}=
} is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/nvmem/nvmem-consumer.yaml=
#
>=20
> I don't know if this can be made to work, i.e. can you have both
> in yaml? Can a type be declared as a oneOf or something like that?

I wasn't able to get this to work with a node name of just
'nvmem'.

If anybody has any suggestions, I'll gladly try them.

I've renamed the node from pmic-nvmem to nvmem-0 in v2, though.

https://lore.kernel.org/all/20250226-max77759-mfd-v2-3-a65ebe2bc0a9@linaro.=
org/

Cheers,
Andre

