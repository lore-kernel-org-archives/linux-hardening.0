Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669849;
	b=p0AmDhRUvHDi8cef/uhnKyobJN/S3aYT9hKTtKBBSEdjPn3rE3nly0038vW5svVG/fBp
	 rucpTu3KdF9xamNAJMjbXpIN/iQRzxU0GLnGFMOnOeEvXWN3SkenKdrWaMbAMk/CiFLp/
	 dkb3KOVMjaE806sAfN3S7UdCFgrARw8P6IpYEC9l0AUMdEqplrqhVy2zlr7BZK/YUaqJA
	 zDFvmGI3YPPCsWS29fhJQ40W4mZhvcVcYwDeB2yF9xgqiWusI6ZOV9YgU+615v7JHElEN
	 vDCW8iGha3NzTJPdEW4yiG5bg5Ko7yGx1/X5yv5qx/b+yQReuTP6B67CpcgCtVmNHEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669849;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=T2Kcmx3WJSx/Ne5USlaUSCaBRqAq+CXbrA7aH/FsNZw=;
	b=i0Mdf19EIfArFKaNGDimUw1F3K6IcSxZEdZYq0D7+q4mexYKhYmePXD6wLZR/9E7Rrgk
	 3EYff9NrRn7Zx+uOLdSaT9OjVr8LZ4Pi8wizpy+ifxDanXnr+Hp1FpI7wol7cwth6qV13
	 EaZkM+hoboKV2OjKuWcIoMnsXqa/EW/ddCRXP9+o2hIMooiTFJ+2TuvW4CI3orvIdNcMY
	 xRGBg/ac//m5PFPCEp7Fe/QTd1LR0cM1sveJCtKpTOk1+lUSspXQXrI2GvBW/9EwIQUnF
	 +lQE49+Z9qVh2jhAAV5ArKyCc+IDHDtQRhLNOA3F34wpNqhiiECyynGmbXmg5amGgvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdNyczk9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C050606A32D;
	Sat, 14 Nov 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdNyczk9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A281F000C4;
	Sat, 14 Nov 2026 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669848;
	bh=T2Kcmx3WJSx/Ne5USlaUSCaBRqAq+CXbrA7aH/FsNZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LdNyczk9Vhx58M26hS9zuZ8OCyU1uGWu67MnAfu4Mpnu+Xn+087ag7/h+cFQbpisS
	 ctRNt8XH1Pwfwvs9UCbSkNc5zzIK9xquMkB3eiA7FqZbFzZoB+jbzxZJ8Zv/t6UkWj
	 ODnZTig7ZS5TYf81hwUoRVJgdbGrx69nVzINgKE8OdNLMxttwHxCd9uTUdjZ395wWS
	 3/h4mRFBLRvIIc18083AeurZEdDGUgAVT2r94veU4zfGmPcj5XuaeMhUpFy6zMNobr
	 rBEv/HaqgLAzm3k7iXM3GCFAoHkwvCZrMGRRnRmFLDmyd6iPJxYHFrgDFOyB0W0/CH
	 hM4NmwSxIzp8g==
Date: Sat, 14 Nov 2026 16:24:01 +0100
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
Subject: [PATCH v6 17/19] string: Make strends() a legacy alias for
 strsuffix()
Message-ID: <8aa3d317d63c7538628b798845dc2092b3f999f8.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="zlbfher2u4f7fn6l"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--zlbfher2u4f7fn6l
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
Subject: [PATCH v6 17/19] string: Make strends() a legacy alias for
 strsuffix()
Message-ID: <8aa3d317d63c7538628b798845dc2092b3f999f8.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

strsuffix() is drop-in compatible with strends() --but see caveats
below--, and provides more functionality for cases where we're
interested in the position of where the suffix is in the string.

strsuffix() returns a pointer that can be converted to bool.  This is
converted implicitly in most places, but if the target type is not bool,
then it might be problematic and require an explicit conversion with !!.
I checked that we don't need this anywhere, and also, I expect the
compiler would likely diagnose in such a case, so this should be safe.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 2f7fb2c70662..7469d4634b3e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -633,6 +633,7 @@ static inline const char *strsuffix(const char *s, cons=
t char *suffix)
 	return streq(s + off, suffix) ? s + off : NULL;
 }
 #define strsuffix(s, sfx)  const_cast(CQChar_of(s) *, strsuffix(s, sfx))
+#define strends(s, sfx)    strsuffix(s, sfx)  // legacy alias
=20
 /**
  * str_has_prefix - Test if a string has a given prefix
@@ -656,23 +657,4 @@ static __always_inline size_t str_has_prefix(const cha=
r *str, const char *prefix
 	return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
 }
=20
-/**
- * strends - Check if a string ends with another string.
- * @str: NULL-terminated string to check against @suffix
- * @suffix: NULL-terminated string defining the suffix to look for in @str
- *
- * Returns:
- * True if @str ends with @suffix. False in all other cases.
- */
-static inline bool __attribute__((nonnull(1, 2)))
-strends(const char *str, const char *suffix)
-{
-	unsigned int str_len =3D strlen(str), suffix_len =3D strlen(suffix);
-
-	if (str_len < suffix_len)
-		return false;
-
-	return !(strcmp(str + str_len - suffix_len, suffix));
-}
-
 #endif /* _LINUX_STRING_H_ */
--=20
2.55.0


--zlbfher2u4f7fn6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fREACgkQ64mZXMKQ
wqnvQw//Z7yF0JaUo1CyQfP0Fch+vd7ks0v5L8lxZUHICeXrBEV9SzwnXhxYg6G5
WC2sLIgXL0vUeBr2m77gsJ/Qf9n/UjCdqh+M3R5WxB5+WeiEy2YTzA4BQg0IihWN
sWbibPt4dm2D8fCGHxCQRv6PauBt1uTWDCx4ngW69aLiyJaGZawvoOJumyeUEMbC
R4Eownz78AV0VBnW9ABDBZg4wEwYnktM/+8ZxFwcSJvQj33itpgBgoThYMyHkHq6
/19bzgihkrRU9QRIAUqC0R3PULg8kP/W449z4ET0RSZTl3WU8jglGZgeFohdBMqB
Wd6rk6R5CY8nfXv+UxWA6qCp3umzIuKAxg9bL5yB1/GBahIFOYGb0VXwU40mrwb+
s6ybeqP7ucyhJeVBcZwnaC7l9HoE+iw35mbu4M9SyYK1AReosZRai8bHM3TFWtQD
jI+PLnZP0dNJ6zHXoAfEXLNx/eyxdgQagQtqS0C9kMxmdNI941cfWZ5TtXy08cw8
o48jPosqSenQj8fvPfaKKQ0KuJTVUfX36wMnNgDeV2WqV1vX6UbFeRaAgpUQ95sX
MI1EiPkZaErz+SdjMZLSKq7/h5zcDZGIvmTfIQmQcx+zUFagUZ7iRXstUGApE6OU
aqzSQCVwhL7aLTJNS+dntunplzgq7SA33d5t4dBcXBIAL5YgFr8=
=w55K
-----END PGP SIGNATURE-----

--zlbfher2u4f7fn6l--
