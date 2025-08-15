Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B982DC326;
	Fri, 15 Aug 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248157; cv=none; b=DGH+fP32BwKFdKBdfeAPF/tzArOpX0/g4N5eGVLBeGuYMV3feQAk8UOQrxONM9Fk7jZbsdDVuInQq0+tgnn+wIjY3W9FzHMScCF7a5CFd84m6AMphbF4ns9k+6lgcVr3u9QeX8m0U0YuWBiacMyIO9JU4K+ICvnXmKI5MNE3vNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248157; c=relaxed/simple;
	bh=P2f0g0pfPqMGxvKXFobQpWgGSAUwBOVDNqc/pTSJKNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSmTlFvYVE1DBG5+PG7KcDYlhRV4MLJ2D0s1ScB43rbIBoZKpPMSmfuoQaKuif+yy9Nx7iBDYgLdwO5HeEx7uRCiLdJp07XqY1UNgHPUwC/sFG0HcIR++MbppctFTSB08d4fEuVE4wWD9HGFVWp0YDDeFdwaHle02Wuab4Zy/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 619F51E32;
	Fri, 15 Aug 2025 01:55:47 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 076A53F63F;
	Fri, 15 Aug 2025 01:55:50 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH v5 06/18] arm64: set_memory: Implement set_memory_pkey()
Date: Fri, 15 Aug 2025 09:55:00 +0100
Message-ID: <20250815085512.2182322-7-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250815085512.2182322-1-kevin.brodsky@arm.com>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement set_memory_pkey() using POE if supported.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/set_memory.h |  4 ++++
 arch/arm64/mm/pageattr.c            | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 90f61b17275e..b6cd6de34abf 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -19,4 +19,8 @@ bool kernel_page_present(struct page *page);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 
+#ifdef CONFIG_ARCH_HAS_KPKEYS
+int set_memory_pkey(unsigned long addr, int numpages, int pkey);
+#endif
+
 #endif /* _ASM_ARM64_SET_MEMORY_H */
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 04d4a8f676db..41d87c2880fe 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -8,6 +8,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
+#include <linux/pkeys.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable-prot.h>
@@ -292,6 +293,30 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
 	return set_memory_valid(addr, nr, valid);
 }
 
+#ifdef CONFIG_ARCH_HAS_KPKEYS
+int set_memory_pkey(unsigned long addr, int numpages, int pkey)
+{
+	unsigned long set_prot = 0;
+
+	if (!system_supports_poe())
+		return 0;
+
+	if (!__is_lm_address(addr))
+		return -EINVAL;
+
+	if (pkey >= arch_max_pkey())
+		return -EINVAL;
+
+	set_prot |= pkey & BIT(0) ? PTE_PO_IDX_0 : 0;
+	set_prot |= pkey & BIT(1) ? PTE_PO_IDX_1 : 0;
+	set_prot |= pkey & BIT(2) ? PTE_PO_IDX_2 : 0;
+
+	return __change_memory_common(addr, PAGE_SIZE * numpages,
+				      __pgprot(set_prot),
+				      __pgprot(PTE_PO_IDX_MASK));
+}
+#endif
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 /*
  * This is - apart from the return value - doing the same
-- 
2.47.0

