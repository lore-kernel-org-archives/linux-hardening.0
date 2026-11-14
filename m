Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667885;
	b=PuElCDmQB5YNdeyW85dY+8QUAwiX7Gz4luc/9BkLb0PgHpG+nxszj5xaInZgZHG0Yo3h
	 BvsSnj9H1YeXjZuWo8GpPdy28eSKmxFRpsHULMNWxXtDrhwetM5hhs+X66C1WZtn7CQYK
	 3oOT51F6Io/MWy850hCTLlou91lmlCkhZYaSKlJh/Tok/u5v6D8TPJk7B21ssD9XEPA2X
	 dnU31oIIIZ7T9FyjlwQhMHCnADQ+JFiXKByH8PwiXpiduF1LDcvTgJvozd9ccVBCiUWAW
	 ZF0aLAoq9ZK3myRJLa6TYLvwyv3mkbc2rp0IDxOafjC8fEQmFZvrfl0EeVeWvxm47tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UJ5F+HaNH4ZBPeQoxzjH5cK/wA3ysLS4ghrprv5+TaM=;
	b=xh1W+Z75AP8LyYSL9dk6g1/JQwUn5xtOlpCHq/c2kz/s2AJirw+foN8sgJF0tQlIKROg
	 LBFOxMQI3EKeC+MoA8wHf7d7ihGZNc2fvPagRu+Kgii3K+tm8wEb9+k9YD4sZeqR4N3eP
	 42jRuVfFVABDYGoUNE1zBwYrekKV2GO7fZSyyn5c5oTv7nEgdLAHkB8SXaYETkxLXq9HW
	 7vGxOrMcrHKgCiCNW6iykSrcBQQuOSQSVFHVszKO3m0XM65sYXc6LJcwU9jdF8y33gCMo
	 jQdazNIGByGeF5qAuhFXJFxhzG+dtQYUUJMQP+4ucAoTpIF+pymQBumSLb4dgaOPsww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dGkNxRVU;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D7606A32D
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D48D7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dGkNxRVU
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed28bac8d7so8561335ad.0
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667884; x=1795272684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UJ5F+HaNH4ZBPeQoxzjH5cK/wA3ysLS4ghrprv5+TaM=;
        b=dGkNxRVUdtRyIQOGoqyZzwhGBsDZ7WX7Dnw1i1Uvzwo7LnwDRSyMpgL9xuKQAq1d0c
         dqAAInek1wNFPbnEu7k9rev1XK7p5S7DrM8VARbyF76a1eCzClLeJlvzdyIwR1pdi+cc
         J1JWQS00R6Qkqk/49gdggpeg6dLyVGSF4XOs3D/EbkbARR6anJfntOSRSoimdit20gou
         i/L4BZYxawdEi7WhRGD/zbhBlTrGGslz28oOTPriRmv8NTG1ku99NyugpNbetHuKShX9
         BAdn+g3jTff1am/zzoqoXYaQdd+PuPBjDosMvzysFFXyWt4njCKVrGW57YTGbWz7O48B
         f/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667884; x=1795272684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UJ5F+HaNH4ZBPeQoxzjH5cK/wA3ysLS4ghrprv5+TaM=;
        b=2RDu8avQJAw8bj7SzG/6XrsESpxr7ppWrgcvge8SdgTPdRZPHOy0B4YU4lGLdNccTS
         uTfdhkhZZ5j8kg+FCSqAqABYkBGO49nhiuLcFH/glmVeP+bZE3nzfaFbris3GPTu/jUt
         UBTLAtxCQvYT8dkah3w7gH4X+IfbBFsAtU7/mjOCKdJHIpxLvcSTFE6Yb4nPF/lj+ywc
         Fb67vxxCMdduk/XtRyOWArp5TB4YvY34EYRFSTUWjl+dPQRNs3jpNdI6x9eMtAEv/dpL
         NPyelUs2SZmM8SeTv/3aJemujCyxSFw2zuJ4zkJa4wJQTtaDXPNXHmHZ5W26HFgagHxr
         ieLw==
X-Forwarded-Encrypted: i=1; AL+hErEeL+h+AGY5h6MfhYL3c4Btlk04GuPU2E+b1Tsmk7s2kDE2OZbG15r3MDhfWNKUyFVO5MQBIwsDDepj02quZmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1gQScylOgL5B2tjnIu9SsUxKobl+cO2cCtBiksEAMEixwa/D5
	38EJQ702cRkjdpSwB7KZXNA9zxx2veJh/3znmcamirA/XKqT131cI9oi
X-Gm-Gg: AYBFou0J24+O/QIJ1eLdzfMgK5ezas1wwi5t73tUC7V99QYLpCIrTSzJ2fTUXKsBphm
	v7jQhnapPI4mcyLd6LODfo9poiGmGZ4T8kSWIjSTHeEZ5uDa+aVd2h7FVdatqFv05JWyVyVn6Vx
	6h0f0XxwPkqYswLHjF3kNWHYjDVRVtbYUDeneiOtRk295v+Ci+UPPJzRZ9jxqmJcpGcWJ8eD2H0
	ROWBfGoNdAf3riRBWptQJJJj4xsqgvf8TaoG9O9xsD4xwi/n3GLmptoD2pgg4can7wjRBQLgTcx
	aJJPQIrm3zr9tc2yCEEnJy+V5Oojd/Uzj466g2kgnFCca2TOu8/AwK7nWRZmsfQu6dHB1D4W1JH
	qkS0R29Ur/I8So79U0yOWRIzgC0JWjMtJFmuSlHBwWS8jhQnJkDywFLKyPOH7HtewmM1l+FaEx9
	8k3U2D3g4AXRgJJMMtF+Ox/uIiBvzz73oY8bJyVsHyr9VLUzlH9cRQQAY3RSUcks7oE++61qe8B
	WAqTz5hhFFDCXz/i8cmFclC3PwoONGC7GF5nMTIFuwuuznaDGKOz8t7TQvWTuJ7uZ8OESBplMQi
	eFnOFjlL5iMJBb31nkAgmGw2FqI4mK93pyAy6QOopuAcnTxN5XiOKij2+ZRdXsHR8y1U
X-Received: by 2002:a17:903:15c8:b0:2e2:d3ef:125 with SMTP id d9443c01a7336-2ee0d9fcecbmr38203785ad.5.1794667884113;
        Sat, 14 Nov 2026 06:51:24 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f874871sm21105465ad.54.2026.11.14.06.51.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:51:23 -0800 (PST)
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
Subject: [RFC PATCH v4 11/18] mm/swap: remove available list
Date: Sat, 14 Nov 2026 22:51:14 +0800
Message-ID: <3bb9571ebf783db7a86a0ee2e7b00883c1de850b.1794666741.git.lianux.mm@gmail.com>
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

The allocator now selects devices from the priority queue. Move the
remaining block-cgroup throttle traversal from swap_avail_head to
swap_active_head under swapon_rwsem. Check SWP_WRITEOK, the off-list
state and the backing block device to retain priority-ordered target
selection.

Remove swap_avail_head, swap_avail_lock, the per-device avail_list field
and their maintenance now that no consumer needs the available plist.
Queue masking and the embedded availability state remain serialized by
swap_queue_update_lock.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 33 ++++++---------------------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6f32de173fb9..d31f3f023d36 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -289,7 +289,6 @@ struct swap_info_struct {
 	struct work_struct discard_work; /* discard worker */
 	struct work_struct reclaim_work; /* reclaim worker */
 	struct list_head discard_clusters; /* discard clusters list */
-	struct plist_node avail_list;   /* entry in swap_avail_head */
 	const struct swap_ops *ops;
 };
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 21d27da95898..5c5e449e9da3 100644
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
@@ -1713,7 +1698,6 @@ static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
 {
 	unsigned long pages;
 
-	spin_lock(&swap_avail_lock);
 	spin_lock(&swap_queue_update_lock);
 
 	/*
@@ -1736,10 +1720,8 @@ static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
 	}
 
 	swap_queue_mask(si);
-	plist_del(&si->avail_list, &swap_avail_head);
 skip:
 	spin_unlock(&swap_queue_update_lock);
-	spin_unlock(&swap_avail_lock);
 }
 
 /* SWAP_USAGE_OFFLIST_BIT can only be cleared by this helper. */
@@ -1748,7 +1730,6 @@ static void add_to_avail_list(struct swap_info_struct *si)
 	long val;
 	unsigned long pages;
 
-	spin_lock(&swap_avail_lock);
 	spin_lock(&swap_queue_update_lock);
 
 	/*
@@ -1779,10 +1760,8 @@ static void add_to_avail_list(struct swap_info_struct *si)
 	}
 
 	swap_queue_unmask(si);
-	plist_add(&si->avail_list, &swap_avail_head);
 skip:
 	spin_unlock(&swap_queue_update_lock);
-	spin_unlock(&swap_avail_lock);
 }
 
 /*
@@ -3910,7 +3889,6 @@ static struct swap_info_struct *alloc_swap_info(void)
 	}
 	p->swap_extent_root = RB_ROOT;
 	plist_node_init(&p->list, 0);
-	plist_node_init(&p->avail_list, 0);
 	p->flags = SWP_USED;
 	percpu_up_write(&swapon_rwsem);
 	if (defer) {
@@ -4326,7 +4304,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	 */
 	si->prio = prio;
 	si->list.prio = -si->prio;
-	si->avail_list.prio = -si->prio;
 
 	/*
 	 * Publish swap_file before making the percpu ref live, then add the device
@@ -4475,14 +4452,16 @@ void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
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
 
