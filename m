Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896390;
	b=1jnK81dtbjCmmvO1oSQWklX8uhAW996F9AVQdyxYCWdHy//sCS6Frr3DgdpACoWd/wmI
	 cBL09fh+9ugZYR1I9mGUBtr2JXcYMSFP5NCWgudqt8eEAZquPTNecbz7nJ+M3EelQeAJX
	 DgkKgDDq2yJs7BIqsBd5rvYqNNoopd3sWbBnwCWWZFsuiX3R2AqecC/orRx3DEcr9mJiZ
	 lDhO2VqVdJ+lxDJjYNtE/FSkGVoDdySFvqzw2mVeDI8DEjDrw+Rp763PpajAKp0A4zZVI
	 C2yrRIu6WXPJ6a1ehfNErJ0ObksgAwlYWAX70YARDIz7NN0V9vUe5+JYpmQuBBCdnWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FhU1YAs03KzkuLsRaXs5pUXGz0dCpsIPHz6nLpR6L9M=;
	b=PFNxa3dXtbxXzWwgtCgL98Z5tPkuKZeYrrt09jvsmDY2+/SZXB0iwBxdbsTlKexbIGn9
	 9mYSmsdxcMmFLmi61hYOQnC1FqqhvSQzw/UrCXg4/sBDEqo0ilVhueLCBKifiAKFOewIn
	 xSWJb0W6VeWQE5bJm2lEX7nTpYGqprGy1cLDlGkMZdqqkYnC2z7F12JHpOx4pV1CCvky0
	 02tYoaki/vPXvSzYRl8fCeAQcQ8MyrruzyrBZxCyBr1sVG2Rt9Annw+U2TJmX7DO50ghD
	 i2FGJlNMQoJh0a5uP0zIU0b1ixMq9a8wXBa8xMKhbvkAVEYm0JC8dCXoBjRNwzOgMHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGuQjJ2I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A62606D803;
	Thu,  5 Nov 2026 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGuQjJ2I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16FB1F000C1;
	Thu,  5 Nov 2026 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896390;
	bh=FhU1YAs03KzkuLsRaXs5pUXGz0dCpsIPHz6nLpR6L9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JGuQjJ2IzssB77zke8KW3yK/VSod7eeoyy9t7ZTZhBJCjResJ0dckz9+lMYw7NOf9
	 F5R4olK9SPS7aMgwfj6OE6ufefVFv2QcIBeNQSxJ2rdOSQEGaWS/FSlCKhTugVT+Pa
	 FmWJBn8kLD4kcYEIJ7PrcAOL2glUE0kcPeAvAkEPrX4bqPjQn8wVRHES5Qx4KN79ZP
	 QCVvkstFj2L8seoIYFYMTLjuR4m4Yx0C27xsat2MeBgnLTKp+jiDF/nIyHt+uetOjo
	 lyfZCjcopWXzsGbHj27gW2IS46XR/sKVOt0S9Kp+/j6N4jlJZkBNVOQtH3cvl2cSJY
	 VziQRZtLXdiQQ==
Date: Thu, 5 Nov 2026 17:33:02 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <auyuINXEJKc1KoG7@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home>
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
	protocol="application/pgp-signature"; boundary="z5ynmj5lbq6r3lak"
Content-Disposition: inline
In-Reply-To: <20261105111423.360f4ba8@gandalf.local.home>


--z5ynmj5lbq6r3lak
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <auyuINXEJKc1KoG7@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20261105111423.360f4ba8@gandalf.local.home>

Hi Steve,

> Date: 2026-11-05 11:14:23-0500
> From: Steven Rostedt <rostedt@goodmis.org>
>
> On Thu, 5 Nov 2026 12:13:03 +0100
> Alejandro Colomar <alx@kernel.org> wrote:
>=20
> > As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> > between an empty prefix matching an empty string from a non-matching
> > prefix.  This is a fundamental design flaw in this API, and not
> > something that can be fixed.
> >=20
> > As always, this is a consequence of choosing sizes instead of pointers.
> > Sizes are often the wrong choice.  In this specific case, pointers are
> > more capable of differentiating these cases, as NULL is a special
> > sentinel value that doesn't need to overload a valid value.
> >=20
> > Let's implement strprefix(), a function that returns a pointer
> > right after the prefix if found, and a null pointer if not found.
> >=20
> > We'll slowly migrate existing code from str_has_prefix() to strprefix().
> >=20
> > Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>=20
> Is there a link to the report? Please add that.

Message-Id: <20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.c=
om>

or in link format,

Link: <https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-pro=
p-v1-1-6e28fe1c72c4@oss.qualcomm.com/>

Which one do you prefer?

>=20
> > =20
> > +/**
> > + * strprefix - string prefix
> > + * @s: The string to be tested
> > + * @prefix: The string to see if @s starts with
> > + *
>=20
> Needs a better description. Feel free to use the one for str_has_prefix().

Ok.

> > + * Returns:
> > + * *  @s+strlen(@prefix) if @s starts with @prefix
> > + * *  NULL if @s does not start with @prefix
> > + */
> > +static __always_inline char *strprefix(const char *s, const char *pref=
ix)
> > +{
> > +	size_t len =3D strlen(prefix);
> > +	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
> > +}
> > +
> >  /**
> >   * str_has_prefix - Test if a string has a given prefix
> >   * @str: The string to test
> >   * @prefix: The string to see if @str starts with
> >   *
> > + * DEPRECATED: Use strprefix()
>=20
> No, it is still useful. Converting trace_event_filter() to strprefix()
> would be very painful, and likely error prone.

What is trace_event_filter()?

	alx@devuan:~/src/linux/linux/master$ grep -rn '\<trace_event_filter\>'
	alx@devuan:~/src/linux/linux/master$ grepc trace_event_filter .
	alx@devuan:~/src/linux/linux/master$ grep -rn trace_event_filter
	kernel/trace/trace_events.c:2833:static const struct file_operations ftrac=
e_event_filter_fops =3D {
	kernel/trace/trace_events.c:3222:			*fops =3D &ftrace_event_filter_fops;

If you point me to a specific line of code, I can attempt a rewrite.

> > + *
> >   * A common way to test a prefix of a string is to do:
> >   *  strncmp(str, prefix, sizeof(prefix) - 1)
> >   *
> >   * But this can lead to bugs due to typos, or if prefix is a pointer
> > - * and not a constant. Instead use str_has_prefix().
> > + * and not a constant. Instead use strprefix().
>=20
> The above can be replaced with:
>=20
>  * This is useful for testing for a prefix and returning the length.
>  * If you only need to test the prefix and perhaps get the pointer to the
>  * position of the string after the prefix, then use strprefix().

Ok, conditional to being convinced that str_has_prefix() is
actually useful in some case.


Have a lovely day!
Alex

>=20
> -- Steve
>=20
>=20
> >   *
> >   * Returns:
> >   * * strlen(@prefix) if @str starts with @prefix
>=20

--=20
<https://www.alejandro-colomar.es>

--z5ynmj5lbq6r3lak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsr7gACgkQ64mZXMKQ
wqkFGBAAmcdE+NG6xDt/RUEGv3puVSofWYpycFYxpP/mQqvwKV0ms9Z86KCHQNfJ
lpogTxCKGGV7MWTonv2y+uSbM8c001AtGc6FqSGYO3WAfvbSgSQWC/Qf4mzK579o
zQSuKIVybaYOtpeebzWAqzg7kL/G6iA6RyGse4Sp5wpSPr57JbOLdw09IGXA7JqF
tUv49HRJby6IMlEPpiKjVBdY2JC4ySK2t2mPDNarCDunbaFenOsE/QPTL4BMN6KM
KDetGOZz9HTdo5TvbClgGyI7GCf4kODH0CWIc3GdAJhXF4XOvb5riEhcxnfOZcH6
pTA6EvUrbIClrLZcbhvWRhAluVy7Qj0WyoHtnilsOq3FVhgeTTpyWdwprbbBByw0
CRFeV8k7IO9i7mFni2fYYbZ7NuQASkGOL2M4uKvhELmjdMFwb2iPGtfNnbsNsZ0J
x2p7Wp75pqlrbWuHp7jtphFO2SbkcUG2tAMgdXIE1truTMWs3vH/W92xAGS70Sho
rVLxZPg177Jr53JgP6LDNo5+sBzylxUQfGMxg3ri/zcRJVPeo9dh6o6NvrXlUOJU
O2AcoGQ4e3FTVhwFK07kjJU0mqCkxtHU+IZasD1Sv8nPsed0z/e0ENMeJsZDMOUz
Zbp7Zy0edTGmf9xza8mCrv0i3E4mvHD/t+xMuz3mGLLX/d+V0Og=
=A3MJ
-----END PGP SIGNATURE-----

--z5ynmj5lbq6r3lak--
