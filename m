Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960847;
	b=q+y6VxuXLUMqPLSUKssrRwlfIf35clCiIQjm/jCcEcKGNgOs5ua63rM7Njvr66QdmShs
	 cS81UXb4g8pN6Aq/bzopd3KjXjZeehCQ/E5UsGmg6CPyNzWv2V/3dpH8Eurc91TXQ5lYn
	 UuCV8ujLdPXFJgnXm34EtJqQIMfdFvI4G+Soijw7Z2nRPAA+oRPqcW8VOulKifFuMnls0
	 rmrJdVFD7QFopRFiay0oQ0b10Qvpq02dbaOWPvkgPASndfSY52bkbp7bF86ce9gJsmxkQ
	 7vHdsV3R1UWmB1PZdUagtCyPdcb5ryZ2NjGXDuj7cU57oErc5JyjUCQgEx0C/KyXnHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EAbgVGUld3HpnIPduKowYF30RMUoJTrsR13doWBMVWU=;
	b=tjLPe7aHEJxIKdGUnxqTjd9qQ3/Dbt01U47tfi86F18WHkn7ik0/85RT9G09RztGRWvC
	 8jRawxU+fFKE1GMst+N5+OnptS8VNZjGSSclfUqWSScfEMUJoBtassauDWfyDQoiMDdHV
	 tcWdaXBW5or0/yShOXE5z5P5yEpQKgHbylp3bCRdPz6v4dvMqRZ9toWvT9yj3c2BgsWjD
	 fQfIXrtThlzmWPH1mF9f99eztkWOxOb28GLHLBNc5PkuWodERBIG6lJs0KZ7/uEcBQ71H
	 yPfd1a6lyRHxoxKc7WeTxj7DabP2alCCIPbIPsA/COwbXSbgk2IazVaA7Va9sdYXzMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GC+TsGsE;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE7606A326
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 10:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24CE7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GC+TsGsE
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so5868455e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 02:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793960845; x=1794565645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EAbgVGUld3HpnIPduKowYF30RMUoJTrsR13doWBMVWU=;
        b=GC+TsGsE8wO2Hqmh/BvcfoRAtl1hYOJCA591nhaN0pElgXjO4M20iBXdOIPR3RQliw
         3qlaglFraP1oT1m4iODRdxxnTpqnFA3+vCr/3V7msrqxK4ZHzvxYrnVNN+YvsVNZ6n8X
         RSYs8R+x3aGovviFhxMIPmkJ5JTzuWi+SsrBNx53LoqQq0YT2b+SO5ET5HXiA7wgA8pQ
         glJJ3s7RN6tV0DY2ad7Pb+XT06BUX1wF423tkB2AGe1rUmodr15NWHEZbbIth4uAdpr3
         sQRJw3yoUJ5ShRTxkaZhL37nzua6weueFVwHdIgRv3mph1yPnozKtZY5bq9F6AjIYjaC
         rGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793960845; x=1794565645;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAbgVGUld3HpnIPduKowYF30RMUoJTrsR13doWBMVWU=;
        b=gC3/BBkG20YmOYD5VRyHl7OmUurgOkpML5qULKdkojO8g/XCCjTAdWKEV0ccFYxMmm
         IVcF8dkY+izIAFRjZrgF8hilY//BG7hZPWKj61RkZFmCiDB5AGiqvMgMpn8y1Prcgfuy
         Y4/EKocqn7J/pERcvbnTfy3QMXJNRJXRNS3k9/KBuDC6TtElryNks33NMRE2l3BEB/IG
         5Mm93R7DBGJlY0hQrCt/91XUMA4f41XBiYtij2x4EhFrl4t2wtXulnTa7yeFIMHycVAD
         chiITPJTPHclmLwH9jEbRVnBYuyvTQmCBbLZE2GSeGMHYaAMCxoJUnzVdUHSzw4P8+5t
         ukQg==
X-Forwarded-Encrypted: i=1; AKwUvBwVnkziBTvKqi7RpT6e7Mfnkz4kYxIhMfJTsb4SIg5zqHcilFiAkYT7UnnQ2aAjAsVdmEUFokoL3myNa4V5V+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VYYApdDlg7bTfjOyJU00OvWwv+2XR3QMQPPCAMFIUH5BQDifi
	J/9fKI+SK/cx5eCGToFhFF8couxMhXfK7LjjzAzDdmnhjwtpYJBwl0xj
X-Gm-Gg: AYBFou2W6Hzv6/SUxDwYXR2urH80yZrD/6HZPp5lLw3mor3uDpkX6AtSIZNG3WOIqEk
	uTz9CE62LaW/9b/RmyJYbHhuI6VziNseMZxBHi7T2/uhdQoAdXm1ZneK5/+HHk8HSj36i+3k55w
	aHJ5tkCGzF/xm/cxsZ5Jsi2ToH6Q7UgcqS9m2swluwFBxUdKePApPMJqoNQ63wxCpFin2JH0PC2
	/ElcfGpTGM471RbP9cGtiffn7GCna6BF9bSrgOcIzXYVcE0GohpkaLvPVh9K3+H6qMtBA24aFGU
	Y7kf4RRmYscqVYqiT9yaVd7etMeC6p4bK0H97QlMAIrUNeF0w41XO67o64nisMa1FvJdnj1Y9dW
	9tHlHkBpLi2m3JBFHcGsY45gdLPIdW/ACH7a37s832CkLE4VSXY7cuScq9zQFX9EWv7YKZeyv6w
	cWncZCLxrhLHTWhe56DDBjGHF9CU4guceZmuLqNoEoPRK+t48447iJKfutDc1fHWJHahihG6sJ1
	/mCgEP8oEZWcTNEDZAxJ218PvfapIl3GJzX2S4SzX/KbXPUVd43FsbY5PWm2sUucfkmLa5myGwR
	LORitq7GzVhY5XIbq5DOKaVigEcxVY+k5CDP9PwvqG+5ruMmjQthoYU8St2kjroJ
X-Received: by 2002:a05:600c:190d:b0:4a3:59c7:f226 with SMTP id 5b1f17b1804b1-4b6de4a5d67mr34911775e9.6.1793960845310;
        Fri, 06 Nov 2026 02:27:25 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6df5eab6esm59845305e9.1.2026.11.06.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:27:24 -0800 (PST)
Date: Fri, 6 Nov 2026 10:27:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, mchehab@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com,
 morbo@google.com
Subject: Re: [PATCH] media: siano: Replace strlcat() with snprintf() in
 sms_ir_init()
Message-ID: <20261106102723.1cc4d350@pumpkin>
In-Reply-To: <CAPDEY+X7q2yeWaa7J=Nre+pQqUa2C760Hh9NovdGNSQ=VsEr8w@mail.gmail.com>
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
	<ausVkYs1-3rJ5Fj0@devuan>
	<20261105113229.4126d872@pumpkin>
	<CAPDEY+X7q2yeWaa7J=Nre+pQqUa2C760Hh9NovdGNSQ=VsEr8w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2026 17:44:00 -0800
Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:

> On Thu, Nov 5, 2026 at 3:32=E2=80=AFAM David Laight <david.laight.linux@g=
mail.com>
> wrote:
> >
> > On Wed, 4 Nov 2026 12:25:17 +0100
> > Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
> > =20
> > > Hi Mariia,
> > > =20
> > > > Date: 2026-11-04 01:02:39-0800
> > > > From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> > > >
> > > > In preparation for removing the deprecated strlcat() API[1],
> > > > replace the strscpy() and strlcat() calls with a single snprintf()
> > > > call to construct the IR device path.
> > > >
> > > > Both the source and destination buffers have the same capacity, =20
> > >
> > > The line above seems irrelevant, and potentially confusing.
> > > The size of the input is not important, because since we're appending
> > > stuff after it, truncation may actually happen. =20
> >
> > And gcc's stupid format overflow check is going to complain. =20
>=20
> Thanks for pointing this out! I initially tested with Clang, but reproduc=
ed
> the warning with GCC. I've switched to seq_buf for v3.

That is entirely OTT.
Currently scnprintf() doesn't complain.

David

>=20
> >
> > David
> > =20
>=20
> Best,
> Mariia
>=20
>=20
> > > =20
> > > > and the return values are unused. This preserves the resulting
> > > > string, including truncation behavior.
> > > >
> > > > Link: https://github.com/KSPP/linux/issues/370 [1]
> > > > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com> =20
> > >
> > > Except for the small comment above,
> > >
> > > Reviewed-by: Alejandro Colomar <alx@kernel.org>
> > >
> > >
> > > Cheers,
> > > Alex
> > > =20
> > > > ---
> > > >  drivers/media/common/siano/smsir.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/media/common/siano/smsir.c =20
> b/drivers/media/common/siano/smsir.c
> > > > index 283770d583d5..636ff228108b 100644
> > > > --- a/drivers/media/common/siano/smsir.c
> > > > +++ b/drivers/media/common/siano/smsir.c
> > > > @@ -55,8 +55,8 @@ int sms_ir_init(struct smscore_device_t *coredev)
> > > >     snprintf(coredev->ir.name, sizeof(coredev->ir.name),
> > > >              "SMS IR (%s)", sms_get_board(board_id)->name);
> > > >
> > > > -   strscpy(coredev->ir.phys, coredev->devpath, =20
> sizeof(coredev->ir.phys));
> > > > -   strlcat(coredev->ir.phys, "/ir0", sizeof(coredev->ir.phys));
> > > > +   snprintf(coredev->ir.phys, sizeof(coredev->ir.phys),
> > > > +            "%s/ir0", coredev->devpath);
> > > >
> > > >     dev->device_name =3D coredev->ir.name;
> > > >     dev->input_phys =3D coredev->ir.phys;
> > > > --
> > > > 2.43.0
> > > >
> > > > =20
> > > =20
> > =20

