Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E94C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbiAXRsY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiAXRsX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC7C06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:48:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11A06B811AC
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E216CC340E5;
        Mon, 24 Jan 2022 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046500;
        bh=7DENFUqX6QUcNqYG/pBBlPLnnfMOmgh0iQQhcDzMsQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHOi4VRlkF2qKjHQzK6ewS5e/MKEYXnoQJP11Hjvb5UoI6uxipX3uUhzmM+G1TewU
         3rGfaOwK7pJwGZ5qWLooUSoHTt/jUw9qjE/VofWimO15I6qS7O9jhjGp2WMz5OAVVG
         XLHlHz+UTHuJhnxmuV1vJaZCpe1VZlkxj+MiKbYUCP6TezcntFzi0SdFRbGVTx6VY9
         3pvO90WF5U0S00SQY7wLN78bmWf6wQX0vzD6S+waAyQWkjfG3gDI5qkxryVLTN6fFd
         bGqU/bciDZiS0HdSEIYKq2HftS3F+rfpDFNFFZmegjDXv6KIIMT/xlb6n7f6TCmAz5
         0bf3pezXKdH2w==
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
Subject: [PATCH v5 08/32] ARM: decompressor: disable stack protector
Date:   Mon, 24 Jan 2022 18:47:20 +0100
Message-Id: <20220124174744.1054712-9-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287; h=from:subject; bh=7DENFUqX6QUcNqYG/pBBlPLnnfMOmgh0iQQhcDzMsQM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYRw1vg9bTWrzxjXxct6bFRDnUedQU8GtMkJfgP H7BPCmmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mEQAKCRDDTyI5ktmPJIbQC/ 9VmBkgyHhKLbiux61LpaifaTnN5QBo9JOHIzL2TlbP0QlVjuJIr7dj0ToJMb/dLZJWEeLaC9UL/yt8 hUq2Y48C6y3j8JmWAFa59MLb0ydXoc6wd9UydwmFTW2uCYoqYi45MxxJ7V8e+Ar/6TH2kRWRdp8HyX MRBVBWVtoQcozJzRBuSzljR+JwQX6DYZG5SeTMWe+jMqCT8y7i86hCL8AOi5MOrpv8rIzbyFjsCMom u0x9w1NXBL1y/ObHlW9c3CSags7XvEDYnAD9olWirLdgd/hbvSw7oX62A6otFbqMBCfyd8Lk/QYvsf Txb9aUiidG+R4ly0QZMbF+oosuQjIL1ygZXW0K4j8QSh+XlPs7Ezz5JlAFHlaacRKgET6418zAGUOy g7ut3zUs+aDF9iqw/mwNQwRpMiQjtWHZWUNdelfx8GXJM/5pKRocbZ++fnqzKGDJI8lbrcT9OD9EUz LSw/AzxQSFZFEvF9bwS8yJSaOnstLaSWOc1hmh5AAFv1o=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Enabling the stack protector in the decompressor is of dubious value,
given that it uses a fixed value for the canary, cannot print any output
unless CONFIG_DEBUG_LL is enabled (which relies on board specific build
time settings), and is already disabled for a good chunk of the code
(libfdt).

So let's just disable it in the decompressor. This will make it easier
in the future to manage the command line options that would need to be
removed again in this context for the TLS register based stack
protector.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/Makefile | 6 +-----
 arch/arm/boot/compressed/misc.c   | 7 -------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 954eee8a785a..187a187706cb 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -92,17 +92,13 @@ ifeq ($(CONFIG_USE_OF),y)
 OBJS	+= $(libfdt_objs) fdt_check_mem_start.o
 endif
 
-# -fstack-protector-strong triggers protection checks in this code,
-# but it is being used too early to link to meaningful stack_chk logic.
-$(foreach o, $(libfdt_objs) atags_to_fdt.o fdt_check_mem_start.o, \
-	$(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt -fno-stack-protector))
-
 targets       := vmlinux vmlinux.lds piggy_data piggy.o \
 		 head.o $(OBJS)
 
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 
 ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin \
+	     -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
 	     -I$(obj) $(DISABLE_ARM_SSP_PER_TASK_PLUGIN)
 ccflags-remove-$(CONFIG_FUNCTION_TRACER) += -pg
 asflags-y := -DZIMAGE
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index e1e9a5dde853..c3c66ff2d696 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -128,13 +128,6 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
 
-const unsigned long __stack_chk_guard = 0x000a0dff;
-
-void __stack_chk_fail(void)
-{
-	error("stack-protector: Kernel stack is corrupted\n");
-}
-
 extern int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
 
 
-- 
2.30.2

