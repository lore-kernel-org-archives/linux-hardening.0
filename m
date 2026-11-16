Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845243;
	b=jRt0v/eI8C1Jd5KvW4S+dU8hZQlKaWTUKoXkUonLgezC4k7wSeQ6gv1x8KBmyQVLTYU9
	 s5m7J0UCtCCYPPEAM7Eptb4LdptHj2g8aFjhOK4rt0SZvXBWSny/VcA3TzBsxWImB2PoW
	 /hhGXvC9lzoHbsRZgDFdMp3MzFBtjrXe0Ad6Fz8a2TYl1BZPjdHGUq3l493D/0s/tYj1b
	 LKIG4ZtgYHgcnwOWxUCHgQpwIzMopDWiqkQrJY2NpXMd50sEll2ydR5uy4a5r4SSCf+1R
	 9dg9QCn8zVwFlC1YrCe6uh6kSEGwdt7y7Cg/YDBhAJoeDSlaNGU7PNiuLwRR1h8Nipw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845243;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IKV0hxoQg5hgOML35K8D4/uSv/9pAoDIN4rBZUJXI8Q=;
	b=qYfkzcp904Tp0mG8jxpulxxWQiBkq94a2Y/nM9sKeSCEN5D4/dnizgAyDQGEIuakGjR/
	 ztqNP5Z+WB5mjLqBrPZDLOhDtgft6Vdd3Hu+RUn3dTlRUFW5hzgb9q0LYYq+5lM5wCcxx
	 49bwJyul0LzDEPyyjxWRoPo4vEV8QdPwtg93O+5HNkJrs67drtPK8kj/P2AH7xT9jXy0q
	 NYBQNGE88g88b/Ap1iSpzDz9NS//R4W5WNOwDIsVVDlI+31MvmhlTlc7T6/un5kk6/iFm
	 p1bimcNyXXzS9GUwCpk4bNFH3UC49V+A5KI5nt1gWd2K6QRctZWQ9wWhhRjnlBVbgQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="QPjXvev/";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="IU/57tgZ";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB52606A323;
	Mon, 16 Nov 2026 16:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB52606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=QPjXvev/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=IU/57tgZ
Date: Mon, 16 Nov 2026 17:07:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794845239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKV0hxoQg5hgOML35K8D4/uSv/9pAoDIN4rBZUJXI8Q=;
	b=QPjXvev/fmS6baQMvJBooWt282/oYgPtyoqzKqIpkRejy6aJWhsfurqQa378ygpzgJpeiT
	aqhautM0UdBIonR2K2lYfJD4lRf/KXcI9iJlzmPYMQaHq/tS45NxGn2KQ7vRQtOLMYgg2+
	cWAnfzs4MaPkNrfvw8EbL6V6jX/3L21fsPz/ms+TYmTKnNhDSP+PX/xhVfeJb8wIB9k/+g
	ST3DkvRqEfAgTHDzDhPX05Z6tKw+7E/RhUxoVRYtFvRLmEn/wggWsjMSZePi8uRgQNnoBA
	fHKl2MUgkSM8P02kR/pCri04E1Cl7wZdqNrazsoOXnrb0fv1Kos5T7lKeFXVag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794845239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKV0hxoQg5hgOML35K8D4/uSv/9pAoDIN4rBZUJXI8Q=;
	b=IU/57tgZJYBCfpVisNGjzh93D7596t+Pl1ZUmiCHZzHb39PZoAhhQB+ZLrU+pByZTEEmiq
	FCcW9vUaWjDaH2DQ==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 00/12] nvmem: Add Raspberry Pi OTP nvmem driver
Message-ID: <dzxhqxl4dn7jeqjr3qhvmzegyqyxnrstwotoqkoqoxiipwfxao@pzawf4vd3gos>
References: <20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de>
 <336dc797-2406-4d81-b322-61b85ac52bdd@kernel.org>
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
In-Reply-To: <336dc797-2406-4d81-b322-61b85ac52bdd@kernel.org>

Hi Srini,

On Mon, Nov 16, 2026 at 03:56:06PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 11/10/26 4:33 PM, Gregor Herburger wrote:
> > Hi,
> > 
> > This series adds support for the Raspberry Pis OTP registers. The
> > Raspberry Pi has one or more OTP regions. These registers are accessible
> > through the firmware. Add a driver for it and add updates the devicetree
> > for the Raspberry Pi 5.
> 
> What is the merge strategy for this series?
> Am happy to pick up non-dt patches 1-6/12 and 12/12.
> let me know other wise.
Wondering why you answer on the v8 series. Have you seen that I have sent
another series with some additional fixes?
see: https://lore.kernel.org/all/20261116-rpi-otp-driver-v10-0-15302dcfd5e1@linutronix.de/ 

Also please note that the first patch has already been applied by Florian. So
one of you must drop that patch.
see: https://lore.kernel.org/all/20261114032710.874144-1-florian.fainelli@broadcom.com/
I included the patch here because I didn't knew which was going to be applied
first and I wanted that the series can be applied cleanly by Sashiko.

Maybe Florian can pick the rest of the patches?

Best regards
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
