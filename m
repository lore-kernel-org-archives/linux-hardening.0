Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221423;
	b=1FXaQlQcm39Ft1XUhDO27OFu5ZlUr17nXyRyEa/enQ4fFDCQKlsyXCR139Ar/MCfoyxP
	 E1L8+okL+mCaFRoiLk6pguCnXNy86V3FXhJpNB18bp/8H//AqEDSJ/kOPrUg3D7K3csGT
	 AejoN9qWPAZE3gkyz83bZ4lx+lj5N0k/vrc/LyzTRtBd1yqUrDRD4gQRVx6GKhl/Tl6E+
	 P5b0fGyRAvJEYsV6Wl1xup5T0FusfxQNaAGPA6kmMhW+Y0hN1+PCI3rQh9ywmThvGvER+
	 qFnly4pxRRiwnKXQ61kVA7/A7G3jrcbIWhf0wimxK/vSKG+MInerjVGBDeByqSBBMgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221423;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UpXqsVsz6qQ2/W1ZJGXSMvZgVzYrzKwYZcX+fxHmDu0=;
	b=kM7j5Uf8y/fv2m9ysMWO0ee1oB3P1T/VVwOy1RENcHGn+3LVroYuYbDK5VQ/p6Nf7avU
	 EgfxJRN0qm9zA8Fk59E1T4oLArI6SFBBEx+D9flIlopfqlBrDbIXrJnYYHVQq7guVBjik
	 VYI4cmiw++suYC0OV9LHd8RBdyNcLKEo4Vbk4M/OyutJRLrQxMUepq8++FDiyozUbEkXs
	 RZEd46Fq57Ltg4H6bGsHg+MGfmJ/etGn2AzPaGd6kX/VljtxqW/FNx+KfHvHVpWR7WvBz
	 aF4EgVl7xMaQ3JLMD3DxijTWIUf5+drY3Ne2EswlfV2MR1wbEdCqYR5rHJ8SUzSd7RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zk3Jwg8v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B06606A31D
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zk3Jwg8v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C731F01825;
	Wed, 28 Oct 2026 21:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793221422;
	bh=UpXqsVsz6qQ2/W1ZJGXSMvZgVzYrzKwYZcX+fxHmDu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zk3Jwg8vpEa4eG4L2KlXH0RmXrTjxD6a7BGhoz3N3A94Yp9WN30fWyqwgPSeOUyWt
	 movB4xdEHGH7g0sDy5vNAMLTEvIVUq2ICpo789aRLoWu8oZ3OxTDLS0HaN9N0MDvh6
	 ibPRcwk09HY2h8iDB9UTbfW0usHFcA+JkFcIhPybFMlLvEex1rAtDrcvYpIVOjaaPZ
	 A8FejxAkgsa0DpTK+6b+WRprytBL32F1yvAt9glM2tH+gn9YgIvaSah9UfUULg7ev5
	 sCe1LnUJM8Bs+hk4+sNtXudhquWkyMldJIPvMXkKcRcf0kKqhx6hTtJ9+YfMpX34Au
	 2ew+c8IA76SNw==
Date: Wed, 28 Oct 2026 22:03:39 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: seq_buf_used() return value on overflow
Message-ID: <auJiwtzt3O8WstLX@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
 <auJfBNeZGDbvMBxS@devuan>
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
	protocol="application/pgp-signature"; boundary="xfetl56dgdqhjlsu"
Content-Disposition: inline
In-Reply-To: <auJfBNeZGDbvMBxS@devuan>


--xfetl56dgdqhjlsu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: seq_buf_used() return value on overflow
Message-ID: <auJiwtzt3O8WstLX@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
 <auJfBNeZGDbvMBxS@devuan>
MIME-Version: 1.0
In-Reply-To: <auJfBNeZGDbvMBxS@devuan>

> Date: 2026-10-28 21:59:44+0100
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
> Hi Steven,
>=20
>=20
> Another question that arised while rewriting seq_buf.
>=20
> There's seq_buf_used(), which replaced (in 2014) the previous
> SEQ_BUF_USED().  That commit changed the value from
> 	min((s)->len, (s)->size - 1)
> to
> 	min(s->len, s->size)
> but didn't change any other code.  I don't see any mentions about that
> off-by-one change in the commit message.  (There are two 'Link:' tags,
> but I didn't see any discussion about this patch in those; they seem to
> focus on other patches of the same set.)
>=20
> I wonder, because when changing to use pointers, the good behavior would
> be with the -1, so I wonder whether we can go back to the old behavior
> easily, or if anything depends on that value.  Was this a regression?
> Or was it a silent fix?  Or is it unimportant at the moment?
>=20
> This is the commit that I'm talking about:
>=20
> eeab98154dc0 (2014-11-19; "seq_buf: Create seq_buf_used() to find out how=
 much was written")
>=20
> Here's what I'd like to change:
>=20
> 	diff --git i/include/linux/seq_buf.h w/include/linux/seq_buf.h
> 	index 05e70ac18ddb..63d077dd8a74 100644
> 	--- i/include/linux/seq_buf.h
> 	+++ w/include/linux/seq_buf.h
> 	@@ -78,7 +78,7 @@
> 	 /* How much buffer was written? */
> 	 static inline unsigned int seq_buf_used(struct seq_buf *s)
> 	 {
> 	-       return min(s->len, s->size);
> 	+       return min(s->len, s->size - 1);
> 	 }
> 	=20
> 	 /**
>=20
> The rationale for having that -1 is the following:
> Consider a representation of a buffer where s->p holds either a pointer
> to the terminating null byte (or the position where it should be written,
> if not yet written), or NULL if the buffer has overflown, and s->end
> holds unconditionally ARRAY_END() of the buffer.
>=20
> By doing s->size-1 on overflow, we'd translate it to s->end-1 with the
> pointer representation, which happens to point to the null byte (or
> where it should be written), which would make this offset quite
> consistent.
>=20
> If we do s->size without the -1, then that offset puts us one-past-the-
> last element, which isn't usable in the same places.

Oh, I think I see the reason.  If ->size=3D=3D0, then -1 would wrap around
and give a huge value.

So, we can't do this for now.  I'll have to do the change at the same
time that I do the other changes (I was hoping I could do some parts
gradually).


Cheers,
Alex

>=20
> If you would accept a patch to add back that -1, let me know and I'll
> send it, or feel free to do it yourself adding the following:
>=20
> 	Reported-by: Alejandro Colomar <alx@kernel.org>
> 	Suggested-by: Alejandro Colomar <alx@kernel.org>
>=20
> I guess it would be better that I send a patch with a proper commit
> message.
>=20
>=20
> Have a lovely night!
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--xfetl56dgdqhjlsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmriYysACgkQ64mZXMKQ
wqnxRRAAjKEHDKJnRJEqY5pBWiI8caZ/04KXmKGSfsPGJY6iTcB9tRD2NC9YW35d
E0NtXzRyf5XvuEf8VOO8NV69nfgaeDWFvF7J0ymfXytKkeKKFVoHLoJ7U9CAXW2w
xXAR8LzUkTgC07Sm0DLmkEaIl+HDQflk36K4UlSurxO36yehG90U4I6Vz6AOqQMt
X6pnd8g6nWh/2GbgdGV5158PVfeHiPYgs11oYuXXHWe3AsW3csMQEQRflrjd9rUV
nM588fulbgHH4Y1SuTAlvCEf3sj2ijLvlIYod27lEJSlbIslZgMXe+jzELdDfzv7
U4w3NJQxZPASWv7a7BB1qW76Alfg37+Rb+TEdkbC+L+hT3D5deRTfZigbJnEVE82
SYCL9VkJFHM0uPyOyKdrm0pyBfh751WV4EGnvyzUhni4xkU69Rrb60xYaHhQUYlo
cBYYBOpo1UpY6fCKL0b5ItQ4qoMT0PE1N9x+1A16jOppyHvupZvLBIJS34FN7m6c
KleXcUJuKEDtEgbz9hrLCilxPbHlKivrjlfiKAVJQ8ii1A7xS2T4sRbR5qaS00+8
9TrI/ePUAO27j6rDy9p0daN/gtzUTQtukr/cM5pImtDL7KQ2WHktT8qm3GGSfgRJ
GLbFiw7axtwugZ+8u0+GfkScCqeS3yJYMdwB+dYzjny5L4LtgZw=
=8uKc
-----END PGP SIGNATURE-----

--xfetl56dgdqhjlsu--
