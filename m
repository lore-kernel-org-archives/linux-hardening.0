Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D62D476CF6
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062329; cv=none; b=hyV31WRu6NnJuI/FcYrK9r46Gcx2lqm2+CbB+NZQM4nHB5O/YIVzwBMigJo52rNyMsIq8nmRBu+tyhUF6cFeKGaRZ9bMkO9foyog8/QbOMCJjTaTJPISoNERHUjAsifCPEidODfUxp3+U3jDJL28fgfHSB2bRK4d3/1VEssbDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062329; c=relaxed/simple;
	bh=FCGum1rTAVPaw3kfR73YNYjOCQm2+TowdZAQ4naswfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uS40z/qphHfRVFiohZBKyCHr+LRjIZrd2ccmGP1BUx6pNVe3g1aBdALxrWDfaI0Yl5cfJ9UwOZcUk9Gzb+1k2sUgfdcvMmKBMCOgr2QNd5NkZf5NNbPf3Tjr6Klv0t4Yi/nm1ttW5Imk+sTE9i7lEQ3reibrJx8f4LGPh8BeS4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KM8LyCZX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KM8LyCZX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01F7F19F6;
	Tue, 18 Aug 2026 07:12:03 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F3733F85F;
	Tue, 18 Aug 2026 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787062326; bh=FCGum1rTAVPaw3kfR73YNYjOCQm2+TowdZAQ4naswfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KM8LyCZXFoj2SvWeg4FGMfVfyTECIs2/JVcKP3TzZ0xStyDKLjYaZ0cR3odPlKCOW
	 R89GcnDMSAgmVu93FnpXq8LTI0wIc11PuL9ccaEFetP2FTKbixbLItiNQx18OmKuYC
	 ZCRu1Xf/noLdgQMlvM5rFelQT89YHjYdnkE4JLMY=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 18 Aug 2026 15:08:51 +0100
Subject: [PATCH RFC v9 09/25] arm64: Enable kpkeys
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-kpkeys-v9-9-743ad31b2c8f@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787062276; l=1824;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=FCGum1rTAVPaw3kfR73YNYjOCQm2+TowdZAQ4naswfQ=;
 b=cWs9/HhYQLlTOWcxsFeqRjaQ1YfUuLMxMTT+5dNmHs0vj2L1unepwEAB2wJrTYv+tdehkAoM/
 zD6D9oE2xVzBMNqlw/+Y7ieQRDluBuS3dfwZyC+BdW4UgNNENLR2FpS
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

This is the final step to enable kpkeys on arm64. We enable
POE at EL1 by setting TCR2_EL1.POE, and initialise POR_EL1 to the
default value, enabling access to the default pkey/POIndex (0).
An ISB is added so that POE restrictions are enforced immediately.

Having done this, we can now select ARCH_HAS_KPKEYS if ARM64_POE is
enabled.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/Kconfig             | 1 +
 arch/arm64/kernel/cpufeature.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3afe0688919..0afa085c66be 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2202,6 +2202,7 @@ config ARM64_POE
 	def_bool y
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
+	select ARCH_HAS_KPKEYS
 	help
 	  The Permission Overlay Extension is used to implement Memory
 	  Protection Keys. Memory Protection Keys provides a mechanism for
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9a22df0c5120..4f2f54007ed6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -76,6 +76,7 @@
 #include <linux/kasan.h>
 #include <linux/percpu.h>
 #include <linux/sched/isolation.h>
+#include <linux/kpkeys.h>
 
 #include <asm/arm_pmuv3.h>
 #include <asm/cpu.h>
@@ -2463,8 +2464,10 @@ static void cpu_enable_mops(const struct arm64_cpu_capabilities *__unused)
 #ifdef CONFIG_ARM64_POE
 static void cpu_enable_poe(const struct arm64_cpu_capabilities *__unused)
 {
-	sysreg_clear_set(REG_TCR2_EL1, 0, TCR2_EL1_E0POE);
+	write_sysreg_s(POR_EL1_INIT, SYS_POR_EL1);
+	sysreg_clear_set(REG_TCR2_EL1, 0, TCR2_EL1_E0POE | TCR2_EL1_POE);
 	sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_E0POE);
+	isb();
 }
 #endif
 

-- 
2.51.2

