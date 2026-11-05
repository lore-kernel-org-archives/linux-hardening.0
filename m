Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882797;
	b=geBgdZK0FyK048J0kPMqpFTPHGFgtV4b1RWuBTXgSg/4jsmHWeFxdZ1cdM20QmgqHgoq
	 4NX9V6sqQh6CRzqfiXLxUzQUXGlxe1TLL0NlICJcQIE2vcnBXRl0oNTETb9h9l5e6tBGo
	 fVyoN9CXiWHA+9xFcU8BlFtcLcdy43WtrLM+zkGvlz/PlaKc2g3/VY0Zjf5exqtt00xbr
	 AwppEd1Xmw+HpOXeeflqmjvSpyFPRMlt7w2Dc9WZF3OoC+f0boLL7lc/1Vwxl1f77FfI8
	 +KPaEwqb/WI0zTCgTVhU55Sj1ZmsoCFun2GNjU5KDor4Cdpgto3XKslDuHvySP2HU5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882797;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=qR+ajvSYIWPcrZNdjwbZ50re504SAD6q3ySr9SMHBx8=;
	b=UZgoF8fM48sTpWnkysXNGb5/T2OHlEGQaTWDHEw42gXye1S5W1HXiRPQ4gZwZ+AJQrJ7
	 vqaJ+nWSjVd/I0PNEYhEIADQb5lMRBuLy4yCOYai7vZaKjBIqALMNtMRLaZMI7tB9Xc1f
	 htrftL9XV5wuChrMXrgo1reTaWyWl/9spiK0EdmcYLHSjf+BaDWuyD8akw4FoHNBx+RHr
	 1B84Cu8Ba36YFsHDgD4BcesYN9Jfvp0ESNPvMN2TiRz60oS+vRCTGs3xSZsQuz9MUV8CQ
	 SBpOfY+Nni+uLGM9MT0DLjk66GLUA8sqRR34xMgsVkjtJs2gPOn4NMOEHN8qLKJPEUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZxMliIS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF93606EEA9;
	Thu,  5 Nov 2026 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZxMliIS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100191F000C1;
	Thu,  5 Nov 2026 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882796;
	bh=qR+ajvSYIWPcrZNdjwbZ50re504SAD6q3ySr9SMHBx8=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=ZZxMliISmCl/Tp4L06tvt5/sKFhrPNo2vAlfg9fO9139UMkY6UslmksHQv4Seldj7
	 vRmYkaERO9yABDNP9h0dWn6OBbdhbBuLJcMQfAIkycmLwfDPT4octgL9d6tOIR/o7F
	 4e3NtvSNQiWUegIAsN0E3XpzvsYgCewXmh7/a1TLY4W4RkgYxD7NAQ4voNEgNoMB8C
	 +1wh1R3JWMQslLsqkJ8TqWb4ft3F+Z7mdYzMJDMoFM0JTB0rXGtQINavj8/iQVOdxP
	 3q2s49ytUZaiz2MraBIi+Gy2PfMElAuStZLCHvAjP6/L8zFgyTVd3uyeKp9r96z9Du
	 E3a1IwOnSGFhA==
Date: Thu, 5 Nov 2026 13:46:29 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1793882260.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="qn7iw7mespqvynf7"
Content-Disposition: inline
In-Reply-To: <cover.1793882260.git.alx@kernel.org>


--qn7iw7mespqvynf7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.lore.kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
References: <cover.1793882260.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1793882260.git.alx@kernel.org>

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

Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h   | 19 ++++++++++++++++++-
 lib/tests/string_kunit.c |  9 +++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 6cb5cdd01158..0397e630bdc8 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -545,16 +545,33 @@ void memcpy_and_pad(void *dest, size_t dest_len, cons=
t void *src, size_t count,
 	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
 })
=20
+/**
+ * strprefix - string prefix
+ * @s: The string to be tested
+ * @prefix: The string to see if @s starts with
+ *
+ * Returns:
+ * *  @s+strlen(@prefix) if @s starts with @prefix
+ * *  NULL if @s does not start with @prefix
+ */
+static __always_inline char *strprefix(const char *s, const char *prefix)
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
+ * DEPRECATED: Use strprefix()
+ *
  * A common way to test a prefix of a string is to do:
  *  strncmp(str, prefix, sizeof(prefix) - 1)
  *
  * But this can lead to bugs due to typos, or if prefix is a pointer
- * and not a constant. Instead use str_has_prefix().
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


--qn7iw7mespqvynf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrseqUACgkQ64mZXMKQ
wqmE+RAAi//xNeKO6CmsOrB3NIvDBoX24bbY3uNB1l7M0K0l/nlKlGL9O90gBn4W
o2PXYR9FBlFtm7UpiE3erJ2CRuDEFMxE4Cpkrkjq1shHK0TNDM610K9wOxkRcPYO
4eWMlqPUHp4GQck96BgTD+D6XSbahqhHGhzwcda9OzTG/utn2mRMiKLfpQ0JKl5z
bsYI7V5iY9z1MqIEv1yHA9h9rzFvZrJPsE/IGuYvF9+8iMzAYpy9GK7+VLljmPYQ
OO17C8dKQ2rS7HF8C1SEyevg2Xad9ACHzsXqqqVGZ6lBMEMX33jPtMhKtkPNlGZ6
FIHG03WpI7Sf1267kwQQMq3ovtq/lMKdoYpfiqkolAsBjoDO8+8CrU7N4SfqyNJV
KtCx4bujHxHrI6Pg3p9Jo65tQKFeE+wuJEvrCBRhFCvOvA3OywWyUsHl5YWAnbHd
kKY1k++YN3UiRRX9n701F0DDsZ3VUcdLD+vtyBPZPbWFK0SN+0SptSz1rGzv3u/E
kOAdr0/gue4WGhprVoOTFk4J0Di/EtoDX2wA9ztY6lC8ZBUZ5YCZ4sLA1CnJ42FF
m/ZCAdAIUHed6nNA5mfYCD/9GvtdeY+fifDvny9O01Rn0C/zNUaN7S1gULW6oXil
Jkvh+AwDpRSJJ1yL/XUiqUn6Vf67Eq0TSDGPQWqrpcOX9UcRHU8=
=VU/x
-----END PGP SIGNATURE-----

--qn7iw7mespqvynf7--
