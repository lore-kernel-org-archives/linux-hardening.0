Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117419;
	b=k8oTb5RPndgjSuAO7qA5qGpv+r5e0N9YaEJuoegb+zORDpLHb+b0bcJ/XnvRbAFinf5z
	 vF6Q9ib7/XXsSRNcdDe4KNVoNQkwzxxsiqgs7BWjgYUH0OZ3U6cx2Tx8FJlOBOx1tqJO4
	 hEB9RD5rGogTMlXzDQTwhpANSWvWOuWnoGIpxVhJ4sSc0PU5KoRTan8q5Q8IJEAfOsSUi
	 8H+D1rTNwoiKstwx6EDTSVbtnmpfDn5QMFoLsOkpedyXQ3D+ntFoc+np1oxKPuypHLAsA
	 xG7vQ5QRF6Mytcw2xOqeNdD/Dj4uTntp/Tg6BmOPsGVW5U5MOMViYPH2mAPnjqGRG4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K3Fc6Qd16BKiEoRWwD8fs3AmZLAKUuVGN6JC9AyRnB4=;
	b=rEb7JwpgvhstaHB/9wN7NvqvWf0XaI0QoeW8SAPjaoPRQZH+jYDm7jgZucuINKCLYK+g
	 j21UutjbE982/CEB3uEdRhcsiTgFHBia42O4v5+mXGitsrpCW2vb1z2s7d8Qe7eUkYv9i
	 GAyPVwz1Q7K69E/24tu7nrdqQCRXalMMc2kQTuHsHO8qe0nBN6aFoPGfCxMCWMmMeZU5W
	 d4nVAFUZLvnTKvS1SJPGi6jPchITCfympJZFcBgowKVXBCxquLeeYanyBRBCwb5wleKrW
	 gcZf2VMRkRubD05iHiR8C/gbVOdCmuTbxZHBXDd8qXa86w3hckUboAsA8cFj1l+lZPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HXKeQK1v;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9788606A31B
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9788606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HXKeQK1v
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8fe8e343fso26579365ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117418; x=1793722218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K3Fc6Qd16BKiEoRWwD8fs3AmZLAKUuVGN6JC9AyRnB4=;
        b=HXKeQK1vBvPm91HtcYhla53wjgB1hXvht20hvn4vwueglOYy4nGWmBZ4XP0JhRa8No
         3R0oYvJpd465TZETfmWBIjSMRkmOzHq0VSz27eAfTcuTL2FGeZqms/NNR/cM46hJdkKf
         ZV6UYPvSFt3vV7kD8Cbue3iS2HJbKHm61ykKwcTAm0V2qRjKQPu6EGRFvvHo4BFI5zSs
         nndhw2VMCVCahs6tkSJtXhfj9N0Y8wV3yaaQiA/TU4FLUw+2Cf+U6MTPihJas+5DYcul
         DIuGgNtSqY2+0LVUhty8JbO90pvcMoIVJIS6eHWF1aCSTG2yTSwy1KYPWtmwNIJHUQZG
         R2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117418; x=1793722218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K3Fc6Qd16BKiEoRWwD8fs3AmZLAKUuVGN6JC9AyRnB4=;
        b=JvYHxst3uJXf9a0Rir0gokREPNVcrM0fto8FCZ/GVwwLp9MK6SKObQr+fAlp8nyOfJ
         wNfaoaEt2PjowHogYbsUwq8NzM59huNcx81iNHusNHfAU03P1r+g4POtnaIkB5fw/PjG
         TlT//EtTt8LbqcCPXrfZtZB2Fr13df/ZZVo1qTeyX9pC5kIAqylIiblJNsC0LZZm6vey
         /5POdGE9jIjjl2X7GaXX/AcMp+wXt+MluSJUXELCRpypOoMiol/1akgtrWVp7qDqeXvw
         CeIfQOj9y/EzGUU4qaHfmIPbzGW1b37NyUndkUPaDPEReZvGAe98XT4BRCNkv0/pSED4
         xtIg==
X-Forwarded-Encrypted: i=1; AKwUvBwWdr98w8KDK00DHTEeNPrHCll5OF6/akLTIkqMN9WIbb4la4r42lxx//M/AIh0AQ3AFNERDJeuk38e1TtBoWQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCA/OpBpjO+2B5ge5eE2rYDD8zH+HKYtwPAN0VNbe0BZq+f2QW
	T1ahY+1YWGukL4E3J6mSE15PJAqVI2S/+FlreS8S0FE6A/cLIZkYN+pz
X-Gm-Gg: AYBFou2D6hmBgJwxKzCRbt8SKrkeICbQDykFxH6hSemI2Y447ddJk4UC0+ZxbRkbaPh
	264u3UuR3sABWKLO/Be7/Ru3RYNusbYj+9YVNd0VYrFeOUpOhIywfLqmIDb5Kpg8ohXe1nhzZwY
	KhHWR/9MlZkGN2jmX/zkyYQea9lQIgUYU87VKDd+IMP5KfPRBnFwt7oKP0Q9NwMh3VUO2KS/S5t
	V/xj6c8N8HQsRwwSLiXLZDp3ZuflpLmmgCCVQ6OTKgHi9BU64wJ/EwDTcURBHQwWZRU6EfuSD60
	64bP4W5hvczCFWlJyaYq322pDL6KyxhEnSGH041bvoG04uMB491vZNgGIe6L/ispkusH/6HQc2t
	nsfbE/pOoL/s8j7gFP6pceJcufmrI76LxWDX87+f5RFXjvq/lIC8RKPI3RfCvg8Q1WgRGMHRfEp
	gOUHjERMILwdQxkiEFcLNxqBqnBLnJqv/x4F+kj5uqQPTcEjxVuI6FtoSfD+5iajV+NxKylQFsY
	/J959UcGW5QGYtt2zaAyd5mBIcMndRCYaYCTSfv6wlS9RsTmuRE+kk5qRCh0pcFIfLXrQh5jOBz
	+0pRy0d98VQSYlit8j4zdp2zA9a2VhSS1N4S+9EZ
X-Received: by 2002:a17:903:3c63:b0:2e9:87a1:98b8 with SMTP id d9443c01a7336-2ea9c95ba29mr81806135ad.73.1793117418072;
        Tue, 27 Oct 2026 09:10:18 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm12213585ad.65.2026.10.27.09.10.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:10:17 -0700 (PDT)
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
Subject: [RFC PATCH v3 11/18] mm/swap: remove available list
Date: Wed, 28 Oct 2026 00:09:49 +0800
Message-ID: <485a50f467e22ab0801b0ff16f2465fc4ed8c429.1793106426.git.lianux.mm@gmail.com>
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

Pure cleanup, no functional change.

After the priority queue replaced the allocator's device selection,
swap_avail_head and swap_avail_lock are no longer used. Remove them.

The throttle path now walks swap_active_head under swapon_rwsem.
Check SWP_WRITEOK and the existing off-list state. This preserves the old
priority ordering and does not select a full swap device.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 33 ++++++---------------------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 9357a9065f37..17b8ec654ee2 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -287,7 +287,6 @@ struct swap_info_struct {
 	struct work_struct discard_work; /* discard worker */
 	struct work_struct reclaim_work; /* reclaim worker */
 	struct list_head discard_clusters; /* discard clusters list */
-	struct plist_node avail_list;   /* entry in swap_avail_head */
 	const struct swap_ops *ops;
 };
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2065e566b7a3..0a16343a5b03 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -96,21 +96,6 @@ static const char Bad_offset[] = "Bad swap offset entry ";
  */
 static PLIST_HEAD(swap_active_head);
 
-/*
- * all available (active, not full) swap_info_structs
- * protected with swap_avail_lock, ordered by priority.
- * This is used by folio_alloc_swap() instead of swap_active_head
- * because swap_active_head includes all swap_info_structs,
- * but folio_alloc_swap() doesn't need to look at full ones.
- * This uses its own lock instead of swapon_rwsem because when a
- * swap_info_struct changes between not-full/full, it needs to
- * add/remove itself to/from this list, but the swap_info_struct->lock
- * is held and the locking order requires swapon_rwsem to be taken
- * before any swap_info_struct->lock.
- */
-static PLIST_HEAD(swap_avail_head);
-static DEFINE_SPINLOCK(swap_avail_lock);
-
 static inline struct swap_info_struct *__swap_iter(int *i, unsigned long flag)
 {
 	lockdep_assert_held(&swapon_rwsem);
@@ -1652,7 +1637,6 @@ static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
 {
 	unsigned long pages;
 
-	spin_lock(&swap_avail_lock);
 	spin_lock(&swap_queue_update_lock);
 
 	/*
@@ -1672,10 +1656,8 @@ static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
 	}
 
 	swap_queue_mask(si);
-	plist_del(&si->avail_list, &swap_avail_head);
 skip:
 	spin_unlock(&swap_queue_update_lock);
-	spin_unlock(&swap_avail_lock);
 }
 
 /* SWAP_USAGE_OFFLIST_BIT can only be cleared by this helper. */
@@ -1684,7 +1666,6 @@ static void add_to_avail_list(struct swap_info_struct *si)
 	long val;
 	unsigned long pages;
 
-	spin_lock(&swap_avail_lock);
 	spin_lock(&swap_queue_update_lock);
 
 	/*
@@ -1715,10 +1696,8 @@ static void add_to_avail_list(struct swap_info_struct *si)
 	}
 
 	swap_queue_unmask(si);
-	plist_add(&si->avail_list, &swap_avail_head);
 skip:
 	spin_unlock(&swap_queue_update_lock);
-	spin_unlock(&swap_avail_lock);
 }
 
 /*
@@ -3844,7 +3823,6 @@ static struct swap_info_struct *alloc_swap_info(void)
 	}
 	p->swap_extent_root = RB_ROOT;
 	plist_node_init(&p->list, 0);
-	plist_node_init(&p->avail_list, 0);
 	p->flags = SWP_USED;
 	percpu_up_write(&swapon_rwsem);
 	if (defer) {
@@ -4260,7 +4238,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	 */
 	si->prio = prio;
 	si->list.prio = -si->prio;
-	si->avail_list.prio = -si->prio;
 
 	/*
 	 * Publish swap_file before making the percpu ref live, then add the device
@@ -4409,14 +4386,16 @@ void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
 	if (current->throttle_disk)
 		return;
 
-	spin_lock(&swap_avail_lock);
-	plist_for_each_entry(si, &swap_avail_head, avail_list) {
-		if (si->bdev) {
+	percpu_down_read(&swapon_rwsem);
+	plist_for_each_entry(si, &swap_active_head, list) {
+		if ((si->flags & SWP_WRITEOK) &&
+		    !(atomic_long_read(&si->inuse_pages) &
+		      SWAP_USAGE_OFFLIST_BIT) && si->bdev) {
 			blkcg_schedule_throttle(si->bdev->bd_disk, true);
 			break;
 		}
 	}
-	spin_unlock(&swap_avail_lock);
+	percpu_up_read(&swapon_rwsem);
 }
 #endif
 
