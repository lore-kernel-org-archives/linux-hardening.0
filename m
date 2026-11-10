Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324844;
	b=WjRQLWeMwP+rngnD4A4rR4GBQuwNgn1PpXRelE6u3lLniyPdY+/R2bZUNCupJOosaNNe
	 HI8WWQ1FC8iDEGWQnJKYRsWTwQfz7C1vMMqyd+ZmzNx7aHnNz08UsgKcJ5e/hSBqpo92i
	 To4bk8/YXiLrOUj+H+Kn5ZWVZkRjTlxlU2vLU0B0jvVgD9AemWkoebe55uKgC7vZpVC8K
	 ndCGvMnNV2ekQQHK+6e+bhZi4cxkZE0abg0y9TZ7VYZ3sWk9Dvxmefw/uXOXjMekksgDF
	 gre+Y3I4+GEHdHbKLYQ59hSW230ltXgKgPqdqf+feQGeU3yzbRW//ABN4mJfvEWf1rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324844;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=suPwDnEQ4Nuqw9vmAHzmrX5geUBzqPwGK0H7vf0Futs=;
	b=xcrL5gJWeY/qodJPLAkgKQc9duuWEEN0f/c/nzGgTq2LdLPU9K7f8o1+raYlWJb7l2sN
	 P/n6n//e5niKMeNqzcf8De8ngdOehLs8HVEA+y3zZ9nZrboNH4dTBE7DKcuFaYN88/FM9
	 QSr9r+3wTzcxCi8HqH3Yg8vAQsK/W6MPfx0iiKlwpaUT3MMS6P/j6qvEadl6jK7hK/Rix
	 MKdWsALgPZK+aKfBpmxJCNZLFgTC8Knsshm/1UrWpKMTmHuDacl8EhWsy6NhT8E5O7FeS
	 5gN56otuO/nDnHl8NQzqetqLs9Inicbr0IhazHW2pJGBAqMrEztzGyiHBaVtlPuPTMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMMDR55l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F70606A33B;
	Tue, 10 Nov 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMMDR55l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BC81F008A6;
	Tue, 10 Nov 2026 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324844;
	bh=suPwDnEQ4Nuqw9vmAHzmrX5geUBzqPwGK0H7vf0Futs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GMMDR55lRHfWeXagXOdigkIRL7+nf5KxAXntF9PRcNLgt0f9VlLELaK20V8rAMfA3
	 m+8Ky4bX+D0FZT4IM9fPzhXUbSccvjptmMwKMj5IxWVR+2J3QHegPebmaTpTI/nKlS
	 o4fPFBwlKnofG07NUcr0jHr1aQnYRvWf+tiaXrBSxdyUlLVcbVKuhXqLH2XKvU6+rk
	 c8hYb2y8o6zBBzqqTruuosv1Er8tEpz37somlOdHWzjzGgI/m7p07WLyKbE15q+tsE
	 Qpa6EK/uyVWnr5xLptw9qYHvmUyDoaam2T/4/RYImfDBEvRO+mmcqwKJE6/Y90Idip
	 Sgo9lpr/XkkKA==
Date: Tue, 10 Nov 2026 16:33:56 +0100
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
Subject: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="2akalsv6evdjykkq"
Content-Disposition: inline
In-Reply-To: <cover.1794323750.git.alx@kernel.org>


--2akalsv6evdjykkq
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
Subject: [PATCH v3 5/5] string: Make strprefix() const-qualifier-generic
Message-ID: <35bf6672f84f07de3f40e8db9e7fcfd643894fec.1794323750.git.alx@kernel.org>
References: <cover.1794323750.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794323750.git.alx@kernel.org>

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 9e59f9697c9e..55ca4cb5122c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -590,7 +590,9 @@ void memcpy_and_pad(void *dest, size_t dest_len, const =
void *src, size_t count,
  * *  @s+strlen(@prefix) if @s starts with @prefix
  * *  NULL if @s does not start with @prefix
  */
-static inline char *strprefix(const char *s, const char *prefix)
+#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx))
+
+static inline char *(strprefix)(const char *s, const char *prefix)
 {
 	size_t len =3D strlen(prefix);
 	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
--=20
2.55.0


--2akalsv6evdjykkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzOWQACgkQ64mZXMKQ
wqlcyA//QPet05X7Vq71O9QY6rC2CAd9KE+ARESBD95/8CRIJyyKSmnZbemnUMk7
Q8st9ldGgylY8jP1iGRSP8dM8TwSLt/AqMQSU6PlbCqWqTXwNOSQeqP1pD836p+m
sT/uMUwL8M9MTZJGOAprbpToUg+zg3QcNQ3RfbHkLSQM80FoZi/GAp0YsVBx21h2
mhMQoZ2l1k2GAZ1Y9H1btEa9s8hMiwDrKO/Jgf1OuKmb3p1ctfTaZcd+rnVcH80M
0uLiL/0fMqWJAgiNfVLJRsKDl77unPN8kdBiLmakm4OTk+kKaooIo2J5dpHLQIj4
iC64N0eTQN2gjw3N2ZfmKcYnYvg6peoZs26ElWUfV7/6fOhDjc8ZWLtHJyD4m3Jg
BDq3a4ngDplvCJiRuvI0z67/EwF3uspXE6DUJwfQrndBVD5AMmNhjq4gU+zzTrqb
eeQOfOslcFSX8Q0as5cKK88sQrhdMfvMVoyLNSaH33li/xPI4brt5bbAUyHZY86m
wgqRQP7iUb7YYr+MA5prX8rdl892kolIgAiqiIsvpaXNW8UoUBdDE5dTm6WiBIPy
EFO8EyqL6yuiB7a4f1hgIIvarlgV+TRnc8paZRZj53EBlDXizX9yz5OBnTEG/Tek
yjwMRNfd643ozhEQJLPhy7feOnXgbTMMWiSBVUbmajUfY8v5EOA=
=s6WA
-----END PGP SIGNATURE-----

--2akalsv6evdjykkq--
