Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29840233146;
	Mon,  9 Dec 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750691; cv=none; b=nNJAnqliakiSoybsu8wXlUxj3ZzWGF7AZQjTTSJjRXJjsJHs3fI2NhURhMrnScPzUa5rWmbJYuaTLsMiObnQhMkf1x/MZc6++XfW6RxfETcDVI8NFJH8j/EhDhq6UhY8/SNqAzMNQ4hpG2Z+NrUL0UNkMZN5tT5pZShrx3Ii6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750691; c=relaxed/simple;
	bh=NkhX649mCYlm7UTdk/xDLU53bUCSolAXgQE7UT4MYkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6LxJjNcfIu4enZMRr57j2Y1Gjj1vx9dg4onC8bwEtXdkJQZtkffg19/Fck5WgE1fKY3QqOQnb9546mXnpEed5mKwb+SS6ChAaxjHoApiwSXrEM4An5ct7k+7hrlhEppbaP0EzpMHJyFV3jifyZNqMJfH6loJxw0iJ1neUECGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Lea7Y9Yx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Lea7Y9Yx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=72S7Y0m68TBMZpKjMYQCWjvfm2dgENRCYqhWK6vxrak=; b=Lea7Y9YxXbamN6pcuB6gVBs3b1
	H7qlEJ7sripF744GpmuSDBQaAaaCeESaiMVUhZHbNzFvhejhDuyKpsAk3oIDOWdRIrGslWxXK0kej
	c+Omu7VKApsh9wOfv7iCEevSiwBvwvHtxql7ZkYoI2PV7HrR9fvaoHmnObZbkVKbWxmg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKdkb-00Ffga-6D; Mon, 09 Dec 2024 14:24:37 +0100
Date: Mon, 9 Dec 2024 14:24:37 +0100
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
Message-ID: <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <95ff66ca2c89f69d893c2ce9eed9a0c677633c7b.1733737487.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ff66ca2c89f69d893c2ce9eed9a0c677633c7b.1733737487.git.matthias.schiffer@ew.tq-group.com>

> +&cpsw_port1 {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&cpsw3g_phy0>;
> +};
> +
> +&cpsw_port2 {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&cpsw3g_phy3>;
> +};

rgmii-rxid is very odd.

> +
> +&cpsw3g_mdio {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mdio1_pins>;
> +
> +	cpsw3g_phy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x0>;
> +		reset-gpios = <&main_gpio1 11 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <1000>;
> +		reset-deassert-us = <1000>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;

I guess this is the explanation.

What happens when you use rgmii-id, and don't have this delay here?
That would be normal.

	Andrew
