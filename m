Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117178;
	b=eJq1Wt5jhHhQpYcKjebs0L9jceKni7K2xPTn77DCnd6ns42WCKJrTXVD9o+v11EdmeCH
	 lKVTsSfE5Da/vxNrofYAhW2s//k/gDh3XvaR5y/4kHTRbuJgjnMJzIeIv8+9bupSnFj8V
	 NiW/xGtgFjHPfYQQnPndhF7LXZwMgpBnMQaVoWjx6Nu+d+2HUOz15VUW7ERw7yLNyZtq0
	 EGBd1IAkRvk2j92+tAXjnbn3EymE4v0hZJ8a5h5iWxnFTlD55t5RSVHBi9Cis7CqVoZFd
	 Ln2lZLdOIqhG2OhS8ou3eFfemqzTxActYEoM6MrJSviqRU0ZkcnkNKhNTzwlGfaKpoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qII63eC0LU7E+F5t8Bg2YK08YX0cPPryRBRU+kP6RuA=;
	b=2AT9ytEORO/i3k5MsQW4dXYPgWKtvEYXa0ElQbXBGE5nwUzS7ZT0d4ROIg2Pm7u3dqCw
	 maQV9W/oGn4fqzWrXjd4tXKQIC6qSw2asVdGp4Ajwup7l7rjX0NlV7DNgCl5G+CgWn0qc
	 aVbdF6CkTrSRfTsrxCc7zJwDiRrQFrzunv1Y5N9rpAaFdnljrYX0zKutIAqk+3ZUkwqTn
	 RbaG4XAXjFWA7HXR5O8hL3mMDfi/94hTR/dlquKd7dv7q2AbXgRGitsY6YslD+jzE3bMn
	 1AGP3+Zu8+y7W0uMHB0fAj8cVr//jtHAbsl8YVpYljSxXQc7GEMjRUmFE9F2NMLKNcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z6H7BIDG;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA67606A31A
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEA67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z6H7BIDG
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070781f63so43274b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117177; x=1793721977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qII63eC0LU7E+F5t8Bg2YK08YX0cPPryRBRU+kP6RuA=;
        b=Z6H7BIDGodWIm64QzR7BuLeSmF9sL+mZ/hmC9kXBkiRkKGXwGJ7GpDNu+5WWM4DoHI
         V4YRrmymf+wxw2b71G8uMLrpwWQMT1c/+pT++EO15CkkW0lkXRKxNH0rtDKtb++RBcND
         SBHiQsbZ1ptIpyKtO4jk4hqaP1LEbrxaNvK6BxHIYy+73MciztmsaIz/ILGzIqapzWx+
         PATyH5REdrG8F/K661XEnV6+P7lfL4UWjYZqv1m78NbaL06msCnmpR3ZWobE0XsnCLrf
         ouUdkbQhdxQNrONhAz8E/tqTxEjjtZCJEwRkUak/cKRVFp7b7jcRiGyJ1RbYodbRvPD/
         E/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117177; x=1793721977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qII63eC0LU7E+F5t8Bg2YK08YX0cPPryRBRU+kP6RuA=;
        b=DidQJ2turUqtwc6BjoSJebyXJ4THObNnUkgd4xobvrzJRPn4S19Vbvg8xh9YcMPGAP
         pz02uulJC1njWdtYaV68YeT2NX0RFKoWlN09jNst+BASe/wVaANlZDCwY4pue0eWpODC
         p72xwh88mN7e39z71rL51rRTSiGthU+H04AtvEvPjEEVBXDM+LSjNL2fGG/fn2KjsAQM
         qtADeuWbWKuZBzNfPIHunrric2W4CdwB4qAp2MnO2N0zpSf/J+bQIj1jLgcgf1WWA8Gh
         PihKgwtTjZv6Pf9ckZbQM6MxSR6ApW8gTxkeD6X12LOLWs4tBPiGr/Ch9DwZRUDlUr6N
         f1XQ==
X-Forwarded-Encrypted: i=1; AKwUvBynS2Yf3cKHwAy5GYefPztr/SXRdgt+iA/x29crVqqmqMEpjLEZL780meGurfPH92x4j85pSPvRbIBDFrGpuyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8wrjBWRFU516B6J7FchHLna9AvVozvroXOLy3KNIoUI33MFN4
	eFlWFF4eDd6zAMeV0Ofy3/9dRloAvfHvTw6hc0epUW/Ulxpx2o1rkjyx
X-Gm-Gg: AYBFou3cA8Y5pnF9w+sRNO6GzDmEn62CGJZacd2LC3VSOszc/UcTJpaMPVCzQVF9OR+
	af42YwM7Bo691kFDD4cvnJ+qwb2Akd8A/uZjeu4qIx0dFiWYlFebcUOCbDm/ghJqoAy72iQVp+n
	vokTHTwvrJmKqZPMO7roKO4C+skAcIsH/xtKNmbB42PZcruLb5Z9JZ+UFyhQ9RK1QrNt3+WLhfm
	xEVgv1m1gkCOR3iAN0PLoEJDjDOpmyDBItpYgBw3briplrPWxvxi8noCSGI8wKOBr9pVECc7WNw
	odynShMH57fZ0XazYHPRuTsMRZM15gcAWGyPMrk4NRrWrlT3MSAdDgQay4H3qZ05fNnfmf6Y0K2
	ks81pkA0ZCCUbwDXUwHNOynS/9lPgAeB1cPEkXiNpO2ft81Ap4jTXW3PRPdanJNXf4PD/DybRg8
	R40tBJL1T5evFS3U/2PFrNY4OtLIBQhH27yPP0FSdMt466J10+ZHMySG2wnpKbdsSOWK7PLxwUA
	UNx8XtECZgjn9W3jW5McLB0cO1ex7D3rg5nl1pNa2cjk/aptZxaKAELuP4t11e8eReKhl5LA0b1
	GmtFW8CGBnoWJD9L4Uc=
X-Received: by 2002:a05:6a21:a109:b0:3de:74ee:c045 with SMTP id adf61e73a8af0-3e7af7e9aebmr7586844637.7.1793117176871;
        Tue, 27 Oct 2026 09:06:16 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a0d983ebsm306033b3a.0.2026.10.27.09.06.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:06:16 -0700 (PDT)
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
Subject: [RFC PATCH v3 05/18] mm/swap: change the swapon lock into a percpu rwsem
Date: Wed, 28 Oct 2026 00:05:48 +0800
Message-ID: <d7120017ded998ca722ed78e1995f0d1af82e88c.1793106426.git.lianux.mm@gmail.com>
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

Reading swap metadata is a common hot path, while swapon and swapoff
are costly and very rare.  Convert the existing swap_lock spinlock
into a percpu rwsem so that readers can run concurrently without
contention.  This is a first step toward cleaning up the swap lock
model and we might already see a performance gain for existing
readers.

Also update the comments in swap_info_struct to reflect the lock
name change.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 include/linux/swap.h |  10 ++--
 mm/swapfile.c        | 129 +++++++++++++++++++++++--------------------
 2 files changed, 73 insertions(+), 66 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 66b8e602178d..80a14a8daba2 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -191,17 +191,17 @@ struct swap_extent {
 /*
  * Swap device flags, except the ones documented below, all are immutable
  * after exposed by swap_device_enable, and until the device is freed again
- * (SWP_USED unset). The exceptions:
- * - SWP_USED: Protected by swap_lock. Indicates the device is inuse. Once
+ * (SWP_USED unset). The exceptions are all protected by swapon_rwsem:
+ * - SWP_USED: Protected by swapon_rwsem. Indicates the device is inuse. Once
  *   set, won't be cleared unless all reference to this device is freed and
  *   swapoff finished.
- * - SWP_WRITEOK: Protected by both swap_lock and swap_avail_lock, clearing
+ * - SWP_WRITEOK: Protected by both swapon_rwsem and swap_avail_lock, clearing
  *   this flag also waits for all current cluster lock users to exit so
  *   checking this flag while holding any of these locks ensures the device
  *   is safe to use at the moment. Note: clearing this flag doesn't affect
  *   pending IO or async requests, it only prevents further entry allocation
  *   or new async request (e.g. discard) from initiating.
- * - SWP_HIBERNATION: Protected by swap_lock. Indicates if the device
+ * - SWP_HIBERNATION: Protected by swapon_rwsem. Indicates if the device
  *   is pinned for hibernation.
  */
 enum {
@@ -274,7 +274,7 @@ struct swap_info_struct {
 	spinlock_t lock;		/*
 					 * Protect cluster lists. Other fields
 					 * are only changed at swapon/swapoff,
-					 * so are protected by swap_lock.
+					 * so are protected by swapon_rwsem.
 					 */
 	struct work_struct discard_work; /* discard worker */
 	struct work_struct reclaim_work; /* reclaim worker */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b72f4fc3e811..4ffde6827d44 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -57,23 +57,29 @@ static void move_cluster(struct swap_info_struct *si,
 			 enum swap_cluster_flags new_flags);
 
 /*
- * Protects the swap_info array, and the SWP_USED flag. swap_info contains
- * lazily allocated & freed swap device info struts, and SWP_USED indicates
- * which device is used, ~SWP_USED devices and can be reused.
- *
- * Also protects swap_active_head total_swap_pages, and the SWP_WRITEOK flag.
+ * Serializes swapon/swapoff (writers) and protects the swap_info
+ * array, nr_swapfiles, total_swap_pages, and part of swap device
+ * info content (see comment of swap_info_struct).  Readers
+ * (allocation, /proc/swaps, etc.) take percpu_down_read() which
+ * is cheap as the hot path.
+ */
+DEFINE_STATIC_PERCPU_RWSEM(swapon_rwsem);
+/*
+ * swap_info contains lazily allocated swap device info structs, and
+ * SWP_USED indicates which device is used, ~SWP_USED devices can be
+ * reused. Protected by swapon_rwsem, but reading could be lockless.
  */
-static DEFINE_SPINLOCK(swap_lock);
+struct swap_info_struct *swap_info[MAX_SWAPFILES];
 static unsigned int nr_swapfiles;
-atomic_long_t nr_swap_pages;
+long total_swap_pages;
+
 /*
  * Some modules use swappable objects and may try to swap them out under
  * memory pressure (via the shrinker). Before doing so, they may wish to
  * check to see if any swap space is available.
  */
+atomic_long_t nr_swap_pages;
 EXPORT_SYMBOL_GPL(nr_swap_pages);
-/* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
-long total_swap_pages;
 #define DEF_SWAP_PRIO  -1
 unsigned long swapfile_maximum_size;
 #ifdef CONFIG_MIGRATION
@@ -85,7 +91,7 @@ static const char Bad_offset[] = "Bad swap offset entry ";
 
 /*
  * all active swap_info_structs
- * protected with swap_lock, and ordered by priority.
+ * protected with swapon_rwsem, and ordered by priority.
  */
 static PLIST_HEAD(swap_active_head);
 
@@ -95,20 +101,18 @@ static PLIST_HEAD(swap_active_head);
  * This is used by folio_alloc_swap() instead of swap_active_head
  * because swap_active_head includes all swap_info_structs,
  * but folio_alloc_swap() doesn't need to look at full ones.
- * This uses its own lock instead of swap_lock because when a
+ * This uses its own lock instead of swapon_rwsem because when a
  * swap_info_struct changes between not-full/full, it needs to
  * add/remove itself to/from this list, but the swap_info_struct->lock
- * is held and the locking order requires swap_lock to be taken
+ * is held and the locking order requires swapon_rwsem to be taken
  * before any swap_info_struct->lock.
  */
 static PLIST_HEAD(swap_avail_head);
 static DEFINE_SPINLOCK(swap_avail_lock);
 
-struct swap_info_struct *swap_info[MAX_SWAPFILES];
-
 static inline struct swap_info_struct *__swap_iter(int *i, unsigned long flag)
 {
-	lockdep_assert_held(&swap_lock);
+	lockdep_assert_held(&swapon_rwsem);
 	while (*i < nr_swapfiles) {
 		struct swap_info_struct *si = __swap_type_to_info(*i);
 
@@ -128,7 +132,7 @@ static inline struct swap_info_struct *__swap_iter(int *i, unsigned long flag)
  * for_each_swap - iterate through all allocated and inuse swap devices
  * @si: the iterator
  *
- * Context: The caller must hold swap_lock. The lock may be dropped during
+ * Context: The caller must hold swapon_rwsem. The lock may be dropped during
  * the loop body but must be re-acquired before the next iteration.
  */
 #define for_each_swap(si) __for_each_swap(si, SWP_USED)
@@ -1377,10 +1381,10 @@ static bool get_swap_device_info(struct swap_info_struct *si)
 	/*
 	 * Guarantee the si->users are checked before accessing other
 	 * fields of swap_info_struct, and si->flags (SWP_WRITEOK) is
-	 * up to dated.
+	 * up to date.
 	 *
-	 * Paired with the spin_unlock() after setup_swap_info() in
-	 * swap_device_enable(), and smp_wmb() in swapoff.
+	 * Paired with percpu_up_write() in swap_device_enable(), and
+	 * smp_wmb() after clearing SWP_WRITEOK in swapoff.
 	 */
 	smp_rmb();
 	return true;
@@ -1465,10 +1469,10 @@ static bool swap_sync_discard(void)
 	bool ret = false;
 	struct swap_info_struct *si, *next;
 
-	spin_lock(&swap_lock);
+	percpu_down_read(&swapon_rwsem);
 start_over:
 	plist_for_each_entry_safe(si, next, &swap_active_head, list) {
-		spin_unlock(&swap_lock);
+		percpu_up_read(&swapon_rwsem);
 		if (get_swap_device_info(si)) {
 			if (si->flags & SWP_PAGE_DISCARD)
 				ret = swap_do_scheduled_discard(si);
@@ -1477,11 +1481,11 @@ start_over:
 		if (ret)
 			return true;
 
-		spin_lock(&swap_lock);
+		percpu_down_read(&swapon_rwsem);
 		if (plist_node_empty(&next->list))
 			goto start_over;
 	}
-	spin_unlock(&swap_lock);
+	percpu_up_read(&swapon_rwsem);
 
 	return false;
 }
@@ -2294,7 +2298,7 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
 	int ret;
 	struct swap_info_struct *si;
 
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	ret = __find_hibernation_swap_type(device, offset);
 	if (ret < 0)
 		goto out;
@@ -2318,7 +2322,7 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
 	si->flags |= SWP_HIBERNATION;
 
 out:
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	return ret;
 }
 
@@ -2330,7 +2334,7 @@ out:
  *
  * Look up the swap device for @device/@offset and atomically transfer
  * the SWP_HIBERNATION pin from @old_type (if valid) to the new device,
- * all under a single swap_lock critical section. This closes the
+ * all under a single swapon_rwsem writer section. This closes the
  * swapoff() window that exists when callers unpin and re-pin in two
  * separate operations.
  *
@@ -2350,28 +2354,28 @@ int repin_hibernation_swap_type(int old_type, dev_t device, sector_t offset)
 	struct swap_info_struct *old_si, *new_si;
 	int new_type;
 
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 
 	new_type = __find_hibernation_swap_type(device, offset);
 	if (new_type < 0) {
-		spin_unlock(&swap_lock);
+		percpu_up_write(&swapon_rwsem);
 		return new_type;
 	}
 
 	new_si = swap_type_to_info(new_type);
 	if (WARN_ON_ONCE(!new_si)) {
-		spin_unlock(&swap_lock);
+		percpu_up_write(&swapon_rwsem);
 		return -ENODEV;
 	}
 
 	old_si = swap_type_to_info(old_type);
 	if (new_si == old_si) {
-		spin_unlock(&swap_lock);
+		percpu_up_write(&swapon_rwsem);
 		return new_type;
 	}
 
 	if (WARN_ON_ONCE(new_si->flags & SWP_HIBERNATION)) {
-		spin_unlock(&swap_lock);
+		percpu_up_write(&swapon_rwsem);
 		return -EBUSY;
 	}
 
@@ -2379,7 +2383,7 @@ int repin_hibernation_swap_type(int old_type, dev_t device, sector_t offset)
 		old_si->flags &= ~SWP_HIBERNATION;
 	new_si->flags |= SWP_HIBERNATION;
 
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	return new_type;
 }
 
@@ -2397,11 +2401,11 @@ void unpin_hibernation_swap_type(int type)
 {
 	struct swap_info_struct *si;
 
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	si = swap_type_to_info(type);
 	if (si)
 		si->flags &= ~SWP_HIBERNATION;
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 }
 
 /**
@@ -2426,9 +2430,9 @@ int find_hibernation_swap_type(dev_t device, sector_t offset)
 {
 	int type;
 
-	spin_lock(&swap_lock);
+	percpu_down_read(&swapon_rwsem);
 	type = __find_hibernation_swap_type(device, offset);
-	spin_unlock(&swap_lock);
+	percpu_up_read(&swapon_rwsem);
 
 	return type;
 }
@@ -2438,13 +2442,13 @@ int find_first_swap(dev_t *device)
 	int ret = -ENODEV;
 	struct swap_info_struct *si;
 
-	spin_lock(&swap_lock);
+	percpu_down_read(&swapon_rwsem);
 	for_each_avail_swap(si) {
 		*device = si->bdev->bd_dev;
 		ret = si->type;
 		break;
 	}
-	spin_unlock(&swap_lock);
+	percpu_up_read(&swapon_rwsem);
 	return ret;
 }
 
@@ -2473,7 +2477,7 @@ unsigned int count_swap_pages(int type, int free)
 {
 	unsigned int n = 0;
 
-	spin_lock(&swap_lock);
+	percpu_down_read(&swapon_rwsem);
 	if ((unsigned int)type < nr_swapfiles) {
 		struct swap_info_struct *sis = swap_info[type];
 
@@ -2485,7 +2489,7 @@ unsigned int count_swap_pages(int type, int free)
 		}
 		spin_unlock(&sis->lock);
 	}
-	spin_unlock(&swap_lock);
+	percpu_up_read(&swapon_rwsem);
 	return n;
 }
 #endif /* CONFIG_HIBERNATION */
@@ -2801,10 +2805,10 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 	unsigned long swp_tb;
 
 	/*
-	 * No need for swap_lock here: we're just looking
+	 * No need for swapon_rwsem here: we're just looking
 	 * for whether an entry is in use, not modifying it; false
 	 * hits are okay, and sys_swapoff() has already prevented new
-	 * allocations from this area (while holding swap_lock).
+	 * allocations from this area (while holding swapon_rwsem).
 	 */
 	i = prev + 1;
 	while (i < si->max) {
@@ -2942,8 +2946,8 @@ success:
 
 /*
  * After a successful try_to_unuse, if no swap is now in use, we know
- * we can empty the mmlist.  swap_lock must be held on entry and exit.
- * Note that mmlist_lock nests inside swap_lock, and an mm must be
+ * we can empty the mmlist. swapon_rwsem must be held on entry and exit.
+ * Note that mmlist_lock nests inside swapon_rwsem, and an mm must be
  * added to the mmlist just after page_duplicate - before would be racy.
  */
 static void drain_mmlist(void)
@@ -3095,8 +3099,7 @@ static int setup_swap_extents(struct swap_info_struct *sis,
  */
 static void swap_device_enable(struct swap_info_struct *si)
 {
-	spin_lock(&swap_lock);
-
+	percpu_down_write(&swapon_rwsem);
 	spin_lock(&swap_avail_lock);
 	si->flags |= SWP_WRITEOK;
 	spin_unlock(&swap_avail_lock);
@@ -3104,7 +3107,7 @@ static void swap_device_enable(struct swap_info_struct *si)
 	atomic_long_add(si->pages, &nr_swap_pages);
 	total_swap_pages += si->pages;
 	plist_add(&si->list, &swap_active_head);
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 
 	add_to_avail_list(si);
 }
@@ -3117,7 +3120,7 @@ static int swap_device_disable(struct address_space *mapping,
 	unsigned long offset, end;
 	int err = -EINVAL;
 
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	plist_for_each_entry(si, &swap_active_head, list) {
 		if ((si->flags & SWP_WRITEOK) &&
 		    si->swap_file->f_mapping == mapping) {
@@ -3152,14 +3155,14 @@ static int swap_device_disable(struct address_space *mapping,
 
 	end = ALIGN(si->max, SWAPFILE_CLUSTER);
 unlock:
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	if (err)
 		return err;
 
 	del_from_avail_list(si, true);
 
 	/*
-	 * The swap allocator doesn't take swap_lock. Looping through every
+	 * The swap allocator doesn't take swapon_rwsem. Looping through every
 	 * cluster lock after clearing SWP_WRITEOK ensures that allocators see
 	 * the updated flag and that no allocation remains in flight.
 	 */
@@ -3273,7 +3276,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		atomic_dec(&nr_rotate_swap);
 
 	mutex_lock(&swapon_mutex);
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	spin_lock(&p->lock);
 	drain_mmlist();
 
@@ -3284,7 +3287,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->max = 0;
 	p->cluster_info = NULL;
 	spin_unlock(&p->lock);
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
 	mutex_unlock(&swapon_mutex);
@@ -3303,10 +3306,14 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	 * Clear the SWP_USED flag after all resources are freed so that swapon
 	 * can reuse this swap_info in alloc_swap_info() safely.  It is ok to
 	 * not hold p->lock after we cleared its SWP_WRITEOK.
+	 *
+	 * The write lock ensures the flag clear is visible to lockless
+	 * readers of swap_type_to_info() before alloc_swap_info() reuses
+	 * this slot.
 	 */
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	p->flags = 0;
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
@@ -3466,13 +3473,13 @@ static struct swap_info_struct *alloc_swap_info(void)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	for (type = 0; type < nr_swapfiles; type++) {
 		if (!(swap_info[type]->flags & SWP_USED))
 			break;
 	}
 	if (type >= MAX_SWAPFILES) {
-		spin_unlock(&swap_lock);
+		percpu_up_write(&swapon_rwsem);
 		percpu_ref_exit(&p->users);
 		kvfree(p);
 		return ERR_PTR(-EPERM);
@@ -3497,7 +3504,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 	plist_node_init(&p->list, 0);
 	plist_node_init(&p->avail_list, 0);
 	p->flags = SWP_USED;
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	if (defer) {
 		percpu_ref_exit(&defer->users);
 		kvfree(defer);
@@ -3933,9 +3940,9 @@ bad_swap:
 	 * Clear the SWP_USED flag after all resources are freed so
 	 * alloc_swap_info can reuse this si safely.
 	 */
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	si->flags = 0;
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	if (inced_nr_rotate_swap)
 		atomic_dec(&nr_rotate_swap);
 	if (swap_file)
@@ -3953,14 +3960,14 @@ void si_swapinfo(struct sysinfo *val)
 	struct swap_info_struct *si;
 	unsigned long nr_to_be_unused = 0;
 
-	spin_lock(&swap_lock);
+	percpu_down_read(&swapon_rwsem);
 	for_each_swap(si) {
 		if (!(si->flags & SWP_WRITEOK))
 			nr_to_be_unused += swap_usage_in_pages(si);
 	}
 	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
 	val->totalswap = total_swap_pages + nr_to_be_unused;
-	spin_unlock(&swap_lock);
+	percpu_up_read(&swapon_rwsem);
 }
 
 /*
