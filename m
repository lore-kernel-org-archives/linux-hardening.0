Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712431;
	b=lLY5kZSCO3nyQY1RHicU+0yzFHOOWF27pPeemSShIPmdEjzm6VVFOBbKhOXlTfVPw/48
	 jsNzUg9nv/kwA7Nn9P4l9yQPCV4qJ6a3iKl+1zc+3gHNJ9fJiam8/yFvRKUa2CQbg//Q9
	 gE4rkGcIVZv8NF/Juw4j5VxYTA5oAqIEqoCNYV8IMaZ0DAJ5CngnN0sve4tCjzgN6xynF
	 UPwrEnQb3j5+hA1xGZM4g7yK+CGkpmTLzP3UxhWg/FCMpytGlt1JlTm9ouZnb02UjPorN
	 5gAZegeBSAH2qYJstGDmK5MokaUrJ3OkEroOqHfniw5a+EPWMKuJocU4wPcfYL3awjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712431;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=tDNZ/z9F/s7zgYkf/IN8IpT3HLwOBUU20CqMLqmY2SY=;
	b=HdfCpK+UqZOw0t/NyAJ13M2kP1lVSo/GTop/qlOWab6DEI5YGqkUurMO1IIGTuwkqMPi
	 554kt7uvVzlPGniFBXZQsSZC6wCoGK7UZJJgzqQepO3GeSxCiKnQJFyLO5Gs//r9eP/wj
	 xAgrLglNXp8vel0Yby3MhX63Ylp7ey8u7MRCZBtKhw4QYG74NtUgCGpExTtzOjs4AaUoQ
	 b2VOMgj9WFGV9+lwTcwn9i/YVLm1L6Yr4UjOl9ujoDGUnIs8eZmHmmPcVg95rsmRq9fdp
	 0XZK/AviqBUnAbn5bfO2308fxY7U+f2Cjhp+o1CelH11z4wRT8GDaLLCJjG+zUh17dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfbIHWJz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045646083636
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfbIHWJz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0B31F00A17;
	Tue,  3 Nov 2026 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712430;
	bh=tDNZ/z9F/s7zgYkf/IN8IpT3HLwOBUU20CqMLqmY2SY=;
	h=Date:From:To:Cc:Subject;
	b=JfbIHWJzSItQJfe27GQv4Q1dcPU480d5aVVW+ql0gh/TvcXTDw+l9wb4RW+3SJUoL
	 DwwZC4FBulR8xJtjjFfOty5CzTTqp/jL7HWH1vI5KY12Cx7mCZEmbEdi6yZwQmSUxw
	 7b0zn436bKEbYznHdscVvqV/6hfpUWF2GcNqsjvWR65FnVnDVv44JSW0PzKn7eDOnH
	 8ZpoZ6cnp5zm+tl3Jvj4VVtQ2MNCcfrlXJkqwfP8mL2Ak3D25zdQsMf+9+tCR6CTnC
	 Zw6ArL24dks4Z13/AHsDk1A67Cs7AS7XH5OjMcOOP3laSdIw9MNPKMpyiZSLXGCSo6
	 D4cz23+pvmF6Q==
Date: Tue, 3 Nov 2026 14:27:08 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 0/2] Simplify implementation of strscpy()
Message-ID: <cover.1793712214.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="qt4zqqt3uhhlb3eh"
Content-Disposition: inline


--qt4zqqt3uhhlb3eh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 0/2] Simplify implementation of strscpy()
Message-ID: <cover.1793712214.git.alx@kernel.org>
MIME-Version: 1.0

Hi!

Here's a simpler implementation of the default arguments in strscpy(9).
It avoids having to build concatenated names, the ignored '...' in
__strscpy0, counting arguments, etc.  It's replaced by a quite simple
macro that takes two arguments, and picks the last non-empty one.

It requires a C23 feature, but it's supported as a GNU extension in
GNU C11 mode, and was implemented a long time ago, so it should be fine.


Have a lovely day!
Alex

Alejandro Colomar (2):
  args: Add DEFARG() to implement macro default arguments
  string: Simplify strscpy[_pad]()

 include/linux/args.h   |  5 +++++
 include/linux/string.h | 22 ++++------------------
 2 files changed, 9 insertions(+), 18 deletions(-)

Range-diff against v0:
-:  ------------ > 1:  be1057524eb2 args: Add DEFARG() to implement macro d=
efault arguments
-:  ------------ > 2:  31096484d9be string: Simplify strscpy[_pad]()
--=20
2.55.0


--qt4zqqt3uhhlb3eh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrp4SsACgkQ64mZXMKQ
wqnEihAAkRlgr1/YzGWZ4iKT7Ih+5MEK3aYJG8lVMUFzMT+1cKKJli/kHBuMbzde
0WaR6n7x9/Mg35xhOYDgYo3Fb6OT3t+1MzMw/eZRqb3ZKd65CLxuKsYIScblZYRn
OtzfI9y06TKOZN4uUCCuVeGgPK0kY9V5p96QYX4Jd4eXeW6tLNExFgaDN6Z/itWa
0sfkHeagBXOZuo8QLNLPpXNa8Cq9tgKz7nioajJAIsPe2HiQjbBqEa1hyIbVkti7
VX7Lx8c88F7Y4xYdvHsBYT5L9vNT1X1YdSeFks0k7YSWRIaxdfnZH+IvVKm5iyC8
LDHyae0n0jZmSO69WXQdxNPeA/0RTNfY0HS3vHw2+lVCPA8eyc/MXkbYOYjkjjYD
t38wvjyoQxMaIuPEpzrmO6piAvGexfOBjAZv6VSuX/Lb9fcgeW6sE/IzF4HaKNMr
u3gsRpEZR+U0xmiTdqrU0lDWdaW8iGumNEjRTCHUVfGMXtiUUhDNAC13rVC/MWY9
ybmHgR2EfJuO8xG18db2Z0qGYZItgbE78NnY4rBvftwnSJEWu92+OAb9kC/VS/ty
HBmOwAboEgTWPRsNlg8IdAYaTAq1/FxTm7B9uxnk1QdxL9+KyDKnfR87Zz2vY2hV
8ZczEDFUll1tSy+uPHJe53bUREkTSVN4gIULJULSYjp22Qs0XUo=
=G56b
-----END PGP SIGNATURE-----

--qt4zqqt3uhhlb3eh--
