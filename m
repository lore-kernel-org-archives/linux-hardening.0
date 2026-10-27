Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117021;
	b=Lbikf6gkjGh0lMPnR4aiCOtCcLFJ8DeTe6rv3wfD8ro2AGpCOFZ8arVUfriOrqrCc1KX
	 lTPOaRZzYvBD1SCpXkMLzA2xZCe5Kz4wDpbAtsQ7EkgJqmQkT2oB4n7KL+uvLt/1qWnwc
	 SJ4poNP/LjFCD1XBfg/abRUETADesf8yaFRdC4mBjZ472XriRgjdVTS5el+bt8bEmYHCG
	 ASLUs+cIlE3rqqepAyod51R/bzEr0Tya0mb4E0ng2OVz3ZxnZ4dI+Ikg1jngj3IFsfViM
	 wjVOQZd5/+Mdy3IlUaU/AhhPgM6v9kqwy1mTfNE7Nn/aN/cqJ6m7q/XS4xetwpsgkyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wzW+q10RWKie6Pha9KgepWUrxRSzuZH0wvLMyxYlSms=;
	b=5F1vP8Ies6MNSnrPn5b/eqBhYl8vY/5p+TbjNd/KHu/2C7dMNNL2U4sOM8+mgcGdWUE/
	 9MCnZ3Fy0TKgoD4UAcpQVzuYVb06bQZ3EFMG/0ErEzvJGRZAVKi3MvCpLlFpgST3/1Uq5
	 WNR+7W4MiXnv+JPa5Xw60C8YyAvrZibM/mKSb624vKCb4CNkxhz3hC901+rHIuNVW2Ir9
	 e4tUjFSVat5lTTLS36VnPS8nPBdByVZSkU3KDh/Rod1S9Eh9YJFfifMW607dpTZ6zkr21
	 RayLbZ9SLLwTjeM7cPKbtptbg1pRJ/qpoMrHWHBIE3SFka08WYjKQ/08YTP+MC/AQIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WhQv5itt;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540D606A31A
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5540D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WhQv5itt
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso58454a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117021; x=1793721821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzW+q10RWKie6Pha9KgepWUrxRSzuZH0wvLMyxYlSms=;
        b=WhQv5ittd0oz85RgWEF3DXu+89f2TB9Ts7u9GRywla4UEbM/JrVBwau6j1cn/IqzNT
         l1OQsifQxT3KIJjnH8wsBo6UwNfY4QIhrFsvUnLT2MZ0mD46Z6nwikD0b0WLxwaD9nG6
         ISEXCFpP6XZn+iNauWjvY5x4ctpO8xISDn77NL1aUnwAa0t00nrs6h0gdQKOoRgYlpGC
         sd/ahvYHEPTPBLRPyAGGV2gWUQauACBBVMbd1YoUV1wFKJ5uM7kiJJx9+8/ldYVcFE3o
         u0VpO+RcEyheU4oaHVpKC6rc4tX8kyppjnqzEOu7G4qWZlJlUpidXPx9bP+7TZmFD9NJ
         LiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117021; x=1793721821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzW+q10RWKie6Pha9KgepWUrxRSzuZH0wvLMyxYlSms=;
        b=RlAILJPQzCVSEljf0YR8IeQ5QOVq7WJkt28EdjHD81I1ftDs4p/yRqZt8vu1k8xrCj
         5M5MRNJ6mXf1R4ZdYtzM8ETgVUj6eCpqR2Mnge7R97jwEsVjadKnASKsBlsR/eR24OTB
         9dh6ajgDwwllncpqEmeYOea1G7f+W2VH4fQuJLi/1eRTOC/vU9e7hybJtubJ+tDEXEP6
         WSCnbpT8eYmisMDGx4VZH5eNb3a1DHox5odXdjIJgsUWtKEZwunf293Kq/p02QIfpMpT
         tW1vQ1BRSjO6iotBQVc193Zr2bI6kRMcR2eWlz2vwdCFIHt4fjC6/4iDWG4JOUrwPAdP
         Ia1g==
X-Forwarded-Encrypted: i=1; AKwUvBy+1gRhtNsUCF7TLzFaXYO1ay9rNHZHRfRzVD8PYv2abRcxgxcKaR4RsBr2eMTm5XHI4ZRvI6V8wHnRlhPa370=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdqqCG4PgjbMMgF3Kw3C7Vec4LHnynMhIAXgxSq2r1QrmdFi1a
	bJuJBDR6gjKcOBVdToGnpAeIntqb3YA4LOBbWQTdt7oRgTeUb4lZAdlW
X-Gm-Gg: AYBFou24nJ5npvPGWyPHKSFlHcXSL4KeHUr0ODpSML44VbUlXIyUtMd3y8HpGAd1CwY
	EB4vhDJmI7Hy+Cx7WwTPPiJZqzDeXbeKr3I5K9VkSn2ym0mbDDYFDmkdJX4shE+LI+UGOmHYOFx
	D/gTQ+v7lP2lk6yTl0hjfn1dguUE25NIzbbUHy73rJNuhSfh2eneneWMYu2uL44lu/eQrVRrt/r
	zPcG4SAZh6Dza+D/IT9XsJrkSVZG4wPAZIdc237upDOJfa0abvFMaFGE2uggYuUA3jmcMj0p835
	OX4n06WmKSCzpa1G/I67HqYMzPzaB8aMXn0eKWIS543lCZm4hZR2BJU87B2WCn/eJXQEnKs1EIf
	ZrbkLLI6J3A0VC0UQZXdwwAwDlMO87qzWYfjEmLTWgHwBmwu0mA/JNHkUciuE8qKGZ07EF3bG4j
	RKdrcheAlC7VEhgqGqYNmxIrsgeisL0rQnFXhTVLCjdl8nlqP6/ai3oC8XfoCbMMegKGcySO40f
	zbtPpTfeLd/vKwbXwjkb6iYy2MZK3hiYbbjZEGNo60emtRlfmiFV46HBamoUsxq0hnpM9ZPHyaO
	mFE0+ijS7YMmG1KdM/P38VMmW8jN5/lKgPG3Vn+S
X-Received: by 2002:a17:90b:2cd0:b0:3ac:77c8:ac29 with SMTP id 98e67ed59e1d1-3adea89910fmr7468966a91.15.1793117020581;
        Tue, 27 Oct 2026 09:03:40 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae406519fesm4273776a91.12.2026.10.27.09.03.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:03:39 -0700 (PDT)
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
Subject: [RFC PATCH v3 01/18] mm/swap: remove unused parameter for reading swap header
Date: Wed, 28 Oct 2026 00:03:17 +0800
Message-ID: <50b9084b4845d8a93bba7cecd1d65e13808e012f.1793106426.git.lianux.mm@gmail.com>
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

No feature change, just a minor cleanup.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c3288910b3e3..7acb33cd8b71 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3568,9 +3568,8 @@ __weak unsigned long arch_max_swapfile_size(void)
 	return generic_max_swapfile_size();
 }
 
-static unsigned long read_swap_header(struct swap_info_struct *si,
-					union swap_header *swap_header,
-					struct inode *inode)
+static unsigned long read_swap_header(union swap_header *swap_header,
+				      struct inode *inode)
 {
 	int i;
 	unsigned long maxpages;
@@ -3801,7 +3800,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	}
 	swap_header = kmap_local_folio(folio, 0);
 
-	maxpages = read_swap_header(si, swap_header, inode);
+	maxpages = read_swap_header(swap_header, inode);
 	if (unlikely(!maxpages)) {
 		error = -EINVAL;
 		goto bad_swap_unlock_inode;
