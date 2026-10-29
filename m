Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274432;
	b=4igkiBpI5vaMGqEQ9lU1wx/SM+ecJPQGJ+wuewOnPWIKVFIiRT/sMpybTUmTw3o2nsA0
	 SgxxR8cCXLyxgTbFJv3jlsA0eo7SvxgmZK/smHJm1N/tV45wQBMawVD9j5K1540+1KqkO
	 wJBWp19L1QhLTI9h9pNiT9VFlF06mWC6ZrAXe85kUNts4tUJty0HxO+VdOdiecHktjo7M
	 JJgs2hJ6bhC1QKKoe/LQ2fcPjA6aLtdlMVf2meSk8gOX7lNHMyhIb/zVbweSU+OEnKCYB
	 w3cm74/HpJCuJTpKqeK/gUWJIj+Q7M62mNmFWBlnSIQ0FnGGJwsGKhRg1oAs1yxKtxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274432;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KfNw/lmlklBZ+l9YvMzac5jotwi5TZidREpCwaf9h7w=;
	b=KIhgxqysvYcRDYvkyEr0iGye0Cl2ZvX7zKWGMen+zj7Q/1fUWYrujf+rW0sacgI1T+ff
	 CCxFcZsQNm1SIGhRv7YiMsPY+pQZzK1zkmL56+TePvRsnrsgSIKgZPuVcv3Uoxjzzcxfn
	 DtzTaDMlwRihf8YKROU+xoQhX4ZL+qye/+P2K1ZTEc/h9GHgJO7peDCpHHH/068tR1Uyl
	 i8FbVEuPPfWsWSbk/Ot+WJj7AxEedw+nC5CdqKfGsW6UTtG8KQ3I8LOm6dz3tJKahgFMe
	 AiCjFF7CVKumz4cJD3y9+yPB5r8xVMGLqOj/Djx94aYuncMmI0ezEW+GftUmMUr0z+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhaNEMLT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC6606A31C;
	Thu, 29 Oct 2026 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhaNEMLT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76FF1F01825;
	Thu, 29 Oct 2026 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793274431;
	bh=KfNw/lmlklBZ+l9YvMzac5jotwi5TZidREpCwaf9h7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QhaNEMLTZLMaGDYqEGbrSSA+5fW1E/Uu7pX4zzWmdhR/qxYB0qIHYniMuh6JUHWZL
	 JEtgEowjXFO2TGyKh5kCwpdlnWeVeWYvPpOD32AsboQpfHIqfw20YIvE6eiQrMy6T2
	 JSeNaJ/wadGewkUH7h+rWxWL/bTH1m8iL/aG1PdKVl4SZMK/9MezGq114Ay/K73Cuu
	 fQEaL7qYJcVXTMMmQTzEgIlc9rEQKUO6vCfNK/AAvdgmD6G1JxvbaubONQRxDPue+/
	 3faytAkM4ZUdVB1PT5YY9G6HiKxkpYSaXmvEPG5g5BgEt7TOSF/5LsJzT0AyQmEn3I
	 wHYFcPfK0/Lhw==
Date: Thu, 29 Oct 2026 12:47:04 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Mark a seq_buf overflowed when terminating it
 loses a byte
Message-ID: <auMwo_T_FsZp5UsB@devuan>
References: <20261029053250.i.220-kees@kernel.org>
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
	protocol="application/pgp-signature"; boundary="zuxyigp5g75cr537"
Content-Disposition: inline
In-Reply-To: <20261029053250.i.220-kees@kernel.org>


--zuxyigp5g75cr537
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Mark a seq_buf overflowed when terminating it
 loses a byte
Message-ID: <auMwo_T_FsZp5UsB@devuan>
References: <20261029053250.i.220-kees@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029053250.i.220-kees@kernel.org>

Hi Kees, Steve,

> Date: 2026-10-28 22:32:54-0700
> From: Kees Cook <kees@kernel.org>
>
> When there is no room after the data for a NUL, __seq_buf_terminate()
> writes it over the last byte of the buffer. An overflowed seq_buf has
> already lost data, but one that is exactly full, as seq_buf_putc(),
> seq_buf_putmem(), and seq_buf_commit() can leave it, has not: the NUL
> replaces the last byte written, and the seq_buf still does not report
> an overflow. seq_buf_str(), seq_buf_strlen(), and seq_buf_terminate()
> all go through it, so each of them can silently truncate what was
> written, and seq_buf_pop() then returns the NUL in place of the byte it
> replaced.
>=20
> Mark the seq_buf overflowed in that case with seq_buf_set_overflow(),
> as suggested in review. Nothing is left between "len" and "size" for it
> to clear there, and seq_buf_used() still counts the lost byte.
>=20
> No current caller checks for overflow after terminating a seq_buf that
> can be left exactly full, so none of them behaves differently.

This fix in theory solves the issue.  However, I wonder if this is maybe
too late to report the overflow.  Callers normally expect the overflow
to happen while they're performing their writes, and maybe they don't
expect the overflow to happen at this point, so they might forget to
test, and keep going with truncated data.

How about not allowing a full buffer without a NUL terminator in the
first place?  That is, we could report a _putmem or _putc operation that
writes a non-zero byte to the last element in the buffer as being
overflowed.

This would waste one byte, but would prevent users from having to expect
a possible overflow when reading a buffer.


Have a lovely day!
Alex

>=20
> Add a test that fills a seq_buf exactly and checks that each of the
> three accessors marks it overflowed, that seq_buf_pop() then returns
> -1, and that a seq_buf with room for the NUL is not marked. Update the
> existing tests that terminate an exactly full seq_buf to expect it, and
> move the length check in the seq_buf_do_printk() test after the run,
> so that the buffer still reaches seq_buf_do_printk() exactly full.
>=20
> Tests passed under qemu on ARCH=3Dx86_64 with GCC 16.2.0 and CONFIG_KASAN=
=3Dy,
> and on big-endian ARCH=3Ds390 with GCC s390x-linux-gnu 16.2.0, and the new
> test fails with the fix reverted.
>=20
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20261016145928.16eddc9a@gandalf.local=
=2Ehome/
> Fixes: 8d1478bfd63be ("seq_buf: Add seq_buf_strlen()")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/seq_buf.h   | 19 ++++++++++-----
>  lib/tests/seq_buf_kunit.c | 49 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 60 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index f006f2654e4c..c38b5eccc212 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -128,8 +128,8 @@ static inline unsigned int seq_buf_used(struct seq_bu=
f *s)
> =20
>  /*
>   * NUL-terminate the buffer in @s: directly after the data when there is
> - * room for it, otherwise in the last byte of the buffer. @s->size must =
not
> - * be zero.
> + * room for it, otherwise in the last byte of the buffer, which marks @s=
 as
> + * overflowed. @s->size must not be zero.
>   *
>   * Returns: the offset of the NUL.
>   */
> @@ -137,10 +137,16 @@ static inline size_t __seq_buf_terminate(struct seq=
_buf *s)
>  {
>  	size_t end;
> =20
> -	if (seq_buf_buffer_left(s))
> +	if (seq_buf_buffer_left(s)) {
>  		end =3D s->len;
> -	else
> +	} else {
>  		end =3D s->size - 1;
> +		/*
> +		 * About to overwrite a written byte in the last position
> +		 * in the buffer, so it must be considered overflowed now.
> +		 */
> +		seq_buf_set_overflow(s);
> +	}
> =20
>  	s->buffer[end] =3D 0;
> =20
> @@ -158,7 +164,8 @@ static inline size_t __seq_buf_terminate(struct seq_b=
uf *s)
>   * the last byte of the buffer is zeroed, and the len will still
>   * point passed it. The same happens when the buffer is exactly
>   * full: the NUL takes the place of the last byte written, which is
> - * lost, though seq_buf_used() still counts it.
> + * lost, so @s is marked as overflowed, though seq_buf_used() still
> + * counts that byte.
>   *
>   * A zero-sized seq_buf has nowhere to put a NUL, so the empty string
>   * is returned instead of writing to @s->buffer. Any other seq_buf
> @@ -189,7 +196,7 @@ static inline const char *seq_buf_str(struct seq_buf =
*s)
>   * without walking it. Unlike seq_buf_used(), this does not count the by=
te
>   * given up to the NUL when the buffer is full or has overflowed. When t=
he
>   * buffer is exactly full, that byte is the last one written, and calling
> - * either function loses it.
> + * either function loses it and marks @s as overflowed.
>   *
>   * A zero-sized seq_buf holds no string, so 0 is returned without writing
>   * to @s->buffer, matching what seq_buf_str() returns for one.
> diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
> index fc53e9ef844c..a67ed6d7b517 100644
> --- a/lib/tests/seq_buf_kunit.c
> +++ b/lib/tests/seq_buf_kunit.c
> @@ -504,13 +504,13 @@ static void seq_buf_do_printk_test(struct kunit *te=
st)
>  	seq_buf_putc(&s, '!');
>  	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&s));
>  	KUNIT_ASSERT_EQ(test, seq_buf_used(&s), 8);
> -	KUNIT_ASSERT_EQ(test, strlen(seq_buf_str(&s)), 7);
> =20
>  	seq_buf_printk_run(&capture, &s);
> =20
>  	/* The one line that was written, and nothing after it. */
>  	KUNIT_EXPECT_EQ(test, seq_buf_printk_marked, 1);
>  	KUNIT_EXPECT_EQ(test, seq_buf_printk_empty, 0);
> +	KUNIT_EXPECT_EQ(test, strlen(seq_buf_str(&s)), 7);
> =20
>  	/* Check that lines without a trailing newline are shown. */
>  	seq_buf_puts(&t, SEQ_BUF_PRINTK_MARKER "\n" SEQ_BUF_PRINTK_MARKER);
> @@ -630,7 +630,8 @@ static void seq_buf_strlen_full_test(struct kunit *te=
st)
>  	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
>  	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
>  	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 3);
> -	/* seq_buf_strlen() terminates the buffer by itself. */
> +	/* seq_buf_strlen() terminates the buffer by itself, losing the 'd'. */
> +	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
>  	KUNIT_EXPECT_EQ(test, s.buffer[3], '\0');
>  	KUNIT_EXPECT_EQ(test, strnlen(s.buffer, s.size), 3);
>  	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
> @@ -649,6 +650,7 @@ static void seq_buf_strlen_full_test(struct kunit *te=
st)
>  	seq_buf_commit(&t, len);
>  	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&t));
>  	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 7);
> +	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&t));
>  	KUNIT_EXPECT_EQ(test, t.buffer[7], '\0');
>  	KUNIT_EXPECT_EQ(test, strnlen(t.buffer, t.size), 7);
>  	KUNIT_EXPECT_STREQ(test, seq_buf_str(&t), "zzzzzzz");
> @@ -735,6 +737,48 @@ static void seq_buf_terminate_test(struct kunit *tes=
t)
>  	KUNIT_EXPECT_STREQ(test, buf, "untouched");
>  }
> =20
> +static void seq_buf_terminate_full_test(struct kunit *test)
> +{
> +	DECLARE_SEQ_BUF(s, 4);
> +	DECLARE_SEQ_BUF(t, 4);
> +	DECLARE_SEQ_BUF(u, 4);
> +	DECLARE_SEQ_BUF(v, 4);
> +
> +	/*
> +	 * Terminating a buffer that is exactly full puts the NUL over the
> +	 * last byte written, so what it holds is truncated, and each of
> +	 * seq_buf_str(), seq_buf_strlen() and seq_buf_terminate() must mark
> +	 * it overflowed.
> +	 */
> +	seq_buf_putmem(&s, "abcd", 4);
> +	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&s));
> +	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
> +	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
> +	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
> +	/* The NUL must not be popped in place of the 'd' it replaced. */
> +	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), -1);
> +	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
> +
> +	seq_buf_putmem(&t, "abcd", 4);
> +	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&t));
> +	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 3);
> +	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&t));
> +
> +	seq_buf_putmem(&u, "abcd", 4);
> +	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&u));
> +	seq_buf_terminate(&u);
> +	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&u));
> +	KUNIT_EXPECT_STREQ(test, u.buffer, "abc");
> +
> +	/* With room left for the NUL, nothing is lost. */
> +	seq_buf_putmem(&v, "abc", 3);
> +	KUNIT_EXPECT_STREQ(test, seq_buf_str(&v), "abc");
> +	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&v), 3);
> +	seq_buf_terminate(&v);
> +	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&v));
> +	KUNIT_EXPECT_EQ(test, seq_buf_pop(&v), 'c');
> +}
> +
>  static struct kunit_case seq_buf_test_cases[] =3D {
>  	KUNIT_CASE(seq_buf_init_test),
>  	KUNIT_CASE(seq_buf_init_append_test),
> @@ -760,6 +804,7 @@ static struct kunit_case seq_buf_test_cases[] =3D {
>  	KUNIT_CASE(seq_buf_strlen_embedded_nul_test),
>  	KUNIT_CASE(seq_buf_strlen_zero_size_test),
>  	KUNIT_CASE(seq_buf_terminate_test),
> +	KUNIT_CASE(seq_buf_terminate_full_test),
>  	KUNIT_CASE(seq_buf_do_printk_test),
>  	{}
>  };
> --=20
> 2.55.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--zuxyigp5g75cr537
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrjMjMACgkQ64mZXMKQ
wqnDWQ/8DVIVKbIT/J6NXxDLQWA6+Y2aCXLaK6vBUh9pMsld7FKgULh/0gKpNZMt
JvSyMbygSt3xDwORZu6kgjzMX0qAi79ZlcnDCk+8OKZQl6oOb7RECmAuqq6qW6sM
ti1HorqMAcw/rVYokghBlY2MSpf4Afwacmznr9Me6/qZTdD1gkBymWurfnw7PjFb
o+AJ6bPczA89lnFcP3wyEqmgSHwCATVxKTqM5jGZElOOfZZoOFeVMk58lrKo7uRU
0F0nAxKpR3aPlp9CuQwPpTrY4L3ra+jH/ksGLWxqeRHUKWaQc/Eie5XWZMQ5+KKy
cwfuPIhm8ZDrFgshfTU+k8nGRxulRgRb7a1YXeicCHzU3J0yGKm4cbvTLTGWezFP
bE63ezQqg10jejxYncZuZC7lWBw40usWoBBqhXdc1+H8ugzXtoDJTfIUvydE7oeb
QsS79GEzNAsFsWjLX0lLol/AHxiYt1dS3eCYo1ohq+iyoj61cuEUUULH5oD0ad90
GOPrCLp9Djyjo+HBi2da+m7PAQeFS9nyznck0nyYNGfW493JXlO+BAM+esgWX4QZ
VadBbxdHnCwIYoBEcG5qD3l33t/8QUXLvcanP2B3gvkzOXJ5RYxC8aRi30CPonDN
k0BliTgQNnzHZwln4zIayl+I4HqdO1XGrJVZVDttz+3d2zd5hQg=
=2Zmt
-----END PGP SIGNATURE-----

--zuxyigp5g75cr537--
