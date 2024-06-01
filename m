Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2F4690;
	Sat,  1 Jun 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717211438; cv=none; b=G50iGBEUgE0zS+dkt637m2js1wm/LxQSc8c4X6hVqzcbgHH+rH1nQeG6U+J01lja+vxqLhSvhkRiYzAtK1YqDTC0bIdB6rSFxavEX6GYMx22rDvaTeCOb5GY4heLDa6BzZA9x+qXEF0SM5HRGDxTYBtjHfEv7DuaaqtQuMID43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717211438; c=relaxed/simple;
	bh=oSGW82qH1pk7AijenKYz6iWCOpYTl6GSAI49mjY7zTY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=pMsMsnEElbpP7cXjjg1Jhgg3iHI6tQuCh+Gw8gaJiDazcRmm2HCMF2cBM8dF8KEcjb0bqLfZXDwGhM+oD1M1ymaFY3MH3gukFoTkGDTEhGWE7C4G3Calr0tpU+GzBsVH759xSCBpBE1JXmNO5t4WYt+pzweC0WCRXle9jtQjtu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOF9zUte; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOF9zUte"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f4a5344ec7so20251545ad.1;
        Fri, 31 May 2024 20:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717211436; x=1717816236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZapLPythn+7OkdKcS6JWdxzNsHsHOH/K7Ra5EurPq0=;
        b=XOF9zUte+q1Zt+8PC8zO4VSGZGTZbv+MpvZWZIf/+8Ui1YTM+cGvu0WPJlT0GSL9G3
         bZJrS+rl53cVDhRaxcRie8PALKcqYiKGU8C5Nk47eNmdG1OKCOeKFtsGkWnw+SAt1G8T
         h5Bs+csIJZaDDvpbevOy2BU7nX7QqSWhOL+h22et60QQAhdFd7je2QLaOJ6WyODwnS2b
         9D9Kx0u4F77ci6kkbncueANuNCfAn16CbUX0dSPaAZw+31+c9iJ0PjYTODsNUy4AL6wG
         ATO/ADtm27hQaW/Tcytb3TxA3CpPKAUxWHZ1qqVwzkGlvX9ENEVcZLtwTsIr7jO/gF9O
         zIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717211436; x=1717816236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZapLPythn+7OkdKcS6JWdxzNsHsHOH/K7Ra5EurPq0=;
        b=I0H9PORBZPicqKdUvgCi4/6EYZ3sZr+0OgFkGdbfGdlT15UtrR/QeTtdE7qtH1DhWL
         OCjqdyliaiogJ91qB86YDwp0fiWtczemXOzQQwC8m9fGDMftxDbE6iMc9tMwD4EkQt3O
         JHp0xWth6Kdx37f5UeQhUEDAfeppM+Zbp030etkwuLECIZXBkWKxLj8iciVs9Xj4NTDa
         fNvtgyJyFjAT0tCQDbwfPCU4lTJzx6Wdk1ecqH/XhatTJv11/BnR2TI+AUrd3lt9PZmD
         3cvic992loE+65VVHS4PksgGpiTQAh+OxpOUnkqZZYP3FTnwIozc9Fa3Ksyy2vhMrGhv
         4UFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEjwbBO5KYccNzT1Ir8H91y7BMF5+MKvftVqDA+OhCI/+cLYpOe4gOhBdGOvkvooG+FwsbaoL+e4+17fVVA7B+XO5GvR5tVjsOhw4761QCX396j+CymKEvl8X2TjxTfYJDAogx3BPQRoVL/Bwh
X-Gm-Message-State: AOJu0YyV4tLaBk0TNP0/PFw3QIrtNqZQsQJ5lMrRL+lbZ5PrNUkFIRD2
	+6f9vwkMlM4t9dKC+rDAbs0sD31mT623hOJ+EGcWlBCb37oZH0xP
X-Google-Smtp-Source: AGHT+IFhsqiVz9EDeD/CbXvtEMgU+B5unGFQLECQrx8z9hlXmFFpKVSwe+ozJKX0foC9phVtE7m7Cw==
X-Received: by 2002:a17:902:780c:b0:1f1:8fd9:b99d with SMTP id d9443c01a7336-1f61bfa6dc5mr71550035ad.23.1717211436189;
        Fri, 31 May 2024 20:10:36 -0700 (PDT)
Received: from localhost.localdomain ([2604:a880:4:1d0::427:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6323ddac9sm24097325ad.173.2024.05.31.20.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 20:10:35 -0700 (PDT)
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
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Changbin Du <changbin.du@huawei.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Tina Zhang <tina.zhang@intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] x86/traps: Enable UBSAN traps on x86
Date: Sat,  1 Jun 2024 03:10:05 +0000
Message-Id: <20240601031019.3708758-1-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Bring x86 to parity with arm64, similar to commit 25b84002afb9
("arm64: Support Clang UBSAN trap codes for better reporting").
Enable the output of UBSAN type information on x86 architectures
compiled with clang when CONFIG_UBSAN_TRAP=y. Currently ARM
architectures output which specific sanitizer caused the trap,
via the encoded data in the trap instruction. Clang on x86
currently encodes the same data in ud1 instructions but the x86
handle_bug() and is_valid_bugaddr() functions currently only look
at ud2s.

Signed-off-by: Gatlin Newhouse <gatlin.newhouse@gmail.com>
---
Changes in v2:
  - Name the new constants 'LEN_ASOP' and 'INSN_ASOP' instead of
    'LEN_REX' and 'INSN_REX'
  - Change handle_ubsan_failure() from enum bug_trap_type to void
    function

v1: https://lore.kernel.org/linux-hardening/20240529022043.3661757-1-gatlin.newhouse@gmail.com/
---
 MAINTAINERS                  |  2 ++
 arch/x86/include/asm/bug.h   |  8 ++++++++
 arch/x86/include/asm/ubsan.h | 18 ++++++++++++++++++
 arch/x86/kernel/Makefile     |  1 +
 arch/x86/kernel/traps.c      | 29 +++++++++++++++++++++++------
 arch/x86/kernel/ubsan.c      | 30 ++++++++++++++++++++++++++++++
 6 files changed, 82 insertions(+), 6 deletions(-)
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
index a3ec87d198ac..1023c149f93d 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -13,6 +13,14 @@
 #define INSN_UD2	0x0b0f
 #define LEN_UD2		2
 
+/*
+ * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
+ */
+#define INSN_UD1	0xb90f
+#define LEN_UD1		2
+#define INSN_ASOP	0x67
+#define LEN_ASOP	1
+
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/include/asm/ubsan.h b/arch/x86/include/asm/ubsan.h
new file mode 100644
index 000000000000..896ad7bf587f
--- /dev/null
+++ b/arch/x86/include/asm/ubsan.h
@@ -0,0 +1,18 @@
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
+#ifdef CONFIG_UBSAN_TRAP
+void handle_ubsan_failure(struct pt_regs *regs, int insn);
+#else
+static inline void handle_ubsan_failure(struct pt_regs *regs, int insn) { return; }
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
index 4fa0b17e5043..ee77c868090a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -67,6 +67,7 @@
 #include <asm/vdso.h>
 #include <asm/tdx.h>
 #include <asm/cfi.h>
+#include <asm/ubsan.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -79,6 +80,9 @@
 
 DECLARE_BITMAP(system_vectors, NR_VECTORS);
 
+/*
+ * Check for UD1, UD2, with or without Address Size Override Prefixes instructions.
+ */
 __always_inline int is_valid_bugaddr(unsigned long addr)
 {
 	if (addr < TASK_SIZE_MAX)
@@ -88,7 +92,13 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
 	 * We got #UD, if the text isn't readable we'd have gotten
 	 * a different exception.
 	 */
-	return *(unsigned short *)addr == INSN_UD2;
+	if (*(u16 *)addr == INSN_UD2)
+		return INSN_UD2;
+	if (*(u16 *)addr == INSN_UD1)
+		return INSN_UD1;
+	if (*(u8 *)addr == INSN_ASOP && *(u16 *)(addr + 1) == INSN_UD1)
+		return INSN_ASOP;
+	return 0;
 }
 
 static nokprobe_inline int
@@ -216,6 +226,7 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
+	int insn;
 
 	/*
 	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
@@ -223,7 +234,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 * irqentry_enter().
 	 */
 	kmsan_unpoison_entry_regs(regs);
-	if (!is_valid_bugaddr(regs->ip))
+	insn = is_valid_bugaddr(regs->ip);
+	if (insn == 0)
 		return handled;
 
 	/*
@@ -236,10 +248,15 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
-	    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-		regs->ip += LEN_UD2;
-		handled = true;
+
+	if (insn == INSN_UD2) {
+		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
+		handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
+			regs->ip += LEN_UD2;
+			handled = true;
+		}
+	} else {
+		handle_ubsan_failure(regs, insn);
 	}
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
new file mode 100644
index 000000000000..35b2039a3b8f
--- /dev/null
+++ b/arch/x86/kernel/ubsan.c
@@ -0,0 +1,30 @@
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
+void handle_ubsan_failure(struct pt_regs *regs, int insn)
+{
+	u32 type = 0;
+
+	if (insn == INSN_ASOP) {
+		type = (*(u16 *)(regs->ip + LEN_ASOP + LEN_UD1));
+		if ((type & 0xFF) == 0x40)
+			type = (type >> 8) & 0xFF;
+	} else {
+		type = (*(u16 *)(regs->ip + LEN_UD1));
+		if ((type & 0xFF) == 0x40)
+			type = (type >> 8) & 0xFF;
+	}
+	pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
+}
-- 
2.25.1

