Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640643;
	b=zIvW0jfUNEH5pOIdafWi5al/nY6tBL2JcIzqxTPpkU/qqjQSbdc31oyPRgUCu52NnJUg
	 uTGHNR16QJsfoPrPBSwBmgKlT4MZG/5Bi9Klv251E5hLZ9WSKZDZzlJwGJSMZ+uu7zXCa
	 NiQ0zbzp355gjUkGVjAU+rjQp9q5anna7WhefJUVdYm80bXaAtHM7tdOU1OwMQVhqzL+z
	 UsbLxTZ8Ggh5n6/6JWxwP9+Q/ZBUIIEhon5V4YWieoe6v6orf5fsTnQn46Z7ErEBUkSIU
	 FLIzvUtDi1lQyKftvf11s/BwJBMzY2ozek8lZynrO3xoPVvTWWJg6d0q8k9K3BK+kvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640643;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y3LegPwVKGSVYTYdnNK4I6DxBgHW3VMi3mPtmoy/Eqs=;
	b=VjF/QreTxaCA+toF5O0Lpvia2zRM4ZE7ZJk7YN4RQX756YwCQdQnX7hOVi/vbIfuLlze
	 QV1Hd29XKP6cT7byPOkHYwibzUJysZR1cqTr9rTbxiC1KNji8DjFuDL0DE4crCp68eArM
	 ODX1Rf1wEfNnlCCJRGTC9tvAWlvXoCefLVK99IzdB8nji7u0BPGmx64Cq1pV93KbLj4DY
	 nCAky7BA+HRrhXRIMh4jMiX6RcW51btg0OBzwS8vGgsyM85jClfBgDPS1brx/yVrU8dIB
	 C3ZQE26Pj5uF87gQgxpxyi8xEA2Usluhps/B0quCRTrr0yEqKq1FdJ+go86izl/fsiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOZXrH8V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488E606A31E;
	Wed, 25 Nov 2026 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOZXrH8V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379C41F01568;
	Wed, 25 Nov 2026 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640643;
	bh=y3LegPwVKGSVYTYdnNK4I6DxBgHW3VMi3mPtmoy/Eqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SOZXrH8VjGGZIEn+RvYNUg6ZSEjUG9EpcRoZMiSGQuyPaJhZaSsg6r/wcq8qNF6+R
	 HnW3yWDK0j0vr6APaY6FPEO9ruKb/mrj/44NuY/Tr0U6Z+dBaWpcfEiXPty1AoavOF
	 T7sMDQdGe5rT0aNG1U1EZk4EhLQQIKPnEN+52kx0HHIUPsqkMkSLkN8wU6WgDYpZW5
	 VdQBJzcchGigtusjm+K66ZwZ1aZFUsE2Y2o82YUxW2IEvGDE02kdMppm5R1HidsvhO
	 BF+JyIv8KnjGloyUQ9EdElQkgfnELtdaJZFWfo1d3HcX1cSMBa1aS+/AfIID2qrecG
	 a59w0z21/Tuog==
Date: Wed, 25 Nov 2026 22:03:55 +0100
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
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v7 4/4] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <396395e1d02ca080da67cfd91a1c49058b2676b6.1795639368.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1795639368.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="fjjisv5scmeduji5"
Content-Disposition: inline
In-Reply-To: <cover.1795639368.git.alx@kernel.org>


--fjjisv5scmeduji5
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
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v7 4/4] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <396395e1d02ca080da67cfd91a1c49058b2676b6.1795639368.git.alx@kernel.org>
References: <cover.1795639368.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1795639368.git.alx@kernel.org>

str_has_prefix() returns the prefix length on match and 0 on mismatch,
so the mistmatch case can't be told from "empty prefix matched an empty
string".

For instance: the OF root node's name as returned by
fwnode_get_name() is "" and will return 0 for any name matched against
it and since len is 0 too, fwnode_name_eq() will return true.

Let's use strprefix() instead, which also makes this function simpler.

Fixes: a9c8c738066b7 ("device property: Add fwnode_name_eq()")
Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-pr=
op-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Message-ID: <avrSUUM3HMgxTNpl@kekkonen.localdomain>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3fl=
k>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3fl=
k>
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


--fjjisv5scmeduji5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHTTsACgkQ64mZXMKQ
wqkBnxAAh0WX/H6Enmms6CUV7vEcc/4/NkXCxHtSlwrxno6cATv6nWgEYHHxPKjR
ftuo75LWWlg27wzrap/CXoNEeSag+hqrshQ6whaUwQP15fL3R3U1LwQyb7XN6CJ8
ztYt4ZX937mPzy1zALQcnZxnqYF2fZVIZk71OG8VAWBHRQ9QKoYgeJOmvx0PqCdQ
8fal0/0A9k38mjwTjIQuKRJE5YmUkILz5okSLzB0GBO38Czm3UUPn+nkMvlLCjpZ
GgZ9ThDvnYKer9KDOHY4n6WEGcNABfApr+nWyP8S62aUIDLesErhAes4wIfuUysG
h55aaMEmyDhKUqtvVcrf36UyXzKw79WmYCzpLD8Y6vA32wBM3Weq5jahZxA26yBa
5oilj6vqr5OPc6L0E/JNa3K9Y/eBB2ZyxQ9wCSJccjgVQyFqMZxYM/A156WhpAhG
hgNDv0Os3RqThGhyf1FVO01P8GfrGNABUoPR+id0Ah+RB48aDlqacIxPKaO0i5rj
Vsk7LUho4hGKojJ72zLPC8MDbjWB3DX+xdOXwAwQyfYji/oG+I2f8+j+6hQMQpQp
8fav9x1mysmK1zFtx6JsDA95PsN1Zj0auojciidiyyjbrYd30tR+5d3eIhn+qrbl
IDTgIcEzqWHtc7SWkXG3H49l8B38QfC2JoMSh0ZH21rOR1y++b0=
=iRYl
-----END PGP SIGNATURE-----

--fjjisv5scmeduji5--
