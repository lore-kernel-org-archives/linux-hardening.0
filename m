Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B48747884B
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062334; cv=none; b=b/Al6tR9LfdS/MIQ9e1MZgNB2+F8MEYNn1NDuRnCkYggks7m8AxjmdkBfHnR4QKtdHDEO38SS/SxpKC8RTyMAmlWIIU8eyufizqQMRjhJ7g02FlMNvcIz+yIyO4ACqvCgHBYPaV8TuzB94Ld+oYjhVuhpPUIRL/Ckt4qEjP5GLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062334; c=relaxed/simple;
	bh=nU3eiDcO03IFOkcW/QGHHUOPCdH6UYiP9fWY6Wc22aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2Bwf6QC8g5jpRkZgZbyW6/0zT+FzP0vkSvLkETV09z+QfJFrZ9K6GKZVdf+od53zHlmt6evX3QUrIZN6F5gizm4wdSXROvjbRv+dNiS9LsSt0PI19VU8OrKgj+klNE0lYwAm5pPqc9s8xmJaHR6or50eM8mR1767h1+cGf6de0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TpDgui9M; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TpDgui9M"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F297B19F0;
	Tue, 18 Aug 2026 07:12:07 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A4813F85F;
	Tue, 18 Aug 2026 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787062331; bh=nU3eiDcO03IFOkcW/QGHHUOPCdH6UYiP9fWY6Wc22aE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TpDgui9MEP/DBiWOyzoEFsB1lSyWL8ccgweMm+voZxhnjOnFlIV32WzriZZ5/oRPo
	 tnPqXku3XwOXWsK2MZqvD6H70hyFxKWRJQOQL3X5cxyVCg0oEn6vItIQoDoecGu6vE
	 9voczrix6U4Ain8AcgwnMaD8FjPPJkqWUfsxemAw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 18 Aug 2026 15:08:52 +0100
Subject: [PATCH RFC v9 10/25] memblock: Move INIT_MEMBLOCK_* macros to
 header
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-kpkeys-v9-10-743ad31b2c8f@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787062276; l=1850;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=nU3eiDcO03IFOkcW/QGHHUOPCdH6UYiP9fWY6Wc22aE=;
 b=B0yfVHLm7lbOmhzKoBAFNdH82AYQgzd/UVKdZtKYaNAexZho70FVP/w0siiGh33OJI1gNWTC/
 Brpeg+LeXnWDRFfn/jmPmIAPVCw79DvJkgh9fVeFcjJUTg7KeQ0CBKn
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The upcoming page table allocator for the kpkeys_hardened_pgtables
feature will need to know the maximum number of memblock regions.
Move the corresponding macros to <linux/memblock.h> to allow that.

INIT_MEMBLOCK_{RESERVED,MEMORY}_REGIONS may be overridden, but this
should be fine as only arm64 and loong currently do that and the
relevant header is already (indirectly) included by
<linux/memblock.h>.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/memblock.h | 11 +++++++++++
 mm/memblock.c            | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 5afcd99aa8c1..c61f80e31cc1 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -24,6 +24,17 @@ extern unsigned long max_pfn;
  */
 extern unsigned long long max_possible_pfn;
 
+#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_PHYSMEM_REGIONS			4
+
+#ifndef INIT_MEMBLOCK_RESERVED_REGIONS
+#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
+#endif
+
+#ifndef INIT_MEMBLOCK_MEMORY_REGIONS
+#define INIT_MEMBLOCK_MEMORY_REGIONS		INIT_MEMBLOCK_REGIONS
+#endif
+
 /**
  * enum memblock_flags - definition of memory region attributes
  * @MEMBLOCK_NONE: no special request
diff --git a/mm/memblock.c b/mm/memblock.c
index 6349c48154f4..3b497d3556bb 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -30,17 +30,6 @@
 
 #include "internal.h"
 
-#define INIT_MEMBLOCK_REGIONS			128
-#define INIT_PHYSMEM_REGIONS			4
-
-#ifndef INIT_MEMBLOCK_RESERVED_REGIONS
-# define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
-#endif
-
-#ifndef INIT_MEMBLOCK_MEMORY_REGIONS
-#define INIT_MEMBLOCK_MEMORY_REGIONS		INIT_MEMBLOCK_REGIONS
-#endif
-
 /**
  * DOC: memblock overview
  *

-- 
2.51.2

