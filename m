Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396503;
	b=ZTelH6QMWJWytzNQqavo+vYAHFDY9ymH19tcOmUfLiiIoLC4SNP4TjkSm7HO+rkoehVc
	 FhPU07JTRaUydHfiqad0GfydXZIJ2bwEXpbTBQ7CdnMpFtDcSCERypYqVxGH7//AJOZBn
	 J9kJHVfkxVCw+Zvg5Kt3OeS1xVwUwIBc7JRX0Lo3jlUiVN4kVBo8SSG7beKKD236ugBzi
	 KM+niKBetmt+QSGClsK95Oj0Yw/Zwe01RNoGUbd+Zg085Pz5Tz+Zhnvu3+fanNjHrVprd
	 kBSx1NCwMKAViBb9ypC35hGZOph3DxTq9YKjJ/QNusKBrWm/W16Da4NDtjcbslmHCBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396503;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=clef96KdjZtZB+RQYxzzZuV2jPu47KF1xnUT/nBcCUg=;
	b=BfxgPTyOD9pbPaNOEKjseD2ifDodqPwJjfQQuyMoEDPbE7Pq5+fe/ADXrVySDS0+qt4W
	 HmYeW1+LTHBqRxDIiHAwrtm0CNT6n5m/951YuQc1KbDWNljdEjEgd1dAKTN2kSCxH/pxr
	 Kdbx9lrKcERkURS0u5BU6hltj3lmTPkZhJEk8+VKnJnYA/5axBaEUbUv6wn+qBLulqOPr
	 1twVYk6OuMh70sDYjE8RzVUqSzZBEJTw3mvi9APNaMdEImRLjJKmE0qf470NLSvXSYR3/
	 G7FU5pEpNXdKFqitCKHJ3UUWbaf2DSqxR48cHTgRsHG+ppfdUBDFQcIb81zU0X45bBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ayqxgo59;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6369606A321;
	Wed, 11 Nov 2026 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ayqxgo59
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393661F00A05;
	Wed, 11 Nov 2026 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794396503;
	bh=clef96KdjZtZB+RQYxzzZuV2jPu47KF1xnUT/nBcCUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ayqxgo59eQ+nGKS/KTdfCsu+dMa/H8G1aehKwxPZyzLU7hiJqpdhteuph0QlvGVar
	 KThM/cQMx+yC/8FhudvKzGGSjuTORv/dw/KZrSfd1QdzN/JBaF3dBnBgxRmnuFdfqp
	 n1FPOZ16vGTb4zwDZbm/h/rSsit0DXrRQqbnVHsyyFQx7Yrics0Ki0FMLRhV9cgXbB
	 2eQKV8/9MmvQdJDho+7xXgjGczcNXaE8iKOxuwg807er8Hc9a7Vi0PoB0KkbwZlRWj
	 L+OoRFmxDM5wjOCx6lk/7VkLFZPB7zXnl35kahUakxg14Wwuf7k0YSYXTI45UoQIPQ
	 6wRvbic8PMXAA==
Date: Wed, 11 Nov 2026 12:28:15 +0100
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
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <avRQgOTnRtfec9fQ@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
 <20261111103438.2f822202@pumpkin>
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
	protocol="application/pgp-signature"; boundary="emb45eljbrwlkh5i"
Content-Disposition: inline
In-Reply-To: <20261111103438.2f822202@pumpkin>


--emb45eljbrwlkh5i
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
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <avRQgOTnRtfec9fQ@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
 <20261111103438.2f822202@pumpkin>
MIME-Version: 1.0
In-Reply-To: <20261111103438.2f822202@pumpkin>

Hi David,

> Date: 2026-11-11 10:34:38+0000
> From: David Laight <david.laight.linux@gmail.com>
>
[...]
> > -static inline char *strprefix(const char *s, const char *prefix)
> > +#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx=
))
>=20
> Isn't in enough to do:
> #define strprefix(s, pfx) ((typeof(s))strprefix(s, pfx))
>=20
> which correctly preserves all qualifiers.

This would return a const void* if you pass a const void*.  In general,
we shouldn't be passing a void* to a string function, but C allows this.
With CQChar_of(), you coerce a 'const void *' into a 'const char *'.

See also: <https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3998.pdf#subse=
ction.0.7.28.5>


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--emb45eljbrwlkh5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0UU4ACgkQ64mZXMKQ
wqntIA/8CnvRBh0GWiV0pEkB8CsI4Ei5vpzo05YozhZPx/C1LqQ1TJF36UF6GtZ1
+MjZVOShNf6prPOICad/7qSz/Uay+Q/H14G5O4ErzKZbKCyqC4osWoLsTIeskIFO
ptOZSr/EQF3GM+fKSrowiVbw+FkPOT6CetmSbrvUNOhXo0Sd62SOyM3QorRW/QfA
EbInkrMvvBUiivyqITSgmCFAKynJvncUQeoobTjAnxe14KnWKwXAYMiES5UEnxlt
egShlBDaCgDbKYgtawdjj5iMZM25YQuYHFzj9N163MJwZSusKK81kzBHxkpdtIHj
TZq0SKiUUar7nC2hI3YQNIT6yVMhNdnvCE4dkfgDuNqDaPuq2geHWuNNLd4LGFh6
u4g10Ncbqm9g1xdyESjXUYLuBfebPrHsQ4F6T3cx09GE+6GzxGET3466rQs0qTlA
Hm26LNi/ZT8Y4Up/V8EWgWweE0yji+i1Kcm8Z3y1U6KfYFIsnT5lms9lLz6h04IQ
cf5UH3vSVZgzbvZg2IcAwevjodfrdHDMFUYLO0Gz572B2ztMTpC1MJW6QiXogLbz
JIc8+VKrfb4HxP3Gt00HTz85/Ug502kAFe3NmpW62Uxsn6bmQi/up6X2IjgoIWOQ
kbhH92N6QFMGkKgBS+LhFS7TXmhDzDNVh5yJbbCb3yL8Dg1VpMA=
=TVMp
-----END PGP SIGNATURE-----

--emb45eljbrwlkh5i--
