Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A9139579;
	Mon,  9 Dec 2024 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762165; cv=none; b=phsAoHFuNdsmk0rZ4LmFNyUceAD+vv99v7M3MOx4Vk0mFq/c7rspI7JfpxFB1w6JOmcx/IsGw8ihHBaswrpKosLYALIl+LmiNREjapMt9Vhf/e+a2sXBQCRNt/RgelgkWzmfTzTIypkM1m8DXcscWlm/xZtJ8HLnoGyBeqx5ghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762165; c=relaxed/simple;
	bh=NYlPI26e2HRDl4GwsB53oLUmpFK8NP4TWK/1Pfvt9kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI/7BRsvBEJd9l+9oleqR2S+pZqBY+0o5EuJ+3xdHgxk0o6M35AvdmPJb7uUKm4XkT8iXhDoauvv6/sdR5AmKFPIvtFg7al02UMOhLuzWRrVpJTRE/7nMKr8qYOxMvCC0GlgiT2SjBHziMT+g1vqx3l6qYla4kuqzRt84msszYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pR1U65lX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pR1U65lX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8U5tytWB8jdTsBEP80ajIb2iAzJeX3cQD0jCPv4mRhY=; b=pR1U65lXh+gULXxoVbxUmjRMTg
	IaO8ybI+roY8bQmY7Kvi6CfXfzHAR4U8rod0j/KCAhNs2QDSgiGDMrQuyBfNmVKZTktWAPzYThk79
	nCqeF4Oh768TW3ErNVa4LLSjrePI+TavuFE0bgUS7lCacke6tf7FHBlbeakub7tK8dIEftPKYeVJn
	8DAQFQc7nMN3ZhkoNb23G/mOKlTcMcJVjWkjlrPVxt+4ur4sju0Scf1ydRZ+gz9Mf/7NyQDnNCOea
	yyRpPJ7Wj/kEs6SrdHPhc0TFp9Yp0THsH9Ub0pLvc1B7ONfVFmHSz+IivnuBBcxm4EezyCR8U5s8y
	ENmtf4BA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45626)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tKgjY-00017C-0l;
	Mon, 09 Dec 2024 16:35:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tKgjU-00026q-0x;
	Mon, 09 Dec 2024 16:35:40 +0000
Date: Mon, 9 Dec 2024 16:35:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
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
Message-ID: <Z1ccXClgTg5Guq6R@shell.armlinux.org.uk>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <95ff66ca2c89f69d893c2ce9eed9a0c677633c7b.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
 <c902a56cf34838f60cee67624bb923e91d74e9e0.camel@ew.tq-group.com>
 <d25b1447-c28b-4998-b238-92672434dc28@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d25b1447-c28b-4998-b238-92672434dc28@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 09, 2024 at 03:42:52PM +0100, Andrew Lunn wrote:
> I also find a lot of developers don't really understand what phy-mode
> and PHY_INTERFACE_MODE_RGMII_* actually mean.

... which is why we documented it in Documentation/networking/phy.rst,
but it seems folk who run into RGMII stuff don't read that document.

I'm wondering if we can come up with some kernel-doc compatible way to
document them in linux/phy.h instead, which may stand an improved
chance of being read?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
