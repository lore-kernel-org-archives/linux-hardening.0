Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667856;
	b=TCa1S2h3lzmsOW0Oejp+i8/Yc6DRb59UUJbTZ2b7NmVMHMNl0nSZvT/yxFVv3oe8QGHO
	 WtYrguAMTbT95/GJWsT8wV+CO7i6WQ5lq+0zv5UTbEZIkOqTS5FoJu8C0+OZE+RhKcXFd
	 SwTYgz1u6ZCPHXLy+a8oGtXTErZlqJHIMpvIewMm4GsY+Cwdf0kjxl96a9yFjefswzR5z
	 oxKDbjhFYv763YjxmRcwA3d6OtM+cRCr4sKL3iaU4CqcmxgYW13xmx0ou65hAzlqYfJvv
	 P5pF+35u/piRYOp2PQpGjqH6vMEgwHApbfBURGg/QnMXV6DpniTG7GMBAwiREIJdvQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iDtGnnmzB8XetLwM09gGYvTUDRew+lNVR5IPpgOPUfI=;
	b=TU3+E4IDVIbGlwhzGbO3myCdqfAgMYYW1hVgtts7V65MWZlnC/FysrfCIm55E6k7DV4M
	 HEo4VwnVJRRIN3CDPep8CYcme3dVvY2QfZdzaOkZvlk9N06YidRFK+XiL9I7lr1qQhkIx
	 ytxKhFBWaw0bH37T/lNZgKFGwtUtsnBKwQSit1mQ26ZVql0G/wJhVfkQwtPb/uK9Ni8/B
	 6ckwP8IUd6Q4i9BdfluJU1QL7KUtlHGYD0Lqr6V3Ns5q7A3+nAMK76kcRjfxad2G+lGfi
	 GGPkZ3sh2Hby7GyI/mIFh/aXN9ly7YUi07Sf77eUBBe1idzPkzdYhieg4C0HVaitlVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k3KwirAV;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE9606A338
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFCE9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k3KwirAV
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so868387b3a.1
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667855; x=1795272655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDtGnnmzB8XetLwM09gGYvTUDRew+lNVR5IPpgOPUfI=;
        b=k3KwirAV3wzijCpVmXtlLg2dA7gSKDFx5Wb9bPKnOz+rW8+zdED6bmG5WkcJsY/U0+
         btuprnHGz1H+ur7F4TBWjmsXVYYfWGbz69ru9dbkIY8W0f/I5sjN8SR/PJ38p1LyZJ2C
         dR2p1GNRGzc7kE4kwshemUhXbge6GbA4nuoaeHAtdNDAy4VGe/2rQYdlYWrbELuv+pf4
         V4ZgY8PAqWMo9VfxEd6cmHUVAxPcxbMt4XZyjBgbUTz1jAn4F+0eruAoSyVSXbxIC5de
         KNmUgPN71/nBLwCHK6L9Ibl5WgtcYKRKVBWn604XHYi1iCrBu5wypqR3ZNA086lBmu6d
         i9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667855; x=1795272655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDtGnnmzB8XetLwM09gGYvTUDRew+lNVR5IPpgOPUfI=;
        b=XEytkWUii0Xmm4dddIh9Ova5kPZz6ujnE/kSHdFGVZ7Mz7AlJgAM4NNp4Tb5D/q8LJ
         I93B4PGQbClWX95UG+4W8y5WSSqnGPKNWTWKZyO8kq1GEjRGRFa4GsyQeO8hvX8IONtS
         tmXIw581YS914Up/eos5guwCPd+CYcq1C+tjyuf5uUZWz60y3p0/QR9BTxcKo4HePBai
         7LfsZDwkfb69Ag6BAdHxsShvhipIJjoDRgNkuBovS7pWTlCeD8d4BcCpC1iQT3sOPph7
         DcsPpweJ7w6ynCytNWb6El5QbeBvj06b4pENW3/O5obc5fWC7O+wGydndLAFF77ZBAQH
         CTMw==
X-Forwarded-Encrypted: i=1; AL+hErHl50ltS7vZKk+a1rGOlxSp6P5MBwuXqqyKaGVzXX7no/V5KoXYVa09oZOqle/Zmbd6cbOG1IZ6tbg458j3mkQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KUT2dXVjU9oFR46uKUu3Mm2y8ateAYKcsG5TtkQhTj4z18pVd
	N2n03p6pTh1yW1EtFFb5T/FWbkr45V8jW9KHDSJ+2vtLooPAh+Dc5oPug+1HhQ==
X-Gm-Gg: AYBFou0dcWdL7o6slFalNTTNu7KMk+h6Mrx1AEBd8OMlnlVsyiI0LXLySZCQtA8/Kq1
	EYPwgYOUo3ZHuGdF3MmIcif6Vj1OoE6gzj9CVE8Bx8k9ny7rseG9tQ8PFFwz8sRAXlCxEqpLC1i
	gsGumk6QAHMB3SsZ0dwRHgdiBCJiJY79ikTyO0y4h6LxuEsBA8cQNd8lNbvzb0quf1/0kOJfZKT
	mTHvJEvWx6f4+g2TwMhcFQqQY156MVp4XhHyDQZrRuCb3TGW5CaVVgtwOGpHHagY8QuedAgraFa
	WS3xgTDmj52CCtr1MNNsf9RxSwioIeeajt+FaI+WZv/09T5yuQBugSXzIgUMNmCd59D8q+H2EYe
	I2ySjq6/KQA/RJPUEDrQbfkCNOnuMJZUrj9Q7N1KCpS5AOMHW4B9kGX6GNpt+RbJmd2jwh7huoN
	icmDcVgvWTqi1JOv8I28z2cLd6hpxr/BXmI3cEIM3g/78wu2jK+TWH+wpQpcKWT+vHGHENvh8yP
	g6IKBSclcd99ifgqP6CzANYs5yIr2LkoygMs+meM5D+egpsfwYXIB5ScoqbxHDNsvzw0/34rU5K
	eW4Yss2pPQ2FEh5/5AVF9hUjZQbWgrLx8zV6e7Qki+Gy5u/7wPMX5Mwh/UjT4LtmOyvKMINMdTE
	NpeRuHxRBqEdw2w==
X-Received: by 2002:aa7:9303:0:b0:8b9:227b:bfc with SMTP id d2e1a72fcca58-8bd5c0b5795mr6012445b3a.1.1794667855205;
        Sat, 14 Nov 2026 06:50:55 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1d5f005sm2141222b3a.29.2026.11.14.06.50.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:50:54 -0800 (PST)
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
Subject: [RFC PATCH v4 09/18] mm/swap: avoid direct reclaim when populating swap cluster metadata
Date: Sat, 14 Nov 2026 22:50:40 +0800
Message-ID: <88057ceeb0228fd33f42637a3c9647eea74d5d95.1794666741.git.lianux.mm@gmail.com>
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

Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c46b43414bf4..fae862fc873c 100644
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
