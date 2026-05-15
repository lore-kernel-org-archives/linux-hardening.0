Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145748BD32
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854241; cv=none; b=SEXLKeqh/vx91GqCFp/ZQo2w1NkbBJcy32lSX3IxcC7ZIax7n+nGnvrov1Mlbh1GsKlGaAcN3VFPrugYVhsWC/sfsZumdFUQIMSCyCi827KqieT+G6V5J81zb6pan9dH/jHJDXVUf6Wvc/Kn33+5hmfC/xcMc0exEeZgYLctNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854241; c=relaxed/simple;
	bh=/uNrr7I3e4CqMrlpCg2OIX0J6TcPN1mB4Ff0tS/sVg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZV/5GBArqKm72HN+OThucI0TGc07T+Yu/pjEmj+Mldubn6rVamf1EI7XMPvGFqBrZoaQlY/cN91sq7s70n9u9Pha+4lf5u46/JZ2r2geuJwjVJMvQ6twMIfKxMef9zl1nijNbfjFVZRsZVqBPmBQWemMCsh+zt9l6KCsMwh8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIuNPYbv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIuNPYbv"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bb91b426e40so1543794866b.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 07:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778854238; x=1779459038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKdZwHICxAcumd/0vYmGg6f5JCYmSEbXy5dzzVwJhKM=;
        b=CIuNPYbvVmXkew0FAG1LT3qUAX3rFmvju1UmboJHfHKqraGujjKUcpwY8/SwtAH/W0
         /z6bBWhM2qOZeR0q0Nh7zhOocD6NM67hDl9UPqthJ5Tx51x+Hd9TlfSsXsMnr+xdyriL
         FjzlMT7H+r/LgX2Wx6v33lvAWEkqGnheIfKT5l9E3SfiGmla9H0tOLnyrkRGei4b8PSY
         OOnLfeO9d3jkZTgxBUKZVSPV6jIgMdeqRnR+9eoBM6igcSzj8yK1TUp9F+6AzrABmA1r
         afiSYwyDW4TosKhpbgj3LGH1OmKKCfwzrBCKZRL7zlj/NABazm4xiBtb5xJ+yjR3dbGs
         v7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778854238; x=1779459038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xKdZwHICxAcumd/0vYmGg6f5JCYmSEbXy5dzzVwJhKM=;
        b=lBYDW4Go8W9r7Gr7nG84cAQAbW+9Z3xqKXoUaa1xZvRsCrj3JgfdwCntf7RRZYu1NG
         Js51HEOC3i37EkKGPMAp3no/o4cPgAjoxnSVVONM4eBH+0oJKj/sp65JXARO3z4GDtTX
         Xl2HRtw1vREpk+O00ALiHn1B64xnFdyJMZwt5+xx3iRJ6Y4xZ+cWSt2v7d3jzsur8wG0
         h9DJxnk5PaYZAigx44XEcJ3tJxD7nvA/lgtxR7cq1LyMtqZ9IcB3NfNUaq/3LslmE7Vx
         Zu8B66btP4sYOKYGqwis3hOxJr77BHh18h3OO+C57BZr2hj0qv284fwE0h/2Y7GpMvQA
         lEgA==
X-Forwarded-Encrypted: i=1; AFNElJ/c1FB1lPvKYPAFUL0GCfUlZgqajZWzv6ytvn38piwPc1zhudxXMS+O5dT3i4klGRx8vbNpKD+tABEz8klLR64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fAS8m/0Z0jtwj4k23Q2+mSoAJ0RJoLITUtnFRe9/ENVWZPdc
	5WDJJviREo2l3sZwFl4waNtK+3KnXCgyMS9ueeG+9CkFiN+LoP73iy9Y
X-Gm-Gg: Acq92OGXZccI/U4srCBbroYMugTb/DD40+JGVCgUNyzP8OO0ki7e1ofZs5ZCvfhtaSj
	ZH3srWsUOdnIGELnUGR+wH62vtaDxMiBoB9+Nf8Y3ZVlSZHm+dtf9t3VfRQbFVasMhblegYSDgr
	H0/asdC5hiT+orDyW6won/d9SRgqyyD7wXOvienKEkmdw6I/xGggVrLxD0XxAx7+LqYq9RWLhT+
	NTn21a23X9VQKoPAtrXB/mTy80DYnrgT3z1xg67bJV/Qt1sm3ZA88izaXzBk/3ovMWpuCIOjUcf
	elziJqnYRUew3esCN7hNl0b6d0sdo3XcBir58S+JBIquWEikipMa3seJtMBfAoeS2SzCDj7kYAK
	hCd4knqhM/JUXOSGI38h9BTHxlyYgaC5UpoxaxBxNdhAmULvIRunQUCJSHkxzOVJ2dca7/mje0F
	gWnaB7vs5ShCBUD6YMgGf8Dncm1GYXlQT3kom+4DQSPVHHktRcAu5Y
X-Received: by 2002:a17:907:8691:b0:bc1:36dd:c6c9 with SMTP id a640c23a62f3a-bd517928fecmr236919866b.33.1778854237868;
        Fri, 15 May 2026 07:10:37 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([77.243.23.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831197bf00sm2115768a12.31.2026.05.15.07.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:10:37 -0700 (PDT)
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
Subject: [PATCH v3 1/2] riscv: lib: add memcmp() implementation
Date: Fri, 15 May 2026 16:10:18 +0200
Message-ID: <20260515141019.1234037-2-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515141019.1234037-1-milant2002@gmail.com>
References: <20260515141019.1234037-1-milant2002@gmail.com>
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
 arch/riscv/lib/memcmp.S         | 125 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 4 files changed, 132 insertions(+), 1 deletion(-)
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
index 000000000..a531e481c
--- /dev/null
+++ b/arch/riscv/lib/memcmp.S
@@ -0,0 +1,125 @@
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
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
+memcmp_zbb:
+
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
+#endif
+SYM_FUNC_END(memcmp)
+SYM_FUNC_ALIAS(__pi_memcmp, memcmp)
+EXPORT_SYMBOL(memcmp)
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

