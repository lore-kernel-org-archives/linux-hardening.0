Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575428;
	b=eBC+BJp7UVv9TpTfJ48dJJy+M9XeEwQ5clZRwRuRS387cJTbao7vkudevThceGAou8aY
	 K5vqiXuCT4kycMgRsHr6/+aGrNo3u3FJvmoNjYaTEv2Z0uSBSWpqdXUZ+OobZ6OPNRxyF
	 AgA5jaojU/lQTJtNUthp4Xj+bBuN6PxRG/V2655RkD0p0MdACH7uFrLENefy+FmsO0yCg
	 YMuelc6zklbQqmp2i5+21gfZ8P90YbMOO7tQPn9xWMDQhXtxEZb4ASiA0iS5PZ+byzOgv
	 GQQxbvWJfuyrudLHsr8bsfLiMoGWhG1LpbOq7+PTU3Id62iUQ94Fbw9h8oAQhy6p11w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575428;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 Alx-In-Reply-To:MIME-Version:Content-Type:Content-Disposition;
	bh=5Nw5QdQ2LipMMXbE9+f5KOI9u4NU8apKWwRPX9UFWWI=;
	b=WqXcLZDvD0mKz/MkSUhlNohRzzZXDRhlSqzCPkvH3nOAMkrKIUIa/gytVEIwfyCOdt+1
	 N54YJg1BoBDbp7zar4F5MUbR4AIj2tMylWtHsTPijp9ckdYFJ8pnU41r2NRIIqhvbL93t
	 GRqUjo5oz4gyRutv3sr4yc4kH3cG/UUdWp7TgXzSStvZKjeZOOh9Yf0Gtst5FwZCimqhL
	 2jpDEENw0uCbLnUYtXWPYWIHv5DjNnPpJi9tjYwniG3I8eRwIESGBsSTj/nnUi3Lgy8GO
	 ihBbe+YLTAUItqcThVybqidR6LbxBDFCIeH3+tltpQprJKHYz4uit7LSQ+UZ0zxt4AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONeOrL1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2B606A884;
	Fri, 13 Nov 2026 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONeOrL1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35971F000C5;
	Fri, 13 Nov 2026 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575428;
	bh=5Nw5QdQ2LipMMXbE9+f5KOI9u4NU8apKWwRPX9UFWWI=;
	h=Date:From:To:Cc:Subject;
	b=ONeOrL1BeOf4hGia79lqyZL6gmaWPvNS6neP/ejFy1CdKrclehEm9lWh0r5HergFO
	 23sXwxc1XX0yaxxzre0+0xA7OGX5c9YM/US5hPbHcGzO4dIX6ueHICBHAg+sj4mWej
	 5twz9GQ8o5Bl1d6mmUMzd8LL2ZAaporqQnxyHV9wz/O/uTTxq+Q18a14OgNy65PQH+
	 pNKRb4zT1AHptqe5YhT7OuCji3phI5yc3vWJ2W/6ucCA27v1BpyGsgHAEWgB4UD7GU
	 WVQ1QNzA22i32SCwLUp01JK22mecRiVskMRopBUMK6sTdmHOUAt9k8upsupawQrgII
	 UItzsfV8B1hTw==
Date: Fri, 13 Nov 2026 14:10:21 +0100
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
Subject: [PATCH v5 0/7] Add strprefix() and fix a bug with it
Message-ID: <cover.1794574496.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="y5uhzqovcxyopyph"
Content-Disposition: inline


--y5uhzqovcxyopyph
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
Subject: [PATCH v5 0/7] Add strprefix() and fix a bug with it
Message-ID: <cover.1794574496.git.alx@kernel.org>
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

Changes in v5
~~~~~~~~~~~~~

-  [1/7]
   -  Fix .rst formatting.  [sashiko]
-  [2/7]
   -  Move the function to "lib/string.h" to be able to use
      WARN_ON_ONCE().  [Andy, Bart]
-  [3/7]  -- no changes --
-  [4/7]
   -  Simplify const_cast(), which makes it more robust.  'T:' didn't
      work, because in case const T is the same type as T, there's
      ambiguity in which branch should be taken, and the compiler
      rejects that.  We could go back to 'default:' (as in v3), but that
      is only needed for casting 'const char **' to 'char **'; since we
      don't need that at the moment, let's keep it simple, and we'll be
      able to add it in the future if we ever want that.
-  [5/7]  -- no changes --
-  [6/7]  -- no changes --
-  [7/7]
   -  New patch; use strprefix() to implement strstarts().

I didn't apply some changes requrested by reviewers:

-  I didn't move strprefix() to "lib/string.h" implementing it as a loop
   with manual byte operations.  The only reason for that seems to be
   performance, but I expect by being inline, the compiler should be
   able to completely drop the strlen(3) call in many cases, making the
   inline function faster.

See range-diff below.

v1: <https://lore.kernel.org/linux-hardening/cover.1793876837.git.alx@kerne=
l.org/>
v2: <https://lore.kernel.org/linux-hardening/cover.1793882260.git.alx@kerne=
l.org/>
v3: <https://lore.kernel.org/linux-hardening/cover.1794323750.git.alx@kerne=
l.org/>
v4: <https://lore.kernel.org/linux-hardening/cover.1794425425.git.alx@kerne=
l.org/>

Testing
~~~~~~~

(I've indented the output, to better see the commands.)

$ git log --oneline --graph v7.4-rc1^..strprefix5
	* 382a44f7c686 (HEAD -> strprefix, tag: strprefix5) string: Implement strs=
tarts() with strprefix()
	* 0ca0b7aabcfc string: Make strprefix() const-qualifier-generic
	* 1294b3d64440 string: Add [C]QChar_of() and QVoid_of()
	* b615b5afb05e stddef: Add const_cast()
	* 49252e78c9b6 device property: Fix fwnode_name_eq() for empty node names
	* df3a35c469c6 string: Warn if the prefix is the empty string
	* f25bf43d7f18 string: Add strprefix(), and deprecate str_has_prefix()
	* 6628e7d4c6b2 (tag: v7.4-rc1, master) Linux 7.4-rc1
$ cat .kunitconfig
	CONFIG_KUNIT=3Dy
	CONFIG_STRING_KUNIT_TEST=3Dy
$ mkdir -p ~/tmp/strprefix5
$ export TMPDIR=3D$HOME/tmp/strprefix5/
$ ./tools/testing/kunit/kunit.py run "string*"
	[13:27:47] Configuring KUnit Kernel ...
	[13:27:47] Building KUnit Kernel ...
	Populating config with:
	$ make ARCH=3Dum O=3D.kunit olddefconfig
	Building with:
	$ make all compile_commands.json scripts_gdb ARCH=3Dum O=3D.kunit --jobs=
=3D24
	[13:28:02] Starting KUnit Kernel (1/1)...
	[13:28:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	Running tests with:
	$ .kunit/linux 'kunit.filter_glob=3Dstring*' kunit.enable=3D1 mem=3D1G con=
sole=3Dtty kunit_shutdown=3Dhalt
	[13:28:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string-stream-test (12 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:28:02] [PASSED] string_stream_managed_init_test
	[13:28:02] [PASSED] string_stream_unmanaged_init_test
	[13:28:02] [PASSED] string_stream_managed_free_test
	[13:28:02] [PASSED] string_stream_resource_free_test
	[13:28:02] [PASSED] string_stream_line_add_test
	[13:28:02] [PASSED] string_stream_variable_length_line_test
	[13:28:02] [PASSED] string_stream_append_test
	[13:28:02] [PASSED] string_stream_append_auto_newline_test
	[13:28:02] [PASSED] string_stream_append_empty_string_test
	[13:28:02] [PASSED] string_stream_no_auto_newline_test
	[13:28:02] [PASSED] string_stream_auto_newline_test
	[13:28:02] [PASSED] string_stream_performance_test
	[13:28:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] string-s=
tream-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:28:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D strin=
g (29 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:28:02] [PASSED] string_test_memset16
	[13:28:02] [PASSED] string_test_memset32
	[13:28:02] [PASSED] string_test_memset64
	[13:28:02] [PASSED] string_test_strlen
	[13:28:02] [PASSED] string_test_strnlen
	[13:28:02] [PASSED] string_test_strchr
	[13:28:02] [PASSED] string_test_strnchr
	[13:28:02] [PASSED] string_test_strrchr
	[13:28:02] [PASSED] string_test_strspn
	[13:28:02] [PASSED] string_test_strprefix
	[13:28:02] [PASSED] string_test_strcmp
	[13:28:02] [PASSED] string_test_strcmp_long_strings
	[13:28:02] [PASSED] string_test_strncmp
	[13:28:02] [PASSED] string_test_strncmp_long_strings
	[13:28:02] [PASSED] string_test_strcasecmp
	[13:28:02] [PASSED] string_test_strcasecmp_long_strings
	[13:28:02] [PASSED] string_test_strncasecmp
	[13:28:02] [PASSED] string_test_strncasecmp_long_strings
	[13:28:02] [PASSED] string_test_strscpy
	[13:28:02] [PASSED] string_test_strcat
	[13:28:02] [PASSED] string_test_strncat
	[13:28:02] [PASSED] string_test_strlcat
	[13:28:02] [PASSED] string_test_strtomem
	[13:28:02] [PASSED] string_test_memtostr
	[13:28:02] [PASSED] string_test_strends
	[13:28:02] [SKIPPED] string_bench_strlen (not enabled)
	[13:28:02] [SKIPPED] string_bench_strnlen (not enabled)
	[13:28:02] [SKIPPED] string_bench_strchr (not enabled)
	[13:28:02] [SKIPPED] string_bench_strrchr (not enabled)
	[13:28:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 [PASSED] string =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
	[13:28:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string_helpers (4=
 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:28:02] [PASSED] test_get_size
	[13:28:02] [PASSED] test_upper_lower
	[13:28:02] [PASSED] test_unescape
	[13:28:02] [PASSED] test_escape
	[13:28:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] st=
ring_helpers =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:28:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:28:02] Testing complete. Ran 45 tests: passed: 41, skipped: 4
	[13:28:02] Elapsed time: 15.583s total, 0.000s configuring, 15.366s buildi=
ng, 0.172s running

$ make allmodconfig
	  HOSTCC  scripts/basic/fixdep
	  HOSTCC  scripts/kconfig/conf.o
	  HOSTCC  scripts/kconfig/confdata.o
	  HOSTCC  scripts/kconfig/expr.o
	  LEX     scripts/kconfig/lexer.lex.c
	  YACC    scripts/kconfig/parser.tab.[ch]
	  HOSTCC  scripts/kconfig/lexer.lex.o
	  HOSTCC  scripts/kconfig/menu.o
	  HOSTCC  scripts/kconfig/parser.tab.o
	  HOSTCC  scripts/kconfig/preprocess.o
	  HOSTCC  scripts/kconfig/symbol.o
	  HOSTCC  scripts/kconfig/util.o
	  HOSTLD  scripts/kconfig/conf
	#
	# configuration written to .config
	#
$ time make -j24 | ts -s
	00:00:01   GEN     arch/x86/include/generated/asm/orc_hash.h
	00:00:01   UPD     arch/x86/include/generated/uapi/asm/bpf_perf_event.h
	00:00:01   UPD     arch/x86/include/generated/uapi/asm/errno.h
=2E..
	00:21:49   LD [M]  net/qrtr/qrtr-tun.ko
	00:21:49   LD [M]  net/qrtr/qrtr-mhi.ko
	00:21:49   LD [M]  virt/lib/irqbypass.ko

	real	21m48.882s
	user	439m26.908s
	sys	25m20.132s


Have a lovely day!
Alex


Alejandro Colomar (7):
  string: Add strprefix(), and deprecate str_has_prefix()
  string: Warn if the prefix is the empty string
  device property: Fix fwnode_name_eq() for empty node names
  stddef: Add const_cast()
  string: Add [C]QChar_of() and QVoid_of()
  string: Make strprefix() const-qualifier-generic
  string: Implement strstarts() with strprefix()

 drivers/base/property.c  |  5 +---
 include/linux/stddef.h   | 11 +++++++++
 include/linux/string.h   | 52 ++++++++++++++++++++++++++++++++--------
 lib/string.c             | 24 +++++++++++++++++++
 lib/tests/string_kunit.c |  9 +++++++
 5 files changed, 87 insertions(+), 14 deletions(-)

Range-diff against v4:
1:  a74fabd985a8 ! 1:  f25bf43d7f18 string: Add strprefix(), and deprecate =
str_has_prefix()
    @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest_=
len, const v
     + * and not a constant.  Instead use strprefix().
     + *
     + * Returns:
    -+ * *  @s+strlen(@prefix) if @s starts with @prefix
    ++ * *  @s + strlen(@prefix) if @s starts with @prefix
     + * *  NULL if @s does not start with @prefix
     + */
     +static inline char *strprefix(const char *s, const char *prefix)
2:  cd09427148a0 ! 2:  df3a35c469c6 string: Warn if the prefix is the empty=
 string
    @@ Commit message
         Warn if it happens.  Also, document that if such corner case
         is needed, strprefix() is preferable.
    =20
    +    We need to move str_has_prefix() to "lib/string.h" to be able to u=
se
    +    WARN_ON_ONCE().
    +
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
         Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-=
each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Suggested-by: Steven Rostedt <rostedt@goodmis.org>
    +    Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/string.h ##
    +@@ include/linux/string.h: extern char * strstr(const char *, const ch=
ar *);
    + #ifndef __HAVE_ARCH_STRNSTR
    + extern char * strnstr(const char *, const char *, size_t);
    + #endif
    ++extern size_t str_has_prefix(const char *str, const char *prefix);
    + #ifndef __HAVE_ARCH_STRLEN
    + extern __kernel_size_t strlen(const char *);
    + #endif
     @@ include/linux/string.h: static inline char *strprefix(const char *s=
, const char *prefix)
    -  * This is similar to strprefix(), but returns an offset instead of
    -  * a pointer.
    -  *
    + 	return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
    + }
    +=20
    +-/**
    +- * str_has_prefix - Test if a string has a given prefix
    +- * @str: The string to test
    +- * @prefix: The string to see if @str starts with
    +- *
    +- * This is similar to strprefix(), but returns an offset instead of
    +- * a pointer.
    +- *
    +- * Returns:
    +- * * strlen(@prefix) if @str starts with @prefix
    +- * * 0 if @str does not start with @prefix
    +- */
    +-static __always_inline size_t str_has_prefix(const char *str, const c=
har *prefix)
    +-{
    +-	size_t len =3D strlen(prefix);
    +-	return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
    +-}
    +-
    + /**
    +  * strstarts - does @str start with @prefix?
    +  * @str: string to examine
    +
    + ## lib/string.c ##
    +@@ lib/string.c: char *strnstr(const char *s1, const char *s2, size_t =
len)
    + EXPORT_SYMBOL(strnstr);
    + #endif
    +=20
    ++/**
    ++ * str_has_prefix - Test if a string has a given prefix
    ++ * @str: The string to test
    ++ * @prefix: The string to see if @str starts with
    ++ *
    ++ * This is similar to strprefix(), but returns an offset instead of
    ++ * a pointer.
    ++ *
     + * Unlike for strprefix(), if the prefix is an empty string, the
     + * behavior is undefined.  If you need to support arbitrary prefixes,
     + * use strprefix().
     + *
    -  * Returns:
    -  * * strlen(@prefix) if @str starts with @prefix
    -  * * 0 if @str does not start with @prefix
    -@@ include/linux/string.h: static inline char *strprefix(const char *s=
, const char *prefix)
    - static __always_inline size_t str_has_prefix(const char *str, const c=
har *prefix)
    - {
    - 	size_t len =3D strlen(prefix);
    ++ * Returns:
    ++ * * strlen(@prefix) if @str starts with @prefix
    ++ * * 0 if @str does not start with @prefix
    ++ */
    ++size_t str_has_prefix(const char *str, const char *prefix)
    ++{
    ++	size_t len =3D strlen(prefix);
     +	WARN_ON_ONCE(len =3D=3D 0);
    - 	return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
    - }
    -=20
    ++	return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
    ++}
    ++EXPORT_SYMBOL(str_has_prefix);
    ++
    + #ifndef __HAVE_ARCH_MEMCHR
    + /**
    +  * memchr - Find a character in an area of memory.
3:  0058b60f662c =3D 3:  49252e78c9b6 device property: Fix fwnode_name_eq()=
 for empty node names
4:  ce623fe0432b ! 4:  b615b5afb05e stddef: Add const_cast()
    @@ Commit message
         It's similar to C++'s const_cast(), but it is more restrictive: it=
 can
         only cast away 'const', and not arbitrary qualifiers.
    =20
    -    David made it a bit more robust.
    -
    -    Link: https://lore.kernel.org/linux-hardening/20261111102535.434c2=
eee@pumpkin/
    -    Co-developed-by: David Laight <david.laight.linux@gmail.com>
    +    Cc: David Laight <david.laight.linux@gmail.com>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/stddef.h ##
    @@ include/linux/stddef.h: enum {
     + * @T: Type for the cast.
     + * @p: Pointer to be casted.
     + *
    -+ * If @p is of type const @T, then it is casted to @T.
    -+ * If @p is of type @T, then it is returned without any casts.
    ++ * Cast @p to type @T.  The macro verifies that @p is of type const @=
T.
     + * This avoids mistakes that change anything other than 'const' in a =
cast.
     + */
    -+#define const_cast(T, p)  _Generic(p, const T: (T) (p), T: (p))
    ++#define const_cast(T, p)  _Generic(p, const T: (T) (p))
     +
      #endif
5:  206d2045abcf =3D 5:  1294b3d64440 string: Add [C]QChar_of() and QVoid_o=
f()
6:  69d1792e5edf ! 6:  0ca0b7aabcfc string: Make strprefix() const-qualifie=
r-generic
    @@ Commit message
    =20
      ## include/linux/string.h ##
     @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest=
_len, const void *src, size_t count,
    -  * *  @s+strlen(@prefix) if @s starts with @prefix
    +  * *  @s + strlen(@prefix) if @s starts with @prefix
       * *  NULL if @s does not start with @prefix
       */
     -static inline char *strprefix(const char *s, const char *prefix)
    @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest_=
len, const v
     +#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pf=
x))
     =20
      /**
    -  * str_has_prefix - Test if a string has a given prefix
    +  * strstarts - does @str start with @prefix?
-:  ------------ > 7:  382a44f7c686 string: Implement strstarts() with strp=
refix()
--=20
2.55.0


--y5uhzqovcxyopyph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3DDYACgkQ64mZXMKQ
wqnnqRAAm8fVVzbp0C8gJPvaCN8AxMdQuqLnaTs9/OvVWk26YDM0KaHmI07bT/nt
EP32MrBCymnKE4Mt26jV2uyFZ4jATJuSHEMZS6UFq0x2VaQBuAF8eEbD0oiY4Bof
/O5joAaNfRDHWuxVI8OP7JA1Pvq1/mxbYIgexdce5b2/Lu/M1jYhvTheadWyi/Yq
H7JYLu0xGR9Z6ReQyMFc1Fs3fDNNSzseC2kxGRC1IU7Cm4EnrDHVXFfeItyky+UX
HqLUh6szJwRfHXk8v/pUYCLrQVAAddt8qrgborCSqe2m2hB2alRZrxC/EvhoLfah
exiNyT1dce3P4BQGyWGCGYnZSIGBCukFq+pT5J4lAH2AuSzQrRYCQlTJvlo6IAje
IM3n9s+oKMYXJAFmptkFuR8sJMs2LAiCjdo0yDrJTgLoHG98mU7GFW41yPnfrOvl
Y1WNvccXSj9Ab2qJRD3m2SmnsBn52Pc+VKMLQA7EoA5vsDprTf9h+KTnGzdWWy1W
u/yW8vvqchADRSaNF6SXMKSoXiEQqr+9GudAyIY+b9lK735gwxmNdkrubTB8fjN+
0IwCfwSgAMLYBva/p35+kT1Pu1TjEEsTP7IhT5mM3o3gjnpr5F25s1mgNYpP0w8i
Tfyyr/rfyr1zjcMRsom6bdKva4pk0MfyAdJfOT7zyR0N8wlBp6Y=
=Qx1p
-----END PGP SIGNATURE-----

--y5uhzqovcxyopyph--
