Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353257;
	b=BtyObp4fAXxDDpQ+AQ1QQJHVxAONEWb72Y08nS28Cv1upiFvjIvlWXxopbF4Pl+Lgr8/
	 AqcwA1nWsqrR33kBxPiVc6MlmhqXdH7PALOiyILVDLyymoKi500fkk7GselrCB/wRcGQ/
	 r7rf2h4tZczeLyZQl4hZ+ErIyY8241MW07YFXzLYjk5+uhcGczzjNeAjHDVUZJnQ9Eq3n
	 YteeKX1fsuwQrmVJrbpgpv4f6dUmuYBNXNSlWqhz2eCrRSo3MzPr0wct0VcZT8XLcpCU8
	 5xz26+ToX8wMV2B8fTItepj3abENlzfX3NbBkrVcreH1o2d+GtWA4xroOH/s9BTMsWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353257;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9SU31qE105wrvP2RpFtRMcpfeuKBum+yU6ILTSHS1GM=;
	b=n02YznYzH4FldH63UE7+o/g+PNp7h0M4VbQifJu24VIBf1ozWZ40peJep8oS3Wv2I8LP
	 wX6U0unwr2KF+gCOcqVsJLjjtgd/TQ8nBZXMMDenfxuIGxGMEoMKY+AIeFXJ9qY87A+wf
	 mO/FefoISvkgCq9xiwG7Moj6/bp3QziVMk7d9woNVR9C6ULv0fpj9fcypHaYrwTEd5oV7
	 iH/FMKmlgaUj7tlcBNbpvSKL7vTTSoxXha7VhM+EW8umGcUXoQFUHLfR1Ofm1XG8jVM9/
	 WtoBpLX+hfsrTPqlFY9npmqwsqBGZgsUzmuFO4C/sIKByDqusS5K6laQtKJ46OZ/ncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJ19FyuM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6135A606A31C;
	Tue, 10 Nov 2026 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJ19FyuM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160641F0093C;
	Tue, 10 Nov 2026 23:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353257;
	bh=9SU31qE105wrvP2RpFtRMcpfeuKBum+yU6ILTSHS1GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KJ19FyuMQ16mdsKO22OSo/lQFdDl2kxijdpfs/PF1yA76fI+By9ox3drrd/O0XSvA
	 v8NjcftwFfKTxaSM5Xnh5Cywb5T2elzFBm9YYwZzhfuwUmxX+ObbaEYuBbsF6XzJWb
	 +lT05RUof+xJFIWGEur+Dgt+EoY1Pmn2X1idZFZAsVNpDr9SlGuwDi9YyMwwNP8QC1
	 YBk2jHRBSo3r5YVW3aFyBqXuTlAdATK8Az+lPxbfvj8MxuK0xFJTrbK/ihEKC3zpIw
	 KGlCJ/lwbgrMAuyzQV/knVHSvNk/0aSmVJQ99Rg3sktRktx8jKxiR8HoXGFCLVA3cX
	 ijdLNfc56ltkg==
Date: Wed, 11 Nov 2026 00:27:28 +0100
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <avOn57pfHntiwcaD@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
 <64aa89daf23821f95780813fe96882ff61688578.camel@perches.com>
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
	protocol="application/pgp-signature"; boundary="b2kxsrve4gpqpi5u"
Content-Disposition: inline
In-Reply-To: <64aa89daf23821f95780813fe96882ff61688578.camel@perches.com>


--b2kxsrve4gpqpi5u
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <avOn57pfHntiwcaD@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
 <64aa89daf23821f95780813fe96882ff61688578.camel@perches.com>
MIME-Version: 1.0
In-Reply-To: <64aa89daf23821f95780813fe96882ff61688578.camel@perches.com>

Hi Joe,

> Date: 2026-11-10 08:32:41-0800
> From: Joe Perches <joe@perches.com>
>
> On Tue, 2026-11-10 at 16:33 +0100, Alejandro Colomar wrote:
>=20
> no commit description on proposed patch

There isn't much to say, but I'll add something (the explanation of why
the parentheses are needed around the function name, for example).

> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >  include/linux/string.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 9e59f9697c9e..55ca4cb5122c 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -590,7 +590,9 @@ void memcpy_and_pad(void *dest, size_t dest_len, co=
nst void *src, size_t count,
> >   * *  @s+strlen(@prefix) if @s starts with @prefix
> >   * *  NULL if @s does not start with @prefix
> >   */
> > -static inline char *strprefix(const char *s, const char *prefix)
> > +#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx=
))
> > +
> > +static inline char *(strprefix)(const char *s, const char *prefix)
>=20
> Why introduce a new coding style?

It's not style; the parentheses are technically needed to avoid macro
expansion, since the macro has the same name as the function.

Alternatively, I could rename the function to __strprefix().


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--b2kxsrve4gpqpi5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzqFoACgkQ64mZXMKQ
wqnkyw//SMcrvLK94m7pGptAYwrkzsAjnS/ms1rp2DXVYYygDz590sAwqXuMmExR
SIEeUlm5Tj25X3zVAAi1b1P9GPG96sKMz1xVWYrbr2rp5kTW6Ugzlh2lozAfCpn2
KKR6o+yz5vrU0dor0jy6/m0FdiIuWUiDcAquAoNIuXP7xXJifq/YQiaXrqV7wGQw
qPA7rP8WcEXGtStTMGyZMscwwkbEAkUOjj62u4LKIXEdBIT531d+tVgGo8wZDXYx
yNQshQTqYa10OZGy3Yox8CukE6h70T9PSUSGp/hdGnriyUY4OlsgnSvbESvPbHM7
Hogdw3SS+hEV2mPxVsiKhYdomgUe2OlMNFaXwocFYzG14kGSVrKHHSjgAOhiXuBT
8Y/DdHRNaUwvk4n4M+JkjWsqBlBlEtOkwN/EiXoaXxjP2wfkJgK/XnkcxMERclrY
gDUsM/wiP73wMno2RMb9kicpHFd17RjWMAvH1/57QW4Oypa3y/fCTCEIXPn+Zt2i
GELd/ylruhm6vPAIN9bPC3vtBbrWs/PVUqK1ezgf6khXdJq+DdbFkFG8t/wesnm6
utI5wPKRQ1moDEwIfqTBBCialEyod8Nh3a+hCUz5B4yg8EzbZxGuAG6ctjIEI8Mr
99esL/VEmx5QoXEHdE1RhoejHLhmlfgk+4FKZHTXSbC0+Ty3o68=
=AAVC
-----END PGP SIGNATURE-----

--b2kxsrve4gpqpi5u--
