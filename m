Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729770;
	b=EHkbDf3h4OTAQr049UjUdcFui898FvwAwBbqooVD4nx8iy3V1UpoOncPB2a7fymRzV8d
	 lspm9nt1b3i3K7qMPGY5ka2qM3U7eQaI3zsVLI91ml8+Nzx0cPWqx3FhOUoGUpqYvmJKs
	 h804WrbrV74qwed1lYDUhNBdIG7nrFG4wtO5cYpO+uB30ng5KJguOzNoqqdDjiP6gaiyr
	 hlWAcep9Bg3r/xajXpvWTvv78HhI4SRzFlJZGdy0ZL7ApxmalJ/I9ViKJrq+IQZoSH3Et
	 /QzWz6gFLp9aARZ6yeY8zQ/hHlaVVyBqVbFEhbkju3YVAU2Mg83aBAhhN67lTQsUHiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729770;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lSFEsXx3nBqQNb7z98ARqhe2UkfetK4VZXZD7RYmnqo=;
	b=hUoudefvBkwQpyQfJF1b0CvKsEaB0q2+2S2BEQkG3AnglfSOOiDKJLk0hauLcbTd2W1G
	 nA2OsgPbP5GS8nXEETUI6gfji3pJdzkAPccqKWRerIUOdGSJB+4vWCxpOhEHJD32NAcF/
	 zoh+jaPJdMz7/Glkl/tLDr3pL6YXREneujiuvTIvHqrubQeg77LVAonVGXTaNUoujOss9
	 RPHb2z3Gq6fS8Xo+XgZsMudVcsDTLDrkGCHO0GU3VGgwDc8SCzf5VMXDr1+N5DLM0aCHZ
	 GqI0mUl96h75SE5OTB+2Vk00R2Y/yKR9OIMwUmOCDRrcv4EG7BQLJNeGCXFo5eQM+Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZW8qhcIE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE78606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZW8qhcIE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10911F000C1;
	Thu, 26 Nov 2026 21:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795729770;
	bh=lSFEsXx3nBqQNb7z98ARqhe2UkfetK4VZXZD7RYmnqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZW8qhcIErS+LXUVeFpVj0ld2SPXuD+wvfwXh/gvYQAywfoqlDu+TTQp9wI5ZboMn7
	 9vG9tetDHGxT8FZxocBb8dhcl3VjkxKJh8k4kH1lhPhSU3qA0cICupKvIY5QwQvJNl
	 NAChocBgGpRYovhmwdsz8mYsO1tozKLAzgtXVBxGTwddq+9IFNPQvtWRkZlE+wLLuH
	 opfo9o2jLJKPN97jMW1sNyOKShSKcZh7HOrBk47312nAEP1RMi+m1Ez5OPXIB7d5zf
	 EXJtaq6dPmG0yzZsSqUUXVR7r38hTCN0uxnHRqxt40VDLjUuA3aycRy1lfAXff2xso
	 3AjpN6xtXj4WA==
Date: Thu, 26 Nov 2026 22:49:25 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] string: Add missing const
Message-ID: <awipH14MBd3rxgQj@devuan>
References: <9331ce2afba1a44bb84f371581478a9ac5ee7380.1795631164.git.alx@kernel.org>
 <awhOK6BFK6Rj0ytu@ashevche-desk.local>
 <awhWDGMVswTMHjzo@devuan>
 <awib7UleD4RO4K9v@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="vyr557renkoxvxwo"
Content-Disposition: inline
In-Reply-To: <awib7UleD4RO4K9v@ashevche-desk.local>


--vyr557renkoxvxwo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] string: Add missing const
Message-ID: <awipH14MBd3rxgQj@devuan>
References: <9331ce2afba1a44bb84f371581478a9ac5ee7380.1795631164.git.alx@kernel.org>
 <awhOK6BFK6Rj0ytu@ashevche-desk.local>
 <awhWDGMVswTMHjzo@devuan>
 <awib7UleD4RO4K9v@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <awib7UleD4RO4K9v@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-26 22:51:57+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Thu, Nov 26, 2026 at 04:55:07PM +0100, Alejandro Colomar wrote:
> > > On Wed, Nov 25, 2026 at 07:26:38PM +0100, Alejandro Colomar wrote:
> > > > This pointer is derived from other const pointers.
> > >=20
> > > Constification almost always is a good thing, if this builds and work=
s as
> > > expected,
> >=20
> > Yup, I built it as part of a larger branch.  I didn't run the tests,
> > but this should be a compile-time-only thing, so I don't think it's
> > necessary.
>=20
> Running kunit test is so-o easy! Just run
>=20
> ./tools/testing/kunit/kunit.py run string
>=20
> It will fail if compilation fails, so it's 2-in-1.

I've passed the tests now; see below.


Have a lovely night!
Alex

$ git log -1
	commit 9331ce2afba1a44bb84f371581478a9ac5ee7380 (HEAD -> qchar)
	Author: Alejandro Colomar <alx@kernel.org>
	Date:   2026-11-25 19:25:10 +0100

	    string: Add missing const
	   =20
	    This pointer is derived from other const pointers.
	   =20
	    Signed-off-by: Alejandro Colomar <alx@kernel.org>
$ cp ../kunitconfig .kunitconfig
$ cat .kunitconfig
	CONFIG_KUNIT=3Dy
	CONFIG_STRING_KUNIT_TEST=3Dy
$ mkdir -p ~/tmp/const-string1
$ export TMPDIR=3D$HOME/tmp/const-string1/
$ ./tools/testing/kunit/kunit.py run "string*"
	[22:47:41] Configuring KUnit Kernel ...
	Generating .config ...
	Populating config with:
	$ make ARCH=3Dum O=3D.kunit olddefconfig
	[22:47:44] Building KUnit Kernel ...
	Populating config with:
	$ make ARCH=3Dum O=3D.kunit olddefconfig
	Building with:
	$ make all compile_commands.json scripts_gdb ARCH=3Dum O=3D.kunit --jobs=
=3D24
	../drivers/base/dd.c: In function =E2=80=98__device_set_driver_override=E2=
=80=99:
	../drivers/base/dd.c:406:20: warning: assignment discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
	  406 |                 cp =3D strnchr(s, len, '\n');
	      |                    ^

	[22:48:01] Starting KUnit Kernel (1/1)...
	[22:48:01] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	Running tests with:
	$ .kunit/linux 'kunit.filter_glob=3Dstring*' kunit.enable=3D1 mem=3D1G con=
sole=3Dtty kunit_shutdown=3Dhalt
	[22:48:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string-stream-test (12 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[22:48:02] [PASSED] string_stream_managed_init_test
	[22:48:02] [PASSED] string_stream_unmanaged_init_test
	[22:48:02] [PASSED] string_stream_managed_free_test
	[22:48:02] [PASSED] string_stream_resource_free_test
	[22:48:02] [PASSED] string_stream_line_add_test
	[22:48:02] [PASSED] string_stream_variable_length_line_test
	[22:48:02] [PASSED] string_stream_append_test
	[22:48:02] [PASSED] string_stream_append_auto_newline_test
	[22:48:02] [PASSED] string_stream_append_empty_string_test
	[22:48:02] [PASSED] string_stream_no_auto_newline_test
	[22:48:02] [PASSED] string_stream_auto_newline_test
	[22:48:02] [PASSED] string_stream_performance_test
	[22:48:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] string-s=
tream-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[22:48:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D strin=
g (29 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[22:48:02] [PASSED] string_test_memset16
	[22:48:02] [PASSED] string_test_memset32
	[22:48:02] [PASSED] string_test_memset64
	[22:48:02] [PASSED] string_test_strlen
	[22:48:02] [PASSED] string_test_strnlen
	[22:48:02] [PASSED] string_test_strchr
	[22:48:02] [PASSED] string_test_strnchr
	[22:48:02] [PASSED] string_test_strrchr
	[22:48:02] [PASSED] string_test_strspn
	[22:48:02] [PASSED] string_test_streq
	[22:48:02] [PASSED] string_test_strcmp
	[22:48:02] [PASSED] string_test_strcmp_long_strings
	[22:48:02] [PASSED] string_test_strncmp
	[22:48:02] [PASSED] string_test_strncmp_long_strings
	[22:48:02] [PASSED] string_test_strcasecmp
	[22:48:02] [PASSED] string_test_strcasecmp_long_strings
	[22:48:02] [PASSED] string_test_strncasecmp
	[22:48:02] [PASSED] string_test_strncasecmp_long_strings
	[22:48:02] [PASSED] string_test_strscpy
	[22:48:02] [PASSED] string_test_strcat
	[22:48:02] [PASSED] string_test_strncat
	[22:48:02] [PASSED] string_test_strlcat
	[22:48:02] [PASSED] string_test_strtomem
	[22:48:02] [PASSED] string_test_memtostr
	[22:48:02] [PASSED] string_test_strends
	[22:48:02] [SKIPPED] string_bench_strlen (not enabled)
	[22:48:02] [SKIPPED] string_bench_strnlen (not enabled)
	[22:48:02] [SKIPPED] string_bench_strchr (not enabled)
	[22:48:02] [SKIPPED] string_bench_strrchr (not enabled)
	[22:48:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 [PASSED] string =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
	[22:48:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string_helpers (4=
 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[22:48:02] [PASSED] test_get_size
	[22:48:02] [PASSED] test_upper_lower
	[22:48:02] [PASSED] test_unescape
	[22:48:02] [PASSED] test_escape
	[22:48:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] st=
ring_helpers =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[22:48:02] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[22:48:02] Testing complete. Ran 45 tests: passed: 41, skipped: 4
	[22:48:02] Elapsed time: 20.674s total, 3.447s configuring, 17.058s buildi=
ng, 0.128s running

--=20
<https://www.alejandro-colomar.es>

--vyr557renkoxvxwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsIqV8ACgkQ64mZXMKQ
wqmrqw/7B1etOaM39loIwDIMOJwXQZvv3+CfPSPaclD3lu52b00L6SgXRawc87GB
atnJXnyPU/T14eGdYP1KL0WrKjRaBGTTrNp7z90Bwy1NsKE8gmOA6HU8MMYXDOTs
AEUKty1bx9RguaxyDlsiY2zl1VQFR+WWitN5eOp/xcR5DtwticrSZhaVFRRfPvsz
TCzLP1o75x/SZf3/Dktizf7r0ITqB3rsHOjfNTPzb5VWOXnktzG783bBe9tdayAE
LmDlNartMYm8aO4SDobbiO3TTh9lOjGlcKKIWLvkNNQSn60WC9xgPoUDYT334fVU
3giD4xXgExMJnM0y33PGLo1auKInN8h54/+zaFAR4etV3KZfRWg9NnT/LjqVtSjv
0loFiC8tp/ah+Mb27TFSFjfoOep+Ca1XTuyE81DVPQNvMW3AaIn6648eO/XAV+ZP
Udwp+zZ0rMnR4BOk6UKLgk+waOLCYIVdrhSf7uoUA/NgrLDpPlTUqjNWse4RnWK4
jaxDXcoU3XWWtY0oRX0IUH0LiFe/Uw31gkSJ5vyT1yfUV2ltIF0PYo8DewU9eaWy
ffiM5et+tYxG02DcqcPqHJ6c3lRxk9AZq7av8nROEEdlZAeRm0xUI/w4d12bjuIJ
MWl2wGNRmTB1rjwh1Te29klG++xyiqtL279h4wkX/ELpfrlSPgQ=
=62RA
-----END PGP SIGNATURE-----

--vyr557renkoxvxwo--
