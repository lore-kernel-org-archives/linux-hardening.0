Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286197;
	b=ZIPpB7bz4TzFeVBiKx9mGWp4Ra7vAjJwZIxrKyyVpDTxOZaLi0WMsxa8RozmOu5V33AR
	 +y2ud/VE/n64Xa7rXgEGheOlAKBLalq7Nhh+0CdMxKWFg0nM3Ssn1uo6hY0ok8Qg2aXNV
	 pmVElwaPC6ihRQiKf3MY/UdR9T3xi8a6HdRVdVTRAC7Xi2miPnWmxw9N64+b+yVWvdzD4
	 v+kXsqM3uS5kN3KmFBOOrPoRxGQ4/CHNWluhyZK3lwRtS7jRHDljGwre1JKDMD0K3/jZS
	 UcnEn2cWH/PUL9TPdjWvD7WY3ExiTxpH87jqa1OgIF4+IsAgJ2f2i7/Ld4ZfjrMLklQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286197;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=muLDySWWwhObOT3WUd63ROE8iWeXOi5X1K49GMfurvo=;
	b=TisORht3ggN0KwhLkGdwza9W5pdhh9ywMERvG167tn1ZH7QTgjI/6+hqPj0e4hzwqMub
	 2X0oUwFoPqr/ZRm/x9Bf97HA7Ea4PDEQsU289mphizEQB2WNllfdMMV+Cw5+7CL6M7ooR
	 AzMWFNQk77JvPsiW0GU6HzxvkYzRwRTVyyRogA6omw6m0igdPhqgmfEsenyUPDEBOhlqm
	 me/iKKjE/edSJudzthJ2QJa7y94H5APjKO5GW6mT6EzuguTcqAsWIvzYBCabs8oFEGdog
	 ezanVV0ipcDJDI6dmVI+A4pZMcDKsYvBticVXGD/tLfsRPcJeR9Ke/DYtT27VFgQs3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqaVkY0N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B76606A31D
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqaVkY0N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1A11F01829;
	Thu, 29 Oct 2026 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286197;
	bh=muLDySWWwhObOT3WUd63ROE8iWeXOi5X1K49GMfurvo=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=mqaVkY0NhR/PL5Znf17xR3kZWzk+fzDpdvYQNkJTCOlRMp5uOJMdbTKP7giuZEbwN
	 DLh4Loh+X54hewcUf67pqxoUgg8T02hmTP5mK7RUI1/NVI0BFvyvdGrt4qYT/orBGY
	 ckdbdex+DIIRdgfNMrIT95DASmlL9tm37n28/PoVPB2u/gyU8CAlWK9I5sL07ABv+b
	 xAjFydxiBaUWMoJe1+Ut8NGIVKyasDHjYniwrm34bCiqgU1r+mcL43+6vdM21bnk75
	 DeZd30ND1W40QHIpqV74HNVD7Hc6VOxp8r6cFV5yYFAcXvF0lDVVeVEJ+YCL2+vMGO
	 EWnLqyoDWH27Q==
Date: Thu, 29 Oct 2026 16:03:13 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	linux-hardening@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>, 
	Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1] seq_buf: Add seq_buf_create() to implement
 DECLARE_SEQ_BUF()
Message-ID: <auNZxvOwfaqdjE_E@devuan>
References: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
 <20261028211227.2b644f2e@fedora>
 <auMtYh5eJKLjrubA@devuan>
 <20261029094156.141f8c54@gandalf.local.home>
 <auNRKk_IaN8kBPiS@devuan>
 <20261029102830.77858afd@gandalf.local.home>
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
	protocol="application/pgp-signature"; boundary="ea4rrfx3iullve7v"
Content-Disposition: inline
In-Reply-To: <20261029102830.77858afd@gandalf.local.home>


--ea4rrfx3iullve7v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
List-Id: <linux-hardening.lore.kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	linux-hardening@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>, 
	Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1] seq_buf: Add seq_buf_create() to implement
 DECLARE_SEQ_BUF()
Message-ID: <auNZxvOwfaqdjE_E@devuan>
References: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
 <20261028211227.2b644f2e@fedora>
 <auMtYh5eJKLjrubA@devuan>
 <20261029094156.141f8c54@gandalf.local.home>
 <auNRKk_IaN8kBPiS@devuan>
 <20261029102830.77858afd@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20261029102830.77858afd@gandalf.local.home>

Hi Steve,

> Date: 2026-10-29 10:28:30-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
> On Thu, 29 Oct 2026 15:15:29 +0100
> Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
>=20
> > > Honestly, you haven't convinced me that the pointer logic is any bett=
er. It
> > > looks to me that it may be just be moving the complexity elsewhere. =
=20
> >=20
> > The complexity doesn't move elsewhere, IMO.  It has an issue with file-
> > scope initialization, indeed, because derived pointers cannot be
> > constant expressions, and thus this precise problem, but other than
> > that, there's no off-by-one-prone edges in that design.
>=20
> If you have to change the current API to satisfy the constraints of a new
> implementation, that is moving the complexity.

It adds some small churn, but I wouldn't call that "complexity", given
that it actually reduces the complexity of the callers too.

> > However, I understand the fear, so I'll try to prove the simplicity
> > before asking you to trust me about it.  (I guess by doing a full
> > conversion, and showing that the diff reduces code without showing
> > corner cases like the bug we're discussing at the moment in the other
> > thread.)
> >=20
> > > Yes, using indexes can be error prone, but if you keep all that abstr=
acted
> > > out to make sure you can validate that it works, it should be fine. N=
othing
> > > that uses seq_buf should care about the internals. =20
> >=20
> > Actually, there are a few places where those internals somewhat already
> > escape the API.  For example:
> >=20
> > 	avail =3D seq_buf_get_buf(s, &buf);
> > 	seq_buf_init(&ns, buf, avail);
>=20
> How is this exposing the internals? It's an API and it only modifies what
> the user has control of (the buffer supplied in the first place).

It would be better to not=20

> > could be rewritten to use a single function (we can already do that):
> >=20
> > 	seq_buf_get_tail(&ns, s);
> >=20
> > This way, we don't need to have a temporary 'char *buf' that we don't
> > really need in the caller, and we also avoid inspecting the available
> > size.
>=20
> What happens if there's no size left?

More or less the same as now, I think.

Since I don't have a tree with the recent patches from Kees, I don't
know if that has changed recently, but from what's in v7.3, I think
it will behave as this:

-  If the buffer has already overflowed (len>size+1), it will WARN().
   Then, it will produce a null pointer, and a size of 0.

-  If the buffer is exactly full, then it will also produce a null
   pointer and a size of 0, but without WARN().

With pointers, it could do something like this:

	static inline void
	seq_buf_get_tail(struct seq_buf *tail, const struct seq_buf *s)
	{
		if (seq_buf_buffer_left(s)) {
			tail->buffer =3D s->p;
			tail->p =3D s->p;
			tail->end =3D s->end;
		} else {
			WARN_ON(seq_buf_has_overflowed(s));
			tail->buffer =3D (static char[1]){""};
			tail->p =3D NULL;
			tail->p =3D tail->buffer + 1;
		}
	}

Which gives you an overflowed buffer, which is safe to hold.  One can
read it, and will read an empty string.  Any attempts to write to it
would be no-ops, since it's already overflowed.

> > This could be done already with this:
> >=20
> > 	diff --git i/include/linux/seq_buf.h w/include/linux/seq_buf.h
> > 	index f006f2654e4c..f7ee062374bf 100644
> > 	--- i/include/linux/seq_buf.h
> > 	+++ w/include/linux/seq_buf.h
> > 	@@ -58,6 +58,16 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned=
 int size)
> > 		seq_buf_clear(s);
> > 	 }
> > 	=20
> > 	+static inline void
> > 	+seq_buf_get_tail(struct seq_buf *tail, const struct seq_buf *s)
> > 	+{
> > 	+       char *p;
> > 	+       size_t size;
> > 	+
> > 	+       size =3D seq_buf_get_buf(s, &p);
> > 	+       seq_buf_init(tail, p, size);
> > 	+}
> > 	+
> > 	 /*
> > 	  * seq_buf have a buffer that might overflow. When this happens
> > 	  * len is set to be greater than size.
> >=20
> > > Using indexes should not
> > > be a point of failure as it's not extended outside the scope of the
> > > internals of seq_buf. =20
> >=20
> > Except that many places do look at the size by looking at the return
> > value of things like seq_buf_get_buf().
>=20
> That's not the internals. And your pointer algorithm had better supply the
> same API.

The pointer algorithm presents the remaining size with
seq_buf_buffer_left(), but doesn't expose it when getting the tail of
a buffer, because I didn't find it necessary.  We could expose it there
too, though.

> The amount of buffer left has nothing to do with the
> implementation of seq_buf.
>=20
> >=20
> > > That is, once you prove the internals of seq_buf is correct, then you=
 are done. =20
> >=20
> > And also except that you still need to prove the internals of seq_buf,
> > which aren't exactly trivial.  With pointers, those internals become
> > simpler.
> >=20
> > I have a draft for moving to pointers, and it cleans the implementation
> > quite a lot:
> >=20
> > 	 include/linux/seq_buf.h |  86 +++++++++++----------------
> > 	 lib/seq_buf.c           | 101 ++++++++++----------------------
> > 	 2 files changed, 66 insertions(+), 121 deletions(-)
> >=20
> > (It's far from ready.)
>=20
> Don't bother. I don't think you understand the usage of seq_buf.

I'm certainly not understanding all the use cases of it.  I'm just
seeing it being used to replace snprintf(3) and strscpy(9) calls, in
theory to make them safer, and I'm doubting that will really improve
safety.  For this use case, a pointer-based API is much safer and
simpler, and I'd entirely avoid seq_buf.  That's why I'm trying to learn
seq_buf and see if it can be changed in that way.


Cheers,
Alex

> I also
> already don't like the changes and I don't see why they are even necessar=
y.
>=20
> -- Steve
>=20

--=20
<https://www.alejandro-colomar.es>

--ea4rrfx3iullve7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrjYCsACgkQ64mZXMKQ
wqn11xAAsutaJkGTzoJpqvKBOrawj+WfGAFnG0gXUo+fASN9A4DI1qt2SlLHeJzM
003PqwSSrPukWVCwlhVTwwMpepvlcgNCS1jPurgt9mU7Jj6JCExHoUnNcCrKjUYe
yBUBJ8eU3JgyuZzUkQakF08VSfmWO+N7sDpq9FXSo2b2x8OcZrmXcVeT+qhATxE6
djN4U812P71Q2Sc2D6eg2a2+DNgMNNZTepP3QMbwFYSjCvArjamRHbZSwcOO5Y0a
lX91CjI2U4vTTlzKLxpzBLgrqHlpqWKq9LilwbFMQXuM7Q8r8EJSfsKlajeKcaeW
mwphdDsX7/QtzQlqQHN+l1NW/zyxSKAhiAEgreOTh2rdzlWhyyKS6Y/JIO3Ob4hV
OMQnKmsN5etnZdj9RqcH7EHWfg4wlJhedlpgrSs4S/RtGslurPcT2gDUTbkDJepS
KY+8xynrHFMxrrHJhgBBwn1afOvUCwcvw2WyrFASdmx/6V0ai2PFU/KU/Ql1vY92
9bNejzoTVA7o91GmZh9AGFhDU9CnUVlNAPJXe+obd5iuWjs0St7SVyWuHzPosa2D
6MzJPZo9ZmU1nqumd7OYEwZVKJE9V/KYM5y9WAHcP+lkxrmcnLP2iO1IXhj5tK2k
0qJgSC8qpts5HgGxx7/JD/1Ff51X9IwEW41rGrJfOekzWVRv9A0=
=Cwa2
-----END PGP SIGNATURE-----

--ea4rrfx3iullve7v--
