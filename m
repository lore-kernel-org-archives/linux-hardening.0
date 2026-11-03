Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712438;
	b=4tSWDDaSZfMIEeqZq85snOeKUmURtjzzoveeNs3ckPUceA14ja5+THa8sM5HhPClbvHk
	 10lcyiV5uZ6Q6rK1IM7nfsDE1Vfhai9JXOyDzgvOpweWeW88kCIU7dojS9IIfDIt5kxXC
	 xmy6OWkKcvPHzi9xACCvbDVU0EooK81aiEHMO1P5ntctkTkgElOQ1k5SLYFbc9mgKa81v
	 ElliS9vw23bvp9smaPNoytfaAvhaCPzSOTFUiiDtopmwocQAUC2E4qZ94aalqrbKOtCr2
	 iKgASo6ysWy2A5gQwa5eYBM7bq5M84aUaOGlrf/xbDNXuOiruoE+emYKlJej/nMF7fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712438;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=apKhX4kG9OwOW1IQDL1yZG4qw6/s/0QEtFSoTj400P4=;
	b=owZ9h5m+T/ZZOFMU4rBzfl+YEgD9SCOCbbXEUblPDxc7Oz4u2x9rXGXdQFPIiiWLTulb
	 3SS6yj1pj66Dgj9fVQudbYarn5k3nKHLVtIosXQ38OX2oNg52V/bRoBSEbzElQNeoHqN2
	 fo+XEFHfxs/IOtCGLuMZgiFU08ppJwjy+ERw8iWqg3fKNeTIwryCjh6j17mmLj4oqLQ+o
	 zGOk8BQ0yzfBbgtw4ziE4XpAWMMrHtXJVLjsSt038TBG33RTp/nahV/ohVoOGpsizN+0j
	 1CLLHqASJzL65z+sVRtFb82W6qjQRdbhzNkU91C5kFD0Fmh42yeaZBWuqV9ccbiGd8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IygRsno4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC0606D80E
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IygRsno4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335131F00919;
	Tue,  3 Nov 2026 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712437;
	bh=apKhX4kG9OwOW1IQDL1yZG4qw6/s/0QEtFSoTj400P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IygRsno4NOHfE/iBNfzdCIZL1f7GksXNFEHtc4kTUoenDGqAhr/XDfOfJoxVADq4V
	 GetzlPEjKCPR6aGBrPdksDj6cQ5YhKIQ6CzaqYFyONb4j5+3rUc6mZFu5KqS9oj+MR
	 /GXGLZIJ7yOOTykSFhCDqe8F6ylkvx79lkFMADLZDhuHX0zQwlT2w5A7MmtvwGjjsS
	 LdbcZjzOAV/aoFSe8MrTKRsKKo2nYhTGWjhJ2GvEDyjYgQrg68jpKEAb1DyF3IFPia
	 7k3u84BqwCGHtgTF/WE3zCL407sLlZMhNWvv/uvKsMkpb/s8WIS3+DZgawg0rFunc8
	 5T8kGK0j6V64A==
Date: Tue, 3 Nov 2026 14:27:14 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 2/2] string: Simplify strscpy[_pad]()
Message-ID: <31096484d9be38ed36bfdfe8a5ff3302bd5b8266.1793712214.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="gjpmhifg5dlkzgvp"
Content-Disposition: inline
In-Reply-To: <cover.1793712214.git.alx@kernel.org>


--gjpmhifg5dlkzgvp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 2/2] string: Simplify strscpy[_pad]()
Message-ID: <31096484d9be38ed36bfdfe8a5ff3302bd5b8266.1793712214.git.alx@kernel.org>
References: <cover.1793712214.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1793712214.git.alx@kernel.org>

Remove the need for intermediate macros and COUNT_ARGS().

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/string.h | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 6cb5cdd01158..b17c7b9d8bc9 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -69,22 +69,6 @@ extern char * strcpy(char *,const char *);
 #endif
 ssize_t sized_strscpy(char *, const char *, size_t);
=20
-/*
- * The 2 argument style can only be used when dst is an array with a
- * known size.
- */
-#define __strscpy0(dst, src, ...)	\
-	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +	\
-				__must_be_cstr(dst) + __must_be_cstr(src))
-#define __strscpy1(dst, src, size)	\
-	sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
-
-#define __strscpy_pad0(dst, src, ...)	\
-	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst) +	\
-				    __must_be_cstr(dst) + __must_be_cstr(src))
-#define __strscpy_pad1(dst, src, size)	\
-	sized_strscpy_pad(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(s=
rc))
-
 /**
  * strscpy - Copy a C-string into a sized buffer
  * @dst: Where to copy the string to
@@ -108,7 +92,8 @@ ssize_t sized_strscpy(char *, const char *, size_t);
  * truncated.
  */
 #define strscpy(dst, src, ...)	\
-	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
+	sized_strscpy(dst, src, DEFARG(sizeof(dst) + __must_be_array(dst), __VA_A=
RGS__) + \
+				__must_be_cstr(dst) + __must_be_cstr(src))
=20
 #define sized_strscpy_pad(dest, src, count)	({			\
 	char *__dst =3D (dest);						\
@@ -143,7 +128,8 @@ ssize_t sized_strscpy(char *, const char *, size_t);
  * * -E2BIG if count is 0 or @src was truncated.
  */
 #define strscpy_pad(dst, src, ...)	\
-	CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
+	sized_strscpy_pad(dst, src, DEFARG(sizeof(dst) + __must_be_array(dst), __=
VA_ARGS__) + \
+				__must_be_cstr(dst) + __must_be_cstr(src))
=20
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
--=20
2.55.0


--gjpmhifg5dlkzgvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrp4TIACgkQ64mZXMKQ
wqksog//brmInBU/TqpkD8s94JRg/IypnrTiPkrw1hbIaVX8QxuPmedJPg91aQ3E
roDqlxIXNIlpTW/B5BGjz9qz0gnyxYDsoBWUj5aSlYDgboja0NiaZwRKw2jfk2hS
WoP+7/3H0PdAAKHvEMt+s8JAJ18B8ZDK+6nqrzHyk9UpnNXF0c5Pgbn295JQoFE0
ZIicc3lWxInJQbtBWJDYalVOPtDodbCV/59DrH/KNdHAbGJ4yOJXrCDNhMZFwgnE
1ao9lzJXWZtqKbKgaKSgd/bWjbr2a+oKXwFKHEvR+ULSxYZLFoJnmTExhzJuCCyE
zCp36R+ffkclGD3TwJzm2d+GCUPvOEKtCfbZkFN+JytsG6+jPsg2P++799x8f0AO
rG5upWg9IcL2pypKkwe0M7nu7uofX1hBOB+iY3wdLZ+tx/DQ+L4WZWdPOxPyD9aA
K7HFoGH9MERZlOBuKa+rowvEfoOfNYMtKD0MihzKW29Hf94J0EcSc0vQ1z2PJjxJ
LhQBCxGodvCkpuq177PzZ4YxucJx4yaoVIHJ1OleoDjcCEQQtAQJTaxuG0Wr0uzf
t/+/SqcZRLoeu/Z/WEWcN5iiBctSiOxVhlKZHeE/TFWCEfoEGg8mllgn9pgUpqDh
W1B3kETdQ6QO1RUfrY3Cwh6WFziC9Nru5lAtY6YHPzURfIwm05A=
=iiC2
-----END PGP SIGNATURE-----

--gjpmhifg5dlkzgvp--
