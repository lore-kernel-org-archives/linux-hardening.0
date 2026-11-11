Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426947;
	b=WvhfTFNUqW52qgERszvgZkbVhaKXnFy9clT5G/prumWHxQe/rORcIfatjrrcp0WHIy8O
	 Z2B2Vk8w/09PJ1Wpcp6ECiEondwg4ezUzm9lH5CA5mUKmp/8b/ii4Pj0R3Kt2pz3uSR8l
	 lIwy99LULqTeEMWEHzOv7I/pifYvCPIDaBGaiNgQ/onARGAJY3cFKzvFSES7RMWrwHdf+
	 0OKim2ShQd4tPq1nCHa+ZT5rwpWs+tqCllul1qyTpjqDWCyWXRl1OXFW85BVgxvk+hFvr
	 LyntRY+NZxrQ1Hv5ogS23bhpOnUQMkRV0NuVLg0utstgMzC75NDS+IJXSWH2qUctyTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426947;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XaidZb7Mf5qo1jkgN91YolFfOYB9ahZXYFii9xkxxaw=;
	b=DmfEG5D1aKTjMjFwz6ShX9oQZPsNJUb0MD7/BEDdKFDKg9s1lWioLJ5FFBbuggt+HJLn
	 wcp+O4YcnZw4YOds/F5bSM1sAChqcOAJkBH7Z5cjZVlBMnuCfB1WKp5mP+3H3iN1o9ate
	 mnpW+PpSKJ5ASHJ97CEfr5JNggmhwoGLpthJmMIf1JZNhUk0a1F4FHUhhdMCn9uMYEgAS
	 YZFFKJPZ3XyqAeLbXIE28IVKmLcCyC47o26Wi3W1gbbeyFEqu0tHS8wb/z1b9Fgauiusu
	 NPb1ZICZPQ/OT8KK6X7712Tp4keD7r45aUHkB9byH2mc+flCuFdwIW5O02t3YbHGDyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H/Z5i63G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD5606A330;
	Wed, 11 Nov 2026 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/Z5i63G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803DD1F00A05;
	Wed, 11 Nov 2026 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426947;
	bh=XaidZb7Mf5qo1jkgN91YolFfOYB9ahZXYFii9xkxxaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H/Z5i63G1xGrEJlESYjYLRS1Qj8faDuBLJI042qdq+qegwFhByFa7d2OLLyYwEkLl
	 8t1q5fy/b6OMKRzS8z3P26AOBK8TdGAFW2l4stsr7DluBmc3LVObRteJH/LjCd526e
	 XoTMqPA5ovvUwfwgke9dqX6Qu6B27o9iRiUGLSbvHs+d31Rqdxm+HTe8KIKz8qR/qs
	 Ueg9syb1sSMjNj9IvZ3v2at7s7YAAmrrC+CJF8m7PSxgMSXccmhHXBMWTwwqq+STlY
	 31+EzyHBqgsExVWiHm8Dvoi0l0GxPDJUieuQicRB/MqQcbYaSxKUNZYXuYLu1afNFH
	 qlmGSlIrqH96A==
Date: Wed, 11 Nov 2026 20:55:39 +0100
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
Subject: [PATCH v4 4/6] stddef: Add const_cast()
Message-ID: <ce623fe0432ba7fe74e12171e52d2dd1f1ad2c39.1794425425.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="kmdxffwpz52mdgze"
Content-Disposition: inline
In-Reply-To: <cover.1794425425.git.alx@kernel.org>


--kmdxffwpz52mdgze
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
Subject: [PATCH v4 4/6] stddef: Add const_cast()
Message-ID: <ce623fe0432ba7fe74e12171e52d2dd1f1ad2c39.1794425425.git.alx@kernel.org>
References: <cover.1794425425.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794425425.git.alx@kernel.org>

This macro serves to cast const away without risking unwanted
conversions due to mistakes in the cast.

It's similar to C++'s const_cast(), but it is more restrictive: it can
only cast away 'const', and not arbitrary qualifiers.

David made it a bit more robust.

Link: https://lore.kernel.org/linux-hardening/20261111102535.434c2eee@pumpk=
in/
Co-developed-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/stddef.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index e1851c50c89b..5201d71db387 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -194,4 +194,16 @@ enum {
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
+ * If @p is of type const @T, then it is casted to @T.
+ * If @p is of type @T, then it is returned without any casts.
+ * This avoids mistakes that change anything other than 'const' in a cast.
+ */
+#define const_cast(T, p)  _Generic(p, const T: (T) (p), T: (p))
+
 #endif
--=20
2.55.0


--kmdxffwpz52mdgze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0yDsACgkQ64mZXMKQ
wqlEwg//VIov7tiH7p3A2S7JmvuibW4T6idCVgzoJL8GVYnqx1+g8kJwnQveQDnT
ENb/GlAC1Q5Sv5zZ1ZityU3PaUcL+oYunwqy/1aNguj7yYByksf3svmAADJhhFPV
EKuYRWxcqt/u/AMD5Iw8Eb6TWfU5hW1bx+QgEVlH6iizXR4x8OGEWPrMg3QE7b57
2GoOfg+hzP5hyw39NrDOnqVCoZghZdgIhrf2o1JEP3T/++s7NA6SamxMAv/FE81J
Ybc24VH6Z0mp8eyxxQ48fLtrmGv4fTEu68A6h/ey1/ES95lxiV0xAba+HdOy6nnl
2UrpKRrhhCXGBksvGMbCD4ol41JI5M6bhtVeMRZljq/D+tvHCqheBoxPk7hHiS+M
ob3iuA1hLJ3hGjbeN53c2Ku58AWLNrlgqBjw5ty7ev/+T6IPIp6SM+8B7V3l35nE
jzdJT5O2za2IsS67/DPeLjidt7vDTrhdS6RMaqZXD9zCbuuIlVE6q0uK+aLZ6JyI
hbKb+ODJxTEP+1pewHA8sfJ2lFPF7c+AcniV/R+AhYazvEEC+ETh9IIoeKBfjppC
+O+twuYjWpgKLvJsQnKivrrhxrX+rpXAkIf1ypx1DWzJGeWTfj0xJpKuM6xJJyhc
hnvphdgdBx/LLL9DRgVd7WRG/YXwrkiYE9n4hYBHOv6q8EdfbWU=
=+vuY
-----END PGP SIGNATURE-----

--kmdxffwpz52mdgze--
