Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB26C43217
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 22:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbhLMWjJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbhLMWjF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 17:39:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFCFC0613FE
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 14:39:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso14588770pjb.0
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 14:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+S/VUT00+x6Z89xGgyuUNI6qyyri/wBiYIReskukCeo=;
        b=be2VJyv0F8VJ9seriq9Of4P5A2gEqfdJF/M7gDlAQQ1JQ2YYzUk0g4ZjmZDQd8idHX
         IYqWo1HYhg4r3AVywsaEsIl2Q5rV+BjwuLmdI5boZfY78g8dkLD61v2yvKkEww/fCG2N
         jKtiSYfllrTTfg7IPXesRe3OIxzAMCBxWoL1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+S/VUT00+x6Z89xGgyuUNI6qyyri/wBiYIReskukCeo=;
        b=0M8lwCQKwvQ1PuUrBORLJztQ4AmHBnGxIbcl9NoEI4pTTexhmZuX4ES1G3h4CtFU33
         9XaXaYoXZfVS/nkQB+nFf6R3+NBk4aILcWld1526nXF8Iq9BbuBDsqc7kf4IGRGgBEWq
         ylFvOFPPsWquWnsq+SYRIouUSTvsJXXq4c2vi59kiPzkj1TccavMPBeRVx8B3K9X2n68
         TU88zoazg7YhiIPludMTREx+qdDiHs+5wFnuVUxnRACmqIQbZOSfbeUB69cTuUz7YEZ+
         GVp9iONAJkC9/aDTWzN+gDJA3zQZOTINjJ+LCN+rw9UKc5G49lqZUGHIbmxAvFej5Ol/
         bZcw==
X-Gm-Message-State: AOAM532QVHIahCQnGqnsNxKlHKSuDcBPtEdnEXOhdDry49SFC4Ni0S+9
        xVhIv5PXDptQadIr8vaaEb0Moiob+zlwvg==
X-Google-Smtp-Source: ABdhPJwdoix/yTBKz/2BgZrs1Q/wm1ReoN398quHYHtKhFBOCSRrSGiQjasuUFPQ1QcgsB8Pg1be1w==
X-Received: by 2002:a17:902:bf4b:b0:143:aa96:f608 with SMTP id u11-20020a170902bf4b00b00143aa96f608mr1038689pls.23.1639435144665;
        Mon, 13 Dec 2021 14:39:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y190sm13118399pfg.153.2021.12.13.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:39:04 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] fortify: Detect struct member overflows in memset() at compile-time
Date:   Mon, 13 Dec 2021 14:33:30 -0800
Message-Id: <20211213223331.135412-17-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3657; h=from:subject; bh=AnF2T8S0riHB2TUA3T95l35firv45Lry8MXqk/mof/8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o6zUesA2HmcbV8VDUR/FHxBGAXdI6UXLyl52LJ /Sp6XLmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKOgAKCRCJcvTf3G3AJn7xD/ 43+ftwFcw6Z3MbxWyqFBUl0QJ+jnhtO9yA4tEmuPsKde7wWuGIQIVcB+LM7tf9AGYTuo4m96woAiR9 o0g2DOOxWlRpUB835qT2vHKJJjvrNo9kiqTnGmNMZWlatctJEMiS7Os1qJgeidn1hyVz/x8ijHKlaa Fxkah8HxUxEFOa7z8iHGXVcIj3cKJZ/9VtreYNta+KGmrH6xf9IBG4YgTFBwNW/TnyXzxJrlCjkM// tbdnCf30Dr6AeKwjfDOWCkAxUsyxQsWhTBWLYG9s7dJSbZMFA7DgfYsjpGihDhcvPyX1YHK4zZ5rRR T11TgtszpQ7CBsBlyQp/6AFdAZ8EJq/h5KzIiTstWWu0LqfcP04tfuDiC85UaeWVeWv+PEz9cWKQt7 hHMii/6aF12qwhIclS6MuJMzLBSAen/k2FO5wqZ+4DRFhEerGl+sV20fdB8eHct1Nc/UK47+TfiFH9 NvnCHU5g9wX/yYe7ZIVrA3w8DNdv81zGT+a4L2/6kmeBjqnnw8wFn9JTgUW/CG4iKl1IBktnsxedTM BaJY1Igxxq0jNmop3X1fPHriG9nh/mLQ2K9B0trUgmsETbrhbvOLwNum4u1RKF5KVZo7OnyRjRIeSP K64ry9GwMC8sxdXQD6M+7L8JQ1iDO9M/ZBhI9DlzJgP0220IuYuDNfnZHiTw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As done for memcpy(), also update memset() to use the same tightened
compile-time bounds checking under CONFIG_FORTIFY_SOURCE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h                | 54 ++++++++++++++++---
 .../write_overflow_field-memset.c             |  5 ++
 2 files changed, 51 insertions(+), 8 deletions(-)
 create mode 100644 lib/test_fortify/write_overflow_field-memset.c

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c07871a3fcd0..c45159dbdaa1 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -200,17 +200,56 @@ __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
 	return p;
 }
 
-__FORTIFY_INLINE void *memset(void *p, int c, __kernel_size_t size)
+__FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
+					 const size_t p_size,
+					 const size_t p_size_field)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	if (__builtin_constant_p(size)) {
+		/*
+		 * Length argument is a constant expression, so we
+		 * can perform compile-time bounds checking where
+		 * buffer sizes are known.
+		 */
 
-	if (__builtin_constant_p(size) && p_size < size)
-		__write_overflow();
-	if (p_size < size)
-		fortify_panic(__func__);
-	return __underlying_memset(p, c, size);
+		/* Error when size is larger than enclosing struct. */
+		if (p_size > p_size_field && p_size < size)
+			__write_overflow();
+
+		/* Warn when write size is larger than dest field. */
+		if (p_size_field < size)
+			__write_overflow_field(p_size_field, size);
+	}
+	/*
+	 * At this point, length argument may not be a constant expression,
+	 * so run-time bounds checking can be done where buffer sizes are
+	 * known. (This is not an "else" because the above checks may only
+	 * be compile-time warnings, and we want to still warn for run-time
+	 * overflows.)
+	 */
+
+	/*
+	 * Always stop accesses beyond the struct that contains the
+	 * field, when the buffer's remaining size is known.
+	 * (The -1 test is to optimize away checks where the buffer
+	 * lengths are unknown.)
+	 */
+	if (p_size != (size_t)(-1) && p_size < size)
+		fortify_panic("memset");
 }
 
+#define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
+	size_t __fortify_size = (size_t)(size);				\
+	fortify_memset_chk(__fortify_size, p_size, p_size_field),	\
+	__underlying_memset(p, c, __fortify_size);			\
+})
+
+/*
+ * __builtin_object_size() must be captured here to avoid evaluating argument
+ * side-effects further into the macro layers.
+ */
+#define memset(p, c, s) __fortify_memset_chk(p, c, s,			\
+		__builtin_object_size(p, 0), __builtin_object_size(p, 1))
+
 /*
  * To make sure the compiler can enforce protection against buffer overflows,
  * memcpy(), memmove(), and memset() must not be used beyond individual
@@ -401,7 +440,6 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 /* Don't use these outside the FORITFY_SOURCE implementation */
 #undef __underlying_memchr
 #undef __underlying_memcmp
-#undef __underlying_memset
 #undef __underlying_strcat
 #undef __underlying_strcpy
 #undef __underlying_strlen
diff --git a/lib/test_fortify/write_overflow_field-memset.c b/lib/test_fortify/write_overflow_field-memset.c
new file mode 100644
index 000000000000..2331da26909e
--- /dev/null
+++ b/lib/test_fortify/write_overflow_field-memset.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define TEST	\
+	memset(instance.buf, 0x42, sizeof(instance.buf) + 1)
+
+#include "test_fortify.h"
-- 
2.30.2

