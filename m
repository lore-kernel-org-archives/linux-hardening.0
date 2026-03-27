Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB63BFE3B
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774594212; cv=none; b=JZ6YgzIvbCyJchvMC/H+bLapWvxJa90cuksWojEjNioFCZ6ZQ1qlbpICwS6cKAhDDPyFhwOYUhAr6NMe/rxjV43i0ZoJWhSxNNTfMlTwMiZ1bYY7F/pegQGu3bl1nV7qKJko3lMpuIIG/j0iYr5zxfAaiUrbiyPZKBMjmiriVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774594212; c=relaxed/simple;
	bh=1dWUyOdg++Elf+xJ9paDNfSROfcsFdUXQ2M05px6OnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaXBom+7LJOMwxEvEpDNb9iLLv5mOeRq7jL4GhCwVFgYzDYMbb7yuBc1Ffs0Ku4z0bDTL92vxN543uG/69GU04jlbzrvBwj9vme9H9dhaudncroVkfQi+HA3xQx1G6zxlqBKe2glIEN9k6H7Xv/g3WyBgP9b+UA3nHc2oVF8sn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w610p-000269-BY; Fri, 27 Mar 2026 07:49:43 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w610o-002LYU-36;
	Fri, 27 Mar 2026 07:49:43 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A940650DE7F;
	Fri, 27 Mar 2026 06:49:42 +0000 (UTC)
Date: Fri, 27 Mar 2026 07:49:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Thorsten Scherer <t.scherer@eckelmann.de>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:KERNEL HARDENING not covered by other areas:Keyword:b__counted_by_le|_be?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] siox: use kzalloc_flex
Message-ID: <20260327-cunning-eccentric-ant-d791c8-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260326044725.234216-1-rosenp@gmail.com>
 <20260326-pastel-monumental-bullfinch-44df90-mkl@pengutronix.de>
 <CAKxU2N_0EJfv4EHyLbBJsn27Hui9U3SvaZ_bnbcnmAx8=mZAvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgmyhfkbc2e5bvzs"
Content-Disposition: inline
In-Reply-To: <CAKxU2N_0EJfv4EHyLbBJsn27Hui9U3SvaZ_bnbcnmAx8=mZAvw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org


--cgmyhfkbc2e5bvzs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] siox: use kzalloc_flex
MIME-Version: 1.0

On 26.03.2026 12:17:34, Rosen Penev wrote:
> > NACK - What's you motivation to do this?

> > The "size" extra space is not used for master->buf, but for
> > dev->driver_data. master->buf is allocated in siox_device_add().

> I assume this means a new struct member should be added and
    ^^^^^^
> kzalloc_flex modified to work on that.

I suggest you look at the code, try to understand what it currently
does, then re-think what your proposed changed do, what problem your
changes fix.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cgmyhfkbc2e5bvzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacYogwAKCRDMOmT6rpmt
0qWmAQDyg5WO7uTlOUyWKCwnFp1cZjwjLSs/9YPkeE5i/FEl9QD7Bwc5aUhwQpxt
FcSQqQ9nAM5vZHP6WRb2W65/YEN4og8=
=Lw4o
-----END PGP SIGNATURE-----

--cgmyhfkbc2e5bvzs--
