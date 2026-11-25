Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640626;
	b=nksCsbO/VBRBtfm7ZHwBMuJ5oBTJqhcyWY2/Ji7sCgTOBY9PZ2chziXj/0853OJrVaH/
	 FZ096royQMzZVIHynwmzKWgLQGE1BtC18/nMzZG+1G4V+VXoyaUyHmENge27whSQXD3zY
	 nkwEhMc5IHGMy8QXTwMuvZsd3FzzkpSAHyVz75x4hiQWXay3zSM0oDKnmfvy9sjsHfkcO
	 v59VXC8POpkMu4527lK4viS3oNIN41pJn7wa4Y6en1eoxa7nCE+eEm8x6p33h5O245w04
	 wDj6ontOsm80sFjyu9nBKDrvLixg61sHkkG9iXa517IdlAVIu4P5OFnNmrmTBuNbHXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640626;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TDa39fF8t9NIGpvWx91b/yjMs/wLAuhTzEniDBWlpoY=;
	b=cYC0/neTTcmmfM84x6PiX+fjFithANArWYgJvZbQ7veEZe8cdW1H63hP7Ff7OvtClgoC
	 hflPKVdv9NJEoFSmKJnmRpNYEjx5mALh5H17Kgy8doaRkZOa0BwlZ/INOHTwdHlnRpb9D
	 9iUxYxKkjcXMeHNuGWNqlu5uSIIsUd+3fcEUfKe8QicgFK8yhUWE6KYwSleM1q6krOG8D
	 YktLTOgQtfxnWuZANUDRvCnLUUSHuNILF2cjI6OK5YE6E2t1JTH9UneBFvju3EQzil6Hl
	 Rw0N8ASF+oNSnye93f8lkq9exT3BNFD79Lh+9vhHRv1w0/+oFPz8lEvPopMVKIBs3RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZUC9d0Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139B606A323;
	Wed, 25 Nov 2026 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZUC9d0Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9061F000CF;
	Wed, 25 Nov 2026 21:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640626;
	bh=TDa39fF8t9NIGpvWx91b/yjMs/wLAuhTzEniDBWlpoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mZUC9d0YWNooTdanrwddpIU4Mbok4fSPIFpbwUbLssb0X0MgUulXqc9k/R0fYiDAa
	 pCAB0/YXyRVidyf251fcSdxLkNMo8G0NV0XEUbVMNn5iq4qCZUWHsOxiwq5JmX1+XA
	 E+FJ3gKRz2qi/80s1O9ATihk2jlahU9R1crYEIw651bYS4NFzUfdV5njtkcP7eu4Wh
	 vYcebFsQpe+5VO4FiqWUpaeKR6pNtiwpGxMrF6PBhGgfM1i1RBJn/PkKr/XIvGdE3/
	 H01he2sXGj8JUc3LeAK5Ikbh3QJ9R1/5MakYmd+IZ1BQIHmreBb56IqK3OvbPGSC7f
	 CmyPg7BYLsZfw==
Date: Wed, 25 Nov 2026 22:03:38 +0100
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
Subject: [PATCH v7 2/4] string: Add strprefix()
Message-ID: <b32d70163fb454fee2667548c63c4d4d3b19d7bb.1795639368.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="e5hmt7yi62hdfrkx"
Content-Disposition: inline
In-Reply-To: <cover.1795639368.git.alx@kernel.org>


--e5hmt7yi62hdfrkx
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
Subject: [PATCH v7 2/4] string: Add strprefix()
Message-ID: <b32d70163fb454fee2667548c63c4d4d3b19d7bb.1795639368.git.alx@kernel.org>
References: <cover.1795639368.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1795639368.git.alx@kernel.org>

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


--e5hmt7yi62hdfrkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHTSoACgkQ64mZXMKQ
wqnkOBAAtIdmhXQ8LLGa6u2HZeq4E0SoFSyZpMPZ5eSkjkNcKndiEn/REsjgyJEB
0GjDJzdfMzUHdtHVWDtbrXijhn+ol0hHEymDFNrXgCoXUoG3uX8uK8gWLAn4+qmf
UaUxkIl5amC7lq1gl0nP0l3HUoVLOqDOO9MHXBDmJIdmy4nBRdq9KYC0UYF//+81
0WxadktFdXiSRWwlE7iHoFWF8nGfsd7opJCk4De+anCNgymNdXJQg6LR6Vvb91cg
xfSJwk5a+OqQAwqilJVRK7BX/jU66Nfm/qfowKtKRssFic9ptH0s8ClkZKxSkzHY
OjlBzs/sVb8k1mfEDaUrcdBXOpQ4TGdIS53UVcwt6UV3kHzJxmOf/DhYuUzUtHIA
1oBrEvAQgVbFzK7qwWFrtMcUmkQ5vGhVnkrGYvzR7INyR5UiEkpgq7nSZZ4xRKKB
dme0O77ufdI2BqpjI9Pkdnrh95oCLXI+/KDc5upwi7dVLDYBrn/jm2EEVpB+DcoY
a6KWdHKoZhxFvTKfcdguJyfhW31unM28/6OK/otwS8hk/+fYsBolfaW/YkapHTQD
SWrfBBlXmMtH0vyw0YIMyGFTqN6x8zWMYbcqvqpVZPO30l2lIYOmYbkgMDmzymYq
AxD7ZnlOuMnoz3wZUC7qC+2tBhfb/l4QLsonQ7y6SX4AGLFsTd4=
=8t69
-----END PGP SIGNATURE-----

--e5hmt7yi62hdfrkx--
