Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138896;
	b=RUa6UIZZXJXYUsq8t4IvV9zaacHSx5no1jsyGl7IVVgy3ezhWbeIgN9CtQSBujR+ouHh
	 /ZUCmgwej2sqw9ln7fdGST/rJoQskwF96N8FrzwgxKeWgLm6APJ3UE/3Q2LDF65/zRfzk
	 PQ1Mk2fxNxQKtC1ytRC3MOUwPJRwund7uqq6aYS6Sfx1Tydf2C3EAtFIk56ENTdKIKkQ3
	 SZXY+IvN3U55A2IZoBBtvSgssZwe1LVgE1gFaM/z9pmwVq0MXeZObl1ujpn1DAyS1UddL
	 CIYghjnesQ0HY9awJEBn0d25CMxnZpGEBHCOzITu2ffWvFnOLKmiwF0BMPOXmiwyeZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138896;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BHVUQx1P4ANp37N/y+cseBVegL9EZWxWZ+7QojdeYnQ=;
	b=KhNPaWV5qsUQ977bxH6RPdDdA9F7gPq/wyLCbv4Vc/euCk2dMeGec5JBWvDktYNr2gdR
	 nIa5Ixv+zDfe651ELU+d+rK/GWNtKX+v0HFrD2AmhR2tMQnmWtZMM7992g5M8+71blmg4
	 IZlsUR4WvbkYgW+1n88ovaBSVJxmCy2n1o1PGniJue0E6pMZ97rtkAbW9mDS9/NG7ffXi
	 9125MA4DgaoreubqYgp3pIl7R/QHOet8DpsEviHf/0Doc91rXXIT10TyDfiUBWWMnCbpp
	 c4rhqDbBSi3pLnVole9TQ46iWV8CcYp9U+ah1r7AweyrZfMzheBoeKlNDsHmt8EsZdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRmer0kb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40A606A31C;
	Sun,  8 Nov 2026 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRmer0kb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BF41F0089F;
	Sun,  8 Nov 2026 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794138895;
	bh=BHVUQx1P4ANp37N/y+cseBVegL9EZWxWZ+7QojdeYnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NRmer0kbeW5B6STgfperEMCztCA8C1eXyYu5SPaggrJzyVxMju+AEJE3D5Mh5ap2m
	 UeRATlnCLYQCXhwHuherqkeT1onfsqcTveIIPkGPdk5TL2Qi3sUaBBSypboA9pkCRy
	 YMwnHpP/dNz7obras9Q1ZuqI5LQrhHYvi8CGLyrSvtsG6exkK7wbuE5q9NI49YCLVW
	 LnoXF2lRqilrVylImSjSVBSGTbR3edGrI0WybEfk2szZfi9Pt/Kj/kX/lNykMlzhBK
	 L8e4s0ECglJREOZYbJzLa5oJo8yxZjfzNDTZ6EF8ZPoXNHn93yImHR/sOKkEz3/aMP
	 brG5oCZCJr90w==
Date: Sun, 8 Nov 2026 12:54:33 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, andy@kernel.org, bartosz.golaszewski@oss.qualcomm.com, 
	brgl@kernel.org, dakr@kernel.org, devicetree@vger.kernel.org, djrscally@gmail.com, 
	driver-core@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	heikki.krogerus@linux.intel.com, hverkuil-cisco@xs4all.nl, joe@perches.com, johan@kernel.org, 
	kees@kernel.org, laurent.pinchart@ideasonboard.com, lenb@kernel.org, 
	linusw@kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org, 
	rafael@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	sakari.ailus@linux.intel.com, saravanak@kernel.org, schwab@linux-m68k.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, zanussi@kernel.org
Subject: Re: [PATCH v2 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avBikocxPXRos_GF@debian>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
 <20261105125154.83478-1-geert@linux-m68k.org>
 <aux8LYQkGSNjCGHv@devuan>
 <alpine.DEB.2.21.2611070223510.17804@angie.orcam.me.uk>
 <au7TvMP0YhW2e_oM@debian>
 <alpine.DEB.2.21.2611071115110.17804@angie.orcam.me.uk>
 <avBglVuXPjbKnWwl@debian>
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
	protocol="application/pgp-signature"; boundary="z7wg63skqeylt2ym"
Content-Disposition: inline
In-Reply-To: <avBglVuXPjbKnWwl@debian>


--z7wg63skqeylt2ym
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, andy@kernel.org, bartosz.golaszewski@oss.qualcomm.com, 
	brgl@kernel.org, dakr@kernel.org, devicetree@vger.kernel.org, djrscally@gmail.com, 
	driver-core@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	heikki.krogerus@linux.intel.com, hverkuil-cisco@xs4all.nl, joe@perches.com, johan@kernel.org, 
	kees@kernel.org, laurent.pinchart@ideasonboard.com, lenb@kernel.org, 
	linusw@kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org, 
	rafael@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	sakari.ailus@linux.intel.com, saravanak@kernel.org, schwab@linux-m68k.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, zanussi@kernel.org
Subject: Re: [PATCH v2 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avBikocxPXRos_GF@debian>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
 <20261105125154.83478-1-geert@linux-m68k.org>
 <aux8LYQkGSNjCGHv@devuan>
 <alpine.DEB.2.21.2611070223510.17804@angie.orcam.me.uk>
 <au7TvMP0YhW2e_oM@debian>
 <alpine.DEB.2.21.2611071115110.17804@angie.orcam.me.uk>
 <avBglVuXPjbKnWwl@debian>
MIME-Version: 1.0
In-Reply-To: <avBglVuXPjbKnWwl@debian>

> Date: 2026-11-08 12:49:08+0100
> From: Alejandro Colomar <alx@kernel.org>
>
> Hi Maciej,
>=20
> > Date: 2026-11-08 11:05:51+0000
> > From: "Maciej W. Rozycki" <macro@orcam.me.uk>
> >
> > On Sat, 7 Nov 2026, Alejandro Colomar wrote:
> >=20
> > > Hi Maciej,
> > >=20
> > > > Date: 2026-11-07 02:44:23+0000
> > > > From: "Maciej W. Rozycki" <macro@orcam.me.uk>
> > > >
> > > > On Thu, 5 Nov 2026, Alejandro Colomar wrote:
> > > >=20
> > > > > Do you think strafterprefix() would be better?  Do you have any o=
ther
> > > > > suggestions?
> > > >=20
> > > >  FWIW strsuffix() seems an obvious choice to me.  After all what th=
e API=20
> > > > does is request the string's suffix beyond the specified leading pa=
rt.
> > >=20
> > > Actually, strsuffix() is something else:
> > >=20
> > > 	char *
> > > 	strsuffix_(const char *str, const char *suffix)
> > > 	{
> > > 		ptrdiff_t  off;
> > >=20
> > > 		off =3D strlen(str) - strlen(suffix);
> > > 		if (off < 0)
> > > 			return NULL;
> > >=20
> > > 		if (!streq(str + off, suffix))
> > > 			return NULL;
> > >=20
> > > 		return str + off;
> > > 	}
> > >=20
> > > It finds the start of a suffix in a string.  That is:
> > >=20
> > > 	strcmp(strsuffix("foobar", "bar"), "bar") =3D=3D 0;
> >=20
> >  Hmm, I'd have called that strskipto().  If that's not possible for som=
e=20
> > reason (I can't see it used in Linux), then strskip() or strskipover()=
=20
> > could be used for this API.

Another issue with the name strskipto() is that the name doesn't make it
clear whether the second argument is a string, or a list of characters.

That is, would strskipto() something similar to strpbrk(3)?
It's not clear from the name.  From strprefix() and strsuffix(), the
meaning of the second argument is clear from the function name.


Cheers,
Alex

>=20
> strsuffix() exists in many projects, and in all of them it seems to have
> these semantics (or very similar ones).
>=20
> Just look at a Debian code search of those names.
>=20
> The strprefix() and strsuffix() pair of functions are widely
> implemented, and while the exact details of the return value differ
> slightly (some return just a boolean, others return a pointer that can
> be used as a boolean too), the overall semantics of them are quite
> consistent.  strsuffix() has less drift than strprefix().
>=20
> If we added strsuffix() here with the semantics commonly attributed to
> strprefix(), and then had strskipto() with the semantics commonly
> attributed to strsuffix(), I'd expect programmers to eventually get
> confused and use the wrong one.=20
>=20
>=20
> Have a lovely day!
> Alex
>=20
> >=20
> >  FWIW,
> >=20
> >   Maciej
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--z7wg63skqeylt2ym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrwYvkACgkQ64mZXMKQ
wqkx6BAAlb7cMjGl5jTUSPTQsPNzOhKUBvaTO4Y15M+n+/XhKFuxB6LuZ//e8tqm
Cw78YmBH0aqOPJFdgp+n6wQq8hEO8uF9/e/tw842SQps9qSCoPzKRVSmb2l3KjvO
6aIUau9u7I2t6Hc1nLyR5bIRvpRBN5SLCOGAJJOpEqgXamBS3hJtzpLQpHlVL/k4
RaDfQh9HeQsuVFMh2NxNsBEAao+Ooj0X+LklJCQI3Oddz9+sxUGQWt556jYS0LHT
h2i2EckYB3WwbjZqUZA3aSAUeQp5n3JfS4UcLl2j+S30lB3StB7iVVNPd9198SyZ
RzcKtU0ecxnBkLE0wKJGkZ2iuqSXR5rUxTOQb+S1hwbsORhNQVsyd7t67GTFX2oM
86gXv/0pH3LJfbnMgTjgn2FPfqRVLrH4CQQouvsxInL/j/mLcdOFi40GqVzyUw/P
2t8E2bE21ZCIdL8/vrOJhPxcLdrRZQbOHACb5CWp0Z4wnSOoRoVi+UA+wTW6V7Lf
NfsBe92am3aFory4pzqiBScjkPux01+LOOouj3rTnD/AzOEHDNS7yDsCc5aNvDUC
LlSxy7b3BuJRnsAeMnOMNZ+MXlP6HDL0UmaXumT97Sb1HlMf6BAqoMVzr0D4CyJ+
I0HHWr5h/yKJl2GcovzTcmXIcMNBUsKnM8bJTvmbLRbsN1t9628=
=TmP3
-----END PGP SIGNATURE-----

--z7wg63skqeylt2ym--
