Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBFEEB64DA
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Jun 2023 20:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjF3UyK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 30 Jun 2023 16:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjF3UyJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 30 Jun 2023 16:54:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502153C1D
        for <linux-hardening@vger.kernel.org>; Fri, 30 Jun 2023 13:54:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565d1b86a64so21592787b3.3
        for <linux-hardening@vger.kernel.org>; Fri, 30 Jun 2023 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688158447; x=1690750447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy7Fn5DLlDdqthMyo7I1xd7MlIY02Kh4pQfI/B0cxdo=;
        b=FvnQlIQ7mYUe01dsW0Xj2KBmxBFwH8Vzk+wi3C8T0j1qVYSosHexnwLmcP8tli2Cnh
         o5ySE81SipJPG9Hrb0Grc8iBjojvv0dr1ETjSdBuML/POMqIq+6sNhJHJUM2y63H2AVH
         fG0uHMC5IFWwno/8vyuJCDqT6wTNfWH/qz+m3dH1Tze9ARgDjbMG9lKW4oPUwhmT6nZ2
         Arjf0CbqjZCN1lZP72cyFdHK/TcUYd3AMzJZuL6nE0NSe/GS7qq8yObT8LI2v0enKubd
         cjeNuBMq0zxWDorYIxRTdKlIYp9/er3mJU/zfIzqFrsu7yPQmJFcoI8ICouq8XC2ExV0
         maQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688158447; x=1690750447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy7Fn5DLlDdqthMyo7I1xd7MlIY02Kh4pQfI/B0cxdo=;
        b=E4QlOliFGOoyZkOCM2n8kM65jjkrWwqshltQwt8C4ngEgRoQPjhtAYePvRaIMA3Cq3
         H6CWZJjqOsXU5a6+f1ff/rBYa3YsoCxEG9zVF9E92MH/gtKLBrJ1KV3OEcCUCioaru4O
         rtMWsw1Pk5HrI9hr63R6V0sd8OvGg5XSTy4zrJPH+FyK67/YiWJWUkbMNGzZtiBWGg7x
         LdJ/nkHXld1CvQ0w5GKu+a/Z8aIhduZMASrp7K6sZQDaNHYakO3l05Ir8JMhwyGjr8u8
         gjZPh87HO2W2rpWEfR2ISHqWKvWa3cxVbBVMeztgOjfl7sgvlWgr2vkH7nNgs6UX1yCa
         CMDQ==
X-Gm-Message-State: ABy/qLbGIV2FAksYcDh/VQ+Euj1LPHrR8R6LKkZ/74gu9vEkyGlavRPf
        j4FNHSPK5P+qWoGm1G1o5oP7xI9aNHPj5kROag==
X-Google-Smtp-Source: APBJJlFnckz+hwDRlXiHLL4xP5pCQih5vkspaQJsrxW2y5s3Z8acuG/CUlTu1id83U8GZyI85yby8KJ+tH5sl88V0g==
X-Received: from yuxiao.svl.corp.google.com ([2620:15c:2a3:200:511c:d1b:e03e:e72])
 (user=yuxiaozhang job=sendgmr) by 2002:a25:ad17:0:b0:bac:fd63:b567 with SMTP
 id y23-20020a25ad17000000b00bacfd63b567mr25043ybi.4.1688158447602; Fri, 30
 Jun 2023 13:54:07 -0700 (PDT)
Date:   Fri, 30 Jun 2023 13:53:58 -0700
In-Reply-To: <202306281053.EC5115465B@keescook>
Mime-Version: 1.0
References: <202306281053.EC5115465B@keescook>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630205358.3601280-1-yuxiaozhang@google.com>
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc limitation
From:   Yuxiao Zhang <yuxiaozhang@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com, Yuxiao Zhang <yuxiaozhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Sorry forgot to add subject header in msg which messed up email client,
resending it again

Added size details to commit message and fixed the format. See the new
patch below.

Thanks,
-Yuxiao


From cd3ec6155a3cf0e198afdf2d040c73ee146b696f Mon Sep 17 00:00:00 2001
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Fri, 30 Jun 2023 10:45:21 -0700
Subject: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation

Current pmsg implementation is using kmalloc for pmsg record buffer,
which has max size limits of 2^(MAX_ORDER + PAGE_SHIFT). Currently even
we allocate enough space with pmsg-size, pmsg will still fail if the
file size is larger than what kmalloc allowed.

Since we don't need physical contiguous memory for pmsg buffer,
we can use kvmalloc to avoid such limitation.

Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
---
 fs/pstore/inode.c    | 2 +-
 fs/pstore/platform.c | 9 +++++----
 fs/pstore/ram.c      | 5 +++--
 fs/pstore/ram_core.c | 3 ++-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index ffbadb8b3032..df7fb2ad4599 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -54,7 +54,7 @@ static void free_pstore_private(struct pstore_private *private)
 	if (!private)
 		return;
 	if (private->record) {
-		kfree(private->record->buf);
+		kvfree(private->record->buf);
 		kfree(private->record->priv);
 		kfree(private->record);
 	}
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index cbc0b468c1ab..f51e9460ac9d 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -32,6 +32,7 @@
 #include <linux/uaccess.h>
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
+#include <linux/mm.h>
 
 #include "internal.h"
 
@@ -549,7 +550,7 @@ static int pstore_write_user_compat(struct pstore_record *record,
 	if (record->buf)
 		return -EINVAL;
 
-	record->buf = memdup_user(buf, record->size);
+	record->buf = vmemdup_user(buf, record->size);
 	if (IS_ERR(record->buf)) {
 		ret = PTR_ERR(record->buf);
 		goto out;
@@ -557,7 +558,7 @@ static int pstore_write_user_compat(struct pstore_record *record,
 
 	ret = record->psi->write(record);
 
-	kfree(record->buf);
+	kvfree(record->buf);
 out:
 	record->buf = NULL;
 
@@ -730,7 +731,7 @@ static void decompress_record(struct pstore_record *record)
 		return;
 
 	/* Swap out compressed contents with decompressed contents. */
-	kfree(record->buf);
+	kvfree(record->buf);
 	record->buf = unzipped;
 	record->size = unzipped_len;
 	record->compressed = false;
@@ -783,7 +784,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 		rc = pstore_mkfile(root, record);
 		if (rc) {
 			/* pstore_mkfile() did not take record, so free it. */
-			kfree(record->buf);
+			kvfree(record->buf);
 			kfree(record->priv);
 			kfree(record);
 			if (rc != -EEXIST || !quiet)
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ade66dbe5f39..296465b14fa9 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/mm.h>
 
 #include "internal.h"
 #include "ram_internal.h"
@@ -268,7 +269,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 	/* ECC correction notice */
 	record->ecc_notice_size = persistent_ram_ecc_string(prz, NULL, 0);
 
-	record->buf = kmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
+	record->buf = kvmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
 	if (record->buf == NULL) {
 		size = -ENOMEM;
 		goto out;
@@ -282,7 +283,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 
 out:
 	if (free_prz) {
-		kfree(prz->old_log);
+		kvfree(prz->old_log);
 		kfree(prz);
 	}
 
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 966191d3a5ba..3453d493ec27 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <asm/page.h>
 
 #include "ram_internal.h"
@@ -385,7 +386,7 @@ void *persistent_ram_old(struct persistent_ram_zone *prz)
 
 void persistent_ram_free_old(struct persistent_ram_zone *prz)
 {
-	kfree(prz->old_log);
+	kvfree(prz->old_log);
 	prz->old_log = NULL;
 	prz->old_log_size = 0;
 }
-- 
2.41.0.255.g8b1d071c50-goog

