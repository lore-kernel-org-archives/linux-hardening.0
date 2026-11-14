Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669809;
	b=U59Xv+bgH8TXCAFhDscdNKMTxHFiWeq0niPu3TY/ujEb69nVF2N/8jI9h7jRMNzJKzV6
	 r/uqP//LLJZTqE/uk/+al4Z8DU9xRN6wgUFzvylvP25OTAiS5KbXWNQHxPdSZlcREbZHH
	 sOYfrbwpr/3Qltxt4ruxWiQzsPrMiSNqfHeOaJDxzpPdGf3AjbRQfvhUgqPh6yaExElv+
	 8VVnkB2eEGlxmo/QzyeT1A6KpYijb4y9UqxgQ6qZQF7ZXvKDl93yDKwQK/knrb40AmDlH
	 5RkcD8vjCFuOBUNwWeDWmrDM6Aqq84fpaaUxJDtzcqI1K1TFwrtdIYYp75oFrIrlIkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669809;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eXOLW0+HGjYK0J/azmDm4dM5bDe2n+IaCBFvyjJcskI=;
	b=5jIQfC5ZEk+qCH6PzWMCCfh1owr3eQVUurS6ja29Xy9AZTMoVL1xFAepUQfhs6/f289L
	 zhA5a8SkUIX4XS/0iQAuPuh8FFrWS8thNPz3e0RMab9O44Qruf3gGhJjByS6a61+xTGu4
	 /21rKkzKoVmxFmFzsGbup6P7cqbq1r76NZpO2bkK8gayHLgBj5BQWgFMjcatY2dVj2Mnb
	 8j9N2zE1/nz/Mtz26B6nGu/4aIUznPSkeQlFKkQIz7TPmJfMFpYtU6YKLe0AOZ+nU/bwA
	 opxWQBIkx9walHPjIIpRNwOp6aiGZXkmPIIOGBTfxgwsarxX/lk5ULf/FdeR9YyBE2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W5rd//gl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E27606A32E;
	Sat, 14 Nov 2026 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5rd//gl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF401F000C5;
	Sat, 14 Nov 2026 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669808;
	bh=eXOLW0+HGjYK0J/azmDm4dM5bDe2n+IaCBFvyjJcskI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W5rd//gl3NjJVeBFbK6T9LPrhQLa220r//SXlNgCx4rUZhX1OG78eYiuySVzh8ruh
	 /nHkf5GcdKTcE+Kjd6+aVfPS0z+sX8r3TSGG6Bq4hM8ZwmS7SAnSZXyxNW1AMuk0D/
	 y70kb05s9vOI2/ruMUNN2G5pXk7qD/nrC2JYleNAIqTU6rzAxCqTqi9x6gJoV/pupI
	 8mQxTZC2P8pDxvYcQN0wTozXVi0wY9eoNtjKNHUDp6bSJTaxNaP4Z0msSeHlnIzPZE
	 Hl4UKl1W2DcHawamSObc0vRGFjYhQ5lejAN+X40+SQ5WFiL2YGEzayTRx7noj3siJl
	 wMGLsim2IeG7g==
Date: Sat, 14 Nov 2026 16:23:21 +0100
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
Subject: [PATCH v6 12/19] string: Remove strstarts()
Message-ID: <cabc673b9ac73c137ad6f7dea52f8566c5821675.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="y2obdjo25ujvfqvc"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--y2obdjo25ujvfqvc
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
Subject: [PATCH v6 12/19] string: Remove strstarts()
Message-ID: <cabc673b9ac73c137ad6f7dea52f8566c5821675.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

It's now unused, as it's been fully replaced by strprefix().

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 0a466360dbb3..6b0de932e23a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -609,7 +609,6 @@ static inline const char *strprefix(const char *s, cons=
t char *prefix)
 	return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
 }
 #define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx))
-#define strstarts(s, pfx)  strprefix(s, pfx)  // legacy alias
=20
 /**
  * str_has_prefix - Test if a string has a given prefix
--=20
2.55.0


--y2obdjo25ujvfqvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fOkACgkQ64mZXMKQ
wqkPUhAApIeDHRhxFUKTf5avR9mQNXvCnsBfRwGq/S3Le+wldyh7+Rzep2cWle14
s5EAftDqLtWBDI5kuHZilYRR1lRtm9chY8eoPL0B4l7d69i+QNVuysZmCp4WvDVt
dWtSYeoScozke5bG2g5bDiGtW+FJguwBtt4CybvSc0sibGODC34el4tGRvZOZG28
Zi1Bfk9w8DYVcga0gx0e9K4LBX2Q/afZj+3zTZ2YKRRyJS06I2JeqMJNbKzzo16p
d9kQKxcn4Tomv6eeAw1qf+GGipJc2RWLvnEpKiiq4434oBl9UWtSsvW/kLqHqy6C
kZPlQ7SlYAWpEx/cAd8Wjh1Jq46IIJGxGCw1iVaVveNvfvXxGWIlIqU0ZDJJiaVg
0MYi+2NuDwIsUdPgVMMyM3/7fIOd1h9T6MBstLI4Xckq4R3wiaQqHDW1YRPNHN+v
gPYOa+GGS9r5RcwQ5mjdC2tg3heu5tIl9cfQBAFDfXpn0h0pv9POEebxRD+d9lKT
deofjAQKaOZWJ4Mo8Cwiuua4OW1qZvAThMGGSHYX7Hy5Gn6H/JGhLUGu7gzDZzMv
cOA7TDMjJLzEX9uiw490ucMWa3SqzUvvobtGgb+QukpoBMvoy9uLqVJRDn4S+t+b
GROJ7y8vK6nCAbGML4dzvI8vM+1Z4Ri412ZBnXhI7dfwNVveDp4=
=IZjD
-----END PGP SIGNATURE-----

--y2obdjo25ujvfqvc--
