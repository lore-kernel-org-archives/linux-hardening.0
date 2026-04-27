Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F93D6CDC
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304148; cv=none; b=eI+zHOPENbDbdPVxupF57bLFZaWiPkAaaGXW50GtNtxhOhkeUOp/dl6QHS7xCiRuAB1ZA1DO/c84zgCJ9ZJr1wTFCIJadP/By55EwEJHytdjE24ZK+ZWE0L+oO3WQp1PzELGuXgn6imayTuELu3l9jxpn5t1ecoystbxfb/zeaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304148; c=relaxed/simple;
	bh=5aJqD3YjV78A3aSXyWLniC+6Eqi71MBuIePvROYkngA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ogUxfPkwzHSWvtI5N/QUcW8Fhnvb1DHP7BM8yT2DlOESaCLNFALlcT28konQod/wezP9TIAMpzsStu7t9dFoF6bmjxdWYp0Lfv+n+c9paLN3a87M0JwxdxLM6AWBUUPJW6c5IWXy4zupgJF6tLvnREq3w3CRVV3989K1W0zn2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHsXUKXc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHsXUKXc"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so91794665e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304145; x=1777908945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmP6R09Q9nWqYYDZQR+Duu/8tNuRQcuIH0M5Nuu7R3A=;
        b=UHsXUKXcCkd96A2T3fVhJWyy2gGMy2hmkeqcticoBJ1u4ls79WF/bz+dEEg0tcHcPq
         wF2L32k9NaV4CiAiylnAjXks4MGpsjy5CRvo4lCYHPKY/MjWgnA68Ea95KFSnn8N6zSK
         lt7i9jGi9Vy0VaUda41zAXMxm9D9x2yZcHquMe4SvU/TMcByUdzaeAcFxAD1SgC6UAtx
         RGKS15rwN2ken6f6Ry3VaKFxk1wgX7vE1zYNDbmAYPGdMvTaYvH8xYS1jNtwomNnwiPX
         PKLSqPs4KAEc/LU+4HeZffXdWaOFda5vPUDbJf8LI/EADoIwU33w24SFTo3oT8bWSkF+
         J9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304145; x=1777908945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmP6R09Q9nWqYYDZQR+Duu/8tNuRQcuIH0M5Nuu7R3A=;
        b=Bwsd+OPJv2KI+Cu53cLjwbLA7k0VfQUL66GCfT5yR9d/j6c6q7nuAoIU3kq/xFqJyK
         0NdXJ34ktPZGlSJPOoSMdeiBRQsoMB1LtKo8aL5d77WrsM6soDgREfCuyENcw5Vwxkmn
         Z5o+Q9tMxuurPqrjptYHstpCEHrGlBIUoquspz9HmKkogv/u8/T3gidudmRjd0677WnR
         dyHfYM8YRNlA6u0HIzRxZw026neK5p4Eh/8ut3BWm3Q6Meevs8NptntFwDC/uF+9eiFO
         3t1OnxXm0HjvO70sTW5sLwXlW5tkWbRwkQ4wRfVMjh48E8C+phxVqYbGrGcfHgD+iN/n
         8dtg==
X-Forwarded-Encrypted: i=1; AFNElJ/SwYHulJ+0PKpW1+CsEXFL55ztX+a3wqfY7GMEe2zOVeg9FSOunA5fJONlualeQGq6BuXX5S6mK3uqAFqm/ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmeytDsMpK2uASfVkXGdV7lMWU6lWXzDsjyxf2jjTIASxJqKeb
	acJzre5gWPbistiXTvjgLoaFATGVD3YmqtqA1hQcPHdyyMkfLEkZI2Z5k8ikDsygVrFdCXy0Mg=
	=
X-Received: from wmqo21.prod.google.com ([2002:a05:600c:4fd5:b0:486:7a8:4f4e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:190f:b0:48a:6315:da26
 with SMTP id 5b1f17b1804b1-48a6315da72mr216539215e9.26.1777304144872; Mon, 27
 Apr 2026 08:35:44 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:27 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=ardb@kernel.org;
 h=from:subject; bh=TaqiODuFtOBPeOY7+zirlhCAHHbOKzDzJrx2Uvu6+0U=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E4fzFC72tqPtWjWHA8yaWU1Y72S85i48K/X2HmNcy
 pIdrxM7SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETSPjIybPkSXFT9mmXt+wyr
 Tw3/otuqXJ56eLXKyPRt3vTriPK1hYwM5w6/Xlfbco49iWf7XsYt/4uijGorz1hflb/6oC80o/Y yDwA=
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-27-ardb+git@google.com>
Subject: [PATCH v4 10/15] arm64: Move fixmap page tables to end of kernel image
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

Move the fixmap page tables out of the BSS section, and place them at
the end of the image, right before the init_pg_dir section where some of
the other statically allocated page tables live.

These page tables are currently the only data objects in vmlinux that
are meant to be accessed via the kernel image's linear alias, and so
placing them together allows the remainder of the data/bss section to be
remapped read-only or unmapped entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 5 +++++
 arch/arm64/mm/fixmap.c          | 7 ++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e1ac876200a3..2dca18574619 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -353,6 +353,11 @@ SECTIONS
 	__pi___bss_start = __bss_start;
 
 	. = ALIGN(PAGE_SIZE);
+	.fixmap_pgdir : {
+		__fixmap_pgdir_start = .;
+		*(.fixmap_bss)
+	}
+
 	__pi_init_pg_dir = .;
 	. += INIT_DIR_SIZE;
 	__pi_init_pg_end = .;
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index c5c5425791da..b649ea1a46e4 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -31,9 +31,10 @@ static_assert(NR_BM_PMD_TABLES == 1);
 
 #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
 
-static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
+#define __fixmap_bss	__section(".fixmap_bss") __aligned(PAGE_SIZE)
+static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __fixmap_bss;
+static pmd_t bm_pmd[PTRS_PER_PMD] __fixmap_bss __maybe_unused;
+static pud_t bm_pud[PTRS_PER_PUD] __fixmap_bss __maybe_unused;
 
 static inline pte_t *fixmap_pte(unsigned long addr)
 {
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

