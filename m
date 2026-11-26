Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695460;
	b=0rrs7vxZbleWOna77Do0bo3KgY3rdZAe6vWEe4tQ1qfXeuQUgY9/odPHcOL7tb4pwLqU
	 ExlnVSppai7uNpFkoWwHW6cB4NnicKxlZAcIpHecKYimkuD9MfQ37Kz6V3908O627yaiT
	 EERqbSmpLHUivKV70wYl6iglSvtpxbM1e2GFDqcBzZjEmK6JFi0AntBMxTx6HT0Hwe0tQ
	 DgdwfgRadxpxq/nBMCPtWll/LuSwuLVl9j/uVflhqCe9rshwyc7gim6BFch7mNnz8mTRm
	 A/wRyON2FuB03RkjHHabJ0DnOwaggk0Z5brOuP4EkamoimTauDGn62ZAbteSghj2CYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695460;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TKrCprL4bwmGowdMLtA7CW9oomW9938I5ELPxNZ3Qkg=;
	b=cS85lwG6KmFLDvNKa54KDfumlr9JYG10MXJcr2AudVYPJxxKLJeycCgDSaI2e8egB/s9
	 8fp8nsLHn/pTcTt5NHQUQcN1ZD2HhCHChQvpkAVlAsHVrM/BgDMEm2oix3oIHa7ulVrrD
	 f5MiL7o+nypNXhnJ35yr43piE5fCwvE7SOGEymMC/OhEOSm0yFs5OH47jcJTV8oJPRGKf
	 iAXkDVm58mfLAv8/YD0R2Z3dEo/lFDUPA+rqs9Mv8vqo7BTIe4fD1cYKERzuoKHdvxb3+
	 7DLlS2wKYQZhhxZiqUn6tjlFH3Av4oJab3jElXulD4wrfbiTjZlhdAr04tIHQkCm/3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZSOs2ZQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359A606A331;
	Thu, 26 Nov 2026 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZSOs2ZQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0871F0093C;
	Thu, 26 Nov 2026 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695459;
	bh=TKrCprL4bwmGowdMLtA7CW9oomW9938I5ELPxNZ3Qkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fZSOs2ZQ4Y4qXjaIu5I1Rg9IDkCW/miBUdt5ZbDnUncIB29Dj3zBtVcpddFlDIACM
	 Z8n3eE6GCXKI27wpkaz4GjLnHGVQlf1GjV3g3t1YWhQHjUd/xFrcXnr+7jLhk2sqYb
	 hDQgGWDIw2DmDEB97WYAxfyAdh3C0BlZwF6yqAU3JuiDRTd/xLq48R+TCVSpdHjpWE
	 mTXE3844VBLHwU54Pi5oCLYhkz+GmQ+8pvw3xqEFWYPZGbsf692ZyEdI/P79zp1dYZ
	 54mFVU7uzLzRMeTRNiVz9qCEDEdNyN3qK44o5MnbPNFty5w32Er7SN0EUq3hMtzuoa
	 T+wmQ6boOiFVg==
Date: Thu, 26 Nov 2026 13:17:31 +0100
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
Subject: [PATCH v8 2/4] string: Add strprefix()
Message-ID: <a688f0a1c20afadeed42ec4645b44de75874c223.1795695151.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="ln3rtl23xmvkvcrj"
Content-Disposition: inline
In-Reply-To: <cover.1795695151.git.alx@kernel.org>


--ln3rtl23xmvkvcrj
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
Subject: [PATCH v8 2/4] string: Add strprefix()
Message-ID: <a688f0a1c20afadeed42ec4645b44de75874c223.1795695151.git.alx@kernel.org>
References: <cover.1795695151.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1795695151.git.alx@kernel.org>

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
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h   | 28 +++++++++++++++++++++++-----
 lib/tests/string_kunit.c |  9 +++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 9b3e578d9aca..a6a1953c52e3 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -557,16 +557,34 @@ void memcpy_and_pad(void *dest, size_t dest_len, cons=
t void *src, size_t count,
 	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
 })
=20
+/**
+ * strprefix - string prefix
+ * @s: The string to be tested
+ * @prefix: The string to see if @s starts with
+ *
+ * This function determines whether the string pointed to by @s
+ * starts with the sequence of characters
+ * (excluding the terminating null character)
+ * in the string pointed to by @prefix.
+ *
+ * Returns:
+ * *  @s + strlen(@prefix) if @s starts with @prefix
+ * *  NULL if @s does not start with @prefix
+ */
+__nonnull_args(1, 2)
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
index f84a60d4414c..6c5cc5f85516 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -299,6 +299,14 @@ static void string_test_streq(struct kunit *test)
 	KUNIT_ASSERT_FALSE(test, streq("", "bar"));
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
@@ -904,6 +912,7 @@ static struct kunit_case string_test_cases[] =3D {
 	KUNIT_CASE(string_test_strrchr),
 	KUNIT_CASE(string_test_strspn),
 	KUNIT_CASE(string_test_streq),
+	KUNIT_CASE(string_test_strprefix),
 	KUNIT_CASE(string_test_strcmp),
 	KUNIT_CASE(string_test_strcmp_long_strings),
 	KUNIT_CASE(string_test_strncmp),
--=20
2.55.0


--ln3rtl23xmvkvcrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsII1sACgkQ64mZXMKQ
wqlyWw//Q4W0q+3zp/UnAFmqMdfxKeMPGpVB+FYXnjs0yfezFK8nMoQPtnFu7w5b
D5V4LrE/ImyRuT1YiS08YfBnm88EdUPdgc8bEdWHvgJl0wQw6UEJLdbSAADAQ0Y6
XBeUWttwWd/nj6tqpNysNVOWnSaZawvfNk78HdDl986lVh7O+K3YqS4z4RUPyEzJ
+S8VuScvnGSjdrhP+Fhii8Wtajt3t4rRM2fK+CAbFB2cnOci4XNK5e4j5R1UqZ+m
0ujK9iMoJkgs+2HmnzdvuDLFATqUGr/IElN4Yt0r15Xhc6FKupONirHNng/W1K8S
RDAPz+XQpd7HvoK4+dX4fxDYtm9wIaRhN4ekPFekQzhNiH1ChzKsmXXFyE3Y7vC4
wNB1H4NMcnd+SvV+owxYWFhL93+J0/7D77osf43tSaunFYw0MoNeL+waH19SSzga
joYq6KrYz8Ma9qntcCZ4QOhYaSaOD3He/THMzD+ueqWIj51SZFQ/uZgrgBKeI+dI
M/oTfounTljauXIUOx5vyjkBh5TkLLb9MrvwA5HxrDEhIVXEuZz3DXw2CCtUns3e
fH5BkYq1b3/bA1CC79hsXIhIHf0l8v3oyvJFbQy2csCtQ6CehRRYXWShxtmwZHFE
CqmqN19tPgHCIdczBSgnvtrOfvyECgwkE4Q+Z8BOMRal8xdcsYs=
=VtQr
-----END PGP SIGNATURE-----

--ln3rtl23xmvkvcrj--
