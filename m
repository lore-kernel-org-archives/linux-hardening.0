Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0C2FCE14;
	Thu, 10 Jul 2025 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189891; cv=none; b=MdecIqUJ3DHkxxfPmvd0QkWq24M8J8ykS8EuxH7wxcbh1AUJpztlgX9KiLS4sjMa/Du96y9gsxzf7h+iFTS2tCVAb/VZkgGAK/+s8FAxb180onRESXO6KnRZM87/Vmwk76xVbZFmrGyk6ZwLN5XunlJA83wsH9TOgqMVq7OMRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189891; c=relaxed/simple;
	bh=yBhJ7jmYA0boZs71t+Q02sJpnvcmoh4aCEatyyAlf5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dInwQfIzt9nXOgDStLI5WbK6pX41j8QPIHAr8K25In9RVTNXtjBy2JddLEZMxSspxmco572wLM1ZJLJPKhbOVw2sPM6Qwq5U7uqfsSmydIjSMujgRrN++1cdiWJFPvdcc/V3dTrZQZ/Ts3EygAUPhhuC1/EHAxoQ6z256CPh4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEw4YreP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEw4YreP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD578C4CEE3;
	Thu, 10 Jul 2025 23:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752189891;
	bh=yBhJ7jmYA0boZs71t+Q02sJpnvcmoh4aCEatyyAlf5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEw4YrePhrzELF6Pbe1r3IR3JZKbRp9kpd275ZM81ATAPD9FK+QPu7dzyUDcsmuth
	 5vwMlR07emlBd5TJYUa+Qbcq7NyDE4PekGUH8kYVY6d2+WBHOPaN2/UfeD3LHfog4a
	 SCYoXz9dMA7OxWpmGhqGfA2yhN2KX9kSRQ3JfvF7A1eVdqTcAX5bDPnk+LyiYzkglw
	 xTZH6gClj3GarPQHaRdWBGS1Rk+lizFbpQekWzKSWRRs75nI4WwX5HNU39bLIBjGkr
	 CA3ZyBlcvBjuIfdgLspir3NumhiMsjGHaG2g9fVP7lTSFwP/hRgZKwpH9tHNA6E2mz
	 tjxN179EdSgiA==
Date: Fri, 11 Jul 2025 01:24:44 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <vgqpplbhg6krsufibrhe4n5agnh7vcrdsmoqd225guiakr3ojs@2dltrftpb3p2>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6edp5zcpae764526"
Content-Disposition: inline
In-Reply-To: <krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>


--6edp5zcpae764526
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>
MIME-Version: 1.0
In-Reply-To: <krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>

On Fri, Jul 11, 2025 at 01:23:56AM +0200, Alejandro Colomar wrote:
> Hi Linus,
>=20
> [I'll reply to both of your emails at once]
>=20
> On Thu, Jul 10, 2025 at 02:58:24PM -0700, Linus Torvalds wrote:
> > You took my suggestion, and then you messed it up.
> >=20
> > Your version of sprintf_array() is broken. It evaluates 'a' twice.
> > Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
> > argument.
>=20
> An array has no issue being evaluated twice (unless it's a VLA).  On the
> other hand, I agree it's better to not do that in the first place.
> My bad for forgetting about it.  Sorry.
>=20
> On Thu, Jul 10, 2025 at 03:08:29PM -0700, Linus Torvalds wrote:
> > If you want to return an error on truncation, do it right.  Not by
> > returning NULL, but by actually returning an error.
>=20
> Okay.
>=20
> > For example, in the kernel, we finally fixed 'strcpy()'. After about a
> > million different versions of 'copy a string' where every single
> > version was complete garbage, we ended up with 'strscpy()'. Yeah, the
> > name isn't lovely, but the *use* of it is:
>=20
> I have implemented the same thing in shadow, called strtcpy() (T for
> truncation).  (With the difference that we read the string twice, since
> we don't care about threads.)
>=20
> I also plan to propose standardization of that one in ISO C.
>=20
> >  - it returns the length of the result for people who want it - which
> > is by far the most common thing people want
>=20
> Agree.
>=20
> >  - it returns an actual honest-to-goodness error code if something
> > overflowed, instead of the absoilutely horrible "source length" of the
> > string that strlcpy() does and which is fundamentally broken (because
> > it requires that you walk *past* the end of the source,
> > Christ-on-a-stick what a broken interface)
>=20
> Agree.
>=20
> >  - it can take an array as an argument (without the need for another
> > name - see my earlier argument about not making up new names by just
> > having generics)
>=20
> We can't make the same thing with sprintf() variants because they're
> variadic, so you can't count the number of arguments.  And since the
> 'end' argument is of the same type as the formatted string, we can't
> do it with _Generic reliably either.
>=20
> > Now, it has nasty naming (exactly the kind of 'add random character'
> > naming that I was arguing against), and that comes from so many
> > different broken versions until we hit on something that works.
> >=20
> > strncpy is horrible garbage. strlcpy is even worse. strscpy actually
> > works and so far hasn't caused issues (there's a 'pad' version for the
> > very rare situation where you want 'strncpy-like' padding, but it
> > still guarantees NUL-termination, and still has a good return value).
>=20
> Agree.
>=20
> > Let's agree to *not* make horrible garbage when making up new versions
> > of sprintf.
>=20
> Agree.  I indeed introduced the mistake accidentally in v4, after you
> complained of having too many functions, as I was introducing not one
> but two APIs: seprintf() and stprintf(), where seprintf() is what now
> we're calling sprintf_end(), and stprintf() we could call it
> sprintf_trunc().  So I did the mistake by trying to reduce the number of
> functions to just one, which is wrong.
>=20
> So, maybe I should go back to those functions, and just give them good
> names.
>=20
> What do you think of the following?
>=20
> 	#define sprintf_array(a, ...)  sprintf_trunc(a, ARRAY_SIZE(a), __VA_ARGS=
__)
> 	#define vsprintf_array(a, ap)  vsprintf_trunc(a, ARRAY_SIZE(a), ap)
>=20
> 	char *sprintf_end(char *p, const char end[0], const char *fmt, ...);
> 	char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list =
args);
> 	int sprintf_trunc(char *buf, size_t size, const char *fmt, ...);
> 	int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args=
);
>=20
> 	char *sprintf_end(char *p, const char end[0], const char *fmt, ...)
> 	{
> 		va_list args;
>=20
> 		va_start(args, fmt);
> 		p =3D vseprintf(p, end, fmt, args);

Typo here.  It's vsprintf_end().

> 		va_end(args);
>=20
> 		return p;
> 	}
>=20
> 	char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list =
args)
> 	{
> 		int len;
>=20
> 		if (unlikely(p =3D=3D NULL))
> 			return NULL;
>=20
> 		len =3D vsprintf_trunc(p, end - p, fmt, args);
> 		if (unlikely(len < 0))
> 			return NULL;
>=20
> 		return p + len;
> 	}
>=20
> 	int sprintf_trunc(char *buf, size_t size, const char *fmt, ...)
> 	{
> 		va_list args;
> 		int len;
>=20
> 		va_start(args, fmt);
> 		len =3D vstprintf(buf, size, fmt, args);

Typo here.  It's vsprintf_trunc().

> 		va_end(args);
>=20
> 		return len;
> 	}
>=20
> 	int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args)
> 	{
> 		int len;
>=20
> 		if (WARN_ON_ONCE(size =3D=3D 0 || size > INT_MAX))
> 			return -EOVERFLOW;
>=20
> 		len =3D vsnprintf(buf, size, fmt, args);
> 		if (unlikely(len >=3D size))
> 			return -E2BIG;
>=20
> 		return len;
> 	}
>=20
> sprintf_trunc() is like strscpy(), but with a formatted string.  It
> could replace uses of s[c]nprintf() where there's a single call (no
> chained calls).
>=20
> sprintf_array() is like the 2-argument version of strscpy().  It could
> replace s[c]nprintf() calls where there's no chained calls, where the
> input is an array.
>=20
> sprintf_end() would replace the chained calls.
>=20
> Does this sound good to you?
>=20
>=20
> Cheers,
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--6edp5zcpae764526
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhwS7wACgkQ64mZXMKQ
wqlOQxAAqQqG5Z7+Xh1jkMiJqhKKnJ4dTK0nc7NVJNqdOHZBJCjt7CCvZulq+QO5
TAKjjj5aaK3ZA+XB42UNR6cya6aL88fDOr4d6srebkLTkGoEXnjBN/VWardd8z2d
Iq8z4UsaxfDDA8OQVz2lbcnFxA2KSszs9SwsP0mZZXjCZSdrIKqguPaexaJ1ZSkC
IML9PzRqUqm9KbJn9qroGTx5DWRg2hf/q+T6PxCjzU+DDQL7mh1+XHgL3EXL1s4Y
9+DnXRe+s9VJ8A/TcAwlbdZO99Cp4YpnNJP+m8y0wOJpOgIwlk51hbGGZ2U+jIU9
nISZk+EZTERJLqU06PVPp3wVyWhxTqVIcbxhQTGKGumltTWaHu2i2yI/RkoMLL/c
FRm8AnuO4X874TUc9JJTCq9ycz0BAv8YRmbNDmZoVcm8XhBzKVPo03h1LOm/kTnq
+seYP9mJz6BiFwSXok60CZrsflPlaob3z3tFnMgwG/7qXwMnS6gW3FDRMFMuPVCf
7vmiDiXMOf0sjwYzM0AYDqqWaGDloWBxU0KwUH0e9+Tp/mDxJbaCxr/1G7fyX3QL
QtRd6yUURufITU56DsxEJYx9PkDdheYm9JI91ZFHEajSrR0FzQd+SwcNivSk6q8p
fYtGfPwriq8GxHRzTxeYlCWcy2YKIhb63RLIRNuIgcDyDZ+EKhc=
=icSd
-----END PGP SIGNATURE-----

--6edp5zcpae764526--
