Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDA1C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Feb 2022 22:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiBHWyI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiBHWx4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Feb 2022 17:53:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E143C061578
        for <linux-hardening@vger.kernel.org>; Tue,  8 Feb 2022 14:53:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso429310pjh.5
        for <linux-hardening@vger.kernel.org>; Tue, 08 Feb 2022 14:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UuLl1lhQUOpyY4F3HChSqUr+c0VI6V5HzLLZgZKWEaw=;
        b=ik6XSnGwoTVxVDhYB8ynCOQG4c6bMYjzhqvsiu2jcXe2sP8H/QSj3cEyNxiwz0JqcI
         yhFaUhjIqFt5MOUx2V19RIDMBibxcVbZ6v4Hv6eewU5L6TQXwtUB9sV4WytGY/DN7qwG
         AFOWBrAzmZHKOJFerj+7gNv3n6o15KnEoDTHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UuLl1lhQUOpyY4F3HChSqUr+c0VI6V5HzLLZgZKWEaw=;
        b=TqiOwv3SpK9VHPPE1gBxCS1ifup0M8x7g8JyCprpE9fQssPKoYabnJ3IIgeZIV8vL+
         xIqzwjZkIS8ndZAnXZoviMobLuA9feINAkWGbAbj53vAh1QMDHb9kq4nRHBpaVv+FfsM
         i9dyk30QusHsd238QOfvJSkGv9LbWQGigMcPlpCTkKsLoA79HXtQ5XImKnxxrdB4UMUr
         JokG6inhxpFJgeOQvntV6Sx+i4h8yyn/GH45ehGuStWwoCQ6KWTjI9Bx+Bz40pMyouOK
         jmGvih3ilS+4yf33qhRERBv2KzEETfoLOhl1B2gfLhozgw9e6pMPRTUb48SoX0bldXNu
         Wntw==
X-Gm-Message-State: AOAM5317VpEb9jljNRxj84RAmxSMZhW80+E7v1TNfOSAZ9Cic2l/FXvT
        5fbajcVnIRgxeOu/yucZqbtCzg==
X-Google-Smtp-Source: ABdhPJxFXk/eqGfISYiBlXBCy8lWVfEtqVMkIfl1a7/KbgQHxia/IVUlGc1fcQAipi4dlXl4FbwWrQ==
X-Received: by 2002:a17:90a:8401:: with SMTP id j1mr197099pjn.235.1644360833475;
        Tue, 08 Feb 2022 14:53:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p6sm4103431pfo.73.2022.02.08.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 14:53:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v7 6/8] fortify: Use __diagnose_as() for better diagnostic coverage
Date:   Tue,  8 Feb 2022 14:53:48 -0800
Message-Id: <20220208225350.1331628-7-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208225350.1331628-1-keescook@chromium.org>
References: <20220208225350.1331628-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3932; h=from:subject; bh=PmLo1tH3dH3S3QkOsOrJ2Edy3uWnbVOSIVtbl+9ShXk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAvR9iyMHXECK2JnvWQS1iN7Uf9vsEXNUF5vYwO7A cAhxA5aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgL0fQAKCRCJcvTf3G3AJqVYEA CyQ0/tVUuN3tDpvncf1tTIZjtUYX4pf2TahFr8HOnEfQGNMWu5BS9wLCOh3WOdeUYjYVs5VZBA5MIt UaLeH1UXkGbkq9oMh5ufGedggXk5mtvcRDJvD+hhH5Y57jEx+tDCYo+0sVJKJpidE3tgNdwVVxEES4 p5XxCjCT2vuOGMp6SFnxybOIiNno96PSn+pBtz685ioHZj1J5oKXtauJFYIxyB87Jhjwp3nMCqySDx moipYuvoJZzyB31hOAPgVSjNWOTgzuCWt1WsvZ15rkNMCcZ7QFBXVxMI/EG+diCYlkpvB4Z2K4+T5h 1hA5hN5yeMZtbr0MoeMaQA27W3EUviSkedxaq3RbKYMIASvn7/wUXn9RMCrQtT0IjyUe/30NPw04nl fV8bU0Yc/IDWLfpfSbtyan1Fg+1f2kGuCkVjemGnCi/cgzfdNoyW3GHbX9RvJmcdLfoCVazMN/i2il gw3969Ms5R/ZIqU8sLVb3YH0bGXdlGgmjv7M7bO67cTapCN6ryUGo8LBFSsIB2a/UWP/OVrRvCPixO vr4QsI3xmQwk6grd01qg0tRBUg2SAiq+tmIxvA+ymbeZOCfiGw9MWEkqHLqW04mSX13DLx0nEPTsBG nNspaED0AyhKfnYHUED2f9lu59lSApQ2HkqDudabNbLoY6g9YoD3RrnDv9Iw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for using Clang's __pass_object_size, add __diagnose_as()
attributes to mark the functions as being the same as the indicated
builtins. When __daignose_as() is available, Clang will have a more
complete ability to apply its own diagnostic analysis to callers of these
functions, as if they were the builtins themselves. Without __diagnose_as,
Clang's compile time diagnostic messages won't be as precise as they
could be, but at least users of older toolchains will still benefit from
having fortified routines.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index f874ada4b9af..db1ad1c1c79a 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -50,7 +50,8 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define __underlying_strncpy	__builtin_strncpy
 #endif
 
-__FORTIFY_INLINE char *strncpy(char * const p, const char *q, __kernel_size_t size)
+__FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
+char *strncpy(char * const p, const char *q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
@@ -61,7 +62,8 @@ __FORTIFY_INLINE char *strncpy(char * const p, const char *q, __kernel_size_t si
 	return __underlying_strncpy(p, q, size);
 }
 
-__FORTIFY_INLINE char *strcat(char * const p, const char *q)
+__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
+char *strcat(char * const p, const char *q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
@@ -94,7 +96,8 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t m
 }
 
 /* defined after fortified strnlen to reuse it. */
-__FORTIFY_INLINE __kernel_size_t strlen(const char * const p)
+__FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
+__kernel_size_t strlen(const char * const p)
 {
 	__kernel_size_t ret;
 	size_t p_size = __builtin_object_size(p, 1);
@@ -183,7 +186,8 @@ __FORTIFY_INLINE ssize_t strscpy(char * const p, const char * const q, size_t si
 }
 
 /* defined after fortified strlen and strnlen to reuse them */
-__FORTIFY_INLINE char *strncat(char * const p, const char * const q, __kernel_size_t count)
+__FORTIFY_INLINE __diagnose_as(__builtin_strncat, 1, 2, 3)
+char *strncat(char * const p, const char * const q, __kernel_size_t count)
 {
 	size_t p_len, copy_len;
 	size_t p_size = __builtin_object_size(p, 1);
@@ -365,7 +369,8 @@ __FORTIFY_INLINE void *memscan(void * const p, int c, __kernel_size_t size)
 	return __real_memscan(p, c, size);
 }
 
-__FORTIFY_INLINE int memcmp(const void * const p, const void * const q, __kernel_size_t size)
+__FORTIFY_INLINE __diagnose_as(__builtin_memcmp, 1, 2, 3)
+int memcmp(const void * const p, const void * const q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 	size_t q_size = __builtin_object_size(q, 0);
@@ -381,7 +386,8 @@ __FORTIFY_INLINE int memcmp(const void * const p, const void * const q, __kernel
 	return __underlying_memcmp(p, q, size);
 }
 
-__FORTIFY_INLINE void *memchr(const void * const p, int c, __kernel_size_t size)
+__FORTIFY_INLINE __diagnose_as(__builtin_memchr, 1, 2, 3)
+void *memchr(const void * const p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -417,7 +423,8 @@ __FORTIFY_INLINE void *kmemdup(const void * const p, size_t size, gfp_t gfp)
 }
 
 /* Defined after fortified strlen to reuse it. */
-__FORTIFY_INLINE char *strcpy(char * const p, const char * const q)
+__FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
+char *strcpy(char * const p, const char * const q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
-- 
2.30.2

