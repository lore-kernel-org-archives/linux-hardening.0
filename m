Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4853C7DFE
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018815; cv=none; b=Su1CW8fQffkxfngE9uI95CAX7Uk9ZekPdGr0wm/kaYrU95So8RXnZBD9lHVgqJIEQ06E6PgIIPgNKSrrduwiW/Yt3mXpxZtcGos62+pHZNQaoQ0ieMbmnvWqWbw8eeLf8/PlcS8nr6xvQPSjsxYHZDRHZCKImYb9ShaUPaeEj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018815; c=relaxed/simple;
	bh=HoCluaTNl9G0txdMgRZVXDTrF1dgE/9ZbkNP4CHKFxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BotV6dY4habH0i87KsgNdcDiHlM8l0UREJCZ1STGO/AavXrqsBh8aBeHls+t+GB8VCd/AhWw5fpwDoTqjVJPnmvHr+VvjfkrfWo7wmiAl3q3+QdKLrgo7Mx3eORNjlkZRv1WlhRcfMBlPolL1U0fuo+MjyfcQ5qi4zGDbPUoNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSQBrSnS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSQBrSnS"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48531e6012bso35462465e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018809; x=1774623609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjGy6iI8Lh1+RRlATGg4ihT8EoGsIDJChLyr1UIJtV4=;
        b=fSQBrSnSJ2Inqlvki+Ny1DziYrYOFP6nvAnQJE8BTMqfCuQQCDsrn35vgKUMZokyJN
         5+DEHKZKe6nI4Qf9fXORnlH41XMBYy/Ryemskfda3Vte8b4lNfbvUTe31l1sSdYIV/T7
         pfa26sSbvPPqfiVJRfU121veheghrARDBDhAi/2EqoOqxLk3d9lgG0BDOhjJhG69tSqy
         dK9ekAdapQCePYMVX0++hIpjbDRKwOt1zNRLe4hJA4Mip0ok8Zc8cyVUfB5bOj9bFLub
         bZEStEs0iCp3Na5AwymKQCdCsR5PfDCvG6NKCi12b0tt46Q1vy/svshXbXcuCILOmofZ
         Nybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018809; x=1774623609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjGy6iI8Lh1+RRlATGg4ihT8EoGsIDJChLyr1UIJtV4=;
        b=lAMTiMLb4/M/kyYEb8LVXYTCMcWg3m0Zl6BrsOr84F3MYtlHC9ojyCw7rZlGqV7P7l
         qNFWN4a0jCpDyjcI4shOhGc5Xb+FOETzcfelxp+9NpblyAG88hBawnnzf7jGIcGEO6N/
         tSaBgsDM9cgI7WklZUyIvR4FyZJ66wmGvqitYTSFXjnF9bRKvqdjnEHHqEJP3T77bYvv
         7REYudZ0/bTrmDV/TfVL0J/6fyBTLwgnhvzSMdTNBfalHxQXttTGorqlpwoclbN7atIC
         Nqa0PKW7AM4TFZR2A8o0o+D5gNfhqw9M98r+EAQhpNHfe6EvJ3jeKQrWnLqQZW95hnJc
         uD2w==
X-Forwarded-Encrypted: i=1; AJvYcCXc6NunISdsdZUCK6sbtxj32rb0rqIiZ2ZyajlhIFTOcsDkuY1Wau8g6obfJfzKERgz932WJRp1Lt4fX5DJcUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycF1S5dbniUQ0VLBwWQjmiPKr6SfiVn0lzk2UtCIN7bGUWyyMT
	11fOdyNYIYRgxBonL2/TiauaSyWTdEcXbWJOGsXm4i7rOS0L5wC5R/BOraI8L1yOQ3mBrM45Dw=
	=
X-Received: from wmro18.prod.google.com ([2002:a05:600c:3792:b0:485:3f57:3523])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c48f:b0:485:2a85:e5ec
 with SMTP id 5b1f17b1804b1-486febb60c6mr50654835e9.2.1774018809101; Fri, 20
 Mar 2026 08:00:09 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:45 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=ardb@kernel.org;
 h=from:subject; bh=Tdi7XhvZoK6DyplxF9vlkCNhMDHkkf+zkyeuXcEumuM=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwhMJ6eNTvln2M575eF1IP7qYb3vbFKfHNqy3N/jId
 d+5fOdzRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIrQbD/7LHP8Je2fJcfpVk
 dpgv73/XeeYJrRf97U0O6DhwrL3CspThf3Fi7Lk6pYKFkV9/vA9W28FQfbjy7fHJoh8antZMv5h mygIA
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-25-ardb+git@google.com>
Subject: [PATCH v3 10/13] arm64: Move fixmap page tables to end of kernel image
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
 arch/arm64/mm/fixmap.c          | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 2d021a576e50..282516def39c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -335,6 +335,11 @@ SECTIONS
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
index c3dd3c868cf5..30aba998cf38 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -31,9 +31,10 @@ static_assert(NR_BM_PMD_TABLES == 1);
 
 #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
 
+#define __fixmap_bss	__section(".fixmap_bss") __aligned(PAGE_SIZE)
 static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
+static pmd_t bm_pmd[PTRS_PER_PMD] __fixmap_bss __maybe_unused;
+static pud_t bm_pud[PTRS_PER_PUD] __fixmap_bss __maybe_unused;
 
 static inline pte_t *fixmap_pte(unsigned long addr)
 {
-- 
2.53.0.959.g497ff81fa9-goog

