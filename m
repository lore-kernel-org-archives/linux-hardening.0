Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B922D7A0
	for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655202; cv=none; b=U1IOqxWTRaNdmaeY+Nu7MOBKJ5Jz2czQ1dBn2fQKhBFhgOLmxfRUtfaQ3cKIS9xn23XLZDTZ7szbph4gnvGMoE38uFtPfFist4QQucyN938jbYZvJyHAbC6URMOHBOxFP2AjpDw0P4BY7vlqb8QBp6JDVhLdFuP2qS/nEfqSQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655202; c=relaxed/simple;
	bh=mFk2iRlhqswVknidb/hzvERvekGfFTJg0dMalWU77y4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+8ZQzkderFVTXxS/tDFJvTwX3CWXKGDmu2oCeAhpGBcxTC6gB64rgCAqC1Q4RIWpY+SjDf9YwCSoip04mRcFQg7z3AL7g3khyTDR9r3puSXY9bA3yRbQjq/+JrWnkJIBUwyFexkECwBo+5QlFcmfRem8lM4s82cjosP6WjXIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TCAFzTcc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCAFzTcc"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so426301f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 03:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740655197; x=1741259997; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nrBhEllEopBWP9HcbxGglPZEUP0T/ozOsx35CY7uHqE=;
        b=TCAFzTccKDEqN/cG7jdNOUx5oNnLP5XP7cdWrI16NZICBnJ5N6/BHeTAgKV/Nf7LBE
         UecM/jLQUfB0tTS5FsxtdxVxvKfbzeLaid7qJlACP0tIVsI7DueQw60igCvKHuvpDt8e
         AL9hDaXrOrE6fzG0zkEC2Yoha1kzA9O4PrCHfg05B82iwQlF2aNbsgnnWC/AyMVO8fJ6
         VmL/IyoWRKw5cllvTsuNuXaNTr4cpk8koN/GJEmDKg3CL79fvyRZqv/pHZMXI0MhK/MW
         +Ig5KEJOTvNnp0yi6lUV6WuqVPwWx2jltdrOZuULM/VvMfLVwl4tsDKOiJwkroK519y0
         FBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655197; x=1741259997;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrBhEllEopBWP9HcbxGglPZEUP0T/ozOsx35CY7uHqE=;
        b=Kfm01iiO7H/uioaLeZpvS604oREM+ocavnCuxocq3/FNNOZAbaRhyOxkO6QpTliUQ+
         dR1ZCjoI+cn+yJUm8Nuc9Bigt+IGn9eIlws3Ne0ZphuHBm/Tgfsx4q7ex1ea691THdBg
         xeXU/rSUWg4nINNrFh/O37/30mYiC1joOZkMXPvYVJPX5QH8hgkd+yPUeQSFPeXLG94Q
         RGSW2aK5f5fpDA2bF7WNLqkxgsyE7hym8OyRmetiSu2+fjpryiTAS7GiOFqvV3JiDUHT
         1gOAFVCxAfLJ/McH9UtYwYqATtVImTgzOxIIookJ9uQAxa6ZHoQWPfVvMqAOgr/6zLrX
         fNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7BmGOiPanR6a/RgJVdoOjd+WSldYQJ4Kfb2LTKEQ9UdC+Xld/7TybEMuXCiEldY4pcCUvF8Cex2kp2rXeZjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhEPuuFVNPRLq8/ybIihS0YTAGq3KApCNZrIMLjpd5eyr5e4c
	f+bI0VKRQzdLGB0fg85sLt3C2xEaSOJxVzsvEIDx/hdZQuug7/i0Zl1dEbdotE8=
X-Gm-Gg: ASbGnctgkvqIzN6Zp2sl1lJYAjzxT5EhaTr8v2NDuAKkXExV/OG6kBaFKc8ROaIrboE
	bOwUi3uHl4f/H1OOwGdfyWXkCn3SgIxbxcwzoZuQYdSTS+os4IFiYpRYcYs77GZ2pwXJrdbjbuC
	mSHYEubzDcCQO5NlST+kduB2aVkjerp5cg8jEwqK97XM0aeyuzVhH8NS3l3m73jNxcc+i+C/+um
	/xnlfCm4+IERgP36ZufuxwUxdwLvLC1E723EF7Q4reLoRaKx7gkEdieSzMyU/NaoS44VdqtmDoJ
	EnOS5aACtOGWPCUNC7/jTR5huB6Zag==
X-Google-Smtp-Source: AGHT+IFNsHD/pjhFobiNqCnZP2X8gKHsds8DdBj5VgmPHcb5ULaRf/oWFT2BO7FN/J4etiEnEeAlQw==
X-Received: by 2002:adf:ed49:0:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-390d4f9cfb7mr5139769f8f.51.1740655197122;
        Thu, 27 Feb 2025 03:19:57 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm1742403f8f.31.2025.02.27.03.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:19:56 -0800 (PST)
Message-ID: <f3db83179b405ca056fd55abdd6c38adaedbaea0.camel@linaro.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: gpio: add max77759 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 devicetree@vger.kernel.org,  Kees Cook <kees@kernel.org>,
 linux-gpio@vger.kernel.org, Srinivas Kandagatla	
 <srinivas.kandagatla@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
  Will McVicker <willmcvicker@google.com>, Conor Dooley
 <conor+dt@kernel.org>, kernel-team@android.com,  Bartosz Golaszewski	
 <brgl@bgdev.pl>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Lee Jones <lee@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Feb 2025 11:19:55 +0000
In-Reply-To: <174060184807.3654907.17826939583833772128.robh@kernel.org>
References: <20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org>
	 <20250226-max77759-mfd-v2-1-a65ebe2bc0a9@linaro.org>
	 <174060184807.3654907.17826939583833772128.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-26 at 14:30 -0600, Rob Herring (Arm) wrote:
>=20
> On Wed, 26 Feb 2025 17:51:20 +0000, Andr=C3=A9 Draszik wrote:
> > The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> > includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> > Port Controller (TCPC), NVMEM, and a GPIO expander.
> >=20
> > This describes its GPIO module.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >=20
> > ---
> > v2:
> > * drop 'interrupts' property and sort properties alphabetically
> > ---
> > =C2=A0.../bindings/gpio/maxim,max77759-gpio.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 44 ++++++++++++++++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++
> > =C2=A02 files changed, 50 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
>=20
>=20
> doc reference errors (make refcheckdocs):
> Warning: Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml =
references a file that doesn't exist:
> Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
> Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml: Document=
ation/devicetree/bindings/mfd/maxim,max77759.yaml
>=20
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202502=
26-max77759-mfd-v2-1-a65ebe2bc0a9@linaro.org
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:

'make dt_binding_check' doesn't invoke 'make refcheckdocs', unless
I'm doing something wrong - and therefore 'make dt_binding_check'
doesn't print any warning, contrary to what seems to be implied by
the paragraph above, If I run 'make refcheckdocs', I do get the
error, too, sure enough.

I've never come across refcheckdocs, and it wasn't on my radar.

The error is because the binding's 'description:' references the
mfd binding using the complete path and the mfd binding is added
in a later patch only in this version of the series:

  >=C2=A0... For additional information, see
  > Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.

the error goes away if a relative path is used instead:

  > ... For additional information, see
  > ../mfd/maxim,max77759.yaml.

I'd like to keep the reference to the mfd binding, and keep
refcheckdocs working as intended (i.e. keep using the full
path), so I'll split the gpio binding patch into two, the first
one without the path and a 2nd one to add the full mfd binding
path, to be applied after the mfd binding. Same for the similar
nvmem binding.

Unless there is a different preference?


Cheers,
Andre'
