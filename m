Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B3376A10
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203914; cv=none; b=hKse0dX8Oy3auG8M8X8oSh2XBtXpoGmp67Ywl4SP5saqvm+tPrCr+eB8iEstuMKm3xqJvjbTCN+hWWcXcS+autUbQgOg7PvafQMZzH6qTLdNIRfEDJ89ngTpiaBU4VBwyjkRK8yMUmSjuknVQDZ23NLM1pS4KtUqoPU8xBwyx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203914; c=relaxed/simple;
	bh=jjYhcW/kbMDe/UK3BjYp/roCAIoFYhxhPdWkrX5A06k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pl6gfg2yguExAHTZKsGWhTYLKQH2gbHR/W1FnAgyHAe2bJbaelza+lV5DlbmD369oux4AFeQfMItRYH8ySWTpYeaCcH1kI4vFlr57akIMHmZDpQN5BnzSyqdFloQQQTWCvd4APT4guU6MLZZHhlLbkmtC1Q3xgD30lZ6+cNQlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcRwsfZ+; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcRwsfZ+"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4518f777225so3094559f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203906; x=1779808706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjHc0cb+NE/2F+UEf5a5kfxEL68f5+QTn7aAzw8hvjg=;
        b=wcRwsfZ+aBSlJb8766MA0/9RIx4rvlwgXgZj6ybY4JwkKt//yBUeqaTFtd0z3DfV84
         ne7hIobT6wcWB9dgOvDI4AAutO/jz71PbYZHkVe0/Tpuo1AixXcrPKVcaAaI1S+MNI4o
         mDWCSJnbDQJkSsIyBzVr/lkad2nDB2Q6vNdWXKf8+mIrBRZNTOJX6mVzPObICdKnonlR
         k5x387lzrwYdQrIrQ8ujUGOnOn3ZVCp8g0ZKexuMxD/FDfygyHVrx18iSE6cIC5bq2Vs
         AYBy0+PbmZnT4JL+PT3N+i4iHk33ZJq8ifPPXQnE4ea6igUM6rRJTAiizD0j0819E5zV
         Kt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203906; x=1779808706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjHc0cb+NE/2F+UEf5a5kfxEL68f5+QTn7aAzw8hvjg=;
        b=h6sFYnLc5Ntu7NsM7u6OvrWXjigfAlbNt0rkYAiiZYqbOohcvfyqK4hpoiY7ltqTFY
         JjFU2oRyO7NmlMbG5nsD3kbV/3kVsNCRGdlDEy96KIAO03gjapFTiHjN1UfVLCvFdNqW
         RAO9dzhyCCDIsBIMTJ+2nyG2gTAsm48jxSO34649NOUU/fMGGevvv+RGBCJmicWwdlKz
         /tG29VNV3WA008Va+IviE/eCkC0frgz5B8TTgTlXrfayIhX+SYv+7YU9iXO82znKuHYI
         ROdAgaMLOr7wzoSMNgYk3+9o6GkZJ9MNv6RqWTw/N2c9D/oxv7pWz/xq1IUW1cRjFtxF
         F68w==
X-Forwarded-Encrypted: i=1; AFNElJ/kh6hHDueAI25pGGdt3pf2NA+gClTVkEmNX6iPMe4svK2xhHX2IbIbOCg5qr0/mlDiv+dnycF9vU5SrwEJeL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRZ4T3OwLUGQC7ieCFnz1WX+sx6LvVQav/PS9NmKVkXM90gGl
	1lMLd2YD+gv6khHEV6kY6321VLvr3X+Vv+PRm3G2ZcBMbxhSOMBJ5d9sw09SKUYKQ5hV/7N08w=
	=
X-Received: from wrjb13.prod.google.com ([2002:adf:e30d:0:b0:45b:cad1:2df1])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2c06:b0:45d:4fc0:fe0a
 with SMTP id ffacd0b85a97d-45e5c5dd346mr33349921f8f.32.1779203905296; Tue, 19
 May 2026 08:18:25 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:24 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=ardb@kernel.org;
 h=from:subject; bh=DzlMi7mku98t808/4L/IevsaqNhHNBA7ZPaOWGTKp3M=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7ozjx5JHO2c9Tvz2bbb1UYGuFVGxfyOk/Lcl39l/K
 H2HsKVMRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI0z2MDCcD0w4yfjZVbdjI
 l/1mdYzWeoF7uf/65CXWOutIPTyn6s7wz/CboZoY8yGh2dyvFDVyd1ef1EtQfpqkvm298dz7pw+ +ZwAA
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-22-ardb+git@google.com>
Subject: [PATCH v5 07/13] arm64: mm: Permit contiguous descriptors to be rewritten
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

Currently, pgattr_change_is_safe() is overly pedantic when it comes to
descriptors with the contiguous hint attribute set, as it rejects
assignments even if the old and the new value are the same.

So relax the check to allow that.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0405fac18959..7cecd25aa83b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -134,10 +134,6 @@ bool pgattr_change_is_safe(pteval_t old, pteval_t new)
 	if (pte_pfn(__pte(old)) != pte_pfn(__pte(new)))
 		return false;
 
-	/* live contiguous mappings may not be manipulated at all */
-	if ((old | new) & PTE_CONT)
-		return false;
-
 	/* Transitioning from Non-Global to Global is unsafe */
 	if (old & ~new & PTE_NG)
 		return false;
-- 
2.54.0.563.g4f69b47b94-goog

