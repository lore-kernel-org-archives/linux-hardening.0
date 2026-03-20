Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EFA3C5543
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018812; cv=none; b=VoyuPNDg+XmBg9XtOWk53rMIEPvz9XgytLZFDeEIimkbTWu0Ax7oS8jZ0URADQL5tKLNZWqbFs/eNMV8u51stAvYjFO6WhxF7pg5FDrOp6/yAI8IVzvnh/kjr0jyELb1xnQeAH9e+VeXS34tuYyV0Qr50IeB8JdBW4pW1CIEE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018812; c=relaxed/simple;
	bh=canmmlI35APlaWJNQK0BwtfwphNlOC33tKxAIxRLctg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XUHAvBW4HjR9shfaA11RTlhYvxrF8OuSqwU94krtMQsu+LwaI8aExp2J2y49QuuPVqSJLY6YUX6AmF9PzstpuNB52q8iJT9SlN9rTOtBRwCQ8Js2naK0xbMVyyMUoGiTDwBgPoK6fqkToAtmBSI21eTOjv3zf9vkLJUFXGsWC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e0EZ689I; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0EZ689I"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-486fe3b9441so7199745e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018806; x=1774623606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+nHE9g4Iled9/dsrfh2bAJinc1yfJyvV2ys78zWRafI=;
        b=e0EZ689IBdRnk4PHf+07tz6ZUhlC890vRag/fppf5ejLUJMV1fVzqzC5U32oywIoht
         jLr1eddQwtybnwLUTRzTcAkn83+68oJtKoGnQz6zOl7p8fiyqwSgQPIOObuMDBNW09Rr
         zeKvOB4z2Nnm2RMdOnJ4KC190t+zBr72ZZZFKVpRy2khjzt5IqYUNVV7lPafkYSB1J/v
         TCQJ+qEbsH6yJuoiHqtS5A6//IrFhw4Pnv8IjO2QCCUrXd710f6ESYtbsxpOj0ABmZcj
         GmTzJjCiIazdQU7P+tIL/a3TYYd91Ib0BE0p4tB25QzGO8WgcjvnRf25AN57ONBpI3Sb
         Drbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018806; x=1774623606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nHE9g4Iled9/dsrfh2bAJinc1yfJyvV2ys78zWRafI=;
        b=AI6ee91wzhcpR4eVNiSAgo+7B/ThsuFXd/y/MNSpMXlPd6hlTK8TFEoFDbvYCpJnOe
         k4gR09JC5oGNpAXP3UVjgxOwmH4bUhQIOP/0pWGjFrDLbhGpNt09EPMgR2CDa10/jHeq
         hR+Gu80HNPJ9Mjqb/AvO4gn54g0qzdol2sIXlS0f68r9g4HTd3UyqphN9/ehar+lEmi8
         9CQp8YnVlX38aUhTPSCbbdL+za1of1yDD+oDsMrl90oEDeKe+7CKNvIb91PcfqPoLnQf
         F8BnID8uSrnmy8AaAVC2r+r13/8Mkz2vj4KRZTBfGDF0U9d3JOC+uXY5Ae5rn53R0DTr
         QSKw==
X-Forwarded-Encrypted: i=1; AJvYcCUl58OIBdw39EEKQr5J9iF6ztH84SiqaGc6RpUoeJAK9riDv4ztWLHKW6GAaNjZIU1WTEmhpNVHG7zgcvtoYQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlweGXjvMRWFlG086gqIDWWJYn9b4sQFmU2HM0MnwbKCvSGXT0
	DWJ0Q+Y4J+DlIywCnu5Dwup00T8OXVllB259YMZput4RQo8iyWBhZkLOgGa2vInDBLTUjYct3A=
	=
X-Received: from wmaj7.prod.google.com ([2002:a05:600c:6c07:b0:480:4a03:7b6f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e8e:b0:483:c35d:3659
 with SMTP id 5b1f17b1804b1-486fee04a48mr47773445e9.18.1774018805524; Fri, 20
 Mar 2026 08:00:05 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:42 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=ardb@kernel.org;
 h=from:subject; bh=dhCmT0xhgO1wynakhoxtMTULOKMtch1e7OuwxF75oGw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwoMI8+i12Utr1y67d7vnI7fbJp4TO31Wf/7f9fSZp
 X3oO/cfHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAigkyMDGscNhv8F7vWM/FC
 Br+T9vd3Pc+uP/MPefnRf/d5MatA3WeMDPcY8y/NOCEmXsvdHe7z5c29JU1ceyKN9p2IN9+S579 /KTsA
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-22-ardb+git@google.com>
Subject: [PATCH v3 07/13] arm64: mm: Use hierarchical XN mapping for the fixmap
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

Nothing in the fixmap or in its vicinity requires executable
permissions, and given that it is placed at exactly 1 GiB from the end
of the virtual address space, we can safely set the hierarchical XN
attributes on the level 2 table entries covering the fixmap, without
running the risk of inadvertently taking away the executable permissions
on an adjacent mappings.

This is a hardening measure that reduces the risk of the fixmap being
abused to create executable mappings in the kernel address space.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/fixmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index c5c5425791da..c3dd3c868cf5 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -48,7 +48,8 @@ static void __init early_fixmap_init_pte(pmd_t *pmdp, unsigned long addr)
 	if (pmd_none(pmd)) {
 		ptep = bm_pte[BM_PTE_TABLE_IDX(addr)];
 		__pmd_populate(pmdp, __pa_symbol(ptep),
-			       PMD_TYPE_TABLE | PMD_TABLE_AF);
+			       PMD_TYPE_TABLE | PMD_TABLE_AF |
+			       PMD_TABLE_PXN | PMD_TABLE_UXN);
 	}
 }
 
-- 
2.53.0.959.g497ff81fa9-goog

