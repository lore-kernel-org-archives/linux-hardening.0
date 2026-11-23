Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443599;
	b=r462QVm019sc8ypVZNSQGFkUSmYs9yM0+W1Wvy7HNQgS84GdEHPIlDhBQoyosiyMUdsM
	 iNv5Nbm2IfgJiG8enxeDH/Bq47x3n/AywCXuzt2S+48IdiA3ZoQCZPMbCKmiGTK5q4d8X
	 99j3XEvg17DxCE/xiVpl3uirQzW0WKWoDxAu60KIDXHOVX1V6VKWDd6bjPoPq9rxaGiNi
	 Bs3xZ6eGRIHso+NrYIMcBOWUgfrnSdLI6mNZIEVhksG9M83s24q+mmdnFyJRLGfIhJ0jL
	 KAqr+0TxpNIQfhBszSMRK20CcdWQnnP4EfQaMbb4RMU8Pud2eJ10qH4ZlEIds2crpsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y226DZkwLHV/0wLned+bdA2tSEyU1JvBKnaVWIVUoR8=;
	b=5V246w3LvCl/GWFGRI3nAmPdEMMUNE54Boe/mzGt3c0/Y98osQblwaf8GojiwyDgwbTl
	 +LuRr/lnfj8zUufz+Vb86HkmABOEsvNOHKGATTJ3BJoDJ8ZRYZgqpKVpfSydg/xhzqeip
	 HG70LDO8S87IEZ10v1tfzbKEMCOWNWYx4Nk2b63Gc6l8Kx6zgPAWRtnZZKDfMOrZuxNdf
	 nJglnm0wFJp5qTsX4evZwa7KFH4ve7wFuefnr8Gm9PBB4uIxK0LRAioSIt4RwlDD9Odfr
	 U7GqEkpOc9Wj0sBR+Umwa+xdRgBitKSsxfbpt30GOVMR7ALnTIV07ZXZoPqojZZ8U2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BkREXJ/B";
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E31606A31A
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E31606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BkREXJ/B
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so4079944c88.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443598; x=1796048398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y226DZkwLHV/0wLned+bdA2tSEyU1JvBKnaVWIVUoR8=;
        b=BkREXJ/BXiDHJyUVu9BXVhXdtOTtx2gQC44oDHvVkAnLsroA70wEVDpoiTzJkhjAbD
         hQV5IlaaajhaDZiA/u41gVg0720axesf4RBXB0p4P66LmSjkszkkT3kkJYqWQ7p7sw32
         rDWX6hpEeTUw4/JUkLhIRrTEPHpqp0xjxRsw2qRU1UK9vOTeYzHXtMjo4Jg/FiHILvNu
         d4upBmFwjoFVgR4ZRGusk0HTg/0FiJeCw+HCSUqt7DYgXc/iMhGX61CXNGGc0kOae3xk
         ZIaeHM9/tFZUezu4yLK0RJC82OXvnmgAIyEdKyGgPjn9nywBSJbw+MwDcFXsupwH5v/i
         OJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443598; x=1796048398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y226DZkwLHV/0wLned+bdA2tSEyU1JvBKnaVWIVUoR8=;
        b=HwYQ2PlOqScCHB8UXuK6TrDbDmjiJtd9fsAECuoUnItiMJXBzvlKAc5114cW6YO4Dt
         vKzUG0sV/AMvKGBCszDsJmg6oolgSRM1T+5M4T7x3Uh14HjX9uBN1C5/usTjSZEFs8lY
         0oAyCNbC4U6u34ESPA/0qhMbdJkj0KaJnXaudxWxFtr5mloKNpATC/83PkMdeOLH2syI
         3EsGjtYMFA2NRVj9cJUiUahbUAbxRUTGjC08gV5x94y/yswFQMjMHqoSWHFnFgAy2pDf
         L5cTU+wusgpig0DRy88hc7VpQ1HGLg9/Bn4Gz2kYkQTEaapi3f45M3wKULWFBoPsZrHf
         gcTw==
X-Forwarded-Encrypted: i=1; AL+hErHr+9BLRL+d67qZU6j8FapNfMjgH22FVlr/MbKooAtME5AuKv3DwnAp+qSSlId1hT/YkaWvdKipXhTES0LYJhs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+atIh1oXUjeiFLH4dzVFDkFdcpHFe5C5VeZXHehzq+8ELgdrZM
	hPpX+P9YqkPfmrPXa5ChsJnWa3oJI0qPZpf27/cruWq24Ztk7VfLHXe8
X-Gm-Gg: AZFdTZdVw4Posx7rvjymZ7MydCbVwlem6YIb8/sZtBrWoIcmQQvR8SKklkzkuAStdh8
	hcGuqdpyEchg4m7iAcFSgGKddLr85SvNcuQ+3sj3auaKsY7pVibJ8uoazWGetUbktWPmvyGhbkr
	4vP3EV55cN9T8ApfpZower7jAfzM/kpMB5TAhPUWT+TsIWlLvLsDMzCgtGrx01CScBVyv2XqLPB
	DX62pjdvt8PYnI3aMx7Y4z4cqZScKRUNkcl3TnzbQjpboJcjZh2yndv2G2n0ZJds3D0JvjXLypA
	tvDWHNocvLivod+30ykeChtphPYoyMAEyPhph/EBje3zy89N7mdZ60fe8ylqgwNDCws+L7l9inc
	mu1puxR4VqHgjm3JENBfguSIZbJ7GJHnrnDgaRSTovo1HlzNIMUNdBAtW2HLLJNyoZZ1sxEAMhq
	0LAUX0WpxHEurYOSSd7zYBRmiPz8ZIuxTqw7YFDyYu/A41yBFC9+6EfAlZDwssktBUa90KMB631
	OKTZ3D1WRKdOIKUKdK20tZ9eeFYPPwVDTUF+UDmBhchv0PFpbPyVt/KM4KNNlJbmv0CXwiYLS3v
	1tqavGQpLm4axVVKcqATc6zPUamL4H7OQIWsD7NKLOSz3OFylNJM0uDrmzQvrh506RkI6ZthDqx
	m25KWKXwSjn6OCGw=
X-Received: by 2002:a05:7022:1586:b0:199:e38c:29a0 with SMTP id a92af1059eb24-1b55690e6e8mr13031567c88.31.1795443598397;
        Mon, 23 Nov 2026 06:19:58 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm29427377c88.12.2026.11.23.06.19.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:19:58 -0800 (PST)
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
Subject: [PATCH v5 17/19] mm/swap: advance the global queue cursor directly between priority rings
Date: Mon, 23 Nov 2026 22:19:47 +0800
Message-ID: <7d2e42d489849716d6a4a3b906673959e6d9a28d.1795439990.git.lianux.mm@gmail.com>
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

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 51 ++++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0c4452fa53ae..5a8663e9f954 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -194,10 +194,10 @@ struct swap_queue_reader {
 };
 
 struct swap_queue_cursor {
-	bool valid;
 	bool no_fallback; /* Do not descend to a lower priority ring. */
 	unsigned int ring_idx;
 	unsigned int offset;
+	unsigned int nr_iter;
 };
 
 static __percpu struct swap_queue_reader *swap_queue_readers;
@@ -307,37 +307,39 @@ static void swap_queue_install_readers(struct swap_queue_reader __percpu *reader
 	swap_queue_reset_readers();
 }
 
-static struct swap_info_struct *swap_queue_get_device(long nr_alloc, int nr_iter,
-						      struct swap_queue_cursor *cursor)
+static struct swap_info_struct *
+swap_queue_get_device(long nr_alloc, struct swap_queue_cursor *cursor)
 {
 	bool rotate = false;
 	struct swap_info_struct *si;
 	struct swap_queue_reader_head *head;
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
-			return ERR_PTR(cursor->no_fallback ? -E2BIG : -ENOENT);
-	}
-	if (cursor->no_fallback && cursor->ring_idx != queue_idx)
-		return ERR_PTR(-E2BIG);
-
 	ring = swap_queue[queue_idx];
+	if (cursor->nr_iter >= ring->size) {
+		if (cursor->no_fallback)
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
 	head = this_cpu_ptr(&swap_queue_readers->heads[queue_idx]);
 	/*
 	 * Snapshot the starting offset for this walk. Other allocations on
 	 * this CPU can move the shared head between retries.
 	 */
-	if (!cursor->valid || cursor->ring_idx != queue_idx) {
-		cursor->valid = true;
-		cursor->ring_idx = queue_idx;
+	if (!nr_iter) {
 		if (head->rr_counter < nr_alloc)
 			rotate = true;
 		else if (head->offset >= ring->size)
@@ -1845,29 +1847,25 @@ static bool get_swap_device_info(struct swap_info_struct *si)
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
@@ -1882,7 +1880,6 @@ static int swap_alloc_entry(struct folio *folio)
 
 	migrate_enable();
 	percpu_up_read(&swapon_rwsem);
-	return ret;
 }
 
 /*
