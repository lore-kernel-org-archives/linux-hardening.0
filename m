Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F04C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 08:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA45E6103C
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 08:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhJZIVM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233719AbhJZIVM (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Oct 2021 04:21:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D8646058D;
        Tue, 26 Oct 2021 08:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635236328;
        bh=8C1F/kzj+q+J+wJE28QeYmG8nFMQHg0s+Hv5ZuvhrlQ=;
        h=From:To:Cc:Subject:Date:From;
        b=n/upNScCCtEgo98nztEW34+saTf81pSdD3GIOVMF3kQydLRAP3PYBE7jU1YUpocAa
         EERS8gi/siyqxNIQGCFk8g0QAmg+QRaKxkvFwa3+CPSowHVU3Ym4aO2+S1F6K+Y1EQ
         39Xe2adqbfFn+zKxsLH4Uf0YoB0uzkyZ06Bip5MLIShieCgMFm9GP4KCiHkpCxo+7m
         cGgtF7MODv/u7xYGGb/LT0+Q+S/PEPi1s2j/42RKP0yrn9qcvFWjOCyKUYixnP/V28
         SLiMlhYUsRhDXd2Y7sdBVPA4m+jV1KvltptTH0LuVJJWzZDGp0UF1GXXlA4UyMdnJb
         RqpXdBXmnwawA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        thomas.preudhomme@celest.fr, adhemerval.zanella@linaro.org,
        Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        gcc-patches@gcc.gnu.org
Subject: [PATCH v3 0/1] implement TLS register based stack canary for ARM
Date:   Tue, 26 Oct 2021 10:18:35 +0200
Message-Id: <20211026081836.3518758-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102352

In the Linux kernel, user processes calling into the kernel are
essentially threads running in the same address space, of a program that
never terminates. This means that using a global variable for the stack
protector canary value is problematic on SMP systems, as we can never
change it unless we reboot the system. (Processes that sleep for any
reason will do so on a call into the kernel, which means that there will
always be live kernel stack frames carrying copies of the canary taken
when the function was entered)

AArch64 implements -mstack-protector-guard=sysreg for this purpose, as
this permits the kernel to use different memory addresses for the stack
canary for each CPU, and context switch the chosen system register with
the rest of the process, allowing each process to use its own unique
value for the stack canary.

This patch implements something similar, but for the 32-bit ARM kernel,
which will start using the user space TLS register TPIDRURO to index
per-process metadata while running in the kernel. This means we can just
add an offset to TPIDRURO to obtain the address from which to load the
canary value.

As for the spilling issues that have been fixed in this code in the
past: I suppose a register carrying the TLS register value will never
get spilled to begin with?

Changes since v2:
- fix the template for stack_protect_test_tls so it correctly conveys
  the fact that it sets the Z flag

Comments/suggestions welcome.

Cc: Keith Packard <keithpac@amazon.com>
Cc: thomas.preudhomme@celest.fr
Cc: adhemerval.zanella@linaro.org
Cc: Qing Zhao <qing.zhao@oracle.com>
Cc: Richard Sandiford <richard.sandiford@arm.com>
Cc: gcc-patches@gcc.gnu.org

Ard Biesheuvel (1):
  [ARM] Add support for TLS register based stack protector canary access

 gcc/config/arm/arm-opts.h   |  6 ++
 gcc/config/arm/arm-protos.h |  2 +
 gcc/config/arm/arm.c        | 52 ++++++++++++++++
 gcc/config/arm/arm.md       | 62 +++++++++++++++++++-
 gcc/config/arm/arm.opt      | 22 +++++++
 gcc/doc/invoke.texi         |  9 +++
 6 files changed, 151 insertions(+), 2 deletions(-)

-- 
2.30.2

