Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9784202F7E;
	Fri,  6 Dec 2024 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480033; cv=none; b=NTuAXpPEUBI0KDQhf6oxNhBWQw7sdyotam7ChmwnujFIMISb4D7ALSqnKf7PMk72J57b69hnyqAdMyGdd5Lj3pBLk5C8TkT6XQ8BWhvnemr5rvMXLfCk0uax/34RSWvfkLGAj2zh+6ytRfyRr/Mnz9pySB6Aey68lY5/PIsD9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480033; c=relaxed/simple;
	bh=pOja1sM50YpIU+w+RhbNwS4Z/W8PzSFIuNa4L8jerOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cqb4rNkaBlwe17H44FVqT4PaxrUT70OaqomjKLz5ijRNveqneuF/QmrQunFjL4RKEzbU50qerga07S2e77WjMDw61ooM9dCGY3//NPeoKgqo/uAUNoLSKVZKdJyhIWm0PVv1ivcWCBi5n0CYuFCqhHpfA2T6Cd2QUDz1YEQJNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58708169E;
	Fri,  6 Dec 2024 02:14:19 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ED083F7D8;
	Fri,  6 Dec 2024 02:13:48 -0800 (PST)
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
Subject: [RFC PATCH 12/16] arm64: mm: Map p4d/pgd with privileged pkey
Date: Fri,  6 Dec 2024 10:11:06 +0000
Message-ID: <20241206101110.1646108-13-kevin.brodsky@arm.com>
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

If CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, map p4d/pgd pages
using a privileged pkey (KPKEYS_PKEY_PGTABLES), so that they can
only be written under guard(kpkeys_hardened_pgtables).

The case where pgd is not page-sized is not currently handled -
this is pending support for pkeys in kmem_cache.

This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
(default).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/pgalloc.h | 21 ++++++++++++++++++---
 arch/arm64/mm/pgd.c              | 30 ++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index e75422864d1b..c006aecd6ba5 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -88,18 +88,33 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	gfp_t gfp = GFP_PGTABLE_USER;
+	int ret;
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	return (p4d_t *)get_zeroed_page(gfp);
+
+	addr = get_zeroed_page(gfp);
+	if (!addr)
+		return NULL;
+
+	ret = kpkeys_protect_pgtable_memory(addr, 1);
+	if (ret) {
+		free_page(addr);
+		return NULL;
+	}
+
+	return (p4d_t *)addr;
 }
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
+	unsigned long addr = (unsigned long)p4d;
+
 	if (!pgtable_l5_enabled())
 		return;
-	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	free_page((unsigned long)p4d);
+	BUG_ON(addr & (PAGE_SIZE-1));
+	kpkeys_unprotect_pgtable_memory(addr, 1);
+	free_page(addr);
 }
 
 #define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 0c501cabc238..3577cc1821af 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -28,12 +28,38 @@ static bool pgdir_is_page_size(void)
 	return false;
 }
 
+static pgd_t *pgd_page_alloc(gfp_t gfp)
+{
+	unsigned long addr;
+	int ret;
+
+	addr = __get_free_page(gfp);
+	if (!addr)
+		return NULL;
+
+	ret = kpkeys_protect_pgtable_memory(addr, 1);
+	if (ret) {
+		free_page(addr);
+		return NULL;
+	}
+
+	return (pgd_t *)addr;
+}
+
+static void pgd_page_free(pgd_t *pgd)
+{
+	unsigned long addr = (unsigned long)pgd;
+
+	kpkeys_unprotect_pgtable_memory(addr, 1);
+	free_page(addr);
+}
+
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	gfp_t gfp = GFP_PGTABLE_USER;
 
 	if (pgdir_is_page_size())
-		return (pgd_t *)__get_free_page(gfp);
+		return pgd_page_alloc(gfp);
 	else
 		return kmem_cache_alloc(pgd_cache, gfp);
 }
@@ -41,7 +67,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
 	if (pgdir_is_page_size())
-		free_page((unsigned long)pgd);
+		pgd_page_free(pgd);
 	else
 		kmem_cache_free(pgd_cache, pgd);
 }
-- 
2.47.0

