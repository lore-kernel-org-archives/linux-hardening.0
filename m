Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8B407CDA
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203925; cv=none; b=Qrfy4j2NN2gDiBST50bmrUGLxxCAkKA77CmlPvqgxButb29wrsCbIytEAQ1oH8KhCBTTOlP2F1R8dOlHEt8JrR9PvFBBUqFyyoMsc9LSGNZNRydRZX/AxykZYfBjJ+/gDmOagmebFoAoXJDG39xU5KKDBAcnuUzJqvjzfVeAy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203925; c=relaxed/simple;
	bh=BpyhR/DkcI+vdlfgGNG1TzB22JyPApdAXwmLfX2Op64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a4wmHvKXjnjm1Ygu95VgyXg5yBeXGEC6uG5nvwsJrwrONnluUMJL1uxuFJlpSBDm89RH002FV8vJxdUSGYJVWyld2x1/5f1Ay6h69gHEjYRKes/GFecC5m6aTIPw6xTiOKAso5Z9Y5kUcw/K1EnIh9lD4CVgRhpnYBgOh7xmq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0SDucgo; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0SDucgo"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fd233d1e2so38972275e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203916; x=1779808716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwt+xg304itl9Q4y9dyVOqGujD4Vg308m/u0QoJNJxg=;
        b=G0SDucgoMsLF3thAcfoczmim6SmyNOzBWSqKuGOvRZXzLnXmwE+FtsfMBnea9VIjt3
         Dgnd7SgSyaxWfeGE035o6ZwsmK/KT46b1x95zoTJz1a9mDGPx5Yvu7txT9GGrk0LFPh8
         MWEipc8XEqnJeRKPx9XDdqPn2sxng05D6z5Epei0zEBor2NVe0WvpCpKfIsfxidJ/gtY
         B6spQ4dQFSR45jpn0qNjX7drfNgsR9QlWOq0f8B7wJWGMvs1rNx+Emuq286G1Y4C2sIY
         LvyYJ0GTrOBUCFwyaZtjndl+k+zHyjj5Ce4XC2394QkIBYzBC+WK+s/8FCFlNoKwxrJk
         u38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203916; x=1779808716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwt+xg304itl9Q4y9dyVOqGujD4Vg308m/u0QoJNJxg=;
        b=HfL9MeO3AS700V91ajebEQhiqRrUBQt9NLhNl81yWST6qlA6n0SMCNkxd6AmdghOcc
         LrVOusZ/0SEfYYRvxWAMQW2OLhuvPcAJISHZ7You6+MMkCmaeS1KkOJnTmnjONPfh4Av
         fILh5rQL3sxsy9mkkuBNG95JGMansWPryQyXAuzs+ok9paOkiItMpujgN9nFOwzzq3FG
         cFxY777FwzL9CJu373SxzDlTlnNskKNTUhTiR5tLgwp4uC/mZyeM8hFGpWpqIepcFFP8
         4KZa/CDPXUUiEQO8cHAEnriK8tGs1k7gPCvBOms6BU+krw6N4pa0uziewxYBg2YeGaCC
         IPJw==
X-Forwarded-Encrypted: i=1; AFNElJ9dtjfRQEMTGtkHMfRPt18PMOjZQ2ZjdYwfNu9MdCmzTiSbRqLRUv4nIIzKN9ndviwhj2SPV2j7YYTHo90fM8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUuCdnKNm36gQprUtUzg3Uale2Ohfyz6+HwfxmPfb6KQLbNfX
	fop1wRO6r4VcPaaLaM69rXyZlm5tcJpAYQ6DghOnxShg6lxSQvqSPaFHoGnjPTfSsjcktq+WOA=
	=
X-Received: from wrnz14.prod.google.com ([2002:adf:ec8e:0:b0:44c:f516:cbb4])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:10:b0:48f:e230:2a1b
 with SMTP id 5b1f17b1804b1-48fe6630137mr253844655e9.30.1779203916085; Tue, 19
 May 2026 08:18:36 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:26 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933; i=ardb@kernel.org;
 h=from:subject; bh=7JrpdyvPdL1s+/ehcMcKhbiYpfIb7J1bzPCRFLZDLcg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7ryfbU3x9e+3LC5ff7rx1wuN2GTFbXOe32Cu8cvPz
 vnOfNO8o5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExk+TyGf3p7cv4pVosZ/Xm/
 ZG+Uf4emX6NSUtiWg5fCHzPUTj/CqszIsCmn+ghHSolWRsbsiRLlU/nvMRWcb3cMSLc8eOJ2yY5 aPgA=
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-24-ardb+git@google.com>
Subject: [PATCH v5 09/13] arm64: mm: Permit contiguous attribute for
 preliminary mappings
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

There are a few cases where we omit the contiguous hint for mappings
that start out as read-write and are remapped read-only later, on the
basis that manipulating live descriptors with the PTE_CONT attribute set
is unsafe. When support for the contiguous hint was added to the code,
the ARM ARM was ambiguous about this, and so we erred on the side of
caution.

In the meantime, this has been clarified [0], and regions that will be
remapped in their entirety can use the contiguous hint both in the
initial mapping as well as the one that replaces it. Note that this
requires that the logic that may be called to remap overlapping regions
respects existing valid descriptors that have the contiguous bit
cleared.

So omit the NO_CONT_MAPPINGS flag in places where it is unneeded.

Thanks to Ryan for the reference.

[0] RJQQTC

For a TLB lookup in a contiguous region mapped by translation table entries that
have consistent values for the Contiguous bit, but have the OA, attributes, or
permissions misprogrammed, that TLB lookup is permitted to produce an OA, access
permissions, and memory attributes that are consistent with any one of the
programmed translation table values.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 224fec6ce9d7..d4ad9e4766a6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1000,8 +1000,7 @@ void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 			&phys, virt);
 		return;
 	}
-	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-				 NO_CONT_MAPPINGS);
+	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, 0);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
@@ -1028,8 +1027,7 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 
-	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-				 NO_CONT_MAPPINGS);
+	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, 0);
 
 	/* flush the TLBs after updating live kernel mappings */
 	flush_tlb_kernel_range(virt, virt + size);
@@ -1175,11 +1173,8 @@ static void __init map_mem(void)
 	 * alternative patching has completed). This makes the contents
 	 * of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
-	 * Note that contiguous mappings cannot be remapped in this way,
-	 * so we should avoid them here.
 	 */
-	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
-		       NO_CONT_MAPPINGS);
+	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL), 0);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
-- 
2.54.0.563.g4f69b47b94-goog

