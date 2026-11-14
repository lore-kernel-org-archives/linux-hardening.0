Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669719;
	b=XxVFwe5rQvKMVLb0GsHTCQdxe8fInbWwTDelNT9iL3Hv1PkgWQ80weXceVbCT01128xc
	 ZphGc9g8sAL5gghcxBJQ8Glj2yWk5sEOkZ71zUaH3GGg+ktHuUtcCr8HcUwzmtSot6kpd
	 jvmxU4Wl2EnWaHRHMdLgWnn6z+d8kH9PcJHCIX/5j7qzFj4asd1EkBxHB/a2kv4etvM3o
	 HqsaKQ6iYWI6aN1GlpIaU1dh29hMVabiTdaVyCN2oVxQomKrWn2BnO5e90WNR3me0fvY5
	 F+5Vg5R48j89f/zxHiViJQcuBMp1VC961t7OuE3hJ9VdDPwTU4Q0VN6RjIwQrhO1FJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669719;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eyRjOj1n2GcWdTB8gZXqJMxfVkyspEp3nTiT7oAcNU8=;
	b=sBKD1RYtJ09HuJVmH6jBQqutLYY4bj3iAZ4SKnN8eT0slmKerUEDcoLOxygEYlNdQ7kL
	 9fRr6PIlF40HHzUKltz5LDdAtdhQNwqAMdqyt9k3m6vIFQ4qJHfTDyjSKwITu2fa7SHDk
	 V139d1v1+9J9lWdqmBPe6VglC86BhdELwVii9s0iSPUPqLzQxHgtnTVhb4OeEBEKsgpX2
	 QLJ7icQgkiKaSH4q9RKKkeHiW2Ep9s+f/F1f5kEEImEZQ63M6kbjOcwHhGiP7CIlMZ3qt
	 weOxacfN739wxuaEnkm0QKC1rF6K8Caal6eYbnIRXvNfu9faOgr2sUgfOPPE6lMZl/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P4fK/Omq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48BF606A32E;
	Sat, 14 Nov 2026 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4fK/Omq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CDA1F000C7;
	Sat, 14 Nov 2026 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669719;
	bh=eyRjOj1n2GcWdTB8gZXqJMxfVkyspEp3nTiT7oAcNU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P4fK/OmqPKerQa8iu0KU9xzKTMoI9DS4B1p8sgJN6j0hTO9ltIkQwod7o5nq+Er9j
	 hDZcNTNR3DOMZoEe0CHllJny9tOsHTprMO4BtzzAbpTfo8jECXQI1xJd+FDbNE5eeZ
	 6fmjFbsarnbfHfYYtB1Q89og2nDVdJmm4inkAQRhTilTweiygxbwhF/GkYa+TCazj8
	 vJ/fEOjlmvN0dUCuUAWnplGTbJi6Gu93jKMTMoh7UA4tj9qv+DUL3sdk9CT/cYcDq9
	 JqyklOZ7gzbcknqvrkqcJkJtLTaPpsKqIS0euL1Cj+b/hyQdkfGCX1OQq+lKkYRiVd
	 FlhoA0zcYr6mQ==
Date: Sat, 14 Nov 2026 16:21:52 +0100
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
Subject: [PATCH v6 01/19] string: Add streq()
Message-ID: <cff11fd710fd57aacc6fd8f4c544d58ee94f527b.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="s56ps5r27eve3rn6"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--s56ps5r27eve3rn6
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
Subject: [PATCH v6 01/19] string: Add streq()
Message-ID: <cff11fd710fd57aacc6fd8f4c544d58ee94f527b.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

The return value of strcmp(3) being reversed makes it prone to mistakes.
Since most of the time we're only interested in simple equality, add
this API for those cases.

This removes some driver-specific definitions of streq(3).

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 drivers/clk/socfpga/clk-gate-a10.c |  2 --
 drivers/clk/socfpga/clk.h          |  1 -
 include/linux/string.h             | 12 ++++++++++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate-a10.c b/drivers/clk/socfpga/clk-g=
ate-a10.c
index ba12179061b3..df9f660db8a0 100644
--- a/drivers/clk/socfpga/clk-gate-a10.c
+++ b/drivers/clk/socfpga/clk-gate-a10.c
@@ -11,8 +11,6 @@
=20
 #include "clk.h"
=20
-#define streq(a, b) (strcmp((a), (b)) =3D=3D 0)
-
 #define to_socfpga_gate_clk(p) container_of(p, struct socfpga_gate_clk, hw=
=2Ehw)
=20
 /* SDMMC Group for System Manager defines */
diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
index 9a2fb2dde5b8..2008e6f34a5d 100644
--- a/drivers/clk/socfpga/clk.h
+++ b/drivers/clk/socfpga/clk.h
@@ -19,7 +19,6 @@
=20
 #define SOCFPGA_MAX_PARENTS		5
=20
-#define streq(a, b) (strcmp((a), (b)) =3D=3D 0)
 #define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
 	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
=20
diff --git a/include/linux/string.h b/include/linux/string.h
index 6cb5cdd01158..9b3e578d9aca 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -14,6 +14,18 @@
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
=20
+/**
+ * streq - strings equal
+ *
+ * @s1: string to compare
+ * @s2: string to compare
+ *
+ * Compare two strings for equality.
+ *
+ * Return: true iff the strings are equal
+ */
+#define streq(s1, s2)  (strcmp(s1, s2) =3D=3D 0)
+
 extern char *strndup_user(const char __user *, long);
 extern void *memdup_user(const void __user *, size_t) __realloc_size(2);
 extern void *vmemdup_user(const void __user *, size_t) __realloc_size(2);
--=20
2.55.0


--s56ps5r27eve3rn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fJAACgkQ64mZXMKQ
wqmTlA//UrvgDircwX44TszIxO7pcaTer4e7iBsYHv2YNS8hx1koC/81PTpyGCNY
4GaA5RMvUuulWO65dTWw7eTafyyOEljkKlq9cvs+rZIiM1qoXYlSFc5Q4v65YMvw
ZHMy7PDX9vg7uxNXdnlaAv4MqztgzHT6m38tQbLBfSplUsvoNY+UHN4GjTGJdAAc
a0eEQkq7HeFQemJDkxTTNJkmfV+Gv5Wm9aOYNj+LOckTBJFxsILE935Fw2aA2C6x
Moq6IIjVhWlTQKG7qiNQo5sB8PWfER/pe4VJwNDlmNYURvz9lGdZZojkPk+QhVs0
njbCNzmeJanmKR448tz2G7URl1KPMxDjmWubhptKsfhbrHThrct4oy3kEqUy25hN
bv6tS3D9ZV9cIG62VTC4FzQ8b5n2CCeNKaN7WMZy0vU7R+cVmQ7aZ0fkVVJMfC78
jwqD0SyrncEG25KX/9VJ0I8CksrpylYFA+omJTA5Q5j0/bhUeUfEWnaaUlQcVMZc
rzZNtu8ZRyOw2q/BFefS6j/a3QE56Z1g9SOTRWfT/9U6Jp+wZd8j3mavxPJ11rLd
7exnaKYykRWcWSnP/FVrcF2xJJhrKjVDPiQVG4XVb59a/dlZY6aylc4CtW//Bclu
I9YzlC5VeUQyB3SOmnUujPQkXgvpKoPg9LFwaxjwHeODVXi/VHo=
=wUTo
-----END PGP SIGNATURE-----

--s56ps5r27eve3rn6--
