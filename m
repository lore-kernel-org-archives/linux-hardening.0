Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1406B1E1029
	for <linux-hardening@vger.kernel.org>; Wed,  9 Oct 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477843; cv=none; b=tgKC68RY5YJlwsXJto36w5lm1NwN7t5JHGMF4Eg48mbf99OzTQko9YQQdOKnGw/XGPfGlw/KuGo8+f+xGD0Qv0S9YvAAACaKyPvDiZ/C9Gy5OFyR/kW5O2W+fwqfRUXIz7EOX0CXuxVgTKJqjAwUiVbCgghMwB/CaGZGw/971n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477843; c=relaxed/simple;
	bh=0bHcAwk1FtE7wnS8yZd3g7IH7HqaPqTuvx0X6BBDCTM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZjCykxokrEGLb33lpT8y09M1yTiBx2X7ISNewiZ4pzbcCCJraVTMteUjiPFrwSXVT5iOB1sqRcDAyQtc6opsCcZRYjqK3ashMmemE/wPmz7u2JM84LreQlmgfIppF6yvVySRH93m89kdXag1QwwhI4oCWJFKXsLFxVDnJcsjphI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m5cWThOb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5cWThOb"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so9732799276.0
        for <linux-hardening@vger.kernel.org>; Wed, 09 Oct 2024 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728477840; x=1729082640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EOQGqInYbwRKx9I5MqqmxixFjvxM615DnKf+PJhCNdk=;
        b=m5cWThObbcHX3nv+egNTpszU/CLy5R7cPLXQqvH6bZpVZGBEo2D8mes/DJsnUrdX5c
         Q7m9AII+uBXDjcD32KMdI8Q79T18+4M/rEkr9m+zDyf7e9/gAf4gk/LmLiD+f0VNQlkr
         7uVLUjJG/ep9uFIRfIQTJWsB9jIEwt2obCbvdZehEvNiOv3IB7aEOa8ItVBH5f6cp5Ji
         Mg2do4nd2rBkeKMp6XVbNsnW/X3DcsopplOFoY4N2l4+oKZ2J2W0TajZ+1GdhRX+Aj8i
         DLeY5IdnbKLUuT7g7QenIo+1aXk+xtT2gPzdSA3tHL6smxY5KXLzPLNSSg6ussUARu+v
         4BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477840; x=1729082640;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOQGqInYbwRKx9I5MqqmxixFjvxM615DnKf+PJhCNdk=;
        b=AmWq6GGnLGd+9F6359UhPmFNlSF5TXU2q+szfP2oF9zSbl18gib0YOQZroLgUJ2m6c
         CRXqyxpaDORx3PkeeQXMio/evSdAUy5gcXc4PO9q8IxP5xWoUXFoJlMKva7QVgiiNwHO
         pZyOKdYRDwbYi1ccwRMEEHd6bO6ExVWTFj9zcYGPWIA61zy40yhcIMjz37UFRq7h7mq4
         E4tcIa9mPsxUyK6Kk0VY3Hl4y436zGKASCo+IuhvivnwC1IEIL474IUtivx/h1ePV7T2
         tjRTSHyeytgkiRRFNWPuBXKDxDSAYuSt7IZJq8rCRq5w0M+bdYG31TS9+1yEAeng2fYN
         lSWw==
X-Forwarded-Encrypted: i=1; AJvYcCWt29LJ/zS0odB6SvGfB+4WYjoN/qBeAU2WtcP2scPAl22KaswyFVraT2iws93/Xt+PoHJ2G3Ft6AwJzKOVZ1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9yim1hubQxuTWoVlYYC4SQe4hRd3gOtwIfnSXSHojpj+wXC4w
	gNjA/F6DgaQ81st+8MVhGYjiIBNLwJKvO9BglG1Q3qt5y8Yr+h8wp65TK+EZq99nzJmxlA==
X-Google-Smtp-Source: AGHT+IEJxRS5v5JwaZ6SyyYklYdBADtytTHLbXNxpRbD72Gz4pQYyrhKTh2d3rdekoiaZZUxOons9M1K
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:abad:0:b0:e11:44fb:af26 with SMTP id
 3f1490d57ef6-e28fe31ff16mr1675276.2.1728477839944; Wed, 09 Oct 2024 05:43:59
 -0700 (PDT)
Date: Wed,  9 Oct 2024 14:43:53 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5424; i=ardb@kernel.org;
 h=from:subject; bh=UDyw98mBYs75N34uUwJo9zjn819mhGUVva9KMoRGrbQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ2tqlMu4VpoLWdM0oba8P/clYL7b97ojO67+r1VQeBZV
 L/k2XsdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCL34hgZNsceuz1DmeGr5xr1
 uasn5t/X7JlUsuJbgHvSRna7r1qPAhn+2YtMD18T/KW162H3HGnbs2bpi5yWRK/fLSFxTieHa+k xPgA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009124352.3105119-2-ardb+git@google.com>
Subject: [PATCH v2] x86/stackprotector: Work around strict Clang TLS symbol requirements
From: Ard Biesheuvel <ardb+git@google.com>
To: x86@kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Brian Gerst <brgerst@gmail.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

GCC and Clang both implement stack protector support based on Thread
Local Storage (TLS) variables, and this is used in the kernel to
implement per-task stack cookies, by copying a task's stack cookie into
a per-CPU variable every time it is scheduled in.

Both now also implement -mstack-protector-guard-symbol=, which permits
the TLS variable to be specified directly. This is useful because it
will allow us to move away from using a fixed offset of 40 bytes into
the per-CPU area on x86_64, which requires a lot of special handling in
the per-CPU code and the runtime relocation code.

However, while GCC is rather lax in its implementation of this command
line option, Clang actually requires that the provided symbol name
refers to a TLS variable (i.e., one declared with __thread), although it
also permits the variable to be undeclared entirely, in which case it
will use an implicit declaration of the right type.

The upshot of this is that Clang will emit the correct references to the
stack cookie variable in most cases, e.g.,

   10d:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
                      10f: R_386_32   __stack_chk_guard

However, if a non-TLS definition of the symbol in question is visible in
the same compilation unit (which amounts to the whole of vmlinux if LTO
is enabled), it will drop the per-CPU prefix and emit a load from a
bogus address.

Work around this by using a symbol name that never occurs in C code, and
emit it as an alias in the linker script.

Fixes: 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")
Cc: <stable@vger.kernel.org>
Cc: Fangrui Song <i@maskray.me>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/1854
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: add declaration of alias to asm-prototypes.h, but expose it only to
    genksyms

 arch/x86/Makefile                     |  5 +++--
 arch/x86/entry/entry.S                | 16 ++++++++++++++++
 arch/x86/include/asm/asm-prototypes.h |  3 +++
 arch/x86/kernel/cpu/common.c          |  2 ++
 arch/x86/kernel/vmlinux.lds.S         |  3 +++
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index cd75e78a06c1..5b773b34768d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -142,9 +142,10 @@ ifeq ($(CONFIG_X86_32),y)
 
     ifeq ($(CONFIG_STACKPROTECTOR),y)
         ifeq ($(CONFIG_SMP),y)
-			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
+            KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
+                             -mstack-protector-guard-symbol=__ref_stack_chk_guard
         else
-			KBUILD_CFLAGS += -mstack-protector-guard=global
+            KBUILD_CFLAGS += -mstack-protector-guard=global
         endif
     endif
 else
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index d9feadffa972..a503e6d535f8 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -46,3 +46,19 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
 .popsection
 
 THUNK warn_thunk_thunk, __warn_thunk
+
+#ifndef CONFIG_X86_64
+/*
+ * Clang's implementation of TLS stack cookies requires the variable in
+ * question to be a TLS variable. If the variable happens to be defined as an
+ * ordinary variable with external linkage in the same compilation unit (which
+ * amounts to the whole of vmlinux with LTO enabled), Clang will drop the
+ * segment register prefix from the references, resulting in broken code. Work
+ * around this by avoiding the symbol used in -mstack-protector-guard-symbol=
+ * entirely in the C code, and use an alias emitted by the linker script
+ * instead.
+ */
+#ifdef CONFIG_STACKPROTECTOR
+EXPORT_SYMBOL(__ref_stack_chk_guard);
+#endif
+#endif
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 25466c4d2134..3674006e3974 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -20,3 +20,6 @@
 extern void cmpxchg8b_emu(void);
 #endif
 
+#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
+extern unsigned long __ref_stack_chk_guard;
+#endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 07a34d723505..ba83f54dfaa8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2085,8 +2085,10 @@ void syscall_init(void)
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+#ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
+#endif
 
 #endif	/* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2b7c8c14c6fd..a80ad2bf8da4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -490,6 +490,9 @@ SECTIONS
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
+/* needed for Clang - see arch/x86/entry/entry.S */
+PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
+
 #ifdef CONFIG_X86_64
 /*
  * Per-cpu symbols which need to be offset from __per_cpu_load
-- 
2.47.0.rc0.187.ge670bccf7e-goog

