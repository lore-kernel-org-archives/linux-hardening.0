Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217561AD3E5;
	Wed, 19 Mar 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398821; cv=none; b=gbOt7J9OkPOkfWGj5/rTDvTF2QhDbOB8wGIyUeXJR+lcHjbSI0a281M1M2rPR6J4P67G9u4D9nBB1J0yINx6IKJD7YoT4LyzREL5CpLUdGsEDaRc+yxOeTFYhF1dV0uZfDvTbatdnlmTYHqb3Z51D4LGskQ0CSY9rPyHmP/g2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398821; c=relaxed/simple;
	bh=hZp8bKrhsM4SKX+Ce8UlGm3QMhSPZn+QWpNEU4QZwdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tagj15fVJ9rrbjerLdHq8Yw6qMrtN4uw4yuE/2JR1G5XG6yZ0SM60k0zNzu1hAPqB6rQr83SLVg889Pk7ljRZJomdlWk6CvD4GilpDkH+0zsSPdcenBT48w5WTx1CCFXUb+5ygglcAmv8xaX6WdoiLj90zFle5r/WBZqo4JRiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dYaZwAuK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dYaZwAuK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6odEtpsbLUs835q3V1F9htFlGcWFQ+wEDjb2L+ALX80=; b=dYaZwAuKzjhW3ZNTaXcIQCJ+k3
	iwLZzorpQDDaAyO/kmFL7XmMhmEGHfatWWzfcgfuXU/jGuELtOAuRpmVvjoc76qc1hdkeSLn7ifeg
	l+jurutCvlp6IFNR97ie6mCjgcxpu8WB7me7nKLDSciOcoK8FEmVSnyk2SCRBNVtf6dw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuvWP-006NhH-ND; Wed, 19 Mar 2025 16:39:57 +0100
Date: Wed, 19 Mar 2025 16:39:57 +0100
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
Message-ID: <c277cc6b-6624-44df-94ff-45b341859b62@lunn.ch>
References: <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
 <c902a56cf34838f60cee67624bb923e91d74e9e0.camel@ew.tq-group.com>
 <d25b1447-c28b-4998-b238-92672434dc28@lunn.ch>
 <e16076d16349e929af82fa987a658bff1d9804c4.camel@ew.tq-group.com>
 <a2a2f201-73a4-4a99-baef-0d593a88c872@lunn.ch>
 <309052f3f69950fe43390505cc7254aee8c8f5c6.camel@ew.tq-group.com>
 <2953e10c-0a57-4d49-b831-3864a07eefd5@lunn.ch>
 <e6ee878f655c31473bca54e4187d9006a19158b1.camel@ew.tq-group.com>
 <262ff436-2334-43bb-a998-ab48f06ea0e3@lunn.ch>
 <570d9c2a25b437ab75f14104b354027210809028.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570d9c2a25b437ab75f14104b354027210809028.camel@ew.tq-group.com>

> > > Fixing MAC drivers to interpret the values without
> > > "id" to mean that there is a delay on the PCB will break existing Device Trees,
> > > so that's no good.
> > 
> > You need to look at it broken driver by broken driver. I _think_ the
> > Aspeed case can be fixed. Others we need to look at the details. Maybe
> > in some cases we do need to add a warning to the device tree binding
> > the driver is FUBAR and has special, broken meaning for 'rgmii'.
> 
> I don't know about Aspeed (maybe you're mixing something up, or I'm not aware of
> something?) - in the case of the TI driver I'm dealing with, this is indeed
> possible to fix up because the MAC always adds a delay, it is not configurable.

The Aspeed driver also gets RGMII delays wrong. And there is an
ongoing discussion about how to fix it. The discussions there probably
apply to most drivers which get RGMII delays wrong. Following the
discussions on how RGMII is broken in other places might help you fix
the TI driver.

> The whole point of my suggestions is to allow fixing the drivers while staying
> compatible with old, broken Device Trees. If we could add a property 'phy-mode-
> is-fubar' to old Device Trees, we could just fix them instead - but we can only
> fix in-tree DTS, and it will only have an effect on systems that update their
> DTBs with their kernel, so I believe this simply isn't an option because of
> backwards compat guarantees for Device Trees.

So you need the TI driver to accept the broken 'rgmii', and the
correct 'rgmii-id'. You say the MAC hardware always adds the delay. So

1) Patch the driver to test for 'rgmii', and issues a warning that the
   DT is wrong and needs updating.

2) Add the missing masking of the value passed to the PHY. Since the
   MAC driver is adding the delays, it needs to modify the
   phy_interface_t passed to phy_connect(), masking out the delays the
   MAC is adding. This is an established procedure for MACs which
   implement the delays, rather than ask the PHY to do it. It then
   becomes possible to use the correct 'rgmii-id' value.

3) Patch the TI .dts files to use the correct rgmii-id. That makes the
   warnings added in 1) go away.

This is a lot simpler than the Aspeed case, but the basic discussion
taking place with the Aspeed driver would give you useful background.

	Andrew
