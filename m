Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7D7C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 17 May 2022 21:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiEQVtS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 May 2022 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiEQVtR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 May 2022 17:49:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141EC52B20
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 14:49:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i17so14763pla.10
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4//2wcKUjm7wVE+xXDVk0cokK7GAjJzcAndozpK7d/8=;
        b=RJWTaG1dDrGlVlN9KIiw3fChhdkiehjq8Tb+cv7yMQ+vNtYUf4id+SS2yYctoOlqda
         /r1Y6KvHFG5W/EVhz6KsZtQYc33sdqliL9JbXe0jlnetB7tk1wtQqvzTZUQv3flxF8mF
         2192vx5iJRL7mHaHaw+4VXDke6dA2keORShjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4//2wcKUjm7wVE+xXDVk0cokK7GAjJzcAndozpK7d/8=;
        b=4tZmcrcgKacSYe+QAie5XLtpe/Ek6YAtY1UNkPF5d1clHlTBvzDzqE19ihIjb0mDvv
         A501J25anfD0tMXDh4sXl5TQN4hUi4kAyhc5wvHCesPJOllINBP7RhE+jO0hgZAWoU6p
         IkOWkNvbi0vFuyVfamcnafCoxYsgagOjMAyHzOavlBrIz+P+umeHXshrepUg4dxNNjve
         e+j/3Ik0JuFaDLv3XfYtU+tM4IV2yKN1WTbL1hE63YRKl0DKHieO0VYTUegoc+BO3svo
         1OSrtzZqR2VS2HygrdiXPjdGjQ06j/Dkl8eWVJ6ufpj0K3xVZLgboIAdM4iZ6l6oJaDo
         YPPQ==
X-Gm-Message-State: AOAM533LrJg2dRXq11lAp8wMTffJZ+CzeysCCj+nubtD2Gnb1VWBs2uk
        AJDXX3JAzOpUBYfMhAUY24bcFg==
X-Google-Smtp-Source: ABdhPJziHuyE0QeOGD0VhJ/kDrr6NCR/uSL8rCaLKSTsf+QpH+6n6R7Y91lQDLvs7/tddWZZ89iPeA==
X-Received: by 2002:a17:903:248:b0:155:e8c6:8770 with SMTP id j8-20020a170903024800b00155e8c68770mr23351128plh.129.1652824156579;
        Tue, 17 May 2022 14:49:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id kt11-20020a17090b214b00b001df2f8f0a45sm100414pjb.1.2022.05.17.14.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:49:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/usercopy: Check vmalloc and >0-order folios
Date:   Tue, 17 May 2022 14:49:14 -0700
Message-Id: <20220517214914.878350-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3494; h=from:subject; bh=KIxGg/ioZZNsqgLwDtXiGSi0ZEwDVlEBciuJk08W4UA=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBihBha9G04FHWcCTd7MhyLQxr78bdbNBU4rSYVFYNi MZ8LJdKJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoQYWgAKCRCJcvTf3G3AJobcD/ YuB5UwDN5hpVQpV0PSSQClKJvq9bVnYGBcfPtsge25S7v3naqnBsgagAlaEPG7OWlTm9mECiDY2Zhi Ql2IMvxjxzvZgh2Vt0rvt3kSrQg9QExkghVnLo9FpBppfu0Mf0M5CgR2J7OomYA9/q5PRPVLkAZ04h kC7BhVpVF5wBrXzlKnYgM0ilie7FceNgigXtpv6qtOal5uuOCT0Z7hAQeSB7rF5Ga5ORYxsZmjsGHR SOFohvY7SelzSTpb34ZPsaQtHHhyK1pzDSoL3EXjGGR2TmyPnvmnGlHBGoCExY/bQProc1YB+NTOm/ Pr/E99jOQwx+o9p+0uWtdqfXqdrr2js1XcMLsliSFcc3dR97DvnGM9hGm9bQVnMnIOTXDH3nzxsNRX 3DPJAKx3zexH8ehWyOAIUdW6Bzv2cdzT+zXs5BnaXODtIosKAvIyw7nN4nlWkuwPW5z0cFh48wzvyX gTMPO1UAcYY/k7Ci5C7ABY/4l0IFMIRXIiHe3eFGaUGNDhQMRzGqUIa0P/LsdSVHakUK/bjWRNUdSI fpEjcYrOO0I6cW88DjQT8lETwJZFk0vIbS0isIWVhD+CFaZozqaAVRX+1WX4PGuIqqCKVr9wFTbrgU rqKiYBERWpFgLHmuldb91pXRDot9nI0FCJZkdmJxnXWt05cL1kQvhAWxdb
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add coverage for the recently added usercopy checks for vmalloc and
folios, via USERCOPY_VMALLOC and USERCOPY_FOLIO respectively.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/usercopy.c | 83 +++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 945806db2a13..6215ec995cd3 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -5,6 +5,7 @@
  */
 #include "lkdtm.h"
 #include <linux/slab.h>
+#include <linux/highmem.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/task_stack.h>
 #include <linux/mman.h>
@@ -341,6 +342,86 @@ static void lkdtm_USERCOPY_KERNEL(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
+/*
+ * This expects "kaddr" to point to a PAGE_SIZE allocation, which means
+ * a more complete test that would include copy_from_user() would risk
+ * memory corruption. Just test copy_to_user() here, as that exercises
+ * almost exactly the same code paths.
+ */
+static void do_usercopy_page_span(const char *name, void *kaddr)
+{
+	unsigned long uaddr;
+
+	uaddr = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	if (uaddr >= TASK_SIZE) {
+		pr_warn("Failed to allocate user memory\n");
+		return;
+	}
+
+	/* Initialize contents. */
+	memset(kaddr, 0xAA, PAGE_SIZE);
+
+	/* Bump the kaddr forward to detect a page-spanning overflow. */
+	kaddr += PAGE_SIZE / 2;
+
+	pr_info("attempting good copy_to_user() from kernel %s: %px\n",
+		name, kaddr);
+	if (copy_to_user((void __user *)uaddr, kaddr,
+			 unconst + (PAGE_SIZE / 2))) {
+		pr_err("copy_to_user() failed unexpectedly?!\n");
+		goto free_user;
+	}
+
+	pr_info("attempting bad copy_to_user() from kernel %s: %px\n",
+		name, kaddr);
+	if (copy_to_user((void __user *)uaddr, kaddr, unconst + PAGE_SIZE)) {
+		pr_warn("Good, copy_to_user() failed, but lacked Oops(?!)\n");
+		goto free_user;
+	}
+
+	pr_err("FAIL: bad copy_to_user() not detected!\n");
+	pr_expected_config_param(CONFIG_HARDENED_USERCOPY, "hardened_usercopy");
+
+free_user:
+	vm_munmap(uaddr, PAGE_SIZE);
+}
+
+static void lkdtm_USERCOPY_VMALLOC(void)
+{
+	void *addr;
+
+	addr = vmalloc(PAGE_SIZE);
+	if (!addr) {
+		pr_err("vmalloc() failed!?\n");
+		return;
+	}
+	do_usercopy_page_span("vmalloc", addr);
+	vfree(addr);
+}
+
+static void lkdtm_USERCOPY_FOLIO(void)
+{
+	struct folio *folio;
+	void *addr;
+
+	/*
+	 * FIXME: Folio checking currently misses 0-order allocations, so
+	 * allocate and bump forward to the last page.
+	 */
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 1);
+	if (!folio) {
+		pr_err("folio_alloc() failed!?\n");
+		return;
+	}
+	addr = folio_address(folio);
+	if (addr)
+		do_usercopy_page_span("folio", addr + PAGE_SIZE);
+	else
+		pr_err("folio_address() failed?!\n");
+	folio_put(folio);
+}
+
 void __init lkdtm_usercopy_init(void)
 {
 	/* Prepare cache that lacks SLAB_USERCOPY flag. */
@@ -365,6 +446,8 @@ static struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_STACK_FRAME_TO),
 	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
 	CRASHTYPE(USERCOPY_STACK_BEYOND),
+	CRASHTYPE(USERCOPY_VMALLOC),
+	CRASHTYPE(USERCOPY_FOLIO),
 	CRASHTYPE(USERCOPY_KERNEL),
 };
 
-- 
2.32.0

