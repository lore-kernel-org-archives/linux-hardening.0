Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390832;
	b=0M2qPmKHGbywSAinQNooWRQqx5QxsUXMpzSeXBD67NFGLhSQTtFou+YB/mVi1qR/hPNR
	 QpoGnThmN6k6TRuW5JnGfS1vxy9yW7os33Fa4xmf2vt5eGFGCbXIPeZbSlieg3JxudScI
	 /Sl1drQw9deLcBE1oWx+HVMhXLSd7aPsS8ScqXrA6zpU2o9KxhVCkJq2rUKM7zDWH3mxN
	 5CR29InmAYfT9hTi6ZvQ8bteAyPncY0ILl3BjIT9jfwvyZeX3fv3YMua5GnRDFQ1P/2t8
	 he7pA69OIaKtGuZQa2bZdqRHfSeC4oNCJMj5mA9n3eB4VnXwKJRRSNjBcY01Qyzi39w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390832;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QJDDgqPhmpgr24cJQYE2mT3Nmxs4hMnayZXdVHDbk84=;
	b=2ZBy8ZqlcCH9CH7+/B3lfOtPxWN0iAVM1PQw19p1g+ZrR9cXaX5iy9QtccKUm+5n53ug
	 z4PQTozcXgLLgYzgJodEYAbgOOSMasQI1wb6svyDtRHKgWQ48YYgqP1SrdqqQl25K3/42
	 tO4upEKrbvYjzQhNRrOKlPL+oWfWYc24cyVn028tunp0U96bstIfsD0J6IkrupheUkn74
	 JlgdDVt7swjJSgLWVls4gSQcaa0XJf7iU/duJn6Qzcwi+dopnmNGo6XOuHbBzab+6So9V
	 H3bz+wQRDjZ0DgR6mk7EFvyMThSKVWbpSsctxEybAj7BjjOT8TPz7hNyFT12v+hwhSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fv3HM2kI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BBF606A327;
	Fri, 30 Oct 2026 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fv3HM2kI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE791F00A02;
	Fri, 30 Oct 2026 20:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793390831;
	bh=QJDDgqPhmpgr24cJQYE2mT3Nmxs4hMnayZXdVHDbk84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fv3HM2kI7PWnqLUSVyAnEu3JV+znovDfa9o8iwG4JLDu+CTVeuVQGpxU91ptoso8l
	 LQsmqNfZZNQl7eO5ilc9oI60oi63jdOmybmHtD3s9YlIshFDqJMJcbOXbSQsPWaF5v
	 euxrYyKa6s1XSbWbH0cl3NiNDDlvBnAzaGN13kUFhfUfI13ePDFFBXXvJAdOIc71s5
	 zmKexB2d8oEyWoUqvInzW6mOal+wGn1EbR+JT0l2/BKDUcK4yySzSm3x7Q1VvAFu3t
	 8om36Dn+piewF8fHSOsTNOylPfVQIPivbS/rYrmq/o59OIhhylz+0Kt/PzMQlFaB3o
	 tk0U68RBedFEw==
Date: Fri, 30 Oct 2026 21:07:06 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Mark a seq_buf overflowed when terminating it
 loses a byte
Message-ID: <auT3Lt4y9s-8g_FK@devuan>
References: <20261029053250.i.220-kees@kernel.org>
 <auMwo_T_FsZp5UsB@devuan>
 <20261029091845.21464a1a@gandalf.local.home>
 <auNNcmUuR8DS7Hys@devuan>
 <20261029101838.7c34a2f2@gandalf.local.home>
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
	protocol="application/pgp-signature"; boundary="jhcsbhgj56dj35dk"
Content-Disposition: inline
In-Reply-To: <20261029101838.7c34a2f2@gandalf.local.home>


--jhcsbhgj56dj35dk
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
Message-ID: <auT3Lt4y9s-8g_FK@devuan>
References: <20261029053250.i.220-kees@kernel.org>
 <auMwo_T_FsZp5UsB@devuan>
 <20261029091845.21464a1a@gandalf.local.home>
 <auNNcmUuR8DS7Hys@devuan>
 <20261029101838.7c34a2f2@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20261029101838.7c34a2f2@gandalf.local.home>

Hi Steve,

> Date: 2026-10-29 10:18:38-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
[...]
> > > > > @@ -137,10 +137,16 @@ static inline size_t __seq_buf_terminate(st=
ruct seq_buf *s)
> > > > >  {
> > > > >  	size_t end;
> > > > >   =20
> > >=20
> > > Hmm, I was thinking that this should first check if the string is alr=
eady
> > > terminated with a nul byte. Why add another one if it is?
> > >  =20
> > > > > -	if (seq_buf_buffer_left(s))
> > > > > +	if (seq_buf_buffer_left(s)) { =20
> > >=20
> > > 		if (s->len && !s->buffer[s->len - 1])
> > > 			return;
> > >  =20
> > > > >  		end =3D s->len;
> > > > > -	else
> > > > > +	} else {
> > > > >  		end =3D s->size - 1; =20
> > >=20
> > > 		if (!s->buffer[end])
> > > 			return;
> > >=20
> > > Otherwise this overflows the buffer even when it is already terminate=
d. =20
> >=20
> > If it is already terminated, s->buffer+s->len points to the NUL, right?
>=20
> Not necessarially, a seq_buf_putmem() could have added the NUL terminator.
> Then calling seq_buf_str() or seq_buf_terminate() should not overflow it.

Ugh!  This is another can of worms.  Do we need to accept users calling
_putmem() including a NUL terminator?  Perhaps we could ask users to not
include that NUL with _putmem() (and if they do so, then the buffer
might have two NULs, which isn't terrible).  Or perhaps _putmem() could
do .len-- if the last byte is a NUL.

Anyway, I'm disliking this API too much, and will probably work on my
own stpecpy()/seprintf() pointer-based pair of APIs to replace
strscpy(9)/snprintf(3), which are much simpler to use correctly, and
require much less churn than moving from strscpy(9)/snprintf(3) to
seq_buf.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--jhcsbhgj56dj35dk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrk+OQACgkQ64mZXMKQ
wqmgMg/9EEOoifhLaZxKkNnS1jL/LV9w9VNkkp2iZ5oPwJwzWkr4PHcvMZSBpTR9
zeo5XYDMl8OtR6RSlI8BhYpZQzOtuiUXvJ2MEYXYVsXPXolDCWziBjJQr11vfr21
/vhsRg8LxwIVBun5E20F0GnYPCtj/bB0PlyLymimLK2pO69sUo5Dr2/qIzHPa28W
80IdQBk+X6yQ6/ueawzmBaMJ8mzD7rFvafy64etpXOgQ9vKNDMBEFFlhoRBfpNGJ
ePhVJRRhqvJNpcykIHVyFoDlfd6fAVU00EB94sEg2ZePFMqoY30U5itthAlVOLNz
wshz+1LyCcmE5CHedm0/AlVXwfUBdFVaR9+Qzgbjq+T90kciaKpsMatOnsvzjzHX
jSm+kgoEc7d+hrC3NkX3eeTh89YZRiV3wHZJl87Oy+2Ux6QlpQn49VZDszgoNfb8
lUMR4OZxKuqRoVJhTJXEl32k8P9aljDGqt6t7DJ5TvNlCC5cd5S4JQBfvvEx26T5
9PTJ3QyFMom5+2Aox9SV6u0I4q77wjmznaShL86aMVpQgBzSECaMvIwnVFu5VkTH
qchnqpoe6GAglEcS1ZPk6pf8gGl32JoH5JQ0dvs5vr0Hc/yjy4y1DKLOYYvv11ds
zKas/Py0HQGjgJ6Eo5l1rvxNz6ehWvGb/0OtE2kKkXri5iLMvTc=
=Ut2j
-----END PGP SIGNATURE-----

--jhcsbhgj56dj35dk--
