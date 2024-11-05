Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B151D14E3;
	Tue,  5 Nov 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803240; cv=none; b=NuZKmgvvZ/VXRhTt5aIgUU5Xu5iDehpe/2J6E5L+LM6OItCP7JqFYMifmPpeYJd7Ulxa15fq/jx6RVPSv9UdR+azUrF/bo1HMafBxkJNH7+36yCz8bAAT21/eb3oDVQ2QFwu95nZTlERAmJOKuMQt6UEgL+Uz+4JJYB0hA1KzUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803240; c=relaxed/simple;
	bh=ZeGJ32onS1PAytPMeWyffNKx42P4Y5ebI72qKCfQPwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oF6Y8yozPkRjUp0wdn8hS/5BwhDBqgVaA5p3sQ5obY9sY2JxR8kiFzGP9M71lMrojhU9rIWI/qXGnLjV0fZB9+EUlGQTxYSkzfh/7C5wsnFHjAYkFgpKi4XMg3ZNAyHstncDiTGQ6Ym90KE9nLMvrN69JdQenT4aC4Klp/EC1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=XDRTuwYl; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=f3iygS1G reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="XDRTuwYl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f3iygS1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730803237; x=1762339237;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=HnhOcDqM62BM39XeYtBpS6hPjPuyhp80jJ6lENbc2lQ=;
  b=XDRTuwYly0+xQ1keRhstg8Q+kyJL1bCPp5L16H+3VTrt1+sFKm7ETqkv
   D3IFdmkXXDKHxmVkObXL1if3Bh1R4uPf/mF4r+TyeHCiVWpfbD16zz20H
   E1s5neF9pYZD+a2FhNqIjwIFZ+hujVxiN4sLadVi68y4zN32ifXWLoIKC
   8gjeEP9fm5a5Jt/fSfbGdjrF9tpLpu3CI1bjvmsiJCSFNGme77bKjzi//
   fBni5qdH/IiFLJYjUVuzBruk5q9tqJlrfoumtWilo9xNBsqKfzjFc1v9N
   +rDFl2g/xrSyL5mRiXaLpLdI5krsZIA+84eFigbuctGsIdP8sRP3blOCE
   w==;
X-CSE-ConnectionGUID: AIkgqKuXSf2GqGYxRnWDAw==
X-CSE-MsgGUID: vkGBDWlmR2O3XtYPq2HK6g==
X-IronPort-AV: E=Sophos;i="6.11,259,1725314400"; 
   d="scan'208";a="39855291"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Nov 2024 11:40:28 +0100
X-CheckPoint: {6729F61B-23-5736D786-D50827BE}
X-MAIL-CPID: 51C17FF78442E03FAB7181DB78149BC6_2
X-Control-Analysis: str=0001.0A682F22.6729F61C.004F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62129161302;
	Tue,  5 Nov 2024 11:40:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730803223;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HnhOcDqM62BM39XeYtBpS6hPjPuyhp80jJ6lENbc2lQ=;
	b=f3iygS1GUJvasDTnbGPHuttJdMX/2lqYoS/6+vCQ3Th8WLd+VqtaZU/BSlaJ4s76JNRSAd
	4AVJQzH467QFo8Vhb1O3Q5/0cXAPTZQXXN2QGfFk+aPT4ZCQgrqnmFE5SCCLwBv+oBHMKu
	6ZgBPDlVNnTJG/RauHtIV6h7Hw7SFQBOFzIV31ro/lK61PgD3/x09ma3pA4vqtLyhubA/2
	2ooJNAQpQUUkFORsFBckki5hutdrOo+0Zx488XI3HBHwWXZEsiofyFfZjFVGy6zF8DrFQT
	bDsPF6dlPkdL//VXddmybEYk1ZSkiApd7QJAaMaD1mH6DRCGsI8wYfXoTAgp/w==
Message-ID: <c73cac598788ccabd1791b1232e8fd9d7ce23ac6.camel@ew.tq-group.com>
Subject: Re: [PATCH 2/5] dt-bindings: arm: ti: Add compatible for
 AM625-based TQMa62xx SOM family and carrier board
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Conor Dooley <conor@kernel.org>
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
Date: Tue, 05 Nov 2024 11:40:20 +0100
In-Reply-To: <20241104-floral-dexterous-7d3fee2ff616@spud>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
	 <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>
	 <20241104-floral-dexterous-7d3fee2ff616@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 2024-11-04 at 18:47 +0000, Conor Dooley wrote:
> On Mon, Nov 04, 2024 at 10:47:25AM +0100, Matthias Schiffer wrote:
> > The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
> > the matching reference/starterkit carrier board.
>=20
> Why all the wildcards? Why isn't there a compatible per device in the
> family?

For the compatible string we've chosen the TQMa6254 as the representative f=
or the TQMa62xx family.

MBa62xx is the proper name of the baseboard; this board can be combined wit=
h any TQMa62xx family
SOM.

Best,
Matthias



>=20
> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documen=
tation/devicetree/bindings/arm/ti/k3.yaml
> > index b0be02f9d1253..d8b52b95fba7b 100644
> > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > @@ -73,6 +73,13 @@ properties:
> >            - const: toradex,verdin-am62          # Verdin AM62 Module
> >            - const: ti,am625
> > =20
> > +      - description: K3 AM625 SoC on TQ-Systems TQMa62xx SoM
> > +        items:
> > +          - enum:
> > +              - tq,am625-tqma6254-mba62xx # MBa62xx base board
> > +          - const: tq,am625-tqma6254
> > +          - const: ti,am625
> > +
> >        - description: K3 AM642 SoC
> >          items:
> >            - enum:
> > --=20
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > https://www.tq-group.com/
> >=20
> Achtung externe E-Mail:=C2=A0=C3=96ffnen Sie Anh=C3=A4nge und Links nur, =
wenn Sie wissen, dass diese aus einer sicheren Quelle stammen und sicher si=
nd. Leiten Sie die E-Mail im Zweifelsfall zur Pr=C3=BCfung an den IT-Helpde=
sk weiter.
>   Attention external email:=C2=A0Open attachments and links only if you k=
now that they are from a secure source and are safe. In doubt forward the e=
mail to the IT-Helpdesk to check it.
>=20
> =C2=A0

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
