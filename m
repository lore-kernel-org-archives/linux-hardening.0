Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C58AC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E08760F21
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhJMPZA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhJMPY7 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:24:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA3026113D;
        Wed, 13 Oct 2021 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138576;
        bh=flUoePz/ELcAVPcE4t/3y39R7GhsHD4BKh/RcKQ0z/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hu+vgOE5Q2S9stUfHBDPDugz9oB89WK6gH/XriFHis7aAX7tSXsemgZIWMoyiQqO2
         t1QBMgGqJUBe0iF/3ocgjAEUklT6vBbbcoKKN2+QgEo9qMfLWfYIFscRnZ6XdMMpnI
         WJfetasZ1V1G/B7Xh+Htus9qWG+UhsARVYXNMlv5oAsxZvUnpUu2yCFMA2yclHzM/r
         E8HZLcY+mDCwP2LUJYeITP645O+zaIpv8XdTeRf3QC/PSzSRF6G5YSof63yvOc52N5
         bYm3q5qT0TewizUH+C0FsgWJjbFAQiQHWhGoTrr9LzYdValf0juXFRraBv+fbdUnLb
         HJ2iIjvZd09vg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 1/9] arm64: assembler: enable PAC for non-leaf assembler routines
Date:   Wed, 13 Oct 2021 17:22:35 +0200
Message-Id: <20211013152243.2216899-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
References: <20211013152243.2216899-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; h=from:subject; bh=flUoePz/ELcAVPcE4t/3y39R7GhsHD4BKh/RcKQ0z/A=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhZvmyx1T9ZjfUmm1pG7KbdLlq1l1jOmPiOC7NNXoR hU1cfDCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWb5sgAKCRDDTyI5ktmPJL70DA DGmzNDA3P176nmDyPRGr1hOmSglwN3TvUuOkL/jZIMFs32EjsnNYmO+iShq/g7MCXzc7Hd0QLHr8wy c2WUEEzxpXDr7aYnNw89G5S1s36fOGm8Ys624CxdenYJvD88FO2nqWu9mX+x+5d+5dn2g8IK4Ft5Kb Wru1SnRVcVJdBapduHdYTelK5hvJFr2soctm2EZZB28YPsmUhVJ1LhftuTf9S3thqhtLsKCefJfx6u FnIGGVdomcqPVqKRjbLXlZ2v+UGt3wppn96v//u4oqlAAqfRpWO116lE0NZXdKrIw2igOqBCbWq8Zn J83jIi2eAZukiT1qwaD6OCMeHZ4ZxyHZ6R/R5iBZkNvtZAE2mVE9vDFrQB1knnLxzpK1Q1yhFgbosY ofniB1oyZ0tp7kwjoQjmhCOW65mvithKKIVxhrbrLEaEU1oHqS6bO6vbVR11rMMDrjip8wP5nskcAZ fR0DpBDYKSL5RIgK7rTT63eC5GqR9ZLeH1OEZyV97yst8=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Enable pointer signing and authentication when preserving and restoring
the linker register to/from the stack for assembler routines that use
the frame_push and frame_pop macros to set up their stack frames. This
protects the return address from inadvertent modification while stored
in memory.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 89faca0e740d..ceed84ac4005 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -665,6 +665,9 @@ alternative_endif
 	 *              for locals.
 	 */
 	.macro		frame_push, regcount:req, extra
+#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
+	paciasp
+#endif
 	__frame		st, \regcount, \extra
 	.endm
 
@@ -676,6 +679,9 @@ alternative_endif
 	 */
 	.macro		frame_pop
 	__frame		ld
+#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
+	autiasp
+#endif
 	.endm
 
 	.macro		__frame_regs, reg1, reg2, op, num
-- 
2.30.2

