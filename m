Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB833F4DF3
	for <linux-hardening@vger.kernel.org>; Fri, 29 May 2026 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066947; cv=none; b=WRgtdl4aqVAXoMthANu2N3QQPU8nd9a2VHxV+FyMRqMItkamtT4iIOssktgSc8TZBqYW8Gu4ZLnhEnkEEhHaLd0TeMyp79gbuTHs2rIlo/+HcyN/JlmsphwiN0Xn9e9gLPzaqY8TnD8CsrSb7XG9IsK8heITyEWBLIQFQ1HUx9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066947; c=relaxed/simple;
	bh=4xQdV5XtQmtevKnSBlhcrGlUsurlYKlfMGs9sPmwYVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=op4wR9GKHya8ON+TYS77FNQmd2/ZtdCTBWwTfGXSQPtv9r9d8x4bZk93QGtNE7eGC0hEOljC7r+VqvraLCWkVl6NjauTeJTbYCDOfIqPWNfTnyygJH8Afd5hoxrZ1zJUvB28nn4J7GB5uLioLLHW7UDE3e/aAWqCDdhCGNK35CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKNZK2WY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKNZK2WY"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49041d39887so57610545e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 29 May 2026 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066944; x=1780671744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jiyjEGpnno65e28CupjUd9OJcNW9bWS5umqxs4/DfeA=;
        b=iKNZK2WYm4q6bLi536240S4EfrGCmw2Z5w+TDIe1LCYKftHNdh9PFVThZHRu2lgGf4
         nfoRhLn7HBbPUGh8FfrTC41YxMku246Xd+n7VGpPt1+Tc7QKuTPYmedrmaZipw+RUrms
         gP/SfXaBLt9nvi9BBmo5/HyTRcpdDvwltB9z7FgB7B9MJXdqHF2vpBunDSDlxHqfqwjm
         ZHb/OOdNbwgomMaxq+pxLSmlUwDeMEEdqHBE/KrgCnL5nc4bwaG2OizhX9tMvtPsVYli
         99EGCjGro2cnt2APMhBd5+3jBjGAcmXuWGCAal64Zbswq1YqvAcCV/DKCIEaVk/y8WyO
         4/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066944; x=1780671744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiyjEGpnno65e28CupjUd9OJcNW9bWS5umqxs4/DfeA=;
        b=iLtK5Gb++DsD0ppe3pfZyOgh2Gk7rnRGg0cLvRtEdDOUyLWjr0HJy+YADXwWA2eaj+
         0ldsxGkzkwHxo+w5sWCcyV44O8dkaIhk/Dpq+Hn4H5XjENIkBPEr02GOun2Kx/rKuTiA
         df0xTwI6lrqwTraV29eqOYITnQqQPnYUEzBSHxu93acfKJ9pJEqXcc7VDxiGkTDSdYCK
         HURB/c8vOq1stUZgFSAy9F7SazoTPFT+B+cQ0D0GWvZJ6/YYfGui482L/XTra0/ggpqg
         6lSzj2TFN742Se+DfJPfm8ae1J+n69IIGjSQmZ5y8U7vxMFT+Nax3znqf0uGKwtnfT83
         /ZFg==
X-Forwarded-Encrypted: i=1; AFNElJ/P6Hu5pKn0QYbWaEMSkja+dEz4V9gAazEur1bm0iPXiDXxssVPLJ34mKC3cMhcTug8k7rsb5ZvQncjkpiuND4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHsYVDzvkuVLZ7jbcwsDiQnV6QclrhfEOS5NabESYxBQXbp0gO
	BlIAb8jggMu7tjabHVAAToTA07A9trq+Eqkogv756QGn+FqVOcpIA1HVXgW4RQxLmM3aFcO9FQ=
	=
X-Received: from wmbgx19.prod.google.com ([2002:a05:600c:8593:b0:489:1d25:1a63])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a315:b0:490:53d3:4767
 with SMTP id 5b1f17b1804b1-490a2912114mr284275e9.7.1780066944330; Fri, 29 May
 2026 08:02:24 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:57 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; i=ardb@kernel.org;
 h=from:subject; bh=aFPaV3eZRwZbfRuJcOVglMiqpjLOoyYLSair5CgEE90=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVZr0Ro45KbG/U3TOPQvc7JNkwC0kaWy1cjWvuuPuw
 kXLLSd0lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInMk2T4Z7Hw4UF3Zx6hsg1W
 SuvzdNwYJPwFeT9LdVbN/bJSSk70NCPDCQPV3OWP9bYd/e+4xmP7gWzbOV2yZp1zagvtpm/ydwp nBwA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-23-ardb+git@google.com>
Subject: [PATCH v7 06/15] arm64: mm: Permit contiguous descriptors to be manipulated
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Currently, pgattr_change_is_safe() is overly pedantic when it comes to
descriptors with the contiguous hint attribute set, as it rejects
assignments even if the old and the new value are the same.

In fact, as per ARM ARM RJQQTC, manipulating descriptors with the
contiguous bit set is safe as long as the bit itself does not change
value, in the sense that no TLB conflict aborts or other exceptions may
be raised as a result. Inconsistent permission attributes within the
contiguous region may result in any of the alternatives to be taken to
apply to the entire region, which might be a programming error, but it
does not constitute an unsafe manipulation in terms of what
pgattr_change_is_safe() is intended to detect.

So drop the special PTE_CONT check, but still omit PTE_CONT from 'mask'
so that modifying the bit is still regarded as unsafe.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6b42d724bd1b..d7a6991e1844 100644
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
2.54.0.823.g6e5bcc1fc9-goog

