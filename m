Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827088;
	b=ZMnyZbG3jAn0FywNjAHCkfUj72Yd9UxcDEfH5qRsHtpOiOGiwNCpC+tC7MKb2Z7wtGYX
	 UaIAPAV/6aFMlfyXajbLt64vdaBzuNuvdpJHtEiUk/MVySCm+Fdm8LWIqBCGNAo2/lNfL
	 zVZHtbrLhlbQiFY7KTFc1ovjpHO3hepc1oRUIhtRyHNOWFvM516fQ5Hd2K7eM/UhJ+v1V
	 WC+D+L5rQkF8GefjvGBKYFx/b4kyBbQ4eN7oQfqU2ej1gV9CHBF526/c2GkMImLjEskJ0
	 GFf0s1CkaFTFm1Ke3VLtqK09yRGT/bSkDbAZiSNvca1S2Yr7KrhpqKxHialyOXxmANQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827088;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ojv1C8PqgE0O+EonqeuruT11+CSXtErx4XDlHdngvG4=;
	b=IP8HLVlJOSli/9l0va+75bsVs3ouN0+t5XYKRUY0tIt6jGbbfIRNjkQYgWvHezj4F/JD
	 gELX7thJALurzDxaZOmG4aobpNEy7Bg3WtU1wBiAQ4WqPvRN+L2kRTjT9s478MB9f4Ufl
	 iEFYmLz2e79742X2XLJHkzpeQJEWffqjRUeIXRTYsJfK4EVnqZe9FS5frARw5zsxs67uy
	 O00BnxwLhYiuqi65agb/YDALK2G2BKyKfucI7kVD4k6p1fKJ+ZE0IOP7dNwLubweSwxYc
	 Z66Q0rsWom/+0HeOU+FKyIUibKOqEedQxrnD+LHNWfUO7P2FGGUyLmdr7r0Ig4WZ+TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUi+PNRe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618B606A8AA;
	Mon, 16 Nov 2026 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUi+PNRe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B191F0092C;
	Mon, 16 Nov 2026 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827087;
	bh=ojv1C8PqgE0O+EonqeuruT11+CSXtErx4XDlHdngvG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iUi+PNReGUUMppHJlzotgnYnDO2xlFPsLSCBn+G2VpzKMzbBFdWgvL29HYba4B6lR
	 cpM35Fenr8zaI2TkOgj2xsXpXAZcNwEZJn4ZPkqRZZvjgIAQTZmISKcyMdgMPNWWOj
	 WruDGnykd5E+rGabp5iU4A+nm5R+j/BIu5Y7+MXWwWyZg4OUylMz7/wnuT7cLndYr2
	 6BON7qZ6ntfomn/0oaUFM9d2+Lz5QJMaXq3KbJSrNz7qBWFM4RSh1bW7EpuN54pofg
	 modYf0DovYhNvdsGb5dTtE4J5j1pyqw4iOQDbMRagFTSR5FcvYssuwD8DoDx6BZnBY
	 9rYhKkDBLqUGA==
Date: Mon, 16 Nov 2026 12:04:38 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org, 
	Ralf Baechle <ralf@linux-mips.org>, Joe Perches <joe@perches.com>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: Off-by-one in arch/mips/bcm47xx/time.c (was: [PATCH v6 02/19]
 string: Add strprefix())
Message-ID: <avrjCJ27hY824tOb@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
 <avi54hgKgovNHfKy@devuan>
 <avriaVSTl4jL0OEo@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="y2ytdsd4hvmvmw6q"
Content-Disposition: inline
In-Reply-To: <avriaVSTl4jL0OEo@ashevche-desk.local>


--y2ytdsd4hvmvmw6q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org, 
	Ralf Baechle <ralf@linux-mips.org>, Joe Perches <joe@perches.com>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: Off-by-one in arch/mips/bcm47xx/time.c (was: [PATCH v6 02/19]
 string: Add strprefix())
Message-ID: <avrjCJ27hY824tOb@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
 <avi54hgKgovNHfKy@devuan>
 <avriaVSTl4jL0OEo@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <avriaVSTl4jL0OEo@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-16 13:00:57+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Sat, Nov 14, 2026 at 08:49:21PM +0100, Alejandro Colomar wrote:
>=20
> [...]
>=20
> > > And these are all candidates for converted uses to
> > > whatever is the function name or steq:
> > >=20
> > > $ git grep -P '[^w]strncmp\s*\(\s*[\w\.\-\>\s]*,\s*\"\w*"\s*,\s*\d+\s=
*\)' -- '*.[ch]' | wc -l
> > > 946
> >=20
> > Looking at those, I've seen a bug in BCM47XX, introduced in 2224de9d152b
> > (2013-10-29; "MIPS: BCM47XX: Fix clock detection for BCM5354 with 200MHz
> >  clock").
> >=20
> > Look at this line of code:
> >=20
> > 	$ grep strncmp arch/mips/bcm47xx/time.c
> > 			if (len >=3D 0 && !strncmp(buf, "200", 4))
> >=20
> > That strncmp(3) call is wrong, as it's really behaving as strcmp(3),
> > since the 4 is off-by-one.  I'd like to know what was the intention.
> > Was it meant to be !strncmp(buf, "200", 3)?  Or was it meant to be just
> > !strcmp(buf, "200")?
>=20
> When in doubts, preserve current behaviour over refactoring.

Thanks!  Agree.  I've done that in the separate streq(3) patch set.
<https://lore.kernel.org/linux-hardening/cover.1794767906.git.alx@kernel.or=
g/T/>.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--y2ytdsd4hvmvmw6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr640YACgkQ64mZXMKQ
wqkzAQ//S8rlu4W2qXz6P0gQz3J7TURv9r9A3EdbifKFmoV3+LJ86ajr425VDn+j
mrY8uZSeKDSCOXH/RWaOtO2+xB1LA0bohcmAtAZ6Qr5qD/LeeOrOPgqB9MVhev2p
5RBQI4H/XKGbNYZwwNZEmHwy2a8cv/zPaC69NuR7pKdlmTR7Q3RUObwemZ2xgXGv
jFSedxxeJXL7Muy9m0xl7KDbNzu3SGScDsdBPvP2VkOMVLjYDZBRjzNUi4G0U4TU
umtI2dtYzB5KC5ZGaLqHEq01nEZGWn//QElojp2biq0RQ4tLFtMXsiMUtkgxIdjl
Fuc9PZlj4gzMy3VHvOJ+88tVCLGIRTqPuDlh0KwbOd2n8TFFcP+3/dLOCXMYZ6rf
PpSkANM5GVeX+67cLeXR1DWWYabxQscI01R/r203S8w+O6hJAyGKEMcpxlaqps3M
7EvhUEEP6j5tT69K+vEemJhfWgXEfn2QGmgb0FCgLGGLyoE+CwM7b2NkJ/zv2ekR
of6eE7zCRrEQvEd4/ySFacfyLaZbe3Mv/lMa64sGiYZ+EHKlLxGSxojhYSxDFWoJ
I4xsD2rJ1G2tJHMrYzPJDdtXJTYp4Xcfa3LIMArje/hzKuizs9Dd6TGDpnl9w6uk
NnyauIcujGFSV9KMJEjCfbDV7d5liSsurA2hElx5FVU5Vz1+BSU=
=UCCe
-----END PGP SIGNATURE-----

--y2ytdsd4hvmvmw6q--
