Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18539A04A
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997249; cv=none; b=f9FqZvhIQgf8IPAKxk/HjXAm9Gpb5ugHcHyTfu78g3DpFxVTdloxsTJcm10j2UbgK3sl/2JzmhtMeFOKm4XJfXPycNR8FV1r7L2O1e/QZoosri1D2/MjMOXkMlAIDvnpu5eRCSA7URrmU4Imu5ZUd92fJVKK2LnmnXIlrwFSI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997249; c=relaxed/simple;
	bh=6h53wIhICiTdohxtZ773SNUpArSJEO1cKJs65JAmPCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tZNoo/M9HJfL2VTXfZs2qQ/0nNsi2bu9rYdjODyknwXQRxgUMAcG9zKKnUSMdueGcjMa9rMwrqQ9Qj8LgkuirRt1lP0/Mu3igWn1CXLpfU7+HBAU6H249+z8I3nyoxiME6nfnCyvXy7cJO8YWd9ScuG/qtSvL5V481zfmYZLJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d2gpOI5g; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d2gpOI5g"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF37514BF;
	Tue,  5 May 2026 09:07:21 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21CC83F763;
	Tue,  5 May 2026 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777997247; bh=6h53wIhICiTdohxtZ773SNUpArSJEO1cKJs65JAmPCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d2gpOI5gY7qiZ6klE1noMUGXimHfRGXXfFw+/eM4tO7XW+EALiXnHmq1wjynsIv+G
	 KggwbbLDH3ULPGGYBhxAF57HxF7iuKb7O+JN4F44w7LnIGL5e2z5c1jXFkxZrybi0O
	 ZFh8CEGhMPWhgXvF9lkm0kTEcgXMpk4ij4xg1hsI=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 05 May 2026 17:05:54 +0100
Subject: [PATCH RFC v7 05/24] arm64: Implement asm/kpkeys.h using POE
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-kpkeys-v7-5-20c0bdd97197@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777997220; l=2665;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=6h53wIhICiTdohxtZ773SNUpArSJEO1cKJs65JAmPCY=;
 b=kMmOZAzlr5JiNYZ8sm1nG7q9J8yJ+5iLF5bQYnzwypt2/PnQ0z9eV0aNwTIPyYfR+nQ0ESKVw
 Fi7x6wj+1aNCumcVAwAGrapKsxO92BmroPdMDLaQgffctO55Vf5ZLh3
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Implement the kpkeys interface if CONFIG_ARM64_POE is enabled.
The permissions for KPKEYS_PKEY_DEFAULT (pkey 0) are set to RWX as
this pkey is also used for code mappings.

To allow <asm/kpkeys.h> to be included from assembly, also add
appropriate #ifdef's to <asm/por.h>.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 59 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/por.h    |  4 +++
 2 files changed, 63 insertions(+)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
new file mode 100644
index 000000000000..7dad3532cacf
--- /dev/null
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_KPKEYS_H
+#define __ASM_KPKEYS_H
+
+#include <asm/barrier.h>
+#include <asm/cpufeature.h>
+#include <asm/por.h>
+
+#include <asm-generic/kpkeys.h>
+
+/*
+ * Equivalent to por_set_kpkeys_context(0, KPKEYS_CTX_DEFAULT), but can also be
+ * used in assembly.
+ */
+#define POR_EL1_INIT	POR_ELx_PERM_PREP(KPKEYS_PKEY_DEFAULT, POE_RWX)
+
+#ifndef __ASSEMBLY__
+
+static inline bool arch_supports_kpkeys(void)
+{
+	return system_supports_poe();
+}
+
+#ifdef CONFIG_ARM64_POE
+
+static inline u64 por_set_kpkeys_context(u64 por, int ctx)
+{
+	por = por_elx_set_pkey_perms(por, KPKEYS_PKEY_DEFAULT, POE_RWX);
+
+	return por;
+}
+
+static __always_inline void __kpkeys_set_pkey_reg_nosync(u64 pkey_reg)
+{
+	write_sysreg_s(pkey_reg, SYS_POR_EL1);
+}
+
+static __always_inline int arch_kpkeys_set_context(int ctx)
+{
+	u64 prev_por = read_sysreg_s(SYS_POR_EL1);
+	u64 new_por = por_set_kpkeys_context(prev_por, ctx);
+
+	__kpkeys_set_pkey_reg_nosync(new_por);
+	isb();
+
+	return prev_por;
+}
+
+static __always_inline void arch_kpkeys_restore_pkey_reg(u64 pkey_reg)
+{
+	__kpkeys_set_pkey_reg_nosync(pkey_reg);
+	isb();
+}
+
+#endif /* CONFIG_ARM64_POE */
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* __ASM_KPKEYS_H */
diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
index bffb4d2b1246..58dce4b8021b 100644
--- a/arch/arm64/include/asm/por.h
+++ b/arch/arm64/include/asm/por.h
@@ -10,6 +10,8 @@
 
 #define POR_EL0_INIT	POR_ELx_PERM_PREP(0, POE_RWX)
 
+#ifndef __ASSEMBLY__
+
 static inline bool por_elx_allows_read(u64 por, u8 pkey)
 {
 	u8 perm = POR_ELx_PERM_GET(pkey, por);
@@ -38,4 +40,6 @@ static inline u64 por_elx_set_pkey_perms(u64 por, u8 pkey, u64 perms)
 	return (por & ~(POE_MASK << shift)) | (perms << shift);
 }
 
+#endif	/* __ASSEMBLY__ */
+
 #endif /* _ASM_ARM64_POR_H */

-- 
2.51.2

