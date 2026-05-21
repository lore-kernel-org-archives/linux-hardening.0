Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1A3E6385;
	Thu, 21 May 2026 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374304; cv=none; b=TkrnWUcbNl75wcGbYK29uw9Fio2z9I7HU9kcJED4o3UF9QVrkfrGeZhAvl7tSv1SsMeQ29V92TdLm2o88OFbh/xLzSF4kC+9G+dP34eiGZLs415l89pG01Fs8ft00rAlEWdXZfKvb/zqwhOWEU99ff7dtyPhN83d/y1WCQWCmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374304; c=relaxed/simple;
	bh=2mpKLOMvNNiqCp2E2vtxLhWblnL3moD4QYjjvd5zCdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qebo3FswenU23N6TOtulQkA4WnPTemvalkO+cg2Ac6ZjJlnDumQ88dPVjERm9fxXTL/Nfl8WlaxzIf/ySdtL36fJh+AioAtqoSi9P3HgLNgMTneNYqctIctcz6hkXwk2POsLIpCr1y5vSfxzymbVXVuiHPdrVeFpTyuUPt04bJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ubhaa0JL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txcK/sur; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ubhaa0JL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txcK/sur"
Date: Thu, 21 May 2026 16:38:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779374299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOz2+iWRM2wDOOs0YNhvWRw3uLkbQzJuYN48Hif/9uo=;
	b=ubhaa0JLmOR3y9vevmVht6oRt8fB5pyi5Bv7tkih5zW0XDqmPutB5n0Vp+HX57ObDrHxgR
	PzyKrc3ep2GlQjj8U4ezpYZ1F21CuJXPwRKGjbm/W4J6Jhe280uz0lDGpDma8klD8wQokb
	1InfeFRj7OEP6fipD8ThNgkGVUwzzVKU42zRQEfTOxNHYUBfvEp/SRTlunfJRuBXx21S5f
	YmQelfaLG2J38RPfLXoTU0s/wobQUjBeOVltGl3B+T8dWz53OQCqjjiVaksYb3NSKqa2Nh
	M2e1E0Nrj1yMrejAgxiSSTyOmsfDkJIaCgv2dd4t84JqTLOUodHGvRN0qKgZtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779374299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOz2+iWRM2wDOOs0YNhvWRw3uLkbQzJuYN48Hif/9uo=;
	b=txcK/surYtQLmpTtlOUsTQg47X+5bf5hFPrnW0pWoZ+6X6E3P7EZRF+XLJuSaxn4AdM9d6
	Ykz9P8WetXt7gDDg==
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
Subject: Re: [PATCH v5 5/8] firmware: raspberrypi: register nvmem driver
Message-ID: <20260521163452-5e1b28b5-3c2c-4658-99e5-1e8b480e14b0@linutronix.de>
References: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
 <20260520-rpi-otp-driver-v5-5-b26e5908eeac@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-rpi-otp-driver-v5-5-b26e5908eeac@linutronix.de>

On Wed, May 20, 2026 at 04:27:57PM +0200, Gregor Herburger wrote:
> The Raspberry Pi firmware exposes two regions with otp registers. The
> first region called "customer otp" is available on all Raspberry Pi
> models. The second is only available on the Raspberry Pi 5 (bcm2712).
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  drivers/firmware/raspberrypi.c             | 59 +++++++++++++++++++++++++++++-
>  include/soc/bcm2835/raspberrypi-firmware.h |  5 +++
>  2 files changed, 63 insertions(+), 1 deletion(-)

(...)

> +static void rpi_register_otp_driver(struct device *dev)
> +{
> +	struct rpi_firmware *fw = dev_get_drvdata(dev);
> +
> +	rpi_otp_customer = platform_device_register_data(dev, "raspberrypi-otp",
> +							 PLATFORM_DEVID_AUTO,
> +							 &rpi_otp_customer_data,
> +							 sizeof(rpi_otp_customer_data));
> +
> +	if (IS_ERR(rpi_otp_customer))
> +		dev_err(dev, "Failed to register customer OTP device: %ld\n",
> +			PTR_ERR(rpi_otp_customer));

These should use %pe which will nicely format the error.
This also differs from the other subdevice registrations which do not
print a message on error.

> +
> +	if (fw->soc == RPI_FIRMWARE_SOC_BCM2712) {
> +		rpi_otp_private = platform_device_register_data(dev, "raspberrypi-otp",
> +								PLATFORM_DEVID_AUTO,
> +								&rpi_otp_private_data,
> +								sizeof(rpi_otp_private_data));
> +
> +		if (IS_ERR(rpi_otp_private))
> +			dev_err(dev, "Failed to register private OTP device: %ld\n",
> +				PTR_ERR(rpi_otp_private));
> +	}
> +}

(...)
