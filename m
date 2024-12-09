Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493C1BEF6E;
	Mon,  9 Dec 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755386; cv=none; b=bpWUIA8iX4f6JbMyBX/6W0oY6epVtxB0hLMm8IHuXw+ZAbkPhh9sKpilh7K4QkXGDw6/14yp6oftSbC3F08GpdEhp8f1CZubgZgpvXyYAEiuMXX9xdAF0fZfRaH85jVyg1YHrJaSVcSzt1VY2/F0ilfWoP8SM1LjEKwY2/f6EWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755386; c=relaxed/simple;
	bh=oAaN1GSj78zca2LyH1vVjyVyuzC5DSmrRJkeitGwMj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj2Gf945eK227h7tCyX1G3lPYOFEVvcqGSBATVYxnLj38/oWqDwZGGvBjFlzB5qQ9XX9FujOig8YrpXbM+MUTOYe0T9g2yy2vcYeI/8T4qoanKnXYze+fpruZboH+hsq7NQe/pIID3qWqqoX5KXwh0LoHcj7Nsp8FLrj1GbkCb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=I645VjK9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="I645VjK9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m16HeTv0L0CtuYH/B+yfB6+rKUcSgAg6Vxdkd5F26V4=; b=I645VjK9kvC67P7dLGOB/uZw3b
	Z59qZlJPd6n9JOP3MaUmCm1uVX9YCDOmrEvMN7HxwtbMmcu78/hwOo6KzU/vqSYgyPKfZwZ1nR1if
	dKPYNh9NyZoTYNr8pNjKZi+kA+T5QVf9o3bDGM593vNPHuO+p7tmg4+g5vrgJbo1oBYY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKeyK-00FgPR-5B; Mon, 09 Dec 2024 15:42:52 +0100
Date: Mon, 9 Dec 2024 15:42:52 +0100
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
Message-ID: <d25b1447-c28b-4998-b238-92672434dc28@lunn.ch>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <95ff66ca2c89f69d893c2ce9eed9a0c677633c7b.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
 <c902a56cf34838f60cee67624bb923e91d74e9e0.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c902a56cf34838f60cee67624bb923e91d74e9e0.camel@ew.tq-group.com>

On Mon, Dec 09, 2024 at 02:55:31PM +0100, Matthias Schiffer wrote:
> On Mon, 2024-12-09 at 14:24 +0100, Andrew Lunn wrote:
> > 
> > > +&cpsw_port1 {
> > > +	phy-mode = "rgmii-rxid";
> > > +	phy-handle = <&cpsw3g_phy0>;
> > > +};
> > > +
> > > +&cpsw_port2 {
> > > +	phy-mode = "rgmii-rxid";
> > > +	phy-handle = <&cpsw3g_phy3>;
> > > +};
> > 
> > rgmii-rxid is very odd.
> > 
> > > +
> > > +&cpsw3g_mdio {
> > > +	status = "okay";
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&main_mdio1_pins>;
> > > +
> > > +	cpsw3g_phy0: ethernet-phy@0 {
> > > +		compatible = "ethernet-phy-ieee802.3-c22";
> > > +		reg = <0x0>;
> > > +		reset-gpios = <&main_gpio1 11 GPIO_ACTIVE_LOW>;
> > > +		reset-assert-us = <1000>;
> > > +		reset-deassert-us = <1000>;
> > > +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> > 
> > I guess this is the explanation.
> > 
> > What happens when you use rgmii-id, and don't have this delay here?
> > That would be normal.
> > 
> > 	Andrew
> 
> 
> This is normal for AM62-based boards, see the DTSI of the TI reference
> starterkit for example:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi#n451
> 
> With rgmii-id, both ti,rx-internal-delay and ti,tx-internal-delay should be set.
> As ti,*-internal-delay sets the delay on the PHY side, phy-mode "rgmii" is the
> one that would not use either:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/ti,dp83867.yaml#n78
> 
> At the end of the day, does it really matter as long as MAC and PHY agree on the
> used mode? We copied this part of the hardware design from the TI reference
> board, and did our hardware qualification with these settings, so I think it
> makes sense to use the same phy-mode configuration.

What i try to achieve is every board uses the same configuration. The
PHY adds the delays, not the MAC. There are a few exceptions, because
a few cheap PHYs don't support delays, and so the MAC needs to add
them. But in general, any board i review, i always ask that the PHY
does the delay.

Also, don't put too much value in vendor code. Vendors don't care
about Linux has a whole, being uniform across all systems. Many
vendors do the minimum to get their stuff working, sometimes Monkeys
typing Shakespeare, and not a lot more.

I also find a lot of developers don't really understand what phy-mode
and PHY_INTERFACE_MODE_RGMII_* actually mean. phy-mode = 'rgmii' means
the board has extra long clock lines, so the MAC/PHY does not need to
add delays. rgmii-rxid means the board has an extra long rx clock
line, but a normal length tx clock line. Now, i doubt your board is
actually like this?

You want to correctly describe your hardware in DT, which i guess is
"rgmii-id". That means something, either the MAC or the PHY needs to
add delays. PHY_INTERFACE_MODE_RGMII_* is what is passed to the
PHY. To get it to add the 2ns delays, you pass
PHY_INTERFACE_MODE_RGMII_ID, and you should not need any additional
properties in DT, it should default to 2ns. If you need to tune the
delay, 2ns does not work, but you actually need 1.8ns etc, then you
can add additional parameters. But given you have
DP83867_RGMIIDCTL_2_00_NS, i doubt you need this.

	Andrew
