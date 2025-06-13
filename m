Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DF2C1593
	for <linux-hardening@vger.kernel.org>; Fri, 13 Jun 2025 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807746; cv=none; b=NHXxHRhNQTRb+e7zfYDmCQDnnT0nzJ8AJFGKpnAPz53HmVg4OW+V99Jb0wVtsi53QzqUMVK7WvL9S+etTa2J5ww6FpSDr7dF4xYHZgH48ku7kCKECZZ08KdInQ82Hh0tEDt8W4s+O+DY3BApk3pXRDLiJttkpasKAdhw6i86rMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807746; c=relaxed/simple;
	bh=CtNvxnB0vPCKAmcYC/efh99DjurqltuJUPHBbthRWF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bATHZO7ZP1m8cE9qGj17q1d2r5d8wSzUfMC4v9TyAFRQEH9iLbZBdG/jWOyTCRV28yNo+wY6lXBiel56l8zqqF1oLYSzuWaSTJTak1LAbPTCX4NTItFaGedo+N2zbyUS6wsYMvBmV7B8tp4fr75ezvP7CDFece1BpZaKQxM84xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=R/FyAZcl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="R/FyAZcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nZy3
	8NmYICe8Mu3Mjf0MKMXMdi41KhsE9KdB9TPXbwo=; b=R/FyAZcluhMz+xilJAeX
	AjuZC66tdPKDOWPqHfc55pWuX1hKenjxDjbiNOlSEtvAeTK+JRrq2CsPizBCDmxF
	Pqx2h976CSHwMUbpNXeLPRCL3IvKrbwU6DUes2Lkv9G9L11zL/TyHvlPJFLJ3GiE
	+efyepQVVJqaWErYYfnK+OI/fQUPNBJ2kddB57jzDyAdWvEkioEUYFUvyc5YH0Yk
	fau42RxrxDfr0uJFKJ0JW0KwOF3M5eR7PHuElpYo83effjkSrnNUlgAMmr1CU0+T
	vWdeMwfO40Bq9Cwww0x8DUl+AaAOChIZfJyMqzXZsAd1y3RAX0edRkGTq1tiRDNN
	FQ==
Received: (qmail 166897 invoked from network); 13 Jun 2025 11:42:21 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jun 2025 11:42:21 +0200
X-UD-Smtp-Session: l3s3148p1@bEzU3HA3pOEgAwDPXy2/ACpZfVCNKldR
Date: Fri, 13 Jun 2025 11:42:20 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Frank Li <Frank.li@nxp.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-i3c@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RFC 4/7] i3c: add driver for Renesas I3C IP
Message-ID: <aEvyfM42WTKENbFO@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Frank Li <Frank.li@nxp.com>, linux-renesas-soc@vger.kernel.org,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-i3c@lists.infradead.org,
	linux-hardening@vger.kernel.org
References: <20250611093934.4208-1-wsa+renesas@sang-engineering.com>
 <20250611093934.4208-5-wsa+renesas@sang-engineering.com>
 <aEmws+OtHirrUPUo@lizhi-Precision-Tower-5810>
 <aErqY0QWMRdC7Pvg@shikoro>
 <aEsDj5Vcb4zFJFlo@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K40i87jX3QkMmMc9"
Content-Disposition: inline
In-Reply-To: <aEsDj5Vcb4zFJFlo@lizhi-Precision-Tower-5810>


--K40i87jX3QkMmMc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > And there are only 8 of these registers. So, there is a maximum of 8 for
> > this controller. We could hardcode 8. But we could leave the handling as
> > is, just in case a future controller has more or less of these
> > registers.
>=20
> Okay, can you point me spec link.

Overview of the SoC:
https://www.renesas.com/en/products/microcontrollers-microprocessors/rz-mpu=
s/rzg3s-general-purpose-microprocessors-single-core-arm-cortex-a55-11ghz-cp=
u-and-dual-core-cortex-m33-250mhz#documents

Datasheet:
https://www.renesas.com/en/document/mah/rzg3s-group-users-manual-hardware?r=
=3D25458591

> > Sure thing. I think I didn't get feedback on my original suggestion so
> > far. If I now know you are positive about it, I will give it a try.
>=20
> Sorry, linux-i3c mail list always delay your post, did you register linux=
-i3c
> mail list.

I did subscribe. I receive mails and my patches using git-send-email go
through directly. My responses to mails are always held back just saying
"suspicious header". But I don't know what is "suspicious", so I can't
work on it.

> > There is a specified timeout? I couldn't find one in the specs, can you
> > kindly point me to it? So, the solution is to use 100us as timeout?
>=20
> See: 5.1.2.5 Controller Clock Stalling

Ah, I missed this one so far. Thanks!

> The spec have not defined what exactly happen if stall clock more than
> 100us.

I am going to the I3C Plugfest in Warszaw in 10 days. I could ask people
there...

Happy hacking,

   Wolfram


--K40i87jX3QkMmMc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmhL8nwACgkQFA3kzBSg
KbbuVA/+I4VgOS79AXzpTRA0k72Re819xTv12Dq7qqQyCvfvXCSQWsGPY/bHSW7G
w0mdyHeWX668BlMnSJ0tG16z3aOERAYb84wNXH4hobO2IN5pTAi532QkA/4GOniQ
gKgep4L26X5/tE1OcO0fb6wUiezfzKRr0FRvgiv34rdK7lnK3zrNij+DjH+t9Osf
iazabHh+KZGOe0IqqU14ePC3W23edCu6HgluAXscThJSLl+aucuS53XEoO9oPBto
Lpt694NxL5Cu61OKYEzRmcbh0UdHx8CtH98QgKNifMVR60kd8yByfefcpcMfZDQV
aKcS5fRiH0qBbxRGO2nvgHYQR8B0N3EPFDs3tRtpGLq74rr2q8Yyf5JEdlBBitQe
d6JZvrSJGo3P+rL4OFlYeYvCkc0hu3BvPAqEfVzup6qBes3YvClh9j7kEGDU2ySj
NTx9t1hrFqFFSccOtzAVvRtuXXLOfowYgK9+n/xqzOjINWT4S8PM//pDcrEjrr1/
r6UJ3PgVCnTaIImNh1LTx87bYOLC+D+h/yQfW7YWJn0IQ8c5gSaoPRdH5txhJo4M
Z9hD+awjQveg5jIA/B5ghu2CVGxK+u/Lixh07uywkjfefoiKLiPLFbmweSMQLQHk
RsQtvyJ3wz/jbiHo8RFWauThZa0iiU40L3VW1xogTk3SFfjc1XU=
=wf2Y
-----END PGP SIGNATURE-----

--K40i87jX3QkMmMc9--
