Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC2340A57;
	Tue, 19 May 2026 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182163; cv=none; b=pjLx4lDAA8z2elf8d53sgkyQzRhILSt3MeaQweW9knEv9LJAd0mDF+Uh5dN2NVBayl/xh+cAplYsAsj5OBRKQnugD2QYiU9cHZwN9DAFpSB3n1w7p+8Dfccypsl69HBRGu4LfJqxW3rLooiBv9y/aH1ZFKsV3ATibx6sTetcOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182163; c=relaxed/simple;
	bh=KMm8DNAQzAEDU5Xa5RqvnCwhHWRB6xux1RCWiauFkq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7dl9gBadDeSKhlJrt0MCGuHsy4FxzOOT5T1UsN9qlP2VZUheDarftZYjYWbxiDViykn4Eoxbhi7lr3mhaerSepIrougH+PLwJ8JKNffhLTwpvEdTLPnanYDmbu4vC0eTGV2/1XDGSzCpE9I20daiWRkgh52tirs14wy83OdYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xp1/BReS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yIp11LYZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xp1/BReS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yIp11LYZ"
Date: Tue, 19 May 2026 11:15:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779182160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UtwtBFwadYy1vJSe0JaB/O9Syh60kHZInyPQwvy3ZmA=;
	b=xp1/BReSXshfgEJKm5kPlcSVJkDtgtETCP+0c3Kmn4bIGZnwIg9r1hsCQNc6QVtYcoXi2j
	bIgllsCksIxNgYbT2+vmCsF835FYaSo48KztWaMrNdFxLZP7gE5RFiFHRSbyv6hpRb3lc/
	+6P1FbnfcYm/fP4p91ZBieEF8cLtNmn0WW4j+pcGa4IHy3w2D24ml77JVEYY3Ehn3wtqEH
	+L1dqiKA1Q40+tqnA3U5M8jdcjyVKW7gj588aeYxYNtsksBOFNPM3aalqjxu7l9eMuz2J+
	7GKN+rxFAvxAee8N1NW7JRxm5m/W2/9/XVAhnlI6LON5TAixIdsrw4tvNiDG3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779182160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UtwtBFwadYy1vJSe0JaB/O9Syh60kHZInyPQwvy3ZmA=;
	b=yIp11LYZiIbEZAcbUGs9WcfFD5GkhFJCvOQRO6X4R3go545uvAhqfRJHe0Kwg0PEe1lUnE
	0GaYAD3ikOxKlgAw==
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
Subject: Re: [PATCH v4 3/5] firmware: raspberrypi: register nvmem driver
Message-ID: <20260519111442-f1e6d418-9a92-4934-8a9c-c5f7827f853e@linutronix.de>
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
 <20260508-rpi-otp-driver-v4-3-cf8d725d8821@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-rpi-otp-driver-v4-3-cf8d725d8821@linutronix.de>

On Fri, May 08, 2026 at 04:42:46PM +0200, Gregor Herburger wrote:
> The Raspberry Pi firmware exposes two regions with otp registers. The
> first region called "customer otp" is available on all Raspberry Pi
> models. The second is only available on the Raspberry Pi 5 (bcm2712).

(...)

> @@ -327,12 +371,25 @@ static void rpi_firmware_remove(struct platform_device *pdev)
>  	rpi_hwmon = NULL;
>  	platform_device_unregister(rpi_clk);
>  	rpi_clk = NULL;
> +	platform_device_unregister(rpi_otp_customer);
> +	rpi_otp_customer = NULL;
> +	if (rpi_otp_private)

This check looks unnecessary.

> +		platform_device_unregister(rpi_otp_private);
> +
> +	rpi_otp_private = NULL;
>  
>  	rpi_firmware_put(fw);
>  }
