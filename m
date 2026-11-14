Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671518;
	b=49GCTNxDnE2m6ovRMnUl6mQpeKeKxlwXrwKA8gor3tkiaEX8dyWH0YfKv6c/79p7XoB/
	 J5JZXzNjSuQVTA16urEEBb0/v7i3RBFvyrqN0AL8ADr7mVcHDS/xfYaO+DqdVtpCOCrKG
	 xpWLs234H7Qc5iAPv5E1zax1+UDBwqU+/R0vcLVlyDoVtTx+Rj9JlgJEEiUrA/efUj94K
	 W04Qv2nZYnba9ChzLosjniF78keAZTnqKqm5YIKdoxb49FYodPVHmv6Q4ganIoVowlGVk
	 RVeh9eqBNy5CZQ8XjiHpUVd3Z0d3nrpEFGAo1Ooo6nFX29iNfibNuhhjqCh2olUxX6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671518;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ay+4tVhIMp+XOI4JVfrSEwfzZS0QIhMQhkQl15NaVGg=;
	b=09UKs3meGaBk3YUN1H0PRg/wiZpvTcTbseM5axPun9Y2PeU3OKuV5aFTNFlG+S/WeFGG
	 G5TPBUzBc4mkC+eIK6jzF3+vzTv5V7ROxEJBX428xVHI4XqCAAahU2dtJkYRDoG8u0740
	 AO6Y28erGHywFHJbey/bvSyiGfiPDFv2vIBrXOw0xx+gpFHahusM8acEMAP112ZVzxw0w
	 xkHgSRkFp7auPPW6cvUh9XEk4wCFSGPD4YAgtgHqlH0A4thcVRxO5Jz+u8lsPCQdi2D0c
	 3WXUHsu/6s/DONz1CiisQSvY0NTbcqcz1qBeHScF1Gjc5IrlRKKc9YScrToiEZt7nhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fI+WIJxv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B5606A327;
	Sat, 14 Nov 2026 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fI+WIJxv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EAF1F000C4;
	Sat, 14 Nov 2026 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794671518;
	bh=Ay+4tVhIMp+XOI4JVfrSEwfzZS0QIhMQhkQl15NaVGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fI+WIJxvVDi8sUkeBnt+UyOUFmChw37gp0llcUVcGMcI/r7TEkC0ay7x59CVpk39H
	 QGCF1SWaNjmwTvZ3QP/40ysmgTOmx9kmvRQlwp/V65Sc37MgXD7AWdyi8UBdufMjiM
	 6JuhfhmW0iSuGGQzOl+sZ1dNnjDO02sYeDW4O48TNLIf8DFsPKgc6Lhbba0tEAj77V
	 dtYC4XTbcXQmw0/tvA8ja3/zJOvRElvVoM2B/LGi5uwwLlAnuPAw2x0yrSEtJqhHK1
	 d+XiNfa4rghcAWfH8QUYmj5fUiU71rHOddkOHNc81YnCHVze5L/Z9VEoCwSXfgDalp
	 ABB7xl4PyhM9Q==
Date: Sat, 14 Nov 2026 16:51:54 +0100
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 09/19] string: Make strstarts() a legacy alias for
 strprefix()
Message-ID: <aviDEUMYSy19Ce2P@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <212e7fc2cb99b631c493f59b8b38e1fd3db81231.1794667407.git.alx@kernel.org>
 <sashiko-outbox-214720@kernel.org>
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
	protocol="application/pgp-signature"; boundary="pzvscjedtxxqgz4u"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-214720@kernel.org>


--pzvscjedtxxqgz4u
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 09/19] string: Make strstarts() a legacy alias for
 strprefix()
Message-ID: <aviDEUMYSy19Ce2P@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <212e7fc2cb99b631c493f59b8b38e1fd3db81231.1794667407.git.alx@kernel.org>
 <sashiko-outbox-214720@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-214720@kernel.org>

> Date: 2026-11-14 15:33:19+0000
> From: sashiko-bot@kernel.org
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] string: strstarts() macro expansion shadowed by local strprefix
>   variable
> --
>=20
> commit e4b277f22320c7ff4dbc9e8cc88221ad43eb8ba6
> Author: Alejandro Colomar <alx@kernel.org>
>=20
> string: Make strstarts() a legacy alias for strprefix()
>=20
> This commit replaces the inline strstarts() function with a macro alias f=
or
> strprefix().
>=20
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 013c6169def05..0a466360dbb39 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -609,6 +609,7 @@ static inline const char *strprefix(const char *s, =
const char *prefix)
> >  	return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
> >  }
> >  #define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx=
))
> > +#define strstarts(s, pfx)  strprefix(s, pfx)  // legacy alias
>=20
> [Severity: High]
> Does expanding strstarts() to strprefix() break the build when a caller h=
as
> a local variable named strprefix?
>=20
> drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c:hp_populate_securi=
ty_buffer() {
> 	u16 *auth =3D authbuf;
> 	char *strprefix =3D NULL;
> 	int ret =3D 0;
>=20
> 	if (strstarts(authentication, BEAM_PREFIX)) {
>     ...
> }
>=20
> Because the strprefix() macro expands to a call to the inline function
> strprefix() in the caller's scope, the local pointer variable strprefix
> shadows the function identifier and breaks compilation when
> CONFIG_HP_BIOSCFG is enabled.  A later patch in this series, commit
> "platform/x86: hp-bioscfg: Rename local variable", renames that variable =
to
> prefix and should be ordered before this commit to keep the series
> bisectable.

This reivew is wrong.  A local variable cannot shadow a macro.  Also,
a function-like macro is only expanded if it's followed by an opening
parenthesis.  In the case of spmobj-attributes.c, the local variable
doesn't have a parenthesis, and thus doesn't trigger expansion.

>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794667407.=
git.alx@kernel.org?part=3D9

--=20
<https://www.alejandro-colomar.es>

--pzvscjedtxxqgz4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4g5oACgkQ64mZXMKQ
wqmwHhAAiFVjyiefbzb/8bh8qNeVDW7MN5bBDviUhLr9ZdbHwxFsBd4fmeH3wVPh
pns7YoLgPS42KCZODZy09iExymulnFs4F0axM0xn+bhjxYBBrv2LvZvIaLAPNfQ/
wpWVn7/b7hSMnH0qwQBWcdX1zyXI6Br6oz7kPNf8U6fFi6zxrUNJPdnA86zhgoUn
Ut8oExqMGwnPVif/FLMuSdbpOxDMv4ZLVKgnly3qSJss7uJyk9dalcjqgtqaBdEn
Ii3HeNXZhQMU7yDbhom8bfGIrRoCdJaOA3dbUnvLU4Ouc2CSNc/bGnsih39iLES9
sB0qjlGW/+iEbfyjTlCqMBhztkMZ9xB/p7A7wuPiPDrMLw2p2dnSawkMrTBpr63k
k877MyHmkdLQbp4/dUhmGd7mZdj/l1TJo0kzShnsxbJJB06ALcPVEcwUHMpyRD+J
gdAkeqyUVJmT6RSHDYqoeIAFaFF3mEVlk+5M0WSqxj9JpSvh5ev7cXhm03Sgzxzg
J1OFd8tG+kG4gC9nN2Wpw4AxMTB8NDIew1Kl8DrAjWCixVzh7+lm/n5uaZ6eXQyD
TV4J5zsOLX+gMjVuHXunK9GIOv3MA+jkGIpJZHhfG5Yw4SSNi0AtM2FMluwNmEyA
25YPsspTgmfei3yh8/i8Xal/hk084tAPVY10+4CAhm+WzAPpjfI=
=mfNa
-----END PGP SIGNATURE-----

--pzvscjedtxxqgz4u--
