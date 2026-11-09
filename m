Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240082;
	b=x8NNGNm8OfJf+Sp61XBrZLPypwQ7fahdC+UW2+nXzsMevh/F3sCq9QEveYZiOKsxleTx
	 wexBvi/b72TFXRvErcL6+idKFIgxLMuF9pBFhYCb3/Q+7EkXPc/4mJaKr6urW8DOs/eku
	 sat06bCtremaeKc0MrQHoISXKv93MjUU2CYVtA17yKVEqLaVVcaCP4YbCRbEVnBgrWC2I
	 77IynbqHPRj9F7CMotX7PtmvYTHrmlOF/GeHcPdTULp8NNBTtRwHo7udi7LUta5kxRnOr
	 XZd07FVGpCjCok7Cm9NgEyshJFzx38c9TeX635I7seCGUmfXLNjnrsK0Hw77QkoH1xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240082;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=dY9xuTSUx+VKL/ce4GOjJF5WW3kIPH+saWseajGc3UE=;
	b=m+R1Sayhe3luw3WIyVZpW9x24haMz90VUn33ssqyWqgR7b8WWdfbf/q/1mcnqKCFrY3i
	 yKSDOHIZrd43SJFVdFcfSx/CyyHIJhFMPsOih3njWkldEJyekZ9QzM5SXgD4lkxeBK5dh
	 +zOhP6/TeimAAJXAiQb298nKu9NadMNnm2EA/PABt4GcnVfLGJdcwri5YJvvBfL6LmbtM
	 KzRI2osT4bP+wkdfr9i3Ez3JvJ2NH4YG/1y4j6LG1MHIqGmeCu0VCGv+8r9eHgXr8cyeh
	 TOczxfqKRS+//hj6WgIaaeYKl4L9DdpYIyoYEivMULTQ9geZfSRyxeMI5/S439Ur7AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oWE9SHeT;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F5460A5BD1;
	Mon,  9 Nov 2026 16:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68F5460A5BD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oWE9SHeT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C96E51691;
	Mon,  9 Nov 2026 08:01:18 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECB673F632;
	Mon,  9 Nov 2026 08:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240081; bh=Y0zSXQuI73WVYRp+ApaQSKHcTrjkRu31AZuqJ4SX/+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oWE9SHeTz0Zr4EwuExxrKWPcs0DZPuSD1zxVxPYO66wezmOJmTn+Vxc23FrbAQ70L
	 fXFbPD1rD0uD4dJXodLqZWxzK7X+y6B7JI3Po/gnxNx/lQq4JfEi3WG7xYnoBQ84H3
	 M2CLJMDSagcRY2kSgkjXrMFDzqNUs8cry8oWgozs=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:34 +0000
Subject: [PATCH RFC v10 09/22] arm64: mm: Enable overlays for all EL1
 indirect permissions
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
Message-Id: <20261109-kpkeys-v10-9-aa6c4d9603bc@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=1848;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=Y0zSXQuI73WVYRp+ApaQSKHcTrjkRu31AZuqJ4SX/+Y=;
 b=DrIUmvyOStKkICsbTho2FY0JXL/3bvaGUJYYur70JPOyzgyrSslhzEX+PR7cTWOovxbTg9h/L
 DUVO/Ct8ZdXBsPzaw5R0LMJ9uaOUXPKQQA0Z3TwnP3F27plZAsjgHiW
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

In preparation of using POE inside the kernel, enable "Overlay
applied" for kernel memory types in PIR_EL1. This ensures that the
permissions set in POR_EL1 affect all kernel mappings.

User memory types must be left untouched (overlays not applied)
because any privileged access to user memory (e.g. futex atomic
without FEAT_LSUI) would then be mistakenly checked against POR_EL1.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Linu Cherian <linu.cherian@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 590ef4328f12..eb779c0e892d 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -183,9 +183,9 @@ static inline bool __pure lpa2_is_enabled(void)
 	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RW)     | \
 	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_READONLY),      PIE_R)      | \
 	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_SHARED),        PIE_RW)     | \
-	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_ROX),    PIE_RX)     | \
-	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_EXEC),   PIE_RWX)    | \
-	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_RO),     PIE_R)      | \
-	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL),        PIE_RW))
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_ROX),    PIE_RX_O)   | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_EXEC),   PIE_RWX_O)  | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_RO),     PIE_R_O)    | \
+	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL),        PIE_RW_O))
 
 #endif /* __ASM_PGTABLE_PROT_H */

-- 
2.56.0

