Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C300C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiAXRs0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbiAXRsZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FC6C06173D
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:48:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97CE261312
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366AFC340E7;
        Mon, 24 Jan 2022 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046504;
        bh=f8Nqb3G0T6NtLnnu+yWZJPJPQixJ1gZNM6Ac/klURW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSsX4x4jLuafE9svL1ozqMSj2vIHSUogLZprQu6STa5uDvHyhKPR5Ui6MET5UFLL0
         M1lYVsFzSCSRCYhWC+7pvhcMP1JmeIvYkO7rRGd6dqeC0I/RsORXI5u5sX3jYVipkm
         NO2dihXElHgvnFpGoX2SqUNAtu33VTpbxGwiBjOJQEpnuQf313hTLDSjqO8jCmcYFM
         Xk5OKRdDWo1ArXYOM900lc14Etipw6/Inc8T4UL4JZqgaiqMMwrUuoIem9CfpanGir
         sUnQbJe5dsvUmA5rCRTHXJrHSBslR+zlDh/gTWJiwXIzQMwtU8h4DHEyry8xSVEGFx
         r1Ch+ZWdFSudA==
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
Subject: [PATCH v5 09/32] ARM: stackprotector: prefer compiler for TLS based per-task protector
Date:   Mon, 24 Jan 2022 18:47:21 +0100
Message-Id: <20220124174744.1054712-10-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513; h=from:subject; bh=f8Nqb3G0T6NtLnnu+yWZJPJPQixJ1gZNM6Ac/klURW4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYTZlMJ78iBD7DO80vedjoony6HHekMDH4mewn2 +dW9rqOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mEwAKCRDDTyI5ktmPJBGDC/ 9PWWz0hXeVkofk4FE7To0upAfk6Hjl707Nfk9hM+c5OyhsKiqh5d4pMQ/qElIST02QtYUeeZFiBX/U 4bPQ+k4+yyVbWj96Rrfbx4js+Nc9sw5Ctd8t7yoAU4VMYneeDCq+mde81W8M/P5LqkOYCJznmqsPgS hEa6YBuOdgGEFsKi7VklY4+RN4d+jz4wb3ZILSg66aQe3EARW1MhY85cnn8uk92BfNlSWGzKn2MKq1 DstFk+fwuoKz+RkVWlBKXorPy3e20BT1/gVmL/W6xfGIZ4GjFpsLp9uhZ7SSkSfGKAcocsh81JY0AS BJomqnJfMUTTrpMSqVIqiZqsudUj+1L3SHdHV6mFfgWnvbuy2KOSF/LGq/fagD8EHo4jGjFIsrxHma YzcS0AFF5dIbQx47UjImm6ftiO7A3Bn9nnfFQcewJx89faxqqpob8z0+Axo1aqhvcL3FPiYG+KdcPh TsdYAeKlBgJN+jjohb8N4qLAw6UCn2yl1egQ0GA+mbHRA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Currently, we implement the per-task stack protector for ARM using a GCC
plugin, due to lack of native compiler support. However, work is
underway to get this implemented in the compiler, which means we will be
able to deprecate the GCC plugin at some point.

In the meantime, we will need to support both, where the native compiler
implementation is obviously preferred. So let's wire this up in Kconfig
and the Makefile.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/Kconfig  | 8 ++++++--
 arch/arm/Makefile | 9 +++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7528cbdb90a1..99ac5d75dcec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1596,10 +1596,14 @@ config XEN
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
 
+config CC_HAVE_STACKPROTECTOR_TLS
+	def_bool $(cc-option,-mtp=cp15 -mstack-protector-guard=tls -mstack-protector-guard-offset=0)
+
 config STACKPROTECTOR_PER_TASK
 	bool "Use a unique stack canary value for each task"
-	depends on GCC_PLUGINS && STACKPROTECTOR && THREAD_INFO_IN_TASK && !XIP_DEFLATED_DATA
-	select GCC_PLUGIN_ARM_SSP_PER_TASK
+	depends on STACKPROTECTOR && THREAD_INFO_IN_TASK && !XIP_DEFLATED_DATA
+	depends on GCC_PLUGINS || CC_HAVE_STACKPROTECTOR_TLS
+	select GCC_PLUGIN_ARM_SSP_PER_TASK if !CC_HAVE_STACKPROTECTOR_TLS
 	default y
 	help
 	  Due to the fact that GCC uses an ordinary symbol reference from
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 77172d555c7e..e943624cbf87 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -275,6 +275,14 @@ endif
 
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
+ifeq ($(CONFIG_CC_HAVE_STACKPROTECTOR_TLS),y)
+stack_protector_prepare: prepare0
+	$(eval KBUILD_CFLAGS += \
+		-mstack-protector-guard=tls \
+		-mstack-protector-guard-offset=$(shell	\
+			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}'\
+				include/generated/asm-offsets.h))
+else
 stack_protector_prepare: prepare0
 	$(eval SSP_PLUGIN_CFLAGS := \
 		-fplugin-arg-arm_ssp_per_task_plugin-offset=$(shell	\
@@ -283,6 +291,7 @@ stack_protector_prepare: prepare0
 	$(eval KBUILD_CFLAGS += $(SSP_PLUGIN_CFLAGS))
 	$(eval GCC_PLUGINS_CFLAGS += $(SSP_PLUGIN_CFLAGS))
 endif
+endif
 
 all:	$(notdir $(KBUILD_IMAGE))
 
-- 
2.30.2

