Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C1295D90
	for <linux-hardening@vger.kernel.org>; Tue,  4 Nov 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275288; cv=none; b=Rd0pMJWbL7+WXYintgc9v6Td2RlX+d6jOLXS3eEz/D/aWN0NCFZTHKORLpL4BOyUoHFkLs6X/UK7LZpaMaEYQfhisLquqUmBIDC9H0rxLykqR6svqk/MVp/uJ8r8RdWxIOWFEIi/C77/tjV2dhZ+yBD8nedgAS9BLdkiUP+iEKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275288; c=relaxed/simple;
	bh=ojsgCnXIB8qni4bjSFjO5057deJ/Og+a0RjgFeCsmwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pJkO5znzHjJzNo/nsZnTuSU/vs2P0X2Kx6qM+RIcikRrxwam9kuoNkwsJHKO5mTQ2hGtWNEUM/KUrP/z57Ut2QEvd7RIDLDk26pd8/PVy4QKeXP/MLwZFEKmYZTN35Je3W2EhnX5b8+SFS5d2glxzClDCIwsXbCxBNqhZR48ybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVrP23Gz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVrP23Gz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DD1C116C6;
	Tue,  4 Nov 2025 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762275287;
	bh=ojsgCnXIB8qni4bjSFjO5057deJ/Og+a0RjgFeCsmwA=;
	h=From:To:Cc:Subject:Date:From;
	b=IVrP23GzutxT+BRpnqsbCnmBpenLbnuqiDZE64FmhBXHTGaYY3v/yjYH9bTMDMKhw
	 ea9ira0m0bKijRPIW5mGE99OfjXU+/FE25aV3fuVhD0b+K0diL4ZxCacuIyHXbsdho
	 RM/m9LAUvcnYKskjcBNiE4rk1YqcOBd/EcH7qiW+Quorz7uw7DiQYZlVk2KsbfPXBq
	 DLmO8L5hEMVOg3/z+psxtkDmY+vkrOI26FpFln9pDYk5h666dmL6ajT3HjglJyCG+f
	 pXgw1TTt6/qXX9ziZpfkw1vHDC+Ox1t5VRsCeWWJjPvi2+k5g7JyaOXQZRnjEmvb70
	 YTySd8+fMBELg==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
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
Subject: [PATCH v6 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Tue,  4 Nov 2025 08:54:30 -0800
Message-Id: <20251104165430.it.619-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8124; i=kees@kernel.org; h=from:subject:message-id; bh=ojsgCnXIB8qni4bjSFjO5057deJ/Og+a0RjgFeCsmwA=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlc+qfWSDcFik7R91I+y6u+Z11n/dEdnDq3TNfzXeYNm tw3d8mjjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImstGb4w3uk0Ff7F2fjBr1V U+YeCFxyuZnp9rKFfQde/f3e6pt2KY6R4W26xfF/1byGKc+WFERMtrezCGq0XLEroDS778WTBL9 gFgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

[Added Uros Bizjak to CC for x86 backend review, I'd only added x86_64
maintainers before, not i386]

Hi,

This series implements[1][2] the Linux Kernel Control Flow Integrity
ABI, which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

Changes since v5[3]:

- Use static inline for kcfi_get_type_id_for_expanding_gimple_call.
- Document rationale for kcfi_get_type_id_for_expanding_gimple_call.
- Drop aarch64 -ffixed-$reg restrictions and tests.
- Rebase to latest master.

Thanks!

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[2] https://github.com/KSPP/linux/issues/369
[3] https://lore.kernel.org/linux-hardening/20251022181345.do.256-kees@kernel.org/

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
 gcc/config/i386/i386-protos.h                 |   1 +
 gcc/config/i386/i386.h                        |   3 +-
 gcc/config/riscv/riscv-protos.h               |   3 +
 gcc/config/aarch64/aarch64.md                 |  64 +-
 gcc/config/arm/arm.md                         |  62 ++
 gcc/config/i386/i386.md                       |  62 +-
 gcc/config/riscv/riscv.md                     |  76 +-
 gcc/config/aarch64/aarch64.cc                 | 105 +++
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
 76 files changed, 5212 insertions(+), 33 deletions(-)
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

