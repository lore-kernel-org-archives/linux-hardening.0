Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C23DFC6F
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794313; cv=none; b=Sn7KOdNIs9BOw3obAuqzWwBKCqO0eurZF+wdxbkTqoemxiDzfIEz1CybmpFMobh+Syz2OYNBvOoVa7Igil261Y2I+OpTCY3DeWmXyAyAjIjXxud7e9J20oNfsFPJwNb3yFE8CiQwzMn1iCkXUhxtvib9x4thm4wLEr0Rz5LdTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794313; c=relaxed/simple;
	bh=tdSh+emP90ANDDLr4gHqcl2n9jLxHG0p28D+Gnc4lOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCrorOEgPYeZNMS8554z7PNob3UGDh5SAV16ZoMfQOnnNVYyw/pkJNTfnYFLtWyxtwT8lNyE42me42CR5z158Os/8ZKhZb4WintDkooLsldw4t/TToasdkicdsCIayRzWUWiYMZcRwKuEm8spPYjgerddCWLlR1cRf5ecwU2g+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G6Qh4uyO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G6Qh4uyO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AD62169C;
	Tue, 26 May 2026 04:18:26 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ABD73F7D8;
	Tue, 26 May 2026 04:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779794311; bh=tdSh+emP90ANDDLr4gHqcl2n9jLxHG0p28D+Gnc4lOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G6Qh4uyOUk14RrgWwvp7BlKMYZOIJVQPQyDyGrJ/wn6FiXKVFkyn0lMuRcFJzfGej
	 DFzV1DszD8XXUocbHQkip3oFVB/VukZmNPLOUC4Fwgsk/4enrFmlAsnPDK1b4vca8o
	 t3Hil7XQ68LyxySvYJaOj8elFG/Qyunte2v8kDGw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 26 May 2026 12:16:07 +0100
Subject: [PATCH RFC v8 18/24] arm64: kpkeys: Ensure the linear map can be
 modified
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-kpkeys-v8-18-eaaacdacc67c@arm.com>
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
In-Reply-To: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
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
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779794212; l=1874;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=tdSh+emP90ANDDLr4gHqcl2n9jLxHG0p28D+Gnc4lOo=;
 b=fr6yZ8zM49YMzbl4pAqvIkdQX/UfKJYoPwtJoio3Jal7ikmbiUIgCdawtO09/ldvib7ULH/Mo
 AAKCsH7PRrcAzXVFFVEK/p3goI1iijinMde8JrGEBNZJcPtBkmoSXNV
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

When the kpkeys_hardened_pgtables feature is enabled, we need to be
able to modify attributes (specifically the pkey/POIndex) in the
linear map at page granularity.

Add the appropriate check to can_set_direct_map() on the same
principle as rodata_full and other features.

kpkeys_hardened_pgtables currently requires the linear map to be
fully PTE-mapped, so we also need to ensure that force_pte_mapping()
returns true, like for DEBUG_PAGEALLOC.

Both functions can be called very early, before POE is actually
detected, so the early_enabled() helper is used.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/mm/mmu.c      | 2 +-
 arch/arm64/mm/pageattr.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dc69553d6326..c67b46592af6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -760,7 +760,7 @@ static inline bool force_pte_mapping(void)
 	const bool bbml2 = system_capabilities_finalized() ?
 		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
 
-	if (debug_pagealloc_enabled())
+	if (debug_pagealloc_enabled() || kpkeys_hardened_pgtables_early_enabled())
 		return true;
 	if (bbml2)
 		return false;
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 8f3519400bd1..87543ec660f5 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -101,7 +101,8 @@ bool can_set_direct_map(void)
 	 * Realms need to make pages shared/protected at page granularity.
 	 */
 	return rodata_full || debug_pagealloc_enabled() ||
-		arm64_kfence_can_set_direct_map() || is_realm_world();
+		arm64_kfence_can_set_direct_map() || is_realm_world() ||
+		kpkeys_hardened_pgtables_early_enabled();
 }
 
 static int update_range_prot(unsigned long start, unsigned long size,

-- 
2.51.2

