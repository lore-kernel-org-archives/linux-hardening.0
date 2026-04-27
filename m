Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FF6349AEA
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304141; cv=none; b=eO0jAsZ5/AAwI13A/lPC1dTymJqczR6G9KeNZwu862rTFRADxqm20F0NgufgN/vlXjjdQ3THOW5QoCR5n+V+dE9pi8Xc3ue36mCNLzu7hSdz3UFX89tTlIHYqYFHPT7qU58ZFw5bm70i5tkVnxL0RhuqwTpcqrBxT+LV/y0cMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304141; c=relaxed/simple;
	bh=dtc12+NMVIXo5ice1yzML7hq7wO8bZW1G1K/irYhX/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYtrLFcqYUhLU3PLT64H2UV8oKYOnPNzeBvwpLg+F4I39iC+/tVn6z2GSw+oWidC+x168DoMBKNAZbP4VndrshEbhKU7NvlBxJ5nHzhy8Yom36b6eZoz80cYgh6Wk1zvJ5cC+Yfx6IHxXxg7Ufztl8JKtp/okiwegrkCJb5mh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhOwhZXD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhOwhZXD"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836abfc742so91557795e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304137; x=1777908937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc51wPzk67h/KJWuIdvgej4c5wVXm+tSlcwLrREqPXw=;
        b=uhOwhZXDvEW9MAb+baj06krBE2oliep+BSSwvPcagHtmnftY0UvBDz8h5JZG3ZQttH
         YlibFwHVummJt6jVvAucwWKEboUeWvz96aXxInErc6+RLWVeWXIP2XkI1LZB8fo3gMV9
         hmA9oPfsmwpXtoLxqtupaavJC+ahMwI57S1/6L37PVg9vP7Fspxon6UsLt1edH4HzafY
         l9ZIWWeA3SejmCt6bJuR3QLas8cTlCfy2CGW+gy7CLiKFtgyK3BrkFRVh7nUNMPP67r0
         dUuYxbsbrmMAIOzWrpquu/jEmC7USnCrpjykRxAl3Yq09EiQkqLgiMz/FXncLgH26H8B
         RfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304137; x=1777908937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc51wPzk67h/KJWuIdvgej4c5wVXm+tSlcwLrREqPXw=;
        b=F4UzyGHMQuGV9QkYSkGx+S4zR/aBgUsUWgtae+PtpkF+aeEh2Mc/KditDmyAgpF3mQ
         GHt1wC6YQbL/C2e5by6aGacdnW8OjimssG8DIiC+Ayr/Brn2cOWz5G434ibWiBMwJb0i
         X8uB/thx6ZilK2qOBR6iwIyU2ykOj3jqzUNdSeZ8zXHzzhOmSpZtrpZIWXfgg+QwRZLy
         u9VVajf+MF/Umhqh7O2Z8EgN8ImICdpshHMv3h9yT8aXcawbJLjRmmDp9NQLEHjdjFWl
         Qxv3ueY1syzv7mj5uD+Vl5ese2x0hwk9/9l5mjJqeafZC17wwHg3qFVqOHGyUNKKwW7Y
         JtXA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZoO1dwx2UwA6KcUTvVLViUqjW1bc+ei9VCVN1NiYj8vv7GacRIvjqNLMQZ6T3pITrELmQDhKhEMm/uB2GbJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/lq/PXkIzN/rh4tFa9F8L5r0J0xWCq9qQ5dQfZjVaXVkrO281
	KGIHZJiBO7+LtCq0y2ArxHPixCPsnc56pckI5gb4ySVnWtOKiWNbn9mcm5iGANRwPCJgh4fCzQ=
	=
X-Received: from wrrf15.prod.google.com ([2002:adf:f98f:0:b0:445:9b34:32eb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b14:b0:48a:52d9:54ab
 with SMTP id 5b1f17b1804b1-48a52d95604mr460176645e9.30.1777304137397; Mon, 27
 Apr 2026 08:35:37 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:20 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=ardb@kernel.org;
 h=from:subject; bh=GHwWYq60lqNuozERz0S434bqDfMxYbnUraaeSVA3Tn0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN947/7X8wOXuLePiOp7MONnvXiUl5NBamL377hk804c
 tjhpENeRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI+npGhoWiYueTlCv3njc5
 eKI4u3WiW9EuwdunmA+vma0g5vHDOoKRYavEAeGovTdWuwnO7aw0j1t2v8qU20TqZU3o42gvDsX t/AA=
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-20-ardb+git@google.com>
Subject: [PATCH v4 03/15] arm64: mm: Preserve existing table mappings when
 mapping DRAM
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
index f084993024ab..801a54ade76f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -256,7 +256,8 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pmd_table(old_pmd)) {
 			pmd_set_huge(pmdp, phys, prot);
 
 			/*
@@ -379,7 +380,8 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		 */
 		if (pud_sect_supported() &&
 		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pud_table(old_pud)) {
 			pud_set_huge(pudp, phys, prot);
 
 			/*
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

