Return-Path: <SRS0=JAUN=DU=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DF3C433E7
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Oct 2020 17:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5073425323
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Oct 2020 17:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="ViekDnis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgJMRMF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Oct 2020 13:12:05 -0400
Received: from devianza.investici.org ([198.167.222.108]:52655 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbgJMRMF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Oct 2020 13:12:05 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 13:12:04 EDT
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4C9hln6ZZvz6vHc;
        Tue, 13 Oct 2020 17:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1602608789;
        bh=O0xVLPX5YJu0AWUukKU616B+yzQxzOPQ7s8x+cgsjzU=;
        h=From:To:Cc:Subject:Date:From;
        b=ViekDnisswfkh3ouzpAjUphDs/gYHYZjrdI2v355s9haoNxTuuzAlhrhZRGrUevM1
         C6JUvu9TxkJd5vZPunEnF404Lqvq+GjsLlvEscvwJm6v+5WX7BTvf0tNBUKVnCtBQt
         ZAiNfxCOv58eEFVowgmQ1GdaqHN/jYkZV2Pp9D1M=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4C9hln582Sz6vGx;
        Tue, 13 Oct 2020 17:06:29 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC][PATCH v1] Fortify string function strscpy.
Date:   Tue, 13 Oct 2020 18:59:56 +0200
Message-Id: <20201013165955.7350-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Hi.


First, I do hope you are all fine and the same for your relatives.

This patch is related to this issue:
https://github.com/KSPP/linux/issues/96

In this patch, I fortified strscpy so the function detects write overflows to
dest.
I did not deal with read overflows since strscpy will exit when '\0' is met in
src.

Unfortunately, I did not test this modification at run time because I did not
find enough documentation about LKDTM to make it work.
Also, when I booted the modified kernel inside a VM, I had oom reaper called to
kill systemd related processes when I used len as third argument of
__real_strscpy...
For all these reasons I marked this patch as RFC.


Best regards.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 include/linux/string.h | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index b1f3894a0a3e..b661863619e0 100644
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
 
@@ -357,6 +359,49 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 	return ret;
 }
 
+/* defined after fortified strlen to reuse it */
+extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
+__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t count)
+{
+	size_t len;
+	size_t p_size = __builtin_object_size(p, 0);
+	size_t q_size = __builtin_object_size(q, 0);
+	/*
+	 * If p_size and q_size cannot be known at compile time we just had to
+	 * trust this function caller.
+	 */
+	if (p_size == (size_t)-1 && q_size == (size_t)-1)
+		return __real_strscpy(p, q, count);
+	len = strlen(q);
+	if (count) {
+		/* If count is bigger than INT_MAX, strscpy returns -E2BIG. */
+		if (WARN_ON_ONCE(count > INT_MAX))
+			return -E2BIG;
+		/*
+		 * strscpy handles read overflows by stop reading q when '\0' is
+		 * met.
+		 * We stick to this behavior here.
+		 */
+		len = (len >= count) ? count : len;
+		/*
+		 * If len can be known at compile time and is greater than
+		 * p_size, generate a compile time write overflow error.
+		 */
+		if (__builtin_constant_p(len) && len > p_size)
+			__write_overflow();
+		/* Otherwise generate a runtime write overflow error. */
+		if (len > p_size)
+			fortify_panic(__func__);
+		/*
+		 * Still use count as third argument to correctly compute max
+		 * inside strscpy.
+		 */
+		return __real_strscpy(p, q, count);
+	}
+	/* If count is 0, strscpy return -E2BIG. */
+	return -E2BIG;
+}
+
 /* defined after fortified strlen and strnlen to reuse them */
 __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
 {
-- 
2.20.1

