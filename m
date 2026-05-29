Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B13F44F6
	for <linux-hardening@vger.kernel.org>; Fri, 29 May 2026 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066946; cv=none; b=jMV/5BZgkBgljtKQienU9udk2rmCQofEsny1JU6TtdF+B7v5k3kIJN4iWjARaCqWxJVPuvAPP48Fio7eBk0d3QExYwKsQsqhyyEzdvXYLyytkGSMdU1chwnv8G6Ox7JSMgRZBjwV/0kdORzXIr2kUIR4dQsaYPtL9rR7c9mTkLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066946; c=relaxed/simple;
	bh=mefb2BUpeFYk0zitvgHd6k235xD5JCNkHqkPJ1oqbQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nl0JnC91yU5UUqyY/f6UOMflDDwIxgjKRnLUw16SfUyz22YPXaHZLZXTfKN/XWgZIlMrjlNMMSX1OiRjLA8rwDu+6HU7BcbD2B7N68HE6DXattJHOyumQI797sj11dQbzl6Zeb8S2D8lVJ/F0heFCC6pASVDI3iRJq+xmkWvj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2Q3Eg4K; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2Q3Eg4K"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4909e55c480so9133175e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 29 May 2026 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066943; x=1780671743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwwWx+36ZO5AyFG8PbXK1ZtkzsCWR7UH7LxbrRw2oLU=;
        b=q2Q3Eg4KOZRi4Mp+FIJLB+bqZ14qM0lFu9GH+AkydSRmfG0r7mSIxAW/C7gyTtpJQG
         yojp8GJRX0S2GsbY7n3x2HeLY72jeSPCSd0ht0KVs1p5FBm90QnrLv9vmkYGZJ9x7ip3
         5A0jpBkr6SjoUQifiyB08lQHkudgEkfTyDC+enAIDhyOJN9hCJX2ZRu6UK9/4WCO8bEt
         23xtMp/xojDyATJeZPEpOwbUItMrddVhGGMks1VulfsYO4cfW9/XcLK07vhDLN4Y7CWI
         9soqnIjQjOhQwqdA8GbqVf9exT9Rn4o1Xy5HEA/DyOCWtQ0D4sg3h33OCOVU10urQG2N
         nfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066943; x=1780671743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwwWx+36ZO5AyFG8PbXK1ZtkzsCWR7UH7LxbrRw2oLU=;
        b=OzlUcYJL9lVZZjipmLsdSMGJ/qxaqKLpnc39BHm2x0IlKUHn1m2rlsytkAO6xYY2J1
         Q6mFg9caifANGiZfhKKO1WjpbATlZy9ZdbnGRp0cmqlC3L7ZOwtGbLQa5XSPqV/X6G2Z
         k4qdklvRdjZHYsS1Q66vleJO4PMYZKaYCtkq1jycFk2cNgag5UEJp/7OICOD6l4ir/f1
         yYt3kjH7c/KUBGsJAGFntculkudqe2nyb2UNJBIlqOeQ5X3L+Oa0JN9MXSTLqrJTy9ZK
         UzlYXcoj5F+cgi8j9XRUYV/OX3Q2WmWMbOQYDn1mDDVLY6cQ3GiupoH9t+aA6PI/obnd
         73sA==
X-Forwarded-Encrypted: i=1; AFNElJ/uBp4FS3Nl5jEUHc0EqBVrTG2Rt0DUZ2+Qc8wnL1niCUj9f7CcfYHL5j1c4XeH6a3hZ2z8DQUdgPqZ87AtNvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwckIvaGxq8EI4UnRdCByRje90iz4rGi8n2N1L+DKK2cILlXp5f
	jQJaC6Px7HFxxnz7VL1TqR+I+WvrvPqO6KY8PlYgeQ7M2rOPBQTxVYoj2CbMGY7G7pwr5UIaLg=
	=
X-Received: from wmbiv7.prod.google.com ([2002:a05:600c:5487:b0:48f:de29:3f52])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:2313:b0:490:6237:5213
 with SMTP id 5b1f17b1804b1-4909c0af69cmr42420765e9.23.1780066943345; Fri, 29
 May 2026 08:02:23 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:56 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3700; i=ardb@kernel.org;
 h=from:subject; bh=JEV2e9VnURwytUBvbY/jPf+EEXewGZ41iq/e9jE9rQo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVap1rG3Fm6CS7u4UZS4lT7Z9HxxXNudcEuL6naq74
 afp7KCOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGPCgx/uKQ8e8xyJPt5JLP2
 bi5SltRnOvLycG3KFEeBXT7tu08rMTKsXffM79eljW7bhWbvntV0WFru9cWYiprdF6/MlLIvbk5 kAAA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-22-ardb+git@google.com>
Subject: [PATCH v7 05/15] arm64: mm: Preserve non-contiguous descriptors when
 mapping DRAM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Instead of blindly overwriting existing live entries regardless of the
value of their contiguous bit when mapping DRAM regions at
contiguous-hint granularity, check whether the contiguous region in
question contains any valid descriptors that have the contiguous bit
cleared, and in that case, leave the contiguous bit unset on the entire
region. This permits the logic of mapping the kernel's linear alias to
be simplified in a subsequent patch.

Note that this can only result in a misprogrammed contiguous bit (as per
ARM ARM RNGLXZ) if the region in question already contains a mix of
valid contiguous and valid non-contiguous descriptors, in which case it
was already misprogrammed to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable.h |  4 ++++
 arch/arm64/mm/mmu.c              | 22 ++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

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
index 5c827fa3cd38..6b42d724bd1b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -187,6 +187,14 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
 }
 
+static bool pte_range_has_valid_noncont(pte_t *ptep)
+{
+	for (int i = 0; i < CONT_PTES; i++)
+		if (pte_valid_noncont(__ptep_get(&ptep[i])))
+			return true;
+	return false;
+}
+
 static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 			       unsigned long end, phys_addr_t phys,
 			       pgprot_t prot,
@@ -224,7 +232,8 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pte_range_has_valid_noncont(ptep))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		init_pte(ptep, addr, next, phys, __prot);
@@ -283,6 +292,14 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	return 0;
 }
 
+static bool pmd_range_has_valid_noncont(pmd_t *pmdp)
+{
+	for (int i = 0; i < CONT_PMDS; i++)
+		if (pte_valid_noncont(pmd_pte(READ_ONCE(pmdp[i]))))
+			return true;
+	return false;
+}
+
 static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 			       unsigned long end, phys_addr_t phys,
 			       pgprot_t prot,
@@ -324,7 +341,8 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pmd_range_has_valid_noncont(pmdp))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		ret = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
-- 
2.54.0.823.g6e5bcc1fc9-goog

