Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930DBC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbiAXRr5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:47:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49812 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240939AbiAXRr4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:47:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7807EB811AC
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A247C340E5;
        Mon, 24 Jan 2022 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046474;
        bh=/IveAmA8ac9oULy4Ym0yBni95GI5JyvOP4fHUItZRxU=;
        h=From:To:Cc:Subject:Date:From;
        b=IDAsthU7Q8zV5PTUfFfb38mCps9xbCZiXAT9RAkWeJVM/kr2b68wygOX7SlYLHQRn
         6A+NYGWBycPV9HH6NXfC6HtbHsyn9MW9llyQcN200+TonHJamdaxikVRzZoahyiHpe
         m7NTFd+4eAG1kGtWRxP1yMUkEcpQj6M3sosKyC8nBFY6dmjOSOW3F0FFIncKUUmeRC
         MChv0SmsjfTRQp5eqMsZutk+VCo8beKCiD76FNIsnV9oarv7wk8umFZiI4R+x5NhVA
         A0Pq4NrU8xzZuF/vUdBJHOB7iwAP/ATI/pP2bCqwCjKb418lteK1PWwuQPi7khqM32
         tussZBL4x/ssg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v5 00/32] ARM vmap'ed and IRQ stacks roundup
Date:   Mon, 24 Jan 2022 18:47:12 +0100
Message-Id: <20220124174744.1054712-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8373; h=from:subject; bh=/IveAmA8ac9oULy4Ym0yBni95GI5JyvOP4fHUItZRxU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYBaEmHO2Z6fQzbplvcXSC46n9ZaylWHmyGDoRk X396zhaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mAQAKCRDDTyI5ktmPJG2pC/ 4q5HtUXH6Ip4DTiPjRpvkb5TU4a1qgC3AbOT2XuVmdt/AW0s4OoRIAoHlOv7busFLKYZFr8vAGoPzq yLvCQx1yBIC1y5jn7uUwBirbys2fcLyisLYl/PvyxuKIBn85BK0KpBv6vpyNap/vAJJiAbmocz71et ONeQs1Zsi6nX5/4u5g8r2pFGAXOOSm2sSWWGwvr2QwjWrDoXbQ7VM4/uM0r8mCZvU5EB3VXXQLbgOU V9KW1VZeIC63YKUM5IwGiuN0VwN76K5Up+5WzcpWCGy5r15RmQMbBjhNYR5WXmNcBkEQ6qKAdcbwSN YaNQ7/Qhqs7Mg+DSIA2Y0pc8F3oY1M+tRI6RumR9Z83+oF74uv9yAleGDAaeVnz18X0uJVhyqYyfH6 dvomzcVJb3QSnxIT1I+nLbsmZIXlzL049bQ/EF/tU8a7gMAMte0e9G9+t68q3jIbp10U42H+NkopXu WIoYkXAClmgbLj/2wnGZx2URcW0Zgf9/iC7ygZxLlepy4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This v5 series is a combined followup to

- IRQ stacks support for v7 SMP systems [0],
- vmap'ed stacks support for v7 SMP systems[1],
- extending support for both IRQ stacks and vmap'ed stacks for all
  remaining configurations, including v6/v7 SMP multiplatform kernels
  and uniprocessor configurations including v7-M [2]

[0] https://lore.kernel.org/linux-arm-kernel/20211115084732.3704393-1-ardb@kernel.org/
[1] https://lore.kernel.org/linux-arm-kernel/20211122092816.2865873-1-ardb@kernel.org/
[2] https://lore.kernel.org/linux-arm-kernel/20211206164659.1495084-1-ardb@kernel.org/

This work was queued up in the ARM tree for a while, but due to problems
with the vmap'ed stacks code, which was difficult to revert in
isolation, the whole stack was dropped again.

In order to prevent similar problems from occurring this time around,
the series was reorganized so that the vmap'ed stacks changes appear at
the very end, which also results in a more natural progression of the
changes.

Changes since v4:
- incorporate fixups to avoid build failures on Clang related to
  literals in subsections,
- switch from the ID map to swapper_pg_dir as early as possible when
  onlining a CPU on !LPAE, to ensure that the stack is mapped,
- use SMP_ON_UP patching to elide HWCAP_TLS tests on SMP+v6,
- clean up __switch_to() for Thumb2 a bit more,
- add patch to make the vmalloc_seq counter SMP safe,
- use enter_lazy_tlb() hook on !LPAE to ensure that the active_mm used
  by a kernel thread has a mapping for its vmap'ed stack,

Code can be found under the arm-vmap-stacks-v5 tag at
git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git

Cc: Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Keith Packard <keithpac@amazon.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Jesse Taube <mr.bossman075@gmail.com>

Ard Biesheuvel (26):
  ARM: riscpc: drop support for IOMD_IRQREQC/IOMD_IRQREQD IRQ groups
  ARM: decompressor: disable stack protector
  ARM: stackprotector: prefer compiler for TLS based per-task protector
  ARM: entry: preserve thread_info pointer in switch_to
  ARM: module: implement support for PC-relative group relocations
  ARM: assembler: add optimized ldr/str macros to load variables from
    memory
  ARM: percpu: add SMP_ON_UP support
  ARM: use TLS register for 'current' on !SMP as well
  ARM: smp: defer TPIDRURO update for SMP v6 configurations too
  ARM: implement THREAD_INFO_IN_TASK for uniprocessor systems
  ARM: assembler: introduce bl_r macro
  ARM: unwind: support unwinding across multiple stacks
  ARM: export dump_mem() to other objects
  ARM: unwind: dump exception stack from calling frame
  ARM: backtrace-clang: avoid crash on bogus frame pointer
  ARM: implement IRQ stacks
  ARM: call_with_stack: add unwind support
  ARM: run softirqs on the per-CPU IRQ stack
  ARM: memcpy: use frame pointer as unwind anchor
  ARM: memmove: use frame pointer as unwind anchor
  ARM: memset: clean up unwind annotations
  ARM: unwind: disregard unwind info before stack frame is set up
  ARM: entry: rework stack realignment code in svc_entry
  ARM: switch_to: clean up Thumb2 code path
  ARM: mm: prepare vmalloc_seq handling for use under SMP
  ARM: implement support for vmap'ed stacks

Arnd Bergmann (5):
  ARM: riscpc: use GENERIC_IRQ_MULTI_HANDLER
  ARM: footbridge: use GENERIC_IRQ_MULTI_HANDLER
  ARM: iop32x: offset IRQ numbers by 1
  ARM: iop32x: use GENERIC_IRQ_MULTI_HANDLER
  ARM: remove old-style irq entry

Vladimir Murzin (1):
  irqchip: nvic: Use GENERIC_IRQ_MULTI_HANDLER

 arch/arm/Kconfig                                    |  39 ++--
 arch/arm/Makefile                                   |   9 +
 arch/arm/boot/compressed/Makefile                   |   6 +-
 arch/arm/boot/compressed/misc.c                     |   7 -
 arch/arm/include/asm/assembler.h                    | 209 ++++++++++++++++----
 arch/arm/include/asm/current.h                      |  47 +++--
 arch/arm/include/asm/elf.h                          |   3 +
 arch/arm/include/asm/entry-macro-multi.S            |  40 ----
 arch/arm/include/asm/hardware/entry-macro-iomd.S    | 131 ------------
 arch/arm/include/asm/insn.h                         |  17 ++
 arch/arm/include/asm/irq.h                          |   1 -
 arch/arm/include/asm/mach/arch.h                    |   2 -
 arch/arm/include/asm/mmu.h                          |   2 +-
 arch/arm/include/asm/mmu_context.h                  |  22 ++-
 arch/arm/include/asm/page.h                         |   3 +
 arch/arm/include/asm/percpu.h                       |  36 +++-
 arch/arm/include/asm/smp.h                          |   5 -
 arch/arm/include/asm/stacktrace.h                   |  12 ++
 arch/arm/include/asm/switch_to.h                    |   3 +-
 arch/arm/include/asm/thread_info.h                  |  35 +---
 arch/arm/include/asm/tls.h                          |  30 ++-
 arch/arm/include/asm/v7m.h                          |   3 +-
 arch/arm/kernel/asm-offsets.c                       |   3 -
 arch/arm/kernel/entry-armv.S                        | 208 +++++++++++++++----
 arch/arm/kernel/entry-common.S                      |  16 +-
 arch/arm/kernel/entry-header.S                      |  47 ++++-
 arch/arm/kernel/entry-v7m.S                         |  39 ++--
 arch/arm/kernel/head-common.S                       |   4 +-
 arch/arm/kernel/head.S                              |   7 +
 arch/arm/kernel/irq.c                               |  55 ++++--
 arch/arm/kernel/module.c                            |  90 +++++++++
 arch/arm/kernel/process.c                           |   7 +-
 arch/arm/kernel/setup.c                             |   8 +-
 arch/arm/kernel/sleep.S                             |  13 ++
 arch/arm/kernel/smp.c                               |  11 +-
 arch/arm/kernel/traps.c                             |  92 ++++++++-
 arch/arm/kernel/unwind.c                            |  50 +++--
 arch/arm/kernel/vmlinux.lds.S                       |   4 +-
 arch/arm/lib/backtrace-clang.S                      |  13 +-
 arch/arm/lib/backtrace.S                            |   7 +
 arch/arm/lib/call_with_stack.S                      |  33 +++-
 arch/arm/lib/copy_from_user.S                       |  13 +-
 arch/arm/lib/copy_template.S                        |  67 +++----
 arch/arm/lib/copy_to_user.S                         |  13 +-
 arch/arm/lib/memcpy.S                               |  13 +-
 arch/arm/lib/memmove.S                              |  60 ++----
 arch/arm/lib/memset.S                               |   7 +-
 arch/arm/mach-footbridge/common.c                   |  87 ++++++++
 arch/arm/mach-footbridge/include/mach/entry-macro.S | 107 ----------
 arch/arm/mach-iop32x/cp6.c                          |  10 +-
 arch/arm/mach-iop32x/include/mach/entry-macro.S     |  31 ---
 arch/arm/mach-iop32x/include/mach/irqs.h            |   2 +-
 arch/arm/mach-iop32x/iop3xx.h                       |   1 +
 arch/arm/mach-iop32x/irq.c                          |  29 ++-
 arch/arm/mach-iop32x/irqs.h                         |  60 +++---
 arch/arm/mach-rpc/fiq.S                             |   5 +-
 arch/arm/mach-rpc/include/mach/entry-macro.S        |  13 --
 arch/arm/mach-rpc/irq.c                             |  95 +++++++++
 arch/arm/mm/Kconfig                                 |   1 +
 arch/arm/mm/context.c                               |   3 +-
 arch/arm/mm/ioremap.c                               |  18 +-
 drivers/irqchip/Kconfig                             |   1 +
 drivers/irqchip/irq-nvic.c                          |  22 +--
 63 files changed, 1270 insertions(+), 757 deletions(-)
 delete mode 100644 arch/arm/include/asm/entry-macro-multi.S
 delete mode 100644 arch/arm/include/asm/hardware/entry-macro-iomd.S
 delete mode 100644 arch/arm/mach-footbridge/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-iop32x/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-rpc/include/mach/entry-macro.S

-- 
2.30.2

