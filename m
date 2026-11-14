Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669865;
	b=iAM8BhovV1ZIa+NKINfu6KynZs/Hwj6TTYM7keiEg2RuUNy/UdhnzFSitnmHmUNcp6FJ
	 bZCZLQPD2dU4FGL6r3v+MiSrQMXzgl+siDcRT2vBXtQMg/fStoAPvbUDNtQbRsO1CiCbh
	 BGVkzpigJuxYe9Mo2HnakIjj7NrdBGs3kOkluZ2i6aKMPHRMbANuDKCUJKZ91NijLLYTM
	 CsgGH+9rtLFAuuryt2fzIHzMwhtv5etinOVidvyq9DQ/zp9q79a3YYciPP08kSBzF42Lj
	 6TfvwaGi45mMFePq5Z0LnZsHQLvg6GauS89w6hNV2KjdxniIqEfNf8uJzeWL1XkvVSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669865;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HVscJ2IwqtoUJ9t81zzUz0oyptelOLp85I4J/ziaHHg=;
	b=L9IozHA41HB8cMCJQt532o+0zczSlkSg3CHIrtDxMED11ik9NhOAaazRoXu6T5hLaXxC
	 4MY85q/kVxjdyMN/tDSH5MDzwTWxLy1TJ/CjsiYuxdjvW3xkmzTwwREIHau8zwdB3tguV
	 23YLuJJjOHaLc5ZCu+cILDLsiI38fe66Vd9TT7Ey8EliQK01Ii8yc4bIujSorcOZdF/zp
	 vEl6gJr+RK7aZbWe87QQXx5FKImk52G9EOOUit5p20ijwztlkS59p8DbHgJDU7oihlDEX
	 ocDv/age/1ncdKF+lCJauzyDHygy7JzonJkYmbp1eqh07Yw4nn9Y3SNdV6KTYXfjhBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEM7+CNA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04713606A329;
	Sat, 14 Nov 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEM7+CNA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B5F1F000C5;
	Sat, 14 Nov 2026 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669864;
	bh=HVscJ2IwqtoUJ9t81zzUz0oyptelOLp85I4J/ziaHHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AEM7+CNAtnfjXox70wpf2tLDzFsXu9/dopb8oqGbDf/D6dlEpj9TDLn2cxxtZY0CJ
	 /85Ounl01702r8h2lbwQ1r4XW7EpPQYhD0ao2uqBBDYL38FFwdrTa9AbYKEcJKGx/Q
	 8XtR690IZX8cAPQbOFvPkebrIec46rTK0374r6zHaJPkZOyyJaKc9ow5sB/sV3y2Fd
	 Ot+4BoQfTJhWjn8OVPvQzNkwXbLMf+dDeY6reS8J9Ot87XWzJK/H5No4/B1B7yJufZ
	 CToWjaU2SPz0cVsV08eDab11Mta84wd4pTj+Tm5XwKZ4JQR5kb/SLWu1CwYSKiO8Vp
	 bVJq4gtRPEPYw==
Date: Sat, 14 Nov 2026 16:24:17 +0100
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
Subject: [PATCH v6 19/19] string: Remove strends()
Message-ID: <8d5cac1ac296fe3b78a08d87624584fa98441879.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="iiaev2xmklrgibdq"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--iiaev2xmklrgibdq
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
Subject: [PATCH v6 19/19] string: Remove strends()
Message-ID: <8d5cac1ac296fe3b78a08d87624584fa98441879.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

It's now unused, as it's been fully replaced by strsuffix().

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7469d4634b3e..f41f30f8bac7 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -633,7 +633,6 @@ static inline const char *strsuffix(const char *s, cons=
t char *suffix)
 	return streq(s + off, suffix) ? s + off : NULL;
 }
 #define strsuffix(s, sfx)  const_cast(CQChar_of(s) *, strsuffix(s, sfx))
-#define strends(s, sfx)    strsuffix(s, sfx)  // legacy alias
=20
 /**
  * str_has_prefix - Test if a string has a given prefix
--=20
2.55.0


--iiaev2xmklrgibdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fSEACgkQ64mZXMKQ
wqnIeA//U4/8HCQXsw+OneO6RlHOIvopC3sKg9xu99vfLCDwmI2/XJfT78zA4JDt
rL94280el6Q0xY+CLIDrt8VXFJJS/7lmE1z/Sv4U1cucaTlydsBilT2BCKmxks7L
oUgWy2zUkXI7CAX9ou6lXqUV44QUJKdqz44OeU3KwhvLzswGRODiAmSHujbxhuaC
gWoK2xJIlba63xmMPSZJ7cXtJHqVGVB86XbWexhgBK3fkXffRBA3HO8zophERYYy
phMRFPC6QxgABxQp0QCxOHYsvyD2fWEhnJi0VRgwLzIZ+XcU4orvdYbWaDcoVmSX
RUh7WDOKycFv5UC2KlLmb7OgtS7HCwDYM9gRciiY6EZlyO0H/x7zqwC/9BxHIhzr
dHGkxiSPhV/BJlpQu7h5LkxzD4nbB3jB4z79CfaIdfi4I2inApKsDtLjrG2tR5HL
2BI5NLxZ+4PNu6KoiBRuQJf2yKtPbeHsblLfKjZxj6EFTLK3WS9kmIZgEyCWVWzD
bI4F5z/Wdp8Qm6qqE2+AET9DM39W0J79g+3RsGjRNEdqR6SuV+uWzDmIY6/g5TkM
KAclUJBFwxNOwdmkGlOLDC2LbSYGDpFVusWYgK4vhLXCGYOZQ4zjt639yZxGDblx
CR5Weaj3q25oRI7p+RNOWWoxpCpMH8WtGxN2pT8H3uXbrTnAFCA=
=p3mA
-----END PGP SIGNATURE-----

--iiaev2xmklrgibdq--
