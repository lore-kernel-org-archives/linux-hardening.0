Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934B364028;
	Fri, 27 Feb 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215053; cv=none; b=oYPBcJvsRfKhCiO44X6/xr8PbTx2El2JZJTzKC+DRrurnTtd9qe/doZqF4bIbsxdFXNyzbXv2r4el/Es0rsIYpGmxeUMsddc7srQKYkq1RqRN7GddA61Q2x8NHYNQ+M5d8epHiVvkVLOBD5Kn9hB31tSiFUA8aLajMFPjGk4Df8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215053; c=relaxed/simple;
	bh=cfjyc1N2BcHEcLbNJ4gC5T3UGv+P/Ejs7Sk4aDpPbSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRlZmkCc9p8GmHUJAEEUralrVuFZPo1cueTzgeAD2/xYpppw4WBVw+T2uoL566fPGo2t3/71pSY6tUo90KpwSG7LpXrncnCkOtuZ1akitTxcCvvCzQx3ZNE/y5ZAewc6cNSKiTh2k308+NvvcGi9uQ8YTiaJ0R3ANH0URE6m2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 239D714BF;
	Fri, 27 Feb 2026 09:57:25 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 112383F73B;
	Fri, 27 Feb 2026 09:57:26 -0800 (PST)
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
Subject: [PATCH v6 23/30] arm64: kpkeys: Ensure the linear map can be modified
Date: Fri, 27 Feb 2026 17:55:11 +0000
Message-ID: <20260227175518.3728055-24-kevin.brodsky@arm.com>
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

When the kpkeys_hardened_pgtables feature is enabled, we need to be
able to modify attributes (specifically the pkey/POIndex) in the
linear map at page granularity.

Add the appropriate check to can_set_direct_map() and
force_pte_mapping(), on the same principle as rodata_full and other
features.

These functions can be called very early, before POE is actually
detected. Introduce a helper that returns whether the hardening
feature is/will be enabled, by checking whether POE is supported
by the CPU if it hasn't been detected yet.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 18 ++++++++++++++++++
 arch/arm64/mm/mmu.c             |  3 ++-
 arch/arm64/mm/pageattr.c        |  3 ++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 64d6e22740ec..eeebbdfe239a 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -57,6 +57,24 @@ static __always_inline void arch_kpkeys_restore_pkey_reg(u64 pkey_reg)
 
 #endif /* CONFIG_ARM64_POE */
 
+#ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
+
+static inline bool arm64_supports_kpkeys_hardened_pgtables(void)
+{
+	/* POE is a boot feature */
+	return boot_capabilities_finalized() ?
+		system_supports_poe() : cpu_has_poe();
+}
+
+#else /* CONFIG_KPKEYS_HARDENED_PGTABLES */
+
+static inline bool arm64_supports_kpkeys_hardened_pgtables(void)
+{
+	return false;
+}
+
+#endif /* CONFIG_KPKEYS_HARDENED_PGTABLES */
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __ASM_KPKEYS_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a8e982ac5079..ea1cb1875257 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -764,7 +764,8 @@ static inline bool force_pte_mapping(void)
 		return true;
 	if (bbml2)
 		return false;
-	return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world();
+	return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world() ||
+		arm64_supports_kpkeys_hardened_pgtables();
 }
 
 static DEFINE_MUTEX(pgtable_split_lock);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index d2a7e104a5c2..05e57387c0b5 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -96,7 +96,8 @@ bool can_set_direct_map(void)
 	 * Realms need to make pages shared/protected at page granularity.
 	 */
 	return rodata_full || debug_pagealloc_enabled() ||
-		arm64_kfence_can_set_direct_map() || is_realm_world();
+		arm64_kfence_can_set_direct_map() || is_realm_world() ||
+		arm64_supports_kpkeys_hardened_pgtables();
 }
 
 static int update_range_prot(unsigned long start, unsigned long size,
-- 
2.51.2

