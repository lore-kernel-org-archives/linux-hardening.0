Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB124C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 22:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbhLMWdl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbhLMWdk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:40 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73882C061756
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 14:33:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b13so12222356plg.2
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 14:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XePop71BAe68mw50RwS+N6TSHJsYbygZ4JZ1GxvcihU=;
        b=dScK2HMeuPUGKcjaC1DKQzJcpkOZj35YD+Mh6NQoy4B9ST7blxSpJ6NvgyEgIAFOzu
         rYlxvTFRD9YS92x2/j3JMPs///couZD5oAHVnctJvoEoMo3TXLSE6rtdDCdXLna0yr6v
         gH1hvDRa2/EosZvjArpWGHkFrSd9OvpOIO7Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XePop71BAe68mw50RwS+N6TSHJsYbygZ4JZ1GxvcihU=;
        b=ed4wPP8XzQNX5kxge9h4wx5fA29cDZKsl82WwXRE6RK+wxkZrL17hdJ/zlKT0H/7OB
         pc4YwYSqkr8DnLvOJ2oBSHL+cn6K6dcaQqYyH/GOvp+chPqDRiCNM7j/GJgGcdIIm61P
         dHtjXTFrQ9LweCCbb6VhXaBiStC0I0DLaa3mwv/uFNXYJAPECY3RsI4a9Si3/AmMmIbK
         uzyXMvoZ8CEhOcystoge1zxphky0NGlGG1GVm9coEt4IQIJZ7oIG1Q3ZJ7vy2e8CmAk+
         gvd2hl+4qJPwfo0ssSUccOEVDqjWun+XR9DHIfEstssGNYR6PMt/YEC8O0bFkGzEfs0g
         TKMQ==
X-Gm-Message-State: AOAM530Bv1raU3b9qMFjnydxu07cwegM+iBJywm/+GulWTyJ5e3wgl/p
        k7YXL2/S5mOczqlKIZaZO5TZxjm0liewvw==
X-Google-Smtp-Source: ABdhPJxl9GAQQlALJjrqIQ2B0q6YXKTnZ0OV/Ee29gsgRwDEvjbHkuGLjcqNrNC5cxQt+eL87ewVoA==
X-Received: by 2002:a17:90a:df96:: with SMTP id p22mr1237496pjv.129.1639434818946;
        Mon, 13 Dec 2021 14:33:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u17sm11967327pfk.179.2021.12.13.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:37 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] fortify: Detect struct member overflows in memmove() at compile-time
Date:   Mon, 13 Dec 2021 14:33:21 -0800
Message-Id: <20211213223331.135412-8-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3921; h=from:subject; bh=NHgKQ5zNG6IM/0vHoqNXCgmZkQClPEP+xhPUVBbQFRw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o4bumukIHwp8QcWHEiGg9puPl0+xIA9Rkye74Z Nt0WOfCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKOAAKCRCJcvTf3G3AJpvEEA CFBRB1E1dILWQu8Dj2b44G7xaYXtSY6P712CwCYX6RbALNSjK6VFp7uvft+AK36zdHrYBX0v6L/jqC qY6Ol+54FildRWZCtpjdzEK1MWMtfS044s/ew4iag8BP6oEGjCBIgGnD8iUz3Kg0lGcipA4Qtecypi nE7p7FxQhYgDEhzTn7UChhMpWTiFkm2pRRkDWwSAPKBdQaxEsQnpJqPYIWJnpskJFZEz7mHfMpftVK UJq1O3D/lSmuZYbXPbkbcO21PXA3Klv4qOCvWXfiRscJWdanKMMoWIxOCG5wO6us9TdKR8CxefTX6r ph/DtkKyo6FrHJJ7PWv96mycudBOmVoBMIeDLLRkX8EALu47Vrt3OXIr9dDBtt75BTP0C4SwnfXnaw UILF/b3RK4taKXlogdJIJpHCqm70m/uj760oI4b8Xr9Q2XmZwoTgvg345FiiEoPjbY+Ck4wxlNfpXw Q/DOf2boQWEAux7jHftB0bRqNobfT1Ie1ply4CSu3u5UdEE3mrKIV2CshU3DHiJCR3zxq7GpYtP2aG X3hypGMb4EX6xGCD8zfIN2L2LvDcYhW6tsprD13LRzYn634UCwQGdwkV2aJXEcRUUBTO16udNzr1n0 VoM3KTmbf8SbvkQCf0UPG7x4Q1VVj5pY3RORGa0MQMcl7hhjMF7T+umECLeQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As done for memcpy(), also update memmove() to use the same tightened
compile-time checks under CONFIG_FORTIFY_SOURCE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/misc.c               |  3 ++-
 arch/x86/lib/memcpy_32.c                      |  1 +
 include/linux/fortify-string.h                | 21 ++++---------------
 .../read_overflow2_field-memmove.c            |  5 +++++
 .../write_overflow_field-memmove.c            |  5 +++++
 5 files changed, 17 insertions(+), 18 deletions(-)
 create mode 100644 lib/test_fortify/read_overflow2_field-memmove.c
 create mode 100644 lib/test_fortify/write_overflow_field-memmove.c

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index a4339cb2d247..1cdcaf34ee36 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -37,10 +37,11 @@
  * try to define their own functions if these are not defined as macros.
  */
 #define memzero(s, n)	memset((s), 0, (n))
+#ifndef memmove
 #define memmove		memmove
-
 /* Functions used by the included decompressor code below. */
 void *memmove(void *dest, const void *src, size_t n);
+#endif
 
 /*
  * This is set up by the setup-routine at boot-time
diff --git a/arch/x86/lib/memcpy_32.c b/arch/x86/lib/memcpy_32.c
index e565d1c9019e..f19b7fd07f04 100644
--- a/arch/x86/lib/memcpy_32.c
+++ b/arch/x86/lib/memcpy_32.c
@@ -4,6 +4,7 @@
 
 #undef memcpy
 #undef memset
+#undef memmove
 
 __visible void *memcpy(void *to, const void *from, size_t n)
 {
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 132efa1ff49f..c07871a3fcd0 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -309,22 +309,10 @@ __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
 		__builtin_object_size(p, 0), __builtin_object_size(q, 0), \
 		__builtin_object_size(p, 1), __builtin_object_size(q, 1), \
 		memcpy)
-
-__FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
-{
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
-
-	if (__builtin_constant_p(size)) {
-		if (p_size < size)
-			__write_overflow();
-		if (q_size < size)
-			__read_overflow2();
-	}
-	if (p_size < size || q_size < size)
-		fortify_panic(__func__);
-	return __underlying_memmove(p, q, size);
-}
+#define memmove(p, q, s)  __fortify_memcpy_chk(p, q, s,			\
+		__builtin_object_size(p, 0), __builtin_object_size(q, 0), \
+		__builtin_object_size(p, 1), __builtin_object_size(q, 1), \
+		memmove)
 
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
 __FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
@@ -413,7 +401,6 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 /* Don't use these outside the FORITFY_SOURCE implementation */
 #undef __underlying_memchr
 #undef __underlying_memcmp
-#undef __underlying_memmove
 #undef __underlying_memset
 #undef __underlying_strcat
 #undef __underlying_strcpy
diff --git a/lib/test_fortify/read_overflow2_field-memmove.c b/lib/test_fortify/read_overflow2_field-memmove.c
new file mode 100644
index 000000000000..6cc2724c8f62
--- /dev/null
+++ b/lib/test_fortify/read_overflow2_field-memmove.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define TEST	\
+	memmove(large, instance.buf, sizeof(instance.buf) + 1)
+
+#include "test_fortify.h"
diff --git a/lib/test_fortify/write_overflow_field-memmove.c b/lib/test_fortify/write_overflow_field-memmove.c
new file mode 100644
index 000000000000..377fcf9bb2fd
--- /dev/null
+++ b/lib/test_fortify/write_overflow_field-memmove.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define TEST	\
+	memmove(instance.buf, large, sizeof(instance.buf) + 1)
+
+#include "test_fortify.h"
-- 
2.30.2

