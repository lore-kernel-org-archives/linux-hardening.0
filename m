Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8791DDC18
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433933; cv=none; b=K++7bNVHM0k4qRWsa/MePOMu5aKyCfUNpyod6Q/XZYSYW5Drb94sSnDWVqMSTtjxy6SCM18UFc/Y8yM6Uwof0adt6MdRUlwjUc21wG2xYaY9WrFV8wW4k8I7Dddd4+9VfyzK14Nesq/Jqd0gvxf1G4fOQzzXjvSIIq4MIDm9rv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433933; c=relaxed/simple;
	bh=7vTZ4bcifDx0uBbn/YdD+tR5nT8QjS33t2BFPkAir4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BghHmY9RmFpSdF6FGfe0gzVnAYVXbWC0e+OVklg9nZ4n5AYXFef9jrEioF6RBjzipAgI4Xoj80OOZv3NbEJhamqWk9fVyUPbihj8GZBHhkhJoHAgU9ZaZatqqFmH/8rX5yPGuHsQHNfJfK8UL0ln9kGyLhzXGreOtLjqM/1TIV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RTijXo78; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTijXo78"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43690d4605dso30551105e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 13:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740433928; x=1741038728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7vTZ4bcifDx0uBbn/YdD+tR5nT8QjS33t2BFPkAir4g=;
        b=RTijXo78K7Nkv6aS8jriXBFtU45mxiRA841f06CFVKYew5ga2WuR8XL/6K05nsw/l3
         cwmsN4Q42fRCWBz3Oaut7qoUBOqG26O4crrzPnUsmDRwCq6DjZkAHHEPFtajNhYps3i9
         J9DkOwGW7zJnp53siwqPF8N5IQt+4HKvR/9iPUP2roG0b7kTJKbwMXO3WlPhXFOZAMSZ
         nss9LCsXb7EZrLZ+Xny7d7HoV/31YXZdlLTrClPiMz4J7ex7sisPprFSwld0qE1SZUwA
         j2m67KCrtTtHsAGg4ARX62FlqO72YI50tHJhPgzf+R9sHLMll3ufUy7MHmj39cUKvqet
         2a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433928; x=1741038728;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vTZ4bcifDx0uBbn/YdD+tR5nT8QjS33t2BFPkAir4g=;
        b=kdqV3Z93XclBdImKnb/cotZsYXL+Zyc/wOuC1mgRnXvN4IOfnJJZR7uuIo5CgsDOTn
         ISx5mgg9gB7stzQz8Sj7i5NG4xjA1FN36ctQCbk1oRf6UlaGeIxZ39m4mxSC/7N45/NQ
         dubztq9fSuDma2Cyv7LvlpwIpVWDcynTHesKMjtGbPAea3AdG8Ksf05Ce7MdqnThGJh/
         DVxQiqIekSPKz/zQExrGl6w5LEoVQLjwNGexfjsmuKw2fZp1bxRZ51DQkcYd9OE000gc
         5lIgM7zoXH9ls+nF/eCstuFEvpuP2T9zpCGvYWfck7gpedQ10AqGLhIA45sENZSxXTa1
         6Kaw==
X-Forwarded-Encrypted: i=1; AJvYcCX7w0Jhya+s5uJ5/hncMkp9srmnc5+4TXC7/RR9UA5Fs6YFii4EDrpPmcdjz3bYj4ntH9zz0jpLzAumtAGftmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYoOzgmj50sgr65H3123P59+x/KtY+q6B0eXNC15P3TuQcZRz
	72RYYqWw7518k0AQUyIqQf3PRwMRQGwo4FXo7AniTBtdxjY+gid+1mrQriDcyVM=
X-Gm-Gg: ASbGncsUF7hFat2x0csgqCU0aK55JWwDByrDV/+tGVC0eGtHvwHqGCvQtqc+BiuzPcT
	HTLhyZLw5xmkn1GkM02B0hEiMBUgTAkyYjVcoYS8ugzGiUS3vVn4WiWlokbsEAwOGOyPzs3KaVP
	lvogi1X+3G95Yc5WHBt/wINXNHDJLdS2qWj9kpIBlmsHdRRaos9Wzoo1TZ3KXkFmr7XxR5vibWy
	R/X4x615rVplxGqC83C268xwb3ZlLI/ZZl4fYQphLJ28kQdyZM5NsaKZIBmbK2BuhwKtiKnMmez
	TP6pW2s68wVVzAUsZWuOm5IJ41nVjw==
X-Google-Smtp-Source: AGHT+IHmJNkurL7RO4E3X7dffqrJqghhJyUiAOpbxbEyAGEjCiGP4Aji7mTnE2UrlwDFQi5MR+cgww==
X-Received: by 2002:a05:600c:468c:b0:439:a1c7:7b29 with SMTP id 5b1f17b1804b1-43ab0f426c6mr7915255e9.17.1740433928545;
        Mon, 24 Feb 2025 13:52:08 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd88371asm216037f8f.57.2025.02.24.13.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:52:07 -0800 (PST)
Message-ID: <854925a6204f36fff6d653bb4a30c55a6adb3aef.camel@linaro.org>
Subject: Re: [PATCH 2/6] dt-bindings: gpio: add max77759 binding
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
Date: Mon, 24 Feb 2025 21:52:06 +0000
In-Reply-To: <20250224153858.GC3137990-robh@kernel.org>
References: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
	 <20250224-max77759-mfd-v1-2-2bff36f9d055@linaro.org>
	 <20250224153858.GC3137990-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rob,

On Mon, 2025-02-24 at 09:38 -0600, Rob Herring wrote:
> On Mon, Feb 24, 2025 at 10:28:50AM +0000, Andr=C3=A9 Draszik wrote:
> > Add the DT binding document for the GPIO module of the Maxim MAX77759.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0.../bindings/gpio/maxim,max77759-gpio.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 47 ++++++++++++++++++++++
> > =C2=A01 file changed, 47 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio=
.yaml
> > b/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml
> > new file mode 100644
> > index 000000000000..9bafb16ad688
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/maxim,max77759-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim Integrated MAX77759 GPIO
> > +
> > +maintainers:
> > +=C2=A0 - Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > +
> > +description: |
> > +=C2=A0 This module is part of the MAX77759 PMIC. For additional inform=
ation, see
> > +=C2=A0 Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
> > +
> > +=C2=A0 The MAX77759 is a PMIC integrating, amongst others, a GPIO cont=
roller
> > +=C2=A0 including interrupt support for 2 GPIO lines.
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 const: maxim,max77759-gpio
> > +
> > +=C2=A0 "#interrupt-cells":
> > +=C2=A0=C2=A0=C2=A0 const: 2
> > +
> > +=C2=A0 interrupt-controller: true
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 2
>=20
> You need to define what each interrupt is.

I think maybe the interrupts property is not needed after all:

The PMIC has one external interrupt line (described by the top-level
device), and the two interrupts here are just a representation of
the PMIC's internal status register (i.e. top level interrupt is
raised when status register for one of the gpio lines changes,
amongst other things).

The intention is for a gpio driver to just treat and model them as
cascaded interrupts, but they don't need to be configured in any
way via device tree, as everything happens internally inside the
PMIC, there is no board-dependent routing or trigger type possible.
(Of course, there can be drivers subscribing to one (or both) of the two
cascaded interrupts here, but that shouldn't matter I believe).

Does that make sense? I added the property because
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
says it's a requirement to have an interrupts property, but I
believe it doesn't actually apply in this case as there's nothing
than can be configured.

Am I missing something?

Cheers,
Andre'

>=20
> > +
> > +=C2=A0 "#gpio-cells":
> > +=C2=A0=C2=A0=C2=A0 const: 2
> > +
> > +=C2=A0 gpio-controller: true
> > +
> > +=C2=A0 gpio-line-names:
> > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - "#gpio-cells"
> > +=C2=A0 - gpio-controller
> > +=C2=A0 - "#interrupt-cells"
> > +=C2=A0 - interrupt-controller
> > +
> > +additionalProperties: false
> >=20
> > --=20
> > 2.48.1.658.g4767266eb4-goog
> >=20

