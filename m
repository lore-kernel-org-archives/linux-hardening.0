Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669744;
	b=U+AAEaQnSV+fSynYVzQ1YhN+68SlEOzi5bSRo6qlD/twrKYiVLroQ3phl69GJoz4JeHQ
	 OnfMvWm7DqZ/FByg39QLznxVbayGXAfPZf86y1TGUFO7tAJuhhBytfd28QF1gO9Jnd7Bc
	 5110TsgQ3lJlyJQVpQ291o+7LXuwJDGDWF3f/T7FUUcUiI0iVq7kFeiyJd2xci426kMLv
	 hDpfPvfnCvjWCBb6OG2+1JTbS2BPxTiIpadGmxCsqFYv2TkgsUTi5+wmiePLkBSS/GcOL
	 s148DowKkZYLkmV0GfSrFyAwXuNCp0a8QyqXEVbOiTUa5mJxQwUExcnq47FFAmCIxSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669744;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7RTVeZnoQXzbrU5aWExKZbE1jrQcxoBFuEURSiW+QPc=;
	b=Xng+JSrufnXH9Sb9bd+BLJJSjDWB9qIuvh0Q3f/8tW6RatK/C+ho6L3PWjUaBdIAlLT6
	 EO9hf/k3NgStSKcHiOnGpf5CQF6gNn1Wg/+looNOapXPi9Q6HR9J355pOi2CiK9vsig6S
	 FDZR6IvzaSRHGywVBQmCh/AXnqDe6jAiL4ffVDzqpTtWte7d/gv7/tMO2NxDIYlf1OfRP
	 XP+W9qWDfO1Sv54HGaci9or9Y45F74bejhWGvcGB8aefVH+RYA6jTLvOV9kxlgGftvVV7
	 T7Tl4ny3O2MTHFd3xaDJbPFMsvALN+0LFjIdBga1Jni0NoJ9ZippxVKAIiEw2U5ps7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jksVCXwV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE915606A323;
	Sat, 14 Nov 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jksVCXwV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449B81F000C4;
	Sat, 14 Nov 2026 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669744;
	bh=7RTVeZnoQXzbrU5aWExKZbE1jrQcxoBFuEURSiW+QPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jksVCXwVycSECQPQRrvL6DiV+xbpL1efm9kh2UdTDJlP/m6F93RlSq11GpUzaDhqr
	 qizv6nkr1wa1cQg3iv2aLzEBPhmuJnJ0pOuTBJtTuhvCaXyqHgLBWET9NQxP+wI69P
	 DUhGWfnMYTreJoBsTst+DLd9IdRRptak+IjNXsxGvhd47T4wQ/dLXQ6QBff6KHDT5i
	 3lpEwh2Sbpu7XOj03nNGPPPeMZqj7as0NH6sFrZm6c961wY+GXb6E6gAe0yWxaUA3B
	 HWQjqEdwFzoZKtSysoeGuFKK0G4OUAzX73/jqsFRVugOd6pKvdbExAT8cj0yr/rwxb
	 NKvoajiuEv2mw==
Date: Sat, 14 Nov 2026 16:22:16 +0100
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
Subject: [PATCH v6 04/19] device property: Fix fwnode_name_eq() for empty
 node names
Message-ID: <7fc1321995f1aec9d7b92c6a89047cc9fb28c52a.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="wtdlqwxcwgefkbpm"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--wtdlqwxcwgefkbpm
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
Subject: [PATCH v6 04/19] device property: Fix fwnode_name_eq() for empty
 node names
Message-ID: <7fc1321995f1aec9d7b92c6a89047cc9fb28c52a.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

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


--wtdlqwxcwgefkbpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fKgACgkQ64mZXMKQ
wqkeRBAAnz5kSdyFIrsMCZm/jZiNO6Z1J760d63tT0d1t93QE0cgoSD/g03DWN/u
xTxhoTi2BIjqEaZ9tJcD0KDOHG8gz4QG+5Mh4UTKq8BeMkzL9TzIzX6xfKnhCpg6
ITOfyIn3Ib8uWchjIQiDr7qbuSsog3Kr460utB+DcLlvlKbmWKv+zAepZrwQ/4tr
q+NPZ/VlkRxJrVVmvXHglb+R4ZF3+Du2Z93zugqvD0dgI+oc2T5qcv0N3neJUqbi
pCynlsqSnLRG32S0k7EXFO5hM+e6VjyrPb/ZTJkvTHcF8w68Cqj3T87G5xU7yMIm
g6xNPmR/2HS8JG8qoY7VffnNqKWR1vYne9J3wIsCErij6vugssDoVDGk0e3Rdx8d
4jCfcR4Ekxwg4ZpnuUeWjRqlfxpLJbILA07A4fhS3cuKgBYc4vywlR2VBUpp2CVO
vF5PmhsLbbtNxQpfP7duFKnrXjJi3I2GFnzOX+xJJ2pabFAHMQQTuJnZB3mPT7tX
bv6ea9TmS60a7zARVJbTE1OnSdg8jJzscuiU5ixU48qmgdm10YkiQATxuZ4A3ydY
/Q2VnCP2oeilW83n0eLZoLtDiN05AYCgOQSRPUuWWST6UswFj0PcgjyaCzlwBBOe
vYXrJPGusmBLntbJra3o/pnRjySbFn1w+sGP4YknDG0lqkP8yfY=
=U5m0
-----END PGP SIGNATURE-----

--wtdlqwxcwgefkbpm--
