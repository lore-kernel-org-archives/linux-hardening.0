Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8128B407
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841783; cv=none; b=n7T4huvJg9ODgFDLpN0y8gXhWZkf6VhfQjW+8U7Tq71XiwineGpCJnJTXfOZ6DVLee1XR/siHC7uV+n4u/2rL57yyFV3ok5877ePfRu5OrH9+70gan50N/s9bcEsB/mHhnoNqTtQopqHUSF/72eV0FYl6fX5lqPsOb6oOa4Ott4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841783; c=relaxed/simple;
	bh=/YnhQ/jVzLR/fMSw9NDdL1umAtJHUy1qKpqUa4B8LO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZErkznDJbdCi531hKp2j1VWCRK1SP1RcfFd/wTJjSuR/d0FCa4SNSU/R0Na1EyPdCIAo6O/dDJQm1VK3kA2Zb832fSF8w66MCfNgfxGLmP74Y1ghNmiE41sEUfbQ2jMgvyfNLkva8NScyXhsF/0EfP8umbxaoI6r982NDeoOplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IdvAgrzO; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdvAgrzO"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so55592835e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768841780; x=1769446580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYzWrHN2Tb1+sOzqvSgFkFnU6zAOyR4NYaLGjHgj3Gc=;
        b=IdvAgrzOWeodPQ1Awc1SMD/40r4kICo0PxFUJkllf+tMoanpwhlILOx7uVUtwVTNou
         H4WvNDBm9kdSRWvnWVOVsp/EMhQOkaldomzzf43M8YYRqMvBdkq5Mu/rxEpjaCspxNna
         ZUohpWOLIQiN9Dg2WkYYRHy99IVxM025wBBklI8zFC1/TQVQua2OclvoiZtxFOGcSyTn
         Ch3+1iS5xpTYFDNi1m4pc2p4mnfA9Nq7Jd0s4rDrq+0co+K53ugdGu+oa0LiOv6yH2kK
         Fz6K36zjZLS3Us+icBu6mt5E6a4r2b/zVDMy1I9nnfEUMKUvmzV5KGHdVc6KSYszqlkK
         dlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841780; x=1769446580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYzWrHN2Tb1+sOzqvSgFkFnU6zAOyR4NYaLGjHgj3Gc=;
        b=pvaJWDPBSsm8eBdqN/pji8mS2PB5o7cxAkz1RE1fP4Vv9zq4SB3xfUhbL2yIBani8b
         /8L2YZKG/SjOxLDhKT72GWm79w9fQ96iGVcKbsvTsQ5ifU64p1g7IpI947slRWKdXSqV
         HvpRQ5nBlmT24pgnjXSu67bs3GZDhdRHgwcNBux81c83wIj6Yz7LctPgMi1TXwMwvzaJ
         E7Q5fBFEDn3sYJJl86EZ1BKo+5kDa2CFh0oYOraXc4ffo74o73ByPSNfHcFv7m5WiuMS
         LwE0NoyFHlvem3PZG+VWIk/tzisoNzMMSBMxcmIfkKhwq21V7d2esNxwxZbYo+n8E5gK
         /uZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc3Z0C76oJ9TfJaEtVgVuXNZiHaTFSzgsaGQNcZZHsE0+A5n6YGZYwunYmSfIk3aKpQ1Ud1GdrSc7Espf/VHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzROOIZnd5YsZCWHdk3FA7y6hwiK9osPI0vOp7HomjZkptBuQ+J
	pu0Rgb1GGkgmdVjeNfMvBTIeNLvIwPn+eU4C1Ytz52GI6C5DqsjEoM86KYlTrl4fcBM8AyNhZg=
	=
X-Received: from wmpb25.prod.google.com ([2002:a05:600c:4a99:b0:47b:d5ad:dd7f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:e41a:b0:46e:4b79:551
 with SMTP id 5b1f17b1804b1-48024b8a77bmr128214125e9.31.1768841780129; Mon, 19
 Jan 2026 08:56:20 -0800 (PST)
Date: Mon, 19 Jan 2026 17:47:49 +0100
In-Reply-To: <20260119164747.1402434-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260119164747.1402434-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1953; i=ardb@kernel.org;
 h=from:subject; bh=pH0qhntASVe+teACB8I8uAP7qr08zJ3z+pk5XF62igc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JITMvweSMgsuupXxNr0PWybb8ujf3yOU1itoSQq7c0065f
 Z8VkBnSUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaybQojw2m+xOC8P0r+H/tO
 6zxuMe87bfe0y1tx/vpp52vmpfLeE2RkOGF3SK/uxKbJNStMdZZUq29ym8Bp9G+XeKXTBb0f3fn yPAA=
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119164747.1402434-7-ardb+git@google.com>
Subject: [PATCH 1/4] arm64: Move fixmap page tables to end of kernel image
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
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
index ad6133b89e7a..df530e6f3e53 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -334,6 +334,11 @@ SECTIONS
 	__pi___bss_start = __bss_start;
 
 	. = ALIGN(PAGE_SIZE);
+	.pgdir : {
+		__pgdir_start = .;
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
2.52.0.457.g6b5491de43-goog

