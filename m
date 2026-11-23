Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443415;
	b=1oTmy4FQrBErTHb6UrVN2XqJM2zIJPN2w7vz126KoblzQpa5uVOmzoW8THlwj1EZCwez
	 hsiKnLhb0m3tXa+nQX2ALFUkdVLcB2ec9v/36G1zfV3+tfgnYPVs9W1rfTsE7fo+v+YRY
	 kbSEMByfTzOn/QFNCJKy5IzlW1dTWlIM81YrQ0DGLJdrtCSQuck/keAFXCjNzkykwjOCK
	 nC6tnS5gURSl+KwpMxFjlNEG546QolVLI1e1jyJ1Bqih4CCv15ke2tzYhU1grSWXTOkkr
	 U3txNMlFbYlAz1qM6RAdZ7Y6r7FfFEVHOmvFh9E4haR6icSNkzihaVoWiI2TI5beClQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iABdfnxFx3EmjF7ws7PA7smuift4fgOpvgTOd+xZhS4=;
	b=4uAT9aqP2AOuL5Jwvku/uC7i3FisHzaDmCq52e8TCw9jZPmnyeLamqRttRRPMcSIMMm3
	 LMUvGnIGpGcg/wRuHuhTuOgF5mPQ/zSCBOye1QBiy+G/GLPh8h6zD9u6yoNM8EWUsC/x5
	 IawSrxMzPUYWttNC1MPgocKyMzMVsMZD8cIme7BbJtJJ+M2/stYhVtEXgmzU4WN7LKT5g
	 1kBdtytt+vcMYOUGadYkJaHyyyf1xX8cv2vOovROrn4Iza7YsUEcGhJsBA2RWQtnv4PhM
	 OEPPJdzKZ+xV1bGYGNAKkCzCrzai/0LjYHPGqLH0HgBdxH6NGgnkNGmKh5YAzqA9nGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COhcGflT;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34F606A31F
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF34F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COhcGflT
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-38692f62b22so2068204eec.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443414; x=1796048214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iABdfnxFx3EmjF7ws7PA7smuift4fgOpvgTOd+xZhS4=;
        b=COhcGflTyCM45/kfreFf475KC4AC3AyTivAdiA9ls04P1yxz0v2PIFaUp8AAAa4sHf
         1JgU8p6K3QuFR9mrOnRF/7Veo330NWVidUUzg3xtoCkspqz06klRaCNRPxIh2TgONPIi
         b1p0amu14cKC4S8SeTXKSfY1Z16bVswbspGkXu67m2+f1O5FniUT/4BRWZ/APIwQ1eYK
         QXKzdGmXvvzjOchQRNBWmmJb1sJsRX4ysmUzMOa6GRb8I91akz8lGF1vhNuODV0Jag0q
         wQavLJjMHJvvbvSihhKfGXpJ5JAK75ck16AM5vE/gCxi54IsptTurZrMfMDEqpC34iG8
         JjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443414; x=1796048214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iABdfnxFx3EmjF7ws7PA7smuift4fgOpvgTOd+xZhS4=;
        b=vUQBYKKIT74gDV6RoBdvS7juuflHch0nRWbtc9x9C67u+XECbkvGXyjG5Knyac57Py
         8oE0stPBFHOS5jwWPdm+c0+7AtGDWOqhDOnVFcGQs8dcyrlBZe2l4ade3wNTwRSSd5KW
         RXYmwxxRyD834bUJjS7P3H3dkZRpc7Z/W+ki1x4ehJHkz54vKMW+1Og62x/+hMo5bS8E
         OqoqWSWNbcrR2OX2FJHOscpwfs2pdyqBLjbDxqieY9xkMA3YRTzIIyGXGMxHRJ1vSlgC
         KPQYtLSRf4oWhzf6hFgah0ODR59gjNpZs8hOgpZipKtR/jZrjQ9VVhNFjqZKWC5cfUyZ
         faMQ==
X-Forwarded-Encrypted: i=1; AL+hErHNQFYcUuBV1pvrQyxJH+I7F3GQTmDRfbBE1lwW1bEu+XdI49hc9lhkKOFMFxvyWK/I98IrjO7AbrGLtRt5+CA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l+RtRo5Lqp1/I8cysIFsFitu+2DQzGR3Oh70UTC4LXiGG587u
	qUoWkCzppGmcJOBtEO+d4dBqX1eIv33Ys6JnbJAoavEWpCG+IIUWwfiS
X-Gm-Gg: AZFdTZfGLgSQxxu000na45+qwDZGp5N+rj7qqi9p3WuSSkgLGk5c9icUoyxo65FSG1M
	d0cpRNMXkJt7e1p13ni8OyKUP75clsk7PxiZ91Be9OrxSV+ClX6Ybflq5Nyqb5WbkjquYGHx3Sv
	u7p8L27Ae+4j9fwWsBIDumGnpprw6oZ9vrEXzyYgD4ONLFbO+ykNR9RY9bMxkTcOYfWJslaBwoa
	/N+qvpd9r+K9Cmm8s86/TVvWQas3NKMWOF9Lj2k9S+693OYu7FDto55oirud3T/2LAD02TnRT7u
	4rKytsJf5ohze0nwJB9qoU4FzB4GC4Q11W/aJCbxzMCPvcxBTJCPfWq9pMV02w2eLJOVhHpIlop
	zzoYohQjC/9WcnmtC5oDQoAPp3tVit26IdElpq+sxAfT0q8ZfzCcz8crKGeqvA/1PbaaGn+r6ze
	2x4RBy/Of5uglteAFnlJVz+h5tY7ZArf1dJmubmS4YsehWkRpq8aywka8KBRHd+tRlU0Tv6Oux5
	jF8l9kwJnnaXh0of52+NjJ5ONVGLeo9H/AYiKNJPHF1JMqywDb6a+YSxa8Mk/onHDKXCIAbGrWJ
	3uKSVUKHKWLNzuFC+IcAkh9Y+Yx3rL86YqInwfIWeECPRe3+rx15kkZwHPlrtsIPGmv9
X-Received: by 2002:a05:7301:53c3:b0:380:f8fd:d19b with SMTP id 5a478bee46e88-3856fb693d7mr13310163eec.38.1795443413871;
        Mon, 23 Nov 2026 06:16:53 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b9bdafb5sm3063417eec.9.2026.11.23.06.16.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:16:53 -0800 (PST)
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
Subject: [PATCH v5 05/19] mm/swap: change the swapon lock into a percpu rwsem
Date: Mon, 23 Nov 2026 22:16:42 +0800
Message-ID: <4f355219f202e5fce9e8dac7dee75f3ea7c51d4e.1795439990.git.lianux.mm@gmail.com>
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

Reading swap metadata is a common hot path, while swapon and swapoff
are costly and rare. Convert swap_lock from a spinlock to the
swapon_rwsem percpu rwsem so metadata readers can run concurrently.
Writers still serialize topology changes and exclude readers.

Preserve the atomic writable/off-list/available-list transition under
swap_avail_lock. The device-selection and cluster-allocation paths do
not yet hold swapon_rwsem; the priority queue patch adds that allocation
reader protocol.

Also update the comments in swap_info_struct to reflect the lock
name change.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 include/linux/swap.h |  10 ++--
 mm/swapfile.c        | 126 ++++++++++++++++++++++---------------------
 2 files changed, 69 insertions(+), 67 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0fa77f5679a2..717387e16a2d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -192,18 +192,18 @@ struct swap_extent {
  * Swap device flags, except the ones documented below, all are immutable
  * after exposed by swap_device_enable, and until the device is freed again
  * (SWP_USED unset), except that teardown clears SWP_ACTIVATED after draining
- * allocators and live references. The other exceptions:
- * - SWP_USED: Protected by swap_lock. Indicates the device is inuse. Once
+ * allocators and live references. The other exceptions use swapon_rwsem:
+ * - SWP_USED: Protected by swapon_rwsem. Indicates the device is inuse. Once
  *   set, won't be cleared unless all reference to this device is freed and
  *   swapoff finished.
- * - SWP_WRITEOK: Protected by swap_lock, si->lock and swap_avail_lock.
+ * - SWP_WRITEOK: Protected by swapon_rwsem, si->lock and swap_avail_lock.
  *   Clearing this flag is followed by waiting for all current cluster lock
  *   users to exit, so
  *   checking this flag while holding any of these locks ensures the device
  *   is safe to use at the moment. Note: clearing this flag doesn't affect
  *   pending IO or async requests, it only prevents further entry allocation
  *   or new async request (e.g. discard) from initiating.
- * - SWP_HIBERNATION: Protected by swap_lock. Indicates if the device
+ * - SWP_HIBERNATION: Protected by swapon_rwsem. Indicates if the device
  *   is pinned for hibernation.
  */
 enum {
@@ -276,7 +276,7 @@ struct swap_info_struct {
 	spinlock_t lock;		/*
 					 * Protect cluster lists. Other fields
 					 * are only changed at swapon/swapoff,
-					 * so are protected by swap_lock.
+					 * so are protected by swapon_rwsem.
 					 */
 	struct work_struct discard_work; /* discard worker */
 	struct work_struct reclaim_work; /* reclaim worker */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 56b75770d320..7a97cfd8d009 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -57,23 +57,28 @@ static void move_cluster(struct swap_info_struct *si,
 			 enum swap_cluster_flags new_flags);
 
 /*
- * Protects the swap_info array, and the SWP_USED flag. swap_info contains
- * lazily allocated & freed swap device info struts, and SWP_USED indicates
- * which device is used, ~SWP_USED devices and can be reused.
- *
- * Also protects swap_active_head total_swap_pages, and the SWP_WRITEOK flag.
+ * Serializes swapon/swapoff (writers) and protects the swap_info
+ * array, nr_swapfiles, total_swap_pages, and part of swap device
+ * info content (see comment of swap_info_struct). Read-side users
+ * take percpu_down_read() while inspecting this protected state.
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
@@ -85,7 +90,7 @@ static const char Bad_offset[] = "Bad swap offset entry ";
 
 /*
  * all active swap_info_structs
- * protected with swap_lock, and ordered by priority.
+ * protected with swapon_rwsem, and ordered by priority.
  */
 static PLIST_HEAD(swap_active_head);
 
@@ -95,20 +100,18 @@ static PLIST_HEAD(swap_active_head);
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
 
@@ -128,7 +131,7 @@ static inline struct swap_info_struct *__swap_iter(int *i, unsigned long flag)
  * for_each_swap_info - iterate over all allocated swap descriptors
  * @si: the iterator
  *
- * Context: The caller must hold swap_lock. The lock may be dropped during
+ * Context: The caller must hold swapon_rwsem. The lock may be dropped during
  * the loop body but must be re-acquired before the next iteration.
  */
 #define for_each_swap_info(si) __for_each_swap(si, 0)
@@ -1309,7 +1312,7 @@ static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
 					     pages | SWAP_USAGE_OFFLIST_BIT))
 			goto skip;
 	} else {
-		lockdep_assert_held(&swap_lock);
+		lockdep_assert_held_write(&swapon_rwsem);
 		lockdep_assert_held(&si->lock);
 		si->flags &= ~SWP_WRITEOK;
 		atomic_long_or(SWAP_USAGE_OFFLIST_BIT, &si->inuse_pages);
@@ -1441,10 +1444,10 @@ static bool get_swap_device_info(struct swap_info_struct *si)
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
@@ -1529,10 +1532,10 @@ static bool swap_sync_discard(void)
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
@@ -1541,11 +1544,11 @@ static bool swap_sync_discard(void)
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
@@ -2349,7 +2352,7 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
 	int ret;
 	struct swap_info_struct *si;
 
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	ret = __find_hibernation_swap_type(device, offset);
 	if (ret < 0)
 		goto out;
@@ -2373,7 +2376,7 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
 	si->flags |= SWP_HIBERNATION;
 
 out:
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	return ret;
 }
 
@@ -2385,7 +2388,7 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
  *
  * Look up the swap device for @device/@offset and atomically transfer
  * the SWP_HIBERNATION pin from @old_type (if valid) to the new device,
- * all under a single swap_lock critical section. This closes the
+ * all under a single swapon_rwsem writer section. This closes the
  * swapoff() window that exists when callers unpin and re-pin in two
  * separate operations.
  *
@@ -2405,28 +2408,28 @@ int repin_hibernation_swap_type(int old_type, dev_t device, sector_t offset)
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
 
@@ -2434,7 +2437,7 @@ int repin_hibernation_swap_type(int old_type, dev_t device, sector_t offset)
 		old_si->flags &= ~SWP_HIBERNATION;
 	new_si->flags |= SWP_HIBERNATION;
 
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	return new_type;
 }
 
@@ -2452,11 +2455,11 @@ void unpin_hibernation_swap_type(int type)
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
@@ -2481,9 +2484,9 @@ int find_hibernation_swap_type(dev_t device, sector_t offset)
 {
 	int type;
 
-	spin_lock(&swap_lock);
+	percpu_down_read(&swapon_rwsem);
 	type = __find_hibernation_swap_type(device, offset);
-	spin_unlock(&swap_lock);
+	percpu_up_read(&swapon_rwsem);
 
 	return type;
 }
@@ -2493,13 +2496,13 @@ int find_first_swap(dev_t *device)
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
 
@@ -2528,7 +2531,7 @@ unsigned int count_swap_pages(int type, int free)
 {
 	unsigned int n = 0;
 
-	spin_lock(&swap_lock);
+	percpu_down_read(&swapon_rwsem);
 	if ((unsigned int)type < nr_swapfiles) {
 		struct swap_info_struct *sis = swap_info[type];
 
@@ -2540,7 +2543,7 @@ unsigned int count_swap_pages(int type, int free)
 		}
 		spin_unlock(&sis->lock);
 	}
-	spin_unlock(&swap_lock);
+	percpu_up_read(&swapon_rwsem);
 	return n;
 }
 #endif /* CONFIG_HIBERNATION */
@@ -2866,10 +2869,10 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
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
@@ -3007,8 +3010,8 @@ static int try_to_unuse(unsigned int type)
 
 /*
  * After a successful try_to_unuse, if no swap is now in use, we know
- * we can empty the mmlist.  swap_lock must be held on entry and exit.
- * Note that mmlist_lock nests inside swap_lock, and an mm must be
+ * we can empty the mmlist. swapon_rwsem must be held on entry and exit.
+ * Note that mmlist_lock nests inside swapon_rwsem, and an mm must be
  * added to the mmlist just after page_duplicate - before would be racy.
  */
 static void drain_mmlist(void)
@@ -3160,8 +3163,7 @@ static int setup_swap_extents(struct swap_info_struct *sis,
  */
 static void swap_device_enable(struct swap_info_struct *si)
 {
-	spin_lock(&swap_lock);
-
+	percpu_down_write(&swapon_rwsem);
 	spin_lock(&si->lock);
 	spin_lock(&swap_avail_lock);
 	si->flags |= SWP_WRITEOK;
@@ -3171,7 +3173,7 @@ static void swap_device_enable(struct swap_info_struct *si)
 	atomic_long_add(si->pages, &nr_swap_pages);
 	total_swap_pages += si->pages;
 	plist_add(&si->list, &swap_active_head);
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 
 	add_to_avail_list(si);
 }
@@ -3184,7 +3186,7 @@ static int swap_device_disable(struct address_space *mapping,
 	unsigned long offset, end;
 	int err = -EINVAL;
 
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	plist_for_each_entry(si, &swap_active_head, list) {
 		if ((si->flags & SWP_WRITEOK) &&
 		    si->swap_file->f_mapping == mapping) {
@@ -3220,12 +3222,12 @@ static int swap_device_disable(struct address_space *mapping,
 
 	end = ALIGN(si->max, SWAPFILE_CLUSTER);
 unlock:
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	if (err)
 		return err;
 
 	/*
-	 * The swap allocator doesn't take swap_lock. Looping through every
+	 * The swap allocator doesn't take swapon_rwsem. Looping through every
 	 * cluster lock after clearing SWP_WRITEOK ensures that allocators see
 	 * the updated flag and that no allocation remains in flight.
 	 */
@@ -3339,7 +3341,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		atomic_dec(&nr_rotate_swap);
 
 	mutex_lock(&swapon_mutex);
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	spin_lock(&p->lock);
 	drain_mmlist();
 
@@ -3350,7 +3352,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->max = 0;
 	p->cluster_info = NULL;
 	spin_unlock(&p->lock);
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
 	mutex_unlock(&swapon_mutex);
@@ -3370,9 +3372,9 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	 * can reuse this swap_info in alloc_swap_info() safely.  It is ok to
 	 * not hold p->lock after we cleared its SWP_WRITEOK.
 	 */
-	spin_lock(&swap_lock);
+	percpu_down_write(&swapon_rwsem);
 	p->flags = 0;
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 
 	atomic_inc(&proc_poll_event);
 	wake_up_interruptible(&proc_poll_wait);
@@ -3532,13 +3534,13 @@ static struct swap_info_struct *alloc_swap_info(void)
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
@@ -3563,7 +3565,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 	plist_node_init(&p->list, 0);
 	plist_node_init(&p->avail_list, 0);
 	p->flags = SWP_USED;
-	spin_unlock(&swap_lock);
+	percpu_up_write(&swapon_rwsem);
 	if (defer) {
 		percpu_ref_exit(&defer->users);
 		kvfree(defer);
@@ -3999,9 +4001,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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
@@ -4019,7 +4021,7 @@ void si_swapinfo(struct sysinfo *val)
 	struct swap_info_struct *si;
 	unsigned long nr_to_be_unused = 0;
 
-	spin_lock(&swap_lock);
+	percpu_down_read(&swapon_rwsem);
 	for_each_swap_info(si) {
 		unsigned long flags = READ_ONCE(si->flags);
 
@@ -4028,7 +4030,7 @@ void si_swapinfo(struct sysinfo *val)
 	}
 	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
 	val->totalswap = total_swap_pages + nr_to_be_unused;
-	spin_unlock(&swap_lock);
+	percpu_up_read(&swapon_rwsem);
 }
 
 /*
