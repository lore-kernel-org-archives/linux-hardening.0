Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426915;
	b=M17cSjcGpxXPjS5G7R5y9u8QMWR8pKFNh5Q49fGSZ5tGZwOyow7bs/iYs7EuK9l/jbsL
	 gV0XtMEFf4UGludiCJubuy6xh6htM6E9K8hzziGlDfD6I9cX+GgLYgLMUWyhnmKiT2joQ
	 pcVsXXdXktiGrtZJRUVhR6tFH8P/ep3wBCVQ/I/s6HX3WB5MiQpqJnVX5dCbs+mrEBBhJ
	 XJDmKnSuJxa2DV6S5GCDOeX5A0x9tb0IYVdzbRzFULnrRo9uTzmk9OnedfXj9Jjw7yQuQ
	 XMx7XkFDzUFNjdnpW+6I9zu9VPhevmF/fRqkmrducWzIt2H/ALUVs9d4EP76L7iRa6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426915;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 Alx-In-Reply-To:MIME-Version:Content-Type:Content-Disposition;
	bh=iENEpx4FRqC7og/qPl3NdY89leTg1m+KfD2SYQ647gM=;
	b=hJTidC0JJuWOgfmCp/asHNLeJjEIw2pc9ifakvKyiRzQmVJ95brC+/VilJ/IY58j+ltS
	 MDQNrsl1moyYPXf/658Cy238cw/fHAbz+dprNz68rYh/ElSEAgzhDRe9OZK19lubTdd1s
	 4wqPL4ojXfVtBX+Gb7C1i3PEiCqzvBB+F2uuXtTHmfs4ZCWCe3GYP0ZpjLz7Gkn3rpLLV
	 NdcCB5/94p4zNCVfgcaNqBB7RlM2RYyKjRn2NHzTxLm6pddDLnM6AZpRL1UrG+JLtS/ko
	 MsYp1IRIxXy13KFQZdhG1dKPBISCIoCXLlPa9Y/pyzVfZq4pnpnVFh2grNIbu1gPerQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1eb5kEs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ADE606A31C;
	Wed, 11 Nov 2026 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1eb5kEs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4348F1F00A05;
	Wed, 11 Nov 2026 19:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426915;
	bh=iENEpx4FRqC7og/qPl3NdY89leTg1m+KfD2SYQ647gM=;
	h=Date:From:To:Cc:Subject;
	b=Z1eb5kEsXN69s6NNrYa/U6+Ib/1gnZ1tvkHy0ekIkZgm0b4Gn6xSjbTyOlprMOGFK
	 dRTzmdDg5SH62wMLOkq++cj1XzrxI/NyUHJKbQdSuMKy3j8rz1Txbddjyl+zLDg7C7
	 t26lNyrm4HZOQbQtn/G/3HFlLUyoX5Qd6dh5OXZrSj53YcvZLchuA7PmAPIYv9iQG9
	 qj6Uv+U0wubfTSUtTqRHn+PLD6dGTQwGl6qI4oMZ9dMJr6ShPgSv9Q6CSCVX2IiOZz
	 ed7zCPbEFXHBVRcSnro3J1B5VX9AiVXFnl1NGN29CXSlxzFRTgXWZMw5dFnh07RzIH
	 0/rJ9R5DxZcxw==
Date: Wed, 11 Nov 2026 20:55:07 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: [PATCH v4 0/6] Add strprefix() and fix a bug with it
Message-ID: <cover.1794425425.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
Alx-In-Reply-To: <cover.1793876837.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="i3rwcpva5plffwsz"
Content-Disposition: inline


--i3rwcpva5plffwsz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: [PATCH v4 0/6] Add strprefix() and fix a bug with it
Message-ID: <cover.1794425425.git.alx@kernel.org>
MIME-Version: 1.0

Hi!

str_has_prefix() is based on sizes and lengths, which means it must
overload the valid length 0 to mean not found.  This is a typical
consequence of choosing to design an API around sizes and lengths, and
vanishes when moving to pointer-based similar APIs.

According to its author (Steven R.), str_has_prefix() was never meant to
accept an empty prefix, but that's not documented, and there's no
obvious reason why that would be acceptable for a generic string
function (as opposed to a function very specific to its original use).
Anyway, as suggested by Steven, I've added a WARN_ON_ONCE() to catch
such uses, and also added documentation stating this limitation.

Users of strings need a function whose behavior extends naturally to the
empty string, and we can do better, by returning a pointer.  And indeed,
users have ended up using str_has_prefix() with empty prefix, expecting
it to work (as is natural of a generic string API).

This patch set adds strprefix(), deprecates str_has_prefix(), and uses
strprefix() in one place to fix a bug reported by Bartosz.

We can later work on replacing the other uses of str_has_prefix(), which
might hide similar bugs.

This patch set also adds infrastructure to make string functions return
a pointer that is as qualified as the input pointer.

Changes in v4
~~~~~~~~~~~~~

-  [1/6]
   -  Remove deprecation notice.  [Steve]
   -  Move documentation of str_has_prefix() to strprefix().  [Steve]
   -  Document str_has_prefix() by comparing it to strprefix().
   -  Match parameters in documentation and code.
-  [2/6]
   -  Add WARN_ON_ONCE() to str_has_prefix().  [Steve]
   -  Document limitation of str_has_prefix().
-  [3/6]  -- no changes --
-  [4/6]
   -  Document that it might drop const, but doesn't need to.
   -  Make const_cast() more robust, by replacing 'default:'
      with 'T:'.  [David]
-  [5/6] =20
   -  Replace [0] array notation with * pointer notation, to silence
      spurious -Wpointer-arith diagnostic.  I wouldn't have changed
      anything if it weren't nontrivial, because that diagnostic is not
      part of -Wall -Wextra, and is also not too important, but since
      the solution was trivial, I'm fine with it.  TBH, I prefered [0],
      but I can live with *.  [sashiko]
-  [6/6]
   -  Define the macro after the function, to avoid wrapping the
      function name in parentheses.  [Joe, David]
   -  Document why we need CQChar_of() --the simpler typeof()-- is not
      good enough.  [David]
   -  Change the function to return non-const.  const_cast() can't add
      const, it only removes it; thus, we must have it always in the
      function, and then have const_cast() drop it conditionally.  This
      also removes a cast.  [sashiko]

I didn't apply some changes requested by reviewers:

-  I didn't rename const_cast(), since I'm not convinced about the
   suggested alternatives being better.  And after all, a cast is only
   needed for dropping const, but never for adding it (because it adds
   implicitly), so a const_cast() obviously implies that const might be
   dropped.

See range-diff below.

Testing
~~~~~~~

I haven't changed the implementation of the function meaningfully, so
haven't re-run tests.  Since the changes since v2 are only about type
safety and diagnostics, I have built again with 'allmodconfig', just to
make sure it still compiles.

Alejandro Colomar (6):
  string: Add strprefix(), and deprecate str_has_prefix()
  string: Warn if the prefix is the empty string
  device property: Fix fwnode_name_eq() for empty node names
  stddef: Add const_cast()
  string: Add [C]QChar_of() and QVoid_of()
  string: Make strprefix() const-qualifier-generic

 drivers/base/property.c  |  5 +---
 include/linux/stddef.h   | 12 ++++++++
 include/linux/string.h   | 62 +++++++++++++++++++++++++++++++++++++---
 lib/tests/string_kunit.c |  9 ++++++
 4 files changed, 80 insertions(+), 8 deletions(-)

Range-diff against v3:
1:  556766412884 ! 1:  a74fabd985a8 string: Add strprefix(), and deprecate =
str_has_prefix()
    @@ Commit message
    =20
         We'll slowly migrate existing code from str_has_prefix() to strpre=
fix().
    =20
    -    Copy the description from str_has_prefix().
    +    Move the description from str_has_prefix(), and describe
    +    str_has_prefix() by comparing it to strprefix().
    =20
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
         Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-=
each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
    @@ Commit message
    =20
      ## include/linux/string.h ##
     @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest=
_len, const void *src, size_t count,
    + 	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
      })
     =20
    - /**
    -- * str_has_prefix - Test if a string has a given prefix
    -- * @str: The string to test
    -- * @prefix: The string to see if @str starts with
    ++/**
     + * strprefix - string prefix
     + * @s: The string to be tested
     + * @prefix: The string to see if @s starts with
    -  *
    -  * A common way to test a prefix of a string is to do:
    -  *  strncmp(str, prefix, sizeof(prefix) - 1)
    -  *
    -  * But this can lead to bugs due to typos, or if prefix is a pointer
    -- * and not a constant. Instead use str_has_prefix().
    -+ * and not a constant. Instead use strprefix().
    ++ *
    ++ * A common way to test a prefix of a string is to do:
    ++ *  strncmp(s, prefix, sizeof(prefix) - 1)
    ++ *
    ++ * But this can lead to bugs due to typos, or if prefix is a pointer
    ++ * and not a constant.  Instead use strprefix().
     + *
     + * Returns:
     + * *  @s+strlen(@prefix) if @s starts with @prefix
    @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest_=
len, const v
     +	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
     +}
     +
    -+/**
    -+ * str_has_prefix - Test if a string has a given prefix
    -+ * @str: The string to test
    -+ * @prefix: The string to see if @str starts with
    -+ *
    -+ * DEPRECATED: Use strprefix()
    -+ *
    -+ * A common way to test a prefix of a string is to do:
    -+ *  strncmp(str, prefix, sizeof(prefix) - 1)
    -+ *
    -+ * But this can lead to bugs due to typos, or if prefix is a pointer
    -+ * and not a constant. Instead use strprefix().
    + /**
    +  * str_has_prefix - Test if a string has a given prefix
    +  * @str: The string to test
    +  * @prefix: The string to see if @str starts with
    +  *
    +- * A common way to test a prefix of a string is to do:
    +- *  strncmp(str, prefix, sizeof(prefix) - 1)
    +- *
    +- * But this can lead to bugs due to typos, or if prefix is a pointer
    +- * and not a constant. Instead use str_has_prefix().
    ++ * This is similar to strprefix(), but returns an offset instead of
    ++ * a pointer.
       *
       * Returns:
       * * strlen(@prefix) if @str starts with @prefix
-:  ------------ > 2:  cd09427148a0 string: Warn if the prefix is the empty=
 string
2:  eed085c85f36 =3D 3:  0058b60f662c device property: Fix fwnode_name_eq()=
 for empty node names
3:  2bf5cf7baad8 ! 4:  ce623fe0432b stddef: Add const_cast()
    @@ Commit message
         It's similar to C++'s const_cast(), but it is more restrictive: it=
 can
         only cast away 'const', and not arbitrary qualifiers.
    =20
    +    David made it a bit more robust.
    +
    +    Link: https://lore.kernel.org/linux-hardening/20261111102535.434c2=
eee@pumpkin/
    +    Co-developed-by: David Laight <david.laight.linux@gmail.com>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/stddef.h ##
    @@ include/linux/stddef.h: enum {
      	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
     =20
     +/**
    -+ * const_cast() - Drop const in the left-most derivation of a pointer
    ++ * const_cast() - At most, drop const in the left-most derivation of =
a pointer
     + *
     + * @T: Type for the cast.
     + * @p: Pointer to be casted.
     + *
     + * If @p is of type const @T, then it is casted to @T.
    -+ * Otherwise, @p is returned without any casts.
    ++ * If @p is of type @T, then it is returned without any casts.
     + * This avoids mistakes that change anything other than 'const' in a =
cast.
     + */
    -+#define const_cast(T, p)  _Generic(p, const T: (T) (p), default: (p))
    ++#define const_cast(T, p)  _Generic(p, const T: (T) (p), T: (p))
     +
      #endif
4:  415453a31ebf ! 5:  206d2045abcf string: Add [C]QChar_of() and QVoid_of()
    @@ include/linux/string.h
     + * This macro produces the type name 'void',
     + * qualified with any qualifiers present in the element of @p.
     + */
    -+#define QVoid_of(p)       typeof((__QVoidptr_of(p)){0}[0])
    ++#define QVoid_of(p)       typeof(*(__QVoidptr_of(p)){0})
     +#define __QVoidptr_of(p)  typeof(1?(p):(void*){0})
     +
     +/**
5:  35bf6672f84f ! 6:  69d1792e5edf string: Make strprefix() const-qualifie=
r-generic
    @@ Metadata
      ## Commit message ##
         string: Make strprefix() const-qualifier-generic
    =20
    +    Add a macro of the same name, which returns a pointer that is
    +    const-qualified iff the input string is const-qualified.  The retu=
rn
    +    type is a possibly-const-qualified pointer to char, even if the in=
put
    +    is a possibly-const-qualified pointer to void, which is why we req=
uire
    +    the CQChar_of() macro.
    +
    +    The function now needs to return 'const char *', because const_cas=
t()
    +    can only drop const, but never add it.
    +
         Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
    +    Cc: Joe Perches <joe@perches.com>
    +    Cc: David Laight <david.laight.linux@gmail.com>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/string.h ##
    @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest_=
len, const v
       * *  NULL if @s does not start with @prefix
       */
     -static inline char *strprefix(const char *s, const char *prefix)
    -+#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pf=
x))
    -+
    -+static inline char *(strprefix)(const char *s, const char *prefix)
    ++static inline const char *strprefix(const char *s, const char *prefix)
      {
        size_t len =3D strlen(prefix);
    -   return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
    +-  return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
    ++  return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
    + }
    ++#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pf=
x))
    +=20
    + /**
    +  * str_has_prefix - Test if a string has a given prefix

--=20
2.55.0


--i3rwcpva5plffwsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0yBQACgkQ64mZXMKQ
wqmzOA/+IUpNzbc45ROcCRtsveFAXqpiG9N6sA4xOyqMuujWDKE3tlKBV8Z5gFjd
KkEMBLXxYWFNxtZKdNyIDfMr7EwIHquwAw/JuiHZqfumOU8Sasca8++0w8S9dA+6
JRE/NPNP+Th8RdUUeQoYTIxodsJl58JgMTlh/rSPRiL7wa+YnajTJ9KfbEhkPAS2
RVIQpxCSpyH7VlmNce04ck7cXBXPR7uj6QOXfbb45HQnHYyf1i2HfHfjTlcKZJdX
EdxxCgkdhQ3GhfRPkYRCz3qdq7AvfQdYaNFNDgltARw6bdSB2vuoYrrfSuXwjbZc
YYmuRBQuepuuFwrrZ7rexdu+b6qIhy/P4KOyzanN8MfKHeeHI9BK+ssy3hwKKiqP
oFbNFAKwlm4iBhPnrQn8doyjivb6zqz7N7885cdsxZe5st5HIeD+QFk4VI6f3mKD
kbnyYry8ragXzHyCJ/murBfmufgyuI7vMWs9rHSABt56IB+e9aeAyUFCXSyHG+Gy
3tAxwv6PT5Z3Pxgxkm+K2+XmXzOfLzLyVGyz30AYvJdaftFaT9OK6b7dqHWgbGlf
xY/28rgLzQyF+lsZ/h4WTVIMpfbhGmy6m0SWvfuXZ5GoxMHKxRjNXUIBz6quiJTd
9L2t4WWsj2pSAzErus5vl7mvrMsh02P33MbH5JQJ3wPKAxWGQ1g=
=SvjB
-----END PGP SIGNATURE-----

--i3rwcpva5plffwsz--
