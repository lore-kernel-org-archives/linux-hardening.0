Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441443;
	b=Oya366Q8+jst2ekt0pTbgKU1vW2oLAjrHvBu0GpriSVBEIM/B0Uy3gmxw+cu/LrOH70P
	 k2uc8t9D9kWm1MzPFfeX3SUkfOIi2DD4U9IKFWky64IUAMZkQyEPGoKiNQlAShtPAc/uV
	 kBiG0HEscBjjgkUfIjYby2TtSsjtrlmNI8EJJzTcDgwYFTfCkue4mspmJGK8TPkgMI0FC
	 g2uacn+PIQbQr6PRkSy+TvniotqH5LcIrQGXe7qFZCMoPlSezfsqtR6WcMYxZRjzBPgFB
	 f2FyDW5No8qRI5shWFqVGdOljekamO+mT24zbEffFMp18YvK+iT9ua5+1bvdmtFJGSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441443;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Qgyp88LEM3OJxFzD/83Bf52sCGPR1iAeNITec+VQzik=;
	b=HrRnYVU37T38+FQDpLljLMhCr4BMPunQtwlvzla+e7sbtAyZCsSth+HCk97FoWTG+1Sr
	 SsYKUXbl5lj7VRc74Y84vmSWHJ67iqCarT+S1fOT1vYyiNBlgsJNlcjBFiI80z6HySxjN
	 oqDiHwBw2IfjOVHSKd6bWibpsuqJpK/d9xcs9jHAVqa1TTQ6ft3fsEwqfIFYYHHN5bh6n
	 +qiKz6571aVp85y2E/njTrUBiLHsXmzA7pIQ2eWfLXIlmfJ8JcruybHf0O48NhCq/58+H
	 5BNqY0M0cCFts2sjohZzyzwBnOq/VBmQrHv5CttvVP0nV7R5Qy7gG3DBGAgN1ON+Huw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=To+vR8XE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F72606A31A
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=To+vR8XE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3121F000CA;
	Mon, 23 Nov 2026 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795441443;
	bh=Qgyp88LEM3OJxFzD/83Bf52sCGPR1iAeNITec+VQzik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=To+vR8XEYjJd11rOhJ45ypgD7FIHcNrhrfCChLcqPPJ3gzu1ssOsnxO2h0T/RkAy1
	 bAO65MIFaDDlTOMijCFcmKqvHeI6Cp0S8bvWdFo55YWV8n36jiXPAIsQesQnfIOpg6
	 GaE/tCHQx6/c13DZBChJGx+emDKH+nt74MTfwUmB5uum4XPbGMGgYPoKyaqGI4DFbf
	 /Le8ZtfptUuE8Dzmjfcspqy6ES8RLee3dktMxPy8GS2BU52g94RDfsVYAIHGWBtEE3
	 jSlF/fYIina1j4HBVRTXbPrMywhYFiambyKI553Tojx60kL2/qrt8F5vgsJcqN46M2
	 wKNXkZmLEagmg==
Date: Mon, 23 Nov 2026 14:43:59 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 0/4] Add streq(3), and use it to replace confusing
 uses of strncmp(3)
Message-ID: <awRCZ8plu5l0AwyV@devuan>
References: <cover.1794767906.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="vqzikntmw323roz7"
Content-Disposition: inline
In-Reply-To: <cover.1794767906.git.alx@kernel.org>


--vqzikntmw323roz7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 0/4] Add streq(3), and use it to replace confusing
 uses of strncmp(3)
Message-ID: <awRCZ8plu5l0AwyV@devuan>
References: <cover.1794767906.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794767906.git.alx@kernel.org>

Hi!

Just a gentle ping on this patch.  It didn't seem to get any feedback,
which I take as something good (no important issues with it, I guess),
since the patch is quite simple.

I've never done a tree-wide change like this, so I don't know if it's
okay as is, or if I should split the tree-wide patch into small patches
for each subsystem (and where are the boundaries).  Any advice?


Have a lovely day!
Alex

> Date: 2026-11-15 19:46:10+0100
> From: Alejandro Colomar <alx@kernel.org>
>
> Hi!
>=20
> This is a spin off from the patch set that adds strprefix()[1].
> This patch set replaces some uses of strncmp(3), so that later the
> strprefix() patch set is easier to apply.
>=20
> [1]: <https://lore.kernel.org/linux-hardening/cover.1794667407.git.alx@ke=
rnel.org/T/>
>=20
> This patch set doesn't replace strcmp(3) with streq(3), since there are
> thousands of those, and those are less important now.  The strncmp(3)
> ones are the most important, because they can be easily confused with
> strprefix().
>=20
> Testing
> ~~~~~~~
>=20
> (I've indented the output, to better see the commands.)
>=20
> $ git log --oneline --graph v7.4-rc1^..streq1
> 	* 7994b5827030 (HEAD -> streq, tag: streq1) treewide: Use streq(3) inste=
ad of unnecessary uses of strncmp(3)
> 	* b93e0d005739 treewide: Use streq(3) instead of confusing uses of strnc=
mp(3)
> 	* 1715e2c9c8ea tools/: Add streq() to nolibc/string
> 	* ad8500a6eb0a string: Add streq()
> 	* 6628e7d4c6b2 (tag: v7.4-rc1, master) Linux 7.4-rc1
> $ cp ../kunitconfig .kunitconfig
> $ cat .kunitconfig
> 	CONFIG_KUNIT=3Dy
> 	CONFIG_STRING_KUNIT_TEST=3Dy
> $ mkdir -p ~/tmp/streq1
> $ export TMPDIR=3D$HOME/tmp/streq1/
> $ ./tools/testing/kunit/kunit.py run "string*"
> 	[18:45:10] Configuring KUnit Kernel ...
> 	Generating .config ...
> 	Populating config with:
> 	$ make ARCH=3Dum O=3D.kunit olddefconfig
> 	[18:45:14] Building KUnit Kernel ...
> 	Populating config with:
> 	$ make ARCH=3Dum O=3D.kunit olddefconfig
> 	Building with:
> 	$ make all compile_commands.json scripts_gdb ARCH=3Dum O=3D.kunit --jobs=
=3D24
> 	[18:45:30] Starting KUnit Kernel (1/1)...
> 	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	Running tests with:
> 	$ .kunit/linux 'kunit.filter_glob=3Dstring*' kunit.enable=3D1 mem=3D1G c=
onsole=3Dtty kunit_shutdown=3Dhalt
> 	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string-stream-test (1=
2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	[18:45:30] [PASSED] string_stream_managed_init_test
> 	[18:45:30] [PASSED] string_stream_unmanaged_init_test
> 	[18:45:30] [PASSED] string_stream_managed_free_test
> 	[18:45:30] [PASSED] string_stream_resource_free_test
> 	[18:45:30] [PASSED] string_stream_line_add_test
> 	[18:45:30] [PASSED] string_stream_variable_length_line_test
> 	[18:45:30] [PASSED] string_stream_append_test
> 	[18:45:30] [PASSED] string_stream_append_auto_newline_test
> 	[18:45:30] [PASSED] string_stream_append_empty_string_test
> 	[18:45:30] [PASSED] string_stream_no_auto_newline_test
> 	[18:45:30] [PASSED] string_stream_auto_newline_test
> 	[18:45:30] [PASSED] string_stream_performance_test
> 	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] string=
-stream-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D str=
ing (29 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	[18:45:30] [PASSED] string_test_memset16
> 	[18:45:30] [PASSED] string_test_memset32
> 	[18:45:30] [PASSED] string_test_memset64
> 	[18:45:30] [PASSED] string_test_strlen
> 	[18:45:30] [PASSED] string_test_strnlen
> 	[18:45:30] [PASSED] string_test_strchr
> 	[18:45:30] [PASSED] string_test_strnchr
> 	[18:45:30] [PASSED] string_test_strrchr
> 	[18:45:30] [PASSED] string_test_strspn
> 	[18:45:30] [PASSED] string_test_streq
> 	[18:45:30] [PASSED] string_test_strcmp
> 	[18:45:30] [PASSED] string_test_strcmp_long_strings
> 	[18:45:30] [PASSED] string_test_strncmp
> 	[18:45:30] [PASSED] string_test_strncmp_long_strings
> 	[18:45:30] [PASSED] string_test_strcasecmp
> 	[18:45:30] [PASSED] string_test_strcasecmp_long_strings
> 	[18:45:30] [PASSED] string_test_strncasecmp
> 	[18:45:30] [PASSED] string_test_strncasecmp_long_strings
> 	[18:45:30] [PASSED] string_test_strscpy
> 	[18:45:30] [PASSED] string_test_strcat
> 	[18:45:30] [PASSED] string_test_strncat
> 	[18:45:30] [PASSED] string_test_strlcat
> 	[18:45:30] [PASSED] string_test_strtomem
> 	[18:45:30] [PASSED] string_test_memtostr
> 	[18:45:30] [PASSED] string_test_strends
> 	[18:45:30] [SKIPPED] string_bench_strlen (not enabled)
> 	[18:45:30] [SKIPPED] string_bench_strnlen (not enabled)
> 	[18:45:30] [SKIPPED] string_bench_strchr (not enabled)
> 	[18:45:30] [SKIPPED] string_bench_strrchr (not enabled)
> 	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D [PASSED] string =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> 	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string_helpers =
(4 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	[18:45:30] [PASSED] test_get_size
> 	[18:45:30] [PASSED] test_upper_lower
> 	[18:45:30] [PASSED] test_unescape
> 	[18:45:30] [PASSED] test_escape
> 	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] =
string_helpers =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	[18:45:30] Testing complete. Ran 45 tests: passed: 41, skipped: 4
> 	[18:45:30] Elapsed time: 19.736s total, 3.261s configuring, 16.309s buil=
ding, 0.162s running
>=20
> $ make allmodconfig
> 	  HOSTCC  scripts/basic/fixdep
> 	  HOSTCC  scripts/kconfig/conf.o
> 	  HOSTCC  scripts/kconfig/confdata.o
> 	  HOSTCC  scripts/kconfig/expr.o
> 	  LEX     scripts/kconfig/lexer.lex.c
> 	  YACC    scripts/kconfig/parser.tab.[ch]
> 	  HOSTCC  scripts/kconfig/lexer.lex.o
> 	  HOSTCC  scripts/kconfig/menu.o
> 	  HOSTCC  scripts/kconfig/parser.tab.o
> 	  HOSTCC  scripts/kconfig/preprocess.o
> 	  HOSTCC  scripts/kconfig/symbol.o
> 	  HOSTCC  scripts/kconfig/util.o
> 	  HOSTLD  scripts/kconfig/conf
> 	#
> 	# configuration written to .config
> 	#
> $ time make -j24 | ts -s
> 	00:00:00   GEN     arch/x86/include/generated/asm/orc_hash.h
> 	00:00:00   UPD     arch/x86/include/generated/uapi/asm/bpf_perf_event.h
> 	00:00:00   UPD     arch/x86/include/generated/uapi/asm/errno.h
> ...
> 	00:20:03   LD [M]  net/qrtr/qrtr-tun.ko
> 	00:20:03   LD [M]  net/qrtr/qrtr-mhi.ko
> 	00:20:03   LD [M]  virt/lib/irqbypass.ko
>=20
> 	real	20m3.221s
> 	user	425m2.307s
> 	sys	25m40.226s
>=20
>=20
> Have a lovely night!
> Alex
>=20
>=20
> Alejandro Colomar (4):
>   string: Add streq()
>   tools/: Add streq() to nolibc/string
>   treewide: Use streq(3) instead of confusing uses of strncmp(3)
>   treewide: Use streq(3) instead of unnecessary uses of strncmp(3)
>=20
>  arch/arm/mach-omap2/sr_device.c                    |  8 ++++----
>  arch/m68k/sun3/prom/console.c                      |  6 +++---
>  arch/mips/bcm47xx/time.c                           |  2 +-
>  arch/powerpc/kernel/security.c                     |  2 +-
>  drivers/clk/socfpga/clk-gate-a10.c                 |  2 --
>  drivers/clk/socfpga/clk.h                          |  1 -
>  drivers/edac/amd64_edac.c                          |  2 +-
>  drivers/edac/i10nm_base.c                          |  2 +-
>  drivers/edac/igen6_edac.c                          |  2 +-
>  drivers/edac/imh_base.c                            |  2 +-
>  drivers/edac/pnd2_edac.c                           |  2 +-
>  drivers/edac/sb_edac.c                             |  2 +-
>  drivers/edac/skx_base.c                            |  2 +-
>  drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.c       |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c         |  2 +-
>  fs/ocfs2/filecheck.c                               |  6 +++---
>  include/linux/remoteproc/pruss.h                   |  2 +-
>  include/linux/string.h                             | 12 ++++++++++++
>  lib/tests/string_kunit.c                           | 13 +++++++++++++
>  net/netfilter/xt_set.c                             |  2 +-
>  sound/hda/codecs/side-codecs/tas2781_hda_i2c.c     |  2 +-
>  tools/bpf/bpftool/btf.c                            |  4 ++--
>  tools/include/nolibc/string.h                      |  2 ++
>  tools/perf/util/callchain.c                        |  8 ++++----
>  tools/perf/util/evsel.c                            |  3 +--
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c |  8 ++++----
>  tools/testing/selftests/kvm/steal_time.c           |  2 +-
>  tools/testing/selftests/kvm/x86/xen_shinfo_test.c  |  4 ++--
>  tools/testing/selftests/proc/proc-subset-pid.c     |  5 -----
>  tools/testing/selftests/proc/proc.h                |  5 -----
>  30 files changed, 65 insertions(+), 52 deletions(-)
>=20
> Range-diff against v0:
> -:  ------------ > 1:  ad8500a6eb0a string: Add streq()
> -:  ------------ > 2:  1715e2c9c8ea tools/: Add streq() to nolibc/string
> -:  ------------ > 3:  b93e0d005739 treewide: Use streq(3) instead of con=
fusing uses of strncmp(3)
> -:  ------------ > 4:  7994b5827030 treewide: Use streq(3) instead of unn=
ecessary uses of strncmp(3)
> --=20
> 2.55.0
>=20



--=20
<https://www.alejandro-colomar.es>

--vqzikntmw323roz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsEQxkACgkQ64mZXMKQ
wqmPJg/7B6aL9hx/YFrPoFUP3iVuwueeQtY3qMabm6EqfYuWAxvjAIvp/VzOv64S
dIhN4Ppq501eLVeBWGYUDT2fh32s8Cf8qVD5Lr/yZZHwx3sOVlBMbnT0QUir/GFh
AEr1FGyai/tOJlYCADxCn7uJZhHCgGq8WA79SQN7coN84UD9fCTD8H0o+rSBYbzb
Vi7oIAF0yrLXboayEAqiGpERb3fapor9KunUOsJXvROoJ/Oh3WnbsznemXDV5F8m
2oa8MYT9ZdQqKAVE2e2ePIVqVwhSoXoCgnaV2im3evFQWQwWVY/M5nm9NUwBZvL6
I8W/oMln7Rx+6420l9IkGnlO5nT2YqfxAS9ATmxaHa35PPm2naafk5kEz4GBvwBh
iBlnYtagmFBvoKKjahwajhZmjWZQcP3mL6AkC1j0Xvo9FlxTF93ISn+no+teMI8K
6TT6LAvMGhfbgKfr6jEQ78vSJ8Vf2touhcSIFUqA3ez9Y7BGxyO+02yCwMBiwV2P
QAlA9jobJli5OlD40ui6UbBck77sdkYXgVkwkxMWrrHz6Cu1brxZ0kdsdyVwsqXm
2DxFc1dOHfiIy08AstymI5SNNcXe8mu7hotKTjAKW5vvjr7l/SL0kWVRawDpS1tJ
jh1x6MwU9mMSe+cf2mT5Nwvt1f+QIZ0nu0MJWm9EslKp8ms83RQ=
=kwd8
-----END PGP SIGNATURE-----

--vqzikntmw323roz7--
