Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF68C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244435AbiAXRtX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbiAXRtL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32933C061744
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:49:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C36C760FDB
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEB4C340EA;
        Mon, 24 Jan 2022 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046550;
        bh=sifjNQNJvaYEmpF/TXEf0tvu/5CoVCOTu+0FI2xI1u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulH9xi0v36dKdwRPxm0h3KHR/s25UMUrfoclFb0QBcasIcdHh8mWHQNVYdw+v/wFz
         jt+0jzJzuynSO1pydKeaYM0CoT+b4brAzQYW9aLHE2S97Gle8z9Iik2VcFnKIfzhlW
         CsTccgTIqFeaV+q17FYVrJXrB/hydJFX4Mp3OcC64HEYvEQWdkJVcPchO8qS4XJGFx
         C4rTuzBHT6xxP9NXI2j8DNEV0LvpDCqKUI9FIsSs00+Ht+ZvozSCMBfOp83KlDquqJ
         spqtC2/+LOkxeSeBU7VnPFARS8lKhi0733fScSegcQmm9TIvddTAh+6VY4A1ts4YCN
         UPyoaNvPd7Org==
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
Subject: [PATCH v5 23/32] ARM: call_with_stack: add unwind support
Date:   Mon, 24 Jan 2022 18:47:35 +0100
Message-Id: <20220124174744.1054712-24-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301; h=from:subject; bh=sifjNQNJvaYEmpF/TXEf0tvu/5CoVCOTu+0FI2xI1u4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYtE3gGvhLgCmUm3gkuPv+muXMmo8Zv0BVJ9wIE WTEKmMaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mLQAKCRDDTyI5ktmPJBjOC/ 0fJ5EJ7XBT2oHcL3oEgjcm1AMtan3NExCq49rRD8olPqSud5SgGVkNwdHauMJeurvHcaXxwvWbG3mP ptgWdmR8kUlv0mEHqLx+qHF986QjHGaKdNG3c/75z7AhQ0H3/E1tEVzr5tVeVSpwYyE8afKu33sLhH JsDxfKuMR0ySBFXe+ChN9L6wRIQ/p3iHeJ/p5QnlYimv2tcNQDyy4CeuGpd/Oj6PNtuSI0zFBhUs5X +ohLC53Vp52GT3sP17rG6JPphvOkAiETffcX1Rh63cfGzxhki4xTnNOxwblKARSvRhIe1LJ56Z+65p AaI4PVpwBSFD0ONQOTPywkQ1XDOmbSidZ4ij+cleQjA2VeNtchnGMh2D2Vz0WErYtBZQf+hLgGtMWE JQjPfRSlgjngAkUwqBblJfmLf7uwXgQB40mY2ks9pURAxyBr+zvny9UArrc+MgPjyB+hDN8d2tREhr 5+8Hz4B336Cf0my4/sOgPlKwFUaEtUY1eFZtPQyaFb/g4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Restructure the code and add the unwind annotations so that both the
frame pointer unwinder as well as the EHABI unwind info based unwinder
will be able to follow the call stack through call_with_stack().

Since GCC and Clang use different formats for the stack frame, two
methods are implemented: a GCC version that pushes fp, sp, lr and pc for
compatibility with the frame pointer unwinder, and a second version that
works with Clang, as well as with the EHABI unwinder both in ARM and
Thumb2 modes.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/lib/call_with_stack.S | 33 +++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/arm/lib/call_with_stack.S b/arch/arm/lib/call_with_stack.S
index 28b0341ae786..0a268a6c513c 100644
--- a/arch/arm/lib/call_with_stack.S
+++ b/arch/arm/lib/call_with_stack.S
@@ -8,25 +8,42 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 /*
  * void call_with_stack(void (*fn)(void *), void *arg, void *sp)
  *
  * Change the stack to that pointed at by sp, then invoke fn(arg) with
  * the new stack.
+ *
+ * The sequence below follows the APCS frame convention for frame pointer
+ * unwinding, and implements the unwinder annotations needed by the EABI
+ * unwinder.
  */
-ENTRY(call_with_stack)
-	str	sp, [r2, #-4]!
-	str	lr, [r2, #-4]!
 
+ENTRY(call_with_stack)
+#if defined(CONFIG_UNWINDER_FRAME_POINTER) && defined(CONFIG_CC_IS_GCC)
+	mov	ip, sp
+	push	{fp, ip, lr, pc}
+	sub	fp, ip, #4
+#else
+UNWIND( .fnstart		)
+UNWIND( .save	{fpreg, lr}	)
+	push	{fpreg, lr}
+UNWIND( .setfp	fpreg, sp	)
+	mov	fpreg, sp
+#endif
 	mov	sp, r2
 	mov	r2, r0
 	mov	r0, r1
 
-	badr	lr, 1f
-	ret	r2
+	bl_r	r2
 
-1:	ldr	lr, [sp]
-	ldr	sp, [sp, #4]
-	ret	lr
+#if defined(CONFIG_UNWINDER_FRAME_POINTER) && defined(CONFIG_CC_IS_GCC)
+	ldmdb	fp, {fp, sp, pc}
+#else
+	mov	sp, fpreg
+	pop	{fpreg, pc}
+UNWIND( .fnend			)
+#endif
 ENDPROC(call_with_stack)
-- 
2.30.2

