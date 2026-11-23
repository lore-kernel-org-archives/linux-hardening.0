Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443442;
	b=GEKMmGBWBEEh3j+Obq50P9KB3K1WCde6sYxy0k/YXEyDC1LUl2m6UX+iN7BkDeQwRa2O
	 Gmlxm6HyCjCCi+PrLNcC5fKT+O1Bpxr6bGrPWfm6YzrmrcQOSwG2KjEMu/N6VidXLIGzJ
	 ZvU4/r1zCEpFdWR0Sx8oHap+/YPY5mzbTxrf3b7JpzTJeIOeKlVMMdCIiNfQIjrbYzJVT
	 SvL4h7SfCsMU/0FDwtSe7AqmEQPoz3Pf0iiXwhtDfEG+E4SXbekvi1IkGvzBRsEj0nIXJ
	 IIG2NBdQm8aH+bNKRyliqKkUwKv0ut8pmYWgloUVKKvLJ4kLcjI7RavrPaRg9/yUgNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=przsGoNeXdp32y5+6ZBoctPoG5cTnWhcKcU3VSR8K0w=;
	b=hNIp3LqM3f8XGYPMuG7PhZdNbHhKHVixoKfe2QEgwn0LEjCy8u45yxVxttrVV3SDqhpE
	 rYLA92AIYXMl6W1by8NKfOmy0HlHqM0/tgKKVygR6+0CIR7IMh8BBWAWrrVHWk9dEriSH
	 4vnVs2jbj+lJpVXya8VIm6V6n8+L1hN8ef772TTJHaH7AEj3jl98SQBMctAThx3DVgbDQ
	 zu5yNtMWKhrmnuAIWs4Yu6QSiW75HhouiYcaoWON1y4swQnmmKDL2g8GrRkaMEkRHg+SH
	 K4vQlhsgDoqzPiU6Md5+TlLlGgQma/mAF80NNbdaTzFOzRRWHM+jQpB8EZ1mtcd8txA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2AizJe5;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B776606A337
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B776606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2AizJe5
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-38190551625so6945601eec.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443441; x=1796048241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=przsGoNeXdp32y5+6ZBoctPoG5cTnWhcKcU3VSR8K0w=;
        b=i2AizJe5pyGTtPA2EL9klU9iQ0Oc61UHeyuM0N6V+wuADh4zRX/S+rsMqpGNyx1NVf
         G7TJOuPp7eXNu2eFEFA0a/UCoOB7o5v6+90vwIha1dPuWhBJN21x7ts3gRFeqEtkEVMN
         R4zGtk8C3ltRcbzlKVmZ8zqBstWuYUCTM5oQJf5HSLKDfEHycGxox3aEyfkro8jqGb9v
         V4lsB1HO678gm9waHfqr6CE0XGZtymfOsYRaX3kCG+e5KKizHWviEqYxzVPCF2/B1q86
         mOmLRPq3VP9BrFqN3Pf6HqKDMaqRwV5PL5/jKeuhc/BugRC6H2a0RoShhpX7Sv0ZSTzB
         oAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443441; x=1796048241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=przsGoNeXdp32y5+6ZBoctPoG5cTnWhcKcU3VSR8K0w=;
        b=0kF1Wm/gQ4Fo2Du9IEj/ZfdzjteEGQ9Arri+tBMWX0cjZHxE8n1g4Fz24W4tYdr7mi
         Oeg7bWMqho0YyQINYv9soj/MKskYc1ztR2Tk+vmpjJ1Ijtv+AAvlkTHdxBB9IkEtvfvi
         07X9ROhNtwfMFnT2Z6Hz1zK7aJVu9BHQqXiInWb2uEhxZhYdJWz1erth+tPlcyvt2QuX
         +5tdlyC8OnTTgl4yRFj7C7lC9/H1v9p8RepLYImaUfttGk7YFj4jo0Q8yhi0iV1tX5jz
         YxSSQujvOAf7fOPGdxFYzQvI13RWc09p3NjjkVfuXNXaytj/2m2qEQdNbeVXJ68xu1dV
         cMGw==
X-Forwarded-Encrypted: i=1; AL+hErGQqirvH6hzmkwURI4ZDxSk8Ot06FNIR7tyCTTKmb7irB0Z7xmninWaSQZZISQ1FXg+2hDtaUiDvAJv4qL6Z1Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+//V5Fex1sgJBkAqsGVhTCT/WCJiRSHp1AfMHKnjo5KATjjZHt
	jq2jqnbOFoPRW5EjyhbiWJJ5SuT3nOzg2Iehmix8Wx0ONLKoU08VJzdw
X-Gm-Gg: AZFdTZcI+dwdnDxc3d59IsDUfSr0FN9JzAxLyg5dpwI5vYDn3MXv/P32Me97oVmjHd5
	SIAczEBZEi1jQxMAcuyZi8QxmtNypQssXx0t0FiUo/WUa3MVAng6nws0ACs/XTQIop3TGNd1aoq
	SJNtrS+3GTFstqTd+aVFz86Ol37pIq315LGgMUAa61xTQeg6fEns0m/BxsfOqgUJbnj/T1BMUET
	cVy86MisV1WYsI5PTjeCCmDlei74Iz0lu5Dc1MRgisXy5dAJyyNYb29bO8gWm9dmrGY07mGrmEf
	o/B7E01MSpS6IYlNZcPhsmz+WNrgHULi4/TvKbr6WKO77CtjBIe7O2LQqZK8Notne0VWgj62DrT
	uHveoMlnX9d5feKZ7u8uWgiOYjuftyV23QPSxCeRmJvxR3CKM4maoDlba71WILp5TdI4i5K01I8
	JyHT5flrqnRCDjpdMWQq/ppZFSsZglidPrvwYu1a97S4yAT/Vp7aBZ7nJzSBCIT/9xAHMXe/lEK
	oRcclDOGh8j1eQ6tiQWdgdnrRf77fKAPBWCZjF8JKwXrusZZ7Ie0flLbA70SD8ORGqkP4HDcEOu
	pr2aO2zrVspBxIRxi4PyPRSRdGcY7d7oA+SmZ+vjCaRyUlLyXMMbSMorZ296xN7Z3HSr
X-Received: by 2002:a05:693c:880e:20b0:386:b54a:7f6e with SMTP id 5a478bee46e88-386b54a8032mr2033437eec.6.1795443440605;
        Mon, 23 Nov 2026 06:17:20 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm42979741eec.10.2026.11.23.06.17.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:17:20 -0800 (PST)
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
Subject: [PATCH v5 07/19] mm/swap: consolidate swap inuse accounting helpers
Date: Mon, 23 Nov 2026 22:17:06 +0800
Message-ID: <21e7cb1a16aed56568fa400f5385acd36513aa46.1795439990.git.lianux.mm@gmail.com>
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

Inline the swap_usage_add/sub helpers into their only callers and
rename the callers to better reflect what they actually do: track
per-device inuse page counts.

Keep the existing accounting and allocation policy. In the inlined
full-device path, reclaim work is scheduled before availability removal
rather than afterwards. Slot-free notifications and zswap invalidation
retain their existing order.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 64 ++++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 24f301ef4e3a..4fac894f8c2a 100644
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
