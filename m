Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04C3DCD8F
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280808; cv=none; b=tx2nvGUV2igDjfvD4oBta3FsyWb/0tu0dC8mNmJyleQYlTkQxoyWuSgtioPGZPlw8I718tr9+3tdZmk+mJh3v91GzT0ABEvd3Y0mw/TZyGbR0cGXbBUmxhYpWeOrYcKjflKLaJacKlnE4VT6mwGEfEnVprK/A5qVHFcwzz8Ru4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280808; c=relaxed/simple;
	bh=K7L6/XB0yyn6ybRoO/c5hHdoNUlLw642jyc1eKLVk90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSIDdmD9hYMUiZI1EfFQMnUGdnujntELVRflo2hdRCQIlwt/drlE552ATS/GrUQS1YbyB0oKd3ns7S94YupDMSijUHuCFyRyZZq2zmeoNRftLIuf4yvyTym614C6RjjjJPJN8TYoGhsx9tOWxg7unLH9UNEIgEW7mAeqwQkPLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgCk/1FQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgCk/1FQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-444826c16ffso4307603f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779280805; x=1779885605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vz7ySB1n7hiRbxQUx3+c5jByhWmQvmCG7QHugS1JFY=;
        b=rgCk/1FQk8j0wXw/14HfpslWx0wgaY1M27wQ671n1g0XxOk4E+poy69mgX2kO2X3Zh
         mAi6qHVyXyGEiav9Rv9jH2bJvPdbyyanGhb76Wd+zLivn4jQQgbix74cNGcupOZJ1/eI
         aoVc76rAHwzn/odiaTUfYVvDXALC226zHt78RRwDfLjDOhE5PTCLDcp8Xsrsq1Q0/aae
         1e8ERrNr7YN6ozDddyOcg+F3+GiR25zaVZX6YYIAFXZCGm4VmXBOtIcmano+mM72YE7L
         b9vOtSJ8EIkfM7lUyWslFsoYDRlPktDQhcU6ecxec/u1a0WDmXRZ0nQgES/puCxAEOWe
         0zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779280805; x=1779885605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0vz7ySB1n7hiRbxQUx3+c5jByhWmQvmCG7QHugS1JFY=;
        b=lDjxGHjaG9s45Ix8a+SMSm4T1ioW08sfQLfPxALwAD9vSkyCjf3VhtDtmXV2jqt/z/
         LDOBd1g4JG0axhhaCqIWd8Yj5/htZeE5l1jmVkzAiPAXlIZdC8XQQITlSsQPCXU0Zm1G
         HgFW6eSHSFQMzNPHbmMHSh8FyE+Uw7iXvRUvW987pndcm/m+VWOp1MSe5IQjhfQG4mB2
         fmro7H9ur7uKfLfgfvFXLhKqgubqcVzP1xFCuwmP6VzWmMbace+i6BGCUWNNP6UDdPk8
         ccxwLkDv9WSa9anJeeNeTieF3oDt22BxI4kq0Eut/LcMM3DXszEQYvuR0oFFpPyeqR7R
         QJjg==
X-Forwarded-Encrypted: i=1; AFNElJ/ObE3as4/RR6P6r06vPtr7JM9tFm61o4tw1jFMOYTnIyBXgnKNpJ/XsroTb3KfknLRoV6pvi88HbFSTeGIK50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPoI37nysl39oQL1OKW7F2NmXkE2eUEih3jz/yTtoVp9qAQso/
	qwDk8Sau2Xr+m89Ksq2ls5+wkAfn8zawIQCWFPf2Got7R5IGmuPDXH0W
X-Gm-Gg: Acq92OH3woXlmSyRGQp/tEXwDUtHme5XGDKNnIPHm6VPomJ7hsL5jt7dxFnnIqYKwyE
	HZE4K5FMHWOQRJSL2gJDPM34dA3eDuMEHM5dxd1CAgew2AgxiY/0jtdbLecJcUWH1rH+WSBqxPh
	+hZuZcT2c5cNABALtx7hyLon3uFuFHBHNlMrz4cX6uVDGgeo+Ovel5+8V3g2/5c/K8abETkjME4
	r7m+iRp7aRQ7w4hhyvpY23KpPWhoVXM7ufmdMYeLjYBHRzSESImE7L4YYnAN7AqyfhkCRbDRQed
	OgEpj4HN6vjHsnu6wq69987ez4gBMI36FTc0zvgTSt5M1cy49GYyju1gm/TPoVHmbMjUn3Bueal
	F9/Qvv4s7X0dPy+7PCGFWPQ5+CJ5Vm/i3aOBJ0ggcOYhae74wBTEl/ontj5SCBGWD9EJW5T6CqY
	E8IFLYfhoQEphTUF2/4DLk3BgQOn4qzUQRxi7fLeWo9Q==
X-Received: by 2002:a05:6000:1a8e:b0:43e:a70d:7622 with SMTP id ffacd0b85a97d-45e5c58d96amr36524506f8f.22.1779280804903;
        Wed, 20 May 2026 05:40:04 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([89.216.37.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm54460252f8f.12.2026.05.20.05.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:40:04 -0700 (PDT)
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
Subject: [PATCH v6 1/2] riscv: lib: add memcmp() implementation
Date: Wed, 20 May 2026 14:39:53 +0200
Message-ID: <20260520123954.379630-2-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520123954.379630-1-milant2002@gmail.com>
References: <20260520123954.379630-1-milant2002@gmail.com>
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
v6 changes:
    - Fixed build errors kernel test robot noticed. 
    - Link to v5: https://lore.kernel.org/all/20260519140029.1190381-1-milant2002@gmail.com/
    
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
 arch/riscv/lib/memcmp.S         | 107 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 4 files changed, 114 insertions(+), 1 deletion(-)
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
index 000000000..bdb92941d
--- /dev/null
+++ b/arch/riscv/lib/memcmp.S
@@ -0,0 +1,107 @@
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
+7:
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
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
+#if !defined(CONFIG_CPU_BIG_ENDIAN) && \
+	defined(CONFIG_TOOLCHAIN_HAS_ZBB) && defined(CONFIG_RISCV_ISA_ZBB)
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

