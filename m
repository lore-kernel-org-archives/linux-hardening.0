Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1E42036F1;
	Fri,  6 Dec 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480036; cv=none; b=ZQjkWQmUWJMlBTbLeCT6yAtxAz7NsZLhN434xawtA4vT3ZNez34J1jlieXUir3kn/q5UvBxrbObog5sfN4jqRHnOsItmMu14hF/toCtVmTHDj+k7eO/0/VNShiVqQtASp1YCTMGzfCj/DBFoPh4ADN7k7+rE3t6xOZg38PRNp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480036; c=relaxed/simple;
	bh=jAVzm1ZGmCTMzZJx4z0BksSiRB2C/sioSOVgFSR78a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eapWaQdTtn5nUPFoJR8UAbpvm9iUvkl/gy0+aqWyLcRJuepm/RcUFT0hoKxdC5+G5b4wudBSCs7C7N+enouBif1DEH0omKWyQLk5Q4L0afGxPPe6KwuqEOdf9Jmrh2xIIN7oyur+9WCPJAmHkMmR4Lv15nyBP6OxGODY4OHanZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 901F1176C;
	Fri,  6 Dec 2024 02:14:22 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69F93F71E;
	Fri,  6 Dec 2024 02:13:51 -0800 (PST)
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
Subject: [RFC PATCH 13/16] arm64: mm: Reset pkey in __tlb_remove_table()
Date: Fri,  6 Dec 2024 10:11:07 +0000
Message-ID: <20241206101110.1646108-14-kevin.brodsky@arm.com>
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

Page table pages are typically freed via tlb_remove_table() and
friends. Ensure that the linear mapping for those pages is reset to
the default pkey when CONFIG_KPKEYS_HARDENED_PGTABLES is enabled.

This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
(default).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/tlb.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed..d1611ffa6d91 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -10,10 +10,14 @@
 
 #include <linux/pagemap.h>
 #include <linux/swap.h>
+#include <linux/kpkeys.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct page *page = (struct page *)_table;
+
+	kpkeys_unprotect_pgtable_memory((unsigned long)page_address(page), 1);
+	free_page_and_swap_cache(page);
 }
 
 #define tlb_flush tlb_flush
-- 
2.47.0

