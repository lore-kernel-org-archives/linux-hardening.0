Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117089;
	b=awX3E+39Eo6oa3D+EugKEszQnVKQwxmswbslidMprzzhNOliwz1umSuLmF/tTj7ctnx/
	 On454xxpNRJ5G5YdyGwYtLB3uRkophFV0tGyErkd95zhydTr6ro7K4pZ/a1f68NyEdB7Q
	 6vBAgfaioUjOrnME6+J+luXZSagdYnPa0tpw/dddnWwmHSd7GrDsZP2ijnCe7HrqJOU0C
	 jjvIyn5WrwEivR1fHL4x0rc5Klss1WktgmpohGXuME1uYGTufazA2RdJurOS4X81BHw/P
	 fAEQ9LbZtmIcjX1FB0fjDX91VYldQu9ooptA+Dbafx2G3GxoNioBzbRjmV8hP1WcUhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+MYD44DcHjEZ2ajshlbEu8zM2l23xxTluRkoB1K/Gu4=;
	b=O4EK4n1UJg6nBGNBkUXwbhJkhEcaA23Dtqgkb3+8GTmMM2EwHzrls6lihtf4ALoaMEdl
	 H3jseIsTujdbyPljzwelvWfQAyrOCWRCbSjPd/g7lBGYcV0Wy9Uk4//nj/KqJGaTdk4Sw
	 qJke3lON3pbXQu4ysOc/BAdX4BATShxrD+ORJDkQrF4gnzqIgOs/E9nSDr1dYJ/hKhAgG
	 VDdFlt4O9siKy4gBFE2H6EFE29xSsR2xmrKG6gvkhmV4ETEOCgoZaFwNbv3xuDZ5XkSs2
	 3w0V4dGCrr2PHDAGJ+GWUeHFbBW+nCWEP5w/TJx2X3x2QQY9dDd5ZiiEHDWzopZEoaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0a+oBaPb;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42108606A334
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42108606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0a+oBaPb
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso50818a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117089; x=1793721889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+MYD44DcHjEZ2ajshlbEu8zM2l23xxTluRkoB1K/Gu4=;
        b=0a+oBaPbI/eabn9e3ieePEsqdCkA7N+1Hzel8GOwEERcyUcByN6KdcHJU30ygyydDF
         IcK2VFwmD6hgzZlPDhpww2+aSNsQyGlKFIU42zEBrwSPOxN6SZBgxUEgH9QQbX91EG/h
         yld/xXamE5wE+h/jXf1OAB9IxL2uljJL42hJNM01Sqtg5mYydd0fC956sXD98lypwaQ6
         nB/6CWt01DdHbLbJeu3l/lyHrJir48Sxx4j7YDel8ygyzCSuN7MXa0h4lXd7fMYAsrmR
         mqJvUOkPGChCZ+6H0Mv+x6wviLqWewbzhVZqv9lQQX5UctqnpKPTcYT7umEAjwyzrN63
         wbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117089; x=1793721889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+MYD44DcHjEZ2ajshlbEu8zM2l23xxTluRkoB1K/Gu4=;
        b=dpf6dDb3fJ/OrTI90/HyrOhZPq46v1CHG1V8xvnDakA/R2Iget4ijExTCpWJdIKFkS
         yCeR/jCIH3mCaShaZJO17mWogFkgJ4cqpztPqBOZ4+LdfSvKg2iBz7+t4bllDZ/iQZf6
         AhYftmQWlZxL22Dc7dFYGflSM6lmtWdxfeVuje/vmQUKcl+VDPjsOG+3aY1VWLcc2Bih
         SuXh8h/l5g/DT68SdVzK6rrhhSAkhCdeNhuvRev/9hEWU64hH2d24fWLSl913o85Emwa
         rcM6NElHG8UbaoNxY/wgwiE2CZF1xmIrNM179Unx70tiHsom4W2o5zzfdzJ1ZquSSs9y
         4BXg==
X-Forwarded-Encrypted: i=1; AKwUvBy9limtlAOjMq8peYL2M0Nak1BlPoP1Yp+5ABHQZGjiPPXBxJyUe4GZmb8/FwaEvLUujOrG8L8x4ICwXQF+KKI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBSksicH4xWOXmZTwfZNM8iyg0gdUL3k56JMpQaNOipjXqMGcW
	M7k1ZCmc1/ffmqheI9s+bI/54jVpH1Wtotwi12V9wSvesYnODPgIc5id
X-Gm-Gg: AYBFou0+FF56D0tSS2UWNIp+63gVU9+bE5WCmNEU7llHuAifVXcmbLSZQoUdvATTkJo
	/mIoc7WzqWm0gng5N5JOApgmxtjVrj2Vuas02P7rz3FEUMy0oJxm+vPkrYrPukTc3MwAQwEb8fG
	ZJZ9ztz7IMR6MSwauU1R0IgzOYX0tzRFVPCCCPYbcUWqatvnMM6PymMwPAS1SUadZ2vKTgyLKHn
	xRRU780kphBdk/YxnSRxWqrj5RXvzJ00dBYS4LRIglthho8jBeT+wzuxmFmHLtZSFL0IkTQEqs4
	duEQhwRzK+keueTDXRX6/vTId0VSn4eKwqs88tzki1FI8AK9PhVZe6qL+A226fJVTdP+XADzZP2
	BL9NHpz92TkkJ9G0dqBTbRonMFN2/yKVnVCBypRz+MjAAjPfLLl2dQwKqdw7F1ttqdYIM/3Z8K/
	7cOwmjXG8WDMnCcQ5Ul79C5ha7yQ8VPghvC8KKsoAGeuzbI4vUMXHSVbOx/qYvA4sMp0TlSnwVG
	aDtEGiBEUCNJnEi98GxN/Ry+FegRbJm28vV9S33/y8PRAFNR8PYQQuIKBuJkQNaMS25ulrb+eVc
	j7h1tf+VriGeOYnth60=
X-Received: by 2002:a17:90a:e187:b0:3ab:b764:826c with SMTP id 98e67ed59e1d1-3adea898711mr8493030a91.12.1793117088477;
        Tue, 27 Oct 2026 09:04:48 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae406361e2sm4290903a91.8.2026.10.27.09.04.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:04:47 -0700 (PDT)
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
Subject: [RFC PATCH v3 03/18] mm/swap: cleanup and document swap device availability flag usage
Date: Wed, 28 Oct 2026 00:04:21 +0800
Message-ID: <c3a660c13ec9a98af8a496b5f9139e73eab5aa3a.1793106426.git.lianux.mm@gmail.com>
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

Rework swap device flag and metadata handling to make the writable
publication and disable boundaries explicit.

Introduce swap_device_enable() and swap_device_disable(). Move
SWP_WRITEOK updates into these boundaries while keeping availability
updates serialized with swap_avail_lock.

Preserve the existing swap_lock critical section across mapping lookup,
hibernation checks and the disable transition. Drain cluster allocators
after dropping swap_lock, retaining the device-identity protection
without holding swap_lock over all cluster locks.

Document the flag lifetime and locking rules.

Signed-off-by: Kairui Song <kasong@tencent.com>
Co-developed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 include/linux/swap.h |  27 ++++--
 mm/swapfile.c        | 207 ++++++++++++++++++++-----------------------
 2 files changed, 115 insertions(+), 119 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4f686709d71f..66b8e602178d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -188,6 +188,22 @@ struct swap_extent {
 	((offsetof(union swap_header, magic.magic) - \
 	  offsetof(union swap_header, info.badpages)) / sizeof(int))
 
+/*
+ * Swap device flags, except the ones documented below, all are immutable
+ * after exposed by swap_device_enable, and until the device is freed again
+ * (SWP_USED unset). The exceptions:
+ * - SWP_USED: Protected by swap_lock. Indicates the device is inuse. Once
+ *   set, won't be cleared unless all reference to this device is freed and
+ *   swapoff finished.
+ * - SWP_WRITEOK: Protected by both swap_lock and swap_avail_lock, clearing
+ *   this flag also waits for all current cluster lock users to exit so
+ *   checking this flag while holding any of these locks ensures the device
+ *   is safe to use at the moment. Note: clearing this flag doesn't affect
+ *   pending IO or async requests, it only prevents further entry allocation
+ *   or new async request (e.g. discard) from initiating.
+ * - SWP_HIBERNATION: Protected by swap_lock. Indicates if the device
+ *   is pinned for hibernation.
+ */
 enum {
 	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
 	SWP_WRITEOK	= (1 << 1),	/* ok to write to this swap?	*/
@@ -256,14 +272,9 @@ struct swap_info_struct {
 	struct file *swap_file;		/* seldom referenced */
 	struct completion comp;		/* seldom referenced */
 	spinlock_t lock;		/*
-					 * protect map scan related fields like
-					 * inuse_pages and all cluster lists.
-					 * Other fields are only changed
-					 * at swapon/swapoff, so are protected
-					 * by swap_lock. changing flags need
-					 * hold this lock and swap_lock. If
-					 * both locks need hold, hold swap_lock
-					 * first.
+					 * Protect cluster lists. Other fields
+					 * are only changed at swapon/swapoff,
+					 * so are protected by swap_lock.
 					 */
 	struct work_struct discard_work; /* discard worker */
 	struct work_struct reclaim_work; /* reclaim worker */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index cf8c0999655c..4adcfbbb3730 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1207,28 +1207,20 @@ static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
 
 	spin_lock(&swap_avail_lock);
 
-	if (swapoff) {
-		/*
-		 * Forcefully remove it. Clear the SWP_WRITEOK flags for
-		 * swapoff here so it's synchronized by both si->lock and
-		 * swap_avail_lock, to ensure the result can be seen by
-		 * add_to_avail_list.
-		 */
-		lockdep_assert_held(&si->lock);
-		si->flags &= ~SWP_WRITEOK;
-		atomic_long_or(SWAP_USAGE_OFFLIST_BIT, &si->inuse_pages);
-	} else {
-		/*
-		 * If not called by swapoff, take it off-list only if it's
-		 * full and SWAP_USAGE_OFFLIST_BIT is not set (strictly
-		 * si->inuse_pages == pages), any concurrent slot freeing,
-		 * or device already removed from plist by someone else
-		 * will make this return false.
-		 */
+	/*
+	 * Force remove it only for swapoff. Else, take it off-list only if
+	 * it's full and SWAP_USAGE_OFFLIST_BIT is not set (strictly
+	 * si->inuse_pages == pages), so concurrent slot freeing, or
+	 * concurrent list removal will make the cmpxchg fail and skip
+	 * the removal.
+	 */
+	if (!swapoff) {
 		pages = si->pages;
 		if (!atomic_long_try_cmpxchg(&si->inuse_pages, &pages,
 					     pages | SWAP_USAGE_OFFLIST_BIT))
 			goto skip;
+	} else {
+		atomic_long_or(SWAP_USAGE_OFFLIST_BIT, &si->inuse_pages);
 	}
 
 	plist_del(&si->avail_list, &swap_avail_head);
@@ -1238,21 +1230,21 @@ skip:
 }
 
 /* SWAP_USAGE_OFFLIST_BIT can only be cleared by this helper. */
-static void add_to_avail_list(struct swap_info_struct *si, bool swapon)
+static void add_to_avail_list(struct swap_info_struct *si)
 {
 	long val;
 	unsigned long pages;
 
 	spin_lock(&swap_avail_lock);
 
-	/* Corresponding to SWP_WRITEOK clearing in del_from_avail_list */
-	if (swapon) {
-		lockdep_assert_held(&si->lock);
-		si->flags |= SWP_WRITEOK;
-	} else {
-		if (!(READ_ONCE(si->flags) & SWP_WRITEOK))
-			goto skip;
-	}
+	/*
+	 * Add the device to the avail list if SWP_WRITEOK is set and
+	 * SWAP_USAGE_OFFLIST_BIT is still set. Swapoff clears
+	 * SWP_WRITEOK first, so the device won't be re-added after
+	 * swapoff starts unless swap_device_enable resurrects it.
+	 */
+	if (!(si->flags & SWP_WRITEOK))
+		goto skip;
 
 	if (!(atomic_long_read(&si->inuse_pages) & SWAP_USAGE_OFFLIST_BIT))
 		goto skip;
@@ -1308,7 +1300,7 @@ static void swap_usage_sub(struct swap_info_struct *si, unsigned int nr_entries)
 	 * add it to the plist.
 	 */
 	if (unlikely(val & SWAP_USAGE_OFFLIST_BIT))
-		add_to_avail_list(si, false);
+		add_to_avail_list(si);
 }
 
 static void swap_range_alloc(struct swap_info_struct *si,
@@ -1360,7 +1352,7 @@ static bool get_swap_device_info(struct swap_info_struct *si)
 	 * up to dated.
 	 *
 	 * Paired with the spin_unlock() after setup_swap_info() in
-	 * enable_swap_info(), and smp_wmb() in swapoff.
+	 * swap_device_enable(), and smp_wmb() in swapoff.
 	 */
 	smp_rmb();
 	return true;
@@ -3078,58 +3070,87 @@ static int setup_swap_extents(struct swap_info_struct *sis,
 	return generic_swapfile_activate(sis, swap_file, span);
 }
 
-static void _enable_swap_info(struct swap_info_struct *si)
+/*
+ * Mark a fully initialized swap device writable and expose it to the
+ * allocator. The caller must have resurrected its percpu ref first.
+ */
+static void swap_device_enable(struct swap_info_struct *si)
 {
-	atomic_long_add(si->pages, &nr_swap_pages);
-	total_swap_pages += si->pages;
+	spin_lock(&swap_lock);
 
-	assert_spin_locked(&swap_lock);
+	spin_lock(&swap_avail_lock);
+	si->flags |= SWP_WRITEOK;
+	spin_unlock(&swap_avail_lock);
 
+	atomic_long_add(si->pages, &nr_swap_pages);
+	total_swap_pages += si->pages;
 	plist_add(&si->list, &swap_active_head);
+	spin_unlock(&swap_lock);
 
-	/* Add back to available list */
-	add_to_avail_list(si, true);
+	add_to_avail_list(si);
 }
 
-/*
- * Called after the swap device is ready, resurrect its percpu ref, it's now
- * safe to reference it. Add it to the list to expose it to the allocator.
- */
-static void enable_swap_info(struct swap_info_struct *si)
+static int swap_device_disable(struct address_space *mapping,
+			       struct swap_info_struct **swap_info)
 {
-	percpu_ref_resurrect(&si->users);
-	spin_lock(&swap_lock);
-	spin_lock(&si->lock);
-	_enable_swap_info(si);
-	spin_unlock(&si->lock);
-	spin_unlock(&swap_lock);
-}
+	struct swap_info_struct *si;
+	struct swap_cluster_info *ci;
+	unsigned long offset, end;
+	int err = -EINVAL;
 
-static void reinsert_swap_info(struct swap_info_struct *si)
-{
 	spin_lock(&swap_lock);
-	spin_lock(&si->lock);
-	_enable_swap_info(si);
-	spin_unlock(&si->lock);
-	spin_unlock(&swap_lock);
-}
+	plist_for_each_entry(si, &swap_active_head, list) {
+		if ((si->flags & SWP_WRITEOK) &&
+		    si->swap_file->f_mapping == mapping) {
+			err = 0;
+			break;
+		}
+	}
+	if (err)
+		goto unlock;
 
-/*
- * Called after clearing SWP_WRITEOK, ensures cluster_alloc_range
- * see the updated flags, so there will be no more allocations.
- */
-static void wait_for_allocation(struct swap_info_struct *si)
-{
-	unsigned long offset;
-	unsigned long end = ALIGN(si->max, SWAPFILE_CLUSTER);
-	struct swap_cluster_info *ci;
+	/*
+	 * Refuse swapoff while the device is pinned for hibernation.
+	 */
+	if (si->flags & SWP_HIBERNATION) {
+		err = -EBUSY;
+		goto unlock;
+	}
 
-	BUG_ON(si->flags & SWP_WRITEOK);
+	if (security_vm_enough_memory_mm(current->mm, si->pages)) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+	vm_unacct_memory(si->pages);
 
+	spin_lock(&swap_avail_lock);
+	si->flags &= ~SWP_WRITEOK;
+	spin_unlock(&swap_avail_lock);
+
+	plist_del(&si->list, &swap_active_head);
+	total_swap_pages -= si->pages;
+	atomic_long_sub(si->pages, &nr_swap_pages);
+
+	end = ALIGN(si->max, SWAPFILE_CLUSTER);
+unlock:
+	spin_unlock(&swap_lock);
+	if (err)
+		return err;
+
+	del_from_avail_list(si, true);
+
+	/*
+	 * The swap allocator doesn't take swap_lock. Looping through every
+	 * cluster lock after clearing SWP_WRITEOK ensures that allocators see
+	 * the updated flag and that no allocation remains in flight.
+	 */
 	for (offset = 0; offset < end; offset += SWAPFILE_CLUSTER) {
 		ci = swap_cluster_lock(si, offset);
 		swap_cluster_unlock(ci);
 	}
+
+	*swap_info = si;
+	return 0;
 }
 
 static void free_swap_cluster_info(struct swap_cluster_info *cluster_info,
@@ -3174,7 +3195,6 @@ static void flush_percpu_swap_cluster(struct swap_info_struct *si)
 	}
 }
 
-
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
@@ -3183,7 +3203,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	struct address_space *mapping;
 	struct inode *inode;
 	unsigned int maxpages;
-	int err, found = 0;
+	int err;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -3196,44 +3216,11 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		return PTR_ERR(victim);
 
 	mapping = victim->f_mapping;
-	spin_lock(&swap_lock);
-	plist_for_each_entry(p, &swap_active_head, list) {
-		if (p->flags & SWP_WRITEOK) {
-			if (p->swap_file->f_mapping == mapping) {
-				found = 1;
-				break;
-			}
-		}
-	}
-	if (!found) {
-		err = -EINVAL;
-		spin_unlock(&swap_lock);
-		goto out_dput;
-	}
-
-	/* Refuse swapoff while the device is pinned for hibernation */
-	if (p->flags & SWP_HIBERNATION) {
-		err = -EBUSY;
-		spin_unlock(&swap_lock);
-		goto out_dput;
-	}
-
-	if (!security_vm_enough_memory_mm(current->mm, p->pages))
-		vm_unacct_memory(p->pages);
-	else {
-		err = -ENOMEM;
-		spin_unlock(&swap_lock);
-		goto out_dput;
-	}
-	spin_lock(&p->lock);
-	del_from_avail_list(p, true);
-	plist_del(&p->list, &swap_active_head);
-	atomic_long_sub(p->pages, &nr_swap_pages);
-	total_swap_pages -= p->pages;
-	spin_unlock(&p->lock);
-	spin_unlock(&swap_lock);
+	err = swap_device_disable(mapping, &p);
+	filp_close(victim, NULL);
 
-	wait_for_allocation(p);
+	if (err)
+		return err;
 
 	set_current_oom_origin();
 	err = try_to_unuse(p->type);
@@ -3241,8 +3228,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	if (err) {
 		/* re-insert swap space back into swap_list */
-		reinsert_swap_info(p);
-		goto out_dput;
+		swap_device_enable(p);
+		return err;
 	}
 
 	/*
@@ -3302,13 +3289,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->flags = 0;
 	spin_unlock(&swap_lock);
 
-	err = 0;
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
 
-out_dput:
-	filp_close(victim, NULL);
-	return err;
+	return 0;
 }
 
 #ifdef CONFIG_PROC_FS
@@ -3730,7 +3714,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	/*
 	 * Allocate or reuse existing !SWP_USED swap_info. The returned
 	 * si will stay in a dying status, so nothing will access its content
-	 * until enable_swap_info resurrects its percpu ref and expose it.
+	 * until swap_device_enable resurrects its percpu ref and expose it.
 	 */
 	si = alloc_swap_info();
 	if (IS_ERR(si))
@@ -3898,7 +3882,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	si->swap_file = swap_file;
 
 	/* Sets SWP_WRITEOK, resurrect the percpu ref, expose the swap device */
-	enable_swap_info(si);
+	percpu_ref_resurrect(&si->users);
+	swap_device_enable(si);
 
 	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
 		K(si->pages), name->name, si->prio, nr_extents,
