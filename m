Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A4944F
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805845; cv=none; b=WY7STjNkw8/RQspUfE7vaND3BlqOgf4vJZbmmOnpT4a/zc/2/p4fQZKN5fJ5c7ps/luDfZBupVw0pC/TVMpH7YJd0qa1GQRMEbq0GWIxhhU9jZiwQbo2cB+3CfSBx/pA8/MraCX3TAREODU6lg/gfKPC/g7zlq3OfV3u30Tawc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805845; c=relaxed/simple;
	bh=VtQXeJdU83W6zrlgKFfts+4mBtpQyXe1OLyl81OfcjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RefG22ukb4ei+Yz1PenJfxGB2xAiJEEuWEX1T1+ixFQYaQTEdHuD2CRHUaWUeUpkV17cE6oWOF7iQb8FfdQGMAbFWfqaD+5tKt/8MC7Dx1/QoMHmTe7ojgwDUfSncmS+fjBt85EvOPQvDI2d0VdXkAL0EA2D8rYyjKC2MUMs8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opLo2Rt6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opLo2Rt6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452EDC4CEEB;
	Sat, 13 Sep 2025 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757805845;
	bh=VtQXeJdU83W6zrlgKFfts+4mBtpQyXe1OLyl81OfcjE=;
	h=From:To:Cc:Subject:Date:From;
	b=opLo2Rt66dpvZAOWmErBXZTxpZA/GEQxxitameL+lmusq9byY8b6VWVPKaYfMf8uW
	 515fVzb5jbnlFvDzb1iOxAxbBtvOvgjfj3BTgD7PrLbESA354PnsCGbOO5+gNJ8KQR
	 5E9JPf8HdqT+Fk4eet0RBlO/NjXdkEcaSp7+kTjbqScGFdcXTxUVBRygQWC718jDVc
	 5POQrHsOgTq5JOyclUb0/jHF2zFkBil2tPxywm1sLGT6YjQLMt+7M3ES3Q9FTyTVOO
	 oscFJPCYFGey9p3wc45Rlcwn93EYR7TOAOhq9CJsQZCi175fTdfi2824muuZlubJCz
	 kdy+7I7xICjRg==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v3 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Sat, 13 Sep 2025 16:23:56 -0700
Message-Id: <20250913231256.make.519-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7358; i=kees@kernel.org; h=from:subject:message-id; bh=VtQXeJdU83W6zrlgKFfts+4mBtpQyXe1OLyl81OfcjE=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlH//K/trQ97LJH++wU1wlvPPu8XE85ma27WHLMI/pg/ sJVSa7/O0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZSJMHIsIDBvCBkFtucYKGF KR6Fdy+Hf5HnXCCw6YBW+pKJczk+nGBkmONkpDJ3i2nr99yNZ7fWhjAzyZw+kuVx44kFs/LjwxX svAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi!

Here is v3, which has continued to evolve a lot from v2[1].

This series implements[2][3] the Linux Kernel Control Flow Integrity
ABI, which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

Changes since v2:

- Refactored mangling to provide actual builtins, making it SO much
  easier to test. This is good not just for KCFI but also for coming
  type-aware allocators that need to have a stable value (32-bit
  hash) to represent C types.

- Consolidated DECL vs TYPE attributes for KCFI type_id, allowing
  for the removal of all the GIMPLE type wrapping and the GIMPLE
  passes entirely.

- Tightened testsuite to be much more target and option aware.

- Support nocf_check to disable preamble generation.

- Passes contrib/check_GNU_style.py (with some clear exceptions).

- Added more documentation.

- General cleanups and comment clarifications.

Thanks!

-Kees

[1] https://lore.kernel.org/linux-hardening/20250905001157.it.269-kees@kernel.org/
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[3] https://github.com/KSPP/linux/issues/369

Kees Cook (7):
  typeinfo: Introduce KCFI typeinfo mangling API
  kcfi: Add core Kernel Control Flow Integrity infrastructure
  x86: Add x86_64 Kernel Control Flow Integrity implementation
  aarch64: Add AArch64 Kernel Control Flow Integrity implementation
  arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
  riscv: Add RISC-V Kernel Control Flow Integrity implementation
  kcfi: Add regression test suite

 gcc/kcfi.h                                    |  52 ++
 gcc/kcfi.cc                                   | 601 ++++++++++++++++++
 gcc/Makefile.in                               |   2 +
 gcc/c-family/c-common.h                       |   1 +
 gcc/config/aarch64/aarch64-protos.h           |   5 +
 gcc/config/arm/arm-protos.h                   |   4 +
 gcc/config/i386/i386-protos.h                 |   1 +
 gcc/config/i386/i386.h                        |   3 +-
 gcc/config/riscv/riscv-protos.h               |   3 +
 gcc/flag-types.h                              |   2 +
 gcc/gimple.h                                  |  22 +
 gcc/kcfi-typeinfo.h                           |  32 +
 gcc/tree-pass.h                               |   1 +
 .../gcc.dg/builtin-typeinfo-errors.c          |  28 +
 gcc/testsuite/gcc.dg/builtin-typeinfo.c       | 350 ++++++++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  72 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       | 108 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  84 +++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         | 136 ++++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 135 ++++
 .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |  54 ++
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  55 ++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     | 100 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |  39 ++
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |  48 ++
 .../gcc.dg/kcfi/kcfi-patchable-basic.c        |  70 ++
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  62 ++
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  51 ++
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  60 ++
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  60 ++
 .../gcc.dg/kcfi/kcfi-pic-addressing.c         | 104 +++
 .../gcc.dg/kcfi/kcfi-retpoline-r11.c          |  50 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c      | 151 +++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   | 142 +++++
 .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  54 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  41 ++
 gcc/c-family/c-attribs.cc                     |  17 +-
 gcc/c-family/c-common.cc                      |   2 +
 gcc/c/c-parser.cc                             |  72 +++
 gcc/config/aarch64/aarch64.cc                 | 116 ++++
 gcc/config/aarch64/aarch64.md                 |  64 +-
 gcc/config/arm/arm.cc                         | 146 +++++
 gcc/config/arm/arm.md                         |  62 ++
 gcc/config/i386/i386-expand.cc                |  22 +-
 gcc/config/i386/i386.cc                       | 130 ++++
 gcc/config/i386/i386.md                       |  62 +-
 gcc/config/riscv/riscv.cc                     | 159 +++++
 gcc/config/riscv/riscv.md                     |  76 ++-
 gcc/df-scan.cc                                |   7 +
 gcc/doc/extend.texi                           | 132 ++++
 gcc/doc/invoke.texi                           | 100 +++
 gcc/doc/tm.texi                               |  31 +
 gcc/doc/tm.texi.in                            |  12 +
 gcc/final.cc                                  |   3 +
 gcc/kcfi-typeinfo.cc                          | 475 ++++++++++++++
 gcc/opts.cc                                   |   1 +
 gcc/passes.cc                                 |   1 +
 gcc/passes.def                                |   1 +
 gcc/rtl.def                                   |   6 +
 gcc/rtlanal.cc                                |   5 +
 gcc/target.def                                |  38 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  64 ++
 gcc/toplev.cc                                 |  10 +
 gcc/tree-inline.cc                            |  10 +
 gcc/varasm.cc                                 |  37 +-
 65 files changed, 4611 insertions(+), 33 deletions(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/kcfi.cc
 create mode 100644 gcc/kcfi-typeinfo.h
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-basic.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-pic-addressing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-retpoline-r11.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
 create mode 100644 gcc/kcfi-typeinfo.cc
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp

-- 
2.34.1

