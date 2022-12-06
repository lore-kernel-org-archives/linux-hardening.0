Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6786C63705
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Dec 2022 15:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiLFPHH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Dec 2022 10:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiLFPGb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:31 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A4729810
        for <linux-hardening@vger.kernel.org>; Tue,  6 Dec 2022 07:02:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y4so14181455plb.2
        for <linux-hardening@vger.kernel.org>; Tue, 06 Dec 2022 07:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWkrRAknVBR+DtqNNWTgcHsNLwaDUPfHC+NIWe1Ak98=;
        b=QV0CaNM9WiSGeS6ovz8FZ+s36DTHQgyDc2qJhuQZWS+8Cc0b75tuIxwziO9cqnBDrS
         d62yHSr7sI+gLZtQ0eFneYw5KkhAi9V7PEQ+/5diopD1jIjEnjX1PYq6f74fwGV39y2J
         UaiWrQA9IDEXUuIndZ63KqFP17HO9XEhXj9/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWkrRAknVBR+DtqNNWTgcHsNLwaDUPfHC+NIWe1Ak98=;
        b=zTRFU89vpVDgvo0FUDMyo4HnKuyQCkgVqHwYJwMlZOUBCez9QdWyOc3OpB7Y3ZanVJ
         izcnSLo5IT9DQZB6sfkGfYb26Ebv3FSPg3+7blOanyXuYPDqmQl3i0rLXkA4uWZvomwY
         4rdftq+S5sFVF+R1BC2Nt7dPLP3bUyUyEY3VvI4nXmloNbN8vwhJH57jfzICsjnzIwXq
         ZKY+LE67UbsN5bow/3xcODIMDPcBi1S0Q2q5bW+3T7cwYLXgedq3iTaeKTa93Ol9EIhB
         iBM8EMNIp6KwAGSRvKx8aWhuBrEczdpkdgjh+VnFUilkyzfer6bSxSSvakZj0q+3xEE8
         4SSA==
X-Gm-Message-State: ANoB5pmb+mQpJgx4grr7uqMO/2HL83rzTYYmmFpILc5oFoF/XsAurShC
        2+EvfUL+iVVOZGXVR2dzWCB/8w==
X-Google-Smtp-Source: AA0mqf4I/7uAWlEBT7poxsnJg1bA/PCu0XuDolnkjy4etwsd45zgKT3IuP9zusEdep5ysxfcdvrvtA==
X-Received: by 2002:a17:90a:8c96:b0:218:7e9d:8d0a with SMTP id b22-20020a17090a8c9600b002187e9d8d0amr88986847pjo.41.1670338968356;
        Tue, 06 Dec 2022 07:02:48 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 62-20020a621441000000b00575bab45644sm3343019pfu.61.2022.12.06.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:02:47 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v4 1/6] mm/memfd: add F_SEAL_EXEC
Date:   Tue,  6 Dec 2022 15:02:28 +0000
Message-Id: <20221206150233.1963717-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221206150233.1963717-1-jeffxu@google.com>
References: <20221206150233.1963717-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Daniel Verkamp <dverkamp@chromium.org>

The new F_SEAL_EXEC flag will prevent modification of the exec bits:
written as traditional octal mask, 0111, or as named flags, S_IXUSR |
S_IXGRP | S_IXOTH. Any chmod(2) or similar call that attempts to modify
any of these bits after the seal is applied will fail with errno EPERM.

This will preserve the execute bits as they are at the time of sealing,
so the memfd will become either permanently executable or permanently
un-executable.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Co-developed-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/uapi/linux/fcntl.h | 1 +
 mm/memfd.c                 | 2 ++
 mm/shmem.c                 | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..e8c07da58c9f 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,7 @@
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
 #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
+#define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 08f5f8304746..4ebeab94aa74 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -147,6 +147,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 }
 
 #define F_ALL_SEALS (F_SEAL_SEAL | \
+		     F_SEAL_EXEC | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
 		     F_SEAL_WRITE | \
@@ -175,6 +176,7 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 	 *   SEAL_SHRINK: Prevent the file from shrinking
 	 *   SEAL_GROW: Prevent the file from growing
 	 *   SEAL_WRITE: Prevent write access to the file
+	 *   SEAL_EXEC: Prevent modification of the exec bits in the file mode
 	 *
 	 * As we don't require any trust relationship between two parties, we
 	 * must prevent seals from being removed. Therefore, sealing a file
diff --git a/mm/shmem.c b/mm/shmem.c
index c1d8b8a1aa3b..e18a9cf9d937 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1085,6 +1085,12 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 	if (error)
 		return error;
 
+	if ((info->seals & F_SEAL_EXEC) && (attr->ia_valid & ATTR_MODE)) {
+		if ((inode->i_mode ^ attr->ia_mode) & 0111) {
+			return -EPERM;
+		}
+	}
+
 	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

