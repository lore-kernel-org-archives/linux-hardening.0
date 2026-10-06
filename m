Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52F3A9D94;
	Tue,  6 Oct 2026 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278437; cv=none; b=h1a9zB5afy0pYJEpuBxDT2T951CtdnD6H5++iSEijvHA0asqeLObFCoippkoUugfr7EUHXl8REOe2G+FLm5+w17XN/aMFb0X0lUS8L9ziNco4RMcIc6myl32oL0/qsXlIIJcfgvGrS3tn8tEfiKJ9KyVUlhON8TvFq7ThGN4Jdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278437; c=relaxed/simple;
	bh=qvVs6BUL6uU5DGS29fmp8uUzY+nuvwiJ5sJfljH/ZrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE5Mw+r9yuX1z8rvcm/VQWy4xUsj6vK1tN6cAm5f0XakD+4+UTfjxY+Q0XSgTfnofu8wIivyLNjGaJzHWDfV/EqInnMksWrYBdD/9kkhQhCiNAegjXjj9XNXL8VhjhNA83PDvL78cBG12ujGPOG+/KCgXGIvlOyvIanN33KkkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRw+ahTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRw+ahTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0B31F000FF;
	Tue,  6 Oct 2026 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278436;
	bh=g22MNOcpZQJw77B5VL8DpAGxBVPLTKqDTmR4tL3lAoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRw+ahTZOj8L5wMO/OOKXOp+m9QqnvsM5QclJ2Og8BK0ZKjzb0r3QaToflZoWBxNj
	 0ixbDV7CTgQuAViLDZ4qn68GDlQR7JpowyAb6DtOK4EzhfVAluV9DP9BlRr/PQElkH
	 zxJ67wrI5jLV52zefbwDwhXtipAjVbGjHMoN1xgO9CrQdDoqAGnRhR+drQJKeZ+tVw
	 QGhwiATEhEcyDhZXGlkIMpe2LVhMXIk3vA6SCakgnwRaTzkOyj0gn59yJX2CAJfukr
	 O81wfm2M48KuWfEAtzri9Dtffd2vrW+77rTYkHwrXTTB7REMEoCCkTPzSoAuJ56DPE
	 JrH6B6Da/nM7A==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	Pedro Falcato <pfalcato@suse.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/8] mm/slab: Mark the kmem_buckets_create() context as a Context: section
Date: Tue,  6 Oct 2026 02:20:27 -0700
Message-ID: <20261006092035.166776-1-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006092030.got.500-kees@kernel.org>
References: <20261006092030.got.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=kees@kernel.org; h=from:subject; bh=qvVs6BUL6uU5DGS29fmp8uUzY+nuvwiJ5sJfljH/ZrI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlH9saLnhcKCTUMfdiWFjUn4/CmE+kh7qycc6MnSHyxt +4IqZndUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMBEeVUaGdQ5K/KGvzNR6r+7Y 8/n4Lqv8aD49Bp493sHLgjW3y2ydyfDP+tu/PTv4TTstL0+3SWt/GPaS68kPy/XVGl8PtFmFbOX kAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

kmem_buckets_create() had the same sentence about calling context as
kmem_cache_create(), but lacked the "Context:" prefix, so kernel-doc
rendered in the body instead of as a "context" section.

Give it the missing prefix. Additionally fix the "a interrupt" typo
__kmem_cache_create_args() had.

Fixes: b32801d1255be ("mm/slab: Introduce kmem_buckets_create() and family")
Assisted-by: LLM
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Hao Li <hao.li@linux.dev>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 mm/slab_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index b19ba1b31484..270408ce5a9d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -311,7 +311,7 @@ __kmem_cache_alias(const char *name, unsigned int size, slab_flags_t flags,
  * &SLAB_TYPESAFE_BY_RCU - Slab page (not individual objects) freeing delayed
  * by a grace period - see the full description before using.
  *
- * Context: Cannot be called within a interrupt, but can be interrupted.
+ * Context: Cannot be called within an interrupt, but can be interrupted.
  *
  * Return: a pointer to the cache on success, NULL on failure.
  */
@@ -422,7 +422,7 @@ static struct kmem_cache *kmem_buckets_cache __ro_after_init;
  *		to/from userspace.
  * @ctor: A constructor for the objects, run when new allocations are made.
  *
- * Cannot be called within an interrupt, but can be interrupted.
+ * Context: Cannot be called within an interrupt, but can be interrupted.
  *
  * Return: a pointer to the cache on success, NULL on failure. When
  * CONFIG_SLAB_BUCKETS is not enabled, ZERO_SIZE_PTR is returned, and
-- 
2.55.0

