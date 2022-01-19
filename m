Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F53C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Jan 2022 17:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbiASRoK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356491AbiASRoJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Jan 2022 12:44:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FCCC06161C
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jan 2022 09:44:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E356961627
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jan 2022 17:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E698AC004E1;
        Wed, 19 Jan 2022 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642614248;
        bh=jq4s/oA0DDjx8jGj6JwzqN5gq/hOGEwIali9Yb3Eh9E=;
        h=From:To:Cc:Subject:Date:From;
        b=KiFIg2AOZW4ijO/rBDSnB/39G6g020zQ6tNGkNvC5Pqf1ONRXMd2l/4DNRPJUudRL
         nC2wljSW+h1IIpjSzx5o2J/wLTuzVF8uE2oifV0ABPCao9j4S8tvaG9sI6LNaH4YoO
         wgJBzcNkVH7HpWwzc1/pqHpvm2Jc7BFfpUiq49B48ZsyPtLuG1/C8on/uN4ImEV9Xq
         2LFcroF/oZJASmj2bz3Jjbx02CAXz6NK4Ffi9E8Pr1C+dcq7KUyZg8Pr6n37we2qY4
         Y7J3mdgtiVA+ECxqXDEshNYwTPArg25kaqd0z4VCLveGTikLF2VGKPbi+sJg8w72Ce
         0WPjkhyc1MDhQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        thomas.preudhomme@celest.fr, adhemerval.zanella@linaro.org,
        Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Kyrylo Tkachov <kyryo.tkachov@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        gcc-patches@gcc.gnu.org
Subject: [PATCH v6 0/1] implement TLS register based stack canary for ARM
Date:   Wed, 19 Jan 2022 18:43:52 +0100
Message-Id: <20220119174353.213723-1-ardb@kernel.org>
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

Changes since v5:
- rebase onto latest changes, including .c -> .cc rename
- ensure that tests execute only on targets that can support them

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
Cc: Richard Earnshaw <Richard.Earnshaw@arm.com>
Cc: gcc-patches@gcc.gnu.org

Ard Biesheuvel (1):
  [ARM] Add support for TLS register based stack protector canary access

 gcc/config/arm/arm-opts.h                        |  6 ++
 gcc/config/arm/arm-protos.h                      |  2 +
 gcc/config/arm/arm.cc                            | 55 +++++++++++++++
 gcc/config/arm/arm.md                            | 71 +++++++++++++++++++-
 gcc/config/arm/arm.opt                           | 22 ++++++
 gcc/doc/invoke.texi                              | 11 +++
 gcc/testsuite/gcc.target/arm/stack-protector-7.c | 12 ++++
 gcc/testsuite/gcc.target/arm/stack-protector-8.c |  7 ++
 8 files changed, 184 insertions(+), 2 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/arm/stack-protector-7.c
 create mode 100644 gcc/testsuite/gcc.target/arm/stack-protector-8.c

-- 
2.30.2

