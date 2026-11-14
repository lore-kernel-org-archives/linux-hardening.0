Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681358;
	b=OvC/SSxJwIMLG2soH/CTQGiUK8XzhUTgK1pYj6VnMYvDa8ngfsYh5KXkOk8JdUYHQ8E5
	 9/OKJN6nE0mT1+giM6Ht2J2gXEEoIV1Wq+G/mEqNks7N3H2XqxG7Kn3ShZ5MCvu2TtwWT
	 dRqUmXmQ5GitDdXNVoEbrnmMzPWX5NrPLl7F+3wOkJEZxYoOj53SK1fSb4YtAsssoGuyx
	 yAQ24rPdqqzwLeu29bGxCYU6nAGHWvmt4cvHE9tss/SpgSEFX4w4ROMiOe+AJjOmGRIZA
	 R/J7/YEcWobiJ0AuswM63or3ZA0aonHA+izMYZHr7iJE6u6g/qQVWds2/s/qGYUZMAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681358;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2ooyXWRMtFslw9WzwoZWv+EIcdXi9S1dTvlk9W/PTIE=;
	b=qeiwR3mwtde9ZvAaQ/MvpdLjyCp79yyHXM5mUf212uIdmFYhcYrppr6Nl/H/rCMx9B88
	 J7UtfuKeQZhUJPrZ60kM86soz0G1dnsEPjkEqfpIuoF/I9SyyRww/4B4U9FRcmYBTyXG7
	 15QQlZnRDlHn6zN6g9IMFHuaE66AWKj6FRJKR7fVqCaWMed0vt7J5dSapEM3bDTG5DMBB
	 TkJm2rJKz0DNcvxKA6OR7X/RBrIlX3cZs2ajCK9nBmCrVZ3Wj9EEdKnEhrm2SwIJpNPbi
	 rcKz2/UuBGizwWI/t92kBWfxF2DpMHrODZV1lZ98HBnKAbbispu+LijjaQozwdBV14A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvGeDvAO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A89606A327;
	Sat, 14 Nov 2026 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvGeDvAO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FE61F000C4;
	Sat, 14 Nov 2026 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681357;
	bh=2ooyXWRMtFslw9WzwoZWv+EIcdXi9S1dTvlk9W/PTIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bvGeDvAO9fZn7rhcv/WgdJM/KFNwzPYGLc418Ij+GG+hDc3S1mmLwamBELXK5VjAZ
	 A5SQAQVs1MfXnkqOEymwEJfE+OOjkwtn9pVM+vA8TO9X7ckAHNdYrRaNTx8mGjTnot
	 EWSRiDTQkpHquERzhDu5B0PiGT4u4KooNDYV3FxNyH0891Z/q7/AjMuIBhsWGxZeff
	 YOT0cacdmprENJEmLXOfjoIOWyZ4r82KpJD6l5qZ5b5v1hjZJwNg8fzgdaAujJgVNg
	 YW4/EhDchhtVC+M4ddJ0HGytkPJZZk9qwkNFFmchfwubd8VhpAFBkmDgI7dUmir820
	 Ko6dkkrBwTu5A==
Date: Sat, 14 Nov 2026 19:35:49 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v6 02/19] string: Add strprefix()
Message-ID: <avioOefTkbt9RRd-@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <6de04b9cf2dfe9ff1dacdddc0a76752a714a991c.camel@perches.com>
 <aviTcYS995cB-lTY@devuan>
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
	protocol="application/pgp-signature"; boundary="o7urukik6pfwpygo"
Content-Disposition: inline
In-Reply-To: <aviTcYS995cB-lTY@devuan>


--o7urukik6pfwpygo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v6 02/19] string: Add strprefix()
Message-ID: <avioOefTkbt9RRd-@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <6de04b9cf2dfe9ff1dacdddc0a76752a714a991c.camel@perches.com>
 <aviTcYS995cB-lTY@devuan>
MIME-Version: 1.0
In-Reply-To: <aviTcYS995cB-lTY@devuan>

[CC +=3D Rusty]

Hi Joe,

> Date: 2026-11-14 18:03:44+0100
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
> Hi Joe,
>=20
> > Date: 2026-11-14 07:28:23-0800
> > From: Joe Perches <joe@perches.com>
> >
> > On Sat, 2026-11-14 at 16:22 +0100, Alejandro Colomar wrote:
> > > As Bartosz reported, str_has_prefix() has a bug: it can't differentia=
te
> > > between an empty prefix matching an empty string from a non-matching
> > > prefix.  This is a fundamental design flaw in this API, and not
> > > something that can be fixed.
> >=20
> > I still think this description is poor.
> > It's neither a bug nor a flaw.
> > It's a design choice.
>=20
> As explained in more detail in the subthread, I think it is a bug.
>=20
> If the function name were strprefix_len(), it would be a legitimate
> design choice, since 0 would indeed be the length of such a prefix, and
> it would be arguably useful to return 0 on a non-matching prefix.
>=20
> But the function is named str_has_prefix().  Since an empty string is by
> convention (strstr(3), etc.) the prefix of every string, returning false
> is a bug.  Since the function returns 0 for such a case, it misbehaves.
>=20
> Perhaps we can reach an agreement if I prepend this commit with one that
> renames all uses of str_has_prefix() to strprefix_len().  Then, I would
> agree to consider this as a design choice, and remove the text above.

Here's the list of categories from Rusty Russell:

	10. It's impossible to get wrong.
	9. The compiler/linker won't let you get it wrong.
	8. The compiler will warn if you get it wrong.
	7. The obvious use is (probably) the correct one.
	6. The name tells you how to use it.
	5. Do it right or it will always break at runtime.
	4. Follow common convention and you'll get it right.
	3. Read the documentation and you'll get it right.
	2. Read the implementation and you'll get it right.
	1. Read the correct mailing list thread and you'll get it right.

	-1. Read the mailing list thread and you'll get it wrong.
	-2. Read the implementation and you'll get it wrong.
	-3. Read the documentation and you'll get it wrong.
	-4. Follow common convention and you'll get it wrong.
	-5. Do it right and it will sometimes break at runtime.
	-6. The name tells you how not to use it.
	-7. The obvious use is wrong.
	-8. The compiler will warn if you get it right.
	-9. The compiler/linker won't let you get it right.
	-10. It's impossible to get right.

str_has_prefix() would get a -7, because the obvious use is wrong, or
perhaps a -6, because the name tells you how not to use it.

strprefix() is not perfect, but it's decent.  I'd say it can be a 3 at
least, if we document it as the following:

	This function determines whether the string pointed to by @s
	starts with the sequence of characters
	(excluding the terminating null character)
	in the string pointed to by @prefix.

	Returns:
	*  @s + strlen(@prefix) if @s starts with @prefix
	*  NULL if @s does not start with @prefix


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--o7urukik6pfwpygo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4qf8ACgkQ64mZXMKQ
wqlOew//WE0aX4ca1YyO/Zijt2BYJ5MSLj5QZkLLEsWA85Wf3chHvFXvlnkrneNq
FLXNKjeA3XFDF0RXFf+ZFMhqqxVZgQfdM503fF0X42F1Tath3Ibf+yBp8QGbgVkc
S3rqLOPZGXvscFA+35gjairoCGswgcWojy5knXOTHKN0TA3WOY8fyQWSKXDTSSFO
Es0c8m7upIsEEZRbcuqs5QuxoS4fqBYyerr4fEdZmrm67hTlNQmtuYGF4i3z12f7
Kn+2oB4+SRqwmNnTReffYoyv6F/RNuJEEXebyFqT5EejINvJLIfI15F3GbSKmpp7
sUue6IAYMJxmWGJkXJngaMiwwElE+1rYMcm2wNpFxjAXNukOrF9mRiYuLNw3sVKV
Tol1dbKLwkY2HUrx9MeK5D4SafQWUkNx8hKGWeu6uAqHGeCN3dB8hoYbviUkLPSc
VOIQ8Sh6uSOxAljt9p5dSpPgvBcJQ8Hin6ZrHt+BELfhk10uPXqQn2yuiAGys3Ga
KosuEcNl/c+RKrf6aHAqd+Z2DrFp9yD/vXVBwLr/HMr/C48buGuwkFsc1DJsku0D
gQU17bBYAwdTYP0bLERgXz0XSzndrd6FB3a6Zr4wmCy8TW5/1J3JYGoTTVkKX1X/
8/v5CoWKb+Psas4r4pnwTlETclXA3wECzYTymRjWNP34gQBMvPc=
=gajV
-----END PGP SIGNATURE-----

--o7urukik6pfwpygo--
