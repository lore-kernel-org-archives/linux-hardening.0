Return-Path: <SRS0=98sU=D4=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83264C55178
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 15:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3FF20BED
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 15:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="kkE6Vw4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444000AbgJUPG1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Oct 2020 11:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443805AbgJUPG1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Oct 2020 11:06:27 -0400
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB2C0613CE
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2020 08:06:27 -0700 (PDT)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CGYjZ2B8Qz12jp;
        Wed, 21 Oct 2020 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603292786;
        bh=gEisyTzwLUV41IxjCWVvB3lfkoTrhPqzQD7vKXGFNgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkE6Vw4d0KU8pysTF378+V9T9a3PXA6PUQh6jN6GlXssvythZI5DPSwwyn3eB2Gnv
         hkj5PNbkY9TEm1q4K/UncQ3uDn6mZFifTEfGuqtRdjV15O4RKwn3ZBUNPigpx5n7aU
         oeOWt1qwwtleW39Qv9FS6L1xU5tnlsUF9KpGykLA=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CGYjZ1D8zz12jm;
        Wed, 21 Oct 2020 15:06:26 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     dja@axtens.net, Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC][PATCH v3 3/5] Fortify string function strscpy.
Date:   Wed, 21 Oct 2020 17:06:06 +0200
Message-Id: <20201021150608.16469-4-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201021150608.16469-1-laniel_francis@privacyrequired.com>
References: <20201021150608.16469-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Fortified strscpy detects write overflows to dest.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 include/linux/string.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 46e91d684c47..add7426ff718 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -6,6 +6,8 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/bug.h>		/* for WARN_ON_ONCE */
+#include <linux/errno.h>	/* for E2BIG */
 #include <stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -357,6 +359,42 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 	return ret;
 }
 
+/* defined after fortified strnlen to reuse it */
+extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
+__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
+{
+	size_t len;
+	/*
+	 * Use 1 as second argument to guess only p size even and not the
+	 * surrounding struct size (in case it is embedded inside a struct).
+	 */
+	size_t p_size = __builtin_object_size(p, 1);
+
+	/*
+	 * If size can be known at compile time and is greater than
+	 * p_size, generate a compile time write overflow error.
+	 */
+	if (__builtin_constant_p(size) && size > p_size)
+		__write_overflow();
+
+	len = strnlen(q, size);
+	/*
+	 * strscpy handles read overflows by stop reading q when '\0' is
+	 * met.
+	 * We stick to this behavior here.
+	 */
+	len = (len >= size) ? size : len;
+
+	/* Otherwise generate a runtime write overflow error. */
+	if (len > p_size)
+		fortify_panic(__func__);
+	/*
+	 * Still use size as third argument to correctly compute max
+	 * inside strscpy.
+	 */
+	return __real_strscpy(p, q, size);
+}
+
 /* defined after fortified strlen and strnlen to reuse them */
 __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
 {
-- 
2.20.1

