Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964993815D7;
	Tue, 20 Jan 2026 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892362; cv=none; b=f9YcCo+Xm7f+sqnWXM8fnrP3ShpY09kISiyNNEFLTFJR2ho6trqdzEbfSAfu3kr+TbEBGTt/Vjv5cKjj95TGSpvU/b51C9qR8xRrBKp9wETV1oF1u7HsRVkmmoZq00WF/I3hwH3GTf26+gGyl1fqlXt6ZqOThZ3XyLNv1kyL658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892362; c=relaxed/simple;
	bh=GdH2pY8+pZSHM0wE5KVnv6Gq0OIhbIOgqthm9S4aHhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPtTcqikwAYc8MStbvBE1RbWIJask0oAoYxwNEg+9Jv7pCqvWBIFMXRJoOtTnZ9erOyRdZNqRb1qLMkvpMoo6g1NrhLVbQdPbqqdPaq/qe/z24oBWOn82TU88oAG8xCAgJPFyqTumZMjSFUbNRD7FqbDhqXwQvnVPzmPpmuwQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8058d94cf5cd11f0b0f03b4cfa9209d1-20260120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:445d1891-85fb-4743-a8c0-d2f96e8f4ace,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:0377b55296ab42505135e9029bd3ae39,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8058d94cf5cd11f0b0f03b4cfa9209d1-20260120
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 336366237; Tue, 20 Jan 2026 14:59:01 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	kees@kernel.org,
	andy@kernel.org,
	jiangfeng@kylinos.cn,
	ebiggers@kernel.org,
	martin.petersen@oracle.com,
	ardb@kernel.org,
	charlie@rivosinc.com,
	conor.dooley@microchip.com,
	ajones@ventanamicro.com,
	linus.walleij@linaro.org,
	nathan@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 6/8] riscv: lib: add strnlen implementation
Date: Tue, 20 Jan 2026 14:58:50 +0800
Message-Id: <20260120065852.166857-7-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260120065852.166857-1-jiangfeng@kylinos.cn>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an optimized strnlen() implementation for RISC-V. This version
includes a generic word-at-a-time optimization and a Zbb-powered
optimization using the 'orc.b' instruction, derived from the strlen
implementation.

Benchmark results (QEMU TCG, rv64):
  Length | Original (MB/s) | Optimized (MB/s) | Improvement
  -------|-----------------|------------------|------------
  16 B   | 189             | 310              | +64.0%
  512 B  | 344             | 1535             | +346.2%
  4096 B | 363             | 1854             | +410.7%

Suggested-by: Andy Shevchenko <andy@kernel.org>
Tested-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 arch/riscv/include/asm/string.h |   3 +
 arch/riscv/lib/Makefile         |   1 +
 arch/riscv/lib/strnlen.S        | 164 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 4 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/strnlen.S

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index 5ba77f60bf0b..16634d67c217 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -28,6 +28,9 @@ extern asmlinkage __kernel_size_t strlen(const char *);
 
 #define __HAVE_ARCH_STRNCMP
 extern asmlinkage int strncmp(const char *cs, const char *ct, size_t count);
+
+#define __HAVE_ARCH_STRNLEN
+extern asmlinkage __kernel_size_t strnlen(const char *, size_t);
 #endif
 
 /* For those files which don't want to check by kasan. */
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index bbc031124974..0969d8136df0 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -7,6 +7,7 @@ ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
 lib-y			+= strcmp.o
 lib-y			+= strlen.o
 lib-y			+= strncmp.o
+lib-y			+= strnlen.o
 endif
 lib-y			+= csum.o
 ifeq ($(CONFIG_MMU), y)
diff --git a/arch/riscv/lib/strnlen.S b/arch/riscv/lib/strnlen.S
new file mode 100644
index 000000000000..4af0df9442f1
--- /dev/null
+++ b/arch/riscv/lib/strnlen.S
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Base on arch/riscv/lib/strlen.S
+ *
+ * Copyright (C) Feng Jiang <jiangfeng@kylinos.cn>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/alternative-macros.h>
+#include <asm/hwcap.h>
+
+/* size_t strnlen(const char *s, size_t count) */
+SYM_FUNC_START(strnlen)
+
+	__ALTERNATIVE_CFG("nop", "j strnlen_zbb", 0, RISCV_ISA_EXT_ZBB,
+		IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
+
+
+	/*
+	 * Returns
+	 *   a0 - String length
+	 *
+	 * Parameters
+	 *   a0 - String to measure
+	 *   a1 - Max length of string
+	 *
+	 * Clobbers
+	 *   t0, t1, t2
+	 */
+	addi	t1, a0, -1
+	add	t2, a0, a1
+1:
+	addi	t1, t1, 1
+	beq	t1, t2, 2f
+	lbu	t0, 0(t1)
+	bnez	t0, 1b
+2:
+	sub	a0, t1, a0
+	ret
+
+
+/*
+ * Variant of strnlen using the ZBB extension if available
+ */
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
+strnlen_zbb:
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+# define CZ	clz
+# define SHIFT	sll
+#else
+# define CZ	ctz
+# define SHIFT	srl
+#endif
+
+.option push
+.option arch,+zbb
+
+	/*
+	 * Returns
+	 *   a0 - String length
+	 *
+	 * Parameters
+	 *   a0 - String to measure
+	 *   a1 - Max length of string
+	 *
+	 * Clobbers
+	 *   t0, t1, t2, t3, t4
+	 */
+
+	/* If maxlen is 0, return 0. */
+	beqz	a1, 3f
+
+	/* Number of irrelevant bytes in the first word. */
+	andi	t2, a0, SZREG-1
+
+	/* Align pointer. */
+	andi	t0, a0, -SZREG
+
+	li	t3, SZREG
+	sub	t3, t3, t2
+	slli	t2, t2, 3
+
+	/* Aligned boundary. */
+	add	t4, a0, a1
+	andi	t4, t4, -SZREG
+
+	/* Get the first word.  */
+	REG_L	t1, 0(t0)
+
+	/*
+	 * Shift away the partial data we loaded to remove the irrelevant bytes
+	 * preceding the string with the effect of adding NUL bytes at the
+	 * end of the string's first word.
+	 */
+	SHIFT	t1, t1, t2
+
+	/* Convert non-NUL into 0xff and NUL into 0x00. */
+	orc.b	t1, t1
+
+	/* Convert non-NUL into 0x00 and NUL into 0xff. */
+	not	t1, t1
+
+	/*
+	 * Search for the first set bit (corresponding to a NUL byte in the
+	 * original chunk).
+	 */
+	CZ	t1, t1
+
+	/*
+	 * The first chunk is special: compare against the number
+	 * of valid bytes in this chunk.
+	 */
+	srli	a0, t1, 3
+
+	/* Limit the result by maxlen. */
+	bleu	a1, a0, 3f
+
+	bgtu	t3, a0, 2f
+
+	/* Prepare for the word comparison loop. */
+	addi	t2, t0, SZREG
+	li	t3, -1
+
+	/*
+	 * Our critical loop is 4 instructions and processes data in
+	 * 4 byte or 8 byte chunks.
+	 */
+	.p2align 3
+1:
+	REG_L	t1, SZREG(t0)
+	addi	t0, t0, SZREG
+	orc.b	t1, t1
+	bgeu	t0, t4, 4f
+	beq	t1, t3, 1b
+4:
+	not	t1, t1
+	CZ	t1, t1
+	srli	t1, t1, 3
+
+	/* Get number of processed bytes. */
+	sub	t2, t0, t2
+
+	/* Add number of characters in the first word.  */
+	add	a0, a0, t2
+
+	/* Add number of characters in the last word.  */
+	add	a0, a0, t1
+
+	/* Ensure the final result does not exceed maxlen. */
+	bgeu	a0, a1, 3f
+2:
+	ret
+3:
+	mv	a0, a1
+	ret
+
+.option pop
+#endif
+SYM_FUNC_END(strnlen)
+SYM_FUNC_ALIAS(__pi_strnlen, strnlen)
+EXPORT_SYMBOL(strnlen)
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 530e497ca2f9..d7c0533108be 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -2,7 +2,7 @@
 
 purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
 ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
-purgatory-y += strcmp.o strlen.o strncmp.o
+purgatory-y += strcmp.o strlen.o strncmp.o strnlen.o
 endif
 
 targets += $(purgatory-y)
@@ -32,6 +32,9 @@ $(obj)/strncmp.o: $(srctree)/arch/riscv/lib/strncmp.S FORCE
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
+$(obj)/strnlen.o: $(srctree)/arch/riscv/lib/strnlen.S FORCE
+	$(call if_changed_rule,as_o_S)
+
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
-- 
2.25.1

