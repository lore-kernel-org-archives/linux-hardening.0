Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575453;
	b=y99jv00lY3qtC8u+54X3p+NdwyITqSpW4ARvTVqRPFfErmD99wo9lYrpi18TEzQ6xlkz
	 R/PjX6o5mY3yll/bAaxwNgLhq2JCBOHfOcIe1FBDZQDQNU8SiudeVknZL42/auIbMbDOD
	 Pw31woBJPg0pDsGO895D7OVi0GGOl0oKsrgcnhxoSbeoXwWPb+86p8NGP8TAIvbHeTLcc
	 F89klsWpbFmrlUJYBX9PQAVMcT9lcoe5Hr1J6Hyp7275nOvrJ7DWWZd7KF12e/U+JhLr0
	 JwYBsYQsO5f+8FiJvpPG7Jt73Jgiru4EF4IGb61GkophR6jKfaWqZXYI/xHTechxRQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575453;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=guZZLUOOWLe36XTGz7S29Ra/nU+v0i+q4JQWfs5C5zM=;
	b=HC3/5ZPIavMVT4zZOqt9k7UilC8u/V1UMAqTrfMHdBEdTdcHDcDLyuF+fwySmM5IzIp+
	 HccHmZqI1famLk+XG6a5uRWg++NPCCGvSIjsaZF77fdF83n2a3gekEMv9YuLNSBbSKtZB
	 UtsAfNrpSJ8FJxy43w1ivpy44/GANmWE151cn8Ao/KtofOwirUCKSgY5C7ua2Lq8CVQVR
	 dxQgFMsYW8fC5eTTJBvgy4RHpvkitRvhAwkL6khM+6gWrlWdSgE4aVfT18FwLFs19aeRK
	 hHPtNq/+4fHUy9mDpcQCsRZzEBIfVpFY41j/3ycjv077ZierZ+hn4g7axjBvsjRJpOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwmBr8F+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB0606A338;
	Fri, 13 Nov 2026 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwmBr8F+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4A21F000D2;
	Fri, 13 Nov 2026 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575453;
	bh=guZZLUOOWLe36XTGz7S29Ra/nU+v0i+q4JQWfs5C5zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CwmBr8F+T6p6r8rPRx/LjIv0zpIOoghFBdNJK82UY4WEvBkVc4nCEocA7e/tD98Se
	 DhCLpoOT+Rnr9HlPCkX+4axI34EzKFNBC3mz/HcIf56fA62bHfcc5jIbQYIFIRRhDo
	 hMiI5d2WL6aK8PIkGizdK0Jhkq1GLOVOS6OiPJuewQvnkV/AakkI0+giWLIqLkvc+m
	 NBpl40RjKnqHXCUfkXu3xabyMyg9JhrRUwQFaTAnjpPhHc9vzpP62vYhWE7o33qWrB
	 6l6/QBPD+PQ2cgVXkYz4sJPyNDMBKu2qUhCzHCyktJcRsV0ZZL1UJL0+rNSEd71HTX
	 xK0NNRJyqxbPw==
Date: Fri, 13 Nov 2026 14:10:45 +0100
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
Subject: [PATCH v5 3/7] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <49252e78c9b6f270a67978ea566a5987ac745119.1794574496.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="2tuvleuzoqte42jm"
Content-Disposition: inline
In-Reply-To: <cover.1794574496.git.alx@kernel.org>


--2tuvleuzoqte42jm
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
Subject: [PATCH v5 3/7] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <49252e78c9b6f270a67978ea566a5987ac745119.1794574496.git.alx@kernel.org>
References: <cover.1794574496.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794574496.git.alx@kernel.org>

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


--2tuvleuzoqte42jm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3DFUACgkQ64mZXMKQ
wqkB+w//YNYitDoH4KljcEjBLWTl5kbu4Td2omYz2XI2F4XVgeXK8dhZicz4GsW8
kI4BJ9NSe08BzG2RiII2ov9qCAN05oyJ0n2k3zrd/GcoAtso4nw/v/Ls6hlfAAHr
aAUVVQmW+KKlDmaW5L+knPyms5O6k2wCmhahWlIxrYy6gw/MOjMrL6f0YvRheVZT
7Gkxd/Wob2bu3zSOOp6oUQtYc7pEHDNB/8nnUsmoaRm09csy37dWHQhWdJHrX3OG
KQGduWoA43d5ckYZfvwlfgqtpRQysbtc39ztJpusTaLZr1jWGHEMEVABBSH6g+WP
/QRStAFJkKKHRtgu4eux0b2hngX/6kkXvVxj3F/+fYEIWbSo4Q1ZuEAyjmPEu+kF
ND+ZVzjapZVnfSmg/Jbjg3weq+wnPYfiac62I0ciIP0QbNHNW8XJagd4h7idTCdv
jcDOUxmQdrLQzPXvods98CQHZB0YI/iBFL13zld33sgUlN3qN9+JegUlP7/+0hnR
144xdoI2tNcl+IFawzxOBe2ZXNr130kY7DtkIGITy94vM/4zdlAVdf6MgwJ8vOJt
Yg4L476A2p+Nx7UxV6+IbhQktR7m7tWarzoqNJogKIPZ8uhKOPxl7miNbMf1HdoH
fXY+BDKO3QgZ0kYiZC3eev7zldWpJca16A8D0Zg03CLu+ddQZrA=
=1tez
-----END PGP SIGNATURE-----

--2tuvleuzoqte42jm--
