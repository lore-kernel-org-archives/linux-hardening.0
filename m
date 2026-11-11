Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355430;
	b=TxoL0i6Asera+hTuH0kp/sI3+AnwVqwbHrruLrNfGCuq3tAeM+K1DIq+lH8mX44Zckoq
	 U+AC3Cvg012yoXKWKVMdt3K7xOXZ8vP8ApJMZCin5thl/lHrGlTX0/AexugUAh0JzHoAu
	 zbihFV6Ee5+J9SmXSWAvdnzmRE5qwVEuTlDlWU1km/tatnOq6sOqng3n1a81vC4J6v8L4
	 +G4txGrYHAakr6wKwTkeyW/KLBXzKymNJGWmUbIZg9To1qB/nkbsgjbBPowuGmkHclBBj
	 IzjtLHL4kKEvh9Rk4pQhBJhhhk4st7AGyVOVuewB659DRGYP8oCG4Fth5xaXOGq6dvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355430;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G6vtQZE3ujvpxlS2I2KZ02SKJAR98+LOdANoRmy/Db8=;
	b=f51UNJiu0AVyj/2DDO4ZHt4+KLU5QA/SW0qTSlkDflSWqMmbcoqKM3alUTBc6iNwULOw
	 kE4EFdOXXXJCjmHZS/gHhnamx/3azQ78KVIxcI9ongOf61XQ1ueEa5hmYVhfFMpzp33kE
	 IRkhTUd2t2/EDq5lbgl7UIAQ+G0MxXUgCxMCf3GUn3So/fle1n5wEISaxIZg/Aj/s11VK
	 tGHNzJPgsvVK8ou26dNZw1deA4VZEoCJo6ZtvWS5r2pnWcg/pxHlloOntXGdIn6gUCkKc
	 xbP6rhl3YjQUyVhDPIzTpGDSboP9xeCbSImh3PeCTr9BRBfe4qFYx+JgmMfUtWfy28w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf6gFqXN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD8606A321;
	Wed, 11 Nov 2026 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf6gFqXN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A60A1F0089F;
	Wed, 11 Nov 2026 00:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355429;
	bh=G6vtQZE3ujvpxlS2I2KZ02SKJAR98+LOdANoRmy/Db8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gf6gFqXNZ9CoFov+cIHt/cLKduR6rdDO3hZNovZFqQjIJb91tU7vfitfeuSQzC/fv
	 fWIQCb2bUxxHk1W128Gd//Ji/w6uMyBqoBfIIg1ntXT9Qu6jwAxnVcWbOmSQwChBVT
	 vMwFfp+4vDBcfwQPf2vXZOCtwgNtFkWXPW70CNmirYevx4C7KuBUIL4HZkNIkONfb+
	 MD8kMgoXiD9tNKkXeZgTuaDEEFDDdd8vzWfCqJczzmWOgxK9oAQgi94iYZXH8CRGcC
	 prnhCdr6jI5sdhjddXFqbDL1iF0YsQOB/cUkGz9cD5XljsTwQ9bOI/jHOPLUZTl+8N
	 QGJamtB4FVfwQ==
Date: Wed, 11 Nov 2026 01:03:46 +0100
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 4/5] string: Add [C]QChar_of() and QVoid_of()
Message-ID: <avOuLrmqKK5Vb2vH@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <415453a31ebf1aed3b41da1a28913f5cbe58f175.1794323750.git.alx@kernel.org>
 <sashiko-outbox-207285@kernel.org>
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
	protocol="application/pgp-signature"; boundary="k4z2mch3442cdwfc"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-207285@kernel.org>


--k4z2mch3442cdwfc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 4/5] string: Add [C]QChar_of() and QVoid_of()
Message-ID: <avOuLrmqKK5Vb2vH@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <415453a31ebf1aed3b41da1a28913f5cbe58f175.1794323750.git.alx@kernel.org>
 <sashiko-outbox-207285@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-207285@kernel.org>

> Date: 2026-11-10 15:45:13+0000
> From: sashiko-bot@kernel.org
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] string: void pointer subscript in QVoid_of() breaks Clang
>   builds

It seems I can't build with LLVM in the way that sashiko suggested in
the other mail, so I can't reproduce this:

	$ make LLVM=3D1
	  SYNC    include/config/auto.conf
	  HOSTCC  scripts/basic/fixdep
	clang: error: invalid linker name in argument '-fuse-ld=3Dlld'
	make[3]: *** [scripts/Makefile.host:114: scripts/basic/fixdep] Error 1
	make[2]: *** [Makefile:682: scripts_basic] Error 2
	make[1]: *** [/srv/alx/src/linux/linux/llvm/Makefile:912: include/config/a=
uto.conf] Error 2
	make[1]: *** [include/config/auto.conf] Deleting file 'include/generated/r=
ustc_cfg'
	make[1]: *** [include/config/auto.conf] Deleting file 'include/generated/a=
utoconf.h'
	make: *** [Makefile:248: __sub-make] Error 2

But I see no reason why Clang shouldn't build this.  I've written
a small test program just to see, and Clang seems to just work well:

	alx@devuan:~/tmp$ cat const.c=20
	#include <stddef.h>

	#define QVoid_of(p)       typeof((__QVoidptr_of(p)){0}[0])
	#define __QVoidptr_of(p)  typeof(1?(p):(void*){0})

	int
	main(void)
	{
		const void  *p;
		QVoid_of(p) *q;  // const void *
	}
	alx@devuan:~/tmp$ gcc -Wall -Wextra -Wno-unused const.c=20
	alx@devuan:~/tmp$ clang -Wall -Wextra -Wno-unused const.c=20
	alx@devuan:~/tmp$=20

Unless anyone can actually reproduce the build issue, I'll assume this
report is nonsense.

> - [Medium] string: QChar_of() fails to compile when pointee has
>   qualifiers other than Q

That's actually desirable.  You don't want to call strchr(3) with
a pointer to volatile.

> --
>=20
> commit cea37634307d89ede7b6ca6128f006d50a90391c
> Author: Alejandro Colomar <alx@kernel.org>
>=20
> string: Add [C]QChar_of() and QVoid_of()
>=20
> This commit introduces the QVoid_of(), QChar_of(), and CQChar_of() helper
> macros in include/linux/string.h to support qualifier-generic string macr=
os.
>=20
> > diff --git a/include/linux/string.h b/include/linux/string.h
[...]
>=20
> [Severity: High]
> Does applying the array subscript [0] to a void pointer in QVoid_of()
> break Clang builds?

I don't see why it would.  I can't use LLVM myself, so can't reproduce,
but a small test program shows that Clang works just fine with it.

> __QVoidptr_of(p) produces a pointer to (qualified) void.  Because array
> subscripting requires a pointer to a complete object type, Clang rejects
> (__QVoidptr_of(p)){0}[0] even inside typeof() with an incomplete type
> error, and GCC emits a -Wpointer-arith warning when pointer arithmetic
> warnings are enabled.  Using unary * instead of [0], such as
> typeof(*(__QVoidptr_of(p)){0}), avoids both issues.

This is a lie, unless anyone can confirm.

[...]
> [Severity: Medium]
> Can QChar_of() fail to compile when the pointed-to type of p carries a
> qualifier other than Q?

Indeed, a desirable property.

> QVoid_of(p) preserves all qualifiers on the target of p, but the _Generic
> selection only matches exact Q void * and unqualified void *.  Passing a
> volatile char * or const volatile char * to CQChar_of(p) produces a
> volatile void * or const volatile void * controlling expression, which
> matches neither association and fails at compile time.  Matching against
> Q QVoid_of(p) *: (Q char){0} and default: (char){0} would test specifical=
ly
> for Q regardless of other qualifiers.

You certainly don't want to pass a volatile char* to strchr(3).


Alex

--=20
<https://www.alejandro-colomar.es>

--k4z2mch3442cdwfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzsNsACgkQ64mZXMKQ
wqlYyA//WP431CwOyyGiJ5Z4Nq4DkoB7lbZioy90Yl+g7zuCkZGvPoK5u3DTM6y2
RcILdOR7a+CcZwlnfZ+uq6cFM0MSdsj4AkNWGVChYTCRKNaO3K4Ln6S62Gj9/xqR
f1EGFr7gHkARKeFJCb+nAUUKHuRXXOsXEmAvFZrxsG/SM33rP3kmnKO829UvLoBQ
DDi3V2Gmf3N3AS9MKk8yfv7yWFktDkogn2WPwRr7l+7QP0KbM8pyeFCQ8DtxXzMQ
nHJ4/Xyg3O1SYFOFSr30b7TVDSg9sX0WHFTg6vy6Q097B/+nZ0mcXtUebgFc6i+v
ctGoaRYlL9/ULqWYqyOWb/yMxDXKJuiLmLh2BVGfQsIHG+KC19F+aSoCehyawg0J
2Sv1qGWgZhaE/5DdwPr2VRD3bYDx79n6JemIS2z3YDMpN4YmjNkOHolqFr3I8qMZ
p7+mc5t7ACtB7psgUh4BJ+oUAPaLflvXKCjn0tFtbNRS94SfiMpwxfYrMT+MzPI1
h0HvUuS+8kGTZhvriKw5pKLe5qXf1m+iwIfzznyEY0e5Dsz/hdxLK/vhDORsnGSJ
UBW2c9G67/dZS8FdNJC+GLfLLeJSFLEf1onrBjtigp5ebFOwwjrM5j+m5XZO8gfM
3T5YUS4eDKCZLwzH38VjkYqQ+ztrEmFtGggF746acwwtrGj9wTo=
=N5aI
-----END PGP SIGNATURE-----

--k4z2mch3442cdwfc--
