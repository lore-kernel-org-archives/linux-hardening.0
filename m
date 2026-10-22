Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699897;
	b=3IH+rkz0N23GhOjj9e+HmgdnuuwfGFK51Po4B1zX6JD5LB6I91tenYkC2BRCnPu5rUB+
	 FFZOb3Vx4HvuOMaaZ4w9nh0zVYqyvXRyTByWylhTskK+PDL0HZwJAkgbwa4OP4F0rGlGT
	 BGpk5CKKO7kkfgWQrpOczpgDqwYSB1tPyC2Tf9xIhNkQHt/LQbkHR3UdMfSi77Sq/uyjF
	 J050jfsOCvnp/jk+OGRm7bPhdJ9Yatwyuaa0Cid7e0iiBFZ4VvKC2zo5HL2xVYucBomgU
	 1eDtv5OmEzLzGXUAmmgBMqolNd96cPTJzhGtM/d3sfeDUEVTKTfxNM9W4dzGWu7jZSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699897;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8YeXKojMVZ/QKBEred3exRdn/k0MseRHZQRqTCQsT7E=;
	b=xnFsYnYXMzN3ppqrKBHfwjEj6vMS9sO9ceRG9EcsLm3VSNjZ1rnvMQRt28h2XJ5fmk9w
	 NAKVW6I7PcnW9ogwDe14/FLdu7SRcfSvJPUtoMLD6tkkgmiuEEmBiEXIhbmrrcp0X3Uus
	 5ESBhcbwupLKgPZ11jsDJCi7MQj5ja8O5RgaEJM2MMtZQEJQN9DAH0CcGYZvOHS5M2frU
	 TAd+BlwjLRQae1n6/CGuuZn0h2Z8a/3kswqVDm9TxsfnLVMhQlBMVYx6ia+/ncK0xEz+J
	 r10y1YQ58hJEuHLKuM0PuH3XSg3Qt5UnrK5kA9Dh2N0n9XXQ/9SbcfqYSRBVu/Iwnsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NnZIkso/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA77606A31A;
	Thu, 22 Oct 2026 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnZIkso/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FEC1F031E1;
	Thu, 22 Oct 2026 20:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792699897;
	bh=8YeXKojMVZ/QKBEred3exRdn/k0MseRHZQRqTCQsT7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NnZIkso/2KXBoi6qMcQQ3e+73LkZkQeYI7tFin4B6XbQ+I4zuXxMPPRYK/DT2z6nh
	 bcEboRefE3QneNNz75zbr8DF3OxFDAxLtWnagYAvV3Z7vYAir3z9DkbEdSDgEl0X0g
	 lPQ0OvmQXJHR1M3QgoBKAC2f6da3Vm5+8+/dnM1UVvPa6ukuVBLdwMgJbvgaD6wIQ+
	 K7t8fXzHobtdBH7VlPbX9HWHbodbBHNOASX6+H1CYDmRHXv+KIPgyS/IbRLL3sXc8M
	 6rliNs5t88hbu0GJN5jX7UT14Szh8/XrmcMzMnGV2QOrXdEttGVFrySLx56KJCT1zH
	 xxrxhCaCfmSow==
Date: Thu, 22 Oct 2026 22:11:27 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <atptYsHyS6YGtzPV@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
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
	protocol="application/pgp-signature"; boundary="74wc3amtt2nanemr"
Content-Disposition: inline
In-Reply-To: <20261022155726.7f20c4cb@gandalf.local.home>


--74wc3amtt2nanemr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <atptYsHyS6YGtzPV@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20261022155726.7f20c4cb@gandalf.local.home>

Hi Steven,

> Date: 2026-10-22 15:57:51-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
> On Thu, 22 Oct 2026 21:41:53 +0200
> Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
>=20
> > > > Hmm, I just realized that this could inadvertently overflow the buf=
fer. If
> > > > len =3D=3D size, it may not be overflowed. If using seq_buf_putmem(=
) and
> > > > filling the entire buffer, calling this would force an overflow as =
we just
> > > > truncated the last byte. =20
> > >=20
> > > Hm, yes. So the "else" branch needs to include:
> > >=20
> > > 	s->len =3D s->size + 1; =20
> >=20
> > Please think again about the possibility of using pointers instead of
> > lengths.  This is a source of off-by-one bugs that's only caused by
> > the choice of data, I believe.  If using pointers, truncation would be
> > stored as a NULL pointer, and off-by-ones would be less likely.
> >=20
> > Consider this off-by-one to be just a sympthom of the underlying
> > problematic design.  Whenever a design forces you to write +1 or -1,
> > there are high chances that the design is sub-optimal regarding safety.
>=20
> It's not an off-by-one error here. The s->len =3D size - 1 is correct, bu=
t it
> also has a side effect of removing a character without marking it
> overflowed.

It's correct, but at the same time an opportunity for off-by-one
mistakes.

> The seq_buf defines being "overflowed" as s->len =3D=3D s->size + 1.
> What the else statement should have is:
>=20
> 	else
> 		seq_buf_set_overflow(s);
>=20
> Which would be less confusing to reviewers as that is defined as:
>=20
> static inline void
> seq_buf_set_overflow(struct seq_buf *s)
> {
> 	s->len =3D s->size + 1;
> }

Agree.

But still, a better design would do:

	static inline void
	seq_buf_set_overflow(struct seq_buf *s)
	{
		s->p =3D NULL;
	}

This is way more robust, and also easier to understand.  My head is
boiling when trying to review this patch set for correctness.  That's
not a good sign.


Have a lovely night!
Alex

>=20
> -- Steve

--=20
<https://www.alejandro-colomar.es>

--74wc3amtt2nanemr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrabegACgkQ64mZXMKQ
wqmu5Q//Wfe63wcUcEFjGLtX0Hv7/Frnxp/TzsOySg7UPJ+7DDOTz+Klx7Fl/Ue7
dsoRh/uEkhLc6LRdcl8akPcAo8b+/Vn5TQbOPeG+DpgR5xvSs/XJuF9IxyVN4oh2
zIZm1iEJcCQjCYvQF+ecNtDPrY4fvkq3Sueg4xLc84+LU7kzS+JenJPQYf+JgDd/
tuiPDBbyhOLNiZZtqt7Nm4VVbB1RVgZG8Ze2Rtjwr0wrvBgqHzvqb1SyjX2oKgp4
pTd52gck2wDUdVqTxWEA61+J57y5ElA/NiykkObyr3MkhSVEULUVaYa1/n/6vT0D
R9biVwM5AnvadaMKC6tjd603jemFT2G4oONJJ68eZcgQVHTYr8/Y4LPZllajg3tw
uORuak9XpeOzCRhCiTTJhOumQqp9qRWe90PFbmAfmxz1hkceb/n1XMzR+oRzOqRZ
MnyV0eEhSPosUMqEVWgtBimlht4w8m5S/UoQ5fW4eOt1vGYAij0I2ctKHeV3dGlr
X6430dgoeL3KRHRVBwONXLWiRyIHWQ5h+6gPco7QaXnfRzM1K/GRtfVX3ovlq4Nj
V1xeTRv1gUhcUKr2lPGQMVqetaq2/EWwSXKTl2cX/UQOY3spj8uK1kkMCFA8czZb
Zbzxk9P08GvYp1Tfm71LLAN1NoAYtcNtMYaas6bMph0RzcllWXY=
=WWyU
-----END PGP SIGNATURE-----

--74wc3amtt2nanemr--
