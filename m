Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671282;
	b=cY7FnbKkl1vubL6uUvmuSvNg/g+foFsMxAt5bdz0UtDE+4ybrPNXDMu61gmHeKLwFd/Q
	 6GQzm0hkqE2FX1p43iDMEq1y+K4f8vz7Wop6HumSrCXx/N/PO6PGJxN6HaPx5+HQcIuct
	 D+joiPS6mDfa+hBVQiLBdIiYveNIxrq4Sb95T6SfWxwy/17hBxNDaOz/umNYUgWjredry
	 /j+keA6eO5aPty6O66/Tj6gXP3Ebr7+k/jDWqsQpvMejc2zzeJtTTaYYLWbx8RKCbb0Qo
	 bOhD72w8gLLRc84DE2dXGMsY6s1nZO4nQOGDz3KJindIhUFx8tYfqqv4XrlCVKMr1Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671282;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=C+dqSjNjF9Sl+zA2nPwgsKw9ujFKlrdNxWlzU1i+sSA=;
	b=1bAEkCVJqwYs+Rz9oONrucC3DRYpzVcakY4ePXzK8O7TtNYJMDKRrI14dLYAwt/E6vCW
	 g05xl+oWTVZCX0MaIkH51EJRWYOXnFnXhhBrclCw8vjKmhxHRet6ORn8n2oR+6A9zudrk
	 hyJDFlXJJaT/StRS4FcWbFFCLUn/SGGh76UGFfUF65l2LoPCpPDma0j5J9twCZCV1Iw0W
	 UDZ3qtL/QtOob7aiT9+ouLMEnLkqwD2V8Rvu3m2PysCj8IVGod12b3k1hpb7JIRc8ULPD
	 98AaUx9Ydqn+n9S4thozTEylrQTJeid1eahBBuQS7M7eP9LimUdAEM7PmhSRQYd4pmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COgOFwJH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D6606A32D;
	Sat, 14 Nov 2026 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COgOFwJH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BC11F000C4;
	Sat, 14 Nov 2026 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794671282;
	bh=C+dqSjNjF9Sl+zA2nPwgsKw9ujFKlrdNxWlzU1i+sSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=COgOFwJHEJZaAAfWoFTfiD7K5r74SN6vU/uAs4rN1Pe/z0jTFPgjUsnHXKPE/HNt+
	 I5aXMHKfHsNxp1S7RX62dz8EuEibpVCINUOIZMs9el1Y6KSFGIJDYxmszME1NKGcW+
	 yrdN09ZTJ9d9KwycXpyATRJcGxSDSqsNZlEnJh8GVpWgK1vDeZvfTKelIXlVsEJxPZ
	 ee166bzhsuJq7HHavfSbKivtabCu/PpGdj5MKWsqZh05tVP90AEkT6RIl/22rWR/AN
	 SQSr9Idl0NVOE5XgAPoCJSrr7eMS6GWU/iKnQ1u+8+P3sYQ7MKjv+wgv0Z/rbnvG5L
	 ur2XGD88JIzxw==
Date: Sat, 14 Nov 2026 16:47:58 +0100
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 15/19] treewide: Replace some uses of str_has_prefix()
 by strprefix()
Message-ID: <aviCffxC8LvSWW87@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <95bfed420dd9616707e640708245ce2aebbb6ff6.1794667407.git.alx@kernel.org>
 <sashiko-outbox-214722@kernel.org>
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
	protocol="application/pgp-signature"; boundary="ua7yryicvytvc3i3"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-214722@kernel.org>


--ua7yryicvytvc3i3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 15/19] treewide: Replace some uses of str_has_prefix()
 by strprefix()
Message-ID: <aviCffxC8LvSWW87@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <95bfed420dd9616707e640708245ce2aebbb6ff6.1794667407.git.alx@kernel.org>
 <sashiko-outbox-214722@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-214722@kernel.org>

> Date: 2026-11-14 15:34:40+0000
> From: sashiko-bot@kernel.org
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] tracing: NULL pointer dereference in trace_set_options()
> --
>=20
> commit c09c1b839b46a18b156e43281c4fb679a76cfe40
> Author: Alejandro Colomar <alx@kernel.org>
>=20
> treewide: Replace some uses of str_has_prefix() by strprefix()
>=20
> This commit replaces several callers of str_has_prefix() across the tree
> with strprefix() to avoid manual pointer arithmetic.
>=20
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 4ccdefb5c3efe..f9f3faaede094 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4085,19 +4085,18 @@ int set_tracer_flag(struct trace_array *tr, u64=
 mask, int enabled)
> > =20
> >  int trace_set_options(struct trace_array *tr, char *option)
> >  {
> > -	char *cmp;
> > +	char *cmp, *p;
> >  	int neg =3D 0;
> >  	int ret;
> >  	size_t orig_len =3D strlen(option);
> > -	int len;
> > =20
> >  	cmp =3D strstrip(option);
> > =20
> > -	len =3D str_has_prefix(cmp, "no");
> > -	if (len)
> > +	p =3D strprefix(cmp, "no");
> > +	if (p)
> >  		neg =3D 1;
> > =20
> > -	cmp +=3D len;
> > +	cmp =3D p;

Ouch!  I meant to write 'cmp =3D p ?: cmp;'.

Will fix for v7.

>=20
> [Severity: High]
> Does this set cmp to NULL when the option does not start with "no"?
> strprefix() returns NULL on a non-match, and "cmp =3D p;" runs outside the
> "if (p)" check, causing a NULL pointer dereference when cmp is passed to
> match_string() right below.
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794667407.=
git.alx@kernel.org?part=3D15

--=20
<https://www.alejandro-colomar.es>

--ua7yryicvytvc3i3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4gq4ACgkQ64mZXMKQ
wqlnaw//SGanRpCyPt2bQsCGLXaJBvRcIr/FVgNv3q1+lxemh4dSvR+KIbSdKXK6
CoV2TKWU4KAJpEfhmxWk+gfnfE+yHlh6+hNy8clN1BzhrKr2EMmHUa7ThCK0fOqQ
6UBhW9PYk/F9t4Qwph6Evuv1X5DwMSVATrRGC8v8lsQTqbT47MAUkG24w+xSsgYj
uw/fCmtvQ8aYCmi5dwmxejKDSqbWHIT2OjBEvytOgfQlOcoHKwQyNvBwaeIbR05r
TtPCCC7N8lK/grWDHWNudPH46lelourIjUrQeN1JeUF8+xrzP/f0i39d2tbF4VwU
L6Uwu17RRophjGmgT5tmf/zag0zXEXF9AhRntXQVEES86Lnlugrp7DRqGZDC0IvN
7/rNixsRTJ5r0S82F1dVGdMUb9zot+AS1e4y0e7Xy0g1vg2CiNWjXxgIQCQkbX/4
E9bvCYHMgChcn9HvdFu9HwXV0pqyJS6JsPUc/Cv4MIFwtYZ8K68PMzi3O6jDc8UF
BQW/epzYJc7EZQahIpYEF5UtZruup3AFTKpR5WSB/8UCFCAe7+E3YE7QRMa5CVTf
uc7yVudWhfiLFzJ9BhHy5RGaAcZGk0qICTaH1El1pehn1uEhG/PDIYR/iS8cMPAU
EzURcit3olzuai9mRriVQP/xFZtkg0V+wH42G7kRJJ6Bbc2KfNQ=
=rno2
-----END PGP SIGNATURE-----

--ua7yryicvytvc3i3--
