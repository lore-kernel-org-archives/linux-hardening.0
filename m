Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C52FD696;
	Wed, 14 Oct 2026 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791955426; cv=none; b=EqXEiWpbHYV25umH+vF26Gb0kzDqD2PowqIHoW9cAnDDbR9VAMKd3SsXz8goIs6sGr8ygLxgfhMjeZa+qWVwb5DNc3us6t6IPNZOG+Xw267x7kI7ZGJYa4M+ThqhgyXAZFdc9K/53giCK3DAIcYRKGozMaQvntAZXEhOLONQEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791955426; c=relaxed/simple;
	bh=KqfbVCq/uttC9NZZEzuvqGaEBpfsS3q5IX9Y3dwx7Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kArQsWZy9ztg7LbEHxKtrP3rNUf5MDEjgXp5TkLKZDZBbRY1a1rU6N0lqwoi83wY5Blh+aN1wdiQx1kdbaKz1qJNoZQeGFe7VwmuUzdh8rYjuY8sQQuWD4tZPhd2/YkIrDCs5Ee7S2fohuDIdxIpd7U+TgyZLeqcksvce2+4lIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWUy0I8g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWUy0I8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DF21F00893;
	Wed, 14 Oct 2026 05:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791955424;
	bh=DxBlHiyxQnkomrHKRTne2QV8xmS9hT0nspY3XRMEVWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WWUy0I8gBwJ01lFC5f8D/cYm1bdbW2yI/FzyXuxB+3pzt9oM66mFIJ5e6UiSXZeMo
	 4Sb4jUgOj2T2AgOJ6Qih6viuw5ZTYFE/5y5uEzZhbOoEWUF9QgGtdXwX4soNLWfLa3
	 HeyfX77CbeMA23wlnNkuL/aDuSggp6vaHISVA5GOyCF8OPstcbz0aktvCAQz2G07r7
	 /F8V4al0bUpfEwcIxKjWWDRSjzJqh4FVAf6oayzDqGF8NjJhPaL8F0bL4IynXd+iLD
	 Nwj1adxN5pJ9ugR+F/NH+dG0GQx7ZZGGbjxkaITQMHHgSP5EKWu2g7qpzf7gTIVP/M
	 zyjfvjqLBodgA==
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
Subject: [PATCH v7 1/2] mm/slab: Mark the kmem_buckets_create() context as a Context: section
Date: Tue, 13 Oct 2026 22:23:42 -0700
Message-ID: <20261014052344.384723-1-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014052338.nothing.279-kees@kernel.org>
References: <20261014052338.nothing.279-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=kees@kernel.org; h=from:subject; bh=KqfbVCq/uttC9NZZEzuvqGaEBpfsS3q5IX9Y3dwx7Uw=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnnBe9Z/lrYtMzAcEuVwirV1MU7PM45LuhYaqqjGPf+z +TklpkiHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABMRnMjwv2yFzfbQ1Wc+iPPp vMq97b1ky60wp8T0LUdn+sqr+q5yvc7IcI59S6PgHfHZf/UbFq/vVWe4W33s6xSR9qnFTxoPlPx S5gIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

kmem_buckets_create() had the same sentence about calling context as
kmem_cache_create(), but lacked the "Context:" prefix, so kernel-doc
rendered in the body instead of as a "context" section.

Give it the missing prefix. Additionally fix the "a interrupt" typo
__kmem_cache_create_args() had.

Fixes: b32801d1255be ("mm/slab: Introduce kmem_buckets_create() and family")
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Hao Li <hao.li@linux.dev>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
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

