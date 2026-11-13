Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575485;
	b=tgi2OH9oipzWq2cF8/oYjnyw6nffjGCJXMgPD/2rEnU+bN1OmZ9f8tqp93LtBjGyeEXJ
	 bE4i8vZLlB6jmf7WiEb03KsPze1VD8nCul+7K6ogABF3OXgXZ3MsLiNXXuVjZXPOrYkVl
	 WxSEvqr13UTqEjw5qZadcW4E9IN3Nx02R/H4fC0wDIY7oZOS917ZOVLsqc5tLnOH+AQQX
	 Bu0h0QLId/e0wRQWwklCa9CYLa645SFXGIHzTzq65Lbmlnt/EJe+V1Kn7NAzahDMEJtx1
	 p1qsCCCwCx1ZGow7QhQk5Bq44EkdZFQLyYEipuLMTsRDyS7OQjv+3WYA/RwKBdAm8/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575485;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qFtqGYTUNjzUMFsrvi1S0kj12LfH81X2ePo6PmzMZ8s=;
	b=DqCiClDDVM128NrZGRWE6hA5Od3cOrmPDQ8D41UlMjuoq8oq4k4mL0eFPi58imTm9oED
	 p22PTVGclRYNeqrIc/0Ta36GTcg25Nv3Ek68zB8mLQ4kGfaHcMQT3i7EOIiPW8Q+qbP4I
	 Hqve1nJYrgfT+SiCyTVQmiIxcI/xcJ/UwVutpTNUZ9Cz1/JENg3HhD8xjTYEZFErU7IZy
	 qNy771HvrWctATQw0fOSOYLW/ENWgmHeJXYhEPu2qfZFyoHEJCfnH6qspqOPO3DNizED/
	 KU3AODmSM6R2GPQhCYw38Sk8ILoUy/xQrWWjyynSCdTdw9BdENB4nzhPyRreNg2BXiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4dEznPn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D260A2622;
	Fri, 13 Nov 2026 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4dEznPn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4935A1F000CB;
	Fri, 13 Nov 2026 13:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575485;
	bh=qFtqGYTUNjzUMFsrvi1S0kj12LfH81X2ePo6PmzMZ8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J4dEznPnZVV05l9En6yqvyZDvjtEy+Q5xoLBHeTu6rXs99d3+spn7QkVa9mBt8yoK
	 SwwfyWimhp7A4uocyxYg8ByLb13Ne9Kc9uwo9vAov+jE93Py0ib7eVN7aZ+5yuqepq
	 Ew9F76GbfloXcIYf60ui0ecN4MNSqko/s6D2CAS8b84CSGYKqoOvY7iKayjN/5ArjJ
	 Bf4kbEYNs34bkb12aepNeLQ819B9/dg3KL3vC0Q76EaNfZGnf0ZNGYseWkC0XSA+5O
	 LCOlrx639rbHgTtJujt2dn3yKWUeuwOPJtSQZTZVG4YyiDXpclAmr9eUrNYGB1LaCn
	 J1RGlWwQ0aQEA==
Date: Fri, 13 Nov 2026 14:11:17 +0100
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
Subject: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="7k3j24klskngolpj"
Content-Disposition: inline
In-Reply-To: <cover.1794574496.git.alx@kernel.org>


--7k3j24klskngolpj
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
Subject: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
References: <cover.1794574496.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794574496.git.alx@kernel.org>

The compiler should be able to optimize out the unused pointer
arithmetic done at the end, so performance-wise this shouldn't change
anything.

This change de-duplicates the almost-identical implementations,
and better shows the relationship between the two functions.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b1468d3913f6..015d2c7ee6c2 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -608,7 +608,7 @@ static inline const char *strprefix(const char *s, cons=
t char *prefix)
  */
 static inline bool strstarts(const char *str, const char *prefix)
 {
-	return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
+	return strprefix(str, prefix);
 }
=20
 /**
--=20
2.55.0


--7k3j24klskngolpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3DHUACgkQ64mZXMKQ
wqnLwA//WtiQCSR9YMqBx8L2aue7x9Qj4+hXDLVCAOfRvOmsHqkxBdQ9cY2xZ6/F
MOuH0+c33PPFNENCj7SbrYKc4x3ri2/whEiBiROfYElLAHkglecYr2Z8dfEPL/hq
SWajYY8WTuthJgrEKwI+b2iGgmCMHOD+DkJkXiPfTCqUZduwlWCFAC2h2Tut7m+E
OVo811ViJnxlql6eXP4e8Xvcl3k16/3VXEygU/4YkqaImGb7eZQ/ZP+S8ApewcY5
44y9K5GgLpg0HjeoGPOqkG2gr6hZi4rR36mMKzLJI7TDOtMBz+xCHk0PlgBstypK
yzYZ7bjYfW8AH+ZpeGYc+RHsfb5s1xPgAVcpJ8lWGPcq2ZtfFRcv02AV6mN/vsit
4cfFJti2mHDkDxM3LI05PjEuBrrCRnqDF06ZldgEawPztY2GWWnuGJS3y7oq2EhR
W3Z7xDUbgvT57Ol7deOjSrpKhiJ4w4NEh100CgsolfGuM4RZCNwq9dRmRZpXebiq
+GYlzTIFpIO/pnDTGscV47S0uUtQby629SCsx5k6yKs+RFI7jPGu95ucm0aBgOAS
o4057EKqRReM32gmpi+WOPgoz7O3F4JwFC6R5kr+VKnd8EOlRbXes2EzHHcNgRVt
pr0SbVQ0dpARbz0mXxKFlgX8lvoMReU4VDtn15UATo/PUq9pY0g=
=sI0e
-----END PGP SIGNATURE-----

--7k3j24klskngolpj--
