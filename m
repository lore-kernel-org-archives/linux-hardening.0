Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52EC328605
	for <linux-hardening@vger.kernel.org>; Wed, 10 Dec 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765392941; cv=none; b=IIWe3vKUEgbMelbBNtcChsCPOa1y8rdkintBHMCTZcevZcIHhM62Rftl+ZxOmy0IVdArb+9auoj3bMzxf6vu9m62YKvRfl7KmRT94cCuhDk8CCGEEJjRpkkxeggAsE+IkWESe4UtU/nZ44fEG4+/6Fqw1vIDcvacLOUFOWZtJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765392941; c=relaxed/simple;
	bh=1Hbdh6jTJSSHfqP15373EHCBUxMJyXgoni2j56+x1Sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nb9R2uDwppHw9ctg4GFePSTDUIVRgIQULnWXxyVb1iL6QHXMqiB2lzw/bvuB4bKy7nHwftf0CCXpMF6QpBYxa07a045tvAjcSFY5LitjcNGS+xr62ilymQW9+J/U6qkV15ODlMoszEezURxoX6SRZ4oOaUW4ivUiAcuL6kHfxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id DAFAA33BF0E;
	Wed, 10 Dec 2025 18:55:34 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>,  Uros Bizjak <ubizjak@gmail.com>,
  Joseph Myers <josmyers@redhat.com>,  Richard Biener <rguenther@suse.de>,
  Jeff Law <jeffreyalaw@gmail.com>,  Andrew Pinski <pinskia@gmail.com>,
  Jakub Jelinek <jakub@redhat.com>,  Martin Uecker <uecker@tugraz.at>,
  Peter Zijlstra <peterz@infradead.org>,  Ard Biesheuvel <ardb@kernel.org>,
  Jan Hubicka <hubicka@ucw.cz>,  Richard Earnshaw
 <richard.earnshaw@arm.com>,  Richard Sandiford
 <richard.sandiford@arm.com>,  Marcus Shawcroft <marcus.shawcroft@arm.com>,
  Kyrylo Tkachov <kyrylo.tkachov@arm.com>,  Kito Cheng
 <kito.cheng@gmail.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Andrew
 Waterman <andrew@sifive.com>,  Jim Wilson <jim.wilson.gcc@gmail.com>,  Dan
 Li <ashimida.1990@gmail.com>,  Sami Tolvanen <samitolvanen@google.com>,
  Ramon de C Valle <rcvalle@google.com>,  Joao Moreira
 <joao@overdrivepizza.com>,  Nathan Chancellor <nathan@kernel.org>,  Bill
 Wendling <morbo@google.com>,  "Osterlund, Sebastian"
 <sebastian.osterlund@intel.com>,  "Constable, Scott D"
 <scott.d.constable@intel.com>,  gcc-patches@gcc.gnu.org,
  linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 0/7] Introduce Kernel Control Flow Integrity ABI
 [PR107048]
In-Reply-To: <20251210022025.harder.803-kees@kernel.org>
Organization: Gentoo
References: <20251210022025.harder.803-kees@kernel.org>
User-Agent: mu4e 1.12.13; emacs 31.0.50
Date: Wed, 10 Dec 2025 18:55:31 +0000
Message-ID: <875xaei2u4.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <kees@kernel.org> writes:

> Hi,
>
> This series implements[1][2] the Linux Kernel Control Flow Integrity
> ABI, which provides a function prototype based forward edge control flow
> integrity protection by instrumenting every indirect call to check for
> a hash value before the target function address. If the hash at the call
> site and the hash at the target do not match, execution will trap.
>
> I'm hoping we can land front- and middle-end and do architectures as
> they also pass review. What do folks think? I'd really like to get this
> in a position where more people can test with GCC snapshots, etc.

What's the status of this on the kernel side? Could you link me to
patches so I can have a play?

Thank you for working on this. We get a lot of requests for it and
pressure to build the kernel with Clang for this feature.

>
> Thanks!
>
> -Kees
>
> Changes since v8[3], addressing Andrew's feedback:
>
> - Split out aarch64 indirect branch logic into separate patch[4].
> - Simplify aarch64 asm output.
> - Clarify BTI interaction (it's safe) in commit log.
> - Move kcfi compatibility checking into hook logic instead of overrides
>   in aarch64, i386, and riscv.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
> [2] https://github.com/KSPP/linux/issues/369
> [3] https://lore.kernel.org/linux-hardening/20251120222105.us.687-kees@kernel.org/
> [4] https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=59a5fecfb260456dd60be687491717f3dbdb354f
>
> Kees Cook (7):
>   typeinfo: Introduce KCFI typeinfo mangling API
>   kcfi: Add core Kernel Control Flow Integrity infrastructure
>   kcfi: Add regression test suite
>   x86: Add x86_64 Kernel Control Flow Integrity implementation
>   aarch64: Add AArch64 Kernel Control Flow Integrity implementation
>   arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
>   riscv: Add RISC-V Kernel Control Flow Integrity implementation
>
>  gcc/kcfi.h                                    |  59 ++
>  gcc/kcfi.cc                                   | 696 ++++++++++++++++++
>  gcc/config/aarch64/aarch64-protos.h           |   4 +
>  gcc/config/arm/arm-protos.h                   |   4 +
>  gcc/config/i386/i386-protos.h                 |   2 +-
>  gcc/config/i386/i386.h                        |   3 +-
>  gcc/config/riscv/riscv-protos.h               |   3 +
>  gcc/config/aarch64/aarch64.md                 |  56 ++
>  gcc/config/arm/arm.md                         |  62 ++
>  gcc/config/i386/i386.md                       |  63 +-
>  gcc/config/riscv/riscv.md                     |  76 +-
>  gcc/config/aarch64/aarch64.cc                 |  93 +++
>  gcc/config/arm/arm.cc                         | 170 +++++
>  gcc/config/i386/i386-expand.cc                |  22 +-
>  gcc/config/i386/i386.cc                       | 210 +++++-
>  gcc/config/riscv/riscv.cc                     | 180 +++++
>  gcc/doc/extend.texi                           | 137 ++++
>  gcc/doc/invoke.texi                           | 127 ++++
>  gcc/doc/tm.texi                               |  32 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  51 ++
>  gcc/testsuite/lib/target-supports.exp         |  14 +
>  .../gcc.dg/builtin-typeinfo-errors.c          |  28 +
>  gcc/testsuite/gcc.dg/builtin-typeinfo.c       | 350 +++++++++
>  .../gcc.dg/kcfi/kcfi-aarch64-ilp32.c          |   7 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    | 114 +++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c |  15 +
>  .../gcc.dg/kcfi/kcfi-arm-fixed-r12.c          |  15 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       | 149 ++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  90 +++
>  .../gcc.dg/kcfi/kcfi-cold-partition.c         | 126 ++++
>  .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 203 +++++
>  .../gcc.dg/kcfi/kcfi-complex-addressing.s     |   0
>  .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |  54 ++
>  .../gcc.dg/kcfi/kcfi-move-preservation.c      | 118 +++
>  .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     | 100 +++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |  39 +
>  .../gcc.dg/kcfi/kcfi-offset-validation.c      |  38 +
>  .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  64 ++
>  .../gcc.dg/kcfi/kcfi-patchable-incompatible.c |   7 +
>  .../gcc.dg/kcfi/kcfi-patchable-large.c        |  54 ++
>  .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  60 ++
>  .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  61 ++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c  |   7 +
>  .../gcc.dg/kcfi/kcfi-riscv-fixed-t1.c         |   7 +
>  .../gcc.dg/kcfi/kcfi-riscv-fixed-t2.c         |   7 +
>  .../gcc.dg/kcfi/kcfi-riscv-fixed-t3.c         |   7 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c      | 276 +++++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   | 140 ++++
>  .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  69 ++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  29 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c    |   7 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c    |  93 +++
>  .../gcc.dg/kcfi/kcfi-x86-fixed-r10.c          |   7 +
>  .../gcc.dg/kcfi/kcfi-x86-fixed-r11.c          |   7 +
>  .../gcc.dg/kcfi/kcfi-x86-retpoline-r11.c      |  40 +
>  gcc/Makefile.in                               |   2 +
>  gcc/c-family/c-common.h                       |   1 +
>  gcc/flag-types.h                              |   2 +
>  gcc/gimple.h                                  |  22 +
>  gcc/kcfi-typeinfo.h                           |  32 +
>  gcc/tree-pass.h                               |   1 +
>  gcc/c-family/c-attribs.cc                     |  17 +-
>  gcc/c-family/c-common.cc                      |   2 +
>  gcc/c/c-parser.cc                             |  72 ++
>  gcc/common.opt                                |   8 +
>  gcc/df-scan.cc                                |   7 +
>  gcc/doc/tm.texi.in                            |  12 +
>  gcc/final.cc                                  |   3 +
>  gcc/kcfi-typeinfo.cc                          | 516 +++++++++++++
>  gcc/opts.cc                                   |   2 +
>  gcc/passes.cc                                 |   1 +
>  gcc/passes.def                                |   1 +
>  gcc/rtl.def                                   |   6 +
>  gcc/rtlanal.cc                                |   5 +
>  gcc/target.def                                |  39 +
>  gcc/toplev.cc                                 |  12 +
>  gcc/tree-inline.cc                            |  10 +
>  gcc/varasm.cc                                 |  37 +-
>  78 files changed, 5218 insertions(+), 44 deletions(-)
>  create mode 100644 gcc/kcfi.h
>  create mode 100644 gcc/kcfi.cc
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp
>  create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
>  create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-ilp32.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-r12.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.s
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-incompatible.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
>  create mode 100644 gcc/kcfi-typeinfo.h
>  create mode 100644 gcc/kcfi-typeinfo.cc
