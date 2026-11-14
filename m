Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669760;
	b=H8viBKGrSdCLawQsB3KeW5HbKTVEb1QQ9RJRVQzGdTiMwp0w0GNj6Gubp6r5xs89WUDT
	 aqX5PUsPCDE2+JcvM3gOEZ9Pvf8GM41F5CfLMBqfj+eRXHP3csOhGTa8ArFsGbsv/nh6u
	 ea6Z2dgeAMVRDR/sBHSOPSM8MSqsCfePMg5Zn5X8144BdJdLXJgh/orbhdQOHdmQ9QmVm
	 lT/5JqE29ZtadnL4rdQXPQ+pd8p9UK/Sb+pdF/x0XqqVx2lDnDRhvc5gAnmfPZNFg1jZt
	 4b3wMeVnxwTQCpynKesPQX2TkYELH/tX1zXH+RKU/ZQ8pw3IPcjNR9DU5B5QtWzkqgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669760;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8RjCLZPHXJx+7d4HSezeTKWGDSmaGsCxtdB/bi5JR0Y=;
	b=LxO6GIZgme2PgeTCUT3OAMvZv7oZ5zf1W0QqH1j/+n3kkKW/ipIfnPOktgxM3qQwJrNl
	 mRBuAJshu5juDk+g40IDZ3dzMv8SA1CQ5V3pAxnWWycb+WOFYh+GahVu38gh/eX9D9/wP
	 rva9Pvsi3Vs8I/VxNejW5VBel89UrNZDY7tKG3TptEDXdqvMQprx6d3h9Ts6yhVQ39u/E
	 +gS0w0aPvpkFsJ7sIHIeUAQOikVU41Yl5z7faV9sjLHR6+dX9DQPF52fIKBAmPy1yzCOP
	 HsryvLZ5KGt0yRB9NqS+wDjnDE9O7eVU2sQm2r+tnlqmfuapfK/LVeIV7BAOMfilgIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FplEl19G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84084606A88A;
	Sat, 14 Nov 2026 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FplEl19G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890891F000C6;
	Sat, 14 Nov 2026 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669760;
	bh=8RjCLZPHXJx+7d4HSezeTKWGDSmaGsCxtdB/bi5JR0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FplEl19GMetldjZNHHkkVBQpiXbXjtREspmx9WjkYekZCD6IIzHrxOI/8v3uJX8cl
	 hH2WzvPqqPv5iLxIRoSJFjzGQzeKoS3+ZqzmxAnKDB5uoPvRmapu5bIgfJKOhO27gz
	 dpAuiQK3qD61GlAuty/3SORJnnbvsTHFg5WO4SwQTDAdU+LAMCVNZ6DKdSOTr7zdG6
	 8Fd+mTgRqkwTIFT3hC7kDuwbVDLhSiJC5KrTqnSpDMHy5JEMNorK/H2nVaZJQshba8
	 tVM/4YLl0oLMyByxBfxizY5WQ3o69AZAwNXoJo8yv1ltXsTGToAs6w79lhwgMTsrWW
	 GFQFlM99HfKvg==
Date: Sat, 14 Nov 2026 16:22:33 +0100
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
Subject: [PATCH v6 06/19] string: Add [C]QChar_of() and QVoid_of()
Message-ID: <d9680e101472aeca2348026dc4851cee2f95568c.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="4gkmbp3yoapjok2l"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--4gkmbp3yoapjok2l
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
Subject: [PATCH v6 06/19] string: Add [C]QChar_of() and QVoid_of()
Message-ID: <d9680e101472aeca2348026dc4851cee2f95568c.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

These macros serve to implement qualifier-generic macros as those
specified in ISO C23.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 58b8b7c02b8d..ede8883c99a1 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -14,6 +14,36 @@
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
=20
+/**
+ * QVoid_of - qualified void of
+ *
+ * @p: Pointer to test for qualifiers
+ *
+ * This macro produces the type name 'void',
+ * qualified with any qualifiers present in the element of @p.
+ */
+#define QVoid_of(p)       typeof(*(__QVoidptr_of(p)){0})
+#define __QVoidptr_of(p)  typeof(1?(p):(void*){0})
+
+/**
+ * QChar_of - qualified char of
+ *
+ * @Q: Qualifier to test.
+ * @p: Pointer to test for the @Q qualifier
+ *
+ * This macro produces the type name 'char',
+ * @Q-qualified iff the input pointer points to a @Q-qualified element.
+ */
+#define QChar_of(Q, p)  typeof                                        \
+(                                                                     \
+	_Generic((QVoid_of(p) *){0},                                  \
+		Q void *:  (Q char){0},                               \
+		void *:    (  char){0}                                \
+	)                                                             \
+)
+// CQChar_of - const qualified char of
+#define CQChar_of(p)  QChar_of(const, p)
+
 /**
  * streq - strings equal
  *
--=20
2.55.0


--4gkmbp3yoapjok2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fLgACgkQ64mZXMKQ
wqkCIBAAvUbKccNo3RDBAng6MkPVUefl8V+f34wXra8ZmYhqmkH4j1WkxgzTh85P
XUpTLbzo1ix9FNtR4rFXzRCqHRr+rVS4M1SKjl0yhTmttZg1RxlMDJpJqcgzwwkM
0grMVyvTIXOv6ZN3cXSxAaXedZR4qqwmOgWXLKqctfIP/zbe0NaVjWiNsRxJosau
E/wRwxKgfjC9Irgl+k+gDQ+xBdUKx9LCnokayBAR7ZM/MslO7PFsP0RBKWgbPX8O
PV40o/kVoN3fBLKCcIoEs3PD00WpDJN7HHUjdJZXa7fIgwilMbxjXGXtR3ltoeP6
q5Jn1mEE1Q287gsH+RCJWFG6uW+FGps9w2HTRm2zbxCr9/Js63s/0Hv1O9UNv3Uw
lSIY8JpXraYStRvsGwBDAxHyFglEg6tSUWqIbWLWl7iMB/+pJapZBUKFWYqvlGAd
bxb2Uc9YEHTHCUYioEw4Q9aTfxyyHYv1IW5cZq8WFStNQFUq4FPQeyJ7pM5gr8s2
JY8W/v48y0rXJMlp5ULpbv/+48GeZAPtxRcCM9H1+p5GdRNZYKQetgqrO9gn8uWn
Z9vcHxVVCeDgAae8WIKWHml/+HRIh5/JRAXhPulUeqyN1GV96xGiG7ZXsLDe4VJj
l9pB66CDiAOige0zHAs2zQiJ8ZCN05xt/a5/Yv3w+iO6nyD5G2Y=
=SYmJ
-----END PGP SIGNATURE-----

--4gkmbp3yoapjok2l--
