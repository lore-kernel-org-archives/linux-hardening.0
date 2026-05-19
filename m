Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7E369D4C;
	Tue, 19 May 2026 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187655; cv=none; b=OC3MNTVy2OVAPo0HWHfDxHoYUJH6px5xTGHlrazrp9dmVjJDvPTHZmslXDogzRgB7914YnZALg0RxttoPtAxNm/Y4BSoryvQXEKLTzx+qdwffJIYR6I1jQogEiBsudlVqjITlQP3u/nUEv3ECO7EkdyZX2Au2HQbWSAtt4Nnxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187655; c=relaxed/simple;
	bh=bHuCXdXGKvP3ESmHoK7oobj/L5KctrrlFKOD+MgU75o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up0rO6SlTFWIoO/xn0qUSzycNQyCMCSz0IFRFuJUB8V6rIgiOzNlXjLUApp+nMOaBatDhOk7JQldnn05XYcsaikIAc9WRZUUMJFwyq1fJfIdC+FZwZbFA17OPR2fIl85WQzSQNCAT6VY1RTHNxOqGjfzXI147nDdlEdcomqv2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m6AO7vZZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pkxjd7DE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m6AO7vZZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pkxjd7DE"
Date: Tue, 19 May 2026 12:47:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779187652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q60EfCLUFk1gJm09+b3WgWO/cMVpTuRFJqZCCOqpfo=;
	b=m6AO7vZZtNrhhMS7oB+nSYNhvnRo4YGUzkvcYZBFvgQSWM4GZAkjOlhyuJTuQfpc8Zb0h3
	W3Ntgv6nrQ7Use4om4pl1x+hUD+ie/3ebBQ0HMmLPLlV/3hMaO9bKcEkHk7JC0WsXyknzR
	rwQC2CnwuJ4tMthsfhZqbuYuIWQHNTuT0u4PH9WE18ZWIFx7U+J2wUfLeQxeEFyQrDDoRH
	QMZwBuTxDUjPqFAYPt2hYMS9CKrFcGcs56d7nK1Q3ecZKJMadapfyk2KdaOqhi9e311mBt
	R4oBQSaV2L+YMS12WQ69JNb1nDz5tlZu4/S9MAMQWVgLGqIvrtpkn6QgUk0fTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779187652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q60EfCLUFk1gJm09+b3WgWO/cMVpTuRFJqZCCOqpfo=;
	b=pkxjd7DEZvG2Mj5JYHckMljpwLSQC7PwA+bYyrymWtkO3HY8YI66M9viu2Axqy7lauHjNh
	4zvQIwkGikLNqEDA==
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
Subject: Re: [PATCH v4 2/5] nvmem: Add the Raspberry Pi OTP driver
Message-ID: <20260519123911-0a9ca1dc-7fee-425f-ba0f-e86368596e55@linutronix.de>
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
 <20260508-rpi-otp-driver-v4-2-cf8d725d8821@linutronix.de>
 <20260519110041-2d8d92c2-d265-43d1-848f-bf9231a106c8@linutronix.de>
 <bv4vwmkkjh23lahkrupwclqs7il4vxqeknalgqn52k3wc6ztsg@z5ukn774brtg>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bv4vwmkkjh23lahkrupwclqs7il4vxqeknalgqn52k3wc6ztsg@z5ukn774brtg>

On Tue, May 19, 2026 at 12:20:14PM +0200, Gregor Herburger wrote:
> On Tue, May 19, 2026 at 11:14:28AM +0200, Thomas Weißschuh wrote:
> > On Fri, May 08, 2026 at 04:42:45PM +0200, Gregor Herburger wrote:
> > > +config NVMEM_RASPBERRYPI_OTP
> > > +	tristate "Raspberry Pi OTP support"
> > > +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
> > 
> > The '&& !RASPBERRYPI_FIRMWARE' clause looks weird, is it really necessary?
> 
> Yes it does looks weird but I think it is necessary. Without this it would be
> possible to build RASPBERRYPI_FIRMWARE=m and NVMEM_RASPBERRYPI_OTP=y which
> results in linker errors.

Fair enough. I would prefer the solution below, though.
It would cleanly solve the issues also for other (future) drivers.

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 17595a96e90b..0efd479ffced 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -188,7 +188,7 @@ struct rpi_otp_driver_data {
        int size;
 };
 
-#if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
+#if IS_REACHABLE(CONFIG_RASPBERRYPI_FIRMWARE)
 int rpi_firmware_property(struct rpi_firmware *fw,
                          u32 tag, void *data, size_t len);
 int rpi_firmware_property_list(struct rpi_firmware *fw,

(...)

> > > +static int rpi_otp_read(void *context, unsigned int offset, void *buf, size_t bytes)
> > > +{
> > > +	struct rpi_otp_priv *priv = context;
> > > +	struct rpi_otp_header *fwbuf;
> > > +	u32 count;
> > > +	int ret;
> > > +
> > > +	if (!IS_ALIGNED(offset, 4) || !IS_ALIGNED(bytes, 4))
> > > +		return -EINVAL;
> > 
> > Isn't this already enforced by the nvmem core?
> 
> Only for sysfs access through bin_attr_nvmem_read/bin_attr_nvmem_write. But
> there is an in-kernel API nvmem_device_read/nvmem_device_write which does not
> have alignment checks. So I added the check to be more defensive here.

The other drivers don't seem to check this explicitly. It looks like an
accident waiting to happen.

(...)


Thomas
