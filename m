Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117452;
	b=odfX6YB2r/Qt/EtCNPowDs3It2Yp/24Q9sPJ94oSU66OEO5lTrqamIDHV0z379XVdv2g
	 rX6zolBPYG2051fdgRFKpnkaAsUzOWiy1jc8AltmcgEA4b7ypxlQ7cnwNnaWPG5pQO4br
	 zEYuy0HJInyWFBYmxQzyUOFJU0KnvQDPPYOU6ERTHEcTLXvkMDQmp7r0Ee2r4ms/HivFC
	 CepwPr/rJzCfIVlI6EtJNq4t6m6CR28ryG824KpAXkdpxwI7xzD342dVyZlXzT0XxTSCh
	 Xjtj8PuPhGixdqdJKZ+LAl/kBQVOuKotq4Afp7U7etNW2ngSSY4B1GYmgmZHmgAP7ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BMVK9C6kjD2I/C8Mw6stURXeaeBe+UoUZ1aPJYJvbec=;
	b=N3JShdx9Dusr7obr32WrYLbaQjMmnCiOcDKeJyw9paU1Qn/TlcaoaHIfUhCxIKuCX1jM
	 pEYyX/hmpk5HgN7Mon3h4Y9ucO3cETtpem2olEHeAaTOayyGNuxbwcpLKFM+Y54LrOwMp
	 xwLulYs/DYhhwY2el0PVEplwembAt/EWtdhJawtFp651t+qDRt+JPNvTforBXAGxU0Chf
	 xAFtfmvhB0USGDY0uaHrSk+S3yWnPvuXHvPdFNDH4/d2g7nyh0DswhDmlyprETMN7Dy/1
	 tLhsQDBouzpVSTIOq+ZTsKH4tTph01CCIb8l6RGTTWWLhUDqbIjvg0rsBIyEESiLBPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lcfqmi6u;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8669606A31E
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8669606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lcfqmi6u
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so88759a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117451; x=1793722251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BMVK9C6kjD2I/C8Mw6stURXeaeBe+UoUZ1aPJYJvbec=;
        b=lcfqmi6uWIHBzrsyd9x7cyO5eZRwit3b90b42XmpZyfvkMq1G4AcNm6z+fhFQt52pP
         /5VyRQ0ZkAqMI4BY6iIJCJrtW4VFccaEeUV83WMpqVdKX8h7LR4qnEWtuwxWTxVhfcWK
         U7lAMVW/3MBzZsbYA5FaheX2tvD0X2Odke0Ejb5yOLKJvc+ewR/CPQoikzIRieR820Z/
         CUS1zhYO5UKyJjVo/h7NSNOKoId+3NOb85oI0jEF1HcBYEDDBXfPUpCOMAgAogp250Tz
         5YGDPoIKwJyPxHnqKrEVgBhgXva/AEbx4oyx3uP6RBdcZw9EdE+iKb5mBRoB9yoCkpnH
         3QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117451; x=1793722251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BMVK9C6kjD2I/C8Mw6stURXeaeBe+UoUZ1aPJYJvbec=;
        b=O3wGDpCpEJcELX021fYK/XAozotOQFTewChDsatmrW2O/xw6+3yXGtMlQyaRMW9MJ7
         U4G+2+qwYF23ZqgsNP2cqrNC9MnJc9Dx36sE0CFuwBHgq9fTl5SVl3wMzK61Uk/oq9Yr
         kJN5wc5ir58pLA3MP4nALeF8NStPT1oD3gR0YI+D9OwUb0v/DgPg5mz5MnKm7doYcJ7Y
         jP+XOzKwsXASPS+vReDqrmEtWQHundT2N+6gY9KkLOQ6g6XKyVYdVr4ZmOZocXF1X6P8
         XxRtqlBTMrbqMKVsKhScK5/6P6h9Zv2QvDo5iXLapTEtMnMHqzsEj/PrshxM+NRI3Qcg
         MHNQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1EpZftvMzelgXiqLx3J5kUivuUhrmh+kq/On/aljv5xw8GT49K+yeHlvCnkIwfSqwgBchloDVRG7jXf/8laE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK53chjy0YqZAZBWEf2gEZLxm1FOcK/p7CuywUX68Zh+4mW235l
	G6WDNwPM5Raw9rttrHhSX26cKXoOSfuiYmSvd8A18Qn57gMRuBQQUV+8
X-Gm-Gg: AYBFou0h2V51DgE75c3g8n7W7WmErhsLbAwmBtQutuzajnUYdklRsBnGWhELHoiIMg5
	LL+SvcdWE14VNohdrGTa+hKmb37DM56+iPLdLdL3gb2jnGAO/BcwKoO2w/mLf6r34CaV569G8rN
	6u856RMTz7K9Hqs/1+U0zPzruvg+tnIXlF/Y6i0OgAmyD0hsmRee0Fd4JASO8ORrMbp904d8r3Y
	4GJuPG/BfmFody00ZJaUbbmrPQgH++ol515KFkF+uljneZHsYADCfyapvvyfDYBVN7BtWc+fWEz
	JcZfuE39z+oNtRqJEbIimz7lFU2OluoptHH3u8xy1wvY8hqmvD6KtiNMU9vPig+bgbQsLBdBmi0
	Dy2WltPd7sU4rx11M/G9RsDet4IjoBWeMIOISqidIo4IH2o0uUZe/oAXYnCxqYjp71XoJJjuYGp
	NcPh0SodRiOcIFWa7kogHOE7slbXwwwyyf+LNDNlIWegnO9yB0GPjqnpni7NpiFn3jf2JN1VIU1
	o67CKWWRnIVNd1u9BSMyshUxh6Wq2Do2WFswwac7sd2v8QwhBZeC8nW9d98UPyNKrWJekGqCY3k
	UACrKaayWm6brA3vkhg=
X-Received: by 2002:a17:90b:3141:b0:3ac:9a54:e3ce with SMTP id 98e67ed59e1d1-3adeafb073fmr8492945a91.63.1793117450954;
        Tue, 27 Oct 2026 09:10:50 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae402a0692sm4393099a91.2.2026.10.27.09.10.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:10:50 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	linjh22s@gmail.com,
	kunwu.chan@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org,
	tglx@kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH v3 12/18] mm/swap: bound synchronous discard during allocation
Date: Wed, 28 Oct 2026 00:10:24 +0800
Message-ID: <1de96c68db9d3ac83ae485a1eddabcea1a2524a1.1793106426.git.lianux.mm@gmail.com>
In-Reply-To: <cover.1793106426.git.lianux.mm@gmail.com>
References: <cover.1793106426.git.lianux.mm@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The per-device cluster cache lets the allocator select a device before
handling that device's pending discards. Issue discard on the selected
device when its free-cluster list is drained instead of waiting for a
global fallback scan.

Do not drain a discard list that freeing paths can replenish. Factor
out swap_discard_one_cluster(), isolate one cluster under si->lock,
retain CLUSTER_FLAG_DISCARD while I/O is in flight, and return it to the
free list after completion. The background worker keeps processing the
list.

Each call to the device-cluster allocator handles at most one cluster
synchronously before retrying allocation. A folio allocation can try
multiple devices, so this is a per-device-attempt budget. It bounds the
amount of discard work, not device I/O completion latency.

Link: https://lore.kernel.org/all/CAMgjq7CsYhEjvtN85XGkrONYAJxve7gG593TFeOGV-oax++kWA@mail.gmail.com/
Signed-off-by: Kairui Song <kasong@tencent.com>
Co-developed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 149 ++++++++++++++++++++++----------------------------
 1 file changed, 64 insertions(+), 85 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0a16343a5b03..5c26682c0bab 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -585,6 +585,26 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
 	return atomic_long_read(&si->inuse_pages) & SWAP_USAGE_COUNTER_MASK;
 }
 
+/*
+ * Serialize the allocation on single CPU or globally to avoid
+ * fragmentation and make the workflow easier to follow.
+ */
+static void swap_alloc_lock_device(struct swap_info_struct *si)
+{
+	if (si->flags & SWP_SOLIDSTATE)
+		local_lock(&si->percpu_cluster->lock);
+	else
+		spin_lock(&si->global_cluster->lock);
+}
+
+static void swap_alloc_unlock_device(struct swap_info_struct *si)
+{
+	if (si->flags & SWP_SOLIDSTATE)
+		local_unlock(&si->percpu_cluster->lock);
+	else
+		spin_unlock(&si->global_cluster->lock);
+}
+
 /* Reclaim the swap entry anyway if possible */
 #define TTRS_ANYWAY		0x1
 /*
@@ -982,10 +1002,7 @@ swap_cluster_populate(struct swap_info_struct *si,
 	 * which could give allocator hooks and failure cleanup reserve access.
 	 */
 	spin_unlock(&ci->lock);
-	if (si->flags & SWP_SOLIDSTATE)
-		local_unlock(&si->percpu_cluster->lock);
-	else
-		spin_unlock(&si->global_cluster->lock);
+	swap_alloc_unlock_device(si);
 
 	gfp = (GFP_KERNEL | __GFP_HIGH | __GFP_NOMEMALLOC) &
 		~__GFP_DIRECT_RECLAIM;
@@ -999,10 +1016,7 @@ swap_cluster_populate(struct swap_info_struct *si,
 	 * could happen with ignoring the percpu cluster is fragmentation,
 	 * which is acceptable since this fallback and race is rare.
 	 */
-	if (si->flags & SWP_SOLIDSTATE)
-		local_lock(&si->percpu_cluster->lock);
-	else
-		spin_lock(&si->global_cluster->lock);
+	swap_alloc_lock_device(si);
 	spin_lock(&ci->lock);
 
 	if (ret) {
@@ -1092,44 +1106,40 @@ static struct swap_cluster_info *isolate_lock_cluster(
 }
 
 /*
- * Doing discard actually. After a cluster discard is finished, the cluster
- * will be added to free cluster list. Discard cluster is a bit special as
- * they don't participate in allocation or reclaim, so clusters marked as
- * CLUSTER_FLAG_DISCARD must remain off-list or on discard list.
+ * Discard one cluster. After the discard is finished, the cluster will be
+ * added to the free cluster list. Discard clusters are special because they
+ * don't participate in allocation or reclaim, so CLUSTER_FLAG_DISCARD must
+ * remain set while a cluster is either queued or being discarded.
  */
-static bool swap_do_scheduled_discard(struct swap_info_struct *si)
+static bool swap_discard_one_cluster(struct swap_info_struct *si)
 {
 	struct swap_cluster_info *ci;
-	bool ret = false;
 	unsigned int idx;
 
 	spin_lock(&si->lock);
-	while (!list_empty(&si->discard_clusters)) {
-		ci = list_first_entry(&si->discard_clusters, struct swap_cluster_info, list);
-		/*
-		 * Delete the cluster from list to prepare for discard, but keep
-		 * the CLUSTER_FLAG_DISCARD flag, there could be percpu_cluster
-		 * pointing to it, or ran into by relocate_cluster.
-		 */
-		list_del(&ci->list);
-		idx = cluster_index(si, ci);
+	if (list_empty(&si->discard_clusters)) {
 		spin_unlock(&si->lock);
-		discard_swap_cluster(si, idx * SWAPFILE_CLUSTER,
-				SWAPFILE_CLUSTER);
-
-		spin_lock(&ci->lock);
-		/*
-		 * Discard is done, clear its flags as it's off-list, then
-		 * return the cluster to allocation list.
-		 */
-		ci->flags = CLUSTER_FLAG_NONE;
-		__free_cluster(si, ci);
-		spin_unlock(&ci->lock);
-		ret = true;
-		spin_lock(&si->lock);
+		return false;
 	}
+
+	ci = list_first_entry(&si->discard_clusters,
+			      struct swap_cluster_info, list);
+	/*
+	 * Delete the cluster from the list, but keep CLUSTER_FLAG_DISCARD
+	 * set while the discard is in flight. A percpu cluster may still
+	 * point to it, or relocate_cluster() may encounter it.
+	 */
+	list_del(&ci->list);
+	idx = cluster_index(si, ci);
 	spin_unlock(&si->lock);
-	return ret;
+
+	discard_swap_cluster(si, idx * SWAPFILE_CLUSTER, SWAPFILE_CLUSTER);
+
+	spin_lock(&ci->lock);
+	ci->flags = CLUSTER_FLAG_NONE;
+	__free_cluster(si, ci);
+	spin_unlock(&ci->lock);
+	return true;
 }
 
 static void swap_discard_work(struct work_struct *work)
@@ -1138,7 +1148,8 @@ static void swap_discard_work(struct work_struct *work)
 
 	si = container_of(work, struct swap_info_struct, discard_work);
 
-	swap_do_scheduled_discard(si);
+	while (swap_discard_one_cluster(si))
+		cond_resched();
 }
 
 static void swap_users_ref_free(struct percpu_ref *ref)
@@ -1536,6 +1547,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 	struct swap_cluster_info *ci;
 	unsigned int order = likely(folio) ? folio_order(folio) : 0;
 	unsigned int offset = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
+	bool discarded = false;
 
 	/*
 	 * Swapfile is not block device so unable
@@ -1544,15 +1556,12 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 	if (order && !(si->flags & SWP_BLKDEV))
 		return 0;
 
-	if (si->flags & SWP_SOLIDSTATE) {
-		/* Fast path using per CPU cluster */
-		local_lock(&si->percpu_cluster->lock);
+restart:
+	swap_alloc_lock_device(si);
+	if (si->flags & SWP_SOLIDSTATE)
 		offset = __this_cpu_read(si->percpu_cluster->next[order]);
-	} else {
-		/* Serialize HDD SWAP allocation for each device. */
-		spin_lock(&si->global_cluster->lock);
+	else
 		offset = si->global_cluster->next[order];
-	}
 
 	if (offset != SWAP_ENTRY_INVALID) {
 		ci = swap_cluster_lock(si, offset);
@@ -1576,6 +1585,15 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 		found = alloc_swap_scan_list(si, &si->free_clusters, folio, false);
 		if (found)
 			goto done;
+
+		if (!discarded) {
+			swap_alloc_unlock_device(si);
+			if (swap_discard_one_cluster(si)) {
+				discarded = true;
+				goto restart;
+			}
+			swap_alloc_lock_device(si);
+		}
 	}
 
 	if (order < PMD_ORDER) {
@@ -1624,10 +1642,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 			goto done;
 	}
 done:
-	if (si->flags & SWP_SOLIDSTATE)
-		local_unlock(&si->percpu_cluster->lock);
-	else
-		spin_unlock(&si->global_cluster->lock);
+	swap_alloc_unlock_device(si);
 
 	return found;
 }
@@ -1818,36 +1833,6 @@ static int swap_alloc_entry(struct folio *folio)
 	return ret;
 }
 
-/*
- * Discard pending clusters in a synchronized way when under high pressure.
- * Return: true if any cluster is discarded.
- */
-static bool swap_sync_discard(void)
-{
-	bool ret = false;
-	struct swap_info_struct *si, *next;
-
-	percpu_down_read(&swapon_rwsem);
-start_over:
-	plist_for_each_entry_safe(si, next, &swap_active_head, list) {
-		percpu_up_read(&swapon_rwsem);
-		if (get_swap_device_info(si)) {
-			if (si->flags & SWP_PAGE_DISCARD)
-				ret = swap_do_scheduled_discard(si);
-			put_swap_device(si);
-		}
-		if (ret)
-			return true;
-
-		percpu_down_read(&swapon_rwsem);
-		if (plist_node_empty(&next->list))
-			goto start_over;
-	}
-	percpu_up_read(&swapon_rwsem);
-
-	return false;
-}
-
 static int swap_extend_table_alloc(struct swap_info_struct *si,
 				   struct swap_cluster_info *ci,
 				   unsigned int ci_off, gfp_t gfp)
@@ -2149,14 +2134,8 @@ int folio_alloc_swap(struct folio *folio)
 		}
 	}
 
-again:
 	swap_alloc_entry(folio);
 
-	if (!order && unlikely(!folio_test_swapcache(folio))) {
-		if (swap_sync_discard())
-			goto again;
-	}
-
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
 	if (unlikely(mem_cgroup_try_charge_swap(folio))) {
 		swap_cache_del_folio(folio);
