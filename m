Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669793;
	b=ayGFgCUZTIy74EX2fvqb7f09bp9Oq9FEayFY4APndAOW6I8WenPJDVWl7mFBDKheCZ8p
	 rDiZruPH90es5glDyNH8ZdziW4l7X+B0gVxfnTgi6TTVx8K/9ewZrHuAhuxGy3toZ/09g
	 1fE7xByTZm8lsnKYWhNk68BSXvXu19i4dgYPHzSy0YRJgCxGVMvbE5mWTku1AmpzCJQLc
	 x8Is9dE6HtvqPY31w59rhSLSJdXLLfF7eo12Y9s1sqf8U9oJBIuB/Ep0wuwS/N8JyTOCr
	 OOTpB7nST4m61dPHsGOY1bhJBSrOUH1bKqEx1ZGao1JVrM/6hXFOmOiFgLxyQAfiSlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669793;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m2whvGHzoXghVkUuBgcPx7Vpcv0Zz5rDXyGbPh2kW6k=;
	b=yCHzT2MgfsEc+XlIVY3cHxRV9x1z1AdQEsD9Gh8IejFaqNSH7JiVN4qMIo9aXyDGtXm8
	 DRGJV4zO8G5WUqfd6r7+PMXyT0SdbMm2CK0sq1KZ2jUg4lXdp9rEV5bMB+uNeEQ9fho4P
	 U4G3pJkNZBtl1b19glnRhNRq45FxmqyLndL2EESQ1GJUsCDJvcWLEbGW5f6EgQI1cPAzh
	 2gInVShCDj/4YyFauvhEw8yI9zU/Of3C37JVMK9PLeJKjzosidB+BZUyRkPV2phT79WZp
	 MDa37XaWLaDVTW16x/oDOepOp4k5v9HG0izGCkQUC7Xdq/DcZWhqOd4LAoTqafPN1IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqGSnji9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B9606A33B;
	Sat, 14 Nov 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqGSnji9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CE51F000C4;
	Sat, 14 Nov 2026 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669792;
	bh=m2whvGHzoXghVkUuBgcPx7Vpcv0Zz5rDXyGbPh2kW6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oqGSnji9q/gwmw+aNo0x90HtbxCO1JGmGcar0NZdEQ0b/H4hZ1GXwaDFJKZ8MoWiU
	 DlZruS6ZSVIZN+bJRqQkGF96sdpB+NicbYdaJjg/KkeN+UHyIqclikkJ0FoVdFNNVl
	 DKdVpF86qn9gFF0WxPSEIBt/Mue5v+ooxETopqss/qsGgl6xG2ZSV7j+lJdptAMfQb
	 t3oi5jXVK61KW8GmdcWAZy6AhOTx/zk4yPPADrXKkZMFAAjIrwKt7qafGp0tTaX/fX
	 ZwyGPJQJOSL35pXhHEJMp/t50rRPcIi44rocCZH9kB4s7j3SzF/g9Krw7dTK11iTuJ
	 8Rw5xBsbTmy0w==
Date: Sat, 14 Nov 2026 16:23:05 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
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
Subject: [PATCH v6 10/19] platform/x86: hp-bioscfg: Rename local variable
Message-ID: <ec94f69d2925d2362e8bde4ca1b1f7f3893c0315.1794667407.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="n4zfxb4iseidw3nu"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--n4zfxb4iseidw3nu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
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
Subject: [PATCH v6 10/19] platform/x86: hp-bioscfg: Rename local variable
Message-ID: <ec94f69d2925d2362e8bde4ca1b1f7f3893c0315.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

strprefix shadows a function of the same name.  Let's rename it.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drive=
rs/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
index 343b2356943e..a38d200bd0d9 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
@@ -67,7 +67,7 @@ size_t hp_calculate_security_buffer(const char *authentic=
ation)
 int hp_populate_security_buffer(u16 *authbuf, const char *authentication)
 {
 	u16 *auth =3D authbuf;
-	char *strprefix =3D NULL;
+	char *prefix =3D NULL;
 	int ret =3D 0;
=20
 	if (strstarts(authentication, BEAM_PREFIX)) {
@@ -87,13 +87,13 @@ int hp_populate_security_buffer(u16 *authbuf, const cha=
r *authentication)
 		 */
=20
 		/* append UTF_PREFIX to part and then convert it to unicode */
-		strprefix =3D kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
+		prefix =3D kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
 				      authentication);
-		if (!strprefix)
+		if (!prefix)
 			return -ENOMEM;
=20
-		auth =3D hp_ascii_to_utf16_unicode(auth, strprefix);
-		kfree(strprefix);
+		auth =3D hp_ascii_to_utf16_unicode(auth, prefix);
+		kfree(prefix);
=20
 		if (!auth) {
 			ret =3D -EINVAL;
--=20
2.55.0


--n4zfxb4iseidw3nu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fNgACgkQ64mZXMKQ
wqmDMxAAgj4zHKcm3bLuyNe1pfRcxfybr8N97GG7fqyUwy+gQHbjaFgcl0ryzaBb
bkp4Mg5FStfZMkD1K5932+7zQPYoN7XqRCPKNuHwxX8DPGWwYLhcxijb/Z1FImZF
HkX6z59DSxGpBH2TLvEtWAVMiPGOIHpn6mDONJM/KnUCxmH7zHiyJ3EdwP3JgEl2
1UBD082ppMqxW1WP5qZesyIQEcbdzc2hNXdysJ/70Wp2O+btJuiOet7GXin3CXGB
4btGdL/VbhvtFOBILvCWzqbZlF++cVn+UoHvupOjXFh0tPMrOOigHpNqc2tKiJsb
ROFM3ktzuOAU9PzZ1kBnAwk1+KCYH3enHKZ+gU8HL1XkNuH8lti7bmNlFLwWI82P
Xk+QenYAtq7gzyv2WRCuHL/4XzvSamglhN0R4FP7Rj6/O8gXUyeMhYA7Myf0JXPq
ZJ1jotKYd6eWS2WiiSK74EW/hcdn7aWaZ1prDLcOCM4yt5UcEZuieBrU65NXRRkM
IYaTyIM5fxdIB+hU6/EWBgfmZrcSt2nmYIp1QRH+NB3e0bFyEzvMmL8phQRW8cLk
7kcBKUfKCU4Pw//sjv3BdjFAHccROfTv7zHyOcR4PpN3EEl0xXTilAjURi3aP/CO
kBBNMymk0znEJYLUiSlYa59soIjhs+bP7ajB5RdFF+yrNlqMZbg=
=uINI
-----END PGP SIGNATURE-----

--n4zfxb4iseidw3nu--
