Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B6225775;
	Thu, 21 May 2026 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367234; cv=none; b=km1JqxMg+YaKsj9t7tscw/3o6R3Tf4eoEGqmpyeGB0jdnQLb1szeTr0lHFR1CkPusZqST7mTj82zdWprcXYc9ZSE11YrQwvzQNcJZvhQaJvBVc3FvpR2TJTrRDIn+xnUIBXb99LlUTWVS6wVQmWI1jFxY1hQpYCgsKyaIDtFbWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367234; c=relaxed/simple;
	bh=9Y0y7pZycGbEOeO9/OyccNveQ4PnpxVbx1Oaw+ivBqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MCE8QuqxIlhm9BpgvvH+30ox6f/1wC5yqgeDBUx9sv+qrzHX5GGGVzXAcMN9IOXHcCAudoA/w3A5NgHjVgsImwxRi7f6X+c1Uyt5yAaH5MFpe5JrJETUzwFofd+caLVVA8O0kPCP0EvZ3IawNrUAReDXwdTSGtNUuZBdKcj9Tfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScCUhpbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScCUhpbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799B61F00A3B;
	Thu, 21 May 2026 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367233;
	bh=RlAOM2lZrtJhhmPATuaev+PMTZ0nLmMQGqFD18Zj8Ds=;
	h=From:To:Cc:Subject:Date;
	b=ScCUhpbrSDupPtmSqPFnD2k7W1tWR9KtDOK5Y3502t0qCdePjhyX8i6FD+cUrBnvk
	 jOGqEBPGtfJK8orGqwNjFAaEd8DODy6YdBziASiWTyG6ggnwyOWf+78tLE3hm34VCO
	 /1zI0ITJk7wbl5qEiodt4YWfeZPdlHv8pKg0hGpw/1un+H5PIsHy6HjmqzhAr93Jeu
	 yl11Ag+TH+h5q6wsvQGUiywv8YrfCk+p4D5XE7YMz3RE7maDOLULM4n/ROGNtzwROX
	 fowwmTXqfqxaFS0ovfspUzfjVwhP+2m69rok4NKkmqaArlBTZ+Yrfoh30+RtoWeFpD
	 MVkHsuBTWlaxg==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mm/util: Use kmalloc buckets for kmemdup_nul()
Date: Thu, 21 May 2026 05:40:31 -0700
Message-Id: <20260521124026.work.036-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2565; i=kees@kernel.org; h=from:subject:message-id; bh=9Y0y7pZycGbEOeO9/OyccNveQ4PnpxVbx1Oaw+ivBqg=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl8f+32OLZtm9+yYp/5+n/7u5sdGhyWrzBdbSjiFbGH1 /jDPT/FjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgInsPcLwP2FP3cldJ4++OZrD X3XtsFzmfenFry5KfeBe2N7J6x3y8j/Df+eeuVaqsVErn/Q4FESk1jbetZKVtnjPIvhd+/HDTeK 3GAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The use of the kmemdup_nul()-family of allocations are explicitly for
allocating NUL terminated strings, so these would be best separated from
typed allocations, as they are their own set of arbitrarily sized
allocations. They are not as risky as userspace controlled allocations,
but these would be good to separate as well.

  # grep memdup_nul /proc/slabinfo | cut -c-25
  memdup_nul-8k          0
  memdup_nul-4k          0
  memdup_nul-2k          0
  memdup_nul-1k          0
  memdup_nul-512        28
  memdup_nul-256         0
  memdup_nul-192        60
  memdup_nul-128        60
  memdup_nul-96         60
  memdup_nul-64        180
  memdup_nul-32        960
  memdup_nul-16       1860
  memdup_nul-8        1980

Suggested-by: Harry Yoo <harry@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <linux-mm@kvack.org>
---
 mm/util.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 3cc949a0b7ed..419269bb53da 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -34,6 +34,9 @@
 #include "internal.h"
 #include "swap.h"
 
+static kmem_buckets *user_buckets __ro_after_init;
+static kmem_buckets *nul_buckets __ro_after_init;
+
 /**
  * kfree_const - conditionally free memory
  * @x: pointer to the memory
@@ -61,7 +64,7 @@ static __always_inline char *__kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 	char *buf;
 
 	/* '+1' for the NUL terminator */
-	buf = kmalloc_track_caller(len + 1, gfp);
+	buf = kmem_buckets_alloc_track_caller(nul_buckets, len + 1, gfp);
 	if (!buf)
 		return NULL;
 
@@ -195,15 +198,14 @@ char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup_nul);
 
-static kmem_buckets *user_buckets __ro_after_init;
-
-static int __init init_user_buckets(void)
+static int __init init_buckets(void)
 {
 	user_buckets = kmem_buckets_create("memdup_user", 0, 0, INT_MAX, NULL);
+	nul_buckets = kmem_buckets_create("memdup_nul", 0, 0, INT_MAX, NULL);
 
 	return 0;
 }
-subsys_initcall(init_user_buckets);
+subsys_initcall(init_buckets);
 
 /**
  * memdup_user - duplicate memory region from user space
-- 
2.34.1

