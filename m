Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443498;
	b=aUWZxH7w4umRVPXm46tVX+Y6NOyohP4lLX1fmEfvfzDcCsXeriYgjwqDfnY0jaGCFzY6
	 QKXCJqsWukUsiGB+PUNsejCoo4bH0RyNYJLsU9IUpMGOfZTZYPFkPqGQegQt3+bwvb9Sn
	 VdaEdAGB7Fn3ahmFWaYoAPxMtzF0Ywny7t+XAse+JgD7EaG6FMBzPF7POWhjda+pjAJ6a
	 ni4CWoQgTz4kCVP4lKp6xNAVPgsmNZuuHj/XloC00wAsNQp//PF/oGhlU8GzDYI0ErGgT
	 AZfnUMrSnCVUyEm7EnrkF4eA03Hj8q5KkrFRqjqGKYGLWjxgw2Nb334hpzGbK8lCFdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wZPzpBpjg0sp41buwUabT4ELftt8au76u2ycWcMBhOA=;
	b=aX3yMMRkDbjr4EoZI9icULqrk1+LzUtcBhaGxFfAunXu+OXY9EbFhvfMnPipyYRk+K7A
	 HILMDKLfG583OZs5QzU+p8rKSaTspGSFDm4qwi46k7vVUNxH1WlW+YpK1fMhmptfz56vH
	 d7KHMpmJ7rh6wnyChOK+iv1q8BBdHoPd6JQ8/HHuFkdJL/tTdngxduGSsAvXrbwhs5hGl
	 cfJO9XOXHAPsFpyinnkxGA8BR0A4fgS4Dei+1m5SHhK1sspk9q9LTlNAvosJDaxPd140A
	 2ETKvWcUKPDz1OzMOXtHDlKZZmNO0ThQFgkoUaiXDgART2gEC75wVxFLj8BqGHRneTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pCxEOsGV;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C215606A32A
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C215606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pCxEOsGV
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so4077421c88.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443498; x=1796048298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wZPzpBpjg0sp41buwUabT4ELftt8au76u2ycWcMBhOA=;
        b=pCxEOsGVr5XuHbF/iMvo7/FyLjc1HsZAjtWgt+vlMft2dGdqOlEg4X4JSkVlLYN63V
         KAtxC8VeeDMnAwbeCrYcDcGxDIhrmBNniVeYg8iTEusEdWl24YmWLBzXg60v5N24OZzk
         5VzVEvE+Dyywb554MqHqPpcp+nTbM1pffOeowDfCwl15tpgOi8csgaseiGLNEGkQWfG4
         SRojr2LXCfCy6lik/n6A0eYDKAg27mLoRSp903jA4SY52mXKpffvC7aUw1Bs6pYktk5+
         1f22R6sgwFfrxkJTfZJib8emWnFAL9I//uqRDWgPix7teN/BH74b6IAph2I9mkVqNUh/
         GPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443498; x=1796048298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wZPzpBpjg0sp41buwUabT4ELftt8au76u2ycWcMBhOA=;
        b=MkC+4y40RyLBDNq5NviZrGiN+ohxE8DnCwcmyADQVJ8hyIw9rjOcQTCjbjuc9Mikuk
         67tmUJozWIhtvaOlv1Wc3YTSUQwjx+2ixlvMNNI6LVUUx2PWT0wIfmPRkaavetAAxbto
         FtKTletMhRVr65LryBiCTEwa+B4Go9OAL/jfmwYl/E3Xdx/MEZYaLZhE424JysM5h/Z+
         JLZEINlIe/111ONnsi3hBJfrqmGxbPgUR2QEH6xk1Njw/ouIs3eqLfUq2BDj+YUb6mIq
         RtaxhZTeKrpgVV4s3uODI+tVEP/dtMi1tVODHEm1vBMhx2qelQIjUAwzoJgN8p1sWJ8Z
         15lg==
X-Forwarded-Encrypted: i=1; AL+hErFQrEmAgcgfhNm84zwsYs41vls/z2xTyfJLyWFV7K59cCIQ8dZ+7xwnYfh4Tbmk2tfi+u324aeZxXWTQ0zx3/Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vbZ/rtNuxVPuxFxkZdKrWl1rKmUSL+hET+tA9Qy09MxmLBuL6
	qdzjPE2GqtB1U4qaT8LyWERQwdZiOADwFUfsLeSB18rAw0FiBs4nS/cw
X-Gm-Gg: AZFdTZetLSNN3go5SgTutITnTZDPul3dcvjAB7TeZKwSOqm4cXLoMxY4llhoLQOSqOn
	2mAbJjmpkl5SVQgRJxXuMu00GrPBu2wZjsAgAaz8JU8+41q/9NBHqyHAUIc35cjeOyl/MtcwR81
	sIPjzKf+e24u6pIoWyby/70PidUm6MknIHBWBw1wFnwm3THMPkJkCpFeR+UdTuZ89tVpmUKyLdX
	RMwE/0K67aRIxm7Ag3BF3yEFMAcsR8aC3MK4x1Ea0LviLorG+7R27wyl6W2DA0gMXw4uTB2dn6D
	pbosnd123UQxjEjNuPC5C/UGxkt9l12Ssmnm89kOqn2AcDZy6bHSZcBmlJJyr+236a++iNgPCEa
	yjZJXAOWNr/9T+zHrK5zMGuFjgkN7i3IxzH5yoFvgZXLKQ+oLK+DlrqXsoAi9h1QOe9AmVOzV+8
	FrLeJgtbTz001ld1uf0FSc1ivxBorJLh2q57QVbPWzrOAGF1LrwYXvE/oFKcWrOT+LOWvyqKJoL
	vzx21sv4te1tUSAAzOkNiVC073u90eXSkKmNKX5lvBo6mV7YC+Pf1cj+DWGq3LEv9TPbyuMdtFB
	TcgwcYs0sSILzdBi69Znk5kDtw+GjHhxQNBg2nRPktKaSHNkbh/7BGhWNfnGeyNgNXmTe8lvo3E
	uL2Dii4WXHIobD5U=
X-Received: by 2002:a05:7022:f509:b0:1b2:41af:c21c with SMTP id a92af1059eb24-1b55694689amr10214838c88.39.1795443496157;
        Mon, 23 Nov 2026 06:18:16 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm26797807c88.0.2026.11.23.06.18.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:18:15 -0800 (PST)
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
Subject: [PATCH v5 09/19] mm/swap: avoid direct reclaim when populating swap cluster metadata
Date: Mon, 23 Nov 2026 22:18:03 +0800
Message-ID: <e920cffdb3a65905dbcf51fa3520785a8c49fcb4.1795439990.git.lianux.mm@gmail.com>
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

Swap cluster population is entered from swap allocation and may itself
need memory for slot metadata. Its fallback drops the device and cluster
locks before allocating with GFP_KERNEL, which can reenter swap
allocation through direct reclaim.

Make this allocation boundary explicitly non-reclaiming so callers can
retain outer synchronization without a recursive swap allocation.
Clear __GFP_DIRECT_RECLAIM from the fallback request while retaining
__GFP_HIGH and __GFP_NOMEMALLOC. The retry can still wake kswapd, but
fails without direct reclaim when memory is unavailable.

This can make metadata allocation fail earlier under memory pressure.
Keep the existing isolated-cluster rollback and restrict this request
without adding a task-wide PF_MEMALLOC scope.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index cd2cb360f274..70913402a265 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -586,13 +586,14 @@ static void swap_cluster_assert_empty(struct swap_cluster_info *ci,
 }
 
 /*
- * Allocate swap table for one cluster. Attempt an atomic allocation first,
- * then fallback to sleeping allocation.
+ * Allocate swap table for one cluster. Attempt allocation under the locks
+ * first, then retry with the locks dropped without entering direct reclaim.
  */
 static struct swap_cluster_info *
 swap_cluster_populate(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci)
 {
+	gfp_t gfp;
 	int ret;
 
 	/*
@@ -610,9 +611,11 @@ swap_cluster_populate(struct swap_info_struct *si,
 		return ci;
 
 	/*
-	 * Try a sleep allocation. Each isolated free cluster may cause
-	 * a sleep allocation, but there is a limited number of them, so
-	 * the potential recursive allocation is limited.
+	 * Drop the device and cluster locks before retrying. Metadata allocation
+	 * must not recurse into swap allocation through direct reclaim: callers
+	 * can retain outer synchronization across cluster population. Restrict
+	 * this request instead of granting the task PF_MEMALLOC, which could
+	 * give allocator hooks and failure cleanup reserve access.
 	 */
 	spin_unlock(&ci->lock);
 	if (si->flags & SWP_SOLIDSTATE)
@@ -620,8 +623,9 @@ swap_cluster_populate(struct swap_info_struct *si,
 	else
 		spin_unlock(&si->global_cluster->lock);
 
-	ret = swap_cluster_alloc_table(si, ci, __GFP_HIGH | __GFP_NOMEMALLOC |
-					     GFP_KERNEL, false);
+	gfp = (GFP_KERNEL | __GFP_HIGH | __GFP_NOMEMALLOC) &
+		~__GFP_DIRECT_RECLAIM;
+	ret = swap_cluster_alloc_table(si, ci, gfp, false);
 
 	/*
 	 * Back to atomic context. We might have migrated to a new CPU with a
@@ -3160,9 +3164,8 @@ static int swap_device_disable(struct address_space *mapping,
 		return err;
 
 	/*
-	 * The swap allocator doesn't take swapon_rwsem. Looping through every
-	 * cluster lock after clearing SWP_WRITEOK ensures that allocators see
-	 * the updated flag and that no allocation remains in flight.
+	 * Drain cluster-lock users after clearing SWP_WRITEOK, so swapoff
+	 * does not race with operations that started before the transition.
 	 */
 	for (offset = 0; offset < end; offset += SWAPFILE_CLUSTER) {
 		ci = swap_cluster_lock(si, offset);
