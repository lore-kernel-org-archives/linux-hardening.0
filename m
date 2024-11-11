Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495011714B2;
	Mon, 11 Nov 2024 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319157; cv=none; b=CngMn8Lki12hz5pTTbyMWuidUWFtAgWcwxnKqZpkI9u4RDpnPAqCEGUOWdV7R/UOgX13aKMZjveqleAxAkgV3JLhuWPDKRGo99G+coes0g+xRs+TzYlhuKBm1CLY2hKg6R4enXlbtwphmbEpkmaYx+TglTaVF37AiaAjk3rRjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319157; c=relaxed/simple;
	bh=oqchIAOV+ujAuuqGpj2VFndIG4Bf4mSoSDUOyVmgWy0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qFtpHfaZbJefGalnuc3qMxbyEb2JmSXdbuiyKxjygrgVWB62wx0Vt4PUAVuCdDjxOrOIIOcKJg3Ho5/pCkWi3DVZt/E7/AOJVq0YtJ5ALoaysVceBBX5ktKvJEKya56Ea29CZZKG38n40QmxT99zxqKRRyjX2RwS8sojJ5Fu1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=PuCA/Y8B; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=K2zNtide reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="PuCA/Y8B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="K2zNtide"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731319154; x=1762855154;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oqchIAOV+ujAuuqGpj2VFndIG4Bf4mSoSDUOyVmgWy0=;
  b=PuCA/Y8Boy6Je5SH6lPqNK7ey7Xc4gNXw5/M3mxRgFHUsqW47uRLF4Wm
   g5z8Sl4LQQRymaPXZKcQk53NXMGcZpq3bGyCNDgnnLYoNaKrjTXcLbH+k
   wd8nagAGQhrUyHAQCyDwS3BIF/Q6mFK54dQiwclVoRApW4MGdiHEnAA4q
   jAm1CuM6w+FT8jleelBxWAuduiC6mc2cDfpRIjt+ZSGfaimrmxc+1tO3X
   essB63JxJ6liRJvAONeQfWQ/XJTemih+2PSNxnJP7eyCNH6PTUazP2xt+
   gY9efh+LzfB16Xrfp2QEWkTafwAuA61jlPnVrzVNpa0GmcJJnvuGFbB25
   Q==;
X-CSE-ConnectionGUID: bLzZoMNiTlC78uJSz6rOag==
X-CSE-MsgGUID: fLtsWKQiRT+AHbmP2bbOBQ==
X-IronPort-AV: E=Sophos;i="6.12,144,1728943200"; 
   d="scan'208";a="39960460"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Nov 2024 10:59:04 +0100
X-CheckPoint: {6731D568-30-D31EDE1A-D52D6119}
X-MAIL-CPID: 072718E0F89994E832C944FEBBA3E4C7_5
X-Control-Analysis: str=0001.0A682F25.6731D569.005A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01EFA165700;
	Mon, 11 Nov 2024 10:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731319140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqchIAOV+ujAuuqGpj2VFndIG4Bf4mSoSDUOyVmgWy0=;
	b=K2zNtideaFnscstKqfITpwJxPHlZA+t9kTzTL9KSiI52w4VBrqmDKo1sX/5+uHpgJMPpGi
	/KJV7gskuxM30VoCmQSkQEA3Ou/4t3wdza8k8GL2qQVfyBFSVPuIASlfHaIhBve4siYqcu
	o8Fe86VdngGAsIuOIqMy+NWrg+Ycj0tCDAMplZP8KRMjXOooVjmxHPt4QLUQF4uGR4fW33
	Z0ycB9lqfIxhALVFWdHv6iNmmzcRKCGcSVEF89XxYZN35jJwpi+Wd/ExWPGdLjKRHfGagp
	d8XRWCbP7Zi94OJhOHMIgoXCtGZ8iWiyfwV53JxTFOQyARUUaJDOMbSWV9Qdgg==
Message-ID: <068c22af19c07a7c79bb4abb0366a2505b4b1aae.camel@ew.tq-group.com>
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
Date: Mon, 11 Nov 2024 10:58:57 +0100
In-Reply-To: <20241106-happy-anything-46f7293f6aca@spud>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
	 <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>
	 <20241104-floral-dexterous-7d3fee2ff616@spud>
	 <c73cac598788ccabd1791b1232e8fd9d7ce23ac6.camel@ew.tq-group.com>
	 <20241105-tinsmith-countable-fbb51045bc98@spud>
	 <7286141141fe4930cd2581dac7a1fb36a98e62c4.camel@ew.tq-group.com>
	 <20241106-happy-anything-46f7293f6aca@spud>
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

On Wed, 2024-11-06 at 16:40 +0000, Conor Dooley wrote:
> On Wed, Nov 06, 2024 at 01:03:08PM +0100, Matthias Schiffer wrote:
> > On Tue, 2024-11-05 at 18:55 +0000, Conor Dooley wrote:
> > > On Tue, Nov 05, 2024 at 11:40:20AM +0100, Matthias Schiffer wrote:
> > > > On Mon, 2024-11-04 at 18:47 +0000, Conor Dooley wrote:
> > > > > On Mon, Nov 04, 2024 at 10:47:25AM +0100, Matthias Schiffer wrote=
:
> > > > > > The TQMa62xx is a SoM family with a pluggable connector. The MB=
a62xx is
> > > > > > the matching reference/starterkit carrier board.
> > > > >=20
> > > > > Why all the wildcards? Why isn't there a compatible per device in=
 the
> > > > > family?
> >=20
> > Because all variants use the same Device Tree. There is also only one c=
ompatible and one (main) DTSI
> > for the AM62 SoC family, which our Device Trees are based on.
>=20
> So what varies between the members of the family?

There are currently 6 SoCs in the family:
- AM6254
- AM6252
- AM6251
- AM6234
- AM6232
- AM6231

They differ in:
- Existence of GPU (AM625 vs AM623)
- Number of Cortex-A53 cores (last digit)
=20
All of these use ti,am625 as their SoC-level compatible. The differences ar=
e currently handled by U-
Boot, which checks various feature flags in the SoC registers and patches t=
he OS DTB accordingly by
removing CPU nodes and disabling the GPU node if necessary.

>=20
> > > > For the compatible string we've chosen the TQMa6254 as the represen=
tative for the TQMa62xx family.
> > >=20
> > > And all the boards in the family are the exact same?
> >=20
> > There is a single TQMa62xx PCB, which has some AM62 family SoC installe=
d (AM6254 in the case of the
> > TQMa6254, but all AM62 are possible). TQMa62xx is also the name used fo=
r marketing when not talking
> > about a specific SoC variant:
> > https://www.tq-group.com/en/products/tq-embedded/arm-architecture/tqma6=
2xx/
> >=20
> > Some SoM variants with different RAM/eMMC/SPI-NOR/... do exist, but the=
y don't have separate device
> > trees (firmware may patch some variant information into the DTB however=
, like the correct RAM size).
> >=20
> > Choosing one representative for the family including the SoC variant nu=
mber, but not distinguishing
> > minor variants matches the level of detail used for our other SOMs alre=
ady supported by mainline
> > Linux (like the TQMa64xxL and various i.MX-based platforms).
>=20
> I don't like any of this wildcard stuff at all, who is to say that the
> next soc you put on your SoM won't be an am62a7, which has a specific
> compatible in the kernel? Your fallback then would be ti,am62a7 not
> ti,am625. Probably someone will say "that's the am62a family not the
> am62 family" - but that exact thing is why I hate all of this
> wildcarding. It's barely any more effort to have a tqm6231 and a tqm6254
> compatible than what you're doing with wildcard but it is unambiguous.

Our intention here is to have one SOM compatible string for each SoC compat=
ible string. As all SoC
variants use the same compatible ti,am625, we've chosen to do the same (usi=
ng tq,am625-tqma6254 as
the representative.) A hypothetical SOM using a ti,am62a7 would obviously n=
ot use the
tq,am625-tqma6254 compatible string.

At no point we're including wildcards in our compatible strings - we're reu=
sing a specific
compatible string for multiple compatible variants. Or is what you're takin=
g issue with the wildcard
in the description string in the YAML? That one I don't have much of an opi=
nion on.

Best,
Matthias


>=20
>=20
> =C2=A0

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
