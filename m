Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877191;
	b=vxmieMLzsapChyh40kkKNUTaYd9X5VRO0hF3imSUfjD5fYbCDnTC1LpEtG8Dc93ksghE
	 g4ODgmf8nFUY+njBgZdlqmECHeYSF+yKXivruxHhXJGdQwGZsSAWmO17++IxdLHpetA1J
	 XoCssjzK06ijOxoHXwyHsibQvKVXsd6mFQ4OblUHYm4ZGUN8MsTwDtUhEag0q45VKnYC2
	 3NZyVEJMSvNZBM+abq+Xc/V3I7UJaH66Us7oH9nEzgpmMPPGm8GH10o8JLAV3ZfyrsJ5f
	 2HF0YP21nUI/S0pgIMAYatRbEdn8BgmPBL2/Jov1TB/z8IuHQzl1qliiuyu6X+g2isQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877191;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=2tVBLkspS/pcV2twFy5VIVtnZMrYpSwDIb0KYFUTXfU=;
	b=jeEVZa0v64/W2nAPUcx+WaW4zkztN6hAU5PrPwr3HrEKDcLIrqw29g57M55nO1HZBQ32
	 pxI1y8Af8J1nXeSlgi4rpto0z2MlKqqixP/BkVGCdyBivyIA9HsGHrQGcHhIxscofL1np
	 2lojz0AJz8tb+i9wxSETCEmzL4tQSxGDmClZ1olgqF0UhQFvqH9nUkVhSl5haAy8Lsi5J
	 sQFXdAqJzhi3bWD9+AUZKnh/y0IkrrTqzCzpLlGQKiPheTJAUt5PVjPvqgZAOURoYU++M
	 jLAtf21e17iEb2UqaeqEqArjJom1BTTF2ylNvgd4ybXsFRQKPDgtxyzBquEiaLjg1Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFzOpoQ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC2606D81E;
	Thu,  5 Nov 2026 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFzOpoQ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A131F00919;
	Thu,  5 Nov 2026 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877191;
	bh=2tVBLkspS/pcV2twFy5VIVtnZMrYpSwDIb0KYFUTXfU=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=AFzOpoQ4zdhuwU2LuP5T0kvBzXYFhUyX2iDxo2Uf/rq79kdDqIYN8zj9rEALINKlu
	 2/XyEsvHp94YrzNAVHesJs4U6TJ4Y8uQg4ZZ93SsECr2BNgQYS2Ijz3HZ4wvUfKaf6
	 VIRhS9XvI/gouXupZ7E8d3B15nkv7exL0ElaKG9iWJ2TUrPrOoRRLJSS60tRew2wSp
	 9Fgz3g1xRY8pMWMXgWBbKAkMLy/xjhr11hzcffSYUaV29IK3gobtugA++1lu2aKeJa
	 HDkHhJ1yirN3+rNVZEckdb0a0F3Wch9T/zvaY3LEVr5BDk4/6oGmP1ftgnIvK+iwZA
	 lXGNPkk2Yx3OA==
Date: Thu, 5 Nov 2026 12:13:03 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: alx+linux-hardening@kernel.org, Alejandro Colomar <alx@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1793876837.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="5k6bo5x76lzahrf6"
Content-Disposition: inline
In-Reply-To: <cover.1793876837.git.alx@kernel.org>


--5k6bo5x76lzahrf6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.lore.kernel.org>
Cc: alx+linux-hardening@kernel.org, Alejandro Colomar <alx@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
References: <cover.1793876837.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1793876837.git.alx@kernel.org>

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
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Joe Perches <joe@perches.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Saravana Kannan <saravanak@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tom Zanussi <zanussi@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: driver-core@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

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
--=20
2.55.0


--5k6bo5x76lzahrf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsZL8ACgkQ64mZXMKQ
wqnk8A/6Aq7WPOagi6Sfx8s5CgbwInsS6EffBqQ/4TOLlrx9auPCrvZFFHP8IDIY
FiYV8YHPirbxBEuGKE4fVURzB8h0JPT7OXch7spASby/KSY52V/h8rSRM284nNFd
ofrm4iST+LNuYQ2MPFx3G40GXhOKExPxvbX+QyEbYowJnXg++K5rkRWN2SmvDcmH
1u1rQFfBCCaDaW9ZB1/AUI60TIfBi1BXEH9ZBfLMRzDB+UfbmtK9N7Fb7LmWTD5Q
lWCicYqqQcswqTpMJu80eX+nRZ1+jlPz8/5X5FhWgJltQlBfUtEZDQHs3Muvs122
aj8eu4O8cL0wzYP9beE5M9RMYFP46hYN7JQWg49dEn0LhCSiQBqjHNYpTm4Ltsai
zCgPH1FjdFpD1urssqai/fIzGI/UvalG17mNP57Q1Kx4XCj0B4Z7GdsRNQETfepl
T7HASb5MHMhif02QDE1yYJMayS9xKBe5HJS2Sai4MXHoNgwhKfzQUJ7aYuDZFgMt
e80qKPDo2FN+OmYR6IHZB3t6Oj9lj+xkfZoPmVbkoiYzyRDQ0/XUAR+GM3pgrPIn
mNlBu9Ul65RVbXgsWhgg/71zCIWktmxzPwmD43W8nU0SJvdn+6E3vj0cXmc/l7Lm
SIklhbePjI48isKL44y9gU5pbyNknIt/i0hx7IrzQifOaCrt9KU=
=sKqC
-----END PGP SIGNATURE-----

--5k6bo5x76lzahrf6--
