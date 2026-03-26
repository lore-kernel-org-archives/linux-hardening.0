Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFD37F729
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513341; cv=none; b=KBHYfeoxEQYIVCBw5WvswrhuPcwzTK5IsAqR4X07Bb1Pctyg8WZbLqMFmOqnLaJsN9OSNSptzRxxx/aLij53zKZkUBbyek3JF0vb+nifiYH8YJRA7rTYcawJbWqtjOvwDhW2Mc7on6V6pUiFRQ2Wa6Oq0SW2bJpU/dw0zhlv1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513341; c=relaxed/simple;
	bh=n+Bo6Os4r+q7XD+1rl+1TYeoyM+inLHE7ZtNG6hZQU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwRFmLJKh/dBntx+v1+Gx6Qth8cBOCf9VzYK9I5/MjeHsg3T1fAdNQYjZpoG22G1dqNtT7mnLXne6xEf3LpN69IqvA3EGclUeWLpOZU5hXwTTnnRB1qVYMyrsAkDg2ZggH05piinhxAeJAHhd21phXumseg8M2eFqpQ2X6IYAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w5fyn-0001ky-E8; Thu, 26 Mar 2026 09:22:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w5fyn-002C8H-0M;
	Thu, 26 Mar 2026 09:22:13 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C626A50D28A;
	Thu, 26 Mar 2026 08:22:12 +0000 (UTC)
Date: Thu, 26 Mar 2026 09:22:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Thorsten Scherer <t.scherer@eckelmann.de>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:KERNEL HARDENING not covered by other areas:Keyword:b__counted_by_le|_be?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] siox: use kzalloc_flex
Message-ID: <20260326-pastel-monumental-bullfinch-44df90-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260326044725.234216-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vcniopiyw4fezxey"
Content-Disposition: inline
In-Reply-To: <20260326044725.234216-1-rosenp@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org


--vcniopiyw4fezxey
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] siox: use kzalloc_flex
MIME-Version: 1.0

On 25.03.2026 21:47:25, Rosen Penev wrote:
> Use the proper function to allocate a struct with a flexible array
> member.
>
> Add __counted_by for extra runtime analysis. Add counting variable
> assignment as required by __counted_by.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

NACK - What's you motivation to do this?

> ---
>  drivers/siox/siox-core.c | 5 +++--
>  drivers/siox/siox.h      | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
> index 3e8f3b6a4555..b87e2a12d640 100644
> --- a/drivers/siox/siox-core.c
> +++ b/drivers/siox/siox-core.c
> @@ -689,10 +689,11 @@ struct siox_master *siox_master_alloc(struct device=
 *dev,
>  	if (!dev)
>  		return NULL;
>
> -	smaster =3D kzalloc(sizeof(*smaster) + size, GFP_KERNEL);
> +	smaster =3D kzalloc_flex(*smaster, buf, size);
>  	if (!smaster)
>  		return NULL;
>
> +	smaster->buf_len =3D size;

The "size" extra space is not used for master->buf, but for
dev->driver_data. master->buf is allocated in siox_device_add().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vcniopiyw4fezxey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacTssgAKCRDMOmT6rpmt
0sjmAQDUEPIu1uSxu8QOn1tP1Zfn4F5e9rvIf31DPaKHUUKShgEAhVrBT1ofFDBr
hf9kRLQHKiVOhaaVYRh6lPtPTfc0CQE=
=jYVi
-----END PGP SIGNATURE-----

--vcniopiyw4fezxey--
