Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427058;
	b=dW5Mrd0ZzMEjUUtlYVl5Yq1BUu8thvIIqS97RcFl73+FuRcatf0l5GEpmw/cXfYAd6gR
	 wPNOF4KwQmVXy43GQg4UBZuPyU+EK9jrV5NtqMscvdG/IXo5DttrPKYJZouXUIk03R77D
	 I64YVT75g/eqdtrJzxhioNXospJeXlp8nC8d/JEjsS5uP62sxprokCPtW4fqa0hxHUhoW
	 0+STXo1xtXuY6kIkqkDe8CQjPnX6wea+42qfjQmmpJyJvvKQPOxE3xRa8hOlkpd2GYMea
	 ljw3jdu5C4CFkakaTd7LDA3kI7rDCsHnf7EErlK1N587kWlgXevJac+6ODj22U3y2Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427058;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QWBWav1cp1GKn3RCOV39/sy+/mqjj3e4l5sc6Ipflxw=;
	b=x0vkktVt3fa8el8XYai3PGC7MOunJNwPjQBpzrGgLFI21ejYtabDvLJPphTI2a7mqaol
	 jGQBHhpVmlU2Q0z8e6cL8Aju2YpWarPOdlxlYbeVD9UKTmAK8bdMtNSJ+HGMRK7dwsKAB
	 XM88/9Kp4rQ6kfZmwsCH/GLb+LsB3UCPSiWC63PmzSjL8lZ7s6X1u5PiW+92ct9zFw7j/
	 YA6eFDhfIcL9BPJ7LttiP/X3ybWPEvyTT17j4zYgZGiyKOeQultdN5484/ceubIkXQlDI
	 T48VdLtePrF+67AsOaqBmemogNH17uqNWWCjKSnla4RMp5jTVQP5USewxQAClB+rZMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWqivWmr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE565606A31C;
	Wed, 11 Nov 2026 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWqivWmr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD4A1F00A05;
	Wed, 11 Nov 2026 19:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427058;
	bh=QWBWav1cp1GKn3RCOV39/sy+/mqjj3e4l5sc6Ipflxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UWqivWmrkbKzsiRjycnRaUXRmPS6cQD99O9eWIpZznd6Hc8LQBxNGmjimWWvLEi9D
	 OYVmXpoeXfZG4Nu721aa0F+r5u/9xBqd5k8ldxq4f0O2yLia2F0kZpJcmonuqTW4NT
	 pqa+eksNtrOQtwJ5wgKfkZrpfUywc7hAg1H0HLRqwRLPmF1e0lYQMNlCSch2dRtdSj
	 VNhcNcAV8ZLXRwlb1j1f+2ArJaehGkXR//BAkTZB0OuCsFij7H5sPzvtn5nDSK7h1h
	 kpDRF6v9x0jkdfc2MSNrL2NXHo3jUcM8ZoyhVd7ztBHRArBuTigK6/Qb0yUoBbDa7b
	 Lypa2riHNLRbg==
Date: Wed, 11 Nov 2026 20:57:30 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add strprefix() and fix a bug with it
Message-ID: <avTIWshl9klX0obF@devuan>
References: <cover.1794425425.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="67pbkwc2bccukozj"
Content-Disposition: inline
In-Reply-To: <cover.1794425425.git.alx@kernel.org>


--67pbkwc2bccukozj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add strprefix() and fix a bug with it
Message-ID: <avTIWshl9klX0obF@devuan>
References: <cover.1794425425.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794425425.git.alx@kernel.org>

> Date: 2026-11-11 20:55:07+0100
> From: Alejandro Colomar <alx@kernel.org>
>
> Hi!
>=20
> str_has_prefix() is based on sizes and lengths, which means it must
> overload the valid length 0 to mean not found.  This is a typical
> consequence of choosing to design an API around sizes and lengths, and
> vanishes when moving to pointer-based similar APIs.
>=20
> According to its author (Steven R.), str_has_prefix() was never meant to
> accept an empty prefix, but that's not documented, and there's no
> obvious reason why that would be acceptable for a generic string
> function (as opposed to a function very specific to its original use).
> Anyway, as suggested by Steven, I've added a WARN_ON_ONCE() to catch
> such uses, and also added documentation stating this limitation.
>=20
> Users of strings need a function whose behavior extends naturally to the
> empty string, and we can do better, by returning a pointer.  And indeed,
> users have ended up using str_has_prefix() with empty prefix, expecting
> it to work (as is natural of a generic string API).
>=20
> This patch set adds strprefix(), deprecates str_has_prefix(), and uses
> strprefix() in one place to fix a bug reported by Bartosz.
>=20
> We can later work on replacing the other uses of str_has_prefix(), which
> might hide similar bugs.
>=20
> This patch set also adds infrastructure to make string functions return
> a pointer that is as qualified as the input pointer.
>=20
> Changes in v4
> ~~~~~~~~~~~~~
>=20
> -  [1/6]
>    -  Remove deprecation notice.  [Steve]
>    -  Move documentation of str_has_prefix() to strprefix().  [Steve]
>    -  Document str_has_prefix() by comparing it to strprefix().
>    -  Match parameters in documentation and code.
> -  [2/6]
>    -  Add WARN_ON_ONCE() to str_has_prefix().  [Steve]
>    -  Document limitation of str_has_prefix().
> -  [3/6]  -- no changes --
> -  [4/6]
>    -  Document that it might drop const, but doesn't need to.
>    -  Make const_cast() more robust, by replacing 'default:'
>       with 'T:'.  [David]
> -  [5/6] =20
>    -  Replace [0] array notation with * pointer notation, to silence
>       spurious -Wpointer-arith diagnostic.  I wouldn't have changed
>       anything if it weren't nontrivial, because that diagnostic is not
>       part of -Wall -Wextra, and is also not too important, but since
>       the solution was trivial, I'm fine with it.  TBH, I prefered [0],
>       but I can live with *.  [sashiko]
> -  [6/6]
>    -  Define the macro after the function, to avoid wrapping the
>       function name in parentheses.  [Joe, David]
>    -  Document why we need CQChar_of() --the simpler typeof()-- is not
>       good enough.  [David]
>    -  Change the function to return non-const.  const_cast() can't add
>       const, it only removes it; thus, we must have it always in the
>       function, and then have const_cast() drop it conditionally.  This
>       also removes a cast.  [sashiko]
>=20
> I didn't apply some changes requested by reviewers:
>=20
> -  I didn't rename const_cast(), since I'm not convinced about the
>    suggested alternatives being better.  And after all, a cast is only
>    needed for dropping const, but never for adding it (because it adds
>    implicitly), so a const_cast() obviously implies that const might be
>    dropped.
>=20
> See range-diff below.
>=20
> Testing
> ~~~~~~~
>=20
> I haven't changed the implementation of the function meaningfully, so
> haven't re-run tests.  Since the changes since v2 are only about type
> safety and diagnostics, I have built again with 'allmodconfig', just to
> make sure it still compiles.

Ouch!  It seems I had built before adding WARN_ON_ONCE(), not after.
I just saw a compiler error in a background terminal after hitting send.

	$ make=20
	  DESCEND objtool
	  CC      arch/x86/purgatory/sha256.o
	In file included from ./include/crypto/sha2.h:10,
			 from lib/crypto/sha256.c:13:
	./include/linux/string.h: In function =E2=80=98str_has_prefix=E2=80=99:
	./include/linux/string.h:619:9: error: implicit declaration of function =
=E2=80=98WARN_ON_ONCE=E2=80=99 [-Wimplicit-function-declaration]
	  619 |         WARN_ON_ONCE(len =3D=3D 0);
	      |         ^~~~~~~~~~~~
	make[4]: *** [arch/x86/purgatory/Makefile:12: arch/x86/purgatory/sha256.o]=
 Error 1
	make[3]: *** [scripts/Makefile.build:572: arch/x86/purgatory] Error 2
	make[2]: *** [scripts/Makefile.build:572: arch/x86] Error 2
	make[1]: *** [/srv/alx/src/linux/linux/master/Makefile:2244: .] Error 2
	make: *** [Makefile:248: __sub-make] Error 2

Will fix that for v5, and fully test again.


Cheers,
Alex

>=20
> Alejandro Colomar (6):
>   string: Add strprefix(), and deprecate str_has_prefix()
>   string: Warn if the prefix is the empty string
>   device property: Fix fwnode_name_eq() for empty node names
>   stddef: Add const_cast()
>   string: Add [C]QChar_of() and QVoid_of()
>   string: Make strprefix() const-qualifier-generic
>=20
>  drivers/base/property.c  |  5 +---
>  include/linux/stddef.h   | 12 ++++++++
>  include/linux/string.h   | 62 +++++++++++++++++++++++++++++++++++++---
>  lib/tests/string_kunit.c |  9 ++++++
>  4 files changed, 80 insertions(+), 8 deletions(-)
>=20
> Range-diff against v3:
> 1:  556766412884 ! 1:  a74fabd985a8 string: Add strprefix(), and deprecat=
e str_has_prefix()
>     @@ Commit message
>     =20
>          We'll slowly migrate existing code from str_has_prefix() to strp=
refix().
>     =20
>     -    Copy the description from str_has_prefix().
>     +    Move the description from str_has_prefix(), and describe
>     +    str_has_prefix() by comparing it to strprefix().
>     =20
>          Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualco=
mm.com>
>          Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-fo=
r-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
>     @@ Commit message
>     =20
>       ## include/linux/string.h ##
>      @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t de=
st_len, const void *src, size_t count,
>     + 	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
>       })
>      =20
>     - /**
>     -- * str_has_prefix - Test if a string has a given prefix
>     -- * @str: The string to test
>     -- * @prefix: The string to see if @str starts with
>     ++/**
>      + * strprefix - string prefix
>      + * @s: The string to be tested
>      + * @prefix: The string to see if @s starts with
>     -  *
>     -  * A common way to test a prefix of a string is to do:
>     -  *  strncmp(str, prefix, sizeof(prefix) - 1)
>     -  *
>     -  * But this can lead to bugs due to typos, or if prefix is a pointer
>     -- * and not a constant. Instead use str_has_prefix().
>     -+ * and not a constant. Instead use strprefix().
>     ++ *
>     ++ * A common way to test a prefix of a string is to do:
>     ++ *  strncmp(s, prefix, sizeof(prefix) - 1)
>     ++ *
>     ++ * But this can lead to bugs due to typos, or if prefix is a pointer
>     ++ * and not a constant.  Instead use strprefix().
>      + *
>      + * Returns:
>      + * *  @s+strlen(@prefix) if @s starts with @prefix
>     @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t des=
t_len, const v
>      +	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
>      +}
>      +
>     -+/**
>     -+ * str_has_prefix - Test if a string has a given prefix
>     -+ * @str: The string to test
>     -+ * @prefix: The string to see if @str starts with
>     -+ *
>     -+ * DEPRECATED: Use strprefix()
>     -+ *
>     -+ * A common way to test a prefix of a string is to do:
>     -+ *  strncmp(str, prefix, sizeof(prefix) - 1)
>     -+ *
>     -+ * But this can lead to bugs due to typos, or if prefix is a pointer
>     -+ * and not a constant. Instead use strprefix().
>     + /**
>     +  * str_has_prefix - Test if a string has a given prefix
>     +  * @str: The string to test
>     +  * @prefix: The string to see if @str starts with
>     +  *
>     +- * A common way to test a prefix of a string is to do:
>     +- *  strncmp(str, prefix, sizeof(prefix) - 1)
>     +- *
>     +- * But this can lead to bugs due to typos, or if prefix is a pointer
>     +- * and not a constant. Instead use str_has_prefix().
>     ++ * This is similar to strprefix(), but returns an offset instead of
>     ++ * a pointer.
>        *
>        * Returns:
>        * * strlen(@prefix) if @str starts with @prefix
> -:  ------------ > 2:  cd09427148a0 string: Warn if the prefix is the emp=
ty string
> 2:  eed085c85f36 =3D 3:  0058b60f662c device property: Fix fwnode_name_eq=
() for empty node names
> 3:  2bf5cf7baad8 ! 4:  ce623fe0432b stddef: Add const_cast()
>     @@ Commit message
>          It's similar to C++'s const_cast(), but it is more restrictive: =
it can
>          only cast away 'const', and not arbitrary qualifiers.
>     =20
>     +    David made it a bit more robust.
>     +
>     +    Link: https://lore.kernel.org/linux-hardening/20261111102535.434=
c2eee@pumpkin/
>     +    Co-developed-by: David Laight <david.laight.linux@gmail.com>
>          Signed-off-by: Alejandro Colomar <alx@kernel.org>
>     =20
>       ## include/linux/stddef.h ##
>     @@ include/linux/stddef.h: enum {
>       	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
>      =20
>      +/**
>     -+ * const_cast() - Drop const in the left-most derivation of a point=
er
>     ++ * const_cast() - At most, drop const in the left-most derivation o=
f a pointer
>      + *
>      + * @T: Type for the cast.
>      + * @p: Pointer to be casted.
>      + *
>      + * If @p is of type const @T, then it is casted to @T.
>     -+ * Otherwise, @p is returned without any casts.
>     ++ * If @p is of type @T, then it is returned without any casts.
>      + * This avoids mistakes that change anything other than 'const' in =
a cast.
>      + */
>     -+#define const_cast(T, p)  _Generic(p, const T: (T) (p), default: (p=
))
>     ++#define const_cast(T, p)  _Generic(p, const T: (T) (p), T: (p))
>      +
>       #endif
> 4:  415453a31ebf ! 5:  206d2045abcf string: Add [C]QChar_of() and QVoid_o=
f()
>     @@ include/linux/string.h
>      + * This macro produces the type name 'void',
>      + * qualified with any qualifiers present in the element of @p.
>      + */
>     -+#define QVoid_of(p)       typeof((__QVoidptr_of(p)){0}[0])
>     ++#define QVoid_of(p)       typeof(*(__QVoidptr_of(p)){0})
>      +#define __QVoidptr_of(p)  typeof(1?(p):(void*){0})
>      +
>      +/**
> 5:  35bf6672f84f ! 6:  69d1792e5edf string: Make strprefix() const-qualif=
ier-generic
>     @@ Metadata
>       ## Commit message ##
>          string: Make strprefix() const-qualifier-generic
>     =20
>     +    Add a macro of the same name, which returns a pointer that is
>     +    const-qualified iff the input string is const-qualified.  The re=
turn
>     +    type is a possibly-const-qualified pointer to char, even if the =
input
>     +    is a possibly-const-qualified pointer to void, which is why we r=
equire
>     +    the CQChar_of() macro.
>     +
>     +    The function now needs to return 'const char *', because const_c=
ast()
>     +    can only drop const, but never add it.
>     +
>          Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>     +    Cc: Joe Perches <joe@perches.com>
>     +    Cc: David Laight <david.laight.linux@gmail.com>
>          Signed-off-by: Alejandro Colomar <alx@kernel.org>
>     =20
>       ## include/linux/string.h ##
>     @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t des=
t_len, const v
>        * *  NULL if @s does not start with @prefix
>        */
>      -static inline char *strprefix(const char *s, const char *prefix)
>     -+#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, =
pfx))
>     -+
>     -+static inline char *(strprefix)(const char *s, const char *prefix)
>     ++static inline const char *strprefix(const char *s, const char *pref=
ix)
>       {
>         size_t len =3D strlen(prefix);
>     -   return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
>     +-  return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
>     ++  return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
>     + }
>     ++#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, =
pfx))
>     +=20
>     + /**
>     +  * str_has_prefix - Test if a string has a given prefix
>=20
> --=20
> 2.55.0
>=20



--=20
<https://www.alejandro-colomar.es>

--67pbkwc2bccukozj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0yKoACgkQ64mZXMKQ
wqk6OQ//fvLw+hv6dBfrCvd1p5QemKtJEuczYppccITn2BPjI3zTJOyh6inDRYak
MbUyJ+o66Z8l7Vmnt4IZ1bCI0i6V41C+loT03Z13xvS/9fiWMoahzaTmfk/rdArT
zbGWu5QcJCMBvv02y1P0vx2K4yzq9j4Q44nLgCl68O0XXgXWA7BxwFrlSbKTzwcV
sjmc3zHlohYfhhDK+8pr7uPO92hWdoxe3prZb3usQNhiLoB05Jp2nU9y3F6yZOCo
WlcyrujpzHznTEQoKBnNpPvOFWSkm0ADyilcAmfmzW7RQaMb5eq/6hww6AOj3fBg
vyyUB8S578Z6SDiF+9aaB20pvk/X3PTa3On2L6GQk/OlHljiXpc1xjJnD6WMjwMf
/eZXPjT42wyW37hP2zOp1sppIgcxkczBfPmBlHKALJGZ58uLprwdOxNXqR4f8TGF
hdc1fyVO7dGJdLwA2TpYQssK5Yykf1a7J4/Q2pqdXqqLIxygHvM+YA3fnj7SHcVK
52gualgVZXADHUMCTwaJFvS8HA9RYWBNMmCuoOdnSIjW1dgkLd4LAMvnstjohVhN
XEeqFwnA87P8KeQFn5kjfrLc+XAN7x7SRIk8/d0o/NGy+8yHEchUpuQCnIO07hWy
u82hwKQUJ1+ITup9imAYd9jns/pOYyePXUAd/pwb7O0dQNhj4Bs=
=6klB
-----END PGP SIGNATURE-----

--67pbkwc2bccukozj--
