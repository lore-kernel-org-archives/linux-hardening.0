Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39833364031;
	Fri, 27 Feb 2026 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215062; cv=none; b=g4+Vbo7UH8Xv4k5YRFYDYIgchLfpsWFBbzYPNh1wx+GyAU1Nnf4LAOYFtBSZPsFyzZWPRT2NrSCSrOVW+4lVuVvaJBAaGrl6RMEXWwLWMcoxsfSSo4jXeGVnI6GcKzQouuCD/VKGfpg3/mV6jUg+8oRs2VsA8/kWQoBKTo0y9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215062; c=relaxed/simple;
	bh=4xaZYuingxRN/t3hvCf+IjHey9rMT1T67XbHK/AYuW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZnrpNpQMtn+W9BvlCyYEHJdiaatdtotCAUilD3sBWXJTyyy9bkHvqgwwGWZa7tzMUIi9LGX+VdYojcsLbXjx2wWm0aDORtweTLFJvQcd1WoK/YR96lA37b9655BxeHW9uzSdQHERgdKFjBWzRgs3x0g14gVbRPd+NErJBZ2KjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F69A176B;
	Fri, 27 Feb 2026 09:57:34 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C9833F73B;
	Fri, 27 Feb 2026 09:57:36 -0800 (PST)
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
Subject: [PATCH v6 25/30] arm64: kpkeys: Protect early page tables
Date: Fri, 27 Feb 2026 17:55:13 +0000
Message-ID: <20260227175518.3728055-26-kevin.brodsky@arm.com>
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

Use the dedicated kpkeys allocator for early page tables (used to create
the linear map) when the kpkeys_hardened_pgtables feature is enabled.

CPU features have not been detected at this stage so we use the
early helper arm64_supports_kpkeys_hardened_pgtables(). This is not
a concern as kpkeys_physmem_pgtable_alloc() does not itself use POE
or set_memory_pkey().

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/mm/mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2cee0b7f8a56..7072d5ac0579 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -116,8 +116,11 @@ static phys_addr_t __init early_pgtable_alloc(enum pgtable_type pgtable_type)
 {
 	phys_addr_t phys;
 
-	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
-					 MEMBLOCK_ALLOC_NOLEAKTRACE);
+	if (arm64_supports_kpkeys_hardened_pgtables())
+		phys = kpkeys_physmem_pgtable_alloc();
+	else
+		phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
+						 MEMBLOCK_ALLOC_NOLEAKTRACE);
 	if (!phys)
 		panic("Failed to allocate page table page\n");
 
-- 
2.51.2

