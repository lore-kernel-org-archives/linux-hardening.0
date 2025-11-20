Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7922A7E5
	for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677274; cv=none; b=k2NL6olIHs3LJ0r72xZsJg8htkEv7tDmZIno5c0YmpsDkIl48MzGja0IMPKmAG8xA35MAr1OKF9CPfojrCm/nJqaTf77RrAegUsx1UztEvGT9L1pvq5O6wZfmpHAswsrkq0iwo9HEMTwDKEE7tzfho/uWrOQnBSpV/vjU5iNhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677274; c=relaxed/simple;
	bh=0gMpsXkHYdecXCevzcLYfY9wDVyUzgA+yJXQ5FahlIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ATSfZDXNikw4vd/2Puu/dZKx4UrHyMVyayMVR4sKmDFazyVKVOxMhaL54aNXAUgzU0YUv3bncHGqZFM/6a3jgzS0vRHdCHCBU0//bGb9xQ9HkbPNw1wSOeUwH1nYQJQgbmxRUpG4yP8zAkQEZ2LPGmaumjzsny2AIzqt2QF22o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnCoNYuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnCoNYuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C88FC4CEF1;
	Thu, 20 Nov 2025 22:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677274;
	bh=0gMpsXkHYdecXCevzcLYfY9wDVyUzgA+yJXQ5FahlIo=;
	h=From:To:Cc:Subject:Date:From;
	b=rnCoNYuVApYBclRAM9EJ5Qy5VjrV14mPHvGbvlR9RtnUt6cLHZw1kml5s3Bq9UzgO
	 540FVPOZbavP+vVSZLM35dlI+ktVzKCoO4qqCP5+0inhEpb/xUDSULeAd3x6anJxFt
	 RoShNJbwDWrsZY2AM+TyfKIkjSZXfHge8eB4GnuHlxPSflk7izmcWCOorhHe5AuXBd
	 Cro9Kuw/h5mpTf0sdxS5V9RM3GSQYoTxVlFFpzId13hk1T0uS1ZzdTW/IiRcW6xWY+
	 LRjRdsF7FWp29MJiirQyLk7/u0+RJL8RT8uCW3MJPC+QXyvXnmlubNkfoj5kUGqoux
	 taCgahdIfV7sg==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>,
	Andrew Pinski <pinskia@gmail.com>,
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
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v8 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Thu, 20 Nov 2025 14:21:05 -0800
Message-Id: <20251120222105.us.687-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8334; i=kees@kernel.org; h=from:subject:message-id; bh=0gMpsXkHYdecXCevzcLYfY9wDVyUzgA+yJXQ5FahlIo=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnyU0Lje54tDggxXf+1u23LjGvC7x/ldB+JkfkSNrPkb vaRb6b+HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOZq8/I0Fh2cwPLJBGNtKcz 7MUN3t2vUvZ7GrDdp/r/yscs4lbfwxkZLr22WJK5dcHcD0cKj3+WON/qPLc6cNqupNJyq16Dm2+ S+QE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This series implements[1][2] the Linux Kernel Control Flow Integrity
ABI, which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

I'm hoping we can land front- and middle-end and do architectures as
they also pass review. What do folks think? I'd really like to get this
in a position where more people can test with GCC snapshots, etc.

Thanks!

-Kees

Changes since v7[3], thanks to Jeff Law pointing out CI issues[4]:

- Fix various code style issues reported by contrib/check_GNU_style.py.
- Support more vector types seen with specific RISC-V targets.
- Do not inherit nor pollute DEFAULT_CFLAGS from kcfi.exp.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[2] https://github.com/KSPP/linux/issues/369
[3] https://lore.kernel.org/linux-hardening/20251117201219.makes.617-kees@kernel.org/
[4] https://github.com/ewlu/gcc-precommit-ci/issues/4115#issue-3634981101

Kees Cook (7):
  typeinfo: Introduce KCFI typeinfo mangling API
  kcfi: Add core Kernel Control Flow Integrity infrastructure
  kcfi: Add regression test suite
  x86: Add x86_64 Kernel Control Flow Integrity implementation
  aarch64: Add AArch64 Kernel Control Flow Integrity implementation
  arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
  riscv: Add RISC-V Kernel Control Flow Integrity implementation

 gcc/kcfi.h                                    |  59 ++
 gcc/kcfi.cc                                   | 696 ++++++++++++++++++
 gcc/config/aarch64/aarch64-protos.h           |   5 +
 gcc/config/arm/arm-protos.h                   |   4 +
 gcc/config/i386/i386-protos.h                 |   2 +-
 gcc/config/i386/i386.h                        |   3 +-
 gcc/config/riscv/riscv-protos.h               |   3 +
 gcc/config/aarch64/aarch64.md                 |  66 +-
 gcc/config/arm/arm.md                         |  62 ++
 gcc/config/i386/i386.md                       |  63 +-
 gcc/config/riscv/riscv.md                     |  76 +-
 gcc/config/aarch64/aarch64.cc                 | 105 +++
 gcc/config/arm/arm.cc                         | 170 +++++
 gcc/config/i386/i386-expand.cc                |  22 +-
 gcc/config/i386/i386-options.cc               |  13 +
 gcc/config/i386/i386.cc                       | 189 ++++-
 gcc/config/riscv/riscv.cc                     | 170 +++++
 gcc/doc/extend.texi                           | 137 ++++
 gcc/doc/invoke.texi                           | 127 ++++
 gcc/doc/tm.texi                               |  32 +
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  51 ++
 gcc/testsuite/lib/target-supports.exp         |  14 +
 .../gcc.dg/builtin-typeinfo-errors.c          |  28 +
 gcc/testsuite/gcc.dg/builtin-typeinfo.c       | 350 +++++++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    | 114 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c |  15 +
 .../gcc.dg/kcfi/kcfi-arm-fixed-r12.c          |  15 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       | 149 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  90 +++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         | 126 ++++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 203 +++++
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
 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c      | 276 +++++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   | 140 ++++
 .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  69 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  29 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c    |  93 +++
 .../gcc.dg/kcfi/kcfi-x86-fixed-r10.c          |  17 +
 .../gcc.dg/kcfi/kcfi-x86-fixed-r11.c          |  17 +
 .../gcc.dg/kcfi/kcfi-x86-retpoline-r11.c      |  40 +
 gcc/Makefile.in                               |   2 +
 gcc/c-family/c-common.h                       |   1 +
 gcc/flag-types.h                              |   2 +
 gcc/gimple.h                                  |  22 +
 gcc/kcfi-typeinfo.h                           |  32 +
 gcc/tree-pass.h                               |   1 +
 gcc/c-family/c-attribs.cc                     |  17 +-
 gcc/c-family/c-common.cc                      |   2 +
 gcc/c/c-parser.cc                             |  72 ++
 gcc/common.opt                                |   8 +
 gcc/df-scan.cc                                |   7 +
 gcc/doc/tm.texi.in                            |  12 +
 gcc/final.cc                                  |   3 +
 gcc/kcfi-typeinfo.cc                          | 516 +++++++++++++
 gcc/opts.cc                                   |   2 +
 gcc/passes.cc                                 |   1 +
 gcc/passes.def                                |   1 +
 gcc/rtl.def                                   |   6 +
 gcc/rtlanal.cc                                |   5 +
 gcc/target.def                                |  39 +
 gcc/toplev.cc                                 |  12 +
 gcc/tree-inline.cc                            |  10 +
 gcc/varasm.cc                                 |  37 +-
 76 files changed, 5244 insertions(+), 52 deletions(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/kcfi.cc
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
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
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
 create mode 100644 gcc/kcfi-typeinfo.h
 create mode 100644 gcc/kcfi-typeinfo.cc

-- 
2.34.1

