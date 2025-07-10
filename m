Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293B1E520B;
	Thu, 10 Jul 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183091; cv=none; b=kKGnu6ZjTEudMpwSkM7ac3cM03O2+5rHoqJUZuoHZWqyLPKttNMmcFrFbnlwEZsIKONUj8CompVm5qdZLD22sWEfalUkx9kkYgWn10+OFmqDtDGiDTCoYMqmMbCiVMP4TBpfDZ7uS4RMpEVqxV0WAQ7cEMg0/9CcbqXPAZEo1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183091; c=relaxed/simple;
	bh=VJYVfYb5aKbK4eQQkUA5lmVUT/3A2ehIMDd21vB14NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm2b5W1lZgnuDwQwoOFmF9i+ClC1oBLRqLmXFUpI9ir0R93nGqTSi0YxwXV3lLm93t3GYrqzklD2Ck8fp+7FKj8fqJAad5ZmveDL8GiPdEeincZuhHN9fLcwi2FcsGGLlmO5bANu+Yj5wBzgPIp6QQtGA/NSX17Fv13OnuvcCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeSK1sDO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeSK1sDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFACC4CEF4;
	Thu, 10 Jul 2025 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752183091;
	bh=VJYVfYb5aKbK4eQQkUA5lmVUT/3A2ehIMDd21vB14NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeSK1sDOqEclROIugmqbQobZxBiZYdf79kQefbcHMOIrfLbYKgKXDx74hfzKBA1vG
	 BtdznHoti6CyrMOuAXA+R4jLegAAXftBL79z8VC8CJHmBXRzZGWMaG3ycxud3fzQm3
	 j9WYcAqeN6MIpkDiSzrd8s73a+/yJZh6fHmOFGZvQRCfpGlDTNetJyIPotmjAEnPRS
	 mKP5Sqn74tj7b6ae+9hYkVBLg5C0C4SF0uiNnJUFKqdWh/aZMWfEaQJOlVQ/V94nUs
	 6Hlowmrz2W7Tx3VmqxJZeBRhnBLI4ZGtM5oF0OhPejveemcixwGk1PycR5fRTkMOgb
	 t8nVu0In2zF2g==
Date: Thu, 10 Jul 2025 23:31:24 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>
Subject: [RFC v5 7/7] mm: Use [v]sprintf_array() to avoid specifying the
 array size
Message-ID: <e53d87e684ef4aa940e71e679b6e75fd7cedac36.1752182685.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1752182685.git.alx@kernel.org>

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Marco Elver <elver@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
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
index 783904d8c5ef..c4e588135aea 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1090,7 +1090,7 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	if (bdi->dev)	/* The driver needs to use separate queues per device */
 		return 0;
 
-	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
+	vsprintf_array(bdi->dev_name, fmt, args);
 	dev = device_create(&bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
diff --git a/mm/cma.c b/mm/cma.c
index c04be488b099..61d97a387670 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -237,9 +237,9 @@ static int __init cma_new_area(const char *name, phys_addr_t size,
 	cma_area_count++;
 
 	if (name)
-		snprintf(cma->name, CMA_MAX_NAME, "%s", name);
+		sprintf_array(cma->name, "%s", name);
 	else
-		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
+		sprintf_array(cma->name, "cma%d\n", cma_area_count);
 
 	cma->available_count = cma->count = size >> PAGE_SHIFT;
 	cma->order_per_bit = order_per_bit;
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index fdf899532ca0..751eae9f6364 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -186,7 +186,7 @@ static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
 	rangedir = debugfs_create_dir("ranges", tmp);
 	for (r = 0; r < cma->nranges; r++) {
 		cmr = &cma->ranges[r];
-		snprintf(rdirname, sizeof(rdirname), "%d", r);
+		sprintf_array(rdirname, "%d", r);
 		dir = debugfs_create_dir(rdirname, rangedir);
 		debugfs_create_file("base_pfn", 0444, dir,
 			    &cmr->base_pfn, &cma_debugfs_fops);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6a3cf7935c14..70acc8b3cbb8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4780,8 +4780,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	for (i = 0; i < MAX_NUMNODES; ++i)
 		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
 	INIT_LIST_HEAD(&h->hugepage_activelist);
-	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
-					huge_page_size(h)/SZ_1K);
+	sprintf_array(h->name, "hugepages-%lukB", huge_page_size(h)/SZ_1K);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 58e895f3899a..0953cea93759 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -822,7 +822,7 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
 	for (i = 0; i < tmpl_size; cft++, tmpl++, i++) {
 		*cft = *tmpl;
 		/* rebuild the name */
-		snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
+		sprintf_array(cft->name, "%s.%s", buf, tmpl->name);
 		/* rebuild the private */
 		cft->private = MEMFILE_PRIVATE(idx, tmpl->private);
 		/* rebuild the file_offset */
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index e0f2d5c3a84c..bae82a97a43c 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -211,7 +211,7 @@ void __init hugetlb_cma_reserve(int order)
 
 		size = round_up(size, PAGE_SIZE << order);
 
-		snprintf(name, sizeof(name), "hugetlb%d", nid);
+		sprintf_array(name, "hugetlb%d", nid);
 		/*
 		 * Note that 'order per bit' is based on smallest size that
 		 * may be returned to CMA allocator in the case of
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8357e1a33699..3b40225e7873 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -486,8 +486,7 @@ static void print_memory_metadata(const void *addr)
 		char buffer[4 + (BITS_PER_LONG / 8) * 2];
 		char metadata[META_BYTES_PER_ROW];
 
-		snprintf(buffer, sizeof(buffer),
-				(i == 0) ? ">%px: " : " %px: ", row);
+		sprintf_array(buffer, (i == 0) ? ">%px: " : " %px: ", row);
 
 		/*
 		 * We should not pass a shadow pointer to generic
diff --git a/mm/memblock.c b/mm/memblock.c
index 0e9ebb8aa7fe..3eea7a177330 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2021,7 +2021,7 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
 		flags = rgn->flags;
 #ifdef CONFIG_NUMA
 		if (numa_valid_node(memblock_get_region_node(rgn)))
-			snprintf(nid_buf, sizeof(nid_buf), " on node %d",
+			sprintf_array(nid_buf, " on node %d",
 				 memblock_get_region_node(rgn));
 #endif
 		pr_info(" %s[%#x]\t[%pa-%pa], %pa bytes%s flags: %#x\n",
@@ -2379,7 +2379,7 @@ int reserve_mem_release_by_name(const char *name)
 
 	start = phys_to_virt(map->start);
 	end = start + map->size - 1;
-	snprintf(buf, sizeof(buf), "reserve_mem:%s", name);
+	sprintf_array(buf, "reserve_mem:%s", name);
 	free_reserved_area(start, end, 0, buf);
 	map->size = 0;
 
diff --git a/mm/percpu.c b/mm/percpu.c
index b35494c8ede2..a467102c2405 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3186,7 +3186,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size, pcpu_fc_cpu_to_node_fn_t
 	int upa;
 	int nr_g0_units;
 
-	snprintf(psize_str, sizeof(psize_str), "%luK", PAGE_SIZE >> 10);
+	sprintf_array(psize_str, "%luK", PAGE_SIZE >> 10);
 
 	ai = pcpu_build_alloc_info(reserved_size, 0, PAGE_SIZE, NULL);
 	if (IS_ERR(ai))
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 20eaee3e97f7..f529ac29557c 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -176,7 +176,7 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 		return id;
 	shrinker->debugfs_id = id;
 
-	snprintf(buf, sizeof(buf), "%s-%d", shrinker->name, id);
+	sprintf_array(buf, "%s-%d", shrinker->name, id);
 
 	/* create debugfs entry */
 	entry = debugfs_create_dir(buf, shrinker_debugfs_root);
diff --git a/mm/zswap.c b/mm/zswap.c
index 204fb59da33c..e66b5c5b1ecf 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -271,7 +271,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 		return NULL;
 
 	/* unique name for each pool specifically required by zsmalloc */
-	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
+	sprintf_array(name, "zswap%x", atomic_inc_return(&zswap_pools_count));
 	pool->zpool = zpool_create_pool(type, name, gfp);
 	if (!pool->zpool) {
 		pr_err("%s zpool not available\n", type);
-- 
2.50.0

