Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324836;
	b=094+BvUreguZPlQ+LLxBuEQJ6CwqiFKrboFwi6J+IE/j7VvUaRuZYXpMKrPuHr90W6Vz
	 59u0hvL6NrEMoKA4hpZ+q63p1q9Ve3ZLVvRGA4BmAc/irl7LeLzZJyQsHTLJtYpS0vicV
	 8nB9JGtJQQR0pcmVOu+Q9AMX9rE0XD3nCZGxCfOfvUpTC53kp+RJWJMJIITpxJZS/rtvk
	 J8u/5rhBd/6gIJ+RmGSq7APaX6zqhCavejVY+RnzOikyx+gayO2yW7LCWWUBp5pdz3tJB
	 l2raFqliLELV5L7Ks9A93CNCsLjQANhlOzbOpRbzJ6Gxu+DdqyB1BEvLmeqIwKE+TMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324836;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3owOOx7owO0YzW+AS/1sjv03XsYwvN9g+0EiAc1SJKM=;
	b=HanrY5QL4tDwstvoqiPbUZ4FI8r35QDnhuzhapliZvEtMqUulGnoDCAtlJmZDJpx9jRR
	 op34wch11Omq4UYqNImklCJi5nKZkMFR7FzJvOpkic46RHIyOuB7OHSPw8HP/tWRtQOBy
	 Dhwg1lpDLXLBy4EGhggTvp0a4zPfelmtvKXAHBa4BKBcaowYfjrTjqtVxn3sf2OaiRTuu
	 KpzacugTBva6p2nUcXbNcEQ0jmWKeU2rTgf0xb6xPK8g5M9vFC0bwr+vQX4iETEk6MeZf
	 9qhbni5TtwtjAmTY0VvwMtLZUlARWHoLPHSHehM4wHB750hDerYaS5fqzCxOMMJQqcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4oM7nrx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3F606A33E;
	Tue, 10 Nov 2026 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4oM7nrx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32FF1F0089F;
	Tue, 10 Nov 2026 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324835;
	bh=3owOOx7owO0YzW+AS/1sjv03XsYwvN9g+0EiAc1SJKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q4oM7nrxcrrlczuZqvPnLiHAqazfrBHUvuSz2o3p9VOjHGMtSzK1hC968kqIHgCYJ
	 1jeTc8Ynh96dbrYr9Uft7K0o/zjP39HYpfY2VvBvuZeINr2xj4XoURY7i/ZktdRnVp
	 fQ3Btd+ZvmWr+tXFA1VKPVlLFbQ3EplnxIzXz8Fal03O8ylNDe5VOL7SQlrYLZ9OE+
	 Opn8BCzmK8lAUdLvGZOcKdGiV5EpBLnd+5g9kNeehVj/LyW5NYIvDF/gxqhXBjScO7
	 Y97rdbXf6wgvhlH05tBqaldtqNp79yuVlBKQPenDI9wDkMqyGnnv6vmyM9EOgCgd8X
	 2LdGQIkClXx4g==
Date: Tue, 10 Nov 2026 16:33:48 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alejandro Colomar <alx@kernel.org>, Andreas Schwab <schwab@linux-m68k.org>, 
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
Subject: [PATCH v3 4/5] string: Add [C]QChar_of() and QVoid_of()
Message-ID: <415453a31ebf1aed3b41da1a28913f5cbe58f175.1794323750.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794323750.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="edzk26a3huisnjhz"
Content-Disposition: inline
In-Reply-To: <cover.1794323750.git.alx@kernel.org>


--edzk26a3huisnjhz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alejandro Colomar <alx@kernel.org>, Andreas Schwab <schwab@linux-m68k.org>, 
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
Subject: [PATCH v3 4/5] string: Add [C]QChar_of() and QVoid_of()
Message-ID: <415453a31ebf1aed3b41da1a28913f5cbe58f175.1794323750.git.alx@kernel.org>
References: <cover.1794323750.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794323750.git.alx@kernel.org>

These macros serve to implement qualifier-generic macros as those
specified in ISO C23.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 12e31c17f0d3..9e59f9697c9e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -14,6 +14,36 @@
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
=20
+/**
+ * QVoid_of - qualified void of
+ *
+ * @p: Pointer to test for qualifiers
+ *
+ * This macro produces the type name 'void',
+ * qualified with any qualifiers present in the element of @p.
+ */
+#define QVoid_of(p)       typeof((__QVoidptr_of(p)){0}[0])
+#define __QVoidptr_of(p)  typeof(1?(p):(void*){0})
+
+/**
+ * QChar_of - qualified char of
+ *
+ * @Q: Qualifier to test.
+ * @p: Pointer to test for the @Q qualifier
+ *
+ * This macro produces the type name 'char',
+ * @Q-qualified iff the input pointer points to a @Q-qualified element.
+ */
+#define QChar_of(Q, p)  typeof                                        \
+(                                                                     \
+	_Generic((QVoid_of(p) *){0},                                  \
+		Q void *:  (Q char){0},                               \
+		void *:    (  char){0}                                \
+	)                                                             \
+)
+// CQChar_of - const qualified char of
+#define CQChar_of(p)  QChar_of(const, p)
+
 extern char *strndup_user(const char __user *, long);
 extern void *memdup_user(const void __user *, size_t) __realloc_size(2);
 extern void *vmemdup_user(const void __user *, size_t) __realloc_size(2);
--=20
2.55.0


--edzk26a3huisnjhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzOVwACgkQ64mZXMKQ
wqnzfA/9GrZZK+W+KOb7/G65cAjO7rx/x9rBOsQvMCeJEwmDSJn3Be/VpJVier7+
sUkHYATUyU+q+9GkR0OGKk0Kq1pf8y2wU/NJGFtM4FovgbG6NpZ3ciKSnftLI7p0
JqixEpOHsDJtGgO4LvA1KiJnJhyWOLDIETHMCSEcn3ZLn4VLPfHa0rWIizUCkNpn
BapLhk/76ZVtaUjc17zzlLnApa9VNwi6zdJZWnkicVGFVv8aUc8nXR6tarGsnbkN
2VvWCHG32+Ex9+bXDNcTs4MvOS/m/o9A8k8uttKdhmV4vYu+4NeIBo3wCo0W1bbV
fZI5ZFDqnbNWLnnm8DxyHegN5+fo+yorzE5rD0Bqm9y4Cip0knABMDhw1z7vKT0i
SOvZ4mRB89i8iTMgRF0yLW9vYB5busWZ/xtTKlfQltGV3e/r/QO3f6J8YATYNPxY
0rwViY3O36B7vTpQzAZRSKFElDojX8yJNEmEggc2kHWSyJ8YOSkUJd+1uAtWhm/p
uTZicBjl1vKF7q11LevobiEZIPOobOEj9sB1IhqtVZSEbiRoYjJLzmODg8teLs1Y
wi0WKcqUqdfQrLzPfWHIrvwtzGRxC/sByE9v+PT7xkauL8zQ1jSgQscLR+RrX1JB
uXAh0bzgn8Lq9sxaWF6XoRmqYNObiby+RGvcm2t2nF0UaJwWvm8=
=llC6
-----END PGP SIGNATURE-----

--edzk26a3huisnjhz--
