Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3543433C4
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757031859; cv=none; b=CHjdL/sBfcQTEDGDo6oMzNPD2/sV0qhdme+qZ4X+DX/E5dJ1QjfQ/jDg3BYkMO9hth4wYweisCtML7MCPnqLEgRluog3cs7dQslk7LdZz1LAVZD7pux0ELTQRIcROhDx5hI0N6Ziwg61cLy4fJPRuAABdALblXVuTaF1KsVIqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757031859; c=relaxed/simple;
	bh=Pi7KdB98LhgmMLHa/8sx6iWnu1t0sPbR4Vao6Ry0cCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vy/8aX+wrOe2T/hkvzgmJy2hHNYYFtAxl+qBcjTT+CmoSxWtlPY+v3F/g0C9DIu6Uzlr5EfkHtG5Xxm43wURItSstQG28HU8+e7/Jw8A0piyqucDpswpug/EZ6J25gNuBr5OBalTn5vns8Ev/XziZ/dLwtRKogSCquhF+xwz7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP2/phDh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP2/phDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2A7C4AF09;
	Fri,  5 Sep 2025 00:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757031859;
	bh=Pi7KdB98LhgmMLHa/8sx6iWnu1t0sPbR4Vao6Ry0cCo=;
	h=From:To:Cc:Subject:Date:From;
	b=OP2/phDhJ4ZWyoQVjNxGYDcHJxPd/gWI7Fkg9WvFtoAvHjwrR+AudTLQ3mIwQP2nh
	 AUYTSHbWd9EsY/4Wg1/EloElnYVbkm85ng4JXWxJ8N4+oqmu3XbaqThKJjTpISHu4J
	 ACzKiUonLp6uvxicN6Ao4extytA/1K65lCGqL4gx/MQdW252hlPMN0/KqY3KKpjpwr
	 Bkj2LPk5ttZWLxD03a95B5GJ/GMD873qTG1kxCf+DAzjWxhc4U2dMhuLBpfHUVwBY+
	 a58ZFR3BKAJsS9+69CTVjqaIVODSkI9tvTJWZzpiRuDWStXxnzMVKVrN7FQVJzWYJf
	 /F+VkOqKrMVbg==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Pinski <pinskia@gmail.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
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
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
Date: Thu,  4 Sep 2025 17:24:08 -0700
Message-Id: <20250905001157.it.269-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7104; i=kees@kernel.org; h=from:subject:message-id; bh=Pi7KdB98LhgmMLHa/8sx6iWnu1t0sPbR4Vao6Ry0cCo=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm7dNd0GE4P/2CqGFuzbYKTqYujyC7N7a/5d2qscogRS XXSP+LfUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJENPgz/81+8nsfDv+mP9dcT R04Ipoi+KVxoZ5X7gGnSwyovuXQmfUaGBRzPrZ7e1ynR8X9m+vH25ykrXvixbEsR5W22L28Sf/C fDwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi!

Here is v2, which is substantially changed compared to the RFC[1].

This series implements[2][3] the Linux Kernel Control Flow Integrity
ABI, which provides a function prototype based forward edge control flow
integrity protection by instrumenting every indirect call to check for
a hash value before the target function address. If the hash at the call
site and the hash at the target do not match, execution will trap.

The major change here is getting (what seems to be) proper KCFI RTL
working on the back end so that expansion Just Works. This meant all
the strange hacks I had for handling corner cases mostly went away,
and I was left with an optimizer that actually wanted to help me. :)

I revamped the mangler to do the hashing directly, and incorporated
design details into kcfi.cc (rather than putting it all in the commit
log). I'm using proper target hooks.

I've tested all 4 architectures now, and everything is working for me.

I'm still unsure about the arm32 and riscv RTL expansion: it seems strange
that I have to extract the CALL from PARALLEL patterns, but everything
I tried to match an PARALLEL kept failling.

For the commits, I ended up hand-building the ChangeLog trailers... I
assume there is a better way to do this, but I think I was just too
dense to find it. :P

Thanks!

-Kees

[1] https://lore.kernel.org/linux-hardening/20250821064202.work.893-kees@kernel.org/
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[3] https://github.com/KSPP/linux/issues/369

Kees Cook (7):
  mangle: Introduce C typeinfo mangling API
  kcfi: Add core Kernel Control Flow Integrity infrastructure
  x86: Add x86_64 Kernel Control Flow Integrity implementation
  aarch64: Add AArch64 Kernel Control Flow Integrity implementation
  arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
  riscv: Add RISC-V Kernel Control Flow Integrity implementation
  kcfi: Add regression test suite

 gcc/kcfi.h                                    |   47 +
 gcc/kcfi.cc                                   |  764 ++++++++++++
 gcc/Makefile.in                               |    2 +
 gcc/config/aarch64/aarch64-protos.h           |    5 +
 gcc/config/arm/arm-protos.h                   |    4 +
 gcc/config/i386/i386-protos.h                 |    1 +
 gcc/config/i386/i386.h                        |    3 +-
 gcc/config/riscv/riscv-protos.h               |    3 +
 gcc/flag-types.h                              |    2 +
 gcc/gimple.h                                  |   21 +
 gcc/mangle.h                                  |   32 +
 gcc/tree-pass.h                               |    3 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |   73 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  101 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |   85 ++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         |  137 +++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  125 ++
 .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |   55 +
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |   56 +
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  101 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   41 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |   50 +
 .../gcc.dg/kcfi/kcfi-patchable-basic.c        |   71 ++
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |   64 +
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |   52 +
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |   61 +
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |   61 +
 .../gcc.dg/kcfi/kcfi-pic-addressing.c         |  105 ++
 .../gcc.dg/kcfi/kcfi-retpoline-r11.c          |   51 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  143 +++
 .../gcc.dg/kcfi/kcfi-trap-encoding.c          |   56 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   43 +
 .../gcc.dg/kcfi/kcfi-type-mangling.c          | 1064 +++++++++++++++++
 gcc/c-family/c-attribs.cc                     |   12 +
 gcc/config/aarch64/aarch64.cc                 |  115 ++
 gcc/config/aarch64/aarch64.md                 |   64 +-
 gcc/config/arm/arm.cc                         |  144 +++
 gcc/config/arm/arm.md                         |   62 +
 gcc/config/i386/i386-expand.cc                |   21 +-
 gcc/config/i386/i386.cc                       |  118 ++
 gcc/config/i386/i386.md                       |   62 +-
 gcc/config/riscv/riscv.cc                     |  147 +++
 gcc/config/riscv/riscv.md                     |   74 +-
 gcc/df-scan.cc                                |    6 +
 gcc/doc/invoke.texi                           |  102 ++
 gcc/doc/tm.texi                               |   31 +
 gcc/doc/tm.texi.in                            |   12 +
 gcc/final.cc                                  |    3 +
 gcc/mangle.cc                                 |  512 ++++++++
 gcc/opts.cc                                   |    1 +
 gcc/passes.cc                                 |    1 +
 gcc/passes.def                                |    3 +
 gcc/rtl.def                                   |    6 +
 gcc/rtlanal.cc                                |    5 +
 gcc/target.def                                |   38 +
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |   36 +
 gcc/toplev.cc                                 |   11 +
 gcc/tree-inline.cc                            |   10 +
 gcc/varasm.cc                                 |   46 +-
 59 files changed, 5092 insertions(+), 32 deletions(-)
 create mode 100644 gcc/kcfi.h
 create mode 100644 gcc/kcfi.cc
 create mode 100644 gcc/mangle.h
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
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-type-mangling.c
 create mode 100644 gcc/mangle.cc
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp

-- 
2.34.1

