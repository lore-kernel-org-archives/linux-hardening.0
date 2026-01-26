Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59872314D25
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419664; cv=none; b=VH9xEZgvhqbUtEcFMrI4IpfAg7Q7PfVzCOLNA3louS5mbYzW4pk1L4VsT5W72rxdfhIQ/hhfGgJpydfSYr0SVNasu+4bHg7Rk4tjZRBt6b0O0MOpS10vqlT/E0g70bQZWdsNpCIv5pH7ZT3lAfDf6NSwFHMzeE2jef5+wg+vRUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419664; c=relaxed/simple;
	bh=L7cwOKvPXcZOjJ1SmTkNcTugFF5grDnvPTTvVyQz3Ic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V3aqcpK2fuWFR0VOy14o5wpFwGZS47rugAN1y8tTflrRalyaqtsvX0gzFlr7tU0WFdI+hwQHCQETVXWUNgEZxQ4/0Mm5zkFEINGyeSAfpaVGEeP9raLBP+Hv254pxbdBh4S0tBF4loFg3/FwgWAlotALzIb5UKt4lDdJnee0T+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v8k53LdU; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v8k53LdU"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4803b4e3b9eso34379035e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419658; x=1770024458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6c13B4dAZW2mAGZnzKmX4nddpklZOgYUawWDxi2JBv4=;
        b=v8k53LdUdOb3QWY4/FWwKOcNXT9CYUoT5rOVay1W5GAKiIYHDcwm/9Ns9y7Ox2Rsfy
         g4kTTWqlx9MkH+6xAq1J71H/dQ73bTU2t1Bw28SCCmWZCo1s0xWTPwOkC3tCx+GHvEWt
         e1BTQ85z/0n55NsjzzIHu86ESZNu9H/jUgoxy8dn9aBAs1udZqh4JGKbp1sK1AwlBQiQ
         FbJT5nBHhmow3Roa2VF/iAlmd3PmkTBwLb0VIYcEiqjHGYOzSoMCDawhrZn/04cSdQ+D
         FMdGETDaafRz3Yzy5fH9N+aAfJuF7CqpodMuWdVu5MtIBHlQ0TfdRAgzbNapcWFN8PPU
         jJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419658; x=1770024458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6c13B4dAZW2mAGZnzKmX4nddpklZOgYUawWDxi2JBv4=;
        b=fCThoIvARl5/cvHb278GCXXVgFet8XQoR1RSdGy9HVdHlR5x0+Yiszemy0+uQ0o/P8
         joh4Iyx6o3YmDGirjqztK8vAT2to/YRAGdi1VZ5+OUVQ6kL+JUUvjL1jd1nPXe6YDD+L
         IH8+vAG/LzV/6RYY0vStdALpgZDuWBqsUw9nVVNincgEkC5OouX87n6EajmD6PUGhhKo
         3wxCeDxHSWuLUBMbX2ioIgV7R+gy9K06xtdFqoHxfRWQzLoxzy3Zh/M7Xkwd7/xt0tzg
         J229DjlpitMSVTuir5Nnf3SA0zLIRqU94Gs5z5k+uvRzJCMXiQDjt+en1rG/PAiM+MQ1
         kBpA==
X-Forwarded-Encrypted: i=1; AJvYcCWx7V81cWbMGzGyP+TEF1bKo9safKlTMU7FOt//6YGqgWCjNP/ZP6k2zSXwFTJU/ngFC+WDS1FIzITX9i2p/Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgC7sOTA6+NS9JXdpDMZhuC01eR/LoukJgo64Ibyox444VuMfx
	i3phawHugHzwjfxlY/853eTZgAPdOIE/UNwg8vzQGZiTVsngyP94zsbbDHDDv21ylytyhUyrFg=
	=
X-Received: from wmbjw5.prod.google.com ([2002:a05:600c:5745:b0:477:7aa2:99cb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4592:b0:46e:49fb:4776
 with SMTP id 5b1f17b1804b1-48063973de2mr13675465e9.11.1769419657809; Mon, 26
 Jan 2026 01:27:37 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:38 +0100
In-Reply-To: <20260126092630.1800589-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3337; i=ardb@kernel.org;
 h=from:subject; bh=3Dm3E0e2jB3pb2AJ/LEeXuocNeiU12Y5ft9q6XhOB74=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2OuSwELFPPtn3tW6gekaj0/clPAoOR+hfaN7W0y1q
 lTWW76OUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJHNQQx/eO/+MwrUbC/XWVhk
 zVG5JVvZOvLKmcMbHqhvutM+RYzvDMMfzoLCiVmn310unfv/g/VMhmN756dHaPJc2rFMTOP9zg0 a7AA=
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-19-ardb+git@google.com>
Subject: [PATCH v2 07/10] arm64: mm: Drop redundant pgd_t* argument from map_mem()
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 25 ++++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 377bdc4d84a1..80587cd47ce7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1020,11 +1020,11 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
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
@@ -1072,13 +1072,13 @@ static phys_addr_t __init arm64_kfence_alloc_pool(void)
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
@@ -1114,11 +1114,11 @@ bool arch_kfence_init_pool(void)
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
@@ -1163,7 +1163,7 @@ static void __init map_mem(pgd_t *pgdp)
 		 * if MTE is present. Otherwise, it has the same attributes as
 		 * PAGE_KERNEL.
 		 */
-		__map_memblock(pgdp, start, end, pgprot_tagged(PAGE_KERNEL),
+		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
 
@@ -1177,10 +1177,9 @@ static void __init map_mem(pgd_t *pgdp)
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
@@ -1402,7 +1401,7 @@ static void __init create_idmap(void)
 
 void __init paging_init(void)
 {
-	map_mem(swapper_pg_dir);
+	map_mem();
 
 	memblock_allow_resize();
 
-- 
2.52.0.457.g6b5491de43-goog

