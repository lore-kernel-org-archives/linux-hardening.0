Received: from mx-relay36-hz1.antispameurope.com (mx-relay36-hz1.antispameurope.com [94.100.133.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E834337BA1
	for <linux-hardening@vger.kernel.org>; Wed, 17 Dec 2025 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962730; cv=pass; b=fb31gIsyP0/PjMJiYg/77+5rQkbedmPcZNI0Q8PHP2sB6rfpq2Yaltf0+KqhnM2IIvYodTeNCgORg0eG46/akNI0Uk85KufszMcH0h58t3YAVHqezPHhhHrlr8AZqaAZoKIr5TJGwZBaBtbehlRf6cEnPnC4XFtRxe88/0ELuq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962730; c=relaxed/simple;
	bh=xfujg8/O0zWHhjIR9pfaJn5dYWdiKI7tk4dkgx8mmsU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DURjceGpzdMg9R7UPTFEqW9621wDj98WCXEV8k25tU8hJD+0y99O03yEAFdx1mSDVUtIdCPXm6cfoTeSlr/W4lGYZ2vV0kXO37ymK6Kihz3T3EGS2CO5GnFrYNgOkYmVKQMPqn/NJsU47St7ngKy/e438xFYp883KPdCCVbtXNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LRn5KeJU; arc=pass smtp.client-ip=94.100.133.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LRn5KeJU"
ARC-Authentication-Results: i=1; mx-gate36-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=xfujg8/O0zWHhjIR9pfaJn5dYWdiKI7tk4dkgx8mmsU=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1765962645;
 b=R2Yt9p+YqsHK7F6re+So8LZOMIuwpH1jCXhSavlEClibkJLauHhLeFwOhC1oljzJ+iy2+4Cq
 hsqC3kVcGGqarWxDVeB5Gj6bULjPVoCLxr2/e97smZxukAmjP3awMhg4PPaD3F/S/PGEjsX23wW
 n6a3OoO5BTQrhWKuBZV35HZGnqPbNL04qFpX51TDE8QfNy24OSYNaspb02vsiLWG+jYelQKwVnu
 j3U70i/ld21iYu8IRx47E2eo6yFxhPgW2l3FNKISCpnHfPEYiuvWrr6Rzi76ckSFomRVdRSu6Da
 Rsi0bEwnQXbSEK8Gxs8y+6ys6wO9/PVHkTRcC799Jlmkw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1765962645;
 b=aXHT0ON1blqC8dim913qM8SHso37AYW2+55V+NOleCCtWp9geI+acB75hrTCclIADJFbVzUm
 SJz7mfpKxx6IKercTIsPDWS3cbI/cIINbeFZlGUf01Hyx3w7uYxK8Yy4D1T3tFc2BbnVEuyKhRZ
 XwUjTrC21cViRqTaUSnsfrGZxlE0Vr+MVB4bQbRIihmhTxrZ60a8aTdbXv95zf+WJFuY8kQL7TI
 D7w+PktJX7FUFOJohEyg/vCzBu+++iYl+16gFIh3OgkEH2FGHYBcKXWY8Rdv+AlGLcBFX/qKLWO
 bB+7hTslTIw0jyY8zRqtx7AcB+m/gTG1ckn8ABpxRfKoA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay36-hz1.antispameurope.com;
 Wed, 17 Dec 2025 10:10:45 +0100
Received: from [192.168.153.128] (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 90E2E5A0FA5;
	Wed, 17 Dec 2025 10:10:16 +0100 (CET)
Message-ID: <637f14d1c77c2a1d19f7ea221addbbea51392bd9.camel@ew.tq-group.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and
 MBa62xx carrier board Device Trees
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>,  "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Andrew Lunn <andrew@lunn.ch>,  linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org,  linux@ew.tq-group.com, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>
Date: Wed, 17 Dec 2025 10:10:16 +0100
In-Reply-To: <671625aa-f5da-4e34-9c8c-7a1da282aa5e@ti.com>
References: <cover.1762775119.git.matthias.schiffer@ew.tq-group.com>
	 <0079cc291c78b94068f3d8c59df103e951247acc.1762775119.git.matthias.schiffer@ew.tq-group.com>
	 <d13a95659bdd1c840dfaa46afd6d8583f1b7c88f.camel@ew.tq-group.com>
	 <671625aa-f5da-4e34-9c8c-7a1da282aa5e@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-hardening@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay36-hz1.antispameurope.com with 4dWSgY2fCdz2HYqw
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:3ce335cbe13af60b1b355940102977ec
X-cloud-security:scantime:2.793
DKIM-Signature: a=rsa-sha256;
 bh=xfujg8/O0zWHhjIR9pfaJn5dYWdiKI7tk4dkgx8mmsU=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1765962644; v=1;
 b=LRn5KeJUheqDGLQEdEpFd2cTmgy1cp6RvZ2gbutQoBUM+ipntOC+uVzCR3hG1szKj/2xnNpY
 1PXgaBwZllb/6st+qYpge+gMM7q6dj+KyxR0V2WHjn02N8Y4ma2L/z7K85NtaMpHMi0/4Jv8BGU
 NlwHfz/xG+qWC9CwvNFmHDCvYxTL9FR4yBJgy4D9enc4yWmJekEJSSE3KsmsDK197Zfdfg/aDVB
 HRzZzfuf25JIlfhBfHy/Asxbgwfgy9T1trghESScJB22S0XR0/+OYXc25d+JR4fDFGqzSHASXqv
 DyyTEe4BRKaFFxly0sKDKF9W93ZvHv38dBHkNlmHZTWWw==

On Wed, 2025-11-26 at 10:47 +0530, Vignesh Raghavendra wrote:
> Hi Matthias,
>=20
> On 25/11/25 15:32, Matthias Schiffer wrote:
> > On Mon, 2025-11-10 at 12:49 +0100, Matthias Schiffer wrote:
> > > The TQMa62xx is a SoM family with a pluggable board connector based o=
n the
> > > TI AM62x SoCs. Add DTS(I) for the AM625 (2x Cortex-A53) variant and i=
ts
> > > combination with our MBa62xx carrier board.
> >=20
> > Hi Vignesh,
> >=20
> > do you have any further comments? Can we get this in for 6.19?
> >=20
>=20
> Oops, this somehow fell through the crack, my apologies!
>=20
> I have already sent out the PRs for v6.19. Sorry, this would need to
> wait for v6.20 cycle.
>=20
> [...]
>=20
>=20

Hi Vignesh,

will these patches by applied for v6.20 (if there aren't any more review
comments)? Should I resend them?

Best,
Matthias





--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
