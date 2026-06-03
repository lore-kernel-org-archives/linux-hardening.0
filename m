Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60382874F5
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456698; cv=none; b=keBWQ+mktxt2GsdGzAV1EYvhstBE0tgrKYgHxGaG47DXyKisXw2ekBKj1ZO61+9H8eLKc3DDg82/VLEyCgv4N1h3/s42995hNWB8dJBy9U4nwuifZNDEP3+juLJ2tUNKwU+UQyhkHBsmBgPBAxQ+dYrwdam3qqmROKjaUqbYr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456698; c=relaxed/simple;
	bh=BrLl55rtH6dYClV7fN4/ASsckeGkMGxQmJmComhF1Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9dXKsOn3Z5HDeHwXLiUxVFvyydnKV/BSvD061TMNuUdaASpbn1wTIJQOQkwKMCX6TXRutRRL203+9WSL71H69vQOofvVVk/jprh1xZWi1DMAAQZNjlsVx79/5Wp5TYUt9u08pD1aphfg+dpDBgKy6RsHAh12LRn5fjEejMH5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYl466D2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYl466D2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso22535785ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 20:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456697; x=1781061497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1w/uqKkKsuzaL77QabRVI67EugYIJNkq2g/yoq3O5NI=;
        b=FYl466D2tAo8OlQuJpthU01UIgt4M5vWZiwXJ/gsg5Swxsry3yTMgrFys/t36TyXAY
         PxylWD21tDIKPHCSZ0cfJz2t1RSJQJcUTunbUzn37PVjxhpAQne3lzQWoUyiqCgC5j4U
         JRsuLCbwcNp5uDXH/yUFLoW9lilH0/XFL3GWv8DCw60Y+PqZyHlFOdlOPQ/W6afS0Qxt
         2P3+lJRPGXp4auNbWTZzN0XudLYvxgOaT8za1/Ge1YX2TU0m1u3IzDHWSI63/qff1AFW
         lebzorpGi9IIUfZrH1vPpzjqPdabRd9S+UBH/ORneXVBTwkSqEyIciSP3Az6V9tSzSGE
         68Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456697; x=1781061497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w/uqKkKsuzaL77QabRVI67EugYIJNkq2g/yoq3O5NI=;
        b=bj6BhwEl35HlkwsEQWG0O3v6bt2yrdl3EyrrubLN+FD1/zh37PZrCj7yw+nq3d1k49
         BkeY2soDYtWM+Qs7VkvuTZPD24mXWy7gq2EavDMeLNIulmXPgvIsOs5CeyVH8mXSjs/h
         11fnh7hJLLBwsnFwmRkVz/+A1Nh3Q95CuwnXcYVlBL8cf+l9l6mDEy20TWDY+AUZZT1N
         yW2bGTVcS8VxRhj/JplXSutGmBLUVWorRBdHoPTbIVtpc0qoYrLTe1BcB6dqFAT8Bjtu
         yVGfWQ30P6mn7yonUu4A+Hdbz2/9rhbx2VaoU2ThiTAi9TDWUHtiF8/aboUUBQzt/Dt5
         KyUA==
X-Forwarded-Encrypted: i=1; AFNElJ/lr11RAhma+K4ns4EgyqFWbhSAWyGNpNKvKZQErVExPy6NEwcTjhw3b2mTmEt27dLwJE/OeZJckxgz1pSo3T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWfzEKiG83CJ/+a0+mEAJwlKUQ1KXhnBKHU6//kf2WUTKwuSv
	s+pkg4KnbAxY/+FkmSz/7YmA01qOS6veqaynsWNuerzPEQrSKxwfuLJg
X-Gm-Gg: Acq92OGBpQULOROjmPsRxB2byXaaifGEUk6ihvoya0R2TfWk+cITQ/JINuYJXx6ppXu
	KjqpcrNkJAp29Z7EHgHC0oLuQ5eqqgx51D+XwsP03/8gIB63X86MCb1GEiTTBHdKHMQCqk3VerX
	TvO32NVvjtrAbalhWMbzAppUVuKREgWWSYijDkkuauj2fQaQPVzLf11FESBha+CjM7xAXsYDRnq
	TtKEvjOx2sX26RNLdO5y9tbhQwjeGP9/IAsBk53VxWOKd/xCOKepjF0f9AXgc5i0GyaY5tuaP44
	PUiVo9UTDfxX9+nq8yCe9OcL5TW5bD/tkorXWJNrrCQSqUZu9oxqQ6kggPfSldmNKsukSdH2AFC
	n+Y1a4Eh3ZtC9Mocg7LJ0W4x5nk82T18nzRppnI4KihTrBFYJJYczZh4BqgODGG2gXiJCBBz+yw
	XLbPHOL6Ucycb5Igt8e1HwA8zUevst+jnxiOEhd5v4LbiVmMV0vIyQaTLCMNwxafg387S3xksb6
	z+kO4LfJnozZk0kS0GVcDNJcCI2QmEr/nzv9MKkTH9EhA==
X-Received: by 2002:a17:903:234e:b0:2c0:c3ac:4af3 with SMTP id d9443c01a7336-2c163a203admr14348355ad.15.1780456697015;
        Tue, 02 Jun 2026 20:18:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f94a7fsm7457345ad.28.2026.06.02.20.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:18:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: iommu@lists.linux.dev
Cc: Barry Song <baohua@kernel.org>,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] dma: map_benchmark: turn dma_sg_map_param buf into a flexible array
Date: Tue,  2 Jun 2026 20:17:58 -0700
Message-ID: <20260603031758.290538-1-rosenp@gmail.com>
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
Reviewed-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 v2: use params->npages in sg_alloc_table
 kernel/dma/map_benchmark.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 29eeb5fdf199..fdc070f419f6 100644
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
 
 	if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
-		goto free_buf;
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

