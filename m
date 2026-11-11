Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411055;
	b=bq4Yy02YG9g/o9adewNCXkz/nBBvl70N4iTCb3zQ9J3/AqsjtfwKTjkg/dl/xrDF8adC
	 WpNNGzdm1POt1DFCbV1Q1cvUPWzJjDf0MBV0mDkCv59sSSxBSXN7Z4ngXZ5DF9ca7EIAQ
	 94JeFVHPLeVU2KVnC8nPDnmtVTmE7stSIOF60IuYDuxQDvsOaNaGrWun9zKLlrxV5x9D/
	 sAtzTEKgmcGK8fgOFCGLzUFkOjZO6PIu6ybKHaDelOqRFw6ttSeZOm4B4vGzDi3o2r3Oj
	 GsZ1uvxFjsQyqFeWj/98ATarxPpq1Bx2L/MYcWNvQ06VvTZ6XbTujRg3pnknDvV2bFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411055;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2qK2aGIye1HX+d13MbJVaOFMfu42XDmA8K7eVHsgcko=;
	b=yVnoupEbtzGLMTR8F+UP6rgCOZsBtcR4ZPxBDfp0nTe/glQPtcyAC076vMIAHnRwiwlb
	 fiQoQC1yOblvDW2F8XF83OxSH17M6KdWUtIYh7QtAg5mVUCHRej+0hV9DgaBFQKGRS1eK
	 bLW20U9i3Un/O7OBFPmnD0TtGi7yhtEi/wAYNCAyVFNKNxNbbr/7Lk9jTk5+sbxRNlM6h
	 4nVoLiQ8zbt/nHFYgSVsxBdUuT4dAYhbBxRCxpauDkaxH+m+bqNRPRZEbXo+VEd6puT7h
	 T2P4wDEry7NWukW6O9ipFUz/bVoqHoIJHLlVuXK65KjBmhUGYCsrcfO7CpzjxJqm9IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZceZ+7Nr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C7606A321;
	Wed, 11 Nov 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZceZ+7Nr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161A11F00A05;
	Wed, 11 Nov 2026 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411055;
	bh=2qK2aGIye1HX+d13MbJVaOFMfu42XDmA8K7eVHsgcko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZceZ+7NrP14MGcOiFM03sWRRXENDOZXhRkrZ4/QNcwj0xgc1F2yz+EKuOVWVsLofE
	 u0OHQ8NXUqLQ7+yp1A6dFg68NjW6YMDNv3IeeCbWh5CiU1Tz9xHU5zG9U03lSQiORd
	 KJw2bdKFd96en/Ce4PI72efbnUG+P3uu9IrQO0ebQ0TQC1puayuZbQVxlDKOt0YmPF
	 MQnqVaIXvvxEWhqoeQyNCRlEN6SJVxpi65+6a65b+dsrtXNiXMStsIYpTIMxMXoo00
	 d8lX5ioZrmSNmSC0zdXs5BEYxoAz3VnWjm5ueWZPbzPUopJxulr4J++5L1VROtFWwk
	 i0z027nC4re2A==
Date: Wed, 11 Nov 2026 09:30:49 -0600
From: Rob Herring <robh@kernel.org>
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>,
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 00/12] nvmem: Add Raspberry Pi OTP nvmem driver
Message-ID: <20261111153049.GA2640564-robh@kernel.org>
References: <20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de>
 <66bf8629-225d-4f65-84dd-67f02aa4cab6@kernel.org>
 <y2ocj374gtrwf3ozptwgmqhsy5k26y45uwlbgtyvvmlxkftc2k@gjs3jsbxbm4w>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y2ocj374gtrwf3ozptwgmqhsy5k26y45uwlbgtyvvmlxkftc2k@gjs3jsbxbm4w>

On Wed, Nov 11, 2026 at 09:14:32AM +0100, Gregor Herburger wrote:
> On Wed, Nov 11, 2026 at 09:02:19AM +0100, Krzysztof Kozlowski wrote:
> > On 11/11/2026 08:23, Gregor Herburger wrote:
> > > Hi,
> > > 
> > > This series adds support for the Raspberry Pis OTP registers. The
> > > Raspberry Pi has one or more OTP regions. These registers are accessible
> > > through the firmware. Add a driver for it and add updates the devicetree
> > > for the Raspberry Pi 5.
> > > 
> > > ---
> > > Changes in v9:
> > > - Fix sashiko comment and use fwbuf->count instead of bytes in memcpy
> > > - Link to v8: https://patch.msgid.link/20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de
> > > 
> > 
> > Big series sent three times within last 24 h. Please slow down and give
> > people chance to review your work.
> I sent v7 with a missing commit and based on an wrong commit so Sashiko could
> not apply the series. Sashiko found an issue in v8 so I tried to fix it in v9.
> 
> I have the impression people are not reviewing stuff as long as sashiko has
> issues. So I wanted to fix those things quick.

Like many things, depends on the maintainer...

sashiko found something on every patch? I only look at the binding 
patches, so it is not going to matter to me if sashiko points out issues 
on driver patches. Vice-versa is probably true too.

Rob
