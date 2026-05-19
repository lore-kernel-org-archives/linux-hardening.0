Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706F4028E5
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203927; cv=none; b=QVazKHELVDNjJk/fvjj7tP77ZEfN50+M7kyDEnM81W1kGM1SErv0/FAMyhKlCrFvcypJVCKfv7ToI00JjjcNSvqnGNSWAZPZaSlsyPobbtHjLj97fz5w19lECLrGIjeUHhU+7uAsMsZGLHplFQ0oPnDYyRukYvsBxKszsoeMnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203927; c=relaxed/simple;
	bh=UqlZ4sVMNBq3jADPvj71EOWeBmtBvOcuiOCtXpeGEn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXILJc+i6VN0xwlLsWSxGRLUOTEDIG9psstvPwvafmv3HyDFMHG9GnUWUALR2Afi8YAJRDWyj7taC0Ev0OT1fdxGErb738HIHy7Lig1QBaB+nb6iRdSgu5C/hVNcutpZxZf0MbS/Eqzc553c+6TTpPmL/3pDFtum1P4nLMy49rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JObmqfQW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JObmqfQW"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fda34ed0aso14582275e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203919; x=1779808719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEcGnBezuQEwMCEt3W5bYotUgDgNX6KXYvPMaE0362Y=;
        b=JObmqfQWgqwOHX0CK+Kwc6SSj2iVIShI1UfCl5qiyeUkbkwkAs9NFEdR3KTkN2b8NZ
         S3D/Q8CLhoFh0IJt2DPWvyk8nV5k0IzXItaTnHwtg6youGhIWB4SHuU1Y2Pa1iWI055M
         w/+6fe/2oObee7NHlSW68nYMbuUKwdi1yfkPl0nwjXfRaFvvDe09l6UHQuxUmiSHnazj
         idr4aYLcUO7emLOYgL/8kRyNBZIH20R9qSgjBgbD96Iyqy67EMK6zK1l25m4JkMBFIkb
         zXymdBGtTWJBa6qrkRpQJd2ZZjMJjKffOy/+YmRyMLsoqbSXFHv9LVLBTp+ETY0YHotu
         5yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203919; x=1779808719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEcGnBezuQEwMCEt3W5bYotUgDgNX6KXYvPMaE0362Y=;
        b=lCoLjvs0Cl6r6jWVOCH67yhV8ld5W+Qnys3jIMkPC1lguQopSA8U+RwSpBQ03MnqRO
         ew0GMie4ffyv41ECVv4yqUqWcezKpQW0I/Pk/Tacq7jstj0euyQ6uVin4qLqdAspdxIN
         NsDkkZbgKWupaP8wZIKMw9H4vIsdX4YPw6CVNr87BX7nP9x45c+S8Ssr7+1LMRdNeu+p
         YzYPMf+mCEJlr9/Iej49U1uUm3JRlVc34UVMafK2f8lQtIxXftyb+wDkDbgXt8LlIA1y
         Zxcfh1zsTYHihBRv2VImXDJMevt+4s6K1N+bbWQToDfo6VJIIZKL1GqJWijk0poooSy/
         1/TQ==
X-Forwarded-Encrypted: i=1; AFNElJ96ELZgAi6sAkE9CjlAWklS6RLm/Lufq/EkDqlQmrEilTUQWI1OmKXBY+vPMJyEuRMkDBOjy2xeZnRUaFhagOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95PvjieJfBkRCOPtHgt9YjvfhoAR6mETFxSPbYov2AlFU623A
	kenmX+TZsOxOHMrgUCrgBgLIMCRsMNtkAJLhdeHv3lG/hVhd3Uaq5TwfZKWusc/C+GGukPnCSA=
	=
X-Received: from wmqu11.prod.google.com ([2002:a05:600c:19cb:b0:489:1a41:9f2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6592:b0:48a:557e:6b4f
 with SMTP id 5b1f17b1804b1-48fe62f8861mr324426035e9.23.1779203919263; Tue, 19
 May 2026 08:18:39 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:29 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=ardb@kernel.org;
 h=from:subject; bh=hpZj9tDbz4ule6SV7Pe9qCHUBgjdBV9xPIuiKyNVEQo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7rLlscTzvLYmAbbOjevCUpJ7xev0pTvrw3s0BZueZ
 ivtudxRysIgxsUgK6bIIjD777udpydK1TrPkoWZw8oEMoSBi1MAJnL/DyPDH21Z3q7FHTe+b2Y5
 kpVzasa36zIhHIduB3jOl9g38ZiCK8N/x3P33asf13pw90ttVIyeHyVzWv/N67UNyRmxq6ZfUXz LCgA=
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-27-ardb+git@google.com>
Subject: [PATCH v5 12/13] arm64: mm: Map the kernel data/bss read-only in the
 linear map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

On systems where the bootloader adheres to the original arm64 boot
protocol, the placement of the kernel in the physical address space is
highly predictable, and this makes the placement of its linear alias in
the kernel virtual address space equally predictable, given the lack of
randomization of the linear map.

The linear aliases of the kernel text and rodata regions are already
mapped read-only, but the kernel data and bss are mapped read-write in
this region. This is not needed, so map them read-only as well.

Note that the statically allocated kernel page tables do need to be
modifiable via the linear map, so leave these mapped read-write.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dcff1a538f20..136cfe0f7375 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1122,7 +1122,9 @@ static void __init map_mem(void)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
 	phys_addr_t kernel_start = __pa_symbol(_text);
-	phys_addr_t kernel_end = __pa_symbol(__init_begin);
+	phys_addr_t init_begin = __pa_symbol(__init_begin);
+	phys_addr_t init_end = __pa_symbol(__init_end);
+	phys_addr_t kernel_end = __pa_symbol(__bss_stop);
 	phys_addr_t start, end;
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
@@ -1155,7 +1157,11 @@ static void __init map_mem(void)
 	 * of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
 	 */
-	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
+	__map_memblock(kernel_start, init_begin, pgprot_tagged(PAGE_KERNEL),
+		       flags);
+
+	/* Map the kernel data/bss so it can be remapped later */
+	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
 		       flags);
 
 	/* map all the memory banks */
@@ -1168,6 +1174,11 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
+
+	/* Map the kernel data/bss read-only in the linear map */
+	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
+	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
+			       (unsigned long)lm_alias(__bss_stop));
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.563.g4f69b47b94-goog

