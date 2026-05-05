Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C68848AE04
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997312; cv=none; b=i9feIo5xjDpcJROEQEvHYbBwXcW4RhrmFNxoMUnQVWpZHcX1QpPbuQAf7H1j93atrQdiliBW/ky0xmy+wIuD09/KF3zdAWU8aG8lAN04Kb1LLA0vecBOoTNC46xp4gQdaObZd5vqenXPGAh2DoDvHk5qQETAwaOxQKHmxeHCJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997312; c=relaxed/simple;
	bh=qhiAk4es+a9hrujAuX98hvQ0rPx9R/Rfcb8FmcZAQcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3K91A8rlJBPwobxDC9hkSeeHAYWRh+T6Sp/i/5N+PnEIc9kHpZ6ucA9HDIAKVJCnzL0E5n0i6aYMIuzxbCtXmMGZNLFvjn5QGaw6P6nS9tX1aAFCbugBfKzGX1KHcRIUVlYFYRfvEfJTSTSmi2U46NoO2jmI4uR3CbD9xt8T4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cwz5o39n; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cwz5o39n"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28DB02681;
	Tue,  5 May 2026 09:08:24 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6231B3F905;
	Tue,  5 May 2026 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777997309; bh=qhiAk4es+a9hrujAuX98hvQ0rPx9R/Rfcb8FmcZAQcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cwz5o39njUMufkFV/E0d9BSYsSXSRyEQfsh89MROrUiaAJ3fKPzBPCLmV2jNcMgkV
	 TKtMDmvPWNszl76CME8z6Oxk9MxGe8zGwM2FZR5elYgo/eU/0yUnM+4Fp+oigj7s+2
	 MsKdMBhxpuw9E21Th13mvhGN5KyDk4faXlOjRrik=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 05 May 2026 17:06:08 +0100
Subject: [PATCH RFC v7 19/24] arm64: kpkeys: Protect early page tables
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-kpkeys-v7-19-20c0bdd97197@arm.com>
References: <20260505-kpkeys-v7-0-20c0bdd97197@arm.com>
In-Reply-To: <20260505-kpkeys-v7-0-20c0bdd97197@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
 Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777997220; l=1150;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=qhiAk4es+a9hrujAuX98hvQ0rPx9R/Rfcb8FmcZAQcU=;
 b=ceZ8Tc3q1QQobD2wPmnrxyVPJRe6Vy2svFEKe6fDbmwCJ4eSrjWNuIiq0QYIrPVjTZSfk81sU
 W02DQ8PfNnJAMPnkA0VoACZYdH+p6i2wuTjpUcrNQtYJXla/WnL1wEL
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Use the dedicated kpkeys allocator for early page tables (used to create
the linear map) when the kpkeys_hardened_pgtables feature is enabled.

CPU features have not been detected at this stage so we use the
early_enabled() helper. This is not a concern as
kpkeys_physmem_pgtable_alloc() does not itself use POE or
set_memory_pkey().

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/mm/mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f79e82c0674a..4b9218483dd2 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -109,8 +109,11 @@ static phys_addr_t __init early_pgtable_alloc(enum pgtable_level pgtable_level)
 {
 	phys_addr_t phys;
 
-	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
-					 MEMBLOCK_ALLOC_NOLEAKTRACE);
+	if (kpkeys_hardened_pgtables_early_enabled())
+		phys = kpkeys_physmem_pgtable_alloc();
+	else
+		phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
+						 MEMBLOCK_ALLOC_NOLEAKTRACE);
 	if (!phys)
 		panic("Failed to allocate page table page\n");
 

-- 
2.51.2

