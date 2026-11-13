Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580840;
	b=E9//KdLCqmg3GugNd2PH81LeQ5cUd+4Cf430OnzTIMonFDt685rnCzANzcihhj5mM5lR
	 Ley9aUT+5V9mxsBy61cqK/zUBC97fNEotHSl9RjRHwAF3SgXOb+vlzm/c6DGX95mJwG1Z
	 i+UF2i7e0zsf7LRgnuvVQMPmJyBD+9wVevzqfNaBB+fIdR1WaASiIZCn0/GACylqTAEBD
	 O5d4bZMrXhet6efnSuXv7MfpXS43TYOlN5Yec5PpCQL9LwDdZjFsU62PMJ40tHdddFQdu
	 pTRJ+7kBzEIIDDmW0RPfSgSBsZDEUh7W3upG4TmDUORHFqpJBXR59JiUdoYonqZpyVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v6J2PA8ps+Obv3xED5XfqFFelQRbMTd5jekvcT2len4=;
	b=YconwISRlchaHhbAdb7fywNIILv24lGs0TsYX8SB27QgCAsD/0GBU7VNNzbrf9GI660c
	 zN/Ni+it3+6BFJsynAvhssCPdbWf2LTkH5aLu0PgGLAsi1cxoHAKqF/i75cNskmj9SwkF
	 kaNGFevjRP0DB1UcXmNVSCTTclo9sMKC6wIFbDkqPYc8IpTYWv0SoywpjWM8+i5NKyuYd
	 GK/c1pQak50Xj0y3VPvNw66i1RQYDOYUOgARMZCZIBsY2E/aX241lNr2r/ktphro8Uqi1
	 x9jf2tZXM82mYAv7WZeYUxSn88JiyTRufgVovSME+mP557aOZqMjZ+LdamGZACV2Y2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOokOIKW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEBA606A337;
	Fri, 13 Nov 2026 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOokOIKW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9B71F000C5;
	Fri, 13 Nov 2026 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580840;
	bh=v6J2PA8ps+Obv3xED5XfqFFelQRbMTd5jekvcT2len4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UOokOIKWGgpSIDE8KdDGLFCLg9uf3qXaGEwldS6s7T8wNkf3IaVJitdyLsU1eJ4oX
	 fTsSkdVOLtdYPyPBhdcnr4lyPyqLlgJo1qhmqGVzuvjEK3uRG3nIRqEosssbIihpi0
	 IqdfJRfBm8+BASaoHX9p4NAnjNMAW3EJfXBLnyZ/9U28LmyNKp8wPXYWldk7pyAAZa
	 +WfVLHXLW8L39eYbNsQKx9u5hCDmoSID/k0aIuiLOtP9+iLNdyLNItBW2LhzPPy0g9
	 yFgg265RacmUFnRgnQEsLs9nisYTaT2e5tNaep7jK/NywMuJBBbKPZ3VDtvo560dyN
	 vSfURV9hE10JA==
Date: Fri, 13 Nov 2026 15:40:31 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/7] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avcg2NEwaV-AuuCl@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <f25bf43d7f18c99019a52b9ba9a1e46fa68174c7.1794574496.git.alx@kernel.org>
 <avcfuBAbNkBrk6uy@ashevche-desk.local>
 <avcf5V0B52MV4_PZ@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="lbjzhvni5qjced7m"
Content-Disposition: inline
In-Reply-To: <avcf5V0B52MV4_PZ@ashevche-desk.local>


--lbjzhvni5qjced7m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/7] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avcg2NEwaV-AuuCl@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <f25bf43d7f18c99019a52b9ba9a1e46fa68174c7.1794574496.git.alx@kernel.org>
 <avcfuBAbNkBrk6uy@ashevche-desk.local>
 <avcf5V0B52MV4_PZ@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <avcf5V0B52MV4_PZ@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-13 16:34:13+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Fri, Nov 13, 2026 at 04:33:37PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 13, 2026 at 02:10:29PM +0100, Alejandro Colomar wrote:
> > > As Bartosz reported, str_has_prefix() has a bug: it can't differentia=
te
> > > between an empty prefix matching an empty string from a non-matching
> > > prefix.  This is a fundamental design flaw in this API, and not
> > > something that can be fixed.
> > >=20
> > > As always, this is a consequence of choosing sizes instead of pointer=
s.
> > > Sizes are often the wrong choice.  In this specific case, pointers are
> > > more capable of differentiating these cases, as NULL is a special
> > > sentinel value that doesn't need to overload a valid value.
> > >=20
> > > Let's implement strprefix(), a function that returns a pointer
> > > right after the prefix if found, and a null pointer if not found.
> > >=20
> > > We'll slowly migrate existing code from str_has_prefix() to strprefix=
().
> > >=20
> > > Move the description from str_has_prefix(), and describe
> > > str_has_prefix() by comparing it to strprefix().
> > >=20
> > > Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
> > > Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-eac=
h-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
>=20
> > It's unreferred Link tag, spurious? Please, refer to it in the commit m=
essage
> > to understand why it's here. Use Link: $URL [1] and use [1] in the text.
>=20
> Ah, perhaps you wanted Closes tag instead?

Yeah, it was for linking to Bart's report.  BTW, is it okay to have two
consecutive patches with the same Closes tag?  I guess it is, because
they close different aspects of the same issue.  But at the same time,
the first one doesn't fully close the link.  I guess yeah, I should just
put it in both.  Thanks!


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--lbjzhvni5qjced7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3IV8ACgkQ64mZXMKQ
wqk5GRAAhv7Zt4QneszoZrqzs449xhdmOyig29DcWSpyjk0/VHKt24go5s61enXF
6r5kEYZBYSl2bRU+WqNjqOJRDgNtLGM0YPMqWm2VzXexj6Ait+KtKpYz2SEPHrKy
jQxFCRM78E/afGo9kjEsGfNwQr2XulO1A+u/U1rRyivh8QBJTeGH86Nma5AyjJC5
WYsnEMdVRg9GdiOze2dZGWXktqGW0FjiET/Q+/fodVC1aRryOCYbbLTB+juXsGMA
ij7YgoSZPWkVPGsu/C1btmurqYEIGWF7IZlxD7DtolfGDrVhdMQkhiFVL4wTpnBU
/5NdnsHcydv1nJE0P6rdS+mJjqzsHCZI6rSsD92fEk1GC5MTLMUh9FFvOHQpyHmL
GeJqEYFSd0VVc+OFV4DdYpTw4wxf2XO6xGQzn286kfrMlyhBhDphsv0V/jwGSsOm
SBjce62B124SjdZpKyz2MMJsOGNRCokvOWyCmd+ILPKLDZj+5adUTOVxOYeN6Zoe
M5lcLfNnARJ/jn+AgLqIFG3D0GcOgRJh0bu2jR3UR3GMdgUgXjU7kJQSYZdOYZ/J
7JPyg2UprOuaDm7IpGmFCJgfweMOs1Rs7TCbi71Eyyt0Dn5AJzpcax+csHs3I0g7
U3g9ge/jt2cejC2fiYBHpJ0eZm20ZpQgROJeBbcKuZtVIURDOJs=
=B8A2
-----END PGP SIGNATURE-----

--lbjzhvni5qjced7m--
