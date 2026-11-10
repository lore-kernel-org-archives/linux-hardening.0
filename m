Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324803;
	b=hfXQ1dzqQqtsv0N2K5+8rL2lmJ0IsJ5aZ5/ejqUXwFneT+Sm8snITfA2x0fhXbzzEZ1R
	 DEMwbOEDL8+4UsVl6p/0H34UkiB44aeGkJDmSayFPkKljRIJ6uY1tZ8DTz3OVlo1dUf1c
	 G1/iqcwj2x4uM9cHV71Fx1luGIdlLMtG6YLIck4dRVWCOUEcF6x+XiXjmyIcj85bsMHtT
	 mcW5V906NmS8XoLTUBwN296ye4FYaNVFX8RklEcxyj0dH9N1fxShOyWCk8OwDzPWIOn9l
	 C90DPx0S6+Wsz5Gge8ZQCEpWGycEYwGhrUi1cZLcTEUMh+HSEpb8P7DO+aXSjoWyxvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324803;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 Alx-In-Reply-To:MIME-Version:Content-Type:Content-Disposition;
	bh=XCxFswGonhuE70D4bHiEsaJMPpD38NA8Fe7r383T5jE=;
	b=EMNgWp5MM5/w6hjo3AOKEJ76/vX3n7mYXIHdQLxgzFo/ffkuMCieXTmdtkV5+bl1/tq/
	 cqegvVKGu8w1g6s0Ceroc053OrBAH7kiUKSVYofVO5ZOP4ioYm94cEdHfzk6enk7kAKi1
	 /GH2OFMBNfGNBzh/2iK4DrV78kHam2avGckV4MUaT10+L+6pg3SjuLgzxk7B84OTtrnS9
	 EcTsiF4C1wTKKhRnZlPVBxYenXzJMy6phM37BYjIKnqmVpR26wHI0rhjMjtmvYQuPLmS1
	 4Dc4fbfyVPCnihiqT21sz3gC3tfAtqYjdpqqfw1QwDcbrM5cssGYdd3gGS9ALaPgIJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ddie5fmi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B44606A332;
	Tue, 10 Nov 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ddie5fmi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8A91F008BC;
	Tue, 10 Nov 2026 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324803;
	bh=XCxFswGonhuE70D4bHiEsaJMPpD38NA8Fe7r383T5jE=;
	h=Date:From:To:Cc:Subject;
	b=Ddie5fmijPGpWDhGPmU+YjBYCpO5CEMKmqG4sNfMvkr//zUNZs3epGRhkI8paoKet
	 wQ4vpdKa5p8mdW2cObWPCOOPKzonr50YJ4VO1PSfeVdUyeUxbB2uZ1wnheKlGftFAR
	 cLOslfVMB4yrZSG5ZrBf1MSX9glRSMIHiwagiHg2CTz7yTJtNIIi80uayaOs4cqH+x
	 eUbdJ7xO1lKv1gLumX5pXvrPj+T7aEVBOYEYFod+IE+/mKcUu+qbpMu1SWN2knF5aE
	 KDIZ1CntjQRnLQEGEm7OIdHUan7qwdDxOAF1Y3KHjGYBKpbMYdhRvpvx+vSTKRyM9g
	 2PsPHgsQ/jucA==
Date: Tue, 10 Nov 2026 16:33:15 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alejandro Colomar <alx@kernel.org>, Andreas Schwab <schwab@linux-m68k.org>, 
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
Subject: [PATCH v3 0/5] Add strprefix() and fix a bug with it
Message-ID: <cover.1794323750.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="ldbuj4gtwrs6ecqn"
Content-Disposition: inline


--ldbuj4gtwrs6ecqn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alejandro Colomar <alx@kernel.org>, Andreas Schwab <schwab@linux-m68k.org>, 
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
Subject: [PATCH v3 0/5] Add strprefix() and fix a bug with it
Message-ID: <cover.1794323750.git.alx@kernel.org>
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

Changes in v2
~~~~~~~~~~~~~

-  Copy the description from str_has_prefix().  [Steve]
-  Add links for the Reported-by tags.
-  Make these APIs const-generic.  [Geert]

I didn't apply some changes requested by reviewers:

-  I didn't remove the deprecation of str_has_prefix(), because I think
   it should not be used in new code.  It remains useful for code that
   is already using it, because rewriting all the surrounding code to
   use pointers instead of offsets might be too risky.  However, for new
   code, strprefix() produces simpler code, and is safer, so I don't see
   why str_has_prefix() would be good in any new code.

-  I didn't rename strprefix() to strsuffix(), because that name would
   be worse (strsuffix() is widely implemented with other semantics, and
   having it different here would lead to confusion and bugs).  Andy
   agreed.

See range-diff below.

Testing
~~~~~~~

I haven't changed the implementation of the function, so haven't re-run
tests.  Since the changes since v2 are only about type safety, with a
new wrapper macro, I have built again with 'allmodconfig', just to make
sure it still compiles.


Have a lovely day!
Alex

v1: <https://lore.kernel.org/linux-hardening/cover.1793876837.git.alx@kerne=
l.org/>
v2: <https://lore.kernel.org/linux-hardening/cover.1793882260.git.alx@kerne=
l.org/>

Alejandro Colomar (5):
  string: Add strprefix(), and deprecate str_has_prefix()
  device property: Fix fwnode_name_eq() for empty node names
  stddef: Add const_cast()
  string: Add [C]QChar_of() and QVoid_of()
  string: Make strprefix() const-qualifier-generic

 drivers/base/property.c  |  5 +---
 include/linux/stddef.h   | 12 ++++++++
 include/linux/string.h   | 63 +++++++++++++++++++++++++++++++++++++---
 lib/tests/string_kunit.c |  9 ++++++
 4 files changed, 81 insertions(+), 8 deletions(-)

Range-diff against v2:
1:  d3b325ecefd1 ! 1:  556766412884 string: Add strprefix(), and deprecate =
str_has_prefix()
    @@ Commit message
    =20
         We'll slowly migrate existing code from str_has_prefix() to strpre=
fix().
    =20
    +    Copy the description from str_has_prefix().
    +
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    +    Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-=
each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Cc: Andy Shevchenko <andy@kernel.org>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/string.h ##
     @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest=
_len, const void *src, size_t count,
    - 	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
      })
     =20
    -+/**
    + /**
    +- * str_has_prefix - Test if a string has a given prefix
    +- * @str: The string to test
    +- * @prefix: The string to see if @str starts with
     + * strprefix - string prefix
     + * @s: The string to be tested
     + * @prefix: The string to see if @s starts with
    -+ *
    -+ * Returns:
    -+ * *  @s+strlen(@prefix) if @s starts with @prefix
    -+ * *  NULL if @s does not start with @prefix
    -+ */
    -+static __always_inline char *strprefix(const char *s, const char *pre=
fix)
    -+{
    -+	size_t len =3D strlen(prefix);
    -+	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
    -+}
    -+
    - /**
    -  * str_has_prefix - Test if a string has a given prefix
    -  * @str: The string to test
    -  * @prefix: The string to see if @str starts with
       *
    -+ * DEPRECATED: Use strprefix()
    -+ *
       * A common way to test a prefix of a string is to do:
       *  strncmp(str, prefix, sizeof(prefix) - 1)
       *
       * But this can lead to bugs due to typos, or if prefix is a pointer
     - * and not a constant. Instead use str_has_prefix().
    ++ * and not a constant. Instead use strprefix().
    ++ *
    ++ * Returns:
    ++ * *  @s+strlen(@prefix) if @s starts with @prefix
    ++ * *  NULL if @s does not start with @prefix
    ++ */
    ++static inline char *strprefix(const char *s, const char *prefix)
    ++{
    ++	size_t len =3D strlen(prefix);
    ++	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
    ++}
    ++
    ++/**
    ++ * str_has_prefix - Test if a string has a given prefix
    ++ * @str: The string to test
    ++ * @prefix: The string to see if @str starts with
    ++ *
    ++ * DEPRECATED: Use strprefix()
    ++ *
    ++ * A common way to test a prefix of a string is to do:
    ++ *  strncmp(str, prefix, sizeof(prefix) - 1)
    ++ *
    ++ * But this can lead to bugs due to typos, or if prefix is a pointer
     + * and not a constant. Instead use strprefix().
       *
       * Returns:
2:  ac9728afa027 ! 2:  eed085c85f36 device property: Fix fwnode_name_eq() f=
or empty node names
    @@ Commit message
    =20
         Fixes: a9c8c738066b7 ("device property: Add fwnode_name_eq()")
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    +    Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-=
each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Cc: Andy Shevchenko <andy@kernel.org>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
-:  ------------ > 3:  2bf5cf7baad8 stddef: Add const_cast()
-:  ------------ > 4:  415453a31ebf string: Add [C]QChar_of() and QVoid_of()
-:  ------------ > 5:  35bf6672f84f string: Make strprefix() const-qualifie=
r-generic
--=20
2.55.0


--ldbuj4gtwrs6ecqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzOTUACgkQ64mZXMKQ
wqnw2xAAsmfnUTsvAQv1TyrYARi1Rd58hvUnxkG0m6V70un81IQZzPti4rO0jV16
0Fog3LISySdunRGGJ7C5HE4TaZYCs/sbwTLU6LY+cLR6iNrQUbMt5JJ2csSsh9FZ
/rf0HmaN1+Vrefx9yPI/ORllPlLfH3kCaOYxrYZwQKXxWPPCfmAX2juZwRrIrUEL
qrpTLm6saG5XjpbaklmpSvFhwB9xp5g0BOj9GTrB9msYVlvGtyYh6OuO/T/uPfg1
RJtPsIU0xly8E8EFdmMjPj+Rl9wAljEiM8+bFftAvLPLI5R/UY8WQG9Vw1vyyZhK
IMxpEBg0/ukd1nXwiV4xN3aMxBMw3/JjILW9iv4WR3r5fCLUgvJWxsKkRsoq2SNA
fYkw+617nuwSDyI3jqD/UUGw7OEHLvUTHGA9zMRVirJUY/y0l0gpbNYZJzABNcTw
sIRWOcIvaUp16PU5jKcB0Zw6lPs5rjdoVhcRgPy7hpg3um5icBOnIx8p26VwlmJL
CfRFjY/fTiGzEcBL+MG8FU3FTy41SWTfeCWAzwUzrWgZhdQTGvRh1b6jcsqTubpS
QNCQ+2tGq93IX9uv3IhtwUB7+Op/a3V1s456OTWHrhAulkmDy3DUN3lJc8espvXr
qaVWVPlJDQbKx0o7Jgr+L6Fm6wlHspagP7b550s7AtoCTCEQ1Qw=
=S/N8
-----END PGP SIGNATURE-----

--ldbuj4gtwrs6ecqn--
