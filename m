Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576999;
	b=wFWVkFNJUsytho08Hi7Wn0tp+AjpK2n/WiZUOiIST3D3DsVaihsK9FLcedMjpdJWOH/a
	 Bi8VN4bTHWhLrdDMMOD0G9jWWH5RQZCesOu9A8zjTA3vPHE36S7XjeKcY5KCGIazwmkfU
	 c42h+ouEja/e18G2tbGX610KbV3W1AtkbeLC+UiTnzs4HoMYVzUkCiSSlQFYIHzvGd/Kt
	 tfFgGOdreFc6CoTHJ2zBx41NYGmPGroPS1zGLKORw0SjidiUlz/gQmGnMwqoEe7fBKfwr
	 nsujmscbqKKe6yrMazP6/XvLSgumsmIQEL1XUcWPP+rcRPBKf/Y8ucS6pIUyJR0wGLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576999;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=igHr7MHuS1FMij64WTlt/9wLf6dbRU+4iLOhJw6BnC4=;
	b=xkml9zJIGxNWhJh8P969Imvjxu06AGVA3bN4il/QYHrwep/cWbmleqgPZA5OvxcT2r53
	 X+hTx6obGcjOiryOdYI7s3cNyCfQM3JsxDIOvSG5B1FmxsH32ZOcjMHPozsfX2Kmhbctu
	 DXuwlmQiG970wqjlWJWZvbkFAIoLN5tCCFkbSSI/60VjVB/sxdIKvGJehAb6cTzR7EURh
	 8qyFB6+LqNjDQ2F9KjrlBzIYDgKz3BR41xljMVnQDrbhzrC/EoQ4dOOu4BjKwAn2GE5jV
	 GWYEMfd421JnHEadeSzIqeclsYiqzBA02pIloL6uaVgeDiudGIpf8DCd9cnnIcgZSYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqZ6ZbOF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4A606A884;
	Fri, 13 Nov 2026 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqZ6ZbOF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EE91F000CD;
	Fri, 13 Nov 2026 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794576999;
	bh=igHr7MHuS1FMij64WTlt/9wLf6dbRU+4iLOhJw6BnC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IqZ6ZbOF9HnlhXXMjEM9fLIg+j9V7zmV0degp1m0Mkto5RnaAE7T9un/4LtOKnbWx
	 gIzfoK9spaR0Dtu17+kAWOZxs2XjEbeRN1Oh9zLkfAKzKFgCujO4rYJ5En2FlwAfCb
	 dXM1zBv0ISG3EoQjYWkI8cCHcX+lTM0EKczGtAzlQmuukT+KG2CcdhYuGCMyBaqysB
	 j5QupkchtzkwuZ3U7qDbecT69wT7Cxki5QoFTzhvxK1I6JPUOFbC5JKPoXj1lndKbV
	 CQYN4HnylYip9jAT8VhibSqlHeiTerrREyWP63Ay7OtPT0ZGjYVQP5zIJvZnkr4DRj
	 h9QVdMTABrG1w==
Date: Fri, 13 Nov 2026 14:36:36 +0100
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <avcR0tSX-Fcq9pPf@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <sashiko-outbox-212840@kernel.org>
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
	protocol="application/pgp-signature"; boundary="owupvyj3ozpa6obe"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-212840@kernel.org>


--owupvyj3ozpa6obe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <avcR0tSX-Fcq9pPf@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <sashiko-outbox-212840@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-212840@kernel.org>

> Date: 2026-11-13 13:20:16+0000
> From: sashiko-bot@kernel.org
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] string: strstarts() via strprefix() prevents optimizing out
>   pointer offset
> --
>=20
> commit 8cdc2e9c96584305ea94313f2618d17d8e28f303
> Author: Alejandro Colomar <alx@kernel.org>
>=20
> string: Implement strstarts() with strprefix()
>=20
> This commit changes strstarts() to call strprefix() instead of calling
> strncmp() and strlen() directly.
>=20
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 8c6a79d320474..8ca0deda61606 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -595,7 +595,7 @@ static inline const char *strprefix(const char *s, =
const char *prefix)
> >   */
> >  static inline bool strstarts(const char *str, const char *prefix)
> >  {
> > -	return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
> > +	return strprefix(str, prefix);
> >  }
>=20
> [Severity: Low]
> Can the compiler actually optimize away the s + len pointer arithmetic in
> strprefix() here?
>=20
> strprefix() returns strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL, and
> converting that result to bool requires proving that s + len is non-NULL
> whenever strncmp() returns 0.  Because the kernel builds with
> -fno-delete-null-pointer-checks and -fno-strict-overflow, the compiler
> cannot assume that a runtime pointer is non-NULL or that s + len does not
> wrap to NULL, so callers of strstarts() end up keeping str and len live
> across strncmp() and emitting the extra addition and NULL check.

Hmmm, it seems it's right; the compiler can't optimize out.  I hadn't
taken those flags into account.

Here's a test which seems to corroborate:

	alx@devuan:~/tmp$ cat strstarts.c=20
	#include <string.h>
	bool strstarts(const char *s, const char *prefix)
	{
		return strncmp(s, prefix, strlen(prefix)) =3D=3D 0;
	}
	alx@devuan:~/tmp$ cat strprefix.c=20
	#include <string.h>
	bool strstarts(const char *s, const char *prefix)
	{
		size_t len =3D strlen(prefix);
		return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
	}
	alx@devuan:~/tmp$ gcc -Wall -Wextra -O2 -fno-delete-null-pointer-checks -f=
no-strict-overflow -S strstarts.c=20
	alx@devuan:~/tmp$ gcc -Wall -Wextra -O2 -fno-delete-null-pointer-checks -f=
no-strict-overflow -S strprefix.c=20
	strprefix.c: In function =E2=80=98strstarts=E2=80=99:
	strprefix.c:5:9: warning: the comparison will always evaluate as =E2=80=98=
true=E2=80=99 for the pointer operand in =E2=80=98s + (sizetype)len=E2=80=
=99 must not be NULL [-Waddress]
	    5 |         return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
	      |         ^~~~~~
	alx@devuan:~/tmp$ diff -u strstarts.s strprefix.s
	--- strstarts.s	2026-11-13 14:33:48.478848453 +0100
	+++ strprefix.s	2026-11-13 14:33:51.802880696 +0100
	@@ -1,4 +1,4 @@
	-	.file	"strstarts.c"
	+	.file	"strprefix.c"
		.text
		.p2align 4
		.globl	strstarts
	@@ -6,24 +6,45 @@
	 strstarts:
	 .LFB0:
		.cfi_startproc
	-	pushq	%rbx
	+	pushq	%rbp
		.cfi_def_cfa_offset 16
	-	.cfi_offset 3, -16
	+	.cfi_offset 6, -16
	+	pushq	%rbx
	+	.cfi_def_cfa_offset 24
	+	.cfi_offset 3, -24
		movq	%rdi, %rbx
		movq	%rsi, %rdi
	-	subq	$16, %rsp
	-	.cfi_def_cfa_offset 32
	+	subq	$24, %rsp
	+	.cfi_def_cfa_offset 48
		movq	%rsi, 8(%rsp)
		call	strlen@PLT
		movq	8(%rsp), %rsi
		movq	%rbx, %rdi
		movq	%rax, %rdx
	+	movq	%rax, %rbp
		call	strncmp@PLT
		testl	%eax, %eax
	-	sete	%al
	-	addq	$16, %rsp
	+	jne	.L4
	+	addq	%rbp, %rbx
	+	setne	%al
	+	addq	$24, %rsp
	+	.cfi_remember_state
	+	.cfi_def_cfa_offset 24
	+	popq	%rbx
		.cfi_def_cfa_offset 16
	+	popq	%rbp
	+	.cfi_def_cfa_offset 8
	+	ret
	+	.p2align 4,,10
	+	.p2align 3
	+.L4:
	+	.cfi_restore_state
	+	addq	$24, %rsp
	+	.cfi_def_cfa_offset 24
	+	xorl	%eax, %eax
		popq	%rbx
	+	.cfi_def_cfa_offset 16
	+	popq	%rbp
		.cfi_def_cfa_offset 8
		ret
		.cfi_endproc

I'll drop patch 7/7 in v6.

>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794574496.=
git.alx@kernel.org?part=3D7

--=20
<https://www.alejandro-colomar.es>

--owupvyj3ozpa6obe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3El4ACgkQ64mZXMKQ
wqn+Cw/8DzpyfgnM+bTeENWInkEZw8uZmScqu1SNJl9bN3nH5Aa4GoyUSlmKVIkD
ZAjRaPVlp7XF/kbVyBMIQLzfwT3hVlkghLzp5JU60fac0tP9ujHzKfqu8qw+h992
5KA7umJ+mjc1OIfPVUpVRIxgqFKT+3x3stheg0jcn/ICBFRRpLvHRuJ7Cin2o7xM
oQ+fn5tIK9FiRK71lHkbEGUe36AYHAB2vK7wAm3cksQ4dfhQVaQpd9W1zyXpBqp7
OQvLZsH9Fz0BYXC3o5KGRu5ieOHzNRnmWeBvj0eRgx7LcPL58irHkIiyo2eLG3c+
AloDFR/eN8PRMCSKfxoJVUigluhrt7DpbxzT8L/Nh+CQdzmCT4/Q5tZTZpNE2MEv
QCsWteTdjIU0e2nqxUAKBJdffOPfvIYOZb+EU6z5E99tzOYncfW4YPwAZeXoS0M6
kp2Y0b8lY6fr6kPBTqY8G2VdhfLldDsSw+iOm4flF+NeATuuu6PzfV/rjMci2Ifi
GgvifIyccMhGRkIPCsnk6kIZPp/dgpTiyi9Frk1DPPJMyzGpRxQPkrbVLz0xi98O
fo/ZOErsduWY3jjR7uXckzi4a4FwggT/vaeWnsGJzFsjrDuZBsJb7v/p9vtfYkBR
ldySg5hJH+0gWYC2aMeXNcJ9bVK5pMJE5rMviHDqI8FUO5NeegM=
=A7Je
-----END PGP SIGNATURE-----

--owupvyj3ozpa6obe--
