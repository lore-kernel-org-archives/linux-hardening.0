Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882805;
	b=0CvUcU49aRyJv/7SUZhStETaStZkncbE4+RQHUSTOz5vdGFhK2IkT5bmS95eGtgVgMey
	 EcZFXogvCWAoY3hQIlEjYYUmx2/btag2QWzxuhDoodikgxqAyUw6aaeeGkY7sivR8X4sP
	 g1kLKn2Y3iTUj2oUgjFY0xlmV6VmO0MgA+FdMotjzKS08CjVwsZfYTy+QXOjB6TUWW0o1
	 U8PKUG0BvbxvpM7tdwtNMei5QAf4Dpur2HbXCxX6ZQbG4o/MTqyd53OEdgGw4+lux/Oxl
	 0wNhp1I7v5dWQL24RKJB758kzxx2X0iU3Gymf90+DBfrRyQ4V6jRRV93U+Cbx9VtHTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882805;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=tlCqC29pZRMjBzBT+P2pTBhh1ci6MKOQbd3RaQU0Kj0=;
	b=3rxqDnzp4s59ceDcREhmq/Cv+jdb6ULH2P0DbKeTLT+t3RA7Qwc3j6XWi1pexqdd7G8H
	 vknRWoFTX9Lb1UjcTjhsU8VHlzei5/VEHx4S9QA9+ABN/JCMWWISA1IftcDp+cbF4iw8o
	 b14vbpTftI01t1zqFgQpCdeZSDuawrG0dyWA0woHTQuRT1NEuuv6FPSJztb5zQHOovXzA
	 3GS2buPKPg2YCmdL9BEd5Zwj5sDzaYadQg2XnyGcx544eEXr+t6NEueuzTiYPTsiTMu7N
	 Vrv438e7EqlGJlkBUtZNu/uLFfJRFCrof6Br/Wtrfr7fmwO4BgDldgqfncZ17HcEqgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Isrf9WnN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4D606A33A;
	Thu,  5 Nov 2026 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Isrf9WnN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92F21F000C1;
	Thu,  5 Nov 2026 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882804;
	bh=tlCqC29pZRMjBzBT+P2pTBhh1ci6MKOQbd3RaQU0Kj0=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=Isrf9WnN4bsWUtXwUrC2rfE29DcOMsk4peOkvOOlv8rNAbVODbdltOJ+nS2UCIvVh
	 MzrUfjUEsX1uQc8Ou9gWz/9db0x4s2H2emnPub16hwCEuuCgjYSqI0KOhE06YWBefT
	 /ISd4hiqvHSDN50I23WnwZ6/jbwzDqC4Ohi30hDY8VtaCwfFeEO81nhCetbYFUkOGT
	 ymxF3eWqqvO2D42so1Axz+XvV7K7j7QroVYTk36Vucs24qnFKvgxYutdDdpo8s/CcY
	 +SHBBgj579cDJJxwgUVwfIFpySkT8zSoNQiaNURUS9q/nQC64uRpCjRvBjChSo1yny
	 1OUkWUhyIYKkw==
Date: Thu, 5 Nov 2026 13:46:37 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 2/2] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <ac9728afa0279375c640b6db0a6ca1dd3d600970.1793882260.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1793882260.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="u57eysqcc2vtxbdy"
Content-Disposition: inline
In-Reply-To: <cover.1793882260.git.alx@kernel.org>


--u57eysqcc2vtxbdy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.lore.kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 2/2] device property: Fix fwnode_name_eq() for empty node
 names
Message-ID: <ac9728afa0279375c640b6db0a6ca1dd3d600970.1793882260.git.alx@kernel.org>
References: <cover.1793882260.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1793882260.git.alx@kernel.org>

str_has_prefix() returns the prefix length on match and 0 on mismatch,
so the mistmatch case can't be told from "empty prefix matched an empty
string".

For instance: the OF root node's name as returned by
fwnode_get_name() is "" and will return 0 for any name matched against
it and since len is 0 too, fwnode_name_eq() will return true.

Let's use strprefix() instead, which also makes this function simpler.

Fixes: a9c8c738066b7 ("device property: Add fwnode_name_eq()")
Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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


--u57eysqcc2vtxbdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrseq0ACgkQ64mZXMKQ
wqk6hw//Xsdq+D+ghUWyzNo28OhMsmcV4U28pLayMFnImqbSa7akkbrj3egLxMwy
Uf9RMqq54HmKJiLNHMzBM3gjaYkyBZ84r4z77jhGkBmcesGnQxW2RTL1CfZ13b6K
mBNexlR7vRH5+UlEKaO7b+zsc8PpsA3cbjuXkpTttGTZDRmdO3SEULwNb6lPLBMU
vdGwQNNYbCtniwtEPsqX/o4h6wvBfFFRBsmw4AVOMIm/hxAx3dCFN5/rVdbfdWCa
0GT5Faqyxb5NosqE89ZySJzTbr6/ADPOwGWlVRq+6Wnq9t9/DLRRBekReCt6cZMr
AMr2yxB8CzvrVu+Y6pecdksKrHuFMgnpvvksNPO638c0axGPDnwC006tm4YjWXoK
jfqZK8dFjdl37tk4NbQdxqedBLE1AiLE/Q1VBj6miLRtffegfkWW82p9gXiud8x/
7mYV0d4q50fPKLeSywZCps9wEiwcMzGMf5/g7t89lF05A0Lbu27WTo1fUsUQ9mdX
wHIJ/N75b2Xh35cDWhuezoNlzbaTxoU5vcGZuCrZOf7LTEeCVM+sRVo8smOF8yXT
Yj1hp3mqX+3EMAsH6E0tV3IGrEhc79bsHzaen1NbMLCUQmBvQ81Cz/GioeXjNEKW
JVPTUfWCeOB5GhLnQ9HxgRMm+aWIDJXIS0BUoghlidzPL/Jsmrk=
=hZ8T
-----END PGP SIGNATURE-----

--u57eysqcc2vtxbdy--
