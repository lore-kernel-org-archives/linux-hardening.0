Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1803EA90;
	Tue, 25 Jun 2024 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285945; cv=none; b=UQYf+DsQ8QofSwuFQgtiQowFHtQ65oW6Hq9cw8F8XEGh8awn1WbNw+ul5p0yFOL3Uiq/raVa3pXQGmfkVxevPtFcdSp77sV2GgZEGh8MYuo7PnTT7DJjG1zM/Ag81PpvJ3AvzljH2rEmb7xgIKY5JT4QJfh/eNecwksZ4Dur7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285945; c=relaxed/simple;
	bh=uf26h1JYSU7JrV3mjnHTrBZp7ZfhjcGx4cTJNUqiRx0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qjxefpAQguXJhbFFLJVOsO7oStLbxPXnPkruexNPhQP+z77hxBFZQMEJm8ZPu0N+6eVAuFdxnoGPcFDfqo+UtC+o+y+cb6dZU/mQlyGKV9eSDqxWKQ/cApJdpaEVgtACNMrLeadwEhA5UmGVPxjd6a1xwJfFcV150GISUWj+FEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnshiffU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnshiffU"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70666ac8f81so1942808b3a.1;
        Mon, 24 Jun 2024 20:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719285943; x=1719890743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgG88c9JE6XnPF8CRgN3glLQvH9X2RESdGb7e77LJso=;
        b=PnshiffUhPhZ03vv3Y17L6KS1nniBixMwtYNyw7Aacs8Fdq6JrA3XN9VbHS5oWvVHQ
         Oo3IQMCnNlYr7TWLQeP/NL/YRuzCeBeIbTCrCtBqxsQZyc8Gx8TxF8Nu6KvnbTz0KRjx
         CZNJaPb6sxq/DXTF300P4+oLI8P0NqS+MOezdADAfsLB6B4Uh3TqbodcbQpwTdY3hdCs
         pvMxQ+PQ7Pm6+FeHVKQWdXq21SaeLjdmPvQj4rihfWx8fdXnEBYLMo7qqKez+Dzshl3e
         yhJQ+3yd/YglgNwZ1mYcoDsjtyNyYJT+JM7RMRSH1uf25qDL6qsyvwdYZmGlJ5zj739a
         f3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719285943; x=1719890743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgG88c9JE6XnPF8CRgN3glLQvH9X2RESdGb7e77LJso=;
        b=GLP8kcv80tk1fm6+ovqP+1Sx3mm5d4IasMKYmPo88piZjgLfLaVNuDO521OXwYR3jq
         ErKwiv5gq17aspkzJWuaHg41L24h6KOlzZzmcOeRxO6Cg+0ADv6COl9SSt+YYRCHgeDS
         QT7johEq5IxkQeuoYRSxW0sc/E/W7tDD7smxkfPNKOJRbU0A7et6JOWFxPA6f2en5Utn
         R0qpgj0zf86BXwyhDDere1/VsE9Zxv6LqphNpnMpPYSI0t5XIeP7MOwSLYo+N9ivJggU
         Ld+quA0io4NRH9gc3hUfm9uoHiMxgCZBRLW/Dr8gBTDeDBZz56X7d7MB7Cwu0rA7Rnqk
         Npsw==
X-Forwarded-Encrypted: i=1; AJvYcCX7jnmMFL7fmBKqrwGiV83ATXp0Ezp4/kpndZ/INvhJBG8Ea+QqOIjhm/Tspk4SWhV1SS+mFoWwnG6AwM8yqru084YbgTGD6IlHNE0UCyFgs+eSII7lQJ9APIImnIQFpkVSDf4RPfg9RFsx7xvD
X-Gm-Message-State: AOJu0Yw+N8OH2owIHHUF9t0I/tiqVAu9+paZF5L2MKhKIYIS9P7b0fbo
	/CPM7GSQaTzEmxHuUXQzAISFXZz9w9nUsAY4nb92rDztMBMQcpjt
X-Google-Smtp-Source: AGHT+IEPpdrb00fx09/ouYLd+x1w4KtAvaDoWKza0/Jgyrp0J2ugLXcWaREba6NFaQo03yrDjlVbUg==
X-Received: by 2002:a05:6a21:6da4:b0:1b5:d07a:57b2 with SMTP id adf61e73a8af0-1bd13bb76camr3898830637.12.1719285942871;
        Mon, 24 Jun 2024 20:25:42 -0700 (PDT)
Received: from localhost.localdomain ([2604:a880:4:1d0::427:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-706512e1f6esm6952010b3a.180.2024.06.24.20.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 20:25:42 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <keescook@chromium.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Gatlin Newhouse <gatlin.newhouse@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3] x86/traps: Enable UBSAN traps on x86
Date: Tue, 25 Jun 2024 03:24:55 +0000
Message-Id: <20240625032509.4155839-1-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Currently ARM architectures output which specific sanitizer caused
the trap, via the encoded data in the trap instruction. Clang on
x86 currently encodes the same data in ud1 instructions but the x86
handle_bug() and is_valid_bugaddr() functions currently only look
at ud2s.

Bring x86 to parity with arm64, similar to commit 25b84002afb9
("arm64: Support Clang UBSAN trap codes for better reporting").
Enable the output of UBSAN type information on x86 architectures
compiled with clang when CONFIG_UBSAN_TRAP=y.

Signed-off-by: Gatlin Newhouse <gatlin.newhouse@gmail.com>
---
Changes in v3:
  - Address Thomas's remarks about: change log structure,
    get_ud_type() instead of is_valid_bugaddr(), handle_bug()
    changes, and handle_ubsan_failure().

Changes in v2:
  - Name the new constants 'LEN_ASOP' and 'INSN_ASOP' instead of
    'LEN_REX' and 'INSN_REX'
  - Change handle_ubsan_failure() from enum bug_trap_type to void
    function

v1: https://lore.kernel.org/linux-hardening/20240529022043.3661757-1-gatlin.newhouse@gmail.com/
v2: https://lore.kernel.org/linux-hardening/20240601031019.3708758-1-gatlin.newhouse@gmail.com/
---
 MAINTAINERS                  |  2 ++
 arch/x86/include/asm/bug.h   | 11 ++++++++++
 arch/x86/include/asm/ubsan.h | 23 +++++++++++++++++++++
 arch/x86/kernel/Makefile     |  1 +
 arch/x86/kernel/traps.c      | 40 +++++++++++++++++++++++++++++++-----
 arch/x86/kernel/ubsan.c      | 21 +++++++++++++++++++
 6 files changed, 93 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/include/asm/ubsan.h
 create mode 100644 arch/x86/kernel/ubsan.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 28e20975c26f..b8512887ffb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22635,6 +22635,8 @@ L:	kasan-dev@googlegroups.com
 L:	linux-hardening@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
+F:	arch/x86/include/asm/ubsan.h
+F:	arch/x86/kernel/ubsan.c
 F:	Documentation/dev-tools/ubsan.rst
 F:	include/linux/ubsan.h
 F:	lib/Kconfig.ubsan
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index a3ec87d198ac..a363d13c263b 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -13,6 +13,17 @@
 #define INSN_UD2	0x0b0f
 #define LEN_UD2		2
 
+/*
+ * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
+ */
+#define INSN_UD1	0xb90f
+#define INSN_UD_MASK	0xFFFF
+#define LEN_UD1		2
+#define INSN_ASOP	0x67
+#define INSN_ASOP_MASK	0x00FF
+#define BUG_UD_NONE	0xFFFF
+#define BUG_UD2		0xFFFE
+
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/include/asm/ubsan.h b/arch/x86/include/asm/ubsan.h
new file mode 100644
index 000000000000..ac2080984e83
--- /dev/null
+++ b/arch/x86/include/asm/ubsan.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UBSAN_H
+#define _ASM_X86_UBSAN_H
+
+/*
+ * Clang Undefined Behavior Sanitizer trap mode support.
+ */
+#include <linux/bug.h>
+#include <linux/ubsan.h>
+#include <asm/ptrace.h>
+
+/*
+ * UBSAN uses the EAX register to encode its type in the ModRM byte.
+ */
+#define UBSAN_REG	0x40
+
+#ifdef CONFIG_UBSAN_TRAP
+void handle_ubsan_failure(struct pt_regs *regs, u16 insn);
+#else
+static inline void handle_ubsan_failure(struct pt_regs *regs, u16 insn) { return; }
+#endif /* CONFIG_UBSAN_TRAP */
+
+#endif /* _ASM_X86_UBSAN_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 74077694da7d..fe1d9db27500 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
 obj-$(CONFIG_CFI_CLANG)			+= cfi.o
+obj-$(CONFIG_UBSAN_TRAP)		+= ubsan.o
 
 obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17e5043..aef21287e7ed 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -67,6 +67,7 @@
 #include <asm/vdso.h>
 #include <asm/tdx.h>
 #include <asm/cfi.h>
+#include <asm/ubsan.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -91,6 +92,29 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
 	return *(unsigned short *)addr == INSN_UD2;
 }
 
+/*
+ * Check for UD1, UD2, with or without Address Size Override Prefixes instructions.
+ */
+__always_inline u16 get_ud_type(unsigned long addr)
+{
+	u16 insn;
+
+	if (addr < TASK_SIZE_MAX)
+		return BUG_UD_NONE;
+	insn = *(u16 *)addr;
+	if ((insn & INSN_UD_MASK) == INSN_UD2)
+		return BUG_UD2;
+	if ((insn & INSN_ASOP_MASK) == INSN_ASOP)
+		insn = *(u16 *)(++addr);
+
+	// UBSAN encode the failure type in the two bytes after UD1
+	if ((insn & INSN_UD_MASK) == INSN_UD1)
+		return *(u16 *)(addr + LEN_UD1);
+
+	return BUG_UD_NONE;
+}
+
+
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
@@ -216,6 +240,7 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
+	int ud_type;
 
 	/*
 	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
@@ -223,7 +248,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 * irqentry_enter().
 	 */
 	kmsan_unpoison_entry_regs(regs);
-	if (!is_valid_bugaddr(regs->ip))
+	ud_type = get_ud_type(regs->ip);
+	if (ud_type == BUG_UD_NONE)
 		return handled;
 
 	/*
@@ -236,10 +262,14 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
-	    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-		regs->ip += LEN_UD2;
-		handled = true;
+	if (ud_type == INSN_UD2) {
+		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
+		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
+			regs->ip += LEN_UD2;
+			handled = true;
+		}
+	} else {
+		handle_ubsan_failure(regs, ud_type);
 	}
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
new file mode 100644
index 000000000000..c90e337a1b6a
--- /dev/null
+++ b/arch/x86/kernel/ubsan.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clang Undefined Behavior Sanitizer trap mode support.
+ */
+#include <linux/bug.h>
+#include <linux/string.h>
+#include <linux/printk.h>
+#include <linux/ubsan.h>
+#include <asm/ptrace.h>
+#include <asm/ubsan.h>
+
+/*
+ * Checks for the information embedded in the UD1 trap instruction
+ * for the UB Sanitizer in order to pass along debugging output.
+ */
+void handle_ubsan_failure(struct pt_regs *regs, u16 type)
+{
+	if ((type & 0xFF) == UBSAN_REG)
+		type >>= 8;
+	pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
+}
-- 
2.25.1

