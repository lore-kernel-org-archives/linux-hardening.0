Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1531FC0FF;
	Fri,  6 Dec 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480004; cv=none; b=DnYkMZwy2f4QSs2dGUJ6EmU4B1VgzvGgEMSszmET75UfqFw8a2JoZHXNcWomcY/hrsrn5PgZLx9z26jmbsReOVXX7r/8vPc1vvsZSsq+XeuCxovlYtatdboGEAqlnr7BvBuDG8xK+2n6y7/+kV8QEGDTD984ZzAKiL+SYIK1y6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480004; c=relaxed/simple;
	bh=gx+EilaJUqiJReCNs8kIMv2VtaGCsMsYHlmwmmvHffQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0lPN/t+E8Iw+yf5Fv9Fr2NpE6uwFfGMAuCq+u+p33YFgQdxxilHcwbTbiccAhIXzW4MQRgUx+s27att3tv9JdwToN1CXgxus6TUg6kkXgL9/QYjC0YfmEmfDk11U8vnKxpFbkxhvE61pzhOfTmrETN5tx9HpWujZEDafMCtxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A6A515A1;
	Fri,  6 Dec 2024 02:13:50 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 611A33F71E;
	Fri,  6 Dec 2024 02:13:19 -0800 (PST)
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
Subject: [RFC PATCH 03/16] arm64: mm: Enable overlays for all EL1 indirect permissions
Date: Fri,  6 Dec 2024 10:10:57 +0000
Message-ID: <20241206101110.1646108-4-kevin.brodsky@arm.com>
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

In preparation of using POE inside the kernel, enable "Overlay
applied" for all stage 1 base permissions in PIR_EL1. This ensures
that the permissions set in POR_EL1 affect all kernel mappings.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 9f9cf13bbd95..a1c4f3837ea9 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -174,13 +174,13 @@ static inline bool __pure lpa2_is_enabled(void)
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_NONE_O) | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_NONE_O) | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_NONE_O) | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_R)      | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RW)     | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY),      PIE_R)      | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW)     | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL_ROX),    PIE_RX)     | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL_EXEC),   PIE_RWX)    | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL_RO),     PIE_R)      | \
-	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL),        PIE_RW))
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_R_O)    | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RW_O)   | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY),      PIE_R_O)    | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW_O)   | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL_ROX),    PIE_RX_O)   | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL_EXEC),   PIE_RWX_O)  | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL_RO),     PIE_R_O)    | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_KERNEL),        PIE_RW_O))
 
 #endif /* __ASM_PGTABLE_PROT_H */
-- 
2.47.0

