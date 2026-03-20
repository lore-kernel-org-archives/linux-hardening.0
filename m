Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178133C9EEF
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018821; cv=none; b=pJXvbYCGAy3ZFqBf7T1s3arXgcsADWNA3wwxE+0q6jM8W5+sysEznhlN1z45OKHbIcpYVML4SomOUpUu1zwRfJn84AvIV8LlJ9Qe507OuqmnUKGVWd2wpSKOx0A0aj+7uKrB9g9B0jZ6OVrubTrIeMVVgN0Mp4hKLD0nz0uFup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018821; c=relaxed/simple;
	bh=y2fq/B0Ste8ZL4LB615vCRbVd9h9AjaQG4TJxVVO0rQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FpDIqfBAtqrUiZoiyoSEmEuTkFsv2GJHe/zEeGyvP/eZf8RKKiyomcjOlm4z45Kj6k7Kolz8FJtQxBPPXKCTMIdv9EVcBbC+2gDdssqsSjcQQRXA5cpQCH3HWOcEfF20yarziJrscZxyj+NH/7Pjtyq4g5Q2TNq8K4KkEul2Wos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZd3AXuP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZd3AXuP"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so20005035e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018813; x=1774623613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AllHBw18cmDC2YVJSjzRxyh9hUFulIuf1ZVRU3fSw0M=;
        b=tZd3AXuPHFCVKiP5LrHfPv0BDfUfKFh3CzalBGra2ykIjkYfasx4aUgIzv0O9SvMlw
         8GManECpLghmXzTNENUo8N/L/oRjucVmMJCL7HGpmL63elJh70s7R5FRhPeElS3ITPEC
         1V0fw2a3WnDPsrtPamZbE+Fdf/aBNNhkZG1QQ+GGRJ8tcvrX9tAZAUWc3kScLTdG5xVi
         bjv3pEGUSELAV9tmNVsGYTBV/KIdZdZW7tezTezIjmeLTLd0lzD8AX08MH2XdsIImH7f
         Xin5g0q9m94KbHOeGLA3ghdETGLaym5Da4SRvf3m2tFXePiGdLTBQ4kpwtU98BOINkh7
         c7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018813; x=1774623613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AllHBw18cmDC2YVJSjzRxyh9hUFulIuf1ZVRU3fSw0M=;
        b=JXEiwy1dZ6QpBuIA67S37lwzOOfcsNQrqxlFJsM8UOb88eIjtkMn+gdxzHG/Aon71m
         b+eUgyQ5F/4Nrs+6WqT3yQinzamuxyZvRiQPkICiLfgk9GotSEACkWzD6uDKaZaPE0mX
         R3lPVaHZyeqRH4q7N1OQgvPyoKyrttMrbRW7W6uuw0IosdURKyIrbZmL5mOnOQBm1cC9
         HZ2l9M/QvmhfxHSPS3iQkgLDtyhk4B+DdF12t22UV54kU+ftqLPmBiX22nXYyLIJaUR/
         ULgP52K/8y0vRAkAmFwuKSl3NS8hoPi4bxD72CM8cBonHDOUJynSt+7GwSjtN5YCpi/K
         fTTg==
X-Forwarded-Encrypted: i=1; AJvYcCU2YCDxJr1vKWnFrsCw7mknUg95/wJEwrOTlIgNKETkHIQf0e97NIgtxCuTGJ6TWzQLldz/HBKvLfo0Gmaem/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xKRA3gIWU5X5zr4ngProzXIaen6zTFKu0NCagfFL8dAxyowB
	hTWfWO2VJM6+oDJULpS4ldegAJsrpbbs1dAWd0+nWUevgCqfzGbwzDUWOc2vIpo02Bw21L9a4w=
	=
X-Received: from wmaj7.prod.google.com ([2002:a05:600c:6c07:b0:480:4a03:7b6f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8215:b0:485:4388:348b
 with SMTP id 5b1f17b1804b1-486feb5a3camr48030045e9.0.1774018812807; Fri, 20
 Mar 2026 08:00:12 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:47 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3040; i=ardb@kernel.org;
 h=from:subject; bh=mMdF4nB0Sfg+/JaqMNkV+NJRkgmrh0vw+xoaE44MJaI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwvMJ98weNU5ptLIJkv/+Oj2Ay5hDUO1NXFvd89uqx
 9r0Hgl1lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImUzWP4H7t84yyZKcV7+2Zt
 ypvonf/98fKYjb9+hDk/FNIVvnnampvhn0WH35Jm2fqL8y/5SM/0LvQuyv63O988PprzjlyX3p0 nfAA=
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-27-ardb+git@google.com>
Subject: [PATCH v3 12/13] arm64: mm: Map the kernel data/bss read-only in the
 linear map
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
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/mm/mmu.c               | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 51b0d594239e..f7fe2bcbfd03 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -23,6 +23,7 @@ extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
 extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
+extern char __pgdir_start[];
 
 static inline size_t entry_tramp_text_size(void)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 34ad45a2d95f..5332f4ec743e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1102,7 +1102,9 @@ static void __init map_mem(void)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
 	phys_addr_t kernel_start = __pa_symbol(_text);
-	phys_addr_t kernel_end = __pa_symbol(__init_begin);
+	phys_addr_t init_begin = __pa_symbol(__init_begin);
+	phys_addr_t init_end = __pa_symbol(__init_end);
+	phys_addr_t kernel_end = __pa_symbol(__pgdir_start);
 	phys_addr_t start, end;
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
@@ -1135,7 +1137,10 @@ static void __init map_mem(void)
 	 * of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
 	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, flags);
+	__map_memblock(kernel_start, init_begin, PAGE_KERNEL, flags);
+
+	/* Map the kernel data/bss so it can be remapped later */
+	__map_memblock(init_end, kernel_end, PAGE_KERNEL, flags);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1147,6 +1152,11 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
+
+	/* Map the kernel data/bss read-only in the linear map */
+	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
+	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
+			       (unsigned long)lm_alias(__pgdir_start));
 }
 
 void mark_rodata_ro(void)
-- 
2.53.0.959.g497ff81fa9-goog

