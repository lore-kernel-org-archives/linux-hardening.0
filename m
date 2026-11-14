Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667919;
	b=ZadaLstqiFMfAj7zknqsab7i6PfC4phwxJxGz8ZOQjbBoIxKrN0uf0rD3+UoDnNeYUI6
	 y9BmL2nXDanz0sKYdsbiPrqevYwwqdkyDGS8f7ZiUHbufo9a4eHmR1iiYbaORZki2pMZO
	 A+1SeAXtt/UJVFHpRnl0Uj6EMOsTWitEj0qOc8qtVGhiao0enAT57Gu7B8n6dFZ7lG2KB
	 JmYDjuOcMp6yN0pmBxI03nxIL77q5jD7ghuVzDegcOMcg0ykLtVNTggxJ+GHc3vv4MdVq
	 voacpD473ECXrtzRl4VOkls9giaYJDLSj97ymtpwn75vBQuLVx86meYaEqf8LeZPyZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0GioUseZHzqH/AOOE2IX8pcEfvZptyLPBBSCPC7A9cg=;
	b=eycES/z0tRy64DOfH2kCwrOBjgQ/5Cxj1pEPkYRHtbfOFVhJVX2nurRcRAjHIgS6xrLF
	 +MZazbrgbEJVMHjk63m1gR+7sN7sEJE1GcA3k4ygiL3mTndVeTOBRt5sEi+Za8yHAnRvY
	 YlFdRXBaFHSctx2q3QWZqXu5WlcblOFRS4sdMb2zji9b8v+w0g3Il72fRE+OmEb+gQmb/
	 PjaBZaqb8gGZdn6WIthsEuULN1P6H4dvZktK/VeXTu1fpqgMJkBmZa+ljgcnEiMg/blU0
	 vlwL+TMwNW2WMEWPxg8N237M2UJ9jZourNG0mLzfE4s/cJ4USXp07rvUPuEidSE7WlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AaCEu8VE;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14535606A323
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14535606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AaCEu8VE
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ccca948203aso969847a12.3
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667918; x=1795272718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0GioUseZHzqH/AOOE2IX8pcEfvZptyLPBBSCPC7A9cg=;
        b=AaCEu8VEMfEOx3SPih63jEN7DMRHjwekjEXMO18ozLhlnv1o201jAlY5YgPYvVI+M0
         e5l83Vm/ApD9pdmvSBDvjrmlmeESol9fVa6q9yarSI0ytDD++GXSXiFhD5zc9JVB8B79
         x7RMDqMqlB8y9ZcG3QRVEe/wT/U9hnnJJWBZjBKRWNIbc8thmYYP2IWco8AHJm5rASii
         0+TX4evOytekI5hG2+VGRWE2PV6GRN10hjrWFC0FbPsLMMEfb1JYjZ7Hlw4OPhXTjFXq
         aOIX9cI1yHO2nvSDmkCiqp3fMXaQZce3jQarjM+nDgRswUUyZhl1jRdHIHNsYPOmjXZs
         D/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667918; x=1795272718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0GioUseZHzqH/AOOE2IX8pcEfvZptyLPBBSCPC7A9cg=;
        b=HYF6BahaPGG6Y1FXrFqp7FAaE9CJm8iCjpWeZcc5At23UvMtwhTuWlMa4E20euc3nI
         Qvye3O3nvLnGAbk2V2W52xLucy8uWoXv88pcjw8zTXUqwOkZQUGUWPUg4syCmOelGG1Y
         J0IXUG1qrA1rFtbuuHob9Yqrr5zITGGYvrDGcvbI+ojMM0xygFDq8epucXb/PgeWUufg
         3I8Wy17UcW4DHw0kOSyraSnEtx6rKmkoPf1w8QWy8bRUa5du5Tpyd/DvxnlVCxvYilIy
         frT4M+oKGlGsSSmWO3oXXYVGTzOOqxBMcZcLWxh7R4rlsgsFPtyIEswex0tBcQF+jX2W
         Ogow==
X-Forwarded-Encrypted: i=1; AL+hErHgL3B4YtVWu6KTD7LBeTTR++I1anJEKVgz+tzQZ69m98Ja16G4Q5Y4X9UUP9TNZnbKM6cK0UlW8FX48lE8J3s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EIH0Wgj05e+ReSKden7PzVYgm8do4messIYcpP5f4EYuT+UYi
	/O4s/Op1gmE4p52Kjca/kbRdkyqq2hEiMVlmpu5jiy3ybxgWXt4wesAL
X-Gm-Gg: AYBFou2rDxwPNP98gypH1trdJAyIYb4w3wH2fyC/isMlRZeQvM3Bjrtg5nm6LpMbeRj
	L2/jzsRNn1x4hNpugLe/cLaxT7963kzLL97pv7gV9DqY8t8DSgmH9hWY553gWDUq68iCvKnKfck
	3HOtW8Y3yRVXG7MBA1j9HYK/FC2Q638zJbSduppE97uw/X/FViGqzCDSar1yl5yvYo6vCr5ltnN
	ljqOSZAtNEIlkBFjh5TghO2GsX3fiYFd/QHcT0xur+mRcFl9lDVJ414BXiwk8dAgZ4PkB6pB2ra
	oOyJFSORODbD5r+kk7Y8HMViKgQe7UFIca9oV2aCdChV+ALuy35+z5o160DninL3DA8V4mXdAgi
	WxUk19hZgYMjcEZjyECOCH4zaYpzEBZ0YzcAI/0THG4OY2Wfl+85jYEBPqa/1ec/bQC/wlxtTHx
	DHAIFfTXcgg6jEtqucGvhMViZGztQS5H4ImKYxqW3FikGHpkYpdIfvQE50aNrJEnuHlagDItnQ/
	Rjb874fL81RIVH7O8p8uYUB6MMvzi8mQkuRq6XJBaSQxW+zOKrWsADisT/C+ItPtoXyuUmi8LWP
	tBlPY/xXO2nY1DP96tfS+wMzGsjjPDHcmRLfYaD8FfG9LgLkbSK3ERnPsnMvwncPDSiG
X-Received: by 2002:a05:6300:6cc1:10b0:3f9:797f:3869 with SMTP id adf61e73a8af0-3f9797f51e7mr916044637.47.1794667918330;
        Sat, 14 Nov 2026 06:51:58 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc160bfabsm2392057a12.4.2026.11.14.06.51.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:51:58 -0800 (PST)
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
Subject: [RFC PATCH v4 13/18] mm/swap: drop swap active plist
Date: Sat, 14 Nov 2026 22:51:44 +0800
Message-ID: <9ccd81f6f036eb1c3e50d396b44b5e43cff77d2a.1794666741.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
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

Remove swap_active_head and the associated plist_node. Device identity
lookups can use the writable swap_info iterator without ordering.

Keep priority ordering for the block-cgroup swap throttle target by
walking the priority queue under the topology reader. Choose the first
unmasked, writable, non-offlist device with a backing block device.
Check OFFLIST as well as the pointer tag because full transitions can
temporarily leave an unmasked entry, and keep the explicit WRITEOK
check. The disable transition already publishes its mask before
releasing the topology writer.

This read-only lookup does not consume per-CPU allocation quotas or
change retry cursors. It avoids making the throttle disk depend on
swapon's swap-type assignment order when devices have different
priorities.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 60 +++++++++++++++++++++++---------------------
 2 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d31f3f023d36..ce8a800751ca 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -263,7 +263,6 @@ struct swap_info_struct {
 	struct percpu_ref users;	/* indicate and keep swap device valid. */
 	unsigned long	flags;		/* SWP_USED etc: see above */
 	signed short	prio;		/* swap priority of this type */
-	struct plist_node list;		/* entry in swap_active_head */
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* size of this swap device */
 	struct swap_cluster_info *cluster_info; /* array, one entry per cluster */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6b2dbaf33cb6..bd098114ee4b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -42,7 +42,6 @@
 #include <linux/completion.h>
 #include <linux/suspend.h>
 #include <linux/zswap.h>
-#include <linux/plist.h>
 
 #include <asm/tlbflush.h>
 #include <linux/leafops.h>
@@ -91,12 +90,6 @@ bool swap_migration_ad_supported;
 static const char Bad_file[] = "Bad swap file entry ";
 static const char Bad_offset[] = "Bad swap offset entry ";
 
-/*
- * all active swap_info_structs
- * protected with swapon_rwsem, and ordered by priority.
- */
-static PLIST_HEAD(swap_active_head);
-
 static inline struct swap_info_struct *__swap_iter(int *i, unsigned long flag)
 {
 	lockdep_assert_held(&swapon_rwsem);
@@ -3535,7 +3528,6 @@ static void __swap_device_enable(struct swap_info_struct *si)
 	spin_unlock(&si->lock);
 	atomic_long_add(si->pages, &nr_swap_pages);
 	total_swap_pages += si->pages;
-	plist_add(&si->list, &swap_active_head);
 	add_to_avail_list(si);
 }
 
@@ -3555,9 +3547,8 @@ static int swap_device_disable(struct address_space *mapping,
 	int err = -EINVAL;
 
 	percpu_down_write(&swapon_rwsem);
-	plist_for_each_entry(si, &swap_active_head, list) {
-		if ((si->flags & SWP_WRITEOK) &&
-		    si->swap_file->f_mapping == mapping) {
+	for_each_avail_swap(si) {
+		if (si->swap_file->f_mapping == mapping) {
 			err = 0;
 			break;
 		}
@@ -3583,8 +3574,6 @@ static int swap_device_disable(struct address_space *mapping,
 	spin_lock(&si->lock);
 	del_from_avail_list(si, true);
 	spin_unlock(&si->lock);
-
-	plist_del(&si->list, &swap_active_head);
 	total_swap_pages -= si->pages;
 	atomic_long_sub(si->pages, &nr_swap_pages);
 
@@ -3913,7 +3902,6 @@ static struct swap_info_struct *alloc_swap_info(void)
 		 */
 	}
 	p->swap_extent_root = RB_ROOT;
-	plist_node_init(&p->list, 0);
 	p->flags = SWP_USED;
 	percpu_up_write(&swapon_rwsem);
 	if (defer) {
@@ -4323,12 +4311,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio = swap_flags & SWAP_FLAG_PRIO_MASK;
 
-	/*
-	 * The plist prio is negated because plist ordering is
-	 * low-to-high, while swap ordering is high-to-low
-	 */
 	si->prio = prio;
-	si->list.prio = -si->prio;
 
 	/*
 	 * Publish swap_file before making the percpu ref live, then add the device
@@ -4454,7 +4437,33 @@ int swap_dup_entry_direct(swp_entry_t entry)
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
 static bool __has_usable_swap(void)
 {
-	return !plist_head_empty(&swap_active_head);
+	return READ_ONCE(total_swap_pages) > 0;
+}
+
+static struct swap_info_struct *swap_queue_first_usable_bdev(void)
+{
+	struct swap_prio_ring *ring;
+	struct swap_info_struct *si;
+	unsigned int ring_idx, dev_idx;
+
+	lockdep_assert_held(&swapon_rwsem);
+	for (ring_idx = 0; ring_idx < swap_queue_len; ring_idx++) {
+		ring = swap_queue[ring_idx];
+		for (dev_idx = 0; dev_idx < ring->size; dev_idx++) {
+			si = READ_ONCE(ring->dev[dev_idx]);
+			if (swap_device_masked(si))
+				continue;
+			si = swap_device_unmask_ptr(si);
+			if (!(READ_ONCE(si->flags) & SWP_WRITEOK))
+				continue;
+			if (atomic_long_read(&si->inuse_pages) &
+			    SWAP_USAGE_OFFLIST_BIT)
+				continue;
+			if (si->bdev)
+				return si;
+		}
+	}
+	return NULL;
 }
 
 void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
@@ -4478,14 +4487,9 @@ void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
 		return;
 
 	percpu_down_read(&swapon_rwsem);
-	plist_for_each_entry(si, &swap_active_head, list) {
-		if ((si->flags & SWP_WRITEOK) &&
-		    !(atomic_long_read(&si->inuse_pages) &
-		      SWAP_USAGE_OFFLIST_BIT) && si->bdev) {
-			blkcg_schedule_throttle(si->bdev->bd_disk, true);
-			break;
-		}
-	}
+	si = swap_queue_first_usable_bdev();
+	if (si)
+		blkcg_schedule_throttle(si->bdev->bd_disk, true);
 	percpu_up_read(&swapon_rwsem);
 }
 #endif
