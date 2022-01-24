Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1D8C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244148AbiAXRtC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43846 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbiAXRtB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDABC6134A
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74896C340E8;
        Mon, 24 Jan 2022 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046540;
        bh=6iePrDdRo1FEptrMGTjRPP3aneHB8xt6RRoMqC1C9mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptoBXMtaZHLKhMA8ZOjT6ZDeM19zKEUsr02jw/eJdg/L6NrUF/GECFqOqpjKzN9uW
         GAv+VlVbUg5dUfFtKZul2fhplW6TDm6PVaOkfvT6F2rrUsGC3VGFj4nNgAB4GGN+l3
         J1bdhq99fKavOh7QqNtI6SokiQ7HDMkw3m6shenBu7s0ziOeTBlsGbsfku4bvdrD5A
         ckMdMSQt9Wre0c2DqvUtsy9YstuWph+GT/fB1gGSVu+Pe/QB0ouKGz68DYvMz1cPN9
         mDHcs9h+pZC30MNKxzPoMLaSLPei0gyF6uBTWIhkHAh3kk/E1Cf94S55E69Uz4ukPn
         zCBwEIhQBK0AA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v5 20/32] ARM: unwind: dump exception stack from calling frame
Date:   Mon, 24 Jan 2022 18:47:32 +0100
Message-Id: <20220124174744.1054712-21-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; h=from:subject; bh=6iePrDdRo1FEptrMGTjRPP3aneHB8xt6RRoMqC1C9mk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYoADUPn+SPniy3ES0sTnZF4IDI3RJ7qNFKOy8J dWMFOICJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mKAAKCRDDTyI5ktmPJEt6C/ 0Wu/eTXGd3U041kAWfvVdVR0n0DZfO2wJBB3zXW5/Wjkdjc11GQgSPEOv1pTzpr7d4yYi/74uVhzig tPpzUaRyemIsm7N/NFf41k0CQTzVcQ/oD8olnoRR5dubfuOvBLjyhxl5uoMjCG9TN6T66mgw+8eGdB WD/nHSX4zLHvCSQG95WWDNox34kbqVNQFxFNeuLqzlEUa3uCqhKm6jbRiyJpL64RSGDqd9gIeT2jtv w11qH8Gkjzkp16HeTx1QPZtvX6f4Fk3Ej6U26jUoHCzqHqMJT49LICyZOs4VuaX5CJ3jghr9vduQuH oDD4UNBqspFOyp+oHjzdsiXClX2GnAFLgHFu+wLD/qsPIct8TzfWQIQOHXWJi9hvaNidJZixLVm9nJ SyYbqQi5GOAGMbVpLMkUEEOLz3ZW/9gt3FTvoF60MP40fUP07gYpZA/lhB3lqP3KluojwDlaHIV2IH GEp+moQvWn9omVbO2Trs5kh/aTp4QwNCc51erun/qMmWA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The existing code that dumps the contents of the pt_regs structure
passed to __entry routines does so while unwinding the callee frame, and
dereferences the stack pointer as a struct pt_regs*. This will no longer
work when we enable support for IRQ or overflow stacks, because the
struct pt_regs may live on the task stack, while we are executing from
another stack.

The unwinder has access to this information, but only while unwinding
the calling frame. So let's combine the exception stack dumping code
with the handling of the calling frame as well. By printing it before
dumping the caller/callee addresses, the output order is preserved.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/include/asm/stacktrace.h | 10 ++++++++++
 arch/arm/kernel/traps.c           |  3 ++-
 arch/arm/kernel/unwind.c          |  8 +++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 33ee1aa4b8c0..d87d60532b86 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -18,6 +18,16 @@ struct stackframe {
 	struct llist_node *kr_cur;
 	struct task_struct *tsk;
 #endif
+#ifdef CONFIG_ARM_UNWIND
+	/*
+	 * This field is used to track the stack pointer value when calling
+	 * __entry routines. This is needed when IRQ stacks and overflow stacks
+	 * are used, because in that case, the struct pt_regs passed to these
+	 * __entry routines may be at the top of the task stack, while we are
+	 * executing from another stack.
+	 */
+	unsigned long sp_low;
+#endif
 };
 
 static __always_inline
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 710306eac71f..c51b87f6fc3e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -76,7 +76,8 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
 	printk("%s %ps from %pS\n", loglvl, (void *)where, (void *)from);
 #endif
 
-	if (in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
+	if (!IS_ENABLED(CONFIG_UNWINDER_ARM) &&
+	    in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
 		dump_mem(loglvl, "Exception stack", frame + 4, end);
 }
 
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 9cb9af3fc433..b7a6141c342f 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -29,6 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 
+#include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
 #include <asm/unwind.h>
@@ -459,6 +460,7 @@ int unwind_frame(struct stackframe *frame)
 	frame->sp = ctrl.vrs[SP];
 	frame->lr = ctrl.vrs[LR];
 	frame->pc = ctrl.vrs[PC];
+	frame->sp_low = ctrl.sp_low;
 
 	return URC_OK;
 }
@@ -502,7 +504,11 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		urc = unwind_frame(&frame);
 		if (urc < 0)
 			break;
-		dump_backtrace_entry(where, frame.pc, frame.sp - 4, loglvl);
+		if (in_entry_text(where))
+			dump_mem(loglvl, "Exception stack", frame.sp_low,
+				 frame.sp_low + sizeof(struct pt_regs));
+
+		dump_backtrace_entry(where, frame.pc, 0, loglvl);
 	}
 }
 
-- 
2.30.2

