Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD20D1B4250
	for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740321; cv=none; b=GnKgf4nwo10q0//prpco3aIYvY4LzBEbmg+JSF22THf22p53jSkJpKYv5IftQT3Eo03ZWNOvJoC2r1G82YTjykuTnkvAhppLIij9PG4DmrXuBZ9LSdS4s9hCxyFB6nxJtN/ZSJSZzTCoIIUlxt1Z7p1e/RCeGB3td3fSIdfu1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740321; c=relaxed/simple;
	bh=oxqNUINeTffXc20l0BtSEeH5hWwFLIffg14u7l8+l+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkFPTl01pXXvjTjqbLnlzNfJP/QeagDtZ5AydYQixSFLuJ+BdmATrLFyv5F1DPNEpIkNTNQF2fdNMrt1Uklc+hYLxdwPr5CkJFsUSxhu8BGvkrtcByzVPuvFDQlAv0l6iGUwy2A1ZXBIVvryAMY5Xeab2yw1fu8bbwYhfquJ0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kxUdpb80; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxUdpb80"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-439950a45daso12603735e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 02:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740740318; x=1741345118; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oxqNUINeTffXc20l0BtSEeH5hWwFLIffg14u7l8+l+8=;
        b=kxUdpb80n7pBgWUDV0C2ir3//YEBA5Q7QctLX7E93Fnxu4OzFHRjitL+sp1CF6GbiY
         H5IoylsfqxUmvK87IcjnKuYxumTzpKlxMMpF34cWTKDvtpwA10buOOYPEgeZ00hqpsHh
         3MDUSyAecYMFzz7viZV++8JikkNACZki3w+ZsoWV6+vGfQzwzimwo75eVXxJexSDm5tb
         0mU1nIyayh9A0vYyqYv/V2Jbe08RrKeDZRoplgSr+mlzIEnM5y1lgAD9RTfTQ/TrxWCT
         4pO++SZ56UQXhw2UGcopDTPVE0MwOI4xvxHI9PCYHGX9rwzhHcGac3AECd/brXJXi43U
         ZGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740740318; x=1741345118;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxqNUINeTffXc20l0BtSEeH5hWwFLIffg14u7l8+l+8=;
        b=isJJpQG3lMUFLkMu6+Q98S3KvNlrkEYNX5ZENYMQUgKrYDsafGo+aPQZMjFjMFVM1Y
         KZkn7NbY7VjmEyh37hDyyfDBeC+SnMOyrZG8SYf/VQ3sSCNeT2RX2ImDFEsOk/IBW6EZ
         3+nRwGakusgFgkuVS+iQBG2xxFPokmt6aae+/BSdbZYZwkmcMfoFikKLUC+GO0PmqMDK
         n4TJcmDQzFyUX3o1vnZnnoLX7yy+5sSI6eAIAnUYAAzWpiGjcsCK2CTB7CsKhcYqu+bn
         r/UcmZjotHBHJjKo6Bi6Y/Clxjy8xkjZ7qHziKYBshmz/1yzWZ4AZA2e7OI4mpAEo7uE
         Hlew==
X-Forwarded-Encrypted: i=1; AJvYcCXdZUtROHjExFCXF6muBEVo+omgVfCN1pKJnq16Pad6fRfVDD3H1pBXP3WZl7J48jBfaUNn1QBgByz6ibHUzrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHa4KiqXTJUvgXxHq/E6X3E/VHCz1tjo0bI9FOVTqv9/CBqKZ
	fMytw5+Jk1i5kilNssWPYh3UdRzdBMRxxZr/ERNrJKTNzLPNT1A6pqGvaLyAILuhLi+8+vsV4pe
	f
X-Gm-Gg: ASbGncu71bPAF0M/WNb/EFDNufgnLGW4STTbzCBdKr7qG2rMsbB0pxW6tXzjORkV/qA
	PKJwpAti2VSzQoQ+Vuy37UewmP4G4gT16IstrHkhvwObNdGs4ChK+D01H6Qnva8OgdP2YHJp4iX
	alSjMlqUXCSNTYk5avMB4/CxImkHSUYgW1CIeng8cmSRGWFjaRX1jBxqfuYqoVimzddL420R6Io
	FU4FWW6Q12+3ZBevzjn6zCyn1Ow2VqFAaY/ta2DrXnYr8obEYVHVRw+0p0xZ0QW0GTxNNaUZqO6
	jEuZV7BghoedyXF1pC5Qkvt7rQE4fA==
X-Google-Smtp-Source: AGHT+IEt5YT3CBVFRKgnoMOQ/u6jH6bjwPCwN0M1DfhxLjRDEfi9tiVUCytcpBFYvfzc3Nle3t/Cuw==
X-Received: by 2002:a05:6000:1885:b0:38f:2766:7594 with SMTP id ffacd0b85a97d-390ec7cf66bmr2121670f8f.12.1740740318200;
        Fri, 28 Feb 2025 02:58:38 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795978sm4724227f8f.3.2025.02.28.02.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:58:37 -0800 (PST)
Message-ID: <d06058296a194a4f2c9fcbcc5c24816ecb1f51b1.camel@linaro.org>
Subject: Re: [PATCH v2 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>,  Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva"	 <gustavoars@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>, 	kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hardening@vger.kernel.org
Date: Fri, 28 Feb 2025 10:58:36 +0000
In-Reply-To: <CACRpkdYoWuJzjqiKrSNzdXV+5N9Gp0n+pdCwSZgocwy0JHo7Vw@mail.gmail.com>
References: <20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org>
	 <20250226-max77759-mfd-v2-5-a65ebe2bc0a9@linaro.org>
	 <CACRpkdYoWuJzjqiKrSNzdXV+5N9Gp0n+pdCwSZgocwy0JHo7Vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Linus,

Thanks for you review!

On Fri, 2025-02-28 at 08:10 +0100, Linus Walleij wrote:
> Hi Andr=C3=A9,
>=20
> thanks for your patch!
>=20
> mostly looks fine, given the MFD design is accepted.
> Nitpicks below:
>=20
> On Wed, Feb 26, 2025 at 6:51=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik=
@linaro.org> wrote:
>=20
> > +static irqreturn_t max77759_gpio_irqhandler(int irq, void *data)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int handled =3D 0;
>=20
> bool handled =3D false;
>=20
> (...)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 for_each_set_bit(offset, &pending, MAX77759_N_GPIOS) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned in=
t virq;
>=20
> I usually just call this "irq", as it's not any more virtual than any oth=
er
> Linux magic number, and it can confuse people working with
> actual virtualization when we call things virtual like this.

Calling it 'irq' would shadow the first argument of this irq
handler function, which is also and usually called irq and which
I'd like to avoid shadowing.

Are you OK with 'subirq'? Or any other preference?

Cheers,
Andre'

