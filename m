Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD049233131;
	Mon,  9 Dec 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760922; cv=none; b=kG4XeouWJsxylklYKyGNcGmcyGqF/j1Gj83v05mVfzvqGmv/mS9nyPkpIFylCRA6F0hjNoYCgyKws32nLuQUdwWcEsKL6vkFqDMJw12TBYANob/dxz20QNxJloUIihwFIwkUekIP2VFm3mBttrcSunQJmQIjY76o0yXVuWXDCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760922; c=relaxed/simple;
	bh=/Jxmin0WMSDkwTD01xsxrZ8uovoPnaZG01fKLhFI/VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWx/G7o66NnaNZ4xQrMc0poTu8kIbQXJsIKOLkx0fYagUX6Snhd/HyfDeG5FOUtjV1DbJ/1YcOvc5Qb6hCdhzmiBiGFzVe5856Vd/byGj7sGZoGBtdeOclPcp+FS7C9TFUks7bUiTPCY/Ox1ksPJ/6siANRbGHm4GyqICA6ZgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UwN/nAXd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UwN/nAXd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jhuAePAZ8ZQ2jPG7JG2KWJmbb/vDD1kvHPakjiEM5uk=; b=UwN/nAXdCbg5hTnPExU+Z7mgLx
	SbL6GdW45VGT2qd8kBufCqrskyGXUAPznVedKM/Nix9MQKqUo8jM1R4t/QacwQNaahHbLwFAMd4Q/
	oxoHwri9w986EdBfksTcBcYCVs6huLVOG0Ruq3+otfivHXk5tORU1pcn8jTKcVFwHHd0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKgPR-00Fgw5-QG; Mon, 09 Dec 2024 17:14:57 +0100
Date: Mon, 9 Dec 2024 17:14:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Felipe Balbi <balbi@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>,
	Hari Nagalla <hnagalla@ti.com>, linux@ew.tq-group.com
Subject: Re: [PATCH v2 5/5] arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and
 MBa62xx carrier board Device Trees
Message-ID: <a2a2f201-73a4-4a99-baef-0d593a88c872@lunn.ch>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <95ff66ca2c89f69d893c2ce9eed9a0c677633c7b.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
 <c902a56cf34838f60cee67624bb923e91d74e9e0.camel@ew.tq-group.com>
 <d25b1447-c28b-4998-b238-92672434dc28@lunn.ch>
 <e16076d16349e929af82fa987a658bff1d9804c4.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16076d16349e929af82fa987a658bff1d9804c4.camel@ew.tq-group.com>

> Not our board, but the AM62 SoC. From the datasheet:
> 
> "TXC is delayed internally before being driven to the RGMII[x]_TXC pin. This
> internal delay is always enabled." So enabling the TX delay on the PHY side
> would result in a double delay.

phy-mode describes the board. If the board does not have extra long
clock lines, phy-mode should be rgmii-id.

The fact the MAC is doing something which no other MAC does should be
hidden away in the MAC driver, as much as possible.

The MAC driver should return -EINVAL with phy-mode rgmii, or
rmgii-rxid, because the MAC driver is physically incapable of being
used on a board which has extra long TX clock lines, which 'rmgii' or
rgmii-rxid would indicate.

Since the MAC driver is forcing the TX delay, it needs to take the
value returned from of_get_phy_mode() and mask out the TX bit before
passing it to the PHY.

Now, it could be that history has got in the way. There are boards out
there which have broken DT but work. Fixing the MAC driver to do the
correct thing will break those boards. Vendors with low quality code
which works, but not really.

~/linux/arch/arm64/boot/dts/ti$ grep rgmii k3-am625-*
k3-am625-beagleplay.dts:	phy-mode = "rgmii-rxid";
k3-am625-sk.dts:	phy-mode = "rgmii-rxid";

Yep, these two have broken DT, they don't describe the board
correctly.

O.K. Can we fix this for you board? Yes, i think we can. If you take
rmgii-rxid, aka PHY_INTERFACE_MODE_RGMII_RXID, and mask out the TX,
you still get PHY_INTERFACE_MODE_RGMII_RXID. If you take rgmii-id,
a.k.a. PHY_INTERFACE_MODE_RGMII_ID and mask out the TX, you get
PHY_INTERFACE_MODE_RGMII_RXID, which is what you want.

Please produce a patch to the MAC driver, explaining the horrible mess
the vendor made, and how this fixes it, but should also not break
other boards.

> No such defaults exist in the DP83867 driver. If any rgmii-*id mode is used, the
> corresponding delays *must* be specified in the DTB:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/phy/dp83867.c#n532

That is bad, different to pretty every other PHY driver :-(

If you want, you could patch this driver as well, make it default to
2ns if delays are asked for.

    Andrew

---
pw-bot: cr
