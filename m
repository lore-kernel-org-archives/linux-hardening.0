Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA74028DE
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199243; cv=none; b=HGs9iBzK13X4uY+LsRRmzjSmTX/9+WkXAIukzxws2sYTdjJX9ss5J49FkoyV82uI4mnJRU1cffadPJoAN/0nS35VGa511UvZDDwwf6upUFxwXL4budNW6VOj1BLYprDYbxV3zhFG8+RXg+84gIKmAEp27tGN27pmpZkz2h1/FCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199243; c=relaxed/simple;
	bh=n0E2lDML1l8mOysQKHNgZZUgw9bXTxT4damLfxTShgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4H1iBkhKAYnIzXEIsr3CQKHAfsuBNCxzQ6jjyzmGKZtTPoyOeued5kObJUzeVzz7e2lbkR5Gw8dwII7uz+3e6tNEJ4FcGWt4N7awNxiyd/MmCnlkmQ7bUj/O0uJ/S7DkH52+wuiY9jMrcRqby6c1cVDr83j3v1X7wGBWysCxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoJ14Fnb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoJ14Fnb"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48fde648a71so26344775e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779199240; x=1779804040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7GQ3Lzv1zsJ5so1gCOAqFSPiY4qAFEC2q/y3GviMUk=;
        b=FoJ14Fnb6uP2vXvotkokDrbEyZzvOnwHwjnzCpc+Z0ZO0nVoQB5tJRjMJ//4epFpIH
         W2fz4VR5V53oELoOHJVWauqYn2d+XSRc+S9Rn5beKUwbk7t3lxMYtbEtRXbbzhm/i86E
         ZxSVTbUHKSD1tw66IVZ0Kj9ULHIfm3m2JA4AurtZS3Oka0HBItIaNUG/L9jEgmOfQa3/
         hetFOLEwyW0HXPV3nZZtl+hfDn66HrYNGy04E4Ttm1c3onoApK9w7MNxbC+OVqLr1GHN
         Okzjt5rT5psqi2Utl9k9FUR8NRk1SqK2oy8IiNCH94JJM3A+BAlKzKtdJO0zLLw4iUuT
         PMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199240; x=1779804040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7GQ3Lzv1zsJ5so1gCOAqFSPiY4qAFEC2q/y3GviMUk=;
        b=cJYRT59YiYjiKd5ygH+obRlSo2wZsigBau2UnhaPZMUL+/w7T+cXeCLo+cuWE6UiGp
         U/gKk+GWBHMAqVmwcJjfyeH7BRNtd0oPEEbVqOkVMZStMiD93iRt6rEqL43b7dLnOkDE
         TdCY2iq66xrPxAGPmLGjb+lPcDN+qK8ohTyWQgL1T7KMV4mie/C0CBBpAANZNW9Zc+Gc
         XXQNeg7gQ8ibnfUWKI1JxHfE6xOAcJyHwp4bb9oPc1ysvDeepuR2Wy3FCHepoHDOw4xh
         iieZY+UmeFMD6W53cK6mph7a5wvoCh9Y4RUVMdWAcxgSadaVbK0Zk0ilSJH1W5HxiDOe
         cwJA==
X-Forwarded-Encrypted: i=1; AFNElJ+F3w/bbQQPTM0w7DzFlcc0MeskI2oE6UaDJmV+7ODaKcE8GF2En7TQd0nBX6eVRPJ6GNGfAWvOarCVysZxnHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNvDin12o7fdKOuU1OoJfbS0hyM9feIRMeu6VRc3fBSs8ffmG+
	aUfKwoZuFxE6ql/790qHgx4lx9cvt5OKEWgu+zgED4uyQkaiCcBH3zQa
X-Gm-Gg: Acq92OFd5VDfzHT1M1AyIftLdcw767xlLvCEmR/mv2HVXuwMzLVqvOt4OLcDhxH7dX+
	Whvo4crymt3Csc16BDPaCi0b1RDPc8kZLanhi6Qf4sWhPV4rJnEkW+d70tPkQhx43oGoPOiThjI
	/0rLX/U8uQEDw3gzrySJZD4Z20xz0ofu060c883TAGVkAtl/Pf1iIFP996UKo4LKZpRj3zdho1S
	6/J7iRx2X/USANs8v305d0eLvwrzmGofQFoeHHegHJB88nT8iKL5TxDnrhlOchD3v9/UGnlhf5H
	2mIkoPEdJ/evLCxxq5TJHP3wqgTB2meG7+wMutRaFD5UMnKkSAs2YVq2yFTRYSpUG1TVCc3zOsi
	JDj1wx7/Y4Al4d5/N4uSMmpJLIwjlOguybTjMcdInq1E47kTvjv7mSP3IZE8ik33hu8cVJ/l4W0
	hYK1iBTgsU6Adm+HhT90BuH4yBgpNxx1jp1gC//+D/0fIKd9MhyAg=
X-Received: by 2002:a05:600c:b55:b0:48a:5ee0:7781 with SMTP id 5b1f17b1804b1-48fd636ae2fmr272682745e9.16.1779199239456;
        Tue, 19 May 2026 07:00:39 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([95.86.49.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm44065144f8f.3.2026.05.19.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:00:39 -0700 (PDT)
From: Milan Tripkovic <milant2002@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	kees@kernel.org
Cc: alex@ghiti.fr,
	andy@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dusan.Stojkovic@rt-rk.com,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: [PATCH v5 1/2] riscv: lib: add memcmp() implementation
Date: Tue, 19 May 2026 16:00:28 +0200
Message-ID: <20260519140029.1190381-2-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519140029.1190381-1-milant2002@gmail.com>
References: <20260519140029.1190381-1-milant2002@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

Add an assembly implementation of memcmp() for RISC-V. The implementation
uses word-aligned loads for the generic path and the ZBB extension for
optimized sign resolution, with an assembly fallback for non-ZBB systems.

Benchmark results (QEMU TCG, rv64):

 Len   | Default |NoALIGN | ALIGN  | %NoALIGN | %ALIGN
 ------|---------|--------|--------|----------|--------
 1 B   | 20.3    | 21.5   | 20.9   | +5.9%    | +3.0%
 7 B   | 88.9    | 96.9   | 155.7  | +9.0%    | +75.1%
 8 B   | 89.6    | 110.5  | 176.2  | +23.3%   | +96.7%
 16 B  | 134.4   | 172.8  | 334.8  | +28.6%   | +149.1%
 31 B  | 163.5   | 211.9  | 606.2  | +29.6%   | +270.8%
 64 B  | 203.8   | 240.3  | 968.6  | +17.9%   | +375.3%
 127 B | 224.6   | 269.0  | 1362.8 | +19.8%   | +506.8%
 512 B | 235.7   | 269.9  | 1913.7 | +14.5%   | +711.9%
 1024 B| 256.8   | 283.5  | 2123.6 | +10.4%   | +726.9%
 4096 B| 263.8   | 299.7  | 2290.4 | +13.6%   | +768.2%
 
Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
---
v5 changes:
    - Optimized generic memcmp path with word-aligned loads.
    - Implemented non-ZBB fallback to byte comparison per review.
    - Link to v4: https://lore.kernel.org/all/20260518131407.1026049-2-milant2002@gmail.com/

v2 changes:
    - Added alignment checks for buffers to avoid expensive misaligned loads.
    - Optimized the loop using end-pointers to reduce per-iteration overhead.
    - Implemented word-aligned tail handling using ZBB shifts.
    - Removed redundant pointer equality (a0 == a1) check.
    - Retained BE support via #ifndef; ZBB rev8 is used for the LE fast-path.
    - Link to v1: https://lore.kernel.org/all/20260512141007.1193033-1-milant2002@gmail.com/

 arch/riscv/include/asm/string.h |   2 +
 arch/riscv/lib/Makefile         |   1 +
 arch/riscv/lib/memcmp.S         | 106 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 4 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/memcmp.S

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index 764ffe8f6..5c5299678 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -18,6 +18,8 @@ extern asmlinkage void *__memcpy(void *, const void *, size_t);
 #define __HAVE_ARCH_MEMMOVE
 extern asmlinkage void *memmove(void *, const void *, size_t);
 extern asmlinkage void *__memmove(void *, const void *, size_t);
+#define __HAVE_ARCH_MEMCMP
+extern asmlinkage int memcmp(const void *, const void *, size_t);
 
 #if !(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 #define __HAVE_ARCH_STRCMP
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 6f767b2a3..b529e1be1 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -3,6 +3,7 @@ lib-y			+= delay.o
 lib-y			+= memcpy.o
 lib-y			+= memset.o
 lib-y			+= memmove.o
+lib-y			+= memcmp.o
 ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
 lib-y			+= strcmp.o
 lib-y			+= strlen.o
diff --git a/arch/riscv/lib/memcmp.S b/arch/riscv/lib/memcmp.S
new file mode 100644
index 000000000..cb71cd5ae
--- /dev/null
+++ b/arch/riscv/lib/memcmp.S
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/alternative-macros.h>
+#include <asm/hwcap.h>
+
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
+.option push
+.option arch,+zbb
+#endif
+
+/* int memcmp(const void *cs, const void *ct, size_t n) */
+SYM_FUNC_START(memcmp)
+/*
+ * Parameters
+ *	a0 - Pointer to first memory block (cs), also return value
+ *	a1 - Pointer to second memory block (ct)
+ *	a2 - Number of bytes to compare (n), decremented during loop
+ *
+ * Returns
+ *	a0 - 0 if equal, positive if cs > ct, negative if cs < ct
+ *
+ * Clobbers
+ *	t0, t1, t2, t3, t4
+ */
+	add	t3, a0, a2
+	or	t0, a0, a1
+	andi	t0, t0, (SZREG - 1)
+	bnez	t0, 5f
+
+	addi	t4, t3, -SZREG
+	bltu	t4, a0, 7f
+
+1:
+	REG_L	t1, 0(a0)
+	REG_L	t2, 0(a1)
+	bne	t1, t2, 2f
+	addi	a0, a0, SZREG
+	addi	a1, a1, SZREG
+	bleu	a0, t4, 1b
+
+#if defined(CONFIG_TOOLCHAIN_HAS_ZBB)
+7:
+	__ALTERNATIVE_CFG("j 5f", "nop", 0, RISCV_ISA_EXT_ZBB,
+			  IS_ENABLED(CONFIG_RISCV_ISA_ZBB))
+
+	beq	a0, t3, 4f
+	REG_L	t1, 0(a0)
+	REG_L	t2, 0(a1)
+
+	sub	t0, t3, a0
+	li	t4, SZREG
+	sub	t0, t4, t0
+	slli	t0, t0, 3
+
+#ifndef CONFIG_CPU_BIG_ENDIAN
+	rev8	t1, t1
+	rev8	t2, t2
+#endif
+	srl	t1, t1, t0
+	srl	t2, t2, t0
+
+	bne	t1, t2, 8f
+	li	a0, 0
+	ret
+#else
+	j	5f
+#endif
+5:
+	beq	a0, t3, 4f
+6:
+	lbu	t1, 0(a0)
+	lbu	t2, 0(a1)
+	bne	t1, t2, 3f
+	addi	a0, a0, 1
+	addi	a1, a1, 1
+	bne	a0, t3, 6b
+
+4:	li	a0, 0
+	ret
+2:
+#if !defined(CONFIG_CPU_BIG_ENDIAN) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
+	__ALTERNATIVE_CFG("j 5b", "nop", 0, RISCV_ISA_EXT_ZBB, IS_ENABLED(CONFIG_RISCV_ISA_ZBB))
+	rev8	t1, t1
+	rev8	t2, t2
+#elif !defined(CONFIG_CPU_BIG_ENDIAN)
+	j	5b
+#endif
+8:
+	sltu	a0, t2, t1
+	sltu	t0, t1, t2
+	sub	a0, a0, t0
+	ret
+
+3:
+	sub	a0, t1, t2
+	ret
+
+SYM_FUNC_END(memcmp)
+SYM_FUNC_ALIAS(__pi_memcmp, memcmp)
+EXPORT_SYMBOL(memcmp)
+
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
+.option pop
+#endif
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index b0358a78f..456929971 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
+purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o memcmp.o
 ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
 purgatory-y += strcmp.o strlen.o strncmp.o strnlen.o strchr.o strrchr.o
 endif
@@ -41,6 +41,9 @@ $(obj)/strchr.o: $(srctree)/arch/riscv/lib/strchr.S FORCE
 $(obj)/strrchr.o: $(srctree)/arch/riscv/lib/strrchr.S FORCE
 	$(call if_changed_rule,as_o_S)
 
+$(obj)/memcmp.o: $(srctree)/arch/riscv/lib/memcmp.S FORCE
+	$(call if_changed_rule,as_o_S)
+
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
-- 
2.43.0

