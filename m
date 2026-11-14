Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669728;
	b=H9rfHF0u1hd6l1x1uDayVdPvw2PJaJ3UIo7Sr9wFj+K9er4hkGxtHra8OeXK5KASg8O9
	 yxHiysRu2uc87ndQKRRhEhaDa5zahrlkgZrVFc5xxwjr4vyeYODuZNUYCNjVhR4I8rMgL
	 2xhjQ45tSibmhcrFhGSCnAzOT8Wj4YW/RflgPUX57y+NjLpAXo4xW0+SUxb1ZSLOS/CLw
	 iVgfoRde4G74l9+biesyda7wIvCZOcCYo6bGUIJ3BWUJECpHIFweI+XjG5KdpD4GT/QC7
	 9gZQH98/TWxz3SFqLBWJm6VDKafTpox+jLsNIXmU+zAdqkf8QfEcrDzxKg3nIdIbpSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669728;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5S97dQBMmN49bMaQCLPn0HmAJs1jIuiDMykCwDKKc3c=;
	b=UR1fWPL/OpfoGih6/i6Xod2l0D4nNUEUava4oSX2VHORmUyry16vZT+uGHFJl0xepRHW
	 6nCBzYY5P7/sGjde3Htou8r+cfDZI0oxKTlRoggD3+Gjv43l73ZfqNu4p2BB3+JkigSpQ
	 /2usE0NNd/cMUxhKx6VGF79Dx2FONqATJ8B+Z7HozejhL/5Bk2ykw3tz343Ts405w4/mf
	 yuAGufUmV8mcgW8N1/SQgdGE9st/Nqqk/0JtdzJV703CVMhb66F6GRORLhVEJ4lLqMUjk
	 XhvR0ngD+Hn5FCeKu3v9sdywXwDvL9k7BxB4FO9UJNfTwMVCYfcmxyIfS4nvx+kr7kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orwaEWMU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449C6606A329;
	Sat, 14 Nov 2026 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orwaEWMU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66F01F000C4;
	Sat, 14 Nov 2026 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669727;
	bh=5S97dQBMmN49bMaQCLPn0HmAJs1jIuiDMykCwDKKc3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=orwaEWMUs4czFpdPOlzjNUJKCCWhfhgHzZQ/emxCcxeAdWigUhF/gwoXjkoglBUPw
	 02FkBnVryE4iiiDcraNlu9A88TTYF1oYMnMSymB/DwWKC/Mo363czsTkZNW8+8QYyi
	 JJAWFQTDIQNH5zZ4NWHbtEcoQy7FfpILlSVE9pZHWM874e3sscWMgu4hj9qTjQNQmO
	 SR9IwyVHc/o1eyd1zWTJCoB9Ye68O2nLbBiAmnlt4iER6pKWofYS6HmWStkzorOv1P
	 6vcZ0gpJiu6bfCZOA3nDaIny0IE9uUxfWK4AZ0xh1OV8NLezJOMCAWf1ELuLB5OfSk
	 6mB4LeyXBciuA==
Date: Sat, 14 Nov 2026 16:22:00 +0100
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
Subject: [PATCH v6 02/19] string: Add strprefix()
Message-ID: <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="iueglycp6irasl3b"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--iueglycp6irasl3b
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
Subject: [PATCH v6 02/19] string: Add strprefix()
Message-ID: <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

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

Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-pr=
op-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h   | 29 ++++++++++++++++++++++++-----
 lib/tests/string_kunit.c |  9 +++++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 9b3e578d9aca..14e825e902eb 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -557,16 +557,35 @@ void memcpy_and_pad(void *dest, size_t dest_len, cons=
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
+__attribute__((nonnull(1, 2)))
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
index 0819ace5b027..f603e89866d1 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -287,6 +287,14 @@ static void string_test_strspn(struct kunit *test)
 	}
 }
=20
+static void string_test_strprefix(struct kunit *test)
+{
+	KUNIT_ASSERT_TRUE(test, streq(strprefix("foobar", "foo"), "bar"));
+	KUNIT_ASSERT_TRUE(test, streq(strprefix("foobar", ""), "foobar"));
+	KUNIT_ASSERT_TRUE(test, streq(strprefix("foobar", "foobar"), ""));
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


--iueglycp6irasl3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fJcACgkQ64mZXMKQ
wqmbrQ/8DTa5Qc/kIjm+hMwTjs6qXgwjRbslegS1errdEZ0bMTEVriYP+C8xJ0+Z
vVavpWeNiePLxwYPnsNbZ8p7+3WZX3ZB5166MIE3t1a2jJ1F8fM+H+StkJQmR6Bz
q6BaGIcwqWTrma0y6jOYAFFIyGgNNESAS6CL4AYW1v9CeXFPZKdtL2jduZNdke+P
NAD1Ez4WNSShNuXgaG7UOVE04xW1Ta/FFCSGjY7GWGduH2kEgGw7sGXt3U6DYgVU
kJdQnYAQJTyQ7FgJyim5SG36Vl3EccTeAc2Y9WB/WssnEJRmw6dw1TnNydhRnDj8
yUjRZmJMP5EZ5GuFyuVDXYWiFpr5Jdb1I/by3U0NNiobH7g8Tg/yxWX2r3tVDhW4
23slMjT5LIPt7Jwy8fAl3eWNH1pLOeU/g5+54fahSp8uhk3yhIOkw6+Bu9XXJCyG
coImvQnUBm1jLp4pzilgc53vfChRTfBw74PEKkhKJPywn2ugb2a4RIJiWjYeerck
L9sE/YFvBCXgiaY/HWmy4RpOWf+PVz1oc0Sj5OrKSWFJP57b8tgj3nUk0K5R17sE
YLfsCY95lra+8Gw59PVluqstgMmEJG6Mg1XexwtgPxWHj6yujxx2ete4kfVPgUWf
y6l+WLXE6YvPdM1ssBh1XkO3z8bCuN0POR//MZK3Oko4c+kT30A=
=+USz
-----END PGP SIGNATURE-----

--iueglycp6irasl3b--
