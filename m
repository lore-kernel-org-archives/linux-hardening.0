Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A766346A1D
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777586471; cv=none; b=uUzePksmVOzbE7J+cWXHKtDmIXTs5P5Hu4fG5lnUuZEEPKFnVIMiUj3RtsaQdwarODnf2g9CNiEV0lnl0UvNZg9bccsj3msO0ou0RqT4BfD4aAzQTBC/SRks/DsMaZkIcHw+PHkkTpgf08jep9dWbiBtm3ur16wZkmIPrOMwc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777586471; c=relaxed/simple;
	bh=PliZUdjcdarMC+vMmbXRSruaLKQ7V3ErqYWXkuwC3KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APwL3zPVlafXBBB+LAagEqLOMcXKDqLCyafIjyisw/0mxrERqB6TyZZbTJ9IrjvgACAorg/PC0bQKmHZVTdGF8o1D/WjHCdFf0JMeAMuukkNqTjt3bv7aOsZDDVmJke/8mTOAVtaB51X9r777PRpe335xBOc7rTTnM33AFNxKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApjxexXg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApjxexXg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso992518b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777586470; x=1778191270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBIWSWZQjXNPa2sD5+J+8oDnHNnLvrf+nwX2j+wXk3s=;
        b=ApjxexXgW8hOOYA6Mgyb/zfFuUEdHz+d0m7ZMf/7wtErThUekLSFTggw/kT1XdpfiD
         Z0A3KN1M0AnRqIXkxGE30JbvQrqqJw8drf1m4BiL1M8NAxZUv5go9TAAjI5inAlbfDdO
         YwPL0bDmTo7dnL7NrQG6obvX5FGMTJ/rIaHVXSYrbm09kZP+Tvhb0tL6J+yh/RK4L01E
         wxJzJttke0jUdPuxciJDoKq/SXBQc9kLI1tAGW2LIjZqYhBATBHs11nMNuCRlrexu4Ut
         o3TtPu7k9T7A8x0D5V+nDporXlG+XU0mkuvwQAliwQrmwubsvIOW+tTvhfegecPx1xui
         /kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777586470; x=1778191270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBIWSWZQjXNPa2sD5+J+8oDnHNnLvrf+nwX2j+wXk3s=;
        b=XbzCJaGY2CaEAxp19nIhhqfj7AGVftrSeDYx4Zua32JTshSghQ76FbDbmN5l7ZCI32
         7f7oXqtqsBRaHa5vbWpuokcMBtQep04/DGwTDEK4lDIYCUKLh1Ubs2AZZ4TKsAWD5qSW
         J7PP4ouWeRbjTzhUP10hryH4pbcwN0EIGFOTTH+k6RH0KXNvoXQbuIVyQdhy1C1oXa+A
         AGkv31NgkdfBGe4SEcxKDqA8FaHlhlhExTs2JduD4JSQ2bgYj4XOMZJUsOBTz4Ty8bf2
         c6hm6xqP5EvPskdUunYPFJLWYTI2woCxkoiNB4eoe7zatCzKuu4cZJydxdz96Jdr7sS6
         ting==
X-Forwarded-Encrypted: i=1; AFNElJ++vYxA/y/PBKM9uvsfVYJ5xOq1DYHwBWVK/gu4AsPUiqi4Czd11opJemaxKXEpdmfGsxGw6vX07R18nk9t9ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4HaUcjrvWEC0uH+sw+tQBtOJQyOp+RZ7i6fe2nkz+0grK4T0
	OuWxpzfUnQ5yrUhqFY4wQnSfCrQ56OlAJeH4xCrQfHnDd4iQkN/rlO+s
X-Gm-Gg: AeBDieslLezYQfk61c7kgg9IVnBIbx9RvFoW+vKgdzfWTDGwyrWgIOqN3OyaVv78R3i
	qWzn7yGI6jrUvzkbxi0nm6QFzTtEOs4RzQMB0VZKQVWlNpF1W55rdujQ++QI9Ovqm2HW8y8DLqO
	FAoVFA/qu8aFLve45h3fieTP4e6nDLUp+Hu8gegUFja52n8C5sTPm9v23o7Tynqew1mc2d1E6y1
	aAd2fWdsfbhNg1YgvmLEYA5B9wOkjHsRgHoYYKwbQXXjjUX1ohtmZenrmisB3qmn/n2OIAaW7gj
	hGQNhQuLh+0SmmrLj3KZ+AGSESDmHqF6KTVhMJinR9jI0ZZUf1KuT7cU/Fdxg7gvrR5Nqt7WbII
	R302tqWDhuP4lztznPISI/rEhD00cmHQYFswYCxZp97GqQBhgk36nIdoH3iy9BQQ8zGBZlj2Px1
	VpRzNuKzzS8eLv/1O+MXdfy34+YDqe1VEkT1wuoV0aBq1yNgtUDLeDIF99l8k6JJ/yNb5jXSFFh
	mjBjMhbJlNmZBYPT9OUh1BCEs0f46hzyfmkvWMrosEsxg==
X-Received: by 2002:a05:6a00:8e01:b0:82f:111:61d3 with SMTP id d2e1a72fcca58-8351a5d8a70mr334446b3a.44.1777586469642;
        Thu, 30 Apr 2026 15:01:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad7873sm614130b3a.38.2026.04.30.15.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 15:01:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 2/2] EDAC/device: 3 to 1 allocations in edac_dev_feat_ctx
Date: Thu, 30 Apr 2026 15:00:46 -0700
Message-ID: <20260430220046.72371-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430220046.72371-1-rosenp@gmail.com>
References: <20260430220046.72371-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies memory handling slightly by using a flexible array member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/edac/edac_device.c | 40 +++++++++++++-------------------------
 include/linux/edac.h       |  2 +-
 2 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 9c21997a50e0..a6c41ce68f13 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -569,8 +569,6 @@ static void edac_dev_release(struct device *dev)
 {
 	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
 
-	kfree(ctx->mem_repair);
-	kfree(ctx->scrub);
 	kfree(ctx->dev.groups);
 	kfree(ctx);
 }
@@ -612,6 +610,7 @@ int edac_dev_register(struct device *parent, char *name,
 	int attr_gcnt = 0;
 	int ret = -ENOMEM;
 	int scrub_cnt = 0;
+	size_t alloc_size;
 	int feat;
 
 	if (!parent || !name || !num_features || !ras_features)
@@ -636,26 +635,18 @@ int edac_dev_register(struct device *parent, char *name,
 		}
 	}
 
-	ctx = kzalloc_obj(*ctx);
+	alloc_size = struct_size(ctx, scrub, scrub_cnt);
+	alloc_size += sizeof(*ctx->mem_repair) * mem_repair_cnt;
+	ctx = kzalloc(alloc_size, GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->mem_repair = ctx->scrub + scrub_cnt;
+
 	ras_attr_groups = kzalloc_objs(*ras_attr_groups, attr_gcnt + 1);
 	if (!ras_attr_groups)
 		goto ctx_free;
 
-	if (scrub_cnt) {
-		ctx->scrub = kzalloc_objs(*ctx->scrub, scrub_cnt);
-		if (!ctx->scrub)
-			goto groups_free;
-	}
-
-	if (mem_repair_cnt) {
-		ctx->mem_repair = kzalloc_objs(*ctx->mem_repair, mem_repair_cnt);
-		if (!ctx->mem_repair)
-			goto data_mem_free;
-	}
-
 	attr_gcnt = 0;
 	scrub_cnt = 0;
 	mem_repair_cnt = 0;
@@ -664,7 +655,7 @@ int edac_dev_register(struct device *parent, char *name,
 		case RAS_FEAT_SCRUB:
 			if (!ras_features->scrub_ops || scrub_cnt != ras_features->instance) {
 				ret = -EINVAL;
-				goto data_mem_free;
+				goto groups_free;
 			}
 
 			dev_data = &ctx->scrub[scrub_cnt];
@@ -674,7 +665,7 @@ int edac_dev_register(struct device *parent, char *name,
 			ret = edac_scrub_get_desc(parent, &ras_attr_groups[attr_gcnt],
 						  ras_features->instance);
 			if (ret)
-				goto data_mem_free;
+				goto groups_free;
 
 			scrub_cnt++;
 			attr_gcnt++;
@@ -682,7 +673,7 @@ int edac_dev_register(struct device *parent, char *name,
 		case RAS_FEAT_ECS:
 			if (!ras_features->ecs_ops) {
 				ret = -EINVAL;
-				goto data_mem_free;
+				goto groups_free;
 			}
 
 			dev_data = &ctx->ecs;
@@ -691,7 +682,7 @@ int edac_dev_register(struct device *parent, char *name,
 			ret = edac_ecs_get_desc(parent, &ras_attr_groups[attr_gcnt],
 						ras_features->ecs_info.num_media_frus);
 			if (ret)
-				goto data_mem_free;
+				goto groups_free;
 
 			attr_gcnt += ras_features->ecs_info.num_media_frus;
 			break;
@@ -699,7 +690,7 @@ int edac_dev_register(struct device *parent, char *name,
 			if (!ras_features->mem_repair_ops ||
 			    mem_repair_cnt != ras_features->instance) {
 				ret = -EINVAL;
-				goto data_mem_free;
+				goto groups_free;
 			}
 
 			dev_data = &ctx->mem_repair[mem_repair_cnt];
@@ -709,14 +700,14 @@ int edac_dev_register(struct device *parent, char *name,
 			ret = edac_mem_repair_get_desc(parent, &ras_attr_groups[attr_gcnt],
 						       ras_features->instance);
 			if (ret)
-				goto data_mem_free;
+				goto groups_free;
 
 			mem_repair_cnt++;
 			attr_gcnt++;
 			break;
 		default:
 			ret = -EINVAL;
-			goto data_mem_free;
+			goto groups_free;
 		}
 	}
 
@@ -729,7 +720,7 @@ int edac_dev_register(struct device *parent, char *name,
 
 	ret = dev_set_name(&ctx->dev, "%s", name);
 	if (ret)
-		goto data_mem_free;
+		goto groups_free;
 
 	ret = device_register(&ctx->dev);
 	if (ret) {
@@ -739,9 +730,6 @@ int edac_dev_register(struct device *parent, char *name,
 
 	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
 
-data_mem_free:
-	kfree(ctx->mem_repair);
-	kfree(ctx->scrub);
 groups_free:
 	kfree(ras_attr_groups);
 ctx_free:
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 7a3c1c60dea7..b3ca9e3d0521 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -864,9 +864,9 @@ struct edac_dev_data {
 struct edac_dev_feat_ctx {
 	struct device dev;
 	void *private;
-	struct edac_dev_data *scrub;
 	struct edac_dev_data ecs;
 	struct edac_dev_data *mem_repair;
+	struct edac_dev_data scrub[];
 };
 
 struct edac_dev_feature {
-- 
2.54.0

