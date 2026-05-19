Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26F407CDE
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203924; cv=none; b=HRH1nhqJyZo8EIPtiXDry73A1E3JcdJvd41P1dM7yRx8rsza+3Ibi6rrVMKfzkI3nG1mgtNsQtN+s9I0rBTWC0Vl7VqYonhhU25h1vQuLgFB95P3EfrsEIgALPgakqkxVBPXdcv2n9lqGQSiJ/fX9NOcDbSyAzIagspilp6F4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203924; c=relaxed/simple;
	bh=TC3oNeRclJA2LSfSctl8UoXdAgKSWVLe3BZ18G4Pjko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AYpeI+Is3BFTXaYmGp/Z5uK9PKbEHu1w450TvgfnN3/fdVJ/RU2e7GmX83/sMEP4c33bIzReBTD1iJI1y1zSstGLNU/7Of1rH+9iTAHyFhRfRztJFKRyhnSWIuoN3VHSwyqDoIRbC3J04KiDTUjKjcHm4CzDwyIzdHw7Qra1dWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHW5vsBk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHW5vsBk"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4900f69197fso11032345e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203917; x=1779808717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jz5HVOoTF+6wyIXVi1PRz6mG2EpkE1nqqXU3A/HO1M=;
        b=CHW5vsBkY5PjNYAInY/kn7xn9dfJmL+rpyhyOf2xxh4iFy4VFGrYA97K9AQMi2HeOy
         rrjG3+sI/sJhqHgYMN5lJ1HgXgex0geW26gYp2m2pfGo2Mo8Eb2BpqBeZTB7VexQBPtB
         ZyIaDEBpNWD0W4jJTRBhlEK0u09OLKoe/lNEZU7goR7r4EfbC/xuaW1Q4yFp7NfbN8iW
         ERg9eGjJ+uI6DJtLm8EXc0xIKQEMWgl5lP4Ygg5OwoS3S84l2jFm+0CM1ulsTp3gGaMR
         DP7Tn3vlQ8B6t6scqoZruofCu2G2me/VJYwe0ln+SoVIrDN7UJ0LYH6OZ4Qw8R1qgG8q
         bWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203917; x=1779808717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jz5HVOoTF+6wyIXVi1PRz6mG2EpkE1nqqXU3A/HO1M=;
        b=hATL8wtKwQgL4gifCDCyWsTjzCexKxs0X09Nv7pQEaOt0SqUku40QPTbMaMzmFXoxl
         aJ094xxUdbqvKCObZXpBxr/N/rKgYcIyoWhN5KUsixtpgePhbVkrbrxkuZfgh+mfnI7O
         EYz0F1YmD2eTyBlq5Z3Qiwp6NudzVML5EvmSw8w2bNi94Uaj7519gXDgYNqHq1MPqFkx
         89lyGhtK4OMEBvDYMZflxPX2qF2LxBbQUmI+N+JFKIbd0XD+gjzsxQI85KY9Xdu0tcbQ
         PkwJsvoN9nbTZq/LOZdNwOIiSjpJoIKYi9PF5qG56eyVOEGZ+uNN8Dmwt463F6GtkZit
         CJ/w==
X-Forwarded-Encrypted: i=1; AFNElJ/l03X3yScpAOZsq7TqSYMr5q8CUY7PSz0pws7KNrgnbp1pbs8do+jB049kLhfbiTqfz6p6q2+nHaYposp37FU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlbcn1bJfRrdBEPIbM7wjAevHgDaMatYeCA8Gm0ks3l4mFqLDg
	CZvWORsZGkbiqf/oIQHO6dySpSWXXg7izALIXqge3HgGFgP4GXNRYtDBp0++YLuue4Qawb8MSg=
	=
X-Received: from wmgb4.prod.google.com ([2002:a05:600c:1504:b0:48a:5909:4ec0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b27:b0:48e:7854:1608
 with SMTP id 5b1f17b1804b1-48fe6516b54mr287879475e9.25.1779203917004; Tue, 19
 May 2026 08:18:37 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:27 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2309; i=ardb@kernel.org;
 h=from:subject; bh=UkAnTwiseYdN3aottp779GEWC8HTyTdJGgqvssDeFDs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7oLF8bs37COMHj7P+n7snJGyv9rm41dMbMS8zptLS
 tXt/7u3o5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkZRAjQzevZ0Wao2BR6VYx
 Id/GxVnnL9mVyHGzz3i8hW3B1yMN5xj+St4OTmgr/7Gk+JVAuEzcFYW67LpiNmefmmsV5/P5Y/2 YAA==
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-25-ardb+git@google.com>
Subject: [PATCH v5 10/13] arm64: Move fixmap page tables to end of kernel image
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

Move the fixmap page tables out of the BSS section, and place them at
the end of the image, right before the init_pg_dir section where some of
the other statically allocated page tables live.

These page tables are currently the only data objects in vmlinux that
are meant to be accessed via the kernel image's linear alias, and so
placing them together allows the remainder of the data/bss section to be
remapped read-only or unmapped entirely.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 10 ++++++++--
 arch/arm64/mm/fixmap.c          |  7 ++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e1ac876200a3..64c7bf4b7176 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -349,10 +349,16 @@ SECTIONS
 	_edata = .;
 
 	/* start of zero-init region */
-	BSS_SECTION(SBSS_ALIGN, 0, 0)
+	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
 	__pi___bss_start = __bss_start;
 
-	. = ALIGN(PAGE_SIZE);
+	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
+	.fixmap_pgdir : ALIGN(PAGE_SIZE) {
+		*(.fixmap_bss)
+	}
+	ASSERT(ADDR(.fixmap_pgdir) == __bss_stop, ".fixmap_pgdir should follow BSS")
+
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
2.54.0.563.g4f69b47b94-goog

