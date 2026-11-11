Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428294;
	b=vEqbOAOzmQV4BPqsUJPDYe2FTaN2rswqBV7bzgKpkkiTmPJp/9ayLcvNbmgTRiNNhE1Z
	 MAyQ5gsFGHOAU+Cu1iK1Nw/BGyq8hLYnz9c0wQEd7dyOMgrEGDPsckSSWoKzuFrvV93k0
	 rDNdd6gPM+R5L4hQ6FN+YSDyKMAE2BycCONLzRFUNJBCXTkFPQw9siI0k14FlTRppGHTK
	 ScGMWjpwNYQcf7hfohVmnbvOQH4ZF9aFVLhiEHdCjEYxayFWQQA72eaPnvGGuTqVGSKbV
	 9JNcPl8jOdNyqGTfaafmDkkuY0aYOLEBoFJdvoGPTiJ487RNngl1G+dWDjMmLiF1kXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428294;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Els3/l9AGCSjcC7efz1j19ntkOAQMAY8UI2QWizsyMU=;
	b=R/w0ioztyeTGpw+iH81efs75Gr11u1T7FTX/D4R6WRKdGM/r/Lxg5Fn4aF4IZS9cakik
	 DWqOto5Gp03qWXLqEHRnpMTRtsBGWSz89HDyRYoJ9xuP2WV9FqSRq7viKIsGFf/EpxS4Z
	 hjPDdD8lKrC6iJVYfIaxD6a1FIO+FYYj5AtX16tBYNuzTprcLRCCMugChIX/nWtvfivnp
	 tZBhoB41xazDU0K2euchANBodL1Tt5oFBtHeIbu/RTJI3ALUGL5Vel1Q2BwC9Tdx7aDwy
	 jJGol60jVPU70+ZPu1+xO9lbm1bWjibvr0Qg6k3Rv2fYZ+LNhNjvWu+crD/fXZxQL5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nLI3/DNW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF3606A321;
	Wed, 11 Nov 2026 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLI3/DNW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5FC1F00A05;
	Wed, 11 Nov 2026 20:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428293;
	bh=Els3/l9AGCSjcC7efz1j19ntkOAQMAY8UI2QWizsyMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nLI3/DNWdeV0x1vHF44IGq1ZgW1d12PIIB+PI2iGWrUtJREN6UWn50o5jtAKDZHAP
	 VGvfhxb5Y89pzBf6edS//7RnKRcqZRrMIYW7a1vY5srKD0JLCv3IfAUSt2JBhKSiFE
	 kvMBGL71p1wRbe5uOqiV+7JcSYZOmAsLDhU2/AcyuoDWcu5WOegiWpyeWiCUyAGPrV
	 GbUnZqgqkhG+L6a8A/qLfBXYEhL5XdQ5lCXIvca5JL4WgtWLqQSNJstSHEKd+7NZ0S
	 /vEOx3OgGLn3Zpky4EquBRs3HjuxoWtbaPgQ7k31pOA+ekt+GnkTDLtexOAModBNgp
	 4e2OsXagqP1xA==
Date: Wed, 11 Nov 2026 21:18:05 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 4/6] stddef: Add const_cast()
Message-ID: <avTMrylZawfodg_A@devuan>
References: <cover.1794425425.git.alx@kernel.org>
 <ce623fe0432ba7fe74e12171e52d2dd1f1ad2c39.1794425425.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="wqjyunsqqp33uwdl"
Content-Disposition: inline
In-Reply-To: <ce623fe0432ba7fe74e12171e52d2dd1f1ad2c39.1794425425.git.alx@kernel.org>


--wqjyunsqqp33uwdl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 4/6] stddef: Add const_cast()
Message-ID: <avTMrylZawfodg_A@devuan>
References: <cover.1794425425.git.alx@kernel.org>
 <ce623fe0432ba7fe74e12171e52d2dd1f1ad2c39.1794425425.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ce623fe0432ba7fe74e12171e52d2dd1f1ad2c39.1794425425.git.alx@kernel.org>

Hi David,

> Date: 2026-11-11 20:55:39+0100
> From: Alejandro Colomar <alx@kernel.org>
>
> This macro serves to cast const away without risking unwanted
> conversions due to mistakes in the cast.
>=20
> It's similar to C++'s const_cast(), but it is more restrictive: it can
> only cast away 'const', and not arbitrary qualifiers.
>=20
> David made it a bit more robust.
>=20
> Link: https://lore.kernel.org/linux-hardening/20261111102535.434c2eee@pum=
pkin/
> Co-developed-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  include/linux/stddef.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index e1851c50c89b..5201d71db387 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -194,4 +194,16 @@ enum {
>  #define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)				\
>  	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
> =20
> +/**
> + * const_cast() - At most, drop const in the left-most derivation of a p=
ointer
> + *
> + * @T: Type for the cast.
> + * @p: Pointer to be casted.
> + *
> + * If @p is of type const @T, then it is casted to @T.
> + * If @p is of type @T, then it is returned without any casts.
> + * This avoids mistakes that change anything other than 'const' in a cas=
t.
> + */
> +#define const_cast(T, p)  _Generic(p, const T: (T) (p), T: (p))

Ouch!  I _thought_ I had built with this already, but I might have done
something wrong.  Trying to build now, it fails to compile.  Which
reminds me why I used 'default:' in the first place: when T is the same
type as const T, this fails to build, because _Generic() can't have two
identical selectors.

So, indeed, we need default:.  It's not a big problem, because since
the type T is already validated by the function itself: it T is not
something that can be passed to strprefix()'s first parameter, it will
fail to compile.

So, I'll revert this in v5.


Have a lovely night!
Alex

> +
>  #endif
> --=20
> 2.55.0
>=20



--=20
<https://www.alejandro-colomar.es>

--wqjyunsqqp33uwdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0zXcACgkQ64mZXMKQ
wqkGUA/+OaiDbeJU30QN+XXhjq4wsZoadkGM+HONKlcYIvwd1wpZCXvTexjqEAiu
rBOd45EWU9TJmFtZfv0ss7JTAc5xMLd7aFuqjFWXUQeb0xlMmHyb1RyU8wEHf2TP
b9l8iEe2F0wpccRV30rYPspU28euHBBwvIVQaoWRFNztin3JDGFM76O8OPXI4ySP
oErRSC5piw6pB1fLLy0YfyobN4qkzm9TU6qjnz8W+LUWE2lLq3L2AyRwth6oE/5E
Y3l1kVzSJFuyvlf2pFUxGsNTt0GyHP0UD3tRB0uSJkg/VKOCPChJPXNZiM8IERPU
EH8hK4TivyOOgfEl6M35wtjASXP3TUtZqIajnGuVKIDCb1lq/s5nZGJavY5G9NCQ
NCN5azwflC5oLRU+4gVaTaoXGRq06ZPZYTpMlR6qcHQAhexT+K1/MJXmCDiRpD2f
T4HSIzb2y/3jZW48Ac+5miIOz/AJn3/kq7yu0VvSwmYqBMDqouuPYaOyD7v1CvPW
CT/T3+VPGXsYTAgyZ/4bj4noo33Rr0K1SgBQcwrgtbKOSbCyCf3wny0cFngFZeEj
cm0nPs5WLLhnD6aDNwvrPKRN0U6r5Dkqp/BDgQqqkIr+nDlauvmgPYboFufrkQs/
bKfX7UNnK9v+T1LTE3qorD8tPCCSYtCabBda3K3CYLRCkdw3kic=
=i3+x
-----END PGP SIGNATURE-----

--wqjyunsqqp33uwdl--
