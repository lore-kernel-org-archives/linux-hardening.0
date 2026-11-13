Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575469;
	b=yEBx+gObhxOueAAb/cLibi9HRCiUzzNxn2ry84YSkl2e61FsKY5s0sNf+UPXlBafGHIF
	 +wl+rkgB//dRfTuM5NPvn3YouCQ4aiW1467/vmkUSkdKp4hHqRKWtCJzs7YlEKpkhaBoq
	 Ny7kTPKPnPxtgJMwNZPVCWpm6qF9+3/LgbqQJVCSJ9f/dL2m8BVq09nV5lopESz60Q8Au
	 ZbpTJAryFmsjd5B0tULThCkJuFtCe8E3jXWcKmTh3JXuNMf9uz+uknI1D0jdDDTnMLWN+
	 QNQLCSlZA8jT0UsCV9TY6znrSWvHT4pc0pyNDSTwWVUGrGH9ebdbfW5F80acQjHMpxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575469;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cV058yayD8lqQNsj8kt3xdjGSO6Uw35IkBTo2SsxDvA=;
	b=s93Jvxn5/Twkuy9hM6+A8jeCpxWLbC2CDC6HU7yYDhr41gv+5zZMyVI8U+p8opFFQofO
	 pRc9IpUosp2MvE6um2dGNHJiYXETg/kVzkj4lfOb/9BvkWz8xz8clCTLzd5AZg+u76JfM
	 BRrB5T0YlBvxF//YMwIFuhe6UfHgbgxzDi9aLettIs9g+Oby38KXidAws+c29vdGLKIhM
	 sDoqRhsOwdr5Jg0wyOhNDXSxRjF2c/ZC7894bjcGVGw4Omnh5mmaDKhRxdxXWQYeJoZ+d
	 GMEviqS5tRo51804yQJYWEj+oOlozkjWTpWmQULQ5gXWNIJ4SPCdYtlaN9aWUOxjVgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkOopfCs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9060A3833;
	Fri, 13 Nov 2026 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkOopfCs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4F91F000CF;
	Fri, 13 Nov 2026 13:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575469;
	bh=cV058yayD8lqQNsj8kt3xdjGSO6Uw35IkBTo2SsxDvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BkOopfCsRZJgJZMB1Binr5GWVdSnpZhBLWLMzygopwCChfOober9A2y1U3OA4BJxw
	 xsmfjv7tAg+4lhnBXxgpErTgm/GvwIYIDjWCrEoBWB2YEWou9JlZc7G/Cs5WLt9B3C
	 3OKhurmkAHc4PCNxpUmcSyZvSDo8yEIaNW+5lF75/5Oq26Gj0FtTOPbx1pAe7JdiHC
	 VE3rZ50slOlwfR3AX8XSD8SxKjKl3UMFMOGZCOmVb34r9i402eOhP6d7+Xl2p0kqu7
	 C02PaFXEX5v2ZsVaZYOEjfTpLPhNwsKOWi6d/iG0w6hPA2XEnv2CW5LFPwdr97oO37
	 PqOqVVY1Nl+JA==
Date: Fri, 13 Nov 2026 14:11:01 +0100
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
Subject: [PATCH v5 5/7] string: Add [C]QChar_of() and QVoid_of()
Message-ID: <1294b3d64440346b67b0fc79006984a343fc8bf6.1794574496.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="htjckynr2h2tacdi"
Content-Disposition: inline
In-Reply-To: <cover.1794574496.git.alx@kernel.org>


--htjckynr2h2tacdi
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
Subject: [PATCH v5 5/7] string: Add [C]QChar_of() and QVoid_of()
Message-ID: <1294b3d64440346b67b0fc79006984a343fc8bf6.1794574496.git.alx@kernel.org>
References: <cover.1794574496.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794574496.git.alx@kernel.org>

These macros serve to implement qualifier-generic macros as those
specified in ISO C23.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dcda1b7801bb..5f3ac760df2e 100644
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
+#define QVoid_of(p)       typeof(*(__QVoidptr_of(p)){0})
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


--htjckynr2h2tacdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3DGUACgkQ64mZXMKQ
wqk2Sg//QfQrb1UrLd8CGvqMwU/rdASv0ZafhJ4KUapXbTyNZDou8hC3oVk37F8C
kk/SiDmvHMRYEvoJEhbUmvihjd9ojf3v/c5FEn303JOYXq3JEGKBBQCFVGQUEfY2
mmT56JnJUKBCuanMr0V1OQDWjXTRL8SBqwgwKQVgUBvYtXLyThOcf4NDmfLynvzO
bEk+RVxsZ6baveUv7Crds81DaQK30KIl6f63lM/ean/qj2ua951Z40pWgMgXovM8
CoLHqrKDhbaxbZcvHRBw+ew6qIBK1UfVg1a0Bwgnk0n2J9tya09M9ADUt6NfmPH8
oPu/nHFcpaQu2pm8Ko+FZBrRvIEnzcD9d+vBn0IgM2+szcPN7P3AMD2/dFXFLDT0
EeLDuG0kvG22dMOOXYDNywjPaYPBcDGJ9mRCCW2DuZmuMnt9cz6dRrvn9nrN0jYk
P4w/xPZQxGirYhtob3w4v5zMELwmxk49jkSbDVDJ/dLr2MT/2Bp9YWY/CYyu2ygt
bMcfvVEp703SF/a+oEf5RZBLvEBbV66MNCqsi28AMk1WQyFf9JBJyFts6uQ11qkQ
PHrLlAN04YbEyTaYDp7ExYi9igQc5oEUJLznGPKy0JFsbz0zju+LIvbp0ZLu5mbo
A3ASKcqD9eSwDVRTlHPmwvWR7BIFzQa0ytOtmvbiR4wkVmVJLT4=
=2XCv
-----END PGP SIGNATURE-----

--htjckynr2h2tacdi--
