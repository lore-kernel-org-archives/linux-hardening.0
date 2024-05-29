Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEA15ADB1;
	Wed, 29 May 2024 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949248; cv=none; b=EWblckkG11ZjKmFJutE+iHdPgVA1WFPYUDtS4bClmvMaVysCh0RsxUECqnzFPtYq9iSPEB2kkwjcomhn6Y2Lwie0DasToYJlbh03A5bq+OEWIsH+TiX3WFrmJHtoq9RitcW3nsbb7XowvqyuryNpagmZHrEwYfa5DkfhTtSZ9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949248; c=relaxed/simple;
	bh=U+W//EVdx0UAbUQqkIfAMe/SGhPbRP7U+NdtplK/RrA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iE9nRB+0DmHzNZgVFm/SEqyOIhxWnQm9P6fPZY/jko7vknEaEzlgYdJYa7UP5RSHzQaa4MDhXYjndKp7a6rusdcvSnXiymVbz8F5QF4efGO77qE/+pU9bXUkB0DV95DFfYSuq/y35FEjQdQQGnwICUDs9tmu80NIqm7nZGV9kY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1qVvQWR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1qVvQWR"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6fcbd812b33so1366295b3a.3;
        Tue, 28 May 2024 19:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716949246; x=1717554046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=347Tv+L36ItrUa9DcwFsT5YsIM2weBtvDOWbMcJm1vI=;
        b=U1qVvQWRKaxP7cRgOBoKDYOhJkDDfTvEnvXEkYQZygfslqSrvy7URENsqpRWyrwbE2
         RrcCt9SnSdPxmthf3ebWWz9Cz8CXbHCp4+g4341P6ZomtKi7AxTFCD3yEsceLfP9xMur
         wqR2VflEypP0+UD825nPAqlKB8cmctXCpKYGHnCZmeL4SPa/9cjwugUz/RKygL0q43Nc
         cIWKXpZVwzPF4tHQ43YBrTUFTCvFdlkwddqHqEqMA4h84wcqqO3wd5LdQeg0zkEsNNIv
         KMofHkIDPPD9lkfXqKCK+J2d/2SzBrGUtXyq0KyZJUO4Tec94EZbe0NtYkiBGxOZUwBQ
         Xqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716949246; x=1717554046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=347Tv+L36ItrUa9DcwFsT5YsIM2weBtvDOWbMcJm1vI=;
        b=FDtFnCevcASMJwlzwNk/3lbRtR+vFTXBCL/PDc+niO863xcKzp9XVuVawB7XTqi93e
         vpj3Os0GmLj/PfYWqPF9Y3hLfuR/aH00/3yQYs20NqQ4ElBJDtGnJsf6Xu58srBlsHqn
         018xCg/4n9/W47qcFkHyEpmEWXreCmmRScvqOfMvHQgvISI0GXeOS8TFboS+HCl9ixZW
         pWp2eZuaQCp8ouiVbqi+3fAEfDWb2imBbKk+KJ7a0N/l1E1xya6mn2MFgG9zIqI5pAR4
         9llG54yYypgcypua1kYiHRHTRCv2n8SEDw9B1MNQIaud5QY9GyyZBJsY99jfxkimFiD6
         oyjw==
X-Forwarded-Encrypted: i=1; AJvYcCVYe0bUleE1nWFycPX9E3yqoHZA5gePpsFOob6bFtoxLhhQEF82ejT0806E3zGVxI5do1fHMFfwp28IaEre0sQJO10lFVGQOkvPyTaNmyFDgFKd3IP93mTYiFDwGony6a1gnxTQvpU4QbXeTOQR
X-Gm-Message-State: AOJu0YxAA2mA4u+XyW0uYbyydzX5M9HmrpDrs9mD/Y5JjX0Owdrw76uA
	OQqdsPZtl4Bh5eQXaos+lupGSA1ziSvF0VbqW5Sfsg0WrOHrg7uz
X-Google-Smtp-Source: AGHT+IHoETe02pTx/zsmIpmRrV07oYeWjfDTOvDLsnucWpNSSmY9ikIEOi0eCyGo/VAVReoqmSQpdw==
X-Received: by 2002:a05:6a20:da8f:b0:1af:aec3:2841 with SMTP id adf61e73a8af0-1b212e5bddbmr15754764637.56.1716949245970;
        Tue, 28 May 2024 19:20:45 -0700 (PDT)
Received: from localhost.localdomain ([2604:a880:4:1d0::427:6000])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bf5f6155b6sm9410812a91.29.2024.05.28.19.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 19:20:45 -0700 (PDT)
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
	Baoquan He <bhe@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] x86/traps: Enable UBSAN traps on x86
Date: Wed, 29 May 2024 02:20:30 +0000
Message-Id: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
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
 MAINTAINERS                  |  2 ++
 arch/x86/include/asm/bug.h   |  8 ++++++++
 arch/x86/include/asm/ubsan.h | 21 +++++++++++++++++++++
 arch/x86/kernel/Makefile     |  1 +
 arch/x86/kernel/traps.c      | 34 ++++++++++++++++++++++++++++------
 arch/x86/kernel/ubsan.c      | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 6 deletions(-)
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
index a3ec87d198ac..e3fbed9073f8 100644
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
+#define INSN_REX	0x67
+#define LEN_REX		1
+
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/include/asm/ubsan.h b/arch/x86/include/asm/ubsan.h
new file mode 100644
index 000000000000..5235822eb4ae
--- /dev/null
+++ b/arch/x86/include/asm/ubsan.h
@@ -0,0 +1,21 @@
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
+enum bug_trap_type handle_ubsan_failure(struct pt_regs *regs, int insn);
+#else
+static inline enum bug_trap_type handle_ubsan_failure(struct pt_regs *regs, int insn)
+{
+	return BUG_TRAP_TYPE_NONE;
+}
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
index 4fa0b17e5043..7876449e97a0 100644
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
+ * Check for UD1, UD2, with or without REX instructions.
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
+	if (*(u8 *)addr == INSN_REX && *(u16 *)(addr + 1) == INSN_UD1)
+		return INSN_REX;
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
@@ -236,10 +248,20 @@ static noinstr bool handle_bug(struct pt_regs *regs)
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
+		if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {
+			if (insn == INSN_REX)
+				regs->ip += LEN_REX;
+			regs->ip += LEN_UD1;
+			handled = true;
+		}
 	}
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
new file mode 100644
index 000000000000..6cae11f4fe23
--- /dev/null
+++ b/arch/x86/kernel/ubsan.c
@@ -0,0 +1,32 @@
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
+enum bug_trap_type handle_ubsan_failure(struct pt_regs *regs, int insn)
+{
+	u32 type = 0;
+
+	if (insn == INSN_REX) {
+		type = (*(u16 *)(regs->ip + LEN_REX + LEN_UD1));
+		if ((type & 0xFF) == 0x40)
+			type = (type >> 8) & 0xFF;
+	} else {
+		type = (*(u16 *)(regs->ip + LEN_UD1));
+		if ((type & 0xFF) == 0x40)
+			type = (type >> 8) & 0xFF;
+	}
+	pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
+
+	return BUG_TRAP_TYPE_NONE;
+}
-- 
2.25.1

