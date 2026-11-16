Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833101;
	b=hd48KRYRxDTe5DpujCJ88CBZw+uVnEDmY+KLBYoJ2ybiWG9T1loL4rn9RcYOST+YjpX+
	 R4UOi1UEV7W8SyWmAkbEkzjPjxOdKxZirYPyOFGToPibmtLdrzbEBej/FmrN5wdv9PbHZ
	 Z188YkMgXVUCGLKWiwrxh+b/rMPhnh6jlLkCl8Jls8aoU1uXb6iHuKDcRmlN6enMNmEkR
	 8cZ6lA8pMpXNTVLx+aPXtjGcrx0KcNJPK3RG55vH3nfZeJhpdiaJKUf6GQlKYZLgRiyAX
	 LN9ZZCCDU+PPMuN4GdcYW6KcrO8dpWONktSUKGQed6FXtp/ldxgHL5DW88Ei22H/LTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833101;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Gd3JtHSjhZkWyKm59T5sGeqovV+uq4UZpWkp1MKhIxA=;
	b=HAPiSkphzVU2J3MN4k8GiQoAsnhSppWLK2QIpeT1gMH3cXQ1C6CBB33w/wYIHA7Q21iI
	 2mPbJci1O/YdTskKB28vYkF1tcXGQf8q6dtjAG0RsTKxn8HPhQndiGoThUnZxYoGNF2JT
	 UReei9Bq81aDYwg4i8G0K1VCdthhebXJX4zvrRd4asvZf7LCaagXYy7UbBjhsOm97zKJs
	 HFj0p+1KJVqeuLPrjBQtcKRrXlmYJ9v8TASX8j/R/lkgvysQ3e3toebdPn92362Zbx1zm
	 anOKIJ0vzGbLQHMWcKtIIBW2osb2/ouC/U6+DbIhO2MjYo7fYubkrUCv4qN9R/RI4rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X//yu1fT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F0606A335
	for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X//yu1fT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23591F000C9;
	Mon, 16 Nov 2026 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833101;
	bh=Gd3JtHSjhZkWyKm59T5sGeqovV+uq4UZpWkp1MKhIxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X//yu1fTGN2lhFmXBbWYXkOxKg20bzlNBb6mR6C8HiUqRwum1kMlrRPjACAEWsjsN
	 xfT9VxfR3gHpagUcxRVOuvnu1U1Xo2JIubUO3nvMK2MKP5KfAhLaufPiSklYDFI4gN
	 M4Jf78dnTERNTd/nMLfl0Q0SyCSaaIsTQ1/tHnjhtkdmyVREX/2MGbBQe8GSKcRl37
	 M5iDaG7cD1IK6cpEXfyFMXUBE4kXTLiWRMB4E3KwyFz2fPe9UaltmyrXDrRD9sWwA+
	 NJlYxUw5f35ykdv31gaZ3TJc7SJI3nW9rUS0LtW12aBxzxAMFda7/1wQc+Y16ylwEW
	 KdN5Qo741me6Q==
Date: Mon, 16 Nov 2026 13:44:57 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 4/4] treewide: Use streq(3) instead of unnecessary
 uses of strncmp(3)
Message-ID: <avr6VxeIaXatWFBC@devuan>
References: <cover.1794767906.git.alx@kernel.org>
 <7994b5827030d909928a7b7dab35d8b049974fa4.1794767906.git.alx@kernel.org>
 <avr2OGrm9hHG05lU@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="w5dlod5y2yeudtmp"
Content-Disposition: inline
In-Reply-To: <avr2OGrm9hHG05lU@ashevche-desk.local>


--w5dlod5y2yeudtmp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 4/4] treewide: Use streq(3) instead of unnecessary
 uses of strncmp(3)
Message-ID: <avr6VxeIaXatWFBC@devuan>
References: <cover.1794767906.git.alx@kernel.org>
 <7994b5827030d909928a7b7dab35d8b049974fa4.1794767906.git.alx@kernel.org>
 <avr2OGrm9hHG05lU@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <avr2OGrm9hHG05lU@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-16 14:25:28+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Sun, Nov 15, 2026 at 07:46:24PM +0100, Alejandro Colomar wrote:
> > Uses of strncmp(foo,"bar",sizeof("bar")) are really the same as
> > strcmp(foo,"bar").  There's no good reason to use strncmp(3).
> >=20
> > This code seems to have been confused, and probably thought using
> > strncmp(3) was somehow safer than strcmp(3), but it is not.
> >=20
> > Let's rewrite with streq(3), which makes it more readable.
> > This patch is not changing the behavior of the existing code.
> >=20
> > These cases were found with the following script:
> >=20
> > 	$ git grep -E 'strncmp\([^,]*, [^,]*, sizeof.*[A-Z"]' \
> > 	| grep -v -- '- 1';
>=20
> ...
>=20
> >  arch/m68k/sun3/prom/console.c                  | 6 +++---
>=20
> I hope you compile-tested this at least. IIRC PROM is early boot stage on=
 m68k
> and PPC.

Yes, but never trust my word for that, as I make mistakes.  :)
That's why I try to explicitly show the testing shell session in the
cover letter or in a reply to it.  In this case, the cover letter shows
the full testing I did, including a full build with 'allmodconfig'.


Cheers,
Alex

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--w5dlod5y2yeudtmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr6+skACgkQ64mZXMKQ
wqmH1BAAo2tQCqvErEmv0GrqT446Jy7YuhLKMa4pDQRknWV4ka2unKN1N4RlvILW
lb6oA/hKqMfasV006GQshxh4/KLPcbTg+dIPbhe8EapVQH2axAX1TnJ5OHlTdfYl
3aP+E5lwGm53jzzcvnMduKaL+ryYTiNgrHs05OXHcK7NHLDznpzxf/rsKaYePB6P
tTLstMCbNR+4m4EQQhCR4eO73ow/EvsvkK3j7LoeSG1qf84S4+oK0a5lXhaB+hJb
A0H1d4Z0gNIbnSPmOE0+viPHIpikSES9cVNeOSpKVwd2f0Q7WWSU5QPnDN7CNOx4
nEvpt6oHM1tYk9NqM2EK0T8ixrBYzveNne+c4wDyLBN7dr0cAPReY1+ye7nY1WLr
zVtS//Nn2lccnpszAFNoeYxNGWRjzAUumDvtYeQ5XDIFlM/zhyjgFfhRAG+BxuuV
8/kwe6I0pGZ4cGpniP7Yd37UBvFMuaX4cgb0dmbH8nWTHDxXIZaKZ48doZJqmCSk
lDy+5i9iAbsg/uZLL1ad3U/EYLNd+E634KXp/AkNV+RnqycbLBwk5l8vYOS1eR1V
UlktYTssf6JCLmElPhr2PQruoPiDAeyzU1bp2rpdyj5caTlUWTk68mVawxeWE2U2
QWiO8rlWPRkfRm1AmXzMw/hrmSsxTB6sq1bYzgxtgdGEzb5fpT0=
=1P4a
-----END PGP SIGNATURE-----

--w5dlod5y2yeudtmp--
