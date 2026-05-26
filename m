Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F944218B1
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818369; cv=none; b=OJSAvoQHqENVmgL5b2YK93ktj5PFuLeLC0VIdzFXF2wyWOmdrvKuNIu/cQzoP6bdb4Y4W9T2EiRZ8FIMVOH0MN5O5S8TXq9+UbVhaTETGCHhX7Z8vHLLOBM64S4tQiYcYyP4rLUif8CnPDgR8E7Or4QvRKflRp7N+tCQRr2DLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818369; c=relaxed/simple;
	bh=V2TOu05l3UzOFtNXRBGFhB28KhfoYTIhb2a8yVyUWJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nEFmFmDOClNo0oYftGohV7XP1duvgObW5K9kmdOz+ass8nEhufhluzMeiOeySo3Q77T/6Xgk8jqz48sDKtudVirwBDgO+AOF8XDKWcMC6S399QpFRVOso0m7enyCGa6/AdxHpFJ9KdP/t13KQ1HAvwta41mEoDbsCEUA9hpzDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNevinoE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNevinoE"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490261c79fcso37463655e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818365; x=1780423165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mHEuoeqgeJwwKsR5vVxh3j7NIc/RKdm0H7T5NxNZG0=;
        b=lNevinoEY4bvcQ8lEo1Y4FGFq5erahRUD8NrbawyUWXfnGJQuvjLaGZpoLLzHcAH4P
         fdKe7f88EBZGiazEkGQgojvk/15y6eqqmYlBz6HECx2tjUpIHKYMM1MtquZD+LCpJ22V
         lHqiODgB5yoslmeO3UluJVowpsy3RKWp+P8ooiBzpuxhnA61uvMiK4Zs1DKa5MSH9kYX
         MrqUzQ4i9FceSYU44yg3pC7oalu8GaQahP1J6kqWlErkrkoCmCEldCnuujObsNZNJGxw
         hm2N85zV3yYabVqrQFZ7pw/Vde8YYrIJH19A1XEjWsJ/tC5niKQmd5swqrTM0p+gmjt4
         sPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818365; x=1780423165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mHEuoeqgeJwwKsR5vVxh3j7NIc/RKdm0H7T5NxNZG0=;
        b=N0SWHROYY1mMf5fmGo7ZC3Zji/KxAg5ROskyWlrmDd82YqnvMsXn0qmPyvP81eHZ9B
         7PdqcD+0/uKf4kzHmq3r9GWmmKf9pnyFNy0Y5zcLX8t4Q+y5maD0/uAZBIVHIlDZwg4Z
         LpJb2oRzhwREqS+1XapcUn3W8KiiIKrr1riNFAqRifwEWAwdCcHuXFSSfR2T+i+znATL
         OCBEcu3U39C8pVfew6BLWBmUEojNVPBD9tMd1owEM+LDMPBCBqAj9SK6kUoVc6juRB48
         0uUaPqRyfVcOIS2yRRX+SIfyiIfeIgquLuAM482ynwudCznh1266LEGiI0SdxgRN9fh5
         /xsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ooxVEEVYxcTQ7mj7yu4BFZES2QZuslRs+bC3sqcvIVgEfLHGDanb74HLn3EOEq+TJqQDhRJ79mbMqheye8Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdt7Ggkgp5Hy9NO2xbQoFfCu5xtSo0YEmMwn3rt20Ew/QJwcCU
	AyuSoecU9YwaLy03DXiaVNOX5nrrZQSxSOXremGsVgRZ0EM+mj2y7+Ouh1yczqKMQK+BBy2Uzw=
	=
X-Received: from wmbh6.prod.google.com ([2002:a05:600c:a106:b0:48f:de29:3f52])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a402:b0:48f:e230:29f5
 with SMTP id 5b1f17b1804b1-490426b0c92mr233953415e9.16.1779818365325; Tue, 26
 May 2026 10:59:25 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:51 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=ardb@kernel.org;
 h=from:subject; bh=HTVCAgvGTLScrJ2CZV4D8VSId3uhva+Scq8FVpoE17Y=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fgzPcSP+Z1uPSc089cXOMuHXyr/rHy2TE5mx/o6dx
 X9ece7OjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARxViG/1GnxVK2TMh4vX6H
 yFPbSV03ey81Ml2OaYnZZ/vlkGzNih2MDIuvZ3AHycz03hNo9ypyg7OB0C2/DLkSk46sXolZjBl hfAA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-21-ardb+git@google.com>
Subject: [PATCH v6 04/15] arm64: mm: Preserve existing table mappings when
 mapping DRAM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Instead of blindly overwriting an existing table entry when mapping DRAM
regions, take care not to replace a pre-existing table entry with a
block entry. This permits the logic of mapping the kernel's linear alias
to be simplified in a subsequent patch.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b2ba5b35c35f..5c827fa3cd38 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -256,7 +256,8 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pmd_table(old_pmd)) {
 			WARN_ON(!pmd_set_huge(pmdp, phys, prot));
 
 			/*
@@ -379,7 +380,8 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		 */
 		if (pud_sect_supported() &&
 		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pud_table(old_pud)) {
 			WARN_ON(!pud_set_huge(pudp, phys, prot));
 
 			/*
-- 
2.54.0.794.g4f17f83d09-goog

