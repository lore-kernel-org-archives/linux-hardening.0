Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640609;
	b=LIcIWkBI0mIfi5XbPp6+NXBYvhPLnNsWwScurKsEdPkGtqJhpg1aviVq49xCoifKirKM
	 2ujxK+o/6tCG1712OwjxbEt1FRJ4YxYygX3nCH5a1Q8OYzOVOhxqxvMOmrzC7xq+t4891
	 wWAbizmR9GokIYYnV+74ejOsD6LqOWqtOVeu94qcl4BgFybQTdB5isOCjjlyVLCcEzrhy
	 k0PQnDClAUdfyCU+La2fOK20577awk02E+IeDOA1YTpXDjTLXZGuw+hxcfOqRCTSPDyQa
	 7Uhj3Wcjn04lzQh6retJHiCXabKDM7Mw19DJrIr6ZrJq8rZavqKbQMufVNxi+rmHXDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640609;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 Alx-In-Reply-To:MIME-Version:Content-Type:Content-Disposition;
	bh=xtHYFrKQoYbCgFBgMvYJmjUyH3AVPT8QsMe8YROz4Bk=;
	b=pWdp826pBIf/WFQdz56eOTMn/PeyDrIWJLpLywRrBxOEgBnlK2wHTTcl3Qk/AMY1LF6V
	 A0+f6uZOZJcrzOnkUpe/xozGMTIhIsqt4HpdTTO9LbvWVc7v3+YpY9V8OMHQ32QZHqmu+
	 1hTfWYaJ6Ln9J3rsCkokwh8jp3luvifLtEN1KHgob62gKB17T6yg8vp3O/41QFYC40acU
	 c8d2tSejyVYaQ7m6/uYXncRW6XpvJDg/rR0+B5scDCRw6WFYEC3HtfENlusBRC2Q+hfAK
	 IgHT8E8vUNKUrRZnWIuto68mtIyrhDDED43kvuqdQ1GsVrRviCYQnVy6nZ81OMX+qJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhOORMrW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA35606A31E;
	Wed, 25 Nov 2026 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhOORMrW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6537C1F000CA;
	Wed, 25 Nov 2026 21:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640609;
	bh=xtHYFrKQoYbCgFBgMvYJmjUyH3AVPT8QsMe8YROz4Bk=;
	h=Date:From:To:Cc:Subject;
	b=XhOORMrWmWUb1XWEAo+i3oAQMLb7ZB2Gl3gxclk07ERPGWPs73HOW7+NvZZ7d79My
	 HN/WMk6oI0/HxtGrrCi1aA19gneI0K3WRxtB7ZqCU+WJ/7BPe1kq9ABi9SmmqGcNOV
	 PPOXSnFStcJg484+i8wuB6u5u3Kg72mb0IeK7OtEUuSaHzSd+uvSKDh6eFq93TmYcd
	 RO/GwCg9jaG2MeaLqGWoblKTCgIL09jmYimU0vcYkCJtZLYxq23wVr6dRk30Zz6j+j
	 Ay8iD4OyCextJ89mYyUSbv1blbdtnY6T+SgyIOAe6gE5SZ3M0E4WFaVeVEisAAnAIC
	 Mt4aMRlcsyFWQ==
Date: Wed, 25 Nov 2026 22:03:21 +0100
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
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org
Subject: [PATCH v7 0/4] Add strprefix() and fix a bug with it
Message-ID: <cover.1795639368.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="xhlrb5vu5bjuvz4z"
Content-Disposition: inline


--xhlrb5vu5bjuvz4z
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
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org
Subject: [PATCH v7 0/4] Add strprefix() and fix a bug with it
Message-ID: <cover.1795639368.git.alx@kernel.org>
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

If the function had been named something like strprefix_len(), that
design would have made sense, but being called str_has_prefix(), the
obvious way to call it will result in bugs, because the name contradicts
its intended use.

Users of strings need a function whose behavior extends naturally to the
empty string, and we can do better, by returning a pointer.  And indeed,
users have ended up using str_has_prefix() with empty prefix, expecting
it to work (as is natural of a generic string API with that name).

This patch set adds strprefix(), and uses strprefix() in one place to
fix a bug reported by Bartosz.

It also adds streq(3), just because it simplifies the tests, and is also
a nice interface.

This patch set doesn't include the sibling strsuffix(), and also doesn't
replace any other cases which would benefit from strprefix(), to allow
merging it quickly.  I'll work on a follow-up patch, including the
patches from v6 that have been dropped in this v7, after this has been
applied.


Have a lovely night!
Alexo


Changes in v7
~~~~~~~~~~~~~

-  [1/4]
   -  Add tests for streq(3).
-  [2/4]
   -  Use __nonnull_args().  [Joe]
   -  Rewrite the description entirely, to be descriptive, rather than
      comparative.  [Joe]
-  [3/4]
   -  Remove 'Suggested-by', since the commit changed too much from what
      he suggested.
-  [4/4]
   -  Add 'Reviewed-by' and 'Tested-by' tags, accompanied with the
      'Message-ID's of the emails in which they were given.
-  Drop all other commits from v6, to minimize the patch set, and help
   adopt it quickly.


See the range-diff below.

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
v6: <https://lore.kernel.org/linux-hardening/cover.1794667407.git.alx@kerne=
l.org/>

Testing
~~~~~~~

(I've indented the output, to better see the commands.)

$ git log --oneline --graph v7.4-rc1^..strprefix7
	* 396395e1d02c (HEAD -> strprefix, tag: strprefix7) device property: Fix f=
wnode_name_eq>
	* c4131a109098 string: Document corner-case misbehavior in str_has_prefix(=
) for empty p>
	* b32d70163fb4 string: Add strprefix()
	* ad8500a6eb0a string: Add streq()
	* 6628e7d4c6b2 (tag: v7.4-rc1, master) Linux 7.4-rc1
$ cp ../kunitconfig .kunitconfig
$ cat .kunitconfig
	CONFIG_KUNIT=3Dy
	CONFIG_STRING_KUNIT_TEST=3Dy
$ mkdir -p ~/tmp/strprefix7
$ export TMPDIR=3D$HOME/tmp/strprefix7/
$ ./tools/testing/kunit/kunit.py run "string*"
	[21:40:20] Configuring KUnit Kernel ...
	Generating .config ...
	Populating config with:
	$ make ARCH=3Dum O=3D.kunit olddefconfig
	[21:40:23] Building KUnit Kernel ...
	Populating config with:
	$ make ARCH=3Dum O=3D.kunit olddefconfig
	Building with:
	$ make all compile_commands.json scripts_gdb ARCH=3Dum O=3D.kunit --jobs=
=3D24
	[21:40:39] Starting KUnit Kernel (1/1)...
	[21:40:39] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	Running tests with:
	$ .kunit/linux 'kunit.filter_glob=3Dstring*' kunit.enable=3D1 mem=3D1G con=
sole=3Dtty kunit_shutdown=3Dhalt
	[21:40:39] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string-stream-test (12 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[21:40:39] [PASSED] string_stream_managed_init_test
	[21:40:39] [PASSED] string_stream_unmanaged_init_test
	[21:40:39] [PASSED] string_stream_managed_free_test
	[21:40:39] [PASSED] string_stream_resource_free_test
	[21:40:39] [PASSED] string_stream_line_add_test
	[21:40:39] [PASSED] string_stream_variable_length_line_test
	[21:40:39] [PASSED] string_stream_append_test
	[21:40:39] [PASSED] string_stream_append_auto_newline_test
	[21:40:39] [PASSED] string_stream_append_empty_string_test
	[21:40:39] [PASSED] string_stream_no_auto_newline_test
	[21:40:39] [PASSED] string_stream_auto_newline_test
	[21:40:39] [PASSED] string_stream_performance_test
	[21:40:39] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] string-s=
tream-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[21:40:39] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D strin=
g (30 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[21:40:39] [PASSED] string_test_memset16
	[21:40:40] [PASSED] string_test_memset32
	[21:40:40] [PASSED] string_test_memset64
	[21:40:40] [PASSED] string_test_strlen
	[21:40:40] [PASSED] string_test_strnlen
	[21:40:40] [PASSED] string_test_strchr
	[21:40:40] [PASSED] string_test_strnchr
	[21:40:40] [PASSED] string_test_strrchr
	[21:40:40] [PASSED] string_test_strspn
	[21:40:40] [PASSED] string_test_streq
	[21:40:40] [PASSED] string_test_strprefix
	[21:40:40] [PASSED] string_test_strcmp
	[21:40:40] [PASSED] string_test_strcmp_long_strings
	[21:40:40] [PASSED] string_test_strncmp
	[21:40:40] [PASSED] string_test_strncmp_long_strings
	[21:40:40] [PASSED] string_test_strcasecmp
	[21:40:40] [PASSED] string_test_strcasecmp_long_strings
	[21:40:40] [PASSED] string_test_strncasecmp
	[21:40:40] [PASSED] string_test_strncasecmp_long_strings
	[21:40:40] [PASSED] string_test_strscpy
	[21:40:40] [PASSED] string_test_strcat
	[21:40:40] [PASSED] string_test_strncat
	[21:40:40] [PASSED] string_test_strlcat
	[21:40:40] [PASSED] string_test_strtomem
	[21:40:40] [PASSED] string_test_memtostr
	[21:40:40] [PASSED] string_test_strends
	[21:40:40] [SKIPPED] string_bench_strlen (not enabled)
	[21:40:40] [SKIPPED] string_bench_strnlen (not enabled)
	[21:40:40] [SKIPPED] string_bench_strchr (not enabled)
	[21:40:40] [SKIPPED] string_bench_strrchr (not enabled)
	[21:40:40] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 [PASSED] string =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
	[21:40:40] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string_helpers (4=
 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[21:40:40] [PASSED] test_get_size
	[21:40:40] [PASSED] test_upper_lower
	[21:40:40] [PASSED] test_unescape
	[21:40:40] [PASSED] test_escape
	[21:40:40] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] st=
ring_helpers =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[21:40:40] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[21:40:40] Testing complete. Ran 46 tests: passed: 42, skipped: 4
	[21:40:40] Elapsed time: 19.891s total, 2.881s configuring, 16.793s buildi=
ng, 0.173s running

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
	00:21:16   LD [M]  net/qrtr/qrtr-tun.ko
	00:21:16   LD [M]  net/qrtr/qrtr-mhi.ko
	00:21:16   LD [M]  virt/lib/irqbypass.ko

	real	21m15.252s
	user	442m14.443s
	sys	31m3.323s


Alejandro Colomar (4):
  string: Add streq()
  string: Add strprefix()
  string: Document corner-case misbehavior in str_has_prefix() for empty
    prefix
  device property: Fix fwnode_name_eq() for empty node names

 drivers/base/property.c            |  5 +---
 drivers/clk/socfpga/clk-gate-a10.c |  2 --
 drivers/clk/socfpga/clk.h          |  1 -
 include/linux/string.h             | 42 +++++++++++++++++++++++++++---
 lib/tests/string_kunit.c           | 22 ++++++++++++++++
 5 files changed, 61 insertions(+), 11 deletions(-)

Range-diff against v6:
 1:  cff11fd710fd !  1:  ad8500a6eb0a string: Add streq()
    @@ include/linux/string.h
      extern char *strndup_user(const char __user *, long);
      extern void *memdup_user(const void __user *, size_t) __realloc_size(=
2);
      extern void *vmemdup_user(const void __user *, size_t) __realloc_size=
(2);
    +
    + ## lib/tests/string_kunit.c ##
    +@@ lib/tests/string_kunit.c: static void string_test_strspn(struct kun=
it *test)
    +   }
    + }
    +=20
    ++static void string_test_streq(struct kunit *test)
    ++{
    ++  KUNIT_ASSERT_TRUE(test,  streq("foo", "foo"));
    ++  KUNIT_ASSERT_TRUE(test,  streq("", ""));
    ++
    ++  KUNIT_ASSERT_FALSE(test, streq("foo", "foobar"));
    ++  KUNIT_ASSERT_FALSE(test, streq("foobar", "foo"));
    ++  KUNIT_ASSERT_FALSE(test, streq("foo", "bar"));
    ++  KUNIT_ASSERT_FALSE(test, streq("foo", ""));
    ++  KUNIT_ASSERT_FALSE(test, streq("", "bar"));
    ++}
    ++
    + static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
    + static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
    +=20
    +@@ lib/tests/string_kunit.c: static struct kunit_case string_test_case=
s[] =3D {
    +   KUNIT_CASE(string_test_strnchr),
    +   KUNIT_CASE(string_test_strrchr),
    +   KUNIT_CASE(string_test_strspn),
    ++  KUNIT_CASE(string_test_streq),
    +   KUNIT_CASE(string_test_strcmp),
    +   KUNIT_CASE(string_test_strcmp_long_strings),
    +   KUNIT_CASE(string_test_strncmp),
 2:  0eaa4ce73a2b !  2:  b32d70163fb4 string: Add strprefix()
    @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest_=
len, const v
     + * @s: The string to be tested
     + * @prefix: The string to see if @s starts with
     + *
    -+ * A common way to test a prefix of a string is to do:
    -+ *  strncmp(s, prefix, sizeof(prefix) - 1)
    -+ *
    -+ * But this can lead to bugs due to typos, or if prefix is a pointer
    -+ * and not a constant.  Instead use strprefix().
    ++ * This function determines whether the string pointed to by @s
    ++ * starts with the sequence of characters
    ++ * (excluding the terminating null character)
    ++ * in the string pointed to by @prefix.
     + *
     + * Returns:
     + * *  @s + strlen(@prefix) if @s starts with @prefix
     + * *  NULL if @s does not start with @prefix
     + */
    -+__attribute__((nonnull(1, 2)))
    ++__nonnull_args(1, 2)
     +static inline char *strprefix(const char *s, const char *prefix)
     +{
     +  size_t len =3D strlen(prefix);
    @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest_=
len, const v
       * * strlen(@prefix) if @str starts with @prefix
    =20
      ## lib/tests/string_kunit.c ##
    -@@ lib/tests/string_kunit.c: static void string_test_strspn(struct kun=
it *test)
    -   }
    +@@ lib/tests/string_kunit.c: static void string_test_streq(struct kuni=
t *test)
    +   KUNIT_ASSERT_FALSE(test, streq("", "bar"));
      }
     =20
     +static void string_test_strprefix(struct kunit *test)
    @@ lib/tests/string_kunit.c: static void string_test_strspn(struct kuni=
t *test)
      static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
     =20
     @@ lib/tests/string_kunit.c: static struct kunit_case string_test_case=
s[] =3D {
    -   KUNIT_CASE(string_test_strnchr),
        KUNIT_CASE(string_test_strrchr),
        KUNIT_CASE(string_test_strspn),
    +   KUNIT_CASE(string_test_streq),
     +  KUNIT_CASE(string_test_strprefix),
        KUNIT_CASE(string_test_strcmp),
        KUNIT_CASE(string_test_strcmp_long_strings),
 3:  5648bb17b88a !  3:  c4131a109098 string: Document corner-case misbehav=
ior in str_has_prefix() for empty prefix
    @@ Commit message
    =20
         Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-fo=
r-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    -    Suggested-by: Steven Rostedt <rostedt@goodmis.org>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/string.h ##
 4:  7fc1321995f1 !  4:  396395e1d02c device property: Fix fwnode_name_eq()=
 for empty node names
    @@ Commit message
         Fixes: a9c8c738066b7 ("device property: Add fwnode_name_eq()")
         Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-fo=
r-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    +    Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
    +    Message-ID: <avrSUUM3HMgxTNpl@kekkonen.localdomain>
    +    Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    +    Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf=
63j4lb3flk>
    +    Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.c=
om>
    +    Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf=
63j4lb3flk>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## drivers/base/property.c ##
 5:  2a26768609bd <  -:  ------------ stddef: Add const_cast()
 6:  d9680e101472 <  -:  ------------ string: Add [C]QChar_of() and QVoid_o=
f()
 7:  9def9160f777 <  -:  ------------ string: Make strprefix() const-qualif=
ier-generic
 8:  8a3c50cfe298 <  -:  ------------ perf map: Use bool for return type in=
stead of int
 9:  212e7fc2cb99 <  -:  ------------ string: Make strstarts() a legacy ali=
as for strprefix()
10:  ec94f69d2925 <  -:  ------------ platform/x86: hp-bioscfg: Rename loca=
l variable
11:  782e2941d0f1 <  -:  ------------ treewide: s/strstarts/strprefix/g
12:  cabc673b9ac7 <  -:  ------------ string: Remove strstarts()
13:  024364c695d5 <  -:  ------------ s390/test_unwind: Use bool for boolea=
ns
14:  0c0070455de0 <  -:  ------------ treewide: Replace boolean uses of str=
_has_prefix() by strprefix()
15:  95bfed420dd9 <  -:  ------------ treewide: Replace some uses of str_ha=
s_prefix() by strprefix()
16:  636fe759a4eb <  -:  ------------ string: Add strsuffix()
17:  8aa3d317d63c <  -:  ------------ string: Make strends() a legacy alias=
 for strsuffix()
18:  3cad861d3090 <  -:  ------------ treewide: s/\<strends\>/strsuffix/g
19:  8d5cac1ac296 <  -:  ------------ string: Remove strends()
--=20
2.55.0


--xhlrb5vu5bjuvz4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHTRIACgkQ64mZXMKQ
wqmAXhAAsAiJIPPo+UOOfAVul+my3ZYetfigY31ZZ2nL5TWTUBdMYl8Uapi4QCcL
yG75gBZ68l46Qk0VVEP86SxzjxvAkjijE5XKy/Cidm++Hrdwey95lvu9JWQe2rTs
C9S/ShIoiPEUWGaPGzaBssbqw4RKkcbvYpvtbrruyLEhy+br6sgsRx3nXeVtTZbs
kkJ3BNTMIgLmO1eHzFk+UCKxtEqZ3cwntbp86IzDLceOgKlITqnTS3OUq3Y3dIT6
jEk7T8QPAa48uygvilxRQobHL0lPvT1rS8Wn9Hl/HglKjGl5lcNcQ8/HCvrf1lpw
DvLTmH3Vt0HR6Vz2RXHIJ3SxMz0gpqxgR5Fd7UvFnaPgweZOu2EErMfPm4HSQE9G
AzczBsKCJ/mBhEigC750nW0+a5xKtpX+5zL84/up5j7WYx0IuuQRbLEqMs+OJ8LY
O3Kz2iWYjeFVT57FtLWTcy4HOK0bSt802DKyo9tNkXs0DBq3Q40N9wmlSIu7fLXo
IZ5QvzrUdC+yZhcE3/FW8XrKGcckLYFadWBTCZ4WWefH4jOKa8ynAlxsTF53qhrH
SrTfm1SmAiq/TmrO04CpRz91pOOjgI8zywdV+XSim+SVfr1L/nE5GXQpnWM5x5pG
3WpIaM7U9S0KTRjqsEGq9Oplq7vq5Xq4PFJIfTbUM2DPfn1I7I8=
=FdAW
-----END PGP SIGNATURE-----

--xhlrb5vu5bjuvz4z--
