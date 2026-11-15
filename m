Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794768374;
	b=r5VcMOk42k4eSF3j1tJ+8ZJGWsN4yTM6N9FPzTuiK8uiBndPEGmAqKg+/Rq6nRAzFbcn
	 2Cx2Z+d70QouWHbHLdndY2D5136b1SKk7eDH35hu1VVgUK5zEUXFkmPBYw9M5Nz7NRSZh
	 ya5nVj/lWxpm4CYftetEJ64hY0hZnle7sWgYTIE/vYXd9F+X+XiL4VrA4mKsp0N6IrEGT
	 LbPYge7hebvUfxFMW7eC/dYMsf2Hz7xJOJXlmrHi9iiuzKO625YJ4okn3hCwT1KbMTdo8
	 /tePcIkwwCxj7B6Q1krZVSM3Lb+gPCAMoht8DQZPk9dOmO3AIqeC14TasZB2LQYfSbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794768374;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=GUuyEMTTM+/poOFQwgVgfpQ+zxFRSjMbNIfI4Y/RLmY=;
	b=i1lai/NverII3tacyoYcmV7ul3728+uROCw+1qj+vaUdTL7VmxltddO6/lOomXxfUWs0
	 Rv3WdZS1VgF7EW8Va7ijHobSsBG3akSZb7u29Aq/BCH5asmjK7PNV9UIwwdADsh3gg5EX
	 UQFT0JXIlWuEI/eRSujNqFCOC0smypwYgnbbHHgfxzSLavxWPREprtu/TGm5ver+sLHpv
	 UXmFevIlnvxfDFDxL+PBeRS74sBAFt1os24oJ9l2fAS8WIipZFaw3ulPdKOWlRDUvh7rt
	 k+KSlPpVQZ7ZkwXkuX88fklvktLE1/T42s6YdSKhVWs1Ho7XNBk9iLNKNqEPtdRbXMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SbKZ3zw9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E963606A31D
	for <linux-hardening@vger.kernel.org>; Sun, 15 Nov 2026 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SbKZ3zw9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CDC1F000C4;
	Sun, 15 Nov 2026 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794768373;
	bh=GUuyEMTTM+/poOFQwgVgfpQ+zxFRSjMbNIfI4Y/RLmY=;
	h=Date:From:To:Cc:Subject;
	b=SbKZ3zw9GoDDHenOY484AyIZUBotLRSke05qx8BwENwUICbXWUxzVEL4FNKY5bzdx
	 MJxy3Shz75TAurZfEGhxqBbRYH2ofE+VWXs7ZtNp9uxl7vCY+riSM3jLRRZ0i1GDSX
	 YRF5UuLpTSwjeqTQPEl55/tX+E5LSrjJv/W7CSHVW+iml80ABaVFF5NeXFO1NgPOp7
	 Zgdazgj18pOua5P+SIxTffNnT4yehj4G17oqmey3ooakYjcDj8BuFy6+4JlUCCy1Z+
	 M+AnYVyjdvhhyb2bCsI0XkwzTo6V1kRSHcVxX9QsWX7c4sXzNNyTldKWRQGDBAFB8z
	 9QKw6dPGeu7KA==
Date: Sun, 15 Nov 2026 19:46:10 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 0/4] Add streq(3), and use it to replace confusing uses of
 strncmp(3)
Message-ID: <cover.1794767906.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
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
	protocol="application/pgp-signature"; boundary="zyttii2gfopbzyo3"
Content-Disposition: inline


--zyttii2gfopbzyo3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 0/4] Add streq(3), and use it to replace confusing uses of
 strncmp(3)
Message-ID: <cover.1794767906.git.alx@kernel.org>
MIME-Version: 1.0

Hi!

This is a spin off from the patch set that adds strprefix()[1].
This patch set replaces some uses of strncmp(3), so that later the
strprefix() patch set is easier to apply.

[1]: <https://lore.kernel.org/linux-hardening/cover.1794667407.git.alx@kern=
el.org/T/>

This patch set doesn't replace strcmp(3) with streq(3), since there are
thousands of those, and those are less important now.  The strncmp(3)
ones are the most important, because they can be easily confused with
strprefix().

Testing
~~~~~~~

(I've indented the output, to better see the commands.)

$ git log --oneline --graph v7.4-rc1^..streq1
	* 7994b5827030 (HEAD -> streq, tag: streq1) treewide: Use streq(3) instead=
 of unnecessary uses of strncmp(3)
	* b93e0d005739 treewide: Use streq(3) instead of confusing uses of strncmp=
(3)
	* 1715e2c9c8ea tools/: Add streq() to nolibc/string
	* ad8500a6eb0a string: Add streq()
	* 6628e7d4c6b2 (tag: v7.4-rc1, master) Linux 7.4-rc1
$ cp ../kunitconfig .kunitconfig
$ cat .kunitconfig
	CONFIG_KUNIT=3Dy
	CONFIG_STRING_KUNIT_TEST=3Dy
$ mkdir -p ~/tmp/streq1
$ export TMPDIR=3D$HOME/tmp/streq1/
$ ./tools/testing/kunit/kunit.py run "string*"
	[18:45:10] Configuring KUnit Kernel ...
	Generating .config ...
	Populating config with:
	$ make ARCH=3Dum O=3D.kunit olddefconfig
	[18:45:14] Building KUnit Kernel ...
	Populating config with:
	$ make ARCH=3Dum O=3D.kunit olddefconfig
	Building with:
	$ make all compile_commands.json scripts_gdb ARCH=3Dum O=3D.kunit --jobs=
=3D24
	[18:45:30] Starting KUnit Kernel (1/1)...
	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	Running tests with:
	$ .kunit/linux 'kunit.filter_glob=3Dstring*' kunit.enable=3D1 mem=3D1G con=
sole=3Dtty kunit_shutdown=3Dhalt
	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string-stream-test (12 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[18:45:30] [PASSED] string_stream_managed_init_test
	[18:45:30] [PASSED] string_stream_unmanaged_init_test
	[18:45:30] [PASSED] string_stream_managed_free_test
	[18:45:30] [PASSED] string_stream_resource_free_test
	[18:45:30] [PASSED] string_stream_line_add_test
	[18:45:30] [PASSED] string_stream_variable_length_line_test
	[18:45:30] [PASSED] string_stream_append_test
	[18:45:30] [PASSED] string_stream_append_auto_newline_test
	[18:45:30] [PASSED] string_stream_append_empty_string_test
	[18:45:30] [PASSED] string_stream_no_auto_newline_test
	[18:45:30] [PASSED] string_stream_auto_newline_test
	[18:45:30] [PASSED] string_stream_performance_test
	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] string-s=
tream-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D strin=
g (29 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[18:45:30] [PASSED] string_test_memset16
	[18:45:30] [PASSED] string_test_memset32
	[18:45:30] [PASSED] string_test_memset64
	[18:45:30] [PASSED] string_test_strlen
	[18:45:30] [PASSED] string_test_strnlen
	[18:45:30] [PASSED] string_test_strchr
	[18:45:30] [PASSED] string_test_strnchr
	[18:45:30] [PASSED] string_test_strrchr
	[18:45:30] [PASSED] string_test_strspn
	[18:45:30] [PASSED] string_test_streq
	[18:45:30] [PASSED] string_test_strcmp
	[18:45:30] [PASSED] string_test_strcmp_long_strings
	[18:45:30] [PASSED] string_test_strncmp
	[18:45:30] [PASSED] string_test_strncmp_long_strings
	[18:45:30] [PASSED] string_test_strcasecmp
	[18:45:30] [PASSED] string_test_strcasecmp_long_strings
	[18:45:30] [PASSED] string_test_strncasecmp
	[18:45:30] [PASSED] string_test_strncasecmp_long_strings
	[18:45:30] [PASSED] string_test_strscpy
	[18:45:30] [PASSED] string_test_strcat
	[18:45:30] [PASSED] string_test_strncat
	[18:45:30] [PASSED] string_test_strlcat
	[18:45:30] [PASSED] string_test_strtomem
	[18:45:30] [PASSED] string_test_memtostr
	[18:45:30] [PASSED] string_test_strends
	[18:45:30] [SKIPPED] string_bench_strlen (not enabled)
	[18:45:30] [SKIPPED] string_bench_strnlen (not enabled)
	[18:45:30] [SKIPPED] string_bench_strchr (not enabled)
	[18:45:30] [SKIPPED] string_bench_strrchr (not enabled)
	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 [PASSED] string =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D string_helpers (4=
 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[18:45:30] [PASSED] test_get_size
	[18:45:30] [PASSED] test_upper_lower
	[18:45:30] [PASSED] test_unescape
	[18:45:30] [PASSED] test_escape
	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] st=
ring_helpers =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[18:45:30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[18:45:30] Testing complete. Ran 45 tests: passed: 41, skipped: 4
	[18:45:30] Elapsed time: 19.736s total, 3.261s configuring, 16.309s buildi=
ng, 0.162s running

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
	00:20:03   LD [M]  net/qrtr/qrtr-tun.ko
	00:20:03   LD [M]  net/qrtr/qrtr-mhi.ko
	00:20:03   LD [M]  virt/lib/irqbypass.ko

	real	20m3.221s
	user	425m2.307s
	sys	25m40.226s


Have a lovely night!
Alex


Alejandro Colomar (4):
  string: Add streq()
  tools/: Add streq() to nolibc/string
  treewide: Use streq(3) instead of confusing uses of strncmp(3)
  treewide: Use streq(3) instead of unnecessary uses of strncmp(3)

 arch/arm/mach-omap2/sr_device.c                    |  8 ++++----
 arch/m68k/sun3/prom/console.c                      |  6 +++---
 arch/mips/bcm47xx/time.c                           |  2 +-
 arch/powerpc/kernel/security.c                     |  2 +-
 drivers/clk/socfpga/clk-gate-a10.c                 |  2 --
 drivers/clk/socfpga/clk.h                          |  1 -
 drivers/edac/amd64_edac.c                          |  2 +-
 drivers/edac/i10nm_base.c                          |  2 +-
 drivers/edac/igen6_edac.c                          |  2 +-
 drivers/edac/imh_base.c                            |  2 +-
 drivers/edac/pnd2_edac.c                           |  2 +-
 drivers/edac/sb_edac.c                             |  2 +-
 drivers/edac/skx_base.c                            |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.c       |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c         |  2 +-
 fs/ocfs2/filecheck.c                               |  6 +++---
 include/linux/remoteproc/pruss.h                   |  2 +-
 include/linux/string.h                             | 12 ++++++++++++
 lib/tests/string_kunit.c                           | 13 +++++++++++++
 net/netfilter/xt_set.c                             |  2 +-
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c     |  2 +-
 tools/bpf/bpftool/btf.c                            |  4 ++--
 tools/include/nolibc/string.h                      |  2 ++
 tools/perf/util/callchain.c                        |  8 ++++----
 tools/perf/util/evsel.c                            |  3 +--
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c |  8 ++++----
 tools/testing/selftests/kvm/steal_time.c           |  2 +-
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c  |  4 ++--
 tools/testing/selftests/proc/proc-subset-pid.c     |  5 -----
 tools/testing/selftests/proc/proc.h                |  5 -----
 30 files changed, 65 insertions(+), 52 deletions(-)

Range-diff against v0:
-:  ------------ > 1:  ad8500a6eb0a string: Add streq()
-:  ------------ > 2:  1715e2c9c8ea tools/: Add streq() to nolibc/string
-:  ------------ > 3:  b93e0d005739 treewide: Use streq(3) instead of confu=
sing uses of strncmp(3)
-:  ------------ > 4:  7994b5827030 treewide: Use streq(3) instead of unnec=
essary uses of strncmp(3)
--=20
2.55.0


--zyttii2gfopbzyo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr5/esACgkQ64mZXMKQ
wqkKhQ//bMbWni0PwLeRy9VgGMtfE3LzEgxUM0sJMIWxEQ9CYFo4hv8Yj2sz8dO6
ZnAASYBlhw2DBcRdZE5alKlbYKyN+wAp6umOgEMpbbBleFmnYi2NMnSf0F4MSomt
OIkVhsCOX93ibOylvRpn+93K67ixPhBmuqZEFi9aav4tkExxdenFullz2UkrBnC5
5U0anWzROoJVt8OViq2RooaaaM3nkR6Kwz/VuQZm2MFyTA01Z5c73B9Wr/A1EXwT
a4npPMZe999lJOrQTiB+OS3n+7arNEkxWf0F4o+36FOT25OT3C7hOWBfUnoqhkK5
fvFq8LHXH1Se1dh5nJSC6XUSpGqJwiNoBmn9RqVIMLagXs0kX6uQokvuagXpFHhl
dSYKNoK5sh26ydD2zLhiJA+kZK1hY6VsLHOIff1PMNp3V1OZ3kICu8RokhM6/H2l
clasq3aCyjaD9bYXNikWsAZC3XgH+ivH0W4ArVoDUHvqr1a8X8Dm6vLG4gS51EQy
FKjnZgIVIlai8HZTHC+kyyFCiLN+RQbZcysIMi1LZjO0YUBymOpeneYa/IMt6cks
HVv7sYmLftIntrhN8oJi3BlzdfU8OJSTmGjRtAGk0ScU0etAdSzlGajTl0Ft8Rl6
rYGUvwpxXnvaLD4LxBi1YxPSKRmzQCbj3Yer/u09eIP5U/s7tjA=
=xXtF
-----END PGP SIGNATURE-----

--zyttii2gfopbzyo3--
