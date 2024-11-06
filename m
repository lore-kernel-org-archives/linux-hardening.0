Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623E1DF729;
	Wed,  6 Nov 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894608; cv=none; b=TDp4DX6Hs6eyRx0tqtNdalWKxX1YK15tH900o93nqputgfH4WbupLEJVtq1vCoph4tP0cflWLHcE4HcmCqASyBS3493osJoa4BAwOqT5IudjeDv7J2RLcg/3LPQCS1ylWsddOJJzBXj42KnqVPyrm3ibMVQuhHNl25q6eWVAOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894608; c=relaxed/simple;
	bh=1CWv4ZrN6M3umim2LLfIUNFU4R1eAAmA4QqWSrrVLmg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SuGF2FhNWJY8R6tSsNhGAsznvaYmadBY9rbqXBFWy8lZfVwctDibw6hqYrOw+B7Im5pFYznM7jRl2OYe0yLpvHdQi4/dMZWhAhagP+yzWYQ3yA9lR70lwMRoIAzxLJUw6SIRCfEWL5TL9ASt39VvOGS5NNY0JoXKE01gOKahutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=bYQgKP0q; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=MyqruMMC reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="bYQgKP0q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MyqruMMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730894604; x=1762430604;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1CWv4ZrN6M3umim2LLfIUNFU4R1eAAmA4QqWSrrVLmg=;
  b=bYQgKP0qqXFR/BphGxdLfRgBqqblcIO1/tcgESA+sKL7tD4CeyEVCLIQ
   CG7NefW3G9nH1Le6wqwpAtom32COZhM1YFWimJ4Deea2keAzNxV2MufD4
   0a+gQIThGNKfHJoVX8J3wY3u3MGEc3/qlnjC8OizcLL7OgOWpXpzAVSLw
   4pxdjx5bpyJ4bv2DtnDVnQQBqIN4eTNuP8NWkfnkiQQpqIkgyUh/x9fHR
   En55AdWMro1KYLlQloUCe9k6dHUacXUe5GN7HcVs69wZSmDN3dYi8pIbJ
   elBPgR4OJtryYO1pLTgNlg5uphX9BQOoWJB+Hov6k7OBKnGZ6gJG/FXfN
   g==;
X-CSE-ConnectionGUID: pieM1AbNRD6bZ+HIIGuvjQ==
X-CSE-MsgGUID: 1wL/Ebm/RdSAD34uMIIljQ==
X-IronPort-AV: E=Sophos;i="6.11,262,1725314400"; 
   d="scan'208";a="39884327"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 06 Nov 2024 13:03:15 +0100
X-CheckPoint: {672B5B03-9-F5DC7025-F79421CB}
X-MAIL-CPID: B8FDA72FF4EEA00CCDDAD8EBC4F3B464_0
X-Control-Analysis: str=0001.0A682F15.672B5B03.0084,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4631160A4D;
	Wed,  6 Nov 2024 13:03:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730894590;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1CWv4ZrN6M3umim2LLfIUNFU4R1eAAmA4QqWSrrVLmg=;
	b=MyqruMMCwaAn1/83WQVkFqBBlZ1w8xmo0WnnBSJnD7J4C0rko59siM7kzBf59ilTvHN9+G
	cV/4oFPHvjr3iBu/MQXsr4YrhXWnaQ1bFfQjN/aIGXgFF1ModNW+G9f+6XFw+YNrBXN+8a
	IUnleI+sDdPKmbFxR8KyOIcZwO7LoPZha5x2dpyDPlRB+1ebpk3j4U/s/o8zJ45zxSXuWi
	jupDOroZj1O1onje3FOuBTiYFIKbu2A8EbYxx62wKbGocRBVHD5gRrH3CpoyR1zeFED1MO
	t/5njui1invUIQxBVKECokbIZby+fzf4m8dQXmpucYI1MnMAvFLiV8d/falphw==
Message-ID: <7286141141fe4930cd2581dac7a1fb36a98e62c4.camel@ew.tq-group.com>
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
Date: Wed, 06 Nov 2024 13:03:08 +0100
In-Reply-To: <20241105-tinsmith-countable-fbb51045bc98@spud>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
	 <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>
	 <20241104-floral-dexterous-7d3fee2ff616@spud>
	 <c73cac598788ccabd1791b1232e8fd9d7ce23ac6.camel@ew.tq-group.com>
	 <20241105-tinsmith-countable-fbb51045bc98@spud>
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

On Tue, 2024-11-05 at 18:55 +0000, Conor Dooley wrote:
> On Tue, Nov 05, 2024 at 11:40:20AM +0100, Matthias Schiffer wrote:
> > On Mon, 2024-11-04 at 18:47 +0000, Conor Dooley wrote:
> > > On Mon, Nov 04, 2024 at 10:47:25AM +0100, Matthias Schiffer wrote:
> > > > The TQMa62xx is a SoM family with a pluggable connector. The MBa62x=
x is
> > > > the matching reference/starterkit carrier board.
> > >=20
> > > Why all the wildcards? Why isn't there a compatible per device in the
> > > family?

Because all variants use the same Device Tree. There is also only one compa=
tible and one (main) DTSI
for the AM62 SoC family, which our Device Trees are based on.

> >=20
> > For the compatible string we've chosen the TQMa6254 as the representati=
ve for the TQMa62xx family.
>=20
> And all the boards in the family are the exact same?

There is a single TQMa62xx PCB, which has some AM62 family SoC installed (A=
M6254 in the case of the
TQMa6254, but all AM62 are possible). TQMa62xx is also the name used for ma=
rketing when not talking
about a specific SoC variant:
https://www.tq-group.com/en/products/tq-embedded/arm-architecture/tqma62xx/

Some SoM variants with different RAM/eMMC/SPI-NOR/... do exist, but they do=
n't have separate device
trees (firmware may patch some variant information into the DTB however, li=
ke the correct RAM size).

Choosing one representative for the family including the SoC variant number=
, but not distinguishing
minor variants matches the level of detail used for our other SOMs already =
supported by mainline
Linux (like the TQMa64xxL and various i.MX-based platforms).

Best,
Matthias



>=20
> >=20
> > MBa62xx is the proper name of the baseboard; this board can be combined=
 with any TQMa62xx family
> > SOM.
>=20
> Then that one is fine.
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
