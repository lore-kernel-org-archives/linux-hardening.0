Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426923;
	b=Y34g59DN/7PFuKSJb6GZ4MYM7iyTqAmeoUwjtZc80lDpImrP1s7zAmYagYqaG/b8snzW
	 BIBzZWnHsXN1uNEZZbM0cvSnReBeyDfb4kOWRQmqOWRA4j+Ij+WELbYDLEE8RBLCZQ4NJ
	 sIjHaQp4+pWwOmAPBYkbo9V4Dz9vdBIlzHCe7ADrBttMQxzrGQ6Af2ecgEP7eu+Y6n2ed
	 kW+rSl7RcGgVZb3uSUU7OcNkIEA1ihJzvcUcD9Et2VvF2171ps7/L3DsIe0cXxKvNHbeH
	 RLs23fX7LqxSkMcWNKCZQnU8KDWbhoYvmsd5G4ml0puczUowLJnmSd7lYLui0E/MptA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426923;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3xpHbI62c3/rKnzmxGjsB9A4+YWLweF0sRR23GzkfJE=;
	b=izW8GlCmgPkHGJgXCmJtzMHtAQdkrTW9twEB4JsLIv4I2t8Mqfotht7VYOzBtsPRQoxn
	 koS0wS1E+NUOTmIHOj6kcRWykzoGRRNLF5WtKJXN/LCKFcsTpsh8/ObMs5Ax/DuORh/Sh
	 DvgNDMNyRR60x+2hP3H86o7gNOaG0xUCXxT9Z6COuERz5tIqrS7gJjNXSu6Ge4EXZlefw
	 fh/M3gttigj6osmjY6Edf6fm4vHUbmoS354KOCTTKZcYavSueBEHkCUAUS4sLLbHDZUMa
	 D3eoSkbuRteKFFHhY67AOZmSxrL7RwxUmxkEyQdrtTLrQ059euYaeIKmizN1E3c4/Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mv+hQ3pb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D9606A321;
	Wed, 11 Nov 2026 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mv+hQ3pb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EE01F00A05;
	Wed, 11 Nov 2026 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426923;
	bh=3xpHbI62c3/rKnzmxGjsB9A4+YWLweF0sRR23GzkfJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mv+hQ3pbHhFuBmRi7qnBjH1fF90XUkb3ZFIBDugI9SBzgaslRjPL5xonOF9Dy4Xsb
	 lA1VV6pfsNkrM1aML1nvcRxTJQO3dNLknZZYfupLjz3ZprPSxPXI+7oQdh3xa64/fm
	 df4MVTpnWxK94Qg4JJCWcSKnJa1O7LxcYPMZIhXtlFu5pdnFC6fgJta+sBQ/UvKATw
	 TQYx7KwXYx4+zQ7eAOVVQHNG1jcUqXA2qzQ9ZJBrFMnh616gxwaGv8pHQQEGva616s
	 cG5De7FhxLU2ie8exDzqiw4QSeK5W4M46wRMDyORF6IPRwRLXBNbJXhze6jgFMt/dx
	 s940NAcnUNDyw==
Date: Wed, 11 Nov 2026 20:55:15 +0100
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
Subject: [PATCH v4 1/6] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <a74fabd985a874da7556ae1601053b4bcc100f13.1794425425.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794425425.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="p7m3s2yqoanb4rri"
Content-Disposition: inline
In-Reply-To: <cover.1794425425.git.alx@kernel.org>


--p7m3s2yqoanb4rri
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
Subject: [PATCH v4 1/6] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <a74fabd985a874da7556ae1601053b4bcc100f13.1794425425.git.alx@kernel.org>
References: <cover.1794425425.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794425425.git.alx@kernel.org>

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
index 6cb5cdd01158..d08ca10c39a2 100644
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
+ * *  @s+strlen(@prefix) if @s starts with @prefix
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


--p7m3s2yqoanb4rri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0yCMACgkQ64mZXMKQ
wqmuIg/+OaOmPlBJMyYoWnbFL8MBQmMmWd4rscwLheOahksVvluoqozMr4mAfAKk
bYHw8ubfPbM5sd3xXYFpbqAHNyF15qGel898S3yH/djX7t0gQ2jdp4mlQVVp6H52
qQpt/fNrZCt3hlIMgCw04ghuYkVyvLBju7MY8CVOhSpEw9ZoCM7SPLHQTxjrLqi5
i04hLbjvjwRX8mPN2g2EKqnTitXdfV0S+znadObacWy3Ob1sixMuz7QcGApCSzBz
/m96WRTOXfZe31kgc6GaGN/6qL2oIii96QC4jquCJAWaRtvO7uPZcV2draZzIhkf
gPyhgmlX2SSFQRDQpAhicjHDFRI74YAW600/HvOUnu0rhAXaAfcMnLXZLKy2M+Kc
wpSvAfOqg0+LFMVSNBmtUnDFGE1wpZuFGQ3ew+gFYQ3bxUsMwMcBj+hSqEoRiis/
onHJqL3Z08Va8JSVfJvFqlWIfvGFSK75ODTGPy35hJ4ovsNgM2NSQMZBJLtHYGYn
AcoKMVCz9lj5iRg/ScQj8YUrWEdEQrxC6E4OC/ZnMeF99FozqBbN0t9m09PCNqwm
w4QEEuapAwBDcB/0ESJV1fgGFgv1iYCHr7yz75e23bjZOrvtLLUd181tknceswep
SLTX5Ksyl8X1+OhtfEaErd2b8NcDbRv+7NDf8xJ4Y9PtObKUyRE=
=7ujc
-----END PGP SIGNATURE-----

--p7m3s2yqoanb4rri--
