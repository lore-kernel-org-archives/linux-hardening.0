Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C51BC9FE;
	Mon,  4 Nov 2024 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731165; cv=none; b=bYAccXl1HL53i5GstnWeIIgGh4mvCVoG9ott/9YJKUC2eLNgoPMctTipcsdBhgafr4eJETHB3zzqG3A5ieup/YD5djx/ZJp+lkVCN+FHRTL2jA2mllffeKCv7RfNk2YCinFiPd+bqBRgU4q1ZW5G+ft+4Hd7hn37pZdTmMySg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731165; c=relaxed/simple;
	bh=uuNW8QkqgnaDeBYjYCEj/zDRiaDiB3NGiL194aT02nA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=sOe3qccXf6kBI+IbQvFUrTTZ6C+epx8SMc5nL31zb57rlIw9KT/sh0PHHMQ6dGczCB9NdZZ4Jt00doUp7/1WEV9GXdHy5v/6C7gaxCvLgiAS88XQS5oNB2QinJmQx3oStD7LC6Dj3vEN8Aue/hBeckSawh2MTp0izdArHg/pKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRn/+vtb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRn/+vtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B03C4CED1;
	Mon,  4 Nov 2024 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730731165;
	bh=uuNW8QkqgnaDeBYjYCEj/zDRiaDiB3NGiL194aT02nA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cRn/+vtbSTam1Cs8Yl9oy23CvCJS08Zp0BZeig6G3nUi2Sm3Zl1DNOYMI+4ktZPVU
	 eT930TVQMEqK5Z4NG2OCjLFwh5S3Q7K7cpKWRFeKa+KhZc+KYE7ruVB8f+A1YQex3W
	 8G/qtAUPzZ9vLE63kJaYqThzf7mUqdGbIO4nRLCSOjNV7nZXteyaQWALOQOH0nF4YK
	 0LvPU5O5h23KF8+dR30UxrV7llNQNvdCfOpM4mvCDoDHs++qWBA4Yx+n5bWMr++b19
	 HVbS5pvttFfD2tlHSHnEHMbsxzU9kX2lCn7+N8t8icqFPq6EbjfZD8+JHurPSuurqM
	 a//QVvoJooYzw==
Date: Mon, 04 Nov 2024 08:39:23 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Tero Kristo <kristo@kernel.org>, linux-usb@vger.kernel.org, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
 Felipe Balbi <balbi@kernel.org>, Hari Nagalla <hnagalla@ti.com>, 
 linux@ew.tq-group.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Nishanth Menon <nm@ti.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
Message-Id: <173072771143.3690742.7100697196468196200.robh@kernel.org>
Subject: Re: [PATCH 0/5] TQ-Systems TQMa62xx SoM and MBa62xx board


On Mon, 04 Nov 2024 10:47:23 +0100, Matthias Schiffer wrote:
> This adds Device Trees for out AM62x-based SoM TQMa62xx and its
> reference carrier board MBa62xx.
> 
> Two of the patches are adapted from the TI vendor repo ti-linux-kernel to
> add RemoteProc/RPMsg support for the R5F core. A similar patch has been
> submitted for mainline by TI themselves for the closely related AM62A SoC.
> 
> Not yet included are overlays to enable LVDS display output and MIPI-CSI
> camera input.
> 
> Devarsh Thakkar (1):
>   arm64: dts: ti: k3-am62: Add DM R5 ranges in cbass
> 
> Hari Nagalla (1):
>   arm64: dts: ti: k3-am62-wakeup: Add R5F device node
> 
> Matthias Schiffer (3):
>   dt-bindings: usb: dwc3: Allow connector in USB controller node
>   dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM
>     family and carrier board
>   arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and MBa62xx carrier board
>     Device Trees
> 
>  .../devicetree/bindings/arm/ti/k3.yaml        |   7 +
>  .../devicetree/bindings/usb/snps,dwc3.yaml    |   6 +
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |  24 +
>  arch/arm64/boot/dts/ti/k3-am62.dtsi           |   8 +-
>  .../boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts | 917 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi | 346 +++++++
>  7 files changed, 1307 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi
> 
> --
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y ti/k3-am625-tqma62xx-mba62xx.dtb' for cover.1730299760.git.matthias.schiffer@ew.tq-group.com:

arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dtb: syscon@43000000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#





