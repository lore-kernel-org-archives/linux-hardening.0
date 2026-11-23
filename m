Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443551;
	b=ECngTQrWx5cJRcpqR+RKDE9xA1wHAj3TT4xn0mqKNsr/03AkBCa/zU4alxuDIs799qHO
	 M9nZ6fTObG84dA7br4TEGpDJO6D3AoBc5iYuQUt2KovtivceDzW6zpFRf5SS5w/YWnvOP
	 YTpYpXSB6sxnUxCTqWhVBx/nU9JUSybuvnyYvzaPbpJix+AiBphXb2e4HPagzlD7ukrpK
	 wSn5Oyqca5bCiyzYq6O6SzBXwHIG3vILSqNbf7Ac6vlxY3/Xg4vnNemYyKrX3RX29qc5f
	 li27JBRjXACftHuNj3ZSd0sQ4QFNvb3NAodKQ727t5oVKZsBTdNr83DUAcRonKLKqTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=77msjR0dRhdtgIkE1HozDHoWzLE9oPsBqEtLLPC0LPg=;
	b=uaZeE7VXe8ZqPrdOxI4PPggHe9tcRdzXpBt9/MGoJm3ayMicgZOzwf46v9JTjpLxMYAM
	 TsJdYkVHvqv72gpo1txXhXYKpFxUjmOeKnxqSVfGqiSFY8JWXFRRRBBabIKDYRy6y4EzK
	 H0iqNpvMNRf9NEGxo8lnsoHKTF85NROPiWOASoaXNYloTCdQxWGe1qLn13CRpV0++iZOB
	 clfJBJgps6IjNm8pSKlG2K6/C8YBwAdAgy+btCSz4SCXgLnwUTZ6EmX8/TFfFvFN8E6ki
	 CDyzpHzh+ByINVjUoA0wBAG4RAHj8eeoSJVTfd4saaTjbjfXLaPOG7gZwO0c+IGkGbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aiz3ba6N;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58259606A31F
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58259606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aiz3ba6N
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3869b68caecso4373154eec.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443550; x=1796048350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=77msjR0dRhdtgIkE1HozDHoWzLE9oPsBqEtLLPC0LPg=;
        b=Aiz3ba6NsmaeRbQcZ6/Q1I0oHuDrwWVVieSVGHRkcO0r9jA8e0BL3y6yZ8hhS2ddhR
         f25FWw34JxqBwfF4bBgM8tlog1DJJ6bMg1ZkWQNy4eSOXllpr1w3//P7+y1Oh6hSukR+
         NJXu3/OMF+AaU6kwGbRT10e4PcJcjWTxtdpgDL6/Qr3EhID+l6/EFf7nzIEN4UfnwDwd
         kP18OG6Cc3dsQYL5i0wP3OYd3peFhHuyb1kVQkHp9GxOWLsHO3GhcaH0AaNlVCm2469/
         pO7xOd4Eq9x6OI6ltcyQii4n/OkbISgcjVfOER/1vAU2EiWVhliUF/7XS5ZrhdvClRCu
         pECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443550; x=1796048350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=77msjR0dRhdtgIkE1HozDHoWzLE9oPsBqEtLLPC0LPg=;
        b=z/7ax5NEFZE2YgW5oFd7XDhBM9hfLXvmjf/oYdERvd1mPdDJXqVaOsHnZrBwf5DGj7
         b6vP7J9UEF36ZIy0WCY4Y6cqy6gFUhv0CL/ljWhmH1mSgMKpndLc/ARus+Q2NSewYBR/
         S8gG6k4+t6EiI79e6k7fkplQiiR9H1mVtmfMM+OhDE8BFcGJU9bFLoOU+LS04yRi2zvF
         7gspDCkKQi6EYC2bdmqgpOyYMNrX8zV0jUsumCwJhmBgWXIZtfL8VBbTntiUZsjHKxK5
         uAQA+It9cQiJ6l6EYzc2Q0T5GAtM0/obvOqAo9rIU2izq+PcEiwy+82Ahisnu5FP5uFN
         0hHQ==
X-Forwarded-Encrypted: i=1; AL+hErF9rByiaG7s36CBwT7ra6Gxm0+3IwjHTMgFF1dajdqT6tM+fCTsUQAoCy2/qbHu7HREV2GwsZGSvWm1zPejFI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zCmIy9Ha6VvNALLmGBEtvP3mxbfQxcW0N/iXqE0ccCy6tuA6z
	GBxAxhW+D9xgnL/Nz3576wCEFXPSKnvLqDIQ3jwp6lamsKbsyTAq5MZV
X-Gm-Gg: AZFdTZcW296JCxQQ5fN08oqGCtevDX6lX01L22+6+nQ68u/7YLHSeqfZxVMktKcXPU4
	nzAXCHZ1yRvo7j4qP+AOe4LOdW/IBRovCo4FmIQfuFHC1SrgFpjfY4B4dTGV/TQ+y6rq+QLxe8/
	Wz3ybm1UeBBJI+pSsSSFTMJ6Lox/y+VfIF0wrextD1i2qsJ0CCit7psRFpf+hglrR+LjakdZ5Xd
	IO68n+DTd9+JwZ2uD98acwftaZbE9Z2O0ueO7Dw0/SwviNRTeilkgqzx16woURvWOlFr/DhEDiA
	vl9CvkWWdcyb4D/XGGfy3GZ91qgVwT5MFGdPdSzft6bGHleKsKhCaMzrpnAGPdI2h0DjWBQ5qWf
	HBUaarKXDWAe+AwU5mYFettb8rrab9uiouTvsb4/caePAqzsogCGOqzfrT1HluxVlsBcaDJKZw4
	voM54KRQBTfPpUoJ/t3tG9gesoaVN++BlD6q8cPioV6VdJOi8qMflXbY4xbyHYoWTQh1N3xS7Yu
	+u6KYf8UtiM2dp9l9u6mBurPCchZ9xjScbhjv5m8mtGv/1kZvjuwQXQb8vPlv5voh8t9G0WsHCd
	4Yg+FrK0Iw9DOBDy2Bwrj9z41f8Lw64JgFfF9zuW2i5OhKGa2IZ7GuTmt2eRSpH9sXLy
X-Received: by 2002:a05:7300:6da7:b0:384:5885:2f81 with SMTP id 5a478bee46e88-3856c0c7c05mr16726108eec.5.1795443550374;
        Mon, 23 Nov 2026 06:19:10 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm40230786eec.24.2026.11.23.06.19.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:19:09 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 13/19] mm/swap: bound synchronous discard outside the allocation reader
Date: Mon, 23 Nov 2026 22:18:58 +0800
Message-ID: <ed722bf572f44133ee44f5b2c3d90f53b99f38e2.1795439990.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795439990.git.lianux.mm@gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com>
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

The synchronous discard fallback drains a list that freeing paths can
keep replenishing. Limit each foreground step to one cluster, retaining
CLUSTER_FLAG_DISCARD while I/O is in flight and returning the cluster to
the free list only after completion. The background worker continues to
process the remaining list.

Keep synchronous discard outside the topology reader. Enter this fallback
only after a complete normal order-0 allocation walk fails. A higher-
priority device with only pending discard work does not force synchronous
I/O if a lower-priority device satisfies that walk.

Find a writable discard-capable device under the reader and take its live
reference, then release the reader before issuing I/O. Drop the reference
after completion and restart allocation with a fresh cursor, so a
concurrent topology change cannot leave stale ring state. This also sees
discard work produced by the preceding reclaim scans.

Track the swap types already processed during this folio allocation and
check each candidate at most once per fallback search. An empty check
does not consume the I/O budget. Each swap type can complete at most one
synchronous cluster discard, bounding successful retries by MAX_SWAPFILES
even if membership changes. Do not keep discarding until this task wins
a free cluster from a peer.

Large folios retain the existing same-priority retry and split boundary;
their reader-held cluster walk does not issue synchronous discard. The
budget bounds work count, not device I/O completion latency.

Link: https://lore.kernel.org/all/CAMgjq7CsYhEjvtN85XGkrONYAJxve7gG593TFeOGV-oax++kWA@mail.gmail.com/
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Co-developed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 175 ++++++++++++++++++++++++++++----------------------
 1 file changed, 100 insertions(+), 75 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1f31a3ae75d6..d28dd10c92cc 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -6,6 +6,7 @@
  *  Swap reorganised 29.12.95, Stephen Tweedie
  */
 
+#include <linux/bitmap.h>
 #include <linux/blkdev.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
@@ -583,6 +584,26 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
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
@@ -914,12 +935,8 @@ static int swap_cluster_alloc_table(struct swap_info_struct *si,
 
 lock:
 	if (!locked) {
-		if (si) {
-			if (si->flags & SWP_SOLIDSTATE)
-				local_lock(&si->percpu_cluster->lock);
-			else
-				spin_lock(&si->global_cluster->lock);
-		}
+		if (si)
+			swap_alloc_lock_device(si);
 		spin_lock(&ci->lock);
 	}
 	lockdep_assert_held(&ci->lock);
@@ -1022,10 +1039,7 @@ swap_cluster_populate(struct swap_info_struct *si,
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
@@ -1132,44 +1146,40 @@ static struct swap_cluster_info *isolate_lock_cluster(
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
@@ -1178,7 +1188,8 @@ static void swap_discard_work(struct work_struct *work)
 
 	si = container_of(work, struct swap_info_struct, discard_work);
 
-	swap_do_scheduled_discard(si);
+	while (swap_discard_one_cluster(si))
+		cond_resched();
 }
 
 static void swap_users_ref_free(struct percpu_ref *ref)
@@ -1607,15 +1618,11 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 	if (order && !(si->flags & SWP_BLKDEV))
 		return 0;
 
-	if (si->flags & SWP_SOLIDSTATE) {
-		/* Fast path using per CPU cluster */
-		local_lock(&si->percpu_cluster->lock);
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
@@ -1683,10 +1690,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
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
@@ -1881,33 +1885,50 @@ static int swap_alloc_entry(struct folio *folio)
 }
 
 /*
- * Discard pending clusters in a synchronized way when under high pressure.
- * Return: true if any cluster is discarded.
+ * Discard outside the topology reader, holding only the selected device's
+ * live reference across I/O. Each successful retry starts a fresh queue walk.
  */
-static bool swap_sync_discard(void)
+static bool swap_discard_for_alloc(unsigned long *discarded)
 {
-	bool ret = false;
-	struct swap_info_struct *si, *next;
+	DECLARE_BITMAP(checked, MAX_SWAPFILES) = {};
+	struct swap_info_struct *si, *candidate;
+	unsigned int i, j;
+	bool done;
+	int type;
 
-	percpu_down_read(&swapon_rwsem);
-start_over:
-	plist_for_each_entry_safe(si, next, &swap_active_head, list) {
-		percpu_up_read(&swapon_rwsem);
-		if (get_swap_device_info(si)) {
-			if (si->flags & SWP_PAGE_DISCARD)
-				ret = swap_do_scheduled_discard(si);
-			put_swap_device(si);
+	for (;;) {
+		candidate = NULL;
+		percpu_down_read(&swapon_rwsem);
+		for (i = 0; i < swap_queue_len && !candidate; i++) {
+			struct swap_prio_ring *ring = swap_queue[i];
+
+			for (j = 0; j < ring->size; j++) {
+				si = swap_device_unmask_ptr(READ_ONCE(ring->dev[j]));
+				type = si->type;
+				if (test_bit(type, discarded) || test_bit(type, checked))
+					continue;
+				__set_bit(type, checked);
+				if ((READ_ONCE(si->flags) & (SWP_WRITEOK | SWP_PAGE_DISCARD)) !=
+				    (SWP_WRITEOK | SWP_PAGE_DISCARD))
+					continue;
+				if (get_swap_device_info(si)) {
+					candidate = si;
+					break;
+				}
+			}
 		}
-		if (ret)
-			return true;
+		percpu_up_read(&swapon_rwsem);
+		if (!candidate)
+			return false;
 
-		percpu_down_read(&swapon_rwsem);
-		if (plist_node_empty(&next->list))
-			goto start_over;
+		type = candidate->type;
+		done = swap_discard_one_cluster(candidate);
+		if (done)
+			__set_bit(type, discarded);
+		put_swap_device(candidate);
+		if (done)
+			return true;
 	}
-	percpu_up_read(&swapon_rwsem);
-
-	return false;
 }
 
 static int swap_extend_table_alloc(struct swap_info_struct *si,
@@ -2211,12 +2232,16 @@ int folio_alloc_swap(struct folio *folio)
 		}
 	}
 
-again:
 	swap_alloc_entry(folio);
 
 	if (!order && unlikely(!folio_test_swapcache(folio))) {
-		if (swap_sync_discard())
-			goto again;
+		DECLARE_BITMAP(discarded, MAX_SWAPFILES) = {};
+
+		while (swap_discard_for_alloc(discarded)) {
+			swap_alloc_entry(folio);
+			if (folio_test_swapcache(folio))
+				break;
+		}
 	}
 
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
