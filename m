Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC69C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 13 May 2022 20:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384160AbiEMUXN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 May 2022 16:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384194AbiEMUWt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 May 2022 16:22:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F93115E639
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t42-20020a25aaad000000b00649d5b19ee3so8225185ybi.4
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=JmUcB71UJsapD3GVrO4eUWV0XUj+8/03004nVnvcXak=;
        b=q+waAbIPDqPXiH8Wgpa93Fc43zirFgzfaoRzu0Q5jNfW74oP0t5HWD2wC1p1VHbruB
         7qYzcZ894qexmN06FGKvFmNxzmoZjlpErpk9CisCKJylmj/NZCW/7c+4QXNZUzkOyqY5
         ZmrN+OotCHK0Zxe6n6widKeoxY6e4P6cB5hh8ACBmzF3WPinJVT7094cUhFIg4g9rOgH
         HrYQk4QQjb3Yg8txeGH/fxa1z+bPXdFTIoOUn6STFBkAo5+racs7j7HLOp+WR7/u5i9Z
         fbE+JWGAc+uThCpOJoTMigL5puZSpV0KB0FiT9EKn/mSiY0cT9VjwEJD/StPJlOU0Cev
         8cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=JmUcB71UJsapD3GVrO4eUWV0XUj+8/03004nVnvcXak=;
        b=S9yxnnE4uHW/eACltT5vQY+gB2u62UrvGuuRlvmBUEEGUvHTi7NhpCHV9EKiJ8l1M8
         7jgN01rItpDnu0TLIqlCMMO9FJfj1Rq838YAlpxI0KkLuw+pbmwx2sCfhoIzsFeIsSAI
         KnfSFjm+XKAlRADT9jZT1nwOQ83oZmEyng33g0+cyrWyJ7/EBxwPzt39P1RnjcjmymnS
         KJF4/fMcx9TLf2wXOsey+bLsAFemi1qcEN4/Nmoc3CfxLfolYFtKfHnNopzo1Dwu+/xN
         Wpfy4Xn3nO4H9N7COJQMKQ2+53u2FBMf2Uf47wUKLnlmJHm8f4GpuQrDXAjHj4Kg8mNx
         yJTg==
X-Gm-Message-State: AOAM531SYGx3hMYpUQEBCm6vOPpJ/n6zqLHl/IyZA1UR/HZbl7LIqXvy
        VK9kVtDkhs1EF6PXbdRXBM7kb8/bIbkMSzcYS4A=
X-Google-Smtp-Source: ABdhPJxGXIqwfLWWVdQxKuBrR4ghlUD/U84TY8XUBMGdfyRVGJlvO7KK85ebE9nSek/CneTaJ2zwEZeCATeLZcT7B6g=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:ca0b:0:b0:648:3e2d:3f1e with SMTP
 id a11-20020a25ca0b000000b006483e2d3f1emr6403961ybg.362.1652473367748; Fri,
 13 May 2022 13:22:47 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:58 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; h=from:subject;
 bh=bn6mttx/+N79EqzqH4lUGVrrHJpkhXhGEyYfvAshG7g=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3miAgPARrfh1jZo/AMj9afOxuevNvNz1zEXoxO
 T5E2BAmJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695gAKCRBMtfaEi7xW7uTzC/
 9b9JUjgkRS+vIpbCBv2wAQzLNRFHZegpFnvMQoIRaCvqoY5boY6o0Xuz4QszhTRn1+ascJMVcRMW6Z
 oHJDJPwlebdNS6OMzh83h9gqPCPvFqtHxuUILPy4WV3SidB7tv86rJaDoTIajuK3Ea40avqwWsmfOF
 aRuH7ecXZnSmH7uiY0mhXR/DbiXrBK5xh4ZTiuCx307rT3EhXyn6Ct4FnxDH9pCtH73EbaXflqQkBa
 ryRG4iDZf5TcRVeSDnJr+U81TkzvdCCXZmcWq4wo7r3BL3GeMZOZurN5sSNndagsAYijRCnfD5cj5o
 e4gPm+t6uteLjf2G920Xk43zl0MKhtuWtH2aeRse7fvHufNm5LLJjPTbMjQcA9/IvOaIMWixIS/bpw
 s2jg8SjAkgt4uypGp881cRfUjnY6/ujb0NCeb7C8YoA+20X4sdEJgSLx5vdf1D6AhEjOF5QG/7NyUa
 KNnOpBF6vXJPl0DlF3Ic+IY/CA2aDA/bukfnAaBt3CIeg=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler injects a type preamble
immediately before each function and a check to validate the target
function type before indirect calls:

  ; type preamble
  __cfi_function:
    int3
    int3
    mov <id>, %eax
    int3
    int3
  function:
    ...
  ; indirect call check
    cmpl=C2=A0 =C2=A0 <id>, -6(%r11)
    je      .Ltmp1
    ud2
  .Ltmp1:
    call    __x86_indirect_thunk_r11

Define the __CFI_TYPE helper macro for manual type annotations in
assembly code, add error handling for the CFI ud2 traps, and allow
CONFIG_CFI_CLANG to be selected on x86_64.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig               |  2 ++
 arch/x86/include/asm/linkage.h | 12 +++++++
 arch/x86/kernel/traps.c        | 60 +++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4bed3abf444d..2e73d0792d48 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -108,6 +108,8 @@ config X86
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <=3D 4096
+	select ARCH_SUPPORTS_CFI_CLANG		if X86_64
+	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.=
h
index 85865f1645bd..0ee4a0af3974 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -25,6 +25,18 @@
 #define RET	ret
 #endif
=20
+#ifdef CONFIG_CFI_CLANG
+#define __CFI_TYPE(name)					\
+	.fill 7, 1, 0xCC ASM_NL					\
+	SYM_START(__cfi_##name, SYM_L_LOCAL, SYM_A_NONE)	\
+	int3 ASM_NL						\
+	int3 ASM_NL						\
+	mov __kcfi_typeid_##name, %eax ASM_NL			\
+	int3 ASM_NL						\
+	int3 ASM_NL						\
+	SYM_FUNC_END(__cfi_##name)
+#endif
+
 #else /* __ASSEMBLY__ */
=20
 #ifdef CONFIG_SLS
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1563fb995005..320e257eb4be 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -40,6 +40,7 @@
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
 #include <linux/ioasid.h>
+#include <linux/cfi.h>
=20
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -295,6 +296,62 @@ static inline void handle_invalid_op(struct pt_regs *r=
egs)
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
=20
+#ifdef CONFIG_CFI_CLANG
+static void decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
+			    unsigned long *type)
+{
+	char buffer[MAX_INSN_SIZE];
+	struct insn insn;
+	int offset;
+
+	*target =3D *type =3D 0;
+
+	/*
+	 * The compiler generates the following instruction sequence
+	 * for indirect call checks:
+	 *
+	 * =C2=A0 cmpl=C2=A0 =C2=A0 <id>, -6(%reg)	; 7 bytes
+	 *   je      .Ltmp1		; 2 bytes
+	 *   ud2			; <- addr
+	 *   .Ltmp1:
+	 *
+	 * Both the type and the target address can be decoded from the
+	 * cmpl instruction.
+	 */
+	if (copy_from_kernel_nofault(buffer, (void *)regs->ip - 9, MAX_INSN_SIZE)=
)
+		return;
+	if (insn_decode_kernel(&insn, buffer))
+		return;
+	if (insn.opcode.value !=3D 0x81 || X86_MODRM_REG(insn.modrm.value) !=3D 7=
)
+		return;
+
+	*type =3D insn.immediate.value;
+
+	offset =3D insn_get_modrm_rm_off(&insn, regs);
+	if (offset < 0)
+		return;
+
+	*target =3D *(unsigned long *)((void *)regs + offset);
+}
+
+static enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+{
+	if (is_cfi_trap(regs->ip)) {
+		unsigned long target, type;
+
+		decode_cfi_insn(regs, &target, &type);
+		return report_cfi_failure(regs, regs->ip, target, type);
+	}
+
+	return BUG_TRAP_TYPE_NONE;
+}
+#else
+static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+{
+	return BUG_TRAP_TYPE_NONE;
+}
+#endif /* CONFIG_CFI_CLANG */
+
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled =3D false;
@@ -312,7 +369,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN) {
+	if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN ||
+	    handle_cfi_failure(regs) =3D=3D BUG_TRAP_TYPE_WARN) {
 		regs->ip +=3D LEN_UD2;
 		handled =3D true;
 	}
--=20
2.36.0.550.gb090851708-goog

