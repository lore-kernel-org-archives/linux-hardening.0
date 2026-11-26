Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695451;
	b=0URyNDHxFEd/VqdPeJ/DEGSM3mUz+/bNfaDp1T51X2NBwL6/Ys2PLpRYrDTIhD/sWV9B
	 ZK8I1h6dhrVHrteDsAQ60lQ7VSTxcP27t4qOYcKVcsTYcfkWb0Th6nKwynYYxVPCZveYL
	 f73ThxfRX0xpkK4kWowzpSjSXxFThvrYm6kUTu67Mr1qrVG3a7qsAZxafO1ynwCEuqZKv
	 Fi/JkdpE04+Ol1drJK09iBI5t0lW5M9QDRcxxpcf9FnUrRuYjOWrG6gqbWGoPgUv0BrxE
	 voaqVxUObT6fRjT/Xit0i2978b6pRjHZ5P7ERKHpxRtoQeUf+9lfEDGamQf0FdJDmbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695451;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/qy6ycQd8gahMrFcDnrtTU3M5KDwgN1A+hDpjyn5+b0=;
	b=u0plefVyFir2vHqzjIva27WCVgyrxRkCMO7Zcmk+dnM/fCwGvrmLEc5rBQiW/Qvk828J
	 SLa5xCkJl4QuLqFo0/aMdQWxONE9eWHkcS5qcq41tyNi+duy6CDuJx1tRKkUQfjwYUPJL
	 tNMmijfaG/7VjRfK8GgBroTto4294cr6UHzOZb8XBjovSOkBxZ/pruiGiPaXMMhC2oWR3
	 Qczn4MXpljCJRtn/HYXIdBCWT7GQ1dV5keF1ag5+SdARgUeDigNpWBQgYjI+i7pNnsAfq
	 n0mPFINrDnmwzlPzOhmNvJgRJvjzp+WEtvCeNGepVqVaX7EO1hmwrUDNiffa9cFX0DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddY2g5Dw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A09606A329;
	Thu, 26 Nov 2026 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddY2g5Dw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19331F000C4;
	Thu, 26 Nov 2026 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695450;
	bh=/qy6ycQd8gahMrFcDnrtTU3M5KDwgN1A+hDpjyn5+b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ddY2g5DwLcxOgXsZddKlkHGv4eoGAs5tyYyQNWcOU6oi5pcyM3uM7FRgeA0AFvy39
	 yS1J+j5jipQaADf4QRmXdk279lHp+KOMPFcU+DsY1r7XvMIJYtyTz9p/7QLB2XguPC
	 pfTRK3NhCJISoW82syFfn+t1v+8gBXhqcJlsBQmFy/Fs61icaEbcZyXm0DCBHDFgnV
	 sBv0+SXRe14LeeealqujEzreUxEDDQSPmv7ujIfnn5PlWKh9cqGezubowoYn03F9+d
	 mzntIg/uVkVg76WTvuyd8oiVmT2pS+gI9VTFQXwH8n88fFp+8rtCFTsuW2c7lWyY1+
	 ofjTJiurWbcOw==
Date: Thu, 26 Nov 2026 13:17:22 +0100
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
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v8 1/4] string: Add streq()
Message-ID: <8f3840fa232e7c37a99d5cba03fe61ec28f3f929.1795695151.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1795695151.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="uxhaxx3d5qjh2svw"
Content-Disposition: inline
In-Reply-To: <cover.1795695151.git.alx@kernel.org>


--uxhaxx3d5qjh2svw
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
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v8 1/4] string: Add streq()
Message-ID: <8f3840fa232e7c37a99d5cba03fe61ec28f3f929.1795695151.git.alx@kernel.org>
References: <cover.1795695151.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1795695151.git.alx@kernel.org>

The return value of strcmp(3) being reversed makes it prone to mistakes.
Since most of the time we're only interested in simple equality, add
this API for those cases.

This removes some driver-specific definitions of streq(3).

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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


--uxhaxx3d5qjh2svw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsII1IACgkQ64mZXMKQ
wqlWMRAAruEO8IrHBToLz9KJzKMpGvRH9/CB1uC+EfwTelxXVXGfs8XwUEO0XJU6
PlnEkw63kXDDBB+eoA05KhmsF6jibbArJ+vCJdC6kyKTDKpb2l16McM1b4nDXfWk
UBeil/VaaZDBGFY4xlrEUBxZLx+AP0pOuwi0I6xrPZEWztzorM9viqu+X5KrnuXR
8vzF5HRO3F84igtLZ3BXVX/lMBr33lT/HPqmrPadRPLqyIm50ZMwabd2T7N0u6yD
JVZlqilaBhb4F5TEYRSPb5SuqtWT8KUXU7brc/rEQIOTrDlxa1KW87THMnEfsOAD
3SDmtq3l60iP3F7oMkUS5stFVWk0YnABTTGXnW5oz6W51+eXTO00UnS28ohAGIiD
rM6BobC5a2QAP/yHXMPX0P98DwqfxVFWUzqgnT5SFDTmGVbWczBK4ibbWaMww42b
bwXFg5sVwV34DDq79A0fI84SZclR7Ob1adjbbY6xhqAMOPY6Ryy7zmdOLPWdBOZ3
sSrBXQ8oQRmg3pT5Pocezq0ekezB3fI6QVpKJtxY/Z2KOo9eP6o0f4aiKFpynP6p
bF0nv+iQ6OsHfgnzy+9JuFna8oXu2yOxQ5BRVxzCnT/T+V6eenBRAbZk3zLFOWN/
UtYhYA0LewSVP469uCYBfBIDYjVrQKLLIfX0q34jqKhTj3+6jK8=
=wAeB
-----END PGP SIGNATURE-----

--uxhaxx3d5qjh2svw--
