Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA3CEB64D9
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jun 2023 20:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjF0UZ7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Jun 2023 16:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjF0UZ5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Jun 2023 16:25:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5061BD1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jun 2023 13:25:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c361777c7f7so27124276.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jun 2023 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687897555; x=1690489555;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OrGhpjSBH+uvN2RlFVrnMyWFjf7MZCvpoWYUAG+UcGg=;
        b=J1Ay4xaAwE50titRnLAf8EZ4tOlp28f3hhclzOHSVchSUxINJwhyXY9wEHPBbWfTge
         jR+g6Qg7w9D7qLD7y8MPyelzGYCKfMt40xm05TJk8JQzDZ2Xv0FIDFrt2MjLrE7EqPuR
         +FhFBpbySZ4yVC722kZ+WSAf44aMVbcssT1g9QIOqa1me2sIWUujzxgSR4AmrFtTObz6
         Nt50EtsaW67uPWXg8PwR3SWnu+MuBJwsepJWfrwtDsUVeqqnYqx3jWepoAWjotKXDVyn
         gkqH3ypgLtrjW9EZmi1a24+cbBfm9HqDaddwo2Q2fhlXEhzIELgqVmz9o0rwAVUyCkoW
         JuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687897555; x=1690489555;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrGhpjSBH+uvN2RlFVrnMyWFjf7MZCvpoWYUAG+UcGg=;
        b=NsGVTIzR7csW+7iO5QBtVG9HkGg6QUwPp9NOMgi79WabbFoiDIT/RMqgQ03bkLK0ry
         egHll7qnMjJfARSnmf+8sCqRYPmtCVSzO8fGdoXMQ6DZ6mFnM+S1HTHX7b0t3WWO9Uco
         Nq2OnwwgQOmi98uMRlg25i/MB+u04vZcdiWHoR5v1IH1svWbguKjuObZA1IMZQiaBNYE
         wZSAP/iDUH4SO6ySDQGiooCkKioCCOGYdf5Z0fDaec2w1cYVL17JxwcJ4QabcIkQSEXE
         2CQNzXIjPgB/0e3IRIQDNnNSLVMkdhFF/v7Tunhkc560aPogH1olSkjIhSnl3wW/EZM3
         MnAQ==
X-Gm-Message-State: AC+VfDy5ecuQlWeR6JGyLrctEnJ8cLh4Q9F1x6ZU9EGafsiWQOyWOizp
        3HdeVFjg39JkB138O52fue5yptqbV+DPlCY1lQ==
X-Google-Smtp-Source: ACHHUZ7pwzISo3tUi89gxWua4UMbJKl2ONFmvL3K96MUD3/tkU2czKYAmuuzG/84BwbTNX2A7s33obaNpq3hC+l0CQ==
X-Received: from yuxiao.svl.corp.google.com ([2620:15c:2a3:200:372c:3efd:f120:f25d])
 (user=yuxiaozhang job=sendgmr) by 2002:a25:d205:0:b0:ba8:381b:f764 with SMTP
 id j5-20020a25d205000000b00ba8381bf764mr12393540ybg.3.1687897555050; Tue, 27
 Jun 2023 13:25:55 -0700 (PDT)
Date:   Tue, 27 Jun 2023 13:25:41 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627202540.881909-2-yuxiaozhang@google.com>
Subject: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc limitation
From:   Yuxiao Zhang <yuxiaozhang@google.com>
To:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, wak@google.com,
        Yuxiao Zhang <yuxiaozhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Current pmsg implementation is using kmalloc for pmsg record buffer,
which has max size limits based on page size. Currently even we
allocate enough space with pmsg-size, pmsg will still fail if the
file size is larger than what kmalloc allowed.

Since we don't need physical contiguous memory for pmsg buffer
, we can use kvmalloc to avoid such limitation.

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
2.41.0.162.gfafddb0af9-goog
