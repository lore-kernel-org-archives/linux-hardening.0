Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0323CC83F18
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 18:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbjH3S4s (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244706AbjH3NrN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE58F122
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTYt2BSQEZut8ffX05oFQAoT2Tz1O17bKncsR4XeBIs=;
        b=BfS0DuiV8z5gwUJjXvvmr7wSZZ9lI5xfyijCCeVaHwT+acQmf8bwBfG9bAhOqBmHhNvNUH
        zxe9/WIYiPwxfHU4dRBWVoYjzUwPm7jOyFmmv5Mx1QLmVT+HyMF15wtsIIX22YGO9zGha/
        nx6eNSaUHnAfAWJC/f5HSFP81lmKtI4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-jIp2iOZNPxeYqlI-J4ae9A-1; Wed, 30 Aug 2023 09:46:28 -0400
X-MC-Unique: jIp2iOZNPxeYqlI-J4ae9A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a5c5f0364dso53521866b.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403185; x=1694007985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTYt2BSQEZut8ffX05oFQAoT2Tz1O17bKncsR4XeBIs=;
        b=f0+GbeV6fAnLc/pA2H76t9L+ml0PNPOcndRoO7HBP1wMrfvmzxOBDAURuiHq1GhsID
         batbsB2XvisTcMpph6+ZmaxE4dH3QblfOvl6kdGyWDTOfnYja6K1/dbPpAcTUvgmDrCb
         yoEuiqduoXgQIJzCZPmHwSk/RHPaDLOyzsj99E4dXCpxtCQVJL8HBsfZgN3G4gEM2epz
         zmknN5ETxxlD8ewrvlHsJWwGRi3i/Y+qLuscVVOZY3751hrTiIaTs+QtTWLY+MB85Qto
         hntRu0lEZ98UUZIrkXsUTd6GEOJYS2C4wJNYHj2uGEi+leocE5320PLGzQ3f8lDJ45Bd
         I6eA==
X-Gm-Message-State: AOJu0Yxtd0tNLOa+tU/lURKcLEvqsPW0pYFO9nJNig20RmsmCx8L36T+
        wnJSZFRtUtDDwhzaX0Kyf8vvdloZl88nf2bsU3155P/2IyUMtTnEb8Scm0Y54Z8gMZdDTnIvOaF
        mnbrX8RZQMewogvPQAnyxpClrMM3g
X-Received: by 2002:a17:906:74cb:b0:9a1:eb67:c0d3 with SMTP id z11-20020a17090674cb00b009a1eb67c0d3mr1497343ejl.4.1693403185526;
        Wed, 30 Aug 2023 06:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs3XWD3GCd0nxchFLVqW0usUrIz+VOttxkboYOB/XHHWAwTxGY9Rlu6B7+6AhH9DbE4wdw7w==
X-Received: by 2002:a17:906:74cb:b0:9a1:eb67:c0d3 with SMTP id z11-20020a17090674cb00b009a1eb67c0d3mr1497324ejl.4.1693403185198;
        Wed, 30 Aug 2023 06:46:25 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709063e5a00b009829dc0f2a0sm7174419eji.111.2023.08.30.06.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:24 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>
Subject: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
Date:   Wed, 30 Aug 2023 15:45:52 +0200
Message-ID: <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Currently, user array duplications are sometimes done without an
overflow check. Sometimes the checks are done manually; sometimes the
array size is calculated with array_size() and sometimes by calculating
n * size directly in code.

Introduce wrappers for arrays for memdup_user() and vmemdup_user() to
provide a standardized and safe way for duplicating user arrays.

This is both for new code as well as replacing usage of (v)memdup_user()
in existing code that uses, e.g., n * size to calculate array sizes.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 include/linux/string.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..0e8e7a40bae7 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
+#include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -14,6 +16,46 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ *
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure.  Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
+		return ERR_PTR(-EINVAL);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ *
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure.  Result may be not
+ * physically contiguous.  Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
+		return ERR_PTR(-EINVAL);
+
+	return vmemdup_user(src, nbytes);
+}
+
 /*
  * Include machine specific inline routines
  */
-- 
2.41.0

