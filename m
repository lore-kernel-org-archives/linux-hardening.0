Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFA3C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 20:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE9061037
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 20:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhKRUjn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Nov 2021 15:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhKRUjn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Nov 2021 15:39:43 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E28C061574
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 12:36:42 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r5so6502975pgi.6
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 12:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1P1IVsOV4eoi9h8VVG0W3l3nv1to2b9fsVwdeB/1IV0=;
        b=XnWmnVXy8Au21CmkY8y/BtMpDkPQMhuND3K3CNzihjJfcVFLPT5/u2HN5WJyQSG9Te
         OSdrBqfq+ja1YN0mFXR+PiF7a7wdmZArkA8mBRo2bNG0I8JhKJo7Oc5ONVIz5QGfaz3w
         aw4fLdiay++w9XiZIzeW3JcQqQAcO8cFK0g64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1P1IVsOV4eoi9h8VVG0W3l3nv1to2b9fsVwdeB/1IV0=;
        b=eUd9dGbrouzlYQs2zZrt2JUrKmWRfEIYdY6UovJnRb5J1mQoppOYPmQ0HFVgGEYpNK
         KjQJcZ7PfIpogD9fP1JN77spIUbnVbIalSpllSxAj4/CnuBrWbQjU0TTxlVQdXjqci8U
         Y8GV/06wTomLobJ2yVt/L9ozlsa2VIzIJy3WBOfLASZg1Hu5A/VH0UXxKwHAg7L2sJXc
         GloN52unNuWQVl98ZNzN/IVmwoBFy8vdChbPqBFK5v1xK7tmOO8mQSKqDBuEpfy2MgTV
         8DmvRIqdNvkTr9ADZxCznuDr4QVeDF5S6/Hqa2IJGK9vm65XDj1ZvmtuqgMr+2w+xtrX
         WS/Q==
X-Gm-Message-State: AOAM532jlZrmr5n4y6F7k7J8BoME2VqDFeA1/OMCkQjGKT+RhYEEGq5c
        rU3OwJEnsoUKokL0nu+sUe7jxA==
X-Google-Smtp-Source: ABdhPJx1PH3y3dE/DIYW2gw2KrkrLlgBWpuT41Q8G2aCVm7V4ETphnEr76qWFLI2NdrftFNHjpCBRA==
X-Received: by 2002:a63:e216:: with SMTP id q22mr13302659pgh.3.1637267802207;
        Thu, 18 Nov 2021 12:36:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d9sm7177789pjs.2.2021.11.18.12.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:36:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        linux-hardening@vger.kernel.org
Subject: [PATCH] dm integrity: Use struct_group() to zero struct journal_sector
Date:   Thu, 18 Nov 2021 12:36:40 -0800
Message-Id: <20211118203640.1288585-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; h=from:subject; bh=uXt5rNLQK/+BGfgY+/0jxuDI0+majyoEH4AYy0/HEDA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlrlXhAwJnh6qzFr/hBevLetAK90Djl1nlk7eJu89 EwRtAbaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZa5VwAKCRCJcvTf3G3AJlZuD/ 93cSna6doQ+jybq9Xil1PjrHssaJTkfcyQskeukUC9phbJym57uJK7TxVu3nfT3aYuBX29jiRcS6Gx mXu3VoOCukFyuNI1APYwhsdti5kZia/z6i+2MvlmiISfwTkUTdpvcplLXwSHnWeVTxPGkiK9sMDTf+ 2faBizMacRLwlmqfJUdPnN5Dr9JbyiwAFC+TJ93lGrtWXq9UDrR3okl6vFKMT662AD47jV8qFMimyW +3Ue45vPThhY0F4TCtCrrQRhGnChqyJQF0FWs+Sb4JnwXN3L3dqpF+9/+bOMlxjQ+A46h+nPm6x6Yv o7ybTYRSOKnxKh8r+iKNhRIZwrbu7Z5RKPxzPR1/G6wH0uGOM6mem/bI55KrqM14lPbR0LFdDBv67l zHoThoTesPcmeMY9/mkQqZk1CLmNzuT6q++UiCtGiA6scWPLtgXqo8RTHmISh9fT+NCCMaszqqY53H 2m2HyvrU3/lYOfgDxVkBcw/iCDcnVcdASzU0KMmeJw8dGFzu2Fc0po0hJSHYoHy6nF6JYYuByhPyp0 X+VSsMBiIuCIOOeVg46DXEp2VaHkL1/DjgCYQEjTe+NVU3bfB6/c9FkTyd/vzwyu10TMZNp1u49ijH BLEijZDKf1e4J2W0D9CydNOtpfllzMsjDyOOkgpwP9PIxR0X2Vyc7+5W8hIA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct journal_sector that should be
initialized to zero.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-integrity.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 6319deccbe09..163c94ca4e5c 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -121,8 +121,10 @@ struct journal_entry {
 #define JOURNAL_MAC_SIZE		(JOURNAL_MAC_PER_SECTOR * JOURNAL_BLOCK_SECTORS)
 
 struct journal_sector {
-	__u8 entries[JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR];
-	__u8 mac[JOURNAL_MAC_PER_SECTOR];
+	struct_group(sectors,
+		__u8 entries[JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR];
+		__u8 mac[JOURNAL_MAC_PER_SECTOR];
+	);
 	commit_id_t commit_id;
 };
 
@@ -2870,7 +2872,8 @@ static void init_journal(struct dm_integrity_c *ic, unsigned start_section,
 		wraparound_section(ic, &i);
 		for (j = 0; j < ic->journal_section_sectors; j++) {
 			struct journal_sector *js = access_journal(ic, i, j);
-			memset(&js->entries, 0, JOURNAL_SECTOR_DATA);
+			BUILD_BUG_ON(sizeof(js->sectors) != JOURNAL_SECTOR_DATA);
+			memset(&js->sectors, 0, sizeof(js->sectors));
 			js->commit_id = dm_integrity_commit_id(ic, i, j, commit_seq);
 		}
 		for (j = 0; j < ic->journal_section_entries; j++) {
-- 
2.30.2

