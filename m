Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F08212D60;
	Tue, 10 Dec 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824622; cv=none; b=l6siaLlcQnGg+5BPHH8N0N4Bds9j/O3wzWhF9npphgYJcgNPs84CrM3MbCoO5Do6B5hCoxcT2aS8LwcwO7I4QrqinQ6MENH79991BmG+3FeT6qNUXC7wi/S/ZSWGWnbZLRk8SRTDzmOJWBtJkeMO92mEoGCneEs++4Dq1B9SzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824622; c=relaxed/simple;
	bh=/TeuGAbZ26vSbNhjubofgZnnehIACA5UrhaAhnM3RD8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHixMekA2jpfEkCj4ebb+6RQNnz3qHEoVfeuCx4P7IjDWCURbY4Wpo9c6jnJOrnj5rcZG3dfFLMdnh9Ull8Iac1SMS0F2CQtgK8vtfLIKJnLbn+qbBoqYDNPTjxrXyPpppiZV/VwsLOdw+XfOzjXvdalmjpy4JGtfalY/EOTpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=N9hfPxR3; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lLSEVIYs reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="N9hfPxR3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lLSEVIYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1733824619; x=1765360619;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LPh0yVGEQ9vWISI1i/TYH0JhPJ9KKecMDH0Xpu48hcc=;
  b=N9hfPxR3BBsqJFXfN5JzGh1juxmDc6mli1GCpsAP296F2BioSDc0LC4z
   IqUYDBHsM4HSKrozybuPIw83SLeTVE+ClyNomh/T1lMw2YIkRY/DXzLSy
   gKGLWyltYYwudf0x/jMLEjoWmZJ2QTfyGqqqLHDHfXKU0KNXgbdwPGKg3
   DqW5ujJyUXTVFT7V693G41TkwS14um9Amp9/NgMapTbwYQLHr3QlmOfCh
   rDaqMDPJWk/zUg5v/ZKMnjOTn4QnNwFnqPZmQXNZkFfb9iME4FzEFIRUs
   CWeGpiZ+JHtId+lvlGJUiN3GULZ0XNIOAC8m+6OOZhWJlIdkTa6eP874c
   Q==;
X-CSE-ConnectionGUID: L4jbIdFJRearAlIyQVVXcQ==
X-CSE-MsgGUID: pmEQQ7tuSc27gjXA3zX56g==
X-IronPort-AV: E=Sophos;i="6.12,222,1728943200"; 
   d="scan'208";a="40507636"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 10 Dec 2024 10:56:50 +0100
X-CheckPoint: {67581062-5-98002871-E6E29D66}
X-MAIL-CPID: 3E6B7F7F1FE94745951728CD9D1DD495_3
X-Control-Analysis: str=0001.0A682F1A.67581062.0054,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5BA3D167FF3;
	Tue, 10 Dec 2024 10:56:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1733824605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPh0yVGEQ9vWISI1i/TYH0JhPJ9KKecMDH0Xpu48hcc=;
	b=lLSEVIYs5+7Y+CXHWwxGjqyRow8kmqPCwwfsqJRbU0dGB3uPArrRjNJZIt8AQsDkjzL/s8
	GKke8uKjGNfjS2wkeVbymV+A15exlcdlbbXcWEYCAxm4iQAV3x5DUbCZqllq3Y6WQtzpWe
	ijW/PsTwD08MBNJc36SVETUAei4hL92vI2Wl/lfM9LJHE3CPe/8t1C9fQM/joAekRntcJG
	zkKg4f26O8tuJ7dZHeLkJBhKbkjt38lr98UbV6CvVJbrxfP4L77DjDqe6tWjYe4qARu9ot
	4+XqcHL6rmyYfckuo8ljhOet1+EiN43ItM5YUOXUWzWMrQyw/2q37MCyoyW8AA==
Message-ID: <309052f3f69950fe43390505cc7254aee8c8f5c6.camel@ew.tq-group.com>
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
Date: Tue, 10 Dec 2024 10:56:41 +0100
In-Reply-To: <a2a2f201-73a4-4a99-baef-0d593a88c872@lunn.ch>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
	 <95ff66ca2c89f69d893c2ce9eed9a0c677633c7b.1733737487.git.matthias.schiffer@ew.tq-group.com>
	 <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
	 <c902a56cf34838f60cee67624bb923e91d74e9e0.camel@ew.tq-group.com>
	 <d25b1447-c28b-4998-b238-92672434dc28@lunn.ch>
	 <e16076d16349e929af82fa987a658bff1d9804c4.camel@ew.tq-group.com>
	 <a2a2f201-73a4-4a99-baef-0d593a88c872@lunn.ch>
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

On Mon, 2024-12-09 at 17:14 +0100, Andrew Lunn wrote:
>=20
> > Not our board, but the AM62 SoC. From the datasheet:
> >=20
> > "TXC is delayed internally before being driven to the RGMII[x]_TXC pin.=
 This
> > internal delay is always enabled." So enabling the TX delay on the PHY =
side
> > would result in a double delay.
>=20
> phy-mode describes the board. If the board does not have extra long
> clock lines, phy-mode should be rgmii-id.
>=20
> The fact the MAC is doing something which no other MAC does should be
> hidden away in the MAC driver, as much as possible.

Isn't it kind of a philosophical question whether a delay added by the SoC
integration is part of the MAC or not? One could also argue that the MAC IP=
 core
is always the same, with some SoCs adding the delay and others not. (I don'=
t
know if there are actually SoCs with the same IP core that don't add a dela=
y;
I'm just not a big fan of hiding details in the driver that could easily be
described by the Device Tree, thus making the driver more generic)


>=20
> The MAC driver should return -EINVAL with phy-mode rgmii, or
> rmgii-rxid, because the MAC driver is physically incapable of being
> used on a board which has extra long TX clock lines, which 'rmgii' or
> rgmii-rxid would indicate.
>=20
> Since the MAC driver is forcing the TX delay, it needs to take the
> value returned from of_get_phy_mode() and mask out the TX bit before
> passing it to the PHY.

Hmm okay, this is what the similar ICSSG/PRUETH driver does. I've always fo=
und
that solution to be particularly confusing, but if that's how it's supposed=
 to
work, I'll have to accept that.

In my opinion the documentation Documentation/networking/phy.rst is not ver=
y
clear on this matter - the whole section "(RG)MII/electrical interface
considerations" talks about whether the PHY inserts the delay or not, so my
assumption was that phy-mode describes the PHY side of things and only that=
.

It gets even more confusing when taking into account
Documentation/devicetree/bindings/net/ethernet-controller.yaml, which conta=
ins
comments like "RGMII with internal RX delay provided by the PHY, the MAC sh=
ould
not add an RX delay in this case", which sounds like there are only the cas=
es
"delay is added by the PHY" and "delay is added by the MAC" - the case "del=
ay is
part of the board design, neither MAC nor PHY add it" doesn't even appear.

>=20
> Now, it could be that history has got in the way. There are boards out
> there which have broken DT but work. Fixing the MAC driver to do the
> correct thing will break those boards. Vendors with low quality code
> which works, but not really.
>=20
> ~/linux/arch/arm64/boot/dts/ti$ grep rgmii k3-am625-*
> k3-am625-beagleplay.dts:	phy-mode =3D "rgmii-rxid";
> k3-am625-sk.dts:	phy-mode =3D "rgmii-rxid";
>=20
> Yep, these two have broken DT, they don't describe the board
> correctly.
>=20
> O.K. Can we fix this for you board? Yes, i think we can. If you take
> rmgii-rxid, aka PHY_INTERFACE_MODE_RGMII_RXID, and mask out the TX,
> you still get PHY_INTERFACE_MODE_RGMII_RXID. If you take rgmii-id,
> a.k.a. PHY_INTERFACE_MODE_RGMII_ID and mask out the TX, you get
> PHY_INTERFACE_MODE_RGMII_RXID, which is what you want.
>=20
> Please produce a patch to the MAC driver, explaining the horrible mess
> the vendor made, and how this fixes it, but should also not break
> other boards.

I can make this change, but "am65-cpsw-nuss" currently supports 6 different
compatible strings, many of which are used for multiple SoC families.

Maybe someone from TI could chime in and say whether all of these have the =
fixed
TXC delay, or at least the current compatible strings are already specific
enough to tell whether the SoC adds a delay?


>=20
> > No such defaults exist in the DP83867 driver. If any rgmii-*id mode is =
used, the
> > corresponding delays *must* be specified in the DTB:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/net/phy/dp83867.c#n532
>=20
> That is bad, different to pretty every other PHY driver :-(
>=20
> If you want, you could patch this driver as well, make it default to
> 2ns if delays are asked for.

Makes sense, I'll write a patch for that as well.

Best regards,
Matthias


>=20
>     Andrew
>=20
> ---
> pw-bot: cr

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
