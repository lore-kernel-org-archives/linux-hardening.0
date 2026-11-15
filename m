Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794759821;
	b=dlz60tKq0Vd4lTCGigevyqUl4x1l9q+OsjMTYDCla/7XD4o7JlNPcAraVWE9c66hRRkr
	 rLmEi5OUrigyAFN9V4k910/9x+QI7LOnN4iP/xHWxsI3phIlILbTV/09duC0f7vPRM0J1
	 lzPj/CUQwbWGPiCVjuBHCay0oAq/q23tii+F5gd9jrYMvbVfyHNp4wxt+M/2sacH5/Yjt
	 TNVcOzoKQLiQD2n6J3nlXodZbFHZ7ET3OVy2+mPVejdU2AyX4wiG6avfwfjss0Yi5PlQI
	 HLFhtuxavteL0y/aueIFv7zVuRE5sW77JWqWU95VtIcjH4xOwVyw9rhiQZYeFQubO8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794759821;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MxOvBed5GGE4Yq6nl8AVfIl0sUWw1AmYogyR7OLRNz4=;
	b=Ulq1el/AFGNsDpMOpPxiQvIzbE5ySJMQAvGJf+88d7BvhYE6S7RHnETyqzyH06Vhvfyi
	 8G2X4i5dXuWuovbG/kCUhd+di8TndeqAQVS8u/hgUr6SbsTEOZm8ewTdnXLM3OGenPBZp
	 j6a6rhxWo9rha39XR8avlQFETG3/EJZHBrMX69q+qz40IDrMnYulM13IBSTRPOp5zE7sF
	 LTayT9LiYXNpsOBO+o6+zWyDu5/4JfKExabB3yEni/PgIaE43YRWwfLjFjQ8kBOOPrI5S
	 EwfhojQUpE/ifVoJQYBejl0wdem1aAdTRB38xFResxRaALpfSDtv/OnRo0yL38c9e2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqzrH4rY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F1606A31D;
	Sun, 15 Nov 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqzrH4rY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4A41F000C4;
	Sun, 15 Nov 2026 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794759820;
	bh=MxOvBed5GGE4Yq6nl8AVfIl0sUWw1AmYogyR7OLRNz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aqzrH4rYlEfuW9A3xWkU/baXHkADNA8cR70sXjQl//kXt/DQYFhE6BGslKuvvAibS
	 bbRuR6PeqQjsYLBi5nGeaQI18EBA/4G8fSLIz5MWSdt4k8KZs4df7wPjbhbEMnBBnZ
	 E2XOgPedoIGRXBVKZllw/5cHn+ZJUmCViY4zCmZzMkN/37cjSkLj5xLJHEAOT3Vnw7
	 9vDNRS0CE4ZIYNwQ9dAJaSN8+2ZUL75MibnIKD5LAPr3DcDGu1sZCB7bcx+aBB6oLI
	 Gx5jzOm+hvJaLefF65jqz7ec/n/AYWevCCXwkd4vtBzOGK+Tv/QkI7L6Jkrn3lJ1Ie
	 hF6twFmrGiPMw==
Date: Sun, 15 Nov 2026 17:23:36 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/19] treewide: s/\<strends\>/strsuffix/g
Message-ID: <avnb5iabDyCnXxpZ@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <3cad861d30901777d9bdafec1ccf113e0a3fcfa7.1794667407.git.alx@kernel.org>
 <43c991a975d649c11706714e05ab9bd438e0d7d5.camel@perches.com>
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
	protocol="application/pgp-signature"; boundary="cjurcdw4ztz667rg"
Content-Disposition: inline
In-Reply-To: <43c991a975d649c11706714e05ab9bd438e0d7d5.camel@perches.com>


--cjurcdw4ztz667rg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/19] treewide: s/\<strends\>/strsuffix/g
Message-ID: <avnb5iabDyCnXxpZ@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <3cad861d30901777d9bdafec1ccf113e0a3fcfa7.1794667407.git.alx@kernel.org>
 <43c991a975d649c11706714e05ab9bd438e0d7d5.camel@perches.com>
MIME-Version: 1.0
In-Reply-To: <43c991a975d649c11706714e05ab9bd438e0d7d5.camel@perches.com>

Hi Joe,

> Date: 2026-11-15 08:15:52-0800
> From: Joe Perches <joe@perches.com>
>
> On Sat, 2026-11-14 at 16:24 +0100, Alejandro Colomar wrote:
> > Except for the changes to "lib/tests/string_kunit.c", this was
> > a scripted change:
> >=20
> > 	$ git ls-files \
> > 	| grep '\.[ch]$' \
> > 	| grep -v -e ^tools/ -e ^scripts/ -e ^include/ \
> > 	| xargs grep -l strends \
> > 	| xargs sed -i 's/strends/strsuffix/g';
>=20
> You should really use coccinelle (spatch)

For less trivial stuff, I'd go for a semantic patch, but given this is
a simple textual replacement, sed(1) seems simpler, and good enough.
Do you expect any differences between them?

> and this should probably be 2 patches.

Ok; I'll split them.  I'll first adapt the tests, and then the script
will work fully automated.

>=20
> https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar016.html
>=20
> something like:
>=20
> @@
> expression a1;
> expression a2;
> @@
>=20
> -	strends(a1, a2)
> +	strsuffix(a1, a2)

Thanks for the semantic patch!


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--cjurcdw4ztz667rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr53IgACgkQ64mZXMKQ
wqnvlw/9GPQ/Uu1KDN1uQRg7ZX1LZzWWCfY63mXANkNS9rSlFDH7buXW7DoT+vu2
31W/yM3up79VUUXQXXcmGDkWv8kjv0iPzFRT/aCeUZJaoHZ/hrANGmBOLnZdrgy8
nsSZue1C5sgZ2a0XiPQNI7dIk840+Nnu5orOfw9yOnW9ISrmz6SK6jl2X+hhsDfM
+au2Bq3H3sbnO1Bkgpcu221AgHz6JcJB5leM4FiDTxJ5jQJTSCmAedN/x+YN+Up6
p3yOeM9qFhmW+4ep4xDC2wsSwupcrjmueHlWM3gRKa9DLMmydyH3Y7OmHOSsaP0y
hXRcvBmQdtdL1ku3RwXaNWuXUWn6VwISJFCpQt/L+ut9EQYKe09bVAZmNIxb95od
Wpg42HwtU5W/Yd4NaGN9P/LJm6/neEqbcZORQKfJZAE0Bq5luKsOBlbsfKWlgO4u
GPZzrNICS3xKMtCqFh7wll6g5oAFXgzGC9M2Lh6VssrS822pwDqQt6aHfVnps8TV
KeGx8PlPWqtqbRU/HZ9lplS/VEyLlHj56J/yAqD3AInPCZZiDqgl6n79h7gaOWnd
jg9MwIY80i+24QmTmOmJwDbOm2BBuKuwvNiLn9wN9cRS2RQ1QUmvD1L62yNqHBNV
1JPlGnjTtR0uGtdMB8rsHx3vLQUD/687x+ehJdeTP+YQ3BFJqmE=
=wbQw
-----END PGP SIGNATURE-----

--cjurcdw4ztz667rg--
