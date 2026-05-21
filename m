Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E63E171C;
	Thu, 21 May 2026 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373963; cv=none; b=MQNVCFrd075LWhSG4AsUcmD25SwiRkCwWp/M2stnfg/ME3bYSti3iBAWDvMrGc2fntLf5HW8vhLS5u7v2In2Ch6AauzAaARk4fuXtWQsuASpdk3Hp7LpLmK8tQNRygnNk5cdrmgRbNMPQgFdePquPS13vhl7RijtfeG5m47U+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373963; c=relaxed/simple;
	bh=lcLm5shxn7oNMITQENSHFP+DlvwOnmQLMezoIM28jdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUMQS2YaLWfmXLbyNyz9Lwak4NQfFmTPPP9ot0yO0jZx1M5P6iVnArwNVdf3BFr8XomeMieg+Pmce1Eo6LuK+Xrr9gNBYWeWU9sjEf27Cke6N20CVsQCozhYr3J1467kLJSP2CTQRJ8/ca2CGpFbm/9/qsFo1bLTFGYxRM+nGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lSMj5lBX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kaHE5VX3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lSMj5lBX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kaHE5VX3"
Date: Thu, 21 May 2026 16:32:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779373960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVPrZCD+coHGpNa0YIBuPsQX/qkRW6hAr9QMIdvd5Xw=;
	b=lSMj5lBXBIp3M8gIdnnq/1uQEZ0Mf52/hkfA9o4DW3umiPSjka+xZh5gb8SboPn6x6Lkf6
	x2fEqaApnRcLJ+p0hqdnFQq8TgsI3xg+vFm6TRGfCm7NrTFBhqvHF1DxA7QhYuigoTm0pC
	bYrrNbnDY0fwcMwZroDEC/ScwqTl9PEdAd1YecWdleM6otntMxTUCw7J3jggKM3hQvzpQ6
	b7zAfYqZuegxpMbMA2+3B6zoIJa499KeP9bmgBCHPam+rnzvkpb8YXWyCsvIo5uaCkOfJH
	1QuzGkQzfHQUcRoiNU1BXQCjlZ14IIEkFlH5Kojr+iVqBXG9DL30pPRh05kHKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779373960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVPrZCD+coHGpNa0YIBuPsQX/qkRW6hAr9QMIdvd5Xw=;
	b=kaHE5VX3I6PELgMgGQXQb65vmYnq1tflZkIqVHQ+vQe7t4TMdg7qjYQvuQBJKGVYZk21+L
	d4kfp1ZaLZeijtDg==
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
Subject: Re: [PATCH v5 2/8] nvmem: core: Enforce stride and alignment checks
 for nvmem_device functions
Message-ID: <20260521163223-0b54b648-5272-43ad-a837-cc5364484b6a@linutronix.de>
References: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
 <20260520-rpi-otp-driver-v5-2-b26e5908eeac@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-rpi-otp-driver-v5-2-b26e5908eeac@linutronix.de>

On Wed, May 20, 2026 at 04:27:54PM +0200, Gregor Herburger wrote:
> The stride and word_size attributes in the nvmem_config struct are
> currently only used when reading/writing through sysfs functions
> bin_attr_nvmem_read/bin_attr_nvmem_write and in the nvmem_cell api.
> Reads and writes with nvmem_device_write/nvmem_device_read still allow
> unaligned access.
> 
> Add a check to these functions to enforce word_size and stride_length
> aligned reads and writes.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  drivers/nvmem/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

(...)
