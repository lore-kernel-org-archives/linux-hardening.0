Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA90CCA47F
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Jul 2022 08:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiGAI2t (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 1 Jul 2022 04:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbiGAI2S (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 1 Jul 2022 04:28:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2470E43;
        Fri,  1 Jul 2022 01:27:15 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LZ7Wd62dZzTgCq;
        Fri,  1 Jul 2022 16:23:41 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 16:27:13 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <tglx@linutronix.de>,
        <mark.rutland@arm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: [PATCH -next v3 0/2] powerpc: add support for syscall stack randomization
Date:   Fri, 1 Jul 2022 16:24:33 +0800
Message-ID: <20220701082435.126596-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This patchset adds support for syscall stack randomization for
powerpc, which can make harder the various stack-based attacks that
rely on deterministic stack structure.

Changes in v3:
  -add a lead-up patch to move system_call_exception() to syscall.c to
  avoid disabling stack protector for all functions in interrupt.c
Changes in v2:
  -move choose choose_random_kstack_offset() to the end of system_call_exception
  -allow full 6 (10) bits of entropy
  -disable stack-protector for interrupt.c

Xiu Jianfeng (2):
  powerpc: Move system_call_exception() to syscall.c
  powerpc: add support for syscall stack randomization

 arch/powerpc/Kconfig            |   1 +
 arch/powerpc/kernel/Makefile    |   9 +-
 arch/powerpc/kernel/interrupt.c | 161 ---------------------------
 arch/powerpc/kernel/syscall.c   | 190 ++++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+), 162 deletions(-)
 create mode 100644 arch/powerpc/kernel/syscall.c

-- 
2.17.1

