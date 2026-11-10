Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324820;
	b=5OTnx4m9NQD61SWXfdSVeSt8Qf2LRl3wPR7rnszJOJu1w/z74YciDWP4U2cYjVPcJKYH
	 MA1Z9Jz0nUEcbg7redxZXNmRrKkzyfKfy9rU/fgYQ+z7xwriMxka0Zq7prY32+IWkXdHx
	 hWJezJ8yF2V9ePibDnqtaP5WbK+Tr5ghPI8aIuJ2MIsNU6CQihxgVXq2nwpTtRAmcB3G+
	 KhjANC4ra+/Cwmrt3ou1DfZFeang72FHj3NWppY30lZrrYviq+1SsrVs8wBa+l+saRIk2
	 oGXfEWyiX9DFWAc1C+PHF8+WlQEK7JxvGJFOUPqxTjr+PuZ8ptNdC7tc2s0kPM9Tl7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324820;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+GLZRVyZWKnRQC2vzZ390QmxOuF1n7AlIaRi0tsMUTc=;
	b=NyAkQMV8yrRQp6TXtI8qBv41UW/6cuOqgQrkZvzaJKgeeYeWlbR1ui14QfL5/NLJ89dL
	 VZjCAe6YZiHGBUOP2vwrNIQEWlgy6iwEfVnn7853y+IzI5v/mCEzevae9lkyXkjaEopBb
	 Pjp0Z6Yas3+kFGzj4AQAKbFAFeJxaX0iMR6pgAVUcR3kaNxl88oprALK59YvfoIdX1xni
	 Zo4jxyFmeXB1F/lolvf+liIopLsJOdDC6aj1q7OlJTSi/1AR3BCbDWxkEAXjDc81o7sMc
	 QHzVpcx8qHf7COje5H2Emk7Ccn1s6QjhcDkh9lDWEiu0UAzc9PRYRshRQ8tAubzHcEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQENbBgd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F567606A325;
	Tue, 10 Nov 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQENbBgd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9901F0089F;
	Tue, 10 Nov 2026 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324819;
	bh=+GLZRVyZWKnRQC2vzZ390QmxOuF1n7AlIaRi0tsMUTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nQENbBgdJb7ViUYlNA4s049DiPrIpjplCs1Y+8ffAlAq0etYcyGh94FVZyEMeZjOb
	 zoM9v+wnZvX/24DaLQxeKrUhMuk1nuOSfWjK9VEQ7dmGXeuOv8qgOBa5M93rANZPhn
	 hTbShkxr5XBG0WVlXas7AFzZidBD2Gu3HznAoEC975VkCyZflP2Pydlgq5Dat/sz+c
	 1wUUfk0s0QRjPi9ZCkU0MXJjl+/oK72Ak2RD9UbOgDmiHpIlorFEXV7Q0tGVvIMAXl
	 3bhRo2QcL6RZaG94iBiQJQzjP4ZJ7KRgtFCepcdVAfJIqg4qbNyHivajNCAqhO1QlW
	 MnkSNrCraIElA==
Date: Tue, 10 Nov 2026 16:33:32 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alejandro Colomar <alx@kernel.org>, Andreas Schwab <schwab@linux-m68k.org>, 
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
Subject: [PATCH v3 2/5] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <eed085c85f36707846fac163bb752780824375c6.1794323750.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794323750.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="wsheglliat7su6l2"
Content-Disposition: inline
In-Reply-To: <cover.1794323750.git.alx@kernel.org>


--wsheglliat7su6l2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alejandro Colomar <alx@kernel.org>, Andreas Schwab <schwab@linux-m68k.org>, 
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
Subject: [PATCH v3 2/5] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <eed085c85f36707846fac163bb752780824375c6.1794323750.git.alx@kernel.org>
References: <cover.1794323750.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794323750.git.alx@kernel.org>

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


--wsheglliat7su6l2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzOUsACgkQ64mZXMKQ
wqkhqhAAlvZsp3GKxjGXIg/j6AvQd+j1JUV+bYzXVWi/23s9JObJO4d3bt1YfKyz
LWnQXqI+j457yScS05x0IWhxbfbdQKGzT8bD/TylaOzPw/DKGX5W4rG3SQYK+B2Q
PH9uK/wmkJc4THVLvSWH7HBfiGi/rzL8obywN/q8w6OjupK2nL0d9jwE/Nl/4UuG
FJ7Vz9VJKZek30/ayHym4LUmAoMpap2ii4pq1vLxgAR39O/cjMzGe1mY7hrYLSao
pom+Y3+69bxeZw1P6/QdrXX0RiLRSZi2pvYxPW9Vc9TyahTzolGtAzbpk3E7ZT3X
RogazVYZIM2ylJsAsk032Zx4tv4BVRNWlmlkOKl9JuIkQXPmZL1700W02d5wH1pH
bHoAKiJIigMRXEzkcBW4jGvKWVfxaleAvEb/i19M5F1VaTFW84sINtw4Wfgh5pPC
jXQ0IC7KhZ9t97exRPtPN46Awajwy2VMBR5NGrNTeoJIeyWn112kejrtPSjX1pOT
GgeyjGr8Z144aGfTz1NCoFt6b765fK4OqqnFFqtMv9uVtTAVeI+z/Sde74g1QJAx
H7soqvzUHlX005hTvBAbWRtwaqlc+Mk3mlUGHl+R5BOK2N+iAYCuBYGYAlQLCnqd
tug/Mgb15hgqqu+mv+udGzIyeqhkDm0P/8ahLn3l3VXAQB9t6v8=
=uu0v
-----END PGP SIGNATURE-----

--wsheglliat7su6l2--
