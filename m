Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DF7C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 09:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573841AbiAYJ10 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:27:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51618 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346478AbiAYJPW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 04:15:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABDEAB81722
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 09:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558B7C340E8;
        Tue, 25 Jan 2022 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643102112;
        bh=5CU3hVcUUrrAtI+VHPsC7I+bj7z+ck1jQdWMKOCM39c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqHrJfQitoYSRKlT8nlXeH17rYUeXXkdWq4Ri8VY3ZaNIAY4ePROSrlStES1SLQGZ
         tEUynmT9fJi7+G/YLK3lcqGJayZqHLM09r+rpLa82AOoUQukyZHMtKcv/w+ym0Mmk/
         ap3JeISqlWIfuW8UrtPP/Zt3BtZSW/eSIpaj/llbbHyuVq3Ak4j9zKBMTn4PTYWqVJ
         9jNbXhq+5eMfccIQ65p063vQuQ5+T3fP6JSdmattMkM4jg88HrWAxyDz4kr4TRNZe4
         k6NKsF4AWw7pZ2vJJnzw1koP6ZMPUZlyf1IKyuN/U+l6G6bjHkxIoczNT6TEHrSX6d
         ugoGlzK59Udcg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v6 4/8] ARM: entry: avoid clobbering R9 in IRQ handler
Date:   Tue, 25 Jan 2022 10:14:49 +0100
Message-Id: <20220125091453.1475246-5-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125091453.1475246-1-ardb@kernel.org>
References: <20220125091453.1475246-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; h=from:subject; bh=5CU3hVcUUrrAtI+VHPsC7I+bj7z+ck1jQdWMKOCM39c=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh77+EKwryGpxQeAF7iDJiZrxU30CtGWxP+u9iQr1c h3df2L6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe+/hAAKCRDDTyI5ktmPJGQSC/ 9+EupbXGT4o1empU/QZzrPVb9vEA67V2uYfZoH7YjTAA9JG7ChZVdPgwj/fMpZ9RbfUUx9jpOxrqGn W6oG9OqIeeNq/k1nJwNunEnEFPTHVygkyshpY1ldJrqR4ltHNNjU/nTmYqd5CInm0kPE6ygmhaNOCF TbgmmmR+JyOsznLhPOtyky6+czopVqHkZdCZobvJ9t2NJYvapMP0zATur1DU8aDcslaG7YKQR+WbhQ zorjyFqw2kRrWMD6eW8nKrANyt+VXX9wkGfJq+3JnpdkmAdLvwsycOmGRAJfURsDLuWFDeIn2JCbsG vSf9fFLgiNdr1VLdn4VlsHOt1n8+SkPyuXkv03oBbBSV8afRcxAVKfyIdobukqne2MzQDmfJC1UNxx RzZJmKmdOQTRIZaukyQ5TJCxKIcNQpCcdOxSYnoCXR9QVOiYhaYEpYovJyybhNWzuqtc5lR7QJZGYx hH61cs/7hrV+TgwYTzfzHCELQQq5Rl92/+Y9w5rQ3pFuY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Avoid using R9 in the IRQ handler code, as the entry code uses it for
tsk, and expects it to remain untouched between the IRQ entry and exit
code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/entry-armv.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index b58bda51e4b8..038aabb6578f 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -38,11 +38,10 @@
 #ifdef CONFIG_UNWINDER_ARM
 	mov	fpreg, sp		@ Preserve original SP
 #else
-	mov	r8, fp			@ Preserve original FP
-	mov	r9, sp			@ Preserve original SP
+	mov	r7, fp			@ Preserve original FP
+	mov	r8, sp			@ Preserve original SP
 #endif
 	ldr_this_cpu sp, irq_stack_ptr, r2, r3
-
 	.if	\from_user == 0
 UNWIND(	.setfp	fpreg, sp		)
 	@
@@ -82,8 +81,8 @@ UNWIND(	.setfp	fpreg, sp		)
 #ifdef CONFIG_UNWINDER_ARM
 	mov	sp, fpreg		@ Restore original SP
 #else
-	mov	fp, r8			@ Restore original FP
-	mov	sp, r9			@ Restore original SP
+	mov	fp, r7			@ Restore original FP
+	mov	sp, r8			@ Restore original SP
 #endif // CONFIG_UNWINDER_ARM
 #endif // CONFIG_IRQSTACKS
 	.endm
-- 
2.30.2

