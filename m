Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C9C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 14:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhLMO1J (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 09:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbhLMO1I (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 09:27:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56627C061574
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 06:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FaGT0W88prg5rCbGEk97JZKHxNwNL3WzIICgEAogG4E=; b=mtLnrhgjys1pqoGO33djIsde2C
        8HmUctiwvH5oR5DW9wWo0s0HdWUgQ1mJbtegHveMzx0s3U1pZQP5gNSDCVFu261pmWunSPKgOFcA1
        ysU1GynwW/iXshue2VuFpeTg+2lftBEbO4V2gZvT3LmeSEIoi3H7rlXnWQ2FXa0BiGkQq2aksrbTO
        0e5WZmown/Qp2+9cgPieU6JasAZ/UOB/CipIcx6WEFz2htWixAfE9nQKUriINXvCIGcSMkk4MdM94
        IC3k8tBonM7R+pNu8CsILjWvb2nFyBQh6PPRJ9DTzYqvk8pxWqUGHrXUoS1PZGe/wbwtlyUUQNiWE
        N9wujDPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwmID-00Crlv-8z; Mon, 13 Dec 2021 14:27:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 2/3] mm/usercopy: Detect vmalloc overruns
Date:   Mon, 13 Dec 2021 14:27:02 +0000
Message-Id: <20211213142703.3066590-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213142703.3066590-1-willy@infradead.org>
References: <20211213142703.3066590-1-willy@infradead.org>
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

