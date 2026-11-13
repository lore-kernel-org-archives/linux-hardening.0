Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551673;
	b=0ZoYdRVdiUTkEsUuM2N891ge2rsbDTPy3wLaRoIhZpsNH9OYLMEzsXqQrNi+n5PPNNz8
	 dnnvv0KQc0sr1zqxN+V9bq2WPiVx5Kuxb9KUPvw7D7gP4TxZeVwNY4vJhg0yLpDRWlaQP
	 CIvdr/SXXg3ytsfY2Sq6DDmkyN55ZvjI5N0aDynEBecbBY1KDMmHvwvKV3Mluz7F1fB04
	 yVOw3oqlxpgVqZ4ce//9rHcs9a2hbxlS4XamEiORGCiPW8NmrIzsrAF9oZ1YfKJ+mr4GL
	 roe37WxmYCUbjLflteEWYMQL6jbnCHTyi93FA2xj1h4OP1T5FPuwAy0B1DppDSAFQrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mdanL4lnjhf1tDXUSVl0wHa7iY+CsmDBpWWdd3/y5b0=;
	b=bUluFlgZLcZBvyK65bHTICjNylST/h9l540N7LomYKnf4CEReYlaQs0tcjieaG5Danee
	 bHE8TSg37YryG+5wPHAMFsS0UUUrUmDwKtSkv0G4QmH5nok6DnBFWggj6zqgiWfeH5h1m
	 qE7UlQ1IcqcLKzNdcPyIhniJo6NJmb7i4lxN2w2Q2i+eWLaYeEKtX/GHZaP0/JfqNx7Bb
	 pv6qQJkhOoidgIbKcwdQYqexcpfWQlhf5cxaMA65tlgmzp3Rd6xVpgBAlviLt6Z/OLJ3V
	 jD97vg6aU0zgMI27O35SYInS6T02zzcDkZwmMW7kxX7GLElFnCgN1FGxK4GkYCIqKWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=I6aemvBJ;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20234606A321
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 06:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20234606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=I6aemvBJ
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so8615115e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 22:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794551670; x=1795156470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mdanL4lnjhf1tDXUSVl0wHa7iY+CsmDBpWWdd3/y5b0=;
        b=I6aemvBJHmam6cbe/j4xacPPokmaOo/01fnqrJkf6jHqoIkkA6Oiru/Yu0qvs58vHV
         R/crfoNsxXMT/QzFJPThJV/Yx6I77XkeKVYmi2lcyO6YplQfI0/ZjjWSZfzKqTHWNDPb
         NZR5EvGyQkTPah9S8IbxLyAASDDhZwpgbnHIR3IWkgSSJlv4dbMb3Dg7WzxLkAiNTibI
         C8JMRIBMwid+wNtDLRINIOg8Tr1MHNqmabdR1Dw4O35ztbgC67SgZW1F+H3PBnJb5V3f
         wO6xTFbWvgnhQvigre2rFM4ZpPx+b34UwH8N2Qlw4yp6jY9dkgMO775CT25rjV0W7lGJ
         RlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551670; x=1795156470;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdanL4lnjhf1tDXUSVl0wHa7iY+CsmDBpWWdd3/y5b0=;
        b=QG/IhYQghyfeNYMH9+sbaOPlbDp9CdU7TFVB/IKR3T41DqeZk44sEsMZCIRHNBpu9t
         bb7F9p+MNbrAbWt6CVB7F2ZdCx458TXP9z5p0l+3l/LF1YgMco3oBsbSFlTbpGD111OM
         Q0oBhBMa2SSdjXuwonnxKyuXO1NYevTDpKfqt0q21/AVPx0poze5ojz93HLzewAcOtOG
         vpiTysUTn+wS1/qZjwCZrgsfwY2YVceJzkv5fXx7KOjWslFE2TXzjx4eAi4xKuaKw9FE
         mNaVsTuQ9AjOjU4UIOfaEIvE86O2BRcFvYLZCGsCrfOS/Zgps9IAXxYlahvCuMwsuCHD
         Px2g==
X-Forwarded-Encrypted: i=1; AL+hErF62pNbAy2Yjv4wN1XWBLyo03KXmEbxTO/at7efYeGXCVKl59fptjhbCGNyJ+wJeKkTVsutHmughUKczaurQBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z82SjCVnNAZ6PqUXv+cXHrRTlHbCeQAf+9mKvxgE3qiK/cXWVcq
	sQt6I70u3UXOFyk8woCqf3QBAj0yORlMKMnniXrjSh6/HiGEW0uIM36dbpKxiIbSLZBfveKMdOg
	rbcneBpk=
X-Gm-Gg: AYBFou0l1cECIkryd/m/4KKal79VwLZMkEboHB0epIeoKErGtGaq4qve6mDx20NY5ws
	wIOYsPvQtCjFYT4bM71B+BOHo8na1Z3R0Ab5Ca++YCenXmrlxk6pU9j4/t8K6rKdnSr8m/Pr1/5
	31KNWt1SGnumHzMW08JpnI7uZcw8bkJ9IblQXYk3XH+E0bT+dZBB4nsemSkzW0mtzkGP8ttNc/v
	SXJsDMui7Nboo8AxLBJoTyjgQVYhKLEqa5DAXH88jMF2OnokDaiOTsPqEfNNZI1TFumJcNeLgPk
	ZFgyrN0Jg/GD5R+m9q6SVa+k38rSmJW4p85+zu+Q8NlHW1R5L/W+HqlKJA5JIzvzDqfIOnOcZyZ
	G7vuvbTcLitcU/FWsn8D1Eh3g01EW6Fa2lH+WYHwX6h1jHFnahRTtLhNNyqHTAQ9DbvlbbeSGGs
	ZJrPOfhDOpX2FBL+GdzIJ055ahJDmSn9Ho6gOlQ9foxUu8dtiT+N9MIgnc+phs4eGz/m7RHO4IO
	B4LFuqC6OP7W/mtfU+5Rvct/p/oPLPe9Jc1rlO/o07CTmv/3Eu3ze0qBpTC3OtSbm8O6DOn1vrs
	YCenKI/KYem/5X9xnFBN8yGq02W46FJ42A==
X-Received: by 2002:a05:600c:3f08:b0:4ad:5e09:ae43 with SMTP id 5b1f17b1804b1-4bb55a8d2d6mr27281365e9.29.1794551670522;
        Thu, 12 Nov 2026 22:34:30 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-49c5d22394esm3528090f8f.3.2026.11.12.22.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:34:29 -0800 (PST)
Date: Fri, 13 Nov 2026 07:34:28 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 05/12] nvmem: Add the Raspberry Pi OTP driver
Message-ID: <avauNsYkHqIAshCe@monoceros>
References: <20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de>
 <20261111-rpi-otp-driver-v9-5-0a7292a7a5b4@linutronix.de>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dzmqcqzq6stkx3nh"
Content-Disposition: inline
In-Reply-To: <20261111-rpi-otp-driver-v9-5-0a7292a7a5b4@linutronix.de>


--dzmqcqzq6stkx3nh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v9 05/12] nvmem: Add the Raspberry Pi OTP driver
MIME-Version: 1.0

Hello

[dropped Ray Jui and Scott Branden from Cc: as their addresses don't
seem to exist any more]

On Wed, Nov 11, 2026 at 08:23:27AM +0100, Gregor Herburger wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Don't include <linux/mod_devicetable.h> as that introduces a lot of
unneeded build dependencies. <linux/platform_device.h> is sufficient to
get of_device_id, so you can just drop <linux/mod_devicetable.h>.

> [...]
> +static struct platform_driver raspberrypi_otp_driver = {
> +	.probe	= rpi_otp_probe,
> +	.driver = {
> +		.name	= "raspberrypi-otp",
> +	},
> +	.id_table = raspberrypi_otp_id,
> +};

Inconsistent use of spacing before =. If you ask me everything other than
a single space gets inconsistent over time, so I recommend sticking to
that.

Best regards
Uwe

--dzmqcqzq6stkx3nh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr2r3EACgkQj4D7WH0S
/k6+Ygf/S3+kTetCLEiK3rGw/ROThFP+vKHVE0yIu2nZcj3dbawf3ySgY4wtvMJa
0PbVsBeV9OgRc4ZEsTQF1kcAR823yZXDtiTzGnr2rvlyz6rrl1wvHyPiphHI+w75
XxDCFxj38njwrnwhcUJTxHeH5bpa43eYpLZHCGQeNs/1CalWV1lxeonWMC5+kbzr
TUgmCnXFg059Zu9KpxeAPpAd5uQ3rihwl+7n11njUahK4aBuIhKibFiC/Mur9HJ6
y6s4h4Rk4A4KiA/z4puB/W/FSQLIej2b75CbvUkvGqBX5jOIbgbqza34HyRALj9L
XBcLUzxAKLY5ZvkPb2DgHx5xPh9+sw==
=ExxM
-----END PGP SIGNATURE-----

--dzmqcqzq6stkx3nh--
