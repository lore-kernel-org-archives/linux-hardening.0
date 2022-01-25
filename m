Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A28C4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 09:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455170AbiAYJ1i (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573007AbiAYJSg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 04:18:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95897C061768
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 01:15:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8642EB81732
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 09:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2CEC340E0;
        Tue, 25 Jan 2022 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643102102;
        bh=80GpadFNKVGiePMC5wFZfr7KNkkn+bT2EEfR4nbBbso=;
        h=From:To:Cc:Subject:Date:From;
        b=LGPkh9/08+yZa0xBiBCYKS1OqRmf5rRIPWStvgxqZYpzXcQncPscuP+wp00GbBCzm
         CTTvrpnSz+/rBz/sJs2i45xmNZ3pbzLxfUfpmsb4Zb2TbkQ+GJFZ3zYWPrjErU6vyw
         xc4u9dd3RjhXk1HH4fc6ujMdIFG7reF7wlmLa2VIkfiotzCBmnr5e7+MBf7sKH2pgn
         g4PwdW+dqYXL9gBX0cr0wNjcLG5X/6Cu2dfJ6WrLeiXk6coYZt/zX/rxKjsIDoWuHM
         FImXzeMed7RBF79SCDJkXhEt2d5KK7lnoGIBYiTtc9xFPP7Ojw3EMf2TqzxirCl5qK
         mohUweHI0O9fA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v6 0/8] ARM vmap'ed and IRQ stacks roundup
Date:   Tue, 25 Jan 2022 10:14:45 +0100
Message-Id: <20220125091453.1475246-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2498; h=from:subject; bh=80GpadFNKVGiePMC5wFZfr7KNkkn+bT2EEfR4nbBbso=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7798kogx0Vqb3GMM9c0zSDJLVJ+D8muTYRPe7v4x qYSy3qOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe+/fAAKCRDDTyI5ktmPJKEhC/ 9Z9RMyWwePwof0dLE2g4M66KQhl/JfYZ1Rxh/YmfjkzDqkRCFuJikuc+IbG2VKU26+lNmXduOF2qK/ UE284SxTfHxceYuST1K+/SETnhEe+ftFiWnw/6oW9V/71DjW9b7iBXXdwE3ZxwN0TQfVBozkvyjKAf 3LLhB+H+SobsSnltxy/ux+JAj1MnseeFS0RcmcBKhghC0c48X9xmSaKnnXqiyp3fn/u59kojkwFv0F pqUu/y/1+t3jdyaIfRif1iQrvc1ncP+xB5dpn+Yf2J1MwGgM2ya/cYstFsKNjlSURTpju58l0xReQc K0IAt9EagbvCiUcFmVPWVJyCvYDDv11kHXp1jw19I0ZP7GrKKydbscBfRDqN0aIhyMvnzkSlxBPEZ5 1VOi0map0hhPfiqf/jCanEbFwbMtsexI9GiiMyUaBH/PoKNK3UBI7Ufh7tQFQCkfvh5eVxYWQB3zuJ oOfx5J5p5sVtc5fUURmqXTMEueZZ7MXF7XiVNuxuzmkTw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This v6 series is a followup to [0], and presents the proposed changes
as a set of delta patches against the v4 that was already taken into
rmk/devel-stable, and dropped from v5.17 when it turned out that were
unresolved issues related to suspend/resume.

These patches apply onto rmk/devel-stable directly, which means there is
an unresolved conflict with the changes that landed in v5.17-rc1 via the
ARM tree: these will need to be handled by the maintainer.

Code can be found under the arm-vmap-stacks-v6 tag at
git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git

[0] https://lore.kernel.org/linux-arm-kernel/20220124174744.1054712-1-ardb@kernel.org/

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Keith Packard <keithpac@amazon.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Marc Zyngier <maz@kernel.org>

Ard Biesheuvel (8):
  ARM: mm: switch to swapper_pg_dir early for vmap'ed stack
  ARM: assembler: define a Kconfig symbol for group relocation support
  ARM: smp: elide HWCAP_TLS checks or __entry_task updates on SMP+v6
  ARM: entry: avoid clobbering R9 in IRQ handler
  ARM: mm: make vmalloc_seq handling SMP safe
  ARM: iop: make iop_handle_irq() static
  ARM: drop pointless SMP check on secondary startup path
  ARM: make get_current() and __my_cpu_offset() __always_inline

 arch/arm/Kconfig                   | 13 +++++++++-
 arch/arm/include/asm/assembler.h   |  8 +++----
 arch/arm/include/asm/current.h     | 10 ++++----
 arch/arm/include/asm/mmu.h         |  2 +-
 arch/arm/include/asm/mmu_context.h | 22 +++++++++++++++--
 arch/arm/include/asm/page.h        |  3 +--
 arch/arm/include/asm/percpu.h      |  6 ++---
 arch/arm/include/asm/switch_to.h   |  4 ++--
 arch/arm/include/asm/tls.h         | 22 ++++++++++++-----
 arch/arm/kernel/entry-armv.S       |  9 ++++---
 arch/arm/kernel/entry-header.S     | 17 ++++++-------
 arch/arm/kernel/head.S             |  7 ++++++
 arch/arm/kernel/module.c           |  7 +++++-
 arch/arm/kernel/sleep.S            |  7 ++++++
 arch/arm/kernel/smp.c              |  5 ----
 arch/arm/kernel/traps.c            | 25 ++++++--------------
 arch/arm/mach-iop32x/irq.c         |  2 +-
 arch/arm/mm/context.c              |  3 +--
 arch/arm/mm/ioremap.c              | 18 ++++++++------
 19 files changed, 115 insertions(+), 75 deletions(-)

-- 
2.30.2

