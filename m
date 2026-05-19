Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F894028E5
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203920; cv=none; b=JlmNdZ0H7vAtTkrMxwKQA8mhDT2ccKSL9SzueKACwRPIWMVSStAa/+hdYpV1RMmDb+B7nEAR1cd8UdM72JI8a4vCHpoezkt5xGBnBEGUCyCcZ92eeA222/seAuT/5Cnf8bL6Pdc5C205N045F+iJLWmGHjqVYjzsAYT0ORjo/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203920; c=relaxed/simple;
	bh=knC4g4vfRe0gTn61rwNTsW2MQUnpP1477OnZ0UpSvpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jaEYp7FUTANaLawiXZOUQThSrA6Amnuh6Gbit2o3ufzx+ahd8RA/LL0J1rDKhI4oYAWOz6+90luLxymDSfI1iVB1tjPKlrzC66TGlsZXFlwWlef+HECnVdth1pcSSChCjgSn9nIWWqFTmI6kGJaeYfxURNeLhUwVreHZ2/W0WiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yee5kq+f; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yee5kq+f"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fde68e420so34484915e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203915; x=1779808715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PfDfE++F3RWl/ExerU/oKoiEmKgLmIzVBxPm6lUCPRg=;
        b=Yee5kq+fyuPy/JOkDb/Ro2TGYCcxzoU+gG2ixU+UKP1H4G10IUwnjRa1A+F3RwG70z
         IufiAZREfsVRV9idiGuG9TX1+kSnMrpVBiBbFK0X/vP5dyb2sxWl80Ny1wuwKkQKuRIA
         QyQzMOrgbC1j4o7Kak/XcisxOh4wdLZCVm9yrXWy6AzvvoZPVpkI7ZYDMVKNZC6uGv2C
         mibofyfPAUp+VeBoqjEbERuH9uggrB9LGoO2TCkY+l8HyYm2eRIiWMMkMjqeyFie7x01
         LK4u6IR0ZJCVESjEFD/Gco9DNUZFpIyYlekVRmGlYyTXya1xFbyl8X5iCACJMtlLnEtL
         1srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203915; x=1779808715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfDfE++F3RWl/ExerU/oKoiEmKgLmIzVBxPm6lUCPRg=;
        b=pe8GEIT2zLvLc3AFZ97wvT/qcx5NQMS05hWSM8bmSupntvhkoEroAXxCyhpN2vz+9z
         M9IY+zkzy1DttmGsbFRksozntF/FTWwBqxNgranu7IBb5ROlMTBpJJnsJGRfHFONFJ09
         tRmvnS6CfCogQwZvN5cwkQDsgpewIKynrrcFxHE7lwXLqBxVt29L6lTUu+CgTd8eb94M
         6in0KQcxW2n5d7YG9iz7YwDj3434CA+ZL/VOCKFZUOi7adts3rlmYhL6ui7Cu1AfTKnc
         ynGyB1VPeIn2Z4U6nx/tnQtVimMpSYi/EtmH9q/wVgVW8+9FFyf6WUzkoME8L3w1NGv9
         h48A==
X-Forwarded-Encrypted: i=1; AFNElJ+xprlKHAThFgTAjCNOhzuyo1yv60JMEMD5LV5OZg1cHL8avUrz7whymGZtH24OKAgo3XTwlDVSYbPLSKSJxl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PTHNc81/wjp+vVNmTK0uZajFVwc7kas6bgHW03441bEfNOH+
	ri0NW+i/+i2+xh0r6QmDMpGkSgMHIXxdBYMCnwWffkec6bM1/WOXjFC5ESBeBl4fv9VpG/vgSQ=
	=
X-Received: from wmba2.prod.google.com ([2002:a05:600c:6dc2:b0:48a:5c24:d305])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:34d3:b0:48e:6db3:ff3a
 with SMTP id 5b1f17b1804b1-48fe63270fdmr290761875e9.16.1779203914736; Tue, 19
 May 2026 08:18:34 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:25 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3142; i=ardb@kernel.org;
 h=from:subject; bh=oIF//MguREFG3HyKwOy+szVys8PN/RKtASFWmsHeRws=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7qyjai6rA2NnuvzBPcb5HcUWrJeV8kP0p63Z/GDyg
 rrEP3UdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIftBkZnt9bsqtX63WH7NG/
 r+plOE+Kat8O/Px/l8Tn0Pv1vFYc/xkZlu6eNVN6it3sFw7TGMSfrdvezmPDmlIWMfNT3b8Tb5/ UMwEA
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-23-ardb+git@google.com>
Subject: [PATCH v5 08/13] arm64: kfence: Avoid NOMAP tricks when mapping the
 early pool
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
index 7cecd25aa83b..224fec6ce9d7 100644
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
 
@@ -1195,7 +1181,6 @@ static void __init map_mem(void)
 	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
 		       NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-	arm64_kfence_map_pool(early_kfence_pool);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.563.g4f69b47b94-goog

