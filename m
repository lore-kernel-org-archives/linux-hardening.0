Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1CB3C6A50
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018815; cv=none; b=Nh28+mLjazi83uhA88jHYnxzmK/Lpij/nuYulRjPHLVJ5lHUDfsCfUwzOxHR98nSTMEToGOyoYAJ/PVuEq+542KMTDo9fNkAkZi+//U23o66mAuF04MpXhSZecmXEd+/QoTp0QlRrGWpWlG0uBBPu7K3M6rxnxsXzaDs2BoEEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018815; c=relaxed/simple;
	bh=SnMvYXzc/W5zYVDsnz04o+AoFXRo83ibLCHafQE6S54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z32dTNgQ9ISUsJ1+dzcl/0p0Xm+3eYgGOYw4+UnfWGrao3mOkAfUOSG/eXQENUuKWyrTN6MFC+Yfgo39epIbq9vQL67ONjrjdPaUQXU8qmXNYzxeDhf27zEz9tSWXs7wNtJjpm3PNCOmBXMsU+cByyOYLb4W0vyUfHXF14+HsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/pSL+qB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/pSL+qB"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso18387445e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018807; x=1774623607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5AT0J1SzBmKDTRI+MPd7NHNRTY3KrP/EHQWSy92u3Y=;
        b=C/pSL+qB6v0YHTnWHntgY8IeBRuvFQ/iXQO/8RqwhYoNfQrp/Uq+bZpdXcLqE9Y+Tw
         V+CspFH2SooDdZcT1E1XmFDN4m7Adbb8tTwoPkp6G1Di1HUVoYhuc9NFkNQ/TixmCmLw
         uJ4bsQGSoggjIj6Ke5KuzKsDNfHdryi7gQJp45eBpiGoP39Iqvb8qgXy6vOpojrEZjXH
         wF+FPrbTg9W9kRi1+WLKPqe/tYp39/pIfusqVisKERFL+atUpPiHtLe+ctHVsW0iDLQU
         T6CXRPrwiPsiDKpApudDkDbwrM+Kjh2Psf0eYQqhoZj5tp0B6XT30fBhiikwbScjJzPK
         3fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018807; x=1774623607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5AT0J1SzBmKDTRI+MPd7NHNRTY3KrP/EHQWSy92u3Y=;
        b=TlKqKo8WIc1ozHB38d3D9vkWdFLB79nqQD3XczF3/bBt9aZws2w/Z8WtVOznCl54Iy
         sKCvKcyObiBuZI3P2zfA3xnUsJNH8vg4/BLZZAFKP3w4t/+JWUHBg4Cgqb7uerlJ+4V+
         b12eK8IkBrE2gSwNAnUoEeIswSU4i+uTgCvAYyTa7EbuGIiGU9YFi3z+SgJWH+7SH0+E
         XKfIXSMdv/C+zYQe6Tzy2QFa9xY+CwBHTcfQHrOrFqoEzZWNmAn2rzLgTSccipzBwpev
         Awd9aCJXqjLOt21Akuc/C9TQ8iWe8R/TtzgKkLn9u1RrZeGZwGaxEMjjH1F4HLnELpCN
         xCuw==
X-Forwarded-Encrypted: i=1; AJvYcCUlQxDmLm6k03TgW50S8oZX2eulY/wipQN3gAUmvLn+AkUSBYBXsUrZcRwTOgMnUO+u230PFPieCCmaEL+I2Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWpNoh2TkRFQqh1F+aNzjoGZq7A6lnCgPv/Qpf3Ps35fR8cSM
	T9vuQ8VmbP8JxIOty4nrguKIF7TvLu1Z06xovrVk0i4O2as+8Bcyek0+dR+IG53GQyqDpaapzQ=
	=
X-Received: from wmbhc20.prod.google.com ([2002:a05:600c:8714:b0:486:fe34:ca4f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:8401:b0:483:709e:f238
 with SMTP id 5b1f17b1804b1-486fee297demr40658355e9.29.1774018807146; Fri, 20
 Mar 2026 08:00:07 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:43 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3121; i=ardb@kernel.org;
 h=from:subject; bh=VnAD88hkLu5Up6Du4sjF1AveOX8gYjjnmNe0JbrOG+0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwqMIO70jyYE/p2/KNi920Lz0X/ugW5nOKo/Md52XA
 26Hz1vaUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZiO5WR4d+tzgX3g9Jerc87
 E3eRxd664Iji4VvFHa9cJBU57ZbkBzMyPChvTPatULg0M6nmzqWtzAf+Zx1N+sL29ENg1lJm71n 5nAA=
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-23-ardb+git@google.com>
Subject: [PATCH v3 08/13] arm64: kfence: Avoid NOMAP tricks when mapping the
 early pool
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

Now that the map_mem() routines respect existing page mappings and
contiguous granule sized blocks with the contiguous bit cleared, there
is no longer a reason to play tricks with the memblock NOMAP attribute.
Instead, the kfence pool can be allocated and mapped with page
granularity first, and this granularity will be respected when the rest
of DRAM is mapped later, even if block and contiguous mappings are
allowed for the remainder of those mappings.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 25 ++++----------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6780236b6cf8..1c434c242641 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1047,36 +1047,24 @@ static int __init parse_kfence_early_init(char *arg)
 }
 early_param("kfence.sample_interval", parse_kfence_early_init);
 
-static phys_addr_t __init arm64_kfence_alloc_pool(void)
+static void __init arm64_kfence_map_pool(void)
 {
 	phys_addr_t kfence_pool;
 
 	if (!kfence_early_init)
-		return 0;
+		return;
 
 	kfence_pool = memblock_phys_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
 	if (!kfence_pool) {
 		pr_err("failed to allocate kfence pool\n");
 		kfence_early_init = false;
-		return 0;
-	}
-
-	/* Temporarily mark as NOMAP. */
-	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
-
-	return kfence_pool;
-}
-
-static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool)
-{
-	if (!kfence_pool)
 		return;
+	}
 
 	/* KFENCE pool needs page-level mapping. */
 	__map_memblock(kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
 			pgprot_tagged(PAGE_KERNEL),
 			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
 	__kfence_pool = phys_to_virt(kfence_pool);
 }
 
@@ -1108,8 +1096,7 @@ bool arch_kfence_init_pool(void)
 }
 #else /* CONFIG_KFENCE */
 
-static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
-static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool) { }
+static inline void arm64_kfence_map_pool(void) { }
 
 #endif /* CONFIG_KFENCE */
 
@@ -1119,7 +1106,6 @@ static void __init map_mem(void)
 	phys_addr_t kernel_start = __pa_symbol(_text);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
 	phys_addr_t start, end;
-	phys_addr_t early_kfence_pool;
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
 
@@ -1136,7 +1122,7 @@ static void __init map_mem(void)
 	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end) &&
 		     pgd_index(_PAGE_OFFSET(VA_BITS_MIN)) != PTRS_PER_PGD - 1);
 
-	early_kfence_pool = arm64_kfence_alloc_pool();
+	arm64_kfence_map_pool();
 
 	linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map();
 
@@ -1174,7 +1160,6 @@ static void __init map_mem(void)
 	 */
 	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-	arm64_kfence_map_pool(early_kfence_pool);
 }
 
 void mark_rodata_ro(void)
-- 
2.53.0.959.g497ff81fa9-goog

