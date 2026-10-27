Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117319;
	b=N83G/V0bo1Cr7TdbyqKP1wqT8gY/fFFhgY0gJ2yIEtV6Nk8AYII4rdMntnWa9vgeYXNE
	 X73DoXyOvpvz9n2Ac9riUrXC3ZeJljGkFXfCF25ZHNYhThrg0LjBUJJ4J2SzLYWDhqY5u
	 UjdA6F/a3vtODC7kr5cHf8bT/F/tAwmH9vSvgBajC/m4K0FI4Bn8YNQoxS1nng888pZlu
	 pb+eZu9WSzkiTHgc4F6cOuxKcc3VBCVqTZ6gmqjHiqbNiyYSX7UpPxELKQe6J+MyZpg7v
	 +O5l/N7WkMmJCkxrRQXFBqE3Aup+TUFkkSyFP02O8AdRLZnvF4TVFeeOnukrucn3BvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QVxxN3pOPGXBhWxV8G2yXfM8qxwN8twHCdwdAriEeWA=;
	b=Q/HigvgcPpRZgQWiAX6hofzn9cNdOSu5EJeNg3lAlI1pf9pIQTD7pK823i4OIAXBGK5l
	 8VoX6+emauHhehgUQ0Xd/zy5tkGnZtzrKBPZRNany02QHJ7O20VLZGnrx7gpn/7Dy9Fnx
	 ks5/OWAhsLJY0z0g0aJH7FlRiE14eMVZ0i/xiOEioGruvqGZPconk947HFOObTnxW0eJd
	 oI6ZHC9ik54Yjvi43HyV5YNwNiDdLsMgNum53cTgweV0LWqUfX2VFcLej5fUC+GsYgEoZ
	 srl55t1LGaw+wp0GSwi9D9H5eWHR0ThfG1A11VLBwSn9B932SEshxROysfNHl5w/abg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kb13883k;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E6606A31B
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 218E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kb13883k
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso57319a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117318; x=1793722118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QVxxN3pOPGXBhWxV8G2yXfM8qxwN8twHCdwdAriEeWA=;
        b=Kb13883kzz3b/nlA3jPmO5F6TOoJ5sdAI4+Kyz6oWaIqdtlI0SrZ4rrLzyXSRoUbDY
         yZyvnTXKWlsC6W+vH2tBgqzCsMOFe4uJZmMzdyZ2T2nub7IO4QNSnMMYyhTR0M+hNStO
         bclFP5R7bqxrimOPOG1Qi8NwPigJtx/52D2Hx4xPz1f8DfV0/JldW85ESFz5Y9bXxeQy
         Xyh3GBKr3s+N7LaD+G1UQfD3AuFW+nPeSEaNevzKME1srpC2yl5RKkxByTvB6Seee90z
         jSeqC+uTxrfKXycCMgVGJjI2B9OA+Ve7LB3ENZie49gBzGcpfgN1r+r2v9JsqpuMYKgd
         g/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117318; x=1793722118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QVxxN3pOPGXBhWxV8G2yXfM8qxwN8twHCdwdAriEeWA=;
        b=xt2Qa6E89uUGgfQ+L2mgJMj291vs8ty5C7IPeL9v/cgx3z2nNTRtpl8U2WmWqWvb8B
         2LeJXoHvjpf2+OQ0gB0gHP3+Cf2G3wA1LELQOuUIhKTz78ticeXKYAcFmVek8aDIVzSs
         SZ0o7BMdYwQJH9JnLFwfpbhET1oyrt4Sz1PK8CyQadXtZJXbklcYsDqEf1z5yb+hT5Tz
         Z5if7pJ+ppRwZuJ3R/ehefnotkrkn2COu10AX6dr8PeFlL1Efp67s4GxBZX23G15pNi3
         j+sD6S6XmkEKjJkNsYmU0gDEGiAvOhORd9l8r+QY0r3S/p1U5KOEOSA+fShf3mC0WDYI
         uM0A==
X-Forwarded-Encrypted: i=1; AKwUvBxzQ9Y8xscogsSE/PdQO4nYw1iBHOygcZ9DL9GyyTQ15s/69x4+OZ5NB7exR5bnKWNhcM3VjAzw8ANp0m9o4kY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9rsNUt4y9ySQRIhXns3QPY9kDXb9ZOhTWwgb8xIj2QeIvLbwu
	CT/i1C/ewB+vOaQObTXdNKoWsjlHXx4qtjac+npXARrm+PxbFpYxzQJi
X-Gm-Gg: AYBFou1o6bdFek4PHzw+jSailGl7WuJasVX5/MskloXmBeS+CzabkfZ1kmWyFNz0mec
	4wnHaIyAUQz302v+An9LXKz6UQbEg0CpgDCxJQrPwrVxiJbD7XRdpkMy1MJMXEKop0u7WI3wQKQ
	Fh3pFasJDFCIKW1DF/DYENKNshsf9N6LiPm99tVq3p11cMrqBpaXD7m1SemQDLem0/A9dzTiiqF
	e3Zl8GLsxB27EGBDyBPdgbVA1Vb0NI0C7Y+Lwh9oxXBJ2Bh3YTU2pZ7NByhPBNZtucqqnH9XcST
	jk/jkkLM1vk877dcf2RFlTPcMbvEoE4Ce6+sduokLTaC0+KMkQIi3a6pzI21tr77J70HhNpWu8z
	E0S+9cyqX/OuTSsrjq/1/QlVlh741RYsHhOF8l0H95sG6DMotc60WcSm3++DbNl+7NRIMa6wkNh
	x6ztFA5kZFHZEsDHsmdAz86YHpVNLusjmh6XFtIv7/7e7WqTcq6UUy/p9EkK/nDBUTmBflHWJAH
	3ESZr7PhG2nv8jgwtpXX4Lnxbeo8mpXtktjwUEjebVys9iPNUiR6cpNKV6iCLnzDgwljFql9Q42
	taV6AdMbjfNtWJYNAyFGxTIN5qNyODYpGdL87oHi
X-Received: by 2002:a17:90b:4fd0:b0:3a0:cbe2:9e0c with SMTP id 98e67ed59e1d1-3adeb10f4b9mr8694182a91.63.1793117318387;
        Tue, 27 Oct 2026 09:08:38 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaddd45sm8500624a91.2.2026.10.27.09.08.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:08:38 -0700 (PDT)
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
Subject: [RFC PATCH v3 09/18] mm/swap: avoid direct reclaim when populating swap cluster metadata
Date: Wed, 28 Oct 2026 00:08:12 +0800
Message-ID: <3dcf416531542280b8b01b2bc6bde6f1d094f105.1793106426.git.lianux.mm@gmail.com>
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
index 2035513d3c61..68bed5023299 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -545,13 +545,14 @@ static void swap_cluster_assert_empty(struct swap_cluster_info *ci,
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
@@ -569,9 +570,11 @@ swap_cluster_populate(struct swap_info_struct *si,
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
@@ -579,8 +582,9 @@ swap_cluster_populate(struct swap_info_struct *si,
 	else
 		spin_unlock(&si->global_cluster->lock);
 
-	ret = swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
-					   GFP_KERNEL);
+	gfp = (GFP_KERNEL | __GFP_HIGH | __GFP_NOMEMALLOC) &
+		~__GFP_DIRECT_RECLAIM;
+	ret = swap_cluster_alloc_table(ci, gfp);
 
 	/*
 	 * Back to atomic context. We might have migrated to a new CPU with a
@@ -3095,9 +3099,8 @@ unlock:
 	del_from_avail_list(si, true);
 
 	/*
-	 * The swap allocator doesn't take swapon_rwsem. Looping through every
-	 * cluster lock after clearing SWP_WRITEOK ensures that allocators see
-	 * the updated flag and that no allocation remains in flight.
+	 * Drain cluster-lock users after clearing SWP_WRITEOK, so swapoff
+	 * does not race with operations that started before the transition.
 	 */
 	for (offset = 0; offset < end; offset += SWAPFILE_CLUSTER) {
 		ci = swap_cluster_lock(si, offset);
