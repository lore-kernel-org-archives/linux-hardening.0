Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A98399352;
	Thu, 21 May 2026 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374056; cv=none; b=oxZ7vOt2KF8cnPEcmPgmQZcY/VmyCtvAcYEdv7jNyMRgdlajcMEJumBZcKZkdlN5LcOV/HzXeKMjc9ii0tkOr/qF4pgr+DxH3mCgr2mfgOI8n66feK5hhbQkaH+fZ5sD2Z15VNpDubHdCWio9jSj/K2xuz/aFdOQ4sGWvExA6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374056; c=relaxed/simple;
	bh=3P3HietHxj5kBTDVUQtEkA1bJDUIQtkdlTMiOJxuo5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBLmYL59Q1khtS9lSF/AC+H/GbYr416GBDx7visqOtr8TshE9JRkZJAR3arZrsWmU9ihYo6Fia4uuk1FUNE6uxVt/Kuz5JImzwd2ZrW2S9qPHofxbMkfgjQXLyRfjXeqCT9Kpakrc2Z4SpQcNEl/+GwkDUMVjbbXEKyw+bDywcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sk661n9K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0yWIprTs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sk661n9K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0yWIprTs"
Date: Thu, 21 May 2026 16:34:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779374054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qZjuXJBiANp+9zScLJMqXa99VOzBuWOAEWSOPpMpkU=;
	b=Sk661n9K47N5EqHbFZdAnux+K6yRw2O+7OulPg1dUBpuuDGmjgsF3IvIO8f8aL1+geChDW
	GcXQl8fUfj/PhrlNW7SE+D5f0o2XF2+c621Ml4wu21hlnjsTuV8iRSl0NJUTNafcMptr97
	SbPdIRuskYH8XSAMEQvU0N3H8mszq8DVghvadAGwLEFykFH+BxBGYYyQzbHOSHujMNUi0x
	0EmlETX4tQvD+V5axTaApelp8OEHPZcyW/tHwN/GbSaaeTXNiyqu7D9km6ynqcu1aDxmFn
	tyhW5XS/Rkl3DSFqjh9UPb+s7y0V6DZSgii721PSEqWma8WQJ+nW6HA0fwsUtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779374054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qZjuXJBiANp+9zScLJMqXa99VOzBuWOAEWSOPpMpkU=;
	b=0yWIprTsJejVqpNi5M8FC4KNi/qJAp5QYHcZ2428yee5FLrX6b+/Fgz8McuTDq2LzrsF9h
	opFy0g3NECzczcCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 4/8] nvmem: Add the Raspberry Pi OTP driver
Message-ID: <20260521163245-10305d54-ede8-4b5c-94bc-3abfcfc9d880@linutronix.de>
References: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
 <20260520-rpi-otp-driver-v5-4-b26e5908eeac@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-rpi-otp-driver-v5-4-b26e5908eeac@linutronix.de>

On Wed, May 20, 2026 at 04:27:56PM +0200, Gregor Herburger wrote:
> Raspberry Pis have OTP registers which can be accessed through the
> videocore firmware. Add a nvmem driver to support these OTP registers.
> 
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  drivers/nvmem/Kconfig                      |  11 +++
>  drivers/nvmem/Makefile                     |   1 +
>  drivers/nvmem/raspberrypi-otp.c            | 130 +++++++++++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-firmware.h |  10 +++
>  4 files changed, 152 insertions(+)

(...)

> +static const struct platform_device_id raspberrypi_otp_id[] = {
> +	{ "raspberrypi-otp" },
> +	{},

The last sentinel element should not have a trailing comma,
to make sure nobody places an element after it by accident.

> +};
> +MODULE_DEVICE_TABLE(platform, raspberrypi_otp_id);

(...)
