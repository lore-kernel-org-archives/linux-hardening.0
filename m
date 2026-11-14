Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669712;
	b=eYEHt77aIs+g/Oc04lBAC/PpX29XlpOUf0OMeUlpdFzHBWryfYtlSKwH7IduQSb8/Qtl
	 WFezir+w0BIVKoxeuuS4Oc6cRJnkcAf8A890VVjej5t5tBQDHLQRtCFymOkfOogabt96Y
	 xbKi3Bjm+jwb3fPmU5wrbq+qwAntdvvaLRVzQ9g19B0Gnj8uAPMZMwHSJRvLGo3+As2TB
	 nbR/pSDeyg+1MtSKn5xK07N8Dc8TK5q4A0zMyCkoFxKN6cV/GGsYMTYbL5qnZ3Tq3u2mq
	 TGupxOG9VY5jnk9fud/wzO68L+THicdDY+Iwx0CZsdKQOp77AZLjk+y/fjV/zxzCBww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669712;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 Alx-In-Reply-To:MIME-Version:Content-Type:Content-Disposition;
	bh=1IwabPIz5WOWC4uGAidws4A9jNbkid0thiyt5tYHh18=;
	b=pXvh7tP0EQmDYJbxO/x+gAb2FyTEC2WBReVbA14zfYMnVEgmTrIl94GItLyq2YIqEcI9
	 w96JYOb7PDBrdKwSgotTkg5ojXFNGITEfLt8Y9Dxshx1FeazqkczdKsHQ3i33hqSA9B7w
	 N0vun8MPROIhNJdcZxIqsHEuDtyFgGOAyEc/Sb8W+XVaMKNW0bBCm6WLqtrZVdiKv3yZ0
	 w/77yKU9wKjxS2Of1HMPIgHO8XDIr5/5FSEvIpWBPAMMNKpZ7cgkd4K8Y6+EyXpCJVnNF
	 A7XAMOw8dv5HFI/5f9ugDxiu9iGor3dgEbD42eJlJSFE9cxkQY4Jlr+8rAb3GPrv2Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifnbsc8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A0606A327;
	Sat, 14 Nov 2026 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifnbsc8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4381F000C4;
	Sat, 14 Nov 2026 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669711;
	bh=1IwabPIz5WOWC4uGAidws4A9jNbkid0thiyt5tYHh18=;
	h=Date:From:To:Cc:Subject;
	b=ifnbsc8KtUmivR3/gWobjzsy+XlhROSrrhyT/MPuVVMPal+anaPbKAA7yjtciAdSl
	 bjlkom6dmhS96F6w28TfeItMZQXak8LIcBHZK6E5Yh5NRk17YasZWy6JqH55nFOWoJ
	 KOrWoQb7C11AlkhAofqHS0n4tEMjFrYXleadxziSOH2FPgGR3fjBQXrKBgld47V9MT
	 crTTb1wG37u162C1XaWbbI7rYse2IVUt7SRA0c2zQFgpbfZ+jn/5D+lyWcGnXKr/JO
	 I9utKeyJglRi4A1hBxxH7Pu2PJkbUeDsOE51scuVlAtcbyApPtYk7K+y/xwQBZrjZs
	 zm/n9O/5IcVZQ==
Date: Sat, 14 Nov 2026 16:21:43 +0100
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
Subject: [PATCH v6 00/19] Add strprefix() and fix a bug with it
Message-ID: <cover.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="kabgjiprt5qbrvdj"
Content-Disposition: inline


--kabgjiprt5qbrvdj
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
Subject: [PATCH v6 00/19] Add strprefix() and fix a bug with it
Message-ID: <cover.1794667407.git.alx@kernel.org>
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

This patch set adds strprefix(), uses it to replace most uses of
str_has_prefix(), and notably uses strprefix() in one place to fix a bug
reported by Bartosz.

It also adds strsuffix(), for symmetry.  And it also adds streq(3), just
because it simplifies the tests, deduplicates some definitions of it,
and is also a nice interface.

The patch set also removes strstarts() and strends(), since strprefix()
and strsuffix() are drop-in replacements for them (apart from being
useful in more places).

This patch set also adds infrastructure to make string functions return
a pointer that is as qualified as the input pointer.

Changes in v6
~~~~~~~~~~~~~

-  [1/19]  ++ new patch ++
   -  Add streq(3), since it helps simplify some code in the rest of the
      patch set.
-  [2/19]
   -  Update Subject.
   -  Use Closes tag, and remove Andy from Cc.  [Andy]
   -  Add __attribute__((nonnull(1, 2))), for consistency with the
      existing strends().
-  [3/19]
   -  Don't add WARN_ON_ONCE() to str_has_prefix().  It's too
      problematic.  Just document the issue.  [Andy]
   -  Use Closes tag, and remove Andy from Cc.  [Andy]
-  [4/19]
   -  Use Closes tag, and remove Andy from Cc.  [Andy]
-  [5/19]  =3D=3D no changes =3D=3D
-  [6/19]  =3D=3D no changes =3D=3D
-  [7/19]  =3D=3D no changes =3D=3D
-  [8/19]  ++ new patch ++
   -  Prepare for replacing strstarts() with strprefix().  [Andy]
-  [9/19]
   -  Make strstarts() an alias for strprefix(), in preparation for its
      removal.  [Andy]
-  [10/19]  ++ new patch ++
   -  Prepare for replacing strstarts() with strprefix().  [Andy]
-  [11/19]  ++ new patch ++
   -  Tree-wide replacement of strstarts() with strprefix().  [Andy]
-  [12/19]  ++ new patch ++
   -  Remove strstarts().  [Andy]
-  [13/19]  ++ new patch ++
   -  Prepare for replacing str_has_prefix() with strprefix().
-  [14/19]  ++ new patch ++
   -  Replace the trivial uses of str_has_prefix() with strprefix().
-  [15/19]  ++ new patch ++
   -  Replace some simple uses of str_has_prefic() with strprefix().
-  [16/19]  ++ new patch ++
   -  Add strsuffix() for symmetry.  [Andy]
-  [17/19]  ++ new patch ++
   -  Make strends() an alias for strsuffix(), in preparation for its
      removal.  [Andy]
-  [18/19]  ++ new patch ++
   -  Tree-wide replacement of strends() with strsuffix().  [Andy]
-  [19/19]  ++ new patch ++
   -  Remove strends().  [Andy]

See range-diff below.

v1: <https://lore.kernel.org/linux-hardening/cover.1793876837.git.alx@kerne=
l.org/>
v2: <https://lore.kernel.org/linux-hardening/cover.1793882260.git.alx@kerne=
l.org/>
v3: <https://lore.kernel.org/linux-hardening/cover.1794323750.git.alx@kerne=
l.org/>
v4: <https://lore.kernel.org/linux-hardening/cover.1794425425.git.alx@kerne=
l.org/>
v5: <https://lore.kernel.org/linux-hardening/cover.1794574496.git.alx@kerne=
l.org/>

Testing
~~~~~~~

(I've indented the output, to better see the commands.)

$ git log --oneline --graph v7.4-rc1^..strprefix6
	* 8d5cac1ac296 (HEAD -> strprefix, tag: strprefix6) string: Remove strends=
()
	* 3cad861d3090 treewide: s/\<strends\>/strsuffix/g
	* 8aa3d317d63c string: Make strends() a legacy alias for strsuffix()
	* 636fe759a4eb string: Add strsuffix()
	* 95bfed420dd9 treewide: Replace some uses of str_has_prefix() by strprefi=
x()
	* 0c0070455de0 treewide: Replace boolean uses of str_has_prefix() by strpr=
efix()
	* 024364c695d5 s390/test_unwind: Use bool for booleans
	* cabc673b9ac7 string: Remove strstarts()
	* 782e2941d0f1 treewide: s/strstarts/strprefix/g
	* ec94f69d2925 platform/x86: hp-bioscfg: Rename local variable
	* 212e7fc2cb99 string: Make strstarts() a legacy alias for strprefix()
	* 8a3c50cfe298 perf map: Use bool for return type instead of int
	* 9def9160f777 string: Make strprefix() const-qualifier-generic
	* d9680e101472 string: Add [C]QChar_of() and QVoid_of()
	* 2a26768609bd stddef: Add const_cast()
	* 7fc1321995f1 device property: Fix fwnode_name_eq() for empty node names
	* 5648bb17b88a string: Document corner-case misbehavior in str_has_prefix(=
) for empty prefix
	* 0eaa4ce73a2b string: Add strprefix()
	* cff11fd710fd string: Add streq()
	* 6628e7d4c6b2 (tag: v7.4-rc1, master) Linux 7.4-rc1
$ cp ../kunitconfig .kunitconfig
$ cat .kunitconfig
	CONFIG_KUNIT=3Dy
	CONFIG_STRING_KUNIT_TEST=3Dy
$ mkdir -p ~/tmp/strprefix6
$ export TMPDIR=3D$HOME/tmp/strprefix6/
$ ./tools/testing/kunit/kunit.py run "string*"
	[15:41:05] Configuring KUnit Kernel ...
	Generating .config ...
	Populating config with:
	$ make ARCH=3Dum O=3D.kunit olddefconfig
	[15:41:08] Building KUnit Kernel ...
	Populating config with:
	$ make ARCH=3Dum O=3D.kunit olddefconfig
	Building with:
	$ make all compile_commands.json scripts_gdb ARCH=3Dum O=3D.kunit --jobs=
=3D24
	[15:41:23] Starting KUnit Kernel (1/1)...
	[15:41:23] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	Running tests with:
	$ .kunit/linux 'kunit.filter_glob=3Dstring*' kunit.enable=3D1 mem=3D1G con=
sole=3Dtty kunit_shutdown=3Dhalt
	[15:41:24] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string-stream-test (12 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[15:41:24] [PASSED] string_stream_managed_init_test
	[15:41:24] [PASSED] string_stream_unmanaged_init_test
	[15:41:24] [PASSED] string_stream_managed_free_test
	[15:41:24] [PASSED] string_stream_resource_free_test
	[15:41:24] [PASSED] string_stream_line_add_test
	[15:41:24] [PASSED] string_stream_variable_length_line_test
	[15:41:24] [PASSED] string_stream_append_test
	[15:41:24] [PASSED] string_stream_append_auto_newline_test
	[15:41:24] [PASSED] string_stream_append_empty_string_test
	[15:41:24] [PASSED] string_stream_no_auto_newline_test
	[15:41:24] [PASSED] string_stream_auto_newline_test
	[15:41:24] [PASSED] string_stream_performance_test
	[15:41:24] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] string-s=
tream-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[15:41:24] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D strin=
g (29 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[15:41:24] [PASSED] string_test_memset16
	[15:41:24] [PASSED] string_test_memset32
	[15:41:24] [PASSED] string_test_memset64
	[15:41:24] [PASSED] string_test_strlen
	[15:41:24] [PASSED] string_test_strnlen
	[15:41:24] [PASSED] string_test_strchr
	[15:41:24] [PASSED] string_test_strnchr
	[15:41:24] [PASSED] string_test_strrchr
	[15:41:24] [PASSED] string_test_strspn
	[15:41:24] [PASSED] string_test_strprefix
	[15:41:24] [PASSED] string_test_strcmp
	[15:41:24] [PASSED] string_test_strcmp_long_strings
	[15:41:24] [PASSED] string_test_strncmp
	[15:41:24] [PASSED] string_test_strncmp_long_strings
	[15:41:24] [PASSED] string_test_strcasecmp
	[15:41:24] [PASSED] string_test_strcasecmp_long_strings
	[15:41:24] [PASSED] string_test_strncasecmp
	[15:41:24] [PASSED] string_test_strncasecmp_long_strings
	[15:41:24] [PASSED] string_test_strscpy
	[15:41:24] [PASSED] string_test_strcat
	[15:41:24] [PASSED] string_test_strncat
	[15:41:24] [PASSED] string_test_strlcat
	[15:41:24] [PASSED] string_test_strtomem
	[15:41:24] [PASSED] string_test_memtostr
	[15:41:24] [PASSED] string_test_strsuffix
	[15:41:24] [SKIPPED] string_bench_strlen (not enabled)
	[15:41:24] [SKIPPED] string_bench_strnlen (not enabled)
	[15:41:24] [SKIPPED] string_bench_strchr (not enabled)
	[15:41:24] [SKIPPED] string_bench_strrchr (not enabled)
	[15:41:24] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 [PASSED] string =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
	[15:41:24] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string_helpers (4=
 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[15:41:24] [PASSED] test_get_size
	[15:41:24] [PASSED] test_upper_lower
	[15:41:24] [PASSED] test_unescape
	[15:41:24] [PASSED] test_escape
	[15:41:24] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] st=
ring_helpers =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[15:41:24] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[15:41:24] Testing complete. Ran 45 tests: passed: 41, skipped: 4
	[15:41:24] Elapsed time: 18.895s total, 2.787s configuring, 15.842s buildi=
ng, 0.251s running

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
	00:00:00   GEN     arch/x86/include/generated/asm/orc_hash.h
	00:00:00   UPD     arch/x86/include/generated/uapi/asm/bpf_perf_event.h
	00:00:00   UPD     arch/x86/include/generated/uapi/asm/errno.h
=2E..
	00:20:14   LD [M]  net/qrtr/qrtr-tun.ko
	00:20:14   LD [M]  net/qrtr/qrtr-mhi.ko
	00:20:14   LD [M]  virt/lib/irqbypass.ko

	real	20m14.429s
	user	430m41.022s
	sys	24m28.452s


Have a lovely day!
Alex


Alejandro Colomar (19):
  string: Add streq()
  string: Add strprefix()
  string: Document corner-case misbehavior in str_has_prefix() for empty
    prefix
  device property: Fix fwnode_name_eq() for empty node names
  stddef: Add const_cast()
  string: Add [C]QChar_of() and QVoid_of()
  string: Make strprefix() const-qualifier-generic
  perf map: Use bool for return type instead of int
  string: Make strstarts() a legacy alias for strprefix()
  platform/x86: hp-bioscfg: Rename local variable
  treewide: s/strstarts/strprefix/g
  string: Remove strstarts()
  s390/test_unwind: Use bool for booleans
  treewide: Replace boolean uses of str_has_prefix() by strprefix()
  treewide: Replace some uses of str_has_prefix() by strprefix()
  string: Add strsuffix()
  string: Make strends() a legacy alias for strsuffix()
  treewide: s/\<strends\>/strsuffix/g
  string: Remove strends()

 arch/alpha/kernel/setup.c                     |   2 +-
 arch/arm/kernel/module.c                      |  12 +-
 arch/mips/bcm47xx/board.c                     |   4 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c     |   2 +-
 arch/parisc/kernel/setup.c                    |   2 +-
 arch/powerpc/perf/imc-pmu.c                   |   2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c     |   2 +-
 arch/s390/kernel/early_printk.c               |   2 +-
 arch/s390/kernel/module.c                     |   6 +-
 arch/s390/kernel/setup.c                      |   4 +-
 arch/s390/lib/test_unwind.c                   |  19 +--
 crypto/essiv.c                                |   2 +-
 drivers/base/property.c                       |   5 +-
 drivers/clk/socfpga/clk-gate-a10.c            |   2 -
 drivers/clk/socfpga/clk.h                     |   1 -
 .../firmware/efi/libstub/efi-stub-helper.c    |   2 +-
 drivers/firmware/efi/libstub/gop.c            |  10 +-
 drivers/gpio/gpio-aggregator.c                |   2 +-
 drivers/gpio/gpiolib-shared.c                 |   8 +-
 drivers/gpu/drm/omapdrm/dss/base.c            |   2 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_crtc.c    |   2 +-
 drivers/gpu/drm/xe/xe_configfs.c              |   6 +-
 drivers/hid/hid-uclogic-params.c              |   2 +-
 drivers/iio/pressure/hsc030pa.c               |   2 +-
 drivers/input/mouse/psmouse-base.c            |   2 +-
 drivers/input/mouse/trackpoint.c              |   2 +-
 drivers/md/dm-crypt.c                         |   4 +-
 drivers/md/dm-inlinecrypt.c                   |   2 +-
 drivers/media/i2c/ds90ub960.c                 |   2 +-
 drivers/memory/tegra/tegra20.c                |   4 +-
 drivers/mtd/spi-nor/issi.c                    |   2 +-
 drivers/net/ethernet/amd/pds_core/fw.c        |   5 +-
 drivers/net/ethernet/intel/ice/ice_parser.c   |  10 +-
 drivers/of/property.c                         |   6 +-
 drivers/pci/pwrctrl/core.c                    |   2 +-
 drivers/platform/x86/acerhdf.c                |   6 +-
 drivers/platform/x86/dell/dell-lis3lv02d.c    |   2 +-
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     |  14 +-
 drivers/platform/x86/lenovo/thinkpad_acpi.c   |  54 ++++----
 drivers/platform/x86/touchscreen_dmi.c        |   2 +-
 drivers/remoteproc/imx_dsp_rproc.c            |   2 +-
 drivers/remoteproc/imx_rproc.c                |   8 +-
 drivers/remoteproc/mtk_scp.c                  |   2 +-
 drivers/remoteproc/st_remoteproc.c            |   2 +-
 drivers/remoteproc/stm32_rproc.c              |   2 +-
 drivers/remoteproc/xlnx_r5_remoteproc.c       |   2 +-
 .../media/atomisp/pci/atomisp_csi2_bridge.c   |   2 +-
 drivers/tty/serial/serial_base_bus.c          |   4 +-
 drivers/usb/dwc3/dwc3-pci.c                   |   2 +-
 drivers/usb/musb/musb_cppi41.c                |   4 +-
 drivers/usb/musb/musb_debugfs.c               |  20 +--
 fs/smb/client/reparse.c                       |  14 +-
 include/linux/stddef.h                        |  11 ++
 include/linux/string.h                        | 130 +++++++++++++-----
 init/main.c                                   |   2 +-
 kernel/debug/kdb/kdb_main.c                   |   2 +-
 kernel/kcsan/debugfs.c                        |   2 +-
 kernel/kcsan/report.c                         |   2 +-
 kernel/kprobes.c                              |   4 +-
 kernel/locking/locktorture.c                  |   8 +-
 kernel/module/kallsyms.c                      |   2 +-
 kernel/module/main.c                          |   8 +-
 kernel/power/main.c                           |   2 +-
 kernel/printk/braille.c                       |  14 +-
 kernel/trace/trace.c                          |   9 +-
 kernel/trace/trace_events.c                   |   5 +-
 kernel/trace/trace_events_hist.c              |  58 ++++----
 kernel/trace/trace_events_synth.c             |  10 +-
 kernel/trace/trace_events_user.c              |  22 +--
 kernel/trace/trace_probe.c                    |  22 +--
 kernel/trace/trace_stack.c                    |   6 +-
 lib/tests/string_kunit.c                      |  29 ++--
 mm/arch_numa.c                                |   2 +-
 mm/kfence/report.c                            |  14 +-
 .../hda/codecs/side-codecs/tas2781_hda_i2c.c  |   6 +-
 sound/soc/sdw_utils/soc_sdw_senary_sdca.c     |   2 +-
 tools/perf/util/map.c                         |   2 +-
 77 files changed, 364 insertions(+), 296 deletions(-)

Range-diff against v5:
 -:  ------------ >  1:  cff11fd710fd string: Add streq()
 1:  f25bf43d7f18 !  2:  0eaa4ce73a2b string: Add strprefix(), and deprecat=
e str_has_prefix()
    @@ Metadata
     Author: Alejandro Colomar <alx@kernel.org>
    =20
      ## Commit message ##
    -    string: Add strprefix(), and deprecate str_has_prefix()
    +    string: Add strprefix()
    =20
         As Bartosz reported, str_has_prefix() has a bug: it can't differen=
tiate
         between an empty prefix matching an empty string from a non-matchi=
ng
    @@ Commit message
         Move the description from str_has_prefix(), and describe
         str_has_prefix() by comparing it to strprefix().
    =20
    +    Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-fo=
r-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    -    Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-=
each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
    -    Cc: Andy Shevchenko <andy@kernel.org>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/string.h ##
    @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest_=
len, const v
     + * *  @s + strlen(@prefix) if @s starts with @prefix
     + * *  NULL if @s does not start with @prefix
     + */
    ++__attribute__((nonnull(1, 2)))
     +static inline char *strprefix(const char *s, const char *prefix)
     +{
     +  size_t len =3D strlen(prefix);
    @@ lib/tests/string_kunit.c: static void string_test_strspn(struct kuni=
t *test)
     =20
     +static void string_test_strprefix(struct kunit *test)
     +{
    -+  KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foo"), "bar"));
    -+  KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", ""), "foobar"));
    -+  KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foobar"), ""));
    ++  KUNIT_ASSERT_TRUE(test, streq(strprefix("foobar", "foo"), "bar"));
    ++  KUNIT_ASSERT_TRUE(test, streq(strprefix("foobar", ""), "foobar"));
    ++  KUNIT_ASSERT_TRUE(test, streq(strprefix("foobar", "foobar"), ""));
     +  KUNIT_ASSERT_NULL(test, strprefix("foobar", "bar"));
     +}
     +
 2:  df3a35c469c6 !  3:  5648bb17b88a string: Warn if the prefix is the emp=
ty string
    @@ Metadata
     Author: Alejandro Colomar <alx@kernel.org>
    =20
      ## Commit message ##
    -    string: Warn if the prefix is the empty string
    +    string: Document corner-case misbehavior in str_has_prefix() for e=
mpty prefix
    =20
    -    This corner case is mishandled by this function.
    -    Warn if it happens.  Also, document that if such corner case
    -    is needed, strprefix() is preferable.
    -
    -    We need to move str_has_prefix() to "lib/string.h" to be able to u=
se
    -    WARN_ON_ONCE().
    +    For an empty prefix, this function returns a value that can't be
    +    distinguished from a non-matching prefix.  This is wrong, since an=
 empty
    +    prefix is present in every string, and has resulted in bugs in cod=
e that
    +    called this function without knowing this issue.  Let's document i=
t.
    =20
    +    Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-fo=
r-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    -    Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-=
each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Suggested-by: Steven Rostedt <rostedt@goodmis.org>
    -    Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/string.h ##
    -@@ include/linux/string.h: extern char * strstr(const char *, const ch=
ar *);
    - #ifndef __HAVE_ARCH_STRNSTR
    - extern char * strnstr(const char *, const char *, size_t);
    - #endif
    -+extern size_t str_has_prefix(const char *str, const char *prefix);
    - #ifndef __HAVE_ARCH_STRLEN
    - extern __kernel_size_t strlen(const char *);
    - #endif
     @@ include/linux/string.h: static inline char *strprefix(const char *s=
, const char *prefix)
    -   return strncmp(s, prefix, len) =3D=3D 0 ? (char *) s + len : NULL;
    - }
    -=20
    --/**
    -- * str_has_prefix - Test if a string has a given prefix
    -- * @str: The string to test
    -- * @prefix: The string to see if @str starts with
    -- *
    -- * This is similar to strprefix(), but returns an offset instead of
    -- * a pointer.
    -- *
    -- * Returns:
    -- * * strlen(@prefix) if @str starts with @prefix
    -- * * 0 if @str does not start with @prefix
    -- */
    --static __always_inline size_t str_has_prefix(const char *str, const c=
har *prefix)
    --{
    --  size_t len =3D strlen(prefix);
    --  return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
    --}
    --
    - /**
    -  * strstarts - does @str start with @prefix?
    -  * @str: string to examine
    -
    - ## lib/string.c ##
    -@@ lib/string.c: char *strnstr(const char *s1, const char *s2, size_t =
len)
    - EXPORT_SYMBOL(strnstr);
    - #endif
    -=20
    -+/**
    -+ * str_has_prefix - Test if a string has a given prefix
    -+ * @str: The string to test
    -+ * @prefix: The string to see if @str starts with
    -+ *
    -+ * This is similar to strprefix(), but returns an offset instead of
    -+ * a pointer.
    -+ *
    +  * This is similar to strprefix(), but returns an offset instead of
    +  * a pointer.
    +  *
     + * Unlike for strprefix(), if the prefix is an empty string, the
     + * behavior is undefined.  If you need to support arbitrary prefixes,
     + * use strprefix().
     + *
    -+ * Returns:
    -+ * * strlen(@prefix) if @str starts with @prefix
    -+ * * 0 if @str does not start with @prefix
    -+ */
    -+size_t str_has_prefix(const char *str, const char *prefix)
    -+{
    -+  size_t len =3D strlen(prefix);
    -+  WARN_ON_ONCE(len =3D=3D 0);
    -+  return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
    -+}
    -+EXPORT_SYMBOL(str_has_prefix);
    -+
    - #ifndef __HAVE_ARCH_MEMCHR
    - /**
    -  * memchr - Find a character in an area of memory.
    +  * Returns:
    +  * * strlen(@prefix) if @str starts with @prefix
    +  * * 0 if @str does not start with @prefix
 3:  49252e78c9b6 !  4:  7fc1321995f1 device property: Fix fwnode_name_eq()=
 for empty node names
    @@ Commit message
         Let's use strprefix() instead, which also makes this function simp=
ler.
    =20
         Fixes: a9c8c738066b7 ("device property: Add fwnode_name_eq()")
    +    Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-fo=
r-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    -    Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-=
each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
    -    Cc: Andy Shevchenko <andy@kernel.org>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## drivers/base/property.c ##
 4:  b615b5afb05e =3D  5:  2a26768609bd stddef: Add const_cast()
 5:  1294b3d64440 !  6:  d9680e101472 string: Add [C]QChar_of() and QVoid_o=
f()
    @@ include/linux/string.h
     +// CQChar_of - const qualified char of
     +#define CQChar_of(p)  QChar_of(const, p)
     +
    - extern char *strndup_user(const char __user *, long);
    - extern void *memdup_user(const void __user *, size_t) __realloc_size(=
2);
    - extern void *vmemdup_user(const void __user *, size_t) __realloc_size=
(2);
    + /**
    +  * streq - strings equal
    +  *
 6:  0ca0b7aabcfc !  7:  9def9160f777 string: Make strprefix() const-qualif=
ier-generic
    @@ Commit message
    =20
      ## include/linux/string.h ##
     @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest=
_len, const void *src, size_t count,
    -  * *  @s + strlen(@prefix) if @s starts with @prefix
       * *  NULL if @s does not start with @prefix
       */
    + __attribute__((nonnull(1, 2)))
     -static inline char *strprefix(const char *s, const char *prefix)
     +static inline const char *strprefix(const char *s, const char *prefix)
      {
    @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest_=
len, const v
     +#define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pf=
x))
     =20
      /**
    -  * strstarts - does @str start with @prefix?
    +  * str_has_prefix - Test if a string has a given prefix
 -:  ------------ >  8:  8a3c50cfe298 perf map: Use bool for return type in=
stead of int
 7:  382a44f7c686 !  9:  212e7fc2cb99 string: Implement strstarts() with st=
rprefix()
    @@ Metadata
     Author: Alejandro Colomar <alx@kernel.org>
    =20
      ## Commit message ##
    -    string: Implement strstarts() with strprefix()
    +    string: Make strstarts() a legacy alias for strprefix()
    =20
    -    The compiler should be able to optimize out the unused pointer
    -    arithmetic done at the end, so performance-wise this shouldn't cha=
nge
    -    anything.
    +    strprefix() is drop-in compatible with strstarts() --but see cavea=
ts
    +    below--, and provides more functionality for cases where we're
    +    interested in the position where the prefix ends in the string.
    =20
    -    This change de-duplicates the almost-identical implementations,
    -    and better shows the relationship between the two functions.
    +    strprefix() returns a pointer that can be converted to bool.  This=
 is
    +    converted implicitly in most places, but if the target type is not=
 bool,
    +    then it might be problematic and require an explicit conversion wi=
th !!.
    +
    +    I checked that we don't need this anywhere, and also, I expect the
    +    compiler would likely diagnose in such a case, so this should be s=
afe.
    =20
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/string.h ##
     @@ include/linux/string.h: static inline const char *strprefix(const c=
har *s, const char *prefix)
    -  */
    - static inline bool strstarts(const char *str, const char *prefix)
    - {
    --  return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
    -+  return strprefix(str, prefix);
    +   return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
      }
    + #define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pf=
x))
    ++#define strstarts(s, pfx)  strprefix(s, pfx)  // legacy alias
     =20
      /**
    +  * str_has_prefix - Test if a string has a given prefix
    +@@ include/linux/string.h: static __always_inline size_t str_has_prefi=
x(const char *str, const char *prefix
    +   return strncmp(str, prefix, len) =3D=3D 0 ? len : 0;
    + }
    +=20
    +-/**
    +- * strstarts - does @str start with @prefix?
    +- * @str: string to examine
    +- * @prefix: prefix to look for.
    +- *
    +- * Returns:
    +- * True if @str begins with @prefix. False in all other cases.
    +- */
    +-static inline bool strstarts(const char *str, const char *prefix)
    +-{
    +-  return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
    +-}
    +-
    + /**
    +  * strends - Check if a string ends with another string.
    +  * @str: NULL-terminated string to check against @suffix
 -:  ------------ > 10:  ec94f69d2925 platform/x86: hp-bioscfg: Rename loca=
l variable
 -:  ------------ > 11:  782e2941d0f1 treewide: s/strstarts/strprefix/g
 -:  ------------ > 12:  cabc673b9ac7 string: Remove strstarts()
 -:  ------------ > 13:  024364c695d5 s390/test_unwind: Use bool for boolea=
ns
 -:  ------------ > 14:  0c0070455de0 treewide: Replace boolean uses of str=
_has_prefix() by strprefix()
 -:  ------------ > 15:  95bfed420dd9 treewide: Replace some uses of str_ha=
s_prefix() by strprefix()
 -:  ------------ > 16:  636fe759a4eb string: Add strsuffix()
 -:  ------------ > 17:  8aa3d317d63c string: Make strends() a legacy alias=
 for strsuffix()
 -:  ------------ > 18:  3cad861d3090 treewide: s/\<strends\>/strsuffix/g
 -:  ------------ > 19:  8d5cac1ac296 string: Remove strends()



--=20
2.55.0


--kabgjiprt5qbrvdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fHwACgkQ64mZXMKQ
wql6rQ//bU5PnVtP9aPuSO4J9HohvX8mlAQRXArmKq21yoQL9g/fmlup8xzGg1MR
/bGqatWr4SwM9FVJnZdRbbXsrQikeDaUDl9DETGp7xTgnVgBPwaX/zQFnhOlrZ6C
PYxROgQCIOIaPAIId+Hte0LN9hGIZ3vMVNFkPVzkZVHUd6zc+3wafM6dcF6gqG5i
Lxf+Ou1/+KIPtdc+tB5rg1nj0fJIRMYtkCIWsu7LbLnC5pXUYBIO19++haAu2n97
zeZJkO4MvztbeVPyclsnjxLlb8iqLltcuMqHn8XrsX7TyogFVTXZAftxFG0DTHdx
tMGQPQwjyqdMux9mkMSglxF86iU5rZncSVk5scpiSYbVlbU1nBR/sYnbeo8fOkgN
CUy7YLqn3YJj6QVw14sGUfRpe7OlyMPZybCC91Iwt0aQLBQTbBRYhcgC+XIHXn+y
kg+3hzgnKb65eD+sO4rpntkGpCM7XsHXlxi4LP5J+Yg22ofTI2gItHRTVHukN7Vh
DLZQbi2zNMeOb+duJYtvnOGgssfptHHfFD18+Xdy5PXyMc25ZZ7PImXmkoKV/gwb
iF93l38kE1QdSZrIvCpQtFHL6b4rK7jNRnUJ/UjFTzouWtafucfL1XJuNVEFfLyv
rLlTcNWMVM2694li6bDq0pTVUmnlSXLdBTI+zKXf8IiibLM8BdM=
=JxUo
-----END PGP SIGNATURE-----

--kabgjiprt5qbrvdj--
