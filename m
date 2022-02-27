Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EB8C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 27 Feb 2022 19:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiB0T77 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 27 Feb 2022 14:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiB0T77 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 27 Feb 2022 14:59:59 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1451303
        for <linux-hardening@vger.kernel.org>; Sun, 27 Feb 2022 11:59:21 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so12953167pjb.5
        for <linux-hardening@vger.kernel.org>; Sun, 27 Feb 2022 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDuHse0aOow/G2Z6JU4iai5GABD+3EOHGxi2e9OqBQw=;
        b=JLghLOtkm9OAKbFfMWiP+yM0fTut2ukXs4lHFnrtdCkwAyDuqDZ6+MoU+hEK4n2d2I
         ZvJ9rEK7QfNlS6ms9lzYw8DvA96TTLWy+ZYzEHF3HgcSLGSzf5cKHsBfvFmNEhcKEDXV
         HiRxT9V0zYT6Met+AaKdo6UcGMDBiL8ncD3js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDuHse0aOow/G2Z6JU4iai5GABD+3EOHGxi2e9OqBQw=;
        b=yGpYQu5FOcna+YFwh0SLkPlIy/s6wHNCPLcxxCdkXN8eBC/fqvsJEBLzb5JOO6D21t
         jQr1HO/zM9C7dPnB55SfUbrkNg0MzU5Sib27qm4ixWFk06FPLISiR/hGui1wxMiQ8h8q
         mcznqAGQ+y4/YJ20Kg57WEjXzV1raZmLHqfyY1cqtXEcf3lFvEobGyOaaQ5j8W+/RCNr
         IJcL+xfNt1mXuKL33Kb51jD42c+6GI/0cO+VzcjhOM7w5jG2WnPz5XvSmLZUZcoAG6Ir
         HYGkhINNOZbEiaAhj6jH2HG3c+o1kXSItEZe7NfKgnE4RAo2IoIVcNW4ANxi/iZ23AS+
         mAog==
X-Gm-Message-State: AOAM5317eatopOGN5yBwI5EVzdVvJcdGsyF5Z7ApIX0Lp/tuW+ZnBCEv
        D6bcA9qA/y/HnS1iXLlxCkjvfNR7iR0mqw==
X-Google-Smtp-Source: ABdhPJwJ9cVtE7WJD7TWvaTUT9ip5wXRs8zZM2gxK+r8VPLiKbElLaEtamSnxkHBY9N3USe8eYTH6g==
X-Received: by 2002:a17:90a:de84:b0:1bd:1e3a:a3f1 with SMTP id n4-20020a17090ade8400b001bd1e3aa3f1mr7187479pjv.232.1645991961386;
        Sun, 27 Feb 2022 11:59:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x64-20020a17090a6c4600b001bc6d235a0esm14893382pjj.1.2022.02.27.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 11:59:20 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86/boot: Wrap literal addresses in absolute_pointer()
Date:   Sun, 27 Feb 2022 11:59:18 -0800
Message-Id: <20220227195918.705219-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4839; h=from:subject; bh=KS/kn6IF5Z+YFa29W+HN8pX2O9QN0K+4h8h/j5xgC0o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiG9gWznTDlJe/0XCXXNp+/UWiqqn+XMmR9LMEBfm+ ABdH0EeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhvYFgAKCRCJcvTf3G3AJuBwEA CxSBN7YrkltNotZy0JMmMdP28IK+0M5HlVKqKgXDVpF/z81VYzVU+zjBLU5Qi/qSshQHbP0OWV5YDP 5bEcZcFnUVyTvHjJ0j7cpJj0nO5aZNez2IaGRj1F6DHxZj/wShSqv4Vy4iRefjHQI6v7AyFzKB4+k0 IyUVtUk46eqh76A5kkbscu+6RWUE/yEFqOX+4fM9rfblesblarsLvrr1PbO3TQfWDMIDa41LPajGok biG2I69GIzpEVV9SESI99Rh1iHYbcetFO5uhNZ50orZeCXn3miq/vQsZJcI1pI9w86iwbflKmOU+mY 4UB95EZoq6EfjNOMZD/YxZmUr99VMyvsNYUlaqMGBbLjVStBORQIpXL2CPk5lpXAnMq0fuXlPxo/Wq IJ14Bm6Qf65L3KziiQ55H3bEkrrov0Sz63G4BkXCrKPUjTJGcgGkY31roQXARqybHOUVwkVhOKO29k Fspbwq/vKBVfMd0hmJGKQwgLgA7eUmlX62dvc/yBN5EnFqmhkzZJmUNjTf8Lp6VbGXwcnCF4OjpqBL gR/fE8VaEKbQsEOYlrXggD68F7uRODkDd+ccxLsB8w578ebd5NE8SqJvZQ6sTjLd7Y2zZm87Y0Vitn q1P3ENc28M0TiUeMWpZ8LD+dxbrOrGk6WSLvClh3ckmbU48Y/wxzkkw8rsCA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

GCC 11 (incorrectly[1]) assumes that literal values cast to (void *)
should be treated like a NULL pointer with an offset, and raises
diagnostics when doing bounds checking under -Warray-bounds. GCC 12
got "smarter" about finding these:

In function 'rdfs8',
    inlined from 'vga_recalc_vertical' at /srv/code/arch/x86/boot/video-mode.c:124:29,
    inlined from 'set_mode' at /srv/code/arch/x86/boot/video-mode.c:163:3:
/srv/code/arch/x86/boot/boot.h:114:9: warning: array subscript 0 is outside array bounds of 'u8[0]' {aka 'unsigned char[]'} [-Warray-bounds]
  114 |         asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
      |         ^~~

This has been solved in other places[2] already by using the recently
added absolute_pointer() macro. Do the same here.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
[2] https://lore.kernel.org/all/20210912160149.2227137-1-linux@roeck-us.net/

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: x86@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/boot.h | 36 ++++++++++++++++++++++++------------
 arch/x86/boot/main.c |  2 +-
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 34c9dbb6a47d..686a9d75a0e4 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -110,66 +110,78 @@ typedef unsigned int addr_t;
 
 static inline u8 rdfs8(addr_t addr)
 {
+	u8 *ptr = (u8 *)absolute_pointer(addr);
 	u8 v;
-	asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
+	asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*ptr));
 	return v;
 }
 static inline u16 rdfs16(addr_t addr)
 {
+	u16 *ptr = (u16 *)absolute_pointer(addr);
 	u16 v;
-	asm volatile("movw %%fs:%1,%0" : "=r" (v) : "m" (*(u16 *)addr));
+	asm volatile("movw %%fs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 static inline u32 rdfs32(addr_t addr)
 {
+	u32 *ptr = (u32 *)absolute_pointer(addr);
 	u32 v;
-	asm volatile("movl %%fs:%1,%0" : "=r" (v) : "m" (*(u32 *)addr));
+	asm volatile("movl %%fs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 
 static inline void wrfs8(u8 v, addr_t addr)
 {
-	asm volatile("movb %1,%%fs:%0" : "+m" (*(u8 *)addr) : "qi" (v));
+	u8 *ptr = (u8 *)absolute_pointer(addr);
+	asm volatile("movb %1,%%fs:%0" : "+m" (*ptr) : "qi" (v));
 }
 static inline void wrfs16(u16 v, addr_t addr)
 {
-	asm volatile("movw %1,%%fs:%0" : "+m" (*(u16 *)addr) : "ri" (v));
+	u16 *ptr = (u16 *)absolute_pointer(addr);
+	asm volatile("movw %1,%%fs:%0" : "+m" (*ptr) : "ri" (v));
 }
 static inline void wrfs32(u32 v, addr_t addr)
 {
-	asm volatile("movl %1,%%fs:%0" : "+m" (*(u32 *)addr) : "ri" (v));
+	u32 *ptr = (u32 *)absolute_pointer(addr);
+	asm volatile("movl %1,%%fs:%0" : "+m" (*ptr) : "ri" (v));
 }
 
 static inline u8 rdgs8(addr_t addr)
 {
+	u8 *ptr = (u8 *)absolute_pointer(addr);
 	u8 v;
-	asm volatile("movb %%gs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
+	asm volatile("movb %%gs:%1,%0" : "=q" (v) : "m" (*ptr));
 	return v;
 }
 static inline u16 rdgs16(addr_t addr)
 {
+	u16 *ptr = (u16 *)absolute_pointer(addr);
 	u16 v;
-	asm volatile("movw %%gs:%1,%0" : "=r" (v) : "m" (*(u16 *)addr));
+	asm volatile("movw %%gs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 static inline u32 rdgs32(addr_t addr)
 {
+	u32 *ptr = (u32 *)absolute_pointer(addr);
 	u32 v;
-	asm volatile("movl %%gs:%1,%0" : "=r" (v) : "m" (*(u32 *)addr));
+	asm volatile("movl %%gs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 
 static inline void wrgs8(u8 v, addr_t addr)
 {
-	asm volatile("movb %1,%%gs:%0" : "+m" (*(u8 *)addr) : "qi" (v));
+	u8 *ptr = (u8 *)absolute_pointer(addr);
+	asm volatile("movb %1,%%gs:%0" : "+m" (*ptr) : "qi" (v));
 }
 static inline void wrgs16(u16 v, addr_t addr)
 {
-	asm volatile("movw %1,%%gs:%0" : "+m" (*(u16 *)addr) : "ri" (v));
+	u16 *ptr = (u16 *)absolute_pointer(addr);
+	asm volatile("movw %1,%%gs:%0" : "+m" (*ptr) : "ri" (v));
 }
 static inline void wrgs32(u32 v, addr_t addr)
 {
-	asm volatile("movl %1,%%gs:%0" : "+m" (*(u32 *)addr) : "ri" (v));
+	u32 *ptr = (u32 *)absolute_pointer(addr);
+	asm volatile("movl %1,%%gs:%0" : "+m" (*ptr) : "ri" (v));
 }
 
 /* Note: these only return true/false, not a signed return value! */
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index e3add857c2c9..c421af5a3cdc 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -33,7 +33,7 @@ static void copy_boot_params(void)
 		u16 cl_offset;
 	};
 	const struct old_cmdline * const oldcmd =
-		(const struct old_cmdline *)OLD_CL_ADDRESS;
+		absolute_pointer(OLD_CL_ADDRESS);
 
 	BUILD_BUG_ON(sizeof(boot_params) != 4096);
 	memcpy(&boot_params.hdr, &hdr, sizeof(hdr));
-- 
2.32.0

