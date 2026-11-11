Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426939;
	b=3VyP21wrV352ctzxVJo3ncwxM8g6zNjoNkCDCKzJquhu+02XaLet+gvvE6F0r2Udkibx
	 nfKQeBHvl8l7Wc0Lg1hBgR1Cb7NKEs/XBYxR/l3LErXUsPlcAUlECQzs+jdWCxY6J0sYt
	 sK9kZtV0VVu3YrZe8gfEARk1bBuipgt1XoqGYdsmcmIfZUGrxjhSbqydWtZ+pv6As36SI
	 vf6wYC9NlbWVBw57vDIo90Cv2Qgyv3xamUk3AUJKwMqY+GLUyC0K9bfQElwXkehFiGGSq
	 goB2IcWWbFgoAkSfqRu7MAZBcClNJyo8DgI4umhBGTfEAVwHsS9XT0cmEuLcHC51QBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426939;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Uwv9yr5DTxjAcE1eGU25zcS57niL5DD0qFMsr0d22vc=;
	b=V1HrJESleg+xY5YBRIRy8cU1/RLVeWpr2Nn0KZA3LiCds/5aehRVhYDCAOxlc6L3kiyI
	 JRbghxYIhtim0Nx714OrsfP+fQQctej576199IZYPMcgs8qPwK3Tn6iS5+t3SghD7L4/R
	 j7DNTMXUwnyay2YLozytOBfCErygcNsh5BqoxktTpFqHzoUgjb6WUrlyBFTcHIF0FPSdp
	 Q72m+4nVYw1201XcVv5S3ebsNujjtQv08lo7Yw4++WKaHX4/YDYVTBBdjqb8xDrjxxKDv
	 pxJuI7UQuGTMxkLCVLEZ3Iz9UvQiO2i/YaVmpKC5jCR5stbTUdSyG8wRn2kkq8Es61w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="azpKDlW/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E5606A330;
	Wed, 11 Nov 2026 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azpKDlW/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E6E1F00A06;
	Wed, 11 Nov 2026 19:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426939;
	bh=Uwv9yr5DTxjAcE1eGU25zcS57niL5DD0qFMsr0d22vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=azpKDlW/02wPdWdeoEKxouHa3g3xaZbyrFi7HIaOqacufD1ajRwWx4oHGP5QAgCSl
	 eoxfk32Vm147fh1bYsyK6kICQ8DDptF5Xlz6BXY62BcsoWmFKZp681NQ5tLOCASVE7
	 uA3nqdOTwLkKJAp7xhMwbqQjwztQP3BfxPHg3EY3S0mmuMYXyzxvYVKCV5L683QBWl
	 LsSluy2ZCvoxbSvWSTaq0izHtZAjJ8RnzDY26wP2B1BtSCutsjDVKUNOTUyQoUxWaR
	 IO/wtSXQAIdwtqRfEImGeqV3db8S6C7pGza0sjLcIcppZTWqrv2FZOo4ECfySX7VH4
	 x9WcrJKYtiA7Q==
Date: Wed, 11 Nov 2026 20:55:31 +0100
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 3/6] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <0058b60f662c72f5d0106e260998811782e6f527.1794425425.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="pjpvtkqjco6unxk7"
Content-Disposition: inline
In-Reply-To: <cover.1794425425.git.alx@kernel.org>


--pjpvtkqjco6unxk7
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
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 3/6] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <0058b60f662c72f5d0106e260998811782e6f527.1794425425.git.alx@kernel.org>
References: <cover.1794425425.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794425425.git.alx@kernel.org>

str_has_prefix() returns the prefix length on match and 0 on mismatch,
so the mistmatch case can't be told from "empty prefix matched an empty
string".

For instance: the OF root node's name as returned by
fwnode_get_name() is "" and will return 0 for any name matched against
it and since len is 0 too, fwnode_name_eq() will return true.

Let's use strprefix() instead, which also makes this function simpler.

Fixes: a9c8c738066b7 ("device property: Add fwnode_name_eq()")
Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop=
-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Cc: Andy Shevchenko <andy@kernel.org>
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


--pjpvtkqjco6unxk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0yDMACgkQ64mZXMKQ
wqnbPg/8CjKzCA9hp23Jg1CwyrA1nmuolCIHUeVvQghVdE1gspB39xHS+LR1ZqXf
i8aei9ZPLQngL0FjmffS+1iTblPV7yB4w3qRUqM96iui/ejhM2n6slVzmPlgEwQL
6KW0oPsfmFAYK2K9sjmIaqkraJZfvDkXkYFhfNnoyZHuBm+E8+ZPUggHF3N5Np7L
CRkJshxVFTH22WKnYjZD/Mduzi5IrfjCpxpd754Oc1cfh9ZxUW624cWZXIJ6QFWA
3wCgIv94nYzZUKD4mv1jPxqpuYl+e83e0kXvoc57U3/1LAVc/P6V3xAqEY9bLTOs
XS5XJmkrGH5ahQ+DI63+9FRV/XOB4YlCG1k73vhLXT1Shc7Hhtuz1z7ZO9V/obuw
eLY5qTWb17vna3onMj5TvN9hpgyNg9YPuJWtmb9/qj/JIzmyLEEdFIItHcMwkI8b
b60GEcnvDRvvgjubTdkxcvUcoMSFjQQOXexUUWWarmqRzG4v7R7BDAcrmwKefSHj
X6pZAREQi998jM3T2MwsX5Zmt+AVwVT/5VdOrDzlOztkWjvcG/LQxTA+H2IVMwyH
7/us6UJALY1+evyg87S+MP2R3Zk9HiEHLgV86AjUrK1GXtDZZWAnQ8VMRB8ZRGCX
fXoVndcRiohU+JQ/bLhRhZMQ86Iu6ArirN7QDYXpSMoYbyrZdXI=
=T6J4
-----END PGP SIGNATURE-----

--pjpvtkqjco6unxk7--
