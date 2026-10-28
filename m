Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207624;
	b=YZNeAPNpvsKUv/rERMZy9gVJ51XlqgEfPX2gnZ+R8pLTGfCZXqwiOpj3e3qZaKBC6Ixu
	 ZkW0/14XWVSJFwnroAuu7x3pmq4jiGujnL8QvQsZDmvZ0EdUm92aQU6NlPC0hmiwicRlj
	 uc/BDh5buSKZca7ynrpEtnQ/9+cmiJ6pUaklbHz28+aR96U1psWyTc8AwTIkIPPuIejoE
	 HObpkzO8V9r46GonYX3AudrXVW1QhqgK6eUq5Lcoe6dyFBsqklbRoABINFn+WBr3K8T5N
	 sW3GY1BWs4NN/APg7lH2zJZpqQkZ9DTGqihzT65tQhpGUoaVEE2+4XZFUH5MeHvXe+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207624;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=0AhRDUEAySXmidHdynefyKZAc9r4RsUxZ6nSMbg2ty8=;
	b=IDGJjqtfoGyHXCciB4TWPuGg3M0/FQK82lvt1axFf8g0qso2PnPlRe6XgPljXLCeqfRB
	 GysT0tnColPqVvp/DaCvLX9z/tYOwfYkYPzfayjzjLmfSmMnEMgUQ7wlgz4kOH01gk9NL
	 sqPc56Dw7CG6ElhwTdqwbmOr3Uf/xqLY4uPcGnpVYkthNQUv5unjecXl/t8dyrp52XKMx
	 t4lge5KMiytN5RkRxjsDMlNBNXuJFZz7hZOjqoknzD3X/AZ/gs53aVqPsdtBjpesucmJD
	 62F4ltUFxX/Tb//BOOnSrITnAXl4PenljTgJVUr+kSgHj2A1pf1tp9ofGaNBGXQnHkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e1/Sg79r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4EC606A31C
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1/Sg79r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4094A1F01829;
	Wed, 28 Oct 2026 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207623;
	bh=0AhRDUEAySXmidHdynefyKZAc9r4RsUxZ6nSMbg2ty8=;
	h=Date:From:To:Cc:Subject;
	b=e1/Sg79r04qrUBL0VcG5yaycxPSRzKOoTNQwIjboVjID8IrCBgszXic/h0Tvux3/Q
	 1UUjcvd8ybkNx+QajU43qq+OBIM5XQW7IF0/wc/AvaS/tWYdcm0yEcn3t1DMKPhZZk
	 Y+lY0HNNTd9d2vyelG2kyEL3ZLGoZqwM8wFi4usDH9eFzW62nWjaBkT/zYQeB2Adwd
	 oX5n1vzTHfUe7Xno2tZ9rN6OSd7FIB0uYh6cCSDZNAJFNh9FsyMH5YIP/FJvsK8QcE
	 2YDx0i88W1XaEPBNf3aGAXcY4ukgyJcBLwyT8/msAgKV2M/BjPLhebmfSgyx9Q4+AY
	 deiIM7cXfhbgg==
Date: Wed, 28 Oct 2026 18:13:40 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: seq_buf_putc() and strings
Message-ID: <auIrUV7A8eF8DCGG@devuan>
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
	protocol="application/pgp-signature"; boundary="4pt6wy7knrnrkqio"
Content-Disposition: inline


--4pt6wy7knrnrkqio
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: seq_buf_putc() and strings
Message-ID: <auIrUV7A8eF8DCGG@devuan>
MIME-Version: 1.0

Hi Steven,


I've been looking at rewriting seq_buf with pointers instead of sizes.
While doing that, I've found one place which writes to seq_buf without
forming a proper string (that is, a null-terminated string).

	$ git show v7.3:lib/seq_buf.c | grepc seq_buf_putc
	(standard input):int seq_buf_putc(struct seq_buf *s, unsigned char c)
	{
		WARN_ON(s->size =3D=3D 0);

		if (seq_buf_can_fit(s, 1)) {
			s->buffer[s->len++] =3D c;
			return 0;
		}
		seq_buf_set_overflow(s);
		return -1;
	}

I think a safe API for handling strings would have to make sure that it
*always* holds a string.  I think this function should write a NUL byte
after the byte written, and so, I suggest doing this:

	 		s->buffer[s->len++] =3D c;
	+		s->buffer[s->len] =3D '\0';

Are there any reasons to not write that NUL byte?


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--4pt6wy7knrnrkqio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmriLTgACgkQ64mZXMKQ
wqnMvQ/9FzocDsLkH4W0rjtfqJxcBUm2RLXv3DJv2mbbQH5zYS6Vw1VzJiU89OET
ilCTGjLruib+FSlloVNm0QCR43KELq7dZz1gSpQRXmH2XScJNttTN5uGerMQMiGC
0Gzw9jT4mCmKKWo+ww5bipGkLVy9CGPwXVph2FQol/+ldkqloMkUKdXB89wyuxa2
UZFrIF6NddCAHEBIBnZMoz4IWLJtBZ3mJLNdaxds4TASADbMx+AiAgZIiGHs3aKV
ngXgyKZc1oXdpxsB1LTtECsmVafl3JNdbJSVgAzYr71xRzXOIIUMOZ9HPrvsKIKP
s/C2Dqm0ByKNC5+6EryZJD/Lm0sveNeZzZNLnzSie8yYJsb6Ol55FtZNYPr6ezP9
3gY/BiTHlWxDKIRfQzo46pc+HbRwvnlfxj7/m9MNCE//tQOsAE5dOapDugwOAA/4
+kWqKGY+UBNemZmqykbO9O4EWHcY0RxtrHcrY20kxZXfwxIn8hUi682G/POm7EnQ
QVFU2PizDprbfsWCniayVyUVAReWoIShPwlsQB3bR50KItZMBD+HJNRYK77ruLTR
sVKt8wjunjqHxXEnfa5VTg/rvTAizYX1I2ARBkugMeRRarPJ2e2NOK/GRnq3oCPZ
n/H7DFUU+ZY7Gkd/Aqd70L3WVoTT+fDGM6eoUOX1VvQGShqzek8=
=bmY1
-----END PGP SIGNATURE-----

--4pt6wy7knrnrkqio--
