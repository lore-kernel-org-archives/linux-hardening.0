Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667957;
	b=WVzE0NitMd6tobsLNOVp0ZQF9lZ6TszrxuirrxUiAwawS+Kpwv7OYKFKo/LiJwGUQ7Wt
	 fIoQ44tuu/VGXJVdBLwiVG2mgtLLzo1n3pXv+VEIeX+aK5Lvt8lQLS+aziCS5nEM96IyF
	 n3JkMwPbYnrW+2ICItyeTx9PgqssFQJJzqdf4al9FBJPe7Sf5TMVfvGGQLtifz6G9LH/o
	 3zSvoM8CPs4HxyWk+2qOPdxf/jmyNUkJhx37yvHwEkCoeNlFMDIMqzgfW7p/yVcg5kA4U
	 13o2gKELSBQB1s1NSxXOMUlNNHFVhV7vYMBq2FEtPESygDSWpEJAFtg05a+MArWQGWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A3QqAYG/uE4i1SkonwP/uDxgDXolAyrEYNmgqxrP7PU=;
	b=cnJY5J2/U3wJgHgrI3IQQqJjCqKRNSxn4JawN/MYZmfmypGIaQ/yKZioL4aZsNZ7jzpv
	 q4wjHZQ5Fsph941ViqXlLSrz3HabYudNejp2bXub0ZXmhbYnSxZN9zP4qfRk1pQj051kn
	 EXdtA+syKmUJW+7+DelZyzH+wIxNr2hFSWYrAPOmR1KEdc7ldi0nFn3r26xbvNHIgx8vw
	 BuLGAONAPOKF/kATqy8PeL0LQ3SJ8foKSRU2EWs5C9qxoJvyEbPacoSJri+T9ImAQsBVf
	 Q7Ib2n5tuM5eYG/sbCA76+xqLjOWI9omvMt6A9vDDaIg4fRcJtTWiWp7BfJEFz/K8ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydcwPZto;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF6606A890
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57BF6606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydcwPZto
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ed28bac8d7so8569955ad.0
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667957; x=1795272757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A3QqAYG/uE4i1SkonwP/uDxgDXolAyrEYNmgqxrP7PU=;
        b=ydcwPZtohhbdg6yll3aXSA8PehfsJqyNMMy6Iaxzri/DJOz5kNXICNfBYDcjmz5aQy
         qk+Zsl/cgTwaACFiZj/Ceq4m9QMM7y/gkGD5OJ9KyNxVidtBHPJx8oDN0DApr79fpg12
         42Q4enSzZSuwRHIiGzABFK7Khq/NV/9dyMs1AxIfyWQv1w3b1gGf2JrnqLLBHqfAbWaG
         IlcFbTuHzNUxyCr4coxiYZwcJ7RyD4iUG9BGtzzRD8q1PjnMGE7odWk3GvwPLUkS7hbF
         sFvGmfV1MnA1FkGC4GSZscxPeF2FRhskyQp+o267R++ZRQzPd4N1Oz6Y8kDmhLWQiMzV
         IHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667957; x=1795272757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A3QqAYG/uE4i1SkonwP/uDxgDXolAyrEYNmgqxrP7PU=;
        b=k+kFf28/bfh/RFEFSDjdDdRlTcsgTYUB/aVtuwGq1SuY64oBO5SQvGqk2QhR91WaXg
         PN5xemii1In3O7kMeuyGRhWX7bpiKBCKlg/d80x4+qhsWEWC+B+fHE+eqLc5vLMpAHQY
         1ioiCadBKgs6rROphUaXpG39jwCkIdjgh+cE3/cDU2B0UQzcRoLASfAjeb8j2BvXJR1c
         RugahBCS38ylEqkYUlOO4DllnumSJL9FyGdoKrhlbdNQDGyLlWciPu4Ayvx3VpJMAWpE
         i3cqbsaqaLrjznkkPysq7ce+wZPSeKFVsMpgxObynFWWJGRxZDk6O1pM+0En2NoIw4WR
         ikZw==
X-Forwarded-Encrypted: i=1; AL+hErHZhxU1iKqVUQongXKfxMu0UZS/B+1ZBCF6s8EZSRhHlZUJQJkudf77H1lWz0pQSfb12hXxH5N/aV/eJVKzmuM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/rafU2WiNc7+B5GulmNb6ef9Fl/7peVQOgrESBjlu+0KBg26C
	v1JHCAsmjsCwPQjKdCdG30vdplsZRdDb/+8aKa3rCluNyCU+z7rOEPZx
X-Gm-Gg: AYBFou0+Ucelz5kwHT/lLF5z+6iHWcGUPNfd10PRhxfIZnTcclFZ0GXW3PBrKS6HfFb
	i3Yc6puGDVdibrbz2aLoA5hyv5qkIhB4sTanIQ9oGFgAfK3Vy56wTOoZUJaeACCvObY4qNQ1bWp
	yB5MVD4yU4w883+BEe6GeGHc8NBRf+xpyH43/Hi5mfeGeX1ohMW70hD5EnwRXiP9+xKwXnGwVqA
	QaPxVjThM0GwOix2G9Rh4iavF8bZogNHdw1drme//wKx90uolrUISRy1JN2ODGzTEx8AC2exsrl
	arACmbapc7OdHWn8KOFTnhWA1cUSaSTjYR3uvznXSfEItAhmYruxpqKaCb4cTWVYLGpMA9Fmvd6
	FvHNl3BU/N8ZbDFrd45KaaO02ndJw+NApmvcjROYHpV7Yd0jqi4Nk7j/9Z/nrF5hZBI8DMKvAmw
	NkuXKS+CverOKodwVzBsogIitQYzXRyp/4k0JxlgvdBTvxma6Qzpa+tLOWU86e7Gf1MwBUa3M1S
	rTEPI9UkjqvrKj40YPbAaiseE19Vvtv6FRVPC/tgv8I9cHSUanHfhfaXVfXEnedWGtNOkQTjdxK
	MXE5FpqutYe04sDaUQzTUepNCxUYkN3wVV9GeIoqsgvnO1jnbIBzxt2DlFrfxMT56bQd
X-Received: by 2002:a17:903:11c6:b0:2e6:f3ed:a551 with SMTP id d9443c01a7336-2ee0dd2a28cmr41758785ad.8.1794667956678;
        Sat, 14 Nov 2026 06:52:36 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f862426sm22028765ad.46.2026.11.14.06.52.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:52:36 -0800 (PST)
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
Subject: [RFC PATCH v4 16/18] mm/swap: advance the global queue cursor directly between priority rings
Date: Sat, 14 Nov 2026 22:52:27 +0800
Message-ID: <e72074ac198130494037e80655685cf25ff4bb5b.1794666741.git.lianux.mm@gmail.com>
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

The allocation walk previously passed a total retry index to the selector.
Each retry translated it back to a priority ring by scanning from the
beginning of swap_queue. Keep the ring index and the number of attempted
peers in the task-local cursor instead.

Snapshot the starting device only on the first visit to each ring and
advance each peer exactly once, including masked entries. Preserve the
large-folio same-ring boundary and the stale reader-offset correction.
The selector's complete walk is linear in the devices and priority groups;
device cluster scanning and availability updates have their own costs.

Keep the topology read lock and CPU migration protection across the walk.
The global selector uses only existing priorities and adds no per-memcg
device-selection state or ABI. Existing swap charging and limits remain
in folio_alloc_swap(), whose failure path classifies allocation errors.

The walk no longer returns an ignored internal error to that caller.

Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 51 ++++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5e5c1aef010f..616339c5ae5b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -195,10 +195,10 @@ struct swap_queue_reader {
 };
 
 struct swap_queue_cursor {
-	bool valid;
 	bool ring_only;
 	unsigned int ring_idx;
 	unsigned int offset;
+	unsigned int nr_iter;
 };
 
 static __percpu struct swap_queue_reader *swap_queue_readers;
@@ -308,28 +308,32 @@ static void swap_queue_install_readers(struct swap_queue_reader __percpu *reader
 	swap_queue_reset_readers();
 }
 
-static struct swap_info_struct *swap_queue_get_device(long nr_alloc, int nr_iter,
-						      struct swap_queue_cursor *cursor)
+static struct swap_info_struct *
+swap_queue_get_device(long nr_alloc, struct swap_queue_cursor *cursor)
 {
 	bool rotate = false;
 	struct swap_info_struct *si;
 	struct swap_ring_iterator *ri;
 	struct swap_prio_ring *ring;
-	unsigned int dev_idx, queue_idx;
+	unsigned int dev_idx, queue_idx, nr_iter;
 
-	if (!swap_queue_len)
+	queue_idx = cursor->ring_idx;
+	if (queue_idx >= swap_queue_len)
 		return ERR_PTR(-ENOENT);
 
-	queue_idx = 0;
-	while (nr_iter >= swap_queue[queue_idx]->size) {
-		nr_iter -= swap_queue[queue_idx]->size;
-		if (++queue_idx >= swap_queue_len)
-			return ERR_PTR(cursor->ring_only ? -E2BIG : -ENOENT);
-	}
-	if (cursor->ring_only && cursor->ring_idx != queue_idx)
-		return ERR_PTR(-E2BIG);
-
 	ring = swap_queue[queue_idx];
+	if (cursor->nr_iter >= ring->size) {
+		if (cursor->ring_only)
+			return ERR_PTR(-E2BIG);
+		queue_idx = ++cursor->ring_idx;
+		if (queue_idx >= swap_queue_len)
+			return ERR_PTR(-ENOENT);
+		cursor->nr_iter = 0;
+		ring = swap_queue[queue_idx];
+	}
+
+	/* Consume masked peers too, so every walk remains bounded. */
+	nr_iter = cursor->nr_iter++;
 	local_lock(&swap_queue_readers->lock);
 	ri = this_cpu_ptr(&swap_queue_readers->ri[queue_idx]);
 	/*
@@ -337,9 +341,7 @@ static struct swap_info_struct *swap_queue_get_device(long nr_alloc, int nr_iter
 	 * iterator can move between retries, but the cursor must visit every
 	 * device in the ring exactly once before falling through.
 	 */
-	if (!cursor->valid || cursor->ring_idx != queue_idx) {
-		cursor->valid = true;
-		cursor->ring_idx = queue_idx;
+	if (!nr_iter) {
 		if (ri->rr_counter < nr_alloc)
 			rotate = true;
 		else if (ri->offset >= ring->size)
@@ -1847,29 +1849,25 @@ static bool get_swap_device_info(struct swap_info_struct *si)
 	return true;
 }
 
-static int swap_alloc_entry(struct folio *folio)
+static void swap_alloc_entry(struct folio *folio)
 {
 	struct swap_queue_cursor cursor = {};
 	long nr_pages = folio_nr_pages(folio);
 	struct swap_info_struct *si;
-	int nr_iter, ret;
 
 	percpu_down_read(&swapon_rwsem);
 	migrate_disable();
-	for (nr_iter = 0;; nr_iter++) {
-		si = swap_queue_get_device(nr_pages, nr_iter, &cursor);
+	for (;;) {
+		si = swap_queue_get_device(nr_pages, &cursor);
 		if (IS_ERR(si)) {
-			ret = PTR_ERR(si);
-			if (ret == -EBUSY)
+			if (PTR_ERR(si) == -EBUSY)
 				continue;
 			break;
 		}
 		cluster_alloc_swap_entry(si, folio);
 
-		if (folio_test_swapcache(folio)) {
-			ret = 0;
+		if (folio_test_swapcache(folio))
 			break;
-		}
 
 		/*
 		 * For large allocations, try every device at the same priority,
@@ -1884,7 +1882,6 @@ static int swap_alloc_entry(struct folio *folio)
 
 	migrate_enable();
 	percpu_up_read(&swapon_rwsem);
-	return ret;
 }
 
 /*
