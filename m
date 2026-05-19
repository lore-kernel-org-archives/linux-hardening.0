Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F0400DE3
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203910; cv=none; b=ZTsglhfO4HvWieD3YixR6UteqzkssGLf2AV3ZGjrKbhmfEnyv+npbuyEmhZgrjjYrohuWvhF9Q/VwDGb4x/ZQcqEvf+XUgj17Qzu6A2Bu/Rgc97wJRqb1JU9l9AAI+8f0U8a1G+v0tWrUi1abBuQ9o6sOO33huLfknqQQf2pFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203910; c=relaxed/simple;
	bh=YLa7AFkxj76L3n1yAO/JVQaGfx0SNyfxJ5mN27SAYPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c5mw9uyKZi/4glR2qD6dSjyiSHDp78kxEQpmGnNOfYS8zvEWbGn3q3LTe8OsyLSZbjflTqMY/LsgDzLVO6FSKv7H8v6V9iEBf2RdO0NFO75EdIVjA/dnjHulERdvslOBU8wMmHChKjCDIDj4xMeO292FLMfdAlGZLdY6hf16Nz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y6yGeM4z; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6yGeM4z"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-67fef61ba87so3272580a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203904; x=1779808704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ablq7SDSYy4OVFkmF058uoPsxyfZ6hOzCdrY1mFL1gw=;
        b=Y6yGeM4zG+84LDNQpOZwcAl9pilzYEQfdyUcQXh+gEUloPuAyiBo0OA1arw8zVKD5j
         UaVeow6V1ZncxhK1BXDfTQANsAXONsTm+HDwLVLRQzSdki05RKFvFij2Mglbcz5wiM+S
         sL/CFc+TLLL+Ljf69xSRKfJYrmf/IUzTCAjI9jjSaEaCJvrIDjRt4P4gh/T/DCgM/d8s
         MTsHo8tenFF7IpYExecnyFbrZaEOFGmLBAWQvdDNFNltqAjDqToYq9fAnLaxnPBC8T4S
         eAGkg0/pwxGcs0RYmfCMi7d9R8wXuB6RB/oBzRVrjlvzC4rkHY9sllYvHF5rz60/MOj5
         0jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203904; x=1779808704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ablq7SDSYy4OVFkmF058uoPsxyfZ6hOzCdrY1mFL1gw=;
        b=JJ8fWzlOjF/EzX2tiVWQsPqnsebkK63BFYe963tZ6zzCw3zMLNCDYtOe92ajXpq9vj
         rUrA55QNhN0z9/qRaACX8KqN0lAUsS2xBkVMfP3o3uo80SCOU2aDzIytHR41KjIE/7Bk
         /SBdhExtfR1YWLlHDtfyz2fHqAG2ANAVzv/CulvY6Z6hak547D7tL/8OoZ2Q8jtIUUZu
         w6OhDULpTWQiWZkL0Fo6TT6wOv6tWQg/VcbmoyD2oKXUE8s1DI1sYegsuLFC3cEaYN0t
         4dnKrVHKjaH0XaYnBWANrb6bC3rY0/VvxFuVlseQe/oup5gYPwWwDaCIdrv1iUxDpXz9
         j1nA==
X-Forwarded-Encrypted: i=1; AFNElJ+dP6tV1QErHTeenz6XqHXLQf9o2wZT3bzskdA1KM377V9yCpqPnUSHbOVsrCnTfzANKyW4JJ8uujQTSnIW3og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxODd5/p4Lx31uhreXcrMHKb6NtVeUctyaTm/Ji+gvsZ2yhZ3yv
	sfug7l0+tt/oycWw/tV52yWLnAvVlwn4Mj7TBAFG2htvy7pzJz6UmOwca0aKKKpXbnMkhYQdrw=
	=
X-Received: from edbes15.prod.google.com ([2002:a05:6402:380f:b0:684:6ea:e4eb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:d5d6:0:b0:67b:7a8f:3e2c
 with SMTP id 4fb4d7f45d1cf-683bd38d8b7mr7725381a12.25.1779203903770; Tue, 19
 May 2026 08:18:23 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:23 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3481; i=ardb@kernel.org;
 h=from:subject; bh=x6k1+hxAgsJePfYGlvJneg2rmFUShXoMj4/fbl0R3E4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7tQtN6G1hgdtjmgLWLOkd5w6PlPKS1nrbeH9NZPkW
 yVueP/qKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNRMGP4X3OrUs34rDx3WHeP
 pWTXf/+ikjP81+7duOheUz55P7PXI0aGv4L+DLsrlFS2MG23Y1S+X9HDsL3d9bP+5tYiBT1N60J WAA==
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-21-ardb+git@google.com>
Subject: [PATCH v5 06/13] arm64: mm: Drop redundant pgd_t* argument from map_mem()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

__map_memblock() and map_mem() always operate on swapper_pg_dir, so
there is no need to pass around a pgd_t pointer between them.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cd841a392b44..0405fac18959 100644
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
 
@@ -1196,10 +1196,10 @@ static void __init map_mem(pgd_t *pgdp)
 	 * Note that contiguous mappings cannot be remapped in this way,
 	 * so we should avoid them here.
 	 */
-	__map_memblock(pgdp, kernel_start, kernel_end,
-		       pgprot_tagged(PAGE_KERNEL), NO_CONT_MAPPINGS);
+	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
+		       NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-	arm64_kfence_map_pool(early_kfence_pool, pgdp);
+	arm64_kfence_map_pool(early_kfence_pool);
 }
 
 void mark_rodata_ro(void)
@@ -1421,7 +1421,7 @@ static void __init create_idmap(void)
 
 void __init paging_init(void)
 {
-	map_mem(swapper_pg_dir);
+	map_mem();
 
 	memblock_allow_resize();
 
-- 
2.54.0.563.g4f69b47b94-goog

