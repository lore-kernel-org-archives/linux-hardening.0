Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BC2C63697
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Nov 2020 11:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B38522228
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Nov 2020 11:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="cla1VaLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKRLHz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Nov 2020 06:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgKRLHz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Nov 2020 06:07:55 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582EFC0613D4
        for <linux-hardening@vger.kernel.org>; Wed, 18 Nov 2020 03:07:54 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4Cbg5P1Wm9z8sh9;
        Wed, 18 Nov 2020 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605697673;
        bh=d3Gb/r8juyYmXty1Zs6cAP1wvNQs32vfeMBtqK0HsG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cla1VaLF9A8iQ8uspyGt56+2EzHEPkzE4zr1K1yIKTZvmdonUt7adO43QyOHcgxQP
         gZCAAtJGimTbrpujiIyia+xajD57Uf4NudbV1LFpk1JFmqSMGpOy6OuLBlUDMi5v64
         tjwzx5CKAo0X3tPMmGmOaKFhjcHII7Wf3nonRh30=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4Cbg5N1X4rz8sgF;
        Wed, 18 Nov 2020 11:07:52 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     akpm@linux-foundation.org
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        keescook@chromium.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v5 3/5] string.h: Add FORTIFY coverage for strscpy()
Date:   Wed, 18 Nov 2020 12:07:29 +0100
Message-Id: <20201118110731.15833-4-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201118110731.15833-1-laniel_francis@privacyrequired.com>
References: <20201118110731.15833-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

The fortified version of strscpy ensures the following before vanilla strscpy
is called:
1. There is no read overflow because we either size is smaller than src length
or we shrink size to src length by calling fortified strnlen.
2. There is no write overflow because we either failed during compilation or at
runtime by checking that size is smaller than dest size.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 include/linux/string.h | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 46e91d684c47..1cd63a8a23ab 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -6,6 +6,7 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/errno.h>	/* for E2BIG */
 #include <stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -357,6 +358,53 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 	return ret;
 }
 
+/* defined after fortified strnlen to reuse it */
+extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
+__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
+{
+	size_t len;
+	/* Use string size rather than possible enclosing struct size. */
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
+
+	/* If we cannot get size of p and q default to call strscpy. */
+	if (p_size == (size_t) -1 && q_size == (size_t) -1)
+		return __real_strscpy(p, q, size);
+
+	/*
+	 * If size can be known at compile time and is greater than
+	 * p_size, generate a compile time write overflow error.
+	 */
+	if (__builtin_constant_p(size) && size > p_size)
+		__write_overflow();
+
+	/*
+	 * This call protects from read overflow, because len will default to q
+	 * length if it smaller than size.
+	 */
+	len = strnlen(q, size);
+	/*
+	 * If len equals size, we will copy only size bytes which leads to
+	 * -E2BIG being returned.
+	 * Otherwise we will copy len + 1 because of the final '\O'.
+	 */
+	len = len == size ? size : len + 1;
+
+	/*
+	 * Generate a runtime write overflow error if len is greater than
+	 * p_size.
+	 */
+	if (len > p_size)
+		fortify_panic(__func__);
+
+	/*
+	 * We can now safely call vanilla strscpy because we are protected from:
+	 * 1. Read overflow thanks to call to strnlen().
+	 * 2. Write overflow thanks to above ifs.
+	 */
+	return __real_strscpy(p, q, len);
+}
+
 /* defined after fortified strlen and strnlen to reuse them */
 __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
 {
-- 
2.20.1

