Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882789;
	b=lMQNLLBP1fllZfNjC0+JdllNKZ8vmlNO2tWx3ODMSHYwAEypb9Drz930B9rjFQU33RRX
	 FBk/FIazD8uMECEq6cGh/+mz6MauaFpQd8814ziejcJ+pvmbDTw+TC37ZzV8H2ksniSaW
	 O5inTbmMVGfDURWou563d81t9z4qecGsnfII2j8Aq8maGIfn4y6Im8kwhw35lC78ynjbF
	 37ow/VVBUaKsKnFZyE/ZzZunZfiuEfoYNJOcLNMVghuKdXQo1qsDBqq9Jl9yK68vpr8Hi
	 W8z/IIT47cY4M2KKQ7zaV5+5MDEdYXIqeLJkj7CdKUrGl74kQjdkWVifdygTKBhid3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882789;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=HyzKvsSHqgPO50rdEeW4QLU+dE7ILQaIuU/K9EajKEM=;
	b=191U9rBbj0qPQQOZOgbyT9ElmW/oKq0GgmKTnYHzeg9vmuPkDdHQtqEZAh+MJPNJVRBo
	 I19nsFX3iyKZJsxDz16bsh7shDAG81Sc0oleuOrsGYED6adATktkfcPA9niuK//Ml2Re0
	 y+Qwm9JX8AdzItevnejIJF2xPmCl6BQB6JENfJIb200FPhpYJs8jZNc0MR4qeunBxppPE
	 YvBrYt0oGI55GPm738OZFtBWcry3QE2mIssjQYZAWBdJ1fEtfjy63A1YKH79o66EkxbhX
	 +ZtbIMFBle8JHmeyJCGWmEjqvDHyH0BULHYQH4hSPpAgLfZi2pRrsPgIX1ra5ZiC/Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mGJrm/8U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642F606A339;
	Thu,  5 Nov 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGJrm/8U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658621F000C1;
	Thu,  5 Nov 2026 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882788;
	bh=HyzKvsSHqgPO50rdEeW4QLU+dE7ILQaIuU/K9EajKEM=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=mGJrm/8UYxj8MJaIQAXhg8wrElLZKDTpekKhLPyl4/R8PFwGKjUzjM77f4CoTwmCj
	 J9AbOyK055n64ec1X0SHJm96kTl9mRAaOQ92QJ7Qe2xmWrEj6HoGdMwUxmDSO/ujg3
	 nUShnYQeZiHRFmdPe9uLUBFq/3VLAtztCXVXX6sNhqy4OBnU64wi9HjB+XNUdWwn7H
	 xaleH21BsVvMdolCNvsY4OCBerTuD/Je+w2CjKhk7tZLLUvSSe4BQWFWjGhwBKjFIk
	 f7bly4Hh1GMVftP3VLzuwbCAGB/OZHgJhBgLnN4o5fYyWhkQUVJGlc2ydqGy2S65JF
	 i5lEy3YZZzgdQ==
Date: Thu, 5 Nov 2026 13:46:20 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
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
Subject: [PATCH v2 0/2] Add strprefix() and fix a bug with it
Message-ID: <cover.1793882260.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1793876837.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="jti7rjabgq6a3xqs"
Content-Disposition: inline
In-Reply-To: <cover.1793876837.git.alx@kernel.org>


--jti7rjabgq6a3xqs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.lore.kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
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
Subject: [PATCH v2 0/2] Add strprefix() and fix a bug with it
Message-ID: <cover.1793882260.git.alx@kernel.org>
References: <cover.1793876837.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1793876837.git.alx@kernel.org>

Hi!

str_has_prefix() is based on sizes and lengths, which means it must
overload the valid length 0 to mean not found.  This is a typical
consequence of choosing to design an API around sizes and lengths, and
vanishes when moving to pointer-based similar APIs.

This patch set adds strprefix(), deprecates str_has_prefix(), and uses
strprefix() in one place to fix a bug reported by Bartosz.

We can later work on replacing the other uses of str_has_prefix(), which
might hide similar bugs.

Changes in v2
~~~~~~~~~~~~~

-  Added tests, as suggested by Andy.
-  Remove Cc tags from the commit messages.  [Andy]

Testing
~~~~~~~

The new tests added for strprefix() pass.  Below is the session I ran
for testing.  The important line is:

	[13:26:30] [PASSED] string_test_strprefix

Full session:

	$ cat .kunitconfig=20
	CONFIG_KUNIT=3Dy
	CONFIG_STRING_KUNIT_TEST=3Dy
	$ mkdir -p ~/tmp
	$ export TMPDIR=3D$HOME/tmp
	$ ./tools/testing/kunit/kunit.py run "string*"
	[13:26:28] Configuring KUnit Kernel ...
	[13:26:28] Building KUnit Kernel ...
	Populating config with:
	$ make ARCH=3Dum O=3D.kunit olddefconfig
	Building with:
	$ make all compile_commands.json scripts_gdb ARCH=3Dum O=3D.kunit --jobs=
=3D24
	[13:26:30] Starting KUnit Kernel (1/1)...
	[13:26:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	Running tests with:
	$ .kunit/linux 'kunit.filter_glob=3Dstring*' kunit.enable=3D1 mem=3D1G con=
sole=3Dtty kunit_shutdown=3Dhalt
	[13:26:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string-stream-test (12 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:26:30] [PASSED] string_stream_managed_init_test
	[13:26:30] [PASSED] string_stream_unmanaged_init_test
	[13:26:30] [PASSED] string_stream_managed_free_test
	[13:26:30] [PASSED] string_stream_resource_free_test
	[13:26:30] [PASSED] string_stream_line_add_test
	[13:26:30] [PASSED] string_stream_variable_length_line_test
	[13:26:30] [PASSED] string_stream_append_test
	[13:26:30] [PASSED] string_stream_append_auto_newline_test
	[13:26:30] [PASSED] string_stream_append_empty_string_test
	[13:26:30] [PASSED] string_stream_no_auto_newline_test
	[13:26:30] [PASSED] string_stream_auto_newline_test
	[13:26:30] [PASSED] string_stream_performance_test
	[13:26:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] string-s=
tream-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:26:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D strin=
g (29 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:26:30] [PASSED] string_test_memset16
	[13:26:30] [PASSED] string_test_memset32
	[13:26:30] [PASSED] string_test_memset64
	[13:26:30] [PASSED] string_test_strlen
	[13:26:30] [PASSED] string_test_strnlen
	[13:26:30] [PASSED] string_test_strchr
	[13:26:30] [PASSED] string_test_strnchr
	[13:26:30] [PASSED] string_test_strrchr
	[13:26:30] [PASSED] string_test_strspn
	[13:26:30] [PASSED] string_test_strprefix
	[13:26:30] [PASSED] string_test_strcmp
	[13:26:30] [PASSED] string_test_strcmp_long_strings
	[13:26:30] [PASSED] string_test_strncmp
	[13:26:30] [PASSED] string_test_strncmp_long_strings
	[13:26:30] [PASSED] string_test_strcasecmp
	[13:26:30] [PASSED] string_test_strcasecmp_long_strings
	[13:26:30] [PASSED] string_test_strncasecmp
	[13:26:30] [PASSED] string_test_strncasecmp_long_strings
	[13:26:30] [PASSED] string_test_strscpy
	[13:26:30] [PASSED] string_test_strcat
	[13:26:30] [PASSED] string_test_strncat
	[13:26:30] [PASSED] string_test_strlcat
	[13:26:30] [PASSED] string_test_strtomem
	[13:26:30] [PASSED] string_test_memtostr
	[13:26:30] [PASSED] string_test_strends
	[13:26:30] [SKIPPED] string_bench_strlen (not enabled)
	[13:26:30] [SKIPPED] string_bench_strnlen (not enabled)
	[13:26:30] [SKIPPED] string_bench_strchr (not enabled)
	[13:26:30] [SKIPPED] string_bench_strrchr (not enabled)
	[13:26:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 [PASSED] string =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
	[13:26:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string_helpers (4=
 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:26:30] [PASSED] test_get_size
	[13:26:30] [PASSED] test_upper_lower
	[13:26:30] [PASSED] test_unescape
	[13:26:30] [PASSED] test_escape
	[13:26:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] st=
ring_helpers =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:26:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[13:26:30] Testing complete. Ran 45 tests: passed: 41, skipped: 4
	[13:26:31] Elapsed time: 2.509s total, 0.001s configuring, 2.192s building=
, 0.271s running


Cheers,
Alex

Alejandro Colomar (2):
  string: Add strprefix(), and deprecate str_has_prefix()
  device property: Fix fwnode_name_eq() for empty node names

 drivers/base/property.c  |  5 +----
 include/linux/string.h   | 19 ++++++++++++++++++-
 lib/tests/string_kunit.c |  9 +++++++++
 3 files changed, 28 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  9c81f6f62fd0 ! 1:  d3b325ecefd1 string: Add strprefix(), and deprecate =
str_has_prefix()
    @@ Commit message
         We'll slowly migrate existing code from str_has_prefix() to strpre=
fix().
    =20
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    -    Cc: Andreas Schwab <schwab@linux-m68k.org>
    -    Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
         Cc: Andy Shevchenko <andy@kernel.org>
    -    Cc: Bartosz Golaszewski <brgl@kernel.org>
    -    Cc: Daniel Scally <djrscally@gmail.com>
    -    Cc: Danilo Krummrich <dakr@kernel.org>
    -    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    -    Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
    -    Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
    -    Cc: Joe Perches <joe@perches.com>
    -    Cc: Johan Hovold <johan@kernel.org>
    -    Cc: Kees Cook <kees@kernel.org>
    -    Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    -    Cc: Len Brown <lenb@kernel.org>
    -    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    -    Cc: Linus Walleij <linusw@kernel.org>
    -    Cc: Namhyung Kim <namhyung@kernel.org>
    -    Cc: "Rafael J. Wysocki" <rafael@kernel.org>
    -    Cc: Rob Herring <robh@kernel.org>
    -    Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
    -    Cc: Saravana Kannan <saravanak@kernel.org>
    -    Cc: Steven Rostedt <rostedt@goodmis.org>
    -    Cc: Tom Zanussi <zanussi@kernel.org
    -    Cc: linux-acpi@vger.kernel.org
    -    Cc: driver-core@lists.linux.dev
    -    Cc: linux-kernel@vger.kernel.org
    -    Cc: linux-hardening@vger.kernel.org
    -    Cc: devicetree@vger.kernel.org
    -    Cc: linux-gpio@vger.kernel.org
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/string.h ##
    @@ include/linux/string.h: void memcpy_and_pad(void *dest, size_t dest_=
len, const v
       *
       * Returns:
       * * strlen(@prefix) if @str starts with @prefix
    +
    + ## lib/tests/string_kunit.c ##
    +@@ lib/tests/string_kunit.c: static void string_test_strspn(struct kun=
it *test)
    + 	}
    + }
    +=20
    ++static void string_test_strprefix(struct kunit *test)
    ++{
    ++	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foo"), "bar"));
    ++	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", ""), "foobar"));
    ++	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foobar"), ""));
    ++	KUNIT_ASSERT_NULL(test, strprefix("foobar", "bar"));
    ++}
    ++
    + static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
    + static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
    +=20
    +@@ lib/tests/string_kunit.c: static struct kunit_case string_test_case=
s[] =3D {
    + 	KUNIT_CASE(string_test_strnchr),
    + 	KUNIT_CASE(string_test_strrchr),
    + 	KUNIT_CASE(string_test_strspn),
    ++	KUNIT_CASE(string_test_strprefix),
    + 	KUNIT_CASE(string_test_strcmp),
    + 	KUNIT_CASE(string_test_strcmp_long_strings),
    + 	KUNIT_CASE(string_test_strncmp),
2:  37eafcd682b0 ! 2:  ac9728afa027 device property: Fix fwnode_name_eq() f=
or empty node names
    @@ Commit message
    =20
         Fixes: a9c8c738066b7 ("device property: Add fwnode_name_eq()")
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    -    Cc: Andreas Schwab <schwab@linux-m68k.org>
    -    Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
         Cc: Andy Shevchenko <andy@kernel.org>
    -    Cc: Bartosz Golaszewski <brgl@kernel.org>
    -    Cc: Daniel Scally <djrscally@gmail.com>
    -    Cc: Danilo Krummrich <dakr@kernel.org>
    -    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    -    Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
    -    Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
    -    Cc: Joe Perches <joe@perches.com>
    -    Cc: Johan Hovold <johan@kernel.org>
    -    Cc: Kees Cook <kees@kernel.org>
    -    Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    -    Cc: Len Brown <lenb@kernel.org>
    -    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    -    Cc: Linus Walleij <linusw@kernel.org>
    -    Cc: Namhyung Kim <namhyung@kernel.org>
    -    Cc: "Rafael J. Wysocki" <rafael@kernel.org>
    -    Cc: Rob Herring <robh@kernel.org>
    -    Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
    -    Cc: Saravana Kannan <saravanak@kernel.org>
    -    Cc: Steven Rostedt <rostedt@goodmis.org>
    -    Cc: Tom Zanussi <zanussi@kernel.org
    -    Cc: linux-acpi@vger.kernel.org
    -    Cc: driver-core@lists.linux.dev
    -    Cc: linux-kernel@vger.kernel.org
    -    Cc: linux-hardening@vger.kernel.org
    -    Cc: devicetree@vger.kernel.org
    -    Cc: linux-gpio@vger.kernel.org
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## drivers/base/property.c ##
--=20
2.55.0


--jti7rjabgq6a3xqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsepwACgkQ64mZXMKQ
wqlGEg//VGEqCjaZlhibqTKSLSnyKsgDN6teK1rp/OtYo6FgO5AJq8gImQig7LyH
wMuQJiWdCvHBxngMNyijtu3N5JMG9H1btdxzihjiz0PxX9RXxwsoWdcSMJb2ZZJL
Fe8qPynXr8MDLYlwjFOvuXfAYG3RWM0pSWg2omzowFQaeTweXNVjC0fsar6JE0Pz
vNLGYt4HHtZ5XdO3LjWrcm++iFvS5f2S4bI3si/qIyMN23VzgtIeBUbW2zqtPsqz
TvgrzvzwB6HzUs7znLZshAEvibPgQYa3id/82lFN/BHrQwG41J8rz5zDOY8yeymN
gGvf0kxWWABFxGhNhW2KZzRRSlDxW/sMISuQa7N/zynGW5Pn0+NOUf/kP4YR2L5d
+3kDP1vexWtjGTLr5wz35+dQQjzMfOJzj7UxQaAXbpnS2gQoCkKa8J/r1j6tzH+t
Bsk+mOx0yNJuLvHjszeapZZOjpxszqGxVO+iSYYDNVzkqVg6tRDLNQB+iVf0NWNy
Nq2p+m4pU251Z0a61S2AZUZMjXyBK375/ShAf1qKWctoqzjPt2SemqXhEaOaCYCh
Ms1C0oZagRE9LW2GH3mhvG66munv9A8TKi8cPr2ozseuUmv11zy6qg0N4qsPAamx
ELkWBJzFRjrByv7WRIUy2zbNGnUIyLkh9d3gA8vXjTaml4V7NGw=
=Yrxs
-----END PGP SIGNATURE-----

--jti7rjabgq6a3xqs--
