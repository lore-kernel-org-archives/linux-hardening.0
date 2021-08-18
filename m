Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2C9C432BE
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 21:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F81610A6
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 21:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhHRVlV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 17:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhHRVlR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 17:41:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BBAC0617AD
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 14:40:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nt11so3573647pjb.2
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkpL6W5wADmlyNHUFZldG5mVI9okFbona7uNlwuA1mU=;
        b=Qy6If4qcKtJkUwTqjP8yxEzl81jcjqu3HXxxHD0WGo85OKcGnfjztCysIKYYXPN72G
         SnwjhDp/FioXSHi9fY1oM+99u51Sf23nMV3pdTq5lcrcYFl/uGbHH0LYNFERH/McPKxz
         NnpyYsr58PmrgdH74qwoLj/U42/4DaqEYdHIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkpL6W5wADmlyNHUFZldG5mVI9okFbona7uNlwuA1mU=;
        b=IK0T/UVuy9QoPa/pWugXOEvl5CVdVhOMxf54nS2p+pQ/pjhE4FV0PDzq7tmRw6/B+H
         5D3fg7ruMtQITYTN27W9cjJM05HL0HzL4OGYoS74MY/RVbeQhJ1vQn+h3yj0hDPJkqTF
         cE1ZtMIKAtyVsytr3gmiCK2IvYT96a9dSDmN10NvdUCr9FMHKTQfzQFqR7kPvj+CjCXx
         eS2SY1uZfvlyT8ml/GQXxUXq1FByWFNRNA0Be9g0XX09D2DnxFyaK/qfXPF89dgesFdR
         lyOkaKdJYJUaRsG1pUSEd/yzyJnwvZRjZi7jyVL2eFErLDYkC6AiBJskFywHW85DHQOo
         /18A==
X-Gm-Message-State: AOAM531JYBonFDRi3nR7v3X8UxUVvaUUXC0FNNfmuDHBFMX29/F1SUty
        WAeaWiAh72B4rvPkrkL5rNttEQ==
X-Google-Smtp-Source: ABdhPJzrhbYuLI5UlRW4aCCE3cbFMxFlFAXa9Z61qJQhnBzGGozo/4kJ/fhJlNKJnbWcs4ZQihLH7g==
X-Received: by 2002:a17:90b:fd3:: with SMTP id gd19mr9573234pjb.76.1629322841706;
        Wed, 18 Aug 2021 14:40:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x19sm834704pgk.37.2021.08.18.14.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:40:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
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
Subject: [PATCH v2 5/7] mm/page_alloc: Add __alloc_size attributes for better bounds checking
Date:   Wed, 18 Aug 2021 14:40:19 -0700
Message-Id: <20210818214021.2476230-6-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818214021.2476230-1-keescook@chromium.org>
References: <20210818214021.2476230-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; h=from:subject; bh=W6Cb28S2qXmrTKUD2DPqGU+sVI4WS8pidViY5hBWcNE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHX5ERWo0fTNGYg6mwSKLViBT93/C8jzcI2r2WUjP LwkFmOOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR1+RAAKCRCJcvTf3G3AJu5UD/ 9yIUyrMR9IxHlxKAanhzIsME7zxx04n6zWRtwcafigdh/kVuzrzuRYMif8CdvvgBvmz8HJwZdDcdQE 82qUSTku6Uc0adci2vK6LHAWS+sDWZ3y83xb61th6T9qdLd8fcpin+QnJYegrBY56S1DOI4ipiyEXa w68LROW++aDn1Yb0oS+5DBCusLj0DqNdO63YohcPDDjtXNNamr5A6kjzJLbtUDeFJDxp65/gisJEo6 oV/morkS6bYX73qMpvcGnt1dXWLw6irYepPYWiyYPa29OL4bzmjo8TVNFj6869tivAN6s2p8BxyeHM 5hpfLWXwu1dC1GqLFGMxENpbegEsaqkzhn/KFG3dPkm8DFSCbTzB14kZ7wr1vqD65b1FQoZhlghJEW PWciluNwgNnwlQKgC3uvfsvBPMJvWN5974DLE/OCwJWr4P8y6OGFjeAg3GFD4ds+UgtkXb9nEwEVij SojHGWi6tife8OuVdpiyAaAousPkkz02htMpPDwG8SSxJJO1Fw9CwRWGDF0sEkOHwCCosUKhVTp8Vu UivVUOYfr/LVdMW5lpya4iiJDoBoL8ww5GKz0SAGrRpmPpbLtWALZA9bu9NmpyoloQ9lKFEAACF+dJ Fq0C6qVNHPMSUlCr0vhM7/JSbua0QjaQtTxhpC+iz25WikK4frNDFwJKbcnw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As already done in GrapheneOS, add the __alloc_size attribute for
appropriate page allocator interfaces, to provide additional hinting
for better bounds checking, assisting CONFIG_FORTIFY_SOURCE and other
compiler optimizations.

Co-developed-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Daniel Micay <danielmicay@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/gfp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 3745efd21cf6..897538d5ffd2 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -618,8 +618,10 @@ static inline struct folio *folio_alloc(gfp_t gfp, unsigned int order)
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
 
+__alloc_size(1)
 void *alloc_pages_exact(size_t size, gfp_t gfp_mask);
 void free_pages_exact(void *virt, size_t size);
+__alloc_size(1)
 void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
 
 #define __get_free_page(gfp_mask) \
-- 
2.30.2

