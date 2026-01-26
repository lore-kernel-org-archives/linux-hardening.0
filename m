Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7D314B7D
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419661; cv=none; b=HAYbBZG0LezLUzV7AC7wxBb5SRdtVOcZ0zQrwSMfa3icWiakhKkWdG9Y+fVk4g3yoUuaLljE8prDal46FLRr2I/itQy66RwlQLIOI6/mFNlTA7d3N2UKWPtgNX5KnJbwRtHU7YH1GyFC9yGbVSKG0SA2FTvDGQeiMJwAB5+MPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419661; c=relaxed/simple;
	bh=HbJ+s9ERQpCPv7mfOKNuDHBNCAoRV1bfJEOnQf27PWE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=asexpQ4wneE2hgoW8XSmcDPJrR7LEH4QiNNygIumQKi1bc2UQiBjJiOaZqjlHM1ouFZIWPJ12BoLRvm3jdGkjuCtkN+TbKo03aKDKSLUrNDE9nWsF/JtDUNUQFFMfb0kaFr1ioz39X3OBHbzMNwYKmzHYoK8nM6z7PweEdP4KcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5fl+pEZ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5fl+pEZ"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-480593535efso8350435e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419653; x=1770024453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir5Ku/kBhV1xo3f4cYFTds8Jwvu5+ARQt7mXP3/a2YI=;
        b=H5fl+pEZQo4XnLRNWl92/D8/B14EWNMoWKjkGM5xBMZdSyr7ylUAlqy0SbU0R3xm/s
         +h3XB7Hvxur1QOdGCh4sIJfRIiFfNLyPMH+WJ2X+vL6wGm/jS8aMg6cJ5nz4mJzZ1Yoz
         Ik3JMuVvPWuoT3/te0U28Ie/+qQrLregUpZRnbjxDFG+8Z6Z5EwYubBihlwHWvchOJy3
         35aRhBDSY0fRtaW93qL31Ql0TV6rAYROXUtVy1ANyJDS1EpCd3hDuumeLHKvQb9Cu9JC
         IpP+BFtfB3XeJTBS1tvVcadPUiJG5ozuSogYc2cjLEK1C36XHDRFTaj2auBI59v/Hzin
         l3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419653; x=1770024453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir5Ku/kBhV1xo3f4cYFTds8Jwvu5+ARQt7mXP3/a2YI=;
        b=QwtvAOqBPqL96S6lEjCznpy0U5FO8a9MfZiofn73LRoR+VeXxQVyEg2Dkm1UmCGWGE
         AHIpX67+R4462baJXZM37POHDMfUTB/jfAoAV/qRJEyDUHnxROjzd8C1cp+ewY4sU3vB
         wssmqSxPoE7+1MNE6OWCy5SlIeBinIZCZQhoNV9JAvb+AVf++V8bXZD+DL4q2NWqVe/l
         32vL4pSh8Nu1Ae6VX+CP5d2Ff/jFMkH0pGFcXTYX7FmN+AIm9wb/KmqEuvi6GyFaZCOn
         gF6Td/L7Ip19i/xE2ugbbiJuP6VBd93HL/Qk8md8DhAyIhAgcVk7y8WE0WAb1+c7aVV1
         q5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWXR5+9Rz8HgqPhxpaUhp3P0TUqlpXvIgzEtplgZGrlSaLnPfPaY4Y0YNToPZ793me1CBjiYhSyA/1PGSj+Ni0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNIlRd1OdEyY3baxKaiTUD0sTMzQOxBlm6DiSPyhzsTCo5M1UL
	hrb7W5NVK4P9OXGKEfCFUdgX9OJxScWzt7yj9W3hxdiEeJWOglAHCgnWk4dtYAi2LFqtmUAa6A=
	=
X-Received: from wmcu2.prod.google.com ([2002:a7b:c042:0:b0:47e:e4a5:c5f2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a08c:b0:480:3a72:5c10
 with SMTP id 5b1f17b1804b1-4805ce4f010mr77377385e9.16.1769419653485; Mon, 26
 Jan 2026 01:27:33 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:33 +0100
In-Reply-To: <20260126092630.1800589-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1953; i=ardb@kernel.org;
 h=from:subject; bh=pPbGakq4Y87FHZEohxgZxqjL2z9m2SzmfynlW86oFBs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2OPan3+7fij8ksibeLlIhSWt4tJNvstbmdqFDO+zh
 Vs5Pm3vKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNJ1mL4H17OOzNlTmVlZV79
 +YvKLROfvd2wtjzTXW/xIa5XnZcW/WX4zb5FfJ5ThmXau6Mv2BbW9E99PtvpwHdeVv7LhyP8mrK 3MAIA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-14-ardb+git@google.com>
Subject: [PATCH v2 02/10] arm64: Move fixmap page tables to end of kernel image
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
 arch/arm64/mm/fixmap.c          | 7 ++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b2a093f5b3fc..c089b83308a5 100644
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

