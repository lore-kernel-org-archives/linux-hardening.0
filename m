Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791711;
	b=AOaB1WL0fVJ7mOEkjunWIAIVbzHiL3BWSkl81tF+P0ciHlvnkWSVJbwjQffsRxyzhIIF
	 ST66CjZXYAxweZGDNBpEN16jAXvKj7EyhuL/O8h5RrDFTQBXdj6W3j7k8r8wYcB8fLX1g
	 PVCKXU/OZOFw6gtjVMwf31+yU1Nz1fMtCdmJyL/Ra3zyVzunD5ekc3LCvwnCAHMoS3fwI
	 J3MQIzxkgVLCFybBx8RYhykCTih3W9JJE6Dvfsnsb/yA3jkF+0fISQANiy9VuOd3whS9/
	 Oeu9XS13WAvzqKQOdnPTPJXR1pTO+KiMwdZ9gmS35C2lxQnibbv32LWOf2v0iuiSQcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791711;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=obTKOLqkDEZJYmfrFowrSlbEyKDQTJslblmInhvIYrU=;
	b=K+3qKljCFIHjEMdkxYI+AEJWSZ3Lz20+mqphAX7pftbqjlOxVTMgiijlEd5kW0bBz9vV
	 0SL1WItuvtaaQl5ph+PB52qEdapR7k9TgbNrD38AgUpGbCa2gYKIKEzEeAMvLvxdNSfii
	 vgy+4OlCaAazmeu7ZP2GBRnWIfhZPD4mLvpgMaM8tTS5nKlDZ6caKNSgMRhQOP7sKU5/D
	 gwKk2IBrr/GnEdeDaVzqIhgzCKZJG69FWs7gZJl0MitDN3/QaM1SX5Sm4f5clLq8HH7T9
	 YQj+vQqUzT4CIrCoxBJSIG7Iy+8GMF7BiPC3cB8oqLkAtzC4636YzbmNl3n7sELqBsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oAZVctUf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40406606A326;
	Wed,  4 Nov 2026 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oAZVctUf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B001F000C1;
	Wed,  4 Nov 2026 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793791711;
	bh=obTKOLqkDEZJYmfrFowrSlbEyKDQTJslblmInhvIYrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oAZVctUfAQYDYpcTT3DfbNyi5v306d8OBmGf6ULDQnY0cukQKA3ZDmlP2uNXWxAA3
	 yCT9HSBOFGG0ADKuFfXN6OuoFiff3hRWJh0WakssEzNOExKGp4UxxG48sbcfagI8hO
	 fQBE+5alMc+VJaty0EkqliFKLh8fz4oAWGhVg3F1qUZWx56F3fdq8UCL0Sq3qi1zAV
	 CYBsFUa3Q2tKGRou4yLOO+KvfLNFfzMB+g14qnPwqY8xK3i2gFb1P1aUYN7j/OtiSW
	 b00ZI8wS9WIOoOb+vxq4rUEtVGQaX8EQqJFsttC496ffYOutyqw/SR4742FA417rOk
	 /JWrAqRlvYvKQ==
Date: Wed, 4 Nov 2026 12:28:27 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <ausWlN1oWc0Utnxb@devuan>
References: <20261104033110.out.418-kees@kernel.org>
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
	protocol="application/pgp-signature"; boundary="4kqgamovhkgw6p7w"
Content-Disposition: inline
In-Reply-To: <20261104033110.out.418-kees@kernel.org>


--4kqgamovhkgw6p7w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <ausWlN1oWc0Utnxb@devuan>
References: <20261104033110.out.418-kees@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261104033110.out.418-kees@kernel.org>

Hi Kees,

> Date: 2026-11-03 19:31:13-0800
> From: Kees Cook <kees@kernel.org>
>
> When there is no room after the data for a NUL, __seq_buf_terminate()
> writes the NUL over the last byte of the buffer. An overflowed seq_buf
> has already lost data, but one that is exactly full, as seq_buf_putc(),
> seq_buf_putmem(), and seq_buf_commit() can leave it, has not: the NUL
> replaces the last byte written, and the seq_buf still does not report an
> overflow. seq_buf_str(), seq_buf_strlen(), and seq_buf_terminate() all
> go through it, so each of them can silently truncate what was written,
> and seq_buf_pop() then returns the NUL in place of the byte it replaced.
>=20
> Mark the seq_buf overflowed in that case with seq_buf_set_overflow().
> Nothing is left between "len" and "size" for it to clear there, and
> seq_buf_used() still counts the lost byte. Data that already ends in a
> NUL is left as is.
>=20
> No current caller checks for overflow after terminating a seq_buf that
> can be left exactly full, so none of them behaves differently.
>=20
> Add a test that fills a seq_buf exactly and checks that each of the
> three accessors marks it overflowed, that seq_buf_pop() then returns
> -1, and that a seq_buf with room for the NUL is not marked, and another
> that checks the same accessors on data ending in its own NUL. Update the
> existing tests that terminate an exactly full seq_buf to expect it, and
> move the length check in the seq_buf_do_printk() test after the run,
> so that the buffer still reaches seq_buf_do_printk() exactly full.
>=20
> Tests passed under qemu on ARCH=3Dx86_64 with GCC 16.2.0 and CONFIG_KASAN=
=3Dy,
> and on big-endian ARCH=3Ds390 with GCC s390x-linux-gnu 16.2.0, and the new
> tests fail with the fix reverted.
>=20
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20261016145928.16eddc9a@gandalf.local=
=2Ehome/
> Fixes: f2616c772c768 ("seq_buf: Add seq_buf_terminate() API")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v3:
>  - Reword comments: "left as is", and no "must" (Steven Rostedt)
>  - Fixes: the bug predates seq_buf_strlen(), back to the addition of
>    seq_buf_terminate() (Alejandro Colomar)

Please include:

Cc: Alejandro Colomar <alx@kernel.org>

(or perhaps a second Reported-by.)


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--4kqgamovhkgw6p7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrrFtoACgkQ64mZXMKQ
wqnaXA/+PvzG0uYoc4RLDX5FAjBokvA+YBc6R7Fu8Hp8lEXo5dYG0X60zpM7Bi/k
hDbB+ODWsKFVKSXOBpYzxaeILMjlFLDW01ADbnQmfJXkxNuhcL5rvpNvpvSnzWAj
r7SzY447DaFlvkeijj8ezXf5tyndtEvD98CYA3821gnj1A0054wLvKRdlrUendcO
XNgR8pSHDsE6SVHJTBbJH8Wlb2gj4S5Br8yRKRZBhJAcgBBgm6zewptt/5YYqR9R
/mrqYn7tzi+foLI+k9djU3KeFa+B74KytXo9Yd4ENF69o4zh2oKCvpFb8D4911q5
p9eurio+nR3n800B7KnjL2Ln1mMFbFhdL+nULRTx7CYWxcl7tsVOAk6zqaTcs4d5
okOjnWT5q7nqYEPdiWGWOwWf7afk+lOqkhF+Jb0nA+y/7hUsc624j+jJGCypYF95
VB/vHbuA5JYzgnk4Zwcup5PuATBc1gBrX6fcfpzAKi6nztw0TO+8jowOcdtp7kft
RHo4if6L9g2QJPytV2AIFfltENOdajw0Ta2YazbwuVzQTRfslsXSARCK6I090VGL
iS4Skye9/6CJ2SexE334TkAb0mehhyMQEoCPxxYgxoZf28GfQbV7+pMXB/I58eGt
1eeEvDG4MbpN4fgVSHGM0wOeibNjkacHSx42qgSyR5peAIarnRc=
=a70G
-----END PGP SIGNATURE-----

--4kqgamovhkgw6p7w--
