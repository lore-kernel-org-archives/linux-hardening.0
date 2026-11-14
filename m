Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678756;
	b=0JvmDWwvupkE7Udwsssx5tmloYSrGHEB1b8c0Bz2BwHSmV5tO8NigLzTPhJnN8XzcwtK
	 pDbcN0JTP0ZFr2xcrAtjFXAcrPiqlJPvNzk52XdlwBVyGIfgG+bkTXCalKOv56fBYllrG
	 1HeixDkOGqg92g3CRZjTvZFRYlCNOuUYziU1aseXP7mWi28Kfxvwv8c2gHzVdiZvR0SN+
	 zTgM4j3+jbiC7N80khYq4X0ZBx7N5HLdhjwa8hEbAituBvuCUGicv2jhIw3zftwEmXLLY
	 LBRN1ylbGJru15Oqmjy+7Y9V3E8FUFpP4W6cFv+rlORNcl29f0ZcTGQJvg5r0MFAkrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678756;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6DnD0ERJEjy82XS2qztXwiX3wlv4q+LQrDFFVZf8mKw=;
	b=MRH0D/EXxHXFazW4gbSILYLaZNfD9wheaHIJeN+e1AH0tLfLpKG+vsXahbaKl2GOCR8U
	 QYOiTAf+qrex05WrqKlnjdNmnB8ZUkqwbmNefL3gP6j5vSK5e2fJCJjhwPZ6ULHeskkvj
	 aAswGLfl8y/bYofHTNIKbCWZOj6xdbdbpcn5ch0vYmUoAm7ivFAxoH7VZcfqVYYuiEUaf
	 VJ+k8FEhK5bFutHdH80DUsEzfRGTbPSk6b2IEHhb4Hc+8xUq6TuldL7XCoOwHlIXjqO1f
	 zvPRgsoF5fy5jF/ybZ0rw5WmM0ShLP6xDLxL3br4VLojnhn86J/mEtbrZut71TYa5qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUkan6tp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAD606A323;
	Sat, 14 Nov 2026 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUkan6tp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C1F1F000C4;
	Sat, 14 Nov 2026 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678756;
	bh=6DnD0ERJEjy82XS2qztXwiX3wlv4q+LQrDFFVZf8mKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LUkan6tp+t9+xkSlDkdVdu+VhjTcLDaJ15jrfZbJ0KCQHyoDCmkBTfPrPJrTVRyrx
	 MsyNwaIkGqXupHpT7VyJ6VUkWHlsPniqNmIAirG7hcGtcZIzxBkFn2zfZr9zCzM0Iw
	 eXXHt5o1KTS3DOXc5R/k0jOESiJNvUyB1OKJimGuKEFnbAz1TLC23kYTNQmZ8CDoai
	 fHCNAB34w/YQr8ihy+24iscloBE2xXWNZQly64OFFQXm/AN3PGwOS+u0UM6SInwQGd
	 lZxwI1H/IU04/RMESBZbTdN2owYpJZPyxpWYqf+jNzb2A2I7RREDqmmgIfgtXr339S
	 C79Wfxhd7ExdQ==
Date: Sat, 14 Nov 2026 18:52:32 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 09/19] string: Make strstarts() a legacy alias for
 strprefix()
Message-ID: <avifcIDnASrpmwJF@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <212e7fc2cb99b631c493f59b8b38e1fd3db81231.1794667407.git.alx@kernel.org>
 <sashiko-outbox-214720@kernel.org>
 <aviDEUMYSy19Ce2P@devuan>
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
	protocol="application/pgp-signature"; boundary="57smwsejatqietde"
Content-Disposition: inline
In-Reply-To: <aviDEUMYSy19Ce2P@devuan>


--57smwsejatqietde
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 09/19] string: Make strstarts() a legacy alias for
 strprefix()
Message-ID: <avifcIDnASrpmwJF@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <212e7fc2cb99b631c493f59b8b38e1fd3db81231.1794667407.git.alx@kernel.org>
 <sashiko-outbox-214720@kernel.org>
 <aviDEUMYSy19Ce2P@devuan>
MIME-Version: 1.0
In-Reply-To: <aviDEUMYSy19Ce2P@devuan>

> Date: 2026-11-14 16:51:58+0100
> From: Alejandro Colomar <alx@kernel.org>
>
> > Date: 2026-11-14 15:33:19+0000
> > From: sashiko-bot@kernel.org
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue to consider:
> > - [High] string: strstarts() macro expansion shadowed by local strprefix
> >   variable
> > --
> >=20
> > commit e4b277f22320c7ff4dbc9e8cc88221ad43eb8ba6
> > Author: Alejandro Colomar <alx@kernel.org>
> >=20
> > string: Make strstarts() a legacy alias for strprefix()
> >=20
> > This commit replaces the inline strstarts() function with a macro alias=
 for
> > strprefix().
> >=20
> > > diff --git a/include/linux/string.h b/include/linux/string.h
> > > index 013c6169def05..0a466360dbb39 100644
> > > --- a/include/linux/string.h
> > > +++ b/include/linux/string.h
> > > @@ -609,6 +609,7 @@ static inline const char *strprefix(const char *s=
, const char *prefix)
> > >  	return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
> > >  }
> > >  #define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, p=
fx))
> > > +#define strstarts(s, pfx)  strprefix(s, pfx)  // legacy alias
> >=20
> > [Severity: High]
> > Does expanding strstarts() to strprefix() break the build when a caller=
 has
> > a local variable named strprefix?
> >=20
> > drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c:hp_populate_secu=
rity_buffer() {
> > 	u16 *auth =3D authbuf;
> > 	char *strprefix =3D NULL;
> > 	int ret =3D 0;
> >=20
> > 	if (strstarts(authentication, BEAM_PREFIX)) {
> >     ...
> > }
> >=20
> > Because the strprefix() macro expands to a call to the inline function
> > strprefix() in the caller's scope, the local pointer variable strprefix
> > shadows the function identifier and breaks compilation when
> > CONFIG_HP_BIOSCFG is enabled.  A later patch in this series, commit
> > "platform/x86: hp-bioscfg: Rename local variable", renames that variabl=
e to
> > prefix and should be ordered before this commit to keep the series
> > bisectable.
>=20
> This reivew is wrong.  A local variable cannot shadow a macro.  Also,
> a function-like macro is only expanded if it's followed by an opening
> parenthesis.  In the case of spmobj-attributes.c, the local variable
> doesn't have a parenthesis, and thus doesn't trigger expansion.

After looking at it a second time, while the report from sashiko is
wrong, the code is actually wrong, and reordering the commits would be
appropriate.  I'll reorder them in v7.

>=20
> >=20
> > --=20
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.179466740=
7.git.alx@kernel.org?part=3D9
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--57smwsejatqietde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4n9oACgkQ64mZXMKQ
wqn94A/9GpJCSpka7wT82Abxs2fiQNZNwK2Q+QgOzL+PNv3wcF4mTe02uzPwmuhN
I/jnDKuIEsEcoDKoZoZn2l4hNAckN1WOc1oj9+KBsX+bS0haexRX9zYvbWybbA8E
A+5DmBX0zpCoi1Pj6rBE0hGP/21XUWzCicK4SeRXOBom/teBvX9npqIkJMJZvcs9
OzSTePdutBFwD4gQCLGYjgFOu5+wOEAAgaI34g+gyhwzfiCjmBQfD0IMwlssn26Q
K2mUegNaQkpoMtHG1ynoBIi1BjCx6lzt+WK+cpVaB7SEShH92yw5bAtEG1hdGkf5
c7znVdPLLWbIBQR9jiZ9HnJmy8wOWsGHNF0yDk4w8PA6Cd+E2lXdkWpDZyQMkNk+
HdZbhB5Qa02mzvB2htBUVEr1LjoeMgL1vGx4qp10hmzDHaPcgQIs77oKDWU3JkjJ
fKXW7QFaCOSucMsJNLCGTMvG0bIt+fIt/mPi105xMU2aPigfzECPUhkceSUg8okf
4iLYQP0BgvJ28qhz42HRMPjBqffM/TgKbx4YqoadTzfcsY+wDkWa5peG1Hex3KUe
gJ0kBAs4V299DdAdBqYnTPRt19OxvsjNNkfZmdDjf4uPFeIyH4qcXZPE7SXy7988
tza8A9EsD3HHV6eZWZdih6Ohiv5oZATtw+Y+AmMxR3eGKqG54YA=
=RYYB
-----END PGP SIGNATURE-----

--57smwsejatqietde--
