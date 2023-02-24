Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253FBC64ED8
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Feb 2023 09:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBXJAL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Feb 2023 04:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjBXJAC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Feb 2023 04:00:02 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E52A61EFE
        for <linux-hardening@vger.kernel.org>; Fri, 24 Feb 2023 00:59:59 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id dk16-20020a0564021d9000b004aaa054d189so18645403edb.11
        for <linux-hardening@vger.kernel.org>; Fri, 24 Feb 2023 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=utTJOkvRGl0nLL0ic/scm4HYcaWRO/7AK96vkAXGENA=;
        b=nsiAeT3sqIcbbasW+A96bARZ2VdXg782ZVWDGh5Re7HD9f4mYtT+ysgkT9VaSYSDrH
         Rt4TDQx49hmvv3dcUub42jH8GPt5vPl0M/QeQG2yLn5WWBP/FQw+2Yan4s6yH0Ro/ji+
         qS04eow8+5dPkdqHVrlo7OrazijhFKLKXddf6vGB5bcrovGys+5MHMKJGlr3sX0g+aeK
         HJKPaB6YSIopEMkopNcvfHJzy5rQ3+3mg6ey/bGzmAV3npR1fWi4TbHzdXQXTxHDub6b
         LPjWI4kXgF5wO0d9LH+hU9z9czrjgeeciuNaAms6fH57FV7NV3wEL+gW76aoozJ6QbnN
         vFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utTJOkvRGl0nLL0ic/scm4HYcaWRO/7AK96vkAXGENA=;
        b=Pg8CQozpcRYlWUaRYxOZsNkrnW7OHrpHPVUaUbRRZQO5pAoJDhYAyUIJlps58IypOY
         a4jJK5T/46mWFJatXiJw1Zsom2yyI42FQDwaFIsD0k7OuMvP7avGTrcXbk4zQ4ZhR5pp
         kJeIi3BohHrbhwxJgBK5qBC71P7pprSF82ZRuT/gzRBbF4l3NJwaG8vGg9Zvs5JYdElx
         9rfkTlNATT1YkYFihaS/DkAEUFdzJB3WIdKGwvNR6zHFJeuQYd0ehCgwr9WJ8GyKO/5a
         +jjpb2HGh7QeOUbXLSMSUVUESxys9T3bcUQW/E6dVLllZTpVGPuOhqSiJnCnvwJcsFpO
         JwVA==
X-Gm-Message-State: AO0yUKXpLa9qYxGoMMhuK3nGV1ywqHkGuxtHQZIawFRw/xzUyqqlPTZv
        pEYhrgm2WX12cBOwETm9Qda73dP7DA==
X-Google-Smtp-Source: AK7set9s24s+5VohUfii+zFTuaQPsjyDds6x0J8bwgW3veskTcuKrcCryCoVd2C3OOn3WOO7VsqdRu1bog==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:53eb:6453:f5f5:3bb9])
 (user=elver job=sendgmr) by 2002:a50:d682:0:b0:4af:70a5:55af with SMTP id
 r2-20020a50d682000000b004af70a555afmr2075203edi.1.1677229198008; Fri, 24 Feb
 2023 00:59:58 -0800 (PST)
Date:   Fri, 24 Feb 2023 09:59:39 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224085942.1791837-1-elver@google.com>
Subject: [PATCH v5 1/4] kasan: Emit different calls for instrumentable memintrinsics
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Clang 15 provides an option to prefix memcpy/memset/memmove calls with
__asan_/__hwasan_ in instrumented functions: https://reviews.llvm.org/D122724

GCC will add support in future:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108777

Use it to regain KASAN instrumentation of memcpy/memset/memmove on
architectures that require noinstr to be really free from instrumented
mem*() functions (all GENERIC_ENTRY architectures).

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
v4:
* Also enable it for KASAN_SW_TAGS (__hwasan_mem*).

v3:
* No change.

v2:
* Use asan-kernel-mem-intrinsic-prefix=1, so that once GCC supports the
  param, it also works there (it needs the =1).

The Fixes tag is just there to show the dependency, and that people
shouldn't apply this patch without 69d4c0d32186.
---
 mm/kasan/kasan.h       |  4 ++++
 mm/kasan/shadow.c      | 11 +++++++++++
 scripts/Makefile.kasan |  8 ++++++++
 3 files changed, 23 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 71c15438afcf..172713b87556 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -637,4 +637,8 @@ void __hwasan_storeN_noabort(unsigned long addr, size_t size);
 
 void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size);
 
+void *__hwasan_memset(void *addr, int c, size_t len);
+void *__hwasan_memmove(void *dest, const void *src, size_t len);
+void *__hwasan_memcpy(void *dest, const void *src, size_t len);
+
 #endif /* __MM_KASAN_KASAN_H */
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 98269936a5e4..f8a47cb299cb 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -107,6 +107,17 @@ void *__asan_memcpy(void *dest, const void *src, size_t len)
 }
 EXPORT_SYMBOL(__asan_memcpy);
 
+#ifdef CONFIG_KASAN_SW_TAGS
+void *__hwasan_memset(void *addr, int c, size_t len) __alias(__asan_memset);
+EXPORT_SYMBOL(__hwasan_memset);
+#ifdef __HAVE_ARCH_MEMMOVE
+void *__hwasan_memmove(void *dest, const void *src, size_t len) __alias(__asan_memmove);
+EXPORT_SYMBOL(__hwasan_memmove);
+#endif
+void *__hwasan_memcpy(void *dest, const void *src, size_t len) __alias(__asan_memcpy);
+EXPORT_SYMBOL(__hwasan_memcpy);
+#endif
+
 void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index b9e94c5e7097..fa9f836f8039 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -38,6 +38,11 @@ endif
 
 CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
 
+# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
+# instead. With compilers that don't support this option, compiler-inserted
+# memintrinsics won't be checked by KASAN on GENERIC_ENTRY architectures.
+CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix=1)
+
 endif # CONFIG_KASAN_GENERIC
 
 ifdef CONFIG_KASAN_SW_TAGS
@@ -54,6 +59,9 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
 		$(call cc-param,hwasan-inline-all-checks=0) \
 		$(instrumentation_flags)
 
+# Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
+CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
+
 endif # CONFIG_KASAN_SW_TAGS
 
 export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE
-- 
2.39.2.637.g21b0678d19-goog

