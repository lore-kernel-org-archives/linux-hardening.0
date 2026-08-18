Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26E479889
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062388; cv=none; b=C/X2LmidpL2ou/sJhD3oUUxoK53hEreM8Ka2rMnqh94fK47Zt5F9mwZu6DwbgtnWfCEWJSUxz/FmQjnA6i409dsWKCW50CDNZaJ0FYVZyLj3FZLmGJ0l9SQU1orbrc389LHFeqTLq2oU5u9nyyz8TIdIxbsfvnbipVEQ82m/Dcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062388; c=relaxed/simple;
	bh=3t05Fw3A+f9MIyDqdvDITJQvHNjExASbPyfBJcI1LuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K32hpKVgFN4dHAHtcTGUvq/uzgi9VbJ6YRilL78DPSdIKfnOyL1Hurd3P0BLx/z16xn/UQs6E5Sb+uBWY6DADSO4rBghM32V5SPtGvw4CChGsIhLV3MLelj+YC2tPm34xjWsO7gSM89tfXtWfUzPR0RWQQuXLEIzYo9EVxOz4og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pwLkjCs/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pwLkjCs/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B82BD19F0;
	Tue, 18 Aug 2026 07:13:02 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 047FF3F85F;
	Tue, 18 Aug 2026 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787062386; bh=3t05Fw3A+f9MIyDqdvDITJQvHNjExASbPyfBJcI1LuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pwLkjCs/AMgJE4mllrRzROMnSh51AWur/Cz8aO9KEJaEvhRykqmxkrolfnlet/wDl
	 Jixap6kmpzZqUUqudL01g7v3AlITmPn3FpaeDVEJ41r+Q+6VYINlnMjYEGaR5D73IF
	 2nvDbZG7GwFeyOlA4XC/9+Kjq6eWiKgdjrhQluoY=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 18 Aug 2026 15:09:03 +0100
Subject: [PATCH RFC v9 21/25] arm64: kpkeys: Protect init_pg_dir
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-kpkeys-v9-21-743ad31b2c8f@arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
In-Reply-To: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
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
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787062277; l=1908;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=3t05Fw3A+f9MIyDqdvDITJQvHNjExASbPyfBJcI1LuQ=;
 b=py/irnu2oGc01DHweeRBIz5AEoTp+/gX9Q3vCQ9t0ecqfHJqabMsorRVFPwluZkU7iTiQ7nbh
 0CbEMDQ0cTUAUua6Gls52MN+1metgXlLMKlCJsb1Z8NO6zAvEFvZ6P/
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

When kpkeys_hardened_pgtables is enabled, protect the page tables
that map the kernel image by setting the appropriate pkey for the
linear mapping of those pages.

Most other static page tables (e.g. swapper_pg_dir) should be
read-only both in the kernel image mapping and the linear mapping,
so there is no need to change their pkey.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h |  7 +++++++
 arch/arm64/mm/mmu.c             | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 00e7e5956794..7747af54fd38 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -72,6 +72,13 @@ void arch_kpkeys_leave_context(const struct kpkeys_state *state)
 
 #endif /* CONFIG_ARM64_POE */
 
+#ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
+
+#define arch_kpkeys_protect_static_pgtables arch_kpkeys_protect_static_pgtables
+void arch_kpkeys_protect_static_pgtables(void);
+
+#endif /* CONFIG_KPKEYS_HARDENED_PGTABLES */
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __ASM_KPKEYS_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ee972c78e45c..472ad0f8f002 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1073,6 +1073,18 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
+#ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
+void __init arch_kpkeys_protect_static_pgtables(void)
+{
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

