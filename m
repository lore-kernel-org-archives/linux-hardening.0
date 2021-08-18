Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BDDC19F3A
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 05:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5AB610A1
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 05:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhHRFJ0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 01:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbhHRFJV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 01:09:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89FC0613D9
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 22:08:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e15so1054718plh.8
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 22:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FK2fIWn19YrP32oTsI8kiLBJYwRvpS1FTekYTCayugc=;
        b=m1B7uYDMpDUCE9+R/JaIy7VxsbIG2eNTIT+fHb4u4fBE9H+u1PR56oYkUL087UoT+M
         DoBCwzptwPo08auHY/WjzVvC/Q9cQRvfT0NqWGTkvReAqw+AIskTM4Ip5Ng2F8Zun774
         29fWvW3grg+DRUZp4UHrch1DrUYhmdDSGKQrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FK2fIWn19YrP32oTsI8kiLBJYwRvpS1FTekYTCayugc=;
        b=FAQMRv4lH8zASbxCHySb4X/bG0qFDnCAVTEmirWZ4IDlpppsNQ2subm3x5O1gjjPua
         SqhYBzc2adTO2GLBPIFjsZ7A6W3RzuXU1d2NVVT/zxmwvX/2myR1d4bXISdY9cRTcOwl
         tRa9Wmlkj0XfJud9F0HWIIDn3T7850wnC2i49VPoSLNro0JxIBlHONdDDqUdjndKC1ht
         8/AMXJUBNBu8G+HCiY4+CdwJBjl/9t4o9hWXfUKVUOPA18u9y8f0vnjmJ5phAluTt+7L
         APHQrvo0TIpKxetp7yIw0sZNtvnkdht8giHN/xM/LYZf9gMbKx1cZvhE/a8OdjYiHMf7
         zFBA==
X-Gm-Message-State: AOAM532jxUTo2uUiTXDehZCuOBZJye19QkYqv+soXB+SSOr50HEABxOL
        DuPlwr0MSLbyKfH9C4H8PxXvfA==
X-Google-Smtp-Source: ABdhPJw3TZNVOkyIiaV8rbXlMH7bQVdkoRyiSUgXA9s5bV0IQPqLsxWhNFyH8vNjJf3GqmWHB2GDEQ==
X-Received: by 2002:a17:90b:3718:: with SMTP id mg24mr7652580pjb.158.1629263326717;
        Tue, 17 Aug 2021 22:08:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r13sm5247632pgl.90.2021.08.17.22.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 22:08:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 5/5] mm/vmalloc: Add __alloc_size attributes for better bounds checking
Date:   Tue, 17 Aug 2021 22:08:41 -0700
Message-Id: <20210818050841.2226600-6-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818050841.2226600-1-keescook@chromium.org>
References: <20210818050841.2226600-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2480; h=from:subject; bh=5f6ICgvlEcDnZ5CvExQnS354eTx1Re0AZwmMZI84A5o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHJXYNOcKk3pb/hdH0pQG61sgMsvM2uPEmpliSWFO auEpIquJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyV2AAKCRCJcvTf3G3AJpBhD/ 94RVCDqdDBUbvyrRsg2UwLDN/C/AanhfxGGXoFQZ/Db9AFoP/OQgdhSrh3zfuYH5gL2IfgXtNFQUjH RC+mh0rpeaoG103VtZkh7CxQ6hpcp5Nh4ZgINyIyqdA/3FbngtFC4/JVpleRFrTfqJMKmH5chVM4gC oiBvWIl48k3ExCNccwHsIB4LkhzM2+lLljU2Db9VlLYkcyHK+R47iclOlGK59zI0eNMCV3witO4xYe 9W4bUHcJwGCjCj8ERqtUHGmAG/v6/68E8ga3l/k0SFgC0bbSNbK74t3U0f9SzxDwqV/j8icex3NlKS HzoS6dqNNzf7ANraAm7X0yMYh9OmqdZ6s29xHnSx0P0RGXH2xeB94kciWFVkM6ekX5JSgGfYbheoPC 0GvTs1Q5lar5b+TvABSBB3kdmUJSBW0/puxXf6vFXqOGqGJWCRN4aKkWIJo9Adiq1XfwBPkkbQmyFW Kg+zOhC9BNCApxIfqz/sQ+1BRDF4dqsrohVBpzRlRj6m/67Sg66cTNe2rrItoD1qssJZ8WaadlWbxu qljdjB59uZtvtjlATr5GsPXup7shDyk8B8iNPX2p1w4/6wTeNOHlyy08jWPuXVA0vvTcRc6aZ24e8h XnhJNM1zn93N07XxrnL1mpUka9jN86XbzikHemhZiZP+GZKVZMqYdvssGqxA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As already done in GrapheneOS, add the __alloc_size attribute for
appropriate vmalloc allocator interfaces, to provide additional hinting
for better bounds checking, assisting CONFIG_FORTIFY_SOURCE and other
compiler optimizations.

Co-developed-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Daniel Micay <danielmicay@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/vmalloc.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 2644425b6dce..f4ede07e1dae 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -136,21 +136,21 @@ static inline void vmalloc_init(void)
 static inline unsigned long vmalloc_nr_pages(void) { return 0; }
 #endif
 
-extern void *vmalloc(unsigned long size);
-extern void *vzalloc(unsigned long size);
-extern void *vmalloc_user(unsigned long size);
-extern void *vmalloc_node(unsigned long size, int node);
-extern void *vzalloc_node(unsigned long size, int node);
-extern void *vmalloc_32(unsigned long size);
-extern void *vmalloc_32_user(unsigned long size);
-extern void *__vmalloc(unsigned long size, gfp_t gfp_mask);
+extern void *vmalloc(unsigned long size) __alloc_size(1);
+extern void *vzalloc(unsigned long size) __alloc_size(1);
+extern void *vmalloc_user(unsigned long size) __alloc_size(1);
+extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
+extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
+extern void *vmalloc_32(unsigned long size) __alloc_size(1);
+extern void *vmalloc_32_user(unsigned long size) __alloc_size(1);
+extern void *__vmalloc(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
 extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
-			const void *caller);
+			const void *caller) __alloc_size(1);
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
-		int node, const void *caller);
-void *vmalloc_no_huge(unsigned long size);
+		int node, const void *caller) __alloc_size(1);
+void *vmalloc_no_huge(unsigned long size) __alloc_size(1);
 
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
-- 
2.30.2

