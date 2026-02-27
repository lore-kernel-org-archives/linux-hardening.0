Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA2374751;
	Fri, 27 Feb 2026 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215067; cv=none; b=siqFtTbSedywRIMw948wYcOe9/CEL/O7G9b10JKN79nLKcgMU4Eq/a0oVLPCZdXCwnFTWdzky5wkubUOK3i6JvXz9/R+b3zUgWBXI2ln+eZ675ZpoW2g6yyEdNy3/kUXYshRCGFvNyL6QAUHKxxaj2OXS5j7JBdCtfiLaY7IW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215067; c=relaxed/simple;
	bh=t8i0YdDmkUTnxMOryQjr/QUuxT2yjciR8RYHSCZRf0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5yjFP3Jc0vuZX3EMylMCF8WBEkmCYR87Tn5ZHqiMSzmpCr082u5CwOwo3Tb8Ztw2EyjOvFMvMNB1EnL6qgq8PBIezpfv16qyIUvgb1eKeUL/2sQqC7UL+IKM1LskUidtJYU+kZapgEr05daiHCoWDNGGsy9hWFX1R8pfTRN4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33E3014BF;
	Fri, 27 Feb 2026 09:57:39 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FF1E3F73B;
	Fri, 27 Feb 2026 09:57:41 -0800 (PST)
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
Subject: [PATCH v6 26/30] arm64: kpkeys: Protect init_pg_dir
Date: Fri, 27 Feb 2026 17:55:14 +0000
Message-ID: <20260227175518.3728055-27-kevin.brodsky@arm.com>
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

When kpkeys_hardened_pgtables is enabled, protect the page tables
that map the kernel image by setting the appropriate pkey for the
linear mapping of those pages.

Most other static page tables (e.g. swapper_pg_dir) should be
read-only both in the kernel image mapping and the linear mapping,
so there is no need to change their pkey.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

This patch may not be comprehensive - there are multiple static pools
used for various page directories.

---
 arch/arm64/include/asm/kpkeys.h |  3 +++
 arch/arm64/mm/mmu.c             | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index eeebbdfe239a..2d8bb1e25e3b 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -66,6 +66,9 @@ static inline bool arm64_supports_kpkeys_hardened_pgtables(void)
 		system_supports_poe() : cpu_has_poe();
 }
 
+#define arch_kpkeys_protect_static_pgtables arch_kpkeys_protect_static_pgtables
+void arch_kpkeys_protect_static_pgtables(void);
+
 #else /* CONFIG_KPKEYS_HARDENED_PGTABLES */
 
 static inline bool arm64_supports_kpkeys_hardened_pgtables(void)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7072d5ac0579..1e2cf0166c1d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1048,6 +1048,19 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
+#ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
+void __init arch_kpkeys_protect_static_pgtables(void)
+{
+	extern char __pi_init_pg_dir[], __pi_init_pg_end[];
+	unsigned long addr = (unsigned long)lm_alias(__pi_init_pg_dir);
+	unsigned long size = __pi_init_pg_end - __pi_init_pg_dir;
+	int ret;
+
+	ret = set_memory_pkey(addr, size / PAGE_SIZE, KPKEYS_PKEY_PGTABLES);
+	WARN_ON(ret);
+}
+#endif /* CONFIG_KPKEYS_HARDENED_PGTABLES */
+
 #ifdef CONFIG_KFENCE
 
 bool __ro_after_init kfence_early_init = !!CONFIG_KFENCE_SAMPLE_INTERVAL;
-- 
2.51.2

