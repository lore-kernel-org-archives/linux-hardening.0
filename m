Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793229568;
	b=hm5QZ7tfJX3hgB5CB634+b2qaEgJQu0wfGwZiwB/NlJeTa4sUpqW/R81d51urgJky1ft
	 zL4j5RbBZX+xiREC0KyvL6DYAslu9JHS8EW4SazOjSGXMkpz84hLGKtF/7rM+gekiFdep
	 4ohK1NH6/dWqSri5Esk2MjhMxISykyhsOdbtsjFQb0ja0Hk6c3uoqmI9VT3oNbftPGfob
	 o5vCqY3foV+oK7H0pFgyQYzmhTU8FNKIQy4PPw+xTfGsCGDyRwoAin1/yVpvyZduzzDKS
	 u8lkYGnbIFLEw7ozv+mM3DeatEICkYeJkC9jCe9WZmgaP+Mczsxh5qwDazK37I9h89w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793229568;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=5cHDxJ03lz4Rl0nWJJ3AQKbjATW0Wcd9MeuudeXwC2I=;
	b=jpxjIVnluG+Olpv9ZEuMGSK5sL5sA9gCq+APBdZ/HDtlJdVzvzKFs1+fApb7XyZI1G65
	 1hkx4fWJut5uuKhTEhWy42bMjIvAcpNoORWZXVceSW+0msnM4TMvxWLjBWZ2nJ6J7Zpk9
	 PRDtvu58Rip95kAVs/QWcSuf7WaT99HsoucjQWmt6dWACM95YqFX+9DgL7FEdcqoA4GFi
	 T8A0qat/MdeiK1jE+VBfVBZLaMs7n7iLImU6TfF6FOVFktbYI3d7tIg/sX7S8E2YYf15T
	 rHRlhLMk4fTrS6bb1tDLVAJUbnGlhcCpcPlqMP9SgVBAYJkevr7s/ZZOVprt4W4EmCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPUv4RtX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D80606A31A
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPUv4RtX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DCE1F01825;
	Wed, 28 Oct 2026 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793229567;
	bh=5cHDxJ03lz4Rl0nWJJ3AQKbjATW0Wcd9MeuudeXwC2I=;
	h=Date:From:To:Cc:Subject;
	b=bPUv4RtXbTLzRv/dVudE82uR8m+3U431AEtVV46pPt3kAryatUauNgk66DF/ZuywK
	 XTknw8dmdv7IcCLNrcnjDibY/ws8FwUDWh/ffq2thOhqBplwak1sTsL6Z7RcnTat5V
	 0SiR2HNzp5rv3IMHc2S71U3jm/MZb1z1Eskve0i6U0OF03QTN7AgygxnLFSFifI/PL
	 pGHv4aBeYxJWxEKiPo4SEH/9A3VccM6ydjmy8bbTQUVziBfopJwA30qBFzQ7zogic1
	 i+HGobGKUMZL71kbpfJbMGy315fMqfNDsOPkU31XYJjHFx9skRrYKanBlC5xjz2Hqe
	 pLwbcIsqKQfVQ==
Date: Thu, 29 Oct 2026 00:19:24 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Nathan Lynch <nathanl@linux.ibm.com>, 
	Kees Cook <keescook@chromium.org>
Subject: [RFC v1] seq_buf: Add seq_buf_create() to implement DECLARE_SEQ_BUF()
Message-ID: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="l3auz4orrhlq6fmg"
Content-Disposition: inline


--l3auz4orrhlq6fmg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Nathan Lynch <nathanl@linux.ibm.com>, 
	Kees Cook <keescook@chromium.org>
Subject: [RFC v1] seq_buf: Add seq_buf_create() to implement DECLARE_SEQ_BUF()
Message-ID: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
MIME-Version: 1.0

This implements DECLARE_SEQ_BUF() in a way that is independent of the
members of the structure.

This will allow transitioning to a different implementation of seq_buf
which uses pointers instead of sizes, on which I plan to work soon.

The compiler should be able to optimize this out and produce the same
code as before.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi Steve, Kees,

This is a patch that I could split from the rewrite using pointers, so
we can apply it earlier to reduce the later diff.

I've built a kernel with 'allmodconfig' to check that it's okay.

The reason I need this patch is that we can't calculate the end pointer
of the compound literal without passing it to a function.  If you want
me to hold this patch and send it together with the rest of the rewrite,
I can also do that, but I thought this might be useful by itself.


Have a lovely night!
Alex


 include/linux/seq_buf.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 9f2839e73f8a..facc5643c049 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -25,10 +25,7 @@ struct seq_buf {
 };
=20
 #define DECLARE_SEQ_BUF(NAME, SIZE)			\
-	struct seq_buf NAME =3D {				\
-		.buffer =3D (char[SIZE]) { 0 },		\
-		.size =3D SIZE,				\
-	}
+	struct seq_buf NAME =3D seq_buf_create((char[SIZE]){0}, SIZE)
=20
 static inline void seq_buf_clear(struct seq_buf *s)
 {
@@ -45,6 +42,15 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned int =
size)
 	seq_buf_clear(s);
 }
=20
+static inline struct seq_buf
+seq_buf_create(char *buf, unsigned int size)
+{
+	struct seq_buf  s;
+
+	seq_buf_init(&s, buf, size);
+	return s;
+}
+
 /*
  * seq_buf have a buffer that might overflow. When this happens
  * len is set to be greater than size.

Range-diff against v0:
-:  ------------ > 1:  9bda534b33f0 seq_buf: Add seq_buf_create() to implem=
ent DECLARE_SEQ_BUF()
--=20
2.55.0


--l3auz4orrhlq6fmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrigvwACgkQ64mZXMKQ
wqmPWw/8CgyFgH4NJyXHQEUKxHQxVr7YCj9jsNsbCqCKJL7ej8r6GHNl7sflMwxl
MkFw6lgDZ4AjBE9CL0euLYTj0+Bhff/Jb0/8axSOynT/xH7RZ0TXF+72evWQTyCM
wWJnRqaD9WTK/AKlJ1Ya0uYFIcSqTmJBuDhMpAuCCzcbV8zuMbAlTvciz7ENZVG+
H9ZRWKoySx228E2GS7Rtld7z41UNVVqGzrNskTxLmSZ9/Y9F8d6MWrCKjIQU6neB
ozJVag7lD6v67kgA30YWTmGJICvNVPKqWF2OIA3Rve9uUf5rUbJzDLsIvbOvP8X/
nS4PYAKomtmDGC9Dhl3nbaU78C5pXd9epYGkgXIb9FcyF2oP4p1Gk/ORidvT2ZgP
AARhRVq9Ky51ot+26QRV4uD5KkNvUHxcdbhpLxBVmfGYzu+KOgMKD5/lhc7/Mqo7
L5MVj5eFa7h+XToJ/1y6EIW2SsytZd3jvJm8K63k7F6sSa6os3RWP4uqOXQP77lN
CxZ0AxFyviPWKGScLFX8hWHb7fvriUkGjo92GZzwmTpN8w/s3FaXMfGpbOC75zvN
QzyzYBw/oO6umOWGe0e001tAYeGQ3vPU8sJpsMQnQLiKIQNffd5a+JcNp6GVNSG0
7aOZPnGIaTgufMg7FCE+G7KuapS7bLgR8YP7U5vTuFl2vtSvm7w=
=K/wX
-----END PGP SIGNATURE-----

--l3auz4orrhlq6fmg--
