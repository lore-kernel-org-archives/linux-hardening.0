Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517E22C9EC;
	Thu, 16 Jan 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043053; cv=none; b=AwnRv+zWU7nTC2izwt6sWgdjW/xeH0jVKOXxOwjrdVp1XQfTR/kAJwfjar6nflXRS5XqdYBdDATFMDBuqmn6EyZjprX/s+xb1gS/R0vVL7DrHHwt6w5UJi4VDNLi5IxsMYeC8e6WYS52TX45pCZbt6LC4xQoMWbPn6mjIam3N6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043053; c=relaxed/simple;
	bh=pp53PsG2bW5UFxFqYOwl6ysQE+WIcRtaUgsyKfrRfKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtNNv8lee3McU7V94k5aotiHi+96cGpjfpvMB19oZMilJd679kBk+2dDerkoDxfBXrhBChNyssDP9XjmisC1x835DADeo+E8JvIUos66vpGUhuz2D3MvTjjc0jLmvXuh+wUrnPucV3628Gc0Holg069tNL4dJRYFSx46JUmJcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 537F18346A;
	Thu, 16 Jan 2025 16:50:10 +0100 (CET)
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
 Re: [PATCH v14 4/4] MAINTAINERS: add myself as Marvell PXA1908 maintainer
Date: Thu, 16 Jan 2025 16:47:29 +0100
Message-ID: <2969840.e9J7NaK4W3@radijator>
In-Reply-To: <oapsqjdop3szi7zfwiyy65ty65gz3uid6cc4lfao22o4d6amjd@bmfkt2wnmlom>
References:
 <20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr>
 <20250115-pxa1908-lkml-v14-4-847d24f3665a@skole.hr>
 <oapsqjdop3szi7zfwiyy65ty65gz3uid6cc4lfao22o4d6amjd@bmfkt2wnmlom>
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

On Thursday 16 January 2025 08:56:24 Central European Standard Time Krzyszt=
of=20
Kozlowski wrote:
> On Wed, Jan 15, 2025 at 09:35:57PM +0100, Duje Mihanovi=C4=87 wrote:
> > Add myself as the maintainer for Marvell PXA1908 SoC support.
> >=20
> > Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> > ---
> >=20
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index
> >=20
a87ddad78e26f28ffd0f3433560d6db1518f9f95..caa5f6b96251a3da0f3f9d2f760b38288
> > eb23ab3 100644 --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2624,6 +2624,15 @@ F:	drivers/irqchip/irq-mvebu-*
> >=20
> >  F:	drivers/pinctrl/mvebu/
> >  F:	drivers/rtc/rtc-armada38x.c
> >=20
> > +ARM/Marvell PXA1908 SOC support
> > +M:	Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +T:	git https://gitlab.com/LegoLivesMatter/linux
>=20
> Not sure if this was mentioned ever (it is v14, so it is likely) but if
> that was not clear:
>=20
> Pull requests from non-kernel.org repos must be signed and your key must
> be in kernel.org keyring. Please get your key signed
> (meetups/conferences/keysigning map/video confcalls) and submitted to
> the keyring.
>=20
> Patchset should be sent to soc@, as expressed in soc@ maintainer
> profile.
>=20
> Unless this is not going to be merged by soc@, but someone from Marvell
> maintainers, but then please drop the repo. Git repos here are for
> managing patches.

I didn't know about Git repos being used for patch management, thanks for=20
letting me know.

I believe this is best merged by soc@ since it is not mvebu and is the firs=
t=20
arm64 MMP to be merged. However, for various reasons I'd prefer not to have=
 my=20
key signed quite yet, so would it be possible for this to get merged throug=
h=20
soc@ if I removed the repo?

Also, I will certainly add soc@ to the Cc list in v15.

Regards,
=2D-=20
Duje



