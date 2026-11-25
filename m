Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645576;
	b=TT8gPoqPIBbqIZYW9DT1+E42GnqY/JAIhNekY5ltcsKPNjHL8xoydvveV7bRZrItTvaO
	 6O2RrRR4b8DEpffIeg7k5TRGubz2LbBx8v/8eV+un/bbZ5NCFw51Fvwk6N94voZbL2Hgw
	 VEEjqAcgyzuxHZDBvURiV68IzmfMw0J/JVOs92Y3ARuobnJU/mHhJ28P5+nUexII4Oims
	 lQneC8HsStiugBf3puC3jTB/rQup8ErjUsxHZaDd8Ka4RyhjNiPugzq0o5/E1ozreqCr/
	 D6WVMVdZbrik99ju7wRISaQCwjr/Jg1yFNZ7E/FsGs2lGWSXNJXOmsuWfdcelUZjxWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645576;
	h=Received:DKIM-Signature:Resent-From:Resent-Date:Resent-Message-ID:
	 Resent-To:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Ad4P++K9bZno9nuh/iuXN/ynLGwKsplQDt7xu5Ult50=;
	b=Lur5g+/fwPl47IwgUee8zfQWoC9K/qKo9Kjk0HOIdDTEUOGCZZwjUlMl19S7a1yp0Sp4
	 L07ThxFodrYA1H39RkrHY+nnkZf7ClgP6T+zqGWRTKhW8eGL4zauTkcEFYWsPYwd2+Ao5
	 x+g3rR2qB+JjtkUKL06jO4THiWxTcQPM3wS15VwqlAJrl2jPdNBlVYm7ULW5kRsSltHzH
	 EHahc4G6IJ77vesl9VaxQdQuMRoLDd1cKpFuCMaphNrTxeo+pMsnShga0e14utbu7o3+T
	 L5ivWIlAu63SQtU0D0Gs2gxJ43p26Ah2qQF8jaNBy1X5gyixbOexgzD3xjJ6I/kKrLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngz+mJyD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336A606A69E
	for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngz+mJyD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584541F000D4
	for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 22:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645575;
	bh=Ad4P++K9bZno9nuh/iuXN/ynLGwKsplQDt7xu5Ult50=;
	h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
	 References:In-Reply-To;
	b=ngz+mJyDb81j2SGUZ0pABZZuIMjF/HqF+1OxRkDyQhDpT4lMNAMWrmIM9DMdemQSW
	 LaiYlexH9khIHvPPr50Uj3R0g1T09zwFPh/lSV00CRKrsGsUrrBtZSkJvlg3ooYmWq
	 /UJEx9j8o8kRlEpD7KHRUEcwfyTGDQEHmg2AEHgnvjB6mz/cNws8X3kp6fUhY93pi5
	 g+OpCM2DNBYYsOjTHqnzJZiboj5j5rMuPeG+HzMH/jFEQYJob+cssJEOwrJCnbq1z9
	 LtA3s0XWMdR/Ezq9Wpic4RbcGMRMZAhOCJqrtmt5bn4PQCbeJDD426lmkCZ53oZ9mN
	 JGB/yTuuigBbQ==
Resent-From: Alejandro Colomar <alx+linux-hardening@kernel.org>
Resent-Date: Wed, 25 Nov 2026 23:26:13 +0100
Resent-Message-ID: <awdghW50TxXlrOn-@devuan>
Resent-To: linux-hardening@vger.kernel.org
Date: Wed, 25 Nov 2026 23:25:51 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Alejandro Colomar <alx@kernel.org>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 2/4] string: Add strprefix()
Message-ID: <awdf5dYKbpkbjSif@devuan>
References: <cover.1795639368.git.alx@kernel.org>
 <b32d70163fb454fee2667548c63c4d4d3b19d7bb.1795639368.git.alx@kernel.org>
 <sashiko-outbox-234163@kernel.org>
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
	protocol="application/pgp-signature"; boundary="6gr5d72eivgopjii"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-234163@kernel.org>


--6gr5d72eivgopjii
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Alejandro Colomar <alx@kernel.org>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v7 2/4] string: Add strprefix()
Message-ID: <awdf5dYKbpkbjSif@devuan>
References: <cover.1795639368.git.alx@kernel.org>
 <b32d70163fb454fee2667548c63c4d4d3b19d7bb.1795639368.git.alx@kernel.org>
 <sashiko-outbox-234163@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-234163@kernel.org>

> Date: 2026-11-25 21:11:26+0000
> From: sashiko-bot@kernel.org
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] string: kernel-doc parse failure on strprefix() due to
>   __nonnull_args()
> --
>=20
> commit d8e472e1906ee21263f127c3c8452f752cbf8121
> Author: Alejandro Colomar <alx@kernel.org>
>=20
> string: Add strprefix()
>=20
> This commit introduces strprefix() to return a pointer after a matched
> prefix or NULL on mismatch, and adds KUnit tests for it.
>=20
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 9b3e578d9aca1..a6a1953c52e35 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -557,16 +557,34 @@ void memcpy_and_pad(void *dest, size_t dest_len, =
const void *src, size_t count,
> >  	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
> >  })
> > =20
> > +/**
> > + * strprefix - string prefix
> > + * @s: The string to be tested
> > + * @prefix: The string to see if @s starts with
> > + *
> > + * This function determines whether the string pointed to by @s
> > + * starts with the sequence of characters
> > + * (excluding the terminating null character)
> > + * in the string pointed to by @prefix.
> > + *
> > + * Returns:
> > + * *  @s + strlen(@prefix) if @s starts with @prefix
> > + * *  NULL if @s does not start with @prefix
> > + */
> > +__nonnull_args(1, 2)
> > +static inline char *strprefix(const char *s, const char *prefix)
> > +{
> > +	size_t len =3D strlen(prefix);
> > +	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
> > +}
>=20
> [Severity: Low]
> Does __nonnull_args(1, 2) cause kernel-doc to fail when parsing
> strprefix()?
>=20
> CTransforms.function_xforms in tools/lib/python/kdoc/xforms_lists.py does
> not strip __nonnull_args, so running scripts/kernel-doc on
> include/linux/string.h (included by Documentation/core-api/kernel-api.rst)
> treats __nonnull_args as the function identifier, emits prototype mismatch
> warnings, and omits strprefix() from the generated documentation.  Either
> __nonnull_args could be added to CTransforms.function_xforms or
> __attribute__((nonnull(1, 2))) could be used as in strends() below.

What should I do?

--=20
<https://www.alejandro-colomar.es>

--6gr5d72eivgopjii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHYGsACgkQ64mZXMKQ
wqlpKg/9Eg0tDNXXExM29Z6o0EEbgZkPiV8zGzA+W2gFStSX2ytVV5p/W0iWfitx
rYaH++VwGTz1qUip3YjGMhVUtAC6sFpVCoEO/dMUuP45kcAKOdsxQwoFnFI2ABRz
lNdQO1Cq3sgRH6IHf33aOEyo3HXRdhFHccoM68forOp6eH18j8ZU7Wa0eOEiiqXM
e8zsso5oTGGssXsd69kxXCrZ23Nba1UmYmKNg38lbDdwYAVjZQmB9p/2lO/gCKK1
E5gqbonvrJNcW7uIz5t9iIWZkH8+mzbrt6gMW2SXnoC24hh2nFOh6zBK5uZrCwdB
x10XKPa6VwJrG2l7vwHynwFocImWWXsdrTZ+xsFnPOXncoT0WLdA3zjEAApPkiSO
JOU2GLjfttDsJ+7FsIsCEflTq1U6TjCOXk1qeGydizVm6PXl9V0Qq/h2SVklxQb5
j/eOyevhRvR4gZ81bhqk0hsYw1xgNbMoN//5jH58h5nHt9AglfBVNqDV5RReYqwN
kPwS936GvfyHY9PWLZC78gtlLWcesv1y3DYaHMezHAGU4V48mKWtvDCYZx2ZFSr5
qJHHlt+5nsf0wm50OlkLwK+IdG1f2U/XQVfIxg1sdsh/BpqTFBUOjc96ZjvB7fiu
+uAdetRMOsvgJsy1HkMp8v+zSaN4dfQGmFvjnbl5T4z/nozwLdQ=
=lbBO
-----END PGP SIGNATURE-----

--6gr5d72eivgopjii--
