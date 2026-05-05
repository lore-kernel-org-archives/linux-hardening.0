Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35948B366
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997317; cv=none; b=FmAQMSEmc/zhTgX44FcJq6yCXkFufRduIJNJNecFwfgWtoloOZFJeRNw107BKMLM74XYj7v1fZk0LErXN01yhFo7bNvLYJH0kykwBnvHMbpFSWtjKlGlhI9WAHCpw0rMxGiRWh+DcFzzgBfTdUJfXzGi9/w2h0+Q53NqEFEyqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997317; c=relaxed/simple;
	bh=0t/i/af7XbPJAM8LRw7f7gNVe6Lqn8pDjULpf1JYXBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c6qqB/1mKSDylmc1CW8ee2bkFVQn5Ouil3AtLnUjGbyjVqSYlFysjpaIoqowLDPWSCBUF5/Dt8Kl8jRcw9DVwDocTNlGKRdAoCSBaBqXJ/uSlf9NHS1IVA1DbgMPpRbE2nbVb3RoKLyU/YuQNUUVbOZf/MrGQ7ZLztA42vACiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SF6Ni3DH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SF6Ni3DH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9588814BF;
	Tue,  5 May 2026 09:08:28 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF7AF3F763;
	Tue,  5 May 2026 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777997313; bh=0t/i/af7XbPJAM8LRw7f7gNVe6Lqn8pDjULpf1JYXBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SF6Ni3DHfg3cr3g1wGonGVfVeGZWjyIIj12L52MNiRx7v3ly3BLW5woW8lEXXJrEB
	 Dg3rAyjjcetccCXjgz9E4QIJYNmvaXRK+YXjWoHRtd+5kSyH9d5NFlgf3kj7tXVSfU
	 mw2oS1KMTotj0U/1TXo+uCvRLQibhnRnRdiOE5To=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 05 May 2026 17:06:09 +0100
Subject: [PATCH RFC v7 20/24] arm64: kpkeys: Protect init_pg_dir
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-kpkeys-v7-20-20c0bdd97197@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777997220; l=1970;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=0t/i/af7XbPJAM8LRw7f7gNVe6Lqn8pDjULpf1JYXBk=;
 b=8O9rU2WpeFiig0WwB/55Pw3dRg5PB0MCy4d/wM+xL2uu2T2n6EVglq54KE7Cu8c6GFeCbvk4c
 2rsHMMhC1tOBX3m4pUGvVy/6bqpBhQunPbd4GPrmI/Jt1MJl9FO4Or+
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
 arch/arm64/mm/mmu.c             | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 0c155b970582..71e2035566f4 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -64,6 +64,13 @@ static __always_inline void arch_kpkeys_restore_pkey_reg(u64 pkey_reg)
 
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
index 4b9218483dd2..28100ad547e9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1055,6 +1055,19 @@ void __init mark_linear_text_alias_ro(void)
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

