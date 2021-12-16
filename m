Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51D8C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Dec 2021 21:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbhLPVyC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhLPVyC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Dec 2021 16:54:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5CC061574
        for <linux-hardening@vger.kernel.org>; Thu, 16 Dec 2021 13:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dlV3pNPMcMviclf5RhZNDIDmGBRDvRI+kfEWSJSDVkk=; b=a5rViquGApQES/ro+eHyDlumcs
        160F+ADE5SQRRimF9Cgdlegh0C+3Dw8YOhFmXZPEgEloXTtGY/I8CRteFwJBO5+8FKLOIrkoR7XRW
        3NxBzMzmwyo2Q9SGMUJqPnRmA4DcsN+Muf4x0YomNyH5CiA55zMjdrTcygM556Z2xFtiiIDsjdW/y
        1Gqz/1+CvNcvz/L34z/e14/HITS7g1xl+5l+rSjyfq+FjRLBtdqANW964qpRWcb6PUoCQ/evYrl2L
        cLH6JYCbxRnCzpabI3ahplPPWEM0pE6hfWSnK8cBFYLDvRmHPlb8WVRm3mjd8860IUe+3F6OTcoEb
        HFUton9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxyhE-00FzY8-Op; Thu, 16 Dec 2021 21:53:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 2/4] mm/usercopy: Detect vmalloc overruns
Date:   Thu, 16 Dec 2021 21:53:49 +0000
Message-Id: <20211216215351.3811471-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216215351.3811471-1-willy@infradead.org>
References: <20211216215351.3811471-1-willy@infradead.org>
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
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/usercopy.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 8c039302465f..63476e1506e0 100644
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
@@ -237,6 +238,21 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 		return;
 	}
 
+	if (is_vmalloc_addr(ptr)) {
+		struct vm_struct *vm = find_vm_area(ptr);
+		unsigned long offset;
+
+		if (!vm) {
+			usercopy_abort("vmalloc", "no area", to_user, 0, n);
+			return;
+		}
+
+		offset = ptr - vm->addr;
+		if (offset + n > vm->size)
+			usercopy_abort("vmalloc", NULL, to_user, offset, n);
+		return;
+	}
+
 	page = virt_to_head_page(ptr);
 
 	if (PageSlab(page)) {
-- 
2.33.0

