Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F74C4167D
	for <linux-hardening@archiver.kernel.org>; Sun, 27 Feb 2022 18:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiB0SqL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 27 Feb 2022 13:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiB0SqJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 27 Feb 2022 13:46:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0421050B30
        for <linux-hardening@vger.kernel.org>; Sun, 27 Feb 2022 10:45:23 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so9464391pjb.0
        for <linux-hardening@vger.kernel.org>; Sun, 27 Feb 2022 10:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMkktAsNfHIhPa1AJtPClUlYlr4FtiZE1a3GDbCXgk4=;
        b=eH6EZmnqMckOS9O4oCCAOQ97Gk7PWZAVrFVwAHWRPKjSCasHblw8J3H51Cto/L4Oq/
         7zqDwL6uGdZO25v6bmjZhS2MBNmqdSItLdQ8tnbuPyKYCvQsgJaqVAw1FtxJcVe83/LS
         Zy2H2PJDdnwp3/ziVO/JJXQqpsFMARfT5Ychk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMkktAsNfHIhPa1AJtPClUlYlr4FtiZE1a3GDbCXgk4=;
        b=YSQgl/lz5HQoDfVAtUzQ8oPXH9c9LH5bJEiZ2yVe/z09KViFEp8+2mlVXuuQe8fuyQ
         XhB+JtcWp07K8krlK9JulQRkoKhAUS8mDBAD7yFt9BgUGc/ud+j9ZpBd+B6dPiSCJ9/Y
         qsIioL1LaydSe0zqWCdp+k/feB4fLIenNXEG/o7tBmNpnfXIMa5Dl60UyROZmteardZF
         IaHDPE88AusHKciuxVztbBg55KdAMiZ/OuB0I63Xg8FnSf52Ry+2tM5jeIuqYLP3bDsz
         //07iAMgr1FWfA2dtx7jXG51dQChwbomVJ+tnNik1HazWvZ97nfGyrTDp9CzBpHo/rhp
         X3NA==
X-Gm-Message-State: AOAM5334X+lsaxt554YWZgSi5ts1/VGMPV9JiHBu2uo1VsVFSe/+Jijf
        q9K+yTkRHAdIY7troMkepx6Xrw==
X-Google-Smtp-Source: ABdhPJw84+Su+R84+skE0k1lOhQUbnaFmq9xBqLDdfjXiaJKJ64Oxb/qHpmbmqqlBln5RT3beTcbVA==
X-Received: by 2002:a17:902:d705:b0:14e:e5a2:1b34 with SMTP id w5-20020a170902d70500b0014ee5a21b34mr16650742ply.88.1645987523283;
        Sun, 27 Feb 2022 10:45:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y12-20020a62ce0c000000b004ec4d8900d5sm10038318pfg.163.2022.02.27.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:45:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 5/7] um: Allow builds with Clang
Date:   Sun, 27 Feb 2022 10:45:15 -0800
Message-Id: <20220227184517.504931-6-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227184517.504931-1-keescook@chromium.org>
References: <20220227184517.504931-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3536; h=from:subject; bh=9QnH+z+rCwCFrRsn/51gPTE+pPH8ccRFsd0v6DZGBGk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiG8a8dEBk1HwrxEO2kL1Oda4tIa5yb6JeGO7Q8F+W TXMu3eKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhvGvAAKCRCJcvTf3G3AJh5fD/ 9KuzRhMOYg8agcaXgdhk9bHElsujSJHIv4H/iYy4vhIm5y+K4au1niInCr8gbRxN8h9SSpzFeHVeOV A+xuZDPDYD0/lGfOoYtZpV2f9uQZVbCu2O4DEne9NwKDTvoIRjBem9qfJmbhHpG6gcFnEYy8IA3/oe YoJUrjDoIKakakFQ0EWS7Y3OF6mZutVETPOUUBQJJ6FTmaXehOi2JRWbE5M0Y6f1utAKkHM7GQObJl gp4Y6NzKu3MsgDQC/PitvlV7wxex2381qQKHfMjaBXLtUKLizYHyvbjWStV9XM2J6VbCt0BU/LV+yJ qDs59Ih223zt/j7TbKxTAjrwLIX+byh70A+0o9K4CJvWbyAJ9X5CnAccGvf1HCW28QwuyLrpTwSAy8 YiSKxd9UxcYUI4/CDSV+8r72iiUkt7nWG1Ygv1E416BjhxHrDuk2k7nFssdZEYfIlDIqQA8ey/QpWf d48v7LOCx1Cui2GUH/XGI/QqDM7TOISr58NfvoT02QrJ398Hk/EovB9Y1CzFA+hlUrdcmRLnfw+THt WQvvUo7T7/w80plD1UFpTjsxcPq6znVhO0NCDULvpyGKXfCqzxri43YBojcrgwA4vXNVIrRUeaC5RW nBl0txZW59SpCiVLjlI9W0bmg+VGOmyOQGYcXCJo4mdIvb2DjeBGm21cJnyA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add SUBARCH target for Clang+um (which must go last, not alphabetically,
so the other SUBARCHes are assigned). Remove open-coded "DEFINE"
macro, instead using linux/kbuild.h's version which was updated to use
Clang-friendly assembly in commit cf0c3e68aa81 ("kbuild: fix asm-offset
generation to work with clang"). Redefine "DEFINE_LONGS" in terms of
"COMMENT" and "DEFINE" so that the intended coment actually has useful
content. Add a missed "break" to avoid implicit fall-through warnings.

This lets me run KUnit tests with Clang:

$ ./tools/testing/kunit/kunit.py run --make_options LLVM=1
...

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: David Gow <davidgow@google.com>
Cc: linux-um@lists.infradead.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: llvm@lists.linux.dev
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/lkml/Yg2YubZxvYvx7%2Fnm@dev-arch.archlinux-ax161/
Tested-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/lkml/CABVgOSk=oFxsbSbQE-v65VwR2+mXeGXDDjzq8t7FShwjJ3+kUg@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220217002843.2312603-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20220224055831.1854786-1-keescook@chromium.org
v3:
 - use kbuild.h to avoid duplication (Masahiro)
 - fix intended comments (Masahiro)
 - use SUBARCH (Nathan)
---
 arch/um/os-Linux/execvp.c  | 1 +
 arch/x86/um/user-offsets.c | 9 ++++-----
 scripts/Makefile.clang     | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/um/os-Linux/execvp.c b/arch/um/os-Linux/execvp.c
index 84a0777c2a45..c09a5fd5e225 100644
--- a/arch/um/os-Linux/execvp.c
+++ b/arch/um/os-Linux/execvp.c
@@ -93,6 +93,7 @@ int execvp_noalloc(char *buf, const char *file, char *const argv[])
 					   up finding no executable we can use, we want to diagnose
 					   that we did find one but were denied access.  */
 					got_eacces = 1;
+					break;
 				case ENOENT:
 				case ESTALE:
 				case ENOTDIR:
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index bae61554abcc..e54a9814ccf1 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -8,12 +8,11 @@
 #define __FRAME_OFFSETS
 #include <linux/ptrace.h>
 #include <asm/types.h>
+#include <linux/kbuild.h>
 
-#define DEFINE(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define DEFINE_LONGS(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
+#define DEFINE_LONGS(sym, val)	\
+	COMMENT(#val " / sizeof(unsigned long)");	\
+	DEFINE(sym, val / sizeof(unsigned long))
 
 void foo(void)
 {
diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 51fc23e2e9e5..87285b76adb2 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
 CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390		:= s390x-linux-gnu
 CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
+CLANG_TARGET_FLAGS_um		:= $(CLANG_TARGET_FLAGS_$(SUBARCH))
 CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))
 
 ifeq ($(CROSS_COMPILE),)
-- 
2.32.0

