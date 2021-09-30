Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42A2C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6ADD61881
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 22:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbhI3W3D (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344758AbhI3W2z (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 18:28:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463EEC06176A
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 15:27:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pg10so4754069pjb.5
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 15:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u2ub9aDUdGkR7a45M6+RayGW3Mc5Nzpp+BqvE+GQyD4=;
        b=E4117kGofCjsUGdfSRTGV+cTc7zkGteSQS/YjKtNttFBJetk/lbVRQOWBkP0cou6FX
         nquNIIKcACgN4NjJK0Dk4cvoGaQO1QOvxc7b+qSmM0G/pcadnqVz3fSeHbawfF/+5SxM
         W5CUTPB7Lbr4gYH5opiwBxjGFHpaqPuAJWxhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u2ub9aDUdGkR7a45M6+RayGW3Mc5Nzpp+BqvE+GQyD4=;
        b=mWDmW/3Y8IKxYGV3/HcEESIcg0VSrDb2R3cKHpkexNZtIRU2TU1VmVS/WvOqsiIuwu
         oIyOFk/3rOd+kGZ4EseWDzCqvfTUmjT28bG+59Nitd8UTZwtk3tkogMp0HcbI1nmCEnV
         VVl0/zK+7iKJbc+yagV7xl/IZaAU+F7tldC++jPJefEU0q1sxPjMTev3HVDyQs7dsuMo
         /+IzblJG4qM2CgfQ84ImG0qy5SYR+nIuYdH9XSqB0OgaLXDtaWKgUXAIzFVSckUmM5Fr
         6zW4cQCqlDEC2JXNZUTTZ4Q3B2szpfh/zF9APWz4gIoKOvggXP1xeJEaQRBc2WVvTsF4
         lwGA==
X-Gm-Message-State: AOAM5301BA8mdxzHCwyPCUmZxPbA1oBShMWP4l+E0Qwc59GEa8INp0Ae
        5d4YGDmK1DTPddY/QXVSxYFovg==
X-Google-Smtp-Source: ABdhPJwQdxICM7qve4++qlkIYIKGkfShLBTtRkjuyHcuH/G/SHg9YX/oL/zPE0SniAua+b9zgN40Qw==
X-Received: by 2002:a17:90a:47:: with SMTP id 7mr9261738pjb.46.1633040831839;
        Thu, 30 Sep 2021 15:27:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l185sm4055195pfd.29.2021.09.30.15.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 15:27:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Pekka Enberg <penberg@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Micay <danielmicay@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 7/8] mm/page_alloc: Add __alloc_size attributes for better bounds checking
Date:   Thu, 30 Sep 2021 15:27:03 -0700
Message-Id: <20210930222704.2631604-8-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930222704.2631604-1-keescook@chromium.org>
References: <20210930222704.2631604-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; h=from:subject; bh=yfsJRZe5VPlXhNpESupqg/Lx3TB+JxswN2/B9c/1qRE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVjm4IH1a0nV/SMwCAsRFQGt/UlwMh4gkN7oMNoN0 ZBYvfZOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVY5uAAKCRCJcvTf3G3AJnyND/ 9Jn6MqWe77b4tIIKVMs4JhXxwCeYTw1fq3mDnWNU4lSzNE/x3S6AYm3L/txTVyeheRfpOl7SOWwk70 /CWgalV93SIVwrfyQk3eIHwwaYv5XjUxMKTq9OmuY8shTCHA0Dmu9LfiSuLzV9yZ8WUaBEymsdsauL A3bK8vkp9rzhLE4geifpHgJ2ELbeD+A+KNRW5ojXhXB4SBMsdYtEqRGGSsMURPAyAOIn14yPxBLu4M ILNp4YRWjuhJWMN2YAc262qkmCtJjdPPTiQirjxUttsVUtLbK3BsOqjXu+T/dGyFDCb1+eCMJ0arG5 LR10YyJAmOxmECGqzhaP9h18bHNuGDnHAxpPXDn+AhFwwI/Qw5u7+QnYpaOKUkucflZJbd4KykcidL NxsnbLLexoPG7e3txH9ZWIYh72T0Se7V2u93sp9AhF80AYirhFQw26z3rqV3XeCFQkceyWEaZmiras 5eoD20fPo4Dlt04k/F5h2NaBn/LUiB8YxoMnHv2hVt8Ft/cqmhNRqkI/z5Nux69TO3JMtdRDX67id+ /uJBIcZFdewl3ka+oWfCVb3bpMGdaHVp3+bmLiQGZXR1z6tnH3gUZVUECYU98Kh0AW4LuiNi3A/xGa 0WhDo8ht51lnbE7T8FRhQ7FL8vO50a8MszXtDGPQpVltL0E0RubMc+2FVe6A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As already done in GrapheneOS, add the __alloc_size attribute for
appropriate page allocator interfaces, to provide additional hinting for
better bounds checking, assisting CONFIG_FORTIFY_SOURCE and other compiler
optimizations.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Co-developed-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/gfp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 55b2ec1f965a..fbd4abc33f24 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -608,9 +608,9 @@ static inline struct page *alloc_pages(gfp_t gfp_mask, unsigned int order)
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
 
-void *alloc_pages_exact(size_t size, gfp_t gfp_mask);
+void *alloc_pages_exact(size_t size, gfp_t gfp_mask) __alloc_size(1);
 void free_pages_exact(void *virt, size_t size);
-void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
+__meminit void *alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask) __alloc_size(1);
 
 #define __get_free_page(gfp_mask) \
 		__get_free_pages((gfp_mask), 0)
-- 
2.30.2

