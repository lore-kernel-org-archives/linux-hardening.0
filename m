Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240124;
	b=3OEqKZbj8b0JZYk2BdpGcegFBIpVjzuPYwox3jeQG/RkUKEAEofPXghFyU6ZegyUvy59
	 PYdY69sNC+Qz6tyEwzEuCy8OYgHSaWWmZctiA4yl9cXazHG4leNqVLkIUsYts1PV2zFs0
	 hgpxJxQvGsifcGQJVudsNj0rptjE+r9TV63f4/f+GO5q+Au5Vgc5IgYWf/jUSGBeq5enx
	 dqGMoL6MU/0y27coX2p6LRRC9byWStzd7wAVLaFVrCNXB762J4F7uq3KvxoXXKIMub4QS
	 4a9tDmUTli5zsYXWGZLV8PymR+UtY1fkAkOyhko42kgXCd1YXRGMi+Xk9BUbbkmA5wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240124;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=PWH/40FIqyLP2HM1UmBjogshcVKge2e/eg7YNNWZxRA=;
	b=m+rqsHsmPb7VRRa2dDBx/yoo6dNQnQPPuzrdbreVDtM+0ZghVTqz0KOpn73KmBfBGWP3
	 tFlCUmTngYjuUv6IXwMqg+d+4zleOQmBJGVqpwGy+5a68/nNiKjZ6aZqAG39S3ROnr8M4
	 N9COvuYqZn8cdknR5ZrDBmJ/rE1+3ccKcCU7xVZw68DSJgd3KWrPPgzmMg9NHv/NBqDas
	 JlaiVchoogdeDN7r0vffD4sT68RbqMGSXGN6e/9gW4M06H8Ii2kT9/AtQ8VthGr9OyIq6
	 7umNIyjoha2wrEFzpGrkyhG3z1HjRLdb+KTdEsYplcTz69NIMWnZ2f42SCmIQ7uf8bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QLRNhzZH;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECB76082BE0;
	Mon,  9 Nov 2026 16:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ECB76082BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QLRNhzZH
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A7EA14BF;
	Mon,  9 Nov 2026 08:02:00 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D8B03F632;
	Mon,  9 Nov 2026 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240123; bh=4sCNGHUK8a+nA0I4Chgpt6cz5TZ6O43DyF+ejpn7dJA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QLRNhzZHekFuUQsq0AWTGQpNGB046jveGgekZe61G9dbHw6pQV6whq0aia/ObCBvD
	 GJvVFMvBELXTCmcMfJNPrfCHxQtRcb68AtE9sefGlUCYy8GSgQlQyBhrymk9Q+xSFS
	 BoIiDJGW6o0ZJFGFRaIJVFMsdFTDLRa4F46BsE4Y=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:42 +0000
Subject: [PATCH RFC v10 17/22] arm64: kpkeys: Ensure the linear map can be
 modified
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-kpkeys-v10-17-aa6c4d9603bc@arm.com>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
In-Reply-To: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ard Biesheuvel <ardb+git@google.com>, Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=1906;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=4sCNGHUK8a+nA0I4Chgpt6cz5TZ6O43DyF+ejpn7dJA=;
 b=zHz2C3i1VBSSKWpf7Zi8FAzpoWhJ399jCh5pRME6NVSQtdP3NuRk9Ki9LSALcptG8C/7FVprk
 Q8GTwsRXUSLCG2F2oyUmrzX9qBqX+adtMO0X3w7NQkER0tvzXahhAMy
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

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/mm/mmu.c      | 2 +-
 arch/arm64/mm/pageattr.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a61ea65bd496..c1e3260bd0db 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -781,7 +781,7 @@ static inline bool force_pte_mapping(void)
 	const bool bbml3 = system_capabilities_finalized() ?
 		system_supports_bbml3() : cpu_supports_bbml3();
 
-	if (debug_pagealloc_enabled())
+	if (debug_pagealloc_enabled() || kpkeys_hardened_pgtables_early_enabled())
 		return true;
 	if (bbml3)
 		return false;
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 7143bb2dfecd..35f3e8ab0baa 100644
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
2.56.0

