Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521239;
	b=ZhKjSdFfzjXHFiR87dHPF1mXTgo3aUX6JdbO/x2hT1CsNmuLdGixx2+7ai/MnRzZdQjj
	 1We7SJuXpW577vv7dU9f1IxUg0S1sbnfWIHMtDF/pWOOqvF677JAK97uiuHDbufrZ4SnO
	 RWqpprXPFlzkGh1dZM3VAJlVknAAqJJYvfqt/0C6ZEOLecD9A/GQ1Ud0btsIqB/0zKFD3
	 5+gCSHep7qbO0JZCmXGmpk2lPyEJsrtQMz+Lxsl0SNe2Vq+Gg2AyQ/IwaIkk+sFzxFbHm
	 QIMkC9GxOXmO2MeH2AuyMeDjOsLBmE0LUhUR3y6O32wieJ0MW5FlZ721Z2wGkk1Ts6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521239;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ReVyqXe2av4g6tLUV9DHWUBpBCC6BZrEGkcX74zqGJI=;
	b=XToLKekdJN3TJIfzBHedf7TDFs1pX6CEd3q3q/nJT1kaNriT/MPzvFSFm6ZymHu+eBko
	 dnMLTNBWPNyH59n/LXXzQsIdNyU/EJcyQfSUM2sa5MujAJs/37912U/X38UlNh4jz1yjQ
	 v0EdhyYsau65iuKhIBuS6UKo/AnXD5DLHpoSjJjA7Otyy7e395GOlv5mztkhQ4ZZOUi7W
	 gyl6VxrfSXouvVM/WrYcb9o00/U9mXx+SMg0a/KYArnFRKIYaCphGznOpn5VgWNTCshtQ
	 95lR4gcYOsj38nw4tTIGmDQ60sJDyngCSqNYQ0oWwhokumWN+aBltjOO5gN8NeFVnrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lmb4n366;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2611606A31C;
	Thu, 12 Nov 2026 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lmb4n366
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584561F000C4;
	Thu, 12 Nov 2026 22:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521239;
	bh=ReVyqXe2av4g6tLUV9DHWUBpBCC6BZrEGkcX74zqGJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lmb4n366DeTQad5TR+vZZv189w2+Kbw+FFoTqw4gmi63TuCtczBRzlcLJU+qkJzUf
	 reJwO4Pq+R2qE5IbfO21sPoLc40jim9PgmKNlhik9rKkim50sfb3kIk9tF5kgM9JX7
	 xrOYGTx9v5Lx7xvw8RqpFivEblMmmOgNhpBpTxgwy+n6kNx95+AZVcPfihH58b/Otj
	 B/1uSNg1MX8268oJjG+ePnaXOrZLZqtMgXQ0MwOwsmqhePXYDTBk7U43YW1TrKtVuG
	 GoimiIlzcjrFJ5jjq69yrh96Bi+OCJ49WPtP8lpHBL/rdQNxIWkD4rsAI1Q8/sqlBV
	 js1ErIeKab7XQ==
Date: Thu, 12 Nov 2026 23:07:14 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Mariia Nikitash <nikitash.mariiaw@gmail.com>, hverkuil@kernel.org, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <avYuEyBCkrNrvvJL@devuan>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
 <20261108210232.13800dd3@pumpkin>
 <avDmyLYpWOQ2WB-i@debian>
 <202611120947.AC428BE4B@keescook>
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
	protocol="application/pgp-signature"; boundary="v3qgrxyijyqfgzgl"
Content-Disposition: inline
In-Reply-To: <202611120947.AC428BE4B@keescook>


--v3qgrxyijyqfgzgl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Mariia Nikitash <nikitash.mariiaw@gmail.com>, hverkuil@kernel.org, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <avYuEyBCkrNrvvJL@devuan>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
 <20261108210232.13800dd3@pumpkin>
 <avDmyLYpWOQ2WB-i@debian>
 <202611120947.AC428BE4B@keescook>
MIME-Version: 1.0
In-Reply-To: <202611120947.AC428BE4B@keescook>

Hi Kees,

> Date: 2026-11-12 09:54:15-0800
> From: Kees Cook <kees@kernel.org>
>
> On Sun, Nov 08, 2026 at 10:25:35PM +0100, Alejandro Colomar wrote:
> > Hi David,
> >=20
> > > Date: 2026-11-08 21:02:32+0000
> > > From: David Laight <david.laight.linux@gmail.com>
> > >
[...]
> > > >  	strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> > > > -	strscpy(v->card, tea->card, sizeof(v->card));
> > > > -	strlcat(v->card, " TEA5777", sizeof(v->card));
> > >=20
> > > What is wrong with (and almost OTT):
> > > #define TEA5777 " TEA5777"
> > > 	BUILD_BUG_ON(sizeof(TEA5777) <=3D sizeof(v->card))
> > >=20
> > > 	len =3D strscpy(v->card, tea->card, sizeof(v->card) - sizeof(TEA5777=
) + 1);
> >=20
> > I can answer this one: bugs (particularly, off by one) are quite prone
> > in such code.
> >=20
> > From the Authors of strlcat(3), you can look at OpenBSD's manual page:
> >=20
> > 	Since it is known how many characters were copied the first
> > 	time, things can be sped up a bit by using a copy instead of an
> > 	append:
> >=20
> > 		char *dir, *file, pname[PATH_MAX];
> > 		size_t n;
> >=20
> > 		...
> >=20
> > 		n =3D strlcpy(pname, dir, sizeof(pname));
> > 		if (n >=3D sizeof(pname))
> > 			goto toolong;
> > 		if (strlcpy(pname + n, file, sizeof(pname) - n) >=3D sizeof(pname) - =
n)
> > 			goto toolong;
> >=20
> > 	However, one may question the validity of such optimizations, as
> > 	they defeat the whole purpose of strlcpy() and strlcat().  As a
> > 	matter of fact, the first version of this manual page got it
> > 	wrong.
> >=20
> > > 	if (len < 0)
> > > 		goto fail;
> > > 	memcpy(v->card + len, TEA5777, sizeof(TEA5777);
> > >=20
> > > What might be useful is a helper that would let you write:
> > > 	len =3D strscpy(v->card, tea->card);
> > > 	len =3D strscpy_at(v->card, len, " TEA5777" [, implied_length]);
> > > 	if (len < 0)
> > > 		goto fail;
> >=20
> > Indeed, as said in other threads, I have such an API:
> >=20
> > 	p =3D v->card;
> > 	e =3D ARRAY_END(v->card);
> > 	p =3D stpecpy(p, e, tea->card);
> > 	p =3D stpecpy(p, e, " TEA5777");
> > 	if (p =3D=3D NULL)
> > 		goto fail;
> >=20
> > Linus didn't like my function name.  We could indeed call it strscpy_at=
().
>=20
> I really just don't want to have bare pointers or lengths being used for
> any of these manipulations.


> strlcat needs to go away because it's part
> of the whole C string API that is confused about array vs pointer and
> has no sense of handling bounds. Yes, FORTIFY does its best, but between
> lack of sane bounds and doing a strlen for every action, it has to go.

I disagree that the whole C string API is confused.  In the future,
when array parameters become actual arrays (so you can use _Countof() on
them), you'll have better language support for that.

strlcat(3) indeed has some problems, and has to go, but I would like to
not put the whole C string API in that sack.

>=20
> And I'd like _fewer_ APIs

That's a mistake, IMO.  The reason why programmers write bugs using the
string APIs is precisely because they try to use few APIs, and try to
use them even in places where a more appropriate API would be better.

Take for example strncpy(3).  It has been abused in so many ways, and we
all know the results of that.  Now look at what you've done in the
kernel: it's been replaced by around a dozen different APIs.  Quoting
the documentation:

	The replacements for strncpy() are:

	- strscpy() when the destination must be NUL-terminated.
	- strscpy_pad() when the destination must be NUL-terminated and
	  zero-padded (e.g., structs crossing privilege boundaries).
	- memtostr() for NUL-terminated destinations from non-NUL-terminated
	  fixed-width sources (with the `__nonstring` attribute on the source).
	- memtostr_pad() for the same, but with zero-padding.
	- strtomem() for non-NUL-terminated fixed-width destinations, with
	  the `__nonstring` attribute on the destination.
	- strtomem_pad() for non-NUL-terminated destinations that also need
	  zero-padding.
	- memcpy_and_pad() for bounded copies from potentially unterminated
	  sources where the destination size is a runtime value.

And that is the right thing to do.  In parallel, we've developed
fundamentally the same functions in shadow-utils.  I think that's where
research converges to: one API for each different use case.  That makes
the APIs more descriptive of the action they perform, which let's the
programmer better understand the code.  They're also way more robust, as
you can add many safety checks in the macros that implement them.

> (I realize that didn't happen at all for
> seq_buf, but that our current best direction).

I think the problem in seq_buf is not the amount of functions, but
rather the fact that it tries to support both strings and nonstrings at
the same time.  That's literally repeating the mistake of strncpy(3)
with this new type.  You may try to patch it with tape, but it's
fundamentally flawed, and it will eventually show up (we've already seen
the bugs in its implementation).

> And I especially don't
> want a "len" getting passed around.

I partially agree with this.  I don't like passing a length, because
lengths and sizes are too problematic.  However, I would like you to
trust me that pointers aren't that bad.  We've been using them in
shadow-utils extensively, and they're super-comfortable if the functions
are well designed.

> It needs bounds to be *in* the data
> type. And that means either true arrays,

Indeed, there's work towards that.  I'll show some preview of what may
come in future dialects of C.

Now, we can have a stpecpy() function:

	char *
	stpecpy(char dst[], const char end[0], const char *restrict src)
	{
		ssize_t  dlen;

		if (dst =3D=3D NULL)
			return NULL;
		dlen =3D strscpy(dst, src, end - dst);
		if (dlen < 0)
			return NULL;

		return dst + dlen;
	}

In GCC, you can improve the prototype:

	char *
	stpecpy(char dst[], const char end[];
	    char dst[dst?end-dst:0], const char end[0], const char *restrict src)

With a patch I'm working on for GCC (it might land in GCC 17 if we're
lucky, but it's more likely to end up in GCC 18), we'll be able to use
_Countof() on array parameters, so we could use the two-arg version of
strscpy() for implementing this:

	char *
	stpecpy(char dst[], const char end[];
	    char dst[dst?end-dst:0], const char end[0], const char *restrict src)
	{
		ssize_t  dlen;

		if (dst =3D=3D NULL)
			return NULL;
		dlen =3D strscpy(dst, src);
		if (dlen < 0)
			return NULL;

		return dst + dlen;
	}

And in a few years, we might end up having slices in C, which would
allow having the same functionality with just 2 arguments:

	char
	stpecpy(char dst[:], const char *restrict src)[:]
	{
		ssize_t  dlen;

		if (dst =3D=3D NULL)
			return NULL;
		dlen =3D strscpy(dst, src);
		if (dlen =3D=3D -1)
			return NULL;

		return dst + dlen;
	}

So, there's a bright future for traditional C string APIs.  And it's not
too far away.

> or internal bounds tracking
> (like seq_buf),

I believe that's going to bite eventually, and it will also be difficult
to return to the simplicity of the C string API once we have these few
features that make it safe.

> and it shouldn't have "extra work" associated with it
> (e.g. stpecpy above still has to find the current end of the C string).

No!  stpecpy() is really the same as strscpy(9).  It's *not* a cat
function.  See the implementation(s) above: there's no strlen(3) in it.

The closest relative to it is stpcpy(3) from POSIX, which is really just
strcpy(3), but returning a pointer that encodes the position.  That was
designed precisely to solve the performance issues of strcat(3).

> C strings were a mistake, but here we are.

Trust me: it's not.  The problems with C strings are, as you said above,
the limited support for array parameters in the language.  But it's not
too difficult to solve that problem.  And once that is solved, magically
the traditional string APIs become much better than the structure types,
by being at least as safe, but much simpler.

So, I'd like you to trust me to add stpecpy() --whatever we end up
calling it--, and perhaps the sprintf() variant of it, and see how it
really improves the code.  In the coming years, when we solve the issues
with array parameters in the language, they will become even better.

> So, for "easy" constructions, sprintf-family, and for complex
> constructions, seq_buf. And probably the large bit of thought at each
> place where it is possible, is "how should truncation be communicated?"
>=20
> -Kees


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--v3qgrxyijyqfgzgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr2OIwACgkQ64mZXMKQ
wqmEHQ//W1DL7SYtAzAHPc7wioVh7RmVJF/FZORDB+Hdz2e9X/Fz+ViF03FJ1RnP
ARhTyZgOn/Bsc/btKgfeLwipnzZmWNqj1XitoUdKkXOezHJf9fFGQmVpohwx/eZm
/o59tzgr2SopEsUwLlma0D48VMbfpag4cL/SR1iHwdOMXK7avkaFRXvOEzFjMBnY
TARbtXMtATdyCSnSwChtcesWd8AHgu4YBauXpyKFWAV7b7BAH3cng4OFBya53pXn
bK3GMKAvp57LlrAuNZ6U8rTMnRuB6q9rSGh0w3QEFXEG/NT8SSBoXqZjxGksTM6/
VPH01UG5sc8fGYz5IKvIa2OWQwJiG+U1vqsesgEY+LH6WsA9HZaqNH/BbDvuRmrr
qVvuGzVMtpfXze+lBYJr967hsllhxy1tF0tXlal16PAYTf09hcnZmXiLtJEh95G0
/zmdcFYlO7UsdgZJyIK2E4V9ckIveHfzyp4cqhByininulLeZPIqv/AoDCvGPmYH
ar+OiJzDlEzsBm30Dd3epiKPyFcPzNOhUSrYb0l06Jn4AdjvryrHayJorzodNktH
msgUbRP5ZhEbxbDhEKekyOHcQuUHZFhxMhYNlHMofBbsg/WfcOz4jCWtSprnigoL
UzjYL2Kdr1k5GUdjteMG8q6Nlqnq/FZi4cI51jUcHe+QDQ1X2TM=
=aDiz
-----END PGP SIGNATURE-----

--v3qgrxyijyqfgzgl--
