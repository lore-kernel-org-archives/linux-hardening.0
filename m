Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794687062;
	b=jDL6NJc0PhJM/n2h3hyXLYfHPKYN4ge32hGnyteoMZfJ6+R2cFBbRT7/7odNt5e8/DM5
	 5EjK2zftMWeo/Htw6pPkTNw8SVT1/dvKtGzpox+y9oZjHEZINK4fgCJpwqUfahXNk+hwP
	 VfrgxVCJbswCWr8cKEGopkoC2siNNzyHPjlWdwA8SFajasmlRNvarB9KQ3FEAHFupmiiH
	 Ok8Q8Ut+/FI4CkD7f3ZDWdWvR7+o4dQrQKNGHjBr2/4TfPYIaqKJSNAotGzLK0421LxXl
	 3aomIwfrVSLxLpIFClwiHCtsQvMQtSNev4hscCYmj7l2yF985w+WgeI86Tp7WNL4mmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794687062;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=8l+12b6m4tjoQkXqXgXCvA2lEKsZmoFOuBWiDGcCyxw=;
	b=oXSAUKZ6wL7ai++SoLl++9g5RVxpfr4WjqoFCZmbWggoSsaQ4zEvgkHpHcUpuyT55gcf
	 bxq1bVERO6e//pRRdjFvqBRp5fgJ/JV/w2dWHdOcoGgWRnRQaEJL/McKG9VibS6aI/f/z
	 1572aaC4Ds3hy7y8KKt5O29zTOJIxmGTEf+RcflPE01IuuMV71ykIdmBD3ehzDBqBPrzL
	 u/mFnKobw8ItIt1K5M2P0AOFCJmdk0XMUOeAo33YlqAFLNVYwxF3FdWJykzJzH9IpOCcy
	 WP3qj2TgagpQ9Zk+yMtqWGz7QYVUb1pjJvFzStGqjYuVuP+qATr6/kvcy655MRZVEcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBSI6JF1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DE606A33F
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBSI6JF1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136DB1F000C5;
	Sat, 14 Nov 2026 20:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794687062;
	bh=8l+12b6m4tjoQkXqXgXCvA2lEKsZmoFOuBWiDGcCyxw=;
	h=Date:From:To:Cc:Subject;
	b=eBSI6JF1lDfzpJJDi7TK0oMXlsKjtQ7UNRLafCsJuvHgULdsOyvFqLf/kJpzwcSMw
	 r3v2KldMc24FCma3IuwM0nBwF8Hi/lEtrLfbGQ4rAGA/nfjzfzx8alb2h19HlOXlVR
	 8j3nRTRQlRwiBovwHGFQ2Rg4AEJ5dwGHqJdryE1NGQ/oqmiXy08KSYSxVbSXVa89Oj
	 K41c0pi32TJK04JoBA3tuDkISSW2zOUjzekpP22FDBGocyPXl97x47lTeGlcN5D8DH
	 PO+BZuIWTPO3bGkzyer1h0De6DB/HZohW65dP52xPkSpPGOenRWBybGswNuOyuMYUN
	 YmQDxwICtDocg==
Date: Sat, 14 Nov 2026 21:10:58 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	alx+linux-hardening@kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v1] powerpc: Fix off-by-one bug
Message-ID: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
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
	protocol="application/pgp-signature"; boundary="ys7an7pdgy32so6a"
Content-Disposition: inline


--ys7an7pdgy32so6a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	alx+linux-hardening@kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v1] powerpc: Fix off-by-one bug
Message-ID: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
MIME-Version: 1.0

=46rom the surrounding similar calls, the intention seems obvious: this
seems intended to check for a prefix.

However, I do not understand this code, so take my reading with a grain
of salt.

Fixes: a048a07d7f453 ("powerpc/64s: Add support for a store forwarding barr=
ier at kernel entry/exit")
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

I found this while looking into replacing this code with calls to
strprefix().

 arch/powerpc/kernel/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 600596cb4ffb..37999555bfe6 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -273,7 +273,7 @@ enum stf_barrier_type stf_barrier_type_get(void)
 /* This is the generic flag used by other architectures */
 static int __init handle_ssbd(char *p)
 {
-	if (!p || strncmp(p, "auto", 5) =3D=3D 0 || strncmp(p, "on", 2) =3D=3D 0 =
) {
+	if (!p || strncmp(p, "auto", 4) =3D=3D 0 || strncmp(p, "on", 2) =3D=3D 0 =
) {
 		/* Until firmware tells us, we have the barrier with auto */
 		return 0;
 	} else if (strncmp(p, "off", 3) =3D=3D 0) {
--=20
2.55.0


--ys7an7pdgy32so6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4wFIACgkQ64mZXMKQ
wqkSTQ/9Hl6YBCGT4ghLfidjZfi5Br8fuavBYgESR82RDZB/BJGlXWUoj9wcdnWN
JzQPQgDQPE0oWF1jm54rUZgrntBNDMzvuBT5l9QRJa7gf6PDw44DKeNDv1d1P6J0
TzSHek5YKoAkNWI6K9nRabXWGqwGnwwP0ICcfZSoTvV6u2KunSGVQCm6y+rN2s8I
xsZKBxq2oc204UiddF14m8WA5WrUBO4v8+Fn1fT7W43qztLwz/olTUmg9dg7qqI4
eqQLqIRMKT80H303iyeR06LrcMMvOnUUlSEI6HbK+czzGidLi6eDZxq/rRWEQuls
PAK5X563XyDWupHl8wOkFZKOqtEXRyWBkDwGUxmQIb2KY3Ac9cmq4VY+4h/AkZSS
qAo9stRufUbZGI7ysmWpkao+PoeT2mD5vkU+Mdt5EAS91J0bQGl9GW+TS/eZNgO5
GELjmQ1m4+gEDpuanoOiml/h00w85L58kpyupHF1hP4tcpyE1dJHjBtvgAmMtLaO
a3Ej4DMXZi2/IEnw4f8ppjM6Ec72qaOVIbXoiyFtChLTfYuAkwAn09Slo4Q4mKs+
Per3v/Q0HEGE13hR7E/InaXVP75qNNUIxt671RIxc+K73dus/XjFEt8PltUCjxl0
q2FN3zdKmOLUurBDxFZB+XZyJn6USwIRo0H1TlAy3XoO3/VVXZ4=
=VL6+
-----END PGP SIGNATURE-----

--ys7an7pdgy32so6a--
