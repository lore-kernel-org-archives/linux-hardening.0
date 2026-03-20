Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94AD3B6377
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018806; cv=none; b=gBFCl2DLk9PbkORA3/bFDtsEakyGVh+VHsbef2T6zacLdtgEpvU8ZaEtgBFZHWo60A7ha/ACWG7ZqBj4iNOK2idGGBJ/kjIxxORywD0DQM+qqBlHeDvanvIK8B7o6VCAKR+g7c289lGzgF9XR8nzcwdWDoYXmV7coSsvXy75X28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018806; c=relaxed/simple;
	bh=lPdFgqEE8oXtZZQFrMk9kg0bR0AvOvClQoLr8bca0gQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KIjCWElPWj+L/vMNa21UHpP6YRFbMTI/VRNjiS7aldgsm2ANqskE4F7GcBqDRDmllXOlznUVT14m8nLneqHdo487WtAFvSpHRELX1oBlhuSJT9cJggqmwqnJA4LpIMIDSy4nBw9wP9+OxfMcfdIfCgVo2Fe66oAlpgDKM8QCstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTaW9sce; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTaW9sce"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48531e6012bso35461255e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018801; x=1774623601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=neRKNeSqpvJnLheaedaHzSD+GAHs81oovoUYepc/lXo=;
        b=nTaW9sceDNi5sBhx9ePkdCY1jF6JS3TEFAaC+gmRnb0TUKgMHg0PSh4W0a7/Bl/ctk
         ismke/OvyabB9ImX6GId6zRJpzWzttmZslnYKhV3M1a9dL07b1loas20I+34Gp4uuXwi
         Ap2VnHFTMoCIh8ACn0llXQaojVUBl4h+AZWgRREqoaXjfo2w1e40m7URxOFtpYVWPAuz
         e5reEy9MGv+bvUZUwz4zjfOwv8SC6d9gIMZTmHazQSbx7OXA4E9ZHMlfHjmxdsr3YBgg
         x01mz/gvSgsV7HT5In692s7MP8DGeG2LJJloEkK6x3ieA57TF+5B8FFYWK0K7E/UkwEp
         kXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018801; x=1774623601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neRKNeSqpvJnLheaedaHzSD+GAHs81oovoUYepc/lXo=;
        b=IU+Nda9FVHOT9xjeRjBJe+UWRvjlatktgxYaIjkjWz0bc3IPPOLL4h+9OZ1pGtes0f
         X48RRuv8JBJjEvn4I6AP56mNHQfT5biPb9tQa1uWiBsCoxSVGdW8Zbsyq2OaP3nh4SFv
         mCj/Emr2e+0GXyXfsRZqegSLSIqxBUDqM1e9cAUFV5qWOgQqJA5uoSxhEdew2bS1/LIq
         o5EOCKbDL9X0KZpzf/Mex9GuJsycGa4Vo1w2aL03iUtoYaT6DvSkhCPcZoQVJMqzh9+C
         0Ww/BMqz2YWXcj66UYrMYMSHCr4fwjeOcrIcQsLrhkAqMfZ5CFFh3I0WVt3fEXf51RFZ
         HZRw==
X-Forwarded-Encrypted: i=1; AJvYcCVoPtsIhgcfdB/B92pss4R9RpIvFvawAF278bkrq8/lZItHxgYR2k8rVZrARV8ytq7pV3cPRNyo/YH/BQTDNjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuGOWxtGZ/rPlOHPO/5GSE6wsjzZANlVTuhljb0tKGv9mAVPM5
	+qZQFR4r01FT1inPdGiRslYb2mwLZ5SqZbdOSoq9hqoo+ZHqPcD3fdG3KSy4MitRoxghyxnXQw=
	=
X-Received: from wmlf18.prod.google.com ([2002:a7b:c8d2:0:b0:483:7a98:f072])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c48f:b0:485:b6dd:5066
 with SMTP id 5b1f17b1804b1-486febb6014mr50607075e9.7.1774018800895; Fri, 20
 Mar 2026 08:00:00 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:38 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2697; i=ardb@kernel.org;
 h=from:subject; bh=TuswSFvpHM3Mr71nHK8iSkeQ2cBVxUsQsRsYd8yRYuI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwu1QGc17/9r21omerLN+XHuGaVdo3enIhfHzJrH+i
 Or3aT3YUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYi6sTIcHtC4bWNE784v+yf
 /Pguw5T9ay//LWk3CFO9K+rmvuEK60ZGhoXzPlp/tZjoyPd26e7G850npbKnlJ10WfX05sOIqul HbzIAAA==
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-18-ardb+git@google.com>
Subject: [PATCH v3 03/13] arm64: mm: Preserve non-contiguous descriptors when
 mapping DRAM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
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
index b3e58735c49b..dc007043d86b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -187,6 +187,10 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
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
index 9927b55022d8..7f7d63009440 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -230,7 +230,8 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pte_valid_noncont(__ptep_get(ptep)))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		init_pte(ptep, addr, next, phys, __prot);
@@ -330,7 +331,8 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pte_valid_noncont(pmd_pte(READ_ONCE(*pmdp))))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		ret = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
-- 
2.53.0.959.g497ff81fa9-goog

