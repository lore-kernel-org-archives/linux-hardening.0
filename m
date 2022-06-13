Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4419C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbiFMSay (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245225AbiFMSai (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E203FB41FC
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DEC661414
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C93C34114;
        Mon, 13 Jun 2022 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131563;
        bh=z184xQ+j4dfqKxhZCsP+g0tmE7BGnxlgI1xOjLLX6eY=;
        h=From:To:Cc:Subject:Date:From;
        b=o0wX9DRG5sTa3TDDQAYEOrtZZKx53BiDKeIS+lD3DmSkbT8JkvIw8jWoo/BI0XQ9s
         lb29nd01HstRubGxmEy72BN1/NKtmFxVum6eAZrCMsHYxzeaEuCgOr1lJtIyhRh8RI
         DAgfrs0MbTJMIC7ApcSB2+jh8pdlB12D0OWm7ZxlLO2cs5w6xCeaMnrUNwBNjmkfGc
         YcTbkU841p7mSXWB//ZINfoKZLp/CbCMf/rsuKkwEtvmi40M52C1GGzBcF82OXb8N6
         3WI7qvP90RZEvOlbBZftZj2WT3xou2U6CNBkRI3XySYb8wPrX7WEJCXumfPZtFAZH5
         ogiB5ExIJxBHw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 00/26] arm64: refactor boot flow and add support for WXN
Date:   Mon, 13 Jun 2022 16:45:24 +0200
Message-Id: <20220613144550.3760857-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7202; h=from:subject; bh=z184xQ+j4dfqKxhZCsP+g0tmE7BGnxlgI1xOjLLX6eY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip01rJL6Q0QfCZL+jx8h0qCyV0oEgnf/4lolSimFh bAse12SJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNawAKCRDDTyI5ktmPJNeHDA C47+lDCDEtZT04qm1uCrv+I6sqg3r6SOPYcGc7hVglcJmd3vkbYPGyqw5NajBk8YzsKf8Xf71Dbp8j xDTq/cWZKvpbyJXqo/eTmiTZdVw7UCtkUUvLUvAcRDyiz0BrrvlXNYg1HOwIsUhyWPIwtonFaYLXkw qfIRH2yd0EFqqmt5iAnwFboDfbEO82e0fa8ssTAmQKXdORF9n8Cn64m3cxCqI6I/K36CIni3buQqr5 m838wWFOhzRRxHSw8IWKJfZlarGWoeqLVV4c+jr+k1TI5CQWsfrnva+vW2joJSJPECjKZlH/Ic+jF3 hiaFUXm0o2zvKuQilGogJYsNtSfaPUiPq/MlH3BZWV/1kr7AzR9LVnyPSGMdACGveMR7wrIJv18qyJ aVyC38Fatl+NDMJ/XAqJQCLT+zoEYvgJskW33b1cy/1o8TzyDx5IvcvbfrH0hLB0sBvufvkYXgCGPN 3v6PmAWziDhWHSt4TXD0NnmMR+f6ce6GkLq6gVLA291+k=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

[ TL;DR this series does the following:
  - move variable definitions and assignments out of early asm code
    where possible, and get rid of explicit cache maintenance;
  - convert initial ID map so it covers the entire loaded image as well
    as the DT blob;
  - create the kernel mapping only once instead of twice (for KASLR),
    and do it with the MMU and caches on;
  - avoid mappings that are both writable and executable entirely;
  - avoid parsing the DT while the kernel text and rodata are still
    mapped writable;
  - allow WXN to be enabled (with an opt-out) so writable mappings are
    never executable. ]

This is a followup to a previous series of mine [0][1], and it aims to
streamline the boot flow with respect to cache maintenance and redundant
copying of data in memory, as well as eliminate writable executable
mappings at any time during the boot or after.

Additionally, this series removes the little dance we do to create a
kernel mapping, relocate the kernel, run the KASLR init code, tear down
the old mapping and create a new one, relocate the kernel again, and
finally enter the kernel proper. Instead, it invokes a minimal C
function 'kaslr_early_init()' while running from the ID map which
includes a temporary mapping of the FDT. This change represents a
substantial chunk of the diffstat, as it requires some work to
instantiate code that can run safely from an arbitrary load address.

The WXN support was tested using a Debian bullseye mixed AArch64/armhf
user space, running Gnome shell, Chromium, Firefox, LibreOffice, etc.
Some minimal tweaks are needed to avoid entries appearing in the kernel
log regarding attempts from user space to create PROT_EXEC+PROT_WRITE
mappings, but in most cases (libffi, for instance), the library in
question already carries a workaround, but didn't enable it by default
because it did not detect selinux as being active (which it was not, in
this case)

Changes since v3:
- drop changes for entering with the MMU enabled for now;
- reject mmap() and mprotect() calls with PROT_WRITE and PROT_EXEC flags
  passed when WXN is in effect; this essentially matches the behavior of
  both selinux and PaX, and most distros (including Android) can already
  deal with this just fine;
- defer KASLR initialization to an initcall() to the extent possible.

Changes since v2:
- create a separate, initial ID map that is discarded after boot, and
  create the permanent ID map from C code using the ordinary memory
  mapping code;
- refactor the extended ID map handling, and along with it, simplify the
  early memory mapping macros, so that we can deal with an extended ID
  map that requires multiple table entries at intermediate levels;
- eliminate all variable assignments with the MMU off from the happy
  flow;
- replace temporary FDT mapping in TTBR1 with a FDT mapping in the
  initial ID map;
- use read-only attributes for all code mappings, so we can boot with
  WXN enabled if we elect to do so.

Changes since v1:
- Remove the dodgy handling of the KASLR seed, which was necessary to
  avoid doing two iterations of the setup/teardown of the page tables.
  This is now dealt with by creating the TTBR1 page tables while
  executing from TTBR0, and so all memory manipulations are still done
  with the MMU and caches on.
- Only boot from EFI with the MMU and caches on if the image was not
  moved around in memory. Otherwise, we cannot rely on the firmware's ID
  map to have created an executable mapping for the copied code.

[0] https://lore.kernel.org/all/20220304175657.2744400-1-ardb@kernel.org/
[1] https://lore.kernel.org/all/20220330154205.2483167-1-ardb@kernel.org/
[2] https://lore.kernel.org/all/20220411094824.4176877-1-ardb@kernel.org/

Cc: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>

Ard Biesheuvel (26):
  arm64: head: move kimage_vaddr variable into C file
  arm64: mm: make vabits_actual a build time constant if possible
  arm64: head: move assignment of idmap_t0sz to C code
  arm64: head: drop idmap_ptrs_per_pgd
  arm64: head: simplify page table mapping macros (slightly)
  arm64: head: switch to map_memory macro for the extended ID map
  arm64: head: split off idmap creation code
  arm64: kernel: drop unnecessary PoC cache clean+invalidate
  arm64: head: pass ID map root table address to __enable_mmu()
  arm64: mm: provide idmap pointer to cpu_replace_ttbr1()
  arm64: head: add helper function to remap regions in early page tables
  arm64: head: cover entire kernel image in initial ID map
  arm64: head: use relative references to the RELA and RELR tables
  arm64: head: create a temporary FDT mapping in the initial ID map
  arm64: idreg-override: use early FDT mapping in ID map
  arm64: head: factor out TTBR1 assignment into a macro
  arm64: head: populate kernel page tables with MMU and caches on
  arm64: head: record CPU boot mode after enabling the MMU
  arm64: kaslr: defer initialization to late initcall where permitted
  arm64: head: avoid relocating the kernel twice for KASLR
  arm64: setup: drop early FDT pointer helpers
  arm64: mm: move ro_after_init section into the data segment
  arm64: head: remap the kernel text/inittext region read-only
  mm: add arch hook to validate mmap() prot flags
  arm64: mm: add support for WXN memory translation attribute
  arm64: kernel: move ID map out of .text mapping

 arch/arm64/Kconfig                      |  11 +
 arch/arm64/include/asm/assembler.h      |  37 +-
 arch/arm64/include/asm/cpufeature.h     |   8 +
 arch/arm64/include/asm/kernel-pgtable.h |  18 +-
 arch/arm64/include/asm/memory.h         |   4 +
 arch/arm64/include/asm/mman.h           |  36 ++
 arch/arm64/include/asm/mmu_context.h    |  46 +-
 arch/arm64/include/asm/setup.h          |   3 -
 arch/arm64/kernel/Makefile              |   2 +-
 arch/arm64/kernel/cpufeature.c          |   2 +-
 arch/arm64/kernel/head.S                | 536 ++++++++++----------
 arch/arm64/kernel/hyp-stub.S            |   4 +-
 arch/arm64/kernel/idreg-override.c      |  33 +-
 arch/arm64/kernel/image-vars.h          |   4 +
 arch/arm64/kernel/kaslr.c               | 149 +-----
 arch/arm64/kernel/pi/Makefile           |  33 ++
 arch/arm64/kernel/pi/kaslr_early.c      | 112 ++++
 arch/arm64/kernel/setup.c               |  15 -
 arch/arm64/kernel/sleep.S               |   1 +
 arch/arm64/kernel/suspend.c             |   2 +-
 arch/arm64/kernel/vmlinux.lds.S         |  63 ++-
 arch/arm64/mm/kasan_init.c              |   4 +-
 arch/arm64/mm/mmu.c                     |  96 +++-
 arch/arm64/mm/proc.S                    |  29 +-
 include/linux/mman.h                    |  15 +
 mm/mmap.c                               |   3 +
 26 files changed, 763 insertions(+), 503 deletions(-)
 create mode 100644 arch/arm64/kernel/pi/Makefile
 create mode 100644 arch/arm64/kernel/pi/kaslr_early.c

-- 
2.30.2

