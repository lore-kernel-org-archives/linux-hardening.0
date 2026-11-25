Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640618;
	b=Z4jvW87QOpZW+YvDhqfZstgHsYHRcl3Os5qbTQcSMyxwovOGna8J4cGr1T3VNxm3F6cu
	 dznz1Ulhq+euWGn+KBHc+WvXsFMy9q6ucoLAezB9W5BauyI2emnHquLIXK2tQSEoAFY5w
	 PCqj/GVRNf8rLw3niX3b2gSqqFZMhdfra2A4i9RKjCevNI3AVG116IuNzxe+WnbuQJ0JL
	 YaYiNS8d9xpzQ15j3SAZjzS5tdpfdY3BadScxabIcMZMs79PEkxatO20yW2435SCUC7bR
	 Q86X9X39Si7qcPJm54oy7ktsKvMkWOQFKhBjnst1KhCY5c80ZROsSHo4XDdl2Uo0Y8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640618;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3fhph1GAVJjfdORA0SwXz9/ZpkIdcVsp5TLlvtshcyI=;
	b=MFjusD80WrdAgGuZsDwFUgn8OwzS5nQMta7mPljPxMAZoLrxt5+/5OAISu7dksPctpP8
	 0E22EL6SVEA6/6vDQ4aQBfANmqB36QrrWLC5zHLCINhD5nLO2jUTR/uwUnAg015/Is1n8
	 CDYAKyVbZIJb3XQ0m6Ow45fDI/xTHa1Z6STOEK+fjtWuFS5/Nkf/cIsOaU4ZmXh/Rpfpo
	 y6xU3cFVRELiSd/McILKfVd7CNRDuXHjxMHW/1Wrxo9TYeDtOXZhT4fu07MOBrrqnAlik
	 6d2Mh6C9Z6+FlEVPnyx9FmIO6tZxg3zx/k8q/wQ7LCBPhdIMljk4WXnjo96ccMkLs4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsMlFrT2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0810B606A339;
	Wed, 25 Nov 2026 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsMlFrT2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968351F000D2;
	Wed, 25 Nov 2026 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640617;
	bh=3fhph1GAVJjfdORA0SwXz9/ZpkIdcVsp5TLlvtshcyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UsMlFrT2w1k13mNa6WIzqlIHPTFzVQHzQdK2imMWZnnhPHq6hBj92lDzGtMNkc2CO
	 uVFcvSzdn1s6EcGjqVBp9PySXlf1UNdqX6xdM6KIdE3wiTw1Tlu9J6tu8fBImu9y2O
	 K6WnBlkHkefcWJAopjqASQdYnkf4hs/rCNeHCouVNz91+QSioNIpSEfsNWaCAukwYi
	 nUeIu9XiLzJhb+ljfOrUec6obT4bQPyuRvunUgfF4wwxPrPCz2RG/+6UpUZH5KGrG5
	 MySqeuaZ1I8HzYlBzer+OCLY4djAHWD3jYWMUFHfqyK9DhSrp1QIQ4Tirx2Q/P9jSR
	 kbLxsLzgP0xlQ==
Date: Wed, 25 Nov 2026 22:03:30 +0100
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
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org
Subject: [PATCH v7 1/4] string: Add streq()
Message-ID: <ad8500a6eb0ac67002bb22eb14b3b68b5b5500f2.1795639368.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1795639368.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="xro2a4c6cav3iqwl"
Content-Disposition: inline
In-Reply-To: <cover.1795639368.git.alx@kernel.org>


--xro2a4c6cav3iqwl
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
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org
Subject: [PATCH v7 1/4] string: Add streq()
Message-ID: <ad8500a6eb0ac67002bb22eb14b3b68b5b5500f2.1795639368.git.alx@kernel.org>
References: <cover.1795639368.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1795639368.git.alx@kernel.org>

The return value of strcmp(3) being reversed makes it prone to mistakes.
Since most of the time we're only interested in simple equality, add
this API for those cases.

This removes some driver-specific definitions of streq(3).

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 drivers/clk/socfpga/clk-gate-a10.c |  2 --
 drivers/clk/socfpga/clk.h          |  1 -
 include/linux/string.h             | 12 ++++++++++++
 lib/tests/string_kunit.c           | 13 +++++++++++++
 4 files changed, 25 insertions(+), 3 deletions(-)

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
diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 0819ace5b027..f84a60d4414c 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -287,6 +287,18 @@ static void string_test_strspn(struct kunit *test)
 	}
 }
=20
+static void string_test_streq(struct kunit *test)
+{
+	KUNIT_ASSERT_TRUE(test,  streq("foo", "foo"));
+	KUNIT_ASSERT_TRUE(test,  streq("", ""));
+
+	KUNIT_ASSERT_FALSE(test, streq("foo", "foobar"));
+	KUNIT_ASSERT_FALSE(test, streq("foobar", "foo"));
+	KUNIT_ASSERT_FALSE(test, streq("foo", "bar"));
+	KUNIT_ASSERT_FALSE(test, streq("foo", ""));
+	KUNIT_ASSERT_FALSE(test, streq("", "bar"));
+}
+
 static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
 static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
=20
@@ -891,6 +903,7 @@ static struct kunit_case string_test_cases[] =3D {
 	KUNIT_CASE(string_test_strnchr),
 	KUNIT_CASE(string_test_strrchr),
 	KUNIT_CASE(string_test_strspn),
+	KUNIT_CASE(string_test_streq),
 	KUNIT_CASE(string_test_strcmp),
 	KUNIT_CASE(string_test_strcmp_long_strings),
 	KUNIT_CASE(string_test_strncmp),
--=20
2.55.0


--xro2a4c6cav3iqwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHTSEACgkQ64mZXMKQ
wqktIw//YYLZOPLrBFevQe6OjXEImGlGhTgPV/LWS61pglZlh4R8zQbVFfFu4Z06
0+AXDydFVBHxfOBVvWYAagzOFEZfC/XsDSAhsqyCCA549pEttlqXCocQ+RCgs045
2ob0+9GWn6WDpDLdMAjo6Jb/o2qyDPaftCewR3oYXErs+14YDb9k+aGFZwhFWRhh
5IeBeA3RLxhUHxhF1mKjIpXbRydcNMX63XK4l9hRIhEXlZNAjhJRMgxyr+zcog7x
iOay+Kl9BpD2yCZ++z9quHXAkkNdRuI1qWNtXnE7WYfUUYRvnPJXkELZelUuPDZh
3V5wTo2OsatXVFGLKZZ7nJQfN0LqyXH7Esf5KiIf0clpxm7e197sy1BXmNAFzc4M
CLCDnSK5bCPINhfmMTB90iHnr7RjfSM5Nw7qftEYWZxFiigkCKVPb0vKgrM63T6R
K8mbOGy3sbW3HljYTDZsNnEg+KLqjCgSmjLlyZ8cFtQKgA02KL9v22DN4+aBpjDb
wQyXUq6sPP1Dt9o6dLZ8aXqxlGCen+VEOH7/WQy8M7/3eSDdbe6cqWCPkXrYqhde
t5BE7l+SDxn4fn91jJEfy6Nw8nzgbXCBV+S1j5quMe6FFXLtuD293gdRpShE0r2y
c0qmo3fAEfzzMyfCoKlQ/dSGgTkBC0wGBuMG02HB++T4/hDUSH8=
=Cdqp
-----END PGP SIGNATURE-----

--xro2a4c6cav3iqwl--
