Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4996ACE79CE
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Sep 2023 12:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbjITMhq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Sep 2023 08:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjITMhj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Sep 2023 08:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBEBB4
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695213404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJRnSvDMQADh3Wr31msjxxHMdDRAXuX2nElLtMGFtqc=;
        b=A8rZcPDIyF6ygJJItp+WVhTO/ZMB2pxZ/yxs+xKz8B9wJ5RVBE9m355u8NnbeaP1Z0PGmD
        wAK7qYZr3lTFtvENGtCUTGUlhIbWrgRCOYd90nOBTShPRynfp2C+eG8urYWR7uczSdYw9f
        6SYlwkv+2jIDWSrZ4+nLL8j9aJHFmOQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-BByrgWOONkObIrPs_engow-1; Wed, 20 Sep 2023 08:36:43 -0400
X-MC-Unique: BByrgWOONkObIrPs_engow-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae3a2a03f7so23614766b.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 05:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213402; x=1695818202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJRnSvDMQADh3Wr31msjxxHMdDRAXuX2nElLtMGFtqc=;
        b=WIECIXelqG3K4eB3wxZcLFxD4A/R7fM/5fSDUXBjgu31qs/Fwev09mMe1cEvzhYlDF
         M5LjgcHFpNyCdy9aiid0a2bxXjmwinpGhqFGGglNwb5/c34I3MrxIKoTK+D/8PssbNYM
         rpvHBszmik0KC779VjRmMcicNci9sSJSuN4b/l6k9WAJ9uNJ7YnHSK9O4JYDoo3ZXph7
         Qg6Zq5Yq7ofOqraSKA2K6WaZXxvHACfaKlibHDtA3x2xA7xWXJcJUgzhu2rcin2dIAha
         rVAO7omv4xasjoLP28xmPfYvkeistR9qgy8UCUSLfOUxoe94THR30LESRz+cIS+TKcPg
         GXlQ==
X-Gm-Message-State: AOJu0Yw2JXcW1in0QtR6P8Uh70qOjHuW3TXElC92iD9GG1no0wZd1iDj
        8e29FnTlt/Z6XBbdE3/KCgL1StdVF/pmIWnQrOUr6rrKEpvbXoz3RbwXzhQ55yKsRJyNoIelwdL
        9GquBos0g+K4gQQJM81hDBVfj0mz+
X-Received: by 2002:a17:906:196:b0:9a5:9f3c:961f with SMTP id 22-20020a170906019600b009a59f3c961fmr1815598ejb.3.1695213401732;
        Wed, 20 Sep 2023 05:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERwQ2SjAJQSsC9ZRe6AiF2nzMLomaRThlvgCuHfKcv/TAIMXpcfLWGpl0wj1aEZwFhaqVjcw==
X-Received: by 2002:a17:906:196:b0:9a5:9f3c:961f with SMTP id 22-20020a170906019600b009a59f3c961fmr1815563ejb.3.1695213401348;
        Wed, 20 Sep 2023 05:36:41 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906191200b0098e42bef736sm9348305eje.176.2023.09.20.05.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:37 -0700 (PDT)
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
        David Airlie <airlied@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 1/5] string.h: add array-wrappers for (v)memdup_user()
Date:   Wed, 20 Sep 2023 14:36:09 +0200
Message-ID: <20230920123612.16914-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
---
 include/linux/string.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..debf4ef1098f 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -5,7 +5,9 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -14,6 +16,44 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result may be not
+ * physically contiguous. Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return vmemdup_user(src, nbytes);
+}
+
 /*
  * Include machine specific inline routines
  */
-- 
2.41.0

