Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AEE2580EE;
	Wed,  7 Jan 2026 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767753355; cv=none; b=C/Lt4p++KSEulBYrW65Imlj3qP9XZ/cDYJkZInCYloBcJPZMWA9NqtRl+w7G23S1/5t/3V/Ox84n4fkzC7MEhRu+Qd/jnnhjKUS8V3F3OSWi7dKnJ/MQKa9YOsAgAyyqek4owLxDD9RWXHfjC1vHZDOlcFhjjuOpp8HLrZGKUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767753355; c=relaxed/simple;
	bh=8VOL0Zs2hpEUWFrxw5LD+5zqYAq782+6NeoCBbvPCt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqXgFrBmPUXcs51AnPFUu1VlFDkMnOLLDPV+PxAaAx3bFPQU2WLLoPqwiIrFBFFEFxWYpSxhVRv62SrNxW94Y0OtZ2ElKl8mZqDloDitGREfvE9XsLgPS00u/0yu1cxPnReZTs4+UpxaVpyTaaCwR5q4C5UwKcFddyZIumiN0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 923367ceeb7111f0a38c85956e01ac42-20260107
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b69f9738-a2c9-47ec-a0bd-91c176332fd6,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:d05ce87a718a31b61ee8308145217926,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 923367ceeb7111f0a38c85956e01ac42-20260107
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 989859053; Wed, 07 Jan 2026 10:35:46 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kees@kernel.org,
	andy@kernel.org,
	jiangfeng@kylinos.cn,
	ebiggers@kernel.org,
	martin.petersen@oracle.com,
	Jason@zx2c4.com,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	charlie@rivosinc.com,
	ajones@ventanamicro.com,
	nathan@kernel.org,
	linus.walleij@linaro.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 5/5] riscv: lib: add strrchr implementation
Date: Wed,  7 Jan 2026 10:35:17 +0800
Message-Id: <20260107023517.46840-6-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260107023517.46840-1-jiangfeng@kylinos.cn>
References: <20260107023517.46840-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic assembly implementation of strrchr() for RISC-V.
This provides a functional byte-by-byte version as a foundation
for future optimizations.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 arch/riscv/include/asm/string.h |  3 +++
 arch/riscv/lib/Makefile         |  1 +
 arch/riscv/lib/strrchr.S        | 37 +++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |  5 ++++-
 4 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/strrchr.S

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index ca3ade82b124..764ffe8f6479 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -34,6 +34,9 @@ extern asmlinkage __kernel_size_t strnlen(const char *, size_t);
 
 #define __HAVE_ARCH_STRCHR
 extern asmlinkage char *strchr(const char *, int);
+
+#define __HAVE_ARCH_STRRCHR
+extern asmlinkage char *strrchr(const char *, int);
 #endif
 
 /* For those files which don't want to check by kasan. */
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index b7f804dce1c3..735d0b665536 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -9,6 +9,7 @@ lib-y			+= strlen.o
 lib-y			+= strncmp.o
 lib-y			+= strnlen.o
 lib-y			+= strchr.o
+lib-y			+= strrchr.o
 endif
 lib-y			+= csum.o
 ifeq ($(CONFIG_MMU), y)
diff --git a/arch/riscv/lib/strrchr.S b/arch/riscv/lib/strrchr.S
new file mode 100644
index 000000000000..ac58b20ca21d
--- /dev/null
+++ b/arch/riscv/lib/strrchr.S
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (C) 2025 Feng Jiang <jiangfeng@kylinos.cn>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+
+/* char *strrchr(const char *s, int c) */
+SYM_FUNC_START(strrchr)
+	/*
+	 * Parameters
+	 *	a0 - The string to be searched
+	 *	a1 - The character to seaerch for
+	 *
+	 * Returns
+	 *	a0 - Address of last occurrence of 'c' or 0
+	 *
+	 * Clobbers
+	 *	t0, t1
+	 */
+	andi	a1, a1, 0xff
+	mv	t1, a0
+	li	a0, 0
+1:
+	lbu	t0, 0(t1)
+	bne	t0, a1, 2f
+	mv	a0, t1
+2:
+	addi	t1, t1, 1
+	bnez	t0, 1b
+	ret
+SYM_FUNC_END(strrchr)
+
+SYM_FUNC_ALIAS_WEAK(__pi_strrchr, strrchr)
+EXPORT_SYMBOL(strrchr)
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index e7b3d748c913..b0358a78f11a 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -2,7 +2,7 @@
 
 purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
 ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
-purgatory-y += strcmp.o strlen.o strncmp.o strnlen.o strchr.o
+purgatory-y += strcmp.o strlen.o strncmp.o strnlen.o strchr.o strrchr.o
 endif
 
 targets += $(purgatory-y)
@@ -38,6 +38,9 @@ $(obj)/strnlen.o: $(srctree)/arch/riscv/lib/strnlen.S FORCE
 $(obj)/strchr.o: $(srctree)/arch/riscv/lib/strchr.S FORCE
 	$(call if_changed_rule,as_o_S)
 
+$(obj)/strrchr.o: $(srctree)/arch/riscv/lib/strrchr.S FORCE
+	$(call if_changed_rule,as_o_S)
+
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
-- 
2.25.1

