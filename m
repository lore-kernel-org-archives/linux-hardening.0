Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335228643C
	for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779746809; cv=none; b=J3tlx2wLA1HOW73dSPoMEQIvh+roVaufFFSEUG2YNVyKt6bfv5yuq+Xeyquhiak+zVabyoHPiwJT32vuE+S7fsgVmBguNmeL+g59fcsaYImCtkzJ0mqUdsMM2bXm+Y3eUi2tR2nnR/VZO/SgQUxM4zbJE4qVgkATtcpwq2kaNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779746809; c=relaxed/simple;
	bh=YtQ/yTW46aJTgBS2RYdCC7Mi93eGRCfeb8vPr+OmWWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hexhAJPVRwJp+Y4ewvxHQ7vZoQ2CZVIvAYU0LCVqkxi/dW1FXpRYm2Tlfm/qn5ECTo6NeJpI4QCsnOYpk7Q/pMUlDjKIoHwcrICwELLCx1HzxR5XocEfZ1KmyxAP8mh0lYpDkcOAUxVLnmP+0mT1yTBh+Ywsn+SoWLQHLxlE/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFdiDtQn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFdiDtQn"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36ad15213fbso810939a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779746807; x=1780351607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+vYhTU8Eum/FCo/941Nl+1j7gWIUnZrBBYNxLzj3g=;
        b=oFdiDtQn0tVfBDlXvhUu0Eo9QrgA3bS9hbhqW3010U3IIOE7IMV0YrRfk92dmRSJa1
         iX0LFjpTSlhzWVzERDah3+WxC6SMZkIczMKpNSITXPa6JAHrZea+LsaYhQvGV0j5wh5q
         3N/tmuJTWUOIWnjfIFueD8JJK1UaaZmhGhdMYCpV09B2iJQQTph6DKLNZMsUULh+pM8a
         apLIjYtCeKylNQJ/okpYsrNMYZNWVkbGX7eClIqN2mKkqmghLne7F9obxgTHOyb1EA6W
         hm7jlbDArxCsxRjzhU1xKOob5cxwaB/fnFCzicpaadMiqIfxExp/MAABFoPj0lLumiIL
         6fAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779746807; x=1780351607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb+vYhTU8Eum/FCo/941Nl+1j7gWIUnZrBBYNxLzj3g=;
        b=IT4a+HNW++AoPXuAzmgcXFiIcI8JuWO604fjkCDdHdVj16EuVtrI7dLrbOdxzAmdeq
         RffdpH0Zk/YHQJ/9PpdEuKTJK9ql4su0fRoO6h3JY0hPqfA0gOtzKceVy2uPh0CmRrXy
         HqbUVYJ6XbjcX496cvFwLITfMVrVkn98UvyJml3q7FwZsjd220lcq3CNoZYfI3RHDaIc
         6BcZGvwbfT3ldtynuoHpV9jmzLCpZVU/v6bdpErV0owr/O7D7uf0lTD7AVpbiyAhKwFE
         NbM4wEgaa+GXw6PDhAMBJcMr61+rRbXH/FEfHW7U7H+pVIGJHlrAy/UDImeWqxZyTGzP
         nYVw==
X-Forwarded-Encrypted: i=1; AFNElJ8RPhvNape3sNfjEv6zOFJmL447Fzrfft9a1TfEDO3eIILYAoG/TIyDL+ZSrrIb94L50T3o3Zeevqa9CIWdKNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2iluELV0BC4l3jmhr0hv+iDPYyeMEvl5ft6U/6SsmtyAzU+Hl
	TEKrlUxz7hiztgj9sGIzCf+WIReytE5tfGho1B1QkB7wgZ2wDjEu5uYO
X-Gm-Gg: Acq92OHStF2ok/jCypQWdOjDTGk81+IdJzB/OQokzOSRbtpdZTqC0qpj5MHJd3NxW6r
	CItDU0V+R7jvvXrXGcLUb97xgPp+xK+sRVeXiyLWZnqnQALmwNKG1ZJnL0L7Ws56naFUELy2sir
	PPebKAu9wLK39Oo47gHsrxWKEOx/HR1UQYK/Ga6dl/YiOxLICIEm57Z9PexSAzZlUS1ettfe1Dz
	0ywajYLVXAJPbKwwr2tjNChq5wUOMBl+7n67EN7LUm9W4OROIAgLyhGFXQpvOSyfZ/mytra7J2u
	OKmfWWDYlKrdOZy3xWeV0oAkn3DYPjPEYc7CRS/pqxu9BGECnUzLgh4XlByQjOmTaNTaXtiZcZi
	Tidh/3vzCO6YoNUWFPuk67LZmDSYn13x2nBJ7O8J9BzktdeodVOAeUj9WIF5j2aw358TLxQyNe1
	J9sSVRAPCU5lELp67W7lcuSniGyn6VpQ8z1H2ELLX46v3GibQYARCZpK2N934sUv4G4CJvuFTx1
	OtEpiacx/ApKjW8Irrindkahok9LH/XWoQ=
X-Received: by 2002:a17:90b:5343:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-36a67761c51mr13108866a91.7.1779746806663;
        Mon, 25 May 2026 15:06:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36adc0a6e94sm4713224a91.4.2026.05.25.15.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 15:06:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: iommu@lists.linux.dev
Cc: Barry Song <baohua@kernel.org>,
	linusw@kernel.org,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] dma: map_benchmark: turn dma_sg_map_param buf into a flexible array
Date: Mon, 25 May 2026 15:06:28 -0700
Message-ID: <20260525220628.94833-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buf pointer was kmalloc_array()'d immediately after the parent
struct allocation, with the count (granule, validated to 1..1024 by
the ioctl) trivially available beforehand.  Move buf to the struct
tail as a flexible array member and fold the two allocations into a
single kzalloc_flex(), dropping the kfree(params->buf) in both the
prepare error path and unprepare.

Add __counted_by for extra runtime analysis.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/dma/map_benchmark.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 29eeb5fdf199..a65da5c7710c 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -121,35 +121,35 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
 struct dma_sg_map_param {
 	struct sg_table sgt;
 	struct device *dev;
-	void **buf;
 	u32 npages;
 	u32 dma_dir;
+	void *buf[] __counted_by(npages);
 };
 
 static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
 {
+	struct dma_sg_map_param *params;
 	struct scatterlist *sg;
+	u32 npages;
 	int i;
 
-	struct dma_sg_map_param *params = kzalloc(sizeof(*params), GFP_KERNEL);
-
-	if (!params)
-		return NULL;
 	/*
 	 * Set the number of scatterlist entries based on the granule.
 	 * In SG mode, 'granule' represents the number of scatterlist entries.
 	 * Each scatterlist entry corresponds to a single page.
 	 */
-	params->npages = map->bparam.granule;
+	npages = map->bparam.granule;
+
+	params = kzalloc_flex(*params, buf, npages);
+	if (!params)
+		return NULL;
+
+	params->npages = npages;
 	params->dma_dir = map->bparam.dma_dir;
 	params->dev = map->dev;
-	params->buf = kmalloc_array(params->npages, sizeof(*params->buf),
-				    GFP_KERNEL);
-	if (!params->buf)
-		goto out;
 
-	if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
-		goto free_buf;
+	if (sg_alloc_table(&params->sgt, npages, GFP_KERNEL))
+		goto free_params;
 
 	for_each_sgtable_sg(&params->sgt, sg, i) {
 		params->buf[i] = (void *)__get_free_page(GFP_KERNEL);
@@ -166,9 +166,7 @@ static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
 		free_page((unsigned long)params->buf[i]);
 
 	sg_free_table(&params->sgt);
-free_buf:
-	kfree(params->buf);
-out:
+free_params:
 	kfree(params);
 	return NULL;
 }
@@ -183,7 +181,6 @@ static void dma_sg_map_benchmark_unprepare(void *mparam)
 
 	sg_free_table(&params->sgt);
 
-	kfree(params->buf);
 	kfree(params);
 }
 
-- 
2.54.0

