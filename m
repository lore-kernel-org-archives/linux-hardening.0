Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695468;
	b=cUrhN9R/9jsAAK+ADe4capOAkF72jwIDg6FJLnO7Ckk8QrIOW9sYebLRC7qa5VHA+It7
	 mrrxYPqh4KTRK7+zNZ8KZok9QAv4Kv79yHGDPwWM7nZHzjgc0+Fvx+3CfbwZQv2qFZX8s
	 WHCqO5hz0Dn0mjvimx0Rr5jdttFMXKJNR4T8HNdhzqNLvfGsoSiUdVEhMI148uw7+oYjf
	 VWByjGqpJ8aTuy6AuZVcKXKckmo5S/MRMZ73pBLUsidBkDol0nwZ1902sENYL4vMtEbCW
	 /QTNcQyECUdd8ArUoNAYykC3m3VoTy+527ZyyA1orDk4+EhVhJ05Gp3xiDncx4KcJsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695468;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Pw2YP/3ppKrH38kAQoq3pfEZcb2Z8qyJ41eIvEnJU14=;
	b=TTnm+ELUGqLHgin6flsZXGpb1sLTu30dvRfXlz/Dd6XrGu06MM5xxTbYMDkI4t96UuMf
	 Ir+t0DzNGIUGjUCzXCjiGsSsdpQNGE3m749ixW667YoXLfL/LM6a/DuPxcV88zPnpb+6f
	 VfiHIoIoSby7/H+TbIiKPGXKW1KOZu7VM3csFGFBsE0KnZmm4E6s6Ag//JCXRaUKtEDFe
	 UXxmLS9mq7+CtPxzHj6yGbfAikz9fwOH8GsEQwBlRdxSkXbQckVDRE4S6azE/cpAWrjsu
	 cECJUY7d8whqIgd2RKCnVnQuas4P9YmUZ6/o6Z6qkt6jVDeOnLpsyvcA6C7v/VUIpjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jd68Sf05;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD26606A326;
	Thu, 26 Nov 2026 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jd68Sf05
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4851F000D2;
	Thu, 26 Nov 2026 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695468;
	bh=Pw2YP/3ppKrH38kAQoq3pfEZcb2Z8qyJ41eIvEnJU14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jd68Sf05hBtqzDcfKM9luhgMlXeMF7YLzejNDsPVbGOAj9MHHxgjd7IwGy0tyh3K7
	 MZlbF7vCrRXVp+qJSVqj9lWnhopTPR6AwE9uXxS4oKhC1Kc73Zp+VuWFD1de1wMxfq
	 rFO/kiCksqMSs8XjIyfDlGKOZT1jyHiVvwsHtgBcpLB2V16cY7jsC99C3BjZEvHUcG
	 d0vloms5XC/R/AI39YuK3ozHjsA/e3xkQvlNgwF++tx9Dh0PxWf0pJuQJgz4Q5nNtE
	 pu/c2qzd2X7ogR4kQEbTbMosGIWEsQdDhS4gCMMcjiIYzJJ5p9vj7sYClvcXIMPOBO
	 U7+9Qcw25kSDw==
Date: Thu, 26 Nov 2026 13:17:40 +0100
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
Subject: [PATCH v8 3/4] string: Document corner-case misbehavior in
 str_has_prefix() for empty prefix
Message-ID: <fb24c7a543f8ed0df365fc77261de6438f3d5a0e.1795695151.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="7prfxvdcgvrrqsep"
Content-Disposition: inline
In-Reply-To: <cover.1795695151.git.alx@kernel.org>


--7prfxvdcgvrrqsep
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
Subject: [PATCH v8 3/4] string: Document corner-case misbehavior in
 str_has_prefix() for empty prefix
Message-ID: <fb24c7a543f8ed0df365fc77261de6438f3d5a0e.1795695151.git.alx@kernel.org>
References: <cover.1795695151.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1795695151.git.alx@kernel.org>

For an empty prefix, this function returns a value that can't be
distinguished from a non-matching prefix.  This is wrong, since an empty
prefix is present in every string, and has resulted in bugs in code that
called this function without knowing this issue.  Let's document it.

Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-pr=
op-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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


--7prfxvdcgvrrqsep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsII2QACgkQ64mZXMKQ
wqlosA//Q4Z/ezWoOY4yYZ1ojLGvP+7AW7VXZvbBor2IaAvSihEEp7Jcen0e60VV
t951vFfYDhAABUHAi4U96LEQclIkpAXycHekh0nFxgEgwvEvVi9j1lK76VadYa8c
NtzGfw16MTfLjKYvoxkyUEmUN9juOJKPAmrrUjqEWxUbmQzOCCJPCR+5Ic+DFgbi
RdG/A0CDQMtHLfEwpRMzNKN+M1DxY/65O5PSGvTd/KXhCet+2Ybe7q9n7udwv9Sw
qql3ACJJq0qFLVDjvUgLK4hsY4xMzY2NraQDQiJ7ILd+lpem+S3KZQPUheuWeIv0
wl3BuVUMID46DTDS1rwOWlXkJOmHwazZgn4PevVUIHOhPZnLnfjuqeMjKnGqraQC
/s7Xr5Xoh6kiTA2tjSQniwMKWcxMB9q4jL1wEtBH+PzPmEfPVvaSqahzOPDc8mcl
6zJk8tfIHa7PSKO52cO3Z4f3mTdrhbyOgUo4Yh/YJPUZsW08IDnzRRHUX87pdL7A
ReggJnX0sAxNugfVsq+6iwFT3KWExhEs1RwIWySptEN1HbX2AAcddAY87YtqzE/w
zb1VbgWRmDqiKm9wUy721l0Oe6XM+paPv7C1Z2w5OuPPx8MyHaR49lhgJD1pL6hi
KWVfD7aEeh7sC5e3mIshDU3K0F1B7cP70RZXnV0nOxWBJuSNe1s=
=RYCv
-----END PGP SIGNATURE-----

--7prfxvdcgvrrqsep--
