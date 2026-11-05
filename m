Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877199;
	b=yruialJUXPynFWs1ca9RZ4xUbYtG1krEV53tTsrNRUgyI0mgpsU2bXvUDf//EosKCiOB
	 AiI4sGw/XyON1ITqPoE6RusVuZS4jE0gmNgf7BueChQ+8aVtT1JaN3UQLtn6diJtLTyd0
	 Yyjmpr94xsmZwnb5ZZk2FVzQ4szakxSwkKGO4wkuMZuucxekiD4Q4XtGgcP9ofkuSLGQF
	 x/OQpOfqrNWFGfEyHDTJP4jYKr4SJJYPit7gHEwp/tgnT/EG1F/nz5gbDJhFuLRy+iQsV
	 J9EnDYdbnvPtSZVy3BQ/2vDn9F6gCmqAnwC1YoBPnipe7coFtlifAt8luvCFGxTD3lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877199;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=b8L7yNYxmDPOZvbm9sCH0n0Iy9Uvz/rRZd1QCuz9T6s=;
	b=xY1r5ICwPu+pynE/j2fvbC5rrHmw7BdmOj8kKFQRbrGEcj2zPDBISTL7xKbqI9R1qJ+3
	 r+379blIFkYhP+kxTKOXQgyPWsLfdmV27w/zgAkPzRdmPEAc5CdSGZKQXpZOhyA7w4qa/
	 arUw/kukZicwBCy49DAJ6ha7I89r1pDitrdm1vZDwhiDVHMMvruO0al9b27/4LKBz//23
	 SEiTLMPaPYOVCV2lPXXU/6YbDeCs0GEa2ozqnZ5MrrUz16bB9Btcf36dTbjHxdATXJJUi
	 3A3Y/qkipEDmP4hkwcnoalaGtGLYFzD/MsQqKazGaiewgaaj/k/e1WMHEctQnbNAZsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXtKcJgt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D983606A330;
	Thu,  5 Nov 2026 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXtKcJgt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1851F00A1E;
	Thu,  5 Nov 2026 11:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877199;
	bh=b8L7yNYxmDPOZvbm9sCH0n0Iy9Uvz/rRZd1QCuz9T6s=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=ZXtKcJgtxenqTKY+WsqizmV7bbNVbRK13i70ZEiGtzLLejW5L0Z/UZfwqaijkOoNG
	 Mn/64tO2B0FvaGvlehz8YKrc2I5HT7NZoTJF8X7YTFTbPkX9jj79BqrPLcFNxR7L8u
	 CkjMYl8h/OwMfGpXATJ23D5qmk3yLbiT6VUE3W6OTL27v96Cm43B0TZnYwRyY+o2pN
	 YIN/nu0swhkhQhRQa/eEBjOH1VLksjKlclT0NrhgSxHXJPjWAjS17zRQK91LsH7493
	 4H0pmNF8ZCgc1+MJEsj8tcb39yss/MMKJTSr0V2k2w3TESZj/3+VocWQoJ8jKAAJoL
	 Vt4OR8sgegOsQ==
Date: Thu, 5 Nov 2026 12:13:11 +0100
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
Subject: [PATCH v1 2/2] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <37eafcd682b03391f0b0034915079eaca434eb90.1793876837.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="zxqj3abnbtcygkqj"
Content-Disposition: inline
In-Reply-To: <cover.1793876837.git.alx@kernel.org>


--zxqj3abnbtcygkqj
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
Subject: [PATCH v1 2/2] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <37eafcd682b03391f0b0034915079eaca434eb90.1793876837.git.alx@kernel.org>
References: <cover.1793876837.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1793876837.git.alx@kernel.org>

str_has_prefix() returns the prefix length on match and 0 on mismatch,
so the mistmatch case can't be told from "empty prefix matched an empty
string".

For instance: the OF root node's name as returned by
fwnode_get_name() is "" and will return 0 for any name matched against
it and since len is 0 too, fwnode_name_eq() will return true.

Let's use strprefix() instead, which also makes this function simpler.

Fixes: a9c8c738066b7 ("device property: Add fwnode_name_eq()")
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
 drivers/base/property.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 51109794d727..7728116e2968 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -692,15 +692,12 @@ const char *fwnode_get_name_prefix(const struct fwnod=
e_handle *fwnode)
 bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name)
 {
 	const char *node_name;
-	ptrdiff_t len;
=20
 	node_name =3D fwnode_get_name(fwnode);
 	if (!node_name)
 		return false;
=20
-	len =3D strchrnul(node_name, '@') - node_name;
-
-	return str_has_prefix(node_name, name) =3D=3D len;
+	return strprefix(node_name, name) =3D=3D strchrnul(node_name, '@');
 }
 EXPORT_SYMBOL_GPL(fwnode_name_eq);
=20
--=20
2.55.0


--zxqj3abnbtcygkqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsZMcACgkQ64mZXMKQ
wqn6CBAAlONJdAvgnHp4RC4rYHe8LXiiN9VvcYWeimVf2lPVYC2gyZQnMWrRM7fl
spDdqDQXhdm+DRKaRADXyM9+coUA8/ZvXNUu8B7Ny8yck01rBA/USKGj05HJXiZA
dolw2WaZ9ORF+CN8iT64ZaNf3JAO9Aun7iSX+pRZ9AFfx6BVSgZBoybbKz6fP3M8
yicPIp3x9+W1aKo+uUXeZo3bA8yJYV0DdhXJIcE+eifChWREsVhjshmYA3Md7aDl
HwFS0xZw65BYfJ0HBnecYVyfpZwtgOlGlBNX2OIx0gUe3Lso7aXbMFUCgopciGof
HD1vl6q+69mIn0eYccf41scfOEKRU0xhqujqyk2nFW74K3kwKytbqcnp3fl0r8QR
Y0xqbZRAMQagRihLV5UgPd6cC4e8WgXbmAO179w8b21FFT6S7HWiJ5rsL/D/RTss
kxBCpr0UmHlpgkoIw5D+iNpQKemRcTgXAt1ZPGwy3Nfz8bPUM9H4S1HSp+oYFYZl
7CFRIkXuzIwIo4r4d3mg+NL3z02G+v6fy1adYf2681Ur71ewWC8t3CcVTopR+t2H
TtLy5MLFB7FJt6HPb5yzfod75RjN2Pa2fCFleCsKVZAV9ANrPK3wI2sZqhm3aj94
VaLt8UuhVUeJO/Yp1I744vaE2a28hTd9UucKJah9YDhiWZCEBkQ=
=bNkK
-----END PGP SIGNATURE-----

--zxqj3abnbtcygkqj--
