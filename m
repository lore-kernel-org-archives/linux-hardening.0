Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC872F5C52;
	Thu, 10 Jul 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189836; cv=none; b=hGDNgTPMKVH6oMQpe+goQ0Iqs0jUR54rxoZmEfv7e8xAdjVUYwAGEwtvv5IizvnmhfknImsMkA++Sp/iqtXP+xOPhLE778uezNhg6iJNnSkomw6ulTr6rUHQTVc9GcMV9erddb5AT367FSlpfWSibqlNznE4utrPnRUdSdOQgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189836; c=relaxed/simple;
	bh=KOQiERexs/yoLixl7P/bNkDLLxMUFU5pJHpr73kZB+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsQR2rf83SFtLVGwuu1SZoB3OHTwqIvEquvIBqg84TBql/fajA493BbLDQlrkhJMSzl40hNM3lXw4epUCV9t1az77xh4wz3NoEBCBq1e/iLryHM48tSoD1lxxrHPAM/WcyDbJjXzHhj5JtiZbIYa8NPWkSaBDiDePQxpDD7uKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFnRv05a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFnRv05a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C565FC4CEE3;
	Thu, 10 Jul 2025 23:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752189836;
	bh=KOQiERexs/yoLixl7P/bNkDLLxMUFU5pJHpr73kZB+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFnRv05aBMMuD/UovBMBpX3B8jxMY9f6DsVdtK63J1obMVr4sUhL5pIrBCDQ3Ezzz
	 Yh2ec9j5axRzT0BTskYRmQdXnTJeaHXa7JDcJZC6R6U5wgNrlaGeodlPjidmoy2CAX
	 5sx3MLsPRN3HdfV2uPg0Z86KZpbfb3HyMqTlI5J9kr+Ow2sr+tvS9Qj8tQAxw30GA+
	 b4+biY5FUVNppRK5T0auXi4LzwTCsVqMxP8AMomdKW1iKEeQ1i0knwvO8GFl1oLAFv
	 rkCVB/RHjRXdnIZk+gPMQC3VQ05OW36oBAh4uzaGectYOW+6gb/442tjmaT91vNVZ+
	 xXY4jFLQRDFKw==
Date: Fri, 11 Jul 2025 01:23:49 +0200
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
Message-ID: <krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpnpaylljl22ydn2"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>


--lpnpaylljl22ydn2
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
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>

Hi Linus,

[I'll reply to both of your emails at once]

On Thu, Jul 10, 2025 at 02:58:24PM -0700, Linus Torvalds wrote:
> You took my suggestion, and then you messed it up.
>=20
> Your version of sprintf_array() is broken. It evaluates 'a' twice.
> Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
> argument.

An array has no issue being evaluated twice (unless it's a VLA).  On the
other hand, I agree it's better to not do that in the first place.
My bad for forgetting about it.  Sorry.

On Thu, Jul 10, 2025 at 03:08:29PM -0700, Linus Torvalds wrote:
> If you want to return an error on truncation, do it right.  Not by
> returning NULL, but by actually returning an error.

Okay.

> For example, in the kernel, we finally fixed 'strcpy()'. After about a
> million different versions of 'copy a string' where every single
> version was complete garbage, we ended up with 'strscpy()'. Yeah, the
> name isn't lovely, but the *use* of it is:

I have implemented the same thing in shadow, called strtcpy() (T for
truncation).  (With the difference that we read the string twice, since
we don't care about threads.)

I also plan to propose standardization of that one in ISO C.

>  - it returns the length of the result for people who want it - which
> is by far the most common thing people want

Agree.

>  - it returns an actual honest-to-goodness error code if something
> overflowed, instead of the absoilutely horrible "source length" of the
> string that strlcpy() does and which is fundamentally broken (because
> it requires that you walk *past* the end of the source,
> Christ-on-a-stick what a broken interface)

Agree.

>  - it can take an array as an argument (without the need for another
> name - see my earlier argument about not making up new names by just
> having generics)

We can't make the same thing with sprintf() variants because they're
variadic, so you can't count the number of arguments.  And since the
'end' argument is of the same type as the formatted string, we can't
do it with _Generic reliably either.

> Now, it has nasty naming (exactly the kind of 'add random character'
> naming that I was arguing against), and that comes from so many
> different broken versions until we hit on something that works.
>=20
> strncpy is horrible garbage. strlcpy is even worse. strscpy actually
> works and so far hasn't caused issues (there's a 'pad' version for the
> very rare situation where you want 'strncpy-like' padding, but it
> still guarantees NUL-termination, and still has a good return value).

Agree.

> Let's agree to *not* make horrible garbage when making up new versions
> of sprintf.

Agree.  I indeed introduced the mistake accidentally in v4, after you
complained of having too many functions, as I was introducing not one
but two APIs: seprintf() and stprintf(), where seprintf() is what now
we're calling sprintf_end(), and stprintf() we could call it
sprintf_trunc().  So I did the mistake by trying to reduce the number of
functions to just one, which is wrong.

So, maybe I should go back to those functions, and just give them good
names.

What do you think of the following?

	#define sprintf_array(a, ...)  sprintf_trunc(a, ARRAY_SIZE(a), __VA_ARGS__)
	#define vsprintf_array(a, ap)  vsprintf_trunc(a, ARRAY_SIZE(a), ap)

	char *sprintf_end(char *p, const char end[0], const char *fmt, ...);
	char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list ar=
gs);
	int sprintf_trunc(char *buf, size_t size, const char *fmt, ...);
	int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args);

	char *sprintf_end(char *p, const char end[0], const char *fmt, ...)
	{
		va_list args;

		va_start(args, fmt);
		p =3D vseprintf(p, end, fmt, args);
		va_end(args);

		return p;
	}

	char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list ar=
gs)
	{
		int len;

		if (unlikely(p =3D=3D NULL))
			return NULL;

		len =3D vsprintf_trunc(p, end - p, fmt, args);
		if (unlikely(len < 0))
			return NULL;

		return p + len;
	}

	int sprintf_trunc(char *buf, size_t size, const char *fmt, ...)
	{
		va_list args;
		int len;

		va_start(args, fmt);
		len =3D vstprintf(buf, size, fmt, args);
		va_end(args);

		return len;
	}

	int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args)
	{
		int len;

		if (WARN_ON_ONCE(size =3D=3D 0 || size > INT_MAX))
			return -EOVERFLOW;

		len =3D vsnprintf(buf, size, fmt, args);
		if (unlikely(len >=3D size))
			return -E2BIG;

		return len;
	}

sprintf_trunc() is like strscpy(), but with a formatted string.  It
could replace uses of s[c]nprintf() where there's a single call (no
chained calls).

sprintf_array() is like the 2-argument version of strscpy().  It could
replace s[c]nprintf() calls where there's no chained calls, where the
input is an array.

sprintf_end() would replace the chained calls.

Does this sound good to you?


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--lpnpaylljl22ydn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhwS38ACgkQ64mZXMKQ
wqmhJhAAhZBNcIE/LkNJtDs9GNCCyYFQN+O55h5xwKBvOeNPeOX9QO202kKaYgsO
+BNzl6ccOtttWGx1ReDyi4BrB78LZGtm17mfXSb+kDpeThSMOc4uBdVepQ3CpXwg
p4fdLPwNMWp3kRyN0Y4t8+w4mejmpSKQtwoY/Es/IKp6h8ol+ivkM0V46NviK//I
fqvkaLIeMoiM2fks1mvdELYGBdTtSTjI3iFd5gP8Gk+oxIS6csyjE1MCQbUBcAp1
VNaVVTRNstB34zYgQ6LhL2TzZySl7h1QK4Vd1yN8h8gRSg0TM3U3dWQ0ThcvjnDo
cmoo8L3vj+Ya/hirwJ4h3MR0mSRKgDqvFSXC+p1/tI3xZCZZIFuuALQ2OLIl9gD2
yibSSV6NCBLueGs/UrUIT0Z7d/adiroKW9CRmsMdmLQSsIUDRNlARo2vndL9wU7S
wjBHqh/feWZ9R/1DNQfPgOuqMaqGBqm8wh2eyp828bIgAu+YV75apRZ1Q5kWJTwx
IydZHSnOViZbfo7sDxBG6s6APp2eJJN7+RZpL1doZctkneboKN2L7EYg2ZJErmgO
oYOCbbyGkRqWkedbQ0zOJL7tanUA0zT9OPLABVV/hY6QngajyUeix4pP+ve76aJH
fggtgH9SFW1uhmA7dCnBF1SABfPMrgFB+71kzC6wI+BBgGleLKs=
=hhWT
-----END PGP SIGNATURE-----

--lpnpaylljl22ydn2--
