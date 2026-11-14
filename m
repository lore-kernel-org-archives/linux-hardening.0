Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669768;
	b=dE0T3j1i9gwS7xq+8sNMnjRLJ6/5ilFCg6dT7BRzkYP7XYUulXcOYUlX/bu1ZXKlo+mE
	 e8m6xGiwETDOH6SuJqlvHQ9Wk7fdPE1Ex3OnSmlq9+QIsPZmi90YQeZMj8hbyUX76fi1A
	 KYcoSLK7MWEkKStz0Hm2XB/aGdJGlAECdJKwy1RcdHSEpwZA5pMAoRcizY8L7seqVTSwp
	 fWAc3oB+8nWRRovId6fz3oPQZ1gEqXFo2NtY954aHVk1iPWLnMXBLNuvYeI1H4tFZ98BI
	 A/js9T2BAX1y9RxFXBVAd3aX+M+jYr03T6dNWwaFZrG/YSU9a/kowX9pwmEUeo1wBIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669768;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DTEbOkVQeeMRj4lQHO6ngLc6Wi8Xf1GXCAwQ7awk1QA=;
	b=GTULVNp3SCLBkCCLsvznyq6qsWgk4y5gLAFrtADpLXkIifmf9FyGQk0l22X5cb/Cvi/X
	 bL53TZVbpBgpRXj2sv4IwS6tYflIy3U+b4ULjgTJPGSUqAkTXworgmrDCV3f+gBW+KpCg
	 9ddVlT1EWxrMR3UnpfVvd8dIK3elGBToUtpt/HcxWZAq/OevbsvLu2vZb3NC99aZBuO7X
	 UhCieuLuQs1DWmx3kyh+uxEYbEOXeXEXG0gYjttBfdgUWXp7lTjAHH4k2XkagI75LBRPO
	 pzQD94sRshvuXbsc/qbJM0JRhbJUzFnFU/asZlfR/1SqT8IApkeQ7K1VuvpuPu4Pwdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ks3m8d5L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD237606A331;
	Sat, 14 Nov 2026 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ks3m8d5L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891CC1F000C8;
	Sat, 14 Nov 2026 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669768;
	bh=DTEbOkVQeeMRj4lQHO6ngLc6Wi8Xf1GXCAwQ7awk1QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ks3m8d5LKMCeAXtFjFtIGlMw/YzsRzwe0NfSrsMsSQOnSZHATIga3cDrAe1lhTgaV
	 UAYzlK05sRNGJFtqbV9g6KsQjCbcUTFhwbqBhl5/rnDNhWHBRpaGpOdpUY3bZKUGrD
	 6BubuQNxBB2M5Q6oDFa+6qqf4zXX1pNpvL9GLV5Co/piOmxoKyo6y03VyYbNKkfYLT
	 MBnP57gwqzsciZL8QDFJmf1d+p5CHUcvjcqWhIYmlLaAEDNvcwvcj6WpBaKKPh4MxU
	 hZS5l244brKScwZEST3edP5zoDB3JOAyp2YxQceJYJlUS+MZZQeMzLvziIeCBVKu48
	 QHoDk4nr2AJ0A==
Date: Sat, 14 Nov 2026 16:22:40 +0100
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
	linux-gpio@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v6 07/19] string: Make strprefix() const-qualifier-generic
Message-ID: <9def9160f7779e021be79db1ca42b49891febbbe.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="q3bua4ubejpbjh7t"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--q3bua4ubejpbjh7t
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
	linux-gpio@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v6 07/19] string: Make strprefix() const-qualifier-generic
Message-ID: <9def9160f7779e021be79db1ca42b49891febbbe.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

Add a macro of the same name, which returns a pointer that is
const-qualified iff the input string is const-qualified.  The return
type is a possibly-const-qualified pointer to char, even if the input
is a possibly-const-qualified pointer to void, which is why we require
the CQChar_of() macro.

The function now needs to return 'const char *', because const_cast()
can only drop const, but never add it.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joe Perches <joe@perches.com>
Cc: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index ede8883c99a1..013c6169def0 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -603,11 +603,12 @@ void memcpy_and_pad(void *dest, size_t dest_len, cons=
t void *src, size_t count,
  * *  NULL if @s does not start with @prefix
  */
 __attribute__((nonnull(1, 2)))
-static inline char *strprefix(const char *s, const char *prefix)
+static inline const char *strprefix(const char *s, const char *prefix)
 {
 	size_t len =3D strlen(prefix);
-	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
+	return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
 }
+#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx))
=20
 /**
  * str_has_prefix - Test if a string has a given prefix
--=20
2.55.0


--q3bua4ubejpbjh7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fMAACgkQ64mZXMKQ
wqkNAg/+OXQZ64ODduq3/r05+kK8aC4+ycbMcAXU0vExmE46LISpFNaSEasfPLpD
G75DDo8bPAEUQZ6/WFOTy3tl6+5htpazth08sw67Hs8mZoKhze8x+dTNldvSEScM
iwRi3+0MiVz1OoRHjuYxVgKMAY4M/HZIQ5XAvz93Oux31xPksn5xW1cNA2PVcoS4
kxEQrpxCveActVdvQ8OK8gjycvyzKY52JmIxCXuArsfQiBDK28YH9m9cXzxgheN0
xxWaXT004p2dPKvFoF0UcTNmskI6xgZnetuuD8s4TNdHQBUJRP2ieq1rQ67zlUP/
sVbhgNnQdk398JbCVUD2VaRZUsG474Sk0paUq57EGkNrubh9tZ4vm0CiMZhyqmyC
iVlV6J4e8BrPbDMhSdK33CFzwAX0X5d4B8Ao3FT6KGRWy2HFScRMmPulvAdg9/JK
5OHQnqeJPwMAHmsoaNcBkTskuV5Oz4rUO3c0DRCgGMqzjJGNSTv+Yi2OswhwgEes
IU32wdTb90XKCa6c/OpYq0QGBunS827D/D7EzZjG84R61NLNtjmbamXOLGmlkzLL
kDH8Nh1hct3hgHqtfTPfbDf34vwMY/VdCaQ9QxnNcQRUDdXh8YmidivSillbfGOk
ECAoAEjjOmaTue4PRDlHps0Aj7SM/1d/duwQjtMFCsbpHRDPJfc=
=HMwO
-----END PGP SIGNATURE-----

--q3bua4ubejpbjh7t--
