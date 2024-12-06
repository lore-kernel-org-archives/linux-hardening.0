Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361B20127D;
	Fri,  6 Dec 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480026; cv=none; b=MFwqt+f6voFb1J1eJbQgHKRiQ7CEYNJJLLyF5Fx12lrjvybtF5B569qgpvYR01yCXRAVFtmIbrWA59ebBNSX9nJvCgGTLNjzbMT2BWzR+WyIIgJ7OihniB+5OU4FjLMRe80b4Ie2qr5AyXiO1aHl7MxJ/ZTzqy4BPn0UUmlOMsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480026; c=relaxed/simple;
	bh=v63oPnv4YNCZSimALan027RzoLGb6aTQUE4tll0ATKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jX2BmIFts1FL6rQKYTeB+FknHCu7eirJizmD1uFScajnufYJpyvuPp3yz/o64scihtcyeWKOWfzEsnogv65xk6PHqaVXEdVW8vhV/kP++JYF7piCTYGYTOQAuj+xRFkRRab3qRRp03Ajm0P258X7jerMIHHZWEL9Oqw7tHnq61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD1011691;
	Fri,  6 Dec 2024 02:14:12 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3AD33F71E;
	Fri,  6 Dec 2024 02:13:41 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	jannh@google.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	kees@kernel.org,
	maz@kernel.org,
	pierre.langlois@arm.com,
	qperret@google.com,
	ryan.roberts@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH 10/16] mm: Map page tables with privileged pkey
Date: Fri,  6 Dec 2024 10:11:04 +0000
Message-ID: <20241206101110.1646108-11-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206101110.1646108-1-kevin.brodsky@arm.com>
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, map allocated page
table pages using a privileged pkey (KPKEYS_PKEY_PGTABLES), so that
page tables can only be written under guard(kpkeys_hardened_pgtables).

This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
(default).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 683e883dae77..4fb25454ba85 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,6 +31,7 @@
 #include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
+#include <linux/kpkeys.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -2895,7 +2896,19 @@ static inline bool pagetable_is_reserved(struct ptdesc *pt)
  */
 static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int order)
 {
-	struct page *page = alloc_pages_noprof(gfp | __GFP_COMP, order);
+	struct page *page;
+	int ret;
+
+	page = alloc_pages_noprof(gfp | __GFP_COMP, order);
+	if (!page)
+		return NULL;
+
+	ret = kpkeys_protect_pgtable_memory((unsigned long)page_address(page),
+					    1 << order);
+	if (ret) {
+		__free_pages(page, order);
+		return NULL;
+	}
 
 	return page_ptdesc(page);
 }
@@ -2911,8 +2924,11 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
 static inline void pagetable_free(struct ptdesc *pt)
 {
 	struct page *page = ptdesc_page(pt);
+	unsigned int order = compound_order(page);
 
-	__free_pages(page, compound_order(page));
+	kpkeys_unprotect_pgtable_memory((unsigned long)page_address(page),
+					1 << order);
+	__free_pages(page, order);
 }
 
 #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
-- 
2.47.0

