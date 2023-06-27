Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDC1EB64D9
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jun 2023 01:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjF0BUq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Jun 2023 21:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjF0BUo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Jun 2023 21:20:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135D0173E
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jun 2023 18:20:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fa7b26b442so57675e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jun 2023 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687828840; x=1690420840;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MwvCpFW/GbNtPlS+NY4oiqTY4IcMkcTsbkaeYou0CDY=;
        b=MrXhAAJE9l6zSW90GA8n65w4+eCK49qK/xWh8182A8ET/4h+ybVFaIi0tNHp5ac5Bo
         rSqwJWk9svsna+Mu53daPYTGiqe5GaNwXjVx9VAHJrGU4cJp9aHc6voM4wN0s5KO3K/y
         +O/kPFMf+XtRWmXwYPmeIZZ9a/iT9pfCfMFmllEJbgdnlm83bCiBqBl53Y68hN5RfxrM
         9W8t86scw7RxHinoj/GwRSRaUlFZu8cWPJsBazjhm0IJUgY3S2JGoVFeg9iUh08ZYBsH
         MrXf8fbQAP4jm8jnmhmKSKxtAXDdwE2qdS21V2aGV4Xqc14Vm/OnkU5s0Ss/9sij+5Mi
         ptYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687828840; x=1690420840;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwvCpFW/GbNtPlS+NY4oiqTY4IcMkcTsbkaeYou0CDY=;
        b=ConDYsYwWfAXU04YKWRlFh+3hQHTufFvMGsH8AyeheuLQLc+uq1vHqm6vTZSTER+w4
         DO8EjZTQxnplq0WRqh9GfD2G0gtaMtFUfXg4tXJsh2c8e0U/SyL5UlkhG30frfA1ST4y
         4zKrEUXloiiok6JNkgGOamydl7GIFZ84uRj5w7logi3MxxsICDKK9F+/L6Zh41yZdYFr
         spP7GkkdFqO8U9UqnvWTSqRtRF5lqTLRmNc/61DkUkunQh0PfwMCZB/yuVHZRAmnGfty
         MjTA/3sjws/yZihevaeqosIhbprwnHNoW2M2qnYU1Q3+BnXs3kKRRAjG4HyGrzbAlT1k
         Emkg==
X-Gm-Message-State: AC+VfDz1PZKwUE28GxyeJPO4MZ0Bd4AgU/4rsZbOQlAnTtFSql4nUzXo
        jK+HR1sM2cD1RXki698pj7S+SkYVdcowubY4IGMa72tQJTfZzwAy+MhdTg==
X-Google-Smtp-Source: ACHHUZ4yNnIeW6xZpPLiaVRnq3DPPpO7aR3C7mWs6623sflXXuUQ+liw5rmNxwTYrcSkLr+wQPlWHm14UHK8qJMbQK8=
X-Received: by 2002:a05:600c:4fcd:b0:3f6:f4b:d4a6 with SMTP id
 o13-20020a05600c4fcd00b003f60f4bd4a6mr283186wmq.7.1687828840459; Mon, 26 Jun
 2023 18:20:40 -0700 (PDT)
MIME-Version: 1.0
From:   Yuxiao Zhang <yuxiaozhang@google.com>
Date:   Mon, 26 Jun 2023 18:20:29 -0700
Message-ID: <CAOOoKeQ=b4u1C_FZ-OFHSfVt5Z9xw1KtpJ4316zubt46Tny41Q@mail.gmail.com>
Subject: support pmsg record size larger than kmalloc limitation
To:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org
Cc:     William Kennington <wak@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi pstore maintainers,

Recently we are trying to use pmsg ramoops to store relatively large
file. We found that even with enough space configured with pmsg-size,
it still failed because of kmalloc limitation.

We are thinking of using kvmalloc instead of kmalloc for ramoops pmsg
record buffer. It seems ok to us that the memory is not physically
contiguous. We want to consult with you whether it is safe to do so.

Below is the patch file, note that the change only touches the pmsg
ram path, we don't touch other paths like pstore zone. It is not yet a
solution for all the use case in pstore, just an idea of how we want
to address the issue. We test this on 5.15 and large file works fine.

-----------------------------------

From 5f7ac624d47b49ea827c1ad8e3b47534e0709ea3 Mon Sep 17 00:00:00 2001
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Mon, 26 Jun 2023 16:40:40 -0700
Subject: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation

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
@@ -54,7 +54,7 @@ static void free_pstore_private(struct
pstore_private *private)
  if (!private)
  return;
  if (private->record) {
- kfree(private->record->buf);
+ kvfree(private->record->buf);
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

@@ -549,7 +550,7 @@ static int pstore_write_user_compat(struct
pstore_record *record,
  if (record->buf)
  return -EINVAL;

- record->buf = memdup_user(buf, record->size);
+ record->buf = vmemdup_user(buf, record->size);
  if (IS_ERR(record->buf)) {
  ret = PTR_ERR(record->buf);
  goto out;
@@ -557,7 +558,7 @@ static int pstore_write_user_compat(struct
pstore_record *record,

  ret = record->psi->write(record);

- kfree(record->buf);
+ kvfree(record->buf);
 out:
  record->buf = NULL;

@@ -730,7 +731,7 @@ static void decompress_record(struct pstore_record *record)
  return;

  /* Swap out compressed contents with decompressed contents. */
- kfree(record->buf);
+ kvfree(record->buf);
  record->buf = unzipped;
  record->size = unzipped_len;
  record->compressed = false;
@@ -783,7 +784,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
  rc = pstore_mkfile(root, record);
  if (rc) {
  /* pstore_mkfile() did not take record, so free it. */
- kfree(record->buf);
+ kvfree(record->buf);
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
@@ -268,7 +269,7 @@ static ssize_t ramoops_pstore_read(struct
pstore_record *record)
  /* ECC correction notice */
  record->ecc_notice_size = persistent_ram_ecc_string(prz, NULL, 0);

- record->buf = kmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
+ record->buf = kvmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
  if (record->buf == NULL) {
  size = -ENOMEM;
  goto out;
@@ -282,7 +283,7 @@ static ssize_t ramoops_pstore_read(struct
pstore_record *record)

 out:
  if (free_prz) {
- kfree(prz->old_log);
+ kvfree(prz->old_log);
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
- kfree(prz->old_log);
+ kvfree(prz->old_log);
  prz->old_log = NULL;
  prz->old_log_size = 0;
 }
--

-------------------------------------------
Thanks in advance.
-Yuxiao
