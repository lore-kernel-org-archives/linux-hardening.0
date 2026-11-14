Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667826;
	b=rX9kmowbZEREAAzKPXkNgcqXQCrkejJ2rB09f8W4LnvtBB9FNS8tjV24hiiRjhZOqZhv
	 dQZOHxR4Y/8Q1IF8qAtJmeImO/BFLH2+fqT78J52avGZ4+ynCa1LKH6PROEDlihr6cww3
	 HYB2N9wldpcno62DgDqmKLz6Lz+g3mTVR6/1fCP5sBFI8xKCJmcgoXC/6Sj9dcsY0swia
	 q5gOPtEPZimQ/FzB5TwGbap8y1tEA5haJ2rQlbxEYmnSLeaxMrLieSlfXYPBrL53fyBnG
	 wJ1xoTc3aJitAI+KtYF4iqy2Wi9+DBQMJuxTBvHVzh18iARZpJlcsLppQJOAN4RiPyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lJc/y2I20WRTL00Fzg1UskbrU2jIAE41tHgcdSdOm3s=;
	b=V8zdE5qLOAiiEp45VwyWYCg0L03vfeL16cuD2kDUs9z4Q9btsgsJgQDw/TJwfjVJIvZn
	 F1wiDgr2myI5r4CtmRF3Q3xWlh0IZdmsoRcSrUIfSDkK7FeAwPqxQOjcaWNnDh3kxKMe1
	 GYqmFwDDheiTQIhBc2wSPzRo9EcOWMVWZkGcEK5djFm35mOjD+e228yBN8o73C/884L/8
	 DCWdpwInCPTlnPTi2843uZxlZuPXmGP+5ru6RQ9Qpb8IhK5xrYsMytyVoUSVJdQKw9rNW
	 tqLjIq/OUL2Wfva0qoFjPCtvpa1Jyyb+ZH7jnSYacT93o+KqDu7aWoPqxCvwBcXOw5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xLLkAUJD;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48D606A329
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E48D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xLLkAUJD
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9ae391a05so11122515ad.1
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667825; x=1795272625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJc/y2I20WRTL00Fzg1UskbrU2jIAE41tHgcdSdOm3s=;
        b=xLLkAUJDTDHEJoQHpNIrdy+PoX6LRe/m728FqSwreaZ0iOP3sWX7Xax9U+Oubfk7hP
         XoD86KvafsLvopW4xo1jtsuQXXJMp89qahgeZ1gVEk5LHcbPTE5rUAtqEEJqkdITK1Nw
         NIwolkWir4v1h9RmQRnxxmhgsdydS2WCXHn/BHskbMNLR9Ffwq6fuM6heT94ZqBKWUiq
         j5qPis9FNsNmnJnFtNEvR1c+oL9PKYTQskHOoNFFcC9VCMkl6i4TXnbTTdppbq3fmt77
         ST8xv7SRyGlqLlp9Huox2gk3HSPmdgAlmm1V15VPvuU+a4rR+TQdpJjxmyAluBWE1xKP
         JOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667825; x=1795272625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJc/y2I20WRTL00Fzg1UskbrU2jIAE41tHgcdSdOm3s=;
        b=N77ePbCYXWd6Ez0xionyIxnlbGKXZ2pDNGUKakvHYTOxNnNa1NhlBDJNxcSiHm1rzI
         xNyZlao3ZQEED0woH0jjYSK2Cly4cS4GUiNw5V0wJ/wBpV6YG1TWCSLH3+lMbfEGoZ9/
         WGKSASw3T7HfHDj+69YTe8+9OuQZifZM2d9ROrk06mAzuf4pZGUpi3NrWGeZJ565rsmz
         wydK6oI6/2grI49MEapSMCHjt7oUZahnBeU2EvlCLCgdaYb01JSAMaLX/nFrDBips7fg
         Utb8ba8mqgMuO9o7Y0QYJxI378bD43blxTWqQrBKfk4w+Cmx7ZIYUUl8GOlB6PHtYU7O
         SCZQ==
X-Forwarded-Encrypted: i=1; AL+hErFvDnCtlUZh7p0P65EIFm2BdcXiZf7g1tjZ1RUM7eQDowyCl/1UO2dOZmw+gbewQTQAYDJR+hj23kWSBc1Ktog=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rboCHzUDxBPLXXsfCRNipKah1HLZ44wlRCKwO23psaU2CM/Me
	HjoKSshzOAmEU0kU1S8F5awsSJHX9YptE0PZaDHT0nT4zzMLRZoVwkNq
X-Gm-Gg: AYBFou1hmhuaGL3aNWK4jYFXof3z/kUVQQm78xqPah8oWHEiAcYW1TtyDXNBnalkEag
	nUl4SkZFSlxYgSzwPafRKN6+SSCP6CfQSRV51s4MbdqFg9CV5pPDZCpN/0sE2byOgejq5C1OcZa
	kqsiX9KWDecwo1x9POzosSOkot8wVjEpOJryaUJqaHovFcO7F/r6d8UEX8msztWrPV4Cf0Opvec
	bUTdkxdSgyOHv5tKvaru6QMCxkN1r1HKJFqElEzHCpMN2SjNw5bZE3gPh1JvkfhvBEMpX8Xnq8z
	OWM780FzGUgOPIZuQ795Fx8DztdyuioCsjbcccwKHyrA9CHU3F660jHHsbqvvXTjUAZ3bnFsb+G
	cnZKrcbE97WmVlFV9p/nOF/bi3mbuKEW/3vi4P7xU7a1+xBTVhp4Vm2QVyL2rN2AACdasg0BtmK
	i+ngMkOxyzgVZ7AeoM8ALZRyBdswPDwMcqXtO16m9v+rqkMhasqvT2/+FAekdgayx4i/6SLbkSI
	29KfVRmT0+xJFuiWPmPp6F4MvJtG/8UmoPATeyBV1qgu7PgmPPn+UmGoCpjGrITnFQvhlrwiex7
	2Wn4z/KlfI16NYzwmsGzyx/5HqDdGsUTIUqNNqaQpxZr5tSKJ5yU7KPC1TfTAY1kvF3q
X-Received: by 2002:a17:902:c401:b0:2cf:7db9:e13e with SMTP id d9443c01a7336-2ee0d9fce78mr42048925ad.3.1794667824888;
        Sat, 14 Nov 2026 06:50:24 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f8d708fsm20733985ad.58.2026.11.14.06.50.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:50:24 -0800 (PST)
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
Subject: [RFC PATCH v4 07/18] mm/swap: consolidate swap inuse accounting helpers
Date: Sat, 14 Nov 2026 22:50:09 +0800
Message-ID: <4e554bbb557d0456c953d73f008875f6d983b12f.1794666741.git.lianux.mm@gmail.com>
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

Inline the swap_usage_add/sub helpers into their only callers and
rename the callers to better reflect what they actually do: track
per-device inuse page counts.

Keep the existing accounting and allocation policy. In the inlined
full-device path, reclaim work is scheduled before availability removal
rather than afterwards. Slot-free notifications and zswap invalidation
retain their existing order.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 64 ++++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 277a5c749987..aa020f2706b4 100644
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
@@ -1045,7 +1045,7 @@ static bool __swap_cluster_alloc_entries(struct swap_info_struct *si,
 	if (cluster_is_empty(ci))
 		ci->order = order;
 	ci->count += nr_pages;
-	swap_range_alloc(si, nr_pages);
+	swap_device_inuse_add(si, nr_pages);
 
 	return true;
 }
@@ -1363,53 +1363,36 @@ static void add_to_avail_list(struct swap_info_struct *si)
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
 
@@ -1431,7 +1414,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
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
@@ -2059,7 +2049,7 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 	if (batch_id)
 		mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
 
-	swap_range_free(si, ci_head + ci_start, nr_pages);
+	swap_device_inuse_sub(si, ci_head + ci_start, nr_pages);
 	swap_cluster_assert_empty(ci, ci_start, nr_pages, false);
 
 	if (!ci->count)
@@ -2999,7 +2989,7 @@ static int try_to_unuse(unsigned int type)
 success:
 	/*
 	 * Make sure that further cleanups after try_to_unuse() returns happen
-	 * after swap_range_free() reduces si->inuse_pages to 0.
+	 * after swap_device_inuse_sub() reduces si->inuse_pages to 0.
 	 */
 	smp_mb();
 	return 0;
