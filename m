Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227406;
	b=vxFISQ0U0PclbmtxY4vb1D+Clto7kNnetQtMD5jb7or+2+V56BCKVlA0onySTjbFRQt9
	 si5q3zobhxlOsHc/5Ojsh+L/vt7xSiMoaifzLb8axFqM5Mt7R/zIfdjsEzvGo+GdKE7Jg
	 5YUOeUaoN12Hc93mj+ezNZgQRFXJqXJsC3aGz62YGx63eHW4ARZR/k6WBSJ2ScbGclhm5
	 6JGbYp9whQqaXd9JdGcw6NyolWn9wtOGiDdU50jIHQcvpfLWDUPbnkalB3+eZ8IrmQsvW
	 00k7TYdgHlqXOrMwX64l2rBq4gipQByLaqkc42xH4Gu2ArLNUKlvKx0kl29TUp+vC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227406;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L8Rs7Er1w4HoT0SPorGcBhaQuHjxNAjYlYU8oAyOoRc=;
	b=aCSpCs3hkxI3Jduzb7W8lTcf5mB+tk9Qqlu7JqdxbbBjjMF0hjpoSHNb5DuIY8FSWpzf
	 NUyuPvHzQi2v7lFQe1PPnjW/KXcXaE2a0c9hU9lAa4CbE9q4O2WNn5fAKJzgmTMGpEqDl
	 SUmxQ8ib0bCIyJRhVEfTw2qHa2typavEDCTOiT0JP/KrucHuyZ3SFxOKKpvTeCKF1bomN
	 Qe7haa6yRn9uV7JnFndSVM00Oep8mxteezEQM45DQXQv3zUDBmSvqCWTSDdm/mFfTIFOD
	 P7E6GvykidH4WoPqPaBHSLLR85VxbbrCYSgnIUukWq08pMjzJiS1us8LPheIHcgiuLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3uQ6Ax+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC8606A322;
	Mon,  9 Nov 2026 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3uQ6Ax+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D681F0089F;
	Mon,  9 Nov 2026 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794227406;
	bh=L8Rs7Er1w4HoT0SPorGcBhaQuHjxNAjYlYU8oAyOoRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y3uQ6Ax+FiR0R7buGb6YAx01uzdXvJh50W5B6ThswE0+i5zUkxKQJgaqhYeO8ckMJ
	 mtmb6MPHIiIeOEOoMLJ8JGCJobVZY/yTNXd0d2W6dNx1jXllpkIXouU+N7deW5Hqo8
	 qSvFPXm02uBQg738k1kfHzPPnzlkiaGwYc58H6GNX+mCFg5htYjCcey5FzHCtOIOkv
	 7K+94cpvD4a0KTCiimlerJTw5Hj6e+4mT5L1qmYM6nZJkSQK1fsQYaMhFb80qWgxrH
	 Yv5ta9d35Oa9nHM7Zq5qcBnF+bWut9SW38wepTWqrr080SDj5xD2lEKgY/QLCb9DI+
	 xhsVNwVVbW8GQ==
Date: Mon, 9 Nov 2026 13:29:58 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/9] device property: provide fwnode_property_get_names()
Message-ID: <avG8MITPLRuFcZdO@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-4-6e28fe1c72c4@oss.qualcomm.com>
 <auug8QoQ62ETGg1D@ashevche-desk.local>
 <lmib6742yptkwh7mzduw5xqid6h6rsqchs6aot3usjkcocmxqs@cvcpkwqag6nz>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xdcinei5k7d2f32b"
Content-Disposition: inline
In-Reply-To: <lmib6742yptkwh7mzduw5xqid6h6rsqchs6aot3usjkcocmxqs@cvcpkwqag6nz>


--xdcinei5k7d2f32b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/9] device property: provide fwnode_property_get_names()
Message-ID: <avG8MITPLRuFcZdO@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-4-6e28fe1c72c4@oss.qualcomm.com>
 <auug8QoQ62ETGg1D@ashevche-desk.local>
 <lmib6742yptkwh7mzduw5xqid6h6rsqchs6aot3usjkcocmxqs@cvcpkwqag6nz>
MIME-Version: 1.0
In-Reply-To: <lmib6742yptkwh7mzduw5xqid6h6rsqchs6aot3usjkcocmxqs@cvcpkwqag6nz>

Hi Bartosz,

> Date: 2026-11-09 12:16:56+0100
> From: Bartosz Golaszewski <brgl@kernel.org>
>
> On Wed, Nov 04, 2026 at 11:17:37PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 04, 2026 at 03:03:46PM +0100, Bartosz Golaszewski wrote:
> >=20
> > > + */
> > > +int fwnode_property_get_names(const struct fwnode_handle *fwnode, ch=
ar ***props)
> >=20
> > Triple indirection is rare. Do we really need it?
> >=20
>=20
> I don't have a better alternative. Having two functions: one for
> counting the names and another for retrieving them into a
> caller-provided array is IMO the worse alternative, so I'd keep it.

Would it be possible to return the pointer, and then pass the count as
a parameter?


Have a lovely day!
Alex

>=20
> >=20
> > > +	merged =3D kcalloc(n1 + n2, sizeof(*merged), GFP_KERNEL);
> >=20
> > Shouldn't here be something from overflow.h?
> >
>=20
> I guess size_add() would fit.
>=20
> Ok for other comments.
>=20
> Bart
>=20

--=20
<https://www.alejandro-colomar.es>

--xdcinei5k7d2f32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrxvL8ACgkQ64mZXMKQ
wqn37hAAtjuzjC77MoGzeovCVZHOkf27aePC3mBRrFB4n67PxKxAhnDteTJ0evAk
XClW2pWcMHOYbUgvdJVlbAC5L8ShfrR7UN3Qbh+BMt0ji+0l3q267SU+eAmf24TL
9MoAsrplaMPkwHdK0HajkcIy8fpPIC2QM8PkIpAk3JhZvfmmANA/p/KqYgSp3YiT
u/HJP55J0A7I4f1CK2ym2RZ4NK2NpmlEsTEaa+M2+zhDmS2ztHq3fqu7EmOgksEz
Vq6Rw7iVX6nzAiMnOWoQTMEs2pR/eVU2tjzBael3J+2h/uarnGWJEVfgsCymJ9FY
EU0yg2ebM5mEEaH2uihxVdKnxnUrrjX2JVgaz7jiHBDe9CyHxH9ZHrijOr2QN9wf
CUNMzvq2EN235hyg/aKVrxMvgSM3Sbk480HcjlarM2DotX+6HFMkbEr0bB7ORiMA
TS6+mITone1URnbqAQvqKstDzGDPIsqyZcX9b2dUba91sxDiYbw9DMggeenvLIwS
TCASeoWrO+ggD2sRpHdtkibM8uP9t6knNWEWKFcyFyxgLZFdGrfFldcaUNFaWH33
I9DgDlRL3/DgZwF+qwdzAWNjwiajdAc/B9WowFRyZ97LUcdIWQudD/y/RftA/e6e
5OGdtYkXSeANEuBfQGygAY/RUsnLvSTPE5biq5xmBLCkTvZgK84=
=35DC
-----END PGP SIGNATURE-----

--xdcinei5k7d2f32b--
