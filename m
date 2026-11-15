Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794768377;
	b=0thtkJcOKKRa/8Z1hLlItRsWnPQqsRzaxO2+DxoPsha2uDw0Zb7iaCGE18woNJUbIZgc
	 kNjZ/S4w20uvmg2GH7NHa2mpqpHyhHwDqUK4ESf6PjreMNMrBmqzDlPcGU8Jw1Ba7sbJZ
	 k9tg93LOIoHWRyGOks/KUgmSFVMUKoC/HHD+oE5y82wGLqMVBuNDUi08uTm7enNTKCrLR
	 BaDJddgwYZ1rB2iZ1z8o4mAgZYTMR7TsVdiDQ/z7nNTzHrh2aLACOZmCIYZhnh9Kgvouf
	 ppY27P29psdVrXQgP2UPOPv3UyDzziaIoeZE+SooedYaDk/oA0OmKPVAYBxp4X+THyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794768377;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZpUd6jVQIznlyiVYUXLBiP55JPtomXlhQDeGlHrc3CA=;
	b=jtasaKlnTd6z98EIBSJWP/hunQHL2JGniHmX6dC2rtqsZNQiqv4XNQOC0SmR3qQHVA2t
	 QUpUI6XVGywK/O4IgqoiIgMOYF1+H8Hy1bS4XwOmvgt8ONsNcLGYNKM78x2a2bCYriQMk
	 3a4r1nTv4ZPcm6s0UNmbo3sXcsJ2aIRhpoHoYhg9OVehInzr8p6X3vHZVEkCVyfUFtjlN
	 7llDXap4gtuUR126dYS3iJZvz27e/D702aCzXSOGorN9e5C9zlyQVAImccO797H3uViBM
	 uI1cnk0b5mxQvUEfmzj1rmrbOcBy2sy/GJUNaaO1Aer/mxd8phV8u1lXHSXr8kCJOog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDunxG3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A58606A31A
	for <linux-hardening@vger.kernel.org>; Sun, 15 Nov 2026 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDunxG3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29AE1F000C4;
	Sun, 15 Nov 2026 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794768377;
	bh=ZpUd6jVQIznlyiVYUXLBiP55JPtomXlhQDeGlHrc3CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hDunxG3MdweyW5oh1NyNV5vihQbTqYyaTUxF03ooD0k3TOqGye44OWMvUNUdDKvI1
	 mn4AuWhT70Zw9gSyUjzcpk8JershtEGBr2H2m6L26h+jlFNz8jnpa5rOOdHPUzy/om
	 ZJPK76HEcS+BJmFo7OU7c5jis2HUAZNdrDn7Sv9SgZsI6rw5WnDnpqjirOwW40GMAV
	 M19mXCs3XDLXbcAwCcPAGS5wp8+3T54KC6kJ5DnIJftb1MnfFC8BInwr4mJg3Gs1Bp
	 KvLQQi1mhC0C2J2DSHT8aH446BaSSJfXFUu/hd8VIwFi29XyQm1QlY2F71D6ZBdtvP
	 OXqz5Ag4+NIwQ==
Date: Sun, 15 Nov 2026 19:46:14 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/4] string: Add streq()
Message-ID: <ad8500a6eb0ac67002bb22eb14b3b68b5b5500f2.1794767906.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794767906.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="hporh7z3cf7raezs"
Content-Disposition: inline
In-Reply-To: <cover.1794767906.git.alx@kernel.org>


--hporh7z3cf7raezs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/4] string: Add streq()
Message-ID: <ad8500a6eb0ac67002bb22eb14b3b68b5b5500f2.1794767906.git.alx@kernel.org>
References: <cover.1794767906.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794767906.git.alx@kernel.org>

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


--hporh7z3cf7raezs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr5/fUACgkQ64mZXMKQ
wqlwuRAAknyli8sRJme5PzMiaa8/UeqNEcd9aoUCogDVuH0xlR8p+mreZ4Q9tbZb
KT2SjilVh0iOJ4Z29d5P+cJZBiRsJ2anqrVmf0DqeKS1MdG0keP0FNCVvekJc1J6
vKXOxCVCRWgACSDuyZy3ay0HI2IbLF33Q7/bOFTWnk3phakwf6yrgrM5AAJ8iet4
iJZw+9N5TjVvuephnt52HwdDnF/7XBE/6x2PWKwaFle/WHcfz6tGYda1+X7Rq3NO
kBwXWPZC8H9sXKifWmrx+He6dMEo8kK6U77LllwRUfwQOpyRsn/U9TYvN18T4D5Z
xneNTg6SGhNpdqVQIxJagIX1gPi/7O3SFhqUNpQLzubdEwBllyER9NsWEhFfS+KA
fPKi1IIPOBF3oBsKXAH8h4fYzAB0VFUBAw1WvMxWmCVsqlxZp1bekhq4ZBEEAEav
8MQlrySpJFVUrXpab/xlis+bdi1GH1ebamgika2qfSJIxtdtw1v/yndqIMd3kv9y
whJAGROQKbIdQh/7unpDkZPyXeo/aNVbS7FnouZPYf/LUfWFPFybph/EwMR44N+p
fX5TVlNIRXV3NmmEO6vE9TixR0Sr0yRY2oOrRZAawiaOYrvqu/H7nAazUxJAGXTI
fApFGq7AAkR5Wtna+uT3H1dgPv79g7gM+TH0+RVZhLW50eVDOE0=
=PQAO
-----END PGP SIGNATURE-----

--hporh7z3cf7raezs--
