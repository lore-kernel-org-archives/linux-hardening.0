Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884354;
	b=h78B/tw8kRgUsSOzl34SVeJYXhxbRCEWhobPSqlB2Uq6wV8LNNcx2HDA6f1Gg9/yLckp
	 oiS5xiXdfhB87iuKblLAtK9uKHH4yUz5EhDJuPWQVKAI8MbhzQRnv408KbFJzsast+L9e
	 r8VYv59vSKoPZM9iytB7wWjhV4UCntv/v/vT1fCKwE73rYajqVLLZbp2bEdf5xDidoq0X
	 thvXzQ7n5akZZT9U1Ln3g9e1NcqvlfRUBmr17dRt/sG2Ww4XPHq2lrY0jJjqTkBOnM0H2
	 /fDsfUBqeEVZvaFJ9pNUwXBdtLB94TpW0SBvj45cxNYVsdOqJHqE2z1JLIQcLf40OtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884354;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ATs7HnEmdEhe3LI5EGd4ZDDcZFgADNZDDnrPzFT1G/U=;
	b=xZ08ENuWFGqqbIE/0tyD5qoslKVvP5c5wS/vBJ9irJOF540D4U4ZmoGQWA70F8Az2vSQ
	 OH2ayNVkF2Wb/RUFJ7GnpCwi7EgpVfz5EyRy6vQgX7Vl4PTYsJz5VB3Hy83/V61z2E+jC
	 6QYB8x5yRANwzlFVYzoHTwMMX6lm2v9RC6OvtQQpFMaeebRFTvlc4eCCgpF5AIN1sgWR6
	 52zLCNjBIkHdLkdVsR3/uIOlV9OpK67VJofsWm8oidofLEZH2gRo1DqTERAg6udHRD+FH
	 BeVXF70SjCWiexvhrK5MyfCFz95hBxXsTtVkXd0Bllkvnp8zfZyRj3n5id/aR/ami+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqkhb4BT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5A606A328;
	Thu,  5 Nov 2026 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqkhb4BT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5F91F0093A;
	Thu,  5 Nov 2026 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884354;
	bh=ATs7HnEmdEhe3LI5EGd4ZDDcZFgADNZDDnrPzFT1G/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iqkhb4BTwiwYOge5iCFEfhEkaL/EnD/u8J0qHmXuwCPPCENjMY2HR3hfj2dL+LKJo
	 iPthIADrNq+UqDDGxpDWIlZp69nysgmiZuDoY+tdh/pmc69g65jgJiP03bAGmztZBo
	 fVti/3jnMDOVC5IPmcghcgZ0MlEJ0xKJIMqZhqZeNm6p6Dqj6HfRB4HcC4krYwKJM+
	 mGPlc1CxazUbWWZfPJfhWIbGCCLBCBe58On/YQR/CdIqSztRvUu//tHO9AfSumFwbk
	 Ccs4yCwTwFH+wnIfRHmDP6BmfRT4vRS+GVNjFvmZsAstaFGQOE9PD7iwcVt+qNhE9Q
	 MEUWncVtcDe+Q==
Date: Thu, 5 Nov 2026 14:12:25 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: alx@kernel.org, andy@kernel.org, bartosz.golaszewski@oss.qualcomm.com, 
	brgl@kernel.org, dakr@kernel.org, devicetree@vger.kernel.org, djrscally@gmail.com, 
	driver-core@lists.linux.dev, gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, 
	hverkuil-cisco@xs4all.nl, joe@perches.com, johan@kernel.org, kees@kernel.org, 
	laurent.pinchart@ideasonboard.com, lenb@kernel.org, linusw@kernel.org, linux-acpi@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, rafael@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	sakari.ailus@linux.intel.com, saravanak@kernel.org, schwab@linux-m68k.org, 
	torvalds@linux-foundation.org, zanussi@kernel.org
Subject: Re: [PATCH v2 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <aux8LYQkGSNjCGHv@devuan>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
 <20261105125154.83478-1-geert@linux-m68k.org>
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
	protocol="application/pgp-signature"; boundary="bg5kk5tvxzt5budg"
Content-Disposition: inline
In-Reply-To: <20261105125154.83478-1-geert@linux-m68k.org>


--bg5kk5tvxzt5budg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: alx@kernel.org, andy@kernel.org, bartosz.golaszewski@oss.qualcomm.com, 
	brgl@kernel.org, dakr@kernel.org, devicetree@vger.kernel.org, djrscally@gmail.com, 
	driver-core@lists.linux.dev, gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, 
	hverkuil-cisco@xs4all.nl, joe@perches.com, johan@kernel.org, kees@kernel.org, 
	laurent.pinchart@ideasonboard.com, lenb@kernel.org, linusw@kernel.org, linux-acpi@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, rafael@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	sakari.ailus@linux.intel.com, saravanak@kernel.org, schwab@linux-m68k.org, 
	torvalds@linux-foundation.org, zanussi@kernel.org
Subject: Re: [PATCH v2 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <aux8LYQkGSNjCGHv@devuan>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
 <20261105125154.83478-1-geert@linux-m68k.org>
MIME-Version: 1.0
In-Reply-To: <20261105125154.83478-1-geert@linux-m68k.org>

Hi Geert,

> Date: 2026-11-05 13:51:54+0100
> From: Geert Uytterhoeven <geert@linux-m68k.org>
>
> 	Hi Alejandro,
>=20
> On Thu, 5 Nov 2026 13:46:29, Alejandro Colomar wrote:
> > As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> > between an empty prefix matching an empty string from a non-matching
> > prefix.  This is a fundamental design flaw in this API, and not
> > something that can be fixed.
> >=20
> > As always, this is a consequence of choosing sizes instead of pointers.
> > Sizes are often the wrong choice.  In this specific case, pointers are
> > more capable of differentiating these cases, as NULL is a special
> > sentinel value that doesn't need to overload a valid value.
> >=20
> > Let's implement strprefix(), a function that returns a pointer
> > right after the prefix if found, and a null pointer if not found.
> >=20
> > We'll slowly migrate existing code from str_has_prefix() to strprefix().
> >=20
> > Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
>=20
> Thanks for your patch!

:-)

> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -545,16 +545,33 @@ void memcpy_and_pad(void *dest, size_t dest_len, =
const void *src, size_t count,
> >  	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
> >  })
> > =20
> > +/**
> > + * strprefix - string prefix
>=20
> Naive me assumes this function must return the prefix of the string,
> so IMO is it named badly.

To return the prefix, it'd have to return the second parameter, but the
called already has that, so I expect users would be smart enough to not
expect that.

One could expect that it maybe returns the prefix within the string, but
that would mean returning the string itself, since the prefix must
necessarily start in the first byte.  So, I also expect users to be
smart enough to not expect that.

A plausible name to avoid the pathological interpretations of the name
could be strafterprefix(), but I tend to dislike the unnecessary 'after'
in the name, perhaps because I think the interpretations above are
pathologically wrong.

Do you think strafterprefix() would be better?  Do you have any other
suggestions?

I would prefer keeping the name strprefix(), and perhaps improving
documentation.

> > + * @s: The string to be tested
> > + * @prefix: The string to see if @s starts with
> > + *
> > + * Returns:
> > + * *  @s+strlen(@prefix) if @s starts with @prefix
> > + * *  NULL if @s does not start with @prefix
> > + */
> > +static __always_inline char *strprefix(const char *s, const char *pref=
ix)
>=20
> This returns a non-const substring of the original const parameter, thus
> allowing the caller to modify the original even when it is const.
>=20
> While this is not uncommon behavior for existing standard string
> helpers, I think it would be good to make new functions safer, by not
> allowing to drop constness.  Using _Generic() can be used to support
> both const and non-const strings in a safe way.

Agree.  That's in fact what we do in shadow-utils.  I didn't do it here,
because I didn't know if that kind of magic would be appreciated here.

Here's what we do in shadow-utils:

	#define strprefix(s, prefix)                                  \
	(                                                             \
		const_cast(CQChar_of(s) *, strprefix_(s, prefix))     \
	)

	#define const_cast(T, p)  _Generic(p, const T: (T) (p), default: (p))

	#define CQChar_of(s)    QChar_of(const, s)
	#define QChar_of(Q, s)  typeof                                \
	(                                                             \
		_Generic((QVoid_of(s) *){0},                          \
			Q void *:  (Q char){0},                       \
			void *:    (char){0}                          \
		)                                                     \
	)
	#define QVoid_of(p)     typeof((QVoidptrof_(p)){0}[0])
	#define QVoidptrof_(p)  typeof(1?(p):(void*){0})

	const char *
	strprefix_(const char *s, const char *prefix)
	{
		if (strncmp(s, prefix, strlen(prefix)) !=3D 0)
			return NULL;

		return s + strlen(prefix);
	}

I could do the same here.  Do we want a const_cast() macro?  Or do we
want an open-coded cast?  We use const_cast() in shadow-utils to prevent
accidents in casts that may do very bad stuff.  const_cast() makes sure
we only drop (or add) const at most.

Also, do we want to add the old-style strprefix() now and improve the
const-correctness in a separate patch set?  Or do we want to do all at
once?  I don't mind either way.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--bg5kk5tvxzt5budg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsgLMACgkQ64mZXMKQ
wqlP/w/+NcC1MFIsR7fsdtwEOzc4rsVyMmVZ6JLaXGJ/kIpkNDdlxoiM+nt2ySj1
TKNuX6AtteEaO/xbOpIuyWuaC7LcyTGzYUeeS/8H/jHibC03iW23ltVQJJzM6zRE
+NST4GM8lvMyzmnnAdvr7cS+DM0d2X/5mOm4y4YJYKtxGOJrmm6CGSgx5f3CdcBE
/Z/hQoBMLppwmkCD0ASbzz7Pn3y6vWBJPYKuwKnvNm31ZT/YyOh4a8umcXkWZ45/
wWF8cXQV7CXR4WJ4eko7ZDH3p3ug27GZKIjwz1S5IN8SwPsan3wssGeyNw7KBPM2
vPq32jUfEHq4Q/xsX3JWvYSULcDh/WwDC054rD+Wv18p0S4HmMdYgSAP/xvzqKqP
yERQyZCBPWXK6sQmZA38lqFayiNg2I/1JaHPMYHqi9GrUOuGMnmahyiAve9ArngA
XV8SOYT8KJe+NVGR4jVlWkF3jwRfxJIJ3HCXeV53My8Du6YGK/sIUJv/65dfoJml
cRKsR4pSSFEi9VUh3/iXWZNE6TCBC1eyXRyPIZGB81xlr8DAmV2WBWDT0cEn6jwI
Q8BwX8vZHCkEqH+9C0m3RFvNsPSWy41lnikXwbxp9F/9IlRfWTGtzQN0l/4cTDOw
apqwwRvWEyuoUTRp4Go/mlQqXZkW8EvQvJh7gR6jI+Qi1JgmZrM=
=Rmdl
-----END PGP SIGNATURE-----

--bg5kk5tvxzt5budg--
