Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273604;
	b=U0/0WOLQYXv47uH7BfckVZ2whZjtjnA1eLci3Cux25b0DcCH9j1dHVMSdOOHCpIgzCqI
	 mnoLkqhvHyBn0MXxlbSqJX6yn1hAzVd8MwY+P//A/uezXi/cwQCMFqY0YWx4M3C/02TPV
	 3x8f68oHnk2CWQJAXneN8gHjcQHMmDAY3QLx5eu3kg1miw88NIMZTQJ2YkbNQiqE3yAR8
	 2v1esRhicZIS6JxY5HncBBWv5JnYte14FD60/3eQBbvygncicMaEMTIv8r/Q9Jm5I7RBr
	 GbmhahHSaWfysH5ZS7CPAJ7MTAgga3dIRPxfegILC8/wEh/1pyLL3Z5KQXIfkRydnAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273604;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fvwak73bAaifO/wH29kOPiLW5bXpWdkqExXINtM4Reg=;
	b=dWgUe3ThGL1nJzK5RmI3q12rAToTA/4p+ESwK05QeLdp0tHc/rnA7A1YxJZOOZ6q44dY
	 QiWLKIv6IJ23MwpHYZfakiNLXFCqpUu1cqtlyO4JDbCaj4sg8v81EdK9G1d3rxLaKKnyQ
	 Hkq/hH4JQX92xzLTvTnyQNdCGVX/J03jQf8dRH+Zs3PoBRhaEUq1kGqIZKMK12OpH9JP/
	 UjUHXEgkkXUXS0uTUJVZoUk4MA1BKB3NycrZFmYzwtw/JYcGx43LsitGGt5oOwFhHZa/9
	 ucp179HkfOY/CQ9Q3nKLNoOZ+lQmk9e3v80bRFBDabqKTpce4SFZgg/qsr2I0BGSe0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPr06r99;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB098606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPr06r99
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B78E1F01825;
	Thu, 29 Oct 2026 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793273603;
	bh=fvwak73bAaifO/wH29kOPiLW5bXpWdkqExXINtM4Reg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nPr06r99/NlD/qukkQUMrKexFzW4VumTm4jB4rQQvh1dXJwPmDw+t9pnpmd8ev8m0
	 Fc3kxvxovkksNSWHrzm8ZDFYNRLiIqFhSU7YACNOBB9JfDjBBHKeTWC4BV9AuhoZ79
	 W1uc+yf6C/BY4hEeKFjPo/+Xr36ZTi8tAbgi4muKvYCzDruU5C+ggT4YWSOVjhCU1o
	 N7MBdLPBPYb7GEVCFkTuawXm8y/DIWmp297mfSjUr87RP4XmGQ+z2fbHsgfewFWKU/
	 hnlviqhspmhHBM6UmzFfEumMwNGYr4zb2zPGUf7Qww/5Nfsb/Qm4rj7OWlom/4484d
	 mH0sTgsV3BxTA==
Date: Thu, 29 Oct 2026 12:33:19 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Nathan Lynch <nathanl@linux.ibm.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1] seq_buf: Add seq_buf_create() to implement
 DECLARE_SEQ_BUF()
Message-ID: <auMtYh5eJKLjrubA@devuan>
References: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
 <20261028211227.2b644f2e@fedora>
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
	protocol="application/pgp-signature"; boundary="ucst3yndbhwf35xy"
Content-Disposition: inline
In-Reply-To: <20261028211227.2b644f2e@fedora>


--ucst3yndbhwf35xy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Nathan Lynch <nathanl@linux.ibm.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1] seq_buf: Add seq_buf_create() to implement
 DECLARE_SEQ_BUF()
Message-ID: <auMtYh5eJKLjrubA@devuan>
References: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
 <20261028211227.2b644f2e@fedora>
MIME-Version: 1.0
In-Reply-To: <20261028211227.2b644f2e@fedora>

Hi Steve,

> Date: 2026-10-28 21:12:27-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
> On Thu, 29 Oct 2026 00:19:24 +0100
> Alejandro Colomar <alx@kernel.org> wrote:
>=20
> > This implements DECLARE_SEQ_BUF() in a way that is independent of the
> > members of the structure.
> >=20
> > This will allow transitioning to a different implementation of seq_buf
> > which uses pointers instead of sizes, on which I plan to work soon.
> >=20
> > The compiler should be able to optimize this out and produce the same
> > code as before.
> >=20
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Nathan Lynch <nathanl@linux.ibm.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >=20
> > Hi Steve, Kees,
> >=20
> > This is a patch that I could split from the rewrite using pointers, so
> > we can apply it earlier to reduce the later diff.
> >=20
> > I've built a kernel with 'allmodconfig' to check that it's okay.
> >=20
> > The reason I need this patch is that we can't calculate the end pointer
> > of the compound literal without passing it to a function.  If you want
> > me to hold this patch and send it together with the rest of the rewrite,
> > I can also do that, but I thought this might be useful by itself.
> >=20
> >=20
> > Have a lovely night!
> > Alex
> >=20
> >=20
> >  include/linux/seq_buf.h | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> > index 9f2839e73f8a..facc5643c049 100644
> > --- a/include/linux/seq_buf.h
> > +++ b/include/linux/seq_buf.h
> > @@ -25,10 +25,7 @@ struct seq_buf {
> >  };
> > =20
> >  #define DECLARE_SEQ_BUF(NAME, SIZE)			\
> > -	struct seq_buf NAME =3D {				\
> > -		.buffer =3D (char[SIZE]) { 0 },		\
> > -		.size =3D SIZE,				\
> > -	}
> > +	struct seq_buf NAME =3D seq_buf_create((char[SIZE]){0}, SIZE)
>=20
> It can't use the DECLARE_* name as that is by default something that
> can be used outside of a function:
>=20
>   DECLARE_SEQ_BUF(foo, 1024);
>=20
> Needs to work. Just because nothing does that now, doesn't mean it will
> not happen in the future. From my understanding, all DECLARE_* macros
> for other types work this way.

Hmmmm, then I would like to remove this macro entirely.  It is not
possible to implement it for a structure that has '.p' and '.end'
without a function call.

It would only be implementable with constexpr (or constinit? C++ has too
many constsomething things that slightly differ, and I don't know which
is which) functions that can be called at file scope, but those don't
exist in C.

Would it be okay for you to remove this, and perhaps replace it with
direct calls to seq_buf_create()?  Maybe like this:

	#define SEQ_BUF_CREATE(SIZE)  seq_buf_create((char[SIZE]){0}, SIZE)

	...

	int
	main(void)
	{
		struct seq_buf foo =3D SEQ_BUF_CREATE(1024);
	}


Have a lovely day!
Alex

>=20
> -- Steve
>=20
>=20
> > =20
> >  static inline void seq_buf_clear(struct seq_buf *s)
> >  {
> > @@ -45,6 +42,15 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned =
int size)
> >  	seq_buf_clear(s);
> >  }
> > =20
> > +static inline struct seq_buf
> > +seq_buf_create(char *buf, unsigned int size)
> > +{
> > +	struct seq_buf  s;
> > +
> > +	seq_buf_init(&s, buf, size);
> > +	return s;
> > +}
> > +
> >  /*
> >   * seq_buf have a buffer that might overflow. When this happens
> >   * len is set to be greater than size.
> >=20
> > Range-diff against v0:
> > -:  ------------ > 1:  9bda534b33f0 seq_buf: Add seq_buf_create() to im=
plement DECLARE_SEQ_BUF()
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--ucst3yndbhwf35xy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrjLvkACgkQ64mZXMKQ
wqkPtg//Wn4LZMMzyZEDNw6wd6QKaeOVvRajdMtPELavgp8cfpLUp5Anrr330NqL
F8r2GbVCIg1vTJhUOG5U/Ir3XdoXVtfxTqyHxHV+esJooRKhX25tJVKD45sQNuCA
MR2hA4Os9H/t/NO6NPapiWSe1VdAwv0sRB24plA5IV/KMrQP+3s0NOX5dVdiROhy
RqcNWSPycuPA+WuvvDoSWRUpHc9hh4rDiDTzb7Kzs7tY/fwyA+ZRCBcnCmPrlgfB
1jRZ4rDE35Uv5pgk/1+U7Sznp+m0/uJMobCR1LZcL9+ld9KQ8Fpc1j0IXk6NMh9j
ELE3OKszY5m0kl9ubc+CTDnZox/wSnJuujimaP7Jc9eI9v5hng6ZjJA2vmKrTOGl
/+S7ii/PldoxW4P9d35fuztL8Wg9eG+6IrfaysR0ccEQx/RnLZoNAogaE621PHsI
YxQ/EaC/YlAOx+0DQbu/DXT+KTd4tvfzkF9YpH1M8Gjatsn1lGEacSVU4+bTP+yQ
TzIa7hBaqoKvoxPwiXVrlYdZLXNrokPcCDR9hhAabWB3m/Ixlavt9q8JlTysg2zD
PzCCQTRvWh6QV0dW0gbu+Tp9fSbT7DAqyF1i3i9PW2j1hwKJSyYnZLW6K3LK4mFk
/ATUHyiGQ6VCSTzSKtimBRLpojT4JodRRyX3us7yoTRF3Vfausk=
=CIDo
-----END PGP SIGNATURE-----

--ucst3yndbhwf35xy--
