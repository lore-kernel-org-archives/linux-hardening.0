Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E5AC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897FD60FDA
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhJMPZN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhJMPZM (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:25:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3807E60F21;
        Wed, 13 Oct 2021 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138589;
        bh=eQD2BO1y1WN78+tF0zBVscKBClg5cy2UDC7R0JabKQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TYOWcnI8tY/huxcVvWWtPttfLGRsEXOX4QP3lMR9EVzCGFDWrT3GJtaH5UBwoHROj
         gABvvuMrJAhXq7a0P9w6wmyigUGjCWKKfk7/jBjVb/TQOPjjnFHA9nrQhDcOs4E3Gz
         CMFfa+MHdKqeiS5p0eMO+/HyXDAovAgFKsfWbrlgknf2wRbKdNFHPZ2fd02LQs00oS
         FLL8aqzcFeZulzfyr53TH8sn4kZa2ieWXfgfPtYIRbItcRylaDJfJVOI6TkU8NrvxV
         KbTN5lw7C4kDh7vikCQKZBiLThO3cwPtqgpEVMbtd7Qh4V1KEEpa/Fa0/qsuJZFxRM
         e39Z2fKm/04rw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 8/9] arm64: unwind: add asynchronous unwind tables to the kernel proper
Date:   Wed, 13 Oct 2021 17:22:42 +0200
Message-Id: <20211013152243.2216899-9-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
References: <20211013152243.2216899-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; h=from:subject; bh=eQD2BO1y1WN78+tF0zBVscKBClg5cy2UDC7R0JabKQ0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhZvnACwv78YQ+ao61GTYFQpPJL8whagcvyk+2z7hF B4a2nc2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWb5wAAKCRDDTyI5ktmPJB4QDA C5IvWhLaJcK5LFXb2wAHEUkFk4eNXft92/H7nBWwPhlEt21U5OXEGDb/vALqI1sdvfqYRcLRDOZO45 Mc5mkTbYez8PmglVQin5Jnghv6wozsg13BpA0YZjNoud8DzOEnwBAjvq5LrLiWZ0+xssZZeDIqPtaa vuxjiDpGE4QUn+iyV8hgGLkaMfdBib/6EkyT9MLu8XPPrVbGV98qpdpmJdT62iyc8BzyOo+Jn1mpBy IRlUODD3t8keapV5jK3u7gH6xlGCsmaWGgZ2NtGBkMk1BIkDMxr3udDsi5YdYusDMWqC8VgUY1U5TR 38kkJLlIp9PMm9lE3k0KDwdG19uvcIy/WUg9V/sfCX5ktV/FRkJ2zz8hO7bdcmpN0zK+54ne2MNPvA vO0NP9PjhLi+7anPOX1BMx+0G4Pnzflb1YzQmyKuOwY8oTE6IvMBuV8K53QWvKU/knLusfrwvZ/KW0 ZJQ8KcynVidoucRcbzpMylbzvlLOZUCNWBj7hCGqD0GQU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig                    |  3 +++
 arch/arm64/Makefile                   |  7 ++++++-
 arch/arm64/kernel/vmlinux.lds.S       | 20 ++++++++++++++++++++
 drivers/firmware/efi/libstub/Makefile |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 077f2ec4eeb2..742baca09343 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -350,6 +350,9 @@ config KASAN_SHADOW_OFFSET
 	default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
 	default 0xffffffffffffffff
 
+config UNWIND_TABLES
+	bool
+
 source "arch/arm64/Kconfig.platforms"
 
 menu "Kernel Features"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index c744b1e7b356..95ffc4deebb0 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:=--no-undefined -X
+LDFLAGS_vmlinux	:=--no-undefined -X --eh-frame-hdr
 
 ifeq ($(CONFIG_RELOCATABLE), y)
 # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
@@ -45,8 +45,13 @@ KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
 # Avoid generating .eh_frame* sections.
+ifneq ($(CONFIG_UNWIND_TABLES),y)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
 KBUILD_AFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+else
+KBUILD_CFLAGS	+= -fasynchronous-unwind-tables
+KBUILD_AFLAGS	+= -fasynchronous-unwind-tables
+endif
 
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f6b1a88245db..ed3db80bf696 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -111,6 +111,21 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT
 #endif
 
+#ifdef CONFIG_UNWIND_TABLES
+#define UNWIND_DATA_SECTIONS				\
+	.eh_frame_hdr : {				\
+		__eh_frame_hdr = .;			\
+		*(.eh_frame_hdr)			\
+	}						\
+	.eh_frame : {					\
+		__eh_frame_start = .;			\
+		*(.eh_frame)				\
+		__eh_frame_end = .;			\
+	}
+#else
+#define UNWIND_DATA_SECTIONS
+#endif
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from _stext to _edata, must be a round multiple of the PE/COFF
@@ -139,6 +154,9 @@ SECTIONS
 	/DISCARD/ : {
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
+#ifndef CONFIG_UNWIND_TABLES
+		*(.eh_frame_hdr .eh_frame)
+#endif
 	}
 
 	. = KIMAGE_VADDR;
@@ -217,6 +235,8 @@ SECTIONS
 		__alt_instructions_end = .;
 	}
 
+	UNWIND_DATA_SECTIONS
+
 	. = ALIGN(SEGMENT_ALIGN);
 	__inittext_end = .;
 	__initdata_begin = .;
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..78c46638707a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,6 +20,7 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+				   -fno-unwind-tables -fno-asynchronous-unwind-tables \
 				   $(call cc-option,-mbranch-protection=none)
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
-- 
2.30.2

