Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138BCC4320A
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 05:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA99610A0
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 05:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhHRFJV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 01:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhHRFJS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 01:09:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD933C0613CF
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 22:08:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso4516956pjb.1
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L74a0g3OkBh38ZbWTWhzU9iYTGh84NVXbR3tMlDhDzA=;
        b=VoyLbqvgkeBK3s454PKfXrujQkaO8YCZzfEaRA2GyiUcpN1TJnjrvLnUA6U3DTwvHV
         0Ys0jZJyHXB4alRXdKvUxiRso64wJPdy6zEYBLNKxoCQdQD8i+tubBD/6OTl4b+f9+OV
         IAqGDBIIRzwCBxcb7ESVBQGr+0sWjockpToVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L74a0g3OkBh38ZbWTWhzU9iYTGh84NVXbR3tMlDhDzA=;
        b=qVBFWGQv6I4lGcTxAj6uDxTLMaQChFvaRYAAFgCa68POm0DvMcJor5ttZNLT0FSB5I
         sR4FyuG8NWxGNi8CyA2TnG+iHTUPzf0mBlHd3ezJbRGRgAkYNkmYyF6P8PagZ0F1hMu+
         bKw4EoELXmVQEYKVDyJAC4taprw8j2/bFgIUdIGEWOf4CMrH/MRIby97yYrBcFYZsC4Q
         DZ125WVWaM8KdiOhfXjiPVb4DvfqNMMfsSQI87TyxoihgnXp3S1eW5z3VQu1Y5pbPcRp
         yhG1XV8PVmqJ2Au2UaIBERFuClxdjckZzm6a1Uc9mWjsaPABKDuxs1tskexrDCwnFSWr
         Gr8w==
X-Gm-Message-State: AOAM533St1IvjGi500KfsYiBOp7+c3QlCV5RmHcBnpGabjK8iiFYuQ5F
        dlgFp1TELJQsnNZz7jKrCL4uGg==
X-Google-Smtp-Source: ABdhPJz5s4Wmz9dks92kj/ZztgnowsQotGHMNoaeyBq3IEi/9t+qTx3NfPgPSwibP7e3JjCPogSSQA==
X-Received: by 2002:a17:90a:420c:: with SMTP id o12mr7336775pjg.101.1629263324383;
        Tue, 17 Aug 2021 22:08:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y3sm5280769pgc.67.2021.08.17.22.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 22:08:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 4/5] percpu: Add __alloc_size attributes for better bounds checking
Date:   Tue, 17 Aug 2021 22:08:40 -0700
Message-Id: <20210818050841.2226600-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818050841.2226600-1-keescook@chromium.org>
References: <20210818050841.2226600-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; h=from:subject; bh=AKWCsy+JTouHpICDr1/00oSv9FpxEYB59HC7kt38kf8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHJXYZ7sr0DkI4785A86/V1s6T0JSWbDIAWTqa4IF o+5sgRyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyV2AAKCRCJcvTf3G3AJl81D/ 9vI9JuIir2OOD9eLSzFPss/uOq6+mj5CUm3OhDzeeKcY17QuKv8oZHV/r5p657bW2OcfeR+11HCPEq 3tFGsUIJBkGa16Q5uTm/DieR3q04KNo5M2AGU+XoQMeTmQycXxOOzTL4FLNzsvDgyeIvKuy6LKnAPK DWu6IttP6pgUPRKdSSfRSHHCQeD6CuR3m10veketQgEmTRWLqGPcGdEA9sOVhwlW0htfsprMSKUaDc f0SM0OOKwjPd22H9LkxplH3npRzVY+5xnMfxOcKZoot02ORxcmUILGtHUY9ePhB+pbm7A2VeNXZFlN 7nvLv/XTt7uqlm1eLNNZ4jTzLs9EZFAKQ7jTxeDytxH/N6CSoAmSylYNQyOWca+5t3RYmG6zCjrOO5 5U7G9wyTfDSS5DqJXkjb6DRFujbBqDg5jcBjCoCWqiGVAkiTnpu7NgoLR6zrsDsImoWrSWiCVuwua1 BJtEexhJLfjIJ9AhNPUCEcGCHnpTujcSfmd87HQt4V/6xvXPg57q9gY7Mrf1Nb0JwGquIqLT9YZlnx YMxItzlYJwB9VD8fq13icyty1atksKU4j0CNj0iLHOD2bqqLTTax+bcbfNV5rE9LdnVZx9QxDAlQvL JVOSkAac4aqRz/QlcLsLdDf5rkeWwn2zz2kilbDBVRc7qFw1qEFD76tf3fTQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As already done in GrapheneOS, add the __alloc_size attribute for
appropriate percpu allocator interfaces, to provide additional hinting
for better bounds checking, assisting CONFIG_FORTIFY_SOURCE and other
compiler optimizations.

Co-developed-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Daniel Micay <danielmicay@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/percpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 5e76af742c80..98a9371133f8 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -123,7 +123,7 @@ extern int __init pcpu_page_first_chunk(size_t reserved_size,
 				pcpu_fc_populate_pte_fn_t populate_pte_fn);
 #endif
 
-extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align);
+extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align) __alloc_size(1);
 extern bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr);
 extern bool is_kernel_percpu_address(unsigned long addr);
 
@@ -131,8 +131,8 @@ extern bool is_kernel_percpu_address(unsigned long addr);
 extern void __init setup_per_cpu_areas(void);
 #endif
 
-extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp);
-extern void __percpu *__alloc_percpu(size_t size, size_t align);
+extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
+extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
 extern void free_percpu(void __percpu *__pdata);
 extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 
-- 
2.30.2

