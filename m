Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA026CE1D;
	Tue, 15 Jul 2025 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563302; cv=none; b=jlrEiCtREsbE+4BUK7jfqilpRAPrpeD02hD4fOoqcVW1MxVMQd/8Uf0akxIP31TR/1amRV70AofAHOOJra4+TvKJVGgXPJFYvuR5mW+GlH9dBlhWsEhxKasNwKWpJ7i19lqqRxKW3V9tjZJ3h0q6azd9x2S4lQKSZm0r3mF6DN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563302; c=relaxed/simple;
	bh=ZtiA5UaAo10PuFq9JB+iuvdAzJQmh2KZPxbpkCfnVKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VREzDda4llB91cb1ykvPH+naHDHBGNKdg0HwRZlj89+EtmkN46foYSsCkhz4+YwWr60TOLYErPPATVmZiqZD9h346Oj9B7Xtd4Y3t3Jia9nTMwUt/im7PW9TNdfTpn6gVGiyCXp37FFhMeJvHdCXyCSrkBRXskXa0dMQz3o0uM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP0IAAkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP0IAAkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79EBC4CEE3;
	Tue, 15 Jul 2025 07:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752563301;
	bh=ZtiA5UaAo10PuFq9JB+iuvdAzJQmh2KZPxbpkCfnVKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TP0IAAkR+uae0ksBiq7ASGeMFdtCf/dbiqAmqyydEjE2esjWnXae/M550GQq2ZpWB
	 ED3dS3hQxlpS6Nd/s/xKsZWeNivID86Np8+NLoiaPEn6oRsHuqog08KiealyUGcmvT
	 CDOCm6veFUcBovjuBmlGIQftqM1tqys/PQ3j8eiT1V2xNbAPqcSL5dRHWvx2NYUizk
	 a0XFqSoze9mhTlvgpmWS1R7ERajbtMGJ2ki4yqvAKG4QE1PqDU1B9E38qays/6UrBf
	 d1thz1nnsowj+k1RX+3Qzb8RW6YlvTCjEnkyxuZWkEiiXTcTkSnNbCrdg+2VapcVDm
	 HbAnDdCOo2p3g==
Date: Tue, 15 Jul 2025 09:08:14 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Martin Uecker <ma.uecker@gmail.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <3o3ra7vjn44iey2dosunsm3wa4kagfeas2o4yzsl34girgn2eb@6rnktm2dmwul>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
 <20250711184541.68d770b9@pumpkin>
 <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
 <202507142211.F1E0730A@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="42cidsdllbjeiguv"
Content-Disposition: inline
In-Reply-To: <202507142211.F1E0730A@keescook>


--42cidsdllbjeiguv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Martin Uecker <ma.uecker@gmail.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
 <20250711184541.68d770b9@pumpkin>
 <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
 <202507142211.F1E0730A@keescook>
MIME-Version: 1.0
In-Reply-To: <202507142211.F1E0730A@keescook>

Hi Kees,

On Mon, Jul 14, 2025 at 10:19:39PM -0700, Kees Cook wrote:
> On Fri, Jul 11, 2025 at 10:58:56AM -0700, Linus Torvalds wrote:
> >         struct seq_buf s;
> >         seq_buf_init(&s, buf, szie);
>=20
> And because some folks didn't like this "declaration that requires a
> function call", we even added:
>=20
> 	DECLARE_SEQ_BUF(s, 32);
>=20
> to do it in 1 line. :P
>=20
> I would love to see more string handling replaced with seq_buf.

The thing is, it's not as easy as the fixes I'm proposing, and
sprintf_end() solves a lot of UB in a minimal diff that you can dumbly
apply.

And transitioning from sprintf_end() to seq_buf will still be a
possibility --probably even easier, because the code is simpler than
with s[c]nprintf()--.

Another thing, and this is my opinion, is that I'm not fond of APIs that
keep an internal state.  With sprintf_end(), the state is minimal and
external: the state is the 'p' pointer to where you're going to write.
That way, the programmer knows exactly where the writes occur, and can
reason about it without having to read the implementation and keep a
model of the state in its head.  With a struct-based approach, you hide
the state inside the structure, which means it's not so easy to reason
about how an action will affect the string, at first glance; you need an
expert in the API to know how to use it.

With sprintf_end(), either one is stupid/careless enough to get the
parameters wrong, or the function necessarily works well, *and is simple
to fully understand*.  And considering that we have ENDOF(), it's hard
to understand how one could get it wrong:

	p =3D buf;
	e =3D ENDOF(buf);
	p =3D sprintf_end(p, e, ...);
	p =3D sprintf_end(p, e, ...);
	p =3D sprintf_end(p, e, ...);
	p =3D sprintf_end(p, e, ...);

Admittedly, ENDOF() doesn't compile if buf is not an array, so in those
cases, there's a chance of a paranoic programmer slapping a -1 just in
case, but that doesn't hurt:

	p =3D buf;
	e =3D buf + size;  // Someone might accidentally -1 that?

I'm working on extending the _Countof() operator so that it can be
applied to array parameters to functions, so that it can be used to
count arrays that are not arrays:

	void
	f(size_t n, char buf[n])
	{
		p =3D buf;
		e =3D buf + _Countof(buf);  // _Countof(buf) will evaluate to n.
		...
	}

Which will significantly enhance the usability of sprintf_end().  I want
to implement this for GCC next year (there are a few things that need to
be improved first to be able to do that), and also propose it for
standardization.

For a similar comparison of stateful vs stateless functions, there are
strtok(3) and strsep(3), which apart from minor differences (strtok(3)
collapses adjacent delimiters) are more or less the same.  But I'd use
strsep(3) over strtok(3), even if just because strtok(3) keeps an
internal state, so I always need to be very careful of reading the
documentation to remind myself of what happens to the state after each
call.  strsep(3) is dead simple: you call it, and it updates the pointer
you passed; nothing is kept secretly from the programmer.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--42cidsdllbjeiguv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmh1/lcACgkQ64mZXMKQ
wqkuig//S3hiwlkmTsz7a0bec7iYCPTHlJQErIaH1hA0PDwadlm0Uld/f8mbbM7o
Ps84e7sweLABRiI8zlkgBCM4sK3SY+wyoKz7d9vasg5XiyIVVAPxE3PaArxdTYz5
0eEJpu96pwyMyMk5efylDBnL7q7C2orgiimax53nITbsbQs3gx5rrT1eAFjQ18fk
SWYjiO4LTE+vn/XWYSm/RJQpTRkss67jMrxNTg534J8NG3WRAK4q4ytJPxd3cCrB
1EQs5McuvHSVYcRCqdSfW4BK4EF1gQwwfBGh6VEX/t+i7K4tufhSeaQUGU1x4xmx
ERW0AWe80VDMCyz1hmZkyEj/4r4nXn1hZ8Tjg/bvUK5WDICFKfaTGgd4EbQ4yyuY
+GGOGLpHF/LzIQfGsAMLhv6QCgRd29bT3EHlCSdqpQYYDcBvCY/yCzS19q9C/5r+
kZBJGn0g+hStrC1CjItE8yrviowVmopVLsx5d3cEnjdK1FqZX8OgfWjNdDR6d0dl
Ypk3D6e857x/WBd2p19r6k+Qda0Mw0KDLz/qZ0aoEjGoyBj2s86Ipi3aA54MqJyV
YV/c78fOIDQB4PC+AfsvQ9xYO8Ij264dGBnHJunjZGsL1pTwVSlOnjdVw6gVsr8p
bUsCwLZLs4q1EEFG4RELMcCvjXBoziYheUg2rvW5+lkV/ZPVryI=
=tD+S
-----END PGP SIGNATURE-----

--42cidsdllbjeiguv--
