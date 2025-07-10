Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFCF442C;
	Thu, 10 Jul 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183044; cv=none; b=gRHWfTrrKvTHa9Viky0HnkF2xuz3zMmP7Z3dtQGkylh7CcbMRS0mdW5xqBBREf4NFZtl/QFOw5bZjclYw34tCXes/sMABdh6Xq6A+BU1v1RNH9NrPkEN8+vZwL2GwSSj/Mf5CHpi+an7Eng7FNW9KPt4l3GyXF4hGphoR93PJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183044; c=relaxed/simple;
	bh=Xnn+IXQj5m7Kdx+hyHxFwBQBHZWWRRJZ9gvulG8mFuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCsXuFPDWD9ScTXgvM8cpXGGbbMYrySXoVKpMGpl76JAlpOdhddDoswReOJH3VI5Qd48RWnfGzVyVv9DZ1/DQDd5uoOzi2euGmC8vsbNQ0VXb3sgAd+0UjI9dD2lZ1BKJ70Rtpgra/eNAuPIF3E65Ku0ZGhGURPMBjj9YARI5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHxRN2zF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHxRN2zF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F644C4CEE3;
	Thu, 10 Jul 2025 21:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752183044;
	bh=Xnn+IXQj5m7Kdx+hyHxFwBQBHZWWRRJZ9gvulG8mFuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHxRN2zFHN69cp9iL1eyYv8XCqgL5BhTDAhR4lUWXWb/dVpS9FcGzQkBvBROBtRbN
	 6S0WIbivYRBn/nBd2yLo7PaHvpEXCtuFcV+wsfCpLAc3Ls1AGZnFzH76h1vCGb8cp1
	 fSDJ/m4EOjWYXtQesd7trSnp3uJKTl3TkMxWXE2lVkHsbRgULemPY33Dk5mNzSCHkP
	 G4/lo8XU7/sXel4GyQMrfHIp0mCiuRT5Waa7wbj6e2k+56akymnL8dGBUMeue67vt2
	 9I35fZQpOfoYM235g4Ijyc8e3/b+kPHLpDNsri0TWb2JSd/0WYhZpLUymKEoePwz+N
	 PbbygFR9ht89Q==
Date: Thu, 10 Jul 2025 23:30:37 +0200
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
Subject: [RFC v5 0/7] Add and use sprintf_{end,array}() instead of less
 ergonomic APIs
Message-ID: <cover.1752182685.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751823326.git.alx@kernel.org>

Hi,

Changes in v5:

-  Minor fix in commit message.
-  Rename [V]SPRINTF_END() => [v]sprintf_array(), keeping the
   implementation.

Remaining questions:

-  There are only 3 remaining calls to snprintf(3) under mm/.  They are
   just fine for now, which is why I didn't replace them.  If anyone
   wants to replace them, to get rid of all snprintf(3), we could that.
   I think for now we can leave them, to minimize the churn.

        $ grep -rnI snprintf mm/
        mm/hugetlb_cgroup.c:674:                snprintf(buf, size, "%luGB", hsize / SZ_1G);
        mm/hugetlb_cgroup.c:676:                snprintf(buf, size, "%luMB", hsize / SZ_1M);
        mm/hugetlb_cgroup.c:678:                snprintf(buf, size, "%luKB", hsize / SZ_1K);

-  There are only 2 remaining calls to the kernel's scnprintf().  This
   one I would really like to get rid of.  Also, those calls are quite
   suspicious of not being what we want.  Please do have a look at them
   and confirm what's the appropriate behavior in the 2 cases when the
   string is truncated or not copied at all.  That code is very scary
   for me to try to guess.

        $ grep -rnI scnprintf mm/
        mm/kfence/report.c:75:          int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
        mm/kfence/kfence_test.mod.c:22: { 0x96848186, "scnprintf" },
        mm/kmsan/report.c:42:           len = scnprintf(buf, sizeof(buf), "%ps",

   Apart from two calls, I see a string literal with that name.  Please
   let me know if I should do anything about it.  I don't know what that
   is.

-  I think we should remove one error handling check in
   "mm/page_owner.c" (marked with an XXX comment), but I'm not 100%
   sure.  Please confirm.

Other comments:

-  This is still not complying to coding style.  I'll keep it like that
   while questions remain open.
-  I've tested the tests under CONFIG_KFENCE_KUNIT_TEST=y, and this has
   no regressions at all.
-  With the current style of the sprintf_end() prototyope, this triggers
   a diagnostic due to a GCC bug:
   <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108036>
   It would be interesting to ask GCC to fix that bug.  (Added relevant
   GCC maintainers and contributors to CC in this cover letter.)

For anyone new to the thread, sprintf_end() will be proposed for
standardization soon as seprintf():
<https://lore.kernel.org/linux-hardening/20250710024745.143955-1-alx@kernel.org/T/#u>


Have a lovely night!
Alex


Alejandro Colomar (7):
  vsprintf: Add [v]sprintf_end()
  stacktrace, stackdepot: Add sprintf_end()-like variants of functions
  mm: Use sprintf_end() instead of less ergonomic APIs
  array_size.h: Add ENDOF()
  mm: Fix benign off-by-one bugs
  sprintf: Add [v]sprintf_array()
  mm: Use [v]sprintf_array() to avoid specifying the array size

 include/linux/array_size.h |  6 ++++
 include/linux/sprintf.h    |  6 ++++
 include/linux/stackdepot.h | 13 +++++++++
 include/linux/stacktrace.h |  3 ++
 kernel/stacktrace.c        | 28 ++++++++++++++++++
 lib/stackdepot.c           | 13 +++++++++
 lib/vsprintf.c             | 59 ++++++++++++++++++++++++++++++++++++++
 mm/backing-dev.c           |  2 +-
 mm/cma.c                   |  4 +--
 mm/cma_debug.c             |  2 +-
 mm/hugetlb.c               |  3 +-
 mm/hugetlb_cgroup.c        |  2 +-
 mm/hugetlb_cma.c           |  2 +-
 mm/kasan/report.c          |  3 +-
 mm/kfence/kfence_test.c    | 28 +++++++++---------
 mm/kmsan/kmsan_test.c      |  6 ++--
 mm/memblock.c              |  4 +--
 mm/mempolicy.c             | 18 ++++++------
 mm/page_owner.c            | 32 +++++++++++----------
 mm/percpu.c                |  2 +-
 mm/shrinker_debug.c        |  2 +-
 mm/slub.c                  |  5 ++--
 mm/zswap.c                 |  2 +-
 23 files changed, 187 insertions(+), 58 deletions(-)

Range-diff against v4:
1:  2c4f793de0b8 = 1:  2c4f793de0b8 vsprintf: Add [v]sprintf_end()
2:  894d02b08056 = 2:  894d02b08056 stacktrace, stackdepot: Add sprintf_end()-like variants of functions
3:  690ed4d22f57 = 3:  690ed4d22f57 mm: Use sprintf_end() instead of less ergonomic APIs
4:  e05c5afabb3c = 4:  e05c5afabb3c array_size.h: Add ENDOF()
5:  44a5cfc82acf ! 5:  515445ae064d mm: Fix benign off-by-one bugs
    @@ Commit message
     
         We were wasting a byte due to an off-by-one bug.  s[c]nprintf()
         doesn't write more than $2 bytes including the null byte, so trying to
    -    pass 'size-1' there is wasting one byte.  Now that we use seprintf(),
    -    the situation isn't different: seprintf() will stop writing *before*
    +    pass 'size-1' there is wasting one byte.  Now that we use sprintf_end(),
    +    the situation isn't different: sprintf_end() will stop writing *before*
         'end' --that is, at most the terminating null byte will be written at
         'end-1'--.
     
6:  0314948eb225 ! 6:  04c1e026a67f sprintf: Add [V]SPRINTF_END()
    @@ Metadata
     Author: Alejandro Colomar <alx@kernel.org>
     
      ## Commit message ##
    -    sprintf: Add [V]SPRINTF_END()
    +    sprintf: Add [v]sprintf_array()
     
         These macros take the end of the array argument implicitly to avoid
         programmer mistakes.  This guarantees that the input is an array, unlike
    @@ include/linux/sprintf.h
      #include <linux/types.h>
     +#include <linux/array_size.h>
     +
    -+#define SPRINTF_END(a, fmt, ...)  sprintf_end(a, ENDOF(a), fmt, ##__VA_ARGS__)
    -+#define VSPRINTF_END(a, fmt, ap)  vsprintf_end(a, ENDOF(a), fmt, ap)
    ++#define sprintf_array(a, fmt, ...)  sprintf_end(a, ENDOF(a), fmt, ##__VA_ARGS__)
    ++#define vsprintf_array(a, fmt, ap)  vsprintf_end(a, ENDOF(a), fmt, ap)
      
      int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
      
7:  f99632f42eee ! 7:  e53d87e684ef mm: Use [V]SPRINTF_END() to avoid specifying the array size
    @@ Metadata
     Author: Alejandro Colomar <alx@kernel.org>
     
      ## Commit message ##
    -    mm: Use [V]SPRINTF_END() to avoid specifying the array size
    +    mm: Use [v]sprintf_array() to avoid specifying the array size
     
         Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
         Cc: Marco Elver <elver@google.com>
    @@ mm/backing-dev.c: int bdi_register_va(struct backing_dev_info *bdi, const char *
      		return 0;
      
     -	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
    -+	VSPRINTF_END(bdi->dev_name, fmt, args);
    ++	vsprintf_array(bdi->dev_name, fmt, args);
      	dev = device_create(&bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
      	if (IS_ERR(dev))
      		return PTR_ERR(dev);
    @@ mm/cma.c: static int __init cma_new_area(const char *name, phys_addr_t size,
      
      	if (name)
     -		snprintf(cma->name, CMA_MAX_NAME, "%s", name);
    -+		SPRINTF_END(cma->name, "%s", name);
    ++		sprintf_array(cma->name, "%s", name);
      	else
     -		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
    -+		SPRINTF_END(cma->name, "cma%d\n", cma_area_count);
    ++		sprintf_array(cma->name, "cma%d\n", cma_area_count);
      
      	cma->available_count = cma->count = size >> PAGE_SHIFT;
      	cma->order_per_bit = order_per_bit;
    @@ mm/cma_debug.c: static void cma_debugfs_add_one(struct cma *cma, struct dentry *
      	for (r = 0; r < cma->nranges; r++) {
      		cmr = &cma->ranges[r];
     -		snprintf(rdirname, sizeof(rdirname), "%d", r);
    -+		SPRINTF_END(rdirname, "%d", r);
    ++		sprintf_array(rdirname, "%d", r);
      		dir = debugfs_create_dir(rdirname, rangedir);
      		debugfs_create_file("base_pfn", 0444, dir,
      			    &cmr->base_pfn, &cma_debugfs_fops);
    @@ mm/hugetlb.c: void __init hugetlb_add_hstate(unsigned int order)
      	INIT_LIST_HEAD(&h->hugepage_activelist);
     -	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
     -					huge_page_size(h)/SZ_1K);
    -+	SPRINTF_END(h->name, "hugepages-%lukB", huge_page_size(h)/SZ_1K);
    ++	sprintf_array(h->name, "hugepages-%lukB", huge_page_size(h)/SZ_1K);
      
      	parsed_hstate = h;
      }
    @@ mm/hugetlb_cgroup.c: hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftyp
      		*cft = *tmpl;
      		/* rebuild the name */
     -		snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
    -+		SPRINTF_END(cft->name, "%s.%s", buf, tmpl->name);
    ++		sprintf_array(cft->name, "%s.%s", buf, tmpl->name);
      		/* rebuild the private */
      		cft->private = MEMFILE_PRIVATE(idx, tmpl->private);
      		/* rebuild the file_offset */
    @@ mm/hugetlb_cma.c: void __init hugetlb_cma_reserve(int order)
      		size = round_up(size, PAGE_SIZE << order);
      
     -		snprintf(name, sizeof(name), "hugetlb%d", nid);
    -+		SPRINTF_END(name, "hugetlb%d", nid);
    ++		sprintf_array(name, "hugetlb%d", nid);
      		/*
      		 * Note that 'order per bit' is based on smallest size that
      		 * may be returned to CMA allocator in the case of
    @@ mm/kasan/report.c: static void print_memory_metadata(const void *addr)
      
     -		snprintf(buffer, sizeof(buffer),
     -				(i == 0) ? ">%px: " : " %px: ", row);
    -+		SPRINTF_END(buffer, (i == 0) ? ">%px: " : " %px: ", row);
    ++		sprintf_array(buffer, (i == 0) ? ">%px: " : " %px: ", row);
      
      		/*
      		 * We should not pass a shadow pointer to generic
    @@ mm/memblock.c: static void __init_memblock memblock_dump(struct memblock_type *t
      #ifdef CONFIG_NUMA
      		if (numa_valid_node(memblock_get_region_node(rgn)))
     -			snprintf(nid_buf, sizeof(nid_buf), " on node %d",
    -+			SPRINTF_END(nid_buf, " on node %d",
    ++			sprintf_array(nid_buf, " on node %d",
      				 memblock_get_region_node(rgn));
      #endif
      		pr_info(" %s[%#x]\t[%pa-%pa], %pa bytes%s flags: %#x\n",
    @@ mm/memblock.c: int reserve_mem_release_by_name(const char *name)
      	start = phys_to_virt(map->start);
      	end = start + map->size - 1;
     -	snprintf(buf, sizeof(buf), "reserve_mem:%s", name);
    -+	SPRINTF_END(buf, "reserve_mem:%s", name);
    ++	sprintf_array(buf, "reserve_mem:%s", name);
      	free_reserved_area(start, end, 0, buf);
      	map->size = 0;
      
    @@ mm/percpu.c: int __init pcpu_page_first_chunk(size_t reserved_size, pcpu_fc_cpu_
      	int nr_g0_units;
      
     -	snprintf(psize_str, sizeof(psize_str), "%luK", PAGE_SIZE >> 10);
    -+	SPRINTF_END(psize_str, "%luK", PAGE_SIZE >> 10);
    ++	sprintf_array(psize_str, "%luK", PAGE_SIZE >> 10);
      
      	ai = pcpu_build_alloc_info(reserved_size, 0, PAGE_SIZE, NULL);
      	if (IS_ERR(ai))
    @@ mm/shrinker_debug.c: int shrinker_debugfs_add(struct shrinker *shrinker)
      	shrinker->debugfs_id = id;
      
     -	snprintf(buf, sizeof(buf), "%s-%d", shrinker->name, id);
    -+	SPRINTF_END(buf, "%s-%d", shrinker->name, id);
    ++	sprintf_array(buf, "%s-%d", shrinker->name, id);
      
      	/* create debugfs entry */
      	entry = debugfs_create_dir(buf, shrinker_debugfs_root);
    @@ mm/zswap.c: static struct zswap_pool *zswap_pool_create(char *type, char *compre
      
      	/* unique name for each pool specifically required by zsmalloc */
     -	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
    -+	SPRINTF_END(name, "zswap%x", atomic_inc_return(&zswap_pools_count));
    ++	sprintf_array(name, "zswap%x", atomic_inc_return(&zswap_pools_count));
      	pool->zpool = zpool_create_pool(type, name, gfp);
      	if (!pool->zpool) {
      		pr_err("%s zpool not available\n", type);
-- 
2.50.0

