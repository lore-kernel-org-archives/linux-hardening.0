Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208634;
	b=m4wXGe5+f1NuqJSA93hzUdfa+fXJf2KzG+Q++LJbTCdoaWkET7egOsrk9u+WPkaYjVoT
	 Q7RAJK+lfqYapQX5Ot8oWmXPKRWOVbmD0IhxWosyY43q3oV25AE9axpDaS6v1bL/zF5Hq
	 ay557kDtzXsimgLjWyLm6g/JU4hROtE9NGXGkEXbNe0Ea1jVcD+sbyFsyd6DXnnJxGOES
	 qSfBjw7Ef7m1wl9c04AoYUglg7ZMEfxQ9M9B+tlWTSuEQtygLX8rtekcXxGgjQ/akRWAC
	 ff/KzemKg8kixwoh0/GMFdPTR2ACpmsEb/Vfopmkw3CfmEapLncVEExj7wwpj2uvi6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208634;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FipawM/kxM7kUZf57vwtWDpz0Jl2rssu6OCQcWN7DNU=;
	b=Wsv1d7jGf7zmcr9fvmg2cGpbWquFLQ+CNvXuXvH+KhsgnXvKmKjFOmHm1d2StB/zUfUP
	 TJm0awngJzg3+dhj1niyhCuVUkz69+rdxb/PsCOHiNATN/0ztGNf8iiYo5CBFDeVAGwBz
	 IiMarJETOo94QBFqEViyG/bHJ64RQAwSS7LnI/g+/MmD4wTu3EquUxWTqk+C6hfeqfwS2
	 NBG54JmA77IRFuYuiByVhsdifK5yYq34QKwYTMUVGyqCp3tAcNpdVf7tDCQHgJg8Ar4iN
	 HGYRY1LykayMwuxgNrmxeaIVwCRnoldiWACPOVyFyV9Gj/jX/RF3ACar+JRu99W4QNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQQvfEnj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C52606A31C
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQQvfEnj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FF51F01825;
	Wed, 28 Oct 2026 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793208634;
	bh=FipawM/kxM7kUZf57vwtWDpz0Jl2rssu6OCQcWN7DNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fQQvfEnjFa+mag8BMQkLjlaJi8eaQfsMsWgB+AlWVJ1b+24g9NTDO+KJHZbyf9AFh
	 TpoZfIIJctDc0WemKJVxyKNi6IWGCfz5F++kGZ0GrGUoFL+3NQW3NqTz1FcsLJGd62
	 /JeAaY7qsIXD8/Kk9FAeRRJV3p2lRZfVLvFAbSejvPN9lJC+GvhFXYFn8IJ5yFicmJ
	 WROVAm6GPQ+cHqp/VGnyrhk4TboxU9UH67FKQ4wO2wFxQLOMYhISIcH09xW1N9bMke
	 sPILVCZUSUBnLe506dj11aBFWaPXzwTeWV+kR5wOqrV16mdqfoIUFGH2NLpgW6SdGv
	 87Z2heW4eIMXw==
Date: Wed, 28 Oct 2026 18:30:30 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: seq_buf_putc() and strings
Message-ID: <auIww9qfX9EF6LXq@devuan>
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
	protocol="application/pgp-signature"; boundary="lycc2zqhrfip56wh"
Content-Disposition: inline
In-Reply-To: <auIrUV7A8eF8DCGG@devuan>


--lycc2zqhrfip56wh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: seq_buf_putc() and strings
Message-ID: <auIww9qfX9EF6LXq@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
MIME-Version: 1.0
In-Reply-To: <auIrUV7A8eF8DCGG@devuan>

> Date: 2026-10-28 18:13:43+0100
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
> Hi Steven,
>=20
>=20
> I've been looking at rewriting seq_buf with pointers instead of sizes.
> While doing that, I've found one place which writes to seq_buf without
> forming a proper string (that is, a null-terminated string).
>=20
> 	$ git show v7.3:lib/seq_buf.c | grepc seq_buf_putc
> 	(standard input):int seq_buf_putc(struct seq_buf *s, unsigned char c)
> 	{
> 		WARN_ON(s->size =3D=3D 0);
>=20
> 		if (seq_buf_can_fit(s, 1)) {
> 			s->buffer[s->len++] =3D c;
> 			return 0;
> 		}
> 		seq_buf_set_overflow(s);
> 		return -1;
> 	}
>=20
> I think a safe API for handling strings would have to make sure that it
> *always* holds a string.  I think this function should write a NUL byte
> after the byte written, and so, I suggest doing this:
>=20
> 	 		s->buffer[s->len++] =3D c;
> 	+		s->buffer[s->len] =3D '\0';
>=20
> Are there any reasons to not write that NUL byte?

Or to simplify, we could rewrite the function entirely as:

	 int seq_buf_putc(struct seq_buf *s, unsigned char c)
	 {
	-       WARN_ON(s->size =3D=3D 0);
	-
	-       if (seq_buf_can_fit(s, 1)) {
	-               s->buffer[s->len++] =3D c;
	-               return 0;
	-       }
	-       seq_buf_set_overflow(s);
	-       return -1;
	+       return seq_buf_puts(s, (char [2]){c, '\0'});
	 }

It involves one more function call, but I suspect that overhead is
going to be negligible.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--lycc2zqhrfip56wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmriMTAACgkQ64mZXMKQ
wql/wA//UuWSAX+IDHcOILYdXHRhrj2Obo7tcT4QUKNrt+vD4aaKZ/wjMIz9sUk+
Zm6/mpETl4bZtgX94oNSX8YCze2sK2Z4ECDTefa+Ual7PQ5MsqEx+VJ8bQfdwfYV
ZwvPFocrq9iS1Vpfd/Vv/+UG1YtoNWt1QKIKsYk4yuDLNr0chDpNMLMmEx8v31dT
2JDzvP9fgOsBGomi5tkIiJ8kdiilibkQCU7R9m1dbkJCoq9d8SVi06nUjO2/WdvP
2OdZRjktRm6T8rNt13Tn/F3Rtl0QkRDrmsXJWgKqbaxCHLx3dj+WaPNq3F9SForp
QV7lryfCl6FgD+1g4duMiXnY7rydLDBZDHEtg4rNxrVUcZpROJGND/Y9KF6AnRWf
2bj1DEMcF24EnMJblpKHatwaAq/15RRDI9cYJp1xT665BnfpSnnX5MFOnzevccDw
kelUQ4ujWPoMrVCL7nTxAdy6nI9YDZf27Atn3p1MI2e3GhYiSpE3XWFs9nOWoI9o
zVzjORM71oUOjlkTlqB/xFJ56b5J3miiDnH3n8MdUhT06VBGTL8HfCyV3zxwv3ts
KkRd77JrJj8UUT2LgZ6dhaflY5qwKr5KxOT9NLu+Tcn9bWq3wlZkrWsbuxdwWPpa
cxeEZFqjGJtnqLHFjhpfz6UCTGeD0ywSm5QW0oxO9GQhJy9iX9g=
=8TLi
-----END PGP SIGNATURE-----

--lycc2zqhrfip56wh--
