Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB845C54EBD
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 22:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjAEWCB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 17:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjAEWB5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 17:01:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C80A69509
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 14:01:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so3397112pjq.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GU4F0A6CghntlAPFlpuG7hCmUocPla4d2Q4HBiVaB3k=;
        b=mTH+Pi3ROqEsjK25XUv/HIFl/ZZBPEhOQWIk/soZxwErT2IfckDSCYXjlhJWs9ypug
         hfyPaZoxRTq5zBvRSgv3VMmw3jJyytXAts59+xEQbtr3bpXqq23Zv+V/RK2WBLXPqYCt
         fRDRg4gQgtlwgBJ3z3ia4doa5sW8Sr8N8M5GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GU4F0A6CghntlAPFlpuG7hCmUocPla4d2Q4HBiVaB3k=;
        b=RBoQMTqqtoou3IAQwhii1EoH21UPR3EsHUS4mI/T4RAhaba2A253LEAouaLBAWbgFX
         vfCrD71o29qqIkgKQjcNaGGZBNEGSYTJcT7ttDBBM1MHgcg6uFKXEdsObunyyVq8QW67
         B4thnar9wJfTGDn5yBt8ICtN0LCOiMA+omgKFKfnHVK8DreLBcsTeJ2ctBrkROj/L5xQ
         J7QaxvqgMsfY/rLomhkIF7Ky/+G+IJF0N0rlaPaPgcy3dLC06Y5ifSKMtVAW8tu2XtES
         52Vzldw6cegoiqzrZ4it/88VsJItg4JETU2XAdzUUtlmj+jmR1+biZYmqm8ZtTcXOo20
         YPpQ==
X-Gm-Message-State: AFqh2krw+hbX5X9fSUp/q1d1rfxR+W/Ijf9XaCJcEywOZi5tMObO0iKl
        UqpSy4FixndpAQ0JcXkCfpinrOUqObkKhhdV
X-Google-Smtp-Source: AMrXdXvKdh7czZvM4eVFJAWSkqYwNmvkFxmvgsEkW2lV2vNnboIARMc1tuPcgig4piCwbTioPww16w==
X-Received: by 2002:a05:6a20:1e5a:b0:9d:efbf:48d7 with SMTP id cy26-20020a056a201e5a00b0009defbf48d7mr56663117pzb.27.1672956116121;
        Thu, 05 Jan 2023 14:01:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h9-20020a628309000000b00574db8ca00fsm7924258pfe.185.2023.01.05.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:01:55 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] memremap: Replace 0-length array with flexible array
Date:   Thu,  5 Jan 2023 14:01:53 -0800
Message-Id: <20230105220151.never.343-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2644; h=from:subject:message-id; bh=wqATlM0Wy6ZUz1F3TRvkHL3pT03iLnEph/fbgS+sn5g=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt0jQGs4GvKcEISh+DUGAS/MBAXty4zobHGXMnncR wkthQ0WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7dI0AAKCRCJcvTf3G3AJpIqD/ 0YTMOnoLIq2BdwO/Kzukw8r0GthNIuwD/Zs4fYENGzt1pw16sh9gFyie7bQ9uuvzOzUImgfcoqMT6l GYcn9cU9VCKcv45dtSw5NWxTt30I4Naok6sZ2KEQJyyNxiYs0mXfv/j6ame8zdFCaeSuJjzF1NsC/s JlIyl2OcHHXOHr9AQk+YHlzhwhQ4PLxfPqHVgsSQaU6ygOsUbUqdG5cy8lNg+EmMLuDSzudI/7hBZb CYzdqdsFHDDTjBfivfpo5wG9vwf/+puOdddLEoAK/eL75zvcxVDDkqw5knpCpAU+MQTeJpJkBQqdsz by3KrnXaoaA5xdjveU+mqp+mOdadd/a4SgOwTYdHOvAfuvPe9P1VEkSVDUkp+7nRZQwZwc8PVeBGBX wMOs7ZlUgJvIBCx1DqAsRQUz9Hi7xxnRZPoioyVrPyV4GNPed5bYNnXk/wN/N/7Tw7A1z/dVR3N+DN 7uZmQK7Op1FR7MCa6dP5jCo3FtQ+lgMLWEr7F2xl54WLuDuXt5yhfyCScdHYArvJ95XcXODACD4xN2 W6mQXNFy2+m9yPbmzWZDs+cjL3Jp0l+NAC5l5cjnyXh1nGTm/aF9aeQYblYDl5yYyqDRGHBM+8hPi0 4h8drdjiWhgZEfmJEaq5pk+27Tr4r71W3y7BwztdD3quCAjO90oqnlHHx7RA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
"rule_locs" 0-length array with a flexible array. Detected with GCC 13,
using -fstrict-flex-arrays=3:

In file included from include/asm-generic/memory_model.h:5,
                 from arch/x86/include/asm/page.h:86,
                 from arch/x86/include/asm/thread_info.h:12,
                 from include/linux/thread_info.h:60,
                 from arch/x86/include/asm/preempt.h:9,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:56,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/mm.h:7,
                 from mm/sparse-vmemmap.c:21:
In function 'reuse_compound_section',
    inlined from 'vmemmap_populate_compound_pages' at mm/sparse-vmemmap.c:407:6,
    inlined from '__populate_section_memmap' at mm/sparse-vmemmap.c:463:7:
mm/sparse-vmemmap.c:376:39: warning: array subscript <unknown> is outside array bounds of 'struct range[0]' [-Warray-bounds=]
  376 |                 PHYS_PFN(pgmap->ranges[pgmap->nr_range].start);
      |                          ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
include/linux/pfn.h:22:43: note: in definition of macro 'PHYS_PFN'
   22 | #define PHYS_PFN(x)     ((unsigned long)((x) >> PAGE_SHIFT))
      |                                           ^
In file included from include/linux/mm.h:31:
include/linux/memremap.h: In function '__populate_section_memmap':
include/linux/memremap.h:138:30: note: while referencing 'ranges'
  138 |                 struct range ranges[0];
      |                              ^~~~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alex Sierra <alex.sierra@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/memremap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 7fcaf3180a5b..1314d9c5f05b 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -135,7 +135,7 @@ struct dev_pagemap {
 	int nr_range;
 	union {
 		struct range range;
-		struct range ranges[0];
+		DECLARE_FLEX_ARRAY(struct range, ranges);
 	};
 };
 
-- 
2.34.1

