Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575445;
	b=xN4YhRLpgn1cdw4ABYytyGaEqFLKJbtNVFB+F4TXBO4Tq3cVtMWZ/8VO0dKCu79RDbkW
	 qOTA48MUR9tSErZpZxXrVGF9QfJR9rraeaNxQosmdREgg1WnmryBe7AOQ6evTMpUQHjqk
	 CT3cjEvddKHlrmPWdvDdp5XYtPzmG5z79YIpPBk4lw7Dk++WyhNU2TaawaYPrAJXTuvxv
	 CD3RXZO/yWPI5ePmSkjNe1t5o4j8wLQNQErNoxo/kp09R8KW1BLendaTswmBbeDysuKGV
	 iBtnZsj7eV1sE3xyeivvDkWDN4gp2rPgD+T9OCmrimky0RaPppnOc+DmYssV2s3yXrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575445;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VbE7YM6R+ysxJeY2IQyibEXN5zPh6STPoB84ih3kFLA=;
	b=ZgAUNxRbb6BEkD2zCxq81CCZdSlGkMhHSSs7OeSkYMmg+lwB/YynuKtl+jCNjJj+0e4w
	 bKVEFqfic0AbYcuJrZ4ZPwIvuT9rs6sf8z4uUhWXU6MJAi0PJoGr4b2hT2rARr8OnkW5k
	 OqMrxHUNxVsDnPH7lCxgcRy04qsYdQR8E5036V/zRI0FNal6HEbmjsIpHtAi19WupnbFi
	 +uUx/B8FtDcqbBn5TZHjaLbxGO/anM1cbs95/xTMOvv8yvznJISngXIIaweGDI2gXSQE0
	 gr1VQAP73jZ2GK0HnKwzeUsvMXmM+oqegs9MEghGPsshPIuM5vGHQAiOUgc41X5Pkjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jd2iBvKS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F665606A89D;
	Fri, 13 Nov 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jd2iBvKS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23911F000C4;
	Fri, 13 Nov 2026 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575444;
	bh=VbE7YM6R+ysxJeY2IQyibEXN5zPh6STPoB84ih3kFLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jd2iBvKS2440c0XuDTJYDrWgGsOi5XGapQ0xDbtMv9MXr0JUs+bFRKwX+kakRgpAE
	 Ei1loWxcXSvzmCOT1l+XjirMRPGjvwd9+eIR7Fksvmgc9ptmqp+s/lYkWeWNOHqajt
	 QCRSNywVY91ANyYzCcIDiTaSHoOKyisPkM92cW2aK33nH11B4IwFEtEJZkwMWbT99r
	 fFWf63cikKmZCkWcLuOBFZOIoIkMNAPy/ONqr3klN8/7VT6hFK+1qUI+MInzHifltl
	 Wk/1haVCuFqlSjnby+7/yhz65qOysqjpIxW+0HjVCNHrtVPnjle+pm4iIxaNeaFgad
	 b4hG95l6BV8aw==
Date: Fri, 13 Nov 2026 14:10:37 +0100
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v5 2/7] string: Warn if the prefix is the empty string
Message-ID: <df3a35c469c60c2c9658d66b30e67468ba053863.1794574496.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794574496.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="orzpv65wwknlzngr"
Content-Disposition: inline
In-Reply-To: <cover.1794574496.git.alx@kernel.org>


--orzpv65wwknlzngr
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v5 2/7] string: Warn if the prefix is the empty string
Message-ID: <df3a35c469c60c2c9658d66b30e67468ba053863.1794574496.git.alx@kernel.org>
References: <cover.1794574496.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794574496.git.alx@kernel.org>

This corner case is mishandled by this function.
Warn if it happens.  Also, document that if such corner case
is needed, strprefix() is preferable.

We need to move str_has_prefix() to "lib/string.h" to be able to use
WARN_ON_ONCE().

Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop=
-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 19 +------------------
 lib/string.c           | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 04e8a8c0f05a..dcda1b7801bb 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -194,6 +194,7 @@ extern char * strstr(const char *, const char *);
 #ifndef __HAVE_ARCH_STRNSTR
 extern char * strnstr(const char *, const char *, size_t);
 #endif
+extern size_t str_has_prefix(const char *str, const char *prefix);
 #ifndef __HAVE_ARCH_STRLEN
 extern __kernel_size_t strlen(const char *);
 #endif
@@ -566,24 +567,6 @@ static inline char *strprefix(const char *s, const cha=
r *prefix)
 	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
 }
=20
-/**
- * str_has_prefix - Test if a string has a given prefix
- * @str: The string to test
- * @prefix: The string to see if @str starts with
- *
- * This is similar to strprefix(), but returns an offset instead of
- * a pointer.
- *
- * Returns:
- * * strlen(@prefix) if @str starts with @prefix
- * * 0 if @str does not start with @prefix
- */
-static __always_inline size_t str_has_prefix(const char *str, const char *=
prefix)
-{
-	size_t len =3D strlen(prefix);
-	return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
-}
-
 /**
  * strstarts - does @str start with @prefix?
  * @str: string to examine
diff --git a/lib/string.c b/lib/string.c
index a3778d5aab4a..61a1e79c1b87 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -774,6 +774,30 @@ char *strnstr(const char *s1, const char *s2, size_t l=
en)
 EXPORT_SYMBOL(strnstr);
 #endif
=20
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * This is similar to strprefix(), but returns an offset instead of
+ * a pointer.
+ *
+ * Unlike for strprefix(), if the prefix is an empty string, the
+ * behavior is undefined.  If you need to support arbitrary prefixes,
+ * use strprefix().
+ *
+ * Returns:
+ * * strlen(@prefix) if @str starts with @prefix
+ * * 0 if @str does not start with @prefix
+ */
+size_t str_has_prefix(const char *str, const char *prefix)
+{
+	size_t len =3D strlen(prefix);
+	WARN_ON_ONCE(len =3D=3D 0);
+	return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
+}
+EXPORT_SYMBOL(str_has_prefix);
+
 #ifndef __HAVE_ARCH_MEMCHR
 /**
  * memchr - Find a character in an area of memory.
--=20
2.55.0


--orzpv65wwknlzngr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3DEwACgkQ64mZXMKQ
wqnUrA//R5lQ3MsyqQbsXeCkngjYjP+/REuW7xc2YIsFq6pNaejtxYQUlNa0tvV7
/DgxBnzFOSO+oVw8CFdxm7RtOSoKhxzrva/EH/L5G4pfzWOd1DkPFFUaPwJHi4Ew
uHxQEq5GdzyCH4Fx4Qao5dof6VJ4cnFAHg20+OHPaq7TSdB16Kt8JmJLl3PCq+y9
OxBUw6+g0OIsR+vt+BPCxJrAoKVsHNkwTNdFmBTZQOK/gQ1ztt2+CLSZfyMkpwrC
SosouVxdDJosIgPpqHn9/YInJ4VlDLMwguAq9qbIFDYz3dS30cflcr9NpG4dzwPL
z3HL80tDGg1HPgl4Fjl0/cqXxpRPNWz1bBhdutgM7UBXkFA2fSW9ASDgfMFFC73E
YbkXa7gqCMlUWvDUXeq1wY7htwOgrREgJp4p+/kFAersBBAi0Mi1pxGE5AqUjn7H
CxSzGsIbvE3QYFF8XI6zF6PNkeAuBgtH8+jvyyNGtg7kkxXJ8olezF5ENymD2xw5
thHrvnBcb6bjidM+r22WCDDR8BTD6/ilCs80f41yRDP4UFXWwfc0tEA7RzL/HSF/
j/d/zeX3hOMR9gwY2zEUULS8pXwxXGEvMOcIY+9Qm6qX4RhDWkdzQ/dJEa8T8s/a
rkId0kuGQ2NX974mJ1vd361+qJlyB2NNGFojhIVtCT/o/OnTCMc=
=iIzZ
-----END PGP SIGNATURE-----

--orzpv65wwknlzngr--
