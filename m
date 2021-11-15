Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE95C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Nov 2021 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2511C6328E
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Nov 2021 18:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbhKOSmu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 Nov 2021 13:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241772AbhKOSkq (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 Nov 2021 13:40:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E584D63288;
        Mon, 15 Nov 2021 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636999463;
        bh=ufd3RMHLa/gOk9tdWpstoVi+floesg1Mk/o4gBrnSms=;
        h=From:To:Cc:Subject:Date:From;
        b=Zdah1bcrIpuI6JpzHyjA8m2IZYUAzZpNLDIJg7OVN9zMO+PwDLhcnATmAB9wGEkbY
         mMYBqxjFtYb8APic7++CeRlUGKMr+8H4EKjtLw/VqV9z5wwnBF/7WshhbKEyYAgSxs
         7HjThpjhu8mJhXUC7w9usAhmmY4nB+nffjXY1nWwJoTq7sxYfzFLCCcLKcKtWU4JsF
         d4hlVPrrKxfYWXuS5ZZ4ttdOaYkT+uHlPQCHxnuawG+6Gy0MvwBuGlox+RvotU2HmS
         RSHKb8YcAEhwgbx0zhxT5bb00DyvTHIM4YT0GIb1PGKBlBp/plJ+xXYFd472NPzvsi
         +tZCpXYnXU90w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        thomas.preudhomme@celest.fr, adhemerval.zanella@linaro.org,
        Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Kyrylo Tkachov <kyryo.tkachov@arm.com>, gcc-patches@gcc.gnu.org
Subject: [PATCH v5 0/1] implement TLS register based stack canary for ARM
Date:   Mon, 15 Nov 2021 19:04:09 +0100
Message-Id: <20211115180410.5272-1-ardb@kernel.org>
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

Changes since v4:
- add a couple of test cases
- incorporate feedback received from Qing and Kyrylo

Changes since v3:
- force a reload of the TLS register before performing the stack
  protector check, so that we never rely on the stack for the address of
  the canary 
Changes since v2:
- fix the template for stack_protect_test_tls so it correctly conveys
  the fact that it sets the Z flag

Cc: Keith Packard <keithpac@amazon.com>
Cc: thomas.preudhomme@celest.fr
Cc: adhemerval.zanella@linaro.org
Cc: Qing Zhao <qing.zhao@oracle.com>
Cc: Richard Sandiford <richard.sandiford@arm.com>
Cc: Kyrylo Tkachov <kyryo.tkachov@arm.com>
Cc: gcc-patches@gcc.gnu.org

Ard Biesheuvel (1):
  [ARM] Add support for TLS register based stack protector canary access

 gcc/config/arm/arm-opts.h                        |  6 ++
 gcc/config/arm/arm-protos.h                      |  2 +
 gcc/config/arm/arm.c                             | 55 +++++++++++++++
 gcc/config/arm/arm.md                            | 71 +++++++++++++++++++-
 gcc/config/arm/arm.opt                           | 22 ++++++
 gcc/doc/invoke.texi                              | 11 +++
 gcc/testsuite/gcc.target/arm/stack-protector-7.c | 10 +++
 gcc/testsuite/gcc.target/arm/stack-protector-8.c |  5 ++
 8 files changed, 180 insertions(+), 2 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/arm/stack-protector-7.c
 create mode 100644 gcc/testsuite/gcc.target/arm/stack-protector-8.c

-- 
2.30.2

