Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572929E11B;
	Sun,  6 Jul 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823460; cv=none; b=TNVB5GIrDhF7rLb1W7D+f5amlkMIsiKhswVq0VIP8We8RKgWawISKobt6q+cO1Vv6zWBEboSuhe9qIBQyAN4VJLItlVB3CzHJIa7K6Bwr6mi5aPGGU0zXuMqMD2MJz701hAOeBhnNexj64w5IiO7Zt4qCyCId9x8OghTVMaZArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823460; c=relaxed/simple;
	bh=EOC8hc/se0MHRZ8SrRfccouU5lvaqaEihSZqCN2Z/O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvLWO0LVZNq+JD2L6mdZgYTMY8pZ8J1XxJQEyxw+JxVNVpe+460+R2SLHkDVSqrxz8epS9MiSNGfNsQy+8O1G5aZzEwTnCC3BhAtIXilEI8v17bVBh2B8osrtR633SNsJM5G1khsw1TBnJkDmMTGn7Mm1D0p8/Aey7OOOcMYkrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1weyM3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1weyM3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34891C4CEEE;
	Sun,  6 Jul 2025 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751823460;
	bh=EOC8hc/se0MHRZ8SrRfccouU5lvaqaEihSZqCN2Z/O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1weyM3hNVPu0/1x16f9Mt8C8UeDTBQK+dyY7SRq0JFMah2iy9UbTB4dMkJpKRNmv
	 AHl5PkWOt+XiXoXDcJqlKdizIYlrPWQcnTIjVn5WRVhhXaKolHRdlqAxamQgXAwGBT
	 KtV9WV7MCGqGIp1IEhZY1mQJi7eHof0+bsJKrQnQoA2unlX79nw4lY6nE7CaBDVABB
	 cneEqaPcStmGCHrE7MMbXPjM8SVMcXyiXQKvaER04YM6/ZYAjxe821pgoovXYEWF8I
	 fE+Na4z2bLIbgmLxWZ2qGQXMIcIEz7Jez7WEM9wmQ89gWygknYwxHo+moxgARji0Rf
	 tloCrZBoTosUw==
Date: Sun, 6 Jul 2025 19:37:38 +0200
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
Subject: [RFC v2 3/5] mm: Use seprintf() instead of less ergonomic APIs
Message-ID: <e3271b5f2ad9fe1282c8e6892a15984b9e316340.1751823326.git.alx@kernel.org>
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

While doing this, I detected some anomalies in the existing code:

mm/kfence/kfence_test.c:

	-  The last call to scnprintf() did increment 'cur', but it's
	   unused after that, so it was dead code.  I've removed the dead
	   code in this patch.

	-  'end' is calculated as

		end = &expect[0][sizeof(expect[0] - 1)];

	   However, the '-1' doesn't seem to be necessary.  When passing
	   $2 to scnprintf(), the size was specified as 'end - cur'.
	   And scnprintf() --just like snprintf(3)--, won't write more
	   than $2 bytes (including the null byte).  That means that
	   scnprintf() wouldn't write more than

		&expect[0][sizeof(expect[0]) - 1] - expect[0]

	   which simplifies to

		sizeof(expect[0]) - 1

	   bytes.  But we have sizeof(expect[0]) bytes available, so
	   we're wasting one byte entirely.  This is a benign off-by-one
	   bug.  The two occurrences of this bug will be fixed in a
	   following patch in this series.

mm/kmsan/kmsan_test.c:

	The same benign off-by-one bug calculating the remaining size.

mm/mempolicy.c:

	This file uses the 'p += snprintf()' anti-pattern.  That will
	overflow the pointer on truncation, which has undefined
	behavior.  Using seprintf(), this bug is fixed.

	As in the previous file, here there was also dead code in the
	last scnprintf() call, by incrementing a pointer that is not
	used after the call.  I've removed the dead code.

mm/page_owner.c:

	Within print_page_owner(), there are some calls to scnprintf(),
	which do report truncation.  And then there are other calls to
	snprintf(), where we handle errors (there are two 'goto err').

	I've kept the existing error handling, as I trust it's there for
	a good reason (i.e., we may want to avoid calling
	print_page_owner_memcg() if we truncated before).  Please review
	if this amount of error handling is the right one, or if we want
	to add or remove some.  For seprintf(), a single test for null
	after the last call is enough to detect truncation.

mm/slub.c:

	Again, the 'p += snprintf()' anti-pattern.  This is UB, and by
	using seprintf() we've fixed the bug.

Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 mm/kfence/kfence_test.c | 24 ++++++++++++------------
 mm/kmsan/kmsan_test.c   |  4 ++--
 mm/mempolicy.c          | 18 +++++++++---------
 mm/page_owner.c         | 32 +++++++++++++++++---------------
 mm/slub.c               |  5 +++--
 5 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 00034e37bc9f..ff734c514c03 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -113,26 +113,26 @@ static bool report_matches(const struct expect_report *r)
 	end = &expect[0][sizeof(expect[0]) - 1];
 	switch (r->type) {
 	case KFENCE_ERROR_OOB:
-		cur += scnprintf(cur, end - cur, "BUG: KFENCE: out-of-bounds %s",
+		cur = seprintf(cur, end, "BUG: KFENCE: out-of-bounds %s",
 				 get_access_type(r));
 		break;
 	case KFENCE_ERROR_UAF:
-		cur += scnprintf(cur, end - cur, "BUG: KFENCE: use-after-free %s",
+		cur = seprintf(cur, end, "BUG: KFENCE: use-after-free %s",
 				 get_access_type(r));
 		break;
 	case KFENCE_ERROR_CORRUPTION:
-		cur += scnprintf(cur, end - cur, "BUG: KFENCE: memory corruption");
+		cur = seprintf(cur, end, "BUG: KFENCE: memory corruption");
 		break;
 	case KFENCE_ERROR_INVALID:
-		cur += scnprintf(cur, end - cur, "BUG: KFENCE: invalid %s",
+		cur = seprintf(cur, end, "BUG: KFENCE: invalid %s",
 				 get_access_type(r));
 		break;
 	case KFENCE_ERROR_INVALID_FREE:
-		cur += scnprintf(cur, end - cur, "BUG: KFENCE: invalid free");
+		cur = seprintf(cur, end, "BUG: KFENCE: invalid free");
 		break;
 	}
 
-	scnprintf(cur, end - cur, " in %pS", r->fn);
+	seprintf(cur, end, " in %pS", r->fn);
 	/* The exact offset won't match, remove it; also strip module name. */
 	cur = strchr(expect[0], '+');
 	if (cur)
@@ -144,26 +144,26 @@ static bool report_matches(const struct expect_report *r)
 
 	switch (r->type) {
 	case KFENCE_ERROR_OOB:
-		cur += scnprintf(cur, end - cur, "Out-of-bounds %s at", get_access_type(r));
+		cur = seprintf(cur, end, "Out-of-bounds %s at", get_access_type(r));
 		addr = arch_kfence_test_address(addr);
 		break;
 	case KFENCE_ERROR_UAF:
-		cur += scnprintf(cur, end - cur, "Use-after-free %s at", get_access_type(r));
+		cur = seprintf(cur, end, "Use-after-free %s at", get_access_type(r));
 		addr = arch_kfence_test_address(addr);
 		break;
 	case KFENCE_ERROR_CORRUPTION:
-		cur += scnprintf(cur, end - cur, "Corrupted memory at");
+		cur = seprintf(cur, end, "Corrupted memory at");
 		break;
 	case KFENCE_ERROR_INVALID:
-		cur += scnprintf(cur, end - cur, "Invalid %s at", get_access_type(r));
+		cur = seprintf(cur, end, "Invalid %s at", get_access_type(r));
 		addr = arch_kfence_test_address(addr);
 		break;
 	case KFENCE_ERROR_INVALID_FREE:
-		cur += scnprintf(cur, end - cur, "Invalid free of");
+		cur = seprintf(cur, end, "Invalid free of");
 		break;
 	}
 
-	cur += scnprintf(cur, end - cur, " 0x%p", (void *)addr);
+	seprintf(cur, end, " 0x%p", (void *)addr);
 
 	spin_lock_irqsave(&observed.lock, flags);
 	if (!report_available())
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 9733a22c46c1..a062a46b2d24 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -107,9 +107,9 @@ static bool report_matches(const struct expect_report *r)
 	cur = expected_header;
 	end = &expected_header[sizeof(expected_header) - 1];
 
-	cur += scnprintf(cur, end - cur, "BUG: KMSAN: %s", r->error_type);
+	cur = seprintf(cur, end, "BUG: KMSAN: %s", r->error_type);
 
-	scnprintf(cur, end - cur, " in %s", r->symbol);
+	seprintf(cur, end, " in %s", r->symbol);
 	/* The exact offset won't match, remove it; also strip module name. */
 	cur = strchr(expected_header, '+');
 	if (cur)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b28a1e6ae096..c696e4a6f4c2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3359,6 +3359,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 {
 	char *p = buffer;
+	char *e = buffer + maxlen;
 	nodemask_t nodes = NODE_MASK_NONE;
 	unsigned short mode = MPOL_DEFAULT;
 	unsigned short flags = 0;
@@ -3384,33 +3385,32 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		break;
 	default:
 		WARN_ON_ONCE(1);
-		snprintf(p, maxlen, "unknown");
+		seprintf(p, e, "unknown");
 		return;
 	}
 
-	p += snprintf(p, maxlen, "%s", policy_modes[mode]);
+	p = seprintf(p, e, "%s", policy_modes[mode]);
 
 	if (flags & MPOL_MODE_FLAGS) {
-		p += snprintf(p, buffer + maxlen - p, "=");
+		p = seprintf(p, e, "=");
 
 		/*
 		 * Static and relative are mutually exclusive.
 		 */
 		if (flags & MPOL_F_STATIC_NODES)
-			p += snprintf(p, buffer + maxlen - p, "static");
+			p = seprintf(p, e, "static");
 		else if (flags & MPOL_F_RELATIVE_NODES)
-			p += snprintf(p, buffer + maxlen - p, "relative");
+			p = seprintf(p, e, "relative");
 
 		if (flags & MPOL_F_NUMA_BALANCING) {
 			if (!is_power_of_2(flags & MPOL_MODE_FLAGS))
-				p += snprintf(p, buffer + maxlen - p, "|");
-			p += snprintf(p, buffer + maxlen - p, "balancing");
+				p = seprintf(p, e, "|");
+			p = seprintf(p, e, "balancing");
 		}
 	}
 
 	if (!nodes_empty(nodes))
-		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
-			       nodemask_pr_args(&nodes));
+		seprintf(p, e, ":%*pbl", nodemask_pr_args(&nodes));
 }
 
 #ifdef CONFIG_SYSFS
diff --git a/mm/page_owner.c b/mm/page_owner.c
index cc4a6916eec6..5811738e3320 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -496,7 +496,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 /*
  * Looking for memcg information and print it out
  */
-static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
+static inline char *print_page_owner_memcg(char *p, const char end[0],
 					 struct page *page)
 {
 #ifdef CONFIG_MEMCG
@@ -511,8 +511,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 		goto out_unlock;
 
 	if (memcg_data & MEMCG_DATA_OBJEXTS)
-		ret += scnprintf(kbuf + ret, count - ret,
-				"Slab cache page\n");
+		p = seprintf(p, end, "Slab cache page\n");
 
 	memcg = page_memcg_check(page);
 	if (!memcg)
@@ -520,7 +519,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 
 	online = (memcg->css.flags & CSS_ONLINE);
 	cgroup_name(memcg->css.cgroup, name, sizeof(name));
-	ret += scnprintf(kbuf + ret, count - ret,
+	p = seprintf(p, end,
 			"Charged %sto %smemcg %s\n",
 			PageMemcgKmem(page) ? "(via objcg) " : "",
 			online ? "" : "offline ",
@@ -529,7 +528,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 	rcu_read_unlock();
 #endif /* CONFIG_MEMCG */
 
-	return ret;
+	return p;
 }
 
 static ssize_t
@@ -538,14 +537,16 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		depot_stack_handle_t handle)
 {
 	int ret, pageblock_mt, page_mt;
-	char *kbuf;
+	char *kbuf, *p, *e;
 
 	count = min_t(size_t, count, PAGE_SIZE);
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
 
-	ret = scnprintf(kbuf, count,
+	p = kbuf;
+	e = kbuf + count;
+	p = seprintf(p, e,
 			"Page allocated via order %u, mask %#x(%pGg), pid %d, tgid %d (%s), ts %llu ns\n",
 			page_owner->order, page_owner->gfp_mask,
 			&page_owner->gfp_mask, page_owner->pid,
@@ -555,7 +556,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	/* Print information relevant to grouping pages by mobility */
 	pageblock_mt = get_pageblock_migratetype(page);
 	page_mt  = gfp_migratetype(page_owner->gfp_mask);
-	ret += scnprintf(kbuf + ret, count - ret,
+	p = seprintf(p, e,
 			"PFN 0x%lx type %s Block %lu type %s Flags %pGp\n",
 			pfn,
 			migratetype_names[page_mt],
@@ -563,22 +564,23 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 			migratetype_names[pageblock_mt],
 			&page->flags);
 
-	ret += stack_depot_snprint(handle, kbuf + ret, count - ret, 0);
-	if (ret >= count)
-		goto err;
+	p = stack_depot_seprint(handle, p, e, 0);
+	if (p == NULL)
+		goto err;  // XXX: Should we remove this error handling?
 
 	if (page_owner->last_migrate_reason != -1) {
-		ret += scnprintf(kbuf + ret, count - ret,
+		p = seprintf(p, e,
 			"Page has been migrated, last migrate reason: %s\n",
 			migrate_reason_names[page_owner->last_migrate_reason]);
 	}
 
-	ret = print_page_owner_memcg(kbuf, count, ret, page);
+	p = print_page_owner_memcg(p, e, page);
 
-	ret += snprintf(kbuf + ret, count - ret, "\n");
-	if (ret >= count)
+	p = seprintf(p, e, "\n");
+	if (p == NULL)
 		goto err;
 
+	ret = p - kbuf;
 	if (copy_to_user(buf, kbuf, ret))
 		ret = -EFAULT;
 
diff --git a/mm/slub.c b/mm/slub.c
index be8b09e09d30..b67c6ca0d0f7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7451,6 +7451,7 @@ static char *create_unique_id(struct kmem_cache *s)
 {
 	char *name = kmalloc(ID_STR_LENGTH, GFP_KERNEL);
 	char *p = name;
+	char *e = name + ID_STR_LENGTH;
 
 	if (!name)
 		return ERR_PTR(-ENOMEM);
@@ -7475,9 +7476,9 @@ static char *create_unique_id(struct kmem_cache *s)
 		*p++ = 'A';
 	if (p != name + 1)
 		*p++ = '-';
-	p += snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->size);
+	p = seprintf(p, e, "%07u", s->size);
 
-	if (WARN_ON(p > name + ID_STR_LENGTH - 1)) {
+	if (WARN_ON(p == NULL)) {
 		kfree(name);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.50.0

