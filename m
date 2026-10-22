Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792698122;
	b=TY7y097X9Ox01U37gx54zIUKOtZz68jA6DplPp5n5AOE/qF48Hd5kAeWO9UQU+lCE2DM
	 KCmn9UweB2UVkFQJP/ECteX4WhnMK8cwAZiyex8QvsCK0dfPV/D1cTcD6eEpiKNPpISRG
	 fbdfFz8pQqzYJrK2xswUEUEg4CW0YP+ZxOV48aZf5hKpwLOAHfHW8cSerpZ7ijSgitbMd
	 Qy1hWvLXPv2WwUZjKOBX/5XLhWuREaSXfOo43xByqQfXl3UFXMEKxj/Z0fGLM02fWdp6V
	 NjLI2dJoHdDXEjTYwTjZhBJljFhq0ZkVtVcJ1B+U02Jgu+2vJVNFUJ4QXqZr+zG8aLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698122;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lheJRtPRmGWE2TUG2fgBlSmnzp+Sd9CiT1aRPjq2SGw=;
	b=2nLAj8TSQ9qd2wf4/2oSk0ASzTD8xK+JGX+gmgRwz9+Ny1SGcAkMRh9RcKoRWorUAJoQ
	 Cs9MH0cwoB2jbwN/srThiK/dkMYCSROvY/XaJ30X7DOKJWCZe/FrK1xIM2TYEIhwLHcEU
	 Orvwd3SzywJCvdTnFxSv3I2kUXlfBYla48VjPn5fxG3nVKz8zeiKunRGQlvXRph/e0AJ6
	 0y0ifir2K9aFm11BymoYF6mRvU/I0VGS2KTRjKtVPC2Fs2kIbSLYVPeS12IyPzFHD4qEJ
	 Y9SjPVQhvWLCsr5BQ1tVEZYrTZcgoicomV4sJXwYf6BsOeG38GnWPeB11UfmvMfgVFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6UQfHEl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF64606A31A;
	Thu, 22 Oct 2026 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6UQfHEl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5081F01825;
	Thu, 22 Oct 2026 19:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792698122;
	bh=lheJRtPRmGWE2TUG2fgBlSmnzp+Sd9CiT1aRPjq2SGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j6UQfHElQkCs9tUv8AHtYkJCoDeDZH+6wVvEwgkKqSAF8mucib0L3VfnL8xuVTY2E
	 4GR7y2bPOzr+gn8h1QF9fcVH6KzPHCBI20fPQ15Tv9QapmATyne6l8qwJw+x0xU+HU
	 cphhhk+/rVBFChp6NbWP2DJ2h6oSWcrJJqvZJJ9bqb3HRhcfmNb1s4VFONjKxGTCYg
	 nU766KD8pC8AGenWFAhzEBfIZXp0whsq1DitYTvWOUc0RAlEj+TA6XhpCy6xVIWdik
	 51K5YS5dtPd/rAKpbzRxtK3Pr7pB/uHsk4lJ7hqXo5b7Hq2sHnqoqWVcUeZOMTQqzq
	 7ri/L0MCwlYXA==
Date: Thu, 22 Oct 2026 21:41:53 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <atpmAQ932J3_8IvJ@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
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
	protocol="application/pgp-signature"; boundary="rlvpbuide74u4tp6"
Content-Disposition: inline
In-Reply-To: <202610221058.C5626C5172@keescook>


--rlvpbuide74u4tp6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <atpmAQ932J3_8IvJ@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
MIME-Version: 1.0
In-Reply-To: <202610221058.C5626C5172@keescook>

Hi Kees,

> Date: 2026-10-22 11:06:32-0700
> From: Kees Cook <kees@kernel.org>
>
> On Fri, Oct 16, 2026 at 02:59:28PM -0400, Steven Rostedt wrote:
> > On Mon,  5 Oct 2026 08:56:56 -0700
> > Kees Cook <kees@kernel.org> wrote:
> >=20
> > > +/*
> > > + * NUL-terminate the buffer in @s: directly after the data when ther=
e is
> > > + * room for it, otherwise in the last byte of the buffer. @s->size m=
ust not
> > > + * be zero.
> > > + *
> > > + * Returns: the offset of the NUL.
> > > + */
> > > +static inline size_t __seq_buf_terminate(struct seq_buf *s)
> > > +{
> > > +	size_t end;
> > > +
> > > +	if (seq_buf_buffer_left(s))
> > > +		end =3D s->len;
> > > +	else
> > > +		end =3D s->size - 1;
> > > +
> > > +	s->buffer[end] =3D 0;
> >=20
> > Hmm, I just realized that this could inadvertently overflow the buffer.=
 If
> > len =3D=3D size, it may not be overflowed. If using seq_buf_putmem() and
> > filling the entire buffer, calling this would force an overflow as we j=
ust
> > truncated the last byte.
>=20
> Hm, yes. So the "else" branch needs to include:
>=20
> 	s->len =3D s->size + 1;

Please think again about the possibility of using pointers instead of
lengths.  This is a source of off-by-one bugs that's only caused by
the choice of data, I believe.  If using pointers, truncation would be
stored as a NULL pointer, and off-by-ones would be less likely.

Consider this off-by-one to be just a sympthom of the underlying
problematic design.  Whenever a design forces you to write +1 or -1,
there are high chances that the design is sub-optimal regarding safety.

[...]
> > > +/**
> > > + * seq_buf_strlen - get the length of the NUL-terminated C string in=
 seq_buf
> >=20
> > Hmm,
> >=20
> > I don't really like the way this modifies the string, as the request is
> > just to return the string length.
> >=20
> > Just like the above, this could cause an inadvertent overflow.
> >=20
> > I could envision a use case where we want to use the entire buffer and =
do
> > not expect it to be nul terminated. And this function could be used to =
get
> > the length to print. That is, it may want to use the entire length.
>=20
> Non-C String users would be using seq_buf_used(), not seq_buf_strlen().
>=20
> >=20
> > Having "strlen()" modify the string just seems wrong to me.
>=20
> No, this is absolutely required. It's nonsensical to work on a C String
> without termination. (And it's the entire purpose of this series...)
>=20
> > Is it really needed? If the user wants to make sure the string is
> > terminated, it should use the next patch's "seq_buf_terminate()".
>=20
> The ergonomics on this are very bad. I explicitly don't want to leave a
> foot-gun around for this. :) (i.e. require all C String users also
> remember to terminate it first; the whole point of the API is to have
> the string always be safe.)

Agree.


Have a lovely night!
Alex

> > And we need to update it so that if seq_buf_terminate() causes a
> > truncation, it needs to set that it overflowed.
>=20
> That I agree with. I will send a patch on top of the series since this
> has been in -next for a while and the merge window is here now. :P
>=20
> --=20
> Kees Cook
>=20

--=20
<https://www.alejandro-colomar.es>

--rlvpbuide74u4tp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmraZvoACgkQ64mZXMKQ
wqkG8Q//c6Li4h1uHNVj1RkBmge/yQDIWrkRrq5X12RkDmUe3niHcIB6RlKh0s/z
DyQ8j0DjG69yoIjCL5HmJqJ+swZxvMboisX4duVoOjcZGprGF7HGIxfqzaUv/gkS
uKcJ9VUvpb1ZhmE+lSFu+zRiWoO61MLLj9qxkUwDRxYOboyu2FUak7de5wqJkbh2
y7wL3wTArzF4os6NOKJ41IgKdDTNUAkD9CelH+dsmr+jbMzX1hFaEk8oMCx0t2IM
LgfelCXDvw9sa4DFGDvA6s3cA3ETnirXHJiQ1+1Tq9CrdhbOq5MnlmbwSW2ONcoF
DXU8fzkXmoa+KxXXabUNGUYahCcDv/yTpZN3YZmexRHZzOu2kjUyeoEXas732KnQ
9s32UbYf1dSRpC2SYTpsPxmVEo/5F+sNLllRkeQeoSrKvu4JoPveP8r1HiUIg1Eq
WlfkDcqn6PIHy6xEa9UZICq9IFucHiLjtSJOooYZhJqCyUrrZatG5n9w2XljYOOg
6yjwo2mDODy6nhihgNRKg88U6jxsv51KFdF6ItB0xNsI/x9AvMoRnD8d9Sh9un+r
M0wucow4iGkCNA4YKM6Kjcbs7g6F9+gGs1NVN2ZpI+nrneNxmK3o7OEJTG3gYgLP
m4Mn7F+pdFF3XINmRj6CvOJ2AOYRDrdHLs+qUeAaQWJ9tWW4HPA=
=zgSH
-----END PGP SIGNATURE-----

--rlvpbuide74u4tp6--
