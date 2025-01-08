Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931501FA8F7;
	Wed,  8 Jan 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332483; cv=none; b=ULRcigrdUlsOAvsyvomujsnlrF/DFzKy1tckHyDRPu8wU12q2KjFBTh9sU0uB6UJ797nhD8kpSkcktYZMvaSz329f9LC57HrFHEb3X+HaqLQapo5younk5oWuS+QYe2HLFhSR7Z/GFDYPXFYRkcQZROSZaX/dgdZsiqquRrKGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332483; c=relaxed/simple;
	bh=V7NBXEVq5k2syMALHZPsYhgC4AXMseqyJ8n/LS87KSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNiwZNUMR++c3EWhErE+aOCI9yEsXBg9kBTMSrUNrKLCw+kbuBV+W5JjMitrSFx7q+390WhifvRrs99eUkNX7LhNHB0+DDt28WJo4n5RC+kU/8wiPMlNANUY9kqTQrBU/i4TLB19TU3eB41j6iFsoetKtBogmhgWUy48tMC3/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B350176C;
	Wed,  8 Jan 2025 02:35:09 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31B3A3F673;
	Wed,  8 Jan 2025 02:34:38 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH v2 10/15] mm: Allow __pagetable_ctor() to fail
Date: Wed,  8 Jan 2025 10:32:45 +0000
Message-ID: <20250108103250.3188419-11-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108103250.3188419-1-kevin.brodsky@arm.com>
References: <20250108103250.3188419-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding construction hooks (that may fail) to
__pagetable_ctor(), make __pagetable_ctor() return a bool,
propagate it to pagetable_*_ctor() and handle failure in
the generic {pud,p4d,pgd}_alloc.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/asm-generic/pgalloc.h | 15 ++++++++++++---
 include/linux/mm.h            | 21 ++++++++++-----------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 892ece4558a2..9962f7454d0c 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -173,7 +173,10 @@ static inline pud_t *__pud_alloc_one_noprof(struct mm_struct *mm, unsigned long
 	if (!ptdesc)
 		return NULL;
 
-	pagetable_pud_ctor(ptdesc);
+	if (!pagetable_pud_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
+		return NULL;
+	}
 	return ptdesc_address(ptdesc);
 }
 #define __pud_alloc_one(...)	alloc_hooks(__pud_alloc_one_noprof(__VA_ARGS__))
@@ -227,7 +230,10 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 	if (!ptdesc)
 		return NULL;
 
-	pagetable_p4d_ctor(ptdesc);
+	if (!pagetable_p4d_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
+		return NULL;
+	}
 	return ptdesc_address(ptdesc);
 }
 #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
@@ -271,7 +277,10 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
 	if (!ptdesc)
 		return NULL;
 
-	pagetable_pgd_ctor(ptdesc);
+	if (!pagetable_pgd_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
+		return NULL;
+	}
 	return ptdesc_address(ptdesc);
 }
 #define __pgd_alloc(...)	alloc_hooks(__pgd_alloc_noprof(__VA_ARGS__))
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 453a26bcad1a..e99040be477f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3076,12 +3076,13 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
 
-static inline void __pagetable_ctor(struct ptdesc *ptdesc)
+static inline bool __pagetable_ctor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
 
 	__folio_set_pgtable(folio);
 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+	return true;
 }
 
 static inline void pagetable_dtor(struct ptdesc *ptdesc)
@@ -3103,8 +3104,7 @@ static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
 {
 	if (!ptlock_init(ptdesc))
 		return false;
-	__pagetable_ctor(ptdesc);
-	return true;
+	return __pagetable_ctor(ptdesc);
 }
 
 pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
@@ -3210,8 +3210,7 @@ static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
 	if (!pmd_ptlock_init(ptdesc))
 		return false;
 	ptdesc_pmd_pts_init(ptdesc);
-	__pagetable_ctor(ptdesc);
-	return true;
+	return __pagetable_ctor(ptdesc);
 }
 
 /*
@@ -3233,19 +3232,19 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 	return ptl;
 }
 
-static inline void pagetable_pud_ctor(struct ptdesc *ptdesc)
+static inline bool pagetable_pud_ctor(struct ptdesc *ptdesc)
 {
-	__pagetable_ctor(ptdesc);
+	return __pagetable_ctor(ptdesc);
 }
 
-static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
+static inline bool pagetable_p4d_ctor(struct ptdesc *ptdesc)
 {
-	__pagetable_ctor(ptdesc);
+	return __pagetable_ctor(ptdesc);
 }
 
-static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
+static inline bool pagetable_pgd_ctor(struct ptdesc *ptdesc)
 {
-	__pagetable_ctor(ptdesc);
+	return __pagetable_ctor(ptdesc);
 }
 
 extern void __init pagecache_init(void);
-- 
2.47.0

