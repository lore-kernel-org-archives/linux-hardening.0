Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDB3043DC
	for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163338; cv=none; b=g7v40UKXWhE943EVi0ApLORWrkgTA2z+9okKLmybdVFicXiYnHfVdPILTxQt23DI9SszJOlhwH92a8lKECUNsY8TLOl/cuhBW+rz/6tZ6xoe2eXN9wNZL/kJCMJ7oLqLOJ5nHo5eFGbFHS88La0jkt7Qc/+8E/M023Bq3A2NFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163338; c=relaxed/simple;
	bh=r0yj34Wvlt2JGHbrOwD3nTqXgYIEgNSzbEmxv2iPuMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=b4HXA/maUPBuy8kershYmNl6qz5AOIo550ZQ2/Gg3DvjqmRW7HG3+aM+Vbbdjk+/MlfncPIhPrahIu2TQxtK2DTtdWC4OENELFiloAygJUwBBO3JsSdUTQwtRFjk+h9cZlzM1FR2lnk7DiBCIk5z7GlWTl5mwoKEK5/CcHwKTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbpPuoyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbpPuoyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014601F00A3A;
	Thu, 16 Jul 2026 00:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784163336;
	bh=2dSmjRUPVdq/O71fvB95taGtqfcNWl8JB9oDir55Ls0=;
	h=From:To:Cc:Subject:Date;
	b=lbpPuoyyfe6tO8zXqgjTTYAwEvPApBls6SlA3Lz2Z1mAE1xWSfI7YweHMO62Y2ZoB
	 Q53BuuoOoSVoIu8tgb5QUuirBWkgF64EyuD5TDXuHs83mbUR5lVONsWcF7Sg+gYZtW
	 sDWbsB0rwG5G4SrNL3CGsjkeQ8EJT6NdbdoHv+koW7ri0XZJQXq8Nv8Wb38hDLLHwN
	 K6g2Rlp+n6+rggxtTBC5qn/Hvj7ahzsfTMf4iilr4gb11DoAOyK1PYlgkn8U/sq7i/
	 ujTDuCSmJ2oDh/cG+kr0xPi70p4q8XT5G/j2iGMsabH8tsQyqRlQq9qLTVkaj+qLr1
	 4ZSk9hattgERw==
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund Sebastian" <sebastian.osterlund@intel.com>,
	"Constable Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v14 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Wed, 15 Jul 2026 17:55:27 -0700
Message-Id: <20260716005527.it.950-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10236; i=kees@kernel.org; h=from:subject:message-id; bh=r0yj34Wvlt2JGHbrOwD3nTqXgYIEgNSzbEmxv2iPuMU=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkROsw+UY+1J55uy9tkuZP983Vxy117Xk4Vunv+tPnP+ 0E12RtPdZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEwkh43hf4qSwf61AV/zpTeK rVYMXT2hZO2bbwEVm161255nj9xUY8fwP/aC8gLBSz8MpufMOD7nv9HOgBL9RJ7k1Q4lsbOzeIP 8mQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series implements[1][2] the Linux Kernel Control Flow Integrity
ABI, which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

I'd really like to be in a position where more people can test with GCC
snapshots, etc, and there can be some follow-up patches if people find
issues. Since I don't have commit access, who is the right person to
commit this?

Thanks!

-Kees

Changes since v13[3]:

 - Strip name encoding when forming __cfi_ preamble labels to fix build
   failure for functions with asm("name"); add new test.
 - Link .kcfi_traps to the function's own text section under
   -ffunction-sections so --gc-sections can't drop it (to match Clang);
   add new test.
 - Handle all remaining C type codes in the type-id mangler, adding
   _BitInt, _Complex, nullptr_t, _FloatN/_DecimalN, fixed-point, and opaque
   types; add new tests.
 - Remove redundant IPA type-id caching pass, instead compute type-ids on
   demand which also fixes LTO miscompile.
 - Move the KCFI label counter into final.cc and give the NOP template
   string an owned copy (xstrdup).
 - Use GTY on the cached kcfi_type_id attribute identifier.
 - Header and idiom cleanups: no <string>/config.h/system.h in headers,
   use INCLUDE_STRING, tree_to_uhwi, dyn_cast.
 - Docs: add Itanium C++ ABI link, note C/Objective-C availability, correct
   the ARM 32-bit description and the whole-program offset-ABI note;
   bump copyright to 2026.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[2] https://github.com/KSPP/linux/issues/369
[3] https://inbox.sourceware.org/gcc-patches/20260618204530.work.910-kees@kernel.org/


Kees Cook (7):
  kcfi: Introduce KCFI typeinfo mangling API
  kcfi: Add core Kernel Control Flow Integrity infrastructure
  kcfi: Add regression test suite
  x86: Add x86_64 Kernel Control Flow Integrity implementation
  aarch64: Add AArch64 Kernel Control Flow Integrity implementation
  arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
  riscv: Add RISC-V Kernel Control Flow Integrity implementation

 gcc/kcfi.h                                    |  59 ++
 gcc/kcfi.cc                                   | 632 ++++++++++++
 gcc/config/aarch64/aarch64-protos.h           |   4 +
 gcc/config/arm/arm-protos.h                   |   4 +
 gcc/config/i386/i386-protos.h                 |   2 +-
 gcc/config/i386/i386.h                        |   3 +-
 gcc/config/riscv/riscv-protos.h               |   3 +
 gcc/config/aarch64/aarch64.md                 |  56 +
 gcc/config/arm/arm.md                         |  62 ++
 gcc/config/i386/i386.md                       |  63 +-
 gcc/config/riscv/riscv.md                     |  76 +-
 gcc/config/aarch64/aarch64.cc                 | 127 +++
 gcc/config/arm/arm.cc                         | 217 +++-
 gcc/config/i386/i386-expand.cc                |  28 +-
 gcc/config/i386/i386.cc                       | 210 +++-
 gcc/config/riscv/riscv.cc                     | 199 ++++
 gcc/doc/extend.texi                           | 139 +++
 gcc/doc/invoke.texi                           | 141 +++
 gcc/doc/tm.texi                               |  32 +
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  51 +
 gcc/testsuite/lib/target-supports.exp         |  14 +
 .../gcc.dg/builtin-typeinfo-bitint.c          |  82 ++
 gcc/testsuite/gcc.dg/builtin-typeinfo-c23.c   |  72 ++
 .../gcc.dg/builtin-typeinfo-errors.c          |  28 +
 gcc/testsuite/gcc.dg/builtin-typeinfo-fixed.c |  57 ++
 gcc/testsuite/gcc.dg/builtin-typeinfo.c       | 375 +++++++
 .../gcc.dg/kcfi/kcfi-aarch64-ilp32.c          |   7 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    | 142 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c |  15 +
 .../gcc.dg/kcfi/kcfi-arm-fixed-r12.c          |  15 +
 .../gcc.dg/kcfi/kcfi-arm-sibcall-r3.c         |  50 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-asm-name.c     |  16 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       | 168 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  92 ++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         | 126 +++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 206 ++++
 .../gcc.dg/kcfi/kcfi-direct-call-shapes.c     |  36 +
 .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |  54 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-lto-offset.c   |  26 +
 .../gcc.dg/kcfi/kcfi-move-preservation.c      | 138 +++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     | 100 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |  41 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |  40 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  64 ++
 .../gcc.dg/kcfi/kcfi-patchable-incompatible.c |   7 +
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  57 ++
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  63 ++
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  64 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c  |   7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t1.c         |   7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t2.c         |   7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t3.c         |   7 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c      | 276 +++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   | 144 +++
 .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  88 ++
 .../gcc.dg/kcfi/kcfi-trap-section-per-func.c  |  23 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  29 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c    |   7 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c    |  93 ++
 .../gcc.dg/kcfi/kcfi-x86-fixed-r10.c          |   7 +
 .../gcc.dg/kcfi/kcfi-x86-fixed-r11.c          |   7 +
 .../gcc.dg/kcfi/kcfi-x86-retpoline-r11.c      |  40 +
 gcc/Makefile.in                               |   3 +
 gcc/c-family/c-common.h                       |   1 +
 gcc/flag-types.h                              |   2 +
 gcc/gimple.h                                  |  22 +
 gcc/kcfi-typeinfo.h                           |  31 +
 gcc/selftest.h                                |   1 +
 gcc/c-family/c-attribs.cc                     |  17 +-
 gcc/c-family/c-common.cc                      |   2 +
 gcc/c/c-parser.cc                             |  72 ++
 gcc/common.opt                                |   8 +
 gcc/df-scan.cc                                |   7 +
 gcc/doc/tm.texi.in                            |  12 +
 gcc/final.cc                                  |  17 +
 gcc/kcfi-typeinfo.cc                          | 967 ++++++++++++++++++
 gcc/opts.cc                                   |   5 +-
 gcc/passes.cc                                 |   1 +
 gcc/rtl.def                                   |   6 +
 gcc/rtlanal.cc                                |   5 +
 gcc/selftest-run-tests.cc                     |   1 +
 gcc/target.def                                |  39 +
 gcc/toplev.cc                                 |  12 +
 gcc/tree-inline.cc                            |  10 +
 gcc/varasm.cc                                 |  44 +-
 85 files changed, 6234 insertions(+), 56 deletions(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/kcfi.cc
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-bitint.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-c23.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-fixed.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-ilp32.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-r12.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-sibcall-r3.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-asm-name.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-lto-offset.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-incompatible.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section-per-func.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
 create mode 100644 gcc/kcfi-typeinfo.h
 create mode 100644 gcc/kcfi-typeinfo.cc

-- 
2.34.1

