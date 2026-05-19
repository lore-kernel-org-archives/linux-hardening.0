Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4184431D362
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203912; cv=none; b=qg67+CqgwmQ0oWlmF/rhnOnuiG7XEq7VO1f9gkiEO1XqhReahFU2KU61Gffo9rKa6UyucUgyxIkzNv3ta2rKikcMGdnLnKgbfCiPC+5jiUJ+YSUG65/7mR8PiunIgvxdRQLfG4ApzLpXqaSbXAaT4rfeFyi8rvVkVqwyt2wz9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203912; c=relaxed/simple;
	bh=cV4GnrxgpfSiRWGIE0KjY9GsjzBjpUWNYquDFvlGNqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y70aBVKnSjH1MfYAzPTZI134JtdZDpiXgGEpvVl16bzo5RCQjMqLrgxfauWzlqBJqfQxfhr7VI2uxjGlrCTvXfpXn26GBSK/G8w17X+uq82xRCvaTwK0yxfXBH5r06Ax2x+WN9on5iW6bEmZzPoloP+yb7NpTY3SlAT0Q7JIJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITMgyJgb; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITMgyJgb"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d789cebcfso3163143f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203902; x=1779808702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CS1BtfvkhqK/WG7QMDSO/xvMHjZnFGS59EcNSZDS0Dk=;
        b=ITMgyJgbSlBpSJSEgDuMGfqt0pAv1dtNtPpnPeNI4eD1BRhO8Pjf7FDLS+VWtXiWBY
         CvrPRFL6p29+sxzJ0C3n0HJ8BdVIaTGKYV+cRB8jdGMVrSiTgQjXrfhSYO+WRq1KIGN+
         LvgBYLgztb+h7TWTdoePdGw6sAOXwaFf7nPRr/UHQlAOsg/JFUsEZmZN7D39Mh/sTNBm
         iTeHlIRzu5ohiv1sMCss999G/sXTfwab9Sep3wuf4uGLmzc6daVKyU/pEPzLApUyfahZ
         Kr5yC8ZxfSIt0oHFWh8Ad5YJRpP4hA7mB5hqRiLSceaOZAlsBbxEvge4516ohzpYjbcg
         zjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203902; x=1779808702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CS1BtfvkhqK/WG7QMDSO/xvMHjZnFGS59EcNSZDS0Dk=;
        b=nHE8zj/jlCY7BHj+CUkXb7n9CECRWrlUMSKAbePmjRESva4tlfXGICtxnDiQq7Jiml
         PRr3xwdhn1tRh3WPwOS+zi8nePAKCNmtA0y9N7eqiN+pBDKUUJX4O0lp/0RLtVMzBsT3
         rGkFdcVr6L+TZfLHwtDPCByjCux8D1dtgvR93/fZomFkr9EOCIIHI1JrOmGhu46KY15N
         OSBNUA+o6+x7W20/xQb2XNFcFaebsLQpSM/KoK/qSZFUuhSjdbJlpFOi56168kV4imkD
         qcZABOcSH/n3zNrkZo2bWZD9lfzi7XbF27yiUjMVHTev7E1yTfDAg/cT5Earnenv4X2z
         eHFA==
X-Forwarded-Encrypted: i=1; AFNElJ9ylUxP0L3zLlerTKIfjCC0H5DPBEAmCAESJhbJ5l0G2hmGedQpIhoVk4jFi5FN1ufpPkJ5S/99vmFC62Z/oTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDjrQIX0mNkv1WlY4V+HIHwnXbOGQ5SMgU6PM8mbE73f+cMKv
	PYNLhdZjH4lULlw0B1PHnDrY76i1TKbo5K68pQVd6y1hRIJSQiz7O6pk7QIJUewPWggKeBM5pQ=
	=
X-Received: from wrbhg12.prod.google.com ([2002:a05:6000:1e4c:b0:43d:7480:5bfc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2885:b0:44b:5a37:36c4
 with SMTP id ffacd0b85a97d-45d941b198fmr40017031f8f.26.1779203900883; Tue, 19
 May 2026 08:18:20 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:21 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2697; i=ardb@kernel.org;
 h=from:subject; bh=suqWUpRPoN3mdRoFNlLmQlr8b1d/8QdQDtjxwFffruk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7vhPi2CHG4Vsp5Yef6FSIcbLk+jJoX4rguX5KsV15
 tJ3GHk7SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERu5DMy9C7UkCzh3eQ0N8Zg
 EeM83iu5V5tysvp+HHm5smhdUXqWOyPD3pP9D/9fkf3xM3Jr+f7UbV8D2Y/5b+u9ur+madPEK3o nOQE=
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-19-ardb+git@google.com>
Subject: [PATCH v5 04/13] arm64: mm: Preserve non-contiguous descriptors when
 mapping DRAM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
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
index bd2764f02a7d..4c6ef0d35714 100644
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
2.54.0.563.g4f69b47b94-goog

