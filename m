Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73940C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 04:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F08611C3
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 04:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhJOFBb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Oct 2021 01:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235321AbhJOFBa (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Oct 2021 01:01:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61FCB611BD;
        Fri, 15 Oct 2021 04:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634273960;
        bh=/uoHz+FQ9emMCfOnNYpHnuX4+14/9z8ccvDRKSLVoP0=;
        h=Date:From:To:Cc:Subject:From;
        b=Y122mcwLoD/b2wScp+5PQopFaEb6gR0jljnYfdJ8WTuF1/akfspve+cPzp1y3YShC
         v4gV6akOfvRasvStU+V2JIX/cgiXQE7b10eR4iLwC4EgrMeTULlG95nltbW6U4atQm
         aov3vHuN9LLbxQFeXiW4Qu1k1zRGGlD07PpvxB2KzrLLn5jy70kPO4Zrs9bOexCQKi
         ZYg06OMNThgTC4UcTqkCEvveHGrk92/2kAdEhVkh74kd4hjIIFPZUypny/G2aZ4rl7
         fQ/8rhrKbzgLPrKINnYy1i4aEUPeRzIYq79/k8QmFvJ6etlS00hdAJWF1LLLKJa2PY
         lFBD8l1U7shqQ==
Date:   Fri, 15 Oct 2021 00:03:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Haren Myneni <haren@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] powerpc/vas: Fix potential NULL pointer dereference
Message-ID: <20211015050345.GA1161918@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

(!ptr && !ptr->foo) strikes again. :)

The expression (!ptr && !ptr->foo) is bogus and in case ptr is NULL,
it leads to a NULL pointer dereference: ptr->foo.

Fix this by converting && to ||

This issue was detected with the help of Coccinelle, and audited and
fixed manually.

Fixes: 1a0d0d5ed5e3 ("powerpc/vas: Add platform specific user window operations")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/powerpc/platforms/book3s/vas-api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
index 30172e52e16b..4d82c92ddd52 100644
--- a/arch/powerpc/platforms/book3s/vas-api.c
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -303,7 +303,7 @@ static int coproc_ioc_tx_win_open(struct file *fp, unsigned long arg)
 		return -EINVAL;
 	}
 
-	if (!cp_inst->coproc->vops && !cp_inst->coproc->vops->open_win) {
+	if (!cp_inst->coproc->vops || !cp_inst->coproc->vops->open_win) {
 		pr_err("VAS API is not registered\n");
 		return -EACCES;
 	}
@@ -373,7 +373,7 @@ static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	if (!cp_inst->coproc->vops && !cp_inst->coproc->vops->paste_addr) {
+	if (!cp_inst->coproc->vops || !cp_inst->coproc->vops->paste_addr) {
 		pr_err("%s(): VAS API is not registered\n", __func__);
 		return -EACCES;
 	}
-- 
2.27.0

