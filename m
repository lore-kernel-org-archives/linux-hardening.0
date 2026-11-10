Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324812;
	b=JGLDm1mHvH9GBwOXIkHt00elCq5ueH8FmG0Ulc71iXOCdJwP6XLL4c8KB1nAhqpwYWta
	 yh73JoygkSsrH5yMQHcRYRhMhHdKEK0UrP4I+BhE0GpLPhPK1mnwbkCpQKDXO6FuzTyra
	 KViuWIjDx3wnTY4Gp8V5TdD9JCB6uDfra+9k2OERStloIT5q5k/YXdZRh2uxfVTvimGt4
	 he66fzapMzJUr4Wm1M8L/Wex8xAw5sAWes3UoaZ6ZbtMRGCj/axvaZJyXNzleb2XHj9O4
	 YusnUAo4G1TzslpubEJ6xzlnDbDm4qlsLSr5/EA7UXk4zbS3QgBKoKpnPudumHRUbKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324812;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DWt8GeWZawoex5a+W2d/Na12GAtjhgYXL5w7iWbeav8=;
	b=UqcUBmvNY/oYdcjy0ZaySJfYeFAiU7m5jSTR1Pa7C1OcwHruOLQPF0OejjH43Tyf1vBS
	 s3LknJzIo1cntzFip6rDXc5r5tyi4OGZ11EQHl7k57QOMxYI4uMWBpZz2sbT3bkFC3B3y
	 S1oI8q7g0/AJyzf7795E3paqmdP/zOMDUzKCMAHRGa+AFqyeLxRz8E3440lp7lAGhJerx
	 IbOcbzftPNMITtozr57hE2Fo9rAdU8B3a8Gr7IudO+jfM2CXbN2msHTIddw9IOCVvzubM
	 xEwSBk5TEtRWbAgk/zAwRlXA/QubsJWCTyuGG8QVCK78vEOUI9MQ/lMe9bHNGtWdAGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxEFkoHN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF39606A331;
	Tue, 10 Nov 2026 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxEFkoHN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2691F0089F;
	Tue, 10 Nov 2026 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324811;
	bh=DWt8GeWZawoex5a+W2d/Na12GAtjhgYXL5w7iWbeav8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bxEFkoHNGXlUyTETbf3CJYZvaWkJUH58bpDhEzKSjveXe7CI4bHDJCzbc+HGTHyNZ
	 cdkynZovTmLxBnGaKIzYq7OXVjUr93HOlZp3l1oNvI1QFturNyhPqp9aGfI0RC7OMx
	 IxmOhUUUOhf5HRzUv90zT3P5pummtRkD+pIeCrdoa3Gw6wN+h4uAYbpL4M0rb0Cymj
	 soKgQgIURqljugXSNCvRShvfNmMdPZLH0wm4D4pmBJQNPdru8tPpVCunLIdglpxHyE
	 Ad+oczNO4MiBDy5Q88kWoOVTvVcLihKH04kkWxp7zMD4dh+ue60AmJUD9keUIdz3xu
	 KeCvxGhOiQL1w==
Date: Tue, 10 Nov 2026 16:33:23 +0100
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v3 1/5] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <556766412884389a7cecfe6affcc9fa3a78f9807.1794323750.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="w5tbvnshw7cw7rmq"
Content-Disposition: inline
In-Reply-To: <cover.1794323750.git.alx@kernel.org>


--w5tbvnshw7cw7rmq
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v3 1/5] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <556766412884389a7cecfe6affcc9fa3a78f9807.1794323750.git.alx@kernel.org>
References: <cover.1794323750.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794323750.git.alx@kernel.org>

As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
between an empty prefix matching an empty string from a non-matching
prefix.  This is a fundamental design flaw in this API, and not
something that can be fixed.

As always, this is a consequence of choosing sizes instead of pointers.
Sizes are often the wrong choice.  In this specific case, pointers are
more capable of differentiating these cases, as NULL is a special
sentinel value that doesn't need to overload a valid value.

Let's implement strprefix(), a function that returns a pointer
right after the prefix if found, and a null pointer if not found.

We'll slowly migrate existing code from str_has_prefix() to strprefix().

Copy the description from str_has_prefix().

Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop=
-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h   | 31 +++++++++++++++++++++++++++----
 lib/tests/string_kunit.c |  9 +++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 6cb5cdd01158..12e31c17f0d3 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -546,15 +546,38 @@ void memcpy_and_pad(void *dest, size_t dest_len, cons=
t void *src, size_t count,
 })
=20
 /**
- * str_has_prefix - Test if a string has a given prefix
- * @str: The string to test
- * @prefix: The string to see if @str starts with
+ * strprefix - string prefix
+ * @s: The string to be tested
+ * @prefix: The string to see if @s starts with
  *
  * A common way to test a prefix of a string is to do:
  *  strncmp(str, prefix, sizeof(prefix) - 1)
  *
  * But this can lead to bugs due to typos, or if prefix is a pointer
- * and not a constant. Instead use str_has_prefix().
+ * and not a constant. Instead use strprefix().
+ *
+ * Returns:
+ * *  @s+strlen(@prefix) if @s starts with @prefix
+ * *  NULL if @s does not start with @prefix
+ */
+static inline char *strprefix(const char *s, const char *prefix)
+{
+	size_t len =3D strlen(prefix);
+	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
+}
+
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * DEPRECATED: Use strprefix()
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use strprefix().
  *
  * Returns:
  * * strlen(@prefix) if @str starts with @prefix
diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 0819ace5b027..73d2614b1474 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -287,6 +287,14 @@ static void string_test_strspn(struct kunit *test)
 	}
 }
=20
+static void string_test_strprefix(struct kunit *test)
+{
+	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foo"), "bar"));
+	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", ""), "foobar"));
+	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foobar"), ""));
+	KUNIT_ASSERT_NULL(test, strprefix("foobar", "bar"));
+}
+
 static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
 static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
=20
@@ -891,6 +899,7 @@ static struct kunit_case string_test_cases[] =3D {
 	KUNIT_CASE(string_test_strnchr),
 	KUNIT_CASE(string_test_strrchr),
 	KUNIT_CASE(string_test_strspn),
+	KUNIT_CASE(string_test_strprefix),
 	KUNIT_CASE(string_test_strcmp),
 	KUNIT_CASE(string_test_strcmp_long_strings),
 	KUNIT_CASE(string_test_strncmp),
--=20
2.55.0


--w5tbvnshw7cw7rmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzOUMACgkQ64mZXMKQ
wqkdOhAAqk4pxoTX8Ql2r4i+v3EnpLKDzLD4ZJmPOJiznKaymMqiUmC3Oc3FzeJB
3SvjwWIAINJVL9En9OuL2gud2UcJ9UiJVkoLdsca51z/hg3uZhiFQiGCw6HxL9wX
pr88+kPnmeGwq8CW0JnnCG3+HdVxx/1CVWRsqw8qVmzHeyChQ8XT88enTaZUX+0s
dMWS6luvOcdoXYjoVVZ4Dty8nEa8tzp4CKaqA8x58FTmgki1WC7BgoF+OgTA/FPU
ZPvv0OvMZ7aBOxSVzffkrl6+tdGmuqmpbW8cF1wdtheajR94L+ntmMFxMDuue28b
h6gtA5XdvhX28sw4YsnSMUYy4IgHB9YS1PhSqtcTP4pSmat/tYTWGxhzdWNQXY+E
SW5/7ED5WLHRaRs21klWt5jWHDcjyZoR81OKvUbjBq0kMwOpAoqjkALGTBfV2DnG
ko2C/oKO/hRtLKr/PC7HKJZBJBAZJdezHWMuxkVFNKU/8Rs/4pnZHzHNu4PkbVVl
9nbI+XoEyCUyWq0l8k0x2YiNdERMy8eDfghzqW7w3LbfIbqSN7yJQo/1Cfw/lU7j
8jq+6qf5/aD1fsqtXgeZ4bxx10gOOpEvdY+KykqQRoL3N7Ef/wyU+oDQzDmDcDma
A4U1/N5u9iAxo4leuzh12Ue5WO6Y7vIpMRr1tvnDmwGUirpWn04=
=MRIm
-----END PGP SIGNATURE-----

--w5tbvnshw7cw7rmq--
