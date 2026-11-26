Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696364;
	b=pFUMt/GVUDN25yQtDFHl9HnlsdthuuLqu1tllewndOefqQAWRuqcVV/Df+Uln310f5+S
	 SROrRhV5OxFTAYf1jrVqdYRnbVsqBg3z8sO5YV0+4y8Z6V6jcEQ4e6HiYpIbE/K+Ubb0g
	 iX4Lxm4UcJSi6Sjkr6aXwTZrLiadhE1kuSTHuCzzMlFPUxixIeIHY+IvMHimUhdqycqz0
	 D8rZmDEkCnyFF3eIIfpeAfQY0JAmCrxqVJzlXw0l17RL0SxtyJccy/pjw2KTBKVsZVyo6
	 6vApAdjlRxBxdLUGs5w0y0w6YPW5IeB1IdD0AynHjON9ZZj2F/4T2ZoQQgO337SYXxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696364;
	h=Received:DKIM-Signature:Resent-From:Resent-Date:Resent-Message-ID:
	 Resent-To:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rJWhzNIL+tj4n4QlY+VSkAlQ6BFrtzxrqxx3lX6uxZE=;
	b=oFWKbwfnFTLbib7Jjea7g+6ga1yOB5S90PxfzsbuWn38u1JB43qiV3CUoJJfNWxi8PMM
	 PxuU6YSIEZvYD0ueHl2X5vzCNccUVXunrAeKHjIhIoE0xLmb/6qJBaPaBA30hH3ioa+06
	 fLgn290WUdCeAVO8K9V7Ddxtxi3orIaa+xRA5HWPJycGjuh2jIPV7uPzYTkrA3lWLk/9T
	 LHYHHsK7kmY8G7GYZX3zaZlEdDR+l7OLdZwh+2g0Kj21CM31WfzbDPSjenoON+b7IEKcj
	 DAqeV9tZxNwFPYXAh6dHTrHfqWRB9nvf7imHYJSDvWlh2mSohcoYutPasRbW7pLKkZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwvgAu4r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEB606A31C
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwvgAu4r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918051F000C4
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 12:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696363;
	bh=rJWhzNIL+tj4n4QlY+VSkAlQ6BFrtzxrqxx3lX6uxZE=;
	h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
	 References:In-Reply-To;
	b=YwvgAu4r11kIr5+GaPfg1Np9LpEqaW8mnJ3IgbOlGYimbTltb9ZB8nJQCvfdLbjEI
	 Gz8IVKCG2K9b5KuchWWAEvb5hMP7a1Shv7ffekMKjMh3uPweUdfcXOvqXkEoG6sexj
	 udJOzcmlqJG4AGnAe3FDp2X8YlWENru+Shy02+V4DdMxYEhblvfwT+2XWsQ8vAa7WT
	 l1fdM6NEGs/undxXGl/tnjBLCsjtxXKsNaD6a96H8k9LmKsr0l8+LO5hxy+N7qjR6l
	 kb4quBcqoFwUfbAZwL+PUDsEOCrD5jJd/tqgrcax2jsUTwKhs3xpVwSBimx32FtbSZ
	 iPhAsZzO7zUCA==
Resent-From: Alejandro Colomar <alx+linux-hardening@kernel.org>
Resent-Date: Thu, 26 Nov 2026 13:32:40 +0100
Resent-Message-ID: <awgm6IM5911TkRNw@devuan>
Resent-To: linux-hardening@vger.kernel.org
Date: Thu, 26 Nov 2026 13:32:21 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Alejandro Colomar <alx@kernel.org>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 2/4] string: Add strprefix()
Message-ID: <awgmuC_BnyaEpTXD@devuan>
References: <cover.1795695151.git.alx@kernel.org>
 <a688f0a1c20afadeed42ec4645b44de75874c223.1795695151.git.alx@kernel.org>
 <sashiko-outbox-235501@kernel.org>
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
	protocol="application/pgp-signature"; boundary="k7ucbsxvgidvmt7j"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-235501@kernel.org>


--k7ucbsxvgidvmt7j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Alejandro Colomar <alx@kernel.org>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v8 2/4] string: Add strprefix()
Message-ID: <awgmuC_BnyaEpTXD@devuan>
References: <cover.1795695151.git.alx@kernel.org>
 <a688f0a1c20afadeed42ec4645b44de75874c223.1795695151.git.alx@kernel.org>
 <sashiko-outbox-235501@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-235501@kernel.org>

> Date: 2026-11-26 12:27:03+0000
> From: sashiko-bot@kernel.org
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] string: kernel-doc parse failure on strprefix() due to
>   __nonnull_args()
> --
>=20
> commit fa176bccb75ab1dcd9cc8e153bcc5112c790bc7c
> Author: Alejandro Colomar <alx@kernel.org>
>=20
> string: Add strprefix()
>=20
> This commit adds the strprefix() helper to return a pointer after a match=
ed
> prefix or NULL on mismatch, along with KUnit tests.
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
> Does __nonnull_args(1, 2) break scripts/kernel-doc parsing for strprefix(=
)?
>=20
> CTransforms.function_xforms in tools/lib/python/kdoc/xforms_lists.py does=
 not
> strip __nonnull_args(), so kernel-doc mistakes __nonnull_args for the fun=
ction
> identifier when processing include/linux/string.h (included by
> Documentation/core-api/kernel-api.rst), emitting prototype mismatch warni=
ngs
> and omitting strprefix() from the generated documentation.

As said in v7, I don't know what to do with this.  Any comments?

--=20
<https://www.alejandro-colomar.es>

--k7ucbsxvgidvmt7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsIJssACgkQ64mZXMKQ
wqm8nhAAlDnI2SX/pzG4A5z92tvcaAP3Zkh01E7VF+Swtfsdb0Us3udPKvbbH1i3
+GPzfdlZRVsZ/if/5Z+e2mNcouGDacMYtgE+i3umcBjYFNBN1byZrH7Cuth8R6wM
OVLMmbncQ/Q5xFyhlLDn2mqFbrtq4Iwx9E+LO9hpwPoi7w08KPZz5WCOG8lRxOM4
a9CoiUchqO+l+MU1mIqd2w0wbXwLgZQshB3RvV5ZKXQyah9VXHHqP8LjUj34/L3x
dLAyY+ngK6QgejrmbiyMomMM5H1Jx0mA++w3dY/+wu2OPwQeiKHkCd50c3rCJfVw
yjo6/nQs3rBMSzuhlUFWQxWpx47mMmsVaM5Oo1+G/YtqfoJBGr2VgvokXCN8hTqr
o5lUJ7baHSBX39LxnlBYtoZonjnUzooM49Z2011QkU6h58JYbOFNAftTvN1O0CxY
ibstTfTP1Q3YJAWsmtwDBeyCUsGwaCYXIJC7P0Bi9IOUXpdakHeOrHxAB6idoAj6
eveJyCfEhA8U4xTx8ZYiioB9KluSkv20YhRsPjaoneB74F8BB6hxIHmhQqfFhzWq
L2FwBwsCmVVUqwLFi2CcNc+qsMNAqfNYS0cUeQER/A4QoX92ExgCaLKasfoqC/g/
9Bh+Tx32AFIyRQCGMfNYosjEheSeo85yqANoJuIObArN31RvGek=
=ZLY0
-----END PGP SIGNATURE-----

--k7ucbsxvgidvmt7j--
