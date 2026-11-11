Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394754;
	b=bk/QSiKHbchQPlXy8igEz9LvBEBqnf10O34bykCUBNhAmwn4DEuCA0FPAv2RBboObfGX
	 t/O4DFMO6y3Nt+GgA/9Br7Wgz6ifDEGA7Ug5cT1qXRKGQwcVFUK2UWzfaPglZ5TkDSSwT
	 Qyo9pu9HRgYjrnTpI5iKiT0+6a9f+yv7z+lYqui6m7l1BrmYMlhzLMYpAQ+hoFAD4+Zc0
	 sWDuLGUpdSjxoE637c+BLwislb5m0RVUGv4rctOkFrGgP9Q937+0ZDsxkJMjh/rVIqbNW
	 IFaJKafwMYQHeoRLSPyol43MTVGK2P0NY3oee015rRL8OJMgolJil/E3EW59nzk/ufQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394754;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9o4ST70UuO46LLtkIMPxTPAkfT/+TeanQNFZfYQrPrE=;
	b=XjBiCs+T2SCG7wZU4UGq4mokCXIkZWGuywir6vCTtnxbfXCNAmyJYhFA+YgvCSIH3wMz
	 y7byCZdv0BkcJSZIGAFePY3VXtioWqESgMzHLF+JueszKcTSTdTziJ7dLZJzM30tzLOVH
	 fy3Xj7H26Ak8StCU6tPVyaj1McxlOtwilSezdb/S2gwBgc4KujRXIS00EQ4OvfxY3HO+m
	 EVHK0Ijbx4L8VQg/MkhGsq6oy2mRdo7vFvyUwFLU7FalecPYhElpjwHG0ftf/eKbnieoX
	 yL+X/7Gij8i7+E4UswX4QOV5hIaaroKCzVT9AoZSh1SHeWx7IQtg+vzWL7Zlg7++U4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+C81saN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14D606A31C;
	Wed, 11 Nov 2026 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+C81saN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395AD1F00A05;
	Wed, 11 Nov 2026 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394754;
	bh=9o4ST70UuO46LLtkIMPxTPAkfT/+TeanQNFZfYQrPrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X+C81saNxCyYeNerjLrjfYH67ag3HjJ0s0IEHn9r6ikrVQ7UlH97OpChbMH7gVcoN
	 XvRgc+5dDzkp4ze//9mJ2bJYBMddwCDGHGIA0+zfUP1oNPwxmYsmUEB6G4f0fS0Hcd
	 CdlDXjg2edBVgptBdp5RVMz/JIEseNTF19NlCfh2N7RqZ0oxkXDuFNTb/qNp/6nV/P
	 g4MqrclLquJ9XgDjWuzObmvrJAPrQII9Msm+4vEdkcz7CM7ERIsdNpTYyoSFyh809i
	 CeSBXDU2Dj6sYOmuntw57mEgWxuo2EQ+iqDxKRdtCq/kweowl6u2QfnpZHui/ZL97t
	 MuVgWB3TMOUKw==
Date: Wed, 11 Nov 2026 11:59:05 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Joe Perches <joe@perches.com>, Alejandro Colomar <alx@kernel.org>, 
	linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <avRKYMNAQEUDVnS-@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
 <64aa89daf23821f95780813fe96882ff61688578.camel@perches.com>
 <avOn57pfHntiwcaD@devuan>
 <20261111102836.759ec121@pumpkin>
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
	protocol="application/pgp-signature"; boundary="5ivl7qlzmrv4rlgf"
Content-Disposition: inline
In-Reply-To: <20261111102836.759ec121@pumpkin>


--5ivl7qlzmrv4rlgf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Joe Perches <joe@perches.com>, Alejandro Colomar <alx@kernel.org>, 
	linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <avRKYMNAQEUDVnS-@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
 <64aa89daf23821f95780813fe96882ff61688578.camel@perches.com>
 <avOn57pfHntiwcaD@devuan>
 <20261111102836.759ec121@pumpkin>
MIME-Version: 1.0
In-Reply-To: <20261111102836.759ec121@pumpkin>

Hi David,

> Date: 2026-11-11 10:28:36+0000
> From: David Laight <david.laight.linux@gmail.com>
>
> On Wed, 11 Nov 2026 00:27:28 +0100
> Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
>=20
> > Hi Joe,
> >=20
> > > Date: 2026-11-10 08:32:41-0800
> > > From: Joe Perches <joe@perches.com>
> > >
> > > On Tue, 2026-11-10 at 16:33 +0100, Alejandro Colomar wrote:
> > >=20
> > > no commit description on proposed patch =20
> >=20
> > There isn't much to say, but I'll add something (the explanation of why
> > the parentheses are needed around the function name, for example).
> >=20
> > > > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > > > ---
> > > >  include/linux/string.h | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/include/linux/string.h b/include/linux/string.h
> > > > index 9e59f9697c9e..55ca4cb5122c 100644
> > > > --- a/include/linux/string.h
> > > > +++ b/include/linux/string.h
> > > > @@ -590,7 +590,9 @@ void memcpy_and_pad(void *dest, size_t dest_len=
, const void *src, size_t count,
> > > >   * *  @s+strlen(@prefix) if @s starts with @prefix
> > > >   * *  NULL if @s does not start with @prefix
> > > >   */
> > > > -static inline char *strprefix(const char *s, const char *prefix)
> > > > +#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s,=
 pfx))
> > > > +
> > > > +static inline char *(strprefix)(const char *s, const char *prefix)=
 =20
> > >=20
> > > Why introduce a new coding style? =20
> >=20
> > It's not style; the parentheses are technically needed to avoid macro
> > expansion, since the macro has the same name as the function.
> >=20
> > Alternatively, I could rename the function to __strprefix().
>=20
> Or put the #define after the function definition.

Done for v4.


Cheers,
Alex

>=20
> David
>=20
> >=20
> >=20
> > Have a lovely night!
> > Alex
> >=20
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--5ivl7qlzmrv4rlgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0SnkACgkQ64mZXMKQ
wqkSIw/+JANAA68nz5/+CG2Uu2FsDG/gwOlqCGmdZXBmRcZJU8hhQqw3mrZAC8D3
87/DX6VsCnivD0LWOuqVybLeLXV8hfdE5AuccAnhXvNHNR2nJzl3VnIBxRh9/+rk
BKA7J1WLaOY4qBVNB4A6Napon9uwLwMjCa8qLheKVJXcAi3r/aCWkjPZVDijD41w
bp3DfOTRvzN6baIyu1J2cKhU/HJxIIXDnKFWykwcFwCi6bhJJZYRyI4l48poIZxo
o1VIiASPJnfSrs7l5/k0GdM5g9wAD/cIge7HxlAEsu6jYCZ3TLTOod1UNi9Tel/5
XZkqEF23vXriQc6KSYpbAX4QwRlu5p9m6CWSnwKBH9AqbmZ9kAiFT1qE/Xvdq0zZ
u4WQ6r4lGqu7rOd4uhXM2cBU/bD7wMjuTHeqqQF2ay9WN08S5AsrW9De439mdKVP
K9whrKLOTfjz2oWglsMIY1sDt0MmjVFA1+N6rB06jXGprYNPptJfOAhc4ktulq8l
de4HZR2dPsF1YOwagXCfmHoMFU02ZnNnKLYqb2VrlAA7s1xeR4t+uQNknaAZShYX
HeNI8vDCSK+aOuEf5r1HjK44NVtUxd/ZzgB8nJskAsGzOxfpVkDVeIOYZrVfcbDn
Qihv6z0V8jh2CmUbkWzfK04Hw+dHgaoqt6tHCOntuTECFHZzuDs=
=1grF
-----END PGP SIGNATURE-----

--5ivl7qlzmrv4rlgf--
