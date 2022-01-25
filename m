Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49110C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 09:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbiAYJ12 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:27:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51674 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354906AbiAYJP3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 04:15:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4911CB81730
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 09:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DC6C36AE7;
        Tue, 25 Jan 2022 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643102120;
        bh=xxnXuAM2X8RiqH87OTJXGT/piAFSBEImiMZaqipeFWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhVEcVfPonezSZTM7d+ZSwSgOV68BWZnmo7HO9doqB8+7/GWVIAQMi6Qc7OD7il3P
         bSohmTPQ7oKCTXMIx4asxUIz9JA+h912jeaIEYBGXfxGHZzP6SYJAk2YVqt/9HrP7u
         8OBUHZ5UfX5Ak/UbxiygTke80dM1QrAk+44o8coEkgSXKagjuYUelKVGGdnXvU3PWZ
         hNq3fBNBxGfSRrXWRtBs1ss9DXkV+2DCO8UrRhoTXmH972G15SetSjozttK8fPa7vb
         IHOZH6uDSF4biIEXlymiWgH/qAHRGtgpeWPqJOzNPuMZcbExRk8Nu5D4qfxgujK/wT
         BlG0uF2IsSkiQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v6 7/8] ARM: drop pointless SMP check on secondary startup path
Date:   Tue, 25 Jan 2022 10:14:52 +0100
Message-Id: <20220125091453.1475246-8-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125091453.1475246-1-ardb@kernel.org>
References: <20220125091453.1475246-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=740; h=from:subject; bh=xxnXuAM2X8RiqH87OTJXGT/piAFSBEImiMZaqipeFWI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh77+KoLNbnFvtA845WHBMCSCBH1Wd62Cjt7MlR28K Ryln972JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe+/igAKCRDDTyI5ktmPJL+9C/ 9UbtPJXPKGXGYlhu2Xt6Ks3ysK/ETivNcjSf0FCgR4Udp1Ua/oO/MeCg5c+ELOdwNWTQNpW1sZ5AAC rISQG4vVTh5DpVMh92wW+cOp4TLv/gBkh1UDJW1gLQzWLd3+UyNBEZtEYvQSlcBHRZ9HBLdsWCQR/t kOztlTY5kytaPyjCALqV20nhOKt57bYXi8HyjaECbiM0CqRruarQINXZfi6Wh0yJZ9zMHgxp1sa2Sx sO2EJjDhECunPhnnf//j80qaWvrFMkEh744eCYO7Hadhm6T3kiY2bbpt3K+I752kPU2s05yF3WfR3+ OrqvAfiQClWMEbLIEEQjwJrL9YuLhzFe4z8RBxKnFWjkZhnKxO4bfg+8vqmJXsuccwFalj6UVKrlDK ebhSfn/eWwLv5GKUpUa3irZfGKRnEkZFKVQ18ooBGbFQtcMpjZM6SsXTbOsVHLBs5tOVE9gJW+/pO0 zbK7eD+EkDZwFn4wqL7RqA+f2VCn5/8rR+nj7EPQu31kA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Only SMP systems use the secondary startup path by definition, so there
is no need for SMP conditionals there.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/smp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 951559e5bea3..e34efa96cea1 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -405,11 +405,6 @@ static void smp_store_cpu_info(unsigned int cpuid)
 
 static void set_current(struct task_struct *cur)
 {
-	if (!IS_ENABLED(CONFIG_CURRENT_POINTER_IN_TPIDRURO) && !is_smp()) {
-		__current = cur;
-		return;
-	}
-
 	/* Set TPIDRURO */
 	asm("mcr p15, 0, %0, c13, c0, 3" :: "r"(cur) : "memory");
 }
-- 
2.30.2

