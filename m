Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323461;
	b=hyLRUFay9yH10S/slMhDJfavvGR5qAAoKckDf49Lyv6Ewv0OF3AuM0n/fGHee1p0fP6R
	 VenQei5NFWOLTK9RibG/JB1Tw9HJ1PiCKIsa9Lj/ykt7CFHK/HxqHOZSC2Fb8wqm9o3GQ
	 diOQFomyiQCWeKqyQlGb2kVr7JDE6iAKRYuGYsW0qsVYKZCiKEgxebwblH/i9dinJKu2N
	 pjQ+xZKtOKl8pnb1Dag5GWA7+awvvPvTuYgY9eMpFnD5hG/H6FZxsiYT7Pr0rer/r3lZ3
	 LUZMln/U1oc3AKxbtR/VzUB3BF395CuebuR+S8fUYsqxO44r/d37xZdxLSfmx+VYOtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323461;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k+JfUV0QhaAHCSo5uKVNqubmDMHshz3Y0tNpTYgBNWE=;
	b=WX8kUhDlzDRCnaPncaycSbA5N31RSKip9nwxx7ruFbpuc5ZtExxkHCrWaLVquXkQCpMS
	 hOiN0L4+0JyhTuksXKZYN9JLpB3J2Vt1QPSz1EUTFsWIpPWwCxWa9OdYeLcayFc7iYeWz
	 5LBWl2iDezYSl1amuPszThASbamfvc9rYoPpKTiCXhjgHqGqKcGp0zZMWqVHkxisXkExH
	 p04GgBOY1tR8gh1mtdQpAuiV04c2U1Wh0fgqxYIPTv3VdeOHUryphZoWbwOYc/xNwrKuf
	 g2fn/Rw8ppbH3IbMK/Hx0H8aDJTaFQXGnT6yW1Xs+PrD407AmvqtlN6tqPOGMD7/iPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ff3FmVsD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1160606A31C;
	Tue, 10 Nov 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ff3FmVsD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117751F008A5;
	Tue, 10 Nov 2026 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323460;
	bh=k+JfUV0QhaAHCSo5uKVNqubmDMHshz3Y0tNpTYgBNWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ff3FmVsDnez4qfT39XX0kcfM/DNkc0rXxt/RVnKcZqMWRUtIVUZO3sY1Y1T/jrJAa
	 LMkcjSntcqIt/Dbq3Xerko7WDpaJXndU2wUtOuoW2+uINMqX2Jsh+NPneCeq+ZzcTc
	 y/10hlPv9GBW10fubJHi/KnE3+svfMF9H9xnKvALCEtFQgdn75smaq1BywPaQM223f
	 lLXjmVkwU/bhZko1W7RzSFeDujo+89KOrwp2v8SoKRveZnQxtqZcT6qfBOCpXiNOJC
	 WtdpzOM3P3/7d3roJBdk72LHb5u6IbqeBvAteyUJlQN8Vrn4anv8df/BaYyyG/q+C2
	 W0F51h3lnQSGA==
Date: Tue, 10 Nov 2026 16:10:54 +0100
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
Message-ID: <avMzoKHbsuMcZpW2@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <avL4LoCz2wc164zo@devuan>
 <avMBNUEL9_V7WnK-@devuan>
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
	protocol="application/pgp-signature"; boundary="qpxgmtmgum7gp73j"
Content-Disposition: inline
In-Reply-To: <avMBNUEL9_V7WnK-@devuan>


--qpxgmtmgum7gp73j
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
Message-ID: <avMzoKHbsuMcZpW2@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <avL4LoCz2wc164zo@devuan>
 <avMBNUEL9_V7WnK-@devuan>
MIME-Version: 1.0
In-Reply-To: <avMBNUEL9_V7WnK-@devuan>

> Date: 2026-11-10 12:35:22+0100
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
> > Date: 2026-11-10 12:10:57+0100
> > From: Alejandro Colomar <alx+linux-hardening@kernel.org>
> >
> > Hi Bart,
> >=20
> > > Date: 2026-11-10 10:00:42+0100
> > > From: Bartosz Golaszewski <brgl@kernel.org>
> > >
> > [...]
> > > > > > > +		names[i] =3D kstrdup(prop->name, GFP_KERNEL);
> > > > > >=20
> > > > > > Can property be statically defined somewhere? We might want to =
also optimize
> > > > > > these duplications with const variant (here or elsewhere, for f=
wnode generic
> > > > > > path, I believe).
> > > > >=20
> > > > > Please rephrase because I'm not quite following what you're sayin=
g.
> > > >=20
> > > > Can prop->name come from something that is declared as
> > > >=20
> > > > static const ... foo =3D {
> > > > 	... .name =3D "bar";
> > > > };
> > > >
> > >=20
> > > You can't know it for every instance of struct fwnode_handle, so the
> > > answer is: no.
> > >=20
> > > PS: is there a way of using match_string() with non-const data?
> >=20
> > Given the definition here:
> >=20
> > 	$ grepc match_string .
> > 	./include/linux/string.h:int match_string(const char * const *array, s=
ize_t n, const char *string);
> > 	./lib/string_helpers.c:int match_string(const char * const *array, siz=
e_t n, const char *string)
> > 	{
> > 		int index;
> > 		const char *item;
> >=20
> > 		for (index =3D 0; index < n; index++) {
> > 			item =3D array[index];
> > 			if (!item)
> > 				break;
> > 			if (!strcmp(item, string))
> > 				return index;
> > 		}
> >=20
> > 		return -EINVAL;
> > 	}
> >=20
> > You should be able to call it with a cast.  It's dangerous, but
> > technically it works.  I'm not encouraging it, though.  :)
> >=20
> > 	char **strings;
> >=20
> > 	...
> >=20
> > 	i =3D match_string((const char *const *) strings, n, "foo");
> >=20
> > This is a historic problem in C, which was solved in C++.
>=20
> BTW, self-correction:  it is solved for char *const *, but char** is not
> convertible to const char *const *, neither in C++ nor in future C.

Self-correction of the self-correction: char ** will also be convertible
to const char *const *.  I was confused during a short moment, it seems.

	alx@devuan:~/tmp$ cat const.c=20
	#include <stddef.h>

	int
	main(void)
	{
		const char *const *ccp =3D NULL;
		char **p;

		ccp =3D p;
	}
	alx@devuan:~/tmp$ cat const.c | gcc -x c++ -
	alx@devuan:~/tmp$=20


Cheers,
Alex

>=20
>=20
> Cheers,
> Alex
>=20
> >  I have
> > a proposal paper for the C Committee for solving it as in C++:
> > <https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3987.htm>
> >=20
> > This paper will be discussed (and probably voted in) in the next meeting
> > of the committee (which happens next week), so there's a chance that
> > this will be solved for C2y, and thus the cast will no longer be
> > necessary.
> >=20
> > The history of why this is not allowed in C but is in C++ is, as far as
> > I've been told, the following:
> >=20
> > Back before C and C++ were standardized, C++ invented const, with rules
> > slightly more allowing than what they are now.  This was going to be
> > standardized first in C89.  But very close to the release of C89, they
> > realized about the danger of converting a const char** to a char**
> > implicitly.  They were so close to the release, that they opted for the
> > safest approach: disallow any non-trivial conversions.
> >=20
> > Later, while standardizing C++98, they realized we could allow a few
> > more conversions safely, and so they did.
> >=20
> > C could have taken advantage of that, and pick C++ rules in C99 or C11,
> > but for some reason, nobody proposed that.  I'm proposing it now.  :)
> >=20
> > We've already discussed this proposal informally within the committee
> > for some a year and a half, and there seems to be consensus that we want
> > it.  We're only being careful about the specific language.  But I think
> > I finally got it, and it will go in next week.
> >=20
> >=20
> > Have a lovely day!
> > Alex
> >=20
> > >=20
> > > Bart
> > >=20
> >=20
> > --=20
> > <https://www.alejandro-colomar.es>
>=20
>=20
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--qpxgmtmgum7gp73j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzM/0ACgkQ64mZXMKQ
wqm5Vg/9FMzxE1DzVEdsHiBQi+kE7cGOI4ma9sgDJoEjK6z5pi5vl41VIbj9mKII
2gyshPP75e70Ee00CxPc7F1OEuG0DLkf7Rz9MfydiUWxowxGnZZmvwGjgknk3uZY
TEq+UcZ4eJneqVtMT2O74AtskE0VxyxIrr0fBn/vn/3wxMd3atylcFUuZqSW1jiQ
vUAiMxz6JNIKvtIvaK6FPdMJqP60PxQ5gtIXQtvFlnRx6y8cB2Qoq/wsPdo7RBqf
kmx/lVrbl7Z+i7d3pjq7DkIMdpEYzozg3i0PrGJb3+XmXS4OnNN7GRQUHFZvGEXg
We8350HB3xTkLK3uJTkJ2OO0Yx1Rvuc1x3qIoGlBhhmJirYwjO4smRXKIABqNjEM
tZY+QdsyOgfIiAD+2HGpqyxSSznYC8nOZ8+XlhGVxwEdDeLjJzA3cBuGVQZVzwo2
TXhd/ONWz3/s8yv63CnJINvJliYYJSedAf96xADYYUo+gJx7Nk93eepRxQDWIMI8
jXvCFC4Q9bNXrS5t4lDPGzyiK35y//hBaz1r56nVjRPIiAaUnd5uKDAbY4elhUjM
0GGBVUuPq/ucJ73OfL3fY/oWl8s5aF3AyyGJQRp6PVp8zEzpBIX/6mX2b4MIz2mv
+f+RIixqGWjFtWrhHpUqAN0MEqtmid9TfhEokNAKeWhIAhcZPfM=
=i4c8
-----END PGP SIGNATURE-----

--qpxgmtmgum7gp73j--
