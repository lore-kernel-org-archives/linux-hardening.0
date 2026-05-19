Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87D3A9639;
	Tue, 19 May 2026 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186019; cv=none; b=BfZQB6n2vkmDF14Hz2+c1nk89z+4ldc+Tw16nRLb0BBXBkLeZMyPTtB8hRy8mo/nDXPU+CWRMWjBOTAtpTX7piL5uBZeFwl68Y9UJGTVXqayI5egmGhAev6fHnkJMKF8ozzyh4RYP7hoFbNayf+ywHbTbwk6dqpQrW8wihEu5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186019; c=relaxed/simple;
	bh=+W1sCv03GpFE1OlS0qwndW+deA6u+TTuvfgb3fVLraY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kerUO0CF2t/my3tnXrY6AUkixTBm5XhFk6RP7dmGStSh2NmR3RciPYgHMPUK85sTQo/xoOYGugJTQqQAgsRNbSCBkNwrzPVqjB9PeOvr3xnh/ae/s5o452H/bgiKg9xJLgs7SR6no3Ts/1jalJV+9m+B3oj2GVSU7j2MHmJgX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mMWJ/Vsk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a382yd6U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mMWJ/Vsk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a382yd6U"
Date: Tue, 19 May 2026 12:20:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779186016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWTTnSfqXdKnwvkxIgz1Vius00wgWwYaIbfJKFoluEw=;
	b=mMWJ/VskBn+dCVgGOj/O6xp4COr3uQ7KqJezywuRcQF9yire3SpT6hbuOzqzqr0kyypXix
	6QRCsJZFrS3a3wzd9fTfk5abRZkItzx38U3XToeu4RnZrmhnntBocXhO5CyE1tyPlFv8pm
	p9V3/Zg7xO9tTrwS6ScSVojGu3Mf3CZ6lTL6tzK6XVQWC0BQDUPG3BAt0OcKrGQu7ukSxO
	bF5Iw3SG8qqBAXHy9G7pBJN2GKIcVN9EZFTlQHs/YiODKXFIGSoskV6mVzJS2tTzjEjb4v
	FqEU0m2tk/uxEr1WZzVxORaHxsIoZ+YK7fZ1kXUTUOnTFqquQIoIm5vrbfLJKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779186016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWTTnSfqXdKnwvkxIgz1Vius00wgWwYaIbfJKFoluEw=;
	b=a382yd6UYNBfmPCutP5L0kQcuDHEh9vJkj3DPvLL+Z7Sq+Mw4WTOtX5URKm3ibNcquTcZx
	tHTKS6cqaPU0LHBQ==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 2/5] nvmem: Add the Raspberry Pi OTP driver
Message-ID: <bv4vwmkkjh23lahkrupwclqs7il4vxqeknalgqn52k3wc6ztsg@z5ukn774brtg>
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
 <20260508-rpi-otp-driver-v4-2-cf8d725d8821@linutronix.de>
 <20260519110041-2d8d92c2-d265-43d1-848f-bf9231a106c8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519110041-2d8d92c2-d265-43d1-848f-bf9231a106c8@linutronix.de>

On Tue, May 19, 2026 at 11:14:28AM +0200, Thomas Weißschuh wrote:
> On Fri, May 08, 2026 at 04:42:45PM +0200, Gregor Herburger wrote:
> > +config NVMEM_RASPBERRYPI_OTP
> > +	tristate "Raspberry Pi OTP support"
> > +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
> 
> The '&& !RASPBERRYPI_FIRMWARE' clause looks weird, is it really necessary?

Yes it does looks weird but I think it is necessary. Without this it would be
possible to build RASPBERRYPI_FIRMWARE=m and NVMEM_RASPBERRYPI_OTP=y which
results in linker errors.
> 
> > +	help
> > +	  This driver provides access to the Raspberry Pi OTP memory via the
> > +	  nvmem subsystem. The driver supports the customer OTP as well as the
> > +	  device specific private key OTP (BCM2712 only).
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called raspberrypi-otp.
> 
> While we are here: The empty line here is now missing.

Oh. Thanks will add it again.
> 
> > +++ b/drivers/nvmem/raspberrypi-otp.c
> > @@ -0,0 +1,130 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/overflow.h>
> 
> This looks unused.
> 
> Instead maybe add linux/types.h, linux/align.h
> 
Thanks will drop it and add the suggested headers.

> > +struct rpi_otp_priv {
> > +	struct rpi_firmware *fw;
> > +	struct device *dev;
> 
> This looks unused.
> 
Thansk will remove.

> > +static int rpi_otp_read(void *context, unsigned int offset, void *buf, size_t bytes)
> > +{
> > +	struct rpi_otp_priv *priv = context;
> > +	struct rpi_otp_header *fwbuf;
> > +	u32 count;
> > +	int ret;
> > +
> > +	if (!IS_ALIGNED(offset, 4) || !IS_ALIGNED(bytes, 4))
> > +		return -EINVAL;
> 
> Isn't this already enforced by the nvmem core?

Only for sysfs access through bin_attr_nvmem_read/bin_attr_nvmem_write. But
there is an in-kernel API nvmem_device_read/nvmem_device_write which does not
have alignment checks. So I added the check to be more defensive here.

> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	data = dev_get_platdata(dev);
> > +	if (!data)
> > +		return -ENODEV;
> 
> I would do this before the devm_kzalloc().

Yes will change.

> > +module_platform_driver(raspberry_otp_driver);
> > +
> > +MODULE_AUTHOR("Gregor Herburger <gregor.herburger@linutronix.de>");
> > +MODULE_DESCRIPTION("Raspberry Pi OTP driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:raspberrypi-otp");
> 
> Instead of the manual module alias here and the implicit matching of the
> platform driver this should use an explicit matching table:
> 
> static const struct platform_device_id foo_id[] = {
> 	{ "raspberrypi-otp" },
> 	{}
> };
> MODULE_DEVICE_TABLE(platform, foo_id);
> 
> static struct platform_driver raspberry_otp_driver = {
> 	...
> 	.id_table = foo_id,
> };
> module_platform_driver(raspberry_otp_driver);
> 

Sounds right will change it.

Regards
Gregor
