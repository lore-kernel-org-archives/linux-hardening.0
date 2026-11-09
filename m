Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240062;
	b=STy0AD1dsXSudgBO6OGDtnS/pYHt1P8hau0CCDZdfhcpuIsyIHT++UZtEVqooYl97y7F
	 krdP9mXOJp5qezJE+sPOGO5c0lCpWtrycvk8NbqNwhzfCW/LtWdt9QtDmtuPBaCYdXVIf
	 I/7R4PTyCIoFWw3+j/rQgDq96cijeso5ENTNkCkJMt+k1269QB0TYN/EOtAxfYHh4aZ2p
	 Gkn0yZTD4atZNP4R6XTf15mNLoSK7IVMweQLanZWfzZeFqviFje4bGdiFexKonQ3JsIx/
	 UAAICKRJjMowMoMxrRjPnM5DewT12jDphZg2tWCNJP06KJsHHrEdgPNx014DGLXk4ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240062;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=w/xadSNxlF1dcE7NrliZqcaX647rTwn6tKWJSB5uaPw=;
	b=DYZ41FGfMPeU9JuniIQdkOlXFwRWcYbuyfcY8IxZQ4iTai0dKelM9duZgudBvSkUen18
	 Bh7XsnJV8tfXem9d0jScMz143s4tboiWkhtdP/AbBwVLUZlDVf7IlDxZJ0JzusT9py77S
	 ndH88pDeoWUcWEmCW61LDFnOeUbgkugI5fyC4ccfiE66rf/O5gEJBuKV1mNOw4XqokOp5
	 kPb93HOQQi50lKd3YWr7vXWW88JSewhA4V9xvGCn9jqHep1+9iIMiP1F8KrFciwtMvRz5
	 LsInEC8VUqw58kfoSrgbt2Ti9YBBPhILS+ymbR8M2smnZYfoEAI5sgeEtiSOU6hhfRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ldaoIdlx;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA75B6082BF7;
	Mon,  9 Nov 2026 16:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA75B6082BF7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ldaoIdlx
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED4381758;
	Mon,  9 Nov 2026 08:00:57 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C7CE3F632;
	Mon,  9 Nov 2026 08:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240061; bh=VFlm1dBZL32mMpdbEZlu0B521tRtjxv6y79g4lyfR7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ldaoIdlxnbqof2ygpu7uoIS36TRPBb0a7KqSQG47lJO/WyvgR3DFvILsv50YAk0y9
	 YPbtFv4E19oYZr9mArtAtTya0NZev3zEDxoQQ+SFGyaoI9nR7OVEAfsZj+yDBnj9r7
	 azx2Nrk5IQtYdL2p6rRsHUcMe572fiAZENG3IiO8=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:30 +0000
Subject: [PATCH RFC v10 05/22] arm64: set_memory: Implement
 set_direct_map_pkey()
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
Message-Id: <20261109-kpkeys-v10-5-aa6c4d9603bc@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=2186;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=VFlm1dBZL32mMpdbEZlu0B521tRtjxv6y79g4lyfR7M=;
 b=VcY+DXHdsUztqYXuF9Z+OxZq5jyyzLtxxEifnN6W5UAiKiDqSWPeuNeQjq7koKky74S76Ikfc
 0B9SJZKJAOlBze/gVmLterM9t1uoECjb0BHcViK70dZmXCfp5Ka6tQ/
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Implement set_direct_map_pkey() using POE.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/set_memory.h |  4 ++++
 arch/arm64/mm/pageattr.c            | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 0091ba12200e..8322615b8ffb 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -18,4 +18,8 @@ bool kernel_page_present(struct page *page);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 
+#ifdef CONFIG_ARCH_HAS_KPKEYS
+int set_direct_map_pkey(unsigned long addr, int numpages, int pkey);
+#endif
+
 #endif /* _ASM_ARM64_SET_MEMORY_H */
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index de7bf95003ea..7143bb2dfecd 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -9,6 +9,8 @@
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 #include <linux/pagewalk.h>
+#include <linux/pkeys.h>
+#include <linux/kpkeys.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable-prot.h>
@@ -319,6 +321,30 @@ int __set_memory_enc_dec(unsigned long addr, int numpages, bool encrypt)
 				      __pgprot(PTE_PRESENT_INVALID));
 }
 
+#ifdef CONFIG_ARCH_HAS_KPKEYS
+int set_direct_map_pkey(unsigned long addr, int numpages, int pkey)
+{
+	unsigned long set_prot = 0;
+
+	if (!kpkeys_supported() || !can_set_direct_map())
+		return 0;
+
+	if (!__is_lm_address(kasan_reset_tag((void *)addr)))
+		return -EINVAL;
+
+	if (pkey < 0 || pkey >= arch_max_pkey())
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
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {

-- 
2.56.0

