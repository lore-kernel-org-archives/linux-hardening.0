Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D424EF76
	for <linux-hardening@vger.kernel.org>; Mon, 17 Nov 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763410354; cv=none; b=OK4cBMwQ4BFfk9JwA0/saPkL2b8LfJUe4K+NxYmftcn66MiOYYP/w/ZTNKpzHgP9+H858YtoLt01eVb93GLAKAqXz7I2xHd36Pge2Fpq7LvcyfacKSIiSJY+dh07CuflY5XcjetSXQajvolmSAr7YCeXufsCQIXCG7klti5qefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763410354; c=relaxed/simple;
	bh=uaVNszztuPQ6yBFsSeafB/5b8732Q0LsXA4foy7qkAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aft6yDM146+pf8vECv3yGfR6W1CTPzpbMIf06uh5AfMj/TmBIgZlX7aUptghcd6GP4ghPN9FH1OXK+ShMULUIVCFQ9iiXT6YWFbYTm1KcG2dI3WjAgXH10uU2YIjjFB3AFUcIOvhncwFMlUwGg+AmlfoOjvLfjE7bEZmbIWQhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkucJX9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkucJX9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9EEC2BC86;
	Mon, 17 Nov 2025 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763410352;
	bh=uaVNszztuPQ6yBFsSeafB/5b8732Q0LsXA4foy7qkAs=;
	h=From:To:Cc:Subject:Date:From;
	b=rkucJX9kEPj1Vo3la268KDAcG2eFVEqfiknXPiSihxmMIIRc1jSc4JxUeFvn5kBmA
	 lZdwSjMAC3/1jaPDXV32kDzPsneIyXWdpZjFooNRLvcPm/ufGaG8tdeLq4frzH1y+m
	 uGNzDEue/hTnfxeWkrhWwhox3H+vmDu6GdbTs3PhN+7upQ4twVgYx/JFff3wIUl5CD
	 PdV7NAO5qz0KHJSdyOON3sA/pbbT9EQVaF+Mm5j1t/s+ubn+nhJwnh2sl0lQKQ11GF
	 pqaiyJO3JZ0lFgiQqcEDxGTLKYWO8BbYIrP+mzMdu1mCYrPCPuJkmpCQxlMP3/KWCm
	 2I7M7TEIFQOww==
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
Subject: [PATCH v7 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Mon, 17 Nov 2025 12:12:23 -0800
Message-Id: <20251117201219.makes.617-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8674; i=kees@kernel.org; h=from:subject:message-id; bh=uaVNszztuPQ6yBFsSeafB/5b8732Q0LsXA4foy7qkAs=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnSjat9HPu8nLs3xqnz2k6S/vJ8oeZ7ofspz3fuy99xj +98y6/nHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABMJXsbwV3YJC2cMg1HOrKSC 1R6+e7UqFCvSvPYXN3r//qwaqVYwl5HhsF1tYOhR9/T3r07OY7qSN9vzpMTUoo9JuqfONhS7cgj wAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This series implements[1][2] the Linux Kernel Control Flow Integrity
ABI, which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

I'm hoping that with the front-end patch being simplified in earlier revs
of the series based on Martin's feedback, and Qing's feedback addressed
on the middle-end patch, Uros's feedback addressed in the x86 back-end,
and Andrew's feedback addressed in the aarch64 back-end, we can land
patches 1-5, and iterate from there. I haven't seen arm maintainer
feedback yet (though I addressed feedback from Ard), and I did address
Jeff's feedback on riscv though I'm unclear if it passes muster yet.

What do folks think? I'd really like to get this in a position where
more people can test with GCC snapshots, etc.

Thanks!

-Kees

Changes since v6[3]:

- Collapsed x86 KCFI helper into ix86_output_call_insn (Uros).
- Switched to using define_subst with x86 KCFI RTL (Uros).
  (notably, this wasn't a clean solution for the other architectures
  due to their PARALLEL use, so only x86 could benefit.)

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[2] https://github.com/KSPP/linux/issues/369
[3] https://lore.kernel.org/linux-hardening/20251104165430.it.619-kees@kernel.org/

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
 gcc/config/aarch64/aarch64.md                 |  64 +-
 gcc/config/arm/arm.md                         |  62 ++
 gcc/config/i386/i386.md                       |  63 +-
 gcc/config/riscv/riscv.md                     |  76 +-
 gcc/config/aarch64/aarch64.cc                 | 105 +++
 gcc/config/arm/arm.cc                         | 170 +++++
 gcc/config/i386/i386-expand.cc                |  22 +-
 gcc/config/i386/i386-options.cc               |  11 +
 gcc/config/i386/i386.cc                       | 189 ++++-
 gcc/config/riscv/riscv.cc                     | 169 +++++
 gcc/doc/extend.texi                           | 136 ++++
 gcc/doc/invoke.texi                           | 127 ++++
 gcc/doc/tm.texi                               |  32 +
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  42 ++
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
 76 files changed, 5192 insertions(+), 52 deletions(-)
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

