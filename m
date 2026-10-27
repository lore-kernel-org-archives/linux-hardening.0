Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117255;
	b=3X4248pRD58sq4kTK6n2q/Va1tOgec0aaPU6h7e+IxYzKgsMxDE7sOGIw1TgZifQXAsE
	 W1VGKomIEjsBnk/tl0KC1ZrdyDnBijQ4fzLhiBOn3Co8K7pDlkJMjFGufeBUCaDXmudHi
	 UzPs8UkLyye7li0i2jgaiSmlzIAqYa+mm9CRF7XhWm71fvsdkmsyWcGswmb8hotDRAjd/
	 +JeKu8sO31xzcg7vFZh8bN2+djiXU2jzQICQM3BpYQgUo9dWiIMl4qbiqhblikDhmoBzn
	 FVTn8iSoHpZXMguA18NczahX1L/o+xUwIQFPkaU7YbZBjI5k94i8zeKaSfAz1dBtTpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gSD8mQKziZ5iG8e21wmE1nbLrwweoqqmHmBdVdKDScI=;
	b=nSTXgYCKH5zvXtv6ilveX46loYqinjNTrD7e7eBYQU/Zss6vBsPwBnaQdu+rtt4/b8Tj
	 7L3tVuJ87oN0/XeehCtG7L7Lr9sXknvPiT8j/AFq4nj/oxL4MQ8twSPYKLjh5lUScf9lw
	 Xg7W0KySAlqp0YIhp8SGexwMtDj2pLnPx9egSuZJNz/1mXlxpPDZgYgtB18zkcnVOXrIs
	 8prMc02OLC97FOF50glgQ3eFx5OLmVyreeyeGF41O7e8uI4d++5taEz9htcQ4/9mT1Jjb
	 06vuckwK3jmeEX9dkH+9+fGDJEpS+bPS1IjH9eYJtk3VowupdgvAh78qJNz4b+NQzxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhmII25F;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2572606A31B
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2572606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhmII25F
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea138a3497so28198805ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117254; x=1793722054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gSD8mQKziZ5iG8e21wmE1nbLrwweoqqmHmBdVdKDScI=;
        b=lhmII25FoXT/m8Z3PIUcB21QXxYXr9FjxGaD+4cdOLMdtkqXyummPmszQB0vZqKIId
         IBa/qpo8M+ZpT6mW1bwhUkpzmY0DZyXqjMpn3VML3hiyV0EIvOkRkBiQ+dRfiPUIviCe
         9fhTp9vG1x0g5UXwLu3+mj1n3iprRCvPdndqYOtMNgD3SzY/xfTn2qcpJfQNAe1GgMPk
         69Rx8AaUYAnWoe6l7gS4fDyHlfr1kQJhBTxFRB+XrLznl2QusSJmzKZUPP5hprJx+Cxr
         iUsWAtJoxUHwjyvRHRbltuOn0bPLgZJlCLh7/xtlR0yT6DibYxMrjbRgECtTK0HIysuT
         Zwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117254; x=1793722054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gSD8mQKziZ5iG8e21wmE1nbLrwweoqqmHmBdVdKDScI=;
        b=b2fmiOSWH7O/bNH1fRqugrAqxXzihy3GjQCMG/kGUublviO7IyXej7i28xUZYacFgk
         GIh+tsfRO9KZ4tWZh3e2u+FnacaJqkp5XoBPpEEXxvGT21nYKDHbwtI0Arx8r4eAIUhF
         +9czPAIWLy42stPAS4n9tXr41ffw5e/LHOaM4IOso+sXzUJfjJi0Toq6dmtyLThkX8rN
         vCkGds16DJakrdm9+AsqOvO9IaH9jiukxhomsQOGLg3r8PLHWJs3Ez2ID+oJ2JgKVm1B
         oKfAnnJwgMPtTToiO/nv3pX/UGMDqgDUWAZSTDK8Dp1iNB4FxIRJiKLeez4gz9Ep6c+5
         Xkzw==
X-Forwarded-Encrypted: i=1; AKwUvBwympHk8BX4EZpwkPXdV8y/Se2LxIl2OqwBrag14o4MlTurXdmIAEAjNoDalJPcZk1h0bXwbpmgi5eAlvGQYbM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFqi4RD6HoVffebBWeWPGupjkNJ/QR/VleSPeJVw0dnUqvtplA
	AI3VTQWEDT3GmEWJozpGK/RuJ+HzdaS4GmDue2e4MriVVMq/VeJvf6aDGJhkFg==
X-Gm-Gg: AYBFou3fX2TsgMWjesnSCwrBwqMcE2B4g1/88hZbV7WVW6gc5byq4WsPxktAfg2YMIT
	v0VMaPDjiHbRUnBvFcxfOju2MAv0wWoW7QDY7eOLH5UcBeXD0jtl0H6YmPDvJ2K+8zqK+ktKLYd
	WNAaWMDyQK/GkFflY/1FnO/2zg2q7FpK5b1Z6f7zUBKyWHyir7tJz87/zQQmopAI90VAA6leGCv
	pjsaoxGIDxctbrlU8JHr791ja/wAErI+QO1PQcTDuT+kBm1KazTOZYcvR8venwLRlT7Jw45G0Ba
	QVvMnXzMHkAiIntSawdx5/jTkVbiRA7SX1z/buryvkX8PAnDGUTQfAlTxX7lhLZFekk10YLWZwe
	eob+TKyvtI9HfovLBl7n83p7xBXJLqy1npOnpwKFDUxta0w/QY6A72xeZHWwiY+VdFgHwL1UqqY
	6attGcG15Lyl/fRzbAtuR0WyVErnh3FVL4F112EkJeLa8KOZyplWAq2Sf9XLzxHI1bMJR+mcyDs
	7/syR8Gu6KHhSjRLB56FKsn4u+8FvSCBILrCJQUugecbqks1ly1z5tv3Zrz5p4lODKZcT+Dyvch
	NNXNWa+kFzjWhIWSevVWfIz0YclQs0AgOTvIuGutDmndNKwfERuggT0vWYTeK6rgfzUQ
X-Received: by 2002:a17:902:e807:b0:2e5:54c6:e5c9 with SMTP id d9443c01a7336-2ea9c0c8abamr89571955ad.2.1793117254204;
        Tue, 27 Oct 2026 09:07:34 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6453e90sm12368675ad.1.2026.10.27.09.07.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:07:33 -0700 (PDT)
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
Subject: [RFC PATCH v3 07/18] mm/swap: consolidate swap inuse accounting helpers
Date: Wed, 28 Oct 2026 00:07:09 +0800
Message-ID: <b4951109ce21e1b53e4f339142ffa15b9b0980c6.1793106426.git.lianux.mm@gmail.com>
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

Inline the swap_usage_add/sub helpers into their only callers and
rename the callers to better reflect what they actually do: track
per-device inuse page counts.

No functional change.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 64 ++++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4c10e4a2d9b3..c531e0c45073 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -49,8 +49,8 @@
 #include "internal.h"
 #include "swap.h"
 
-static void swap_range_alloc(struct swap_info_struct *si,
-			     unsigned int nr_entries);
+static void swap_device_inuse_add(struct swap_info_struct *si,
+				  unsigned int nr_entries);
 static bool folio_swapcache_freeable(struct folio *folio);
 static void move_cluster(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci, struct list_head *list,
@@ -992,7 +992,7 @@ static bool __swap_cluster_alloc_entries(struct swap_info_struct *si,
 	if (cluster_is_empty(ci))
 		ci->order = order;
 	ci->count += nr_pages;
-	swap_range_alloc(si, nr_pages);
+	swap_device_inuse_add(si, nr_pages);
 
 	return true;
 }
@@ -1300,53 +1300,36 @@ skip:
 }
 
 /*
- * swap_usage_add / swap_usage_sub of each slot are serialized by ci->lock
- * within each cluster, so the total contribution to the global counter should
- * always be positive and cannot exceed the total number of usable slots.
+ * swap_device_inuse_add / swap_device_inuse_sub are called within cluster
+ * update critical sections and serialized by ci->lock within each cluster,
+ * so the total contribution to the global counter should always be positive
+ * and cannot exceed the total number of usable slots.
  */
-static bool swap_usage_add(struct swap_info_struct *si, unsigned int nr_entries)
+static void swap_device_inuse_add(struct swap_info_struct *si,
+				  unsigned int nr_entries)
 {
-	long val = atomic_long_add_return_relaxed(nr_entries, &si->inuse_pages);
+	long inuse_pages;
 
 	/*
 	 * If device is full, and SWAP_USAGE_OFFLIST_BIT is not set,
 	 * remove it from the plist.
 	 */
-	if (unlikely(val == si->pages)) {
-		del_from_avail_list(si, false);
-		return true;
-	}
-
-	return false;
-}
-
-static void swap_usage_sub(struct swap_info_struct *si, unsigned int nr_entries)
-{
-	long val = atomic_long_sub_return_relaxed(nr_entries, &si->inuse_pages);
-
-	/*
-	 * If device is not full, and SWAP_USAGE_OFFLIST_BIT is set,
-	 * add it to the plist.
-	 */
-	if (unlikely(val & SWAP_USAGE_OFFLIST_BIT))
-		add_to_avail_list(si);
-}
-
-static void swap_range_alloc(struct swap_info_struct *si,
-			     unsigned int nr_entries)
-{
-	if (swap_usage_add(si, nr_entries)) {
+	inuse_pages = atomic_long_add_return_relaxed(nr_entries, &si->inuse_pages);
+	if (unlikely(inuse_pages == si->pages)) {
 		if (vm_swap_full())
 			schedule_work(&si->reclaim_work);
+		del_from_avail_list(si, false);
 	}
+
 	atomic_long_sub(nr_entries, &nr_swap_pages);
 }
 
-static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
-			    unsigned int nr_entries)
+static void swap_device_inuse_sub(struct swap_info_struct *si, unsigned long offset,
+				  unsigned int nr_entries)
 {
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
+	long inuse_pages;
 
 	zswap_invalidate(si->type, offset, nr_entries);
 
@@ -1368,7 +1351,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	 */
 	smp_wmb();
 	atomic_long_add(nr_entries, &nr_swap_pages);
-	swap_usage_sub(si, nr_entries);
+
+	/*
+	 * If device is not full, and SWAP_USAGE_OFFLIST_BIT is set,
+	 * add it back to the plist.
+	 */
+	inuse_pages = atomic_long_sub_return_relaxed(nr_entries, &si->inuse_pages);
+	if (unlikely(inuse_pages & SWAP_USAGE_OFFLIST_BIT))
+		add_to_avail_list(si);
 }
 
 static bool get_swap_device_info(struct swap_info_struct *si)
@@ -1994,7 +1984,7 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 	if (batch_id)
 		mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
 
-	swap_range_free(si, ci_head + ci_start, nr_pages);
+	swap_device_inuse_sub(si, ci_head + ci_start, nr_pages);
 	swap_cluster_assert_empty(ci, ci_start, nr_pages, false);
 
 	if (!ci->count)
@@ -2935,7 +2925,7 @@ retry:
 success:
 	/*
 	 * Make sure that further cleanups after try_to_unuse() returns happen
-	 * after swap_range_free() reduces si->inuse_pages to 0.
+	 * after swap_device_inuse_sub() reduces si->inuse_pages to 0.
 	 */
 	smp_mb();
 	return 0;
