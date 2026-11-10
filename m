Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309245;
	b=RPICqJXo9Jeu51pEWh88KT2rDQ+4WFtBfhUq+jKe3PCZT3iF+qiZLWjft7ksXLz89TWt
	 7GhHnH9kxv3J1oYVPhBIPA80kL6EShwOnFRGdwVhcaPtEvMLOWmLfSY8EChp/GeG14Z8o
	 LKlxSDWbtSiSJrzlNQY5kw7Gwl/C4QnmT4rFuxYkpGFVcTo7v6br8S75iV99eDd3sLTng
	 Qei911qYCsqNOOEqlX3/Sltz0ewW5Ix9ykMtMI80PWcMve+EYbTC4ZFOk5Y6iMe/cTcxs
	 RaMJf5ffXAxPEEOE1Erupkou0NHybIgSnvWL1O3c/Guv6CyWEx1Ej2d0fEHEzyKNbGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309245;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EJYGyku4plj4YEG/HyqlppooqGbqsGjX4RZGU5RMAbo=;
	b=rXQzrOXd0nuW3tRQFYQvPFmhm9GTAJa3ed+BnxYT5nNh0j0Dp1aMX2uswuWoUUtt+DDa
	 r5VRf/LCXizibHMMCszZ1fWoNuHEiIIow4K4GA0lbNKEx4EOuMMD9QRYY568AzwhvTPjU
	 +u4jZMGtv71prEW2JWhVmLpNDLFIIbX4QR/E0SS8eFTVhIsnH91A7E5VZWv2ADhHCkofX
	 m2zB0be40jfdF+YfEj9pra9VePtM780SZQD+2woXEys9aH3Yl+Onu6saC6dWlGS8APK0+
	 0xgZX9NizCC5LMho9JFKGILl1rAFgwZNPXAFL//RHQeJlV0kYoGW5jzNhW6OKsBUYUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgIDDh9w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DA606A31C;
	Tue, 10 Nov 2026 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgIDDh9w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9614C1F008A2;
	Tue, 10 Nov 2026 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309244;
	bh=EJYGyku4plj4YEG/HyqlppooqGbqsGjX4RZGU5RMAbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PgIDDh9wYkSzRgTXcE924njSkPqk0YnOqO0dt1BhVGNnu+S2Ulu+CmHQ55ani1zhq
	 a6snBhc7RHLcI1FoRlYK+GfpUGDs0bhlgetWiW3AcfU2dmYB3upSePUY5OgXbkdP/Q
	 qneG4c56ANkklwEJWL8d1lZ1754hIZQ4xnm/L5Anb5OQsfYsQeLUG+ppuqBXvfwYTJ
	 Nx4INZbGak+MqGlJQgHPuQEUCGgiL35t3yzESBkn534aN32P42J7tyEORBtklNp7rz
	 Nr9Fmxg8wTExnABcYusZzcEt0HOZUvlJER+NGXznkcYp7RkPgYGGYBUkxv3nkzKfD9
	 cx4eD7kv+7aRw==
Date: Tue, 10 Nov 2026 12:13:57 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
Message-ID: <avL8UwNK8iXJQIUo@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <avL4LoCz2wc164zo@devuan>
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
	protocol="application/pgp-signature"; boundary="duvq6kgm7ybsxza3"
Content-Disposition: inline
In-Reply-To: <avL4LoCz2wc164zo@devuan>


--duvq6kgm7ybsxza3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
Message-ID: <avL8UwNK8iXJQIUo@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <avL4LoCz2wc164zo@devuan>
MIME-Version: 1.0
In-Reply-To: <avL4LoCz2wc164zo@devuan>

> Date: 2026-11-10 12:10:57+0100
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
> Hi Bart,
>=20
> > Date: 2026-11-10 10:00:42+0100
> > From: Bartosz Golaszewski <brgl@kernel.org>
> >
> [...]
> > > > > > +		names[i] =3D kstrdup(prop->name, GFP_KERNEL);
> > > > >=20
> > > > > Can property be statically defined somewhere? We might want to al=
so optimize
> > > > > these duplications with const variant (here or elsewhere, for fwn=
ode generic
> > > > > path, I believe).
> > > >=20
> > > > Please rephrase because I'm not quite following what you're saying.
> > >=20
> > > Can prop->name come from something that is declared as
> > >=20
> > > static const ... foo =3D {
> > > 	... .name =3D "bar";
> > > };
> > >
> >=20
> > You can't know it for every instance of struct fwnode_handle, so the
> > answer is: no.
> >=20
> > PS: is there a way of using match_string() with non-const data?
>=20
> Given the definition here:
>=20
> 	$ grepc match_string .
> 	./include/linux/string.h:int match_string(const char * const *array, siz=
e_t n, const char *string);
> 	./lib/string_helpers.c:int match_string(const char * const *array, size_=
t n, const char *string)
> 	{
> 		int index;
> 		const char *item;
>=20
> 		for (index =3D 0; index < n; index++) {
> 			item =3D array[index];
> 			if (!item)
> 				break;
> 			if (!strcmp(item, string))
> 				return index;
> 		}
>=20
> 		return -EINVAL;
> 	}
>=20
> You should be able to call it with a cast.  It's dangerous, but
> technically it works.  I'm not encouraging it, though.  :)
>=20
> 	char **strings;
>=20
> 	...
>=20
> 	i =3D match_string((const char *const *) strings, n, "foo");
>=20
> This is a historic problem in C, which was solved in C++.  I have
> a proposal paper for the C Committee for solving it as in C++:
> <https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3987.htm>
>=20
> This paper will be discussed (and probably voted in) in the next meeting
> of the committee (which happens next week), so there's a chance that
> this will be solved for C2y, and thus the cast will no longer be
> necessary.

FWIW:

	alx@devuan:~/tmp$ cat const.c=20
	#include <stddef.h>

	int
	main(void)
	{
		const char *const *ccp =3D NULL;
		char **p;

		ccp =3D p;
	}
	alx@devuan:~/tmp$ gcc const.c=20
	const.c: In function =E2=80=98main=E2=80=99:
	const.c:9:13: error: assignment to =E2=80=98const char * const*=E2=80=99 f=
rom incompatible pointer type =E2=80=98char **=E2=80=99 [-Wincompatible-poi=
nter-types]
	    9 |         ccp =3D p;
	      |             ^
	alx@devuan:~/tmp$ cat const.c | gcc -x c++ -
	alx@devuan:~/tmp$=20

C2y, if my proposal is voted in, will behave like g++ above.


Cheers,
Alex

>=20
> The history of why this is not allowed in C but is in C++ is, as far as
> I've been told, the following:
>=20
> Back before C and C++ were standardized, C++ invented const, with rules
> slightly more allowing than what they are now.  This was going to be
> standardized first in C89.  But very close to the release of C89, they
> realized about the danger of converting a const char** to a char**
> implicitly.  They were so close to the release, that they opted for the
> safest approach: disallow any non-trivial conversions.
>=20
> Later, while standardizing C++98, they realized we could allow a few
> more conversions safely, and so they did.
>=20
> C could have taken advantage of that, and pick C++ rules in C99 or C11,
> but for some reason, nobody proposed that.  I'm proposing it now.  :)
>=20
> We've already discussed this proposal informally within the committee
> for some a year and a half, and there seems to be consensus that we want
> it.  We're only being careful about the specific language.  But I think
> I finally got it, and it will go in next week.
>=20
>=20
> Have a lovely day!
> Alex
>=20
> >=20
> > Bart
> >=20
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--duvq6kgm7ybsxza3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmry/HUACgkQ64mZXMKQ
wqn/iBAAiyKr32RTSK1TYPvSQDL88d2mG37wJFkiZwQ+iI8faT6DtjYjQitkYcwD
3CjIdOt1+IDPhpe1Cgmr9JdLdORzxcjiGzprYHyTJ2tI48XhfGmuL1tX39aR7RrF
/myY8MICWrxtYs+pA7gNydDwWdpSncWv7xNa0FKP+kzy8tr/unrPcfWxlUL9wtZs
KbWQvzyGzOK3tA9JrOYl7mS/qmUoGUq3kZGbxnYV1Mho22LXk/fa4kB4cSsCUgY0
VrXy4W7R6InMPl3z6iAi6QzKo4qZD6xUYOtDsSsgQ0bobe4Rg0uRWVolH+8DG+6Y
/Ri6DuEwV8x15Y5gzzu826tQYuZIPt+lr3Q3IfiLF3FcGTjHHN0uoh/EXggsH0ih
Yni/L5hj7ldlItbFyaY0WTPtv1C/GCv5DOEDzgKXltLVLdXARD3vbwIAcAto/T/N
7wPsnH5PDd/TCRuQsqr41rPVeF54KpIInzrWttZ7LFHBKe/EWsIJnShFfju+V1Uj
R9PcJaiiq597UzR8ffJMquBsjnz4eUTXtsaFg7jtp/A2/s4earwxUcqWnDcOmdz6
U/izMMopfrM/NCnXvBpXeIMDMY9ZOCo0zawfNqb8JnxS1OOPyulZQsRkPNcAfY/K
KTkHdVHdOzs+8iG7FGCaHW+15ZVskdXQzzo+n3oOTiOlvcf4ZDk=
=7Dj+
-----END PGP SIGNATURE-----

--duvq6kgm7ybsxza3--
