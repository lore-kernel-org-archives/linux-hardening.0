Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAD84582E3
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062310; cv=none; b=ACI8YCuvFqBLxfRgsvEx8esZFuyqb5Y2+wz5mHE5GJ8na3ltoehaIpFcHMuGValFlCJFuEiqI8CpP/8+p3Vx3JyRE0qlaDQ4UCQgOQx1kE0iQO1Yoo/2X2yx8ciydW0EF5VZPRxFYSincSdDXTyd+B+yRmRjUPuOAVemlbmwarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062310; c=relaxed/simple;
	bh=6wbz7M9AxUaVbPIWUUWjzRRnSMPq0HS+t9xWqqATY50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DItVGSktTOqwaOgDax64ujNfG9ECNAIZoe4vRASZ5n9O2sjpe/p4ej5BkeKRbjYpd73mF3nUHAvbQ6+0WoXGHuMaZpt8jGTcF0Z8svWyv/mdYW3DTIfx6W8cuN5ppE89Xl4PQHc95HQjA1Eaja1lzynDvb9s7IFQ8cHdbggtCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eegD3Q5z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eegD3Q5z"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C40119F6;
	Tue, 18 Aug 2026 07:11:43 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578593F85F;
	Tue, 18 Aug 2026 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787062307; bh=6wbz7M9AxUaVbPIWUUWjzRRnSMPq0HS+t9xWqqATY50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eegD3Q5zeLXme4NvXnUJNYwKafnS1JAt4VVHBEbHdSs/9LuqzzWjqNenBJoOpv+oW
	 UeD15hUuXB2GUF+Nw3cbWEYXVCC9G8Y9+PFLZekCFB3REt156/mNAaAHvbVLijXgkX
	 a4CLhHodZe6F1Gjhm9EgzjUU1gV7P6m3VeSq9A3s=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 18 Aug 2026 15:08:47 +0100
Subject: [PATCH RFC v9 05/25] arm64: Implement asm/kpkeys.h using POE
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-kpkeys-v9-5-743ad31b2c8f@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787062276; l=3520;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=6wbz7M9AxUaVbPIWUUWjzRRnSMPq0HS+t9xWqqATY50=;
 b=qSs2aR0MM51fpLHnCL+cqiL5CeqWF8AjtCb69VRsQre+Xry4+dqxT+AElsKlSRpe1daufmoo0
 DHdsQ6uk7EFBwHC3vYbMZnfyPIBOBhD6kw+KHDnL00yy/Gvme1fBgMK
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Implement the kpkeys interface if CONFIG_ARM64_POE is enabled.
The permissions for pkey 0 are set to RWX as this pkey is also used
for code mappings. POR_EL1 is left untouched if we have already
entered the requested context.

To allow <asm/kpkeys.h> to be included from assembly, also add
appropriate #ifdef's to <asm/por.h>.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h       | 67 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/kpkeys_types.h | 15 ++++++++
 arch/arm64/include/asm/por.h          |  4 +++
 3 files changed, 86 insertions(+)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
new file mode 100644
index 000000000000..09fd5a849cb0
--- /dev/null
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_KPKEYS_H
+#define __ASM_KPKEYS_H
+
+#include <linux/kpkeys_types.h>
+
+#include <asm/barrier.h>
+#include <asm/cpufeature.h>
+#include <asm/por.h>
+
+/*
+ * Equivalent to por_set_kpkeys_context(0, KPKEYS_CTX_DEFAULT), but can also be
+ * used in assembly.
+ */
+#define POR_EL1_INIT	POR_ELx_PERM_PREP(0, POE_RWX)
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
+static inline u64 por_set_kpkeys_context(u64 por, enum kpkeys_ctx ctx)
+{
+	por = por_elx_set_pkey_perms(por, 0, POE_RWX);
+
+	return por;
+}
+
+static __always_inline void __kpkeys_set_pkey_reg_nosync(u64 pkey_reg)
+{
+	write_sysreg_s(pkey_reg, SYS_POR_EL1);
+}
+
+static __always_inline
+struct kpkeys_state arch_kpkeys_enter_context(enum kpkeys_ctx ctx)
+{
+	const u64 prev_por = read_sysreg_s(SYS_POR_EL1);
+	const u64 new_por = por_set_kpkeys_context(prev_por, ctx);
+
+	if (prev_por == new_por)
+		return (struct kpkeys_state) { .entered_context = false };
+
+	__kpkeys_set_pkey_reg_nosync(new_por);
+	isb();
+
+	return (struct kpkeys_state) {
+		.entered_context = true,
+		.arch_state.por = prev_por,
+	};
+}
+
+static __always_inline
+void arch_kpkeys_leave_context(const struct kpkeys_state *state)
+{
+	__kpkeys_set_pkey_reg_nosync(state->arch_state.por);
+	isb();
+}
+
+#endif /* CONFIG_ARM64_POE */
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* __ASM_KPKEYS_H */
diff --git a/arch/arm64/include/asm/kpkeys_types.h b/arch/arm64/include/asm/kpkeys_types.h
new file mode 100644
index 000000000000..e9c59a26ee7a
--- /dev/null
+++ b/arch/arm64/include/asm/kpkeys_types.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_KPKEYS_TYPES_H
+#define __ASM_KPKEYS_TYPES_H
+
+#include <linux/types.h>
+
+#ifndef __ASSEMBLY__
+
+struct arch_kpkeys_state {
+	u64 por;
+};
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* __ASM_KPKEYS_TYPES_H */
diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
index 19b3dd1d43a0..dddabf6ffae6 100644
--- a/arch/arm64/include/asm/por.h
+++ b/arch/arm64/include/asm/por.h
@@ -10,6 +10,8 @@
 
 #define POR_EL0_INIT	POR_ELx_PERM_PREP(0, POE_RWX)
 
+#ifndef __ASSEMBLY__
+
 static inline bool por_elx_allows_read(u64 por, u8 pkey)
 {
 	u8 perm = POR_ELx_PERM_GET(pkey, por);
@@ -38,4 +40,6 @@ static inline u64 por_elx_set_pkey_perms(u64 por, u8 pkey, u8 perms)
 	return (por & ~(POE_MASK << shift)) | ((u64)perms << shift);
 }
 
+#endif	/* __ASSEMBLY__ */
+
 #endif /* _ASM_ARM64_POR_H */

-- 
2.51.2

