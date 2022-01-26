Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C64C63682
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 17:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiAZRa4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiAZRaz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 12:30:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF66C06161C
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 09:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3695CB81F84
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 17:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AECC340E8;
        Wed, 26 Jan 2022 17:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643218252;
        bh=DsaWgn2b5/uiNugxCw2SLmR1/vGVjh0Ss2yA9R9s1LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dGb3RS7OkfD5pyOERSPYQyIB/zbpDxa79Y4qflpJQCQR7cp/gUlVUAWi9OCcLody4
         FuJ0zdG3rgIonSxsChrnLiaTQe+wLI2F7XNoMSp6OZ599qyuwChe/c4cEgC4oPJ53I
         Lh1YxpmYcP42bcZhzyoPSk0WGIVARAV0zgCk1GZKY1IWLQu6GCsSQGeS2kgWinvfjR
         SReLjmfb1GwpDjCE9nm8sWJ82Y7JKiF40e4ZrwYGx5SeNU64ATl0VnqI6sjxZ037uA
         ZoSWcwmLqY+NwhY6GPCiSOTcMBM4J32pAGycDHAJjW6EwBN+WbRtsbNc7hFbOD5lEy
         KiZlcdaQ8wagQ==
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
Subject: [RFC PATCH 12/12] arm64: hugetlb: use set_pte_at() not set_pte() to provide mm pointer
Date:   Wed, 26 Jan 2022 18:30:11 +0100
Message-Id: <20220126173011.3476262-13-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126173011.3476262-1-ardb@kernel.org>
References: <20220126173011.3476262-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=828; h=from:subject; bh=DsaWgn2b5/uiNugxCw2SLmR1/vGVjh0Ss2yA9R9s1LM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh8YUiX6nCobhdCM2xfJOu55QOHjqiXQBuGJOyXzVu UUxMSROJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYfGFIgAKCRDDTyI5ktmPJI1zDA CIsdV7m7gTzi2Wdm+kuwbE5P5R5tZ5RUHTok8VsHS0rmypOJ6Xz3Etk0/Fhfbw8fgmLAWy5VQ5nMph HvC+702UWf52zA74CQDMx77//bxRlGTt7kXfuxuxhW+4fAxhgFQSt+jv1E0E7J2Hpu9WRc+AAFPJ6c qbvLVOHnUTRthZHOzxlB7Bl0e8DVqU4cXbcuOa4TSCgcWxJiVg1BdXL8eThwxGF7fy7GOGz4o3fOpr MlTyf8/N6yfluh0Al1EzanO7c/5GZFfBrKjxq85b/jCHCYVwlXs/EXx3aViHmPp8etJ+ndyPyTUDIy IpvwoOHqv+yRee0RyqS8Z9dOpa6PpMs8N2pAeSH0NLPu7J6aG5H4oq86nGzlYaT6GNHDY2xIM7+JsC mZ6RnecKTD8V1mu/KIHxwA7wO/n3kxzQlpHuWJlpQcj3C17mPw8RpVKBeTmonGsNb6mxsqNIEzHAh+ h0uQMBh7mPmfAUuujd8OCDIKYE1H1YJCa0LanJ7bkKb60=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Switch to set_pte_at() so we can provide the mm pointer to the code that
performs the page table update.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index ffb9c229610a..099b28b00f4c 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -252,8 +252,8 @@ void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 
 	ncontig = num_contig_ptes(sz, &pgsize);
 
-	for (i = 0; i < ncontig; i++, ptep++)
-		set_pte(ptep, pte);
+	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
+		set_pte_at(mm, addr, ptep, pte);
 }
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
-- 
2.30.2

