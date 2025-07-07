Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72BC266B56;
	Mon,  7 Jul 2025 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751864783; cv=none; b=m3nYRsldKr8kroXqw6HHUz6euV6Qp9eYrbKUrQ7yPhE76Mud7CJzJDlspWHFcPBDp+YJIW5ETdNklUDX8k2pyDdp3fTUIAOalVGy+FzBip+pZ7ktPp0XB7klXxjWrPZ/CUMQOFOxF43tHsr4MlHjvySIiBE0qHdkEDXEa33hhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751864783; c=relaxed/simple;
	bh=EaXLT+CGpKJNtEk9hexswkbKNeTZZeAMwu/sC3gXADA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV32xRtP0Swy2vkH1gip9fhL5fH0jQJ5m1+pMHegMDnpDU0ds7XC6ETSLvEYhq1I9s506Bfm8mOtwRqUu6C3XZIXPoiZAnmseB3zjxS8abBwHeTrg3ytJcT2yqfgIWG1kdXJs6WxTGhBo4ueunye+q4uO+XdEzVeh6nRYupjqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSvChMM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSvChMM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29016C4CEE3;
	Mon,  7 Jul 2025 05:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751864782;
	bh=EaXLT+CGpKJNtEk9hexswkbKNeTZZeAMwu/sC3gXADA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSvChMM4SgLmmvpULy0SkRZpz2mCGzmQiZ8Ov/5O+ovn83peJjLqhVkQNdCGRJK5j
	 lfIbYmewgE/X7QNfQ1MTOnp9eL/u3seltD5/ZWTZ6HKRlTk1gAFwH+JDx5sNDzorVg
	 BXW8TW7ptQlP037WO8II4SojdlIBY+vwgBllRSWTfhJWRXoNyb0WTpQx1K7avcUCU7
	 eePzPHAMxzgKBarPvVNcDaezX70fQRrut1P+kr1nnOv4qhVCI/+W9HkNosA2O+edKn
	 FKF0PPLI8tKDeouni/npT35VK23IzGevvZLThoE5CchDBx0gwfjMLoicGCYvnP+Ea+
	 pi3RaoTCPuJtQ==
Date: Mon, 7 Jul 2025 07:06:20 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>
Subject: [RFC v3 7/7] mm: Use [V]STPRINTF() to avoid specifying the array size
Message-ID: <d0e95db3c80a7356e33587065d258838651b48c0.1751862634.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751862634.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751862634.git.alx@kernel.org>

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 mm/backing-dev.c    | 2 +-
 mm/cma.c            | 4 ++--
 mm/cma_debug.c      | 2 +-
 mm/hugetlb.c        | 3 +--
 mm/hugetlb_cgroup.c | 2 +-
 mm/hugetlb_cma.c    | 2 +-
 mm/kasan/report.c   | 3 +--
 mm/memblock.c       | 4 ++--
 mm/percpu.c         | 2 +-
 mm/shrinker_debug.c | 2 +-
 mm/zswap.c          | 2 +-
 11 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..408fdf52ee5d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1090,7 +1090,7 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	if (bdi->dev)	/* The driver needs to use separate queues per device */
 		return 0;
 
-	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
+	VSTPRINTF(bdi->dev_name, fmt, args);
 	dev = device_create(&bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
diff --git a/mm/cma.c b/mm/cma.c
index c04be488b099..49c54a74d6ce 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -237,9 +237,9 @@ static int __init cma_new_area(const char *name, phys_addr_t size,
 	cma_area_count++;
 
 	if (name)
-		snprintf(cma->name, CMA_MAX_NAME, "%s", name);
+		STPRINTF(cma->name, "%s", name);
 	else
-		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
+		STPRINTF(cma->name, "cma%d\n", cma_area_count);
 
 	cma->available_count = cma->count = size >> PAGE_SHIFT;
 	cma->order_per_bit = order_per_bit;
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index fdf899532ca0..ae94b7ae6710 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -186,7 +186,7 @@ static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
 	rangedir = debugfs_create_dir("ranges", tmp);
 	for (r = 0; r < cma->nranges; r++) {
 		cmr = &cma->ranges[r];
-		snprintf(rdirname, sizeof(rdirname), "%d", r);
+		STPRINTF(rdirname, "%d", r);
 		dir = debugfs_create_dir(rdirname, rangedir);
 		debugfs_create_file("base_pfn", 0444, dir,
 			    &cmr->base_pfn, &cma_debugfs_fops);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6a3cf7935c14..6d0bd88eeba9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4780,8 +4780,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	for (i = 0; i < MAX_NUMNODES; ++i)
 		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
 	INIT_LIST_HEAD(&h->hugepage_activelist);
-	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
-					huge_page_size(h)/SZ_1K);
+	STPRINTF(h->name, "hugepages-%lukB", huge_page_size(h)/SZ_1K);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 58e895f3899a..8f5ffe35d16d 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -822,7 +822,7 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
 	for (i = 0; i < tmpl_size; cft++, tmpl++, i++) {
 		*cft = *tmpl;
 		/* rebuild the name */
-		snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
+		STPRINTF(cft->name, "%s.%s", buf, tmpl->name);
 		/* rebuild the private */
 		cft->private = MEMFILE_PRIVATE(idx, tmpl->private);
 		/* rebuild the file_offset */
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index e0f2d5c3a84c..c28d09e0ce68 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -211,7 +211,7 @@ void __init hugetlb_cma_reserve(int order)
 
 		size = round_up(size, PAGE_SIZE << order);
 
-		snprintf(name, sizeof(name), "hugetlb%d", nid);
+		STPRINTF(name, "hugetlb%d", nid);
 		/*
 		 * Note that 'order per bit' is based on smallest size that
 		 * may be returned to CMA allocator in the case of
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8357e1a33699..62a9bcff236a 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -486,8 +486,7 @@ static void print_memory_metadata(const void *addr)
 		char buffer[4 + (BITS_PER_LONG / 8) * 2];
 		char metadata[META_BYTES_PER_ROW];
 
-		snprintf(buffer, sizeof(buffer),
-				(i == 0) ? ">%px: " : " %px: ", row);
+		STPRINTF(buffer, (i == 0) ? ">%px: " : " %px: ", row);
 
 		/*
 		 * We should not pass a shadow pointer to generic
diff --git a/mm/memblock.c b/mm/memblock.c
index 0e9ebb8aa7fe..20d3928a6b13 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2021,7 +2021,7 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
 		flags = rgn->flags;
 #ifdef CONFIG_NUMA
 		if (numa_valid_node(memblock_get_region_node(rgn)))
-			snprintf(nid_buf, sizeof(nid_buf), " on node %d",
+			STPRINTF(nid_buf, " on node %d",
 				 memblock_get_region_node(rgn));
 #endif
 		pr_info(" %s[%#x]\t[%pa-%pa], %pa bytes%s flags: %#x\n",
@@ -2379,7 +2379,7 @@ int reserve_mem_release_by_name(const char *name)
 
 	start = phys_to_virt(map->start);
 	end = start + map->size - 1;
-	snprintf(buf, sizeof(buf), "reserve_mem:%s", name);
+	STPRINTF(buf, "reserve_mem:%s", name);
 	free_reserved_area(start, end, 0, buf);
 	map->size = 0;
 
diff --git a/mm/percpu.c b/mm/percpu.c
index b35494c8ede2..8d5b5ac7dbef 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3186,7 +3186,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size, pcpu_fc_cpu_to_node_fn_t
 	int upa;
 	int nr_g0_units;
 
-	snprintf(psize_str, sizeof(psize_str), "%luK", PAGE_SIZE >> 10);
+	STPRINTF(psize_str, "%luK", PAGE_SIZE >> 10);
 
 	ai = pcpu_build_alloc_info(reserved_size, 0, PAGE_SIZE, NULL);
 	if (IS_ERR(ai))
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 20eaee3e97f7..7194f2de8594 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -176,7 +176,7 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 		return id;
 	shrinker->debugfs_id = id;
 
-	snprintf(buf, sizeof(buf), "%s-%d", shrinker->name, id);
+	STPRINTF(buf, "%s-%d", shrinker->name, id);
 
 	/* create debugfs entry */
 	entry = debugfs_create_dir(buf, shrinker_debugfs_root);
diff --git a/mm/zswap.c b/mm/zswap.c
index 204fb59da33c..01c96cb5e84f 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -271,7 +271,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 		return NULL;
 
 	/* unique name for each pool specifically required by zsmalloc */
-	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
+	STPRINTF(name, "zswap%x", atomic_inc_return(&zswap_pools_count));
 	pool->zpool = zpool_create_pool(type, name, gfp);
 	if (!pool->zpool) {
 		pr_err("%s zpool not available\n", type);
-- 
2.50.0

