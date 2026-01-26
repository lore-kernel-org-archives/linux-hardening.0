Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A02314B87
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419662; cv=none; b=L04eeTO0hA5sAl7v0wJ4W8DLMC4H+KltP4VRsElHwVBf7s/AEcvjX02D/0waxtsFmadKVUOj4jfY4nAX3EcnvvOGlCSDetgbEZkrNrV2r5BEN3Uh+gzzhPsfLjhewi+oS0oHZ5BtF6/Cfbxbnqxg/WQaV7YXjT75eqeCbKe+j04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419662; c=relaxed/simple;
	bh=fJbjU4lPsrWz5rpCDXB8BW3dRsBQgJaUJe7WcXD0bIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k6TT3NddioGKVNN3EDjPFAsj5fW4Uazi8h4nqEy+G8VUH44IoO2LctypM5bJC2mYjkTR15InWIwoTLWEcK5F08MQH9+cl2EsNdPMx4obpFVI7Y3ew93yvW+VTikrkmd4Pp+pAndVM1cVdyxlrJuh1ei9n+xmMEcEY3J98vQtENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jgBqTZdS; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgBqTZdS"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4802bb29400so76518805e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419656; x=1770024456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7QZsFTSOh849rOV6LRsDiE1RAQq4Vm6P1yBesuKlE0=;
        b=jgBqTZdSiYdvZ2BTP94nU2eax+aNYN+pTw+A4BeF1qblau5OvJ9/THTzI9qBXI1ySo
         syP9l6Eg5ufr8dt1sUDnblH+ern8pOiQW+3sqtX+m1SZ1zPvmFiT4H3f5eu876usDV1m
         FpbmtH5vjPqQWBS8o/xbeRM9g5wac2Eh4KjxyiOLSigRW1gFP3y+4mf+zD6zf5HhAD6V
         IVC7ZFfNkZN3QSACRAugiEJY8MIlwUj6bBqWHJW0RsiHtubXphTEavQGkrqCmW6zXnkX
         B+KJbatbf/Y3WuY0sQV86RfKwACO7iovfpWBKYy7YqHZ2Nuzx7ELenn9eyTHOPZ8RGcO
         T80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419656; x=1770024456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7QZsFTSOh849rOV6LRsDiE1RAQq4Vm6P1yBesuKlE0=;
        b=nE1A6DlhQqQ2Cqtbf5f43Y6X0WnFVTgbIdxG5EqloGB8fdQkjnnF6+Zq+yAPWiGFFA
         DJXryYRMtNyUlgqu/iAdW68bqZxYDuumL7G0uE39n/BOdy4TXXS9Rs4SV9VylkiKtNwL
         PR+lX+LeWdhMjGGwBM9gqFX58DNkzfPO7l4mYBKqKV9vAZrKYnRUXtTaPrwf4V8ctGKJ
         JDZu1LA63Sl+1WrCOBn5maOiKxlok0rBV2fWkCDrVscMMAbwuc8LdxrZ4x0bcD2kczGf
         HmEMXQ9wy0KEn5CTNOY2ryGpf+MiyPrM1q9Q+nS+TuFEoPCKedMNThmP+EGXzQTWHkdF
         03nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJBKl0eVEiMVciFfJaOpuBNouzTDl0nT23EW4J3j7agB5yiYgJrnO2FLfrnayrx+4gppzIMUNpbr3SWpcYe2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz59DCGC7zY2wlM1vz88Zt7EwOp05eMfL8vEpbowAjDxGVodNTG
	MIN9TOMq0SL09BG99gOdKu/W4yuRL94s18Zyz/vOhZls8QUblr7zZRTwGOiygGSi1kYh+cNWCg=
	=
X-Received: from wmba22.prod.google.com ([2002:a05:600c:6dd6:b0:477:988a:7675])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f43:b0:477:a54a:acba
 with SMTP id 5b1f17b1804b1-4805cf5f2b9mr73678575e9.17.1769419656035; Mon, 26
 Jan 2026 01:27:36 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:36 +0100
In-Reply-To: <20260126092630.1800589-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647; i=ardb@kernel.org;
 h=from:subject; bh=gTtNtodtCpnKfAIP/yDCxL7y5gOaP+fLKD5+ODcsG54=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2DP4c6/cvLuKPOWa81fyz1g4a51h+fLeU3u7soOsT
 nnqbnnfUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYS7cbwP99754VFqcZznjJ1
 Xu8xP5ztEZb8nnMu44t3UrWSFo//lzEybHsbpvN4084X24Xl5myK0lpz6udkN5MTqXyGJY8/3xR y4QMA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-17-ardb+git@google.com>
Subject: [PATCH v2 05/10] arm64: mm: Preserve non-contiguous descriptors when
 mapping DRAM
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

Instead of blindly overwriting existing live entries with the contiguous
bit cleared when mapping DRAM regions, check whether the contiguous
region in question starts with a descriptor that has the valid bit set
and the contiguous bit cleared, and in that case, leave the contiguous
bit unset on the entire region. This permits the logic of mapping the
kernel's linear alias to be simplified in a subsequent patch.

Note that not setting the contiguous bit on any of the descriptors in
the contiguous region can only result in an invalid configuration if it
was already invalid to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 4 ++++
 arch/arm64/mm/mmu.c              | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 64d5f1d9cce9..cb2c4525e49a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -224,6 +224,10 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
  * Returns true if the pte is valid and has the contiguous bit set.
  */
 #define pte_valid_cont(pte)	(pte_valid(pte) && pte_cont(pte))
+/*
+ * Returns true if the pte is valid and has the contiguous bit cleared.
+ */
+#define pte_valid_noncont(pte)	(pte_valid(pte) && !pte_cont(pte))
 /*
  * Could the pte be present in the TLB? We must check mm_tlb_flush_pending
  * so that we don't erroneously return false for pages that have been
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 28cc3cda042c..d7faa98f427c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -230,7 +230,8 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pte_valid_noncont(__ptep_get(ptep)))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		init_pte(ptep, addr, next, phys, __prot);
@@ -330,7 +331,8 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pte_valid_noncont(pmd_pte(READ_ONCE(*pmdp))))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		ret = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
-- 
2.52.0.457.g6b5491de43-goog

