Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575461;
	b=5L6XqtTanT+LrXgfSdw4DMKWj0htI0el/I1KLh2LLVg4VRFMDxicvabOBINMC/gt9G7L
	 rxOlcodCRsdRC/Y+9mQ+biEwmnmd3Bys31ChAGs1GpxSQJnbuFP/r4yx93aHA/gwdcqrb
	 AMldLDfPde/Xdps0TJraJLD3E6DSuOcWiVXtswOWEoFWjUbEkGys5fE/ZKMOGO7QK5G9S
	 VCh7wi7SBDAuiRqk2Zs/HeoLs+9lngjQZ3fDsLeN2OL7vy9lydk4yLDEAP3tEKIwV0rL4
	 2zKckskvnu8WZeV/5OEz1pQ1ACQvgYOlT1PCZ6/+XG9Le6n8eSNxiVePrPOcNWKtAnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575461;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b6S+139ov3SwFZGs8qTOFNvNY0kAh757w+fcimenVL4=;
	b=zEWXqXctGU0LtH3L1n5Bq0kRqE5KS6UzFyB4jYv7v8hYXCIROF4+xkIs9YzOlNMUWM0L
	 e9zK1sBH5+t9ZkPHaVULDaSVBWVNdxtj6IZQ8RVEa80RXblt6JkQGidLHzDrf94uR/sUV
	 QnxpbTo64nrI4XxZiQu+QSfV4ykBMtEHiDRtIjU5PtioC0TsDvzOezeRqib9o0153XNar
	 m/2BF8iGLh6yV8TExqgpDu9RjcLwkBjz6N+blLvSGdmJZTmazCRibaMGTQCeFZII+fS1q
	 IEvzW0q6EOiaNLf1ybsR9D0JbnHnOlHl6h9j1Nl7idgcnRMX8wGqf1mTdOU3PiQ/skQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+UI95Xz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390CD606A332;
	Fri, 13 Nov 2026 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+UI95Xz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2939C1F000C4;
	Fri, 13 Nov 2026 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575461;
	bh=b6S+139ov3SwFZGs8qTOFNvNY0kAh757w+fcimenVL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k+UI95XzNsCUyQDXxOa6HZKsdtejOjvVWWK0M6Ft4gKQMZsvUWHta6I+TaHdFvecr
	 Leg66p61rxdH0WYPG8l/8wIQILml3f35QsVsSjmZJMTceQ+PsVDKOJwe3y/oFK/0FO
	 FN0of7OqBdrSwpHtR5WvKmW4TtV+rFG+dwY5gxafu8CuccddWEHWBmHcf8mke7M6jV
	 PEiTUAlvfuY7L5nWyed4y09vC1laAYE88cGN2J0rfCIu8cpIGuNOuIq/HEai6txdzy
	 b53wsEVWdCaO1QNKc0i2LS3beUxCNlQfXWEZ5fs558PskZ6WNTOYGEFa+RwJ+gpot0
	 RBLZlE1zhiY3Q==
Date: Fri, 13 Nov 2026 14:10:53 +0100
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
	linux-gpio@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v5 4/7] stddef: Add const_cast()
Message-ID: <b615b5afb05e7098f18b9918ed48c28fda64d0a1.1794574496.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="yjwimyclgwre2nbp"
Content-Disposition: inline
In-Reply-To: <cover.1794574496.git.alx@kernel.org>


--yjwimyclgwre2nbp
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
	linux-gpio@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v5 4/7] stddef: Add const_cast()
Message-ID: <b615b5afb05e7098f18b9918ed48c28fda64d0a1.1794574496.git.alx@kernel.org>
References: <cover.1794574496.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794574496.git.alx@kernel.org>

This macro serves to cast const away without risking unwanted
conversions due to mistakes in the cast.

It's similar to C++'s const_cast(), but it is more restrictive: it can
only cast away 'const', and not arbitrary qualifiers.

Cc: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/stddef.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index e1851c50c89b..26c657465e60 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -194,4 +194,15 @@ enum {
 #define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)				\
 	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
=20
+/**
+ * const_cast() - At most, drop const in the left-most derivation of a poi=
nter
+ *
+ * @T: Type for the cast.
+ * @p: Pointer to be casted.
+ *
+ * Cast @p to type @T.  The macro verifies that @p is of type const @T.
+ * This avoids mistakes that change anything other than 'const' in a cast.
+ */
+#define const_cast(T, p)  _Generic(p, const T: (T) (p))
+
 #endif
--=20
2.55.0


--yjwimyclgwre2nbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3DF0ACgkQ64mZXMKQ
wqnvnhAArwpNP3ciwtR4hxR0EEOq7AWwI/8qkWRT9naO9dsngesUrVQoEtZyYVZD
xQah32z8+v8HBlrjmm34+SgVhD4XzkHH3oKPir7Zv567bIQNNidmdqwYFsWf6x5Y
WtITEzRLJBbh4z5dqx6zEiwOsU9P4rvkNx0bqtg/I3TbhX+dMBETJ5BZvKiGGvS1
19n9zd++IWH9OZHn91JbHbVKAO1HMAkfDOAWM0c69ZQlNdFERvby71Vz0Fmfy7e7
4hZ0xVDT8dyXbL1FtBf1nenA0AWUX4zsn/S3jAbgG/B8OKEzYF2vek5UQPbwteyw
zCNAfAScb4G8hobIp2MAgSE81ePBbRc2Oicab9mUQ9l3XSn5FN1SGz5Mg5VZ8yW4
qWVNaB7YoK18Vf8YTzOBw1UoZLJwdr33ghHzwglGkxIb57EsRAq5T0+K2xmZauuz
5en5FDQ/FRseHZ1vCsJC7Ne+dI5V9lAzzb8CoMJukw14v0PPuJL94FneRaZ7J88i
ImEKJrzGJFmtMQXHxaz5PqepSW4VVD+ozy5RfnHKzK4HoSosYY2zCP7rTsLSZonY
utwxRpavPowOiXAtAanHCGqhdlC1jhPxiFZUaMMqRIFBWnFR/sm0hLohnRcCLb38
fUjINOP7hBUqvZJPqQNzJ5BvHogv3rSHQX46+4CfZYVWW8AzfF8=
=JDbu
-----END PGP SIGNATURE-----

--yjwimyclgwre2nbp--
