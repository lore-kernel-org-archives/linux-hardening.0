Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D786363C66;
	Fri, 27 Feb 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215001; cv=none; b=UhJ3VQtHdlM12Bf8TdJXgE1xzJyYFugsDvflyCLtP5UyoxLIt0mGx/QB+kailjF8S0NZdudKiV2HQOWqJEtfPr8niwEDwfoRFcXlyWzugS6apUlpCmgXn7Kno9ZwjydgCAkmatmcligTbbPEgO4bqs71KqZxy4KNLIRrqSIDx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215001; c=relaxed/simple;
	bh=DSRz0ft16I55q/YdDAb4nkK38iW/aQXbvk1YjCDesxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZqztgW7vBZDTEFG2BYDGjQkRr5OtyeRM0Q4IESz0efJi+moL+vdTANU0Gm90Dri+gWq2LYmDnM4ttqFp9i8jUaP9isO/L1X9jzpYX0zsxgOlFESk0ujm8Hw4Q8z2SFN/GZYKLf3R1WBFqtWGlSKxKF/KfpsxxQKmEWAZs7wt1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B0491516;
	Fri, 27 Feb 2026 09:56:33 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74D793F73B;
	Fri, 27 Feb 2026 09:56:35 -0800 (PST)
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
Subject: [PATCH v6 12/30] set_memory: Introduce arch_has_pte_only_direct_map()
Date: Fri, 27 Feb 2026 17:55:00 +0000
Message-ID: <20260227175518.3728055-13-kevin.brodsky@arm.com>
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

Introduce a helper that returns whether the linear map is fully
PTE-mapped (i.e. no block mapping is used). This is a runtime
decision for some architectures, hence the need for a new arch
helper.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/set_memory.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 7b3a8bfde3c6..c6df55422da2 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -58,6 +58,19 @@ static inline bool can_set_direct_map(void)
 #endif
 #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 
+#ifndef arch_has_pte_only_direct_map
+/*
+ * The default assumption is that the direct map might be created using block
+ * mappings (PMD or higher). An architecture may override this if the direct
+ * map is fully PTE-mapped.
+ */
+static inline bool arch_has_pte_only_direct_map(void)
+{
+	return false;
+}
+#define arch_has_pte_only_direct_map arch_has_pte_only_direct_map
+#endif
+
 #ifdef CONFIG_X86_64
 int set_mce_nospec(unsigned long pfn);
 int clear_mce_nospec(unsigned long pfn);
-- 
2.51.2

