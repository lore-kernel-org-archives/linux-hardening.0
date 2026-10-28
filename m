Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223042;
	b=3XnWdo5M4qKv9E16z8lB2CpGoI7cmjCXp3xMYQIwm6Aa3iN67+mTdAYXPToAFyIzUHdy
	 jfQM/ApIjc8rBAscuL26fAkLJFizC90kQTLd7YyGBhrQ74L8MBIwiqLRghRvncKWcUjfG
	 4McwxuKq8PnkJChpLN4nKfGREs7d5EZYSy9H4ba/oB6T/tPvYiacWVaYe8Cs8YALTsPDN
	 rBJyAZqa7+qfCWYy/SFvkVpwjY+oqFsHe7sn/UeCpunmVuZrA11Y+0jE44Jdcw+6i9NJe
	 fgGfOUnJyKFFl77l9S4Qyob0muCY4UAtrd7/Mz747wFF4J6+TSralwxpPjMvpIWyMoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223042;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=likuKG7QmeFWlpwBU8umEI/VlUG1tN2oAPl7GXROFms=;
	b=xGOg+2V1fo9ElOj+DnTrUCO/ASNN6nwxaoCdb0VM/0CSvx8xbUuGEeAnwA8Uaw5b4Ahm
	 05ukPUh9I8gYyX/dx3ZTLaPdelRPGBPhbUZSxzcB4MvjYfaFBLLS6GI1a9jaxzwgIYN14
	 f5+47Tsgo5afWxGDruvl+VvqRM/6I1SS0n9pVigq1GRfbU+AHt6wY0ilAyuolXhuk0csx
	 23FPyOiauRCQSYqMynXevYwnpI1xzQxjis6XrdoxIJM7UJvnTz/4x9vjA9hg/2vWDwHCB
	 emUN8D67aVM/w/zOMN4q8ly8HnjhWMPkJQxygMeH/f3CCcUnQPgOe3lPL++8tAU7k1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BfTb/DjQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ADE606A31E
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfTb/DjQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B299E1F01825;
	Wed, 28 Oct 2026 21:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223041;
	bh=likuKG7QmeFWlpwBU8umEI/VlUG1tN2oAPl7GXROFms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BfTb/DjQs6ZVDD7pFpIuvacw7rxL6AnjIm1dcH/IHUbc54G9+HRcci3eS0oCaZFc2
	 heuyEO5ysza0fZod072T08DPSvjTzlCXTDKV/ioboEBpA62gI4ewuTJLQ+yhwKP5w0
	 Y9aDIn9NLC48eqyd/qCCTXkbFYAQJSJUbxlRZRtedrs64nf6dtDvb5XqoBEZXSenqs
	 eiNiQ8BNPcDiD4r52H+BC5DIHZt4G0YCb9Gdo03XUA1KZI2onrOHIYIqDjs2fO2RFQ
	 b3iK+5dy9yooyU9l+ObD2NCpFYe03tt8+F496k6Dwqkh6PGXVGtoLJdMyqUIpPjEfI
	 4DRnVoLq18b2Q==
Date: Wed, 28 Oct 2026 22:30:38 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: seq_buf_str() silent truncation (data corruption)
Message-ID: <auJmkx1p3nIrYeJ_@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
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
	protocol="application/pgp-signature"; boundary="qcdzw7qxtbbv4uhf"
Content-Disposition: inline
In-Reply-To: <auIrUV7A8eF8DCGG@devuan>


--qcdzw7qxtbbv4uhf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: seq_buf_str() silent truncation (data corruption)
Message-ID: <auJmkx1p3nIrYeJ_@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
MIME-Version: 1.0
In-Reply-To: <auIrUV7A8eF8DCGG@devuan>

Hi Steve,


I believe I've found a bug in seq_buf_str().

Consider the following code:

	char            buf[3];
	struct seq_buf  s;

	seq_buf_init(&s, buf, 3);
	seq_buf_putmem(&s, "foo", 3);  // This will return 0, I believe.

	// At this point, ->len=3D=3D3 and ->size=3D=3D3, I believe.

	seq_buf_str(&s);  // BUG

Let's see the implementation of seq_buf_str():

	$ git show v7.3:include/linux/seq_buf.h | grepc seq_buf_str
	(standard input):static inline const char *seq_buf_str(struct seq_buf *s)
	{
		if (WARN_ON(s->size =3D=3D 0))
			return "";

		if (seq_buf_buffer_left(s))
			s->buffer[s->len] =3D 0;
		else
			s->buffer[s->size - 1] =3D 0;

		return s->buffer;
	}

The first check is fine (we don't trigger the WARN_ON()).
seq_buf_buffer_left(s) will return 0 (it returns 's->size - s->len').
This means we'll execute the second branch.  That branch will result in
overwriting the third byte with a '\0', without reporting the overflow.

I believe the following should fix the bug:

	@@ -102,10 +104,12 @@ static inline const char *seq_buf_str(struct seq_buf=
 *s)
		if (WARN_ON(s->size =3D=3D 0))
			return "";
	=20
	-       if (seq_buf_buffer_left(s))
	+       if (seq_buf_buffer_left(s)) {
			s->buffer[s->len] =3D 0;
	-       else
	+       } else {
	+               seq_buf_set_overflow(s);
			s->buffer[s->size - 1] =3D 0;
	+       }
	=20
		return s->buffer;
	 }

I have not yet researched enough to sign a patch, but please let me know
what you think.  I can prepare a formal patch next week.

NOT-assisted-by: LLM
Reported-by: Alejandro Colomar <alx@kernel.org>


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--qcdzw7qxtbbv4uhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmriaXgACgkQ64mZXMKQ
wql70w//dPBNIhF6gXW6syZ2RF4/k6rjU46dB7j2LJeIqX+pcMYKUypHxPS8zP1D
r1TW4kjPXGvaqWA1hdGLN024Fj9JTeyLLvjIwqYHcrTGDxKU6nMgqgcRaIGqBY7m
MST71eWr67KJuYqTGcutaj/QbjcXLMUM7Iy39wZSmMYX3LJqrKCdr7HNe3ye7Jym
kGvChtAc589xPrlSQu/CUTBHavWz18xYOqoXVP5XIi+oWDhrJiO6Met7/zqoqnbd
vTT/0gJpHpcGJchn9AF3jocmwAYqaBK9/yEnvbbk96oiH6dOdayAU8xoX6vX7DN4
jKHculMBkD5FVCX91LIK30bQNEywJHnS84SZcfvna/hY1r1f9Rt+F+ftS0RtZgJk
xDKOhPDUSioosRMwwa/+50ooj0BhlGW6Z9lz1TwifvrO30qU6XpZf1tnEcL/cNZM
I/nwPuVZ6Vo2Ul2iyGMzkB0EnB6ClYk+D4VaK5Fk4B8/NOOtndWHXdNtYPDy89Sv
+hHyuJXQodz4drDtdJBH5R7AK/rWOhCtfLFM+TiZ1wdSq0YNkFWNrJ8RI65DgCk2
Fhr2aiocrAyqFCno908BimzrelkIydVg3UsdVzdZK/l1epkl5wrBaimV5SwOBqHq
wS3CTkcCFdDSTwM+trY0C300zL5UYUAxARMCaVWCUgPVIekMb4o=
=ZFVO
-----END PGP SIGNATURE-----

--qcdzw7qxtbbv4uhf--
