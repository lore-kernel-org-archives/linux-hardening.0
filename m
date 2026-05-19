Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647643A3E9F;
	Tue, 19 May 2026 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186093; cv=none; b=d0yj8M0ls2WTENqUYh65jcXFFyvYEcKWw+gyPIpoKlf6xJtsEuDA4Y2FlcEiz1Dwd/UwoQi6QwyThD8kJEuabqLMQyG6ubU96bQYtzT9Db7kPYBYwdnjtJWpJPlXlDsAfCQzi/s3QONJEyk7T2zT69OddYg4+0zCh0JrgHZF2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186093; c=relaxed/simple;
	bh=ARieLqJOGJ+upIdN9JtlIyH4THfTb9jSad7xZq+S1tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hopYHLF1EhwFOVOzhRUyimPh5FC5G8BnMAi8Ay9E5ETQ2hUbk/KsE9PrS+nkl8D9oaKSeBLrjkDuu8AJyPRt633pJdMgnVQeqzMd831whwUpOF1hlwXzW/ZseKP3zOCG30BkQ091y6HhY5ZyZNFcf87bnhen/P9ESVHvZWYZGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p7yTZpop; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rOprURbu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p7yTZpop";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rOprURbu"
Date: Tue, 19 May 2026 12:21:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779186090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4MkTPmyiSjKWeSibYiZlPl0g8Ut9Fvq2fUKdqqLp7M=;
	b=p7yTZpopgx8qnMg4xfVsSTSxF6ntf61gKVRBMVDrWWByYCjn9DbH0fEtWWzY6DyDF0CHqL
	y4g2myTR32tiSuF/sn7PERojYEiV9HUPR5zopjMHtx6jokqyq/yqaPyXvXZpLHpbbcyO7J
	QLdVOlc5fErj4vqz2vdFbVJCXblNIdF+zZ/m3OhI/QoZh+3Wp6k/TMY3SXT771ggVZ3fc3
	Gmw6MfsdlP6vyPNaDtVq0MMl79dJyO3tliSPAd9NwarbI/5R4TgRbt5GtYAZDDDm4HIFjy
	WNCgKKS37/VnD+G0JSy0AXBDcT3oU+9/fSvWdr/rwnOuQAUx1dfjCFxLlAV9Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779186090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4MkTPmyiSjKWeSibYiZlPl0g8Ut9Fvq2fUKdqqLp7M=;
	b=rOprURbuQNXUITboV4Vnp0PhwG+5hleZXLEpmvS+rTaOzBv6nAaYU6iVcmgDdc9Jhx3rn+
	npcpxFZO1dHEw1AQ==
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
Subject: Re: [PATCH v4 3/5] firmware: raspberrypi: register nvmem driver
Message-ID: <itr6h3qqjcv5k6mwfj5sgmwviusq2sni35qfkvrq4fu2dyqclx@z734js7deviq>
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
 <20260508-rpi-otp-driver-v4-3-cf8d725d8821@linutronix.de>
 <20260519111442-f1e6d418-9a92-4934-8a9c-c5f7827f853e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519111442-f1e6d418-9a92-4934-8a9c-c5f7827f853e@linutronix.de>

On Tue, May 19, 2026 at 11:15:59AM +0200, Thomas Weißschuh wrote:
> On Fri, May 08, 2026 at 04:42:46PM +0200, Gregor Herburger wrote:
> > The Raspberry Pi firmware exposes two regions with otp registers. The
> > first region called "customer otp" is available on all Raspberry Pi
> > models. The second is only available on the Raspberry Pi 5 (bcm2712).
> 
> (...)
> 
> > @@ -327,12 +371,25 @@ static void rpi_firmware_remove(struct platform_device *pdev)
> >  	rpi_hwmon = NULL;
> >  	platform_device_unregister(rpi_clk);
> >  	rpi_clk = NULL;
> > +	platform_device_unregister(rpi_otp_customer);
> > +	rpi_otp_customer = NULL;
> > +	if (rpi_otp_private)
> 
> This check looks unnecessary.

Looking at platform_device_unregister again it does not do anything when
rpi_otp_private is NULL so i will drop the if.

> 
> > +		platform_device_unregister(rpi_otp_private);
> > +
> > +	rpi_otp_private = NULL;
> >  
> >  	rpi_firmware_put(fw);
> >  }

Regards
Gregor
