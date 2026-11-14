Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669736;
	b=J1/eo4iepbxPYIetj3QRTDmV/6RXhh52R+3rW6BzUlJWaicVihEk1M7Re+dF/3eKmtLe
	 lm7IKgwv2eQjkCP+atsmz/f7k4wKidcu9sVfXnQ5/iCvQH3IxwzdFEoyLFYxhAJ5HAW+N
	 y8YbvQn3rptNueCFIENOC6P2ZiczYL/h/4F9RwTL1JeOH8NI2kQxTArhlJZYSfyGV+YQD
	 vFiAPHgGfLUpRbsGs3iDFASBYPWipSs0k6tMi23pZvVSaKUVj7Ldhpvp/P5g5hQh0OqnP
	 Ei1SVuAS9rrMW+x6t0oHt8UFDjRGoakYH6BvRMioMnJkT7JXbx5Jekf2ka/ckFM5+sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669736;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u68vSOr4DJJ2Qc3KTfFhPqTLzRrraIt9l9O8ZTiVtOE=;
	b=H8pUBrXBBaLrJE/M/J7x8c69j7d8VrrPBEtPD8oRDRtcd0du88L3icw05wDXw08G8rnI
	 TRNT16IxxMwBBOEgmFekQVsl0dhH34DbgdsiBnlEg8SomIa9O9kVe4yn9WEkQTYjHOx1I
	 0yd5P5wn8T5bIEivWw5C0i5Ya2S+a9+KQ65E4VrFXKUHJ1CrXVTYBYmnT0qN+P1NniVl4
	 d101BkXe0T2UeEO8BFr1aJSe/sHsOribaTNRNv2wNNfR9QqyP06h999D0bD4E/dXdSmqL
	 gIvmW5AbYGH2kkZG9Xlh52yUtbhAdAi43FVplJ0ee9B++J/HhFi7tReTo3HhcZZwjSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BREmCHA9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C352606A327;
	Sat, 14 Nov 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BREmCHA9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE821F000C4;
	Sat, 14 Nov 2026 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669736;
	bh=u68vSOr4DJJ2Qc3KTfFhPqTLzRrraIt9l9O8ZTiVtOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BREmCHA9oQPH27Z7HRydudNCfbFQwITeiqKaGrgP+8kWH4m8G06ugsVr2pfvaaTz6
	 PVxXIp3VJz2OXL43M9SSdSrWjWY6ikGfJvBX+XdUUpDdFj5FCClhqmtbedSzMHud7j
	 lj5EdpwbrjaCzJDLlOOd0XZjLvmtBKc0RN11EF1mIm2Y83LKRi7LjQ5n0UQ+AJJRo4
	 JTs4ysB8KRhr9B1mTKI3WSZE4UXOnXmrYrQ+Mdb4V4Vz/Jk5r9I07eiBiNXJIPgkLc
	 o+CNNzZL0t70bjwSAInI0PAcdaQ+OpgQXmfwtpvuAnax4zMx//nSzvdXIM0qPjLj3h
	 DKfxbnSaev/cA==
Date: Sat, 14 Nov 2026 16:22:08 +0100
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
Subject: [PATCH v6 03/19] string: Document corner-case misbehavior in
 str_has_prefix() for empty prefix
Message-ID: <5648bb17b88a7bf368957329fb69312016e5faed.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="zc3jyosvxxifsx37"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--zc3jyosvxxifsx37
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
Subject: [PATCH v6 03/19] string: Document corner-case misbehavior in
 str_has_prefix() for empty prefix
Message-ID: <5648bb17b88a7bf368957329fb69312016e5faed.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

For an empty prefix, this function returns a value that can't be
distinguished from a non-matching prefix.  This is wrong, since an empty
prefix is present in every string, and has resulted in bugs in code that
called this function without knowing this issue.  Let's document it.

Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-pr=
op-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 14e825e902eb..58b8b7c02b8d 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -587,6 +587,10 @@ static inline char *strprefix(const char *s, const cha=
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


--zc3jyosvxxifsx37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fKAACgkQ64mZXMKQ
wqm0dw/7BrrB1tv1KgKeg4srL39EkZTmRrqrAQNN0wBPNGUmgdewIzJLYIAzLYaH
SjP+dcS9nmqwG94G5D0dS8ozoj3qz1KCFPxdmAp2wtOtHeNhVYkO8lcLK5xz1trF
ZVi0l5pAqEart8fOcjrjmzZYBcjAHNEyzbQqyysI2Q8vD4l+luER6soZRgypbBX5
0BdWaySVaur/2hSOX9lPtjBkuPC5DmzmSPnXDYMfunzERHBvEnDom5hYBEek9K0V
OrkZqNv6jbmxIF4zrDQxRw/LLNx/9TxroTDyoyDne2SHa50Lq2Daz9keWmt3Tbnc
uMQAXwx4CcNeDg0u38cSdKmBOl0MgdHL6yFsvLJLMQANRah2lE+2DPl4V9bCBluZ
O2l/f+GmNaHez64ziALSc8tHh/tTUkvzwQTbaHcW+nOMPLTtGztpGIbRr7HoM1TD
GDPumwipA9FnByUks0P1ljht1CrNj0ZqqySTByrwqFRavWDvCmeDe7Ve0aAsTo7G
OZhTRkDrgn0gSTLNsaTH5Mu6oOCRW6zGBy92IAM2WePVUzjokJiO3GTvKNdQiWE2
0nYAi3rB43F85l5AAvuZvSITzbZkpNNbzkPZtPBK1x7rSa8yYj7WL38gxbV/TE5U
iGUym+KIP5RJ5vjlS2Z3FS9bCS3VOFI3AYHhQN3JKTaBQApQ7+4=
=D2PJ
-----END PGP SIGNATURE-----

--zc3jyosvxxifsx37--
