Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224313CA97;
	Fri, 24 Jan 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737730603; cv=none; b=a16MERLGhN6Q88FTBrJIhCVYro3Y1AoEN9TcvNAwQ19WJYc2KElpwm++BqtCMPeDCylif33YlRkPpgLzrfLFPkAUfuwEpiEIcUnN68sHZvaqZ04euGFhZDfvaGiua7aok/x3JNzcAJwANkSfcL58JX8H5bxjfms0do8A5hLA1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737730603; c=relaxed/simple;
	bh=Yjbyq6ifIYb5MG0SmTH26q7S6EHuu8cYd/CzuEG6/vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlsNayqjt+ANYmbD2LKWpS0vC/nsxOZ9F22M/YNh0PN6AhbjSXtOasxIhuLPikk2qwfa2YT9Qx2tPKCO6dXUCrViRr1eDSop5ggKGERWpuKesVBnBfFmQhBSwZQOMpEQZYJ47PGJRr3A+/pzTTxCUxargJR3irFA5lBs5f7cilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4gfHYnQe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4gfHYnQe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J5kjHkJnOHEQs5ufwKsC59GIKFl8SpG5yJzGjmGDr5w=; b=4gfHYnQetFNudQQ+w0vRAFchfg
	Y4EJjpeJ/W5BT2yO0YcIuG4oKRxO0hO6s3EWVekqKFoQ89SXc6yD20w6pJZxVGHBhEjdVLJLt3/cv
	Fi/9fQU0C5QsxoPygdVzEqlZx+xOAqg9qkI9e8HomDOlVKUbQkCBD0bGSdx/h+8x1k3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tbL6Y-007cTY-5X; Fri, 24 Jan 2025 15:56:18 +0100
Date: Fri, 24 Jan 2025 15:56:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Willie Thai <wthai@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, kees@kernel.org,
	tony.luck@intel.com, gpiccoli@igalia.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, openbmc@lists.ozlabs.org,
	leohu@nvidia.com, tingkaic@nvidia.com, dkodihalli@nvidia.com,
	wthai <wthai@willie-obmc-builder.nvidia.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add device tree for Nvidia's GB200NVL
 BMC
Message-ID: <7b47725f-fb57-454c-82f6-859202060243@lunn.ch>
References: <20250124051819.7714-1-wthai@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124051819.7714-1-wthai@nvidia.com>

On Fri, Jan 24, 2025 at 05:18:19AM +0000, Willie Thai wrote:
> From: wthai <wthai@willie-obmc-builder.nvidia.com>
> 
> The GB200NVL BMC is an Aspeed Ast2600 based BMC
> for Nvidia Blackwell GB200NVL platform.
> 
> Signed-off-by: wthai <wthai@nvidia.com>

I'm not sure that is a valid name for a Signed-off-by. I would expect
something like:

Signed-off-by: Willie Thai <wthai@nvidia.com>

> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	phy-mode = "rgmii-rxid";
> +	max-speed = <1000>;
> +	phy-handle = <&ethphy3>;
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};

This phy-mode is wrong. There is a long discussion about this, started
from a BMC submitted by IBM. Please wait until Aspeed fix the MAC
driver before adding support for RGMII based ethernet. You are
probably innocent here, apart from failing to sanity check vendor
advise, which happens to be wrong.

https://lore.kernel.org/netdev/20250107162350.1281165-10-ninad@linux.ibm.com/T/
https://lore.kernel.org/linux-arm-kernel/bebbba7b-f86e-4dc4-8253-65d34cb84804@linux.ibm.com/T/

The max-speed parameter should also be unneeded. Unless you have a
real need for it. Does this MAC/PHY combination support higher speeds,
but they are broken for some reason, so you need to avoid them?

	Andrew
