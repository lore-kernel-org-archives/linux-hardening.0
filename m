Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B741EA7C6
	for <linux-hardening@vger.kernel.org>; Sun, 14 Sep 2025 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757883203; cv=none; b=C82XAXzHNczmkThQJNiNZApDcgEUyRD2FTAK74d2OQXmRwMUfSnrxitWed1xKCuow7yzhSZ2kLi0UTFuXYRxUD5bPmFBxMQivvhJ+bqOLyLNd9peHv1e72FN+MdDZFV8Rj6baXb2L2kHqhMPcprw2cVLOCWclJ9Np3eltcxqG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757883203; c=relaxed/simple;
	bh=xMtyFKIcpinnUryn4EKaEXMJ+emW0yEgzYvM2cw4cKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh7aVcJIrBwTGMrI9GW9joE5/9/NAh2Z0n37BCCjfvW7KrtuqqEE92ZfC8qqFilAzDOD12S99vdt9TO6bRz9aHXHioE8iB8kR9ZQ0/m4JELSrtVJZrLN7xLvi8LsRxpUOeo24JH5nVygd19DjagwBJn96Tc1RDx7HqxbRzOtdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fEdHXYk9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fEdHXYk9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 485A61A0DE4;
	Sun, 14 Sep 2025 20:53:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 163506063F;
	Sun, 14 Sep 2025 20:53:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCCBC102F2A78;
	Sun, 14 Sep 2025 22:53:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757883198; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iYzXZ3Wfu3kuz+opj/Qn7fQ4dEnCR2b0EnW78bmdoVg=;
	b=fEdHXYk9/shQBBHSAcAU5UL56PKn4RwI53fRAxvx9FTkaiMzizZJ+xZuueBrHCUV0+xFNk
	w9hAIIUK0XgzIJt8VKLiJzWg8tGp057ag1Z2RebXjnG9gjv0xVZku/FSVT4NmPd1Vxye4A
	80Zrpv1NzhtGEfHWXYmgILI715PDbQkVhPaghzuCnlAeg/ZQuyPZxOOEtTuOKY0vUopznZ
	Qnip/lEUVi6VeuGJJWHfQiy3DzTVYdnxK1wbtatabWDEUgbjOQ7St8wsVxMM1Cmbt9cVab
	9w5uO5J2Sy1Z+RSRM6/stzE7NoFwqsgpYNiWg12eytxBA3RF35PALnIYM8BGnQ==
Date: Sun, 14 Sep 2025 22:53:12 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jorge Marques <jorge.marques@analog.com>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, gastmaier@gmail.com,
	linux-hardening@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 0/2] Add ADI I3C Controller
Message-ID: <175788312841.382502.16653824321627644225.b4-ty@bootlin.com>
References: <20250827-adi-i3c-master-v9-0-04413925abe1@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-adi-i3c-master-v9-0-04413925abe1@analog.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 27 Aug 2025 15:51:57 +0200, Jorge Marques wrote:
> I3C Controller is subset of the I3C-basic specification to interface
> peripherals through I3C and I2C. The controller RTL is FPGA
> synthesizable and documentation is provided at
> https://analogdevicesinc.github.io/hdl/library/i3c_controller
> 
> The main target for the I3C Controller IP is low-cost FPGAs.
> In this version the driver supports IBI (only the MDB), I3C and I2C
> transfers.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: i3c: Add adi-i3c-master
      https://git.kernel.org/i3c/c/646bc816e071
[2/2] i3c: master: Add driver for Analog Devices I3C Controller IP
      https://git.kernel.org/i3c/c/63cae74bea7c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
