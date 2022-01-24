Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AF7C4332F
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiAXRtY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244574AbiAXRtR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B4C061749
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1729D612ED
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A668CC36AE3;
        Mon, 24 Jan 2022 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046553;
        bh=7/tPcs0AmFlFig2nf32yKs0oXHAh78N7PZcSvkHYuEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ix2obOLvTb/6d1w5I5g0g94HOPKD4OFWz2YGwtrQlnDFUF56aFaNnfwyABSMPZxpF
         gzXcLgS1t6I64zBhnNOYtUOos6GX48qM6FN41EoTbWBULO7Bx/DXxEpqIGSfZ8tdQI
         c2TfrzDgMnbWLFf5TvUMqjk8tfeDPFJGkaiObNP47JzDUwbpUrXGXP2K5APNngMCol
         +ZjlUV9ZRFZ7KcoffeCo8znRH+cCVzYzaa4/FmL0IsBplhe9ihNoiGXIjdfYXsoSM8
         gUaV1Apos2fHBUUbYcw9jaUUw4GovptdDYrq8StYosSVMVuVGo8SNciGhKTHSNtrh1
         Av6QbJbJzUlfQ==
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
Subject: [PATCH v5 24/32] ARM: run softirqs on the per-CPU IRQ stack
Date:   Mon, 24 Jan 2022 18:47:36 +0100
Message-Id: <20220124174744.1054712-25-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406; h=from:subject; bh=7/tPcs0AmFlFig2nf32yKs0oXHAh78N7PZcSvkHYuEk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYv4B3wns+3iHt4GTJhZo+OVZXNyvKE6fQuPEiS KvEVNBWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mLwAKCRDDTyI5ktmPJLenDA CyQSCZqXOD56Vhh+YnyWJmMe8xfbgBj1bMYXUtsZsP1J9T5rB9Yw7WBHzdzsB8UhY1D22YcB1CFCLu EFJETkK4aJHEPvIg+CkC6o5fypRX5oFxUDi6f0XWNiqHxQfBAkgnPGjVnrAU9OzIgjmsKwHiZM+lUs /uNJMlkcTCrVQryAHrpQKtEnkMjzB/JTPCXHm7gG4p08apbOfnL0cOyQPMHOXgW0iI2D0GvKVAoBk2 7FfV5PWaC5DQ0My4bPaschjK/oS5Bd7vIaXYtOxyUNwjANZVIVQ+ygP/ElGu9LutnOc1D7PoFC5y4Y 7porgJKvrOuBi1czxnwsp33uDXMpaHC5aGKW4OF5Cvur7J7wLfjuOeytImanaKJENlkvgyLAnPkD07 CQGBTyDAN+D81vDmYJD76x1cIujuYMOdwlGueW1oP/PFF0aUWHux/J+v/XPlvx3E8MkWuSFSD1pLKX XOX6foFqjgSDULN8KYdRZng64HDILZahR0hCNdtggoYgM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Now that we have enabled IRQ stacks, any softIRQs that are handled over
the back of a hard IRQ will run from the IRQ stack as well. However, any
synchronous softirq processing that happens when re-enabling softIRQs
from task context will still execute on that task's stack.

Since any call to local_bh_enable() at any level in the task's call
stack may trigger a softIRQ processing run, which could potentially
cause a task stack overflow if the combined stack footprints exceed the
stack's size, let's run these synchronous invocations of do_softirq() on
the IRQ stack as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/Kconfig      |  2 ++
 arch/arm/kernel/irq.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 108a7a872084..b959249dd716 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -128,6 +128,8 @@ config ARM
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
 	select THREAD_INFO_IN_TASK
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 92ae80a8e5b4..380376f55554 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -36,11 +36,14 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/cache-uniphier.h>
 #include <asm/outercache.h>
+#include <asm/softirq_stack.h>
 #include <asm/exception.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
+#include "reboot.h"
+
 unsigned long irq_err_count;
 
 asmlinkage DEFINE_PER_CPU_READ_MOSTLY(u8 *, irq_stack_ptr);
@@ -58,6 +61,17 @@ static void __init init_irq_stacks(void)
 	}
 }
 
+static void ____do_softirq(void *arg)
+{
+	__do_softirq();
+}
+
+void do_softirq_own_stack(void)
+{
+	call_with_stack(____do_softirq, NULL,
+			__this_cpu_read(irq_stack_ptr));
+}
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 #ifdef CONFIG_FIQ
-- 
2.30.2

