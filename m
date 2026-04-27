Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDC3C198D
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304146; cv=none; b=fDav147JwdHg82qUucBQZcVj0PDAD9D1APIvCLTcDJPAMgNjIL/s19O/1iafeHayQrs37pjUN+q/3ioY8MBzQy+5uIlSCOejJmTWhcterSDk8j7W+pffQmp3jYT+Rg7prDGBz8L4JQMlLlwU5vKykdVfd/jVK29Ysyn6ioy2APg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304146; c=relaxed/simple;
	bh=XQTAyphR1+vWloMkYQ0Xfuz2LlYAScTF25LGihxHCes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rj2SOxioTwplJfKtweq66B8+wokF1tIPRytuu2J8F+WUsT4UZTM9cluwJQ7PuaIkbkiRiPRvvhw/AvWzBVmhhc7cuCpc3GZh8ueT+HpcIfGb7UUabbo972K4j771jEBegavpQqGWWNAN6GgxVti1KlRMbdR3cgZd4IS+yoOuGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bH+cgSn9; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bH+cgSn9"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488c2cc0cbaso76149335e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304143; x=1777908943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRW0Zv+9eSRHC2Z8bSw9fwUsmK+GqZsuc2Bm/mr5lio=;
        b=bH+cgSn9XqmZ2RJjPxrk1VL3v4kg+eNBH+J7fQsb5GvUfqCzcqAB1mTR+WN3TZsHLq
         h6aH92Ufh/x8nwiGW4iPO5mvpPrw+F9+Dt1cBYLfg5ofIypXT3bRMWxLzuGFEbRvap4N
         6Q77+M2YlgS+U723/3wVb3Au66c5p2HpoY4yCsWGL0nVbBOvKqR4upwK3hoc2f+qu96L
         729tNxWJUFQeAORavPjM8bepZXYcGUXOq6IJM1ik/90SQLc+Xcy3a4OB8hZIX9no8UP4
         1batBezw9q/fl/YdxretNp9X4Smi9Fy9GXAqPP1xHjP7mkk4eyNhzmLTBKSMvni5qnHY
         UzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304143; x=1777908943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRW0Zv+9eSRHC2Z8bSw9fwUsmK+GqZsuc2Bm/mr5lio=;
        b=OmPhk+jeSF4BRS0/8yD1+aZAmIzOPu6D0OoCMvsDXV3fatlBQwzAWkhkouD3l6DbYk
         cl6Vhw+3rlfr5EANURZj6VElWABAz2AVfLl1jK+dCtybhu/Y0JuV53K7whtJtN3QpO4I
         a8akNUis3L16bZ50L2w2+esohQuvkIt0VVtge1oUPoegzQ4RhtP0R6uLUmR/gA1WFB0u
         7rtkeEPEUxvUjanWscafNuw5VmfE9rLiCD7eGsxZ43/7ABd2DhsBaHegYT1yCK4kcH5U
         R2wjsxj8kPg4mFs/wr0EwDhimQF7OPBKGzsdNykthw8XxNhcGkjPTL6BLlrhckaUZRVH
         zO1g==
X-Forwarded-Encrypted: i=1; AFNElJ84ZmwvkAaf9FDTIdkRcgjc7eWpYZGx0Ame/p3EYg20m2nv4dfK/om/5pq3ifx1bNJ3yslN6L/fE0X4TPEKxv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGgIUUJnLamnAWD2mAyVC1L7rlg8xXmP7enOL4Vk7xe/bEkn5
	5/vX3ONRbZh4PIZ3chdQhFxZ5trxJ98RdpjFdB47O+UCdkbqCysEjbDkLBltOPPtBCVeNX7R+w=
	=
X-Received: from wmi26.prod.google.com ([2002:a05:600c:21a:b0:48a:591a:7a7f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6085:b0:488:936a:6220
 with SMTP id 5b1f17b1804b1-488fb782618mr560638815e9.21.1777304142771; Mon, 27
 Apr 2026 08:35:42 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:25 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3127; i=ardb@kernel.org;
 h=from:subject; bh=j6jBQGBWye927YKYtEIXGLmbEkQZrSxTUWO+ZEqsDOA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E6tZbZSRzXSOd4Kz7RcrfTl71zvelVlQ7kjb6c7+6
 +/LvbZ3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImcesvIMHmRmfnsqu7t5Yc4
 f/yT6uhbkVjgOtPMoPXVglXVv166rmL4H7fu82/15c+rukSuf9ApCKp0mWdk7517vtF+nva/d2u e8gAA
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-25-ardb+git@google.com>
Subject: [PATCH v4 08/15] arm64: kfence: Avoid NOMAP tricks when mapping the
 early pool
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
index bfb2f1cae724..4eab40f4aa6f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1067,36 +1067,24 @@ static int __init parse_kfence_early_init(char *arg)
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
 
@@ -1128,8 +1116,7 @@ bool arch_kfence_init_pool(void)
 }
 #else /* CONFIG_KFENCE */
 
-static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
-static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool) { }
+static inline void arm64_kfence_map_pool(void) { }
 
 #endif /* CONFIG_KFENCE */
 
@@ -1139,7 +1126,6 @@ static void __init map_mem(void)
 	phys_addr_t kernel_start = __pa_symbol(_text);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
 	phys_addr_t start, end;
-	phys_addr_t early_kfence_pool;
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
 
@@ -1156,7 +1142,7 @@ static void __init map_mem(void)
 	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end) &&
 		     pgd_index(_PAGE_OFFSET(VA_BITS_MIN)) != PTRS_PER_PGD - 1);
 
-	early_kfence_pool = arm64_kfence_alloc_pool();
+	arm64_kfence_map_pool();
 
 	linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map();
 
@@ -1194,7 +1180,6 @@ static void __init map_mem(void)
 	 */
 	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-	arm64_kfence_map_pool(early_kfence_pool);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

