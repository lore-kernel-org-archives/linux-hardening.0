Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37F3546E6
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292573; cv=none; b=ORFfVVZuQhf5ZLcDsQn6D1SFlK5+5MM+7FE7VcS/RWGe02Ax72ZC/bvXrL6zrVJL/TRhxp6mjh7ZJN0UFlL5HVKn6aN000rmrm7VxFfI0pyDoOMhBQYYwaY6VRWzF7aqG6PD9XrMsNhVN9obfparQYYJP1ZzfNvwp7JCnDY7gsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292573; c=relaxed/simple;
	bh=waoLV/3bEXLRYpEwx6fHog68kuidaBtU4PbGxQ5fRhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXuRo+TPI5ZkVBoNKQJF2I0PLTSu0LkDrC0t9ncActJVBQ7dkQDNmnmMxlFolGq7FjO9NP8iGAe4kK6I/1cPQOGQ26aGutBacA7NDxmab75veQZJ+mah2zeK0V9MTCUZITdvRwziIPANJFptHhJyb33OcULj5W3FpMEX7J6dP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEfifVXB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEfifVXB"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d146705b4so56083465e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292569; x=1779897369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBpbLd/H5G6gmbkig9FYBk9kTUwsFZEKMdkIA0bLw8E=;
        b=SEfifVXBB0NmMfdSzCxTS73frZnlrIaT5tJoU9Ejsn2GZxUB8tJNE+zlFEF3BAmdcP
         g3FlzADsODoz8h9DIpGPHS60ogwWWxU1O3bbkfpT50Fhb5pAMlg4rhz+U7MV5BcaItNL
         CaznmVqKDi2hKfjhv/f/T50zf04KXKzwjxJwkWok4KZKjq47ls/ob1zO7W7X+GxcO9pD
         bi0K/olqcs2IIFGhNKoc4XImCaSQyoYCY7DCKNV7hfS08Aty6NqHlAV6D7CAfFb34mE2
         k9FJWzFfVqOTKQSvUWihedH9EChV/wiZbmAdcHTZDtWbbSnEGaj2ppRL34UPJ8EWs7ld
         hmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292569; x=1779897369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBpbLd/H5G6gmbkig9FYBk9kTUwsFZEKMdkIA0bLw8E=;
        b=gSCJvpv2ghvJvtV0qnFGXnHQwT4iLaL60VyGBtzA9Hv4RUQdf99/WWRi5/0Jn1nIAC
         GFqZzW7Yh9YOjqgC/Krvw+EogDvnKlntuXMVlBYMjRG5oiJYNfksGS/0cdnyMwomcqhd
         wfb1i3vr4dq0j/zeKcZKnuHw3FwXgzOoqy61QjdK79OPLIys3p1OblAPsBOnn07MQobv
         TmYBJVso6AnOpiQPrpLW2vWj27w7BEDC0lUTPW3ETfy+cxc87llmWI58CHZWUBu6NPhA
         tN2yHKJjgc1cpg0VBRe7DkiFWhbMyI9CcDTem8lliUQbp21mEKoZ04Ri78Lrx6AE2eKp
         rwAw==
X-Forwarded-Encrypted: i=1; AFNElJ+9CFmWm6LnU7IqYMei6uIWTuteebTNyBubbnFeyQIYc+hgSZvfmlv4+WP0fUYuEE73Zuf50Pd8B43x+Xi0EpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw56PsUMSqw1Hwwx5joM2A7FyTdwLpUF/ya+RBSfyXLvYYez2wu
	dBFX/JR4jqlUftOBoPxw0z3Qt2bI9v5ecJz1SR0P9h09xsKjlXUhSXmg
X-Gm-Gg: Acq92OE/8WkHhdMvR6zguTnwEr9i7HKH+hidVMHhDoz9HdwZWMpVkGu7VexK0z4t72H
	amxqa6dBgE0noDuBEQcxcakvZwOaZ6QmMXt2uvwjCqdhdpFzrb1BOu0JdC0iJPWjuB35Wkr+TiM
	/qk9j8ZRUwf9LfIP7+rlEFiqOxB+83T0ROkfKuIcnJZwYs0Xp7AZ1R4oAOrVuZ+VnAz5RtLVdeX
	ITei1Eob7dPgCLI4jBR2rb1alf2jHsw/zmZKb+Ud9lrmuaM5NGBk71/1shplmgN6JAJMTfvoPRK
	j2Fi/u6Ru4bxw0l1yiZNA3MYGXXA7qyfFDcZLfjHmhrEos+WV5wxVapFXzBTNGA+n8Er/6QnhKB
	ckKsRy80xYDdd1mDKcdld43gJDtQ87eEYD7j0ZRkvDUC8tFjyIefGDfMrtPBCZEibHU9QO2Tzq5
	0dUfjtBszSASkmc8u9rfccJ6NahvTyHCzkEV1EXE+xgUyFfunhElYG
X-Received: by 2002:a05:600c:491e:b0:48e:978f:c45a with SMTP id 5b1f17b1804b1-48fed455991mr235621165e9.19.1779292568861;
        Wed, 20 May 2026 08:56:08 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([89.216.37.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab290e1sm215565025e9.2.2026.05.20.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:56:08 -0700 (PDT)
From: Milan Tripkovic <milant2002@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Kees Cook <kees@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Andy Shevchenko <andy@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: [PATCH 1/2] riscv: lib: add memchr() implementation
Date: Wed, 20 May 2026 17:55:30 +0200
Message-ID: <20260520155532.1139471-2-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520155532.1139471-1-milant2002@gmail.com>
References: <20260520155532.1139471-1-milant2002@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

This implementation leverages word-at-a-time comparisons and the RISC-V
Zbb extension to accelerate character searching, falling back to a
generic byte-by-byte loop on systems without Zbb support.

Benchmark results (QEMU TCG, rv64):

| len  | zbb    | Wozbb | default | % Wozbb |  % zbb  |
|------|--------|-------|---------|---------|---------|
| 1    | 22.9   | 26    | 22.1    | 17.64 % |  3.62  %|
| 7    | 115.5  | 130.6 | 100.1   | 30.46 % | 15.38  %|
| 8    | 184.3  | 143.3 | 117.2   | 22.26 % | 57.25  %|
| 16   | 322    | 205.1 | 179.7   | 14.13 % | 79.19  %|
| 31   | 361    | 247.4 | 221.7   | 11.59 % | 62.83  %|
| 64   | 880    | 280.6 | 233.2   | 20.32 % | 277.35 %|
| 127  | 961.3  | 307.9 | 271.4   | 13.44 % | 254.20 %|
| 512  | 1812.9 | 325.6 | 294.1   | 10.71 % | 516.42 %|
| 1024 | 1973.2 | 335.4 | 273.8   | 22.49 % | 620.67 %|
| 3173 | 2245.9 | 338.7 | 288.6   | 17.35 % | 678.20 %|
| 4096 | 2327.5 | 345   | 317.5   | 8.661 % | 633.07 %|

Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
---
 arch/riscv/include/asm/string.h |   3 +-
 arch/riscv/lib/Makefile         |   1 +
 arch/riscv/lib/memchr.S         | 126 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 4 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/lib/memchr.S

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index 764ffe8f6479..cfcf1193b446 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -18,7 +18,8 @@ extern asmlinkage void *__memcpy(void *, const void *, size_t);
 #define __HAVE_ARCH_MEMMOVE
 extern asmlinkage void *memmove(void *, const void *, size_t);
 extern asmlinkage void *__memmove(void *, const void *, size_t);
-
+#define __HAVE_ARCH_MEMCHR
+extern asmlinkage void *memchr(const void *s, int c, size_t n);
 #if !(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 #define __HAVE_ARCH_STRCMP
 extern asmlinkage int strcmp(const char *cs, const char *ct);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 6f767b2a349d..bbc54dabbb81 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -3,6 +3,7 @@ lib-y			+= delay.o
 lib-y			+= memcpy.o
 lib-y			+= memset.o
 lib-y			+= memmove.o
+lib-y			+= memchr.o
 ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
 lib-y			+= strcmp.o
 lib-y			+= strlen.o
diff --git a/arch/riscv/lib/memchr.S b/arch/riscv/lib/memchr.S
new file mode 100644
index 000000000000..0e971cf51410
--- /dev/null
+++ b/arch/riscv/lib/memchr.S
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/alternative-macros.h>
+#include <asm/hwcap.h>
+
+/*  void *memchr(const void *s, int c, size_t n) */
+SYM_FUNC_START(memchr)
+
+	__ALTERNATIVE_CFG("nop", "j memchr_zbb", 0, RISCV_ISA_EXT_ZBB,
+		IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
+/*
+ *
+ * Parameters
+ *	a0 - Pointer to memory area (s), also return value
+ *	a1 - Character to search for (c)
+ *	a2 - Number of bytes to search (n)
+ *
+ * Returns
+ *	a0 - Pointer to the matched character, or NULL (0) if not found
+ *
+ * Clobbers
+ *	t0, t1
+ */
+	beqz	a2, 3f
+	andi	a1, a1, 0xff
+	add	t1, a0, a2
+
+1:
+	lbu	t0, 0(a0)
+	beq	t0, a1, 4f
+	addi	a0, a0, 1
+	bne	a0, t1, 1b
+
+3:
+	li	a0, 0
+4:
+	ret
+
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
+.balign 4
+memchr_zbb:
+.option push
+.option arch, +zbb
+/*
+ * Parameters
+ *	a0 - Pointer to memory area (s), also return value
+ *	a1 - Character to search for (c)
+ *	a2 - Number of bytes to search (n)
+ *
+ * Returns
+ *	a0 - Pointer to the matched character, or NULL (0) if not found
+ *
+ * Clobbers
+ *	t0, t1, t2, t3, t4, t5, t6
+ */
+	beqz	a2, 3b
+	add	t6, a0, a2
+	andi	t3, a1, 0xff
+
+	li	t0, SZREG
+	bltu	a2, t0, 8f
+
+#if __riscv_xlen == 64
+	li	t0, 0x0101010101010101
+#else
+	li	t0, 0x01010101
+#endif
+	mul	a1, t3, t0
+
+	andi	t1, a0, SZREG - 1
+	beqz	t1, 5f
+
+1:
+	lbu	t2, 0(a0)
+	beq	t2, t3, 4b
+	addi	a0, a0, 1
+	andi	t1, a0, SZREG - 1
+	bnez	t1, 1b
+
+5:
+	sub	t5, t6, a0
+	andi	t5, t5, -SZREG
+	add	t5, a0, t5
+
+	li	t4, -1
+
+	beq	a0, t5, 8f
+
+6:
+	REG_L	t0, 0(a0)
+	xor	t1, t0, a1
+	orc.b	t1, t1
+	bne	t1, t4, 7f
+	addi	a0, a0, SZREG
+	bltu	a0, t5, 6b
+
+8:
+	beq	a0, t6, 3b
+
+2:
+	lbu	t0, 0(a0)
+	beq	t0, t3, 4b
+	addi	a0, a0, 1
+	bltu	a0, t6, 2b
+
+	j	3b
+
+7:
+	not	t1, t1
+#ifndef CONFIG_CPU_BIG_ENDIAN
+	ctz	t1, t1
+#else
+	clz	t1, t1
+#endif
+	srli	t1, t1, 3
+	add	a0, a0, t1
+	ret
+
+.option pop
+#endif
+
+SYM_FUNC_END(memchr)
+SYM_FUNC_ALIAS(__pi_memchr, memchr)
+EXPORT_SYMBOL(memchr)
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index b0358a78f11a..42e840fad6df 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
+purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o memchr.o
 ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
 purgatory-y += strcmp.o strlen.o strncmp.o strnlen.o strchr.o strrchr.o
 endif
@@ -17,6 +17,9 @@ $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
 $(obj)/memcpy.o: $(srctree)/arch/riscv/lib/memcpy.S FORCE
 	$(call if_changed_rule,as_o_S)
 
+$(obj)/memchr.o: $(srctree)/arch/riscv/lib/memchr.S FORCE
+	$(call if_changed_rule,as_o_S)
+
 $(obj)/memset.o: $(srctree)/arch/riscv/lib/memset.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-- 
2.43.0

