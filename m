Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4431E842
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203906; cv=none; b=cNlmunI50lC1nVGAoTFSTvo1YgQfxMKxKsVEH2vP/a5ybNlkpCYDTavociQKDrxSFg7XeIv2rXlMYUamZUmMipCgqUONCJh5Y/4UqDoHia9ni+a8kq28KocNT6uyw7Jc/3gS7gwsY/J8xG0Q/AgA9F02lA2UXrz9pE2d8OTNUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203906; c=relaxed/simple;
	bh=EcCV5oiqJ9JAPSVTsVn4yK+SKuY8ffWGfqNYSRswBVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nLgrsPRsBsqc6n8vPRLfpK6DR1FG8FbRPfaZEHGt1cu3gGRQ4uA8h0RXp+GtF+/fup37z/dlPz26leIOo0bv6ExyHVObNjumeMY4sqHnosyjwA2R+qg3y4OqrgjTy/0DItc9aaJ49hg2iWzNxhdI3094UgVU/4pUhR5ybt6BhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P0UBYXvq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P0UBYXvq"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-44ffa15dc8cso2183134f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203898; x=1779808698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5i5xhw6twfeNJpf3X2JDAmvPKwL/v73NW4xnl1R+ac=;
        b=P0UBYXvqq553Ac3DEB4dR/ZBAqVnRjmAhZ4dII3cBHQkEYHG/jBqRZQEY2ZqbuFl6K
         p7MfkxeVrE0kZW1GMo6SBtZQ95NunAk51LIMN7Cr9/kZT6HaKKeegrpjL9bb4S8AlQRj
         YYHKz+XX07X3PuttfZCsXmpg8BzgipPuCrAs7TMqEMAwHOMg+Yn4S/HKulCIBjRin2Qv
         7iNcEiG/DuPaAyby5T4/aXE47YW7yY25YCBxgIt76sp+XgkhcgeBGTArmJNDFpNxw/Ss
         UtnXxcCeyKrIbiRHVzWLbpMYtwHtTgY6+hfVJIZcYXb3YSifHCBX8x/zIl5tLkWjNNQu
         eEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203898; x=1779808698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5i5xhw6twfeNJpf3X2JDAmvPKwL/v73NW4xnl1R+ac=;
        b=E6G8ckb4iH9eEd9EpyLeuFVo0l3Ui8Ha2M+NXKHVN9e+R70SLtebLuDsaBmeLX1qjT
         BIe41omFmtB8TSLPeE41uYYp8VQpFSEY6r3c0J4QX0Vw8RAsnYv1ThjBjf+0WHCDNcCo
         9xTAsloXjATMAQUHCABDe9k0rzRwMKxJ6PLcbx7pbRIKgFRCgy2W0XyJsRL0yz1/k7jn
         ctKue4cCExlIjnfEWmGPg5LBPsR+3cyaRYorCqk33YO7FDdSpF/D7lXTQDijeztNKF+y
         ZA8oKDCWxNkAEycAPpoCFpng+KBs+jtNKnf4RaMEv6r7giZYcvkerfKCMb6NWHVHvlX/
         POfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cRWgCZFNxFFcJlY36yYld6DfRrNZi5Dx/Btgg/PNOtgcAP+w/B5k9kcl1+S9i0W9rIoxNffb7MI7J6QKlzNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLf3OyuB82JInLcoFT3nw5MJBpEjBpi1B2RC4sKSEdmElVinc4
	+EMzCeRMWrE0iLtC6BWfAFh9NZE9kur+rUBRevEwvWvWCkKk1C3z0qbpcjlnhlLPAn6l9f0GkQ=
	=
X-Received: from wmbh13.prod.google.com ([2002:a05:600c:a10d:b0:48f:de63:8504])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:314f:b0:490:389:7644
 with SMTP id 5b1f17b1804b1-49006db5bc0mr175687615e9.17.1779203897655; Tue, 19
 May 2026 08:18:17 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:19 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=ardb@kernel.org;
 h=from:subject; bh=Q2W2jspPsv5GaJ5WLwu7DWsztQb/bK6wx+1BuMiTXuk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7sieu88v/5i8jruVR773wtIjbld/Wm40nSSe+cjgw
 YcLqYJ8HaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiGZMZ/nBZtdgr2B5a5Wj+
 iUmAZ231tSsO7SFntz3bed73yPGbq/8yMpwpsb8stmR1T9S10AhOGdXn+2LnfX0psDCo8O08yUs 6T7kA
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-17-ardb+git@google.com>
Subject: [PATCH v5 02/13] mm: Make empty_zero_page[] const
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The empty zero page is used to back any kernel or user space mapping
that is supposed to remain cleared, and so the page itself is never
supposed to be modified.

So mark it as const, which moves it into .rodata rather than .bss: on
most architectures, this ensures that both the kernel's mapping of it
and any aliases that are accessible via the kernel direct (linear) map
are mapped read-only, and cannot be used (inadvertently or maliciously)
to corrupt the contents of the zero page.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pgtable.h | 2 +-
 mm/mm_init.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index cdd68ed3ae1a..67aa23814010 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1993,7 +1993,7 @@ static inline unsigned long zero_pfn(unsigned long addr)
 	return zero_page_pfn;
 }
 
-extern uint8_t empty_zero_page[PAGE_SIZE];
+extern const uint8_t empty_zero_page[PAGE_SIZE];
 extern struct page *__zero_page;
 
 static inline struct page *_zero_page(unsigned long addr)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..46cf001238c5 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
 EXPORT_SYMBOL(zero_page_pfn);
 
 #ifndef __HAVE_COLOR_ZERO_PAGE
-uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
+const uint8_t empty_zero_page[PAGE_SIZE] __aligned(PAGE_SIZE);
 EXPORT_SYMBOL(empty_zero_page);
 
 struct page *__zero_page __ro_after_init;
-- 
2.54.0.563.g4f69b47b94-goog

