Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D423E35C;
	Wed, 12 Mar 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781532; cv=none; b=ls9JGgJMlocefJ2AXqFHOh8geJKTfxZKmRbay8yJUgB6TRNQ2EDosA5pQhvjGuyfNZXsAX/1VkpN88V0mFIvsMjlhiajhmSLWCuXejAA6/w/6cIHL+f9CfNPmwkcTpB22RTRMXYlpBeKU6IoPt7D1dwFJczhTzzPo8Qcqrl4UAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781532; c=relaxed/simple;
	bh=2EOtPyTaC3tCYAuHwDc55aHmCKlLBAh9pEzNhEEBOcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVnM9gR2G+QOi0ZxGCBlxbO5qAjoNctBvTmEU//MIks6DDxl5zU6oJXQJ95LQpsrrznR/uZtzfgyAxKEqGxXY2DbXqGYwTiLTJnJ0yZT7w4pYMGugtLOQvJAKWmCLEMZs/rgh46XzAE3hwNQZxgOK55v33oa9pv1sCjCai0DDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eMKAcuAn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eMKAcuAn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YuyUiiI7ZFuPPHGTzB32+a5/wwkD8Jfy7CZVbltjHtA=; b=eMKAcuAn2Tef46O2sREbd5JusY
	LdZ7uMoXii7OgFq2XCG/PvANlVkUthXXopVpdbVF4KS1LzveZh1HFUpIPonEMVHBAg344Ko/Mq8We
	I1yJauwZk1lslPLU35cn7dyV4rPgR19UmaU5x8cvODdxJrSF4CQFX4jok7x3mDI8j0u4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsKw8-004ebX-Q4; Wed, 12 Mar 2025 13:11:48 +0100
Date: Wed, 12 Mar 2025 13:11:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Willie Thai <wthai@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, kees@kernel.org,
	tony.luck@intel.com, gpiccoli@igalia.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, openbmc@lists.ozlabs.org,
	leohu@nvidia.com, tingkaic@nvidia.com, dkodihalli@nvidia.com,
	maryang@nvidia.com, pmenzel@molgen.mpg.de,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: aspeed: Add device tree for Nvidia's
 GB200NVL BMC
Message-ID: <9ccc845b-9392-4a37-8bca-4f54997126ce@lunn.ch>
References: <20250312045802.4115029-1-wthai@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312045802.4115029-1-wthai@nvidia.com>

> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy3>;
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};

Please read the discussion again. "rgmii" is probably equally wrong as
"rgmii-rxid" you had in v1.

Please talk with Aspeed and ask them the clean up the mess they made
with RGMII delays. Until that happens, adding this node should wait.

     Andrew
