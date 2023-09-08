Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56719EEB566
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Sep 2023 20:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbjIHUD5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjIHUD4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Sep 2023 16:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021CE46
        for <linux-hardening@vger.kernel.org>; Fri,  8 Sep 2023 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4V6bm459ozDimu1heDZpH+ZMi6MrCIxlIoO52rIEKGg=;
        b=BQBkhuZ9PfiOe6bAp4ii50nJSvvprmCN0nxVwUHdHNj8vDjT1em2vA1MhJOwsedmCLrqtB
        hc7g5BoP2Ko9ERPWVqUT4NTzBU7oVdmr+/ZG2Qmu8reKmvuv1BfEc2vwoKKFHrtw1KLPsJ
        jeqaPkz2cxswM2VrR7b1AtrWytEL9yk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-0PLk8I5bP2yYb5D3ZNf4aQ-1; Fri, 08 Sep 2023 16:02:52 -0400
X-MC-Unique: 0PLk8I5bP2yYb5D3ZNf4aQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4121a931b1fso3336101cf.1
        for <linux-hardening@vger.kernel.org>; Fri, 08 Sep 2023 13:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203372; x=1694808172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V6bm459ozDimu1heDZpH+ZMi6MrCIxlIoO52rIEKGg=;
        b=XzgRAmtvt7ms5SPpYIegrs5q3yDGMPTOKD5UN2uq3maoEss8lib6IDNWQvJRjh8y1R
         u/maDfHCBT/G9+9fqTrS/CYQKNiV84fB30LgS9erujDmohgPIWa9SsotVsdCw5zI1BOH
         D1MLIUtxdt1K6tPumYR0PBVJVg178F4BlA7N9yUqV+hEixfew/Z/TaKr2JMuilDzGAYf
         W1gbRVZxPgzDqWrKPQEoBYLYqk8gfV891tyZnaOmTrSKuUWC6J6zWz7RIFjWeczx61ju
         N9g7wznonXFTqNfWeYfdt8UTGP7ZPgWQtnzZ4Vk/5xwbugYV/LOP+2F/41Zll4kLtdOe
         QQhQ==
X-Gm-Message-State: AOJu0YxdXPyk7fHfE6y1vaV/bYQLkuZIF8LZDvwva1i6TNuLnmWdP0dP
        stocJ3KgVr7FnAKvoDb2j0T+60acxAiXH9wvS5kLyBI04JW+fierQHDKU1NfQB/MwxaPuRrTwp4
        k0hLEaKWOmmAQV8zoifYQ2+qAbcUr
X-Received: by 2002:a05:622a:1997:b0:40f:da40:88a with SMTP id u23-20020a05622a199700b0040fda40088amr3927393qtc.4.1694203372365;
        Fri, 08 Sep 2023 13:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUR/6fW5sKr+U41wFGsfMKmuUv8vxb4fBBYTs7l3DnJhhPgBBiRmpLahG272yCMwIEUruJgg==
X-Received: by 2002:a05:622a:1997:b0:40f:da40:88a with SMTP id u23-20020a05622a199700b0040fda40088amr3927365qtc.4.1694203372058;
        Fri, 08 Sep 2023 13:02:52 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id x19-20020ac85393000000b0041511b21a7csm262984qtp.40.2023.09.08.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:02:51 -0700 (PDT)
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
Subject: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
Date:   Fri,  8 Sep 2023 21:59:40 +0200
Message-ID: <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
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
 include/linux/string.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..8c9fc76c7154 100644
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
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
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
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
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

