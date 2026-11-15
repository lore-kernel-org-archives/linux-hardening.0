Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730182;
	b=ZFD87Us69bS/fq+0yu8vQAQZylRutfpXBOxshOR+lIA+0E8rHtKUAAsMq2+hVzH3XblV
	 OQthAjmcUfcpF6TgB4rK10qbWiOtyhCfuVPo+I5IM5yU7sgpg/ZcM1/rBqffocWSfZPLx
	 C4RGBmdRx34ftO3iRz7EL8o5ARbxshZSCj/zOK1YJq5bNloZJ4vbHQf2TsPFYvUmphVmj
	 SlIvBTWOK8EsAz0mhTpVJCJQJUfWOAvhOtRpkQo165rIvweUwGkS3L3TFeWgeyE2Qfpe6
	 G5BxFggJwfJuBQzaMaIbu6WvAjH91kMr5cVvqXuj9ctCcOvOyn6IfjmMBjLItOCKtvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730182;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PVABOfS1cEurhkzfPgNW7y/m51HDn6cHLPvuC8JTSz8=;
	b=i8X8/S2NQHaS5m9CVjG1JCRucoQNH+OE4YlH/XjLXgCKDJi+HKBsP+bOF/9WZfiJ/hG2
	 RzIG1Wa/KFrvB/1aTtOxk6QV5Oru6ObmVlDnEzMTDlv7hSHyaG1jcdr3dRDkIrMZ9vl+u
	 zzEDDcivt3WGcHzJkcHGDhxuMniibGavWSe1e7fIlW8frTttR/kWod7HitHeTNiVmD1Uf
	 fYSQz2lSg03RYJOa/lWfdbhxwSXgjp3Zz5wsUNDddgFkprZmrL2uaRrSsaT9z+e0lGWoL
	 xeNX5zqv9X/iTdlG1R+7WX+jCR4ejOYKwrgvZ9JAah43/D9pvvhsAKdEenHgYW1VEzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QW0De9hp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292160A260D
	for <linux-hardening@vger.kernel.org>; Sun, 15 Nov 2026 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QW0De9hp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407B71F000CB;
	Sun, 15 Nov 2026 08:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794730182;
	bh=PVABOfS1cEurhkzfPgNW7y/m51HDn6cHLPvuC8JTSz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QW0De9hptRjy2KZNabzhVfAHPwOkxjEeSliCim/i93Y3NDLIDeP14qCa9DdzlpqUN
	 zmDB37zlSxtnqXhlHuRBsYIeMT8izcsL1Q1ogX8eDw8d56IV8v6EAQ1K8A18Dz9+Se
	 UrcQjgxq5oO64Q9oVPCvgLGZAZWAuCugGufIWUNue8BCV6qUue5nHaI5vxUlzyqVQ6
	 CkBfKHzgMEmJZ3jKqixj9RW1vIXt+2lDHWlcjDjtx7e7lRcv+7aqhqCXozDYGRcpjz
	 XVA4gHNBjwBH3+2q06vD2Zr0Ix14icSdyZSz7oYBvJl8yfGhX1GKchRHxWVDIdzgte
	 Pd+WZIExrfYUQ==
Date: Sun, 15 Nov 2026 09:09:37 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-hardening@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] powerpc: Fix off-by-one bug
Message-ID: <avloOrDZrYtSsQUN@devuan>
References: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
 <5wxy8x3a.ritesh.list@gmail.com>
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
	protocol="application/pgp-signature"; boundary="veg2gn75rklmo5ow"
Content-Disposition: inline
In-Reply-To: <5wxy8x3a.ritesh.list@gmail.com>


--veg2gn75rklmo5ow
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-hardening@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] powerpc: Fix off-by-one bug
Message-ID: <avloOrDZrYtSsQUN@devuan>
References: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
 <5wxy8x3a.ritesh.list@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5wxy8x3a.ritesh.list@gmail.com>

Hi Ritesh,

> Date: 2026-11-15 11:17:37+0530
> From: Ritesh Harjani <ritesh.list@gmail.com>
>
> Alejandro Colomar <alx@kernel.org> writes:
>=20
> > From the surrounding similar calls, the intention seems obvious: this
> > seems intended to check for a prefix.
> >
>=20
> Could be, however the existing code is not functionally wrong either.
>=20
> I agree it would have been nicer if all three were consistent. However,
> x86 handles the same parameters with exact matches, so if anything "auto"
> is the one doing the right thing here :)
>=20
> But making "on"/"off" exact matches on powerpc now could change
> behaviour for someone passing e.g. "offline" today, so I'd rather leave
> those alone too.
>=20
> > However, I do not understand this code, so take my reading with a grain
> > of salt.
> >
> > Fixes: a048a07d7f453 ("powerpc/64s: Add support for a store forwarding =
barrier at kernel entry/exit")
>=20
> IMHO, I don't think this patch fixes anything functional. So, I don't
> think it will be correct to call this as: "Fix off-by-one bug" or=20
> add fixes tag to it.
> And so, I would suggest, we leave leave today's code as is, based on the
> previous reasoning.
>=20
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >
> > I found this while looking into replacing this code with calls to
> > strprefix().
> >
>=20
> For your conversion, I think, we should keep today's behaviour as is.
> Maybe streq() for "auto" and strprefix() for "on" and "off", which means
> there is is nothing to change or fix.

Thanks!  I'll do that.


Have a lovely day!
Alex

>=20
> -ritesh
>=20

--=20
<https://www.alejandro-colomar.es>

--veg2gn75rklmo5ow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr5aLkACgkQ64mZXMKQ
wqniqg/8CutNlENieQ6OMt7rTaU5Ueh09KVjFCccFeN531lxYl6K5HohatSFUlMt
gIvBtcGIufRtv1+coLDMGQl60zD2JnKFSDPio22TZdBpFDSJPz0NE5rtUT5wEqI8
uqB4kESHZ7Q0HfM9fMNXYCWQNhzH9t0Z7BZWOOYcmegNMGadRicX9L7Uzjk54eKm
sOiZghHRUWDapGFe6neCABjMT0Y1rwWrLwOh4cEIKnK9/ZoVdbJNaa3j9xv9Gaw/
pIF/KLkIworTgnBHQ254B1FNLE5oVE7zHO8FBiL9san+r3IKaHvE8gPBCzPnCFFG
WbUrtXhDxb9at02GQhFxiTWPhz1U+Mh/5MLy8F8YUPb+e7BVftmsKiVgC9T1eSKg
zaow5hwdSlEF/6AcpmMRNKjKljFw+jK81LdZz+iZui44J4rB9t0yw0esJ+KgVUxP
WXy80FGBBAkSygDStuz765Rff2ekjSdhaqFoDPheTOUekH9QiooE6yAqPWvTRUOX
t7Ij+RPhsvb/Q34N0Uo78wxpWJ3H49prwRUWKs30UNGco9zWR1AAzBYZGFQ7KM15
L+pGkMggrwQP+T+qIfxYPkKmTzULSllUBrLaTmnNludwihKfxF4ImmnawooiLQu8
XkcIyOkD1oy95spXFeLC+daHWjpwOo+A7/aIM4JhmbHAgdJhEYY=
=9tNy
-----END PGP SIGNATURE-----

--veg2gn75rklmo5ow--
