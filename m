Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF6FC4332F
	for <linux-hardening@archiver.kernel.org>; Sat,  5 Nov 2022 06:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiKEGfm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 5 Nov 2022 02:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKEGfm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 5 Nov 2022 02:35:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE06A18362
        for <linux-hardening@vger.kernel.org>; Fri,  4 Nov 2022 23:35:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso10127815pjc.0
        for <linux-hardening@vger.kernel.org>; Fri, 04 Nov 2022 23:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+ttrriw2jHbnwBq8r9WNw6hEcBwWElO92RwaTxM2O4=;
        b=JUkgp/e0IphClCG54NWjL/yqLptR2OE1WH8h5TEyrYSFpfliB6k3FR2lKYsnWuL6oh
         SyK0PjXgG139TvsIyS/25Lj4cPM3HwsOAYC7fIH8elQXWGzAi+AdpJQo9K2hoCR9G6Ym
         FcWOplSbLVVXPJfoLops5eLetitvWlePoZQUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+ttrriw2jHbnwBq8r9WNw6hEcBwWElO92RwaTxM2O4=;
        b=MhA8p2FOhlPaFDB++srCQR7L9ShqsNYL1wBW7K5eAXGwrtTsqOfO3iPqoAHFhtn59l
         8BS1MXN8PrCbQ8i4BXqawnP/IducUMcpQkCsO2VqA8zRO6TFGvTKTBJqFKI8eF9p3OAx
         db0k1uopRs+kfiJ1sqpmSEM8h2AXNthWb67GPttvDPhswMcrlLIX8RkWKvEk9CfJ28Ai
         QE2Rq4MKR4pnHvCoN1BSlTICwbxOrdtuYS1CyZ/Va3PlScx7Z2Jld/uoav/ShX0mHLfR
         Y6+a4xybQH5NQQYsH3B0XcgJ1QWRqx6Krmt3PzLn4KEMoFtRBDbZBAdf5wlS1NwNacHU
         6hHw==
X-Gm-Message-State: ACrzQf2Rza1gv1AfoCcrKsciUPMCYVltl+ZBkLORPgoievluixDgm34a
        td2AxOFJGtBug9ON9A/VFW6boA==
X-Google-Smtp-Source: AMsMyM6GIqPmhSXRWkyElAVjS2i8skcIDYLMxIhJaZ10L9qTgqe0jzDdEDbRPuGBca3OtaF+p3hqPA==
X-Received: by 2002:a17:90a:9a8f:b0:212:ea8d:dc34 with SMTP id e15-20020a17090a9a8f00b00212ea8ddc34mr59411973pjp.30.1667630140271;
        Fri, 04 Nov 2022 23:35:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i36-20020a635864000000b00464aa9ea6fasm678014pgm.20.2022.11.04.23.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 23:35:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] mm/slab_common: Restore passing "caller" for tracing
Date:   Fri,  4 Nov 2022 23:35:34 -0700
Message-Id: <20221105063529.never.818-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; h=from:subject:message-id; bh=JSGlXxVXB24xybNyyB3Vx4Hgog1N3EuhU50a+R/H2V4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjZgQ1daoz1U/VFQdp/4qneXVJ7s/nT76PsVBHEcUw Hku/Y+aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2YENQAKCRCJcvTf3G3AJpYND/ 43VInsS7w3k6nIW0kEAEKttCAbRNuYUQth1geGAKEEnDhfwHwhs5BI39fidAQfdwJ3DUS2DkWf2Abu esup2SlME5eBOZ0ffdxyq5O2bH7IsrT1akDDnac6gMn9lrJndYJlVfeigjZlKA+zcpbXCkns6OCLL/ 24AFCoY3DQ8Pjnzlwa2FurtmroYYVT1iiYXGGZMcYUJSM9hLXe9Q+dAjex6CuyNXZp8wwdL7rNnegi qyq3bPBfpuWBA29l+r080Ua4pn74ON7En9+6CQtVaX5bibHwgcsV9aT2LxMmskIhCeMko5Xxl9cN0r u5M5qHnPyjCYLS4IXSUsuJQ7DE/SRA81W6Qh0dQXfazCHFjI1+8TSCHX/hwxCZ6811idprz+VsFoiR y0Z7wojUwvY2odkzybSQeDJoAEVzVX2A7PfzXspwoA+D9VFDdHcyrdNB0JJkfHE69wzSqVpoijFfQD hy/CkLNl9l2YS9QupqWIdzSGDqbvB0+VyxvH2aYakKv9/KxcYJscLbz+jZdtflujeR0WWvUSX68GTv oH+P+DwmUSJ2l5Y9KcfQ17ysXUbFSZRkuiAYFNV8XbYN2jtlC+GAuWWNBP4N2+ieim+FxlBMlAt9Pu sl/rXgcX304x0jVRzknC7ISFsscd2pr+27sGDOhWxNEvzSLSkFrov1lVe/9w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The "caller" argument was accidentally being ignored in a few places
that were recently refactored. Restore these "caller" arguments, instead
of _RET_IP_.

Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org
Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/slab_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 33b1886b06eb..0e614f9e7ed7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -941,7 +941,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = __kmalloc_large_node(size, flags, node);
-		trace_kmalloc(_RET_IP_, ret, size,
+		trace_kmalloc(caller, ret, size,
 			      PAGE_SIZE << get_order(size), flags, node);
 		return ret;
 	}
@@ -953,7 +953,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 
 	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
 	ret = kasan_kmalloc(s, ret, size, flags);
-	trace_kmalloc(_RET_IP_, ret, size, s->size, flags, node);
+	trace_kmalloc(caller, ret, size, s->size, flags, node);
 	return ret;
 }
 
-- 
2.34.1

