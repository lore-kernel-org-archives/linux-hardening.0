Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD274DD6E7;
	Tue, 19 May 2026 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201786; cv=none; b=YYFqgBm6TajgO9RTv79uo2vrLcxallZ24k2kzVwxflspF454w3u2R1VTAR2gQlm8USg9XBMWGZgon+FkIy4zgdV1zFPpOQtIRCbXW6NH9GLsLctH4i1vtTw+jERmPDN3xdYwkOy2J3iEr5S81/+k+ynGrMM/hLw76HVuGylxNwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201786; c=relaxed/simple;
	bh=TWofFx/L7B82ZB0Wmdrz/l3gvZ/qJJHsm2e0U8H+1EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5Km8OLBX6Mm0vqgKUWwGIDz9WXv5C4ZaOkjkCAsX0RxhU3zoUOt+9xt1dijp7dJWGa6FqYWGbRnu4TW9JUzOxYAsc684qcWbvuBCiyuJOQXo+VOQuY7AJSP4wplSah2PW7FXB5HzBIJTjF0IKG9YW1HuBvrD9e4E9Iddfj3SL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OH+Qgj+t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3B2kVHX1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OH+Qgj+t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3B2kVHX1"
Date: Tue, 19 May 2026 16:42:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779201777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMGlyrCBop3la0imMgYJeakA2V0whVzG/+pLGAlldu8=;
	b=OH+Qgj+tzCHqtO+cprnzOIC4l4VI6aeYCO5YXg4tv8XLtgRrzbBKmzIgaxPNqQ67DC2/21
	IeyERJwhSv4TCCjZHXnd88+eyhmLSnOO3vIOS7GfxIZ3hG4zfmdAJa++f9wqGI+bbxN6pv
	SB4Z37YA4jUmWwgNHkwr2zmMv9LHTQfwfe29oHnvLZt0M1IqRMqJi07XNMPtpMP72aTKby
	KYoQ4utgevUG+o03QCXw1uW9MXA02ljj9N4gAF/P7HJ1nQ/X2T+H7vkn9xqztLuB699/JD
	jIPbNTQnyD1KWSZc682vV9RR2dApXmLWBbezCchY/2QhYQ5YGZCo++c+dPr4ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779201777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMGlyrCBop3la0imMgYJeakA2V0whVzG/+pLGAlldu8=;
	b=3B2kVHX1Tw0rd+7jn56ZQDjP9WpyGeprzdwvSyiyokdmGpVza++UDyU4p1CHwUUy1ZP0Gr
	9uGwBCTd22SA/IAA==
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
Message-ID: <v3trqljork46ao3haew4abeky4q5ghjhf2uvkttpptlqgn46ht@kmgbgv6h7qqj>
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
 <20260508-rpi-otp-driver-v4-2-cf8d725d8821@linutronix.de>
 <20260519110041-2d8d92c2-d265-43d1-848f-bf9231a106c8@linutronix.de>
 <bv4vwmkkjh23lahkrupwclqs7il4vxqeknalgqn52k3wc6ztsg@z5ukn774brtg>
 <20260519123911-0a9ca1dc-7fee-425f-ba0f-e86368596e55@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519123911-0a9ca1dc-7fee-425f-ba0f-e86368596e55@linutronix.de>

On Tue, May 19, 2026 at 12:47:31PM +0200, Thomas Weißschuh wrote:
> On Tue, May 19, 2026 at 12:20:14PM +0200, Gregor Herburger wrote:
> > On Tue, May 19, 2026 at 11:14:28AM +0200, Thomas Weißschuh wrote:
> > > On Fri, May 08, 2026 at 04:42:45PM +0200, Gregor Herburger wrote:
> > > > +config NVMEM_RASPBERRYPI_OTP
> > > > +	tristate "Raspberry Pi OTP support"
> > > > +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
> > > 
> > > The '&& !RASPBERRYPI_FIRMWARE' clause looks weird, is it really necessary?
> > 
> > Yes it does looks weird but I think it is necessary. Without this it would be
> > possible to build RASPBERRYPI_FIRMWARE=m and NVMEM_RASPBERRYPI_OTP=y which
> > results in linker errors.
> 
> Fair enough. I would prefer the solution below, though.
> It would cleanly solve the issues also for other (future) drivers.
> 
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
> index 17595a96e90b..0efd479ffced 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -188,7 +188,7 @@ struct rpi_otp_driver_data {
>         int size;
>  };
>  
> -#if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
> +#if IS_REACHABLE(CONFIG_RASPBERRYPI_FIRMWARE)
>  int rpi_firmware_property(struct rpi_firmware *fw,
>                           u32 tag, void *data, size_t len);
>  int rpi_firmware_property_list(struct rpi_firmware *fw,
> 
> (...)
> 
Yes this should work. Will change it in the next version.

> > > > +static int rpi_otp_read(void *context, unsigned int offset, void *buf, size_t bytes)
> > > > +{
> > > > +	struct rpi_otp_priv *priv = context;
> > > > +	struct rpi_otp_header *fwbuf;
> > > > +	u32 count;
> > > > +	int ret;
> > > > +
> > > > +	if (!IS_ALIGNED(offset, 4) || !IS_ALIGNED(bytes, 4))
> > > > +		return -EINVAL;
> > > 
> > > Isn't this already enforced by the nvmem core?
> > 
> > Only for sysfs access through bin_attr_nvmem_read/bin_attr_nvmem_write. But
> > there is an in-kernel API nvmem_device_read/nvmem_device_write which does not
> > have alignment checks. So I added the check to be more defensive here.
> 
> The other drivers don't seem to check this explicitly. It looks like an
> accident waiting to happen.

Indeed, I will have a look at nvmem core and see if I can find a proper solution
for this.

Gregor
