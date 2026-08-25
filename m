Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5FE46C4D1
	for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702282; cv=none; b=s34O288TzowgRBsQ4WO2uzR2kxkFq9nPZ3izTSu4nlNjggeo3HlbOJNojAEPdmEZrFFiN+uc3SE5CL1nV2gTMtnRfNESiu63LHEIZjuUYkvkbXrmJIfRGxCMisA4QX3NaztRYfzAIueOq1MZ4THZrAM1+RL9E6Muteykw923Dkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702282; c=relaxed/simple;
	bh=bXxNk/+qlUoQ/KthHteYMjMKOHjYdfRl4C3gerxqBMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DZnr2QU0fptXXmJZYMx0P2+LfF+XQhegyTi0Wl4El7lDIYkl0mbwjVIIms/vy54nQDnRKe4eEGdepxprUFMGFXGThf3l/mern1ENyhP3S8RbVDlGItZS6cxcwvFibYM9rxQY4bBkT8bewhL3VooPpJ2iiowbMBLnZ51SD8HhSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNpCkNwB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNpCkNwB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455841F00A3D;
	Tue, 25 Aug 2026 23:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787702280;
	bh=yvNKgqYO/xgs9Spf9+sdD9Kzydj3mhIEuubOm6IoWcY=;
	h=From:To:Cc:Subject:Date;
	b=RNpCkNwBX5YqVCwhm69kSpaTwhx6dauTNOwcYRdstS9xSE8mfrokxhiNIBpHAzAvf
	 dWwtRccjTcoh+kywEx0CsiqK+VCet38XxRcHgreawT6+LjuuhCv4oaSChsmLDfWHDz
	 pMc8RCQmYDN1T93eNB5/39pWlmgLeIevxW19F4NPDDi1PnN/C3dayHtioJ7FPhUoCS
	 +sF+OBaeBCfvdr0DhWzpKZL5G6hL/LSLptj7bvd+2HeqFTA0h9geE746GZQTVhoQCi
	 XrA2Nh8jsp88U/sEZM/J/ulvDEV23ko8kYnhdJV/XIPyaVweOLsRN4qj3CgHzvSQCX
	 Y6Eu+SHMdYLdw==
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
Subject: [PATCH v15 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Tue, 25 Aug 2026 16:57:50 -0700
Message-Id: <20260825235748.i.456-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11546; i=kees@kernel.org; h=from:subject:message-id; bh=bXxNk/+qlUoQ/KthHteYMjMKOHjYdfRl4C3gerxqBMQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl9OkwzxEK/3g3UPCb14OE3S/v2Txs6vGI8nuypvcyur T/foS+/o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCLdVYwMJzjMdsp5lmycveMn Q2Gp6bbj/WwBCZpCt3N8GZx/Gre5M/wPz7yy7dKeNzxHzyVsuJfkXzFrozHfybbG1insPcLd6+q YAQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This series implements[1][2] the Linux Kernel Control Flow Integrity
ABI, which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

Regarding the recent AI policy[4], I appear to be compliant, though the
use of the Assisted-by tag in GCC isn't clear to me: it won't distinguish
between the human code and the AI-assisted work in a single patch? So
I left those off in this series but I seek guidance on how it should be
done. Regardless, to clarify: I have been used LLMs to help me research
the GCC codebase, debug crashes, minimize PoCs, generate test cases,
construct and run my multiple architecture build and test orchestration,
and perform code reviews.

For folks that are interested in even more details, I presented at FOSSY
about this work (and will submit it to the Cauldron CFP too); slides
here[5], and there should be video up eventually, but FOSSY hasn't
published it yet.

I'd really like to be in a position where more people can test with GCC
snapshots, etc, and there can be some follow-up patches if people find
issues. Since I don't have commit access, who is the right person to
commit this?

Thanks!

-Kees

Changes since v14[3]:

 - Rebase to latest master.
 - Add a cross-TU / cross-compiler indirect-call compat test. I used
   ALT_CC_UNDER_TEST to compare against Clang -fsanitize-kcfi-hash=FNV-1a.
 - Correctly match the existing type-id ABI (the Itanium typeinfo name was
   missing the "_ZTS" prefix *cough*).
 - Replace the per-function-type type-id attribute with a hash_map cache
   to avoiding touching shared TYPE_ATTRIBUTES.
 - Add a PCH test confirming KCFI type-ids and labels are stable across a
   precompiled header (KCFI state is all codegen-time.)
 - Various small comment tweaks/corrections.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[2] https://github.com/KSPP/linux/issues/369
[3] https://inbox.sourceware.org/gcc-patches/20260716005527.it.950-kees@kernel.org/
[4] https://gcc.gnu.org/ai-policy.html
[5] https://outflux.net/slides/2026/fossy/gcc-kcfi.pdf

Kees Cook (7):
  kcfi: Introduce KCFI typeinfo mangling API
  kcfi: Add core Kernel Control Flow Integrity infrastructure
  kcfi: Add regression test suite
  x86: Add x86_64 Kernel Control Flow Integrity implementation
  aarch64: Add AArch64 Kernel Control Flow Integrity implementation
  arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
  riscv: Add RISC-V Kernel Control Flow Integrity implementation

 gcc/kcfi.h                                    |   59 +
 gcc/kcfi.cc                                   |  622 ++++++++++
 gcc/config/aarch64/aarch64-protos.h           |    4 +
 gcc/config/arm/arm-protos.h                   |    4 +
 gcc/config/i386/i386-protos.h                 |    2 +-
 gcc/config/i386/i386.h                        |    3 +-
 gcc/config/riscv/riscv-protos.h               |    3 +
 gcc/config/aarch64/aarch64.md                 |   56 +
 gcc/config/arm/arm.md                         |   62 +
 gcc/config/i386/i386.md                       |   63 +-
 gcc/config/riscv/riscv.md                     |   76 +-
 gcc/config/aarch64/aarch64.cc                 |  127 +++
 gcc/config/arm/arm.cc                         |  217 +++-
 gcc/config/i386/i386-expand.cc                |   28 +-
 gcc/config/i386/i386.cc                       |  210 +++-
 gcc/config/riscv/riscv.cc                     |  199 ++++
 gcc/doc/extend.texi                           |  141 +++
 gcc/doc/invoke.texi                           |  141 +++
 gcc/doc/tm.texi                               |   32 +
 .../gcc.dg/kcfi-compat/kcfi-compat.exp        |   87 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |   51 +
 gcc/testsuite/lib/target-supports.exp         |   14 +
 .../gcc.dg/builtin-typeinfo-bitint.c          |   82 ++
 gcc/testsuite/gcc.dg/builtin-typeinfo-c23.c   |   72 ++
 .../gcc.dg/builtin-typeinfo-errors.c          |   28 +
 gcc/testsuite/gcc.dg/builtin-typeinfo-fixed.c |   57 +
 gcc/testsuite/gcc.dg/builtin-typeinfo.c       |  375 ++++++
 .../gcc.dg/kcfi-compat/kcfi-indirect-1.h      |   22 +
 .../gcc.dg/kcfi-compat/kcfi-indirect-1_main.c |   22 +
 .../gcc.dg/kcfi-compat/kcfi-indirect-1_x.c    |   37 +
 .../gcc.dg/kcfi-compat/kcfi-indirect-1_y.c    |   34 +
 .../gcc.dg/kcfi/kcfi-aarch64-ilp32.c          |    7 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  142 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c |   15 +
 .../gcc.dg/kcfi/kcfi-arm-fixed-r12.c          |   15 +
 .../gcc.dg/kcfi/kcfi-arm-sibcall-r3.c         |   50 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-asm-name.c     |   16 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  168 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |   92 ++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         |  126 ++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  206 ++++
 .../gcc.dg/kcfi/kcfi-direct-call-shapes.c     |   36 +
 .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |   54 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-lto-offset.c   |   26 +
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  138 +++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  100 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   41 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   40 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |   64 ++
 .../gcc.dg/kcfi/kcfi-patchable-incompatible.c |    7 +
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |   57 +
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |   63 +
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |   64 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c  |    7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t1.c         |    7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t2.c         |    7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t3.c         |    7 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c      |  276 +++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  144 +++
 .../gcc.dg/kcfi/kcfi-trap-encoding.c          |   88 ++
 .../gcc.dg/kcfi/kcfi-trap-section-per-func.c  |   23 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   29 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c    |    7 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c    |   93 ++
 .../gcc.dg/kcfi/kcfi-x86-fixed-r10.c          |    7 +
 .../gcc.dg/kcfi/kcfi-x86-fixed-r11.c          |    7 +
 .../gcc.dg/kcfi/kcfi-x86-retpoline-r11.c      |   40 +
 gcc/testsuite/gcc.dg/pch/kcfi-1.c             |   50 +
 gcc/testsuite/gcc.dg/pch/kcfi-1.hs            |   20 +
 gcc/Makefile.in                               |    3 +
 gcc/c-family/c-common.h                       |    1 +
 gcc/flag-types.h                              |    2 +
 gcc/gimple.h                                  |   22 +
 gcc/kcfi-typeinfo.h                           |   31 +
 gcc/selftest.h                                |    1 +
 gcc/c-family/c-attribs.cc                     |   17 +-
 gcc/c-family/c-common.cc                      |    2 +
 gcc/c/c-parser.cc                             |   72 ++
 gcc/common.opt                                |    8 +
 gcc/df-scan.cc                                |    7 +
 gcc/doc/tm.texi.in                            |   12 +
 gcc/final.cc                                  |   17 +
 gcc/kcfi-typeinfo.cc                          | 1009 +++++++++++++++++
 gcc/opts.cc                                   |    5 +-
 gcc/rtl.def                                   |    6 +
 gcc/rtlanal.cc                                |    5 +
 gcc/selftest-run-tests.cc                     |    1 +
 gcc/target.def                                |   39 +
 gcc/toplev.cc                                 |   12 +
 gcc/tree-inline.cc                            |   10 +
 gcc/varasm.cc                                 |   44 +-
 91 files changed, 6539 insertions(+), 56 deletions(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/kcfi.cc
 create mode 100644 gcc/testsuite/gcc.dg/kcfi-compat/kcfi-compat.exp
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-bitint.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-c23.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-fixed.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1.h
 create mode 100644 gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_main.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_x.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_y.c
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
 create mode 100644 gcc/testsuite/gcc.dg/pch/kcfi-1.c
 create mode 100644 gcc/testsuite/gcc.dg/pch/kcfi-1.hs
 create mode 100644 gcc/kcfi-typeinfo.h
 create mode 100644 gcc/kcfi-typeinfo.cc

-- 
2.34.1

