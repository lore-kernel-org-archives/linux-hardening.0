Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98034BA5A
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304142; cv=none; b=XKsqOcIq1v6dup1Z501u6RBFcRvhlnuGjr/qqziByL6Co0CpiI5SHOSpEzprRf5NhFmHAeqNTRoUuFivV7eZCpvd9tTldRPghyOj4Ih15V+70YDMg9FtbLIy6Cm2c3oUmqFF9MgsrrXSU/yDoAyLHtBE0MIxvsngiz+YUQ38Svw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304142; c=relaxed/simple;
	bh=gSm6M1lFtROo4rxGtvr0diruKjpMo8ltJrOdz1rGszA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+1hs2XbZTAaNLto3o7rBj4JMhuiTioO1caH/PiY/zfc5iIYnY+v+6hnLSMhTjEn7CBRh0nbH+Se8o3mKAv+d1pUwldwhHGn6tLLTtM+Z6pA/0D6JNDFs+J+EhJCZlUUfiGORCV2JI6r6arQk/BEIHNffJ19yYSJqSLNiy2L/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6BXshLT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6BXshLT"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488be33b7a6so70519935e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304139; x=1777908939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=prYizMoqeWKaDZjQ0nuvo6tbUP8AzcnCOIOw0eqIeeQ=;
        b=g6BXshLT6e2zss/zKKD4CjA2ISH8KIcpQJbWGgmh9g6m5VIBu7M3fG9QzYt0V46i89
         IBAIntlsiiqU+i5MEVOJJmQxM219pokgtkPkGGEA9VvIqe28hcAO/4LwI2CMjoNp6bwt
         edVBDJHIy5WO6CqlpVDzGChbspxPbh8o7Epq8J+DFTFoEcMpQp7vQMfGkmsM0FofuoVV
         wFKKNnCRIGQlgUP5aSG/RvSd5zZD53Dxq352miSXmeG/iG5LThSLKit7a2mMNXJGr9qw
         Eoq7ocvxFi9kgRMVlFtdSj37aIJshXCvodCTL/bxRvi4Llswjxzp+82YIKZNuFDpaU9E
         ssGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304139; x=1777908939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prYizMoqeWKaDZjQ0nuvo6tbUP8AzcnCOIOw0eqIeeQ=;
        b=S1p9g4T9xpcPhoxmlzr1JS0PlavEtzyz5Ks+eo8TB+02KW5Ybst8lu/Tna9SgwZyeo
         UqYX7m8VXsEtX0eXPXdvsBdX0pP2nJvd7LG0s7tORzma39aRiHR1/OBpoN84P6rODPt9
         bSxdDP/87QUB9XQYHl7asgiv6SGiuj5AZMuUHP32bOT5vG+NwbfDCJ0ImfhgqCrsSX6m
         DmMjhl2xq+t3jYteD74+3bmSKeY7ArtFZM2CeoPdtILAxLss93xAIacM79qIXr6skXrO
         Yk5gh1oq6zds0BHNZMIi9CUc+46N/jwQySSUWWzcseK7jkwARWarDVItmtsEDSN8Bm6s
         +jjw==
X-Forwarded-Encrypted: i=1; AFNElJ+07xEe9PC0Dz4332I8j4G5nZ+1cAOy97HPaq1hQLprRDDUpof6e0BJPUWniq1rRedn5ZZCL+azzGFdSc664EE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hGUXFn/T03aFBSnRwTv71AEqSt6SidZKXr7hJY1MlBVrD0X5
	MBPmJrxKfnzKSbRnjuhuuMShxnIK45jjb6mjKRWiV0RNQle2rqq7BJz2RMJSOk3E2ohrCFODBw=
	=
X-Received: from wrpx17.prod.google.com ([2002:adf:f651:0:b0:441:2eb5:f2f3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:621a:b0:48a:6268:18a9
 with SMTP id 5b1f17b1804b1-48a626818cdmr232216125e9.13.1777304138328; Mon, 27
 Apr 2026 08:35:38 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:21 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2701; i=ardb@kernel.org;
 h=from:subject; bh=aEcnYdyzs+Jl6x1LXyRc2wvdSGWl6fC+aTg1LsbHjwQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN94//XXIcrTPk7rYUCN2cm+KhM2sqjKyt3IviukIL3z
 nmlYokdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCITmhn+h+c0/z7TXLNLwT+5
 2H668O/amKwlTWfv3NYJ/6xb++rrQYb/3i4e3oYrxG//mbFf4HQ3M8eGnkiV+PfzOz49Fdq1VO4 XGwA=
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-21-ardb+git@google.com>
Subject: [PATCH v4 04/15] arm64: mm: Preserve non-contiguous descriptors when
 mapping DRAM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Instead of blindly overwriting existing live entries with the contiguous
bit cleared when mapping DRAM regions, check whether the contiguous
region in question starts with a descriptor that has the valid bit set
and the contiguous bit cleared, and in that case, leave the contiguous
bit unset on the entire region. This permits the logic of mapping the
kernel's linear alias to be simplified in a subsequent patch.

Note that not setting the contiguous bit on any of the descriptors in
the contiguous region can only result in an invalid configuration if it
was already invalid to begin with.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 4 ++++
 arch/arm64/mm/mmu.c              | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4dfa42b7d053..a1c5894332d9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -181,6 +181,10 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
  * Returns true if the pte is valid and has the contiguous bit set.
  */
 #define pte_valid_cont(pte)	(pte_valid(pte) && pte_cont(pte))
+/*
+ * Returns true if the pte is valid and has the contiguous bit cleared.
+ */
+#define pte_valid_noncont(pte)	(pte_valid(pte) && !pte_cont(pte))
 /*
  * Could the pte be present in the TLB? We must check mm_tlb_flush_pending
  * so that we don't erroneously return false for pages that have been
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 801a54ade76f..005844e521bd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -224,7 +224,8 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pte_valid_noncont(__ptep_get(ptep)))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		init_pte(ptep, addr, next, phys, __prot);
@@ -324,7 +325,8 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pte_valid_noncont(pmd_pte(READ_ONCE(*pmdp))))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		ret = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

