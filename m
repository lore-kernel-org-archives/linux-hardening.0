Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23821C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Feb 2022 06:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiBXGFg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Feb 2022 01:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBXGFe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Feb 2022 01:05:34 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B725A265BF8
        for <linux-hardening@vger.kernel.org>; Wed, 23 Feb 2022 22:05:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso1165938pjb.2
        for <linux-hardening@vger.kernel.org>; Wed, 23 Feb 2022 22:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82MmwUc8o7P6eSkoZhMk8vJ2+4mF0+LmGq2ZAostdm0=;
        b=lHn2GVYWVbS7Odcx61VFV1D/S1uqMQSC9DJPpltVuvznbDO0fPDmKj3PQ0lS/uBxV7
         WCzWCYM2wPQHrpyhfUm6h/jIoatb7iFaA+HZEXp64AS2Cdi630t4MPFVNzZQ93JJhSie
         phEU/Hs8l9TwgK36FsEe7N0sMfftBcT3jP6tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82MmwUc8o7P6eSkoZhMk8vJ2+4mF0+LmGq2ZAostdm0=;
        b=4qKKW5TkD6LSN7QH89cjamLg1lz5hXI/xlaI002Q97b2g2Ln1pWHHom+zKmZBmlMX3
         YszXhsBG358Rk8278HSPh2V//4DqMhhGqotmlNR91+m08+4yxcz8PufPOn3QJDoummY3
         CHSTsal4KTfSWIOFn0aEZWXMvNTd1bmi+51ZQYohrmL9XiFK7Wimtqb/QADoT7qsLEgp
         zKRlum2unBHtNYd1tU+WI5IAkk8tPtEjSAr9bQz156ICdTjTkMeW1EC6p9AbvRPbXGIk
         w7vUn2i3YkJUsIb5J6syGDj+jb8Vu9PDVkx4E9NYICr62EnYGT1S+nxdI9NyKgvs0Fb6
         MGQw==
X-Gm-Message-State: AOAM532QFUrMmEWwp4TY226Jy36YV465PdA/5LVv64QA/+QrhazOPJy9
        blb/ebJKDmvgctJfbpNR69Oa8w==
X-Google-Smtp-Source: ABdhPJxE8wepPMfDDiCHF8gLBA6P2nBpsQzR4IqYhRz3fDE2FdPbBrMX2B9jLfEtmIElrdbpXbtupA==
X-Received: by 2002:a17:902:ac86:b0:14f:c031:bca4 with SMTP id h6-20020a170902ac8600b0014fc031bca4mr1099986plr.78.1645682705237;
        Wed, 23 Feb 2022 22:05:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8sm1702333pfv.84.2022.02.23.22.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:05:05 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Chris Zankel <chris@zankel.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] xtensa: Implement "current_stack_pointer"
Date:   Wed, 23 Feb 2022 22:05:03 -0800
Message-Id: <20220224060503.1856302-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2579; h=from:subject; bh=T/1d5Fi9wAEwTAvkwecbkf1GH8x0d+o9uLdTW5ZQ2xY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFyAOBqHIXtHY4fT4FeLuWhjYO//kkJDQeKiMKwOj QWtEquGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcgDgAKCRCJcvTf3G3AJjpjEA CbYAbl/43DjcAY28rb6d9MkHlyv0UyUidhcuN0LTfUZ9Bza1RXMncDGugnPHX/WpTMVPrVimaC7b/8 5KjUrXu7IDgYNaRlVot0LiCDeLn8V6brOClkMbt6f77sXlyT/HiNtVsmYG9BjLlei+GZd9IgEJAL/D VAkvXUFUcVK4GIyq+1PT0srp/o7I2k0UECPotvvVGx5aMn1JnDyhFDrJbxv2SybWwi+2mKfBpaMvjb ISsaeJG9dHUoVoQcdaqijtku/mXAziPvvNtR2yaJV5HRPsFvh3S7s8NcMd4W/E3rOVIU8aNYfsn357 XSP+T9W6Bln9hru6PnsvzNp1rB8YuJrsbkikEbhL7SR2xNvamOyzyeYxMs9nattZF0BmcOH7uvzxNl dg7djzkgtQ8XqnQ54aOrwRMpIBhGx45CRPqYv+m1osCcHQLGBEMCsBkK/l1JHEFqmcieVHgXCuuw9R 4eknZyM1orIiwV2WynNr38AAnWP2XcmFsi2MJNj6JvDlFiWv2LJ+yUFa4xsswSmdTBm67DRJRDH+Ca zXxpTQIDYslJOKZVJIPXhkbjycHOfQNoedTQmJjf3jcldIXK+/ZcWJWKgRhCsDtsNoyrOm1QtPCRJq pv19mEZlljKlKl+vIF4J950MQfPRGhtbdtlnsEvszYoRLkFwjbp0kzAZnTaw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

To follow the existing per-arch conventions replace open-coded uses
of asm "sp" as "current_stack_pointer". This will let it be used in
non-arch places (like HARDENED_USERCOPY).

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/xtensa/Kconfig                  | 1 +
 arch/xtensa/include/asm/current.h    | 2 ++
 arch/xtensa/include/asm/stacktrace.h | 2 +-
 arch/xtensa/kernel/irq.c             | 3 +--
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 8ac599aa6d99..887432327613 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -3,6 +3,7 @@ config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT if !MMU
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DMA_PREP_COHERENT if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU
diff --git a/arch/xtensa/include/asm/current.h b/arch/xtensa/include/asm/current.h
index 5d98a7ad4251..08010dbf5e09 100644
--- a/arch/xtensa/include/asm/current.h
+++ b/arch/xtensa/include/asm/current.h
@@ -26,6 +26,8 @@ static inline struct task_struct *get_current(void)
 
 #define current get_current()
 
+register unsigned long current_stack_pointer __asm__("a1");
+
 #else
 
 #define GET_CURRENT(reg,sp)		\
diff --git a/arch/xtensa/include/asm/stacktrace.h b/arch/xtensa/include/asm/stacktrace.h
index fe06e8ed162b..4d84fd6bd43c 100644
--- a/arch/xtensa/include/asm/stacktrace.h
+++ b/arch/xtensa/include/asm/stacktrace.h
@@ -22,7 +22,7 @@ static __always_inline unsigned long *stack_pointer(struct task_struct *task)
 	unsigned long *sp;
 
 	if (!task || task == current)
-		__asm__ __volatile__ ("mov %0, a1\n" : "=a"(sp));
+		sp = current_stack_pointer;
 	else
 		sp = (unsigned long *)task->thread.sp;
 
diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index 15051a8a1539..529fe9245821 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -36,9 +36,8 @@ asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
 	{
-		unsigned long sp;
+		unsigned long sp = current_stack_pointer;
 
-		__asm__ __volatile__ ("mov %0, a1\n" : "=a" (sp));
 		sp &= THREAD_SIZE - 1;
 
 		if (unlikely(sp < (sizeof(thread_info) + 1024)))
-- 
2.30.2

