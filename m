Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577685;
	b=aDO+wjyeyA8upWQ5AMHW/9SkuCyk2yJyyM9vV1ryZofvGv/AZ3JynbSBGOQz2L8q7B9U
	 EmH2AUCRNSRNdkeeLvt5MGo+vTeBO5iacCAAVp3SxQI6AGlD4G87pn0Onn0e6U0Vx/CBI
	 o5Xu19kswGKwUuyzuc5UIIwCZhgovtPuJUsqcIQYlfFvPzWQIgYHdWAhDGtQhrc2tdFKp
	 rzMOD/Ljj5/ZzxS3pCtNkW1KUYSt7N5wSmy55quALWnoaZVjjFD/5opQfE8QWKJIbfQKP
	 9PWqR/GJqsiyD4hEv/23OOzxFEhFyzI4ExC+2+skeSDUTcuMMOa0zPat7qX6CLaOjwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577685;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=98DD9GvKbyjoWTiQpEC1uV5CQh28S6aA8oScTTaagZI=;
	b=W5XBEoHfuIgeS2fXjWVjxH2fyD+45i8C9ygP9ClTaMAx2y2b0JgDyysK5ylnxKHi7kr7
	 HmA8vKR3oiwi6fV/qvHtDEsdzih9LWCV1eRnS7WptAfWzOlnF9SHNCueavI8lSVEJQAOf
	 EkYH3rXl/OxhRVjrluZ0fHobZIUT/ZuzKiUj6V2Yc+PWtm8DAOHFL8nNx852+ulTazrE0
	 F/II6cudcZfz2mwpCZnqXpk1mZu99+OghBilFZcboTbv7c6kAXpybBxFJZBEtrtirMfwM
	 QfJc98N+Uf6XmrCRMx//sN3t1bS+vRhnX+ADSivajmYidmgqJ6cE09EN2iMCCVQEqmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8wgVrpE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10A606A8BB;
	Fri, 13 Nov 2026 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8wgVrpE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1491F000C5;
	Fri, 13 Nov 2026 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577685;
	bh=98DD9GvKbyjoWTiQpEC1uV5CQh28S6aA8oScTTaagZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N8wgVrpEqCKxFALFL776UMDWj0hUGpz74/UZcO4i+kmtAz/Q+mdFCA04JMwD7P/U9
	 l5A9em+p3yNHueuJrz0V3c8VOh7E5gLle6UIoXl9nPB0gNhM9prNKAd9YQ3jZiS+2G
	 KHXcHgS2qA6SW+GpZsC9gGQxPxB/Byc53jyPIz5Sfk5xfcuzhufVXIUK5dJF4kNqW1
	 79tUAe/HdMmxOTjAg1eHIrIu4FxX34oVW6+pU+rSacf3Ccjhvhdsuo8xLlelqiYtrm
	 s321DPk6NewS4DAqZ6tzz/4MVAdtefS6bipo+yzMoBA2VHIYwjgLXKflAw4TPBHKlM
	 ZM/xbLYZKTH1g==
Date: Fri, 13 Nov 2026 14:48:01 +0100
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 2/7] string: Warn if the prefix is the empty string
Message-ID: <avcUA0z7CuQqs6Bz@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <df3a35c469c60c2c9658d66b30e67468ba053863.1794574496.git.alx@kernel.org>
 <sashiko-outbox-212859@kernel.org>
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
	protocol="application/pgp-signature"; boundary="jl62dtj4qtrdc7vv"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-212859@kernel.org>


--jl62dtj4qtrdc7vv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 2/7] string: Warn if the prefix is the empty string
Message-ID: <avcUA0z7CuQqs6Bz@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <df3a35c469c60c2c9658d66b30e67468ba053863.1794574496.git.alx@kernel.org>
 <sashiko-outbox-212859@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-212859@kernel.org>

> Date: 2026-11-13 13:26:21+0000
> From: sashiko-bot@kernel.org
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Low] string: moving str_has_prefix() to lib/string.c bypasses
>   FORTIFY_SOURCE
> - [Low] string: commit message cites non-existent lib/string.h and omits
>   function name
> --
>=20
> commit 018109c1aa9a2d5e3def240ae4b9134b27f492d5
> Author: Alejandro Colomar <alx@kernel.org>
>=20
> > string: Warn if the prefix is the empty string
> >
> > This corner case is mishandled by this function.
> > Warn if it happens.  Also, document that if such corner case
> > is needed, strprefix() is preferable.
> >
> > We need to move str_has_prefix() to "lib/string.h" to be able to use
> > WARN_ON_ONCE().
> >
> > Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-=
prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
>=20
> [Severity: Low]
> This isn't a bug, but the commit message says str_has_prefix() is moved to
> "lib/string.h", which does not exist; the patch moves it to lib/string.c.
> Also, neither the subject line nor the opening sentence names
> str_has_prefix().

Oops, typo and thinko.  Will fix for v6.

>=20
> [ ... ]
>=20
> > diff --git a/lib/string.c b/lib/string.c
> > index a3778d5aab4af..61a1e79c1b875 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -774,6 +774,30 @@ char *strnstr(const char *s1, const char *s2, size=
_t len)
> >  EXPORT_SYMBOL(strnstr);
> >  #endif
> > =20
> > +/**
> > + * str_has_prefix - Test if a string has a given prefix
> > + * @str: The string to test
> > + * @prefix: The string to see if @str starts with
> > + *
> > + * This is similar to strprefix(), but returns an offset instead of
> > + * a pointer.
> > + *
> > + * Unlike for strprefix(), if the prefix is an empty string, the
> > + * behavior is undefined.  If you need to support arbitrary prefixes,
> > + * use strprefix().
> > + *
> > + * Returns:
> > + * * strlen(@prefix) if @str starts with @prefix
> > + * * 0 if @str does not start with @prefix
> > + */
> > +size_t str_has_prefix(const char *str, const char *prefix)
> > +{
> > +	size_t len =3D strlen(prefix);
> > +	WARN_ON_ONCE(len =3D=3D 0);
> > +	return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
> > +}
> > +EXPORT_SYMBOL(str_has_prefix);
>=20
> [Severity: Low]
> Does moving str_has_prefix() out-of-line into lib/string.c bypass
> CONFIG_FORTIFY_SOURCE and prevent compile-time constant folding of
> strlen(prefix)?

Preventing the compile-time constant folding of strlen(3) is indeed
a performance degradation, but that's necessary to be able to
WARN_ON_ONCE(), so there isn't anything we can do.

>=20
> lib/string.c is built with __NO_FORTIFY and its top-of-file comment notes
> that it is reserved for routines that have architecture-specific
> alternatives in <asm/string.h> or get overloaded by FORTIFY_SOURCE, while
> other helpers belong in lib/string_helpers.c.

Do we want to move it to "lib/string_helpers.c"?  I don't know enough
about the organization in these files, so just let me know what I should
do.

> When str_has_prefix() was a static __always_inline helper in
> include/linux/string.h (introduced in 72921427d46b ("string.h: Add
> str_has_prefix() helper function")), strlen(prefix) folded string-literal
> prefixes into constants at compile time and ran fortified bounds checks on
> non-constant arrays.  Moving it to lib/string.c forces an out-of-line call
> and an unfortified runtime strlen() scan on every invocation, and shares a
> single WARN_ON_ONCE() state across all callers in the kernel.

I guess that's bonus points for strprefix().  :)

> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794574496.=
git.alx@kernel.org?part=3D2

--=20
<https://www.alejandro-colomar.es>

--jl62dtj4qtrdc7vv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3FREACgkQ64mZXMKQ
wqlHxA/9HSGzldXnzIicmgjy7b3KWGp1uFOpTrC7ibX1q6nkdqw5eSFm29MRyjQ4
oEM+zUtxx3e/nkExqUXZT2zEZBvNpv8vzDi2WNK/Yt6VGIckPDzZGmpmut1Xuadr
UzZkW5EGUhHLpbgaHoF+5rnSAshdshf+Ocp3Oj9bOicHr2NqLbW7XSRDdFc5X3Iy
xgmFBh3D3W1VOW/cpGQlh2/2JUVObBl1mJbeAGsMwzibJwjV95tFxOEiRD9AQE3W
Jzd8h1fN7RjgDXS9RTDN8JhRfPbCWFohuSzNOihblUV/fxOxZTH9lNR7Dzm7ONcA
wbVC7QAAWlUHOvnWmwyv+h5eaNH71sMHIlWzupB8S2CaQ7+zdi9D7NlSb0bwEkrA
gxDGrE3imiVttRn3sUakSgyLTRYlgbCUoHX0y7zudmMDxwaN1+PwEIX53Ow+73sS
e0tT2eUQ4eWuHYBhCOic4FgXXB2TqpZE8TQ6IIey9E/yylFzvulpquct2JmFGMXO
gUxwSCAK9N7l24gjbYZtvAoSyg6hlCLJvwWdNxrLEFHHpodBJtqTrg8rXoCYrI3O
EOOUa0++CMjl6vk2gOSChVU0MCFGbKzv/nAFaYf30W3PlGUH69RwJsDImIlLrNg2
0HQp0xHBhsVMrlw+UsFcBzGNjgEbrGf/FB/ZJ0i34/vR8pXpKoE=
=J6yv
-----END PGP SIGNATURE-----

--jl62dtj4qtrdc7vv--
