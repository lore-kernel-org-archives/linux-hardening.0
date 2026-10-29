Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281972;
	b=uuxjX4eFQhl8hxg8NqFmS/VLuIHYPXO2e92cFbh8PEdbT1qS4vH+Nzr4nONYAYFAGtaW
	 QatZf4vWKtE8fdM4j/2ZsTKo4XPI7PtxOnTKDu70nTjHba3bD4VRlYgy/Tl0mQtVKHSlW
	 jEPtRI6ANQTwMxbUOfaXTERjqb45/SR0VuaETqVqxyKUpvp4dEfq+KcB/BZBBBFy06HNW
	 YLFzw+WfzcQCMFurUYEiVF5dy3/dg6LY5iviKIPm575Znru7UUvT0rDcEsB1COcSQfIYU
	 QtFij7eHV+lXRhc7DWMAnCGIfPooLkGvw/ZB2wArWSEj3/rHD92fO8/DD1GR2XxLnBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281972;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WZB7xneQnbHrSucut/VMFiD9WupDYt7EZVgw8aPOdQE=;
	b=2QN4YLIT5ZUiC3C/LFVQWTbSjEGf+8trrwaBDteoeL98+sExoKwgXg4gqwvl0kdekBLH
	 edghwgXg7AP0uoAYrZo9vuYjkibPqfIqUB7GIgO+j0WCR/5PiVVLll6KAgFuifHV0om+p
	 XIgqTIh1zXA1hAdlYWYyN5fXKKUQl07EaCYTa7j4ZQotk3sBrp7Iepo0D3bniWkPaMkoy
	 xnu/xRbplDSZ1MUkXcJq5c+HSU4BnIybkvBSsdj9ZvpyW6Wt41ZPLzO+DNKmsbUoW5kQU
	 U014EZwL2D+c2NI9ey9hZU/WXMkIaOqC6CpgM6yZqH+mVeqjdLF/5NQdkzZoiHnub+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8rQT21N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C8606A31C;
	Thu, 29 Oct 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8rQT21N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C671F01825;
	Thu, 29 Oct 2026 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281971;
	bh=WZB7xneQnbHrSucut/VMFiD9WupDYt7EZVgw8aPOdQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P8rQT21NZ3ze9vyOwpc+ckgR/cNbNf6P//SEGy7Jp0nHNEQGwEN6in9V34L/4ig+J
	 loj4ub6qLdQyzRbONNWnLezUqPUDpam2la/7xtLGrjilVWeUFBRjvxgSpK5pLDXeEP
	 cbTa9LCtSAMkcIthmg/1nfQ0LLT/0U3NDuvQsbjSQ+Oj26WzBQulb7Er6qd8+MRySe
	 YdAJtrac6fxRR0pUOaCbxmDtXFvVns0MOxmP0sqDD/uhjxzMPmirCMKTpPThwYBifT
	 XuS6hpwKWmFxAJ3ZDoCHDRiCGM6xqGcE3IWb1sA89ABFFYx/gzKeQCvI9rQhKUygkv
	 7UeJrx5ShE3YQ==
Date: Thu, 29 Oct 2026 14:52:47 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Mark a seq_buf overflowed when terminating it
 loses a byte
Message-ID: <auNNcmUuR8DS7Hys@devuan>
References: <20261029053250.i.220-kees@kernel.org>
 <auMwo_T_FsZp5UsB@devuan>
 <20261029091845.21464a1a@gandalf.local.home>
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
	protocol="application/pgp-signature"; boundary="54jmzgfhb4l25z3a"
Content-Disposition: inline
In-Reply-To: <20261029091845.21464a1a@gandalf.local.home>


--54jmzgfhb4l25z3a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Mark a seq_buf overflowed when terminating it
 loses a byte
Message-ID: <auNNcmUuR8DS7Hys@devuan>
References: <20261029053250.i.220-kees@kernel.org>
 <auMwo_T_FsZp5UsB@devuan>
 <20261029091845.21464a1a@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20261029091845.21464a1a@gandalf.local.home>

Hi Steve,

> Date: 2026-10-29 09:18:45-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
> On Thu, 29 Oct 2026 12:47:04 +0100
> Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
>=20
> >=20
> > This fix in theory solves the issue.  However, I wonder if this is maybe
> > too late to report the overflow.  Callers normally expect the overflow
> > to happen while they're performing their writes, and maybe they don't
> > expect the overflow to happen at this point, so they might forget to
> > test, and keep going with truncated data.
>=20
> No, the overflow should be checked when they are done with the seq_buf.
> Which means after they do either seq_buf_str() or seq_buf_terimnate().
>=20
> >=20
> > How about not allowing a full buffer without a NUL terminator in the
> > first place?  That is, we could report a _putmem or _putc operation that
> > writes a non-zero byte to the last element in the buffer as being
> > overflowed.
> >=20
> > This would waste one byte, but would prevent users from having to expect
> > a possible overflow when reading a buffer.
>=20
> This only happens when the user expects the string to have a nul
> terminating byte. Don't think too much into this.

Hmmmm, sounds reasonable under the point of view that users shouldn't
expect these buffers to contain strings.  Then, seq_buf_str() would
obviously be a write operation, since it transforms to a string from
something that wasn't a string.

> > > @@ -137,10 +137,16 @@ static inline size_t __seq_buf_terminate(struct=
 seq_buf *s)
> > >  {
> > >  	size_t end;
> > > =20
>=20
> Hmm, I was thinking that this should first check if the string is already
> terminated with a nul byte. Why add another one if it is?
>=20
> > > -	if (seq_buf_buffer_left(s))
> > > +	if (seq_buf_buffer_left(s)) {
>=20
> 		if (s->len && !s->buffer[s->len - 1])
> 			return;
>=20
> > >  		end =3D s->len;
> > > -	else
> > > +	} else {
> > >  		end =3D s->size - 1;
>=20
> 		if (!s->buffer[end])
> 			return;
>=20
> Otherwise this overflows the buffer even when it is already terminated.

If it is already terminated, s->buffer+s->len points to the NUL, right?
Is so, then we'd only reach this second branch when the buffer has
already overflowed (seq_buf_has_overflowed(s)=3D=3Dtrue).  If the buffer has
not overflowed, s->len<s->size, and thus we'd fall in the first branch.

If we have already overflowed, we shouldn't be concerned about further
overflowing, right?  And on overflow, if there's a NUL, it certainly
must be at s->buffer+s->size-1, so overwriting it with another NUL
wouldn't do any harm.  If this helps us avoid a check (and thus a
branch), it would be worth it, right?

BTW, I'd very much suggest renaming that 'end' local variable to 'nul',
since it is the offset of the NUL byte.  'end' could be confused with
the end of the buffer (as in ARRAY_END()).


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--54jmzgfhb4l25z3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrjT6kACgkQ64mZXMKQ
wqk3Bg/9FCem0Gk8ETPq5oOgGZAIhs8jy6p/mMsd9KjsX2z66Ltah7AITRLt+7rl
3a7pm8nmy3sg7tZ99VWt9hAL8c+rcMk2RgKBJAxo2H0wTd/8Sl40oab+qAiA/2zV
Cksf/w+gmyfAV5K8kimQCz1vEjXblboVtDHL7ffU4TQHHOt32BK0wh8iV6dEmGU+
wrXOPoQxzZvXLpWDPWlu3i5EaNvd0/l7Nb7dVam/lf0kr6MH5ALjLBGUBM3Enscp
0spLNyeXY3QW9OVnILMaZLujKEduvs/mssdW1LqoqOaDIC9YtycMxvCgnc5eQ1HS
amY7soMcG1c2chRx0GPrC1uKfDFSt/XzT3bkbjDc61bBwcJt2Ul2rl0K/DMwmA1c
QZEGlp33vZDfXvBtTrpHvMcQ79F9eNc3ghLvp2x5tz+SmgTVPVJUlpprtWwfUf2J
O1UykeVIlarJGMV5/Z3pK5Xt6ZAs1oZ+HL7BT1KpBofmEC1AAD04Sfg2r752avDh
iLTipExtcwyYeh7AVCHnswRpUmqmMbB/HZPltGwJR7r+VYzfGVQII6ZrrB+HQcwT
UUnUeU0VOf6CikrEZrGS2V0jRax6OoaV7x4AtBcnjiUNrfWGEFPtaJCAW+HX04GY
yXxdKD9wtJFKjyr/LzwuBEjs3bLqz/ByCTH6anrbkYUagKLfBZw=
=jkYe
-----END PGP SIGNATURE-----

--54jmzgfhb4l25z3a--
