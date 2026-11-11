Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384876;
	b=4zkFy/hpEjUSm4Q2Gw+KFpMAIb1OMVPKVDF06IWnHM4krgFcIaCceqgcZ7CBiPu56bcY
	 kvHXUwfjozMDbXHDVop0dNssfjee/UULzbP/6k4DmkJrsmpjV5KTilFq+HGPAe7/BFVR1
	 DWCOgfTA23zDZW2LSQSlSky59tuxnASN0szLneSfqPg31OiINhbQSSTxmD53ZQ3bmPaAO
	 Cozrul6511MKPNroup5ww3WJN+B7uNhFwhxELmkEOWqYcdPhzY7RTfxCAhyEu/tSIIKZN
	 4M1RoZd0+gJ3GqtIBUUUwGfRG3N8hShIixu0YquJ28+I0WZu7/qco+01LEBaK83XwiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384876;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=wmJ1b9tTWjRzHKg6nN8Y+a7QMFiCp98+UkeR3JuH5bc=;
	b=E+C8d3Do3w1qPf4bAwCdmsKgcCvZnfIixJM7CpZJlBYYGQU63/zbhegGBNWJ+kgEzE0r
	 yV0Pby/yL6WB/1oMPMq2u14syUmJC91YGagc0JLAuxhPlKfZ9p72lR4mE4pbLGNcBxwT6
	 CSAPxg2opk5+7AZZa3kBpq6q4daunYbLoWhMRuD6ta/QQzZShOS4mTk2ZcGTGqqSmj9Rj
	 +0lZcFz/PfRjztZbO+k9EP5e8CG/wQ98IZC1ZCPOq2Q/XKF5jPRUXUneJ45VSqzZYI99N
	 Q5qVRzR5dHTmj6MhbIf7/P2NddIC2MC3wWFttyE5Wk6vNc8GrAZZnir/kJ7IKDo8gxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ACknxjPd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="X4/X251s";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969E9606A908;
	Wed, 11 Nov 2026 08:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 969E9606A908
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ACknxjPd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=X4/X251s
Date: Wed, 11 Nov 2026 09:14:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794384873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmJ1b9tTWjRzHKg6nN8Y+a7QMFiCp98+UkeR3JuH5bc=;
	b=ACknxjPdebw24cai+wRztA8YbfoiKGH3lQps7QtppIkCXFbDZttO0oQ+Fq8N2YUBZqPW9G
	Y4aubWBAQWvDF1wFF92KqdWYYr/2ApOPKWwgwXV/tODBz6VYc4ttmhXo3aX9gIIZ7lSduP
	1A9NfjHHwda+nlZFatWBY9BYEOLfaAzUy0Duu8C/AF9MRzfcFDIr2wp1QXwuuRmb89PnN9
	PR4viPPL+Z2kcAiUW+mEGxbNGjTVSiFV5WYCtlcUBX3y7LolQYNhdgT2KDWUhNq3YJl8JM
	dxv9A7pLPrSClMBbFHhJRk4NdMODVuLqL6pdVQ3Kzcc3pfgFa3ZAOkqMiOgfgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794384873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmJ1b9tTWjRzHKg6nN8Y+a7QMFiCp98+UkeR3JuH5bc=;
	b=X4/X251s/ZiAX1MjcpLjNyXXGutSoNKv4fi+XLSCARWmJ0XzxrdyH8IPU7sWh1u5YZ4/gN
	p9DApfiwFN5dagDQ==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 00/12] nvmem: Add Raspberry Pi OTP nvmem driver
Message-ID: <y2ocj374gtrwf3ozptwgmqhsy5k26y45uwlbgtyvvmlxkftc2k@gjs3jsbxbm4w>
References: <20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de>
 <66bf8629-225d-4f65-84dd-67f02aa4cab6@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66bf8629-225d-4f65-84dd-67f02aa4cab6@kernel.org>

On Wed, Nov 11, 2026 at 09:02:19AM +0100, Krzysztof Kozlowski wrote:
> On 11/11/2026 08:23, Gregor Herburger wrote:
> > Hi,
> > 
> > This series adds support for the Raspberry Pis OTP registers. The
> > Raspberry Pi has one or more OTP regions. These registers are accessible
> > through the firmware. Add a driver for it and add updates the devicetree
> > for the Raspberry Pi 5.
> > 
> > ---
> > Changes in v9:
> > - Fix sashiko comment and use fwbuf->count instead of bytes in memcpy
> > - Link to v8: https://patch.msgid.link/20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de
> > 
> 
> Big series sent three times within last 24 h. Please slow down and give
> people chance to review your work.
I sent v7 with a missing commit and based on an wrong commit so Sashiko could
not apply the series. Sashiko found an issue in v8 so I tried to fix it in v9.

I have the impression people are not reviewing stuff as long as sashiko has
issues. So I wanted to fix those things quick.

Anyway I will wait a bit with the next revision.
> 
> Best regards,
> Krzysztof

-- 
Gregor Herburger
Linutronix GmbH | Bahnhofstrasse 3 | D-88690 Uhldingen-Mühlhofen
Phone: +49 7556 25 999 35; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Informations on data privacy 
can be found here): https://linutronix.de/legal/data-protection.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-Mühlhofen | 
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700 
806 | Geschäftsführer (Managing Directors): Dr. Wilfried Wessner, 
Katharina Kopp, Alexander Gieringer
