Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791025;
	b=g4KcvyT++Gojd/m36/QXZYrEKBGeXsqRUzVHAopK2Jiev99IJDrj8KV4474/oIDPCmuy
	 CGOsh0KFoJ76zuuMA6u80B4pnrk6UM4EU6tsFLXh/DiN/kgg5deIJ7F4pPHR2bT/fJzZX
	 XAIvJiDyTZ4R9YgiWEhELMAG47fP++AB9AKhJkCFKERIXRoeaqveIxGT2gpDah6YOe8MD
	 ndkCVEqTKmgyUdd1LzCVK6KtA7qNBI+WwyLa2TFWfN5PLvQbJY1oG34V6TsSh7TrPTCLP
	 BDL8tpVi5ftUW52Wz8XPpONZV1rRASsuPsp5g7G4jEkO0mqmaepPYzlMtr+7VTvG6UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791025;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8Man9aiwWskFKD9FVhK/t+9LJTaNHF5fUBHW++HBPlo=;
	b=rfK1NdqaLzEzCLu1NrAvabAKgXQG2QAIYP+mdJQNEtpCLkp9+C0HPXO0ddL1DkW1VmmH
	 AeRGiQKJv3KMn2E576S3WYcqM2oUjh6uu1u+KM6OSdX8pUyBtLrUt0othpBIAj1/iYADP
	 sEU1k9attpZpet6kLlrkEvNGJowcIruCLj+nBmAemkQUo2T68Jz5u48IGt6lYh1+53UNJ
	 SMeg/KubXACdskgd1Ix8ZXa80cCp053r/IAIX0QO6WO/3HxgYdFeXeC11Xof1qXLonGdd
	 9CHI63fhHPVJXpZZiLD7qHmAmKYfOzI0Hx5P75SuXBAbvbyfgfvajt9vRXPGgGL4UNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oe1+zrGk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478C606A326;
	Wed,  4 Nov 2026 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oe1+zrGk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1B71F00919;
	Wed,  4 Nov 2026 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793791025;
	bh=8Man9aiwWskFKD9FVhK/t+9LJTaNHF5fUBHW++HBPlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oe1+zrGkxceffaUgq6/CsIeoZ1fS5B6ELHFtzwXmbRd11i5wz32WY5zn3EHTumhlU
	 8zqt8XF5ZF6WoE5Fito8wDaLvwo4fq8pBVCj5Ijq76tFk1r5QAzZYGQ86n5ilkw9MR
	 QZLyXH8n817dBXnDXHyFRR7YKTPU4Aed8BYzTTTw9tKMSJnbanD8Vscyhbnc/SRkVq
	 jq/pBqRV2kUorP4MfHn9GCIL81bEncwxJwQ2bSlkahVBEs49rrl9LDO6yvjUlRxQPW
	 Pdz/1WHlL1Lpr0PpNWdqudUZ+gTIbJ8h9xkWc4W2PPRAGx7VP9m7EiZGBeQAN/cuyS
	 8DPSr3Tkz8Jzg==
Date: Wed, 4 Nov 2026 12:17:00 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <ausTcdh966BNVA-_@devuan>
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
	protocol="application/pgp-signature"; boundary="yydwjryjepwm4wp7"
Content-Disposition: inline
In-Reply-To: <20261104033110.out.418-kees@kernel.org>


--yydwjryjepwm4wp7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <ausTcdh966BNVA-_@devuan>
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

Okay for this patch, but still some question:

Since data truncation is almost always wrong, is it a bug that those
users are not verifying that no overflow happened?  Or do they have a
good reason to not verify?


Have a lovely day!
Alex

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
>  v2: https://lore.kernel.org/all/20261030192049.stay.397-kees@kernel.org/
>  v1: https://lore.kernel.org/all/20261029053250.i.220-kees@kernel.org/
>=20
> ---
>  include/linux/seq_buf.h   | 27 ++++++++++---
>  lib/tests/seq_buf_kunit.c | 84 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 103 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index f006f2654e4c..6b915c67d235 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -128,8 +128,9 @@ static inline unsigned int seq_buf_used(struct seq_bu=
f *s)
> =20
>  /*
>   * NUL-terminate the buffer in @s: directly after the data when there is
> - * room for it, otherwise in the last byte of the buffer. @s->size must =
not
> - * be zero.
> + * room for it, otherwise in the last byte of the buffer, which marks @s=
 as
> + * overflowed. Data that already ends in a NUL is left as is. @s->size m=
ust
> + * not be zero.
>   *
>   * Returns: the offset of the NUL.
>   */
> @@ -137,10 +138,20 @@ static inline size_t __seq_buf_terminate(struct seq=
_buf *s)
>  {
>  	size_t end;
> =20
> -	if (seq_buf_buffer_left(s))
> +	if (seq_buf_buffer_left(s)) {
> +		if (s->len && !s->buffer[s->len - 1])
> +			return s->len - 1;
>  		end =3D s->len;
> -	else
> +	} else {
>  		end =3D s->size - 1;
> +		if (!s->buffer[end])
> +			return end;
> +		/*
> +		 * The last byte of data will be overwritten by a NUL
> +		 * character, so mark the seq_buf as overflowed.
> +		 */
> +		seq_buf_set_overflow(s);
> +	}
> =20
>  	s->buffer[end] =3D 0;
> =20
> @@ -158,7 +169,9 @@ static inline size_t __seq_buf_terminate(struct seq_b=
uf *s)
>   * the last byte of the buffer is zeroed, and the len will still
>   * point passed it. The same happens when the buffer is exactly
>   * full: the NUL takes the place of the last byte written, which is
> - * lost, though seq_buf_used() still counts it.
> + * lost, so @s is marked as overflowed, though seq_buf_used() still
> + * counts that byte. When that byte is a NUL already, nothing is lost
> + * and @s is left as is.
>   *
>   * A zero-sized seq_buf has nowhere to put a NUL, so the empty string
>   * is returned instead of writing to @s->buffer. Any other seq_buf
> @@ -189,7 +202,9 @@ static inline const char *seq_buf_str(struct seq_buf =
*s)
>   * without walking it. Unlike seq_buf_used(), this does not count the by=
te
>   * given up to the NUL when the buffer is full or has overflowed. When t=
he
>   * buffer is exactly full, that byte is the last one written, and calling
> - * either function loses it.
> + * either function loses it and marks @s as overflowed, unless it is a N=
UL
> + * itself. Data that ends in a NUL is already terminated, so its length
> + * does not count that NUL.
>   *
>   * A zero-sized seq_buf holds no string, so 0 is returned without writing
>   * to @s->buffer, matching what seq_buf_str() returns for one.
> diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
> index fc53e9ef844c..7f9cd5855922 100644
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
> @@ -735,6 +737,82 @@ static void seq_buf_terminate_test(struct kunit *tes=
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
> +static void seq_buf_terminate_written_nul_test(struct kunit *test)
> +{
> +	DECLARE_SEQ_BUF(s, 4);
> +	DECLARE_SEQ_BUF(t, 4);
> +	DECLARE_SEQ_BUF(u, 4);
> +	DECLARE_SEQ_BUF(v, 8);
> +
> +	/*
> +	 * A buffer filled exactly by data that ends in its own NUL is
> +	 * already terminated, so nothing written is lost, and none of
> +	 * seq_buf_str(), seq_buf_strlen() and seq_buf_terminate() may mark
> +	 * it overflowed.
> +	 */
> +	seq_buf_putmem(&s, "abc", 4);
> +	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
> +	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
> +
> +	seq_buf_putmem(&t, "abc", 4);
> +	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 3);
> +	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&t));
> +
> +	seq_buf_putmem(&u, "abc", 4);
> +	seq_buf_terminate(&u);
> +	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&u));
> +	KUNIT_EXPECT_STREQ(test, u.buffer, "abc");
> +
> +	/* With room left, the length still ends at the NUL that was written. */
> +	seq_buf_putmem(&v, "abc", 4);
> +	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&v), 3);
> +	KUNIT_EXPECT_STREQ(test, seq_buf_str(&v), "abc");
> +	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&v));
> +	KUNIT_EXPECT_EQ(test, seq_buf_used(&v), 4);
> +}
> +
>  static struct kunit_case seq_buf_test_cases[] =3D {
>  	KUNIT_CASE(seq_buf_init_test),
>  	KUNIT_CASE(seq_buf_init_append_test),
> @@ -760,6 +838,8 @@ static struct kunit_case seq_buf_test_cases[] =3D {
>  	KUNIT_CASE(seq_buf_strlen_embedded_nul_test),
>  	KUNIT_CASE(seq_buf_strlen_zero_size_test),
>  	KUNIT_CASE(seq_buf_terminate_test),
> +	KUNIT_CASE(seq_buf_terminate_full_test),
> +	KUNIT_CASE(seq_buf_terminate_written_nul_test),
>  	KUNIT_CASE(seq_buf_do_printk_test),
>  	{}
>  };
> --=20
> 2.55.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--yydwjryjepwm4wp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrrFCYACgkQ64mZXMKQ
wqkGSBAAn3Y4amj1s0ONlbjH2cIh+R2yBwdSHS9zE6Di2friBq2TbZzB7Pq+BRno
CuiXlzUrah1av/uHHGVWz65fTdFH+CdXAyJlUtwpdQCVfjtiE8IAQGnaO0N0AnqC
IHogYIGKbW464RdP2H5Qo88t0OTaubf6uv/K2B4wDTA8L3NMdFdeZdBfWRGU8W+5
NHxNnXGiVa3XNRM56FtWmil+Di0cNHgwvHjugsRe/IUg6kAnJVm/c1p354wwane6
jEBDTcbnj2lqQ2sFpTrAmpinQdJK3jee4OipXWrghNy+Ett9x3g8mLasxxyK5rai
NSxUlR0X1OkM33jz9tTzZ6kt627rcVOvN3VOZ3myKIOxWXekXfMJO0IWKrEQohDo
NT2XpuLxrYV/uOpKEDo9QQudIlg+EDbanI8ZoDUTSfnPXT32wUgU4Wun/rv7fjgD
wrCsiow7pQx1Zr7cnfvMaW9nWghXFxgQrCkBWK2Ozb+bmKXXJTIcIaC0UxDsXgYo
q86GDlaRoLdnXdaZ3eLpsMrrACPi+o6jZy15l7vk0sz+gaVhI8G6dvvBt8xmb8sD
jZa1VJTif7GKFui0wggefFemqvGXLxFma0JjJHg5z1HmO676qVr9+WpE0S1RSfO4
NT4993+cmz+j/bXHhc19VW9S62fmpaQuCRlIKz7EtGc0dl/zFCA=
=wSAV
-----END PGP SIGNATURE-----

--yydwjryjepwm4wp7--
