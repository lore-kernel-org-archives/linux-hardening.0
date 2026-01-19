Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC529BDB4
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841784; cv=none; b=twZY7JfbRHalqZ3E+kifx2BP7CMr9tGoKDtISOhUdqPC6KVkoy+6Ivy+ICl0csevgHh+u0F7HsYqOHfk0YGZ1+1UGXzIxzSoSevMbTa0jHpGpAihuhAmCkV0DMwO9BlOK9q8LNkxYesSUGqxCtO1VnK+YewYiiZMqXHvu5s9rL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841784; c=relaxed/simple;
	bh=GL+pCOWxlU4aBfFzpIGeiFGwOp/CfneCFakRaSiTg7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YmDGBAt0BtA55t3QDL8KVh2YMBKvvadXa8CGqKbYjuO8lX3LEXrtvrwtzuw6xc3jm7GP7xFiM6wlj83CwrxxUQfgWTxY6CXOZS+z/WR+77qy69wP73h21cIAkst+9Hwp9MCFl+8p88XqAorE7ANU6fJpN8sS/2GewZTEVz64Z10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gjg7gnZp; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gjg7gnZp"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47edc79ff28so29109945e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 08:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768841781; x=1769446581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7DSKOLf1JwHasuEDglCrdB4m0c5EheeJOADb/4PLxs=;
        b=Gjg7gnZpmnPJOWjk5rsdlppueF0KCldrtvX3VQgkpXz72kjmcYLucTmVNspmboBznY
         2waHcVIQvx+AW9lddglHPCKecxJ+ljwwZJWCRIZaOgXMKi6TGRXf9F4cimtLP75PY7sO
         vSZQv1/ZzSorkIttXNDZ6cWF+dF26jsdIe41F49C1Cd9ONnYB9GHMhrFp8fcbNfArpi1
         y8W5Ly3vLR3u5FDa7Y5XEqsoWoCllQDsA9QdKkmTKqA6qHYpna6Bb4w0TvayHtACjICA
         lOcy99OTnEfHEH0bBa8jK8K75/NqQZNmJEKBDDMoNmZroQlgCdoSwZF/2wcoBENEPJfF
         5wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841781; x=1769446581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7DSKOLf1JwHasuEDglCrdB4m0c5EheeJOADb/4PLxs=;
        b=ATzqTFM4byHe8PgrpPaP2GzJZfggu6P1ALmNw7XO9gc+qVVLwh5tyUYiRHRzPnzR6Y
         qL5RuAqhwWKrpIohBVTkEs0NOSZsEIjBILQ5ekQ9xqwxdFybAUqiXenapgVSQzAUQ+0j
         TJgSoI8jhBIkEgsnx8xRUc7IRxPl5oPmNuurk1r8D8LvkdaA70KcHEsVHPkyy+VojSxU
         87fNL+qZzlJCi6Lg9zscu20OkqvZN+hqchCTl3U5WcXKcr4ZStCfNzP/CeCkuxPz1TLO
         gJBvQtfKBrbwv0WPp+NzLIFdaJbsr4LtE96K4lFkXO7Y+Gzm89WpB6E/J1jZ7T0yryEH
         yW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbt2CtqtpnnrEF7uDBgFmQkEM3j1XzbeA2AU1SSvTBOMUJNgq0ry4m9Ank8QenbCMcNftWTkESmZoacd2NSW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwi0bzxgtsawOsW4lU48L1ju41EgVZvyV/ETjk9iv0hSs0y6f
	zik666mKuBQNo5KdqUmtR96gZhI1ISu2O2udXWaz/4bKC7XlPQAPjvkdB18Y4fnBfxtn8L5QbQ=
	=
X-Received: from wmbej6.prod.google.com ([2002:a05:600c:3e86:b0:47e:df88:7cfe])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:458d:b0:47d:264e:b435
 with SMTP id 5b1f17b1804b1-4801e34209cmr132069005e9.22.1768841780932; Mon, 19
 Jan 2026 08:56:20 -0800 (PST)
Date: Mon, 19 Jan 2026 17:47:50 +0100
In-Reply-To: <20260119164747.1402434-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260119164747.1402434-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3107; i=ardb@kernel.org;
 h=from:subject; bh=YrSGOpU4qNxhCTfRtGfyxeLhK1Fead/uCkhL+lifxpA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JITMvwdSGu/8qa+8TA732DkZmBYst747LP9BzcpcMTeb6n
 JDQ7NZRysIgxsUgK6bIIjD777udpydK1TrPkoWZw8oEMoSBi1MAJqLWzshwa/KfPfxu/vcdp9h2
 W5qsVV78vbr429dVL3bWSkYb3/2ykpGha9HT9ayrrHMuTF0q299789eMl8dsctkfv9uVMfeM/61 pTAA=
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119164747.1402434-8-ardb+git@google.com>
Subject: [PATCH 2/4] arm64: Map the kernel data/bss read-only in the linear map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

On systems where the bootloader adheres to the original arm64 boot
protocol, the placement of the kernel in the physical address space is
highly predictable, and this makes the placement of its linear alias in
the kernel virtual address space equally predictable, given the lack of
randomization of the linear map.

The linear aliases of the kernel text and rodata regions are already
mapped read-only, but the kernel data and bss are mapped read-write in
this region in this region. This is not needed, so map them read-only as
well.

Note that the statically allocated kernel page tables do need to be
modifiable via the linear map, so leave these mapped read-write.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu.h |  2 +-
 arch/arm64/kernel/smp.c      |  2 +-
 arch/arm64/mm/mmu.c          | 14 ++++++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 137a173df1ff..8b64d2fcb228 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -77,7 +77,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot, bool page_mappings_only);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
-extern void mark_linear_text_alias_ro(void);
+extern void remap_linear_kernel_alias(void);
 extern int split_kernel_leaf_mapping(unsigned long start, unsigned long end);
 extern void linear_map_maybe_split_to_ptes(void);
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1aa324104afb..b5f888ab5d17 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -441,7 +441,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	hyp_mode_check();
 	setup_system_features();
 	setup_user_features();
-	mark_linear_text_alias_ro();
+	remap_linear_kernel_alias();
 }
 
 void __init smp_prepare_boot_cpu(void)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8e1d80a7033e..2a18637ecc15 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1023,14 +1023,24 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
 				 prot, early_pgtable_alloc, flags);
 }
 
-void __init mark_linear_text_alias_ro(void)
+static void remap_linear_data_alias(void)
+{
+	extern const u8 __pgdir_start[];
+
+	update_mapping_prot(__pa_symbol(__init_end), (unsigned long)lm_alias(__init_end),
+			    (unsigned long)__pgdir_start - (unsigned long)__init_end,
+			    PAGE_KERNEL_RO);
+}
+
+void __init remap_linear_kernel_alias(void)
 {
 	/*
-	 * Remove the write permissions from the linear alias of .text/.rodata
+	 * Remove the write permissions from the linear alias of the kernel
 	 */
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
 			    (unsigned long)__init_begin - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
+	remap_linear_data_alias();
 }
 
 #ifdef CONFIG_KFENCE
-- 
2.52.0.457.g6b5491de43-goog

