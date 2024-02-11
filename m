Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147755A785
	for <linux-hardening@vger.kernel.org>; Sun, 11 Feb 2024 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707652318; cv=none; b=Yevqkr+vT/X03ViPRungWOertGNCdMdbxL6wuFVqR4YIM3tDNLi8Kso2jTmJtjWj8432Jfx5YGG5IVueAEYbXv5OIyiKQ2+oTdWnUJhhvox0iuXI9buPXG3LJecvoQX4yoFI6yzdd8C9kFATcfwflcIk8Yec2ZRzfRKUjpGXfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707652318; c=relaxed/simple;
	bh=XOk8Kr8T8eOC+VVzgQLqdZmZkP4QeC0s2lWogs+CjA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGwShuUcqcyOsRexITYlD8laINCMRdrOs0zd8GbshUD6uh0V2V9X0m6suVBFdUZy+mDEYQq0hb/1rtd++FY/K4AvKMShoOsBF4lskpEc3u1oeI964tfw7nc+KF+YP06aRZ/BcApM/rdkVOSNpih5PSXCCwBrp0JCmYpAJp5+ou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZ8Mp-0000La-H1; Sun, 11 Feb 2024 12:51:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZ8Mj-0005Ea-EX; Sun, 11 Feb 2024 12:51:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZ8Mj-002Utq-17;
	Sun, 11 Feb 2024 12:51:21 +0100
Date: Sun, 11 Feb 2024 12:51:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Erick Archer <erick.archer@gmx.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
	Rob Herring <robh@kernel.org>, Li Zetao <lizetao1@huawei.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: Prefer struct_size over open coded
 arithmetic
Message-ID: <rep3323evfhxh5ctmyd2biqrpg2ifej2jei5rsqpei7vuvnmsc@krh3gihuyoox>
References: <20240211091633.4545-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sfcqdcis3bm2zuuf"
Content-Disposition: inline
In-Reply-To: <20240211091633.4545-1-erick.archer@gmx.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org


--sfcqdcis3bm2zuuf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 10:16:33AM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
>=20
> As the "chip" variable is a pointer to "struct mtk_nfc_nand_chip" and
> this structure ends in a flexible array:
>=20
> struct mtk_nfc_nand_chip {
> 	[...]
> 	u8 sels[] __counted_by(nsels);
> };
>=20
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the argument "size + count * size" in the
> devm_kzalloc() function.
>=20
> This way, the code is more readable and safer.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open=
-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sfcqdcis3bm2zuuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXItLgACgkQj4D7WH0S
/k5ikgf9F4/qTgtnox96aTKRccDzsaTgOw9Qi3pN71OjgluyHYlBZZuLkP5oxvMH
1xtEtrRoArhwg8s5AISfkCSKbJG6D3uSXUf9HsjiHx2K2tK+RkQy1vFalheaw7V5
E4xeT2nxo6jpRzzqeqs75p8KbDE1FdrEZZuarr3wqtfb+oapvNF8Fy9a82Yg1BZC
DMVilJ/dMLxb6nLJ6V0fGGOzzio9S8AIFx0alMWvEzVu8i+yDDLBWbQDlQZTqzIn
lfNs4OCNwrzqhNhlWD6V8lzYV8SaUtFW+1A6ZKJb19MwobAnXElAgIQJOWX0PSY1
vASWpbUmeY9zm+JPlBvqvX/3KIcWew==
=DQCU
-----END PGP SIGNATURE-----

--sfcqdcis3bm2zuuf--
