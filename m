Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DAE3B0ADF
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777585440; cv=none; b=TCuS2JC/YduvL0lxLHM8bDk8sj+qYecgkTORgjlbt7JYyUaFD3t8FUtQjMpzoy8pSdE0VZILyRZWBEC2EZnKSGZnVSWNYPBjKzf/sBPnd6DtAbBdopMl7/R6a2C+/atdJrBibQ5p5XCTIdOJUEfO9xFYlrXeNr8sWrlHDv1u+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777585440; c=relaxed/simple;
	bh=M26zyhA5t24GPKGYCTGb/aogmGLpzeEa8q2aXPKEQas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEX2kTZNW9lHiXT5XlfoETIY8zNw4ifDqmuhUdZcyUhE6V/LfscmOiAfuHTG+9V7LVsgaHV8rsGZNxwIKl01p34la97lQjpV2oFm7XowOecd9CTrjxD5eHYVq0q6b59m2KE5mtXP5d5DYKyi7XV+acEmF3eEZQ6fp6Vr+6ws2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVPiMVoy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVPiMVoy"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so1510879a91.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 14:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777585438; x=1778190238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XX7iQVHvtl0B67D8W3qVofrAFP/lX8Hl1A01uIMYbIQ=;
        b=LVPiMVoybTWmuGgEgSqt0ivJb+2mRKP3k03gQwKxTJRnNopjmpe2E8RQVzHYv2qJVK
         Kd0rOey3DIq95uR15GjkbYQQ5CLS174T4cRz4Ru8Kx4iXtUzz3HBT1HZH+vE7sQbZg/d
         xaSOcQffcZ6exgFjccxa6E38VwTx2PKOHe3L8iQVIy6lI3OCZzfT/b9hjBQvjEbXU2t0
         NzdcDe51bpUVXf7C+zSV7CBs+7Iy1/Mkto2WAh4GY0wu9quryHXmmPz8er0kBKWtefay
         sLu0s88FptH6ihX0Vdi00Vy0onquvYhVyGuXa6MaOkqOPC2/m6G8eVwieq4kSaaT/LFX
         z5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777585438; x=1778190238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX7iQVHvtl0B67D8W3qVofrAFP/lX8Hl1A01uIMYbIQ=;
        b=bRspe2QFdqFyk1tueT++yQP6CN7boXhb06AW5vsaXOPXIezFoBIcB4DYzwh2TOIaof
         zVZzLyqXiKjZ+8m1Y6uY/SNWeSQUtYm2x7jS59g30uPg2c0xrtCWAdupfIf5emVYGN5+
         g+nEwuWFdg5hwt2RwyvgZ9p7Rb+eZv2Pvk3nAHZNqM136UpAu8nYu1sk4PB66CeRlauY
         7xsGkaZPI50LLDPAgkk6nm7xMZdEQhc4+2fMnaOuBMbUXBQ+cvkfGX9G8q05qyvhcjlB
         HtycnCXS1HhfyWchkw+9M8oqMAYvh27WhxDSCki/pTM6i5+5A5oGegnUOPWyMoNZGcHy
         lx5g==
X-Forwarded-Encrypted: i=1; AFNElJ8IjPKyLj4lmiMUWOcbGrMfTyal2PGmPvRYRNTV+7k7dI9HGIEIROLxnyNOfT6vmPnDwZ39yqhe9xMrNtOvkzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIqrn6Ju6V3x4SPEnOa2BFCJkZW2E9tdBsTGmNxnkiOOMzJBxf
	KFvwekCQwZkgBbhyTEH4DhML8TkW/2BOGGCrt+MWIw8G/oEJ1A20L+DL
X-Gm-Gg: AeBDietBV22Uz0qBkUVmIztQi93Wa4zWi/Rv3qCoJ2qK3H13VaQNDztNeBGZyMcrmt0
	yW1rGQpI1ZIP3IFJclTAperwiGoabbtmX0GTjqh56vz/0F/TqIABMQLvUq9pMx/xMSGPKHjBtzL
	H8M4YMkq2Meo6DXUNlx07QgPnHRbk45IqKHJtf0TKBqaBS/sKBUllRWZTI2LnZlCSesTsC9+89m
	dd5cn0VAQ98NAaP15xhuNhAYmH0Lc/81Oq4F/8r1DzynnNLJySDe8eB9k1EFrOxzE56cueAVzXc
	v06hwz85oR2U1/wUKusTXP3KrJ6JwmZAlYCwHylRK5f1y+E0PNetsYmk17c6exq6DU82NT6sBRE
	1S+nml2ioDsDGufPq/orisjJs7zNNE5AwQfBjOJGNkM4SSzD32XNIbfsJ1nhpVeBxymTvs1SioJ
	TvuyNVj4rbQJmv7EQC8cAPH7/MKCY/j/AhCu3T0+AVb4WF6Bki0jDI2xlhK1zjQ3/18jUszmgEo
	FHSl0ofTEOo0XErI+Bz1xQnxgat3Iv/JZSfyyKjLW8PMQ==
X-Received: by 2002:a17:90b:5252:b0:35e:3e86:e2d1 with SMTP id 98e67ed59e1d1-364ef3a2290mr304651a91.7.1777585438238;
        Thu, 30 Apr 2026 14:43:58 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2a71bsm3945592a91.1.2026.04.30.14.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:43:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] talitos: allocate channels with main struct
Date: Thu, 30 Apr 2026 14:43:40 -0700
Message-ID: <20260430214340.59588-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/talitos.c | 17 +++++------------
 drivers/crypto/talitos.h |  5 +++--
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index bc61d0fe3514..98323c154031 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3409,14 +3409,18 @@ static int talitos_probe(struct platform_device *ofdev)
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
 	struct talitos_private *priv;
+	unsigned int num_channels;
 	int i, err;
 	int stride;
 	struct resource *res;
 
-	priv = devm_kzalloc(dev, sizeof(struct talitos_private), GFP_KERNEL);
+	of_property_read_u32(np, "fsl,num-channels", &num_channels);
+	priv = devm_kzalloc(dev, struct_size(priv, chan, num_channels), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_channels = num_channels;
+
 	INIT_LIST_HEAD(&priv->alg_list);
 
 	dev_set_drvdata(dev, priv);
@@ -3436,7 +3440,6 @@ static int talitos_probe(struct platform_device *ofdev)
 	}
 
 	/* get SEC version capabilities from device tree */
-	of_property_read_u32(np, "fsl,num-channels", &priv->num_channels);
 	of_property_read_u32(np, "fsl,channel-fifo-len", &priv->chfifo_len);
 	of_property_read_u32(np, "fsl,exec-units-mask", &priv->exec_units);
 	of_property_read_u32(np, "fsl,descriptor-types-mask",
@@ -3511,16 +3514,6 @@ static int talitos_probe(struct platform_device *ofdev)
 		}
 	}
 
-	priv->chan = devm_kcalloc(dev,
-				  priv->num_channels,
-				  sizeof(struct talitos_channel),
-				  GFP_KERNEL);
-	if (!priv->chan) {
-		dev_err(dev, "failed to allocate channel management space\n");
-		err = -ENOMEM;
-		goto err_out;
-	}
-
 	priv->fifo_len = roundup_pow_of_two(priv->chfifo_len);
 
 	for (i = 0; i < priv->num_channels; i++) {
diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
index 1a93ee355929..34b0b5fab7e7 100644
--- a/drivers/crypto/talitos.h
+++ b/drivers/crypto/talitos.h
@@ -139,8 +139,6 @@ struct talitos_private {
 	 */
 	unsigned int fifo_len;
 
-	struct talitos_channel *chan;
-
 	/* next channel to be assigned next incoming descriptor */
 	atomic_t last_chan ____cacheline_aligned;
 
@@ -153,6 +151,9 @@ struct talitos_private {
 	/* hwrng device */
 	struct hwrng rng;
 	bool rng_registered;
+
+	struct talitos_channel chan[] __counted_by(num_channels);
+
 };
 
 /* .features flag */
-- 
2.54.0

