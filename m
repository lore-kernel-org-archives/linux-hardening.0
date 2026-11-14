Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669784;
	b=SElkobkko8lcoaVt9tG07B+nr3QSHIL9+vY4gdgVCL+rUTbmXi7XobIKGtaWegukLyJN
	 prEFe5mbIfnys4nnunUM2aWFxgG6SwaOO80yBNaQC24pc2FqFoeboXD98aL+b8/NieaRv
	 TXhss/lQqUfM8UJYFtRtFFiwJMB4VgYS7aJPUKFem5Yi/5MfZYfKZB1DRYsmO6HXenEIo
	 anti7AUs0jjca2PHPsEap+eylY+dqzo7Fb6T3qJUeHfbLhnnwNTOkYNccIy/VzHnpt9Ve
	 6Gm7vdKejg0Gr/tS6X08Q8PdgrvhkhdpkwYKqa6CdA/nwWks042fYnkPsqONcdICxzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669784;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PVADxcDLKodyfeKS5YwQx/2Ua8vH+dOhYFmnI3gULes=;
	b=ho7CqVKpr4W3mdX0W/r4XHj8KzF5UD+ZoaF8I4SOWBLpJqEQcc9jGZnYvb11wqiPL0ql
	 nD68hfxGKGNT0RTzGjmaczjAXvg2byTFb9RewyoTTycnyvtVsVOiN10NLYpHRkxSI7GIV
	 B4KXTR0dvJLZCwV/MuT9ogxf7SCfR527uMB3XN+AhAFSRYjRnqPegzfbweOf6QrigjHM/
	 3etORShtcaiWchd3OxtP1/qZTYoA38wLMVwrom/1tG0X2z71nxn676BgeJGDkQSpAmqpE
	 kkxbBfjcf+RyqpgSwFIsxKIO1WKHuxHO/wIDmBNGEnxzhU4zAOBorXF4rfr3xvj8qQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gc93nEfS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9A606A327;
	Sat, 14 Nov 2026 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gc93nEfS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4BB1F000C4;
	Sat, 14 Nov 2026 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669784;
	bh=PVADxcDLKodyfeKS5YwQx/2Ua8vH+dOhYFmnI3gULes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gc93nEfSllMqDLMaGst3iHdfYH/VwOWHs3qJaEa7Tl+gkPy+Wsx3pMat0h7tT7+p2
	 hrdfHom7qJlfliYKYBscdLAANYGWKOqkF2DjOwKxnkRL5VWclAU02xi6YAW8rTynuy
	 wq8DBniE0CPtjOGrBgiAMA2BYH1KlDCnUumPVah8qVOZ5Hi3mipQhTWhkuwOm3WX8O
	 3zABEuQljyqyeddS3OHT93RNsyk8Sws0NB6lTOP3uKMd4I4FAzi7NlvdWCM+lExnHZ
	 0k+WqdB2CLqdpCXGOM1DQstd4nW7LZP3MHo55ry0QsnmTimSqeS/5Fy/HV24vMMSvP
	 t70piODDkJo5Q==
Date: Sat, 14 Nov 2026 16:22:57 +0100
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
Subject: [PATCH v6 09/19] string: Make strstarts() a legacy alias for
 strprefix()
Message-ID: <212e7fc2cb99b631c493f59b8b38e1fd3db81231.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="cqnzwkrcujwaocuz"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--cqnzwkrcujwaocuz
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
Subject: [PATCH v6 09/19] string: Make strstarts() a legacy alias for
 strprefix()
Message-ID: <212e7fc2cb99b631c493f59b8b38e1fd3db81231.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

strprefix() is drop-in compatible with strstarts() --but see caveats
below--, and provides more functionality for cases where we're
interested in the position where the prefix ends in the string.

strprefix() returns a pointer that can be converted to bool.  This is
converted implicitly in most places, but if the target type is not bool,
then it might be problematic and require an explicit conversion with !!.

I checked that we don't need this anywhere, and also, I expect the
compiler would likely diagnose in such a case, so this should be safe.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 013c6169def0..0a466360dbb3 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -609,6 +609,7 @@ static inline const char *strprefix(const char *s, cons=
t char *prefix)
 	return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
 }
 #define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx))
+#define strstarts(s, pfx)  strprefix(s, pfx)  // legacy alias
=20
 /**
  * str_has_prefix - Test if a string has a given prefix
@@ -632,19 +633,6 @@ static __always_inline size_t str_has_prefix(const cha=
r *str, const char *prefix
 	return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
 }
=20
-/**
- * strstarts - does @str start with @prefix?
- * @str: string to examine
- * @prefix: prefix to look for.
- *
- * Returns:
- * True if @str begins with @prefix. False in all other cases.
- */
-static inline bool strstarts(const char *str, const char *prefix)
-{
-	return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
-}
-
 /**
  * strends - Check if a string ends with another string.
  * @str: NULL-terminated string to check against @suffix
--=20
2.55.0


--cqnzwkrcujwaocuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fNAACgkQ64mZXMKQ
wqlbvA/+LSuI/e0Pvyr4MEAM5KIUa+YM7fNDzdv9UKjwz7hA2SzHBzMfda44/uKB
wd+yHcxP/s4gxBhGY215X40kRbYY8GJYKMqZsviNBorElmxMAoJPSudTts7T4TV/
93jlnO/D96cyfK6Gq2i/WtzZH/jWZiwcCqPegmXApi5yXsTJkpEGvtN4gu+dFjet
YtI7qTYBa7CEbatz3TuoPJLmP3UEpHFB4lDttJbWXkXHKeg+nnel2jbEnyho6Zre
40KcfJ13JnwlpdyfLk2zCyjjh67b6paqmQq2hVrXbQR8cr7+F3hx8WEyB/BzXb/S
i1ru3C2uP4FDb+geyUaIZ5gVh2Hz/v2P4B8g7HuXTzM1iQIdn0vhIzAgAIPuOcRg
u07ahtkeUzkY0GHQ+TLmV7aDo2lQoRL2z+TrCJ0AhKwKQTJ9YJ981xm9XioL/anK
eayo3TD23w2vy7Ma1jBAjc+khdJO0yhfxjtzVVBJUaMFsLGj0tDpAnQCb3fM71AX
n0/sPP1lXbSqSCTRb12JiLG6UXWWVQm/ZRj47OHysy9sSy3Kl8+rtaN7ll/2HsuK
9e3yD4aQAoyi1wso0nTUWhoxQAAD0f1UZBwxH8Kr1cYGiG5Cwl5kWKKyDw29OXk9
2XL4y1Bq9trHsIHBqZPkEJLFR34IKCLKYRew9cFBPsAxhw4tdP4=
=pwB9
-----END PGP SIGNATURE-----

--cqnzwkrcujwaocuz--
