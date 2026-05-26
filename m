Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061C4218B1
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818366; cv=none; b=J957wMqKaeN0N0BlgddzXvDrWfqh5HwPhYZqEUVhM5EVamaVZN5SCAYa87kt2xesl3CgEa9yUTxeYCnRZjAD0rqcv/szjP48MElTMjY+2Pw1U7JZg1z3XI+5EepKYECy1lwgEG3a9KQoJ67CvCJwjm5QUn90pp3hTA7c/ghzE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818366; c=relaxed/simple;
	bh=R1m6k39Kd5OLBqsE8GC497+ARMHkcaNzcA58gMuGmBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S984s89isDPMNHmlZQiInSuj0wKC83m16v19vTKhXTSJS1rRhWko9p/JaGkWfKBpdpVGYwkvnK90Acndp8GiwX8pz82Rmd/+4x0D9ZAr8IHTKcey2EVRW4nxueCU+EH1Nd5vr0SUKUo0/2Qa4q4rNfbmhp7tf6H3yoRCg445tn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dca1DNw9; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dca1DNw9"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4411a2c034fso9938161f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818363; x=1780423163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyd3IudRVUHVyeM6Sgx7GyCvuriuV9w8zEGgNDuF+gw=;
        b=Dca1DNw9jTpNmoIXPfNF0hs9fT8HMj0eW9HN4w3Ad9sS6/w8hwM3TFwRH/3TjM+79b
         0M80DJAFEJ071CTxxB9cZDHyIzClrBxd68g83I2RzzvqPwj0F2SMX3JC+2L3pbf7bzNT
         t1plu8UBlX/n4o5P/4oEQYcUZ9SMGxS4aXqc9WiHO6iO2JwDnMPjTDU6JX83zPZDEtkt
         sZbmZWgkYfiUuw7idnwsr/gVDvYUrL2UoJSIBVGpztNokG4UcgCfQ5fX+UhvTFbbF7iO
         ou8QdWuXsKlDVGImLt/HIhBLdK9goptRTdZEBi0jD3gCI2ZXI8xZagOd/qijqfqXuKXN
         Xkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818363; x=1780423163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyd3IudRVUHVyeM6Sgx7GyCvuriuV9w8zEGgNDuF+gw=;
        b=QUEFrKCeMX3FDXZ+JQP/D/Pe5vl4s4ewwmOrjUOrsJFzfg3HpZkO6hGRmiwMKodjgl
         ARas4KeD/VqLt6mgMgo59paZaLZrNlvIRhcw/FiIn71FDaeCwkPwVWxGIO6JuNHDt2o+
         otxBHPjqOj+nncX8Qfxm3gIhlOrbCWXQ0uzfQbRBNhA09NgQwMpRMaOr9nvCW+8Gh51c
         KGJWPGBZzq5ZJdPnDWT6oFJyijXJk/RtOaztv3V6jm6ptGTvf3Izi80gfPCC02Jhbebt
         Z4lbpMHGJfnfC9W4qozJivdDsm72m7nkLyB1bODs9cS/cBkSSEpVxp+hntRkGKSTsFCi
         MixA==
X-Forwarded-Encrypted: i=1; AFNElJ+PjvrtpUnxe4Jl93kOchEBUJvxd15i4eKwvOwSZ6/5T1tS/4oyxz7Hz8Qx1QVS6oUEeBmfPwf25SYDjyyT6SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+4vyfIh/PVeRxF5madstO7F17Yk1aFH62HuahyKW0OhzAluY
	ZZd0kQLlQm/vWrwryYE8XZlZGmvZ1k8vGs4VJoNLlR7CC9kXFj4jAcQNslfXAggLfirxp50ysQ=
	=
X-Received: from wrwy1.prod.google.com ([2002:a05:6000:1081:b0:44c:3df5:500e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4917:b0:43d:dd:8ca4
 with SMTP id ffacd0b85a97d-45eb36ab5c9mr33376312f8f.14.1779818362409; Tue, 26
 May 2026 10:59:22 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:49 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439; i=ardb@kernel.org;
 h=from:subject; bh=vIIm6COov+NQzX2nIS8cvw7su4mTKmzskcBcPmulqnI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fpS02zOfRUy3961i3vC1b7n+Evm+/R38NgG/DlrXZ
 Qm+/ezWUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYyZREjw8TXaqzPetiWhH24
 cp5p0vNHbzoXsV7Pm+XWwVYqvcHR9SUjw6wVekazft8qKTufNy9Z5jRL5boX02v9d1fyMKbXF/Q c4gAA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-19-ardb+git@google.com>
Subject: [PATCH v6 02/15] arm64: mm: Drop redundant pgd_t* argument from map_mem()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

__map_memblock() and map_mem() always operate on swapper_pg_dir, so
there is no need to pass around a pgd_t pointer between them.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 25 ++++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 112fa4a3b0eb..aa0e2c6435f7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1035,11 +1035,11 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
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
@@ -1087,13 +1087,13 @@ static phys_addr_t __init arm64_kfence_alloc_pool(void)
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
@@ -1129,11 +1129,11 @@ bool arch_kfence_init_pool(void)
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
@@ -1178,7 +1178,7 @@ static void __init map_mem(pgd_t *pgdp)
 		 * if MTE is present. Otherwise, it has the same attributes as
 		 * PAGE_KERNEL.
 		 */
-		__map_memblock(pgdp, start, end, pgprot_tagged(PAGE_KERNEL),
+		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
 
@@ -1192,10 +1192,9 @@ static void __init map_mem(pgd_t *pgdp)
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
@@ -1417,7 +1416,7 @@ static void __init create_idmap(void)
 
 void __init paging_init(void)
 {
-	map_mem(swapper_pg_dir);
+	map_mem();
 
 	memblock_allow_resize();
 
-- 
2.54.0.794.g4f17f83d09-goog

