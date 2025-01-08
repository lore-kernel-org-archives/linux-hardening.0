Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160AB1F9A9B;
	Wed,  8 Jan 2025 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332467; cv=none; b=NuAhgzZXZ/MDIbsevh43njnxf9gsD1dwR45Q6C09QzGCRocZn3uHhzUxXmF2y72s/F7hu7X6sknzxOKbcdTjmwGbXKz/OaAhKQ8ze76yR7UVQYZw5kTFQuPdeq2ruiEGY5wbB2IU4cxHD9wQwZ/EqHBF5piGoRJmfwROhMBRXlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332467; c=relaxed/simple;
	bh=ADi3c0PRpU2JemlHu/u0oUZ4vDQkss9aFXz31FTjnBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LscsUKHaAlzPEOckRzWedYg3vhjAD8I+hEMmj5JTHf1Vl3E4344R+wGLFWsfXTdcq5uGGjcDFAWwCr/vmyxZxeOSGywdG8N/WYBsEXeMr+QHkKsd6UA4CfQ4CUHpJWMKqjF/OYQVa8TGmE09h25o+Yc0hQBc2Vdu1NieJUJEHvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B740513D5;
	Wed,  8 Jan 2025 02:34:53 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D3B93F673;
	Wed,  8 Jan 2025 02:34:22 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH v2 05/15] arm64: Implement asm/kpkeys.h using POE
Date: Wed,  8 Jan 2025 10:32:40 +0000
Message-ID: <20250108103250.3188419-6-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108103250.3188419-1-kevin.brodsky@arm.com>
References: <20250108103250.3188419-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the kpkeys interface if CONFIG_ARM64_POE is enabled.
The permissions for KPKEYS_PKEY_DEFAULT (pkey 0) are set to RWX as
this pkey is also used for code mappings.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 arch/arm64/include/asm/kpkeys.h

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
new file mode 100644
index 000000000000..e17f6df41873
--- /dev/null
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -0,0 +1,43 @@
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
+static inline bool arch_kpkeys_enabled(void)
+{
+	return system_supports_poe();
+}
+
+#ifdef CONFIG_ARM64_POE
+
+static inline u64 por_set_kpkeys_level(u64 por, int level)
+{
+	por = por_set_pkey_perms(por, KPKEYS_PKEY_DEFAULT, POE_RXW);
+
+	return por;
+}
+
+static inline int arch_kpkeys_set_level(int level)
+{
+	u64 prev_por = read_sysreg_s(SYS_POR_EL1);
+
+	write_sysreg_s(por_set_kpkeys_level(prev_por, level), SYS_POR_EL1);
+	isb();
+
+	return prev_por;
+}
+
+static inline void arch_kpkeys_restore_pkey_reg(u64 pkey_reg)
+{
+	write_sysreg_s(pkey_reg, SYS_POR_EL1);
+	isb();
+}
+
+#endif /* CONFIG_ARM64_POE */
+
+#endif	/* __ASM_KPKEYS_H */
-- 
2.47.0

