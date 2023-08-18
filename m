Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A202EE4997
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 20:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379930AbjHRUNS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379974AbjHRUNC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 16:13:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7FA3C06;
        Fri, 18 Aug 2023 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=0CD3D6jOeO1sWdDFavfexjhFNJHMPMpsIEvUgxTyh6E=; b=ipyv+H5LGEdlhaWfnrn+1J7qPT
        fPhufDWfgXWFnE8a+r96FkCUneijux7oItrLvhAveU59H/vUNgnhp0GXUy98sTNBtM2prGpURItS3
        7tS/Tit4JnP06Yy8lUI38SXv/fskuUbPsTopDJ9Y3SfXyi4jDiisGD6xQqe+y/Lihm91CnN6xg9wo
        oVSd6w8Xsnfdk+3dLi0W/T1prum6OrVi5HcouilJKyjl09UnGB96dNMhohcLJS1Y6qKnOEwZiY6R+
        zVinZGpxAxvk/5TVyZxr6PWfRjR1j5fmJlw7NbCZOnjBJqU6telEO3GpaIA6gnzNgzybW2IgLtc4q
        g08HNihA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX5q4-00BS4h-Rm; Fri, 18 Aug 2023 20:12:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-hardening@vger.kernel.org, linux-docs@vger.kernel.org
Subject: [PATCH] pstore: Fix kernel-doc warning
Date:   Fri, 18 Aug 2023 21:12:53 +0100
Message-Id: <20230818201253.2729485-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Fix the warning for the description of struct persistent_ram_buffer and
improve the descriptions of the other struct members while I'm here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/pstore/ram_core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index eb6df190d752..4fbad03e7c33 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -24,12 +24,10 @@
 /**
  * struct persistent_ram_buffer - persistent circular RAM buffer
  *
- * @sig:
- *	signature to indicate header (PERSISTENT_RAM_SIG xor PRZ-type value)
- * @start:
- *	offset into @data where the beginning of the stored bytes begin
- * @size:
- *	number of valid bytes stored in @data
+ * @sig: Signature to indicate header (PERSISTENT_RAM_SIG xor PRZ-type value)
+ * @start: First valid byte in the buffer.
+ * @size: Number of valid bytes in the buffer.
+ * @data: The contents of the buffer.
  */
 struct persistent_ram_buffer {
 	uint32_t    sig;
-- 
2.40.1

