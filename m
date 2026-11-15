Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794768380;
	b=5FB8EZR2Z31hVIe/PxMPUa4ix1UygplaWZTeg0oHcwpnCkXRqZ77DfKtQV/aorAm39pi
	 puBsKlma7JCWmZffMZi0h2zrXYzC7m66hfPU3pLVyO9qCb4UWQ+I3KqDhrsS6J4vrMS14
	 PY0efqpwV5b5P29Varjo/ceppGTod69d+lDRuYGou3IGGhDH0Lnev6uitISbs0q5GNTwC
	 Pa9tXHeZjxzOMSegXYBmEqPr1rZDRSmA35k9jqgaFTDrtxiKkPt9CnqyChBFJjAJ7hSHr
	 dmrBnL22JZPrM5DFooM/g2zrwdf16Dgvw6/eKwAGQEgq8jx7CSC0T5FP1xWELx/hBaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794768380;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VuKY4aIAQWVGGGoltsj7eaAOR0xSJXejy80v+NMlAmc=;
	b=m1mqhVp3cdtUSB7tGD1EFTUkI/XBZXZIgAraoMoXSq5xKWblOXveF+17nhpdkrfBuwwl
	 uxsH/Ig9TZllmw1FxdSv3UDI2ycRHVaPzc4zR9bK055qZRqJmjy34SRVCwwCHgF9xiWwH
	 TWlzwCtWV2rXuEA469ZAhRjiSi/b65La6ghCUCdEVivP598Qr5V7+qeh43zUYrU2GlOTv
	 48UsZxWuFlkN2x/u39iifGqZTPAfv+GmtRNFEV/cpVNRGvJR27sNo+9FIEyK8sxg0Cp6u
	 1P0wK6c2uHBruMtF0JFsE96p0zdJlOkc7L1KER8NE1qd4Vl2L6aoL951KeGt62w/fzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWxNjoAz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94807606A323
	for <linux-hardening@vger.kernel.org>; Sun, 15 Nov 2026 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWxNjoAz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D9E1F000C4;
	Sun, 15 Nov 2026 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794768380;
	bh=VuKY4aIAQWVGGGoltsj7eaAOR0xSJXejy80v+NMlAmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NWxNjoAz7Xafapc35KNwrCYf6E3JvklwlX3tXy7DXuIRiLi+11MlUEF4E5u82+J9l
	 IOvz2KwPPMoTjXIrQUnjTsnym1/FooKZmQZ59yBVcW1ZAXiv4Ld56FfSp4skl82IV/
	 fn1KFqm+kNDhecr1ntL3fjZzQ+XFdkJYkP/8N/3T3r1eqZT33Y7dkTTgn5fp30d+6g
	 8nPVrfXpnlS8bLVlDB+FBwt0LvIjfZi3jmuF4ov4BDOU0oDVeSJ9A+SqynpSjjBWe+
	 2YTlFAcU7tuJDUtjA5LFjXFeRA/ed8/rnkZdT1dkdwDwYlkXLx5JqBRL0fGhQT6Xhu
	 egAzTLFgp1FlA==
Date: Sun, 15 Nov 2026 19:46:17 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 2/4] tools/: Add streq() to nolibc/string
Message-ID: <1715e2c9c8ea289fca83dccd5802118ad8d3a2cf.1794767906.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794767906.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="vgzb6q5hnjssgi2n"
Content-Disposition: inline
In-Reply-To: <cover.1794767906.git.alx@kernel.org>


--vgzb6q5hnjssgi2n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 2/4] tools/: Add streq() to nolibc/string
Message-ID: <1715e2c9c8ea289fca83dccd5802118ad8d3a2cf.1794767906.git.alx@kernel.org>
References: <cover.1794767906.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794767906.git.alx@kernel.org>

It's more readable than strcmp(3).

This de-duplicates the existing definitions of streq().

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 tools/include/nolibc/string.h                  | 2 ++
 tools/testing/selftests/proc/proc-subset-pid.c | 5 -----
 tools/testing/selftests/proc/proc.h            | 5 -----
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 4000926f44ac..53137fb56213 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -130,6 +130,8 @@ int strcmp(const char *a, const char *b)
 	return diff;
 }
=20
+#define streq(a, b)  (strcmp(a, b) =3D=3D 0)
+
 static __attribute__((unused))
 char *strcpy(char *dst, const char *src)
 {
diff --git a/tools/testing/selftests/proc/proc-subset-pid.c b/tools/testing=
/selftests/proc/proc-subset-pid.c
index d1052bcab039..1f41fcb89f5f 100644
--- a/tools/testing/selftests/proc/proc-subset-pid.c
+++ b/tools/testing/selftests/proc/proc-subset-pid.c
@@ -32,11 +32,6 @@
 #include <unistd.h>
 #include <stdio.h>
=20
-static inline bool streq(const char *a, const char *b)
-{
-	return strcmp(a, b) =3D=3D 0;
-}
-
 static void make_private_proc(void)
 {
 	if (unshare(CLONE_NEWNS) =3D=3D -1) {
diff --git a/tools/testing/selftests/proc/proc.h b/tools/testing/selftests/=
proc/proc.h
index b7d57ea40237..85ac9d4c9cf8 100644
--- a/tools/testing/selftests/proc/proc.h
+++ b/tools/testing/selftests/proc/proc.h
@@ -19,11 +19,6 @@ static inline pid_t sys_gettid(void)
 	return syscall(SYS_gettid);
 }
=20
-static inline bool streq(const char *s1, const char *s2)
-{
-	return strcmp(s1, s2) =3D=3D 0;
-}
-
 static unsigned long long xstrtoull(const char *p, char **end)
 {
 	if (*p =3D=3D '0') {
--=20
2.55.0


--vgzb6q5hnjssgi2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr5/fkACgkQ64mZXMKQ
wqmcMRAAvhMLs2vrABcJdogy1Lnhz88v0gP6kMAiEOahbq6D+TS7ZtAleYt3BpWm
Bd+J99s+6q7efsFsaPvRyOkFC2d1xdv1uUD5vI7Y+refmzoc0ibsYrf3uqzZ890f
R5tVuOt1zGIHK0xrl7BCZ71ob4PyPhkdqfoKM5X/4cCmNeUXPpRBS9hclMaBvziw
P6NHCQMPqF1rgbxyvv7u9Ca+FoPGg4PdIDd4Mm5jYI8mYW3m+ZRVXmumb9VuAt0L
qINUczbiGvxuE69diGNTaLdP8X/S3MZAPl2a+ClAqnUJFD5J/m/QvtVpsdCk3o3h
0OhIaUevI31W8aoNREDqZqsV6/yYVIZS0foG1EEDx+9jTD6+MCC9nNS25UI2+JMS
nxlEEeoqaoFdfTNeTx9gUrqO7qVyqZBkmPA43m0HLQqmnrDh3uJq/zAfvy8cy95L
mVLgGAWtqYctuhL+IHd3I6xSi/L/JPGzGYoOadfmLoXcDz8msV3cUGEqEUO0Ghk2
/D+29r6VyKL3/DGGEZ1MYkDPeB5glfLcoddQnZbOZLfTXIrtlPriMBZlLHDhOrS1
HOyyre5TDwmdSYWuYMBlW1/JuUXHzu5+IapMsO2eXtqp3a7Q3YPNxmXuTrGDjuXI
by1cRaI7Bsn4TSHHC7tjQ8JLMBoIPb3ccr/38WpuGUPzSg+f/7A=
=mc1s
-----END PGP SIGNATURE-----

--vgzb6q5hnjssgi2n--
