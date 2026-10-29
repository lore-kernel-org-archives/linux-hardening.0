Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283334;
	b=xcQib8LfsXKeWSJukk8jyXR2OzDeq6GhtExIxcJsPKIX+8UytkUd9zBtvZeIFbVFsSY0
	 yy9e5C16l7n2/Mwb2O9h2K40Mt+XCIztox6yDOPQiH7P5j+twe5/HTtu3d+IOvV9QPmcR
	 dl9GCtIoJZ372qZLDY3vyLfVil6qbuNghDj5ndaE7h8PXLQMrfZo5mTqb+uezyHEWU/oI
	 eQZjNpkuFOMMTkEv/W4nc0lzQ2WGgdSqvJY4yuxPc7x7MDycHbNnezY4OEeoRlgIxGi/V
	 fD6PIQ9PZCA0mfYWNVLNemuHHzHLOLyfNIkUNPGxBmkjZYjtasKyapNh6mytwT+hhbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283334;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HyPTrBsmYmqM69eKxJsiCi+6VsZcG5vEnaGWF/qeFFg=;
	b=v+GbSsx69D1FXLKKJ6ese6DDGzKjxDMITmmC4deWvXD3/aBy4Cgqz+G8/szk1UdyS0Xo
	 Lk9eQaHzcAt852X2yAoroXmWllnS+hi8nLVIqZV0AwJS2rY0o0wCK1t7b32+SJZJ1Llob
	 uDOaEqyPGUyjmwNaZww77xQqvQY3lzfDz+fHWT8gQhv2vg9qgAdYrOymEtmof+JEv+Oh3
	 Jk116oZAjUX+c8jmVony8cTtOjtqhJCeRQ/rpN2SqP1FEjU/lq8PJZuQj7tZ3i2mfXFFL
	 qng36U801iowtT/faeODnH1Pjd0mCGgx6QiEjsB9TnuGp7N0e4ek4eorMbPphnm3Z8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GB+LYI1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E07606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GB+LYI1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4F31F01828;
	Thu, 29 Oct 2026 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793283333;
	bh=HyPTrBsmYmqM69eKxJsiCi+6VsZcG5vEnaGWF/qeFFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GB+LYI1BNDR8GcgSiRWr6dLRXIa9uFyOdoSDslGmfvSBKuHOUSxyjOpVSGssOicSz
	 9WGYNXPuUhKpX4voYamIxs7n7EVci+km9/bHbrktyDLek4CB5maoxeYMjm2TJa7kTD
	 rFLRDLmyt/8VTWf9TEhZmHFXUxEethBGDcO1/7v1Np6I37IcIsKXST1xRWBgqA7p6k
	 jHhEoJZTQeHX1Srb73JzLROwN7NSpsvX/rnHHC1UoUGjDFNlGbaifdjVl2t7tKMPTs
	 /pzw8S6dGbRaA75Wq1Ml+C0DErG179m+d9KRWkGnGEp4z1iCQdq5SfA+kCjbXklhf7
	 MeOCUzRa9A1kQ==
Date: Thu, 29 Oct 2026 15:15:29 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Nathan Lynch <nathanl@linux.ibm.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1] seq_buf: Add seq_buf_create() to implement
 DECLARE_SEQ_BUF()
Message-ID: <auNRKk_IaN8kBPiS@devuan>
References: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
 <20261028211227.2b644f2e@fedora>
 <auMtYh5eJKLjrubA@devuan>
 <20261029094156.141f8c54@gandalf.local.home>
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
	protocol="application/pgp-signature"; boundary="sdexaymik3sw4xva"
Content-Disposition: inline
In-Reply-To: <20261029094156.141f8c54@gandalf.local.home>


--sdexaymik3sw4xva
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Nathan Lynch <nathanl@linux.ibm.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1] seq_buf: Add seq_buf_create() to implement
 DECLARE_SEQ_BUF()
Message-ID: <auNRKk_IaN8kBPiS@devuan>
References: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
 <20261028211227.2b644f2e@fedora>
 <auMtYh5eJKLjrubA@devuan>
 <20261029094156.141f8c54@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20261029094156.141f8c54@gandalf.local.home>

Hi Steve,

> Date: 2026-10-29 09:41:56-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
> On Thu, 29 Oct 2026 12:33:19 +0100
> Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
>=20
> > > > diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> > > > index 9f2839e73f8a..facc5643c049 100644
> > > > --- a/include/linux/seq_buf.h
> > > > +++ b/include/linux/seq_buf.h
> > > > @@ -25,10 +25,7 @@ struct seq_buf {
> > > >  };
> > > > =20
> > > >  #define DECLARE_SEQ_BUF(NAME, SIZE)			\
> > > > -	struct seq_buf NAME =3D {				\
> > > > -		.buffer =3D (char[SIZE]) { 0 },		\
> > > > -		.size =3D SIZE,				\
> > > > -	}
> > > > +	struct seq_buf NAME =3D seq_buf_create((char[SIZE]){0}, SIZE) =20
> > >=20
> > > It can't use the DECLARE_* name as that is by default something that
> > > can be used outside of a function:
> > >=20
> > >   DECLARE_SEQ_BUF(foo, 1024);
> > >=20
> > > Needs to work. Just because nothing does that now, doesn't mean it wi=
ll
> > > not happen in the future. From my understanding, all DECLARE_* macros
> > > for other types work this way. =20
> >=20
> > Hmmmm, then I would like to remove this macro entirely.  It is not
> > possible to implement it for a structure that has '.p' and '.end'
> > without a function call.
> >=20
> > It would only be implementable with constexpr (or constinit? C++ has too
> > many constsomething things that slightly differ, and I don't know which
> > is which) functions that can be called at file scope, but those don't
> > exist in C.
> >=20
> > Would it be okay for you to remove this, and perhaps replace it with
> > direct calls to seq_buf_create()?  Maybe like this:
> >=20
> > 	#define SEQ_BUF_CREATE(SIZE)  seq_buf_create((char[SIZE]){0}, SIZE)
>=20
> No.
>=20
> Honestly, you haven't convinced me that the pointer logic is any better. =
It
> looks to me that it may be just be moving the complexity elsewhere.

The complexity doesn't move elsewhere, IMO.  It has an issue with file-
scope initialization, indeed, because derived pointers cannot be
constant expressions, and thus this precise problem, but other than
that, there's no off-by-one-prone edges in that design.

However, I understand the fear, so I'll try to prove the simplicity
before asking you to trust me about it.  (I guess by doing a full
conversion, and showing that the diff reduces code without showing
corner cases like the bug we're discussing at the moment in the other
thread.)

> Yes, using indexes can be error prone, but if you keep all that abstracted
> out to make sure you can validate that it works, it should be fine. Nothi=
ng
> that uses seq_buf should care about the internals.

Actually, there are a few places where those internals somewhat already
escape the API.  For example:

	avail =3D seq_buf_get_buf(s, &buf);
	seq_buf_init(&ns, buf, avail);

could be rewritten to use a single function (we can already do that):

	seq_buf_get_tail(&ns, s);

This way, we don't need to have a temporary 'char *buf' that we don't
really need in the caller, and we also avoid inspecting the available
size.

This could be done already with this:

	diff --git i/include/linux/seq_buf.h w/include/linux/seq_buf.h
	index f006f2654e4c..f7ee062374bf 100644
	--- i/include/linux/seq_buf.h
	+++ w/include/linux/seq_buf.h
	@@ -58,6 +58,16 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned int=
 size)
		seq_buf_clear(s);
	 }
	=20
	+static inline void
	+seq_buf_get_tail(struct seq_buf *tail, const struct seq_buf *s)
	+{
	+       char *p;
	+       size_t size;
	+
	+       size =3D seq_buf_get_buf(s, &p);
	+       seq_buf_init(tail, p, size);
	+}
	+
	 /*
	  * seq_buf have a buffer that might overflow. When this happens
	  * len is set to be greater than size.

> Using indexes should not
> be a point of failure as it's not extended outside the scope of the
> internals of seq_buf.

Except that many places do look at the size by looking at the return
value of things like seq_buf_get_buf().

> That is, once you prove the internals of seq_buf is correct, then you are=
 done.

And also except that you still need to prove the internals of seq_buf,
which aren't exactly trivial.  With pointers, those internals become
simpler.

I have a draft for moving to pointers, and it cleans the implementation
quite a lot:

	 include/linux/seq_buf.h |  86 +++++++++++----------------
	 lib/seq_buf.c           | 101 ++++++++++----------------------
	 2 files changed, 66 insertions(+), 121 deletions(-)

(It's far from ready.)


Cheers,
Alex

>=20
> -- Steve
>=20
>=20
> >=20
> > 	...
> >=20
> > 	int
> > 	main(void)
> > 	{
> > 		struct seq_buf foo =3D SEQ_BUF_CREATE(1024);
> > 	}
>=20

--=20
<https://www.alejandro-colomar.es>

--sdexaymik3sw4xva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrjVPsACgkQ64mZXMKQ
wqlQNQ/9G3tyhNvG01ZB2dAmV5WS6uTrIUpvyfdWFh/2TZtb1XKAr/MC7R5euu5C
8gYhHz58BJh61+hX49OGVvjC/ZPLeS8P9qpfEA9RJYx1hnbwVyIK1J4SzKBOII03
m9JLs7J/Byj/FyRSxK8J7eioT8OUC1/+PtvE1W2Nn1Cic8xE/OUQW/BqOXDtHUbN
5mb24nfG1mgniaiwgEKPSDg/re+6PJRiUY+e/PnJyshIAT/bwht0PKf1v4madPkd
mOg8det/jQGC3vdr+RUSbV1lS1Tf2pTLN5fTl9v9P/1uMbRJjHk0LuHufFBkjKTX
RA92Fl+6TRg0veT8yBYlJqNsjNUURXTz/MXCB6ae7fu6x5pH9Cz8YVs3roP3dFqq
n/MGGJa+5oHzhdoBRuLsVZHXM6U0So+5WT+LCbTuS7ldGCvxg1nrmu+5USCyfau7
XQxNItPFEwTXlrHBaKDCn1IST7GORXvBB4bvLx0XBiWuf6bsnRPJPHMhYohbaQ0D
HcTSYwwpeZBruj/NV4LTiSaZ3zpJ1dPOgxJybYDAPNo451O2OJX0FlacEBzmTeht
42k/z03vskljdbOv1M9dDxTDu6aAKUyYpB9IRt57Y9eyBbVKN4y95iwYnXdD66BX
Xkj6kG3DQ6jgzfZSKiHGYIlCjcVC0rmkZOpSNXaePZCsjvGloHE=
=SkcT
-----END PGP SIGNATURE-----

--sdexaymik3sw4xva--
