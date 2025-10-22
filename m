Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0166C336EC2
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157364; cv=none; b=VEPuykjV5/vFL5Dv83T0rn04ROjs/bmCbFEIH8m90+Px6BUOn5U34E8H0nwx20E4vVxEvkXLjwmOeKpGkpJuv4cFN6OKEu0aLLliE/CfPB5IJKiurHmmdf7B62zXL63Tim8GD34hb3iqyllXgApq9l+DPRhuDBWc0kJtYP98XwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157364; c=relaxed/simple;
	bh=g8MCTYQWZWO3boDhs94ShYXK9k9YCHqESryZ0BaaB34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nKh6EjuCN3f5+iY8C0fNu//ctt5hpJ/ZO34uV0GUHov7JGqSGSlk4xH0qtqsHgjwaJbQTOBlYKqg8rwSn02ANsILIph1nGkOJdCeVk7GNkbO/JhA638DV5K4mGBRpTKNM8iAPNa0gQ+L+o2DjFjNUN9JejLKmpynu88xWL1jGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzQBAUGL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzQBAUGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED7EC4CEE7;
	Wed, 22 Oct 2025 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761157363;
	bh=g8MCTYQWZWO3boDhs94ShYXK9k9YCHqESryZ0BaaB34=;
	h=From:To:Cc:Subject:Date:From;
	b=IzQBAUGL8E/C0RWIhMsltcjSWc+WhW2ACgvBGhD0OMuRiHXRF5KFvMMtS8o6cIKyf
	 mME3t/o23iiwUFJBWwJpkTkcWL0YN21hhdgFGw38+l0i6OtZIM+H2LF59fp+SNSFPL
	 axh9F7iIaMqPfSrJ291HYzDYNgtQZSn2eeknANAhl+6r+Gdl7vF+nXhLQgIsFfngFw
	 PwVgdFx+TzywJAZfHzGZuYfoeXfEO5OFAxcQrwyAyZAwybnNXbPlAs6cuqx+c7dR1N
	 /caUoRe2ZMW4RG384RTQJc24yWZmqos+bFNo7ee39il6WXI22vLftZd/2fr0eKRRmp
	 /4OHwAYixIRuQ==
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
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Wed, 22 Oct 2025 11:22:34 -0700
Message-Id: <20251022181345.do.256-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8426; i=kees@kernel.org; h=from:subject:message-id; bh=g8MCTYQWZWO3boDhs94ShYXK9k9YCHqESryZ0BaaB34=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk/Fd5FsnTfnL/8qHyaYsl15YyZQWw8e30/rzzP4M15s SHUSNO2o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCIBYgz/q3ZxxknWTG9PFpYr 2/0rke9V5E2J/Hc7ku4uUwma+/ACByPDi+1Sr3idEg+W10yRsbmgmDLxzgKPM1tqXF+brnWPaLn HAQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series implements[1][2] the Linux Kernel Control Flow Integrity
ABI, which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

Changes since v4[3]:

- Use accessors instead of globals for label counter, typeid offset.
- Avoid using IDENTIFIER_POINTER for lookup_attribute.
- Generally improve comments all over.
- Update "patchable_function_entry” attribute docs for -fsanitize=kcfi.
- Add "arity" support, needed for FineIBT+BHI, thanks to Sebastian Osterlund.
- Update commit logs.
- Rebase to latest master.

Thanks!

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[2] https://github.com/KSPP/linux/issues/369
[3] https://lore.kernel.org/linux-hardening/20250926023737.it.616-kees@kernel.org/

Kees Cook (7):
  typeinfo: Introduce KCFI typeinfo mangling API
  kcfi: Add core Kernel Control Flow Integrity infrastructure
  kcfi: Add regression test suite
  x86: Add x86_64 Kernel Control Flow Integrity implementation
  aarch64: Add AArch64 Kernel Control Flow Integrity implementation
  arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
  riscv: Add RISC-V Kernel Control Flow Integrity implementation

 gcc/kcfi.h                                    |  56 ++
 gcc/kcfi.cc                                   | 691 ++++++++++++++++++
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
 gcc/config/i386/i386.cc                       | 192 +++++
 gcc/config/riscv/riscv.cc                     | 169 +++++
 gcc/doc/extend.texi                           | 136 ++++
 gcc/doc/invoke.texi                           | 127 ++++
 gcc/doc/tm.texi                               |  32 +
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
 gcc/common.opt                                |   4 +
 gcc/df-scan.cc                                |   7 +
 gcc/doc/tm.texi.in                            |  12 +
 gcc/final.cc                                  |   3 +
 gcc/kcfi-typeinfo.cc                          | 485 ++++++++++++
 gcc/opts.cc                                   |   2 +
 gcc/passes.cc                                 |   1 +
 gcc/passes.def                                |   1 +
 gcc/rtl.def                                   |   6 +
 gcc/rtlanal.cc                                |   5 +
 gcc/target.def                                |  39 +
 gcc/toplev.cc                                 |  10 +
 gcc/tree-inline.cc                            |  10 +
 gcc/varasm.cc                                 |  37 +-
 78 files changed, 5244 insertions(+), 33 deletions(-)
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
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
 create mode 100644 gcc/kcfi-typeinfo.h
 create mode 100644 gcc/kcfi-typeinfo.cc

-- 
2.34.1

