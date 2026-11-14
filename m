Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669856;
	b=lukbHQENBUlrekBl/DVvb4zcQFXrUS7/pTZyh/92pnXooNyVMt1SYf+kVxJbWZVE6GY5
	 vJjSEd1brFpMI7E5Zgx2q4WbR3yhOZJkY6+gWR5ZyB+zfxPzPW9JCyUf8J88Eu3XytIEz
	 uMNC9A4CXJod2wYJ4T83E+TSdKsZABHgBTepJ/zkpJ/Gz3O4OchsI8bYSMeR/QpvC7vEG
	 J56vEKf9PDO3/+0KSJHvyfIqM5ioxaPRUTsVL7xrkMxys7r3PedKlaKv+TLhSqTA3Hyiv
	 HFz9BLhps7x5zTcMACBv5LlYsTxuudZ6f/ikaG3OkjGN4Mw0pa9PGEpqsVdI06/4iFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669856;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=658SjM1nmHIXNjrWy5zoXBtxbFVhdAjapTbqQDMWugE=;
	b=J6K+TM9Cgjv4Z2drzoWSK4zzhKIxS24cZODqWPbTcBWWHL7Uz9KXL4OxzCF7hcl+9bja
	 Cd0I8s4UIDJ34xZNJbo3mohxCIMuEBAwCiVDFWHEcZa9yoPutaQSsYW21GT2anliNQBjb
	 FKkFimwxouW3FHQYyAuTVEX4Nopp3KQHC7vndlKaJJd+/k0g+r8oBQSnOwaLVICTwgDuk
	 stnK+EI/gyOAutBthz/sbBlGFNTdU9LHHvb/nCBhaEVQcVz7YqHTOoyC5bDIsus0E7kXh
	 84cEYCkXRljAvRlyfNXIyKFwDjlws7IyISltroHO5QZRNIxHPJUckZV0kPEAEArl82Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jmus1vmC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06DD606A32E;
	Sat, 14 Nov 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jmus1vmC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3E61F000C4;
	Sat, 14 Nov 2026 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669856;
	bh=658SjM1nmHIXNjrWy5zoXBtxbFVhdAjapTbqQDMWugE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jmus1vmC604qGFJZ1UjumJhUw8FqG8u+TA39BsnEFj2XJ/eA5Y8bSWLLlH6SjxOnk
	 yVRayHZp1IlJ6ym7Rlc/A8czYrUF/P1zj1K7WEUOVbu+neiQHwQJhn5okr89GBd79m
	 DzG33MX7H/+SyYzESQRBV7w+8C49+LKKmAScNbs7VlP78fjpF1lWBgq8cUUgHbGLYw
	 mBVZnrLYZQljOyL2Z8lZVGjRoOGocA7v0C1UHGGsDpdXgNOm3YNT08wMYbUYepcTfZ
	 YD/RnkYFvi/Q+EwpBsmmZ1hYz9472w2HpS4hhIEJtEY4ZUf3NouheqITMqNj2T4sw4
	 rDadSrru+nz3w==
Date: Sat, 14 Nov 2026 16:24:09 +0100
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
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 18/19] treewide: s/\<strends\>/strsuffix/g
Message-ID: <3cad861d30901777d9bdafec1ccf113e0a3fcfa7.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="4by47ec3emphsvqn"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--4by47ec3emphsvqn
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
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 18/19] treewide: s/\<strends\>/strsuffix/g
Message-ID: <3cad861d30901777d9bdafec1ccf113e0a3fcfa7.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

Except for the changes to "lib/tests/string_kunit.c", this was
a scripted change:

	$ git ls-files \
	| grep '\.[ch]$' \
	| grep -v -e ^tools/ -e ^scripts/ -e ^include/ \
	| xargs grep -l strends \
	| xargs sed -i 's/strends/strsuffix/g';

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 drivers/gpio/gpiolib-shared.c |  8 ++++----
 drivers/of/property.c         |  4 ++--
 lib/tests/string_kunit.c      | 20 ++++++++++----------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index 8c9ac9d93304..677ec27e4e34 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -182,8 +182,8 @@ static int gpio_shared_of_traverse(struct device_node *=
curr)
 		 * them. We can always just export the quirk list and
 		 * iterate over it here.
 		 */
-		if (!strends(prop->name, "-gpios") &&
-		    !strends(prop->name, "-gpio") &&
+		if (!strsuffix(prop->name, "-gpios") &&
+		    !strsuffix(prop->name, "-gpio") &&
 		    strcmp(prop->name, "gpios") !=3D 0 &&
 		    strcmp(prop->name, "gpio") !=3D 0)
 			continue;
@@ -240,9 +240,9 @@ static int gpio_shared_of_traverse(struct device_node *=
curr)
 				list_add_tail(&entry->list, &gpio_shared_list);
 			}
=20
-			if (strends(prop->name, "gpios"))
+			if (strsuffix(prop->name, "gpios"))
 				suffix =3D "-gpios";
-			else if (strends(prop->name, "gpio"))
+			else if (strsuffix(prop->name, "gpio"))
 				suffix =3D "-gpio";
 			else
 				suffix =3D NULL;
diff --git a/drivers/of/property.c b/drivers/of/property.c
index f0729619a2a0..3a272775a8b7 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1344,7 +1344,7 @@ static struct device_node *parse_suffix_prop_cells(st=
ruct device_node *np,
 {
 	struct of_phandle_args sup_args;
=20
-	if (!strends(prop_name, suffix))
+	if (!strsuffix(prop_name, suffix))
 		return NULL;
=20
 	if (of_parse_phandle_with_args(np, prop_name, cells_name, index,
@@ -1433,7 +1433,7 @@ static struct device_node *parse_pinctrl_n(struct dev=
ice_node *np,
 static struct device_node *parse_gpios(struct device_node *np,
 				       const char *prop_name, int index)
 {
-	if (strends(prop_name, ",nr-gpios"))
+	if (strsuffix(prop_name, ",nr-gpios"))
 		return NULL;
=20
 	return parse_suffix_prop_cells(np, prop_name, index, "-gpios",
diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index f603e89866d1..f07a9480cfb1 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -712,16 +712,16 @@ static void string_test_memtostr(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dest[7], '\0');
 }
=20
-static void string_test_strends(struct kunit *test)
+static void string_test_strsuffix(struct kunit *test)
 {
-	KUNIT_EXPECT_TRUE(test, strends("foo-bar", "bar"));
-	KUNIT_EXPECT_TRUE(test, strends("foo-bar", "-bar"));
-	KUNIT_EXPECT_TRUE(test, strends("foobar", "foobar"));
-	KUNIT_EXPECT_TRUE(test, strends("foobar", ""));
-	KUNIT_EXPECT_FALSE(test, strends("bar", "foobar"));
-	KUNIT_EXPECT_FALSE(test, strends("", "foo"));
-	KUNIT_EXPECT_FALSE(test, strends("foobar", "ba"));
-	KUNIT_EXPECT_TRUE(test, strends("", ""));
+	KUNIT_EXPECT_TRUE(test, streq(strsuffix("foo-bar", "bar"), "bar"));
+	KUNIT_EXPECT_TRUE(test, streq(strsuffix("foo-bar", "-bar"), "-bar"));
+	KUNIT_EXPECT_TRUE(test, streq(strsuffix("foobar", "foobar"), "foobar"));
+	KUNIT_EXPECT_TRUE(test, streq(strsuffix("foobar", ""), ""));
+	KUNIT_EXPECT_NULL(test, strsuffix("bar", "foobar"));
+	KUNIT_EXPECT_NULL(test, strsuffix("", "foo"));
+	KUNIT_EXPECT_NULL(test, strsuffix("foobar", "ba"));
+	KUNIT_EXPECT_TRUE(test, streq(strsuffix("", ""), ""));
 }
=20
 #if IS_ENABLED(CONFIG_STRING_KUNIT_BENCH)
@@ -914,7 +914,7 @@ static struct kunit_case string_test_cases[] =3D {
 	KUNIT_CASE(string_test_strlcat),
 	KUNIT_CASE(string_test_strtomem),
 	KUNIT_CASE(string_test_memtostr),
-	KUNIT_CASE(string_test_strends),
+	KUNIT_CASE(string_test_strsuffix),
 	KUNIT_CASE(string_bench_strlen),
 	KUNIT_CASE(string_bench_strnlen),
 	KUNIT_CASE(string_bench_strchr),
--=20
2.55.0


--4by47ec3emphsvqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fRkACgkQ64mZXMKQ
wqme2Q/+J6zIWGP3DDeu4Ql+AzboR/6KGAbaoUciRLRO1TMTefpt+D56heH0Ayu0
/HnLzv+3hH5rF+VFOlL+NSk2+ehlBBEMgCoDSpLzrfbliMSaVjLPGSA9X6G9Xf1/
pMjp9AgzcG+N+SAwCBNyUTrjCMx8unzL0uwO+a4ptnwZpYG4oT9l44qS6g5OaHvO
X6FeiKQ0CAMxuQ/CswEQUIlxkJid0wdV9gUJ+dsOuV817CUNwPjX4R9o5P2Wh/hs
u6e2V2VK52qUTggAs7hdP/f9dnIhfhOlaeaJI4uL8qk8uY1RBFmrtVlEgaq4XDEU
vgLRrMzzuN/NCfsU2P9Q8T94CYHH/bFXxm05gW9YtFmTdkNraNWhHr8FlWIFEJ/T
6iU7Nw2YHaKI6xb851DCvh5qXcyO/XnnfPO5yYiIBmv+xR12ZjCHHgSR99+8BqCV
hiI0g1+SLhHlN8NwdDF1TkWWmP76y56HnFwO0fu5eUCQ9iGoRA+dQ4GuKhAOCgz7
QaMb33FR1BnUXQdHjh3dFKsgfMzASlUcqJgAMm8Hq5JDZMxl8OCmRseSZFf7fc2y
BiJrAWu722upblNWZ9qEYoT+HWutRQEcylI7jmw28acGaWlEh1g/Sy2utMwt4+l3
e3v9J4vkv5wtMiCVIBP2CZj/1xUy1+pP2imnLrWs2SP9rdIzjUs=
=5WQ3
-----END PGP SIGNATURE-----

--4by47ec3emphsvqn--
