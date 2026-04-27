Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E43D6666
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304147; cv=none; b=c27ucQlAeHYAiN6nmQxsvbZWDCya43jsN4le0MU/JAaVulhaWbmX3SvxJSiPgpRRTuqwOAWx7IF9paE90wg/Mg84m0JrTz2RHPJgbRYn+i0GVHVV2PUcpOgub6vhju8NqjFcCrWQuO22mqaIgUmXSMao/CmFsMZdzMpwkD3p3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304147; c=relaxed/simple;
	bh=cnTzZwtV6wM4iTLgIq3xKSD1jkOxl7u/+eyHiVvz3to=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rgO/RPoE0YkYGW/jf7Ws20Ovs4208zo4S/XHICVotPY8JFjM89ZVv6wpBfh7uv+5IEU4JQz4226OX+ktYWvhOfTjm3IDlgyL/oL4JurM3BHlQ4IVw6kNYl0l2hTcauIwS14zMsMJ3suoaiUqhvIp0TSzXZqEBeRjWWkWDSUl1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKeg2180; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKeg2180"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso91347725e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304144; x=1777908944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BA/E6WicDwezK3gyiAo3eqUE5pDQu9c0JrSuIiaUTE=;
        b=CKeg2180Eycn76dTsW0ZLOFNX32fAOUIxWMUB3Bm1289kgHoV/c/2HM6aLwtH5YfyX
         Klm+E07iOM4B3l7uKA+JA6e+1Zbsn7D7OiQcbwN6nWFFFlTnlXMbADSLh4BxdimTOmWI
         iGrzozOK5iz1X7yt5iHeCl/di/m+Er4Gfn2rmX/OtS34zsU0xLcwAETnxYaG95LkB6+k
         GZ2/M5U5fi3037cHj8WWgagRThbHORHaLHwMdMiSrVsiMeskq5dbhto9+Zp+Kkd8Xmy+
         4rzGj5ACJt5WuSUle1q8EDkRug1CiYeqGdI35FCmk2F+O8YgIcKeX2/CdQkh5FvzW27L
         P1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304144; x=1777908944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BA/E6WicDwezK3gyiAo3eqUE5pDQu9c0JrSuIiaUTE=;
        b=A9DsJq82tu+A9/ZkMoRslNrf9QRcxHXdK48zjwoSa0RV8056Wtl8ss4cLLkhahB5VH
         q/zgmrTNJqHAtXxxm9d2n+IbBh8JAuTe8+rFq0SGJk7qpP24oNHuSTVY42OTxdGTxJh4
         RVuwDRxA2eRcRZjgvzEA/7DobmjHr+SeNv2RFw0tRloZN08TAzrHV/28OvonS24HGCEC
         7QxpCb6EBc7j2fkEgZz8E4DPguBg3M6QpLXs7NbuEsOxwHuAGM2Yr1TZVKYL2fDNoqZd
         mx79KPWt0Kwr6tryKzjX0qvibuLVfr9whbW+3LwR9zD/JQkY5cUoojkWyxAvegLHOTiM
         aGpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8eVzFFgQoVSRSdYJFu4JsiU426Ht++F13aDpqdhvtgwluGxU/0MO9c7toqDkroAh3CBX3QSa/POCNZLeRQ3is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyndSWPH0KKsVIvD3FSWM45oxOGjGGEeWojVsJUyyw9q1QZRutW
	ntvJv9i9rdhv8xmrKevXeBrbMkk6kl00kynw2Q+QM0zCgl6lhEP3Bim9C9xLh9UmAh4RN1Ea6w=
	=
X-Received: from wmsl15.prod.google.com ([2002:a05:600c:1d0f:b0:488:7f4d:30f4])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8115:b0:488:8577:d9cc
 with SMTP id 5b1f17b1804b1-488fb77faacmr552964815e9.20.1777304143994; Mon, 27
 Apr 2026 08:35:43 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:26 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2895; i=ardb@kernel.org;
 h=from:subject; bh=KZuPOnzhvCTYIkGg+7u5wsbMT7w/fODSH3EL/0/zagg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E5vLgafBpVHCxz1SUmelxP6Kd3qkdfpFsMXLg9sPF
 WoserK1o5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEykTJOR4TUXe41Hw4vaRzxT
 mGLXWVx6se1hW1uOb3v81vdLAn5m5jP84ZJm0rae256UuMVmRe7sInHmbY93p/Jwyz966BT+h1O dCQA=
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-26-ardb+git@google.com>
Subject: [PATCH v4 09/15] arm64: mm: Permit contiguous attribute for
 preliminary mappings
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
 arch/arm64/mm/mmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4eab40f4aa6f..5e2348b15783 100644
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
@@ -1175,10 +1173,8 @@ static void __init map_mem(void)
 	 * alternative patching has completed). This makes the contents
 	 * of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
-	 * Note that contiguous mappings cannot be remapped in this way,
-	 * so we should avoid them here.
 	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

