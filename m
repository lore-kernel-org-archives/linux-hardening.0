Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443392;
	b=Gs+HhuSm8tRt9oTXvPfgOI22qQ6YnB8OUoD21YQS3nomsIr5K1XUR994dhFQy9W9QuCT
	 M/NCM8XpDx7mAvfobILyJenPCDqLSMehFWoInAT/dcF5F0A8b5HEOjQGOtzSTVbpK0IYA
	 SteEoPpts4dyAJHot/LUliKnGTUgl8LSPMYarJ1unfmHCjoRrT2veMCHzW036rdG7PzMw
	 jZnjEWz27BIPQimea3i2MAXhE3mqNbk8olI9MdMy6vxPfKjA6M0gI/+m0SaLS1yVRa0SN
	 pv+OJIdzxM3tXb9bht9cSppCEeVE6+EOhcSz3EGjxUYmaPKA6DKLOdJLzjzsuXXVuOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=N5wwuF3qNxJTr89B9mUIXsNBaKeE0BrKs6qw9tATjs8=;
	b=oevYRAorY4RdHLCLgsJvDqe17qnii74ZA6zDbFGy8bwEqR2Ho1qNakG5vrVv2ORhblZ1
	 4R1oFyKBaKzdhWyEVsX9j86anz/Qc8vczB/DbKpzqkVrhBFLzKb6XEskJfA5G4/1JsilN
	 NNkCw0LaZGrZ4x/Ezn2q5sYAsuZO76+vzk6ucqGBHrgfkESJjto1dhMFutyUndT+Lf5yC
	 xlivE+dDhk35rH+OF1nKoiKZ1/OUyQ0+qMQ+84SreQVsE6YzbWbU52J6I2OUiGBPfAvEt
	 CuzngmF6PZPX4ll9gkPzBIz622+BTdXnHpWg4Fk372TZS9YF3qzdTFNz3mkX0T794dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNsnFYnP;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB4606A31E
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FCB4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNsnFYnP
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38644aedba1so4948737eec.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443391; x=1796048191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N5wwuF3qNxJTr89B9mUIXsNBaKeE0BrKs6qw9tATjs8=;
        b=FNsnFYnPmeHEoIe1XWYc0ttlWtz1TWif6Boyc5rYMqorRcngKwYG15DbdXcihbFndJ
         0o7tzcMOdufZJeXD3Jp8hrBNU0UXJhBIfpEoXg1J8Wj9VjdZCJlkKWDOgteN+5HFH+ZI
         rk+6FnKY2nNvq43FCJg3XfzUg6x4aQXrgrAOatGMG/ExW7CeRGYeL4VmnrxmbIftz12W
         aHLW0vRm80rK4K3U2DWPkQt6janbr2y89pMx/8Du83v9C6wmSYys4ZNvW4tTddI4VHTK
         i1SrUs0ZOBJ5SlZIGxXHsA6DNBf7++WDMrem1Z/iMNRVtwBPsi0QHoc9d+0VkHw04tcB
         jU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443391; x=1796048191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N5wwuF3qNxJTr89B9mUIXsNBaKeE0BrKs6qw9tATjs8=;
        b=f/OO+0kTni8C+j13Mkcaq05HHijaCENH5Bw7zuhMxUlMh5tBti/+rvxUmm4EJjpmjV
         pvYQMu4C6MVZ60R127WctY/TtDY07Zs9RPK5oKbJBK9COtUTwjGdFrd/yA/XoK6ytN9+
         s3Dvu5oopx/gWCo2gDhmh+bV/U/Z7z4Rs7IMYq7Uvnkt1FF84FYlZM6nOCxu9sng1R1K
         ofOEvx6VrZTRZa2dgORnfPkDxv30pRB40F6BB1z28sksVbJT0Jh0jfIzlRlZ/+0iNBJd
         /S2nsyYQlRSBAF9/4upysjfXtmuByKegDaWI2iFKbNQCQmMx9sfLuv0LZ1U0vqiOGOu9
         a/Jw==
X-Forwarded-Encrypted: i=1; AL+hErEnyN4e1gHyf5/ywubFdM1Y08/ruIeHIDepKe8NYCjOZhaOmraQE3bmGh3YOPuFYSgQH1AwDV1fqBVMFun1O2Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eozIwrltcrnNzy0seTp1uupqG47WtKRLbULVsWTQbpXwDAcDj
	LIpA3xXRbQat73qpVB93zIjg8AR7g1RLMJntzOtypzrWusEf01StCcsF5avV38aM
X-Gm-Gg: AZFdTZcYnxKdj38Kp5lQ4Vcvd75YMpNa23Rfw98j+FODHWq9p41Q97tldcTgcldcTo+
	1b+ns5L1rjZDsLgCiL6gNS97jImBaS+he/RSOdupmIZ4BHM4nLA8sKeZbUDgNzJhVJCz4mRY1E4
	tpnN3uIPQhX6VeuF7GyfNzwsaPqGpLJhXOcIpzph7iUQuecN0J9GsMtVz14PW0QncJk3Eaou0HX
	mnFAmSbQB4iDiod5VXbnfZYyx6/kqca7RWNSgvTAN4jhLyDSoc8dmsj8Hi/izHO2ETXKH56YfHZ
	01XFwSSHoRhMAzMUVNLf14LTDYIwaDMJusVqsi9tjzTHgB9QZW3I1sB80KktHNy70kSG/9jQId8
	7wKoxquBAI0crCfR/zhdp2hoFOdf9XUpd2Ty8ay0ZrUtBd5okKSkoCt18YkKBv375PbXuyJcN9H
	IdMI/+mypAo/OTWTKlf7TBSVU82jfZEFEh8WL9TR1IRQoLIoEmPO0UY9t8JM+K5WQ/Mquz+LdKv
	9jSDZKFAn3bQ5nSf953mTehOXLPMchVP/7OgFLgXETtQiIolLmiEaKDRG4JLJm3T0pckDOsWvdq
	tbwlsbHHbnckAVEDebAoUOxJQS2GsLklsYWS+yuHVWdLt+cWPMD4nx94cK6uOUPLBy0bUqKay/Z
	/5K1owaPsqINXrQ==
X-Received: by 2002:a05:7301:4718:b0:369:1401:c5c2 with SMTP id 5a478bee46e88-3857025806bmr11873030eec.26.1795443391256;
        Mon, 23 Nov 2026 06:16:31 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm37911629eec.12.2026.11.23.06.16.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:16:30 -0800 (PST)
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
Subject: [PATCH v5 03/19] mm/swap: cleanup and document swap device availability flag usage
Date: Mon, 23 Nov 2026 22:16:21 +0800
Message-ID: <5a83cfe8b0992c65cf4cca1e8cd612b4de0b78c6.1795439990.git.lianux.mm@gmail.com>
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

Rework swap device flag and metadata handling to make the writable
publication and disable boundaries explicit.

Introduce swap_device_enable() and swap_device_disable(). Move
SWP_WRITEOK updates into these boundaries. Clear the writable flag,
set the off-list state and remove the available entry in one
swap_avail_lock critical section, before releasing swap_lock.

Preserve the existing swap_lock critical section across mapping lookup,
hibernation checks and the disable transition. Drain cluster allocators
after dropping swap_lock, retaining the device-identity protection
without holding swap_lock over all cluster locks.

Document the flag lifetime and locking rules.

Signed-off-by: Kairui Song <kasong@tencent.com>
Co-developed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 include/linux/swap.h |  29 ++++--
 mm/swapfile.c        | 205 ++++++++++++++++++++-----------------------
 2 files changed, 118 insertions(+), 116 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4f686709d71f..0fa77f5679a2 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -188,6 +188,24 @@ struct swap_extent {
 	((offsetof(union swap_header, magic.magic) - \
 	  offsetof(union swap_header, info.badpages)) / sizeof(int))
 
+/*
+ * Swap device flags, except the ones documented below, all are immutable
+ * after exposed by swap_device_enable, and until the device is freed again
+ * (SWP_USED unset), except that teardown clears SWP_ACTIVATED after draining
+ * allocators and live references. The other exceptions:
+ * - SWP_USED: Protected by swap_lock. Indicates the device is inuse. Once
+ *   set, won't be cleared unless all reference to this device is freed and
+ *   swapoff finished.
+ * - SWP_WRITEOK: Protected by swap_lock, si->lock and swap_avail_lock.
+ *   Clearing this flag is followed by waiting for all current cluster lock
+ *   users to exit, so
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
@@ -256,14 +274,9 @@ struct swap_info_struct {
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
index 0ae901296731..f22197a6286c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1268,28 +1268,23 @@ static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
 
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
+		lockdep_assert_held(&swap_lock);
+		lockdep_assert_held(&si->lock);
+		si->flags &= ~SWP_WRITEOK;
+		atomic_long_or(SWAP_USAGE_OFFLIST_BIT, &si->inuse_pages);
 	}
 
 	plist_del(&si->avail_list, &swap_avail_head);
@@ -1299,21 +1294,21 @@ static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
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
+	if (!(READ_ONCE(si->flags) & SWP_WRITEOK))
+		goto skip;
 
 	if (!(atomic_long_read(&si->inuse_pages) & SWAP_USAGE_OFFLIST_BIT))
 		goto skip;
@@ -1369,7 +1364,7 @@ static void swap_usage_sub(struct swap_info_struct *si, unsigned int nr_entries)
 	 * add it to the plist.
 	 */
 	if (unlikely(val & SWAP_USAGE_OFFLIST_BIT))
-		add_to_avail_list(si, false);
+		add_to_avail_list(si);
 }
 
 static void swap_range_alloc(struct swap_info_struct *si,
@@ -1421,7 +1416,7 @@ static bool get_swap_device_info(struct swap_info_struct *si)
 	 * up to dated.
 	 *
 	 * Paired with the spin_unlock() after setup_swap_info() in
-	 * enable_swap_info(), and smp_wmb() in swapoff.
+	 * swap_device_enable(), and smp_wmb() in swapoff.
 	 */
 	smp_rmb();
 	return true;
@@ -3140,58 +3135,88 @@ static int setup_swap_extents(struct swap_info_struct *sis,
 	return generic_swapfile_activate(sis, swap_file, span);
 }
 
-static void _enable_swap_info(struct swap_info_struct *si)
-{
-	atomic_long_add(si->pages, &nr_swap_pages);
-	total_swap_pages += si->pages;
-
-	assert_spin_locked(&swap_lock);
-
-	plist_add(&si->list, &swap_active_head);
-
-	/* Add back to available list */
-	add_to_avail_list(si, true);
-}
-
 /*
- * Called after the swap device is ready, resurrect its percpu ref, it's now
- * safe to reference it. Add it to the list to expose it to the allocator.
+ * Mark a fully initialized swap device writable and expose it to the
+ * allocator. The caller must have resurrected its percpu ref first.
  */
-static void enable_swap_info(struct swap_info_struct *si)
+static void swap_device_enable(struct swap_info_struct *si)
 {
-	percpu_ref_resurrect(&si->users);
 	spin_lock(&swap_lock);
+
 	spin_lock(&si->lock);
-	_enable_swap_info(si);
+	spin_lock(&swap_avail_lock);
+	si->flags |= SWP_WRITEOK;
+	spin_unlock(&swap_avail_lock);
 	spin_unlock(&si->lock);
+
+	atomic_long_add(si->pages, &nr_swap_pages);
+	total_swap_pages += si->pages;
+	plist_add(&si->list, &swap_active_head);
 	spin_unlock(&swap_lock);
+
+	add_to_avail_list(si);
 }
 
-static void reinsert_swap_info(struct swap_info_struct *si)
+static int swap_device_disable(struct address_space *mapping,
+			       struct swap_info_struct **swap_info)
 {
+	struct swap_info_struct *si;
+	struct swap_cluster_info *ci;
+	unsigned long offset, end;
+	int err = -EINVAL;
+
 	spin_lock(&swap_lock);
+	plist_for_each_entry(si, &swap_active_head, list) {
+		if ((si->flags & SWP_WRITEOK) &&
+		    si->swap_file->f_mapping == mapping) {
+			err = 0;
+			break;
+		}
+	}
+	if (err)
+		goto unlock;
+
+	/*
+	 * Refuse swapoff while the device is pinned for hibernation.
+	 */
+	if (si->flags & SWP_HIBERNATION) {
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	if (security_vm_enough_memory_mm(current->mm, si->pages)) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+	vm_unacct_memory(si->pages);
+
+	/* Serialize with the WRITEOK check in isolate_lock_cluster(). */
 	spin_lock(&si->lock);
-	_enable_swap_info(si);
+	del_from_avail_list(si, true);
 	spin_unlock(&si->lock);
-	spin_unlock(&swap_lock);
-}
 
-/*
- * Called after clearing SWP_WRITEOK, ensures cluster_alloc_range
- * see the updated flags, so there will be no more allocations.
- */
-static void wait_for_allocation(struct swap_info_struct *si)
-{
-	unsigned long offset;
-	unsigned long end = ALIGN(si->max, SWAPFILE_CLUSTER);
-	struct swap_cluster_info *ci;
+	plist_del(&si->list, &swap_active_head);
+	total_swap_pages -= si->pages;
+	atomic_long_sub(si->pages, &nr_swap_pages);
 
-	BUG_ON(si->flags & SWP_WRITEOK);
+	end = ALIGN(si->max, SWAPFILE_CLUSTER);
+unlock:
+	spin_unlock(&swap_lock);
+	if (err)
+		return err;
 
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
@@ -3236,7 +3261,6 @@ static void flush_percpu_swap_cluster(struct swap_info_struct *si)
 	}
 }
 
-
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
@@ -3245,7 +3269,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	struct address_space *mapping;
 	struct inode *inode;
 	unsigned int maxpages;
-	int err, found = 0;
+	int err;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -3258,44 +3282,11 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
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
@@ -3303,8 +3294,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	if (err) {
 		/* re-insert swap space back into swap_list */
-		reinsert_swap_info(p);
-		goto out_dput;
+		swap_device_enable(p);
+		return err;
 	}
 
 	/*
@@ -3364,13 +3355,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
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
@@ -3792,7 +3780,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	/*
 	 * Allocate or reuse existing !SWP_USED swap_info. The returned
 	 * si will stay in a dying status, so nothing will access its content
-	 * until enable_swap_info resurrects its percpu ref and expose it.
+	 * until swap_device_enable resurrects its percpu ref and expose it.
 	 */
 	si = alloc_swap_info();
 	if (IS_ERR(si))
@@ -3960,7 +3948,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	si->swap_file = swap_file;
 
 	/* Sets SWP_WRITEOK, resurrect the percpu ref, expose the swap device */
-	enable_swap_info(si);
+	percpu_ref_resurrect(&si->users);
+	swap_device_enable(si);
 
 	pr_info("Adding %luk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
 		K((unsigned long)si->pages), name->name, si->prio, nr_extents,
