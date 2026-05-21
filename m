Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186913F2116;
	Thu, 21 May 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373939; cv=none; b=Ae8+08LKfmXKOjae1l3GczQOiVmikSNBUyTHKnYn/hKlNVfuKBYlWIztxt2hdZ3pVHWqK2EMKqbQz0CUbvS+XVw4mt8kSXqg1i6B6sifseJpvDccULaOWvIYBs+Tq5oEUmHdoC1uDAGfFqwSmQnY7BpIW6htK8fYy51FCOqvJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373939; c=relaxed/simple;
	bh=ryhB4k4KAlNY3S8c/7wdxuWk85d93gm4uAyYmd85oPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPk55g+l7mJjZOmE1cswLmyWt9BaVYZDRXEKNKZ5973tJuAGB93Sa7sMl1/AjFOlKPsQvGiULZXzyemrbjhEdemJwTudv2WupF2UxNyPB8EMnxMbwAq7Ab8JaaJSHeRKoTQNA5UWgD1lDlZaOvShIwIjOTlj1LgiZCZB/BNE760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KhQWixjb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CCJ0tBjj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KhQWixjb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CCJ0tBjj"
Date: Thu, 21 May 2026 16:32:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779373936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDLY933PN2EBuLR1r8PdU5Fwy1ql5S35WUEgFUMoOsI=;
	b=KhQWixjbyY2ShxL9WlbXHBdJ7WHF+ugTNis+GXU9J1N08E7I86+Wdv7CflXrZxKlzyoh9O
	a9+K5D3LrEtkmk/wAG6iTWtV41NkkH9bcyc9C6kkyDGuE5iXHDqd+LnO+E35fcBYEAQEMr
	spIyR0APkZlUbJYJxwwBtrAyIgDveX9hHbXzqOGTD8i9FdwGS/aZgTzSXty1b4Po5vFoXg
	Hm8gjzwW/PVry0Ig8RqddkRejk9A3b9/SmVhfZ6iEg/Jm1hnSAgho2HEZdWkECLi8+hGUH
	4pUK2wd9DzYZ9A5a8rZEN+g0Ng1irlP+DTILxemqR3IFy4LeH3p9osgCIuw6Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779373936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDLY933PN2EBuLR1r8PdU5Fwy1ql5S35WUEgFUMoOsI=;
	b=CCJ0tBjjgldKioatLTsKpYYgsMCkOEpPtyoYvjSFInZzfumqyvk/E2HeOWC+Jgo4Maafh2
	AN0w7dxy9OsvXSAg==
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
Subject: Re: [PATCH v5 1/8] soc: bcm2835: Use IS_REACHABLE for function
 declaration
Message-ID: <20260521163126-47047e2d-8f24-4f72-98c1-7c5081ea9871@linutronix.de>
References: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
 <20260520-rpi-otp-driver-v5-1-b26e5908eeac@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-rpi-otp-driver-v5-1-b26e5908eeac@linutronix.de>

On Wed, May 20, 2026 at 04:27:53PM +0200, Gregor Herburger wrote:
> The drivers that depend on the RASPBERRYPI_FIRMWARE use
> 
> 	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
> 
> This should ensure that the driver is not compiled in when
> RASPBERRYPI_FIRMWARE is 'm' on COMPILE_TEST which leads to linker
> errors.
> 
> The same can be achieved by using IS_REACHABLE in the
> raspberrypi-firmware header. This evaluates to false when invoked from
> built-in code. This way the Kconfig can be written as
> 
> 	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
> 
> Which is a more readable variant.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

(...)
