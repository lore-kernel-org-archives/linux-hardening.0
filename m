Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818E53624C8;
	Fri, 27 Feb 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214955; cv=none; b=qyKKN88wnAZePHks+7pgxK2Og1OnSxd/p6WyGhkAOv57jhoJf6lrEm23LcbZ3Z26SfRnVV+LvF/iIZ8vgDEW9utWEAcvl/438RxQYBZRqeo9JIthevUEycnnkktc/Lewbfe0S4FRuIqEv1Pe9UUuO27z6+1RhJy9VaaGPJIA3zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214955; c=relaxed/simple;
	bh=Ej7XZhdLj1ATcU2xluiCiiuQdUONc3oCHQzcB5eX7dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faj7YXHbO4SlgKLb4GtAukuxKs6+hMfS2CDxeRuAKxtcLOQEFS8K7XzQS1mENkRktaQC+WYlX8MpD8UU6ZOHQD7VuHizpIWPyaqHXupkfadcfnmPHhsaugF2crzVYJjE0JOC0uN1bgwOtAAPif2lN+ZonmTIw99C3OZ+dVxfuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 969FA176B;
	Fri, 27 Feb 2026 09:55:46 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 822BA3F73B;
	Fri, 27 Feb 2026 09:55:48 -0800 (PST)
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
Subject: [PATCH v6 02/30] set_memory: Introduce set_memory_pkey() stub
Date: Fri, 27 Feb 2026 17:54:50 +0000
Message-ID: <20260227175518.3728055-3-kevin.brodsky@arm.com>
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

Introduce a new function, set_memory_pkey(), which sets the
protection key (pkey) of pages in the specified linear mapping
range. Architectures implementing kernel pkeys (kpkeys) must
provide a suitable implementation; an empty stub is added as
fallback.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/set_memory.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 3030d9245f5a..7b3a8bfde3c6 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -84,4 +84,11 @@ static inline int set_memory_decrypted(unsigned long addr, int numpages)
 }
 #endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
+#ifndef CONFIG_ARCH_HAS_KPKEYS
+static inline int set_memory_pkey(unsigned long addr, int numpages, int pkey)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_SET_MEMORY_H_ */
-- 
2.51.2

