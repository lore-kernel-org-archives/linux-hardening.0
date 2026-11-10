Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324828;
	b=g71LKay1owJ4oQgP9nm09B9pYq/B2HZXp/jhLWTRM43JNWdN2xCaqNJBwS7wvdJOjzd5
	 W+6mpgxtanzTDW72VyQEfjydOnsBVLnmO5ufv2s8Cv4Rg5eaf2BRq+BRJ8+ispxa4HoxC
	 X79xDDTTq2XR8AZrkpba4exojakSoh0kt45AnjCt+cnVeNqBRnKLwK0GD5J0DEZ2YLPSj
	 JAnwvWEzSCpUatNwNC5VQgUvbVe9TbjYczTy3a5DdDytvxC25/7GszKgVC04qwXglnqOV
	 JCmiKI1Lox1Feyhmku4mzm759RohRL0CaIg9y1l3YjrLbib62q7XZ+K5ldvOuxV0+0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324828;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=g/SjKPleM9qVQQO+iskDBaMPr/z+uX0TPZsgdSwyR3w=;
	b=vJddyVMZbQOS2zOpZaQKdNCVdA0caDB1LZpX0jWawuH4ZM6LxUSMsaCbwRq0YuBSvdOv
	 RxqIkgWAc3gJSBOKLPgVoKVZxDMhJjc8G5VuE0UOR4E4qjFfoP2jRH7tL5vL6FQPoaF/2
	 IkO7fcuqUmdsF4++iKYBEltEMJBV1FG+8hTZ1et96lt/x7h11YkvrAXk3RJw4EE5lN9dV
	 7XAsLSW5m3DwoGf4CxTWnLK6V4KHZ324J5oisS6Z9ONrtRVnsc9IgSsqqYJPM0g7w0YOs
	 5qwBHCQimCwGarE9yyZyDGvHJpf5UbKE10PAEHU+oF6fBhtowdDkR3YxxyktT86+b9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iesYPJDp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C913606A330;
	Tue, 10 Nov 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iesYPJDp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F071F0089F;
	Tue, 10 Nov 2026 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324827;
	bh=g/SjKPleM9qVQQO+iskDBaMPr/z+uX0TPZsgdSwyR3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iesYPJDpDPjLVnVdiNy5DXLlxBTia/Kwz27Osob2NsVKBGheX/8B5gx6Yf2LoF+K0
	 0+zFKA51XIPot7UGZlZh/uxVy+c7sqDHL67CREW04ba5e//+ez3rnkPJBjMAOklXeD
	 t9kRgik7xwXHWudNFYktA3i7j6s0GncwMh+3JUIZoGkGBqtMldkb6JKKveM9W9+r0L
	 QNhxfvLHGR0VDXm9q+ze4qKTL35xCnWKz7J+3W53S4ucbRnp879wimNIdC1FuxqI5K
	 XjypcLiuLHsvNTl22UrfYXHhLjww8mYuIdl1OrxOL0wVB7A89HUKn/ZvArQTBwJvb2
	 wI62LDd7lBo7Q==
Date: Tue, 10 Nov 2026 16:33:40 +0100
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
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 3/5] stddef: Add const_cast()
Message-ID: <2bf5cf7baad87b5b7b7f833df390596a033fd6f6.1794323750.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="x4z5nhiegy4aftww"
Content-Disposition: inline
In-Reply-To: <cover.1794323750.git.alx@kernel.org>


--x4z5nhiegy4aftww
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
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 3/5] stddef: Add const_cast()
Message-ID: <2bf5cf7baad87b5b7b7f833df390596a033fd6f6.1794323750.git.alx@kernel.org>
References: <cover.1794323750.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794323750.git.alx@kernel.org>

This macro serves to cast const away without risking unwanted
conversions due to mistakes in the cast.

It's similar to C++'s const_cast(), but it is more restrictive: it can
only cast away 'const', and not arbitrary qualifiers.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/stddef.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index e1851c50c89b..d79a81406b78 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -194,4 +194,16 @@ enum {
 #define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)				\
 	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
=20
+/**
+ * const_cast() - Drop const in the left-most derivation of a pointer
+ *
+ * @T: Type for the cast.
+ * @p: Pointer to be casted.
+ *
+ * If @p is of type const @T, then it is casted to @T.
+ * Otherwise, @p is returned without any casts.
+ * This avoids mistakes that change anything other than 'const' in a cast.
+ */
+#define const_cast(T, p)  _Generic(p, const T: (T) (p), default: (p))
+
 #endif
--=20
2.55.0


--x4z5nhiegy4aftww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzOVQACgkQ64mZXMKQ
wqkhtRAAlHrELZUj/9qogUkPnG1xDQtdWzwKbfz+1uyKYE54u/857CGFAEB4XKWo
FMPLZI/Cm9cAj9WeBoqgNNxIDhWx+pvv1tUuot6iGkbG7mgqBBsk/ijPViAsNGn0
tBT2ao/aBkf7MZ+/Sg5QAlV2HxUYFWujrHFo2P+HkDfnFSV3RtaZkT5t/+HXK+1p
rHRDXix4+8aSKIid32Ki3Vcd0vwOf6u+heTElGiyQc79YJ8bCR/vvtPrg5IJjx8B
XVR6D+NYv3xJ5/bOivfF+nRBttumFtXFCWsy9YFiYgogO7yZoFde3Au7hj7ALvwj
BCffEQUqUgge13j4mlTGx2uEv74/0kH86FCRJxyqFqh7sFiytDy9Qvd4IEBowwxW
yk0MTMUiCa+MBg4VTejxtf1AzOX9ANzt5sHL1evrobEddQYPUP6EO4WI+0Q/XPYj
7dD429Tcn2sTTcvTQ+yofDuFpFVri7oBqbOSnjAd5NhfV4dMRVszXDGLZ1Z2I1el
kXZYKOLOQG/CHfVpd5B8KE0QQePlk5NzT8nodTlUQAPIlKDkN1w4M2Yulxt46r5X
r76wRDxSfpAktmr0mAl7UG65Y8RJvtBCmAaznfHq8S++Fhdi5VpqQuQWRMCc8IpP
yVGvH+GTRv3qyx7nonwf0ZQLXSm7v1E0ZXTTnWA+uog99TFgsyM=
=KJ8i
-----END PGP SIGNATURE-----

--x4z5nhiegy4aftww--
