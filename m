Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C192571B0;
	Wed,  7 Jan 2026 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767753354; cv=none; b=BQOApWnHvKH+UuzTsobaVAKtVK/DAmEUpwxxlzTCw/Slw595RwJBZpTDyxrilA/HCz5ofw9ZEzJ4VoNmzd79u9esVkuesnMS8UTqcMDOf0Pi9e2KvgZjI7Y7AC4oNtgp1ZY7gsKjik5HaNrNPlM+va1+NUw52GjU/Mo5HO0+TJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767753354; c=relaxed/simple;
	bh=afcj8/Yktki+F49rgq+aLQjXw0XH0lkknvdoVZd8CO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P48TUZu4NAXyZTwCENYqvWK1O+FJjZdO+DEhaTmG2v6waQcZRxJDs5oQhXsEcdtBHruBWZFRiCfDP23qRJjLqVZP48nTR/W8EooHCaV+WTRD/y7J3RRkk+edQDmNr0/y0x/ICX6gn+ag/RzJf/WnNCkirli/BK5+dxPNx9vrb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9170d8daeb7111f0a38c85956e01ac42-20260107
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:911157ea-b2c7-402d-99f9-d93fb2246866,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:8b9353df24245199d7e3a69c057cd8e2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9170d8daeb7111f0a38c85956e01ac42-20260107
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1434618029; Wed, 07 Jan 2026 10:35:45 +0800
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
Subject: [PATCH 4/5] riscv: lib: add strchr implementation
Date: Wed,  7 Jan 2026 10:35:16 +0800
Message-Id: <20260107023517.46840-5-jiangfeng@kylinos.cn>
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

Add a basic assembly implementation of strchr() for RISC-V.
This provides a functional byte-by-byte version as a foundation
for future optimizations.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 arch/riscv/include/asm/string.h |  3 +++
 arch/riscv/lib/Makefile         |  1 +
 arch/riscv/lib/strchr.S         | 35 +++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |  5 ++++-
 4 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/strchr.S

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index 16634d67c217..ca3ade82b124 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -31,6 +31,9 @@ extern asmlinkage int strncmp(const char *cs, const char *ct, size_t count);
 
 #define __HAVE_ARCH_STRNLEN
 extern asmlinkage __kernel_size_t strnlen(const char *, size_t);
+
+#define __HAVE_ARCH_STRCHR
+extern asmlinkage char *strchr(const char *, int);
 #endif
 
 /* For those files which don't want to check by kasan. */
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 0969d8136df0..b7f804dce1c3 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -8,6 +8,7 @@ lib-y			+= strcmp.o
 lib-y			+= strlen.o
 lib-y			+= strncmp.o
 lib-y			+= strnlen.o
+lib-y			+= strchr.o
 endif
 lib-y			+= csum.o
 ifeq ($(CONFIG_MMU), y)
diff --git a/arch/riscv/lib/strchr.S b/arch/riscv/lib/strchr.S
new file mode 100644
index 000000000000..48c3a9da53e3
--- /dev/null
+++ b/arch/riscv/lib/strchr.S
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (C) 2025 Feng Jiang <jiangfeng@kylinos.cn>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+
+/* char *strchr(const char *s, int c) */
+SYM_FUNC_START(strchr)
+	/*
+	 * Parameters
+	 *   a0 - The string to be searched
+	 *   a1 - The character to search for
+	 *
+	 * Returns
+	 *   a0 - Address of first occurrence of 'c' or 0
+	 *
+	 * Clobbers
+	 *   t0
+	 */
+	andi	a1, a1, 0xff
+1:
+	lbu	t0, 0(a0)
+	beq	t0, a1, 2f
+	addi	a0, a0, 1
+	bnez	t0, 1b
+	li	a0, 0
+2:
+	ret
+SYM_FUNC_END(strchr)
+
+SYM_FUNC_ALIAS_WEAK(__pi_strchr, strchr)
+EXPORT_SYMBOL(strchr)
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index d7c0533108be..e7b3d748c913 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -2,7 +2,7 @@
 
 purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
 ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
-purgatory-y += strcmp.o strlen.o strncmp.o strnlen.o
+purgatory-y += strcmp.o strlen.o strncmp.o strnlen.o strchr.o
 endif
 
 targets += $(purgatory-y)
@@ -35,6 +35,9 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 $(obj)/strnlen.o: $(srctree)/arch/riscv/lib/strnlen.S FORCE
 	$(call if_changed_rule,as_o_S)
 
+$(obj)/strchr.o: $(srctree)/arch/riscv/lib/strchr.S FORCE
+	$(call if_changed_rule,as_o_S)
+
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
-- 
2.25.1

