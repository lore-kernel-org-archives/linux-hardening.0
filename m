Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758A3C98B8
	for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760863; cv=none; b=p5gXmEEG9HvgTr7AEKrgJAQwEX2H7EHw7I8ZGA5j4pjiqnY5H1F9yr8nbuafXIjWWikrSZKDn52lFYQ0vy2ugv7xs/Itv4C+qZGWED12Uz/mNAkTjmQnOYyQSNITF/DmWbtItEQdnXWssiIqSA94prNzrDKR2Plj7DUqjU9OTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760863; c=relaxed/simple;
	bh=K9YIy6nRaPm5AKmuze1Wd8slFCu+Gy4VPtOB1XGNHfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q734xst5kG6A1MFdvJFJNMGefOivMnvcaY/XlMh/1HftCwZRuOSVT6zpE6b9X4AXXBTTXlSotDSNNCI6mIB1l+Oz0KhcigJ6SScCGBSHxG5nOne/TjiwT94r4XWxPmNuFWbiCTFvrCKcuz++V9/H5lDHy20x2KM18LWuJCZObuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7wiSy3w; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7wiSy3w"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44e1860558fso5106531f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778760860; x=1779365660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pgj61FBq/UbvmM2TQH6EKEDIV/V9Gcyb7zXKSvEriQc=;
        b=M7wiSy3wX/7cYgCvnUhYvg1uxetNtjmnB2r7FNE0ELT/BbcnqwnHZ2sGi95KROldDq
         o4mYOrpTNJSDYOFmTUkA/EK21thhzorEAE+a4v6rlclPnwoUGGlrwIccoIG8+SC7L5Uw
         4PXvRW8P/ZJbzRPJPvu3+xj5ZF/Wg4otcoBOaiOsAwON5nZEMztuySdrHl1vZgII0rhw
         T0g2adYMU2E/Y7Zbtii6K9DKTYDLR9HMxEaa71fuEp7tzmn42yVA4ae2KP/BMgZlsDby
         9o3HFy3lCQsZdeZGrV88wPmGpBqReAqSIFDCMhW3co5QYD6uFuuVWxB5+Yq0TCUK129I
         RHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778760860; x=1779365660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pgj61FBq/UbvmM2TQH6EKEDIV/V9Gcyb7zXKSvEriQc=;
        b=HRUHnIsgr98roDX10kNmPfEDgU7YPopYve+jBajUSaDeSPhgPZuvXh7XHRZ6RWDtyJ
         xh0jdvYX/zmHsi/gTejN1qFlMmgRWWgtbvBSCceF9Sg8HV0jQLDfKZg5YuOqgPkW7ndP
         IgE9Flqs3zIwvvb+j/Oehx6rd1mElewNiyDAoqzxoM3l3au9NuAxTThXtCLxc0wh538V
         5NeNf6dsqDsUYRbqpeUGpYDpL4Fj/n2/Krf5WGz1I28qrsy2S2By7uz+wLy+ou3gag5v
         Mzk7RZ1yldCZGkARZ9on9iHg9tagNLN9XcFnn35nNUA+IFtVZNOez20qgod+lT3v61z/
         Xx5w==
X-Forwarded-Encrypted: i=1; AFNElJ9rmNbQiOiZII60SoqjTKeEGVzpr0UjDYMP23gKRa63CzYa1K8FV84nOh5EFvGFh7SSz7MRLlZsfaRrcmm0nfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxazQYetzqrm5SjplCqpH0pti0DM5J72hiEi8oU40kIZtjZNGFb
	EVKbIkMHXCjand+p770BHzB9TGxS4E4sZy6UTII0nACVIMCQT7YoopuG
X-Gm-Gg: Acq92OF2V6dDFO4B/XFcHdYXGYJqAc4LI4wnV4W6ActwWHLhFyT09ysADPap1djjPOs
	rFK6ARjxMH7F2RHrllAWVcx//Ko2D+gtwlN7ZVD1vJ3nGJQw+m57WeuegIPleIKmGBNRe83maGn
	Z9tHBDuIxv7/LpgfFhNiZX+18CqAVVNTf15RCoH8ks1CRLGHzG0JIK62EXu+QAoi7+JyC37CHjQ
	zBNaU4bszdKUwdK9w1OfqqDYm2UH6dhnspBHCn3i9hACPzOBMRBHoVm/p9lT0sMGEEvhcAj7Gxn
	IuYVEZGDZwPCYoSrilPKUQU5Ii6Xsmcp5+EJfCdMDPFawkc7YcgvZFuMgaKG2xJW9/TKfY3gTj8
	LOwpllb8JmYOB3qUHkAdEerwwdIS7hIolzvz2MAG4jY4EcECPgsa0tfN3TxEdcJMale1DMFtj1y
	CsgMhTTQa1F03knOa44puk8y5Jm2LuBs/pwPA4KCQKtg==
X-Received: by 2002:adf:e884:0:b0:45d:817c:b8b2 with SMTP id ffacd0b85a97d-45d817cb8f7mr4986962f8f.30.1778760859579;
        Thu, 14 May 2026 05:14:19 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([77.243.27.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767cb9sm6285630f8f.2.2026.05.14.05.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:14:19 -0700 (PDT)
From: Milan Tripkovic <milant2002@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: [PATCH v2 1/2] riscv: lib: add memcmp() implementation
Date: Thu, 14 May 2026 14:13:57 +0200
Message-ID: <20260514121359.931999-2-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514121359.931999-1-milant2002@gmail.com>
References: <20260514121359.931999-1-milant2002@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

Add an assembly implementation of memcmp() for RISC-V. The implementation
uses the ZBB extension for word-at-a-time comparison and an assembly
fallback for non-ZBB systems.

Benchmark results (QEMU TCG, rv64, Aligned):

  Len   | Default | NoZBB  | ZBB    | %NoZBB | %ZBB
  ------|---------|--------|--------|--------|-------
  1 B   | 20.3    | 25.0   | 20.9   | +23.2% | +3.0%
  7 B   | 88.9    | 107.5  | 155.7  | +20.9% | +75.1%
  8 B   | 89.6    | 110.9  | 176.2  | +23.8% | +96.7%
  16 B  | 134.4   | 172.4  | 334.8  | +28.3% | +149.1%
  31 B  | 163.5   | 220.5  | 606.2  | +34.9% | +270.8%
  64 B  | 203.8   | 235.9  | 968.6  | +15.8% | +375.3%
  127 B | 224.6   | 268.7  | 1362.8 | +19.6% | +506.8%
  512 B | 235.7   | 271.1  | 1913.7 | +15.0% | +711.9%
  1024 B| 256.8   | 290.6  | 2123.6 | +13.2% | +726.9%
  4096 B| 263.8   | 302.9  | 2290.4 | +14.8% | +768.2%
  
Benchmark results (QEMU TCG, rv64, Unaligned - Offset 3):

  Len   | Default | NoZBB  | ZBB    | %NoZBB | %ZBB
  ------|---------|--------|--------|--------|-------
  1 B   | 20.7    | 21.7   | 21.5   | +4.8%  | +3.9%
  7 B   | 96.2    | 99.1   | 96.9   | +3.0%  | +0.7%
  8 B   | 97.5    | 118.5  | 110.5  | +21.5% | +13.3%
  16 B  | 136.7   | 166.6  | 172.8  | +21.9% | +26.4%
  31 B  | 167.6   | 206.5  | 211.9  | +23.2% | +26.4%
  64 B  | 204.4   | 229.9  | 240.3  | +12.5% | +17.6%
  127 B | 229.6   | 261.7  | 269.0  | +14.0% | +17.2%
  512 B | 245.5   | 260.8  | 269.9  | +6.2%  | +9.9%
  1024 B| 246.9   | 261.2  | 283.5  | +5.8%  | +14.8%
  4096 B| 250.7   | 295.8  | 299.7  | +18.0% | +19.5%

Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
---
 arch/riscv/include/asm/string.h |   2 +
 arch/riscv/lib/Makefile         |   1 +
 arch/riscv/lib/memcmp.S         | 124 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 4 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/memcmp.S

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index 764ffe8f6479..5c5299678c66 100644
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
index 6f767b2a349d..b529e1be18b2 100644
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
index 000000000000..f7d0eaa08880
--- /dev/null
+++ b/arch/riscv/lib/memcmp.S
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/alternative-macros.h>
+#include <asm/hwcap.h>
+
+/* int memcmp(const void *cs, const void *ct, size_t n) */
+SYM_FUNC_START(memcmp)
+
+	__ALTERNATIVE_CFG("nop", "j memcmp_zbb", 0, RISCV_ISA_EXT_ZBB,
+		IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
+/*
+ * Parameters
+ *	a0 - Pointer to first memory block (cs), also return value
+ *	a1 - Pointer to second memory block (ct)
+ *	a2 - Number of bytes to compare (n), transformed to end pointer (a0 + n)
+ *
+ * Returns
+ *	a0 - 0 if equal, positive if cs > ct, negative if cs < ct
+ *
+ * Clobbers
+ *	t0, t1
+ */
+	beqz	a2, 2f
+	add	a2, a0, a2
+1:
+	lbu	t0, 0(a0)
+	lbu	t1, 0(a1)
+	bne	t0, t1, 3f
+	addi	a0, a0, 1
+	addi	a1, a1, 1
+	bne	a0, a2, 1b
+2:
+	li	a0, 0
+	ret
+3:
+	sub	a0, t0, t1
+	ret
+
+
+memcmp_zbb:
+.option push
+.option arch,+zbb
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
+7:
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
+#ifndef CONFIG_CPU_BIG_ENDIAN
+	rev8	t1, t1
+	rev8	t2, t2
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
+.option pop
+
+SYM_FUNC_END(memcmp)
+SYM_FUNC_ALIAS(__pi_memcmp, memcmp)
+EXPORT_SYMBOL(memcmp)
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index b0358a78f11a..456929971da7 100644
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

