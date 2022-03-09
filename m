Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D7CC433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Mar 2022 17:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiCIRwM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Mar 2022 12:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiCIRwL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Mar 2022 12:52:11 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB2212E763
        for <linux-hardening@vger.kernel.org>; Wed,  9 Mar 2022 09:51:12 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z16so2972354pfh.3
        for <linux-hardening@vger.kernel.org>; Wed, 09 Mar 2022 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yNYR6W1i4K4Ni/CEkCJxcHbOKXs3UUsttBs1JtTk6Y=;
        b=jIEsTXXHOL/3WBA46SZ+xVsvPUwVlvkPR83xqF364uw3fOstQEXIg7PNaRvulvK03A
         tKPuLIGHfMaA42450CMpl56T2/WUhVqfKsMsVxW7w94v2E/M75FTi9jPfBohjhDQhKxN
         0zhPeP03dnynoqGZXLIevLRNA+3k+r8pKihok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yNYR6W1i4K4Ni/CEkCJxcHbOKXs3UUsttBs1JtTk6Y=;
        b=BWveMO8BF2HNeIAm36K6NyqYn6CVKwqZaJ3hmtXB+DHYuTjMqjb6AVXKk13hvM6lNb
         7LczNmzD3ZirCsVvtpG1y8IDC0YLAMU7IIPuFeR5ttgTZ+nffphvtAE4r2wcyxoStJSc
         Ox8P8MEx9+GbywIVGoJ5wrC+6Ko3eDh+F6CtNVSmD50QgDOIf7XRpjvVH9FVdkqSqpg+
         rW0vKBTWhzPf0Zna0I0sjYJGF0Us5tVq3S8Vos2S3U0QcTNcdGOh6GT+cXdZEeEkwhgu
         o9tCfMAJOLMrtK9f2arvYJ31UmKtlo8aVCISaKUbFZwh+1LtkJaTdUjnqFO28RqWHr9h
         0QDw==
X-Gm-Message-State: AOAM532JGVghjw92e4CKqBzTdJN32AU+tJPFnLiuuR23tVWum7zCAQ1r
        0Eci9C0c7yXyG1yHqfUq9qE8zA==
X-Google-Smtp-Source: ABdhPJyombZYcJq2FvqfjICN50veoCiqVO9vyey0648MfcJxzdmqQ7x8AAlHqzTHca5fJWquoks42g==
X-Received: by 2002:a63:f50d:0:b0:374:5e19:d9cb with SMTP id w13-20020a63f50d000000b003745e19d9cbmr689622pgh.475.1646848271660;
        Wed, 09 Mar 2022 09:51:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79902000000b004f75842c97csm3984234pff.209.2022.03.09.09.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 09:51:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ARM/dma-mapping: Remove CMA code when not built with CMA
Date:   Wed,  9 Mar 2022 09:51:07 -0800
Message-Id: <20220309175107.195182-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; h=from:subject; bh=AxSCzKOCweLxS0BQOyfRE0iLV6xSDiEfJpdMxUbtuhE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiKOkKInLTtFRKbblukaLzGwFzn73QyxUhgMKDwRAe 0c/kqUmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYijpCgAKCRCJcvTf3G3AJlseEA CTd4WlF7KPauHdT3S0Tjwsxt1nl1iXDAxf1QskpK9OdWeFkVkmj8YKNJTsm1GbBKwYqoZDOVRXXuEY KT13rBujSgJoo1RMwonHMObE+H+IAmDV2hVp4qoMlXSrFMlELpwOURU4DmSWJ/0L/bE8CpJAvkhTV6 w8ZYdA15XDW4fT3cfyQ/P52d1Hl3LC4iVFsUlSA3mgdtK6Che4uew9uwoaN+sg9gQRK3djU4li7rQY itE7rOeziJ8PA5bt5yD5qd2qqwbXNMzWQz+TphCQLbQxS4/KIQBG8TvchkYst9HC42UPPElblUOP+U XN76rxodQe/1uSZZFgML8zw8hcGfL5OLWeMQWA0umXjtvx0II3xn0gPpVGTZr3QMHuPID8onigj2EI wxGeyK3j8TSS3l09TL8TM7GBDiBErAbCXeLVMIVQA/Icrm9LoqYCM0divB0mZMjZ1hjj6hyyC4Tfvo XlOstkuVQD1LeetY8Z4+AvFvD5HmVwAMthTchqyreOXFivejFpYGDYWzIg6tVLyMSia52YCZzFwMRZ 5wv5+NCovMvvgldkhPzfcnHEYzIi3IK4jAIh9mOHoRmjBscb2jC/+UbwcYUHVL1x4nO+/AfGSh8J3c KietDv7g3gJuqwp9N5AlmeIUDTLEGg5fqIuCp2iYDIDGOr+UANBp24aWT7RA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The MAX_CMA_AREAS could be set to 0, which would result in code that would
attempt to operate beyond the end of a zero-sized array. If CONFIG_CMA
is disabled, just remove this code entirely. Found when building with
-Warray-bounds:

arch/arm/mm/dma-mapping.c:396:22: warning: array subscript <unknown> is outside array bounds of 'str
uct dma_contig_early_reserve[0]' [-Warray-bounds]
  396 |         dma_mmu_remap[dma_mmu_remap_num].size = size;
      |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
arch/arm/mm/dma-mapping.c:389:40: note: while referencing 'dma_mmu_remap'
  389 | static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;
      |                                        ^~~~~~~~~~~~~

Cc: Russell King <linux@armlinux.org.uk>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mm/dma-mapping.c | 2 ++
 arch/arm/mm/mm.h          | 4 ++++
 include/linux/cma.h       | 4 ----
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4b61541853ea..82ffac621854 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -381,6 +381,7 @@ static int __init atomic_pool_init(void)
  */
 postcore_initcall(atomic_pool_init);
 
+#ifdef CONFIG_CMA_AREAS
 struct dma_contig_early_reserve {
 	phys_addr_t base;
 	unsigned long size;
@@ -435,6 +436,7 @@ void __init dma_contiguous_remap(void)
 		iotable_init(&map, 1);
 	}
 }
+#endif
 
 static int __dma_update_pte(pte_t *pte, unsigned long addr, void *data)
 {
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index 9ff683612f2a..d7ffccb7fea7 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -88,6 +88,10 @@ extern phys_addr_t arm_lowmem_limit;
 
 void __init bootmem_init(void);
 void arm_mm_memblock_reserve(void);
+#ifdef CONFIG_CMA_AREAS
 void dma_contiguous_remap(void);
+#else
+static inline void dma_contiguous_remap(void) { }
+#endif
 
 unsigned long __clear_cr(unsigned long mask);
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 90fd742fd1ef..a6f637342740 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -12,10 +12,6 @@
  */
 #ifdef CONFIG_CMA_AREAS
 #define MAX_CMA_AREAS	(1 + CONFIG_CMA_AREAS)
-
-#else
-#define MAX_CMA_AREAS	(0)
-
 #endif
 
 #define CMA_MAX_NAME 64
-- 
2.32.0

