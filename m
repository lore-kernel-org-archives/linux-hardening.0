Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D936E49F;
	Fri, 27 Feb 2026 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215057; cv=none; b=JWz8Nj7KtrtJuNfn1LGS45c+mQddftzTJ9IuNlmgXa+MCETRrs8WYHQKhneq5hV25/wzEltLXylxw5sqO2xwLZOWXgBHQaVaUTu8JhvTQmbLvytUAiC9Ha3RBDl+bTZurUto9aMWkXEf6cEgSq0JjzoZHktFm2HRxgWRKaOVWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215057; c=relaxed/simple;
	bh=P8IDTj4yF6qDQuR+pa/KMXIkjNEeYrDKFCKpXqXY1Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSiRtG/ZtIhi7x0HWaYUwhcZwOP7dVeTQhcjaQBkOH6Hb+pP3HwEYO1zAizvax+6jR/SEyUMvSP3gRBZjMBa91aNNwr6/MXHV90Blq1B46dq0aHtsDcxVXljsH8Z+tbkFq8q8a29o5rnkTB0BiN/kZLqt6+irl4yrTMMi8uQq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE7E41516;
	Fri, 27 Feb 2026 09:57:29 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8C363F73B;
	Fri, 27 Feb 2026 09:57:31 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v6 24/30] arm64: kpkeys: Handle splitting of linear map
Date: Fri, 27 Feb 2026 17:55:12 +0000
Message-ID: <20260227175518.3728055-25-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260227175518.3728055-1-kevin.brodsky@arm.com>
References: <20260227175518.3728055-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kpkeys_hardened_pgtables feature is enabled, special care
is required when allocating page table pages while splitting the
linear map.

Indicate that such pages are being allocated by passing
__GFP_PGTABLE_SPLIT and use the appropriate interface to prepare the
kpkeys_hardened_pgtables allocator in
split_kernel_leaf_mapping().

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ea1cb1875257..2cee0b7f8a56 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -707,7 +707,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 	if (!pud_present(pud))
 		goto out;
 	if (pud_leaf(pud)) {
-		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
+		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL | __GFP_PGTABLE_SPLIT, true);
 		if (ret)
 			goto out;
 	}
@@ -732,7 +732,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 		 */
 		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
 			goto out;
-		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
+		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL | __GFP_PGTABLE_SPLIT, true);
 		if (ret)
 			goto out;
 	}
@@ -800,7 +800,18 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
 	if (start != PAGE_ALIGN(start) || end != PAGE_ALIGN(end))
 		return -EINVAL;
 
+kpkeys_retry:
+	ret = kpkeys_prepare_direct_map_split();
+	if (ret)
+		return ret;
+
 	mutex_lock(&pgtable_split_lock);
+
+	if (!kpkeys_ready_for_direct_map_split()) {
+		mutex_unlock(&pgtable_split_lock);
+		goto kpkeys_retry;
+	}
+
 	lazy_mmu_mode_enable();
 
 	/*
-- 
2.51.2

