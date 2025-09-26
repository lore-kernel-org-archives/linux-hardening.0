Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6C15B54A
	for <linux-hardening@vger.kernel.org>; Fri, 26 Sep 2025 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855773; cv=none; b=IUB6NfV5ejKFpkBT3PdnfQeCi8H3R59RUoPJxQ83Vmzdd3PC4qwDPPJdlZoPGalj8UhIbRf+zMyuB+GvPmrqbYJsB3n7pa1h3nGpv/PDRnWdiCyELguaScISTk9F0YPX5F0Qx+vDotm6PLFSMTPTsXzrR4yWJSwFNzUJ2FaW61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855773; c=relaxed/simple;
	bh=CSihgRaHwPiAC1FL6Ql7OZ1vSHSrh2BqPxzXdNZOFKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=APDvMVJXnPvX4E6jorCz/pLnioZrYpHPk974lKY2gokzGGAomfbjToWAXHc0Zh9gQ+5ZFsNRT5BbjX3m4990LPSuWsrw6GKLmaJJy7yST8iqozJJljvd2hRKtEndFIkW1ALNWqcB5hslqR7xyl0xaLmN+HQn2w0Sa+KaS6gLh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWEVslzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWEVslzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8062AC4CEF0;
	Fri, 26 Sep 2025 03:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855772;
	bh=CSihgRaHwPiAC1FL6Ql7OZ1vSHSrh2BqPxzXdNZOFKY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZWEVslzl4E+ejFHpKvBlbUMSykuLitiZnx/Sn4HOTCWSPKR2nLx9Cia92hEIAot0e
	 hFOHwCJ3JKBOS6taRJslczByBwkTDd4CTc3Dyuz4F2G2d41K8zDm/4R31G5p7nx07H
	 d5Xqa1aYPsqUOHyPGFmeDcJDGWbts2Rth6y8EwrIEO8bcXD6nPehTkpl9dnTfRUV/8
	 8i7KvrXbYroIDpFyPfnP0JnLwZl/Cc5c2OyEcWIzMKoNOHw0FnNRskd7iMtK+YyqmT
	 pOnIRKwb3jISKuq9plOl8At7GQj1UbiRP0jIRCrj8cc7cNJrN0YTBA2R8JS74U/zmA
	 ArW1xPm4xu3YQ==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeff Law <jeffreyalaw@gmail.com>,
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
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Thu, 25 Sep 2025 20:02:42 -0700
Message-Id: <20250926023737.it.616-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8801; i=kees@kernel.org; h=from:subject:message-id; bh=CSihgRaHwPiAC1FL6Ql7OZ1vSHSrh2BqPxzXdNZOFKY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnXmMJeWDyfadVvln5q8ZxzZnrh10IVVxw6fjk22OdYQ Zyc3AP7jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIms+M/wP33CZZZCD9ntySod kR+yvk96y7boq7ebofbzXX2vlVx1fRn+Fxvduy3gYbHkWE6I56Wr0x50pt5pnGK0un1v7N3ZLB9 /sAIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Here is v4! :)

This series implements[1][2] the Linux Kernel Control Flow Integrity
ABI, which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

Changes since v3[3]:

- Clarified commit logs and kcfi.cc design docs further.
- Switched to KCFI-specific global label counter.
- Refactored patchable function entry and alignment padding calculations
  and added extensive comments.
- Moved option validation into early option processing.
- Switched arm to using eor sequence suggested by Ard Biesheuvel.
- Switched arm scratch register to ip with r3 fallback.
- Removed redundant aarch64 clobbers.
- Added KCFI availability function for regression tests.
- Refactored regression tests to use check-function-bodies.
- Split arch-specific regresion test patterns into per-arch patches (I
  don't like having fully separate test source files be per-arch since
  the conditions being tested are usually arch-agnostic).
- Added more complete function interface comments.
- Added -ffixed-$reg option checking and associated tests.
- Various other small cleanups.

Thanks!

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[2] https://github.com/KSPP/linux/issues/369
[3] https://lore.kernel.org/linux-hardening/20250913231256.make.519-kees@kernel.org/

Kees Cook (7):
  typeinfo: Introduce KCFI typeinfo mangling API
  kcfi: Add core Kernel Control Flow Integrity infrastructure
  kcfi: Add regression test suite
  x86: Add x86_64 Kernel Control Flow Integrity implementation
  aarch64: Add AArch64 Kernel Control Flow Integrity implementation
  arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
  riscv: Add RISC-V Kernel Control Flow Integrity implementation

 gcc/kcfi.h                                    |  55 ++
 gcc/kcfi.cc                                   | 670 ++++++++++++++++++
 gcc/config/aarch64/aarch64-protos.h           |   5 +
 gcc/config/arm/arm-protos.h                   |   4 +
 gcc/config/i386/i386-protos.h                 |   1 +
 gcc/config/i386/i386.h                        |   3 +-
 gcc/config/riscv/riscv-protos.h               |   3 +
 gcc/config/aarch64/aarch64.md                 |  64 +-
 gcc/config/arm/arm.md                         |  62 ++
 gcc/config/i386/i386.md                       |  62 +-
 gcc/config/riscv/riscv.md                     |  76 +-
 gcc/config/aarch64/aarch64.cc                 | 111 +++
 gcc/config/arm/arm.cc                         | 170 +++++
 gcc/config/i386/i386-expand.cc                |  22 +-
 gcc/config/i386/i386-options.cc               |  11 +
 gcc/config/i386/i386.cc                       | 128 ++++
 gcc/config/riscv/riscv.cc                     | 169 +++++
 gcc/doc/extend.texi                           | 132 ++++
 gcc/doc/invoke.texi                           | 104 +++
 gcc/doc/tm.texi                               |  31 +
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  42 ++
 gcc/testsuite/lib/target-supports.exp         |  14 +
 .../gcc.dg/builtin-typeinfo-errors.c          |  28 +
 gcc/testsuite/gcc.dg/builtin-typeinfo.c       | 350 +++++++++
 .../gcc.dg/kcfi/kcfi-aarch64-fixed-x16.c      |  17 +
 .../gcc.dg/kcfi/kcfi-aarch64-fixed-x17.c      |  17 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    | 114 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c |  15 +
 .../gcc.dg/kcfi/kcfi-arm-fixed-r12.c          |  15 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       | 149 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  90 +++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         | 126 ++++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 203 ++++++
 .../gcc.dg/kcfi/kcfi-complex-addressing.s     |   0
 .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |  54 ++
 .../gcc.dg/kcfi/kcfi-move-preservation.c      | 118 +++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     | 100 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |  39 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |  38 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  64 ++
 .../gcc.dg/kcfi/kcfi-patchable-incompatible.c |   7 +
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  54 ++
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  60 ++
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  61 ++
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t1.c         |  17 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t2.c         |  17 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t3.c         |  17 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c      | 276 ++++++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   | 140 ++++
 .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  69 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  29 +
 .../gcc.dg/kcfi/kcfi-x86-fixed-r10.c          |  17 +
 .../gcc.dg/kcfi/kcfi-x86-fixed-r11.c          |  17 +
 .../gcc.dg/kcfi/kcfi-x86-retpoline-r11.c      |  40 ++
 gcc/Makefile.in                               |   2 +
 gcc/c-family/c-common.h                       |   1 +
 gcc/flag-types.h                              |   2 +
 gcc/gimple.h                                  |  22 +
 gcc/kcfi-typeinfo.h                           |  32 +
 gcc/tree-pass.h                               |   1 +
 gcc/c-family/c-attribs.cc                     |  17 +-
 gcc/c-family/c-common.cc                      |   2 +
 gcc/c/c-parser.cc                             |  72 ++
 gcc/df-scan.cc                                |   7 +
 gcc/doc/tm.texi.in                            |  12 +
 gcc/final.cc                                  |   3 +
 gcc/kcfi-typeinfo.cc                          | 472 ++++++++++++
 gcc/opts.cc                                   |   1 +
 gcc/passes.cc                                 |   1 +
 gcc/passes.def                                |   1 +
 gcc/rtl.def                                   |   6 +
 gcc/rtlanal.cc                                |   5 +
 gcc/target.def                                |  38 +
 gcc/toplev.cc                                 |  10 +
 gcc/tree-inline.cc                            |  10 +
 gcc/varasm.cc                                 |  37 +-
 76 files changed, 5018 insertions(+), 33 deletions(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/kcfi.cc
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-fixed-x16.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-fixed-x17.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-r12.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.s
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-incompatible.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
 create mode 100644 gcc/kcfi-typeinfo.h
 create mode 100644 gcc/kcfi-typeinfo.cc

-- 
2.34.1

