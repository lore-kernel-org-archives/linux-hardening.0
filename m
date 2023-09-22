Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9FE1EA7C
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E60C433CA;
	Fri, 22 Sep 2023 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695377447;
	bh=33Tgy9zFb+25f45bxXvE9vqs5K0swv1i/LRG0rsLIP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRckGD9LAAQnDK/ghKMPAyO39B4Dc7dD/KtrMuIbVHxFym0bmgfZloMqwY8Oa+abh
	 bTc8ozFDCJKsngLTD8LVVLC54y9eM9cO/bpSCybYzBBG0AIK30FGNQpQHnnpJaWh9f
	 OPnUmrm55U23dce7eswmSUQzYSXE59u0bOmk6g6uCYUYBsU/EqeAkfKClAXk+5y+3D
	 E953C88XqwRTWhXBJrTjk9hdmw5dS5/JUn+XdzIH/SdCr3fjXBPxi5JJW0jHPnPcHa
	 480UWBMKu9RvoxUsoGsYMxM9peExWDWltwdyKwKntJD1LuiBvzM0h4Qumgg4SQj3f4
	 K8tvW0zIDSNxw==
Date: Fri, 22 Sep 2023 12:10:44 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence98@sch.bme.hu>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i2c: cp2615: replace deprecated strncpy with strscpy
Message-ID: <ZQ1oJB0Tiop3Z1Fv@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence98@sch.bme.hu>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230920-strncpy-drivers-i2c-busses-i2c-cp2615-c-v1-1-11406a996794@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c0LwJnjHZmcinQj0"
Content-Disposition: inline
In-Reply-To: <20230920-strncpy-drivers-i2c-busses-i2c-cp2615-c-v1-1-11406a996794@google.com>


--c0LwJnjHZmcinQj0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 08:08:52AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>=20
> We should prefer more robust and less ambiguous string interfaces.
>=20
> We expect name to be NUL-terminated based on its numerous uses with
> functions that expect NUL-terminated strings.
>=20
> For example in i2c-core-base.c +1533:
> | dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
>=20
> NUL-padding is not required as `adap` is already zero-alloacted with:
> | adap =3D devm_kzalloc(&usbif->dev, sizeof(struct i2c_adapter), GFP_KERN=
EL);
>=20
> With the above in mind, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Applied to for-next, thanks!


--c0LwJnjHZmcinQj0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUNaCQACgkQFA3kzBSg
KbZcVg/9E7peMn7vHeP47JzLjr4NVIkVY//5HALFdYGqXGp3VKTizc45nquNyd9j
6BFcXqSC+d1DxJ5hiwuNPRoQc0ftZhaFUweAeucZHh/Gg3iPnK395lVv+WAVIeu8
6DeK8sKeQmBJcQyX9xcPHypJfs3eW2i99KuPhz/97hDNLy4XezL50QOpzBSuarGE
cbelsLwxxaOED+dtW9B5kgTrpNeKdIaBskoufFrOxNYn911cLv+bN0TRXks7tW94
ytVLqdF7A/KH+0QNC1X2mnMcf13hRexZ8K946T/8+Caa1pnAJnzZWmwWsKqX4HPT
6uLU1wQaG5ZrBryF6mItiISL0dRb7qNToS5/oPGHbgq2Pr7nV9JAW62kP18eNcKG
zOP8QApoTzbzSASUR9y6xLhhhaXNvEkAK08HGfcJMtL8gVuJGqfm0eQoiwGTQoTp
gP5rsfDKLgVar5dGkGMQ9OJaR7inQjHjGy0gkQ5+FT0yY0hWANH0eEq0EXmy71/z
suSZZKZJlJK7s6EwS9l4NJlSk/whexyW86srKBq0ilYe+B0KrTnAJaDgxN1HJ8cx
FUkLgfoEuEeuMBCA2E6iymbaB6nl93j7nvl6Y7cqKzJdsbWwoPfpfL+51kKTp4bR
6SoUWGORqbZpku27IhTlRZgEqFnr+GXvGW2y8hW3UiWNrHpKw80=
=V3V8
-----END PGP SIGNATURE-----

--c0LwJnjHZmcinQj0--
