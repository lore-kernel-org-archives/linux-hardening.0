Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED449349AEA
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304143; cv=none; b=gx19s8RRsC3jTU9S4icqZUBlYAmOUFi3U17DdqG91RwTx+VEMZYkBOdmkVesoFWWEx9lOaKple9rGzNGIrcAM5Gxr3w9oUYel126SpWGVAjS14jaR4rlxKA/nVv+v4CK5uZh1tp7bNy6dvFW0bK73AUPHtVJXeHCgnpSA0IFrpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304143; c=relaxed/simple;
	bh=YSn5OY2igzYqsigHvr+U2TYxlmwUZPpRqN93TFEfT3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZFEQYEd/oc2VTShzizfUp3fJTDM2Rzp7ChWZuveDOkrUvxSXKIEP19j+gRLykps4pVj6EvWfmmmOof2aqBNN3h8CzY+Rq1jfY0zDcwJcX0x1G6vk/Axf0g+rCAwtc5giGn+W5hSRqyge3osr6Qif97k9KrR7gllcqpp4sDiJeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJrczqzr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJrczqzr"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so111412765e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304140; x=1777908940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPGO5NkKZbwBF89donUpo2WBB4phkcPD6/ayIGThuKs=;
        b=KJrczqzrhwUrQT/5+h4Qi/Oj0GPy8e4BraXIOjUU5gt9KccJTeuj/6NDpicmEKO6xp
         5Uw1h/Fg+F2KqSXl0FoB8OuQ/moqklegdKv+Z7klBdvKDIhlCf2J9lhOyjJt1triMblG
         6aFpsvminyb1n7bMlLMdU0OBemsXEgma3E3K6LaKwDcOrz3zOx8EKcxONA2xoHjjmrFW
         82Wh6wjMhU9YMLMz3uU7KYvf6VHWlSwsD1i/A6s2Fdygoc602JLNfHXM8QBGxbz/iyux
         IFH2f01+cbZiLXw8quMCUwCuCfzJDYp8A810b4Lqwc+rynM++0QO1mD81iUG3Q3TYVTI
         iHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304140; x=1777908940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPGO5NkKZbwBF89donUpo2WBB4phkcPD6/ayIGThuKs=;
        b=CPrp16fmxta1Req8BNEhOflBznuLqAVZXocUEExO2laDiJQP2buXboq8fq34+SWaOQ
         96PO7s3dCwqTYm78aOQ02a28hT+70y3v4Nr9/ELeV+KrN5OL+26M7mKtJIwRaj8O8JHe
         a2XRHxX8I34529iMDq0iw2NayjAsHKCLez9OH6lGTYVJ9NWGLhby0OhmcG2kKkuebq6K
         WAF4c8JGbf4pb9F+tQ+zfw2XIRZ8W/UabgTcUxPFM7I2whU/gONtVxx2CfJKh2rrAmT5
         kWuMI7myzXKJ0j64d9AgdgiCFVrX208hYW6fKLcA4S5oeR0nRBnhB2toWpD6hTEGvf+f
         wmgA==
X-Forwarded-Encrypted: i=1; AFNElJ8Emi+gpJSxYBD064b6ASvPKhFIEYmkbIiO5wruGPWwHpbhQPpp513Ipl6lcFR5jdesAL2sE5/KXxHtrSMH010=@vger.kernel.org
X-Gm-Message-State: AOJu0YypyFrb3Hg3qVF9Mm4qO18pllyDVJ96ja/0kIhApAPthiqjPi/+
	oFYt2llXx2YKoJFx1IzLU7PknYMyKO4TKtnEHstIaVYiBhHqWF+l3TYZuO8Gs/E37XwGM6f2TA=
	=
X-Received: from wmbjs21.prod.google.com ([2002:a05:600c:5655:b0:489:690:d5dd])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c04a:b0:487:12c:e7e1
 with SMTP id 5b1f17b1804b1-488fb750840mr434963185e9.11.1777304140187; Mon, 27
 Apr 2026 08:35:40 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:23 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3391; i=ardb@kernel.org;
 h=from:subject; bh=I2DZ4/UqDVyZEyJTtirGLkm2tY5dVwLgkN0d0TthFiQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E5Oz4cnQFbZz/ubvO6+x9N2e9y2fv818/K0644BF2
 uqMO09WdZSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJfP3FyNCv9vzcT50tV2ab
 tKs6rdmtmP+ZSdS8q2CHk5bVhmD/I6sZGe6dv55h+qD/YWdJV464V9y9yPhfLStb8rbUHZdcsCT 6KCcA
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-23-ardb+git@google.com>
Subject: [PATCH v4 06/15] arm64: mm: Drop redundant pgd_t* argument from map_mem()
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

__map_memblock() and map_mem() always operate on swapper_pg_dir, so
there is no need to pass around a pgd_t pointer between them.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 25 ++++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index bfbf3fe0d1be..9610dd2d7bd9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1039,11 +1039,11 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 	flush_tlb_kernel_range(virt, virt + size);
 }
 
-static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
-				  phys_addr_t end, pgprot_t prot, int flags)
+static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
+				  pgprot_t prot, int flags)
 {
-	early_create_pgd_mapping(pgdp, start, __phys_to_virt(start), end - start,
-				 prot, early_pgtable_alloc, flags);
+	early_create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
+				 end - start, prot, early_pgtable_alloc, flags);
 }
 
 void __init mark_linear_text_alias_ro(void)
@@ -1091,13 +1091,13 @@ static phys_addr_t __init arm64_kfence_alloc_pool(void)
 	return kfence_pool;
 }
 
-static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp)
+static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool)
 {
 	if (!kfence_pool)
 		return;
 
 	/* KFENCE pool needs page-level mapping. */
-	__map_memblock(pgdp, kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
+	__map_memblock(kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
 			pgprot_tagged(PAGE_KERNEL),
 			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
@@ -1133,11 +1133,11 @@ bool arch_kfence_init_pool(void)
 #else /* CONFIG_KFENCE */
 
 static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
-static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) { }
+static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool) { }
 
 #endif /* CONFIG_KFENCE */
 
-static void __init map_mem(pgd_t *pgdp)
+static void __init map_mem(void)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
 	phys_addr_t kernel_start = __pa_symbol(_text);
@@ -1182,7 +1182,7 @@ static void __init map_mem(pgd_t *pgdp)
 		 * if MTE is present. Otherwise, it has the same attributes as
 		 * PAGE_KERNEL.
 		 */
-		__map_memblock(pgdp, start, end, pgprot_tagged(PAGE_KERNEL),
+		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
 
@@ -1196,10 +1196,9 @@ static void __init map_mem(pgd_t *pgdp)
 	 * Note that contiguous mappings cannot be remapped in this way,
 	 * so we should avoid them here.
 	 */
-	__map_memblock(pgdp, kernel_start, kernel_end,
-		       PAGE_KERNEL, NO_CONT_MAPPINGS);
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-	arm64_kfence_map_pool(early_kfence_pool, pgdp);
+	arm64_kfence_map_pool(early_kfence_pool);
 }
 
 void mark_rodata_ro(void)
@@ -1421,7 +1420,7 @@ static void __init create_idmap(void)
 
 void __init paging_init(void)
 {
-	map_mem(swapper_pg_dir);
+	map_mem();
 
 	memblock_allow_resize();
 
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

