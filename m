Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426955;
	b=Pq6u+9yh4l7AoJYf10Yra0y3aVmMapX2vaZNm2JHTYJBKI0gn49MdY0UUXT/H92Pg5g3
	 hTVajOZqvACG9PjFbjFH8ZwSsoaWmuGhsZ53tzKStLSTX4Jlsnu1KUOpkfIcAvmaqtBi7
	 Jyqm1who8OKV0FcDX4QgNDQ37pqJQkiuatCFrheyhkqynZe4xCzxnnAJWgobPows+9qnY
	 6apaSp4Dog2n6qW59iSRZoWH0pYdGmedf/jcON1In7JwhBBzPWMhLr2zPo4iUFw/0UPGJ
	 EFeoSCPuWMjJvJMpKQJI3ZRhp+R8I50HOcdYVO33lTZoJqUy15xXjG4RFOrBjCZScSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426955;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WX9zrpiZH/FvZE2ZBnPv/gxGB/xbp19guYkMiT2yyDc=;
	b=5RMwzQZObCtebWWCtGC4BPb2/bTCAHZar565dcuG2YSAaoCVdM28BNKRa+ZKQC1jVCsH
	 KCAQu7K8kR9ZfspHXGHQG5bfevM8ubjYcZTFnJGnOlufQkUS96L4L3MNxuPgYox+Di9B5
	 riJc97EWPXVWfYFIfeUj0Px0qDYVMgOZpe798kB2RONOS3gLwoC0loZcF0Nu3Qjg4KBcb
	 wKQgD791pFuqvr/jJY3PCRic5h7bHolXxF2yhu0rlNhEO0IynipZ4ZbUqz73HpyzNmZVw
	 +JaAZLFwiC7X9dVojU3RWEGErVWKRl+XTGdyyEXFoeZFh84DfwttjL/9TKhoPyxzZOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn9NUju+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB48606A330;
	Wed, 11 Nov 2026 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn9NUju+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAE11F00A10;
	Wed, 11 Nov 2026 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426955;
	bh=WX9zrpiZH/FvZE2ZBnPv/gxGB/xbp19guYkMiT2yyDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vn9NUju+QYsbj4von5TZJl7ZRTMfpuzEkT9Fx6JGBBykmF+rJs0wal7YNLT5GrR/Z
	 YmaVaOaAWTybvY01CqTkZuUoA5RjdZP0QmC0bBj0RXx5sw/3jNU6kf9zDW0H0dbuPD
	 3lxNlm/savP4POZ90X9DeJHnWiEIc73WzxvsVTdp5gzam3+cWy+S33L8R09KSR1DOM
	 +W1v87aK5S+82mzoS0EC4Qj4ok0XA+2rQ/678106us1wfeiWz7Rezt1930uo5/a5LA
	 yOy1EKv8/QT5kQhdcNq4HPkPyZalbamniFzJPF1qAClGVawPAJ2Wm8gQjp46H23h2e
	 wqk4rhaOWgXUg==
Date: Wed, 11 Nov 2026 20:55:48 +0100
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
Subject: [PATCH v4 5/6] string: Add [C]QChar_of() and QVoid_of()
Message-ID: <206d2045abcf11a5c97c03636219d9139dbe4076.1794425425.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="2g5juhskwhrdtvlu"
Content-Disposition: inline
In-Reply-To: <cover.1794425425.git.alx@kernel.org>


--2g5juhskwhrdtvlu
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
Subject: [PATCH v4 5/6] string: Add [C]QChar_of() and QVoid_of()
Message-ID: <206d2045abcf11a5c97c03636219d9139dbe4076.1794425425.git.alx@kernel.org>
References: <cover.1794425425.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794425425.git.alx@kernel.org>

These macros serve to implement qualifier-generic macros as those
specified in ISO C23.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 9444e216ab86..168ab1b1fc38 100644
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
 extern char *strndup_user(const char __user *, long);
 extern void *memdup_user(const void __user *, size_t) __realloc_size(2);
 extern void *vmemdup_user(const void __user *, size_t) __realloc_size(2);
--=20
2.55.0


--2g5juhskwhrdtvlu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0yEMACgkQ64mZXMKQ
wqmv1hAAuJOZw2CylN6q4pYE/Lr7AnMitMyi54guVk6aaMOcVflPTb8QV6a+JNB8
EMT5Co2dyEeSgnqj/tCLq2uACsdpP+ms2sweNFSVM98ZI5ei7XkU5BUusZNvbxg4
R/TAMzOnNth+9qpP/RGF6BcmFPn/z0Pw+k9Z2Qz/tnTMc7IgGyYVCS4mlgGjAFFX
Uq1UmU6hWhPh0TU7bOl7dYT5zJIuywcgtPtG0/p7zjG6ahYlul91SjjwY0GqMGxV
wSstukQiJmaz4M0CW6vHM2VXj5BXhPoVaLXuknqde78rSoNXpyl6d4E7ueBg81+V
eUimNpZbaLEpIRxCyZqldVOZxa55Iv2u2+zunMvvol+odXzQ8AaJfw4MwD2fhhWa
CBn6rYIZtZGuG4WUx1w549xps7veXNgAzyI6Ibpqz9qGYUYM2F+cSjPYImbL8EXt
Cc3yyHo7dqbU5RSjIofiaWY8xFIWXror0vyF0rSmQSAqIAS6HSeWr02ea8AJIXPR
eH6v6vha9UmY4C7MGYPyEqi1qJ1DY3mfF8RA47VovISl6EWGJRcUxBbO/PdE5Kjt
MF9bni7EQ+DKutbFzy23ZC7rv07Vs+FLSpOTt2cuA8dVjBcmPXFbb7dbDG0UYSyZ
uIKYPeyKsvyoovD+mr4Ja/H5VnrFWRvQNd//9yBCGwoXgNxDVHM=
=SKCG
-----END PGP SIGNATURE-----

--2g5juhskwhrdtvlu--
