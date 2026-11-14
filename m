Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669841;
	b=3stKOqpmtwPXP5c7FrQN7C3bfXjyiOgugII7nzsXdSSd/rfPFgG5JBj1NDYVzPP9Ylcq
	 yyk3QrEMxZpWwZ7r9z8JwdxroQi9L+7WK4kOextdSzPx0N1zcFqSwvNoPfKs2zNcwHjXm
	 idZbXt9Nqim7Uq6idT7Dbhyn4h5tQ57wrqCQRQwvaeI6T6lMQ1BkePtFzwz5VbeK9kz2T
	 FhTy87eJoab9M4T9tbAkoK2zm1wg99aTlwgDKXxzHat7s2ZIdrq9W0vd8neYs4akgmlx5
	 XFJuDnBlZsc+yMNgFHv7uZkL9Xnu9GPuZ7WEof3MmEwFICPeLO2zuENnbHvKp0JJ/ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669841;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xMSNIiJdSa9iRidaXSnoagbPK9Gb5hgqhXB3yqy3gdU=;
	b=meDQHMMakUMaUdgpGrP9P2u8JT5JVHqa8+9/hKHEQANvG/0XCXdWckMCiE51BCmebZFk
	 xXIZ7KIWb5qCGiHYVeFy22nj801HtO1zxd5e9/swQWqJSDYm6MQsF78UyZe4kwf/Knn9c
	 Olyt4OidJPBhkmXPPdlmPA26T9Bi8n98HMtlMFNJ662j2J05+7tL8+CQdfYR3sQpS0icA
	 ZYwDnSGxhGqiZR5c6wcXjYjaLeiZl3NbpyMOF8mEv7TsUPbJ0l9wyy6oXp6fT7xgsSRGS
	 gORGdO875MY6F/Clt4zstQJTO86jpweC0fB9o37iU56ntAuDRzwcRYCdWLafM6L63Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvNYV54I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B48606A33D;
	Sat, 14 Nov 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvNYV54I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA8A1F000C4;
	Sat, 14 Nov 2026 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669840;
	bh=xMSNIiJdSa9iRidaXSnoagbPK9Gb5hgqhXB3yqy3gdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WvNYV54I/VeRWhC9kQQmPqzCUTN32PTg0VKfiP9JX//HLjAxB5gC7/zRJsHaPFdow
	 iQPbHcLabeCH/+7wPDu3EVwyDIsG+Oszx10Gbr8SsLBbCX2YcnKEkhnnqeSS33RK6Z
	 lxt8cj7zZbPKn/O4Lt/mUIPY4Ol0qH0kdu1TwTsp9vuCM/rJbdk1oiDXHPZmkR7ZzR
	 aHTW1fBXZQQCZFt+Br4C9cx3Y3G3eNs4Kt6ZcAIWal35nmsY3nMNwpsRWEwdMRNYQB
	 oWQcx7TX6Hzie4V4v2lLoHBPSr0AJH9WZdwNmoE55jr4Nu1IWFLtCXMvnUfPCpjW7n
	 wY/eyNcMzOaUQ==
Date: Sat, 14 Nov 2026 16:23:53 +0100
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
Subject: [PATCH v6 16/19] string: Add strsuffix()
Message-ID: <636fe759a4eb0f40bd76a50f64e6bf430a78b37e.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="bawuhcytuvmf75wf"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--bawuhcytuvmf75wf
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
Subject: [PATCH v6 16/19] string: Add strsuffix()
Message-ID: <636fe759a4eb0f40bd76a50f64e6bf430a78b37e.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

This is drop-in compatible with strends(), but is more useful, as it
gives more information.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 6b0de932e23a..2f7fb2c70662 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -47,8 +47,8 @@
 /**
  * streq - strings equal
  *
- * @s1: string to compare
- * @s2: string to compare
+ * @s1: String to compare
+ * @s2: String to compare
  *
  * Compare two strings for equality.
  *
@@ -610,6 +610,30 @@ static inline const char *strprefix(const char *s, con=
st char *prefix)
 }
 #define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx))
=20
+/**
+ * strsuffix - string suffix
+ * @s: The string to be tested
+ * @suffix: The string to see if @s ends with
+ *
+ * Returns:
+ * *  @s + strlen(@s) - strlen(@suffix) if @s ends with @suffix
+ * *  NULL if @s does not end with @suffix
+ */
+__attribute__((nonnull(1, 2)))
+static inline const char *strsuffix(const char *s, const char *suffix)
+{
+	size_t  len, sfxlen, off;
+
+	len =3D strlen(s);
+	sfxlen =3D strlen(suffix);
+	if (len < sfxlen)
+		return NULL;
+
+	off =3D len - sfxlen;
+	return streq(s + off, suffix) ? s + off : NULL;
+}
+#define strsuffix(s, sfx)  const_cast(CQChar_of(s) *, strsuffix(s, sfx))
+
 /**
  * str_has_prefix - Test if a string has a given prefix
  * @str: The string to test
--=20
2.55.0


--bawuhcytuvmf75wf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fQkACgkQ64mZXMKQ
wqkfjxAAlfzfy4TNz/o7eyG/IF81nthlNGaZK77F77e+tDxtqT7RwadhXLq67Gdv
CqWfJioUPXg5Y2TZJkB4gprA0d4b4TAIOMXppcwNkAf3WXatkHt4EGk/mo1EjuPZ
wuVMta288X1BAlkiVsTBpeMv0G1uLIqJBYky9WT+xnhjI2Ku5XrFxsXGiVRB5Juf
sEF+hWGcylL1ILLsyWQqfPHAcaCzlze6X/sgk2rr03zKDRG7ggu7axYSMT6F6Uie
LzaXiQXbzpGAklcTm/H5N//M9WiLsfwOnFo78er4hVUa8rf1T26OlQqAs+t0xByM
vnpXHJKdXiRvqSagX/Ec22nlcbJgNLCeFF94iHJo5Iw/bLYa1hIiDT1zxRsuqplY
pq222//WVvfZK/tLGZyjME6lW5FsLqX5fiJrHCzfV9c8CG9Ix5whFeGe5rmu1rn5
9UZrzUnmFCi+74XY/7hyXJOVPjYA1HluibpI2A83WOnQ6qM3d7cAJZl48BueP74m
3uVoq5V5p29mHppIeGAAVRNLF1vOhf6hZMmAHv2fa/lT2LQiwu0Akdr0NUCQesiH
UzZcnwIs4+1IAGVvR7ynGSW0VHfB4tviDUXJZMUNeqlPhocVKxAFm+U62L6sCT3m
GaxGjO6xVvMIGjaflwEYlgizEtIeTAuhwH//pVNeHi94u6Y4ie4=
=d8QH
-----END PGP SIGNATURE-----

--bawuhcytuvmf75wf--
