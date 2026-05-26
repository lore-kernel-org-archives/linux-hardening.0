Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF5B2D97B9
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794271; cv=none; b=nmKhAo/3kzYfuBzl6xW0wmtwOZetta67SWeIVnP4Rnp8NI35bLXFl4AM8YzTNiF8LdhGR+baqukkC6MiGnHGxVFyQORMlaKAHeZP3WlCfkjHkWH8J42ON1cUhXv9XyaDL9CeytqI0FS3/lp+AaKHM0qDBEtWpe/KwfgVeiRygQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794271; c=relaxed/simple;
	bh=BIW+ZJvi1P4EeD5UF9lAJp1G+q4h4naKio10It8LHdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WdCbjRAZZXMufqLoXLHMH/EmJjpZ5DMSxUTTtp1pIU6kmxDaJarQZpB7qeZRElQx3h9i6ZGi7aj0r+mH5SyDs28cEcA10WN8hxwEtnzY4smlfJOKbaXarhJVanVrVo5iBCHMQD52iC4ylCeIUganuVGul1vTXqMB2yc6XlpIkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CXUQBxWn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CXUQBxWn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8770216F2;
	Tue, 26 May 2026 04:17:44 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B76F83F7D8;
	Tue, 26 May 2026 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779794269; bh=BIW+ZJvi1P4EeD5UF9lAJp1G+q4h4naKio10It8LHdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CXUQBxWnRCwDZIJbyDjOv6buZ/ZHuWq3lv1+SZZ95PXYVPCEok99psIDLKCiBWr5j
	 nA46PFCbUIyYPmEnNSZNNxgOyaOoM5r+Fcgw/ImgQsqrmq4Tf1ySVD6Y18ZCcHBaGz
	 hyxkxF/1qpwM0AL+laviTWnjvM9ARiQxBMPY1G3w=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 26 May 2026 12:15:59 +0100
Subject: [PATCH RFC v8 10/24] memblock: Move INIT_MEMBLOCK_* macros to
 header
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-kpkeys-v8-10-eaaacdacc67c@arm.com>
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
In-Reply-To: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
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
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779794212; l=1850;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=BIW+ZJvi1P4EeD5UF9lAJp1G+q4h4naKio10It8LHdc=;
 b=k/6tYCVgqofYCAapYqWsSvaOAxLzZMkQtTrrGWimL0nEfK5dP+LdOGyVEW4bM+EHz7GaZ5JbC
 m/SoVteI4iJDZnNe5lK94c2vsiiFUy8vWgghfokYtQqib4li3mjDGUK
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
index b0f750d22a7b..e58b2c859b95 100644
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
index a6a1c91e276d..e64ad9c72dc3 100644
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

