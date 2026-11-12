Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794526458;
	b=Tytx7d3Yza7OUj5P2k/fi28JVs9Nc0rHLheodzM7+UMlNjZSBQw4CXky9IeiVRHFlvBq
	 NIPU0fIcOW+sFzXdXsmU2rSqX965vjkdhqCtGXCEyJvUVcIz5JUP2eW2v+M9BkKaSAz/W
	 69vrLgBWYBTxyKlwYNId+EKsbLvXM8NZoCym8lnEPmqACmBmbGz7CVdsVhO0GBDL7jtHH
	 ChlYevMJRk1dZA9LQ5AMavpQsOz+7pubQsanlax9Uq+pIoKAccRELX9aOUDtVWkC53e8I
	 um+05yyiUfgZzQ3PKRX3QZuIaAyyyN+w+L8sWblMOV88zKmtFf0OEKudxAF/TeV1iRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526458;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Sh9ZL6OASL7x6o547mKhzUESIR8P4jSUl+e/976Cyns=;
	b=qXR7cdpLdJS1UT1uzhx71sJwTLyUqECN/pYzyAbxBAg02NzXDpweq1Gy61mPGerzS3hZ
	 en0nZbm338zl/Gc+yFZXtpEWetEX7Cqk9NfUOAPxhNn8z8eDp/P86aryNQkMsHtCo0gLr
	 gOWc2RX+6NOJ5mRemQ+9KZ7HGMOd7i2xOwBrinupvmUvgjfOOF2tic36vuzC2TmVbYk/H
	 pGypxudzhzA6XMVYfMWP9Y0DmkI+U4TY6UE81FBAvKN/6lBiAmufuV/8Ar+bv3UN2xyLH
	 bmjKe0Tw5PYQX3iUejLlWI0xBoTC7ptm3VVU8axpJxBthC3m72HSUqcJkY3Zue8Ev8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZeYvC5t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE1606A31C;
	Thu, 12 Nov 2026 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZeYvC5t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D441F000C4;
	Thu, 12 Nov 2026 23:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794526457;
	bh=Sh9ZL6OASL7x6o547mKhzUESIR8P4jSUl+e/976Cyns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eZeYvC5tgpej/tohuXCQuUmLwb0rAaRU9EozOQnEs0zGx/L0817OmWOhtNy/H2Hgc
	 0MfxQE9QBEEs5bpqbYRifBr9wPavBop5WvEdWu2LimnHfzL0JdBa9uCkSucNqQfbtg
	 Lb1dZYUvZ/DCxIIUZXvZxY7f7WYL+MyBjIXEsXPEp+kaM5PgvBYN/ffV87gUGMBSf3
	 GM4oF+xy7ZebBFbdzzcrClFKrZns5XTxmSuN9XJLDXGLjpxoKHxugnIw6IqgvJFqji
	 GusLrXXxjfJSqQolEghxECt4DcSTUy0xLsukjkUXMr6usfy1YnrBz67PJkt3oh0zhB
	 osRcK7ecH4D+g==
Date: Fri, 13 Nov 2026 00:34:09 +0100
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/6] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avZLqUuq1OApg_MS@devuan>
References: <cover.1794425425.git.alx@kernel.org>
 <a74fabd985a874da7556ae1601053b4bcc100f13.1794425425.git.alx@kernel.org>
 <20261112223107.3a9efb85@pumpkin>
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
	protocol="application/pgp-signature"; boundary="old5g3x2i3efn55u"
Content-Disposition: inline
In-Reply-To: <20261112223107.3a9efb85@pumpkin>


--old5g3x2i3efn55u
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/6] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avZLqUuq1OApg_MS@devuan>
References: <cover.1794425425.git.alx@kernel.org>
 <a74fabd985a874da7556ae1601053b4bcc100f13.1794425425.git.alx@kernel.org>
 <20261112223107.3a9efb85@pumpkin>
MIME-Version: 1.0
In-Reply-To: <20261112223107.3a9efb85@pumpkin>

Hi David,

> Date: 2026-11-12 22:31:07+0000
> From: David Laight <david.laight.linux@gmail.com>
>
[...]
> > +static inline char *strprefix(const char *s, const char *prefix)
> > +{
> > +	size_t len =3D strlen(prefix);
> > +	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
> > +}
>=20
> I suspect this would be better as a real function.

You mean better for performance?

> Possibly even just a simple loop rather than based on calls to
> both strlen and strncmp().
> (Even if the strelen() is mostly a compile-time constant.)
>=20
> Something like:
> #undef strprefix // Or put it the name in ()
> const char *strprefix(const char *s, const char *prefix)
> {
> 	do {
> 		if (!*s)
> 			return *p ? NULL : s;
> 	} while (*s++ =3D=3D *p++);
> 	return p[-1] ? NULL : s - 1;
> }

I don't know.  In user space, I expect strncmp(3)+strlen(3) might be
better due to being super-optimized by glibc, and making it easier for
the compiler to understand the code.

Here, I'm not an expert about such micro-optimizations.

I personally prefer leaving it with the calls to strncmp(3)+strlen(3),
which is safer (the manual loop with byte operations is full of
opportunities for off-by-one bugs), and more readable, and leave it up
to anyone who wants to optimize it to do that later in a separate patch.

Also, having it inline might help optimize further than what a loop can
do, because the strlen(3) call will be entirely optimized out in many
cases.


Have a lovely night!
Alex

> And in the header:
> const char *strprefix(const char *s, const char *prefix);
> #define strprefix(s, p) ((typeof(s))strprefix(s, p))
>=20
> David
>=20
> > +
> >  /**
> >   * str_has_prefix - Test if a string has a given prefix
> >   * @str: The string to test
> >   * @prefix: The string to see if @str starts with
> >   *
> > - * A common way to test a prefix of a string is to do:
> > - *  strncmp(str, prefix, sizeof(prefix) - 1)
> > - *
> > - * But this can lead to bugs due to typos, or if prefix is a pointer
> > - * and not a constant. Instead use str_has_prefix().
> > + * This is similar to strprefix(), but returns an offset instead of
> > + * a pointer.
> >   *
> >   * Returns:
> >   * * strlen(@prefix) if @str starts with @prefix
> > diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
> > index 0819ace5b027..73d2614b1474 100644
> > --- a/lib/tests/string_kunit.c
> > +++ b/lib/tests/string_kunit.c
> > @@ -287,6 +287,14 @@ static void string_test_strspn(struct kunit *test)
> >  	}
> >  }
> > =20
> > +static void string_test_strprefix(struct kunit *test)
> > +{
> > +	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foo"), "bar"));
> > +	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", ""), "foobar"));
> > +	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foobar"), ""));
> > +	KUNIT_ASSERT_NULL(test, strprefix("foobar", "bar"));
> > +}
> > +
> >  static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
> >  static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
> > =20
> > @@ -891,6 +899,7 @@ static struct kunit_case string_test_cases[] =3D {
> >  	KUNIT_CASE(string_test_strnchr),
> >  	KUNIT_CASE(string_test_strrchr),
> >  	KUNIT_CASE(string_test_strspn),
> > +	KUNIT_CASE(string_test_strprefix),
> >  	KUNIT_CASE(string_test_strcmp),
> >  	KUNIT_CASE(string_test_strcmp_long_strings),
> >  	KUNIT_CASE(string_test_strncmp),
>=20

--=20
<https://www.alejandro-colomar.es>

--old5g3x2i3efn55u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr2TOUACgkQ64mZXMKQ
wqmDQQ//Yu41xZyNKzxBSm8wsuEig7agWdonWXyNMq+1QZQ5OJ48m5pcEOuKSnEY
Owih2vpT5IAvOSQNaznvvzDrzmVSqoleMLnqaKAgW0qUKAX9jDJM0jGC07/VTKuM
dojm2fut1khwmig4txxRNT5hghgko3coLs2fsi/oGGoUlV42ixlxc1HYCu5N01mk
vvXh4WfRtyKUXf52s5/tC2fB79yYmW8S8rv7JWwmJRMHw0DhCdgWtUvdDwJjNRdx
02dQChGkKhl8OZiSdvwZ4RF7BqA1K4ruDeCSlFdcRFv/X+oWvaaqdiH5Yzp86hek
RVOAem+ztCvkXDyxKCDuGgCwW0cOw6M8Jsi8hlzksic9FkVoNO+qLCoyoZB870n6
APwXUwt1ah0zFi8K3JiMpI9KqGTsbqrKd0xZmtZ94ogAZWlCowalsfGjuXD/6sZU
Fo1fSm/crDdVzBTM8Ouch+sX+q+ouwxo9WQ00mr4K6T4O42L9RR8Lk2mHT5UQGnU
Martjy+ZhTcGfqiQ0rY1m+Q1c30pmuAonlkaKKZEO+Bi/l8cQqRCpqVGi9tzBnYh
m2V7MN1OllP7+C+Ne4EyDGHmvui//9AYI63NxnBrtnPnPcb9iRtUc+csRz6ItwNP
gCUutAEaPAFg5814l0JSidCzPyAmxxHUt8vULfUMt18UnwV/+uA=
=GnGK
-----END PGP SIGNATURE-----

--old5g3x2i3efn55u--
