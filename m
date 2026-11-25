Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640635;
	b=vaiX2UX9sEWE9SLLloNeXX6e2lbnjF6d9JYdITa6ECH6Xlm5iIzwUTjRLL2kYPq5jhCk
	 3FJ29cgbceoUg/8U+vnu2JMAnm8pyFRovhv1ohBt/cQy8g6Rq1/R57wfjOjDpZk2O4znK
	 BnW2DWFp+tz9qgNzb6lFVaagyA1XLT4ct5UzcbfUdhNUqi/2O/TGEwXM2lwpUv3olzEKj
	 QwaBzkO+RteRgIUGtSdz59ZqrQYYlLf8hLacDguA+Oo2mXYc1QTfl4U7aXhWbUmhnJmU2
	 pERFQ93rNo6J/QrWrxVgV8JMITNIfeJKlmRWGdpgdPIdO1/Sgtxy0DM2WSOd2YIZ4DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640635;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wmijZHZGefJSPTVTzLoeenYyV4LW+jL6u1GaUmT8KdY=;
	b=yrFyR8Mq5zGeWMotJR+mx306PHmUjdyHM38kEE3YFfqhiRjxGyyYpEAziZIkSHgeEY7p
	 FCu0tWyZcQHrlk9M7pVpvHi2bgg0iKTRPWeFoaBBHkgcfL29ITM5etm1GY02Po1ce9Nds
	 JR6wv2hnQdfOlez2P7v5O923GXdb2DmgUpl2rSVeoJPQ1jvFDaka5IWVB4WOHXR7HK06r
	 dE4jADbMBFTvBhLVryJLq9pVd3oc15Eo+R2xHsLqpc2TQRL9DezmI2eZYz47DJWrt+hyu
	 HVY7DIcGqtXYp0HfCI0hszPLl7z9luHKlKUQZW9L+YOkoq3/CVVGd+0dRPpyWQmYveA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBczL63M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C6606A327;
	Wed, 25 Nov 2026 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBczL63M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5981F0089F;
	Wed, 25 Nov 2026 21:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640634;
	bh=wmijZHZGefJSPTVTzLoeenYyV4LW+jL6u1GaUmT8KdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KBczL63MDO8NaKui23qLsq+m8RKqfIEqrsYUmvcAFGNs3EDpmvkL/ohTqnKyHovEb
	 NiDodRl7+jqq0P96zGEMZAVy9U7QJdYQ0otP9W3KsxLTMtozbJYwGjghlcXsJCB6fL
	 2u2Aa5nGchqyw5yWxyKcMEyjQV9NZScpGxJ/jrTDE2S6dQZUUirbVvUf+EgSrDMtTZ
	 W4wC2s73bu3QV50GNb8hCBW322GJRVVH+loa/37hbX52mfVrFClgHTIpVzyOy35wDm
	 SzZVy2bHO8zeL9rNQdVNJOsDHHbeeP7QX0Jfd9oDYyB2mvWpFAE1PV4WPgbq3bp3tz
	 QSaHsQfxJJRyw==
Date: Wed, 25 Nov 2026 22:03:47 +0100
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
Subject: [PATCH v7 3/4] string: Document corner-case misbehavior in
 str_has_prefix() for empty prefix
Message-ID: <c4131a109098b449c67e2f9dc9a82385f6f25cda.1795639368.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="xjztcgxaxyz6bkqq"
Content-Disposition: inline
In-Reply-To: <cover.1795639368.git.alx@kernel.org>


--xjztcgxaxyz6bkqq
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
Subject: [PATCH v7 3/4] string: Document corner-case misbehavior in
 str_has_prefix() for empty prefix
Message-ID: <c4131a109098b449c67e2f9dc9a82385f6f25cda.1795639368.git.alx@kernel.org>
References: <cover.1795639368.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1795639368.git.alx@kernel.org>

For an empty prefix, this function returns a value that can't be
distinguished from a non-matching prefix.  This is wrong, since an empty
prefix is present in every string, and has resulted in bugs in code that
called this function without knowing this issue.  Let's document it.

Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-pr=
op-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index a6a1953c52e3..574eaa8ff527 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -586,6 +586,10 @@ static inline char *strprefix(const char *s, const cha=
r *prefix)
  * This is similar to strprefix(), but returns an offset instead of
  * a pointer.
  *
+ * Unlike for strprefix(), if the prefix is an empty string, the
+ * behavior is undefined.  If you need to support arbitrary prefixes,
+ * use strprefix().
+ *
  * Returns:
  * * strlen(@prefix) if @str starts with @prefix
  * * 0 if @str does not start with @prefix
--=20
2.55.0


--xjztcgxaxyz6bkqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHTTIACgkQ64mZXMKQ
wqklvA/6Ap9Ri7kcdvzfNtwbJVUthxoZSckckvrmyHLwILeHI64l3VfEmuDoue/Q
S8fqB237fLSApWwgRp9uzmaAvJH6r3enGiTQUMvWdO/J94kgkyglx+sZrHmlrKwy
jInu2V97Ow+1HPatmLpzKUDMRS/vdwBh7YE7ZiLwyi7lfNz7Y42oXiMMc7szchjh
vY5MFwwqmO4dJ/+oANML4j6DQzQhMXdd12f1FS7+pPO3lKfpJLAa+Q0xQ+BVl/v1
cs49xeiEfgdd54RAr/SsBDuPl4O6xnskBwjFwCfyr+NLY/0t63+rN0dqKe/J//0D
me99DUnrT45wHT8sMJY8RF34hRyy0rxSlELHSbNW8iaCmgHzhpF/NNSG1eGFrhaY
ofJYtsqM7Y45WPfrwOSiIDD4M72VfJwPz+MrVEp4LK7ytbCPB6HvQzjsId1LuEB1
NaObbwuzDJh32KKqccsppG0SsPJzaiIeGXW2gTO5gcavLyrTh+FbzNrRb0bwugFJ
42qK8abQ31L+U2f3+r8Ngd+V+jJH5CFqkiGLmI1ahLWlOrzFamMSD8PX/x3URQIL
SwGStE8t1Vqu8KCZ8KBXx2K30OOuWtdEL9sEgitNeTin21FytMTI7jq03xqboS++
J1JrDJTsGM/Fk4P287kbl8vGH61m/wbiI6VJp0g/CnKqtiArocY=
=yTzW
-----END PGP SIGNATURE-----

--xjztcgxaxyz6bkqq--
