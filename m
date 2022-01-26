Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5592C63684
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 17:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbiAZRax (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiAZRaw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 12:30:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3058C06161C
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 09:30:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61E3CB81F83
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 17:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7884C340E9;
        Wed, 26 Jan 2022 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643218250;
        bh=/28tCtfFancm5CCSx78Aad6xerDDMgMGm3g+HUtCuTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsvhggZGrDPJhvViDZXQc5RW7Ur63e2g4/8sIHPWOeDixuKztRbv4sznJBVyIk41+
         PTRx6lIWRnxuNZByeHNAvkvk6A3tuvRaHH+C3vwp/L8zGrYD+LcBfWNbm9Rzoo+UHJ
         IqcZjpA1SiwKX0avGzI7rbw4dsl3It/o2UkWR1STBeAIZKT8kpgOJUGslhBHDq1J6q
         ZnamH56hdQxfdh7/sL8v8hz3GIeQi9w7RKNEC/izsXjrzMsy8Ex4f/J9aIVcwHc4c6
         butX3VGsAnAvqkK7MDoGimFUobGE850Oyej1Oefw0V2juAXSqNicItg9Pw8BaDiD3M
         2Vif7+oZa849Q==
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
Subject: [RFC PATCH 11/12] arm64: efi: use set_pte_at() not set_pte() in order to pass mm pointer
Date:   Wed, 26 Jan 2022 18:30:10 +0100
Message-Id: <20220126173011.3476262-12-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126173011.3476262-1-ardb@kernel.org>
References: <20220126173011.3476262-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; h=from:subject; bh=/28tCtfFancm5CCSx78Aad6xerDDMgMGm3g+HUtCuTI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh8YUhx47G2Di37HBOTdk1WIh6QmR6R0DIRCPzQe3u Y9HyTc6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYfGFIQAKCRDDTyI5ktmPJHlUC/ 9fpAGBHh3zml3pjMTEaSbLLUBTmAifHgqXDsTvzBaMFSF0AjLSXGwREtuZo/GjPv8vayjRlRH3qXYs wj3UdGjwglVOKGYXyz//a89HyX0yj4wbs6bluZzQ9lP/EGutJDydzRQw1lUBVxwN1GXBJl2JOzN3CE TYyEnmvOcFHAOo9SqMbyNaR0JpauoD9NJKPuQ1PdwVfl729t580jb50LS8vl+uVeMHZTme8Kb/IPLQ afhYrLIuHqqVqwyMMz8Xfzh1bSOQ2wpytn5fplrqMETqXtgjsPg0V5yWF3htw1lrrNHTf/1SAo5L0F EJM5xf/2icjJ15b+zUUYgsq1EnpBN992ztuWtCassP6GIjwGWPwefQgprtrBG3N9bDK29dDxhrohmo T09Ubm5WXu6Ve68zXBjeJWSWzdA6rDIyj4hl0ks3E3zZq43KCB3+fdUzipGaiw+k0ZOr+1g3uR8zrn z8NsR8XruDSBrpa3LJ+N0zOwDbpaz2B6ViCART/lXHuao=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The set_pte() helper does not carry the struct mm pointer, which makes
it difficult for the implementation to reason about the context in which
the set_pte() call is taking place. So switch to set_pte_at() instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index e1be6c429810..e3e50adfae18 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -92,7 +92,7 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 		pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
 	if (md->attribute & EFI_MEMORY_XP)
 		pte = set_pte_bit(pte, __pgprot(PTE_PXN));
-	set_pte(ptep, pte);
+	set_pte_at(&efi_mm, addr, ptep, pte);
 	return 0;
 }
 
-- 
2.30.2

