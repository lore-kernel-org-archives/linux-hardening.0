Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F804B66F1
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214842; cv=none; b=O5LpngIiTXLP+4atfKozdHdjx5GPFpoi+GMBmxuAZEJaBOclZoL1I3rpbj+MuY+PAl2LlWt4iQFNhskiLHhB321zU/h8PBRhh83IJSfdHUVMi16aTEF6VaZdyR3xjndPD1GDvsCKLwcP18eQ/uNKqtxnqCiSKCUB9WbXNhxFR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214842; c=relaxed/simple;
	bh=IszFW57i/HnjwzMJjW/uot1fa9zWynO6KIGlsW5kh7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3BRPJwR02hHSnKhRjeaTvysqkAlVqAAx8xvYxIyxTHoijeeIRq39eZRyNvvKuPhft8dAltbo6zNMdFrsW1o+JTkNMaP6hcnaGuNipfWtoZF8eoszR4dvoRHmCKBvyuw7hW8wXPjF0eI/FPoy583S/d7iKQDMGDvTqBE3cSQX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvhqBybn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvhqBybn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78A21F00898;
	Mon,  5 Oct 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214839;
	bh=BxalGXlnpxGFksdIBFwW4SKkHY7+TgD8yL79FuNj2W0=;
	h=From:To:Cc:Subject:Date;
	b=JvhqBybnJBqN7YrUTDdGPa6FG64xQl3PjNjwHtSEJWjKZg5o0hqCPPFdxAtnrRMxS
	 TLqQgjx9J9VWSbQsHUrl6zpyJO3VUb+UFt8EWf5xq6i2zhMoTM0c8uL5mhLSG2d8Mf
	 f15pl8ayGmtDAArk7dGgIaPEQ7DjHdTSczVQ788T1XDDNT8LGXpptIvroOvJwNjSef
	 RdK2otOnI7e6K+etyD4CtzscukZPlbx4JtvtKIWTz/SSF9FAuO6g2mnxRErB8FIZgv
	 CgY7DF1tCe/uYs7WSYTaD7sp3emuStmwwOZcnTvu3oZL8IFUuvX0Luh1h4Yj9R0L1e
	 3dtVsKNGO7+bQ==
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>,
	Richard Biener <rguenther@suse.de>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hubicka <hubicka@ucw.cz>,
	Uros Bizjak <ubizjak@gmail.com>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
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
Subject: [PATCH v17 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Mon,  5 Oct 2026 08:40:29 -0700
Message-ID: <20261005154028.out.839-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13531; i=kees@kernel.org; h=from:subject:message-id; bh=IszFW57i/HnjwzMJjW/uot1fa9zWynO6KIGlsW5kh7s=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHj3x0v9H+/qfJ5TqpRKk7nYe9J2vufFgj+ckwxizl2 9eblxxCO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACay4S0jw6Jwzdgfvu/mSXy7 bPT+U3jGmteLD2V/Sd2wvfqy7Las1kJGht93zFvPxGz+u9NM1i6n7eOTCK0Zv3dX1pU8iynYqbS 0jBsA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This series implements[1][2] the Linux Kernel Control Flow Integrity
ABI, which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

Regarding the recent AI policy[3], I appear to be compliant, though the
use of the Assisted-by tag doesn't distinguish between the human code and
the AI-assisted work in a single patch. I used LLMs to help me research
the GCC codebase, debug crashes, minimize PoCs, generate test cases,
construct and run my multiple architecture build and test orchestration,
and perform code reviews. Based on the feedback from Cauldron[4], I've
included the tag on every patch that carries tests.

As before, I'd really like to be in a position where more people can
test with GCC snapshots, etc, and there can be some follow-up patches
if(when) people find issues. It sounded like Andrea and Jeff were going
to hopefully get this landed in the next month? *cross fingers*

Thanks!

-Kees

Changes since v16[5]:

 - Rebase to latest master.
 - Use the target's long double mangling (from targetm.mangle_type)
   in the typeinfo selftest and gcc.dg test instead of hard-coding "e".
   (Reported by Juergen Christ; fix suggested by Andrea Pinski and Jakub
   Jelinek.)
 - RISC-V: use the pointer mode (:P) for the KCFI call patterns' address
   operands, which silences genrecog's "missing mode" warnings without
   hard-coding DImode. (Follow-up to Jeff Law's v2 and v12 feedback.)
 - ARM: fix a scan-assembler-not in kcfi-call-sharing.c that could never
   match, and make it also catch a single call using the wrong type ID.
 - Require the lto effective target in kcfi-lto-offset.c, so it is
   UNSUPPORTED rather than failing when GCC is built without LTO.
 - AArch64: drop an unused kcfi_emit_trap_with_section prototype.
 - AArch64: give the KCFI call patterns their real length (28 bytes, up
   to 36 for sibcalls with SLS hardening). They were counted as 4 bytes,
   so a conditional branch over many KCFI calls could be out of range.
 - Use a volatile function pointer in kcfi-trap-encoding.c so its call
   stays indirect (and KCFI-checked) when the testsuite is run at -O2.
 - Don't mangle top-level qualifiers on pointer parameters ("int *const
   p", "int *restrict p") or on anonymous-typedef parameters into the
   type-id: they are not part of the function type, and Clang drops them.
   Such functions trapped when called through compatible pointer types
   like "void (*)(int *)". This changes their type-ids to match Clang.
 - Add mangling tests for bool and for restrict below the top level
   (with the qualifier order), with expected strings checked against
   Clang.
 - Fix tail merging combining indirect calls that get different KCFI
   checks: calls through members of a union share one pointer value.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[2] https://github.com/KSPP/linux/issues/369
[3] https://gcc.gnu.org/ai-policy.html
[4] https://outflux.net/slides/2026/cauldron/gcc-kcfi.pdf
[5] https://inbox.sourceware.org/gcc-patches/20260902164928.stay.466-kees@kernel.org/

Kees Cook (7):
  kcfi: Introduce KCFI typeinfo mangling API
  kcfi: Add core Kernel Control Flow Integrity infrastructure
  kcfi: Add regression test suite
  x86: Add x86_64 Kernel Control Flow Integrity implementation
  aarch64: Add AArch64 Kernel Control Flow Integrity implementation
  arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
  riscv: Add RISC-V Kernel Control Flow Integrity implementation

 gcc/kcfi.h                                    |   71 ++
 gcc/kcfi.cc                                   |  650 ++++++++++
 gcc/config/aarch64/aarch64-protos.h           |    3 +
 gcc/config/arm/arm-protos.h                   |    4 +
 gcc/config/i386/i386-protos.h                 |    2 +-
 gcc/config/i386/i386.h                        |    3 +-
 gcc/config/riscv/riscv-protos.h               |    3 +
 gcc/config/aarch64/aarch64.md                 |   66 +
 gcc/config/arm/arm.md                         |   62 +
 gcc/config/i386/i386.md                       |   63 +-
 gcc/config/riscv/riscv.md                     |   76 +-
 gcc/config/aarch64/aarch64.cc                 |  127 ++
 gcc/config/arm/arm.cc                         |  217 +++-
 gcc/config/i386/i386-expand.cc                |   28 +-
 gcc/config/i386/i386.cc                       |  210 +++-
 gcc/config/riscv/riscv.cc                     |  199 +++
 gcc/doc/extend.texi                           |  141 +++
 gcc/doc/invoke.texi                           |  141 +++
 gcc/doc/tm.texi                               |   32 +
 .../gcc.dg/kcfi-compat/kcfi-compat.exp        |   87 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |   51 +
 gcc/testsuite/lib/target-supports.exp         |   14 +
 .../gcc.dg/builtin-typeinfo-bitint.c          |   82 ++
 gcc/testsuite/gcc.dg/builtin-typeinfo-c23.c   |   72 ++
 .../gcc.dg/builtin-typeinfo-errors.c          |   28 +
 gcc/testsuite/gcc.dg/builtin-typeinfo-fixed.c |   58 +
 gcc/testsuite/gcc.dg/builtin-typeinfo.c       |  429 +++++++
 .../gcc.dg/kcfi-compat/kcfi-indirect-1.h      |   26 +
 .../gcc.dg/kcfi-compat/kcfi-indirect-1_main.c |   22 +
 .../gcc.dg/kcfi-compat/kcfi-indirect-1_x.c    |   43 +
 .../gcc.dg/kcfi-compat/kcfi-indirect-1_y.c    |   40 +
 .../gcc.dg/kcfi/kcfi-aarch64-branch-range.c   |   29 +
 .../gcc.dg/kcfi/kcfi-aarch64-ilp32.c          |    7 +
 .../kcfi/kcfi-aarch64-insn-length-sls.c       |   32 +
 .../gcc.dg/kcfi/kcfi-aarch64-insn-length.c    |   38 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  142 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c |   15 +
 .../gcc.dg/kcfi/kcfi-arm-fixed-r12.c          |   15 +
 .../gcc.dg/kcfi/kcfi-arm-sibcall-r3.c         |   50 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-asm-name.c     |   16 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  168 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |   95 ++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         |  126 ++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  206 ++++
 .../gcc.dg/kcfi/kcfi-direct-call-shapes.c     |   36 +
 .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |   54 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-lto-offset.c   |   27 +
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  138 +++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  100 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   41 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   40 +
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |   64 +
 .../gcc.dg/kcfi/kcfi-patchable-incompatible.c |    7 +
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |   57 +
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |   63 +
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |   64 +
 .../gcc.dg/kcfi/kcfi-qualified-params.c       |   58 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c  |    7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t1.c         |    7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t2.c         |    7 +
 .../gcc.dg/kcfi/kcfi-riscv-fixed-t3.c         |    7 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c      |  276 +++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  144 +++
 .../gcc.dg/kcfi/kcfi-tail-merge-run.c         |   54 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-merge.c   |   36 +
 .../gcc.dg/kcfi/kcfi-trap-encoding.c          |   89 ++
 .../gcc.dg/kcfi/kcfi-trap-section-per-func.c  |   23 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   29 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c    |    7 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c    |   93 ++
 .../gcc.dg/kcfi/kcfi-x86-endbr-collision.c    |   55 +
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
 gcc/kcfi-typeinfo.cc                          | 1071 +++++++++++++++++
 gcc/opts.cc                                   |    5 +-
 gcc/rtl.def                                   |    6 +
 gcc/rtlanal.cc                                |    5 +
 gcc/selftest-run-tests.cc                     |    1 +
 gcc/target.def                                |   39 +
 gcc/toplev.cc                                 |   12 +
 gcc/tree-inline.cc                            |   10 +
 gcc/tree-ssa-tail-merge.cc                    |    6 +
 gcc/varasm.cc                                 |   44 +-
 99 files changed, 7034 insertions(+), 56 deletions(-)
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
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-branch-range.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-ilp32.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-insn-length-sls.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-insn-length.c
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
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-qualified-params.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-merge-run.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-merge.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section-per-func.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-endbr-collision.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
 create mode 100644 gcc/testsuite/gcc.dg/pch/kcfi-1.c
 create mode 100644 gcc/testsuite/gcc.dg/pch/kcfi-1.hs
 create mode 100644 gcc/kcfi-typeinfo.h
 create mode 100644 gcc/kcfi-typeinfo.cc

-- 
2.55.0

