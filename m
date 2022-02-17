Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFF4C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Feb 2022 00:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiBQA3A (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 19:29:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiBQA3A (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 19:29:00 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D31FFCB4
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 16:28:46 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q132so3525074pgq.7
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 16:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGcQO3MYiNVzzOdQ6PURsZcaUd8RxaLP2F5BG8x7eyQ=;
        b=Lqy2LJOcN+upnxmIuTwy3fpzudc0qiFDVU+dx5qCPOwHk6QfaFIX97c4efamZKjMMi
         euF0m2g0IF54Vfa68IeK+IXk2NUQXtaq7kA0Uod+Y2cXxKbxzrX4PExsECyuXGTltvrA
         i2leezKeoQtfK2DYFOiqo//LmWYDTGnE5l2q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGcQO3MYiNVzzOdQ6PURsZcaUd8RxaLP2F5BG8x7eyQ=;
        b=pWszDw8+bhYBgGA3jdYUsoP7Fg/CuQ/tPrau5tuc6k0nsdPTqXtLMcLUBLyiZoFNG1
         UVS2ZexYL5oQirDaWSCUk2CI59LEvssbHREwFpsCYUVi89IcCmD3U72bBOmuLvhtr0A1
         sGFpNjB+XjM528JoAfaPq+TIFUAgkIj+pMLoxvUM8eOhBPqUpiy7kMLXQauTdpDIxw6M
         BhUC74WLGlMgbrp8u5MCtuSJQc38C0h+p317ZRJoNjmPWLgmlbvdL3JFAx0BftrzquAp
         LawQyki93oQTTgIAHEcjpoewXKg9OfwPxZqKX3U/D0GC/7bTzlVb8P5f4NWBumSjtAHg
         sRNA==
X-Gm-Message-State: AOAM5322p3pc2GI257CjPtgCy9GSsV8jmUlkXgOiJy6SUySR3/y7nvS/
        qKYe7KAifRYpYPebP7AHj77yXA==
X-Google-Smtp-Source: ABdhPJxm+8yfHYB9vBipUYW1o+9PJNIevacMU+b/iaFcke9KfnDnfNB1BpC49YXhw4myccRnzpcrRQ==
X-Received: by 2002:a63:8bca:0:b0:370:2717:3756 with SMTP id j193-20020a638bca000000b0037027173756mr396843pge.604.1645057725956;
        Wed, 16 Feb 2022 16:28:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mj21sm199355pjb.20.2022.02.16.16.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 16:28:45 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Dike <jdike@addtoit.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] um: Allow builds with Clang
Date:   Wed, 16 Feb 2022 16:28:43 -0800
Message-Id: <20220217002843.2312603-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2149; h=from:subject; bh=vShMU0xnxVexx4MO5nHaUDLC8EDUgfNlHp2nsWHEiy8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiDZa6UafTd6YGrYc+tswDkAPHU5vTnnAfc+6lyNW/ iJEEJS+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYg2WugAKCRCJcvTf3G3AJrobD/ 94N3eFm682VZ5KXRjhfpVMnBOe7gen8xGGN/fUaNo7D5ELCrVTZ2MtlaOxpZg3gFE2QOS9Qi3KfN4T evcT3Sx7e2eCQQVIH989akOsLuFQkuDsJRZoHarM0gDLFJzqJYV5DD2F2x802pGeBcAYXME1KMkgYv cjzKSXixhur7fi/4i8v1+oGXSW39WRHeZMsb2tZhhiZerHcEkgc2Z5CBLFgBWBNwdcq0G2bza84e8J /LETYVec+LxaEtcVGZEquYASEuBwVhfnU1ELznR5msJ1OE3CpBJdUq9rFIhJY+FpU3yW1O2FSELINI zyUhxrRYDxplhqkV/9AZtB/cNiD4KJpd7yHH19JsB+773pA2qjFHej71yPlqO76eLGq85fnpkPVLAs OeUT9i/B0TfTI9W2PdqsUuXV2EeAUt52hIJ7Tc0bFsewLzdpgwT+88sk5Gx8/X3eR07rEpVTGVPx8d VhPQDd+eYjbAkmdCIco+FoxapSJq/+HtPyDFsrqsJvHyzfaiSXCkHc4cNjJAOB0P+T4/RTrk5EgpIC Q1k75VinAtx6s3sX/wE3+X7/bDeN2MSznWVfMYpwbZuJ42y6W+HD7mZPRXCg+pBUBzo6xPucFqLzXN MpOxLvy+jlg8HUr9uGvI0UoDqaix1aidkMMl2KM5AWa+wnAS5UJHGqjM7euQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add x86-64 target for Clang+um and update user-offsets.c to use
Clang-friendly assembler, similar to the fix from commit cf0c3e68aa81
("kbuild: fix asm-offset generation to work with clang").

This lets me run KUnit tests with Clang:

$ ./tools/testing/kunit/kunit.py config --make_options LLVM=1
...
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
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/um/user-offsets.c | 4 ++--
 scripts/Makefile.clang     | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index bae61554abcc..d9071827b515 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -10,10 +10,10 @@
 #include <asm/types.h>
 
 #define DEFINE(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val))
 
 #define DEFINE_LONGS(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val/sizeof(unsigned long)))
 
 void foo(void)
 {
diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 51fc23e2e9e5..857b23de51c6 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
 CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390		:= s390x-linux-gnu
 CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
+CLANG_TARGET_FLAGS_um		:= x86_64-linux-gnu
 CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))
 
 ifeq ($(CROSS_COMPILE),)
-- 
2.30.2

