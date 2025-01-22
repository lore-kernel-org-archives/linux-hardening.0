Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0A154420;
	Wed, 22 Jan 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737531469; cv=none; b=UEcG+cVzgWnfjkH741Byt2P9eZWTTLZOWJwJbr0/8fFHHQNFgh2phmhpekofnBfSe4nZ6hpbw0GQl1Ya+zed7TRg0C/zqxeamow5xvfQrlztfmLjnb4Hx8jeeui1Hav70ynVxJX+6glUn6IqsJcjFU8ZySKdsvr3/E2Usk4wl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737531469; c=relaxed/simple;
	bh=YzFrKhpKqWZ75ZD9emtXN+OJdy4cFHJqw0fD82uCYUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z1mWeb/ubpLh0Onx1ZYXrYpFoCD292jSOqszsB4pEFSh07/A7KcuaJO07gwSNdXu3iEvFyxokrlqyKVwzczA+OTQJ4A+6FFU1ekPdBpkmKmnV9KFpf43HKAPIkjh7fZJdDFlCTL7Va0gF+U2Uyti+luoPFfFAsMphh9hZyrRT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YdG9S0Z7nz1JHq6;
	Wed, 22 Jan 2025 15:36:44 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 583681400CF;
	Wed, 22 Jan 2025 15:37:44 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 22 Jan
 2025 15:37:43 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew
 Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Kees
 Cook <kees@kernel.org>
CC: Tamas Koczka <poprdi@google.com>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Xiu Jianfeng
	<xiujianfeng@huawei.com>, <linux-mm@kvack.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/slab: Achieve better kmalloc caches randomization in kvmalloc
Date: Wed, 22 Jan 2025 15:48:17 +0800
Message-ID: <20250122074817.991060-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg100016.china.huawei.com (7.202.181.57)

As revealed by this writeup[1], due to the fact that __kmalloc_node (now
renamed to __kmalloc_node_noprof) is an exported symbol and will never
get inlined, using it in kvmalloc_node (now is __kvmalloc_node_noprof)
would make the RET_IP inside always point to the same address:

    upper_caller
        kvmalloc
        kvmalloc_node
        kvmalloc_node_noprof
        __kvmalloc_node_noprof	<-- all macros all the way down here
            __kmalloc_node_noprof
                __do_kmalloc_node(.., _RET_IP_)
            ...			<-- _RET_IP_ points to

That literally means all kmalloc invoked via kvmalloc would use the same
seed for cache randomization (CONFIG_RANDOM_KMALLOC_CACHES), which makes
this hardening unfunctional.

The root cause of this problem, IMHO, is that using RET_IP only cannot
identify the actual allocation site in case of kmalloc being called
inside wrappers or helper functions. And I believe there could be
similar cases in other functions. Nevertheless, I haven't thought of
any good solution for this. So for now let's solve this specific case
first.

For __kvmalloc_node_noprof, replace __kmalloc_node_noprof with an inline
version, so that RET_IP can take the return address of kvmalloc and
differentiate each kvmalloc invocation:

    upper_caller
        kvmalloc
        kvmalloc_node
        kvmalloc_node_noprof
        __kvmalloc_node_noprof	<-- all macros all the way down here
            __kmalloc_node_inline(.., _RET_IP_)
        ...			<-- _RET_IP_ points to

Thanks to Tamás Koczka for the report and discussion!

Links:
[1] https://github.com/google/security-research/pull/83/files#diff-1604319b55a48c39a210ee52034ed7ff5b9cdc3d704d2d9e34eb230d19fae235R200

Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 include/linux/slab.h | 3 +++
 mm/slub.c            | 7 +++++++
 mm/util.c            | 4 ++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 10a971c2bde3..e03ca4a95511 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -834,6 +834,9 @@ void *__kmalloc_large_noprof(size_t size, gfp_t flags)
 void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
 				__assume_page_alignment __alloc_size(1);
 
+void *__kmalloc_node_inline(size_t size, kmem_buckets *b, gfp_t flags,
+				int node, unsigned long caller);
+
 /**
  * kmalloc - allocate kernel memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slub.c b/mm/slub.c
index c2151c9fee22..ec75070345c6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4319,6 +4319,13 @@ void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flag
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller_noprof);
 
+__always_inline void *__kmalloc_node_inline(size_t size, kmem_buckets *b,
+					    gfp_t flags, int node,
+					    unsigned long caller)
+{
+	return __do_kmalloc_node(size, b, flags, node, caller);
+}
+
 void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE,
diff --git a/mm/util.c b/mm/util.c
index 60aa40f612b8..3910d1d1f595 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -642,9 +642,9 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 	 * It doesn't really make sense to fallback to vmalloc for sub page
 	 * requests
 	 */
-	ret = __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, b),
+	ret = __kmalloc_node_inline(size, PASS_BUCKET_PARAM(b),
 				    kmalloc_gfp_adjust(flags, size),
-				    node);
+				    node, _RET_IP_);
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
-- 
2.25.1

