Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631201;
	b=yMKDLOtT1x4EF6bwM0REhN3BoByBjbMyexi9X2FXuxcY4T4vwCRwzMZL58y9nikGAk5A
	 0I9a0xCSuSulSnYs3ce+EHQ4IId/mC/LLFlUU12blqhMII/fewWysykxq4ZBjmIKrYgFb
	 4uFVlib8SPWGLdflu5eMBa0Vq7Zn38+fvU4lSEl/dk5fTIQ7spzVDOGBkVF+IotpgnM7J
	 cU+9Y5KaxnM3QYaRl7IboK/DPJsTKvermSaPIMFHeeVw7fd29iv4ZCCRlk4C5eCcpLQHH
	 Y5WdC+ptPtJTF6j3x/djR491re4/QK+2N4c1WrQ/S/zMCQkwYK3DOaKfvl1ySKJgstw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631201;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=ox0pwxdrDarzSUuTrykYDi0mqqTMlUjNeiWsMcGE2yY=;
	b=pXDANHPfmO/8E9X1WyUJn0+KWQvnR8VrJr2j1W6L2lQVwEJAzu5yljDYN95Mq2qVfzzY
	 7seUnmXeOYovHvgBrM8fEWr6igicb9kxNWR/5NXit1KorLYdw5P490KNvMXEv9P1i5pTV
	 yT3yLAfpM0PPNS9rsBK2NmEPOyc+NJ+93S29XYO2KDYYSoTmybVIv4A+6Tkjn/5wpd+y0
	 LeCroJ8UCBe0NInJsi57vGfdxRuMxSKt9dZmNyX/frlrH6CdRGnhgj8BMmj6pxvX653vi
	 7R+b7AgkFd3DnDhYw6tHvLJzlmsC06nEbBPQPnlcfDPwULulGP9gSM7RAbfV7YBKqew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QsNjSv/B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16A606A31E
	for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsNjSv/B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E861F000C0;
	Wed, 25 Nov 2026 18:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631201;
	bh=ox0pwxdrDarzSUuTrykYDi0mqqTMlUjNeiWsMcGE2yY=;
	h=Date:From:To:Cc:Subject;
	b=QsNjSv/B4PAHMmSO99bXPrNw7CZuxRr+OYXMckBbwg9iHSc7u+6AzXyG8JAKSngXe
	 EPFdFiZuHks67TXpUei2j3zHNx9jrWE5obAmRo7JhC/i0s4fRiU3nKdo/DPKQK9DVX
	 n1/O9Bw1+ihnHsNUaV58DJK6gSrlzqQbY/ck09e8Dn+y433WCTAhLQNj66dVLQZhrL
	 YdXkaooRom5YMUNkSUEaOby8Q+9RZEKUPsDxOyHK3IA8hAhKJ4pYrqctnVZW34ahOD
	 Vhm5EyLYqEzHynHVo41aScVcGgqW8a3Jf48kI6Og0MwN58/z0EBsUT8rlAYCwxSnrf
	 iKygyNsH7JZ4g==
Date: Wed, 25 Nov 2026 19:26:38 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] string: Add missing const
Message-ID: <9331ce2afba1a44bb84f371581478a9ac5ee7380.1795631164.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="shkelz6cijxiqozm"
Content-Disposition: inline


--shkelz6cijxiqozm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] string: Add missing const
Message-ID: <9331ce2afba1a44bb84f371581478a9ac5ee7380.1795631164.git.alx@kernel.org>
MIME-Version: 1.0

This pointer is derived from other const pointers.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi,

This was found while changing some <linux/string.h> APIs to preserve the
const qualifier in the return type.


Have a lovely night!
Alex

 lib/tests/string_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index f84a60d4414c..2b681089c200 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -233,7 +233,7 @@ static void string_test_strnchr(struct kunit *test)
 {
 	const char *test_string =3D "abcdefghijkl";
 	const char *empty_string =3D "";
-	char *result;
+	const char *result;
 	int i, j;
=20
 	for (i =3D 0; i < strlen(test_string) + 1; i++) {
--=20
2.55.0


--shkelz6cijxiqozm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHKF4ACgkQ64mZXMKQ
wqnczA//T7uM5qITwnet3OEdmi45LA7l7LNrGkVaXTcA+ojfcvtivUnQH5udX1cj
IcE22YbxCUdu/5snXKBbP19qWEGfYuUvevZCa52SDs02SrMw0OD+LvMMN05LNH8H
pBZeLtqBxq8jhDk81iUUjapkJTpMzPU++avogiKq3ezAo0JFunDJxV+3T6uw2axX
HfWHNkmPcELhyGriN2GyXSX3Ma8pgLDxi7vKhPaGqYFImNT/5RLUr0xp/EdYL28a
byR89yotbTCviwZn7pbsREm+gfz5jeZitc49m/vUeTl/z1ak81k7YvFzELaFpAxh
pYIlPKZGFBIRbH6wdKurLAYUFSanVDgl18bHOTOHfZGu87EqhAth3YIn/l8wOmmg
5k84Og8HnsaGMFm1ZTDErXgIodPtUYkwseQlbclNn2LD4MiZfS5wPCpWLAeGdc68
/NDnTFf/UEHRvWC2iuwInZx35Gd9g2vvf8Aqo7ZYwinS41oD3ce+UYmRWAOXq2P2
9rgZ3h3cjwsO1ALHF08t3IjLMtwzhHkKkHhuDyM+Tm5bTfMEa42BtcNfmqPMAHm5
OmyQi6R9DCjjeU5JU54VxoaF3meju8wIoyq8Flb6Fh9at5ABZp1VNuY/wSV+Qxzm
QNayaION9L0pydoOqs67ErkyOfrEWQjDw15ApHVTjtcb3WWh+tU=
=Z/OH
-----END PGP SIGNATURE-----

--shkelz6cijxiqozm--
