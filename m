Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD8027E1DC
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761229; cv=none; b=qOGjDP0zhtTIqt1kghdKy4NLmlNaOxHA1BnyXjaQIqyiwOWyvsxqrhvKJVqHPDiCah2a3FinDY/DcS1AlntY1FZ7dgLXNELUb0wBPafGXjPR1h3cyctHxlUX3DfIK/sHY4ayZHU6Ml+43yBYe4k+rZwLu2CO9AT6ouadm6gZSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761229; c=relaxed/simple;
	bh=ZIOSlVHZDsu4jjfMfZhTZZDr9zCAHK5WsaijnfJuzHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qDrFWQhhS261gZu6kpnoF8O0nOwwX/VfcFBnU6jV6uPCffuGG1oZuz+F/SPGyOSnH8Ps/TlQrvFtqFMARLaGf8giiVOueyp7KTbot887tgqLR1DgmEyTM6EKl7NaRlDnkgz3vAhb9RVGvbmxw7JKKQxKI3JK02pz4f11c7CS8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G47PCetX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G47PCetX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E0CC4CEF4;
	Thu, 21 Aug 2025 07:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755761229;
	bh=ZIOSlVHZDsu4jjfMfZhTZZDr9zCAHK5WsaijnfJuzHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=G47PCetX376zURypl+x3PNKqFfisogXerV7Pos6t68+dFV83PhmU7MjiGcwJPuj/T
	 BpwLGG3J+AyzxfrIST1cc0IzSybodgCW2pL3hw3ABnhjYMArmMm5eMwyNr1i82y8Rr
	 9Rn+24QnGPqrbDWayho8hhL8zvXkrMNrUcFHKrxY8+6JiwEe36fPHNTuwqZ+dr498x
	 z78RmNl/2u2vZSZWBwK8hOsPnBwzN/CgcKTFwm9qKkyyu6KBHRJub9AorsIP61nHB/
	 Ia8vcuMRZvNGf/TO9KxIlSnE0rD/9JJ6xmlKO6H/ZPvryLc/1NNkKACKc9BLYSriCl
	 atCd6vDd8Nvug==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Li <ashimida.1990@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Thu, 21 Aug 2025 00:26:33 -0700
Message-Id: <20250821064202.work.893-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Repeating the start of the 3rd (core kcfi) patch's commit log:

    This series implements the Linux Kernel Control Flow Integrity ABI,
    which provides a function prototype based forward edge control flow
    integrity protection by instrumenting every indirect call to check for
    a hash value before the target function address. If the hash at the call
    site and the hash at the target do not match, execution will trap.

    Just to set expectations, this is an RFC because this is my first time
    working on most of the affected areas in GCC, and it is likely I have
    missed really obvious stuff, or gone about doing things in very wrong
    ways. I tried to find the best way to do stuff, but I was left with many
    questions. :) All that said, this works for x86_64 and aarch64 Linux
    kernels. (I have implemented riscv64 as well, but I lack a viable test
    environment -- I am working on this still.)

I tried to get comments and code style into reasonable shape so as
to not distract horribly from the actual implementation details, but
I suspect I'm still missing some correct style in places. The commit
logs are not in proper ChangeLog format either. I am planning to get
that sorted once this series has gotten some review and I've actually
got code in the right places.

I gave up on trying to keep the testsuite files wrapped at 80
characters. It seemed much less readable, but I will defer to whatever
folks want to see there. :)

Thanks!

-Kees

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
https://github.com/KSPP/linux/issues/369

Kees Cook (7):
  sanitizer: Expand sanitizer flag from 32-bit to 64-bit
  mangle: Introduce C typeinfo mangling API
  kcfi: Add core Kernel Control Flow Integrity infrastructure
  x86: Add x86_64 Kernel Control Flow Integrity implementation
  aarch64: Add AArch64 Kernel Control Flow Integrity implementation
  riscv: Add RISC-V Kernel Control Flow Integrity implementation
  kcfi: Add regression test suite

 gcc/Makefile.in                               |   2 +
 gcc/asan.h                                    |   4 +-
 gcc/c-family/c-common.h                       |   2 +-
 gcc/config/aarch64/aarch64-protos.h           |   4 +
 gcc/config/i386/i386-protos.h                 |   4 +
 gcc/config/riscv/riscv-protos.h               |   1 +
 gcc/flag-types.h                              |  66 +-
 gcc/kcfi.h                                    |  85 ++
 gcc/mangle.h                                  |  29 +
 gcc/opts.h                                    |   8 +-
 gcc/selftest.h                                |   1 +
 gcc/tree-pass.h                               |   1 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-esr.c  |  36 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  83 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  83 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  75 ++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         | 133 +++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 116 +++
 .../gcc.dg/kcfi/kcfi-insn-sequence.c          |  42 +
 .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |  54 ++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  96 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |  39 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |  41 +
 .../gcc.dg/kcfi/kcfi-patchable-basic.c        |  54 ++
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  36 +
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  47 +
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  52 ++
 .../gcc.dg/kcfi/kcfi-patchable-none.c         |  18 +
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  48 +
 .../gcc.dg/kcfi/kcfi-pic-addressing.c         |  98 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   | 111 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  56 ++
 .../gcc.dg/kcfi/kcfi-type-mangling.c          | 864 ++++++++++++++++++
 gcc/c-family/c-attribs.cc                     |  19 +-
 gcc/c/c-parser.cc                             |   4 +-
 gcc/cfgcleanup.cc                             |  20 +
 gcc/cfgexpand.cc                              |  61 ++
 gcc/combine.cc                                |   1 +
 gcc/common.opt                                |   2 +-
 gcc/config/aarch64/aarch64.cc                 | 112 +++
 gcc/config/aarch64/aarch64.md                 | 137 +++
 gcc/config/i386/i386-options.cc               |   3 +
 gcc/config/i386/i386.cc                       | 128 +++
 gcc/config/i386/i386.md                       | 144 +++
 gcc/config/riscv/riscv.cc                     | 157 ++++
 gcc/config/riscv/riscv.md                     |  49 +
 gcc/cp/typeck.cc                              |   2 +-
 gcc/d/d-attribs.cc                            |   8 +-
 gcc/doc/invoke.texi                           |  76 ++
 gcc/dwarf2asm.cc                              |   2 +-
 gcc/emit-rtl.cc                               |   1 +
 gcc/kcfi.cc                                   | 783 ++++++++++++++++
 gcc/mangle.cc                                 | 548 +++++++++++
 gcc/opts.cc                                   |  17 +-
 gcc/passes.cc                                 |   1 +
 gcc/passes.def                                |   3 +
 gcc/recog.cc                                  |   1 +
 gcc/reg-notes.def                             |   6 +
 gcc/targhooks.cc                              |  50 +-
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  36 +
 gcc/toplev.cc                                 |   8 +
 gcc/varasm.cc                                 |  18 +
 62 files changed, 4721 insertions(+), 65 deletions(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/mangle.h
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-esr.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-insn-sequence.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-basic.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-none.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-pic-addressing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-type-mangling.c
 create mode 100644 gcc/kcfi.cc
 create mode 100644 gcc/mangle.cc
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp

-- 
2.34.1

