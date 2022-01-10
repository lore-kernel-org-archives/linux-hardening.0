Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2B4C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 10 Jan 2022 23:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbiAJXPj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 10 Jan 2022 18:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbiAJXPi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 10 Jan 2022 18:15:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08ADC06173F
        for <linux-hardening@vger.kernel.org>; Mon, 10 Jan 2022 15:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nYSnqKs9eUHoLhXGMAa3D+i7diZP4kPH2WYq8LEVbfQ=; b=LNkuwdwOG/DhLYe+dCZA7hAGXP
        lLVMd7rapIm35q3VHLji7eGhYqSIt/rl++mn5ejylF+IeoBJO14ZtB0B4sw7HswMbI3nkhQC6Xg/H
        cL8NSVjmXU+5/hgwLkmAi0gYZvyyheywxnijj0Z6Rk4I9iTbMtFVgq6TnrsQy4vJ+ZS61+Ov2Uhy/
        L/FvXOEZSnjPjv+3n6oMRV5Bf6OG5iwe0LSLuHfeWfXLdIs0E3GsvsXM3+AUgnlgHkMNeWzkA0f7j
        Eg7nLBGxUPCxMdpdlh/BNgAE0eiN99LApbpQuTDOEH7IqsRGTSqOJuL900phQx4ocQ2XsKEYDVKDR
        r9whMWlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n73sy-002nGH-Fy; Mon, 10 Jan 2022 23:15:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/4] mm/usercopy: Detect vmalloc overruns
Date:   Mon, 10 Jan 2022 23:15:28 +0000
Message-Id: <20220110231530.665970-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110231530.665970-1-willy@infradead.org>
References: <20220110231530.665970-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

If you have a vmalloc() allocation, or an address from calling vmap(),
you cannot overrun the vm_area which describes it, regardless of the
size of the underlying allocation.  This probably doesn't do much for
security because vmalloc comes with guard pages these days, but it
prevents usercopy aborts when copying to a vmap() of smaller pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Kees Cook <keescook@chromium.org>
---
 mm/usercopy.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 2d13bc3bd83b..dcf71b7e3098 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/thread_info.h>
+#include <linux/vmalloc.h>
 #include <linux/atomic.h>
 #include <linux/jump_label.h>
 #include <asm/sections.h>
@@ -238,6 +239,21 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 		return;
 	}
 
+	if (is_vmalloc_addr(ptr)) {
+		struct vm_struct *area = find_vm_area(ptr);
+		unsigned long offset;
+
+		if (!area) {
+			usercopy_abort("vmalloc", "no area", to_user, 0, n);
+			return;
+		}
+
+		offset = ptr - area->addr;
+		if (offset + n > get_vm_area_size(area))
+			usercopy_abort("vmalloc", NULL, to_user, offset, n);
+		return;
+	}
+
 	folio = virt_to_folio(ptr);
 
 	if (folio_test_slab(folio)) {
-- 
2.33.0

