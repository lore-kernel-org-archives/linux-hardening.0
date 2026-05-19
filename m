Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892593EA94B;
	Tue, 19 May 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204046; cv=none; b=hJC13ukCIsL01b+7kycyMRKw64uoUI763m9tTqdtX0eDlyjcQnrO+3eqkoUrDBk4U9QN6OBGSPCXf4v2uhSnXtQOQP/OgSc4cLYydq4ZMwVp2EnWDfR4wB5GvlbjBra+FzidGJSxlJPlrVGI46+d4SLvt4bYsG6ZRiKMSJKhzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204046; c=relaxed/simple;
	bh=tBPm4Mg7akPZPjyvzbuAx326K+smcN84KfUckzF51xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TptgOmUt5eC339tbioUoqfB/mkD4jfrHIWX4Vez/i1JJAfz1jJCBCthCqU77ptZvPJljvcjFwOlZrxSprPJJSTkXjTpWECcgOOYw22kx1RrxR5p/3eh2rw+Ljq6hOAySkGM0dm0gjme4xyj5I9siiiQH2ajnJNoc/sm/6auX1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zhxAd3Sj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRFjD/uf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zhxAd3Sj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRFjD/uf"
Date: Tue, 19 May 2026 17:20:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779204043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4stZwo5XtvjTeC6H9z4YtrqfpxDlrJABEAgk0JjJlg=;
	b=zhxAd3SjA66WDR0R93s6RvGfnx2/NwNYoxf6IHx6t67PARrmpq7CU7VVwf/E+FDFhSuN0c
	AQ+1jyQrzoA0k7OZilYptZBXFpTQoJBAD1A1H0+HaIgHeUGSBNzvZrxnvZ/TEKFMiMJLLI
	N4t8LaBZOZsjpJeW/zbNGkYsHcKaMeBwFdIGMkKcTs3i2370iPjdELM/E9nKNxhh8JO1if
	uwSi33V5s9Scw/T79kToAaXxJntUqkEu5BZE2A5hbWnyK93pO918bkapktPM/XPJns1AY8
	4n/88+kFy5o/BlTflyioRsY+cUm97ZFk9Sf94SqTLYfKz9sJGSwpdTs7U1+chQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779204043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4stZwo5XtvjTeC6H9z4YtrqfpxDlrJABEAgk0JjJlg=;
	b=dRFjD/uf/RFqJSChTWxlyaOf82lquqKJrUWh7i81J773hhcoaDQpTIsbmdGWAtbYtezZvJ
	M2MWyqVjCUnDeJBQ==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>, 
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/5] nvmem: Add Raspberry Pi OTP nvmem driver
Message-ID: <ppjkp4v4por5ot3ahmmhr5tz7mderm5ga7ttsop34ob4kbcqft@crydafv6wscb>
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
 <d9e3e10a-c346-4391-b133-4b60fbee5dc3@gmx.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e3e10a-c346-4391-b133-4b60fbee5dc3@gmx.net>

On Tue, May 19, 2026 at 04:55:10PM +0200, Stefan Wahren wrote:
> Hi Gregor,
> 
> Am 08.05.26 um 16:42 schrieb Gregor Herburger:
> > Hi,
> > 
> > This series adds support for the Raspberry Pis OTP registers. The
> > Raspberry Pi has one or more OTP regions. These registers are accessible
> > through the firmware. Add a driver for it and add updates the devicetree
> > for the Raspberry Pi 5.
> > 
> > ---
> > Changes in v4:
> > - Additional patch to drop unnecessary select schema
> > - fix dt-bindings
> > - use __counted_by_le
> > - additional alignment check in read/write callbacks
> > - Link to v3: https://patch.msgid.link/20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de
> > 
> > Changes in v3:
> > - dts: add "raspberrypi,bcm2835-firmware" as fallback and fix dt-bindings
> > - Fix Kconfig depends
> > - Changed firmware data fields to __le32
> > - Add MODULE_ALIAS
> > - Link to v2: https://patch.msgid.link/20260505-rpi-otp-driver-v2-0-e9176ec72837@linutronix.de
> > 
> > Changes in v2:
> > - register nvmem driver from firmware driver and drop firmware sub nodes
> > - Use struct_size and __counted_by for dynamic array
> > - Drop unneeded comment in Kconfig
> > - Use NVMEM_DEVID_NONE
> > - Use kzalloc
> > - Update module description
> > - Link to v1: https://patch.msgid.link/20260408-rpi-otp-driver-v1-0-e02d1dbe6008@linutronix.de
> > 
> > ---
> > Gregor Herburger (5):
> >        dt-bindings: raspberrypi,bcm2835-firmware: Add bcm2712-firmware compatible
> >        nvmem: Add the Raspberry Pi OTP driver
> >        firmware: raspberrypi: register nvmem driver
> >        arm64: dts: broadcom: bcm2712: add raspberrypi,bcm2712-firmware compatible
> >        dt-bindings: raspberrypi,bcm2835-firmware: Drop unnecessary select
> > 
> >   .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |  20 ++--
> >   .../boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi    |   4 +-
> >   drivers/firmware/raspberrypi.c                     |  59 +++++++++-
> >   drivers/nvmem/Kconfig                              |  10 ++
> >   drivers/nvmem/Makefile                             |   1 +
> >   drivers/nvmem/raspberrypi-otp.c                    | 130 +++++++++++++++++++++
> >   include/soc/bcm2835/raspberrypi-firmware.h         |  14 +++
> >   7 files changed, 224 insertions(+), 14 deletions(-)
> since you plan to submit a V5 of this series, could you please append
> another patch to enable the driver as module for arm64/defconfig?

Good Idea, will add it.

Gregor
