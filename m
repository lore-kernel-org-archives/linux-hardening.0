Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676130;
	b=jTnUvq0rZxU2iRQ2cs8l0CK4ZsSqd7FBcKelVDWvXFN0bJpliVc/WBdPWKzv21fUz1+6
	 D82DfpFmJELalc9OF/GTsuXXiAwacss27c7Er/cfPrtumNZ+f7Tig+8sL1E4ZJVR0lOMk
	 BKfFjd3V7fIilJY9rWcKtypCk9x6T3jgzzh8OM4yFlfVxP1Ll1w+YfceYiSs7Z6H/A6Go
	 lin/0wAQimatVu90jHkqAIzdobludBItu8oI2MrpNUNv8xwM53r3oJiXM1R+WMt0pggYJ
	 YQyKGB0vhYqQXjhKTrbYPzm4uQ1aM838lWYcbbcpj6WRGLr8475MOLs2za0bHpDRszg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676130;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BfodKtywx0Z9yeYwpkod4XUy8CUJpBCkMdDTlgsEf/Y=;
	b=ZQ3pBTHMO1TBtgN2h2Zb6mCgGaOHhnoZoYm8xZKzI8r3sHF97LLnY7R89lSmwL0+bURc
	 Czdt22S0hSZapDcAe1ARK7qfOWvt9LHBWAfwpqxsR/HGT0eV1s1f3o6vvOhV7rdf9Vsj2
	 Mvpr/D3lqTKRAw0jQHXBCzcQASHfs6yDgB+3M9hzReAs8l4QQQFsP5XnxVzmjizUvXXuN
	 +M4qciVHL55V/f8yEq4+HXUG2DZsyRgI3N6JL+tUZXqcGqs2CQFDb7pzZsoor5/g9ObQF
	 5wivQx0yH1e3xXcQ2LtXSQGYm2IwdO5i3xKYw/733/qGZJfYYnybZ44kgtx3p0xkJjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CH/Jii6G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4482606A323;
	Sat, 14 Nov 2026 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CH/Jii6G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F8A1F000C4;
	Sat, 14 Nov 2026 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794676129;
	bh=BfodKtywx0Z9yeYwpkod4XUy8CUJpBCkMdDTlgsEf/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CH/Jii6GOxKja93EiEqLupCUDr+JcZmm12fN0f6PRGR+n1EWlvK4pdoZ/yMT6Kksy
	 nv/9wCo7HnuulWAn/hdyNaQPo7c1PvWyzQ9bRO0vAHyhQJ5xXtbauf+PwGyr6OT2ad
	 07CV1JaljkS+4VN6PX1kw622V5PAx7ftVZTAkzSvPlQVQPgNicuIRNzIFiRRS6G/f8
	 TApIYwLgHmJBi4IAPhGiwfaTsTaZerADz2a1ztYamOai0xg3bBO415Jvm73WqS9zmA
	 OKtqiwwjr0wMLfnGv6yVK7zLGcaJIkYLO5gtrX1vdZ9VA7LNO/6lREbAEKWUgrlaQc
	 j2oAxT5R7G8ZA==
Date: Sat, 14 Nov 2026 18:08:41 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 10/19] platform/x86: hp-bioscfg: Rename local variable
Message-ID: <aviVUS3cyyJNHrd6@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <ec94f69d2925d2362e8bde4ca1b1f7f3893c0315.1794667407.git.alx@kernel.org>
 <7d45a8e02dc9407e6b95893d6be1591aadc24cb9.camel@perches.com>
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
	protocol="application/pgp-signature"; boundary="abnhfluguix7tdhv"
Content-Disposition: inline
In-Reply-To: <7d45a8e02dc9407e6b95893d6be1591aadc24cb9.camel@perches.com>


--abnhfluguix7tdhv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 10/19] platform/x86: hp-bioscfg: Rename local variable
Message-ID: <aviVUS3cyyJNHrd6@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <ec94f69d2925d2362e8bde4ca1b1f7f3893c0315.1794667407.git.alx@kernel.org>
 <7d45a8e02dc9407e6b95893d6be1591aadc24cb9.camel@perches.com>
MIME-Version: 1.0
In-Reply-To: <7d45a8e02dc9407e6b95893d6be1591aadc24cb9.camel@perches.com>

Hi Joe,

> Date: 2026-11-14 08:04:56-0800
> From: Joe Perches <joe@perches.com>
>
> On Sat, 2026-11-14 at 16:23 +0100, Alejandro Colomar wrote:
> > strprefix shadows a function of the same name.  Let's rename it.
> []
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/d=
rivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> []
> > @@ -87,13 +87,13 @@ int hp_populate_security_buffer(u16 *authbuf, const=
 char *authentication)
> >  		 */
> > =20
> >  		/* append UTF_PREFIX to part and then convert it to unicode */
> > -		strprefix =3D kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
> > +		prefix =3D kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
> >  				      authentication);
> > -		if (!strprefix)
> > +		if (!prefix)
> >  			return -ENOMEM;
> > =20
> > -		auth =3D hp_ascii_to_utf16_unicode(auth, strprefix);
> > -		kfree(strprefix);
> > +		auth =3D hp_ascii_to_utf16_unicode(auth, prefix);
>=20
> unassociated defect but the auth buffer isn't apparently sized
> so some write beyond buffer seems possible.

Thanks!

I don't fully understand that utf code, so I'll leave this to anyone
else who knows about it.  But I'm interested in it, so if anyone writes
a patch, please CC me.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--abnhfluguix7tdhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4lZkACgkQ64mZXMKQ
wqll2xAAlo/8OIh/wStVWgvbD2tunr8yoPiMTT+S4gmCiYL+v2IvsZLZEOvt+Uba
cDJVqfcsP5vx7xZ4Az9wI1NmA4nqoNmttyo7lwUQwE89TzoBBL2xofp9bOskC64T
oDzrHJcxmz6PhoWJijs+oETz6hGNZcr9+/PkWL4AvcvDcFygbXqV5XQhNzS9RYaI
XCCfpw7zs84g1BFblgIKFJ6QBV8loAXRMaAKn/MMsG6KbYUhexLpQGfHFMZCT6tn
mthZrsUC8xJEtvf6smTcnB7KnKH0uvv5BZKYKMB8J0DXVvUVyNFj5M7gNNQ77bXF
DpbDOdI2vml5foRhv77trTSd3zacxum/pNucr1ZOsr4XsROas4jdBTCtVu9qCEbE
YWVsYrnk6T5ved1awB8mdBcbOBEK29BFuOE1U4NylRvR3rBxcYk6rizn0oj1LD1J
Vyj8S5TkJd/ic7WndOD1k3GkGU9nMQiyTEBmfiWRDAqcZB6PDm40phjzYJdrSd9f
mV09vjgFz6SEqX9uNM9VB/sho0g6Y781mImo9KQf45jrHY1D4hdSCh8XLevTWQVL
KoatE4iiGiegXAwje4sBD6rCTV3hhpAeQpE429JvHx7em/kcBniAFq13AWr3Ubmg
om1bIje2tDd/EKuS8qKcUkJEDxwsM+8/ocUyCztQaFqtOy42XUA=
=pHXv
-----END PGP SIGNATURE-----

--abnhfluguix7tdhv--
