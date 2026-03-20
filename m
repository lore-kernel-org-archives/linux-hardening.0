Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AA3C3C01
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018810; cv=none; b=C9Mn3znbGlUTIPXbEDEeJGzAcuaQyFqhHFusiF9/8dhENhBdWPdQSCqQ4AqOkZcJtl37ObsBq4a3paNmgkpmQ/BxIw0gKFv8bzIXufnRuOHg2mRJu+jDKwjDTCylIQMfnzulHjmdCrwf02GvziO3mbES0HD4zI5CZpjmrvGGnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018810; c=relaxed/simple;
	bh=u1362gPTWsQEK3Ox41VXDUHVwbj9c9rnh1coDsbboU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SifIv6Qe7DDqaQ2AiES0If9/2V52F2fuEwVJgata4u1yAu6fhKom16HqIrO3nXIOs1tPKbeI4kVWU5+wMC1T2vGxQ7HUBfv976EAzam4ng0DRyoane/U8prGvGYeoMcT7jl50UaBZWidiBrL5nDORpeZGQHFBpL9E8eabYCWNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YdMEfUft; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdMEfUft"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-485345e2fdfso3274365e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018803; x=1774623603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jh/oU+9W3ai+MQNGkutnA3eVYC0Uphnsk6tMJ4kF8k=;
        b=YdMEfUftvnlRTZ5AiiysRUU4eO/oBf9JuKnnH6vWwy1384qpVoLOjdthMwj89+tS1L
         kziYcfsInzflamTw9CTdQhM7HjILYFEsKss4+S1pS6g1WPQlvJl2Y4ir00ThjyHBlmE2
         Gu8GC3azIKXYibeeun/t3nxiUf9tv8feck482PPbW70cFtTiGXzmYEjLgYbWKYGQL0YS
         TPcNAoO7qMZPPgghKBJI2zsndt55FVdgI/Y97q3xaYtvUl/P8H6ooJ+DLX9YiwrScBAR
         IgPCSJZAFutxKjsLTZkMWPwiGX3+nADCu9ZBFoSTkm3GGSwQL+Yj07HPvQR92CevnQkI
         U+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018803; x=1774623603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jh/oU+9W3ai+MQNGkutnA3eVYC0Uphnsk6tMJ4kF8k=;
        b=dJxX4zQoyD/MkXouOp1Ll18n/bBbBeSUax3DVM4DYl00DEHGhqdNTXBeQOwg0QNw1l
         C6t+2Tp2EDTsqLR/l1I/ZMyTw3Quq4lQpR1X03F99bL0mH0xaumhk6r+XVTb6WDT/0rZ
         t4pSVIxFysdWfj6+rj5Ylm10bHX4m5wf34be2nBDlUY+2p6MbdDI3X08yQdQEdfTRopE
         v1HPalIRv6iHfUJwIPC24PzmHgAL8IzKJKtzBUJTEL4BVY0djURANCsGSgVoESGqJ9kz
         6BdxNHtmWciCGM1srE+exy0XVbWURbCA1Q+U8RFnpyZ36+Zg/ZXKqywU/sbiYZbt1e23
         Id6A==
X-Forwarded-Encrypted: i=1; AJvYcCX+0O27o5CfAuBahXG1GzbNDR6yMbWJCeW13SmKrfWc7S0utwcrZQJIdJCFSNiaoBBoiYAN6aXdrqjzhUTRW48=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFj3uJM+MpkkkC0K6Sl0tOJLRf+cG3NtQoL0qxI3KcNxtG6yp
	z+9zwe7jVrZcNNuNNTgM2KeVWQxxUeIwSmEh9EG7Qf0miB1jqDdMWtEyZt3Ohiip8RY8YWCPew=
	=
X-Received: from wmi11.prod.google.com ([2002:a05:600c:20b:b0:477:5a4b:d57f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5299:b0:486:fe46:b647
 with SMTP id 5b1f17b1804b1-486fedbfd67mr48551215e9.10.1774018803211; Fri, 20
 Mar 2026 08:00:03 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:40 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3387; i=ardb@kernel.org;
 h=from:subject; bh=5dRiPzrD0xyZ8rzbnMvrrnQQbnRprbflRHsa9Z++mUs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwr17PDktXg+PWEvusPPc9vGt+LUQ2ZsvgwX3cE77/
 WzZLsaDHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAioYcZ/lkbHt4863555up0
 h9ylYX8m9e1cPyPO4pT6kuUv8xPXz9vL8M/OvY/Tar30Hws7Q/357jxH3lzkNbDyZuJKvJ9wrEA gkwkA
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-20-ardb+git@google.com>
Subject: [PATCH v3 05/13] arm64: mm: Drop redundant pgd_t* argument from map_mem()
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

__map_memblock() and map_mem() always operate on swapper_pg_dir, so
there is no need to pass around a pgd_t pointer between them.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 25 ++++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 652fe2c52b5a..744cf76f25aa 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1019,11 +1019,11 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
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
@@ -1071,13 +1071,13 @@ static phys_addr_t __init arm64_kfence_alloc_pool(void)
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
@@ -1113,11 +1113,11 @@ bool arch_kfence_init_pool(void)
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
@@ -1162,7 +1162,7 @@ static void __init map_mem(pgd_t *pgdp)
 		 * if MTE is present. Otherwise, it has the same attributes as
 		 * PAGE_KERNEL.
 		 */
-		__map_memblock(pgdp, start, end, pgprot_tagged(PAGE_KERNEL),
+		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
 
@@ -1176,10 +1176,9 @@ static void __init map_mem(pgd_t *pgdp)
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
@@ -1401,7 +1400,7 @@ static void __init create_idmap(void)
 
 void __init paging_init(void)
 {
-	map_mem(swapper_pg_dir);
+	map_mem();
 
 	memblock_allow_resize();
 
-- 
2.53.0.959.g497ff81fa9-goog

