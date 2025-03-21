Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D815230BFB;
	Fri, 21 Mar 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589672; cv=none; b=SP/jclsaq6C4o64SBfcl7YrM+MSmMqlV7/NjUB1c9Tf8WHL7vwcQxkHVUYOOM0j89pslUCE/HK/MyZ4PlwWx5+/jZsWsCt9+7lWFwBWtlvbHEmB10Qb7kaeu7y2ZyNk170XBPMsMs/avUoyB8GOYEEBNC1ck4yAHRZsSenYWvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589672; c=relaxed/simple;
	bh=wsCETj06SFFwh38K8EPA2OIG7ZSdRNghUF4foeMZKA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IBdNaCWqhew4xmt+Vpn+ql3y/ra6RkgKrYcQqlcUO7qia1YEyaJJjNabbMiLc9h3C7IouvI3+PcqNfpDj6bhdajvdc4Co9mVopTj+DGiv1uaz0zWvNnZqDbqKG6pDzamHtAyAup/eTor6dfuFJ75HjZ7rkI9LupiVT3hWy+riTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYzyp0aL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYzyp0aL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1762C4CEE3;
	Fri, 21 Mar 2025 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742589669;
	bh=wsCETj06SFFwh38K8EPA2OIG7ZSdRNghUF4foeMZKA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYzyp0aLWgDl0chozGbeMXfTMMhk/SOYcfZdkjm35EMrTm3VeBv90LidlrwxCiInT
	 namgg0O/WeBJmRe/N4ulBNHbUwZ8VjE6cjPYe7sBRXlz7qVGFp5eSGKmWw6y2cpxSe
	 qA/8qqMlwf/C1+n12LCV/XaOphvs2/5TPUWIlDSqyiF/hu3aUu+SoMzuqFYYNSxcs4
	 2MwBQCaqAvzjWPyCkgd95sfobXgphcIaJ9e+cTdtmnpjmBN12zZf2MzS8OAJWd81ty
	 YZj7useSYKYdXG4Par3lBSq4ANcAPOEYyVGD6gPk24uWmvZcKP9HlEu4GBGDm6OkyZ
	 KMUavJYMseCxw==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 5/5] [DEBUG] slab: Report number of NULLings
Date: Fri, 21 Mar 2025 13:41:01 -0700
Message-Id: <20250321204105.1898507-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321202620.work.175-kees@kernel.org>
References: <20250321202620.work.175-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=kees@kernel.org; h=from:subject; bh=wsCETj06SFFwh38K8EPA2OIG7ZSdRNghUF4foeMZKA0=; b=owGbwMvMwCVmps19z/KJym7G02pJDOl3z91590rZfsX3/KkRkz2Tr3/lvxS3c+Frkbx/J5+sf qA7OS3+QEcpC4MYF4OsmCJLkJ17nIvH2/Zw97mKMHNYmUCGMHBxCsBEbE0Z/unwiAjKzpU2NTzO nvHlE8OVdfGafqJGd9xSlqZW9TqXOjD8zyla8nTDqfSFWhVxl4Ne67d/+yrb8F3pns91jnMnnb+ 95AcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Just to get a sense of what's happening, report the number of NULL
assignments that have been done. After booting an otherwise standard
Ubuntu image, this shows about 240,000 NULLifications have been performed.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 3 +++
 mm/slab_common.c     | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 2717ad238fa2..a4740c8b6ccb 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -469,6 +469,8 @@ void __kfree(const void *objp);
 void __kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
+extern atomic_t count_nulled;
+
 static inline void kfree_and_null(void **ptr)
 {
 	__kfree(*ptr);
@@ -487,6 +489,7 @@ static inline void kfree_sensitive_and_null(void **ptr)
 ({					\
 	typeof(x) *__ptr = &(x);	\
 	__how ## _and_null((void **)__ptr);	\
+	atomic_inc(&count_nulled);	\
 })
 #define __free_and_maybe_null(__how, x)	\
 	__builtin_choose_expr(__is_lvalue(x), \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9a82952ec266..0412cbab81f9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -42,6 +42,9 @@ LIST_HEAD(slab_caches);
 DEFINE_MUTEX(slab_mutex);
 struct kmem_cache *kmem_cache;
 
+atomic_t count_nulled = ATOMIC_INIT(0);
+EXPORT_SYMBOL(count_nulled);
+
 /*
  * Set of flags that will prevent slab merging
  */
@@ -1084,6 +1087,7 @@ static void print_slabinfo_header(struct seq_file *m)
 	 * without _too_ many complaints.
 	 */
 	seq_puts(m, "slabinfo - version: 2.1\n");
+	seq_printf(m, "# nulled: %d\n", atomic_read(&count_nulled));
 	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
 	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
 	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
-- 
2.34.1

