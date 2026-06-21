Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B35223DE5
	for <linux-hardening@vger.kernel.org>; Sun, 21 Jun 2026 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782083165; cv=none; b=ujCnNmrptm4emXGzj2/XHCECBZdXH1uZ0FmFARtyG74Ur0UjwjeAlhd8aq1XVe7Y6AwNQ/fvOHJkIGcg5UkxwlzPW+Vsk2wxhn+zorujU+kD19ilnKLXmcnPLtKuKXeeIz/EoRjGwiPHtlASqfHELUet114sKN/wLWOiB7V+xx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782083165; c=relaxed/simple;
	bh=qJTn5CXHd/e5CIbC3pPUcS5+McHpPgWgM9sp+xRv1gA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A8BmlumyDkA2adf52PrF+26N/szDFZQE24KANsPf1KXsMOuE28BZlwd8D7kWcB7PbHgvSzu2joM+2RdiylGwbd9cAJ5ie1oL9ZOL/oMV6pCfG9AsNyUEfT/TDp81P+plmyTUUkH55ui72VxwzrQ5Bxiqzh3lZv7z288ZzCdWLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWX/P2aU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWX/P2aU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FA51F000E9;
	Sun, 21 Jun 2026 23:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782083164;
	bh=wlrN/KxP3rQZjHdi1phkxo0/lbqwwEQ6ojWv5yx3ry0=;
	h=Date:From:To:Cc:Subject;
	b=YWX/P2aUA0STeTbeNSnzzsyc/xPG7gF1AGULQBiLpBp7stQ4Yzo/Obv35ZxYHgnuf
	 q10FZWYeCga93hP0iEHYMSURTc6R+9LPTsFt1hgNkpYCJPzxMUxx+JcqA0wILfhI0Y
	 siLQYbH+Rdl1HdhSotnY5Thg87EkgSnQEQKdu6n902IcAEuh+9EETI4+QfeJStQvDI
	 eWXfyN59YLg73SK1RVwHzdi36lDaC3zyUSipiggBDMrEz0vfWifR32gOPDiY5zDf15
	 p35V2SBMJsdsEyM6KHTsnscOX6kGXXmPb4siqjDskv4U5Irc1D6fpBmjsTNW+5k8BD
	 aHHiTm7+/1vQw==
Date: Mon, 22 Jun 2026 01:05:59 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>
Subject: strtomem_pad() review
Message-ID: <ajhpdgpT4NuCMWBv@devuan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ce45hird3y7izl6"
Content-Disposition: inline


--6ce45hird3y7izl6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>
Subject: strtomem_pad() review
Message-ID: <ajhpdgpT4NuCMWBv@devuan>
MIME-Version: 1.0

Hi Kees,

Several people brought to my attention the news that the kernel has
"removed" strncpy(3) --in reality, it has just renamed it into
strtomem_pad()--.

That led me to have a look at what you're using instead, and as
expected, strncpy(3) still exists, with a different name.

I'd like to say that I like the name; it's certainly better than
strncpy(3).  It tells exactly what it does and what it is.

I'll review some commits that affected this macro, and also the
resulting macro.

	commit 6270f4deba3fbd77d1717fb8634f1fc612ff69e2
	Author: Kees Cook <kees@kernel.org>
	Date:   2025-02-05 13:45:26 -0800

	    string.h: Use ARRAY_SIZE() for memtostr*()/strtomem*()
	   =20
	    The destination argument of memtostr*() and strtomem*() must be a
	    fixed-size char array at compile time, so there is no need to use
	    __builtin_object_size() (which is useful for when an argument is
	    either a pointer or unknown). Instead use ARRAY_SIZE(), which has the
	    benefit of working around a bug in Clang (fixed[1] in 15+) that got
	    __builtin_object_size() wrong sometimes.
	   =20
	    Reported-by: kernel test robot <lkp@intel.com>
	    Closes: https://lore.kernel.org/oe-kbuild-all/202501310832.kiAeOt2z-lk=
p@intel.com/
	    Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
	    Link: https://github.com/llvm/llvm-project/commit/d8e0a6d5e9dd2311641f=
9a8a5d2bf9082>
	    Tested-by: Suren Baghdasaryan <surenb@google.com>
	    Signed-off-by: Kees Cook <kees@kernel.org>

	diff --git a/include/linux/string.h b/include/linux/string.h
	--- a/include/linux/string.h
	+++ b/include/linux/string.h
	@@ -435,9 +436,10 @@
	  */
	 #define strtomem(dest, src)    do {                                    \
	-       const size_t _dest_len =3D __builtin_object_size(dest, 1);        \
	+       const size_t _dest_len =3D __must_be_byte_array(dest) +           \
	+                                ARRAY_SIZE(dest);                      \
		const size_t _src_len =3D __builtin_object_size(src, 1);          \
										\
		BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||                \
			     _dest_len =3D=3D (size_t)-1);                          \
		memcpy(dest, src, strnlen(src, min(_src_len, _dest_len)));      \
	 } while (0)

The commit above could have removed the (size_t)-1 check in the
BUILD_BUG_ON() call, I believe.  ARRAY_SIZE() already implies that the
size is not (size_t)-1.  To be complete, it would also imply that the
size is constant, until the kernel starts using VMTs, so the entire
BUILD_BUG_ON() call could be removed, but just in case we use VMTs in
the future, the part about __builtin_constant_p(_dest_len) could be
kept.

BTW, I agree ARRAY_SIZE() is a better choice here.  All the uses of
strtomem() use indeed a compile-time-fixed size.

	commit 0e108725f6cc5b3be9e607f89c9fbcbb236367b7
	Author: Kees Cook <kees@kernel.org>
	Date:   2023-10-18 10:53:58 -0700

	    string: Adjust strtomem() logic to allow for smaller sources
	   =20
	    Arnd noticed we have a case where a shorter source string is being cop=
ied
	    into a destination byte array, but this results in a strnlen() call th=
at
	    exceeds the size of the source. This is seen with -Wstringop-overread:
	   =20
	    In file included from ../include/linux/uuid.h:11,
			     from ../include/linux/mod_devicetable.h:14,
			     from ../include/linux/cpufeature.h:12,
			     from ../arch/x86/coco/tdx/tdx.c:7:
	    ../arch/x86/coco/tdx/tdx.c: In function 'tdx_panic.constprop':
	    ../include/linux/string.h:284:9: error: 'strnlen' specified bound 64 e=
xceeds source size 60 [-Werror=3Dstringop-overread]
	      284 |         memcpy_and_pad(dest, _dest_len, src, strnlen(src, _des=
t_len), pad); \
		  |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
	    ../arch/x86/coco/tdx/tdx.c:124:9: note: in expansion of macro 'strtome=
m_pad'
	      124 |         strtomem_pad(message.str, msg, '\0');
		  |         ^~~~~~~~~~~~
	   =20
	    Use the smaller of the two buffer sizes when calling strnlen(). When
	    src length is unknown (SIZE_MAX), it is adjusted to use dest length,
	    which is what the original code did.
	   =20
	    Reported-by: Arnd Bergmann <arnd@arndb.de>
	    Fixes: dfbafa70bde2 ("string: Introduce strtomem() and strtomem_pad()")
	    Tested-by: Arnd Bergmann <arnd@arndb.de>
	    Cc: Andy Shevchenko <andy@kernel.org>
	    Cc: linux-hardening@vger.kernel.org
	    Signed-off-by: Kees Cook <keescook@chromium.org>

	diff --git a/include/linux/string.h b/include/linux/string.h
	index dbfc66400050..9e3cb6923b0e 100644
	--- a/include/linux/string.h
	+++ b/include/linux/string.h
	@@ -277,10 +277,12 @@ void memcpy_and_pad(void *dest, size_t dest_len, con=
st void *src, size_t count,
	  */
	 #define strtomem_pad(dest, src, pad)	do {				\
		const size_t _dest_len =3D __builtin_object_size(dest, 1);	\
	+	const size_t _src_len =3D __builtin_object_size(src, 1);		\
										\
		BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
			     _dest_len =3D=3D (size_t)-1);				\
	-	memcpy_and_pad(dest, _dest_len, src, strnlen(src, _dest_len), pad); \
	+	memcpy_and_pad(dest, _dest_len, src,				\
	+		       strnlen(src, min(_src_len, _dest_len)), pad);	\
	 } while (0)
	=20
	 /**
	@@ -298,10 +300,11 @@ void memcpy_and_pad(void *dest, size_t dest_len, con=
st void *src, size_t count,
	  */
	 #define strtomem(dest, src)	do {					\
		const size_t _dest_len =3D __builtin_object_size(dest, 1);	\
	+	const size_t _src_len =3D __builtin_object_size(src, 1);		\
										\
		BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
			     _dest_len =3D=3D (size_t)-1);				\
	-	memcpy(dest, src, min(_dest_len, strnlen(src, _dest_len)));	\
	+	memcpy(dest, src, strnlen(src, min(_src_len, _dest_len)));	\
	 } while (0)
	=20
	 /**

This is clearly a compiler bug.  strnlen(3) will never read more than
the string length.  In case the compiler knows the size of the src
buffer, it must also know that it's a properly-terminated string, and
thus not diagnose anything about the buffer size.  It is only in the
case where the source is not a string when the size would matter.  And
thus, the only effects of this commit are:

-  Silencing a false-positive compiler diagnostic.
-  Silencing plausible bugs where the source string is not really
   a string.

I'd strongly encourage talking to GCC to fix this bug.  Per the commit
message, I don't see that having been considered.

Apart from these commits, I'd also like to mention that the ability to
specify the padding seems superfluous.  All uses call it with '\0', so
it would be better to leave it as a mandatory NUL unless and until one
use case for a different padding is found.  The only current call with
a non-NUL padding is in the tests of the macro itself.

Also, I like the tests about the nonstring attribute.  That makes this
strncpy(3) variant quite robust.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--6ce45hird3y7izl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmo4blAACgkQ64mZXMKQ
wqmuBhAAvt+x/lT9U2O9bNGLS09hVxsW9d8C4GkeecD3xNoGgU181TnSuVCp9Zhs
8RCuYzBkGERxO8S+64J6NR8VdhIXRdj0F6EZ6FC60RCV6dATJQWOW3F2f+2onVKV
XXUBm6YUedYBikH2ear3F+3VX8qu6scTxHFWEmA1yGiIuZrh6bJZR5P7eDoJ2H6d
sbMntDJdnTF5278pNf3b/2G3YO3/MYbIrKrKROvNxsAZUIk25eHWtynar3TMMDU9
o7DJDG5OBtq+lEkwcPPq7iGOfzQqYLcbhF8+pckg9jBuuYP43lfZfPQw3nPIHYmB
t1vanSh0D0AWGbHx5+qifvcB0Aii3Up5VS76i3H3PGBrW7N98qJf7VOnL6xalgro
09965f/CVBxpGS34FxC4NdmcD8sg/aDWvciPBlfMXFyhmkpl4oiUFfp3Z/6KdhMF
OJfCAYkm1G+ChYzzFrUQawwaadKgrS+NZSX7qfztbgVOdArgfaPkvLdlFn1oI7r6
d0h0ZYCZP0xKr9e508eQQJxKlywK9yf6vx7+T3ykV48f/35LmKKB8jhZ6J9qQSVe
mlmU8iYuguzqAfzBGGxTPweLcDjNPv8tq0xKfxoAYh6NkeIfr1uq8DP7CybccooB
20/b1LtFwAcDGl2qhohVgI7wRbmXnFuds+48JZuW4yDKOGZdb5U=
=SJmw
-----END PGP SIGNATURE-----

--6ce45hird3y7izl6--
