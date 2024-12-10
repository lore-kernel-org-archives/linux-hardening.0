Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD023ED59;
	Tue, 10 Dec 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860480; cv=none; b=hBmt2l57Dq+sIknsA5/P93OJlkBW3L/4GksKrcQ+nbpu+rd45P2jQDo6Ed5XOOmfLdKIM8Qt4CY7jokUsDbdTm6eFoPW4K8Vigw6afNlgyhMFarEt9eILPOM41BXJJUe/lbsup73ekpMCWiE64XatlmhO/Pe2TeaFzkqLWE6RhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860480; c=relaxed/simple;
	bh=4QD1jq7IN/UMgjwr2EzUkF3AbcDeXPhUr3d1bSOs3Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WglaaIIWV7usW2AxhuJHW6/OScHl/aq4ZyAr8kY2Ztetq/Z/rTkeP15oB6Qmeh1xwdtxrDMDXgfIW0uPn+av/a8kPP3ZGHb/ynsIn5Rvc+4PDLz1BAvndGm7bi+dj78w3VKrmzovGT9eOAdhMJq9KKRQNf0JYsBgjMpE711GND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cAsno5oY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cAsno5oY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qqR4+EDOTOKUygjAju/GpX8orxXt5neI5PHSlKTEs2U=; b=cAsno5oYRVseXjiVyM/UxIK07w
	qtwmVLePT9tyGDCOACnIbCo40y4bTizPr6kk63/9XWmj/J55i3q114gzkNk4xoRKYXmQOOdNnUIwd
	e0z5ZPxhUJZrzSP4ACjLwX4i6KMaSWHX+743h08HRYQNDmcTQeeK8YlV1y3hzlnQT+Iw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tL6JH-00FqUX-Bp; Tue, 10 Dec 2024 20:54:19 +0100
Date: Tue, 10 Dec 2024 20:54:19 +0100
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
Message-ID: <2953e10c-0a57-4d49-b831-3864a07eefd5@lunn.ch>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <95ff66ca2c89f69d893c2ce9eed9a0c677633c7b.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
 <c902a56cf34838f60cee67624bb923e91d74e9e0.camel@ew.tq-group.com>
 <d25b1447-c28b-4998-b238-92672434dc28@lunn.ch>
 <e16076d16349e929af82fa987a658bff1d9804c4.camel@ew.tq-group.com>
 <a2a2f201-73a4-4a99-baef-0d593a88c872@lunn.ch>
 <309052f3f69950fe43390505cc7254aee8c8f5c6.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309052f3f69950fe43390505cc7254aee8c8f5c6.camel@ew.tq-group.com>

On Tue, Dec 10, 2024 at 10:56:41AM +0100, Matthias Schiffer wrote:
> On Mon, 2024-12-09 at 17:14 +0100, Andrew Lunn wrote:
> > 
> > > Not our board, but the AM62 SoC. From the datasheet:
> > > 
> > > "TXC is delayed internally before being driven to the RGMII[x]_TXC pin. This
> > > internal delay is always enabled." So enabling the TX delay on the PHY side
> > > would result in a double delay.
> > 
> > phy-mode describes the board. If the board does not have extra long
> > clock lines, phy-mode should be rgmii-id.
> > 
> > The fact the MAC is doing something which no other MAC does should be
> > hidden away in the MAC driver, as much as possible.
> 
> Isn't it kind of a philosophical question whether a delay added by the SoC
> integration is part of the MAC or not? One could also argue that the MAC IP core
> is always the same, with some SoCs adding the delay and others not. (I don't
> know if there are actually SoCs with the same IP core that don't add a delay;
> I'm just not a big fan of hiding details in the driver that could easily be
> described by the Device Tree, thus making the driver more generic)

It is more about, what does phy-mode = "rgmii"; mean? It means the
board provides the delay via extra long clock lines. Except for when
some random MAC driver has a completely different meaning, it is not
documented it means something else, you have to read the sources and
the mailing lists, to find out what this particularly MAC driver is
doing for phy-mode = "rgmii".

Do we really want that. Or should we define that phy-mode = "rgmii"
means the PCB provides the delay. End of story, no exceptions. And
that "rgmii-id" means the MAC/PHY pair need to provide the delay? End
of story, no exceptions.

> > Since the MAC driver is forcing the TX delay, it needs to take the
> > value returned from of_get_phy_mode() and mask out the TX bit before
> > passing it to the PHY.
> 
> Hmm okay, this is what the similar ICSSG/PRUETH driver does. I've always found
> that solution to be particularly confusing, but if that's how it's supposed to
> work, I'll have to accept that.

It has to be that why. If the MAC does the delay, the MAC needs to
ensure the PHY does not do the delays and well, and it achieves that
by setting PHY_INTERFACE_MODE to indicate the PHY should not add
delays. Do you have a better idea how this can be done?

> In my opinion the documentation Documentation/networking/phy.rst is not very
> clear on this matter - the whole section "(RG)MII/electrical interface
> considerations" talks about whether the PHY inserts the delay or not, so my
> assumption was that phy-mode describes the PHY side of things and only that.
> 
> It gets even more confusing when taking into account
> Documentation/devicetree/bindings/net/ethernet-controller.yaml, which contains
> comments like "RGMII with internal RX delay provided by the PHY, the MAC should
> not add an RX delay in this case", which sounds like there are only the cases
> "delay is added by the PHY" and "delay is added by the MAC" - the case "delay is
> part of the board design, neither MAC nor PHY add it" doesn't even appear.

We have tried to improve the documentation. We have also been very
rigid in reviewing DT bindings, and what these things mean. But it
seems like many developers don't read reviews other developers get. Go
search the email archive. How many times have i had this very same
conversation?

Everybody gets pause wrong. Everybody gets EEE wrong. Everybody gets
RGMII delays wrong, not matter how many times we tell developers they
are getting it wrong.... phylink is helping with this, it takes it out
of developers hands so they cannot get pause or soon EEE wrong.

	Andrew
