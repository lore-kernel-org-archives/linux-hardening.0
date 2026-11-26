Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695477;
	b=li+tMUikE8IXjA00nbFyWMAcMEL/gTtu1hHjyWAUvMfZPoPMdhAJGurNYpPLlN2wiXf+
	 7//55vQAEZ1+W6jZkp+S8LIl2+tznDpsvEt0OHhW7OBTbvoGuV5r+rPaw86fwWxUW/iDR
	 d2rkVcITi2k35ZxZOy1Gy2/VqtsRycgF3ApUkfVb28qSsc/+JiCRYRwDA3OJsmyfOjl4k
	 VONojpMyrLqCUCBDNONAXrZ1+n9zYzz4jbegswfUm0q5d39ALDYVvFyIK7ypgNT8Lbc9/
	 9MohNmYBUZTQRmujyL0Zx873GYX42fMNxxCe2YwvvzX2eGjJbuS5Wi8IIzrcsezSHZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695477;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GnAg1L+ydpIyuTi1m5RI3tEoPVDFRXuqUhAIOsX8UQY=;
	b=se7JWdDDHlfFQ+okQwABacZvklvlfu/rMN/EWcxGvsFXeqGv+qvWvludrbtTh2Bh4Nzj
	 iAvlXxOM9h9vTpGmlPcCTiWl261tdNrlmopPQYuAJKYP6HX1OhhRHDYeHMX6/f4xEQQtW
	 QO3kCSR09NMjVKGfmNkaM2XTP1bQosp4H3q3rRdSUhs4+mYzsd65uMqs7vYbH0XyPkML5
	 EIkFJiIOJFhRqgWvIo3Jrbq74jMCaJY7o0H3MKB5d5j09SQma7UFxJTjK3gauX2k/EYhC
	 7/2lQblMfKordGI4a12xobA4pZrVV36DAwZXoTXQg5lBAvd/dwaFH2MotvYN4lkjDLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2wAPxYa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C7606A31E;
	Thu, 26 Nov 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2wAPxYa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DF51F000CA;
	Thu, 26 Nov 2026 12:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695477;
	bh=GnAg1L+ydpIyuTi1m5RI3tEoPVDFRXuqUhAIOsX8UQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c2wAPxYa3NMibqBlkLQJwnyQyxSjza+cRgDjyzS04FORe11CqOyF0SbP0XYR6qYB8
	 JdN5mUHxSW8+KA3EH0rmEhp/9p1aVPrjuIQq3WWAQVbhsIbNKHjmcL74IcOG9ve/Sw
	 DRgYG+7npVqBeDOoBO713j5eXBf5ZLlHvgU4/kf1yx/vaNHxFSkscFcYJ/kEarPGvY
	 LGJSgzJyZ/zKrNmdap7mmTudfeDynXwzD+ogwHRFNugZWDnB0/ba4GYeET4XQDpH7O
	 Udzy3f7duURYaZr0CQDbQJtR0rE7ks7bfbRHi8jGRVJUyKocqwxaPhQjD/ahBNxmC7
	 bm89o4ikWDcpg==
Date: Thu, 26 Nov 2026 13:17:49 +0100
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
Subject: [PATCH v8 4/4] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <5c23d229235adbd447c16d544bfc0feb27c7524b.1795695151.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1795695151.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="ktiyemgvkt6rcag7"
Content-Disposition: inline
In-Reply-To: <cover.1795695151.git.alx@kernel.org>


--ktiyemgvkt6rcag7
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
Subject: [PATCH v8 4/4] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <5c23d229235adbd447c16d544bfc0feb27c7524b.1795695151.git.alx@kernel.org>
References: <cover.1795695151.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1795695151.git.alx@kernel.org>

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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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


--ktiyemgvkt6rcag7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsII20ACgkQ64mZXMKQ
wqlScw//V+5iU8A1ZOhNKsJDwVkiBghPhzHnkD6nj9redIkRIbLW9CA3ZpSallwK
wXUAhO/tIkqcGZyzCsHod6rG9t8CJ+5UcFZhv03gGLCGIKtkNnaxqguLtDZrkFYA
LN1o+B1FPNRcF32PCaPqEvqbjzCMSM+ODlbZKjsAF7vXBhX2luQ0Y6SObApmVNGU
b1GzXw+7UFE66et5gPKtDxVEhLrGh7W85H365g0s3Uzdz0ArT6YTAG62uvZnqzJy
vOIXagFT8ZxiACzwScgMc76jwrX3jGxrzWjrXCwuAi0FyiQY4pBlMXeyJQHk713J
RlUHp9cYBggEAhhoLXOk1g1xEa+8Far0WXV3DVDnfJttgDhveeDwt7Mdx6V3+Qy7
aL6IaUxnbqnnMotCL0NYnMMM4HO5YLD3sP5kUmFFfHPQ/cPA1794FRhrHMrcKWWG
pK7hcKgjmh/6N1ddkGVPiYd7TTlQhgaf1Qi9pBsrCBkb1fUjQeeHhkol8HpDYAuS
6jC9u9hmXBKIFHwJMPhIf4bmve7q1t+NmXKlcaqcJFFjr5+cYCpd+KCYXNVB5XNe
ba4eNyC1Z6zEvrd90dKnxKnWvPMJMpjI2z2nT//hGuYjWrrKLsZP3AFeroCRiivn
0ZSeCviyIvxwmjvbGKm9LP/qd19qClsIJlZ+aLw2U0Ju7Z0njn4=
=8hnQ
-----END PGP SIGNATURE-----

--ktiyemgvkt6rcag7--
