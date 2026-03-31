Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C323630AD
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955072; cv=none; b=reZSRb/Wd0Q+7Ic1SBNLtgJl8whEgkImmtIoUgP6+bwTsncHs+MxZfUoPMlSeWXXN78qBkXgKikMMpD8+KsPx02NCogZNMXTHqnvnN9Y4nQO5ySBLIYcFmaSY7gj2tzQaYKhtGSQ7jigYrK1pOOsnOzfZpybPpu7JDStM/x1LEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955072; c=relaxed/simple;
	bh=M6EIu6Afc0oBMVsCGDUeBE0bnZVnmi9c0EPuIf/RvQY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BU1av18NFsW6Xzkh7RrQ0YqYNs+gO/eXWjy91DwnGmBjIfaQ1Gj2C1Kuf8QKwCCgFkMdkjje48mrBltjeVewWKkW/23sE2tnYcSTHSYI8/wvhx4xUBwzma/dBAJGud2KcBt0EEz/bs7kJWNczoCPyavX5sB9EkrLf6nWIHZNF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnaIXz+d; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnaIXz+d"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d07f0aca0so611328f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774955069; x=1775559869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=36J1iwO3uewGR7LwpckoN3+SUciZBWS6Lj6AbSclXvk=;
        b=jnaIXz+dLPIrhmBzZiENoHbiO63tBAx3Yn0EG3j0gEOlRWHi09r5BX6ouLMQs93sdw
         QRcJMJIW4nPVYqNe8X49rFUP7o2gUiKDt1kOs6Fx5NtVkYVg6CziLbXN0HZsoTFKgTqA
         nyVPBVn0Yn7HtY1PoCE1+s3fmn/iJI6t0LorstqlYxSr8pWHK70860tJuuCCRix3Ss+5
         BxIcS7cDF2gMXTQgetK+g5/+Itt2MKfrZBNMCB6jWYlKKc+1ncA5lFMKkXtXYNPaFLKL
         iY0n9H9n6ESAPQZlFus53ey3dmOhoVTPsoRw/oM2iq1aNPnTQmzjM+OV68rWWHtxHOlQ
         YUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774955069; x=1775559869;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36J1iwO3uewGR7LwpckoN3+SUciZBWS6Lj6AbSclXvk=;
        b=Yw5b+nnwePc5v2igfmwaRnt5X8UQrkavyEway5+BgIm3uKTd4L3Uyrjc7xsGm2wpry
         fTfPqBhXlbPu2tUYUJTedM6cX8HDo8YQ0Pk3Tk5qaJ4uGquIPaKG2bOBtD0vDlQKO7Zv
         IoM4vz1/Le/fZAHWvndDfPyBB0SwFREcJSXTNg5BSM/wWjKV1V9OcP3pC9VUcZCQvynH
         2NuPLOyR9wtgzCz5/rSpLkDx/pOLahwO0PYpvjc92zQgyhis+k91fLNIDrXYbuPuADIa
         I5wOWR+FmXV4jotzmQqieLUGAnQ6F22sS/tlycV9TDbG25hLaXXwjrV0iZx8Rz3RzEdz
         Cj3g==
X-Gm-Message-State: AOJu0YxCpcfgLeCMsHOEB6Wp/QfbVRR5Dk0xMoou4wOjJ1R5QDvpstcd
	NfsEG86IO7wu1miwYi3ymwcml6QfuZ0XGZAk+vEqzRQxInapwu3iK4TwZLuK1EHF+R128YqZ9A=
	=
X-Received: from wrnl9.prod.google.com ([2002:adf:e9c9:0:b0:43c:ffbe:2059])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4013:b0:43b:5b25:67f8
 with SMTP id ffacd0b85a97d-43b9e99790bmr28653172f8f.20.1774955068516; Tue, 31
 Mar 2026 04:04:28 -0700 (PDT)
Date: Tue, 31 Mar 2026 13:04:23 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5752; i=ardb@kernel.org;
 h=from:subject; bh=UkgpvkytwmrQFmSMa05ABh3qtcMUUiZ2w9uwBJoLROk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfP0KvPZS/7WLjKrffvxxo/vfMwzRDb/yF08s3iforadt
 u62vumXOkpZGMS4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEmm0Y/leWZ9/Ou39Sbc4p
 xeaZWQKKpWtUxB4ktlU4vJx6Vfj7BH6G/xEtFzaX8MoutFYJKLH+u4Sxt3Vt30tTz0n1X1rY/zO 2cgEA
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331110422.301901-2-ardb+git@google.com>
Subject: [PATCH v8] arm64: Use static call trampolines when kCFI is enabled
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-hardening@vger.kernel.org, will@kernel.org, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Sean Christopherson <seanjc@google.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Implement arm64 support for the 'unoptimized' static call variety, which
routes all calls through a trampoline that performs a tail call to the
chosen function, and wire it up for use when kCFI is enabled. This works
around an issue with kCFI and generic static calls, where the prototypes
of default handlers such as __static_call_nop() and __static_call_ret0()
don't match the expected prototype of the call site, resulting in kCFI
false positives [0].

Since static call targets may be located in modules loaded out of direct
branching range, this needs a ADRP/ADD pair to load the branch target
into R16 and a branch-to-register (BR) instruction to perform an
indirect call. This is the exact code sequence that is used by modules
when the call target is out of direct branching range.

Unlike on x86, there is no pressing need on arm64 to avoid indirect
calls at all cost, but hiding it from the compiler as is done here does
have some benefits:
- the literal is located in .rodata, which gives us the same robustness
  advantage that code patching does;
- no D-cache pollution from fetching hash values from .text sections.

From an execution speed PoV, this is unlikely to make any difference at
all.

[0] https://lore.kernel.org/all/20260311225822.1565895-1-cmllamas@google.com/

Cc: Carlos Llamas <cmllamas@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will McVicker <willmcvicker@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v8: Simplify the trampoline by combining the NULL and RET0 cases, and
    dropping the conditional branch and return
v7: https://lore.kernel.org/all/20260313061852.4025964-1-cmllamas@google.com/

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/static_call.h | 31 ++++++++++++++++++++
 arch/arm64/kernel/Makefile           |  1 +
 arch/arm64/kernel/static_call.c      | 23 +++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S      |  1 +
 5 files changed, 57 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 38dba5f7e4d2..9ea19b74b6c3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -252,6 +252,7 @@ config ARM64
 	select HAVE_RSEQ
 	select HAVE_RUST if RUSTC_SUPPORTS_ARM64
 	select HAVE_STACKPROTECTOR
+	select HAVE_STATIC_CALL if CFI
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/asm/static_call.h
new file mode 100644
index 000000000000..b73960c949e4
--- /dev/null
+++ b/arch/arm64/include/asm/static_call.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+
+#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, target)		    \
+	asm("	.pushsection .static_call.text, \"ax\"		\n" \
+	    "	.align	4					\n" \
+	    "	.globl	" name "				\n" \
+	    name ":						\n" \
+	    "	hint	34	/* BTI C */			\n" \
+	    "	adrp	x16, 1f					\n" \
+	    "	ldr	x16, [x16, :lo12:1f]			\n" \
+	    "	br	x16					\n" \
+	    "	.type	" name ", %function			\n" \
+	    "	.size	" name ", . - " name "			\n" \
+	    "	.popsection					\n" \
+	    "	.pushsection .rodata, \"a\"			\n" \
+	    "	.align	3					\n" \
+	    "1:	.quad	" #target "				\n" \
+	    "	.popsection					\n")
+
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(STATIC_CALL_TRAMP_STR(name), #func)
+
+#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, __static_call_return0)
+
+#define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)			\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, __static_call_return0)
+
+#endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 76f32e424065..fe627100d199 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_MODULES)			+= module.o module-plts.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF)	+= watchdog_hld.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
+obj-$(CONFIG_HAVE_STATIC_CALL)		+= static_call.o
 obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
 obj-$(CONFIG_KGDB)			+= kgdb.o
 obj-$(CONFIG_EFI)			+= efi.o efi-rt-wrapper.o
diff --git a/arch/arm64/kernel/static_call.c b/arch/arm64/kernel/static_call.c
new file mode 100644
index 000000000000..8b3a19e10871
--- /dev/null
+++ b/arch/arm64/kernel/static_call.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/static_call.h>
+#include <linux/memory.h>
+#include <asm/text-patching.h>
+
+void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
+{
+	u64 literal;
+	int ret;
+
+	if (!func)
+		func = __static_call_return0;
+
+	/* decode the instructions to discover the literal address */
+	literal = ALIGN_DOWN((u64)tramp + 4, SZ_4K) +
+		  aarch64_insn_adrp_get_offset(le32_to_cpup(tramp + 4)) +
+		  8 * aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12,
+						    le32_to_cpup(tramp + 8));
+
+	ret = aarch64_insn_write_literal_u64((void *)literal, (u64)func);
+	WARN_ON_ONCE(ret);
+}
+EXPORT_SYMBOL_GPL(arch_static_call_transform);
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 2964aad0362e..2d1e75263f03 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -191,6 +191,7 @@ SECTIONS
 			LOCK_TEXT
 			KPROBES_TEXT
 			HYPERVISOR_TEXT
+			STATIC_CALL_TEXT
 			*(.gnu.warning)
 	}
 
-- 
2.53.0.1018.g2bb0e51243-goog

