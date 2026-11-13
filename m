Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580356;
	b=VPFGDShUa4h56diXhjKq6gYLaJGD0r4A0a/OsLumrZpaH3SZH7r79pZE5it3oFdb3tLL
	 4abzque+czsSyHrMCuDzlJ0uKCqyA+j92DrLKoFpPQq+Arx/DAYjixFRFMz8ZiDQtgAwe
	 BS6NUuf4eaaAQPYuWrZ9iZNWCIFcxh8xgG/iFRRBWAOwcfQTbecXMivhMryXRJUaGmSgo
	 2HummtK7Iy2ikCyM/iIJEMZ9u/dvZKcfj+F2mLZMXXE61gjFxAgvrOU25nNHE8F26KvGJ
	 QWyeilOR/s6FuFHeNEUKYHHI42kZ3KfjT9RPmJ4nREzja6Ij4pHymxWJA8zGJ4/0HJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580356;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1BIQo279ufFQ+nv7mKGQRHTWFJlbN4h1fXmbpkje77E=;
	b=yALGf7YSXlu01bZ9ahyqlNREmNGANdhQ8Sy+JiQRkLbxD//1lyuJu/pLM839b+zn92TB
	 XTTx+Rh6+JsM/XwI6ckQmD3xcRII9I3KKS1L3YQniW1bAJ60oh0H6NlJghl8ZSdiAajpv
	 xSI4Qd5BfqWoPHXWMHIsJ58epZ/MN5AcC0zpeUbADQt71nKfClNBShLtVHT1IKzRw7T5K
	 j79toIzPWkpJx5g8ljkRB27fooMoEm4U18hP0CTm6Mo0C2tTJCNXevgwOhZvloPpukvlw
	 TZejDKZBP7uKK23pKgwBxdkw5wruLvb60SzaADQtBvSTTI0h75zAyBqzbdEOrUh4X/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ev2SkSwq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE216606A32E;
	Fri, 13 Nov 2026 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ev2SkSwq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ACD1F000C4;
	Fri, 13 Nov 2026 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580355;
	bh=1BIQo279ufFQ+nv7mKGQRHTWFJlbN4h1fXmbpkje77E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ev2SkSwqhOZ6E0bTjz9w+sL9egRPteyMV8MLasaOCyNylx0lXNMRMemQBzm6IC/ce
	 F9ZYyOTHLa87GU83Huvpk4e3sIl+QrtLgzeZbuJrodpKWvUc72uIOgnt0EZEZ7nf0H
	 0vEC14VeJJZIkVqGsdhQlD/Q8FXmYDn+BqIdnWcB7eg72tuVgWWGRAgWUpqUSV1zGG
	 Qj3hdHxhnTBICsGYp92vdVcBwAqH7avWRpO+mvYJtN+WNycm1j6N1wS2oi/hBRSqDY
	 4e+YmXNsE+L6AoT0SKd0CWidKBR0ssQRSwOlDKEF5i5dgGmVtHDKcDE+fYOqGo5wMb
	 cTvF0+nOGigBA==
Date: Fri, 13 Nov 2026 15:32:31 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 2/7] string: Warn if the prefix is the empty string
Message-ID: <avce5JRaIf8P6aGT@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <df3a35c469c60c2c9658d66b30e67468ba053863.1794574496.git.alx@kernel.org>
 <sashiko-outbox-212859@kernel.org>
 <avcUA0z7CuQqs6Bz@devuan>
 <avcd38TtBtRtWSMe@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="rknuryoxk7agv5hb"
Content-Disposition: inline
In-Reply-To: <avcd38TtBtRtWSMe@ashevche-desk.local>


--rknuryoxk7agv5hb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 2/7] string: Warn if the prefix is the empty string
Message-ID: <avce5JRaIf8P6aGT@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <df3a35c469c60c2c9658d66b30e67468ba053863.1794574496.git.alx@kernel.org>
 <sashiko-outbox-212859@kernel.org>
 <avcUA0z7CuQqs6Bz@devuan>
 <avcd38TtBtRtWSMe@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <avcd38TtBtRtWSMe@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-13 16:25:35+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Fri, Nov 13, 2026 at 02:48:01PM +0100, Alejandro Colomar wrote:
>=20
> ...
>=20
> > > [Severity: Low]
> > > Does moving str_has_prefix() out-of-line into lib/string.c bypass
> > > CONFIG_FORTIFY_SOURCE and prevent compile-time constant folding of
> > > strlen(prefix)?
> >=20
> > Preventing the compile-time constant folding of strlen(3) is indeed
> > a performance degradation, but that's necessary to be able to
> > WARN_ON_ONCE(), so there isn't anything we can do.
> >=20
> > > lib/string.c is built with __NO_FORTIFY and its top-of-file comment n=
otes
> > > that it is reserved for routines that have architecture-specific
> > > alternatives in <asm/string.h> or get overloaded by FORTIFY_SOURCE, w=
hile
> > > other helpers belong in lib/string_helpers.c.
> >=20
> > Do we want to move it to "lib/string_helpers.c"?  I don't know enough
> > about the organization in these files, so just let me know what I should
> > do.
>=20
> string library (generic) is for broad use, so it should really be clean f=
rom
> kernel things. string_helpers is exactly for some custom abstractions we =
use
> in kernel. Now you should answer these questions (or more than that):
> - Are there or potentially be users that needs this API earlier at the bo=
ot?
> - Is this API is detached from the rest of string library semantically?
>   I.o.w. can we group semantically coupled APIs and consider them as a bu=
ndle?
> - Due to the above, ask the first Q against semantically grouped APIs.
>=20
> My personal feeling that what you are trying to do is no go for generic s=
tring
> as is. If you confirm that these APIs are not used / needed at early stag=
es at
> boot, they can be moved completely to string_helpers.

Thanks!  I guess I'll just drop the addition of WARN_ON_ONCE().  Let's
leave the function as is, and document its problems.  It's not worth the
effort.  After all, I think it's a bad function, and should not be used
in new code.


Have a lovely day!
Alex

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--rknuryoxk7agv5hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3H3kACgkQ64mZXMKQ
wqlgvQ/9Gqld7Ifyn3BujxPTUwCIiMyV0wtEymbSvp903UjMMbfetRsaoj4NMZzm
V2pcmjF4QtAgWtqPElhyaCNxEL1cEDrvWgrv/MhaItz6QRAgAf0SjdWctkMhDgoS
xGdWcC7tbfDozmXnBWibd0B/I6LPziil94CSwD5ZRjgmPoG9+Xxdf5b328vLJJfO
yySOpcex0R64+F93i+O1pDiGYBok0kID6ymaS1bRTffmeDRLpBmM10DjmHk66+ke
NI+8BC9kQLCJ19ot8VWQMmRMHvqlJveDDJzOgdVIndTYprdjL6BX0IEfhb2jw/80
3xZx5v6ITHEmB8l59Oe+yKIGLR7GsGNxiAj4OaxVgXbvzpfDXGnRwyWFPLWXMJCZ
OTKqOl4O02PUj4ZwMyAWBsX2bxG3AzGcfOOYPBAVu6Zae/DOTD1qW+0OdfzztJPe
cxrf4gaMnLPmCCwfn5sSUwSRykeC0pjI4b4dfTUxYKCr5g4JNS34znCqZxo90GFB
8M72vSPHgTIx0NZi8PvUnZZm64Iz9N9Kega3/Y+ozeAY4/7/XjsZ/TdV2D7moAzy
9C2wi5ivTvvncg/ni72Of0Fx/NyejZhyesldRMLf4T89MHGK+cI8P+08LimphLct
nlHXXfYxBLFKWXqRNEJI2yoSNFErOZe1F+6E19ua5mf8RGAxQ2o=
=Jcqx
-----END PGP SIGNATURE-----

--rknuryoxk7agv5hb--
