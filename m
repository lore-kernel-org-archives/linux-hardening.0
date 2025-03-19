Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9820D516;
	Wed, 19 Mar 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381170; cv=none; b=emozhNIyIw6uiDif979zAHD6fJOuQPyzyJuPEZPkuM+jW8ulxiAO1moES2gRWsANZPxBo4AHRAStq43QYHu7xU5V/4lwaDBmAKnUchjL9KApmHh9hpLa6yWKB27msK45te4azUa7xgBgbdYg+FW4Isq15CuDAYLzAsaRboDaD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381170; c=relaxed/simple;
	bh=wdzbIG89ILmfdRfnET9Mz/54vv7kkqUfjyTq7a9Bg1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/KB6d8AkT02Cx1zZkqRGuM/W/3+CCKknsoYmLMFUuLGrmHxPvvmsn+UzpKHB2x6WtWg1mkbAsNoTn41BAgk3y+NrUpbh3nQSUaALb+lYyn9qF2YJnOk1Ps0cO5txrBb/rgPOnXgXzvX35M1+UnMkC9heo6/z+NqE/Bjh5NtghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=eojFYqSu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=BZ8UaIc4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eojFYqSu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="BZ8UaIc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1742381163; x=1773917163;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0xp8wZXae5VanysmSaTD4UwbCcT2o03h21ZLo1WcA20=;
  b=eojFYqSuJD2cWrg1gI88GDk1kJ6BbRmTG//wO0jrU35nO2L1soqwH+Ea
   keUTSV/Pu4zo3PYfrirSxrWrlu45tJmr/dDA0UNboLzH/SWFlb9/QIxsf
   W/kHCHzII0z7bHguBJxfhuFzN6KUj4W752bDYtv6o+3eusFWVoh6jzhSU
   uLnN8LeOeB82FiGBRV3/yclMYm7moY68z5Thz79wC89kHyOBF3MNZz42g
   580j8G0+2SEe+qqTP+8AbTf1LaF119CWO9D8mgJCqCCK8N8yXig3xH4xd
   3NHcplfR0iNpDaYHGKOMq+cjE3i47xTv38IDOc8nvEqj0GuAGn726iNwp
   A==;
X-CSE-ConnectionGUID: n4PRbILrSsGE8eU7TLjslg==
X-CSE-MsgGUID: aqLRDqtmTYCviUseDgPqXw==
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="43043019"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Mar 2025 11:45:59 +0100
X-CheckPoint: {67DAA067-6-7141A0B0-E6EDEC14}
X-MAIL-CPID: EC45CA4B4EB15768664355E4B2B4000F_3
X-Control-Analysis: str=0001.0A006377.67DAA05D.0079,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4DF8C1609D8;
	Wed, 19 Mar 2025 11:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1742381154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xp8wZXae5VanysmSaTD4UwbCcT2o03h21ZLo1WcA20=;
	b=BZ8UaIc4rW62iANkjv4y+02NULdJxO4IRwZ4rbF7c7WmHf+n63Bxqh4uH9ppGL+AfxAXKA
	wrvl8zaUx37mzY1TNvUN+SghpXZnyqlvbYmlMUbOkjZNfnI9kp2Ro8hflLB1trlKUz+aZd
	snV9IgsiDXw3jTUR0ZWRM2FozRxN8xBOHOPrWWW0dWuR2IBRfIx3+EDHAsDYtSuMv/IfgI
	+dpRzcoc02RxmwS2kmDcH7bKqbES6xO9pAOR3+eFC0cw3OMLOnlGRtJayd2tfbGadoqwbx
	+DDaH9Bjv272T1UVxJvGE+eD8miYo48momsoNaHzXIi4H3KImosrWzLLsEta+Q==
Message-ID: <e6ee878f655c31473bca54e4187d9006a19158b1.camel@ew.tq-group.com>
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
Date: Wed, 19 Mar 2025 11:45:51 +0100
In-Reply-To: <2953e10c-0a57-4d49-b831-3864a07eefd5@lunn.ch>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
	 <95ff66ca2c89f69d893c2ce9eed9a0c677633c7b.1733737487.git.matthias.schiffer@ew.tq-group.com>
	 <a9c5cfda-e3e3-436a-8d05-b2f096157cfe@lunn.ch>
	 <c902a56cf34838f60cee67624bb923e91d74e9e0.camel@ew.tq-group.com>
	 <d25b1447-c28b-4998-b238-92672434dc28@lunn.ch>
	 <e16076d16349e929af82fa987a658bff1d9804c4.camel@ew.tq-group.com>
	 <a2a2f201-73a4-4a99-baef-0d593a88c872@lunn.ch>
	 <309052f3f69950fe43390505cc7254aee8c8f5c6.camel@ew.tq-group.com>
	 <2953e10c-0a57-4d49-b831-3864a07eefd5@lunn.ch>
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

On Tue, 2024-12-10 at 20:54 +0100, Andrew Lunn wrote:
>=20
> On Tue, Dec 10, 2024 at 10:56:41AM +0100, Matthias Schiffer wrote:
> > On Mon, 2024-12-09 at 17:14 +0100, Andrew Lunn wrote:
> > >=20
> > > > Not our board, but the AM62 SoC. From the datasheet:
> > > >=20
> > > > "TXC is delayed internally before being driven to the RGMII[x]_TXC =
pin. This
> > > > internal delay is always enabled." So enabling the TX delay on the =
PHY side
> > > > would result in a double delay.
> > >=20
> > > phy-mode describes the board. If the board does not have extra long
> > > clock lines, phy-mode should be rgmii-id.
> > >=20
> > > The fact the MAC is doing something which no other MAC does should be
> > > hidden away in the MAC driver, as much as possible.
> >=20
> > Isn't it kind of a philosophical question whether a delay added by the =
SoC
> > integration is part of the MAC or not? One could also argue that the MA=
C IP core
> > is always the same, with some SoCs adding the delay and others not. (I =
don't
> > know if there are actually SoCs with the same IP core that don't add a =
delay;
> > I'm just not a big fan of hiding details in the driver that could easil=
y be
> > described by the Device Tree, thus making the driver more generic)
>=20
> It is more about, what does phy-mode =3D "rgmii"; mean? It means the
> board provides the delay via extra long clock lines. Except for when
> some random MAC driver has a completely different meaning, it is not
> documented it means something else, you have to read the sources and
> the mailing lists, to find out what this particularly MAC driver is
> doing for phy-mode =3D "rgmii".
>=20
> Do we really want that. Or should we define that phy-mode =3D "rgmii"
> means the PCB provides the delay. End of story, no exceptions. And
> that "rgmii-id" means the MAC/PHY pair need to provide the delay? End
> of story, no exceptions.


Hi Andrew,

I've just thought about this issue again. As mentioned, a number of MAC
drivers(*) implement what is described here:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/net/ethernet-controller.yaml?h=3Dv6.13#n=
77


That is, the delay is either added by the PHY or the MAC; having a delay on=
 the
PCB is simply not supported. Fixing MAC drivers to interpret the values wit=
hout
"id" to mean that there is a delay on the PCB will break existing Device Tr=
ees,
so that's no good.

As a first step, I'd update the docs to describe the intended behavior, but
mention that some drivers implement it wrong. The question is how to deal w=
ith
the wrong behavior going forward. I see the following options, but none spa=
rk
joy for me...

- Keep current driver behavior forever where fixing it would break existing
  Device Trees
- Deprecate all existing "rgmii*" values because of their inconsistent
  implementation, come up with new ones. Seems like a huge pain to add supp=
ort
  for in all MAC drivers and other code that deals with PHY modes...
- Introduce an additional DTS flag next to phy-mode to express that the
  phy-mode is supposed to be interpreted correctly

Do you have any suggestions?

Best,
Matthias



(*) At a glance, at least the following MAC drivers appear to configure a d=
elay,
making it impossible to support delays on the PCB with the current
implementation:
- renesas/ravb_main.c
- stmicro/stmmac/dwmac-* (some variants)
- ti/cpsw-phy-sel.c (incomplete; does not distinguish between RX and TX del=
ays)=20
- Some other MAC drivers check for specific PHY_INTERFACE_MODE_RGMII* value=
s,
  which also doesn't seem completely correct



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
