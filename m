Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356876;
	b=D0iobn8vR2TeJH02e9xnin2w3UeFtMaAYTl0+xrox3pwnTP/6Nb1OLq6qDcswPajI0St
	 LdEiv2kIq5qONSmsf1hJReHn2fZbvrMzAOywt7n187I1sDyJaVK4oatYycNlbXKNHxxWf
	 lCfT8B/GXDeSXnnoeG2NQZyqWC5AQryiE13YWxMDAQnpml4cmLZaHq1uP3F2lDc/jZ1Y+
	 D56HAJsB+J+HK1YXNRSamiyW+TIyuKQXd6B51uV3xdD8g+MpD0iIwpA9T99uBERvHrS8B
	 RQyGKDvqjmXG+m9nh2a0tM3K1btCSjrzadPL1v8Xo/4zznQef0PSdnTxAnyp1iSwxJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356876;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QxouRG1KYEdTCRqc89wWZcbxBTtvnYZZATf1L46tV18=;
	b=QO6cr19zL1l9huGhxiRGNC4gvOzGIXArkAk/dksD8sS9o1to1cX4FBcrZa8tov6v8jU5
	 fZ4btRSK+bxNwkKkIsJSWJ/kEGplQsonV2EPd4U1HKHc1SgaGGuTzWP1yH+QrdgbCCspy
	 5QRmTDVwJvHZSH/RG2fQgBM1y/6JhV1TDld+UV56S/xs7zY8i+zOrlkcTQZIykeVHlown
	 fh1D+FK0krh3myNEb4aSKg09iDqRQUMROfzB5/6tT9PcJEGOyyW73bG6Ahe6gdVKCHDrK
	 FMHd8eGXPb7ya8fE+QKe6KeiIe2NAzm3GaHbnB7y5q9Uz3Pqu6CymHOlSPJeuiOnq/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8yNWGFP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E190606A31C;
	Wed, 11 Nov 2026 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8yNWGFP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA5E1F0089F;
	Wed, 11 Nov 2026 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356875;
	bh=QxouRG1KYEdTCRqc89wWZcbxBTtvnYZZATf1L46tV18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i8yNWGFPsUq6WxBEAz4FCU2EgZSv4uWyeQZsCObLRbazsnyDmOcF1yc/xdRjS/kX2
	 +aTWhv0gs8ERKg471ZEJ0l/ZyvIvJBWElC9dEY/eUmkZkBJjRCZZG1Bf0aOey/4No7
	 +U6MDol+Oxxiw2066UxjBzAHIz4ygPERr8KaeHYvZUKJYjU1kfABuQeSL16Yimwx1a
	 3KW4ThZSGtowi0pd1ZB9dAlyVTuHnRPge1cRlmq+NrSyMqsiTM8pl44F6KuxdjtVKr
	 B1/o8MkyncXJTdwOi/ApjNRTruuMi75IUoGC864GRcwyP0KSX3ylN19533FZiLqRKB
	 mKr/zRFclEPIg==
Date: Wed, 11 Nov 2026 01:27:52 +0100
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <avOw9gLozCslpK_D@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
 <sashiko-outbox-207284@kernel.org>
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
	protocol="application/pgp-signature"; boundary="khawwxmlw3jv7fmk"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-207284@kernel.org>


--khawwxmlw3jv7fmk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <avOw9gLozCslpK_D@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
 <sashiko-outbox-207284@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-207284@kernel.org>

> Date: 2026-11-10 15:44:36+0000
> From: sashiko-bot@kernel.org
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] string: strprefix() breaks Clang builds via void * subscript in
>   QVoid_of()

This seems nonsense; already replied to in the review of 4/5.

> - [Medium] string: strprefix() always returns char * due to non-const
>   (strprefix)()

Hmmm.  Fixed for v4.

> - [Low] string: strprefix() macro parameter pfx mismatches @prefix
>   kernel-doc

Hmmm.  Fixed for v4.

> --
>=20
> commit f882ec908122ee0c3f780648b859ed41700664d0
> Author: Alejandro Colomar <alx@kernel.org>
>=20
> string: Make strprefix() const-qualifier-generic
>=20
> This commit wraps strprefix() in a const_cast(CQChar_of(s) *, ...) macro =
so
> that its return type preserves the const qualifier of its first argument.
>=20
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index cb096e9eb9835..3e8a0537b86bb 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -577,7 +577,9 @@ void memcpy_and_pad(void *dest, size_t dest_len, co=
nst void *src, size_t count,
> >   * *  @s+strlen(@prefix) if @s starts with @prefix
> >   * *  NULL if @s does not start with @prefix
> >   */
> > -static inline char *strprefix(const char *s, const char *prefix)
> > +#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx=
))
>=20
> [Severity: High]
> Does expanding CQChar_of(s) here break Clang builds (make LLVM=3D1)?

I can't even seem to build with LLVM=3D1, so can't reproduce, but as said
in the other subthread (4/5), this makes no sense.  Clang accepts this
code just fine.

> CQChar_of(s) expands to QChar_of(const, s), which expands QVoid_of(s):
>=20
> include/linux/string.h:
> #define QVoid_of(p)       typeof((__QVoidptr_of(p)){0}[0])
> #define __QVoidptr_of(p)  typeof(1?(p):(void*){0})
>=20
> Because __QVoidptr_of(p) is void * or const void *, applying the [0] array
> subscript operator to it fails to compile under Clang ("error: subscript =
of a
> pointer to void") in every translation unit that calls strprefix(), such =
as
> drivers/base/property.c, and triggers -Wpointer-arith under W=3D3 in GCC.

Hmmmm, I see why it says Clang may not compile.  For that to happen, one
needs to enable non-usual diagnostics.

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
	alx@devuan:~/tmp$ gcc -Wall -Wextra -Wpointer-arith -Wno-unused const.c=20
	const.c: In function =E2=80=98main=E2=80=99:
	const.c:3:55: warning: pointer of type =E2=80=98void *=E2=80=99 used in ar=
ithmetic [-Wpointer-arith]
	    3 | #define QVoid_of(p)       typeof((__QVoidptr_of(p)){0}[0])
	      |                                                       ^
	const.c:10:9: note: in expansion of macro =E2=80=98QVoid_of=E2=80=99
	   10 |         QVoid_of(p) *q;  // const void *
	      |         ^~~~~~~~

I think this diagnostic isn't very useful, which is why it isn't in
-Wall -Wextra.

> [Severity: Low]
> Does naming the macro parameter pfx instead of prefix cause scripts/kerne=
l-doc
> warnings?  The kernel-doc comment immediately above documents @prefix, and
> scripts/kernel-doc binds that comment to the macro definition that follow=
s it.

Solved.

> > +
> > +static inline char *(strprefix)(const char *s, const char *prefix)
> >  {
> >  	size_t len =3D strlen(prefix);
> >  	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
>=20
> [Severity: Medium]
> Does strprefix(s, pfx) still unconditionally return char * even when s is
> const char *?
>=20
> include/linux/stddef.h:
> #define const_cast(T, p)  _Generic(p, const T: (T) (p), default: (p))
>=20
> In const_cast(CQChar_of(s) *, strprefix(s, pfx)), the first _Generic
> association is const CQChar_of(s) *, which is const char *.  Because the
> underlying (strprefix)() function returns char *, the controlling express=
ion
> never matches const char * and always selects the default branch, returni=
ng
> an unqualified char * and stripping const from read-only strings.  Should
> (strprefix)() return const char * and avoid casting s to char *?

Solved.

>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794323750.=
git.alx@kernel.org?part=3D5

--=20
<https://www.alejandro-colomar.es>

--khawwxmlw3jv7fmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrztogACgkQ64mZXMKQ
wqkDsA//TrX0eaNU2ZrsuPHyztzNkL4tyerQqWmXJ1YWMYONjTmVggnDol7/6kmz
FuwHqMDUIuhLuDyuUlKREO075UEFaqh4CgaONl79PE8TGgqfgh+mD5M1aKgpWyjx
efmJutiWmQrwUrXdq7s0o2hjKrWFmDS7Fakren6/asWJiUmjw8Gud6eFyUGCcT7V
i9JuoWRn5ZtmbNhqwMDVKRXWzluHEz88Vu06VC1DHyW71r8zpcSKIh8z/vY92ZCS
S6JS9hLzto2pNp9sRtZSedpJVCUyPN3V4pXVztFJzkBnJNzVrkVKMU8zme/mVjoJ
LIq+nv1tZHqsux9yTPWSP+r86YEuVJoF3xyZrtaTVEffX7jGxYpZAwtRVH+Op2cn
nXyWfZvQW4kHk1XghRN6oiidLarQgL2SxPndIvzLnW7SHtpwyoQ9lD4nONGvW0ho
0+U3IX+1N7wPYbI0NigZGUxM9h1kVNfWnEU82K1raV7boQ1HP41PxhxrsOnRt22l
/M8UABw1395cOvD9HUUYuN4n24U/S2JPL0fJJVK2z8xaU4qMMHqZW4dDFiYKmbxu
cXaSw5HnmZ+JZiaJr7gvtF9SMCRtDx36Mu2gr04K6KQ2rVGgO+S5AI6aPMIYZAq+
0vrsXL31Fz6f3EHD9rhGpcNdUus7vsgf4oVSg3cuywAv4zpOZvI=
=JswK
-----END PGP SIGNATURE-----

--khawwxmlw3jv7fmk--
