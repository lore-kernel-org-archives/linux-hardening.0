Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A69C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 30 Oct 2021 07:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1820860FC0
	for <linux-hardening@archiver.kernel.org>; Sat, 30 Oct 2021 07:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhJ3HxM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 30 Oct 2021 03:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhJ3HxL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 30 Oct 2021 03:53:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E4EC061570;
        Sat, 30 Oct 2021 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bJjYWtjn/5fwmGiuLlxKjwbWp2U0O7ABgFR/V2MAWLY=; b=fpxxBRgje51u1gz8I/h1bSawIU
        ptgwfqJ1NKoZFChG85eYCef0TVD0cni+Jo87tykK0tTkXhOzXrIwpsljmXtR6R4FviEwVqDhedqbE
        ieQPgExB+YA3jpdmQ8oGyofWssOg1Y/c7IoALNuHagL7O5bhqpmKlJvd3QAolemjTpo/EjmcaMtSc
        SgiwrAEi8wHt+8GAZiYigK4LdJFLub7zJb0sH9DekwVro4h+ybcehoLFvz+wK3oxoFf0BmhevTwb1
        Opm7rBueBxnB0QnB8bTcqqi4dzPmSHGi0ZOLB3/L9drDgCzMpMX/eUEnLZzSXqThkcR7Ip4LNTALa
        LQhtmbEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgj5q-002ILL-HC; Sat, 30 Oct 2021 07:48:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23EE8986247; Sat, 30 Oct 2021 09:47:58 +0200 (CEST)
Date:   Sat, 30 Oct 2021 09:47:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: [PATCH] static_call,x86: Robustify trampoline patching
Message-ID: <20211030074758.GT174703@worktop.programming.kicks-ass.net>
References: <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net>
 <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
 <20211029200324.GR174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029200324.GR174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 29, 2021 at 10:03:24PM +0200, Peter Zijlstra wrote:

> So I had a bit of a peek at what clang generates:
> 
>     3fa4:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        3fa7: R_X86_64_32S      __SCK__x86_pmu_handle_irq
>     3fab:       48 c7 c6 00 00 00 00    mov    $0x0,%rsi        3fae: R_X86_64_32S      __SCT__x86_pmu_handle_irq.cfi_jt
>     3fb2:       e8 00 00 00 00          call   3fb7 <init_hw_perf_events+0x1dc> 3fb3: R_X86_64_PLT32    __static_call_update-0x4
> 
> So this then gives the trampoline jump table entry to
> __static_call_update(), with the result that it will rewrite the
> jump-table entry, not the trampoline!
> 
> Now it so happens that the trampoline looks *exactly* like the
> jump-table entry (one jmp.d32 instruction), so in that regards it'll
> again 'work'.
> 
> But this is all really, as in *really*, wrong. And I'm really sad I'm
> the one to have to discover this, even though I've mentioned
> static_call()s being tricky in previous reviews.

The below makes the clang-cfi build properly sick:

[    0.000000] trampoline signature fail
[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at arch/x86/kernel/static_call.c:65!

---
Subject: static_call,x86: Robustify trampoline patching

Add a few signature bytes after the static call trampoline and verify
those bytes match before patching the trampoline. This avoids patching
random other JMPs (such as CFI jump-table entries) instead.

These bytes decode as:

   d:   53                      push   %rbx
   e:   43 54                   rex.XB push %r12

And happen to spell "SCT".

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/static_call.h |  1 +
 arch/x86/kernel/static_call.c      | 14 ++++++++++----
 tools/objtool/check.c              |  3 +++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index cbb67b6030f9..39ebe0511869 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -27,6 +27,7 @@
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
 	    insns "						\n"	\
+	    ".byte 0x53, 0x43, 0x54				\n"	\
 	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
 	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
 	    ".popsection					\n")
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index ea028e736831..9c407a33a774 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -56,10 +56,15 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void
 	text_poke_bp(insn, code, size, emulate);
 }
 
-static void __static_call_validate(void *insn, bool tail)
+static void __static_call_validate(void *insn, bool tail, bool tramp)
 {
 	u8 opcode = *(u8 *)insn;
 
+	if (tramp && memcmp(insn+5, "SCT", 3)) {
+		pr_err("trampoline signature fail");
+		BUG();
+	}
+
 	if (tail) {
 		if (opcode == JMP32_INSN_OPCODE ||
 		    opcode == RET_INSN_OPCODE)
@@ -74,7 +79,8 @@ static void __static_call_validate(void *insn, bool tail)
 	/*
 	 * If we ever trigger this, our text is corrupt, we'll probably not live long.
 	 */
-	WARN_ONCE(1, "unexpected static_call insn opcode 0x%x at %pS\n", opcode, insn);
+	pr_err("unexpected static_call insn opcode 0x%x at %pS\n", opcode, insn);
+	BUG();
 }
 
 static inline enum insn_type __sc_insn(bool null, bool tail)
@@ -97,12 +103,12 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 	mutex_lock(&text_mutex);
 
 	if (tramp) {
-		__static_call_validate(tramp, true);
+		__static_call_validate(tramp, true, true);
 		__static_call_transform(tramp, __sc_insn(!func, true), func);
 	}
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site) {
-		__static_call_validate(site, tail);
+		__static_call_validate(site, tail, false);
 		__static_call_transform(site, __sc_insn(!func, tail), func);
 	}
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fb3f251ea021..6d5951113d53 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3310,6 +3310,9 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	if (!insn->func)
 		return false;
 
+	if (insn->func->static_call_tramp)
+		return true;
+
 	/*
 	 * CONFIG_UBSAN_TRAP inserts a UD2 when it sees
 	 * __builtin_unreachable().  The BUG() macro has an unreachable() after
