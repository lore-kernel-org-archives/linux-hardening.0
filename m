Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575437;
	b=dM4MUnMV9K71PbhSNlu8F5aopE3dgmldTgvYakSd6YPhvUO3awDHJskfkJWEysrpaGLc
	 pVJyNMb83ZgBT3jLR6mxUChkyopdFXDu9URVgJDr9kwZD712ooMvDixZJfm4MtB3WWWdt
	 66Lx+SQaAmoX6fK/16WCFz4vfsP250lP93OZGo5ZbrHejgohgR3LiJ92prNnaCGufmoDH
	 d73SThV1yCUWVQA5uhkyNEWkVmI9P5znWsBz0vOQEpj6uBgbfhDZx/jZbE2Vob6WKC5YN
	 17FMwZ6IjUYqH2psk9PFU+Pj2upYoZwqes3WGEj1ul0Pabj2SLXaPTGlz9L27mqPwxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575437;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=s3kYLlndz7ODQeqoLPJ0x6q5ayIWFqd9QD0R8JsbVxo=;
	b=oKcqg+0igChnhQsVl3EfOnJFqEeSQBD2E8TkG7FoSzto2wJ4t9Qo6FRArERtEejvQlY9
	 fTqurcR4uvtgtqiyz5cXIAYVbzTiaqQp0LVJSF/bkpMCvs6yCFKEkssGZCEzeN8wWn1G+
	 R13q1aRl8cgIToLz5VDrdJWXRB77doTtvM7+65stI+1v002jr7fc8hbK2sj/5NFhY20WL
	 8d6+UMARvi/bLD6voBvme88YRKWKbnwQ1JEJ4N13XPKhREHHMsHp+3DJ7Il/E3fDI59bT
	 L1Owj0qSkOhG+EMmMVcJw4oeOqEWN876CP3/FK55pY/wpxV1+L96uB6UTpa0eIChcUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eu3Xmuv4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B4606A333;
	Fri, 13 Nov 2026 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eu3Xmuv4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07C21F000D3;
	Fri, 13 Nov 2026 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575436;
	bh=s3kYLlndz7ODQeqoLPJ0x6q5ayIWFqd9QD0R8JsbVxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eu3Xmuv4DqH9FfJ16Kp+ATSHzKyUznfGJCF6hXrzcAlZlNhQPxxDzI710cOWj57nh
	 y1NlNmAyUHeB4feVtZt5SBJ7/74wCzpPviwyE7aVZRL6Ay4dHI0xL0+CD9WBYYv8Ep
	 6XM1spcoD54F2yeZVKKKg62ZXP7YI4DAW1xy2w1D7Vt6AsajKW2rAlO1j//wyGDWs+
	 iWfZf04ExRSAh7p6rcSZIb/UM/ByL+BdJ/A+jOlQHdd1cj13TYPO5q/Bwh+twN6j2J
	 ZgoDbKid6gV3Td4y9MGy+UYyrsKg757m284GzyCy7IuMtgZYHWNgPTAL8KNZX/5Ob8
	 S2+fqSAjmi0Qg==
Date: Fri, 13 Nov 2026 14:10:29 +0100
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 1/7] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <f25bf43d7f18c99019a52b9ba9a1e46fa68174c7.1794574496.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="l6arro45rqxfvdel"
Content-Disposition: inline
In-Reply-To: <cover.1794574496.git.alx@kernel.org>


--l6arro45rqxfvdel
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 1/7] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <f25bf43d7f18c99019a52b9ba9a1e46fa68174c7.1794574496.git.alx@kernel.org>
References: <cover.1794574496.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794574496.git.alx@kernel.org>

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

Move the description from str_has_prefix(), and describe
str_has_prefix() by comparing it to strprefix().

Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop=
-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h   | 28 +++++++++++++++++++++++-----
 lib/tests/string_kunit.c |  9 +++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 6cb5cdd01158..04e8a8c0f05a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -545,16 +545,34 @@ void memcpy_and_pad(void *dest, size_t dest_len, cons=
t void *src, size_t count,
 	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
 })
=20
+/**
+ * strprefix - string prefix
+ * @s: The string to be tested
+ * @prefix: The string to see if @s starts with
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(s, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant.  Instead use strprefix().
+ *
+ * Returns:
+ * *  @s + strlen(@prefix) if @s starts with @prefix
+ * *  NULL if @s does not start with @prefix
+ */
+static inline char *strprefix(const char *s, const char *prefix)
+{
+	size_t len =3D strlen(prefix);
+	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
+}
+
 /**
  * str_has_prefix - Test if a string has a given prefix
  * @str: The string to test
  * @prefix: The string to see if @str starts with
  *
- * A common way to test a prefix of a string is to do:
- *  strncmp(str, prefix, sizeof(prefix) - 1)
- *
- * But this can lead to bugs due to typos, or if prefix is a pointer
- * and not a constant. Instead use str_has_prefix().
+ * This is similar to strprefix(), but returns an offset instead of
+ * a pointer.
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


--l6arro45rqxfvdel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3DEQACgkQ64mZXMKQ
wql3Gg//cTNa0RerWXNHdMOjconvGapjEC1ZMdVN3vWaHfItN8oRry1xFwteIbVF
dIBnMfhu3LZCkd5RdpiRWf5i1iOLZ+mbleKyt2dkmUjAhfRud3Pi0jlxSKjWV2G5
B/Dme0R6MR7fJXbtt29ZmX0n/SajBDyH1chCiXSqhiObR8u2Y/8MQ0dU+Qc6GCDJ
4qhpsBTOP+ZccLcuSQNopxdxFlCCJSGmtHcNZChqayKx1quHynEiSow1OeucFfKo
BQCCBUZ/YssC+Pj+J6PYV5HCWOh6dyOGTQG5svLQVEbmg6kRa+Uv/oN9bYv0OkQS
WVt3eCHGp21FMF/r1r0rfal/9R3MlLCeiwgOfLUSpmGYMB/BCUhz1OnsDncNJcGF
vbISiHzv7kFWyPtwQ9sbJkOiZf0yc1kHoD1ZK0GqVLgA2vh0UJH/u2TbEEvV+rwM
DUHgtPWAzn6ZRzibb8Xa2s4IvQnpUvflVGtOv8e6qh7VwMZ8we3RYmkYAM37iqhd
WIsobP0cNLYgt1nkwb9C0r2xrbFNxwOL+fHlzx1KiVShDCC/t7Qsg7yePK6cTSdI
o6LOu2nfat3mbN9uX6zJLGw/PZ35NIVRocIbCq7K53xJV4M7i5ty73crJW9DEbbz
ESV1RAfefogP5Hy/VPqQ4a/1hJ1MFn39nGM8d4UFSDo95f4M3Yw=
=s5He
-----END PGP SIGNATURE-----

--l6arro45rqxfvdel--
