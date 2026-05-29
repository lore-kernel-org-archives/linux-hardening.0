Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFC3F8712
	for <linux-hardening@vger.kernel.org>; Fri, 29 May 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066952; cv=none; b=TKROjYKO3iwQQNJS2GNBkld8O0Qy1G/8RELTEKnAz19gNWAwhT8RNw5lGtQTxu3Pzx+R4eKaPeZNtWngv41zHU5Y3uVVEhA2SEdIljKBCzDJUx2CtLn6rND8o7UKnis006Qdo5cJy7zBAx0wT/JKS45PAEjEgVVmetqmL+CIL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066952; c=relaxed/simple;
	bh=QaYtjQKKU2ZFCKXwSNKUI8NOyp6rR9SInNzJZhhzRuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cShG7Khx8tx4rbv/rOlB+7ajgwN8z0V+xNwyCaSZ4c7SKEOH4WsAKmM3bNSwHj6lMRaSjRQBAomAilH/CQtjAMC3+npEhkLzAWvtL1SDcW3AEBDLzgT7UfPJ41kR7DDMutkh6UeEddw7AsHPV3ENg+JGa7gimD1mq26/NULaSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ds7+tOe7; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ds7+tOe7"
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-39660440f38so970501fa.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 May 2026 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066948; x=1780671748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xs8UZJaaGpDG2dm36q3rutkvNlrSNXe/Bj9mb4oSyno=;
        b=Ds7+tOe7u6LqidVF9uUrVbA5TmrJvkRrC/FeXq9I/qqB9kpwJdt8chI2z8vDpT69nN
         SRKPRfwIUg9faZmumhtR9W3q8t3xmrRKYp6I7Iq9rR2udFNSoBLhWBRvTC8wvmaZVkWG
         zmXM+TPyol0EiUPJOfWz/55kNLBQRfcrJU52H+w+a8ShvCwbQJ4EJKItJOF7QuuMN8dG
         cNoRT6Um1/QZQCgrXSJFrrjNJHYciFCYuMcYe5N+IMAKX9snhD80mNGl6iEN0hvsSShC
         DpeR7WhS4qH58LmtxqR6vOeVGpsai1QGYykAA1MusogjG1xYOkboPmfFJks4V9yqRuGi
         mXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066948; x=1780671748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs8UZJaaGpDG2dm36q3rutkvNlrSNXe/Bj9mb4oSyno=;
        b=bDwLkZ5URKqWxZbUsr2J5UgIcYGEVBNHsnep7N4VO84AcIalGEOrk27VsLozHZwZYw
         ymrdv0h7GXmQUFGi6celBG6QefYGEFjpoUdiFETe5Om4nsZIWJ+8rvTtFERM+mDl6En6
         DexVpLybqw0153IvrAUj7k/P/670/hPMd1cuJGW7NHYEREC+YIB3B42LUp9R1oq7tUuX
         fM0qnz5XIn5q/Z+f3xsshFTifdiDqcsZYhhvNLZjzuN7TcEUZxnFF/8HpAZ+cCU9JfFV
         ESjmu3T704YyMmO4Cq6EwpGswMoqwmSC6GNltNOVtXacRHunPQIgmwofLf8Yx6EK6ff3
         21wA==
X-Forwarded-Encrypted: i=1; AFNElJ/haRnGgeXMnuTpKQyFiGXtQCsHzTUjSALcn8UeXBij4xKrZCzAmlAWc2vl8LMQNn64xNguzV6Uc82SMyX1m2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa02ge1YidJEskn30hUUnAZZqVeyC4Hp1/5w2ch4xdf/toaBsd
	qHGZBgrMLjOkUttqe32l1WrgvJyxqYxta+VUnNx3p7dSX96Xv8sgyhVBh4g7xip3jcIu0bGBBQ=
	=
X-Received: from wrjb2.prod.google.com ([2002:adf:e302:0:b0:45e:f542:3761])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:990d:0:b0:395:ae3b:3375
 with SMTP id 38308e7fff4ca-39664e981c0mr41301fa.2.1780066948187; Fri, 29 May
 2026 08:02:28 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:00 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3242; i=ardb@kernel.org;
 h=from:subject; bh=QwDzTM46GdUE+NivIT38dC1HutxUWa2GWKTenTtP7nY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVWb2gvjDypnblG6ZO3Wv1Bft/jrhexd79oV7t577u
 RU+EnfqKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZI8zw36neUKL4j/F/nsar
 u7+2BlcevsMd8uPEywc1ppJzt9RzHGb4K8J9S++osuTMJf0rlUt33Z06V/Xzwox9+yqmH1l/Qee ZAysA
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-26-ardb+git@google.com>
Subject: [PATCH v7 09/15] arm64: Move fixmap and kasan page tables to end of
 kernel image
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move the fixmap and kasan page tables out of the BSS section, and place
them at the end of the image, right before the init_pg_dir section where
some of the other statically allocated page tables live.

These page tables are currently the only data objects in vmlinux that
are meant to be accessed via the kernel image's linear alias, and so
placing them together allows the remainder of the data/bss section to be
remapped read-only or unmapped entirely.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu.h    | 2 ++
 arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
 arch/arm64/mm/fixmap.c          | 6 +++---
 arch/arm64/mm/kasan_init.c      | 2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 5e1211c540ab..fb95754f2876 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -13,6 +13,8 @@
 
 #ifndef __ASSEMBLER__
 
+#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
+
 #include <linux/refcount.h>
 #include <asm/cpufeature.h>
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e1ac876200a3..2b0ebfb30c63 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -349,9 +349,15 @@ SECTIONS
 	_edata = .;
 
 	/* start of zero-init region */
-	BSS_SECTION(SBSS_ALIGN, 0, 0)
+	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
 	__pi___bss_start = __bss_start;
 
+	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
+	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
+		*(.pgdir.bss)
+	}
+	ASSERT(ADDR(.pgdir.bss) == __bss_stop, ".pgdir.bss must follow BSS")
+
 	. = ALIGN(PAGE_SIZE);
 	__pi_init_pg_dir = .;
 	. += INIT_DIR_SIZE;
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index c5c5425791da..1a3bbd67dd76 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -31,9 +31,9 @@ static_assert(NR_BM_PMD_TABLES == 1);
 
 #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
 
-static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
+static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __pgtbl_bss;
+static pmd_t bm_pmd[PTRS_PER_PMD] __pgtbl_bss __maybe_unused;
+static pud_t bm_pud[PTRS_PER_PUD] __pgtbl_bss __maybe_unused;
 
 static inline pte_t *fixmap_pte(unsigned long addr)
 {
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index abeb81bf6ebd..dbf22cae82ee 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -214,7 +214,7 @@ asmlinkage void __init kasan_early_init(void)
 		 * shadow pud_t[]/p4d_t[], which could end up getting corrupted
 		 * when the linear region is mapped.
 		 */
-		static pte_t tbl[PTRS_PER_PTE] __page_aligned_bss;
+		static pte_t tbl[PTRS_PER_PTE] __pgtbl_bss;
 		pgd_t *pgdp = pgd_offset_k(KASAN_SHADOW_START);
 
 		set_pgd(pgdp, __pgd(__pa_symbol(tbl) | PGD_TYPE_TABLE));
-- 
2.54.0.823.g6e5bcc1fc9-goog

