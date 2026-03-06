Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693037187B
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772780192; cv=none; b=RK2cltUJkZ1NhiL9qFxLPup3jFISLg0ZzkuhlXiKMCAWR+Ib22wyetXwvrqeQHpeQ030s+cMJrLiUZVL6zInzVojEa6GKaFEAn/enYvp9IT7anmsTQV/x9TKqFYk+zr376sTgC8Cuqc7kY3X1iGsvQVceQTFrLE9X9dwhsthirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772780192; c=relaxed/simple;
	bh=lZi/wMM/ciY0PifjHsWxYMySZzBSA++aFXRYYRu1dVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnFvx20yobASouCKzlDdDova32OQvQeIx7rONZ5Z0rLXqNG2E7oBk26Wu52i02EOA5Eui9tdO7ZiDFVqJZmVt6mg2lrygUT489z2dWlAqIkqpeDGQPILWUedL2OPlkug9qx/SrxRuP+OAYJ2B6Yg0oRbb/ciwXrQLsvX1Y3Md+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vyP6e-0008Cg-FH; Fri, 06 Mar 2026 07:56:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vyP6c-0040ah-0f;
	Fri, 06 Mar 2026 07:56:15 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B80D84F9166;
	Fri, 06 Mar 2026 06:56:13 +0000 (UTC)
Date: Fri, 6 Mar 2026 07:56:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-media@vger.kernel.org, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, gustavoars@kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] media: nxp: imx8-isi: remove kzalloc_objs
Message-ID: <20260306-handsome-quixotic-catfish-705bde-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260306044536.149204-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qt6jm373d6epfxbc"
Content-Disposition: inline
In-Reply-To: <20260306044536.149204-1-rosenp@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org


--qt6jm373d6epfxbc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] media: nxp: imx8-isi: remove kzalloc_objs
MIME-Version: 1.0

On 05.03.2026 20:45:36, Rosen Penev wrote:
> Use a flexible arraay member to combine allocations.
>
> It looks like pipes never gets freed anywhere. Meaning this effectively
> fixes a memory leak.

It's a devm_kzalloc(), which means it's automatically free()ed after the
remove callback.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qt6jm373d6epfxbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaap6igAKCRDMOmT6rpmt
0h0YAP9FYFN9bll7jzuGDpQaPy24yBisGMPapjkkoLpoXI0gFgEA15p+v6RhEWUS
2+WhjuDG94zUDEWMa2eNHkHVZONmfgU=
=Afub
-----END PGP SIGNATURE-----

--qt6jm373d6epfxbc--
