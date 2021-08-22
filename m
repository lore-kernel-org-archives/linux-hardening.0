Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32FEC4338F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF9C61051
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhHVH5x (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhHVH5n (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661ADC061796
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:57:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e7so13647024pgk.2
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSMMgZw7/2olmGwk+x9hLUDcbTdJzqluz+oi39a5oaM=;
        b=IBY/Ab1jTqOxNATsWUpsmSxONXTQq2Ys6gb1+Vyxa8Lpbog138B9bqIQgjgqYQbCAy
         Au0vGoYwvkwjmd/JfcVLueZEasVH4PU5lYaXM7S83ecygMUinu7K8Zq1MrpNBh3GCN+p
         l3bxNibyZlNWMuffpyWPrCb1ABH1473Nbupzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSMMgZw7/2olmGwk+x9hLUDcbTdJzqluz+oi39a5oaM=;
        b=YKLsZoz90NzhitBwf//7sQKd3B0lqAdtIxbaahSGV6mxPy6/fcx+N92xu0e35h0fTW
         9qyHwG31Js7U7gievslkwf4N52LNdIQqegE5cUx7bNMYbv69GCyJXbdF5R1xCUSls2ng
         Jq8M+lKPm10XoaEmQT/WhrO60LSIdozAVA4OwjSp+M/V7h9gSc6ZLV6XZuvfHc4uZ7nf
         rMji7pqnuWDd0UMGF156MDKfWshM3W2xrotrgCLRf5SngiEK3Y22+2+hNpdUnr+2xMrN
         1DFNnscbURXSSRc6kOdi//mjpRukeRzYaFR7F60JlDae9fKVZ5z/e1ltLpD+kiimHY4A
         /wzQ==
X-Gm-Message-State: AOAM530O23ZI9W3h2ziXkXZ3BHib8Q5QjEVvUAlabhBan+HJPd8ieMlM
        +6SOpHXsSCwiXJI7W1oPizk0Ow==
X-Google-Smtp-Source: ABdhPJyXbJowrE/7sid2FKC9cN6WVRYZytt653/I23EunqSwlP9yMw5BQyJG2TAm9RFSJrZx51VZrw==
X-Received: by 2002:a05:6a00:213c:b0:3e1:c3af:134 with SMTP id n28-20020a056a00213c00b003e1c3af0134mr28070949pfj.5.1629619020040;
        Sun, 22 Aug 2021 00:57:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s2sm12005635pfw.193.2021.08.22.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 18/25] fortify: Prepare to improve strnlen() and strlen() warnings
Date:   Sun, 22 Aug 2021 00:51:15 -0700
Message-Id: <20210822075122.864511-19-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; h=from:subject; bh=wvK3U1xEzLn7HBnl3TVbXk2P5Mye7QhLMp4JdS3JmN8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH4jtivRrqM/8t8pX2BgfBDvrRaH9kWYRdFJy03 ZmaWqcKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB+AAKCRCJcvTf3G3AJl6KD/ 9ZeXY58Pb6asLkXbDN3ArZieQhAzcaOUkAzqG+27e2UGmpU0fknMzrGcr5+bkH2vEtiT4wNbDYkQq4 pZ6OZKutd6P6bu3+l+mKEmtVzf6KkiOK6TyJu8byh1zcL79cPXCfg8pQlRxXiNw9RFS166rGMNLxYZ nIEGonm/floTW9BuU4HFNu/TrNFbG3SJgO0nucUsT4WiBiLchgd5aWvp5Gwrv4sn923STbNDhw75NS 43aU65qAxXTi7xVG/NA05RHFoPMpNcl8avEQOoC0yj4euWk9XBOOG8cUT1FrJMNzbSWDjOAx3/bM4v 0clrSucVbpwU/vo+jp9jqrVBhOTsTMe+8wfTYd++e+iKkMkWcWnv//tV/sjsZDhzvXa6H0+INFk1XL lpxEWUOQpYeNp2yhvPBG2mkdvFZiDBLLhr+L3bawbfVA3Bz5X2Qo7e4vQrSlPv0cegUmMFAVIUJWL/ /LioZcopshY+OJkRivbWBSt0y2S43LUmbf+LS8vD8ednSpZl/Dd8ZuWHxgO3SJc/2ByaujeQIdUPI/ BhgTHT8Enu0y2D/+PDRvmDd3WdSYPYc9dmbrkn7GDGz4NFQ/2ZFnWHLUARALIAj8mKIoM4tyL/IlMb Wssv9xgg1JIxTzM7sy2rjvrfS8sqTwDadM85qSaEWTOpykmLWQrNYVa+tR7Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to have strlen() use fortified strnlen() internally, swap their
positions in the source. Doing this as part of later changes makes
review difficult, so reoroder it here; no code changes.

Cc: Francis Laniel <laniel_francis@privacyrequired.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 68bc5978d916..a3cb1d9aacce 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -56,6 +56,17 @@ __FORTIFY_INLINE char *strcat(char *p, const char *q)
 	return p;
 }
 
+extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
+__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
+{
+	size_t p_size = __builtin_object_size(p, 1);
+	__kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
+
+	if (p_size <= ret && maxlen != ret)
+		fortify_panic(__func__);
+	return ret;
+}
+
 __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 {
 	__kernel_size_t ret;
@@ -71,17 +82,6 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 	return ret;
 }
 
-extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
-__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
-{
-	size_t p_size = __builtin_object_size(p, 1);
-	__kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
-
-	if (p_size <= ret && maxlen != ret)
-		fortify_panic(__func__);
-	return ret;
-}
-
 /* defined after fortified strlen to reuse it */
 extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
 __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
-- 
2.30.2

