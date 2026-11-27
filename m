Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795740720;
	b=RMcRYWX1CGaJm7KAFCsZJQLzq8pn+jPoIITw4OwrsGW1DUtvrg3wbUG9GaBhpWfCm4A4
	 kHVf789pCRi2VN3IClFB/4NN8Dv9aZid5tgnCnTZaDmc3TbIkusuCE4voxyKhWJjyBe8N
	 N6ewbB7QGXYwnnVPb8VoapOLBYNpFCJh9uFX4P4ifwhJ85nocgP6wrGkFkL7ZTqH7q2do
	 FIGSs9WwWETnvmep0TP0dEHyNRczJTHcMeObleoo1yiWk0EtgX2izZWnmR9ZOfinfnmC+
	 hr/5aaJNuvJF1GBIoZtBlbekgmRBHNCn0iyNqB33PTZR3/wPullgUWIEOBsjNJrThKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795740720;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2mXKxVp3q1BXtyC7GEBY2jXhHxkGBgswcQNGlms/6J8=;
	b=tkiP22xZ1SUkyNXuCc+N7qTOiaf52hUZjn3KeD7pBvQvZ/Rfh65BEBCzQvzDx95nUbac
	 G8O23MXG6iLjemifcHp+EmA+kKZfjVFlmn9dCWRMqL92/jMipfr4pIFVs0k/LTK73+5vv
	 KqDfNi8I5puxf3IJZnGVhCOKsBPTh2gGtz+l8tkopc2EqgpAM7Q2hygCcwu3mTVS9hgv3
	 Fasz5WVxv9KFiy+E+1Qw/G5HQkm364EgR7pzTBl4MNVX2jSowVZk+VPAwr3mfEj1LomLB
	 dleK5fFOVqPrJPBAlJGhb5bWKKmmUzqDoppIPpGDMJ4Cy6jGGlQJGRH7IdzzrMTZMLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPt3oJjw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77931606A31C;
	Fri, 27 Nov 2026 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPt3oJjw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8539A1F00893;
	Fri, 27 Nov 2026 00:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795740720;
	bh=2mXKxVp3q1BXtyC7GEBY2jXhHxkGBgswcQNGlms/6J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dPt3oJjw0A/ME05Dmt3Pm3WQghXy1GbsgMVVikokYqaNbSDLM2cduRiK17JLrVxQR
	 k9oU1VjR5qLpn9eLpOu3kihE952FK8rEgd9M0UcFs7UXZvcZaagtOw3iU3iL9x0lFr
	 1AIFgPAxeMYlSlubxOlV4VBMVc1FlyGfFgVqT1hrvk2CxpxmtxbJwfMkM15mXpQIHJ
	 juENld81TGIUo6umFXou3prRpxSGlatICxMCQWPLmfTeNT55fvUdZGr9StjrBVeNPV
	 9+r2jf6OJfujGxqy7m7nFA8KIHzdttqpyOeTNt5Dz7lHtKfOIMXF0g3bgers6B/Xpw
	 SZPgX422lEHCA==
Date: Fri, 27 Nov 2026 01:51:56 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Alejandro Colomar <alx@kernel.org>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 2/4] string: Add strprefix()
Message-ID: <awjTa1qL5c1L9pnj@devuan>
References: <cover.1795695151.git.alx@kernel.org>
 <a688f0a1c20afadeed42ec4645b44de75874c223.1795695151.git.alx@kernel.org>
 <sashiko-outbox-235501@kernel.org>
 <awgmuC_BnyaEpTXD@devuan>
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
	protocol="application/pgp-signature"; boundary="ztitlnbzcvr2amzm"
Content-Disposition: inline
In-Reply-To: <awgmuC_BnyaEpTXD@devuan>


--ztitlnbzcvr2amzm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Alejandro Colomar <alx@kernel.org>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 2/4] string: Add strprefix()
Message-ID: <awjTa1qL5c1L9pnj@devuan>
References: <cover.1795695151.git.alx@kernel.org>
 <a688f0a1c20afadeed42ec4645b44de75874c223.1795695151.git.alx@kernel.org>
 <sashiko-outbox-235501@kernel.org>
 <awgmuC_BnyaEpTXD@devuan>
MIME-Version: 1.0
In-Reply-To: <awgmuC_BnyaEpTXD@devuan>

> Date: 2026-11-26 13:32:21+0100
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
> > Date: 2026-11-26 12:27:03+0000
> > From: sashiko-bot@kernel.org
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue to consider:
> > - [Low] string: kernel-doc parse failure on strprefix() due to
> >   __nonnull_args()
> > --
> >=20
> > commit fa176bccb75ab1dcd9cc8e153bcc5112c790bc7c
> > Author: Alejandro Colomar <alx@kernel.org>
> >=20
> > string: Add strprefix()
> >=20
> > This commit adds the strprefix() helper to return a pointer after a mat=
ched
> > prefix or NULL on mismatch, along with KUnit tests.
> >=20
> > > diff --git a/include/linux/string.h b/include/linux/string.h
> > > index 9b3e578d9aca1..a6a1953c52e35 100644
> > > --- a/include/linux/string.h
> > > +++ b/include/linux/string.h
> > > @@ -557,16 +557,34 @@ void memcpy_and_pad(void *dest, size_t dest_len=
, const void *src, size_t count,
> > >  	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
> > >  })
> > > =20
> > > +/**
> > > + * strprefix - string prefix
> > > + * @s: The string to be tested
> > > + * @prefix: The string to see if @s starts with
> > > + *
> > > + * This function determines whether the string pointed to by @s
> > > + * starts with the sequence of characters
> > > + * (excluding the terminating null character)
> > > + * in the string pointed to by @prefix.
> > > + *
> > > + * Returns:
> > > + * *  @s + strlen(@prefix) if @s starts with @prefix
> > > + * *  NULL if @s does not start with @prefix
> > > + */
> > > +__nonnull_args(1, 2)
> > > +static inline char *strprefix(const char *s, const char *prefix)
> > > +{
> > > +	size_t len =3D strlen(prefix);
> > > +	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
> > > +}
> >=20
> > [Severity: Low]
> > Does __nonnull_args(1, 2) break scripts/kernel-doc parsing for strprefi=
x()?
> >=20
> > CTransforms.function_xforms in tools/lib/python/kdoc/xforms_lists.py do=
es not
> > strip __nonnull_args(), so kernel-doc mistakes __nonnull_args for the f=
unction
> > identifier when processing include/linux/string.h (included by
> > Documentation/core-api/kernel-api.rst), emitting prototype mismatch war=
nings
> > and omitting strprefix() from the generated documentation.
>=20
> As said in v7, I don't know what to do with this.  Any comments?

Bartosz reported that this is solved in linux-next by the following
patch:
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/?id=3Db6b0adb6c845>

--=20
<https://www.alejandro-colomar.es>

--ztitlnbzcvr2amzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsI1CwACgkQ64mZXMKQ
wqmf6A/+M9qVTeSuF7m1sBGEx8AURawJb9yFeTyLIGEhBslR1kxB6ek+Ov7xTc5b
EeHQ4BoOnBtAytdwvAQ5cwcEmEoCfSJY7QXd51HSxx8TmReKqNUBRjzZykvEeD9g
O5erP31Km6v3ovdP3TWHe8XZqYuOrIlt/RcpRYXn/X+N3TqHz/CMXKvsBih3Mz2M
s3sWX97ZzplbBNrJlm5fW13bNrGY5eSLA3V7D65i7kQXqeIDbKpwD/RQDIyLlrUn
TY0JXFPYHQPrVUCpRJZhFR5QI+xkGxNafKIaNcaT9RtebuIlnhtutHNSnZwELG4R
qeA1bz6NhqWXERaEAYTR9VAk9BsiGOcgC50EoqV0JG9hGYVq9e5KapXbQgM93AYy
QLWkPGJm2pcGPtqmQE2EbcdjQq1lAzzBE+3WlAN6K7vo61qwLr+gDBZIR2ikkPkN
haoP4UnrygxptSWEkJjWuATBTSKHT8vUJnkeSwKmwnAKLISgz6a7pwdePbGOAziP
9mpeLJNJOkqVtCi/hTbPa786SDD4zOG9cLk2+jZr5L6ns7OpsUzxx8UrL6ihVdg6
qC8nmBIdcqioE89ipQzcEyKfgPskuPcHpCcbYuyDfsDSMONOvJ7HUX865QxmPiN9
XqEFHt+ergxZbbmcAn1EXauNNu4/UQgl0iuczsP++sJP0uH1O78=
=RbQI
-----END PGP SIGNATURE-----

--ztitlnbzcvr2amzm--
