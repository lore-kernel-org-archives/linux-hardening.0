Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEFD1FBC8C;
	Wed,  8 Jan 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332486; cv=none; b=nsnN+6DZB4HRf5SlLgWPBpyqvld8GkWbW6TAgbdWF3U2fqDR9kKJMt9ZS/66434stjFmkJs89xPWg3Zdl00CbvUdqa9W8/5rZPIzcc9dhNeCXIL5dz++HpMB+GjR4qQFiicJMrgKL/oGmp8Dz+7c6JWPpvKOt5B8Z+OYDIqMliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332486; c=relaxed/simple;
	bh=d5k63jL9YybpyZQyvNS/bMNYby/r6OcT2A9wyicj9lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSyl3kNDAel9awAklzFhBLvRZaJs7VHMx9fEvvvruvu/Mw2TngdHLJ7JyGkTY0o7DkoiYcskYa1xlrZyaLuakCZETkkz/mk8uKmn+B46zMNbu++w9V7It6Hl8HAwVReTsueBwFfyB5dUFx7AkcRpdsQ/OdVE/eNCn7A7sam1DyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66B6713D5;
	Wed,  8 Jan 2025 02:35:12 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CDC03F673;
	Wed,  8 Jan 2025 02:34:41 -0800 (PST)
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
Subject: [RFC PATCH v2 11/15] mm: Map page tables with privileged pkey
Date: Wed,  8 Jan 2025 10:32:46 +0000
Message-ID: <20250108103250.3188419-12-kevin.brodsky@arm.com>
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

If CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, map allocated page
table pages using a privileged pkey (KPKEYS_PKEY_PGTABLES), so that
page tables can only be written under guard(kpkeys_hardened_pgtables).

This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
(default).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e99040be477f..714e1af91752 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/cacheinfo.h>
 #include <linux/rcuwait.h>
+#include <linux/kpkeys.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -3082,6 +3083,8 @@ static inline bool __pagetable_ctor(struct ptdesc *ptdesc)
 
 	__folio_set_pgtable(folio);
 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+	if (kpkeys_protect_pgtable_memory(folio))
+		return false;
 	return true;
 }
 
@@ -3092,6 +3095,7 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
 	ptlock_free(ptdesc);
 	__folio_clear_pgtable(folio);
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+	kpkeys_unprotect_pgtable_memory(folio);
 }
 
 static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
-- 
2.47.0

