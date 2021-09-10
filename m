Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D2AC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3782610F8
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 16:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhIJRAH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhIJRAG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Sep 2021 13:00:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C366C061574
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 09:58:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q22so2427394pfu.0
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lgjTrI56jaZVc9PmPrNwrchm6KD1UtWtzwMoryApp6c=;
        b=S+w27qCBI0cwBV8ztUMjxrjtB+T12mcBxTCw7J1MnwZd3ziYEp9DhONjX38bG7oimM
         i2qzD+47rjcnPXWfogNKXRGLecPeiCMBN7Zwufto7hVR6HSIXkOlx7l58rNteraQzrsy
         iP61Ut6G6AFMUaZcV5CatMscrwonJwXOGbXso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lgjTrI56jaZVc9PmPrNwrchm6KD1UtWtzwMoryApp6c=;
        b=pPRtd80YTwe+5wQUevvxssHihBeZ9jgbOeBVlyL1h9f5gJmT6L3eznGeCseXtt2IV7
         peBS/m7iT3lFRbt0H9FOyd1ftuTGsCOJtKI9EMyk2VDsTHxHLJySw8kG9qY7xy5/dlur
         vUwCBE1dPNVJqE7QS+TIRRr2hhKp/RDIAeHl94MYYGVYtukWZwNBGR/VXY6y/Jnz4+JE
         Wan+YX/u1bGh8k0fvd60BOMQyedoT8Z+0Ngb7f1s8c7GuElo/p2MZ5DEWlonPbyWsHsn
         n9pZTUcJviqC54g9K2JzIXWKHyDBGyBDZP7zBesf8yDDl7FahGUGbZede+KqDTrFjFIV
         hYWA==
X-Gm-Message-State: AOAM532r6KEjqNybWpDOJzI2m+RW3fNVL+nQ4L8mAaqMJt1iYSWeqVsa
        kAM6qWbsj0ptOIdezliOqtqP4g==
X-Google-Smtp-Source: ABdhPJzhtlyjVjLkJXixKT4LrsFFM5cwBRq8atGzNgLw+vilEdNBnO22KtmofOSzV+cJ4djF31z9KQ==
X-Received: by 2002:a62:645:0:b0:3f2:23bd:5fc0 with SMTP id 66-20020a620645000000b003f223bd5fc0mr9050860pfg.35.1631293134730;
        Fri, 10 Sep 2021 09:58:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b20sm5261538pfl.9.2021.09.10.09.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:58:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, llvm@lists.linux.dev,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] Compiler Attributes: Check GCC version for __alloc_size attribute
Date:   Fri, 10 Sep 2021 09:58:51 -0700
Message-Id: <20210910165851.3296624-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4577; h=from:subject; bh=TkTWDqWBP+IRWrSPRHIHEjSjQOLhe9YANommKEXZ5D4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhO47LgOtBj3a60y7yGkYEAMPz6LqNTZymiIzqXFO9 4c12DIqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTuOywAKCRCJcvTf3G3AJkcRD/ 4w+wP1GE9cyPd68oLGvZAGJ2feLfD745f2EGo1ErP0MdwRfUNp4vm0JyXWszE8HU6/IqGfjzdithQY i3srK2DYAcxxKvrKRjdaXdR0vNtrRICPFIqfC/PmmWgD6+DvzC/ic2eqyv/VukUxryIJ5it8Eo7ltE EmaBYvq+joxsR77r+xWyHaD+eLcm3HRMWmo7cosh6A4JaIfxAdJqiQKiGg5hVlUWqw6WkkrFHTJOfJ L7C9xu5fP9u2KMPopJKkS/dU0B6t7aW8RzydclgYp5ArYdzfia/3FVdOf0JsCbFdBMWaY2lYq+VQvu 0JnLIwxDAAuuu0Ua+h01U8vFp1k6eeSCMBsmrbi/YJZo8Ll35Hc0UIdj5QUqJlrg2VbS7FH8KIxYOL 4PFPJp7qBVdtH0ZtaC/jZVmZRzdy8HoQ2XuY/2dRXPEupkyFNTVKQzsyyngBCjHE7Py4dy8JqnHZUM e5MYQ5z1oteD/nBwghZdxa4BZP9RCJEvMhaA8d4tvDaGT7aOzYq1BPCeZSmikgfRBaKqj5NJ9c551P KJUmvGfbHso3Ts1ytGh1jU/YloZI09vydfVyEP/BZ7tXosFmOE4j7a1RRXA5WZnj4iZQOgLQXW6r19 Ut+X1CjtsrXsJzjouJHylTT5qLEGQ1Rh3ut5O+CTYrPEczWS/wQ9zR/RGqYw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Unfortunately, just version checking the use of -Wno-alloc-size-larger-than
is not sufficient to make the __alloc_size attribute behave correctly
under older GCC versions. The attribute itself must be disabled in those
situations too, as there appears to be no way to reliably silence the
SIZE_MAX constant expression cases for GCC versions less than 9.1:

In file included from ./include/linux/resource_ext.h:11,
                 from ./include/linux/pci.h:40,
                 from drivers/net/ethernet/intel/ixgbe/ixgbe.h:9,
                 from drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c:4:
In function 'kmalloc_node',
    inlined from 'ixgbe_alloc_q_vector' at ./include/linux/slab.h:743:9:
./include/linux/slab.h:618:9: error: argument 1 value '18446744073709551615' exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
  return __kmalloc_node(size, flags, node);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/slab.h: In function 'ixgbe_alloc_q_vector':
./include/linux/slab.h:455:7: note: in a call to allocation function '__kmalloc_node' declared here
 void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_slab_alignment __malloc;
       ^~~~~~~~~~~~~~

Specifically:
-Wno-alloc-size-larger-than is not correctly handled by GCC < 9.1
  https://godbolt.org/z/hqsfG7q84 (doesn't disable)
  https://godbolt.org/z/P9jdrPTYh (doesn't admit to not knowing about option)
  https://godbolt.org/z/465TPMWKb (only warns when other warnings appear)

-Walloc-size-larger-than=18446744073709551615 is not handled by GCC < 8
  https://godbolt.org/z/73hh1EPxz (ignores numeric value)

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I've been digging through older GCC build logs and found this needed to
be fixed even harder than prior attempts from what Randy had been seeing.
---
 include/linux/compiler-gcc.h        | 9 +++++++++
 include/linux/compiler_attributes.h | 6 ------
 include/linux/compiler_types.h      | 5 +++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 01985821944b..ffe0a7570d66 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -151,3 +151,12 @@
 #else
 #define __diag_GCC_8(s)
 #endif
+
+/*
+ * https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
+ * However, prior to 9.1, -Wno-alloc-size-larger-than does not work,
+ * making this attribute unusable.
+ */
+#if GCC_VERSION < 90100
+#define __alloc_size		/**/
+#endif
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 19f178e20e61..2487be0e7199 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -53,12 +53,6 @@
 #define __aligned(x)                    __attribute__((__aligned__(x)))
 #define __aligned_largest               __attribute__((__aligned__))
 
-/*
- *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
- * clang: https://clang.llvm.org/docs/AttributeReference.html#alloc-size
- */
-#define __alloc_size(x, ...)		__attribute__((__alloc_size__(x, ## __VA_ARGS__)))
-
 /*
  * Note: users of __always_inline currently do not write "inline" themselves,
  * which seems to be required by gcc to apply the attribute according
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c43308b0a9a9..91de9bead40d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -254,6 +254,11 @@ struct ftrace_likely_data {
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
 
+/* If not specifically disabled, allow the use of __alloc_size attribute. */
+#ifndef __alloc_size
+# define __alloc_size(x, ...)		__attribute__((__alloc_size__(x, ## __VA_ARGS__)))
+#endif
+
 #ifdef CONFIG_CC_HAS_ASM_INLINE
 #define asm_inline asm __inline
 #else
-- 
2.30.2

