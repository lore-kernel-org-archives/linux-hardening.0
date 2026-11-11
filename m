Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394298;
	b=uKNdJ36+FbZ9/uj3pvubXi2jWSVChK3eOIbmpAzse0pc+qGK9RgRARl4XE1xcaEe09Dc
	 6SbwawCu9KaZ7BgtU0YBeQ2YyBLaWUa6W6kWyMLcZCKgqGXotpmOsyL43ru9YVNoZoubX
	 iep01mRNl54eXCU5tj7vUo0GbCIZJVurWuFTxb9nsWdElS+Uf8k3NC3c+qWTDy8U28fHT
	 5yf8e8q0ri3E5VzxTDinLA3HG8drit/z2v9D5JxEdwinGMhYLI0DQeH04xCn86UBRGTLU
	 67W6SLIcZCrbCH/e3VLxYPRS4AA3GKOdKDepO5/1n6mp1WDEfhFomiuoqP9gVrlItOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394298;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rjS78XqnLRkcuOiyknQtcMbtEegSaHf+eCvs3lFWAlg=;
	b=WfWLJ09nLPh8YpYMWRsupzulZ1w76oeDawNhySTsvTGP+NQNf0erpuDRqas19WZxCmWQ
	 dkyMiD0Ap3RfsvSGrZ0Iynhx8mM58KxX51ts3TMTFZM7lFYzW0cgoXdSmXYdeAGPUD1wD
	 LuD7b/kk3ye51kmaA8CzLIhpkSjodr+/1312fHUoXuqy2njjkiYD4OPOQvNgPGcXAk26h
	 xRHJvOZlj0EhOy8Tn22UoZiL2t9NGUXrR7ol3biRG23QaIaFYDpuPLItFu24PLHy/Hup3
	 iJoukLsa9dqt3yH3oxLovVkDmln1gXwgxOyrOtVPsykQiRhL7JTYQ/gSA/KVLbMXhBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iK7QsGrs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FA606A31C;
	Wed, 11 Nov 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iK7QsGrs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237181F00A05;
	Wed, 11 Nov 2026 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394298;
	bh=rjS78XqnLRkcuOiyknQtcMbtEegSaHf+eCvs3lFWAlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iK7QsGrsjq4AlHhkK3Z05yAvRe+MbBLWRl7ZxSr0u6NRz2n1mzILNIczCStRFSkdM
	 C0EKKx6aSEeQcwF1AM94ShQrypQYxXn2LS526gMzSkED139sMFZ+pesBij2lq4JSod
	 wdEOuY88REcRf6NkPKeR2N/iv4783+Th8xDgcpC9i0t/5HrnXQrPJzFOpjmqbP+Ypm
	 pLaRsiy/idrGvdxlcE3frA7wMtuSEun6ths7NVMNuq8LDVMY4WiYFWaF7+NF9+w/P4
	 xGaGrhlRbqDqbh0zhLuftnXHp5NnGCajbO/2EEAzLkmSLIl62PkQcSC5HVCBo+xxHC
	 7RSoYUs66fN/Q==
Date: Wed, 11 Nov 2026 11:51:29 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 3/5] stddef: Add const_cast()
Message-ID: <avRGnEBOpKhK8BMz@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <2bf5cf7baad87b5b7b7f833df390596a033fd6f6.1794323750.git.alx@kernel.org>
 <20261111102535.434c2eee@pumpkin>
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
	protocol="application/pgp-signature"; boundary="btplz6fw3gpwuxwj"
Content-Disposition: inline
In-Reply-To: <20261111102535.434c2eee@pumpkin>


--btplz6fw3gpwuxwj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 3/5] stddef: Add const_cast()
Message-ID: <avRGnEBOpKhK8BMz@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <2bf5cf7baad87b5b7b7f833df390596a033fd6f6.1794323750.git.alx@kernel.org>
 <20261111102535.434c2eee@pumpkin>
MIME-Version: 1.0
In-Reply-To: <20261111102535.434c2eee@pumpkin>

Hi David,

> Date: 2026-11-11 10:25:35+0000
> From: David Laight <david.laight.linux@gmail.com>
>
> On Tue, 10 Nov 2026 16:33:40 +0100
> Alejandro Colomar <alx@kernel.org> wrote:
>=20
> > This macro serves to cast const away without risking unwanted
> > conversions due to mistakes in the cast.
> >=20
> > It's similar to C++'s const_cast(), but it is more restrictive: it can
> > only cast away 'const', and not arbitrary qualifiers.
> >=20
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >  include/linux/stddef.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> > index e1851c50c89b..d79a81406b78 100644
> > --- a/include/linux/stddef.h
> > +++ b/include/linux/stddef.h
> > @@ -194,4 +194,16 @@ enum {
> >  #define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)				\
> >  	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
> > =20
> > +/**
> > + * const_cast() - Drop const in the left-most derivation of a pointer
> > + *
> > + * @T: Type for the cast.
> > + * @p: Pointer to be casted.
> > + *
> > + * If @p is of type const @T, then it is casted to @T.
> > + * Otherwise, @p is returned without any casts.
> > + * This avoids mistakes that change anything other than 'const' in a c=
ast.
> > + */
> > +#define const_cast(T, p)  _Generic(p, const T: (T) (p), default: (p))
>=20
> Should it be de_const_cast(), or just de_const().

If we want to be explicit about it being for dropping, perhaps
drop_const() or cast_drop_const() feels more readable to me than
de_const().  I had been calling this const_cast() for following C++'s
name.

> It is a shame you need to specify the type,

In some cases we don't want to drop const; it's a "maybe drop const",
actually.  Perhaps for this reason, cast_drop_const() might be
misleading, in that it tells you that it dropped const, but sometimes
it didn't.  On the other hand, if you thougt you had dropped const and
haven't, you'll get build errors, so it's not a big problem.

The reason why we may want to not drop const is that since we do:

	const_cast(CQChar_of(s) *, strprefix(s, pfx))

'CQChar_of() *' expands to either 'const char *' or 'char *', depending
on the qualification of 's'.  In case it expands to 'const char *', we
want to retain const, and not drop it.  The most accurate name would be
cast_at_most_drop_const_but_maybe_not().  :)

> but why not:
> 	_Generic(p, T: p, const T: (T)(p))
> so that you get a compile time error from the _Generic() if the type
> is wrong.

Thanks!  I like that being more robust.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--btplz6fw3gpwuxwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0SKwACgkQ64mZXMKQ
wqlkrw/+IO0ydpOzz1GwpDbDPEn62YIboIVlzzJZw9hARy4+BkgGCvu54LrKCmdd
5gqMP/Q9O+UTMhdyu9MULP2LJi+lwCiaf+w82JrsNE8BlcvdFLIRJhePbMRAnBqW
eYNF+Rn/Bl6IqlR0ouYo7m4rRBUGH3vIMjGMeXBzssKZ1pdok+hNUv50I187agZf
y2d3377FI0saE/zdf3HlQYCL07vkbMHsTvznB5aEzRkQDJoUXfol+I7gMo1N4A3F
5YKII+lCC9zOOn3ne/kyQSlFwZ8BZ4aSNd5WJL53fjI8QrQC/r4yNx4il1+KjzzL
Gx6XwSG9g6I4H4xX6E0FrZ0ymk/JrC1tm7KPvmvBCLipPm47pI59aNhJb2U5TPp3
7w0WJs3+mQsomF//SOtS+LJgKbf+dQhgAz+AiOPjgK9oedfkizCs/zuvOKygu2TX
VMVqpKmfKYGHTPPmYKGTPUhj5PZZoH66YNsnpmPXvzKN/vJebT8Laz3u1pqQg7Tc
9ENwHWQ8wLaiXLyZRaLUvqPwcj8Qgo1IxZcIhhdjPLlDyMJ2X2XT7fC47FbU/LnT
i8qweKHzZyj41TPUZg2vy5WF78hXDf+N+rClI+NZANA7MuWTw1MC5v20OZZ6fzvt
U8fbg+wgaw9yu0cU9PE2/rh+rF4dXWOZUiecw813sqQYo43cdPQ=
=yVph
-----END PGP SIGNATURE-----

--btplz6fw3gpwuxwj--
