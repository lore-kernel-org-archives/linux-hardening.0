Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947324A7F6;
	Thu, 16 Jan 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041722; cv=none; b=AV9Ht9B7chk96rurVGUKHPj10yln7eScQKLtw9MGqFb1MGgdCDSufN1931ysPhXFy9nX2bKpOiAPBiL+4bs0ZyLiNNlf/XI6QPnOVxO/tED3AFLzvulRH+zmZ5d00WLilbWuXXNmCm6SwcfynVku9liVwXNd2AskqoxRptDXtvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041722; c=relaxed/simple;
	bh=rsInXZsOBmuQayw/szjA6bBIcpvuRkQLjrjIPLqPAjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8zsEuRazoAYvDzEbAnstaXQq3owuHyLCyC51qs/jA/cE1FHHMYeAYn8XMSwOUJFZva8nGMv9/enbpVm/IPiMLmt4stpjJvdMVR1fXFD3o3xua9fiWLYJxEZ/8Jb3QEvG1P/xCJvRidkU66tn8LfwURDzmi6AuqS7tvCxNNFbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id A2BCD820FB;
	Thu, 16 Jan 2025 16:29:46 +0100 (CET)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject:
 Re: [PATCH v14 3/4] arm64: dts: Add DTS for Marvell PXA1908 and
 samsung,coreprimevelte
Date: Thu, 16 Jan 2025 16:26:59 +0100
Message-ID: <5849160.DvuYhMxLoT@radijator>
In-Reply-To: <ct7q2eaps2m2ceghiek2pmb7yhd5it6s53moumfncnyq4d4zmw@fmtoyyn3j5t2>
References:
 <20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr>
 <20250115-pxa1908-lkml-v14-3-847d24f3665a@skole.hr>
 <ct7q2eaps2m2ceghiek2pmb7yhd5it6s53moumfncnyq4d4zmw@fmtoyyn3j5t2>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=duje.mihanovic@skole.hr;
 keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KER
 1amUgTWloYW5vdmnEhyA8ZHVqZUBkdWplbWloYW5vdmljLnh5ej6ImQQTFgoAQRYhBG3/QdYN8x
 S1t2umMK0xk1JFj60DBQJmiSHOAhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAA
 AoJEK0xk1JFj60D1GABAJVSorZdMOlrp/oQtCSH/G53NE56x/JHA8VX+ZQBd/H3AP4/EcUf6eef
 DUxVMh2bdkmuQKsVZGgOGiXpMksrVntWBrQpRHVqZSBNaWhhbm92acSHIDxkdWplLm1paGFub3Z
 pY0Bza29sZS5ocj6ImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSH/AhsDBQkJZg
 GABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw8A/i4lPOL7NaYoYePDq
 l8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xqh2MRcNmJCHA1YhWAbg4
 BGaJIc4SCisGAQQBl1UBBQEBB0DEc9JeA55OlZfWKgvmRgw6a/EpBQ8mDl6nQTBmnd1XHAMBCAe
 IfgQYFgoAJhYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSHOAhsMBQkJZgGAAAoJEK0xk1JFj6
 0DG5MA/iuo4l2GDEZ1Zf+XaS//8FwdXDO9nHkfbV2MHjF4NZXwAQDroMzBdMcqVvc8GABFlTTgG
 j7KrRDz2HwWNyF8ZeprAQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday 16 January 2025 09:00:40 Central European Standard Time Krzyszt=
of=20
Kozlowski wrote:
> On Wed, Jan 15, 2025 at 09:35:56PM +0100, Duje Mihanovi=C4=87 wrote:
> > Add DTS for Marvell PXA1908 SoC and Samsung Galaxy Core Prime Value
> > Edition LTE, a smartphone based on said SoC.
> >=20
> > Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> > ---
> >=20
> >  arch/arm64/boot/dts/marvell/Makefile               |   3 +
> >  .../dts/marvell/pxa1908-samsung-coreprimevelte.dts | 336
> >  +++++++++++++++++++++ arch/arm64/boot/dts/marvell/pxa1908.dtsi        =
  =20
|
> >  300 ++++++++++++++++++ 3 files changed, 639 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/marvell/Makefile
> > b/arch/arm64/boot/dts/marvell/Makefile index
> > ce751b5028e2628834340b5c50f8992092226eba..
39c5749e631db33aa8fb0386a951c0a70
> > 215bc02 100644 --- a/arch/arm64/boot/dts/marvell/Makefile
> > +++ b/arch/arm64/boot/dts/marvell/Makefile
> > @@ -32,3 +32,6 @@ dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9130-cf-base.dtb
> >=20
> >  dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9130-cf-pro.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9131-cf-solidwan.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9132-clearfog.dtb
> >=20
> > +
> > +# MMP SoC Family
> > +dtb-$(CONFIG_ARCH_MMP) +=3D pxa1908-samsung-coreprimevelte.dtb
>=20
> Hm, why separate ARCH if this is part of Marvell Makefile? One ARCH per
> vendor, so if you think this is different than MVEBU, then should be in
> a separate subdirectory of marvell.

I see, for v15 I'll put these in a mmp/ subdir.

> > +
> > +		ramoops@8100000 {
> > +			compatible =3D "ramoops";
> > +			reg =3D <0 0x8100000 0 0x40000>;
> > +			record-size =3D <0x8000>;
> > +			console-size =3D <0x20000>;
> > +			max-reason =3D <5>;
> > +		};
> > +	};
> > +
> > +
>=20
> If there is going to be resend/new version:
> Just one blank line.

Will fix.

Regards,
=2D-=20
Duje



