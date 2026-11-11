Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426964;
	b=kgQKFllT3GCJQQz6viKqstRSF5VJDflzbPy7ziZTKFhv3WCT9prHll+9gXCH+RJdzEy6
	 UNYWA2veWUS4fW9r0jLrp90MwJQYJVfmMxouM5gDfaursvgwy2cro7QBknbYF2ZaBGGxj
	 cnRehYn7/Jf4nFGFa5umLcP0QdECZSMokphOgDFNhVlCdieqLvdfc2cJpK0vY0nNnPUBn
	 LuJEQqucJhASjhKw9uD8bYyFNKri8C/o5Fw2upxrRzOv8AdCPOryQ28d/E75UaspFV4Pc
	 PrnPoSjq2ioqI5YXvpU9DxDqfNlOEB1kzwaQ2KY4ylws4g/Cj9Lg4aBOGcCSLMl6bsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426964;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TkGFnI6eGFZEoeF398+OdI8TclJce4vT7aGxF5WXpx0=;
	b=k7Bd8P308qRIbpcZuLQ4AJ3wEhmyVyaq/aMCZuZS72bRXIGBN/JkSANTo/OQhENf2Qpv
	 bvCj6A36eIY+Iqdmhz6xdPPjlhY45DJrcLDiaYGqHp9mj3cdGXZ4ETcAqBblMD3whjaXi
	 1TYOorEnFbM0kBjkLxUwT6Cmwl3zzihIUi2ldLogeesopgHzrEU77hLjM36tZB67jAOLe
	 4Svtdry0WGaR8Ook2slRb97K+NW5oUJ1Wjw3cQq7MDOpC/R1ZYqhotBBSYATfsuJDF4Rv
	 HQ/GqbRLpMgG4uThi4QijzzGbmHROoPZOsUb7n/Pkb1bV/x1CBsanGNuUB2cqPI7WEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9k88kvL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A6C606A330;
	Wed, 11 Nov 2026 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9k88kvL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875EA1F00A05;
	Wed, 11 Nov 2026 19:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426963;
	bh=TkGFnI6eGFZEoeF398+OdI8TclJce4vT7aGxF5WXpx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U9k88kvL2xIvrSwDbqIo2Ce3moW2wSl5NdVaE1F6PZz5a9EIg0k1ccYIwW04HSnxN
	 kQN9BKD8oYdvzqJ7yiNMQ6+C9r5kPabmIwkVgayGfGcMkPQZxIa/f9KTnXw4eLR4BE
	 Zf/J2R+OC8Yt1O4nQqXtBr3mrUXFiLngHcS9tsu3J1ank9crM4epE1qp/c6vEffv24
	 K0mEzxBRfNe9jR4s3WKCNejhYbBlBVwiPrS3uOQKhNwAupZIFwATWRkUGCA6Z9xrb/
	 ydiw0QPjjgbEHu5Y/DCbkpP5w6o09XmTG+8p2a7YUpNGKzipOFq+M+6nGUWaPN5Yxk
	 FMOlMpvT4wSmQ==
Date: Wed, 11 Nov 2026 20:55:55 +0100
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
	linux-gpio@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v4 6/6] string: Make strprefix() const-qualifier-generic
Message-ID: <69d1792e5edf91eed8cf99745cc840ad954cc3ea.1794425425.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794425425.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="7cel4zc3cpgolqdc"
Content-Disposition: inline
In-Reply-To: <cover.1794425425.git.alx@kernel.org>


--7cel4zc3cpgolqdc
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
	linux-gpio@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v4 6/6] string: Make strprefix() const-qualifier-generic
Message-ID: <69d1792e5edf91eed8cf99745cc840ad954cc3ea.1794425425.git.alx@kernel.org>
References: <cover.1794425425.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794425425.git.alx@kernel.org>

Add a macro of the same name, which returns a pointer that is
const-qualified iff the input string is const-qualified.  The return
type is a possibly-const-qualified pointer to char, even if the input
is a possibly-const-qualified pointer to void, which is why we require
the CQChar_of() macro.

The function now needs to return 'const char *', because const_cast()
can only drop const, but never add it.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joe Perches <joe@perches.com>
Cc: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 168ab1b1fc38..c37041ee089a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -590,11 +590,12 @@ void memcpy_and_pad(void *dest, size_t dest_len, cons=
t void *src, size_t count,
  * *  @s+strlen(@prefix) if @s starts with @prefix
  * *  NULL if @s does not start with @prefix
  */
-static inline char *strprefix(const char *s, const char *prefix)
+static inline const char *strprefix(const char *s, const char *prefix)
 {
 	size_t len =3D strlen(prefix);
-	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
+	return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
 }
+#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx))
=20
 /**
  * str_has_prefix - Test if a string has a given prefix
--=20
2.55.0


--7cel4zc3cpgolqdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0yEsACgkQ64mZXMKQ
wqlTdxAAqpm7IzfQCIviW7FbQIjTC4o363LwW1e8kAHyuyD4CSOEA19CrBtlchcp
3iQTRdZZaEHuv5/VtAJpEus918mEfD/MdHFASp/nDfc7t/Gf49FTk5LOd6LJHcGl
g4k2ta8YhxE7Dmrqmk80543w/te6+kC2TAlUMYpCICgFi3evJNI4ifPG714dCkPN
GlulsvK9mGh+9tDhB/n8niH/7vjCfmPa/hztZJ8EPIITXFZtmDhsEGZwzNxZ9xL7
D79UC+JpH0Qx8KAAo6tziKW5c20GPPdATDpH78EUk3sy+XBVv2/apsQP8nn2Dnl2
8ZJabcBmm+Ez4aJeZ4lwkz81mb2+77cV5CAhB6i33Ny8wasM/+a7H9Q3uMupkr3V
UHVayprTMeiY4itlL9PRWwxfWvS/iRYFw0HLmbvQ2UmKXbpXt7SmQhOBU7UzF1hX
wQwkYhpCGCroFzCim/xAxh+mtPNKhw/liddqAOUOVQebcGJhEEWVIoRtY3lKD8O0
6uc5MQnbyWdscHNLv2GFK4W7UAWMsPlTEPNsEV4b/7SVYtjKOZa+dYxPLBH4P+Pf
9GAL/8Q8h9fS7M6fipJ1Iit6LKHz07K75H8dtXGteTY33CRGgWx2asM01mlCXVGR
V/887xhPAz3L9IfVx45wWjzJLCRjiWrdvokO3IqAvcuz80SwSlM=
=eLX4
-----END PGP SIGNATURE-----

--7cel4zc3cpgolqdc--
