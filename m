Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDA23BD0C
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402892; cv=none; b=fBd19FyW23Nd1fUN5I58I7z/w7ZqQCYSK2ky/qbsdRCyvklD1C5IZsnicwdX39LX3JExm6MhI290YPIK9VZrZG3zmug1nTKrSJwAVlPKK+jnRMxXuRPTOH55ySoWOFCvJ7sI5XYY+wn/Vp87eQ9JrxbVnsrfjWpEKEcantK3/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402892; c=relaxed/simple;
	bh=bLLZFvEQ2mcyD7duh47ZwGoHjIPEzHkxh/Sc0z24Kyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ied1XWvLo2DDa5UgHF4FxEuEcalOucwHQhqKbDFJj8BvPDUFCVjpaKvAic/D7lsAvYGRKXfpAltmGAgcQlGmvWLxiLe5btplzBMNEDGShWpSe0BnHqsahlz5XOCDl3NYQQztsZdAEpmoFasXnTCC8OBy4iaNGhSoTpgEMakebxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+Ogy8EU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+Ogy8EU"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2245978f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 05:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740402889; x=1741007689; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bLLZFvEQ2mcyD7duh47ZwGoHjIPEzHkxh/Sc0z24Kyk=;
        b=A+Ogy8EUQE8JKzQGGQ8yzHdOe/0MnX5du9SpvG1kacFoiGmm70s+MBXnYjNR7GojN/
         kiVDAZ93+M7Uc5FBhSfCfn55OBf7aiz33XEFm2YcMZN3lpxBF5EF8DlahS1ZiAoZoLfg
         eO0TS4s70buKHwUncBL/oTMH59bIo+x/UByxX6lkvv0Y01gtvpuUXVWcMBnGWW18unaU
         TlqnFAggM/4JTQnF4kDteIORunGNTSjv2g756BZN2cbC15QUFcDnkvPRCUx3czvRvm/o
         UJxhbvgc3s0EKj/exnfYM6T/Gb7trNl3SVeK/xLs0hHSbVkVW7ArGs124A7eeFPVvCO2
         cTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402889; x=1741007689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bLLZFvEQ2mcyD7duh47ZwGoHjIPEzHkxh/Sc0z24Kyk=;
        b=lHKwdGsHg/0c+4AYWoBkMu5M+PSh78aToQYvPqXc4GnWm98FxLquPeJ02JoCa1O62E
         12tonJE30gwckb6a5TyLJcG5gQ3m96Hkane8XFqrxlBSG9uL3Omrs6EZk7Aj7yYjxhr2
         UqEu2fIdPs/mCLMUNbqnwq0NEVo5EpiPpxaEF+M10R3pO7Nqfb1W0mZrGVAFeN8cVeCQ
         y7zJ9AfH5aXxlapWay4Wnu2SWdiJz9u0cDkbn094HWgIKbPVbk/DC4g/miln4maUTqHL
         oTIRCDJNCFM+fzF7r8wCe4x0X0YPByOniYUB/G1f0M29jtlyV0aLMR0E5JUvYdOd9nzZ
         I8YA==
X-Forwarded-Encrypted: i=1; AJvYcCVZSZw+SfZWOUgUuIRo0HKG0cnzYsbxp9aP8EYNdTClQ6Jrt+OPj19mGYAr0xQuzFG1WpqVUXmg2DYusCS5WMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mJDCtQj2C1THqvh525+3iui/VEWKPAvksUtgjmAyyFy44ANd
	9Rd61gQSMl1+29zP+gmHoaV7WPoU1V2Dj6XsTcLOVGfAj4A3tA5hmGyz0CtWpS4=
X-Gm-Gg: ASbGnctbGeyzCLtLpauyHet7zyYIZF/g7+OqzJcFUO+WhB25M0JtuHz5cLDUYOOBeaE
	n/l8edpFkNv8hGwWG3drQWl5opvdq1+/IO0qQ2AdZIr/uCnxKFmPjwNQBMDonhxJKMLXW4JlYnn
	ZG5Ob1zkmS6u9fPtd4PSmmXlPCBvjAySIxAsu/zAmaGTHGDYpd8DwuHPnNzigUJoDpQQjqoKs9L
	O7g3d4kBcTioSLtqu0H6Sf5dJVjbYClWy3kuds87sQhHJUGqiSINyaue2k9/b1d1r/UV+yV0Mer
	0PXM1er3BwwiJud7XdWrZbqDkEPL0w==
X-Google-Smtp-Source: AGHT+IE62+bU4+ul+YKhx4/yDKxUqcbC0QHBkW4DOt4UrwyrOCzCT+b1QBYFtOue4gs6rL65DxMppQ==
X-Received: by 2002:a5d:47a3:0:b0:38e:c2de:70d4 with SMTP id ffacd0b85a97d-38f6f0959bamr11119239f8f.42.1740402888772;
        Mon, 24 Feb 2025 05:14:48 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4158sm31190873f8f.3.2025.02.24.05.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:14:48 -0800 (PST)
Message-ID: <b2c8c4757d30b808e3ce800daf6078df6a7a5bcd.camel@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: add max77759 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Kees Cook	 <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Mon, 24 Feb 2025 13:14:47 +0000
In-Reply-To: <288a69e2-0618-4dce-a96d-646daeb6ca70@kernel.org>
References: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
	 <20250224-max77759-mfd-v1-1-2bff36f9d055@linaro.org>
	 <288a69e2-0618-4dce-a96d-646daeb6ca70@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 14:07 +0100, Krzysztof Kozlowski wrote:
> On 24/02/2025 11:28, Andr=C3=A9 Draszik wrote:
> > +=C2=A0 gpio-controller: true
> > +
> > +=C2=A0 "#gpio-cells":
> > +=C2=A0=C2=A0=C2=A0 const: 2
> > +
> > +=C2=A0 gpio:
> > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/gpio/maxim,max77759-gpio.yaml
>=20
> There is no such file at this moment, so this is not bisectable. What's
> more, even if you fix it, you will have dependency which you *must*
> always clearly express in patch changelog or *top* (the first people
> see) of cover letter.

Thanks Krzysztof. You're right of course.
I'll fix the dependency issues in the next version

Cheers,
Andre'

