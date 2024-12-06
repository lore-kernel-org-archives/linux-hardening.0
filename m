Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3271B200B9E;
	Fri,  6 Dec 2024 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480007; cv=none; b=DX5FA2acaYkcDqTx+j3HOVSapJ9fOU1dqS2I16t31N/3iBZE+/fm3qsN7B9ZdukOn7h0MjEgKZN6tjPUlHuhv+t+IDNWOngiv+D3h9xST5dM/sDh+Hiqrr3dR4VOAAYAgZ6r+l0Ne3xd9UGmsHfq+Bev/C3WrPzeefXJ78piN3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480007; c=relaxed/simple;
	bh=cm8of8N6CF+F4QHGa2huIXKOUQPLLZzMmFFRMoMuJFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYV+fD9dIqCiC8E9lG1n/ub/6fD7BEQNug014vxc7TbxqjzPls/jWIrOdzzWzM7nBZ553Z0PPd/HzpVf3ScU0W38PiZ5ev8yDGGlPYoDeepKWmO3RQc00HCiian/9zHRAjt8NdzAGDAKVpXyOqvzdC7uO2PPV7nQTxuJNydwy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8224512FC;
	Fri,  6 Dec 2024 02:13:53 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98E183F71E;
	Fri,  6 Dec 2024 02:13:22 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	jannh@google.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	kees@kernel.org,
	maz@kernel.org,
	pierre.langlois@arm.com,
	qperret@google.com,
	ryan.roberts@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH 04/16] arm64: Introduce por_set_pkey_perms() helper
Date: Fri,  6 Dec 2024 10:10:58 +0000
Message-ID: <20241206101110.1646108-5-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206101110.1646108-1-kevin.brodsky@arm.com>
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper that sets the permissions of a given pkey
(POIndex) in the POR_ELx format, and make use of it in
arch_set_user_pkey_access().

Also ensure that <asm/sysreg.h> is included in asm/por.h to provide
the POE_* definitions.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/por.h |  9 +++++++++
 arch/arm64/mm/mmu.c          | 28 ++++++++++------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
index e06e9f473675..7f0d73980cce 100644
--- a/arch/arm64/include/asm/por.h
+++ b/arch/arm64/include/asm/por.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_ARM64_POR_H
 #define _ASM_ARM64_POR_H
 
+#include <asm/sysreg.h>
+
 #define POR_BITS_PER_PKEY		4
 #define POR_ELx_IDX(por_elx, idx)	(((por_elx) >> ((idx) * POR_BITS_PER_PKEY)) & 0xf)
 
@@ -30,4 +32,11 @@ static inline bool por_elx_allows_exec(u64 por, u8 pkey)
 	return perm & POE_X;
 }
 
+static inline u64 por_set_pkey_perms(u64 por, u8 pkey, u64 perms)
+{
+	u64 shift = pkey * POR_BITS_PER_PKEY;
+
+	return (por & ~(POE_MASK << shift)) | (perms << shift);
+}
+
 #endif /* _ASM_ARM64_POR_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e2739b69e11b..20e0390ee382 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1554,9 +1554,8 @@ void __cpu_replace_ttbr1(pgd_t *pgdp, bool cnp)
 #ifdef CONFIG_ARCH_HAS_PKEYS
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
 {
-	u64 new_por = POE_RXW;
-	u64 old_por;
-	u64 pkey_shift;
+	u64 new_perms;
+	u64 por;
 
 	if (!system_supports_poe())
 		return -ENOSPC;
@@ -1570,26 +1569,19 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long i
 		return -EINVAL;
 
 	/* Set the bits we need in POR:  */
-	new_por = POE_RXW;
+	new_perms = POE_RXW;
 	if (init_val & PKEY_DISABLE_WRITE)
-		new_por &= ~POE_W;
+		new_perms &= ~POE_W;
 	if (init_val & PKEY_DISABLE_ACCESS)
-		new_por &= ~POE_RW;
+		new_perms &= ~POE_RW;
 	if (init_val & PKEY_DISABLE_READ)
-		new_por &= ~POE_R;
+		new_perms &= ~POE_R;
 	if (init_val & PKEY_DISABLE_EXECUTE)
-		new_por &= ~POE_X;
+		new_perms &= ~POE_X;
 
-	/* Shift the bits in to the correct place in POR for pkey: */
-	pkey_shift = pkey * POR_BITS_PER_PKEY;
-	new_por <<= pkey_shift;
-
-	/* Get old POR and mask off any old bits in place: */
-	old_por = read_sysreg_s(SYS_POR_EL0);
-	old_por &= ~(POE_MASK << pkey_shift);
-
-	/* Write old part along with new part: */
-	write_sysreg_s(old_por | new_por, SYS_POR_EL0);
+	por = read_sysreg_s(SYS_POR_EL0);
+	por = por_set_pkey_perms(por, pkey, new_perms);
+	write_sysreg_s(por, SYS_POR_EL0);
 
 	return 0;
 }
-- 
2.47.0

