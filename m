Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2B3E5579
	for <linux-hardening@vger.kernel.org>; Wed,  6 May 2026 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057839; cv=none; b=e6sS7wzN50cDpO86ZCis/E7QH4GoDvFH+yiwnoqooP5QI5Hgc3cobltjgr8INlVCpB23js40mQKgtbPbUfYj5q3BwVkeNmst+in+ceKF+LaXJwssczID0mnliDhNWNJz7w14K2C5XGIlIFGqJ+vWesCbyZrtgd7CvUXf82uJM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057839; c=relaxed/simple;
	bh=cQLi0CLHrdudzOaWTKAoWJWK1hvleJMjSm+2UfxLbTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIBvc8tQOoHGsDpmUb/aSrmGg1cfUHTB16EM00mpSijzJ9KvdFzKBIBk+ELNOdVQF1xIR1md8qyyKgAFBbuG5RmB4cjjj2/RBE+E6Y8fIuNgiYlI25p23izhtwYSKsgdciClZGXoTK/Z38nWbATJiUBZXMhdmpLMNrXcLNA62so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J95gIPq5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J95gIPq5"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-834f1075805so4154596b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 06 May 2026 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778057831; x=1778662631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICj8WNtLmbLEAUfa33M8keUHm3CfftczvpYQJzguyto=;
        b=J95gIPq5t2Erp4ClUyuyn/kQ+GRQJibR1GRWoPO3mQF4E+9w2SNM6dMaMhStk2tyK8
         WqM+IiiiZY7mql611alNjal3+YdYNNe48YL5lS3vmbvVuSW8nkDzdZGFSxaOEMJl8mz5
         F4R2fXd/Fkwx9oBtaljd/T6yWj84+I6ZQA1LhGV11MKGuChzbxwqFLbEYhYMJzH0sr3x
         PCzpevCw9tBGGCssdzUi3zASA2UwyROOfbLo92imRb/FbbH0GttaHBS9PZ8Rq7UEV6RY
         3XgbyaZtD86KPLCR/G5Xz0Ta8J//Drc9uS9GQNMLHjcROQm3gcDVGe0mMgSjy/zdosMQ
         xw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778057831; x=1778662631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICj8WNtLmbLEAUfa33M8keUHm3CfftczvpYQJzguyto=;
        b=SPSKNXhggUYsXGQznqCCQFmM8Y/bRTDxSEDP6wvfe6u8nIhAFq23Bx+tPPSXSkjgKq
         CcPtpyeFIZwi67UBZBO9tjU9omXbn1zGkpk3QWzYIChdWAp0TTF50iRFlBtZCxCZmDXg
         m1+o+xp2B2v0lt4nTOVeBma+lc7g+VIjzNYA6VPg/gqvkxNnECAj0g+fIOsiN9M6gcZj
         FZ4wyrojMoqPwxIdOV8r6y5FZ4xLX3d0PFKxu76o6OL5zsIsAIFchK081D8ZxjKoKXwL
         Qb69FMn0F6G6msX3+aiUyYqw0j6/T4grdEMWLiIQOu1SY7XbZZ4TzBWb8ocBMzcFV9X1
         ujhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IG0WmvD9sjsaBs6k9bk8v7IZQ7bUmGSsrSZZEv4pYBDDvkHIot0sB7PXISXYpTVc/x4JiGpEKN26hVv/HDbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBcNLbzBxzPgt91iaau97oRP+Rm7cdlT1++syKxj7PxX6KeWF
	6ORNbubC9C6VcUpYXXOAVjAmdS2ZBfTqKgbHhefWFl5O3widJHCiWT0Z
X-Gm-Gg: AeBDietri8/SuBL3xgqa8Fzz1fv53Zmil7/LOLvvB16PPMYmyVMnokWsRUnm1bm5tyd
	QaWNbgSvCTOKu51/jE6NOtGRLzTDU+uOYNqMwKrzMD3decRt2CdlR0sQ7bs7PGP0p7gR1eGE/E/
	9miaZx4yfQkXnVZMyMz+wT8Wvw+/76DFNtMnD4fe4jQ0upLCvGnul0Nx6U36lfbJMFWRRuzE+Ms
	ecIYiqLv7M1F9Uj5N8K/1jMoM812ZMEx+c6aD0xXeFK2RklEmv/0ulmbS4vveOdMTc1DnYhWpB2
	8kCfIO2nEhVz0s+oc8wI8ZVrGQV12QI4N33xXGE1K2YytlvC73N12HHD+NuL/MfsfKYwQMmgfv5
	hsuXEyMWdwUn9w+ErHfHqNG7aO0nAIzXMSWRV2+mqt7Yng/vT12CMt4J5p+ts6c7p+EHIfMsiM4
	l+NoE1XTY+dYJ2eFQQHcCr7jmfaOOiMw4e6ccSBx2vKz6L8TIjQdBU7PJ76xIib56S1F3ojPVBg
	PJYDrfQ4oeswQA6VQwypzwpnIMQPrddJRadpSipYgeQwg==
X-Received: by 2002:a05:6a00:27a4:b0:838:a46:ce99 with SMTP id d2e1a72fcca58-83a5e457a1fmr2243116b3a.48.1778057831191;
        Wed, 06 May 2026 01:57:11 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c7ba9sm4807974b3a.35.2026.05.06.01.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:57:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] talitos: allocate channels with main struct
Date: Wed,  6 May 2026 01:56:53 -0700
Message-ID: <20260506085653.1211263-1-rosenp@gmail.com>
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

Error in case of no channels as they are required.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: error when no channels
 drivers/crypto/talitos.c | 19 +++++++------------
 drivers/crypto/talitos.h |  5 +++--
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index bc61d0fe3514..bd4cc06ee13c 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3409,14 +3409,20 @@ static int talitos_probe(struct platform_device *ofdev)
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
 	struct talitos_private *priv;
+	unsigned int num_channels;
 	int i, err;
 	int stride;
 	struct resource *res;
 
-	priv = devm_kzalloc(dev, sizeof(struct talitos_private), GFP_KERNEL);
+	if (of_property_read_u32(np, "fsl,num-channels", &num_channels))
+		return -EINVAL;
+
+	priv = devm_kzalloc(dev, struct_size(priv, chan, num_channels), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_channels = num_channels;
+
 	INIT_LIST_HEAD(&priv->alg_list);
 
 	dev_set_drvdata(dev, priv);
@@ -3436,7 +3442,6 @@ static int talitos_probe(struct platform_device *ofdev)
 	}
 
 	/* get SEC version capabilities from device tree */
-	of_property_read_u32(np, "fsl,num-channels", &priv->num_channels);
 	of_property_read_u32(np, "fsl,channel-fifo-len", &priv->chfifo_len);
 	of_property_read_u32(np, "fsl,exec-units-mask", &priv->exec_units);
 	of_property_read_u32(np, "fsl,descriptor-types-mask",
@@ -3511,16 +3516,6 @@ static int talitos_probe(struct platform_device *ofdev)
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

