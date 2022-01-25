Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC9C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 09:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457368AbiAYJ1M (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:27:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51562 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457384AbiAYJPM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 04:15:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12473B81733
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 09:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D1FC36AE3;
        Tue, 25 Jan 2022 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643102104;
        bh=Z8MsypEn9Y0/+dIdTvMJ9ObEDee5JffC7z7a9ZlDRwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j929Y1IN0v4Wou2FtQSOKTk8hqcdwV5NoPFU+5ZtvovoqvmGt06k6gAABgP1Tflh6
         aNRrL8L3K9AUMQrd5KRwRAvoGOy4PmYonM5797122paqH473E5G/a+oIeRJn0Ml0s3
         gB43IK+OcBr5VV2y5oUrbIEiFW62uqWucn0HvJnmg8ur62k5jxL+2kSxM+XSRtZpbL
         74JFauANtj2WnML95YORL9f3EbO3d5e86q+U6wIwKN+xJphXx6dQIqZoG5+h8Vev89
         XTsjIS+CFSErXjUGo5+BvWxmgWXAJJllPqMn5nEumOWQXcuNMA/hy6KQHR3HzplcCb
         UQsabz+TbtUig==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v6 1/8] ARM: mm: switch to swapper_pg_dir early for vmap'ed stack
Date:   Tue, 25 Jan 2022 10:14:46 +0100
Message-Id: <20220125091453.1475246-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125091453.1475246-1-ardb@kernel.org>
References: <20220125091453.1475246-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345; h=from:subject; bh=Z8MsypEn9Y0/+dIdTvMJ9ObEDee5JffC7z7a9ZlDRwU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh779+uXtZ6ZtwzCio7m54DHr+Vq4QdkXWtPJmjewv EqoJZZiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe+/fgAKCRDDTyI5ktmPJDf2C/ 0TcbEkS8EQzCAFhz/j/KZfj85LqF+tMqirRf6cC7Tv6vPNS0xWXSfCen2IextmidRn9LGxAyYZ5Cwl sKOtV8qjz2YR8T602wzuWUMyJQsG/XhIVdyaijJQbhdmFqUw0g5uI0V7YISFuA6FIJ/rkIo24D2ymU QFJrFC5HVab8HAdjEL2AXcfFprN2vUKzjSQ0GzGx/Gfc9rJrx5Bo/eudHGE62yJ6x/t8zme2WI9smh kKyJt7ys/JZbVwlusQZmqEHcl2lu8DjOTNlLe4Pq8A54MDZmvgqKKA1AWUhhxxQ6ZTjbHMxTJvkqe8 WzOOgODJvobJA/70Gp/oIZvnzBXBnmc+Vjyzipwx2pEGrVNyhIkg+UCvIICOd6dlTwZoyGGlTOhFBU 3ySp9ql7wyRcuzumSpu/Pp/C/RpkeYDnX44PopnI6xzxxj4pyaLWbNzB9FqkmjwNDhq9JDv8Iugrfk Le3Ksd7pPtAbFf/g6NH6aPIGeZh1sGNVQ5bIdaUiha/O0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When onlining a CPU, switch to swapper_pg_dir as soon as possible so
that it is guaranteed that the vmap'ed stack is mapped before it is
used.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/Kconfig        | 2 +-
 arch/arm/kernel/head.S  | 7 +++++++
 arch/arm/kernel/sleep.S | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c32b79453ddf..359a3b85c8b3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -128,7 +128,7 @@ config ARM
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
 	select THREAD_INFO_IN_TASK
-	select HAVE_ARCH_VMAP_STACK if MMU && (!LD_IS_LLD || LLD_VERSION >= 140000) && !PM_SLEEP_SMP
+	select HAVE_ARCH_VMAP_STACK if MMU && (!LD_IS_LLD || LLD_VERSION >= 140000)
 	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index c04dd94630c7..500612d3da2e 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -424,6 +424,13 @@ ENDPROC(secondary_startup)
 ENDPROC(secondary_startup_arm)
 
 ENTRY(__secondary_switched)
+#if defined(CONFIG_VMAP_STACK) && !defined(CONFIG_ARM_LPAE)
+	@ Before using the vmap'ed stack, we have to switch to swapper_pg_dir
+	@ as the ID map does not cover the vmalloc region.
+	mrc	p15, 0, ip, c2, c0, 1	@ read TTBR1
+	mcr	p15, 0, ip, c2, c0, 0	@ set TTBR0
+	instr_sync
+#endif
 	adr_l	r7, secondary_data + 12		@ get secondary_data.stack
 	ldr	sp, [r7]
 	ldr	r0, [r7, #4]			@ get secondary_data.task
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index f909baf17912..a86a1d4f3461 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -119,6 +119,13 @@ ENTRY(cpu_resume_mmu)
 ENDPROC(cpu_resume_mmu)
 	.popsection
 cpu_resume_after_mmu:
+#if defined(CONFIG_VMAP_STACK) && !defined(CONFIG_ARM_LPAE)
+	@ Before using the vmap'ed stack, we have to switch to swapper_pg_dir
+	@ as the ID map does not cover the vmalloc region.
+	mrc	p15, 0, ip, c2, c0, 1	@ read TTBR1
+	mcr	p15, 0, ip, c2, c0, 0	@ set TTBR0
+	instr_sync
+#endif
 	bl	cpu_init		@ restore the und/abt/irq banked regs
 	mov	r0, #0			@ return zero on success
 	ldmfd	sp!, {r4 - r11, pc}
-- 
2.30.2

