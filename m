Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F163CC04AA5
	for <linux-hardening@archiver.kernel.org>; Thu, 25 Aug 2022 12:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiHYMXx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 25 Aug 2022 08:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiHYMXn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 25 Aug 2022 08:23:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF44B2499;
        Thu, 25 Aug 2022 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BxirfEn+QcUwavDcraOgbLlumolE3pLU0QKIe+UOp0o=; b=nAq9Kch4yjPq6ihV3Vvc2DMCg2
        mDOYv/5zvUPmAa26HMCwIFD8JqRYeXpYIZbUr5BeGMaibGvlEK4LEyRhv/3O53qcRQg1mdGLsSb32
        OgkAGv6j2yyTEqjiazVloXBs/K4PuWDtn02kyR8B3vi0KGaFGFtal3J5rbo5bg+ESXwqOfcy9psAp
        LX2E+SQT3r4uBfqr7F3ab61faSIRpa9/drCahuldRgJqWaMkIZOmrRf13qb3mYD3hsU/Gk2jJirU3
        iMRsRz7/L0oWm9y72QTmlnvfNlVpPgK/weXjeoappO4P9AvxKZQ4qBx+xbpaLDW/00rOW7vFPuyGA
        EnbfQ88A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRBtV-00HF0P-0T; Thu, 25 Aug 2022 12:23:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B4C298014D; Thu, 25 Aug 2022 14:23:31 +0200 (CEST)
Date:   Thu, 25 Aug 2022 14:23:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        keescook@chromium.org
Subject: [PATCH] x86/mm: Refuse W^X violations
Message-ID: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


x86 has STRICT_*_RWX, but not even a warning when someone violates it.

Add this warning and fully refuse the transition.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1abd5438f126..9e9bef3f36b3 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -579,6 +579,30 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 	return __pgprot(pgprot_val(prot) & ~forbidden);
 }
 
+/*
+ * Validate and enforce strict W^X semantics.
+ */
+static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
+				  unsigned long pfn, unsigned long npg)
+{
+	unsigned long end;
+
+	if (!((pgprot_val(old) ^ pgprot_val(new)) & (_PAGE_RW | _PAGE_NX)))
+		return new;
+
+	if ((pgprot_val(new) & (_PAGE_RW | _PAGE_NX)) != _PAGE_RW)
+		return new;
+
+	end = start + npg * PAGE_SIZE - 1;
+	WARN(1, "CPA refuse W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",
+	     (unsigned long long)pgprot_val(old),
+	     (unsigned long long)pgprot_val(new),
+	     start, end, pfn);
+
+	/* refuse the transition into WX */
+	return old;
+}
+
 /*
  * Lookup the page table entry for a virtual address in a specific pgd.
  * Return a pointer to the entry and the level of the mapping.
@@ -885,6 +909,8 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
 				      psize, CPA_DETECT);
 
+	new_prot = verify_rwx(old_prot, new_prot, lpaddr, old_pfn, numpages);
+
 	/*
 	 * If there is a conflict, split the large page.
 	 *
@@ -1525,6 +1551,7 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 
 	if (level == PG_LEVEL_4K) {
 		pte_t new_pte;
+		pgprot_t old_prot = pte_pgprot(old_pte);
 		pgprot_t new_prot = pte_pgprot(old_pte);
 		unsigned long pfn = pte_pfn(old_pte);
 
@@ -1536,6 +1563,8 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		new_prot = static_protections(new_prot, address, pfn, 1, 0,
 					      CPA_PROTECT);
 
+		new_prot = verify_rwx(old_prot, new_prot, address, pfn, 1);
+
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 
 		/*
