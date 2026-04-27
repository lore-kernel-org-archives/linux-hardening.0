Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEA3D8113
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304150; cv=none; b=peeK/Dtoat8w61AnOCfauA1QkcB6bBsHt7puDYbQPltzohe2R5Bdm1gBfA1A69pJN63ZjnSKx6NHKKeMpzumR0wzWJVl2Ec8RZnJEeoHzsaFFRfFqVeCTWGPynAb9M9Xr6fwqiUm46Z4nfoWRGJ08/rNTXK2eY8VOv2K4u63BCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304150; c=relaxed/simple;
	bh=xZChKJVKCOn2ZQHxZ9briXztPKj9FQZx9XMBSRmIWus=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cwhEgYw3Ty6W24G4vFi+fbXTP9kD7E7u2TaUqzv6lsbYvmsgAhjLz7sq0U45Rvgi/KbwNENOkiOGkL00/06tTSw1O1V8jCq08pT9AkmF7yPZUjUOattpX9dEhITjrhbSMC3CW7p1xpZByE9blUmAkJ5d6aDx/o1rwuzvYbXrPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAATGf4Z; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAATGf4Z"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so8292644f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304147; x=1777908947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxYPOVRWmcj1klY6tkKd45C/dDkcyiHdqjwOkqhsN/0=;
        b=VAATGf4ZKf0orp+AVPhpwBCMCjAf+JCA+k/LZtRxiBGjxhIs0Aa17J9NDVnnggjXS9
         m0vQRSuEfF2xUkG8D+LGsvmcwt2Dm3tNjhwnFxvwjHlFdCCzQVqm1XfMAjpIW4BnWXji
         LjtHCTf0H/DUZkYPPXcIm5O0uAAfHde7vhE/Sy8A50mmApAbFM4pYVtqyp/p11UG7IYf
         2a/+iJmSHut7eZICyDG97Uqb4Lp8nF4ojWznL2FY9l+eNxXuukjnWcKPgxf0c61RCagw
         Ex42aZcs8Qy3Q50PwuuwIOycNIj6chPTQPmesRJds7mN2DEIp3NwZqjy/W7Zt5LlGTc2
         +LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304147; x=1777908947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxYPOVRWmcj1klY6tkKd45C/dDkcyiHdqjwOkqhsN/0=;
        b=SO6WHrv20r6JCpIwkoNzAd72oGzVNCBaqzpwoTgmKsVj771LmTVQtMa6BkDsxdCYVb
         +2tO7xuxRZVh5r/mfPvLN8CJ+nE/M3LEgW8RjL7ikoPllTmBazc4A6I6fI3Y//0znqvz
         92xAVoRiEijkaFSr2cT3kl4M5yn2S+p0dRcK7GgzHHDuKch+AeNdUTG9EzN0oN5TBUpD
         S0A1H1htpVTzG2TzaE3KuRykTRhccRlSUCjHQ1jxUYYYK3V1pQQP4NcAVvTGGt4ZDayI
         3ygI+TzkslnLuroJit5+vkuFya6hOvKyDH1qDDA43aZs/unjndAhn3eFHR5pqFIl/4vh
         lCuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PMvKy6RvquKAxkzLQWkrBoP1lZkH8CRin3bt6UPXSPP6B1eM5LqRMU4MqzpHIPJM/tHVSidDRtGVGQZYMeag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwonjpZE3tXmsMkv2udhFdsNmPyQdcTCSzgV6aDBmPrkNIai0li
	Ep7TqpgQwfeEabeNvHbgrmVJN9rvuv2fSCxg1Ch6RfkI4o9D8vi5Z2JF49rAPFj8z1Yhf1qqGA=
	=
X-Received: from wrsm7.prod.google.com ([2002:adf:fe47:0:b0:43f:e932:b48d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d88:0:b0:43d:6e0:9458
 with SMTP id ffacd0b85a97d-43fe3e0c779mr67106901f8f.39.1777304147061; Mon, 27
 Apr 2026 08:35:47 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:29 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111; i=ardb@kernel.org;
 h=from:subject; bh=vnOPgzR9gwGy7RU3jbNwlQgfBXncMvaaP3oMs7gg07Y=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E7fhjbPcgs4XVKfeTnOd6X5d81L1wd6JdtmfgucZt
 Dn6GzB2lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlM/Mfwz1hYf8184+dKqf8u
 huwKYeCbfkN1Q8PZ5+f9Qlm8AtrWXmX4Z3804IBu667aItk0A8Wfbn81/Y/98HK+tuNd4pHLyrc 5WQA=
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-29-ardb+git@google.com>
Subject: [PATCH v4 12/15] arm64: mm: Map the kernel data/bss read-only in the
 linear map
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
 arch/arm64/mm/mmu.c               | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 51b0d594239e..32ec21af0823 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -23,6 +23,7 @@ extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
 extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
+extern char __fixmap_pgdir_start[];
 
 static inline size_t entry_tramp_text_size(void)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1a4b4337d29a..9361b7efb848 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1122,7 +1122,9 @@ static void __init map_mem(void)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
 	phys_addr_t kernel_start = __pa_symbol(_text);
-	phys_addr_t kernel_end = __pa_symbol(__init_begin);
+	phys_addr_t init_begin = __pa_symbol(__init_begin);
+	phys_addr_t init_end = __pa_symbol(__init_end);
+	phys_addr_t kernel_end = __pa_symbol(__fixmap_pgdir_start);
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
@@ -1168,6 +1174,12 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
+
+	/* Map the kernel data/bss read-only in the linear map */
+	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL_RO),
+		       flags);
+	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
+			       (unsigned long)lm_alias(__fixmap_pgdir_start));
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

