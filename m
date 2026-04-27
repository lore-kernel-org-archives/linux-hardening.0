Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B73D9021
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304154; cv=none; b=Vlh9QWGa9u3c21N+HeHtR9JniERDp/U6/+q85cM6YVGjNLXGYQYLzAVnMQ2TSo9KFeAdm/vW37UFxI69o2AF/WT5L96fByMwfc0Y9OHwab3I126nNElhviJw07ZBmZ0EGYJLjCR5CDh4/OLASaqKNfjf1uF5H+k5LNo0UaRhunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304154; c=relaxed/simple;
	bh=3xiY6SGTFT0XKPbS48ai+rC6RTmOW0yJHBsDIHf0M2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=srLTo1qmA9liQKYdo8ynDrztzfi6eGNXtYpvrF4Gnr13i5jN28mWzRY6VdcIVIVkKLjfceeUxMZpjEVP2fg9p4/x5oeCgWb410QoSneJX75UZ6XaoTCVLgLyb3H9qjI+7OfrF9FOj/4MP12Gh9bHT8LOWeoTuJbG4oKusczlYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7bSlVgP; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7bSlVgP"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d7d0947aeso6349513f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304151; x=1777908951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DT4zvpGacxHRk/WPHA3P347efnejtMNVhL3FmZpnqUQ=;
        b=j7bSlVgP/KuNbKNcqcWBHw4UauesNn53/2TzWNjnjM+7atfPbKfOO4g+fFi0SCKSFE
         lD9uUAwdmJ3NMB9KlQhKQt52O/e/OuYYeCM9H+mg6hNdvPDF1b50MXuarZlZxa35v88l
         IBf8Ngez32pknX6q4cEMsO81niQQ18s4uErR27mkn8bAjYWYXfGZtq2JaH4BIOU9sO3P
         wwn8QN6AbySH+bjaOSjMW7yy1LzlqjJaYbiS8Us8xBrPtzIdc7IKNJ27O4a52YRdDRC9
         ovzgCVTMUmVHbDjnESSz66wFARdBq59WrpuHgh0uxIAsMehDZKnYsn3BI4EdcJ2oeoSy
         Cqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304151; x=1777908951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DT4zvpGacxHRk/WPHA3P347efnejtMNVhL3FmZpnqUQ=;
        b=UwK4pK6SX1ZfEaWTr577QmcR37wL20NV+Y7unGUSAet8Fq9w29cC0ZIAzBO0jYj8DI
         lTR5Ek2CPkiZCxuneR+EqjCyQ2Iosr8AuQ1qvsY9C8OhKy/b8On3sM4A1C913B90VWqC
         yG52leiEfmXgNIg/POS2OWk0Q1nw8q44AQm3xzan6i81FUZ/JwPZYYa6vymx6UPINtzR
         Bgxn3iUhbzscqBwGqZi9vLW7GIPm0cadvna52Sn/YcldlayWHJL7+v6yqerxhhIldg/2
         /JuCQy2I65hmPeY+XJtySbCxRDhZLE8YWhxb9eXCxL9tMNdzN60zeYiJvYOfmOm+5Jh7
         m6zw==
X-Forwarded-Encrypted: i=1; AFNElJ8r+XWdkbya5LrcD6B1E6/tky+ly2CQWRaKGY+HHg8up2QQWsGp6fOgYKcTgmihnCRx83zDqr+tk+OgJW5siCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjS91Izm5IxPACHRp+99HAGdC8597tMyRYjz1hMr4VVjaid6r
	xEm4On+aIqbNFxsg+JlH/SuyT2wlbgNGPnbAIe4NzEzoscVcQjtzowAC9yqXG6AhCfIZ55tLbw=
	=
X-Received: from wmbdn19.prod.google.com ([2002:a05:600c:6553:b0:48a:55e6:d5c4])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:888b:b0:488:c40b:c8bf
 with SMTP id 5b1f17b1804b1-488fb73d234mr529149015e9.2.1777304150888; Mon, 27
 Apr 2026 08:35:50 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:32 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3660; i=ardb@kernel.org;
 h=from:subject; bh=5/WaFTKUieGOECS5oMgCFK1ktF6MkiLzxXcp+K6DIKQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E3/1lYfbJ77dJSXx5Ty7SW+1FL9kwrFd8h9mz9lz8
 P9LxbYTHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAibycx/M9OuztxTuOemrh5
 3P/U/VdeN3wn/f+WxmsXu7Ztgtv4VhYz/HfpvK1unhEare1hsj3hZmaG3YWulTsrSjxvCd3xnTH xNxMA
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-32-ardb+git@google.com>
Subject: [PATCH v4 15/15] arm64: mm: Remap linear aliases of the fixmap page
 tables read-only
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

The fixmap page tables are statically allocated, and are currently
mapped read-write both in the kernel mapping as well as its linear
alias. Due to lack of randomization of the linear map, these tables will
appear at a priori known offsets in the virtual address space when
booting without physical randomization, which means that a single kernel
write primitive is sufficient for an attacker to map memory of their own
choosing with any permissions at a known virtual address in the kernel's
address space.

To harden against this, move the fixmap PUD and PMD tables to
.pgdir_rodata, so that both their kernel mappings as well as their
linear aliases are mapped read-only during ordinary execution.
The PTE table needs to remain read-write accessible via the kernel
mapping, but its linear alias can be remapped read-only as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 6 ++++--
 arch/arm64/kernel/vmlinux.lds.S  | 1 +
 arch/arm64/mm/fixmap.c           | 5 +++--
 arch/arm64/mm/mmu.c              | 5 +++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 94235dd428be..21afe923cd71 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -822,8 +822,10 @@ extern void set_rodata_pte(pte_t *ptep, pte_t pte);
 
 static inline bool in_pgdir_rodata(void *addr)
 {
-	return addr >= (void *)__pgdir_rodata_start &&
-	       addr < (void *)__pgdir_rodata_end;
+	phys_addr_t pa = __pa_nodebug(addr);
+
+	return pa >= __pa_symbol_nodebug(__pgdir_rodata_start) &&
+	       pa < __pa_symbol_nodebug(__pgdir_rodata_end);
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e5e1d0fd7f27..9b346dd24d1c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -247,6 +247,7 @@ SECTIONS
 		__pgdir_rodata_start = .;
 		swapper_pg_dir = .;
 		. += PAGE_SIZE;
+		*(.fixmap_rodata)
 		__pgdir_rodata_end = .;
 	}
 
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index b649ea1a46e4..ad6d46e5c23e 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -32,9 +32,10 @@ static_assert(NR_BM_PMD_TABLES == 1);
 #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
 
 #define __fixmap_bss	__section(".fixmap_bss") __aligned(PAGE_SIZE)
+#define __fixmap_rodata	__section(".fixmap_rodata") __aligned(PAGE_SIZE)
 static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __fixmap_bss;
-static pmd_t bm_pmd[PTRS_PER_PMD] __fixmap_bss __maybe_unused;
-static pud_t bm_pud[PTRS_PER_PUD] __fixmap_bss __maybe_unused;
+static pmd_t bm_pmd[PTRS_PER_PMD] __fixmap_rodata __maybe_unused;
+static pud_t bm_pud[PTRS_PER_PUD] __fixmap_rodata __maybe_unused;
 
 static inline pte_t *fixmap_pte(unsigned long addr)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 84d81bae07a7..e76fe5b0c5fe 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1076,6 +1076,11 @@ void __init mark_linear_text_alias_ro(void)
 			    (unsigned long)__init_begin - (unsigned long)_text,
 			    pgprot_tagged(PAGE_KERNEL_RO));
 
+	/* Map the fixmap PTE table at __fixmap_pgdir_start R/O in linear map too */
+	update_mapping_prot(__pa_symbol(__fixmap_pgdir_start),
+			    (unsigned long)lm_alias(__fixmap_pgdir_start),
+			    PAGE_SIZE, pgprot_tagged(PAGE_KERNEL_RO));
+
 	remap_linear_data_alias(true);
 
 	if (IS_ENABLED(CONFIG_HIBERNATION)) {
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

