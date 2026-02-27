Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE736C597;
	Fri, 27 Feb 2026 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215083; cv=none; b=sYwaAhlPakmKFQh6CJbHge/++oAQTGiINNaMxtr4fRzIFo0G/TGRC4xjC8frUHpa/7R6VT6wMFGmvG+E9LfJP2+uSyYDgH1N8LbX33sphBHbIsAIx1dZz8UEp39FLSA3mDLE+9T+2CWFHzFzjny0fRklxMmSCLJX66KeCp1Hn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215083; c=relaxed/simple;
	bh=zrZXhiVEZLZD0YoAP17ou/XDKeS6yn/FRAFZUoOkMk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJPbS9VRh8yWr8UOX7Du21bIsQjdP3PP1/n+TMMLbn/NZvg+w82wO+y80Gia9RJjrqDD2dUZ7jCzxDATAmFjGjXQ992P5Z5v2XvP2tA8kiluOD2zFKdiHe9shnuUec/ZxKTG+owflaNYS74j29kao+4KJp8g6469P+OX4g6zerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4313619F6;
	Fri, 27 Feb 2026 09:57:53 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DF7D3F73B;
	Fri, 27 Feb 2026 09:57:55 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v6 29/30] arm64: kpkeys: Enable kpkeys_hardened_pgtables support
Date: Fri, 27 Feb 2026 17:55:17 +0000
Message-ID: <20260227175518.3728055-30-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260227175518.3728055-1-kevin.brodsky@arm.com>
References: <20260227175518.3728055-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kpkeys_hardened_pgtables feature needs to be initialised in two
stages:

1. As soon as the buddy allocator becomes available. The canonical
   place to handle this is mem_init().

2. As soon as the linear map can be split. With BBML2-noabort, this
   requires CPU detection to be completed on all CPUs.
   The earliest point is therefore after setup_system_features() has
   been called.

With that done, all the bits are in place and we can advertise
support for kpkeys_hardened_pgtables by selecting
ARCH_HAS_KPKEYS_HARDENED_PGTABLES if ARM64_POE is enabled.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/Kconfig      | 1 +
 arch/arm64/kernel/smp.c | 2 ++
 arch/arm64/mm/mmu.c     | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 732d4dbbab20..2faf082cc1d0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2165,6 +2165,7 @@ config ARM64_POE
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
 	select ARCH_HAS_KPKEYS
+	select ARCH_HAS_KPKEYS_HARDENED_PGTABLES
 	help
 	  The Permission Overlay Extension is used to implement Memory
 	  Protection Keys. Memory Protection Keys provides a mechanism for
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1aa324104afb..b2efff7a82ef 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -35,6 +35,7 @@
 #include <linux/kgdb.h>
 #include <linux/kvm_host.h>
 #include <linux/nmi.h>
+#include <linux/kpkeys.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -441,6 +442,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	hyp_mode_check();
 	setup_system_features();
 	setup_user_features();
+	kpkeys_hardened_pgtables_init_late();
 	mark_linear_text_alias_ro();
 }
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1e2cf0166c1d..1a96c186c4a3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -2273,3 +2273,8 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long i
 	return 0;
 }
 #endif
+
+void __init mem_init(void)
+{
+	kpkeys_hardened_pgtables_init();
+}
-- 
2.51.2

