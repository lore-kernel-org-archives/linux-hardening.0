Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAC1C63682
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 17:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243726AbiAZRa3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242785AbiAZRa3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 12:30:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F3C06161C
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 09:30:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FED9B81AC2
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 17:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A1AC340E8;
        Wed, 26 Jan 2022 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643218225;
        bh=lOZNDQBKEdhHEAm0EEJe90CRSD2PZxxRVPzRAgeBg+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTEQY/gvBQR4fr6BJJVpEB8tMzPWpBQtKb4mJieQld7XUpKevRmjfWdpyL4JlI/tx
         ApsUi0ztFBxF4ro5UBBwUIAnRss/13D+y6fyoUs0gKFl0gpqn1NuiJ1bdioYd/od/e
         WrJ7IRlaXIVUV76sn7FBqD3A2+KDz1tXTxB6skirn7h78tPaRipCGDb0VMg6TIwlmD
         zYtDRcbp1LhFFGRYSWAn8V/P5Yt/Cz3jUXiePcPbNoufZo33LZ6M6SgE/f7FsmfYPf
         4r3BfJYVyTd4pc/y1lM5iBqkuZPmSxqNpSodsuuKTwC24BKSPZBwu0fsXGJhqZl5tJ
         hPSxT5Eb5u0bg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, linux-hardening@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 02/12] arm64: mm: add helpers to remap page tables read-only/read-write
Date:   Wed, 26 Jan 2022 18:30:01 +0100
Message-Id: <20220126173011.3476262-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126173011.3476262-1-ardb@kernel.org>
References: <20220126173011.3476262-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; h=from:subject; bh=lOZNDQBKEdhHEAm0EEJe90CRSD2PZxxRVPzRAgeBg+g=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh8YUPNZPuIBlYQ+hSRXUzLJbcL5a+cXOtRIAZKvC1 ifBWh+mJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYfGFDwAKCRDDTyI5ktmPJCe+DA CSWOra5ZYs6My7IvQBErUHdCz3EWGT1gOpzkaysGHJySx71LtDunmLFb1SCjxW6VaX0uU8A3PmfRFW dBk1cOwfRvJU/O95yC7aGxLxmiTPDP1LFlut+hHxiIjbhMiBQ/6QhfSq01iso8XQiZZQEL4dEnB8TL Gdr+CI7vbg6070ZKDhLHTBQzDMhPCd3NxtBSvWHQkEc5jhZ3B2YvC+mgAWOzUKPUHZqdbff+vQzbsm WrN3WhPbCsmYU3fTSrgUPPq1trL2ntlYDCquLp+1jfhzq/FmKNlQ8DI3wASm5QHiwmeG/6PfGJe06y 6oKj9uyngpSE4tgFuxt4pWKSPq3MBNGrPQml5D0z4M214r61m73e2nUHHqFnFS6F5PImQpq6aTqHIh 76MI51/EPW0s7bNsm2DlDwxbf7Xbc46fGBVz/awvgT+0aIxITh88AB1Bm6beTaFCjgErEuV3HEyWxW bVZveYVQ3Qw0o3N7ksmnj/ZGDU6hOzSellUrszqpJnL0s=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add a couple of helpers to remap a single page read-only or read-write
via its linear address. This will be used for mappings of page table
pages in the linear region.

Note that set_memory_ro/set_memory_rw operate on addresses in the
vmalloc space only, so they cannot be used here.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable.h |  3 +++
 arch/arm64/mm/pageattr.c         | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c4ba047a82d2..8d3806c68687 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -34,6 +34,9 @@
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 
+int set_pgtable_ro(void *addr);
+int set_pgtable_rw(void *addr);
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index a3bacd79507a..61f4aca08b95 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -153,6 +153,20 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 					__pgprot(PTE_VALID));
 }
 
+int set_pgtable_ro(void *addr)
+{
+	return __change_memory_common((u64)addr, PAGE_SIZE,
+				      __pgprot(PTE_RDONLY),
+				      __pgprot(PTE_WRITE));
+}
+
+int set_pgtable_rw(void *addr)
+{
+	return __change_memory_common((u64)addr, PAGE_SIZE,
+				      __pgprot(PTE_WRITE),
+				      __pgprot(PTE_RDONLY));
+}
+
 int set_direct_map_invalid_noflush(struct page *page)
 {
 	struct page_change_data data = {
-- 
2.30.2

