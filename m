Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712434;
	b=PBzBxp//ZGr5G21zB+42gmoIb7O1q6lN4yoYpYOuEmNp7Bd0MbyD+GxSnR01vhxbHUb7
	 zdrwkVsMRrnSKo6/eTu2olKgVnARlWjTJBNryQl+iwh5kSsYViDL0Gb/u/YgnOM3lZ2G5
	 HEkYYYCAhU3KmV0YOs4ME3nl86RzR3DPpNP9g+u4WwUSGbGRMh6gkJEx/dyodMcFte8X1
	 pG/HUorg9vLa+RF4zrNA182f2dJYVVplULpbsmZ+GQJ4uixvdrF3cVNpmR5j5gBlqFjQc
	 072T09ZfXtuBvQL3lqK+FoNqAh8BTAsv34/guuMtN1Fola38b0F7Wwj8HJqOjE1zrmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZpoEys7LKvHIobqEfGUaeEUkexdg19RlyyN+9oOsNHI=;
	b=P4LzH18ricbTaLE76QVS5SkTXBrL9OuIRGnT7nd+GVRtxNTEIqsfN6mlxyKsj+rNh/xy
	 wpszYNBwRAAPLJRHBVPgHEQLVmENhULBnkOVH14tpOdZCBY2Wycp9KmU/26yTpL9GP8oC
	 4ruqtyANzS9suLB6J7WG2zfrOX7akrhhLZjcc8xe/RM5nGNTQVKUAlhU7zkTmuJP2mq/f
	 atiKcGBlo7MkVsKkJYhE6K9MOCI22UbpexqDooCyYSFVissXcR0aTS7bX1Aatv5CZqqH6
	 ox6jqkkCVxFD0iIDgd2ANB3yxZQ6JeNALLyfGx55GHXOIvDW6QlqgMk/0tuDtUF3Vdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEz2lju8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64017608508A
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEz2lju8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3DB1F00919;
	Tue,  3 Nov 2026 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712434;
	bh=ZpoEys7LKvHIobqEfGUaeEUkexdg19RlyyN+9oOsNHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GEz2lju8PHiXRODh50oazOuLQQ3/HQwYR7gWkn0qJ+zeGdhso54B0NgAfwbwBNwnw
	 0OYDW8qD9HvE4VXRvt0IyzG1efdxBgVGWt1hkCzyNgwvQKBkVTDhWKBxVbD3EEvQ3g
	 dKpBh5A/NhyJYZ0rAbKLP0YFtp1Vvx8szIHcshRXwUZUiv3tToQydUWkJcXYWxbH+4
	 JlhmmDdftmEHpKE1/zut26AUrJ4Jnv3RyCA2uayOSd9jaNC4cMuhd/kwlPWL7ti9cW
	 ZsVaCHBKsqhr4TuVf8+gYs8r9ZBhzb9p9kAJb1+IuhsneiZqySH75INmtnMWGHGAJo
	 mC1/TBi0VgYwg==
Date: Tue, 3 Nov 2026 14:27:11 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/2] args: Add DEFARG() to implement macro default
 arguments
Message-ID: <be1057524eb2d7bb378d205c3fc8074acbf124e2.1793712214.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1793712214.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="3y24ymvbymfwlvjt"
Content-Disposition: inline
In-Reply-To: <cover.1793712214.git.alx@kernel.org>


--3y24ymvbymfwlvjt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/2] args: Add DEFARG() to implement macro default
 arguments
Message-ID: <be1057524eb2d7bb378d205c3fc8074acbf124e2.1793712214.git.alx@kernel.org>
References: <cover.1793712214.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1793712214.git.alx@kernel.org>

It needs __VA_OPT__, which is a C23 feature, but it's provided by GCC
and Clang in GNU-C mode as an extension even without C23.  __VA_OPT__
was implemented in GCC 9 and Clang 6, I think, so it should be widely
available.

Here's a small example program showing how this works:

	alx@devuan:~/tmp$ cat d.c
	#define D__(x, ...)  (x)
	#define D_(x, ...)   D__(__VA_ARGS__ __VA_OPT__(,) x)
	#define D(a, b)      D_(a, b)
	D(1, 2)
	D(1, )
	D(, 2)
	D(,)
	alx@devuan:~/tmp$ gcc -E -Wall -Wextra d.c | grep '^[^#]'
	(2)
	(1)
	(2)
	()

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/args.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/args.h b/include/linux/args.h
index 0562dc51435e..5886011cf791 100644
--- a/include/linux/args.h
+++ b/include/linux/args.h
@@ -3,6 +3,11 @@
 #ifndef _LINUX_ARGS_H
 #define _LINUX_ARGS_H
=20
+/* Expand to 'arg' if non-empty, or to 'def' if 'arg' is empty.  */
+#define ___DEFARG(x, ...)   (x)
+#define __DEFARG(def, ...)  ___DEFARG(__VA_ARGS__ __VA_OPT__(,) def)
+#define DEFARG(def, arg)    __DEFARG(def, arg)
+
 /*
  * How do these macros work?
  *
--=20
2.55.0


--3y24ymvbymfwlvjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrp4S8ACgkQ64mZXMKQ
wqkBdg//dvJXzkKfJAqk85DY/hNVZSAA0EYhMv6+2IEDVjyWDT32H3dZ84mz/vHy
B34Va2JILC5/FmBry+G3NU3Pv55/JEHlnw92TDNB1LrIRY9450HYdizT+S87rCiW
2lsLcXcwh5LmG1BnRygq2F7V55JH6S/Pi1UGoJ7z+U7nymEpLdlshblzhUljWCGp
+tGOHMDyhOK4hrkiTr+UVrnjcZjQs//fLCB7mYvdyLA+WRSMT8yKnTgPDGa9WQVW
r9vYq+Q21RbsxkTbrkKyvHpqOAAXwZjoxqTOmOh3WmqJTmm6yUwiIdMPcLg/7Arg
ybrt6Utw/zzQOVkP1CPRZb87G1yrE0O6v7uDMrxWRf0vWJMsFgWWQtI2xqDHco3D
XDo3NH5OtrOCZzPBIHdC3mqHfaThJyrRUd22sPSG6yGZkL5zdnC591zPTKf3FbvM
TzTsgYT/1Aqm+FoZKyI2v8m/gCIt8QXIG4yHI9EdecjejxSmloWESSs0ewzw3aOK
p4QUTHl3Np4/WG/4IF8KleMvFEkWA80TSklMNcNQ7mXEaKWEOPchr+xMxlYiDd9t
QfFp04vE0pyT73nv9kIwSs7peewjSFr/6V7zw0UoD7lDoT3aqDsGBP+HmqVOwAzH
VtLcZ3p6RbZd1FSgb6e96/ZU4FJ88bOFpPLTxYgTPdk4mavqjWY=
=tbwR
-----END PGP SIGNATURE-----

--3y24ymvbymfwlvjt--
