Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09A3C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiAXRtC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbiAXRs7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866ADC06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4404DB811B3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4F2C340EA;
        Mon, 24 Jan 2022 17:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046537;
        bh=hzwr0hRm0pCWjq8l8jbMgr30YPDHah9JCKu9Q1CEuVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2iz2671c6mkQpga7HjcszEkr+8DPtlHaT7ZbGuW2Vd/vOhwat7nMCWjvOGEhfipq
         Fy4bvI7WdJWbAfE1b2v+kvoFitDIrOA2JpVyNW0QjkyKy76+eUHWAc0ouducfrD/6o
         7//McHJszW3Vr+o8PhTLGe7ESMkWkNvqx9WDPIbTivTIvV6/kWL2TkBQSore1TzXyT
         DnIVna4DtibtkR36ExKcM9A47/16QTIDNwys7m0jYHOJK4LjTQsG1s3rjnxx5Czmc/
         whzeWHPZ47x5NI9/YTgWFMP4gvHVEAUXVixcorvrxjXUyY+t750ZcG2M7b4wUhuqGE
         H7j1PN+JFsKhQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v5 19/32] ARM: export dump_mem() to other objects
Date:   Mon, 24 Jan 2022 18:47:31 +0100
Message-Id: <20220124174744.1054712-20-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2268; h=from:subject; bh=hzwr0hRm0pCWjq8l8jbMgr30YPDHah9JCKu9Q1CEuVU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYmpuhMlypzxjM2W6VUAsKIds288nXeM9jZixvH F9Bd1SyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mJgAKCRDDTyI5ktmPJK99C/ 9LlsEA9esIgLotbrsoi80VjC+BBD4ZzTpdi+TjXh1RR9x+zyyGstouS+lK/4TaJmsvCfioILYd11be RmfnPPTeK8SRfaYU//CPawFIK22NMKEEPMkyy2JEv6E+L6EjnGERbeWJ80kN2ynMr9+liCHwldU4CA zOKgYAB/Xujqem1GMHEr2WH0wLpN/AR1pkoWIdEZGHycUsy9S8BxJDcS4ypVmmymFVFH3IyBNId/+P 8AjxZEgusb1fsVjWfeZkxlJK4puWJgNDzjAg5yLsoytZKjLU9lTCkklPlYvU4pgC5Mmq/qdIGkYlmU i+l4priLrsEq7jhRJ3i1Fudp++JyCFay+6ZtKcrZV19CDfyT9UFZgSqYpaz1W80Ju9W9Ou1QKZCFaG CYPFCcVrkvGtvEOCiLdC1PJAkRHqO/YK13lLiNwXTmRUMvwl90mphUPuiClI6/h1xpUdg8MOhQ9vKF eJg29Z2gMG/PbAe+5vxeN1kixg93rh8/lpbgy7bBi9VyY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The unwind info based stack unwinder will make its own call to
dump_mem() to dump the exception stack, so give it external linkage.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/include/asm/stacktrace.h | 2 ++
 arch/arm/kernel/traps.c           | 7 +++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 8f54f9ad8a9b..33ee1aa4b8c0 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -36,5 +36,7 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
 extern int unwind_frame(struct stackframe *frame);
 extern void walk_stackframe(struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
+extern void dump_mem(const char *lvl, const char *str, unsigned long bottom,
+		     unsigned long top);
 
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index da04ed85855a..710306eac71f 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -35,6 +35,7 @@
 #include <asm/ptrace.h>
 #include <asm/unwind.h>
 #include <asm/tls.h>
+#include <asm/stacktrace.h>
 #include <asm/system_misc.h>
 #include <asm/opcodes.h>
 
@@ -60,8 +61,6 @@ static int __init user_debug_setup(char *str)
 __setup("user_debug=", user_debug_setup);
 #endif
 
-static void dump_mem(const char *, const char *, unsigned long, unsigned long);
-
 void dump_backtrace_entry(unsigned long where, unsigned long from,
 			  unsigned long frame, const char *loglvl)
 {
@@ -120,8 +119,8 @@ static int verify_stack(unsigned long sp)
 /*
  * Dump out the contents of some memory nicely...
  */
-static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
-		     unsigned long top)
+void dump_mem(const char *lvl, const char *str, unsigned long bottom,
+	      unsigned long top)
 {
 	unsigned long first;
 	int i;
-- 
2.30.2

