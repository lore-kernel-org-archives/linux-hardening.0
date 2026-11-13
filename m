Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575477;
	b=0bcr3n0K6epNKTTjZMSpPZDLG1AMCnmYKqHnBEPl2wTRdSuVniKezp7lFuWSLffVK580
	 Nd2I2BMT3bXed6ICkQ2VIc1NN7y7Bp7BjBWu/YcEbBLlhuK27/hrRNwkRVis74RN5HFg6
	 b2xMgNeKR/Lu5+Q2OB/5ao6TSk3YwSPSm5prNe9sXeI2n9rgMQkMlxVx0+OJitXHjPs5H
	 uYJcMq9dmOXTELUU4ZnOwvIPGtRvFftuEjRnOq7OBg0dwZQ80QxWIsCCMglafIuDeW2fN
	 xVPMvIypzQVfESCtAPJ9icOscpAxEQc/msGecv/xsIeOcaFgS+SYBpLdmX/1VKrp6lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575477;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2IdJqO7H1pfkyyGWaWMSZ8sDfdyknWASryND+ME9Ais=;
	b=FWy9HOv98/1iMrFCoijTevyHak9+nFPlCo1ZwTDZ29sXgPIlY8cpI93+zqOrwW8vaEK9
	 mhPO060RZRWkC4DqQvb8goec5vT1sUBJq5/Yb2+8SmpbLsuxGHwqpCWNUbcBFieCx/AfA
	 3azcMag2oHbJmXo07BzvCWcOgl65A+ZlK/+k2U0+a1DBptzFhS1wi6/TTOahv2RaJ4Dok
	 VU7qHwqGv8pr5gNbYL0pUlBvpjWIYTXM0BVtJNh7RQErmylKe4eh2ss2LH9lNsIQkw9D2
	 RA1Jf4vqb+Mf6149Q/48Nf9n4Dko+IUzZM2Vep32IrcQhuDp5EBLBQNl93Yw78JkvJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVjce68U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1D606A898;
	Fri, 13 Nov 2026 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVjce68U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AD01F000D4;
	Fri, 13 Nov 2026 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575477;
	bh=2IdJqO7H1pfkyyGWaWMSZ8sDfdyknWASryND+ME9Ais=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BVjce68Ug4+K43xR+VdmgwahfxDFNZZNKoxtQKpncr5Rc+/f6rWiBSyBhoj3iSkhv
	 6FTQuFVZO1D21W5tZugRO7j45oEDGpXHHE6UduBMaQHeSjA9lRMzUVyyRX4Mas73Jg
	 3g2JbquoNkwq/ta/JWxcjY3hJuFTaudenNwpBJ6bBh7JFkdzP90F7cDr26cKk8Owwm
	 OxN1j2if2fxsmV6/lneYvK8BoViTnfT4oYVRRsX6iX/5/AXXZw+zKP9+j6fJjXK0oa
	 dMr9w7fbfRTe+TAr6VOISD5hQU2IKgqHztrbzf/bu9J1WaQUtqtghZYzKIr5fDZS9m
	 YSDthWSPuzKUg==
Date: Fri, 13 Nov 2026 14:11:09 +0100
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
Subject: [PATCH v5 6/7] string: Make strprefix() const-qualifier-generic
Message-ID: <0ca0b7aabcfcdff06dc3f77b4f74e36f1298338e.1794574496.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794574496.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="i5qsai24wbe35a6n"
Content-Disposition: inline
In-Reply-To: <cover.1794574496.git.alx@kernel.org>


--i5qsai24wbe35a6n
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
Subject: [PATCH v5 6/7] string: Make strprefix() const-qualifier-generic
Message-ID: <0ca0b7aabcfcdff06dc3f77b4f74e36f1298338e.1794574496.git.alx@kernel.org>
References: <cover.1794574496.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794574496.git.alx@kernel.org>

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
index 5f3ac760df2e..b1468d3913f6 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -591,11 +591,12 @@ void memcpy_and_pad(void *dest, size_t dest_len, cons=
t void *src, size_t count,
  * *  @s + strlen(@prefix) if @s starts with @prefix
  * *  NULL if @s does not start with @prefix
  */
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
  * strstarts - does @str start with @prefix?
--=20
2.55.0


--i5qsai24wbe35a6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3DG0ACgkQ64mZXMKQ
wqmtpQ/9FqSVKEd5S68Yl/iTPNzT5abQ6aLd8jnKt/59BsYwr1FJUfQyfMq7M//w
IdMANHxUMZV/aJJyuXOqPjso34nrPat6Z45nu5TwJWiSXbVLLbcyZ21RRBzgcVIq
bfVJeELdUE5ky3GURp39XaZrxfOYR6hnVsvzVbeXKF09XmN0XCDi4XJBrXzgNkKE
WTO1qOswGzGnI7p++w5Z9Jp7PhcRq6bU7Ri90P+lrK6uZY4utW3ivJBHhUB1wo66
+qQajVD8sgOl9IKZoRCyKEO7kIhvaj8hGX6/273+iO+PJjGB37jAyOAYWNlJnJPu
HFN0/1DxPI/jRARW1fKsR6q5i8FP1XC0j4/Jhny2qcIAOWZQWntMcKDaB2xFT5Kl
OBH17rh9tfuFl3ualcktXGES2w0dd/BwCY0rLKqejYUQTIdFZ80mCR49fqAAuVRI
mj9iHXWkdGCgfQWu+zoBcCSvvvIn1l2sT4EL3AOvghPJQ9VCnsCpPqhp6Vmtc4Zb
NCWoLcWWOFz3xMUirbCeQ8Ucje0dP3jqrNVUznwXC61m3h51pT0tPO8Nny12hBGq
opFa1xdtl+WarD7IFMvxBOhvNL2iQmg2QoLrek9A8wwqKTSpcY9q6yw4+FWzhR2j
Sr66HjDHWZV6NcDwjet4xJQHDpeBv+lZ9nPY9w/BYyKAdrv1Hy8=
=bZGI
-----END PGP SIGNATURE-----

--i5qsai24wbe35a6n--
