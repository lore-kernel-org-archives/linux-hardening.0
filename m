Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D11A2392;
	Mon,  9 Dec 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752546; cv=none; b=Cqa1w3U3wCfpoKQC3Pjhitvd4N8C40ZosuK4fQrnEkSvTzvka05BsDEjKk9szAx07oSLJipQkg99kL0uy22qPPOOuuAMWJ4F2CztcVErZu4Q4FTpCT6xSBiJhoPOZHKQHjP5Rd86rUp5lspUurPmYqnAkRaG3evTUygafeFsTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752546; c=relaxed/simple;
	bh=YYFxratArxvKvbLXTcvgqbbnSqNSpdPcrQS/DK4T2sI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jy3hQGSnUDYp2njqCFNPLeXtkfDj27dK1DVvsqlyf4+3A3MOE3f8u6DZZdf0Eyy6WTYmxBCeQOWNzyQChKCPTZbmzFCJH2vl5uBObdpoK5XwkF15wafz2i8MRjTVFcqrVVR0fsJvQRoyWFQKKtC60QbhXiGkfqtKXyZpcJ67QqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=XSiFwoMr; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=QLvbfbmy reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="XSiFwoMr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QLvbfbmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1733752542; x=1765288542;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LteyrmhH69QEmehsyqX62nW+pV4+wAljWT6HLYaaBkI=;
  b=XSiFwoMrBh/GZPB5sin1Gxf2oVQg8z4traQL752UPJXBq1kuQM1JlIfm
   KHanbVT26JaMD5am0JgKWeoGy39pOvS9nueBEL1oeg79i9b7s2fXlnbZj
   /cf0hjqsfW+XV5vCof1+n7DTl6oY4Ru1hg7XVhcUcx6u9Z70NNzsQDu6R
   vQHehiThDa4g702kekcFj5wihKe6Ym0q6fiuYcKyAj+4ixQgMEb/rw5wl
   879TZ2l8DUjnF8JwqqmkxZxtQ2oVEKmPgk2lxn0tqRGeTDIubos5tUdIB
   KhgPNAa4QY7bzPpGlgyVer1gG+y2e3cwGoEJZJoAjNdlAz8c1vYNuIzWE
   g==;
X-CSE-ConnectionGUID: oY3/CPafQFaYj6kvAX6lGA==
X-CSE-MsgGUID: 64VLtlciSiyH8wjSMQSoGQ==
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="40488462"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 09 Dec 2024 14:55:38 +0100
X-CheckPoint: {6756F6DA-18-1B231F50-D910A4E3}
X-MAIL-CPID: 1819D895E6E3B5DBD34CC4AA263FD5E0_5
X-Control-Analysis: str=0001.0A682F1B.6756F6DA.00E2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20C6F166BCD;
	Mon,  9 Dec 2024 14:55:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1733752534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LteyrmhH69QEmehsyqX62nW+pV4+wAljWT6HLYaaBkI=;
	b=QLvbfbmy0PuIHr5aXue1xK8WW6edelWn8QmOxbYyObNboeFIyUcpHv+H+idnIZNdcwpw4D
	58LL1g/e5cxk6Bv2Pe9cKqfA/GWGGWvuUzfR5ouajVv136ABRijxQJtJ94o/kMGCHATg6i
	sqjc50OVIpDk8b7XRN1KWAzrrdsxKKp4RmiCoA/mb5PzVuua+Djfhy05CFd2Lm3QULBDv6
	fnvQM9Oj2CLqHE2KfpYCzQsIPOrJnJxFddZhITrTZrJ2dTQHTDAjPwJ7TzcYkPM04LTDoZ
	/zKyntbPnmhtGa8/BSx31byOgyUwtAN0dymRYLArJ6B79dpOx8SnPIlUvntJWw==
Message-ID: <c902a56cf34838f60cee67624bb923e91d74e9e0.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and
 MBa62xx carrier board Device Trees
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Felipe Balbi <balbi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, linux@ew.tq-group.com
Date: Mon, 09 Dec 2024 14:55:31 +0100
In-Reply-To: <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
	 <95ff66ca2c89f69d893c2ce9eed9a0c677633c7b.1733737487.git.matthias.schiffer@ew.tq-group.com>
	 <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 2024-12-09 at 14:24 +0100, Andrew Lunn wrote:
>=20
> > +&cpsw_port1 {
> > +	phy-mode =3D "rgmii-rxid";
> > +	phy-handle =3D <&cpsw3g_phy0>;
> > +};
> > +
> > +&cpsw_port2 {
> > +	phy-mode =3D "rgmii-rxid";
> > +	phy-handle =3D <&cpsw3g_phy3>;
> > +};
>=20
> rgmii-rxid is very odd.
>=20
> > +
> > +&cpsw3g_mdio {
> > +	status =3D "okay";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&main_mdio1_pins>;
> > +
> > +	cpsw3g_phy0: ethernet-phy@0 {
> > +		compatible =3D "ethernet-phy-ieee802.3-c22";
> > +		reg =3D <0x0>;
> > +		reset-gpios =3D <&main_gpio1 11 GPIO_ACTIVE_LOW>;
> > +		reset-assert-us =3D <1000>;
> > +		reset-deassert-us =3D <1000>;
> > +		ti,rx-internal-delay =3D <DP83867_RGMIIDCTL_2_00_NS>;
>=20
> I guess this is the explanation.
>=20
> What happens when you use rgmii-id, and don't have this delay here?
> That would be normal.
>=20
> 	Andrew


This is normal for AM62-based boards, see the DTSI of the TI reference
starterkit for example:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi#n451

With rgmii-id, both ti,rx-internal-delay and ti,tx-internal-delay should be=
 set.
As ti,*-internal-delay sets the delay on the PHY side, phy-mode "rgmii" is =
the
one that would not use either:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/net/ti,dp83867.yaml#n78

At the end of the day, does it really matter as long as MAC and PHY agree o=
n the
used mode? We copied this part of the hardware design from the TI reference
board, and did our hardware qualification with these settings, so I think i=
t
makes sense to use the same phy-mode configuration.

Best regards,
Matthias


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
